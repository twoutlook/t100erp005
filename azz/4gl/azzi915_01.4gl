#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi915_01.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000004
#+ 
#+ Filename...: azzi915_01
#+ Description: 其他使用者分享的查詢方案
#+ Creator....: 00413(2014-12-29 09:21:02)
#+ Modifier...: 00413(2014-12-29 10:32:37) -SD/PR- 00413
 
{</section>}
 
{<section id="azzi915_01.global" >}
#應用 t02 樣板自動產生(Version:5)

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzxm_d RECORD
       gzxm003 LIKE gzxm_t.gzxm003, 
   gzxm003_desc LIKE type_t.chr500, 
   gzxm001 LIKE gzxm_t.gzxm001, 
   gzxml005 LIKE gzxml_t.gzxml005, 
   gzxm002 LIKE gzxm_t.gzxm002, 
   gzxm007 LIKE gzxm_t.gzxm007
       END RECORD
PRIVATE TYPE type_g_gzxm2_d RECORD
       gzxn004 LIKE gzxn_t.gzxn004, 
   gzxn005 LIKE gzxn_t.gzxn005, 
   gzxn005_desc LIKE type_t.chr500, 
   gzxn009 LIKE gzxn_t.gzxn009, 
   gzxn007 LIKE gzxn_t.gzxn007
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      gzxml001 LIKE gzxml_t.gzxml001,
      gzxml002 LIKE gzxml_t.gzxml002,
      gzxml003 LIKE gzxml_t.gzxml003,
      gzxml004 LIKE gzxml_t.gzxml004,
      gzxml005 LIKE gzxml_t.gzxml005
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gzxm_d
DEFINE g_master_t                   type_g_gzxm_d
DEFINE g_gzxm_d          DYNAMIC ARRAY OF type_g_gzxm_d
DEFINE g_gzxm_d_t        type_g_gzxm_d
DEFINE g_gzxm_d_o        type_g_gzxm_d
DEFINE g_gzxm2_d   DYNAMIC ARRAY OF type_g_gzxm2_d
DEFINE g_gzxm2_d_t type_g_gzxm2_d
DEFINE g_gzxm2_d_o type_g_gzxm2_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE g_ac_last            LIKE type_t.num5              
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num5              #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num5              #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num5              #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num5              #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_gzxm002            LIKE gzxm_t.gzxm002
DEFINE g_gzxm001_return     LIKE gzxm_t.gzxm001
DEFINE g_gzxm003_return     LIKE gzxm_t.gzxm003
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi915_01.main" >}
#應用 a27 樣板自動產生(Version:3)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION azzi915_01(pc_gzxm002)
   #add-point:main段變數傳入
   DEFINE pc_gzxm002   LIKE gzxm_t.gzxm002
   #end add-point
   
   #add-point:main段define

   #end add-point   
   #add-point:main段define

   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   INITIALIZE g_gzxm001_return, g_gzxm003_return TO NULL
   IF cl_null(pc_gzxm002) THEN
      RETURN g_gzxm001_return, g_gzxm003_return
   END IF
   LET g_gzxm002 = pc_gzxm002
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
 
   #add-point:SQL_define

   #end add-point
 
   #add-point:SQL_define

   #end add-point
   
   #add-point:main段define_sql

   #end add-point 
 
   #add-point:main段define_sql

   #end add-point 
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi915_01 WITH FORM cl_ap_formpath("azz","azzi915_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL azzi915_01_init()   
 
   #進入選單 Menu (="N")
   CALL azzi915_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_azzi915_01
 
   #add-point:離開前
   RETURN g_gzxm001_return, g_gzxm003_return
   #end add-point
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi915_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzi915_01_init()
   #add-point:init段define

   #end add-point   
   #add-point:init段define

   #end add-point   
 
   #add-point:畫面資料初始化

   #end add-point
   
   CALL azzi915_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzi915_01_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define

   #end add-point 
   #add-point:ui_dialog段define

   #end add-point 
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      #add-point:ui_dialog段before while

      #end add-point
   
      CALL azzi915_01_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzxm_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_master.* = g_gzxm_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL azzi915_01_fetch()
               CALL azzi915_01_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:2)
   CALL azzi915_01_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                                 #應用 a43 樣板自動產生(Version:2)
               ON ACTION prog_azzi800
                  LET g_action_choice="prog_azzi800"
                  IF cl_auth_chk_act("prog_azzi800") THEN
                     
                     #add-point:ON ACTION prog_azzi800
 
                     #END add-point
                     
                  END IF
 
 
               #應用 a43 樣板自動產生(Version:2)
               ON ACTION prog_azzi915
                  LET g_action_choice="prog_azzi915"
                  IF cl_auth_chk_act("prog_azzi915") THEN
                     
                     #add-point:ON ACTION prog_azzi915
 
                     #END add-point
                     
                  END IF
 
 
               #應用 a43 樣板自動產生(Version:2)
               ON ACTION prog_azzi900
                  LET g_action_choice="prog_azzi900"
                  IF cl_auth_chk_act("prog_azzi900") THEN
                     
                     #add-point:ON ACTION prog_azzi900
 
                     #END add-point
                     
                  END IF
 
 
 
               END MENU
 
 
               #add-point:ON ACTION detail_qrystr

               #END add-point
 
 
 
               
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_gzxm2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 2
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               CALL azzi915_01_idx_chk('d')
               LET g_master.* = g_gzxm_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_gzxm_d.getLength() THEN
                  LET g_detail_idx = g_gzxm_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            NEXT FIELD CURRENT
         
         AFTER DIALOG
            #add-point:ui_dialog段after dialog

            #end add-point
         
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi915_01_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
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
            CALL azzi915_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi915_01_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi915_01_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
         ON ACTION modify_detail
            LET g_gzxm001_return = g_gzxm_d[g_detail_idx].gzxm001
            LET g_gzxm003_return = g_gzxm_d[g_detail_idx].gzxm003
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            LET g_gzxm001_return = g_gzxm_d[g_detail_idx].gzxm001
            LET g_gzxm003_return = g_gzxm_d[g_detail_idx].gzxm003
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION cancel
            INITIALIZE g_gzxm001_return, g_gzxm003_return TO NULL
            LET g_action_choice="exit"
            EXIT DIALOG
      
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="azzi915_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi915_01_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   #add-point:query段define
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzxm_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON gzxm003,gzxm001,gzxml005,gzxm002,gzxm007
           FROM s_detail1[1].gzxm003,s_detail1[1].gzxm001,s_detail1[1].gzxml005,s_detail1[1].gzxm002, 
               s_detail1[1].gzxm007
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.gzxm003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm003
            #add-point:ON ACTION controlp INFIELD gzxm003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzxa003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxm003  #顯示到畫面上
            NEXT FIELD gzxm003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm003
            #add-point:BEFORE FIELD gzxm003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm003
            
            #add-point:AFTER FIELD gzxm003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzxm001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm001
            #add-point:ON ACTION controlp INFIELD gzxm001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzxm001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxm001  #顯示到畫面上
            NEXT FIELD gzxm001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm001
            #add-point:BEFORE FIELD gzxm001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm001
            
            #add-point:AFTER FIELD gzxm001
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxml005
            #add-point:BEFORE FIELD gzxml005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxml005
            
            #add-point:AFTER FIELD gzxml005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzxml005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxml005
            #add-point:ON ACTION controlp INFIELD gzxml005
            
            #END add-point
 
         #Ctrlp:construct.c.page1.gzxm002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm002
            #add-point:ON ACTION controlp INFIELD gzxm002
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzxm002  #顯示到畫面上
            NEXT FIELD gzxm002                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm002
            #add-point:BEFORE FIELD gzxm002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm002
            
            #add-point:AFTER FIELD gzxm002
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm007
            #add-point:BEFORE FIELD gzxm007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm007
            
            #add-point:AFTER FIELD gzxm007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzxm007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm007
            #add-point:ON ACTION controlp INFIELD gzxm007
            
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON gzxn004,gzxn005,gzxn009,gzxn007
           FROM s_detail2[1].gzxn004,s_detail2[1].gzxn005,s_detail2[1].gzxn009,s_detail2[1].gzxn007
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn004
            #add-point:BEFORE FIELD gzxn004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn004
            
            #add-point:AFTER FIELD gzxn004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzxn004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn004
            #add-point:ON ACTION controlp INFIELD gzxn004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn005
            #add-point:BEFORE FIELD gzxn005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn005
            
            #add-point:AFTER FIELD gzxn005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzxn005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn005
            #add-point:ON ACTION controlp INFIELD gzxn005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn009
            #add-point:BEFORE FIELD gzxn009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn009
            
            #add-point:AFTER FIELD gzxn009
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzxn009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn009
            #add-point:ON ACTION controlp INFIELD gzxn009
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn007
            #add-point:BEFORE FIELD gzxn007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn007
            
            #add-point:AFTER FIELD gzxn007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzxn007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn007
            #add-point:ON ACTION controlp INFIELD gzxn007
            
            #END add-point
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct
      
      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         
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
      LET g_wc = ls_wc
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct
   
   #end add-point
   
   LET g_error_show = 1
   CALL azzi915_01_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL azzi915_01_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_gzxm_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_gzxm2_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.insert" >}
