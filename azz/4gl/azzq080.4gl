#該程式已解開Section, 不再透過樣板產出!
{<section id="azzq080.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000025
#+ 
#+ Filename...: azzq080
#+ Description: 授權人數清單查詢
#+ Creator....: 00413(2014-08-07 17:05:53)
#+ Modifier...: 00413(2014-09-19 17:41:51) -SD/PR- 00413
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzq080.global" >}

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzwl_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   gzwl001 LIKE gzwl_t.gzwl001, 
   gzwl003 LIKE gzwl_t.gzwl003, 
   gzwl003_desc LIKE type_t.chr500, 
   gzwl004 LIKE gzwl_t.gzwl004, 
   gzwl015 LIKE gzwl_t.gzwl015,
   gzwl008 LIKE gzwl_t.gzwl008,
   gzwl010 LIKE gzwl_t.gzwl010, 
   gzwl007 LIKE gzwl_t.gzwl007, 
   gzwl012 LIKE gzwl_t.gzwl012,
   gzwl014 LIKE gzwl_t.gzwl014,
   gzwl013 LIKE gzwl_t.gzwl013
       END RECORD
PRIVATE TYPE type_g_gzwl2_d RECORD
       gzwl005 LIKE type_t.chr100, 
   gzwl002 LIKE type_t.chr20, 
   gzwl002_desc LIKE type_t.chr500, 
   gzwl006 LIKE gzwl_t.gzwl006,
   gzxa007 LIKE gzxa_t.gzxa007,
   gzwl015 LIKE gzwl_t.gzwl015,
   gzwl005_desc LIKE type_t.chr500
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gzwl_d
DEFINE g_master_t                   type_g_gzwl_d
DEFINE g_gzwl_d          DYNAMIC ARRAY OF type_g_gzwl_d
DEFINE g_gzwl_d_t        type_g_gzwl_d
DEFINE g_gzwl2_d   DYNAMIC ARRAY OF type_g_gzwl2_d
DEFINE g_gzwl2_d_t type_g_gzwl2_d
 
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_auth_cnt     LIKE type_t.num5   #授權人數
DEFINE g_limit_cnt    LIKE type_t.num5   #執行上限
DEFINE g_auth_notover BOOLEAN            #授權是否已滿
DEFINE g_exec_notover BOOLEAN            #執行上限是否已滿
DEFINE g_keyword_h    DYNAMIC ARRAY OF RECORD
          keyname     STRING,
          wordnum     SMALLINT,
          field       STRING
                      END RECORD
DEFINE g_keyword_d    DYNAMIC ARRAY OF RECORD
          keyname     STRING,
          wordnum     SMALLINT,
          field       STRING
                      END RECORD
DEFINE g_fglwrt       STRING
DEFINE g_dbs_old      STRING
#160726-00036#1
DEFINE g_aid          DYNAMIC ARRAY OF RECORD
          gzwl009     LIKE gzwl_t.gzwl009,
          gzwl012     LIKE gzwl_t.gzwl012
                      END RECORD
DEFINE g_wc_table2    STRING
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="azzq080.main" >}
#+ 此段落由子樣板a26產生
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
   #啟動dscom連線, 但先指回原DB, dscom不能跟LIB一樣用完即斷, 因為裡面有temptable相串, 開關會丟
   LET g_dbs_old = g_dbs
   IF NOT cl_db_setconnect("dscom") THEN
      CALL cl_db_connect("dscom", FALSE)
   END IF
   IF cl_db_setconnect(g_dbs_old) THEN END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq080_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE azzq080_master_referesh FROM g_sql
 
   #add-point:main段define_sql

   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq080_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq080 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzq080_init()   
 
      #進入選單 Menu (="N")
      CALL azzq080_ui_dialog() 
      
      #add-point:畫面關閉前
      #dscom斷線, 連回原DB, 讓exitprogram可以正常
      IF cl_db_setconnect("dscom") THEN
         DISCONNECT CURRENT
         IF NOT cl_db_setconnect(g_dbs_old) THEN END IF
      END IF
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzq080
      
   END IF 
   
   CLOSE azzq080_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="azzq080.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzq080_init()
   #add-point:init段define
   DEFINE ls_title   STRING
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prog
   LET g_ref_fields[2] = "lbl_auth_title"
   CALL ap_ref_array2(g_ref_fields," SELECT gzzd005 FROM gzzd_t WHERE gzzd001 = ? AND gzzd002 = '"||g_lang CLIPPED||"' AND gzzd003 = ? AND gzzd004 = 's'","") RETURNING g_rtn_fields
   LET ls_title = "<span style=\"color: #0054A3; font-size: 14pt; font-weight: bold;\">", g_rtn_fields[1], "</span>"
   CALL gfrm_curr.setElementText("lbl_auth_title", ls_title)
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prog
   LET g_ref_fields[2] = "lbl_process_title"
   CALL ap_ref_array2(g_ref_fields," SELECT gzzd005 FROM gzzd_t WHERE gzzd001 = ? AND gzzd002 = '"||g_lang CLIPPED||"' AND gzzd003 = ? AND gzzd004 = 's'","") RETURNING g_rtn_fields
   LET ls_title = "<span style=\"color: #0054A3; font-size: 14pt; font-weight: bold;\">", g_rtn_fields[1], "</span>"
   CALL gfrm_curr.setElementText("lbl_process_title", ls_title)
   CALL azzq080_add_style()

   CALL azzq080_license_keyword_define()
   #end add-point
 
   CALL azzq080_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="azzq080.default_search" >}
PRIVATE FUNCTION azzq080_default_search()
   #add-point:default_search段define
   
   #end add-point
 
   #add-point:default_search段開始前
   
   #end add-point
 
   #+ 此段落由子樣板qs27產生
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " gzwl001 = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段開始後
   #一開始就需要有資料
   LET g_wc = "gzwl001 IS NOT NULL"
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzq080_ui_dialog()
   DEFINE ls_wc    STRING
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE ls_sql   STRING
   DEFINE li_cnt   LIKE type_t.num5
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 
 
   #end add-point
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=1" THEN
      LET g_detail_idx = 1
      CALL azzq080_b_fill()
   ELSE
      CALL azzq080_query()
   END IF
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzwl_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_gzwl_d.getLength() TO FORMONLY.h_count
               CALL azzq080_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row
 
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_gzwl2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt2)  
         
            BEFORE DISPLAY 