#+ 資料修改
PRIVATE FUNCTION azzi915_01_insert()
   #add-point:insert段define
   
   #end add-point 
   #add-point:insert段define
   
   #end add-point 
   
   #add-point:insert段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL g_gzxm_d.clear() 
   CALL g_gzxm2_d.clear() 
 
   CALL azzi915_01_input('a')
   
   CALL azzi915_01_b_fill(g_wc)
   
   #add-point:insert段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.modify" >}
#+ 資料新增
PRIVATE FUNCTION azzi915_01_modify()
   DEFINE l_ac_t LIKE type_t.num5
   #add-point:modify段define
   
   #end add-point 
   #add-point:modify段define
   
   #end add-point 
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL azzi915_01_input('u')
    
   IF INT_FLAG AND g_gzxm_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL azzi915_01_fetch()
   END IF
   
   #add-point:modify段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi915_01_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define
   
   #end add-point 
   #add-point:delete段define
   
   #end add-point 
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_gzxm_d_t.* = g_gzxm_d[li_ac].*
   LET g_gzxm_d_o.* = g_gzxm_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM gzxm_t 
         WHERE gzxm001 = g_gzxm_d_t.gzxm001
           AND gzxm002 = g_gzxm_d_t.gzxm002
           AND gzxm003 = g_gzxm_d_t.gzxm003
 
           
   #add-point:delete段刪除中
   
   #end add-point 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzxm_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段刪除後
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前
   
   #end add-point 
   DELETE FROM gzxn_t 
         WHERE gzxn001 = g_gzxm_d_t.gzxm001
           AND gzxn002 = g_gzxm_d_t.gzxm002
           AND gzxn003 = g_gzxm_d_t.gzxm003
 
   #add-point:delete段刪除中
   
   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzxn_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi915_01_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   
   #end add-point 
   #add-point:input段define
   
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT gzxm003,gzxm001,gzxm002,gzxm007 FROM gzxm_t WHERE gzxment=? AND gzxm001=?  
       AND gzxm002=? AND gzxm003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE azzi915_01_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT gzxn004,gzxn005,gzxn009,gzxn007 FROM gzxn_t WHERE gzxnent=? AND gzxn001=?  
       AND gzxn002=? AND gzxn003=? AND gzxn004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE azzi915_01_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   
   #add-point:input段修改前
   
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzxm_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               
               #END add-point
            END IF
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzxm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL azzi915_01_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_gzxm_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_gzxm_d[l_ac].*
            LET g_master.* = g_gzxm_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzxm_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzxm_d[l_ac].gzxm001 IS NOT NULL
               AND g_gzxm_d[l_ac].gzxm002 IS NOT NULL
               AND g_gzxm_d[l_ac].gzxm003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzxm_d_t.* = g_gzxm_d[l_ac].*  #BACKUP
               LET g_gzxm_d_o.* = g_gzxm_d[l_ac].*  #BACKUP
               IF NOT azzi915_01_lock_b("gzxm_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi915_01_bcl INTO g_gzxm_d[l_ac].gzxm003,g_gzxm_d[l_ac].gzxm001,g_gzxm_d[l_ac].gzxm002, 
                      g_gzxm_d[l_ac].gzxm007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzxm_d_t.gzxm001 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL azzi915_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi915_01_set_entry_b(l_cmd)
            CALL azzi915_01_set_no_entry_b(l_cmd)
            #add-point:input段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            LET g_detail_multi_table_t.gzxml001 = g_gzxm_d[l_ac].gzxm001
LET g_detail_multi_table_t.gzxml002 = g_gzxm_d[l_ac].gzxm002
LET g_detail_multi_table_t.gzxml003 = g_gzxm_d[l_ac].gzxm003
LET g_detail_multi_table_t.gzxml004 = g_dlang
LET g_detail_multi_table_t.gzxml005 = g_gzxm_d[l_ac].gzxml005
 
            #其他table進行lock
                        INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'gzxml001'
            LET l_var_keys[01] = g_gzxm_d[l_ac].gzxm001
            LET l_field_keys[02] = 'gzxml002'
            LET l_var_keys[02] = g_gzxm_d[l_ac].gzxm002
            LET l_field_keys[03] = 'gzxml003'
            LET l_var_keys[03] = g_gzxm_d[l_ac].gzxm003
            LET l_field_keys[04] = 'gzxml004'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'gzxml_t') THEN
               RETURN 
            END IF 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL azzi915_01_fetch()
            CALL azzi915_01_idx_chk('m')
 
         BEFORE INSERT
            LET g_detail_multi_table_t.gzxml001 = g_gzxm_d[l_ac].gzxm001