#               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac_d = g_detail_idx2
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_gzwl2_d.getLength() TO FORMONLY.h_count
#               CALL azzq080_fetch()
#               LET g_master_idx = l_ac
               #add-point:input段before row
               #根據授權編號, 重整右側執行清單
               CALL azzq080_process_b_fill(g_gzwl2_d[g_detail_idx2].gzwl005)
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            LET g_curr_diag = ui.Dialog.getCurrent()
            #不需要標準功能
            CALL DIALOG.setActionActive("insert", FALSE)
            CALL DIALOG.setActionActive("output", FALSE)
            CALL DIALOG.setActionActive("filter", FALSE)
            #end add-point
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzq080_insert()
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzq080_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo
               #160726-00036#1
               LET ls_sql = "SELECT COUNT(*) FROM ooag_t WHERE ooagent = ? AND ooag001 = ?"
               PREPARE azzq080_ui_dialog_getooag_pre FROM ls_sql
               EXECUTE azzq080_ui_dialog_getooag_pre USING g_enterprise, g_aid[DIALOG.getCurrentRow("s_detail2")].gzwl009 INTO li_cnt
               IF li_cnt > 0 THEN
                  CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_aid[DIALOG.getCurrentRow("s_detail2")].gzwl009)
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_gzwl2_d[DIALOG.getCurrentRow("s_detail2")].gzwl002," [",g_aid[DIALOG.getCurrentRow("s_detail2")].gzwl009,"]"
                  LET g_errparam.code   = "azz-00395"  
                  CALL cl_err()
               END IF
               CONTINUE DIALOG   #這樣就不會點完info後，左側的CurrentRow一直跳回最開頭
               #END add-point
               EXIT DIALOG
            END IF
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL azzq080_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL azzq080_b_fill()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         #+ 此段落由子樣板qs19產生
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_gzwl_d.getLength()
               LET g_gzwl_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_gzwl_d.getLength()
               LET g_gzwl_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_gzwl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gzwl_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_gzwl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gzwl_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
         
 
         #add-point:ui_dialog段自定義action
         ON ACTION killprocess
            CALL azzq080_kill_process()

         ON ACTION licenseinfo_view
            CALL azzq080_fglwrt_display()
         #end add-point
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前
 
         #end add-point
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL azzq080_b_fill()
            END IF
      
      #  ON ACTION qbeclear   # 條件清除
      #     CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzq080_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzwl_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON gzwl001,gzwl003,gzwl004,gzwl007,gzwl014,gzwl008
           FROM s_detail1[1].b_gzwl001,s_detail1[1].b_gzwl003,s_detail1[1].b_gzwl004,s_detail1[1].b_gzwl007, 
               s_detail1[1].b_gzwl014,s_detail1[1].b_gzwl008
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_gzwl001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_gzwl001
            #add-point:BEFORE FIELD b_gzwl001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_gzwl001
            
            #add-point:AFTER FIELD b_gzwl001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_gzwl001
         ON ACTION controlp INFIELD b_gzwl001
            #add-point:ON ACTION controlp INFIELD b_gzwl001

            #END add-point
 
         #----<<b_gzwl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_gzwl003
            #add-point:BEFORE FIELD b_gzwl003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_gzwl003
            
            #add-point:AFTER FIELD b_gzwl003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_gzwl003
         ON ACTION controlp INFIELD b_gzwl003
            #add-point:ON ACTION controlp INFIELD b_gzwl003

            #END add-point
 
         #----<<b_gzwl003_desc>>----
         #----<<b_gzwl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_gzwl004
            #add-point:BEFORE FIELD b_gzwl004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_gzwl004
            
            #add-point:AFTER FIELD b_gzwl004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_gzwl004
         ON ACTION controlp INFIELD b_gzwl004
            #add-point:ON ACTION controlp INFIELD b_gzwl004

            #END add-point
 
         #----<<b_gzwl007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_gzwl007
            #add-point:BEFORE FIELD b_gzwl007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_gzwl007
            
            #add-point:AFTER FIELD b_gzwl007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_gzwl007
         ON ACTION controlp INFIELD b_gzwl007
            #add-point:ON ACTION controlp INFIELD b_gzwl007

            #END add-point
 
         #----<<b_gzwl008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_gzwl008
            #add-point:BEFORE FIELD b_gzwl008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_gzwl008
            
            #add-point:AFTER FIELD b_gzwl008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_gzwl008
         ON ACTION controlp INFIELD b_gzwl008
            #add-point:ON ACTION controlp INFIELD b_gzwl008

            #END add-point
 
         #----<<gzwl005>>----
         #----<<gzwl002>>----
         #----<<gzwl002_desc>>----
         #----<<gzwl006>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      #160726-00036#1
      CONSTRUCT g_wc_table2 ON gzwl002,gzwl006
           FROM s_detail2[1].gzwl002,s_detail2[1].gzwl006
      END CONSTRUCT
      #end add-point 
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   #160726-00036#1
   IF g_wc_table = " 1=1" AND g_wc_table2 = " 1=1" THEN
      LET g_wc = "gzwl001 IS NOT NULL"
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL azzq080_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="azzq080.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzq080_b_fill()
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
   DEFINE ls_sql          STRING
   DEFINE ls_dbs          STRING
   DEFINE lc_gzwl009      LIKE gzwl_t.gzwl009
   DEFINE lc_gzwl012      LIKE gzwl_t.gzwl012
   DEFINE lc_gzou003      LIKE gzou_t.gzou003
   #end add-point
 
   #add-point:b_fill段sql_before
   #抓取清單前, 先整理PID使用情況
   #預計是透過森雄的工具重整

   #必須先處理左側授權列表, 
   CALL azzq080_license_collect()
   #顯示上方人數資訊
   IF g_auth_cnt = 32767 THEN
      DISPLAY g_detail_cnt2, "∞" TO FORMONLY.auth_count, FORMONLY.auth_total
   ELSE
      DISPLAY g_detail_cnt2, g_auth_cnt TO FORMONLY.auth_count, FORMONLY.auth_total
   END IF
   IF g_gzwl2_d.getLength() > 0 THEN
      CALL g_curr_diag.setCurrentRow("s_detail2", 1)
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 = 0 OR cl_null(g_detail_idx2) THEN
         LET g_detail_idx2 = 1
      END IF
      CALL azzq080_process_b_fill(g_gzwl2_d[g_detail_idx2].gzwl005)
   END IF
   RETURN

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF

   LET ls_sql = "SELECT gzou003 FROM gzou_t WHERE gzou001 = ?"
   PREPARE b_fill_getdbs_pre FROM ls_sql
#   LET g_sql = "SELECT DISTINCT gzwl005, gzwl002, ooag011, gzwl006 FROM gzwl_t",
#               " LEFT OUTER JOIN ooag_t ON ooagent = gzwl012 AND ooag001 = gzwl009",
#               " WHERE ", g_wc, " AND ", g_wc_filter,cl_sql_add_filter("gzwl_t"),
#               " ORDER BY gzwl_t.gzwl002"
   LET ls_sql = "SELECT DISTINCT gzwl005, gzwl002, '', gzwl006, gzwl009, gzwl012 FROM gzwl_t",
                " WHERE ", g_wc, " AND ", g_wc_filter,cl_sql_add_filter("gzwl_t"),
                " ORDER BY gzwl_t.gzwl002"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   PREPARE azzq080_pb2 FROM ls_sql
   DECLARE b2_fill_curs CURSOR FOR azzq080_pb2
   CALL g_gzwl2_d.clear()
   LET l_ac_d = 1
   FOREACH b2_fill_curs INTO g_gzwl2_d[l_ac_d].gzwl005, g_gzwl2_d[l_ac_d].gzwl002,
                             g_gzwl2_d[l_ac_d].gzwl002_desc, g_gzwl2_d[l_ac_d].gzwl006,
                             lc_gzwl009, lc_gzwl012
      #授權先全抓, 應該尚未大量到開不出來
      IF cl_null(lc_gzwl012) THEN
         LET lc_gzwl012 = g_enterprise
         LET lc_gzou003 = g_dbs
      ELSE
         INITIALIZE lc_gzou003 TO NULL
         EXECUTE b_fill_getdbs_pre INTO lc_gzou003 USING lc_gzwl012
         IF cl_null(lc_gzou003) THEN
            LET lc_gzou003 = g_dbs
         END IF
      END IF
      LET ls_sql = "SELECT ooag011 FROM ", lc_gzou003 CLIPPED,".ooag_t WHERE ooagent = ? AND ooag001 = ?"
      PREPARE b_fill_getname_pre FROM ls_sql
      EXECUTE b_fill_getname_pre INTO g_gzwl2_d[l_ac_d].gzwl002_desc USING lc_gzwl012, lc_gzwl009
      LET l_ac_d = l_ac_d + 1
   END FOREACH
   #end add-point
 
#   IF cl_null(g_wc_filter) THEN
#      LET g_wc_filter = " 1=1"
#   END IF
#   IF cl_null(g_wc) THEN
#      LET g_wc = " 1=1"
#   END IF
#   IF cl_null(g_wc2) THEN
#      LET g_wc2 = " 1=1"
#   END IF
#   
#   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
#   
#   LET g_sql = "SELECT  UNIQUE '',gzwl001,gzwl003,'',gzwl004,gzwl007,gzwl014,gzwl008,'','','','' FROM gzwl_t", 
#
# 
# 
#               "",
#               " WHERE 1=1 AND ", ls_wc,cl_sql_add_filter("gzwl_t")
#    
#   LET g_sql = g_sql, cl_sql_add_filter("gzwl_t"),
#                      " ORDER BY gzwl_t.gzwl001"
#  
   #add-point:b_fill段sql_after

   #end add-point
 
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE azzq080_pb FROM g_sql
#   DECLARE b_fill_curs CURSOR FOR azzq080_pb
#   
#   OPEN b_fill_curs
# 
#   CALL g_gzwl_d.clear()
#   CALL g_gzwl2_d.clear()   
 
 
   #add-point:陣列清空
 
   #end add-point
 
#   LET g_cnt = l_ac
#   LET l_ac = 1   
#   ERROR "Searching!" 
# 
#   FOREACH b_fill_curs INTO g_gzwl_d[l_ac].sel,g_gzwl_d[l_ac].gzwl001,g_gzwl_d[l_ac].gzwl003,g_gzwl_d[l_ac].gzwl003_desc, 
#       g_gzwl_d[l_ac].gzwl004,g_gzwl_d[l_ac].gzwl007,g_gzwl_d[l_ac].gzwl014,g_gzwl_d[l_ac].gzwl008,g_gzwl2_d[l_ac].gzwl005, 
#       g_gzwl2_d[l_ac].gzwl002,g_gzwl2_d[l_ac].gzwl002_desc,g_gzwl2_d[l_ac].gzwl006
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
      
      #LET g_gzwl_d[l_ac].statepic = cl_get_actipic(g_gzwl_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
      
#      CALL azzq080_detail_show("'1'")      
 
      #同一授權process列表全部顯示
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#         END IF
#         EXIT FOREACH
#      END IF
#      LET l_ac = l_ac + 1
#      
#   END FOREACH
#   LET g_error_show = 0
#   
# 
#   
#   CALL g_gzwl_d.deleteElement(g_gzwl_d.getLength())   
#   CALL g_gzwl2_d.deleteElement(g_gzwl2_d.getLength())
 
 
   #add-point:陣列長度調整

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身)
 
   #end add-point