LET g_detail_multi_table_t.gzxml002 = g_gzxm_d[l_ac].gzxm002
LET g_detail_multi_table_t.gzxml003 = g_gzxm_d[l_ac].gzxm003
LET g_detail_multi_table_t.gzxml004 = g_dlang
LET g_detail_multi_table_t.gzxml005 = g_gzxm_d[l_ac].gzxml005
 
            #判斷能否在此頁面進行資料新增
            
            #清空下層單身
                        CALL g_gzxm2_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzxm_d[l_ac].* TO NULL 
            INITIALIZE g_gzxm_d_t.* TO NULL 
            INITIALIZE g_gzxm_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_gzxm_d_t.* = g_gzxm_d[l_ac].*     #新輸入資料
            LET g_gzxm_d_o.* = g_gzxm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi915_01_set_entry_b("a")
            CALL azzi915_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzxm_d[li_reproduce_target].* = g_gzxm_d[li_reproduce].*
 
               LET g_gzxm_d[g_gzxm_d.getLength()].gzxm001 = NULL
               LET g_gzxm_d[g_gzxm_d.getLength()].gzxm002 = NULL
               LET g_gzxm_d[g_gzxm_d.getLength()].gzxm003 = NULL
 
            END IF
            #add-point:input段before insert
            
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
            SELECT COUNT(*) INTO l_count FROM gzxm_t 
             WHERE gzxment = g_enterprise AND gzxm001 = g_gzxm_d[l_ac].gzxm001 
                                       AND gzxm002 = g_gzxm_d[l_ac].gzxm002 
                                       AND gzxm003 = g_gzxm_d[l_ac].gzxm003 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys[3] = g_gzxm_d[g_detail_idx].gzxm003
               CALL azzi915_01_insert_b('gzxm_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_gzxm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzxm_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi915_01_b_fill(g_wc)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzxm_d[l_ac].gzxm001 = g_detail_multi_table_t.gzxml001 AND
         g_gzxm_d[l_ac].gzxm002 = g_detail_multi_table_t.gzxml002 AND
         g_gzxm_d[l_ac].gzxm003 = g_detail_multi_table_t.gzxml003 AND
         g_gzxm_d[l_ac].gzxml005 = g_detail_multi_table_t.gzxml005 THEN
         ELSE 
            LET l_var_keys[01] = g_gzxm_d[l_ac].gzxm001
            LET l_field_keys[01] = 'gzxml001'
            LET l_var_keys[02] = g_gzxm_d[l_ac].gzxm002
            LET l_field_keys[02] = 'gzxml002'
            LET l_var_keys[03] = g_gzxm_d[l_ac].gzxm003
            LET l_field_keys[03] = 'gzxml003'
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'gzxml004'
            LET l_vars[01] = g_gzxm_d[l_ac].gzxml005
            LET l_fields[01] = 'gzxml005'
            LET l_vars[02] = g_enterprise 
            LET l_fields[02] = 'gzxmlent'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gzxml001
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gzxml002
            LET l_var_keys_bak[03] = g_detail_multi_table_t.gzxml003
            LET l_var_keys_bak[04] = g_detail_multi_table_t.gzxml004
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzxml_t')
         END IF 
 
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_gzxm_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               
               #end add-point
               
               DELETE FROM gzxm_t
                WHERE gzxment = g_enterprise AND 
                      gzxm001 = g_gzxm_d_t.gzxm001
                      AND gzxm002 = g_gzxm_d_t.gzxm002
                      AND gzxm003 = g_gzxm_d_t.gzxm003
 
                      
               #add-point:單身刪除中
               
               #end add-point
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzxm_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'gzxml001'
                  LET l_field_keys[02] = 'gzxml002'
                  LET l_field_keys[03] = 'gzxml003'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.gzxml001
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.gzxml002
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.gzxml003
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzxml_t')
 
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE azzi915_01_bcl
               LET l_count = g_gzxm_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys[3] = g_gzxm_d[g_detail_idx].gzxm003
    
               #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL azzi915_01_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2
               
               #end add-point
                              CALL azzi915_01_delete_b('gzxm_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzxm_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm003
            
            #add-point:AFTER FIELD gzxm003
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzxm_d[g_detail_idx].gzxm001 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm002 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxm_d[g_detail_idx].gzxm001 != g_gzxm_d_t.gzxm001 OR g_gzxm_d[g_detail_idx].gzxm002 != g_gzxm_d_t.gzxm002 OR g_gzxm_d[g_detail_idx].gzxm003 != g_gzxm_d_t.gzxm003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzxm_t WHERE "||"gzxment = '" ||g_enterprise|| "' AND "||"gzxm001 = '"||g_gzxm_d[g_detail_idx].gzxm001 ||"' AND "|| "gzxm002 = '"||g_gzxm_d[g_detail_idx].gzxm002 ||"' AND "|| "gzxm003 = '"||g_gzxm_d[g_detail_idx].gzxm003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzxm_d[l_ac].gzxm003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzxm_d[l_ac].gzxm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzxm_d[l_ac].gzxm003_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm003
            #add-point:BEFORE FIELD gzxm003
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxm003
            #add-point:ON CHANGE gzxm003
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm001
            #add-point:BEFORE FIELD gzxm001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm001
            
            #add-point:AFTER FIELD gzxm001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzxm_d[g_detail_idx].gzxm001 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm002 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxm_d[g_detail_idx].gzxm001 != g_gzxm_d_t.gzxm001 OR g_gzxm_d[g_detail_idx].gzxm002 != g_gzxm_d_t.gzxm002 OR g_gzxm_d[g_detail_idx].gzxm003 != g_gzxm_d_t.gzxm003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzxm_t WHERE "||"gzxment = '" ||g_enterprise|| "' AND "||"gzxm001 = '"||g_gzxm_d[g_detail_idx].gzxm001 ||"' AND "|| "gzxm002 = '"||g_gzxm_d[g_detail_idx].gzxm002 ||"' AND "|| "gzxm003 = '"||g_gzxm_d[g_detail_idx].gzxm003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxm001
            #add-point:ON CHANGE gzxm001
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxml005
            #add-point:BEFORE FIELD gzxml005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxml005
            
            #add-point:AFTER FIELD gzxml005
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxml005
            #add-point:ON CHANGE gzxml005
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm002
            #add-point:BEFORE FIELD gzxm002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm002
            
            #add-point:AFTER FIELD gzxm002
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzxm_d[g_detail_idx].gzxm001 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm002 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxm_d[g_detail_idx].gzxm001 != g_gzxm_d_t.gzxm001 OR g_gzxm_d[g_detail_idx].gzxm002 != g_gzxm_d_t.gzxm002 OR g_gzxm_d[g_detail_idx].gzxm003 != g_gzxm_d_t.gzxm003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzxm_t WHERE "||"gzxment = '" ||g_enterprise|| "' AND "||"gzxm001 = '"||g_gzxm_d[g_detail_idx].gzxm001 ||"' AND "|| "gzxm002 = '"||g_gzxm_d[g_detail_idx].gzxm002 ||"' AND "|| "gzxm003 = '"||g_gzxm_d[g_detail_idx].gzxm003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxm002
            #add-point:ON CHANGE gzxm002
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxm007
            #add-point:BEFORE FIELD gzxm007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxm007
            
            #add-point:AFTER FIELD gzxm007
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxm007
            #add-point:ON CHANGE gzxm007
            
            #END add-point 
 
 
                  #Ctrlp:input.c.page1.gzxm003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm003
            #add-point:ON ACTION controlp INFIELD gzxm003
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzxm_d[l_ac].gzxm003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_gzxa003()                                #呼叫開窗

            LET g_gzxm_d[l_ac].gzxm003 = g_qryparam.return1              

            DISPLAY g_gzxm_d[l_ac].gzxm003 TO gzxm003              #

            NEXT FIELD gzxm003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.gzxm001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm001
            #add-point:ON ACTION controlp INFIELD gzxm001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzxm_d[l_ac].gzxm001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_gzxm001()                                #呼叫開窗

            LET g_gzxm_d[l_ac].gzxm001 = g_qryparam.return1              

            DISPLAY g_gzxm_d[l_ac].gzxm001 TO gzxm001              #

            NEXT FIELD gzxm001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.gzxml005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxml005
            #add-point:ON ACTION controlp INFIELD gzxml005
            
            #END add-point
 
         #Ctrlp:input.c.page1.gzxm002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm002
            #add-point:ON ACTION controlp INFIELD gzxm002
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzxm_d[l_ac].gzxm002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_gzzz001_1()                                #呼叫開窗

            LET g_gzxm_d[l_ac].gzxm002 = g_qryparam.return1              

            DISPLAY g_gzxm_d[l_ac].gzxm002 TO gzxm002              #

            NEXT FIELD gzxm002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.gzxm007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxm007
            #add-point:ON ACTION controlp INFIELD gzxm007
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_gzxm_d[l_ac].* = g_gzxm_d_t.*
               CLOSE azzi915_01_bcl
               CALL s_transaction_end('N','0')
               CANCEL DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzxm_d[l_ac].gzxm001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_gzxm_d[l_ac].* = g_gzxm_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
               
               #add-point:單身修改前
               
               #end add-point
               
               UPDATE gzxm_t SET (gzxm003,gzxm001,gzxm002,gzxm007) = (g_gzxm_d[l_ac].gzxm003,g_gzxm_d[l_ac].gzxm001, 
                   g_gzxm_d[l_ac].gzxm002,g_gzxm_d[l_ac].gzxm007)
                WHERE gzxment = g_enterprise AND
                  gzxm001 = g_gzxm_d_t.gzxm001 #項次   
                  AND gzxm002 = g_gzxm_d_t.gzxm002  
                  AND gzxm003 = g_gzxm_d_t.gzxm003  
 
                  
               #add-point:單身修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzxm_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_gzxm_d[l_ac].* = g_gzxm_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzxm_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_gzxm_d[l_ac].* = g_gzxm_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys_bak[1] = g_gzxm_d_t.gzxm001
               LET gs_keys[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys_bak[2] = g_gzxm_d_t.gzxm002
               LET gs_keys[3] = g_gzxm_d[g_detail_idx].gzxm003
               LET gs_keys_bak[3] = g_gzxm_d_t.gzxm003
               CALL azzi915_01_update_b('gzxm_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzxm_d[l_ac].gzxm001 = g_detail_multi_table_t.gzxml001 AND
         g_gzxm_d[l_ac].gzxm002 = g_detail_multi_table_t.gzxml002 AND
         g_gzxm_d[l_ac].gzxm003 = g_detail_multi_table_t.gzxml003 AND
         g_gzxm_d[l_ac].gzxml005 = g_detail_multi_table_t.gzxml005 THEN
         ELSE 
            LET l_var_keys[01] = g_gzxm_d[l_ac].gzxm001
            LET l_field_keys[01] = 'gzxml001'
            LET l_var_keys[02] = g_gzxm_d[l_ac].gzxm002
            LET l_field_keys[02] = 'gzxml002'
            LET l_var_keys[03] = g_gzxm_d[l_ac].gzxm003
            LET l_field_keys[03] = 'gzxml003'
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'gzxml004'
            LET l_vars[01] = g_gzxm_d[l_ac].gzxml005
            LET l_fields[01] = 'gzxml005'
            LET l_vars[02] = g_enterprise 
            LET l_fields[02] = 'gzxmlent'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gzxml001
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gzxml002
            LET l_var_keys_bak[03] = g_detail_multi_table_t.gzxml003
            LET l_var_keys_bak[04] = g_detail_multi_table_t.gzxml004
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzxml_t')
         END IF 
 
                     
                     LET g_log1 = util.JSON.stringify(g_gzxm_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzxm_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_gzxm_d[l_ac].*
               CALL azzi915_01_key_update_b()
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL azzi915_01_unlock_b("gzxm_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            CALL cl_multitable_unlock()
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_gzxm_d[l_ac].* = g_gzxm_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_gzxm_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzxm_d.getLength()+1
        
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_gzxm2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               
               #END add-point
            END IF
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzxm2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_gzxm2_d.getLength()
            LET g_current_page = 2
            #add-point:資料輸入前
            
            #end add-point
 
         BEFORE INSERT
            IF g_gzxm_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'std-00013' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD gzxm001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzxm2_d[l_ac].* TO NULL 
            INITIALIZE g_gzxm2_d_t.* TO NULL 
            INITIALIZE g_gzxm2_d_o.* TO NULL 
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_gzxm2_d_t.* = g_gzxm2_d[l_ac].*     #新輸入資料
            LET g_gzxm2_d_o.* = g_gzxm2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi915_01_set_entry_b("a")
            CALL azzi915_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzxm2_d[li_reproduce_target].* = g_gzxm2_d[li_reproduce].*
 
               LET g_gzxm2_d[li_reproduce_target].gzxn004 = NULL
            END IF
            #add-point:input段before insert
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzxm2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzxm2_d[l_ac].gzxn004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzxm2_d_t.* = g_gzxm2_d[l_ac].*  #BACKUP
               LET g_gzxm2_d_o.* = g_gzxm2_d[l_ac].*  #BACKUP
               IF NOT azzi915_01_lock_b("gzxn_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi915_01_bcl2 INTO g_gzxm2_d[l_ac].gzxn004,g_gzxm2_d[l_ac].gzxn005,g_gzxm2_d[l_ac].gzxn009, 
                      g_gzxm2_d[l_ac].gzxn007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL azzi915_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi915_01_set_entry_b(l_cmd)
            CALL azzi915_01_set_no_entry_b(l_cmd)
            #add-point:input段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL azzi915_01_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前
               
               #end add-point  
               
               DELETE FROM gzxn_t
                WHERE gzxnent = g_enterprise AND
                   gzxn001 = g_master.gzxm001
                   AND gzxn002 = g_master.gzxm002
                   AND gzxn003 = g_master.gzxm003
                   AND gzxn004 = g_gzxm2_d_t.gzxn004
                   
               #add-point:單身2刪除中
               
               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzxm_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE azzi915_01_bcl
               LET l_count = g_gzxm_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys[3] = g_gzxm_d[g_detail_idx].gzxm003
               LET gs_keys[4] = g_gzxm2_d[g_detail_idx2].gzxn004
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               
               #end add-point
                              CALL azzi915_01_delete_b('gzxn_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzxm2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
            SELECT COUNT(*) INTO l_count FROM gzxn_t 
             WHERE gzxnent = g_enterprise AND
                   gzxn001 = g_master.gzxm001
                   AND gzxn002 = g_master.gzxm002
                   AND gzxn003 = g_master.gzxm003
                   AND gzxn004 = g_gzxm2_d[g_detail_idx2].gzxn004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys[3] = g_gzxm_d[g_detail_idx].gzxm003
               LET gs_keys[4] = g_gzxm2_d[g_detail_idx2].gzxn004
               CALL azzi915_01_insert_b('gzxn_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_gzxm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzxn_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi915_01_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_gzxm2_d[l_ac].* = g_gzxm2_d_t.*
               CLOSE azzi915_01_bcl2
               CALL s_transaction_end('N','0')
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzxm2_d[l_ac].* = g_gzxm2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前
               
               #end add-point
               
               UPDATE gzxn_t SET (gzxn004,gzxn005,gzxn009,gzxn007) = (g_gzxm2_d[l_ac].gzxn004,g_gzxm2_d[l_ac].gzxn005, 
                   g_gzxm2_d[l_ac].gzxn009,g_gzxm2_d[l_ac].gzxn007) #自訂欄位頁簽
                WHERE gzxnent = g_enterprise AND
                   gzxn001 = g_master.gzxm001
                   AND gzxn002 = g_master.gzxm002
                   AND gzxn003 = g_master.gzxm003
                   AND gzxn004 = g_gzxm2_d_t.gzxn004
                   
               #add-point:單身修改中
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzxn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzxm2_d[l_ac].* = g_gzxm2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzxn_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_gzxm2_d[l_ac].* = g_gzxm2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys_bak[1] = g_gzxm_d[g_detail_idx].gzxm001
               LET gs_keys[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys_bak[2] = g_gzxm_d[g_detail_idx].gzxm002
               LET gs_keys[3] = g_gzxm_d[g_detail_idx].gzxm003
               LET gs_keys_bak[3] = g_gzxm_d[g_detail_idx].gzxm003
               LET gs_keys[4] = g_gzxm2_d[g_detail_idx2].gzxn004
               LET gs_keys_bak[4] = g_gzxm2_d_t.gzxn004
               CALL azzi915_01_update_b('gzxn_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_gzxm2_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzxm2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn004
            #add-point:BEFORE FIELD gzxn004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn004
            
            #add-point:AFTER FIELD gzxn004
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzxm_d[g_detail_idx].gzxm001 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm002 IS NOT NULL AND g_gzxm_d[g_detail_idx].gzxm003 IS NOT NULL AND g_gzxm2_d[g_detail_idx2].gzxn004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxm_d[g_detail_idx].gzxm001 != g_gzxm_d[g_detail_idx].gzxm001 OR g_gzxm_d[g_detail_idx].gzxm002 != g_gzxm_d[g_detail_idx].gzxm002 OR g_gzxm_d[g_detail_idx].gzxm003 != g_gzxm_d[g_detail_idx].gzxm003 OR g_gzxm2_d[g_detail_idx2].gzxn004 != g_gzxm2_d_t.gzxn004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzxn_t WHERE "||"gzxnent = '" ||g_enterprise|| "' AND "||"gzxn001 = '"||g_gzxm_d[g_detail_idx].gzxm001 ||"' AND "|| "gzxn002 = '"||g_gzxm_d[g_detail_idx].gzxm002 ||"' AND "|| "gzxn003 = '"||g_gzxm_d[g_detail_idx].gzxm003 ||"' AND "|| "gzxn004 = '"||g_gzxm2_d[g_detail_idx2].gzxn004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxn004
            #add-point:ON CHANGE gzxn004
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn005
            
            #add-point:AFTER FIELD gzxn005
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzxm2_d[l_ac].gzxn005
            CALL ap_ref_array2(g_ref_fields,"SELECT dzebl003 FROM dzebl_t WHERE dzebl001=? AND dzebl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzxm2_d[l_ac].gzxn005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzxm2_d[l_ac].gzxn005_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn005
            #add-point:BEFORE FIELD gzxn005
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxn005
            #add-point:ON CHANGE gzxn005
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn009
            #add-point:BEFORE FIELD gzxn009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn009
            
            #add-point:AFTER FIELD gzxn009
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxn009
            #add-point:ON CHANGE gzxn009
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzxn007
            #add-point:BEFORE FIELD gzxn007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzxn007
            
            #add-point:AFTER FIELD gzxn007
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzxn007
            #add-point:ON CHANGE gzxn007
            
            #END add-point 
 
 
                  #Ctrlp:input.c.page2.gzxn004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn004
            #add-point:ON ACTION controlp INFIELD gzxn004
            
            #END add-point
 
         #Ctrlp:input.c.page2.gzxn005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn005
            #add-point:ON ACTION controlp INFIELD gzxn005
            
            #END add-point
 
         #Ctrlp:input.c.page2.gzxn009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn009
            #add-point:ON ACTION controlp INFIELD gzxn009
            
            #END add-point
 
         #Ctrlp:input.c.page2.gzxn007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzxn007
            #add-point:ON ACTION controlp INFIELD gzxn007
            
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
                  LET g_gzxm2_d[l_ac].* = g_gzxm2_d_t.*
               END IF
               CLOSE azzi915_01_bcl2
               CALL s_transaction_end('N','0')
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL azzi915_01_unlock_b("gzxn_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_gzxm2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzxm2_d.getLength()+1
 
      END INPUT
 
      
 
    
 
      
      #add-point:input段input_array"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_gzxm_d.getLength() THEN
               LET g_detail_idx = g_gzxm_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_gzxm_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzxm003
               WHEN "s_detail2"
                  NEXT FIELD gzxn004
 
            END CASE
         ELSE
            NEXT FIELD gzxm003
         END IF
    
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_gzxm_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_gzxm2_d)
            LET g_export_id[2]   = "s_detail2"
 
            #add-point:ON ACTION exporttoexcel
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
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
 
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx2)
 
   
   #add-point:input段修改後
   
   #end add-point
 
   CLOSE azzi915_01_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi915_01_b_fill(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num5
   #add-point:b_fill段define

   #end add-point
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE t0.gzxm003,t0.gzxm001,t0.gzxm002,t0.gzxm007 ,t1.ooag011 FROM gzxm_t t0", 
 
 
               " LEFT JOIN gzxn_t ON gzxnent = gzxment AND gzxm001 = gzxn001 AND gzxm002 = gzxn002 AND gzxm003 = gzxn003",
 
 
               " LEFT JOIN gzxml_t ON gzxmlent = '"||g_enterprise||"' AND gzxm001 = gzxml001 AND gzxm002 = gzxml002 AND gzxm003 = gzxml003 AND gzxml004 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.gzxm003  ",
 
               " WHERE t0.gzxment= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc
   LET g_sql = g_sql, " AND gzxm010 = 'Y' AND gzxmstus = 'Y'"
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gzxm_t"),
                      " ORDER BY t0.gzxm001,t0.gzxm002,t0.gzxm003"
  
   #add-point:b_fill段sql_after

   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzxm_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE azzi915_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi915_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_gzxm_d.clear()
   CALL g_gzxm2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gzxm_d[l_ac].gzxm003,g_gzxm_d[l_ac].gzxm001,g_gzxm_d[l_ac].gzxm002,g_gzxm_d[l_ac].gzxm007, 
       g_gzxm_d[l_ac].gzxm003_desc
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
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_gzxm_d.deleteElement(g_gzxm_d.getLength())   
   CALL g_gzxm2_d.deleteElement(g_gzxm2_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_gzxm_d.getLength() THEN
      LET g_detail_idx = g_gzxm_d.getLength()
   END IF
 
   IF g_gzxm_d.getLength() > 0 THEN
      LET g_detail_idx = 1
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_gzxm_d.getLength()
      #LET g_gzxm2_d[g_detail_idx2].gzxn004 = g_gzxm_d[g_detail_idx].gzxm001 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE azzi915_01_pb
   
   LET g_loc = 'm'
   CALL azzi915_01_detail_show() 
   
   LET l_ac = 1
   IF g_gzxm_d.getLength() > 0 THEN
      CALL azzi915_01_fetch()
   END IF
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi915_01_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   #add-point:fetch段define
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_gzxm_d.getLength() = 0 THEN
      RETURN
   END IF
   
   CALL g_gzxm2_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE t0.gzxn004,t0.gzxn005,t0.gzxn009,t0.gzxn007 ,t2.dzebl003 FROM gzxn_t t0", 
              
                  "",
                                 " LEFT JOIN dzebl_t t2 ON t2.dzebl001=t0.gzxn005 AND t2.dzebl002='"||g_dlang||"' ",
 
                  " WHERE t0.gzxnent=?  AND t0. gzxn001=?  AND t0. gzxn002=?  AND t0. gzxn003=?"
      #add-point:單身sql wc
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.gzxn004" 
                         
      #add-point:單身填充前
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE azzi915_01_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR azzi915_01_pb2
   END IF
   
   LET l_ac = g_detail_idx
   OPEN b_fill_curs2 USING g_enterprise,g_gzxm_d[l_ac].gzxm001,g_gzxm_d[l_ac].gzxm002,g_gzxm_d[l_ac].gzxm003 
 
   
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_gzxm2_d[l_ac].gzxn004,g_gzxm2_d[l_ac].gzxn005,g_gzxm2_d[l_ac].gzxn009, 
       g_gzxm2_d[l_ac].gzxn007,g_gzxm2_d[l_ac].gzxn005_desc
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
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後
   
   #end add-point
   
   CALL g_gzxm2_d.deleteElement(g_gzxm2_d.getLength())   
 
   
   DISPLAY g_gzxm2_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL azzi915_01_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzi915_01_detail_show()
   DEFINE l_ac_t LIKE type_t.num5
   #add-point:show段define
   
   #end add-point
   #add-point:show段define
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_gzxm_d.getLength()
         #add-point:show段單頭reference

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_gzxm_d[l_ac].gzxm001
   LET g_ref_fields[2] = g_gzxm_d[l_ac].gzxm002
   LET g_ref_fields[3] = g_gzxm_d[l_ac].gzxm003
   CALL ap_ref_array2(g_ref_fields," SELECT gzxml005 FROM gzxml_t WHERE gzxmlent = '"||g_enterprise||"' AND gzxml001 = ? AND gzxml002 = ? AND gzxml003 = ? AND gzxml004 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzxm_d[l_ac].gzxml005 = g_rtn_fields[1] 
   DISPLAY BY NAME g_gzxm_d[l_ac].gzxml005
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_gzxm2_d.getLength()
        #add-point:show段單身reference
        
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi915_01_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point
   #add-point:set_entry_b段define
   
   #end add-point
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="azzi915_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi915_01_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="azzi915_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi915_01_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point  
   #add-point:default_search段define

   #end add-point  
   
   #add-point:default_search段開始前
   IF NOT cl_null(g_gzxm002) THEN
      LET g_wc = " gzxm002 = '", g_gzxm002, "'"
   END IF
   #end add-point  
 
   #add-point:default_search段after sql

   #end add-point  
   
   #add-point:default_search段結束前

   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi915_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
   #add-point:delete_b段define
   
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "gzxm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM gzxm_t
       WHERE gzxment = g_enterprise AND
         gzxm001 = ps_keys_bak[1] AND gzxm002 = ps_keys_bak[2] AND gzxm003 = ps_keys_bak[3]
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
   END IF
   
 
   
   LET ls_group = "gzxn_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM gzxn_t
       WHERE gzxnent = g_enterprise AND
         gzxn001 = ps_keys_bak[1] AND gzxn002 = ps_keys_bak[2] AND gzxn003 = ps_keys_bak[3] AND gzxn004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzxn_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "gzxm_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM gzxn_t
       WHERE gzxnent = g_enterprise AND
         gzxn001 = ps_keys_bak[1] AND gzxn002 = ps_keys_bak[2] AND gzxn003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzxn_t" 
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
 
{<section id="azzi915_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi915_01_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point
   #add-point:insert_b段define
   
   #end add-point
 
   #判斷是否是同一群組的table
   LET ls_group = "gzxm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO gzxm_t
                  (gzxment,
                   gzxm001,gzxm002,gzxm003
                   ,gzxm007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_gzxm_d[g_detail_idx].gzxm007)
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzxm_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "gzxn_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO gzxn_t
                  (gzxnent,
                   gzxn001,gzxn002,gzxn003,gzxn004
                   ,gzxn005,gzxn009,gzxn007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_gzxm2_d[g_detail_idx2].gzxn005,g_gzxm2_d[g_detail_idx2].gzxn009,g_gzxm2_d[g_detail_idx2].gzxn007) 
 
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         RETURN
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi915_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
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
   #add-point:update_b段define
   
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
   LET ls_group = "gzxm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzxm_t" THEN
   
      #add-point:update_b段修改前
      
      #end add-point     
   
      UPDATE gzxm_t 
         SET (gzxm001,gzxm002,gzxm003
              ,gzxm007) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_gzxm_d[g_detail_idx].gzxm007) 
         WHERE gzxm001 = ps_keys_bak[1] AND gzxm002 = ps_keys_bak[2] AND gzxm003 = ps_keys_bak[3]
 
      #add-point:update_b段修改中
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzxm_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzxm_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            LET l_new_key[01] = ps_keys[01] 
LET l_old_key[01] = ps_keys_bak[01] 
LET l_field_key[01] = 'gzxml001'
LET l_new_key[02] = ps_keys[02] 
LET l_old_key[02] = ps_keys_bak[02] 
LET l_field_key[02] = 'gzxml002'
LET l_new_key[03] = ps_keys[03] 
LET l_old_key[03] = ps_keys_bak[03] 
LET l_field_key[03] = 'gzxml003'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'gzxml004'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'gzxml_t')
      END CASE
 
      #add-point:update_b段修改後
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "gzxn_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzxn_t" THEN
   
      #add-point:update_b段修改前
      
      #end add-point    
      
      UPDATE gzxn_t 
         SET (gzxn001,gzxn002,gzxn003,gzxn004
              ,gzxn005,gzxn009,gzxn007) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_gzxm2_d[g_detail_idx2].gzxn005,g_gzxm2_d[g_detail_idx2].gzxn009,g_gzxm2_d[g_detail_idx2].gzxn007)  
 
         WHERE gzxn001 = ps_keys_bak[1] AND gzxn002 = ps_keys_bak[2] AND gzxn003 = ps_keys_bak[3] AND gzxn004 = ps_keys_bak[4]
 
      #add-point:update_b段修改中
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzxn_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzxn_t" 
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
 
{<section id="azzi915_01.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION azzi915_01_key_update_b()
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define
   
   #end add-point
 
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.gzxm001 <> g_master_t.gzxm001 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.gzxm002 <> g_master_t.gzxm002 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.gzxm003 <> g_master_t.gzxm003 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前
   
   #end add-point
   
   UPDATE gzxn_t 
      SET (gzxn001,gzxn002,gzxn003) 
           = 
          (g_master.gzxm001,g_master.gzxm002,g_master.gzxm003) 
      WHERE 
           gzxn001 = g_master_t.gzxm001
           AND gzxn002 = g_master_t.gzxm002
           AND gzxn003 = g_master_t.gzxm003
 
           
   #add-point:update_b段修改中
   
   #end add-point
           
   CASE
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzxn_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi915_01_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL azzi915_01_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gzxm_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi915_01_bcl USING g_enterprise,
                                       g_gzxm_d[g_detail_idx].gzxm001,g_gzxm_d[g_detail_idx].gzxm002, 
                                           g_gzxm_d[g_detail_idx].gzxm003
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi915_01_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "gzxn_t,"
   #僅鎖定自身table
   LET ls_group = "gzxn_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN azzi915_01_bcl2 USING g_enterprise,
                                             g_master.gzxm001,g_master.gzxm002,g_master.gzxm003,
                                             g_gzxm2_d[g_detail_idx2].gzxn004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi915_01_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi915_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE azzi915_01_bcl
   END IF
   
 
    
   LET ls_group = "gzxn_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE azzi915_01_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION azzi915_01_idx_chk(ps_loc)
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   #add-point:idx_chk段define
   
   #end add-point  
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gzxm_d.getLength() THEN
         LET g_detail_idx = g_gzxm_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzxm_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_gzxm_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_gzxm2_d.getLength() THEN
         LET g_detail_idx2 = g_gzxm2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_gzxm2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_gzxm2_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_gzxm2_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_gzxm2_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi915_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:4)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi915_01_set_pk_array()
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
   LET g_pk_array[1].values = g_gzxm_d[g_detail_idx].gzxm001
   LET g_pk_array[1].column = 'gzxm001'
   LET g_pk_array[2].values = g_gzxm_d[g_detail_idx].gzxm002
   LET g_pk_array[2].column = 'gzxm002'
   LET g_pk_array[3].values = g_gzxm_d[g_detail_idx].gzxm003
   LET g_pk_array[3].column = 'gzxm003'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi915_01.state_change" >}
    
 
{</section>}
 
{<section id="azzi915_01.func_signature" >}
   
 
{</section>}
 
{<section id="azzi915_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi915_01.other_function" readonly="Y" >}

 
{</section>}
 