#   LET g_detail_cnt = g_gzwl_d.getLength()
#   DISPLAY g_detail_cnt TO FORMONLY.h_count
#   LET l_ac = g_cnt
#   LET g_cnt = 0
#   
#   CLOSE b_fill_curs
#   FREE azzq080_pb
#   
#   LET l_ac = 1
#   IF g_gzwl_d.getLength() > 0 THEN
#      CALL azzq080_fetch()
#   END IF
   
      CALL azzq080_filter_show('gzwl001','b_gzwl001')
   CALL azzq080_filter_show('gzwl003','b_gzwl003')
   CALL azzq080_filter_show('gzwl004','b_gzwl004')
   CALL azzq080_filter_show('gzwl007','b_gzwl007')
   CALL azzq080_filter_show('gzwl014','b_gzwl014')
   CALL azzq080_filter_show('gzwl008','b_gzwl008')
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzq080.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzq080_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
 
   #add-point:陣列清空
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後
   
   #end add-point 
   
 
   #add-point:陣列筆數調整
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzq080.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzq080_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION azzq080_filter()
   #add-point:filter段define

   #end add-point    
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gzwl001,gzwl003,gzwl004,gzwl007,gzwl014,gzwl008
                          FROM s_detail1[1].b_gzwl001,s_detail1[1].b_gzwl003,s_detail1[1].b_gzwl004, 
                              s_detail1[1].b_gzwl007,s_detail1[1].b_gzwl014,s_detail1[1].b_gzwl008
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
                     DISPLAY azzq080_filter_parser('gzwl001') TO s_detail1[1].b_gzwl001
            DISPLAY azzq080_filter_parser('gzwl003') TO s_detail1[1].b_gzwl003
            DISPLAY azzq080_filter_parser('gzwl004') TO s_detail1[1].b_gzwl004
            DISPLAY azzq080_filter_parser('gzwl007') TO s_detail1[1].b_gzwl007
            DISPLAY azzq080_filter_parser('gzwl014') TO s_detail1[1].b_gzwl014
            DISPLAY azzq080_filter_parser('gzwl008') TO s_detail1[1].b_gzwl008
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG 
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
 
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL azzq080_filter_show('gzwl001','b_gzwl001')
   CALL azzq080_filter_show('gzwl003','b_gzwl003')
   CALL azzq080_filter_show('gzwl004','b_gzwl004')
   CALL azzq080_filter_show('gzwl007','b_gzwl007')
   CALL azzq080_filter_show('gzwl014','b_gzwl014')
   CALL azzq080_filter_show('gzwl008','b_gzwl008')
 
    
   CALL azzq080_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION azzq080_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define
   
   #end add-point    
 
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION azzq080_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = azzq080_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.insert" >}
#+ insert
PRIVATE FUNCTION azzq080_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzq080.modify" >}
#+ modify
PRIVATE FUNCTION azzq080_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.reproduce" >}
#+ reproduce
PRIVATE FUNCTION azzq080_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.delete" >}
#+ delete
PRIVATE FUNCTION azzq080_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq080.other_function" >}
################################################################################
# Descriptions...: 抓取指定授權下的目前執行清單
# Memo...........: 
# Usage..........: CALL azzq080_process_b_fill(pc_gzwl005)
# Input parameter: pc_gzwl005   授權編號
# Return code....: None
# Date & Author..: 2014/09/22 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzq080_process_b_fill(pc_gzwl005)
   DEFINE pc_gzwl005   LIKE gzwl_t.gzwl005
   DEFINE lr_others    RECORD
             pid       LIKE type_t.chr20,
             exemode   LIKE type_t.chr20,
             agent     LIKE type_t.chr20,
             appname   LIKE type_t.chr50,
             host      LIKE type_t.chr50
                       END RECORD
   DEFINE li_i         LIKE type_t.num5
   DEFINE li_repeat    BOOLEAN
   DEFINE lc_channel   base.Channel
   DEFINE ls_cmd       STRING
   DEFINE ls_str       STRING

   #組出右側第一筆資料的where條件
   IF cl_db_setconnect("dscom") THEN END IF
   LET g_sql = "SELECT  UNIQUE '',gzwl001,gzwl003,'',gzwl004,gzwl015,gzwl008,gzwl010,gzwl007,gzwl012,gzwl014,gzwl013 FROM gzwl_t", 
               " WHERE ", g_wc, " AND ", g_wc_filter,cl_sql_add_filter("gzwl_t"),
               "   AND gzwl005 = '", pc_gzwl005, "'",
               " ORDER BY gzwl_t.gzwl004"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzq080_process_b_fill_pre FROM g_sql
   DECLARE azzq080_process_b_fill_curs CURSOR FOR azzq080_process_b_fill_pre
   OPEN azzq080_process_b_fill_curs
   CALL g_gzwl_d.clear()
   LET l_ac = 1   
   FOREACH azzq080_process_b_fill_curs INTO g_gzwl_d[l_ac].sel,g_gzwl_d[l_ac].gzwl001,g_gzwl_d[l_ac].gzwl003,g_gzwl_d[l_ac].gzwl003_desc, 
       g_gzwl_d[l_ac].gzwl004,g_gzwl_d[l_ac].gzwl015,g_gzwl_d[l_ac].gzwl008,g_gzwl_d[l_ac].gzwl010,g_gzwl_d[l_ac].gzwl007,g_gzwl_d[l_ac].gzwl012,g_gzwl_d[l_ac].gzwl014,g_gzwl_d[l_ac].gzwl013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_gzwl_d[l_ac].sel = "N"
      #同一授權process列表全部顯示
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_gzwl_d.deleteElement(l_ac)

   #160726-00036#1 如果有下條件, 就不要額外列出非gzwl資料
   IF g_wc.trim() = "1=1" OR g_wc.trim() = "gzwl001 IS NOT NULL" THEN
   #再去找TERMINAL沒有落在gzwl資料的process, 沒有gzwl005對應, 先拿g_detail_idx2的fdid來尋找
   LET g_sql = "SELECT pid, exemode, agent, appname, host FROM licinfo",
               " WHERE fdid = '", g_gzwl2_d[g_detail_idx2].gzwl005_desc, "'"
   PREPARE azzq080_process_b_fill_pre2 FROM g_sql
   DECLARE azzq080_process_b_fill_curs2 CURSOR FOR azzq080_process_b_fill_pre2
   LET l_ac = g_gzwl_d.getLength() + 1
   FOREACH azzq080_process_b_fill_curs2 INTO lr_others.pid, lr_others.exemode, lr_others.agent, lr_others.appname, lr_others.host
      LET li_repeat = FALSE
      FOR li_i = 1 TO g_gzwl_d.getLength()
          IF g_gzwl_d[li_i].gzwl008 = lr_others.pid THEN
             LET li_repeat = TRUE
             EXIT FOR
          END IF
      END FOR
      IF NOT li_repeat THEN
         LET g_gzwl_d[l_ac].sel = "N"
         LET g_gzwl_d[l_ac].gzwl008 = lr_others.pid
         LET g_gzwl_d[l_ac].gzwl007 = lr_others.exemode, "-", lr_others.agent
         LET g_gzwl_d[l_ac].gzwl015 = lr_others.host
         IF lr_others.appname IS NOT NULL THEN
            LET g_gzwl_d[l_ac].gzwl003_desc = lr_others.appname
         ELSE
            LET lc_channel = base.Channel.create()
            LET ls_cmd = "ps -ef | grep -v grep | grep '", lr_others.pid, "' | awk '{print $9}'"
            CALL lc_channel.openPipe(ls_cmd, "r")
            CALL lc_channel.setDelimiter("")
            WHILE lc_channel.read(ls_str)
               EXIT WHILE
            END WHILE
            LET g_gzwl_d[l_ac].gzwl003_desc = ls_str
         END IF
         LET l_ac = l_ac + 1
      END IF
   END FOREACH
   END IF

   #關聯原DB資料
   IF cl_db_setconnect(g_dbs_old) THEN END IF
   LET g_sql = "SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = ? AND gzzal002 = ?"
   PREPARE azzq080_process_b_fill_getgzzal_pre FROM g_sql
   FOR l_ac = 1 TO g_gzwl_d.getLength()
       EXECUTE azzq080_process_b_fill_getgzzal_pre USING g_gzwl_d[l_ac].gzwl003, g_lang INTO g_gzwl_d[l_ac].gzwl003_desc
   END FOR

   CALL cl_process_user_limit(pc_gzwl005) RETURNING g_limit_cnt, g_detail_cnt, g_exec_notover
   #160726-00036#1 執行作業數已經不只gzwl_t內的資料
   LET g_detail_cnt = g_gzwl_d.getLength()
   IF g_limit_cnt = 32767 THEN
      DISPLAY g_detail_cnt, "∞" TO FORMONLY.process_count, FORMONLY.process_limit
   ELSE
      DISPLAY g_detail_cnt, g_limit_cnt TO FORMONLY.process_count, FORMONLY.process_limit
   END IF
END FUNCTION
################################################################################
# Descriptions...: Genero License清單整理
# Memo...........: 初測, 不同主機同FGLSERVER, 會是一樣的FrontEndId2, License看來是同一個, 主機資訊應該在Process列表呈現
# Usage..........: CALL azzq080_license_collect()
# Input parameter: None
# Return code....: None
# Date & Author..: 2015/06/30 By Saki
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq080_license_collect()
   DEFINE lc_channel base.Channel
   DEFINE ls_str STRING
   DEFINE ls_info STRING
   DEFINE ls_host STRING
   DEFINE ls_fdid STRING
   DEFINE ls_tmp STRING
   DEFINE li_i SMALLINT
   DEFINE ls_jsonstr_d STRING
   DEFINE lr_listchk RECORD
             fdid      LIKE type_t.chr100,
             pid       LIKE type_t.chr20,
             name      LIKE type_t.chr50,
             ip        LIKE type_t.chr20,
             exemode   LIKE type_t.chr20,
             agent     LIKE type_t.chr20,
             appname   LIKE type_t.chr50,
             host      LIKE type_t.chr50
                     END RECORD
   DEFINE ls_sql STRING
   DEFINE li_idx LIKE type_t.num5
   DEFINE ls_cmd STRING
   DEFINE li_cnt LIKE type_t.num5

   CALL g_gzwl2_d.clear()
   CALL g_aid.clear()
   INITIALIZE g_fglwrt TO NULL

   #先執行一下process紀錄檢測並清除過期的
   CALL cl_process_auth_refresh()

   #整理資訊要用到全體gzwl_t, 需先連結dscom, 處理完後才連回原DB
   IF cl_db_setconnect("dscom") THEN END IF
   CREATE TEMP TABLE licinfo(
      fdid        VARCHAR(100),
      pid         VARCHAR(20),
      name        VARCHAR(50),
      ip          VARCHAR(20),
      exemode     VARCHAR(20),
      agent       VARCHAR(20),
      appname     VARCHAR(50),
      host        VARCHAR(50)
   );
   DELETE FROM licinfo
   LET ls_sql = "INSERT INTO licinfo(fdid,pid,name,ip,exemode,agent,appname,host)",
                "             VALUES(?,?,?,?,?,?,?,?)"
   PREPARE azzq080_license_collect_tmp_pre FROM ls_sql

   LET lc_channel = base.Channel.create()
   CALL lc_channel.openPipe("fglWrt -a info users", "r")
   CALL lc_channel.setDelimiter("")
   WHILE lc_channel.read(ls_str)
      IF ls_str IS NULL THEN
         CONTINUE WHILE
      END IF
      LET g_fglwrt = g_fglwrt, ls_str, "\n"

      #處理單頭
      CASE
         WHEN ls_str.getIndexOf("CPU(s)", 1)
            LET g_auth_cnt = 32767
         WHEN ls_str.getIndexOf("Users", 1)
            LET ls_info = ls_str.subString(ls_str.getIndexOf(":",1)+1, ls_str.getLength())
            IF ls_info IS NULL THEN
               LET ls_info = ls_str.subString(ls_str.getIndexOf("Users",1)+5, ls_str.getLength())
            END IF
            LET ls_info = ls_info.trim()
            LET ls_tmp = ls_info.subString(1, ls_info.getIndexOf("/",1)-1)
            LET g_detail_cnt2 = ls_tmp
            LET ls_tmp = ls_info.subString(ls_info.getIndexOf("/",1)+1, ls_info.getLength())
            LET g_auth_cnt = ls_tmp
      END CASE

      #Host是取到一次以後給單身輪著用的
      IF ls_str.getIndexOf("Host",1) THEN
         LET ls_info = ls_str.subString(ls_str.getIndexOf(":",1)+1, ls_str.getLength())
         IF ls_info IS NULL THEN
            LET ls_info = ls_str.subString(ls_str.getIndexOf("Host",1)+4, ls_str.getLength())
         END IF
         LET ls_host = ls_info.trim()
         CONTINUE WHILE
      END IF

      IF ls_str.getIndexOf("FrontEndId2",1) THEN
         LET ls_info = ls_str.subString(ls_str.getIndexOf(":",1)+1, ls_str.getLength())
         IF ls_info IS NULL THEN
            LET ls_info = ls_str.subString(ls_str.getIndexOf("FrontEndId2",1)+11, ls_str.getLength())
         END IF
         LET ls_fdid = ls_info.trim()
         CONTINUE WHILE
      END IF

      #找單身
      FOR li_i = 1 TO g_keyword_d.getLength()
          IF ls_str.getIndexOf(g_keyword_d[li_i].keyname,1) THEN
             INITIALIZE ls_info TO NULL
             IF g_keyword_d[li_i].keyname = "Process Id" THEN
                IF ls_jsonstr_d IS NOT NULL THEN
                   #要先做一個很白癡的比對方式
                   CALL util.JSON.parse("{"||ls_jsonstr_d.subString(1, ls_jsonstr_d.getLength()-1)||"}", lr_listchk)
                   #推測是GWC進入
                   IF lr_listchk.agent IS NOT NULL THEN
                      INITIALIZE lr_listchk.fdid TO NULL
                      LET lr_listchk.fdid = "Web Process - ", lr_listchk.pid
                      LET ls_jsonstr_d = util.JSON.stringify(lr_listchk)
                      LET ls_jsonstr_d = ls_jsonstr_d.subString(2, ls_jsonstr_d.getLength()-1),","
                   END IF
                   #推測是WS進入
                   IF lr_listchk.pid IS NOT NULL AND lr_listchk.name IS NULL AND
                      lr_listchk.ip IS NULL AND lr_listchk.exemode IS NULL AND
                      lr_listchk.agent IS NULL AND lr_listchk.appname IS NULL THEN
                      INITIALIZE lr_listchk.fdid TO NULL
                      LET lr_listchk.name = "Web Service"
                      LET lr_listchk.fdid = "Process - ", lr_listchk.pid
                      LET ls_jsonstr_d = util.JSON.stringify(lr_listchk)
                      LET ls_jsonstr_d = ls_jsonstr_d.subString(2, ls_jsonstr_d.getLength()-1),","
                   END IF
                   EXECUTE azzq080_license_collect_tmp_pre
                     USING lr_listchk.fdid,lr_listchk.pid,lr_listchk.name,lr_listchk.ip,
                           lr_listchk.exemode,lr_listchk.agent,lr_listchk.appname,
                           lr_listchk.host
                   INITIALIZE ls_jsonstr_d TO NULL
                   LET ls_jsonstr_d = ls_jsonstr_d, "\"host\":\"", ls_host, "\",\"fdid\":\"", ls_fdid, "\","
                ELSE
                   LET ls_jsonstr_d = ls_jsonstr_d, "\"host\":\"", ls_host, "\",\"fdid\":\"", ls_fdid, "\","
                END IF
                LET ls_info = ls_str.subString(ls_str.getIndexOf(g_keyword_d[li_i].keyname,1)+g_keyword_d[li_i].wordnum, ls_str.getLength())
             END IF
             IF ls_info IS NULL THEN
                LET ls_info = ls_str.subString(ls_str.getIndexOf(":",1)+1, ls_str.getLength())
             END IF
             IF ls_info IS NULL THEN
                LET ls_info = ls_str.subString(ls_str.getIndexOf(g_keyword_d[li_i].keyname,1)+g_keyword_d[li_i].wordnum, ls_str.getLength())
             END IF
             LET ls_info = ls_info.trim()
             LET ls_jsonstr_d = ls_jsonstr_d, "\"", g_keyword_d[li_i].field, "\":\"", ls_info, "\","
             EXIT FOR
          END IF
      END FOR
   END WHILE
   #最後一筆資料要加進去呀!
   IF ls_jsonstr_d IS NOT NULL THEN
      CALL util.JSON.parse("{"||ls_jsonstr_d.subString(1, ls_jsonstr_d.getLength()-1)||"}", lr_listchk)
      IF lr_listchk.agent IS NOT NULL THEN
         INITIALIZE lr_listchk.fdid TO NULL
         LET lr_listchk.fdid = "Web Process - ", lr_listchk.pid
         LET ls_jsonstr_d = util.JSON.stringify(lr_listchk)
         LET ls_jsonstr_d = ls_jsonstr_d.subString(2, ls_jsonstr_d.getLength()-1),","
      END IF
      #推測是WS進入
      IF lr_listchk.pid IS NOT NULL AND lr_listchk.name IS NULL AND
         lr_listchk.ip IS NULL AND lr_listchk.exemode IS NULL AND
         lr_listchk.agent IS NULL AND lr_listchk.appname IS NULL THEN
         INITIALIZE lr_listchk.fdid TO NULL
         LET lr_listchk.name = "Web Service"
         LET lr_listchk.fdid = "Process - ", lr_listchk.pid
         LET ls_jsonstr_d = util.JSON.stringify(lr_listchk)
         LET ls_jsonstr_d = ls_jsonstr_d.subString(2, ls_jsonstr_d.getLength()-1),","
      END IF
      EXECUTE azzq080_license_collect_tmp_pre
        USING lr_listchk.fdid,lr_listchk.pid,lr_listchk.name,lr_listchk.ip,
              lr_listchk.exemode,lr_listchk.agent,lr_listchk.appname,
              lr_listchk.host
      INITIALIZE ls_jsonstr_d TO NULL
   END IF

   #整理, 並結合process資訊
   LET ls_sql = "SELECT t1.gzwl005, t1.gzwl002, t1.gzwl012, t1.gzwl006, t1.gzwl015, t1.gzwl009, t0.fdid, t0.name, t0.host",
                "  FROM licinfo t0",
                "  LEFT JOIN gzwl_t t1 ON t1.gzwl008 = t0.pid AND t1.gzwl015 = t0.host",
                " WHERE t0.fdid = ? AND t0.ip = ?"
   PREPARE azzq080_license_collect_gzwl_pre FROM ls_sql
   DECLARE azzq080_license_collect_gzwl_curs CURSOR FOR azzq080_license_collect_gzwl_pre
   LET ls_sql = "SELECT t1.gzwl005, t1.gzwl002, t1.gzwl012, t1.gzwl006, t1.gzwl015, t1.gzwl009, t0.fdid, t0.name, t0.host",
                "  FROM licinfo t0",
                "  LEFT JOIN gzwl_t t1 ON t1.gzwl008 = t0.pid AND t1.gzwl015 = t0.host",
                " WHERE t0.pid = ?"
   PREPARE azzq080_license_collect_gzwl2_pre FROM ls_sql
   DECLARE azzq080_license_collect_gzwl2_curs CURSOR FOR azzq080_license_collect_gzwl2_pre

   #160726-00036#1 有下查詢條件時, 左側選單要經過篩選的SQL處理
   LET ls_sql = "SELECT COUNT(*) FROM gzwl_t WHERE ", g_wc," AND gzwl005 = ?"
   PREPARE azzq080_license_collect_qbe_pre FROM ls_sql
   DECLARE azzq080_license_collect_qbe_curs CURSOR FOR azzq080_license_collect_qbe_pre

   LET ls_sql = "SELECT fdid, ip, MAX(pid) FROM licinfo GROUP BY fdid, ip"
   PREPARE azzq080_license_collect_analyze_pre FROM ls_sql
   DECLARE azzq080_license_collect_analyze_curs CURSOR FOR azzq080_license_collect_analyze_pre
   LET li_idx = 1
   FOREACH azzq080_license_collect_analyze_curs INTO lr_listchk.fdid, lr_listchk.ip, lr_listchk.pid
      INITIALIZE lr_listchk.name, lr_listchk.host TO NULL
      IF lr_listchk.fdid IS NOT NULL AND lr_listchk.ip IS NOT NULL THEN
         #同一個FGLSERVER會混雜不紀錄gzwl的process進來, 最好找到其中有gzwl的來呈現
         FOREACH azzq080_license_collect_gzwl_curs USING lr_listchk.fdid, lr_listchk.ip
            INTO g_gzwl2_d[li_idx].gzwl005, g_gzwl2_d[li_idx].gzwl002, g_aid[li_idx].gzwl012, g_gzwl2_d[li_idx].gzwl006, g_gzwl2_d[li_idx].gzwl015, g_aid[li_idx].gzwl009, g_gzwl2_d[li_idx].gzwl005_desc, lr_listchk.name, lr_listchk.host
            IF g_gzwl2_d[li_idx].gzwl005 IS NOT NULL THEN
               EXIT FOREACH
            END IF
         END FOREACH
         IF g_gzwl2_d[li_idx].gzwl005 IS NULL AND lr_listchk.fdid[1] = "{" THEN
            LET g_gzwl2_d[li_idx].gzwl002_desc = "Developer"
         END IF
      ELSE
         #GWC進入沒有fdid, 而且一個process就佔一個user license, 用pid連結gzwl忠實呈現
         FOREACH azzq080_license_collect_gzwl2_curs USING lr_listchk.pid
            INTO g_gzwl2_d[li_idx].gzwl005, g_gzwl2_d[li_idx].gzwl002, g_aid[li_idx].gzwl012, g_gzwl2_d[li_idx].gzwl006, g_gzwl2_d[li_idx].gzwl015, g_aid[li_idx].gzwl009, g_gzwl2_d[li_idx].gzwl005_desc, lr_listchk.name, lr_listchk.host
            IF g_gzwl2_d[li_idx].gzwl005 IS NOT NULL THEN
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      #160726-00036#1 有下查詢條件時, gzwl資料有存在才顯示在左方列表
      IF g_wc.trim() != "1=1" AND g_wc.trim() != "gzwl001 IS NOT NULL" THEN
         IF g_gzwl2_d[li_idx].gzwl005 IS NULL THEN
            CALL g_gzwl2_d.deleteElement(li_idx)
            CONTINUE FOREACH
         ELSE
            EXECUTE azzq080_license_collect_qbe_curs USING g_gzwl2_d[li_idx].gzwl005 INTO li_cnt
            IF li_cnt <= 0 THEN
               CALL g_gzwl2_d.deleteElement(li_idx)
               CONTINUE FOREACH
            END IF
         END IF
      END IF
      IF g_gzwl2_d[li_idx].gzwl005 IS NULL THEN
         LET g_gzwl2_d[li_idx].gzwl002 = lr_listchk.name
         LET g_gzwl2_d[li_idx].gzwl006 = lr_listchk.ip
         LET g_gzwl2_d[li_idx].gzwl015 = lr_listchk.host
         LET g_gzwl2_d[li_idx].gzwl005_desc = lr_listchk.fdid
      END IF
      LET li_idx = li_idx + 1
   END FOREACH

   #再結合原有資料庫資訊
   IF cl_db_setconnect(g_dbs_old) THEN END IF
   LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent = ? AND ooag001 = ?"
   PREPARE azzq080_license_collect_ooag_pre FROM ls_sql
   LET ls_sql = "SELECT gzxa007 FROM gzxa_t WHERE gzxaent = ? AND gzxa001 = ?"
   PREPARE azzq080_license_collect_gzxa_pre FROM ls_sql
   FOR li_idx = 1 TO g_gzwl2_d.getLength()
       EXECUTE azzq080_license_collect_ooag_pre USING g_aid[li_idx].gzwl012, g_aid[li_idx].gzwl009 INTO g_gzwl2_d[li_idx].gzwl002_desc
       #左側參雜fglWrt取出且gzwl並不存在的資訊, fglWrt的電腦id可能被誤解讀為使用者帳號
       EXECUTE azzq080_license_collect_gzxa_pre USING g_aid[li_idx].gzwl012, g_gzwl2_d[li_idx].gzwl002 INTO g_gzwl2_d[li_idx].gzxa007
   END FOR

END FUNCTION
################################################################################
# Descriptions...: 定義fglWrt單身分析的keyword
# Memo...........: 
# Usage..........: CALL azzq080_license_keyword_define()
# Input parameter: None
# Return code....: None
# Date & Author..: 2015/06/30 By Saki
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq080_license_keyword_define()
   DEFINE ls_str STRING
   DEFINE li_i SMALLINT

   #建立關鍵字集
   LET ls_str = "[",
                "{\"keyname\":\"License\",\"field\":\"license\"},",
                "{\"keyname\":\"Product\",\"field\":\"product\"},",
                "{\"keyname\":\"Type\",\"field\":\"type\"},",
                "{\"keyname\":\"Users\",\"field\":\"status\"},",
                "{\"keyname\":\"CPU(s)\",\"field\":\"status\"}",
                "]"
   CALL util.JSON.parse(ls_str, g_keyword_h)
   FOR li_i = 1 TO g_keyword_h.getLength()
       LET g_keyword_h[li_i].wordnum = g_keyword_h[li_i].keyname.getLength()
   END FOR
   LET ls_str = "[",
                "{\"keyname\":\"Process Id\",\"field\":\"pid\"},",
                "{\"keyname\":\"user-name\",\"field\":\"name\"},",
                "{\"keyname\":\"host-addr\",\"field\":\"ip\"},",
                "{\"keyname\":\"cx-mode\",\"field\":\"exemode\"},",
                "{\"keyname\":\"user-agent\",\"field\":\"agent\"},",
                "{\"keyname\":\"app-name\",\"field\":\"appname\"}",
                "]"
   CALL util.JSON.parse(ls_str, g_keyword_d)
   FOR li_i = 1 TO g_keyword_d.getLength()
       LET g_keyword_d[li_i].wordnum = g_keyword_d[li_i].keyname.getLength()
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 定義fglWrt單身分析的keyword
# Memo...........: 
# Usage..........: CALL azzq080_license_keyword_define()
# Input parameter: None
# Return code....: None
# Date & Author..: 2015/06/30 By Saki
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq080_fglwrt_display()
   DEFINE lwin_curr ui.Window
   DEFINE lfrm_curr ui.Form

   OPEN WINDOW azzq080_fglwrt_display_w WITH FORM cl_ap_formpath("azz","azzq080_s02")
      ATTRIBUTES(STYLE="layoutwin")
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()

   DISPLAY g_fglwrt TO formonly.fglwrt
   MENU ""
      ON ACTION close
         EXIT MENU
      ON ACTION exit
         EXIT MENU
   END MENU

   CLOSE WINDOW azzq080_fglwrt_display_w
END FUNCTION

################################################################################
# Descriptions...: 動態新增Style, 以便fglWrt視窗有find功能
# Memo...........: 
# Usage..........: CALL azzq080_add_style()
# Input parameter: None
# Return code....: None
# Date & Author..: 2015/07/16 By Saki
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq080_add_style()
   DEFINE lnode_root,lnode_item,lnode_child,lnode_att om.DomNode
   DEFINE llst_styles om.NodeList
   DEFINE li_i SMALLINT

   LET lnode_root = ui.Interface.getRootNode()
   LET llst_styles = lnode_root.selectByTagName("StyleList")
   FOR li_i = 1 TO llst_styles.getLength()
       LET lnode_item = llst_styles.item(li_i)
       LET lnode_child = lnode_item.createChild("Style")
       CALL lnode_child.setAttribute("name", "TextEdit.integratedSearch")
       LET lnode_att = lnode_child.createChild("StyleAttribute")
       CALL lnode_att.setAttribute("name", "integratedSearch")
       CALL lnode_att.setAttribute("value", "yes")
       EXIT FOR
   END FOR
END FUNCTION
################################################################################
# Descriptions...: 刪除線上process, 並記錄log
# Memo...........: 如果提供不同主機hostname, 是否能刪掉其他主機上的process
# Usage..........: CALL azzq080_kill_process()
# Input parameter: None
# Return code....: None
# Date & Author..: 2015/07/31 By Saki
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq080_kill_process()
   DEFINE ls_ttpswd     STRING
   DEFINE li_idx        LIKE type_t.num5
   DEFINE li_sel_flag   BOOLEAN
   DEFINE ls_cmd        STRING
   DEFINE li_success    BOOLEAN
   DEFINE ls_result     STRING
   DEFINE li_allow_del  BOOLEAN
   DEFINE lr_gzwl       RECORD LIKE gzwl_t.*
   DEFINE lr_gzwn       DYNAMIC ARRAY OF RECORD LIKE gzwn_t.*
   DEFINE ls_sql        STRING
   DEFINE ls_sql_sel    STRING
   DEFINE ls_sql_ins    STRING
   DEFINE ls_sql_del    STRING
   DEFINE ld_date       LIKE type_t.dat
   DEFINE ls_date       STRING
   DEFINE ls_slip       STRING

   LET li_success = TRUE
   LET ls_sql_sel = "SELECT gzwl001, gzwl002, gzwl003, gzwl004, gzwl005, gzwl006, gzwl007,",
                    "       gzwl008, gzwl009, gzwl010, gzwl011, gzwl012, gzwl013, gzwl014,",
                    "       gzwl015 FROM gzwl_t",
                    " WHERE gzwl001 = ?"
   LET ls_sql_ins = "INSERT INTO gzwn_t(gzwndocno, gzwncrtid, gzwncrtdt, gzwn001,",
                    "                   gzwn002, gzwn003, gzwn004, gzwn005, gzwn006,",
                    "                   gzwn007, gzwn008, gzwn009, gzwn010, gzwn011,",
                    "                   gzwn012, gzwn013, gzwn014, gzwn015, gzwn099)",
                    " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
   LET ls_sql_del = "DELETE FROM gzwl_t WHERE gzwl001 = ?"

   #有選擇的話才開始進行步驟
   LET li_sel_flag = FALSE
   FOR li_idx = 1 TO g_gzwl_d.getLength()
       IF g_gzwl_d[li_idx].sel = "Y" THEN
          LET li_sel_flag = TRUE
          EXIT FOR
       END IF
   END FOR

   IF li_sel_flag THEN
      INITIALIZE ls_ttpswd TO NULL
      IF cl_ask_confirm("lib-00208") THEN
         CALL azzq080_01() RETURNING li_allow_del, ls_ttpswd
         IF li_allow_del AND NOT cl_null(ls_ttpswd) THEN
            IF NOT cl_db_setconnect("dscom") THEN END IF
            PREPARE azzq080_kill_process_getinfo1_pre FROM ls_sql_sel
            PREPARE azzq080_kill_process_log1_pre FROM ls_sql_ins
            PREPARE azzq080_kill_process1_pre FROM ls_sql_del
            FOR li_idx = 1 TO g_gzwl_d.getLength()
                IF g_gzwl_d[li_idx].sel = "Y" THEN
                   LET ls_cmd = "echo \"",ls_ttpswd.trim(),"\"|sudo -S -k -u root kill -15 ", g_gzwl_d[li_idx].gzwl008," 2>&1 >&-"
                   RUN ls_cmd RETURNING ls_result
                   IF ls_result != "0" THEN
                      LET li_success = FALSE
                   ELSE
                      #寫入Log
                      INITIALIZE lr_gzwl.* TO NULL
                      EXECUTE azzq080_kill_process_getinfo1_pre USING g_gzwl_d[li_idx].gzwl001
                         INTO lr_gzwl.gzwl001, lr_gzwl.gzwl002, lr_gzwl.gzwl003, lr_gzwl.gzwl004,
                              lr_gzwl.gzwl005, lr_gzwl.gzwl006, lr_gzwl.gzwl007, lr_gzwl.gzwl008,
                              lr_gzwl.gzwl009, lr_gzwl.gzwl010, lr_gzwl.gzwl011, lr_gzwl.gzwl012,
                              lr_gzwl.gzwl013, lr_gzwl.gzwl014, lr_gzwl.gzwl015
                      IF cl_null(lr_gzwl.gzwl001) THEN
                         #這時候應該是沒有進入gzwl的process
                         LET lr_gzwl.gzwl003 = g_gzwl_d[l_ac].gzwl003_desc
                         LET lr_gzwl.gzwl007 = g_gzwl_d[l_ac].gzwl007
                         LET lr_gzwl.gzwl008 = g_gzwl_d[l_ac].gzwl008
                      END IF
                      EXECUTE azzq080_kill_process1_pre USING g_gzwl_d[li_idx].gzwl001
                      #取單號, 可能會搶號, 又不能放棄紀錄, 因為已經被砍掉了, 迴圈很恐怖, 鎖Table也很恐怖, 先不管搶號的insert不成功
                      LET ld_date = cl_get_current()
                      LET ls_date = ld_date USING 'yyyymmdd'
                      LET ls_sql = "SELECT MAX(gzwndocno) FROM gzwn_t WHERE gzwndocno LIKE '", ls_date,"-%'"
                      PREPARE azzq080_kill_process_docno_pre FROM ls_sql
                      EXECUTE azzq080_kill_process_docno_pre INTO lr_gzwn[li_idx].gzwndocno
                      IF cl_null(lr_gzwn[li_idx].gzwndocno) THEN
                         LET ls_slip = "1"
                      ELSE
                         LET ls_slip = lr_gzwn[li_idx].gzwndocno
                         LET ls_slip = ls_slip.subString(10, ls_slip.getLength())
                         LET ls_slip = ls_slip + 1
                      END IF
                      LET lr_gzwn[li_idx].gzwndocno = ls_date, "-", ls_slip USING "&&&&&&"
                      LET lr_gzwn[li_idx].gzwncrtid = g_user
                      LET lr_gzwn[li_idx].gzwncrtdt = cl_get_current()
                      LET lr_gzwn[li_idx].gzwn099 = "1"
                      LET lr_gzwn[li_idx].gzwn001 = lr_gzwl.gzwl001
                      LET lr_gzwn[li_idx].gzwn002 = lr_gzwl.gzwl002
                      LET lr_gzwn[li_idx].gzwn003 = lr_gzwl.gzwl003
                      LET lr_gzwn[li_idx].gzwn004 = lr_gzwl.gzwl004
                      LET lr_gzwn[li_idx].gzwn005 = lr_gzwl.gzwl005
                      LET lr_gzwn[li_idx].gzwn006 = lr_gzwl.gzwl006
                      LET lr_gzwn[li_idx].gzwn007 = lr_gzwl.gzwl007
                      LET lr_gzwn[li_idx].gzwn008 = lr_gzwl.gzwl008
                      LET lr_gzwn[li_idx].gzwn009 = lr_gzwl.gzwl009
                      LET lr_gzwn[li_idx].gzwn010 = lr_gzwl.gzwl010
                      LET lr_gzwn[li_idx].gzwn011 = lr_gzwl.gzwl011
                      LET lr_gzwn[li_idx].gzwn012 = lr_gzwl.gzwl012
                      LET lr_gzwn[li_idx].gzwn013 = lr_gzwl.gzwl013
                      LET lr_gzwn[li_idx].gzwn014 = lr_gzwl.gzwl014
                      LET lr_gzwn[li_idx].gzwn015 = lr_gzwl.gzwl015
                      EXECUTE azzq080_kill_process_log1_pre
                        USING lr_gzwn[li_idx].gzwndocno, lr_gzwn[li_idx].gzwncrtid, lr_gzwn[li_idx].gzwncrtdt,
                              lr_gzwn[li_idx].gzwn001, lr_gzwn[li_idx].gzwn002, lr_gzwn[li_idx].gzwn003, lr_gzwn[li_idx].gzwn004,
                              lr_gzwn[li_idx].gzwn005, lr_gzwn[li_idx].gzwn006, lr_gzwn[li_idx].gzwn007, lr_gzwn[li_idx].gzwn008,
                              lr_gzwn[li_idx].gzwn009, lr_gzwn[li_idx].gzwn010, lr_gzwn[li_idx].gzwn011, lr_gzwn[li_idx].gzwn012,
                              lr_gzwn[li_idx].gzwn013, lr_gzwn[li_idx].gzwn014, lr_gzwn[li_idx].gzwn015, lr_gzwn[li_idx].gzwn099
                   END IF
                END IF
            END FOR
         END IF
      END IF
   END IF

   IF NOT cl_db_setconnect(g_dbs_old) THEN END IF
   IF li_success THEN
      #依照dscom裡面所砍掉的、紀錄的log一樣在原DB內執行, 砍不掉的可能是不同的DB, 也不管他, 讓排程工具處理
      PREPARE azzq080_kill_process_log2_pre FROM ls_sql_ins
      PREPARE azzq080_kill_process2_pre FROM ls_sql_del
      FOR li_idx = 1 TO lr_gzwn.getLength()
          IF lr_gzwn[li_idx].gzwndocno IS NULL THEN
             CONTINUE FOR
          END IF
          EXECUTE azzq080_kill_process2_pre USING lr_gzwn[li_idx].gzwn001
          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
          ELSE
             EXECUTE azzq080_kill_process_log2_pre
               USING lr_gzwn[li_idx].gzwndocno, lr_gzwn[li_idx].gzwncrtid, lr_gzwn[li_idx].gzwncrtdt,
                     lr_gzwn[li_idx].gzwn001, lr_gzwn[li_idx].gzwn002, lr_gzwn[li_idx].gzwn003, lr_gzwn[li_idx].gzwn004,
                     lr_gzwn[li_idx].gzwn005, lr_gzwn[li_idx].gzwn006, lr_gzwn[li_idx].gzwn007, lr_gzwn[li_idx].gzwn008,
                     lr_gzwn[li_idx].gzwn009, lr_gzwn[li_idx].gzwn010, lr_gzwn[li_idx].gzwn011, lr_gzwn[li_idx].gzwn012,
                     lr_gzwn[li_idx].gzwn013, lr_gzwn[li_idx].gzwn014, lr_gzwn[li_idx].gzwn015, lr_gzwn[li_idx].gzwn099
          END IF
      END FOR
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code   = "lib-00209"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   CALL azzq080_b_fill()
END FUNCTION

 
{</section>}
 
