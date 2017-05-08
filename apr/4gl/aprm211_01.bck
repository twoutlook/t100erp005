#該程式已解開Section, 不再透過樣板產出!
{<section id="aprm211_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000030
#+ 
#+ Filename...: aprm211_01
#+ Description: ...
#+ Creator....: 02482(2014/03/28)
#+ Modifier...: 02482(2014/04/01)
#+ Buildtype..: 應用 t02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aprm211_01.global" >}
#160318-00025#48  2016/04/29  By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160905-00007#12  2016/09/06  by 08742    调整系统中无ENT的SQL条件增加ent
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_prdm_d RECORD
       prdmstus LIKE prdm_t.prdmstus,
       prdm004 LIKE prdm_t.prdm004, 
   prdm002 LIKE prdm_t.prdm002, 
   prdm003 LIKE prdm_t.prdm003, 
   prdm005 LIKE prdm_t.prdm005,
   prdm001 LIKE prdm_t.prdm001, 
   prdmsite LIKE prdm_t.prdmsite, 
   prdmunit LIKE prdm_t.prdmunit
       END RECORD
PRIVATE TYPE type_g_prdm2_d RECORD
       prdnstus LIKE prdn_t.prdnstus,
       prdn002 LIKE prdn_t.prdn002, 
   prdn003 LIKE prdn_t.prdn003, 
   prdn004 LIKE prdn_t.prdn004, 
   prdn004_desc LIKE type_t.chr500, 
   prdnsite LIKE prdn_t.prdnsite, 
   prdnunit LIKE prdn_t.prdnunit
       END RECORD
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_prdm_d
DEFINE g_master_t                   type_g_prdm_d
DEFINE g_prdm_d          DYNAMIC ARRAY OF type_g_prdm_d
DEFINE g_prdm_d_t        type_g_prdm_d
DEFINE g_prdm2_d   DYNAMIC ARRAY OF type_g_prdm2_d
DEFINE g_prdm2_d_t type_g_prdm2_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
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
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)

DEFINE g_prdm001       LIKE prdm_t.prdm001
DEFINE g_type          LIKE type_t.chr1
DEFINE g_type1         LIKE type_t.chr1
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="aprm211_01.main" >}
#+ 此段落由子樣板a27產生
#+ 資料輸入
PUBLIC FUNCTION aprm211_01(--)
   #add-point:main段變數傳入
   p_prdm001,p_type,p_type1
   #end add-point
   )
   #add-point:main段define
   DEFINE p_prdm001       LIKE prdm_t.prdm001   #規則編號
   DEFINE p_type          LIKE type_t.chr1      #是否可輸入標識
   DEFINE p_type1         LIKE type_t.chr1      #是否為滿額滿量
   

   LET g_prdm001 = p_prdm001
   LET g_type = p_type
   LET g_type1 = p_type1
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   DECLARE aprm211_01_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aprm211_01_master_referesh FROM g_sql
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aprm211_01 WITH FORM cl_ap_formpath("apr","aprm211_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aprm211_01_init()   
 
   #進入選單 Menu (="N")
   CALL aprm211_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aprm211_01
 
   CLOSE aprm211_01_cl
   
   
 
   #add-point:離開前
   
   #end add-point
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="aprm211_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aprm211_01_init()
   #add-point:init段define
   DEFINE l_msg      STRING
   DEFINE l_prdl024  LIKE prdl_t.prdl024
   #end add-point   
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1   
   LET g_error_show = 1
   
      CALL cl_set_combo_scc('prdm003','6567') 
 
   LET l_ac = 1
   
   
 
   #避免USER直接進入第二單身時無資料
   IF g_prdm_d.getLength() > 0 THEN
      LET g_master_t.* = g_prdm_d[1].*
      LET g_master.* = g_prdm_d[1].*
   END IF
 
   #add-point:畫面資料初始化
   SELECT prdl024 INTO l_prdl024
     FROM prdl_t
    WHERE prdlebt = g_enterprise
      AND prdl001 = g_prdl001
   IF l_prdl024 = '3' THEN
      CALL cl_getmsg('apr-00095',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdm005",l_msg)
   END IF
   IF l_prdl024 = '1' THEN
      CALL cl_getmsg('apr-00146',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prdm005",l_msg)
   END IF
   IF g_type1 <> 'Y' THEN
      CALL cl_set_comp_visible('lbl_prdm004',FALSE)
   ELSE
      CALL cl_set_comp_visible('lbl_prdm004',TRUE)
   END IF
   #CALL cl_set_combo_scc_part('prdn003','6517','1,2')   #150324-00004#1--mark by dongsz
   CALL aprm211_01_prdn003_display()                     #150324-00004#1--add by dongsz
   #end add-point
   
   CALL aprm211_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aprm211_01_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 
   IF g_type = 'N' THEN
      CALL cl_set_act_visible("modify,insert,modify_detail,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,insert,modify_detail,delete", TRUE)
   END IF
   #end add-point
   
   WHILE TRUE
   
      CALL aprm211_01_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_prdm_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
      
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_prdm_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               CALL aprm211_01_fetch()
               LET g_current_page = 1
               CALL aprm211_01_idx_chk('m')
               DISPLAY ARRAY g_prdm2_d TO s_detail2.*
                  BEFORE DISPLAY 
                     EXIT DISPLAY
               END DISPLAY 
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_prdm2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_current_page = 2
               CALL aprm211_01_idx_chk('d')
               LET g_master.* = g_prdm_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
 
      
         #add-point:ui_dialog段define

         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_prdm_d.getLength() THEN
                  LET g_detail_idx = g_prdm_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            IF g_type = 'N' THEN
               CALL cl_set_act_visible("modify,insert,modify_detail,delete", FALSE)
            ELSE
               CALL cl_set_act_visible("modify,insert,modify_detail,delete", TRUE)
            END IF
            CALL cl_set_act_visible("reproduce", FALSE) 
            IF g_type1 <> 'Y' THEN
               CALL cl_set_comp_visible('prdm004',FALSE)
            ELSE
               CALL cl_set_comp_visible('prdm004',TRUE)
            END IF
            #CALL cl_set_combo_scc_part('prdn003','6517','1,2')   #150324-00004#1--mark by dongsz
            CALL aprm211_01_prdn003_display()                     #150324-00004#1--add by dongsz
            NEXT FIELD CURRENT
         
         AFTER DIALOG
            #add-point:ui_dialog段after dialog
            
            #end add-point
         
         
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               #add-point:ON ACTION delete

               #END add-point
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL aprm211_01_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL aprm211_01_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aprm211_01_query()
               #add-point:ON ACTION query

               #END add-point
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               #add-point:ON ACTION reproduce

               #END add-point
               EXIT DIALOG
            END IF
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
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
   RETURN
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 
   IF g_type = 'N' THEN
      CALL cl_set_act_visible("modify,insert,modify_detail,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,insert,modify_detail,delete", TRUE)
   END IF
   #end add-point
   
   WHILE TRUE
   
      #add-point:ui_dialog段before while

      #end add-point
   
      CALL aprm211_01_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_prdm_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
	  
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_prdm_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               CALL aprm211_01_fetch()
               CALL aprm211_01_idx_chk('m')
               
            #自訂ACTION(detail_show,page_1)
            
 
       

 

 
 
 
               
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_prdm2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 2
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               CALL aprm211_01_idx_chk('d')
               LET g_master.* = g_prdm_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_prdm_d.getLength() THEN
                  LET g_detail_idx = g_prdm_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            NEXT FIELD CURRENT
         
         AFTER DIALOG
            #add-point:ui_dialog段after dialog
            IF g_type = 'N' THEN
               CALL cl_set_act_visible("modify,insert,modify_detail,delete", FALSE)
            ELSE
               CALL cl_set_act_visible("modify,insert,modify_detail,delete", TRUE)
            END IF
            #end add-point
         
         
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aprm211_01_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprm211_01_modify()
               #add-point:ON ACTION modify_detail

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
               CALL aprm211_01_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
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
 
{<section id="aprm211_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprm211_01_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   DEFINE l_prdl003  LIKE prdl_t.prdl003
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_prdm_d.clear()
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON prdm004,prdm002,prdm003,prdm005,prdmstus,prdm001,prdmsite,prdmunit
           FROM s_detail1[1].prdm004,s_detail1[1].prdm002,s_detail1[1].prdm003,s_detail1[1].prdm005, 
               s_detail1[1].prdmstus,s_detail1[1].prdm001,s_detail1[1].prdmsite,s_detail1[1].prdmunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #此段落由子樣板a11產生
         ##----<<prdmownid>>----
         ##ON ACTION controlp INFIELD prdmownid
         ##   CALL q_common('','prdmownid',TRUE,FALSE,.prdmownid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmownid
         ##   NEXT FIELD prdmownid  
         #
         ##----<<prdmowndp>>----
         ##ON ACTION controlp INFIELD prdmowndp
         ##   CALL q_common('','prdmowndp',TRUE,FALSE,.prdmowndp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmowndp
         ##   NEXT FIELD prdmowndp
         #
         ##----<<prdmcrtid>>----
         ##ON ACTION controlp INFIELD prdmcrtid
         ##   CALL q_common('','prdmcrtid',TRUE,FALSE,.prdmcrtid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmcrtid
         ##   NEXT FIELD prdmcrtid
         #
         ##----<<prdmcrtdp>>----
         ##ON ACTION controlp INFIELD prdmcrtdp
         ##   CALL q_common('','prdmcrtdp',TRUE,FALSE,.prdmcrtdp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmcrtdp
         ##   NEXT FIELD prdmcrtdp
         #
         ##----<<prdmmodid>>----
         ##ON ACTION controlp INFIELD prdmmodid
         ##   CALL q_common('','prdmmodid',TRUE,FALSE,.prdmmodid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmmodid
         ##   NEXT FIELD prdmmodid
         #
         ##----<<prdmcnfid>>----
         ##ON ACTION controlp INFIELD prdmcnfid
         ##   CALL q_common('','prdmcnfid',TRUE,FALSE,.prdmcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmcnfid
         ##   NEXT FIELD prdmcnfid
         #
         ##----<<prdmpstid>>----
         ##ON ACTION controlp INFIELD prdmpstid
         ##   CALL q_common('','prdmpstid',TRUE,FALSE,.prdmpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdmpstid
         ##   NEXT FIELD prdmpstid
         
         ##----<<prdmcrtdt>>----
         #AFTER FIELD prdmcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdmmoddt>>----
         #AFTER FIELD prdmmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdmcnfdt>>----
         #AFTER FIELD prdmcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdmpstdt>>----
         #AFTER FIELD prdmpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<prdm004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm004
            #add-point:BEFORE FIELD prdm004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm004
            
            #add-point:AFTER FIELD prdm004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdm004
         ON ACTION controlp INFIELD prdm004
            #add-point:ON ACTION controlp INFIELD prdm004
            
            #END add-point
 
         #----<<prdm002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm002
            #add-point:BEFORE FIELD prdm002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm002
            
            #add-point:AFTER FIELD prdm002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdm002
         ON ACTION controlp INFIELD prdm002
            #add-point:ON ACTION controlp INFIELD prdm002
            
            #END add-point
 
         #----<<prdm003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm003
            #add-point:BEFORE FIELD prdm003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm003
            
            #add-point:AFTER FIELD prdm003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdm003
         ON ACTION controlp INFIELD prdm003
            #add-point:ON ACTION controlp INFIELD prdm003
            
            #END add-point
 
         #----<<prdm005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm005
            #add-point:BEFORE FIELD prdm005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm005
            
            #add-point:AFTER FIELD prdm005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdm005
         ON ACTION controlp INFIELD prdm005
            #add-point:ON ACTION controlp INFIELD prdm005
            
            #END add-point
 
         #----<<prdmstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdmstus
            #add-point:BEFORE FIELD prdmstus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdmstus
            
            #add-point:AFTER FIELD prdmstus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdmstus
         ON ACTION controlp INFIELD prdmstus
            #add-point:ON ACTION controlp INFIELD prdmstus
            
            #END add-point
 
         #----<<prdm001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm001
            #add-point:BEFORE FIELD prdm001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm001
            
            #add-point:AFTER FIELD prdm001
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdm001
         ON ACTION controlp INFIELD prdm001
            #add-point:ON ACTION controlp INFIELD prdm001
            
            #END add-point
 
         #----<<prdmsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdmsite
            #add-point:BEFORE FIELD prdmsite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdmsite
            
            #add-point:AFTER FIELD prdmsite
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdmsite
         ON ACTION controlp INFIELD prdmsite
            #add-point:ON ACTION controlp INFIELD prdmsite
            
            #END add-point
 
         #----<<prdmunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdmunit
            #add-point:BEFORE FIELD prdmunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdmunit
            
            #add-point:AFTER FIELD prdmunit
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.prdmunit
         ON ACTION controlp INFIELD prdmunit
            #add-point:ON ACTION controlp INFIELD prdmunit
            
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON prdn002,prdn003,prdn004,prdnstus,prdnsite,prdnunit
           FROM s_detail2[1].prdn002,s_detail2[1].prdn003,s_detail2[1].prdn004,s_detail2[1].prdnstus, 
               s_detail2[1].prdnsite,s_detail2[1].prdnunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #此段落由子樣板a11產生
         ##----<<prdnownid>>----
         ##ON ACTION controlp INFIELD prdnownid
         ##   CALL q_common('','prdnownid',TRUE,FALSE,.prdnownid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdnownid
         ##   NEXT FIELD prdnownid  
         #
         ##----<<prdnowndp>>----
         ##ON ACTION controlp INFIELD prdnowndp
         ##   CALL q_common('','prdnowndp',TRUE,FALSE,.prdnowndp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdnowndp
         ##   NEXT FIELD prdnowndp
         #
         ##----<<prdncrtid>>----
         ##ON ACTION controlp INFIELD prdncrtid
         ##   CALL q_common('','prdncrtid',TRUE,FALSE,.prdncrtid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdncrtid
         ##   NEXT FIELD prdncrtid
         #
         ##----<<prdncrtdp>>----
         ##ON ACTION controlp INFIELD prdncrtdp
         ##   CALL q_common('','prdncrtdp',TRUE,FALSE,.prdncrtdp) RETURNING ls_return
         ##   DISPLAY ls_return TO prdncrtdp
         ##   NEXT FIELD prdncrtdp
         #
         ##----<<prdnmodid>>----
         ##ON ACTION controlp INFIELD prdnmodid
         ##   CALL q_common('','prdnmodid',TRUE,FALSE,.prdnmodid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdnmodid
         ##   NEXT FIELD prdnmodid
         #
         ##----<<prdncnfid>>----
         ##ON ACTION controlp INFIELD prdncnfid
         ##   CALL q_common('','prdncnfid',TRUE,FALSE,.prdncnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdncnfid
         ##   NEXT FIELD prdncnfid
         #
         ##----<<prdnpstid>>----
         ##ON ACTION controlp INFIELD prdnpstid
         ##   CALL q_common('','prdnpstid',TRUE,FALSE,.prdnpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO prdnpstid
         ##   NEXT FIELD prdnpstid
         
         ##----<<prdncrtdt>>----
         #AFTER FIELD prdncrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdnmoddt>>----
         #AFTER FIELD prdnmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdncnfdt>>----
         #AFTER FIELD prdncnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdnpstdt>>----
         #AFTER FIELD prdnpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<prdn002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdn002
            #add-point:BEFORE FIELD prdn002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdn002
            
            #add-point:AFTER FIELD prdn002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdn002
         ON ACTION controlp INFIELD prdn002
            #add-point:ON ACTION controlp INFIELD prdn002
            
            #END add-point
 
         #----<<prdn003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdn003
            #add-point:BEFORE FIELD prdn003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdn003
            
            #add-point:AFTER FIELD prdn003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdn003
         ON ACTION controlp INFIELD prdn003
            #add-point:ON ACTION controlp INFIELD prdn003
            
            #END add-point
 
         #----<<prdn004>>----
         #Ctrlp:construct.c.page2.prdn004
         ON ACTION controlp INFIELD prdn004
            #add-point:ON ACTION controlp INFIELD prdn004
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1'
			SELECT prdl003 INTO l_prdl003
			  FROM prdl_t
			 WHERE prdlent = g_enterprise
			   AND prdl001 = g_prdm001
			LET g_qryparam.arg2 = l_prdl003
            CALL q_prdn004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdn004  #顯示到畫面上

            NEXT FIELD prdn004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdn004
            #add-point:BEFORE FIELD prdn004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdn004
            
            #add-point:AFTER FIELD prdn004
            
            #END add-point
            
 
         #----<<prdn004_desc>>----
         #----<<prdnstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdnstus
            #add-point:BEFORE FIELD prdnstus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdnstus
            
            #add-point:AFTER FIELD prdnstus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdnstus
         ON ACTION controlp INFIELD prdnstus
            #add-point:ON ACTION controlp INFIELD prdnstus
            
            #END add-point
 
         #----<<prdnsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdnsite
            #add-point:BEFORE FIELD prdnsite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdnsite
            
            #add-point:AFTER FIELD prdnsite
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdnsite
         ON ACTION controlp INFIELD prdnsite
            #add-point:ON ACTION controlp INFIELD prdnsite
            
            #END add-point
 
         #----<<prdnunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdnunit
            #add-point:BEFORE FIELD prdnunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdnunit
            
            #add-point:AFTER FIELD prdnunit
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.prdnunit
         ON ACTION controlp INFIELD prdnunit
            #add-point:ON ACTION controlp INFIELD prdnunit
            
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
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_detail_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct
   
   #end add-point
        
   LET g_error_show = 1
   CALL aprm211_01_b_fill(g_wc)
   LET l_ac = g_detail_idx
   CALL aprm211_01_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.insert" >}
#+ 資料修改
PRIVATE FUNCTION aprm211_01_insert()
   #add-point:insert段define
   
   #end add-point 
 
   #add-point:insert段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL g_prdm_d.clear() 
   CALL g_prdm2_d.clear() 
 
   CALL aprm211_01_input('a')
   
   CALL aprm211_01_b_fill(g_wc)
   
   #add-point:insert段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.modify" >}
#+ 資料新增
PRIVATE FUNCTION aprm211_01_modify()
   #add-point:modify段define
   
   #end add-point 
 
   #add-point:modify段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL aprm211_01_input('u')
   
   #add-point:modify段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprm211_01_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define

   #end add-point 
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_prdm_d_t.* = g_prdm_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前

   #end add-point 
   
   #刪除單頭
   #160905-00007#12 -S
  #DELETE FROM prdm_t 
  #      WHERE prdm001 = g_prdm_d_t.prdm001
  #        AND prdm002 = g_prdm_d_t.prdm002
  #        AND prdm004 = g_prdm_d_t.prdm004
   DELETE FROM prdm_t 
         WHERE prdm001 = g_prdm_d_t.prdm001
           AND prdm002 = g_prdm_d_t.prdm002
           AND prdm004 = g_prdm_d_t.prdm004
           AND prdment = g_enterprise 
   #160905-00007#12 -E
           
   #add-point:delete段刪除中

   #end add-point 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "prdm_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段刪除後

   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前

   #end add-point 
   #160905-00007#12 -S
   #DELETE FROM prdn_t 
   #      WHERE prdn001 = g_prdm_d_t.prdm001
   #        AND prdn002 = g_prdm_d_t.prdm002
   DELETE FROM prdn_t 
         WHERE prdn001 = g_prdm_d_t.prdm001
           AND prdn002 = g_prdm_d_t.prdm002
           AND prdnent = g_enterprise 
   #160905-00007#12 -S        
   #add-point:delete段刪除中

   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "prdn_t"
      LET g_errparam.popup = TRUE
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
 
{<section id="aprm211_01.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprm211_01_input(p_cmd)
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
   DEFINE  l_prdm003             LIKE prdm_t.prdm003
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_oocq004             LIKE oocq_t.oocq004
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT prdm004,prdm002,prdm003,prdm005,prdmstus,prdm001,prdmsite,prdmunit FROM  
       prdm_t WHERE prdment=? AND prdm001=? AND prdm002=? AND prdm004=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprm211_01_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT prdn002,prdn003,prdn004,'',prdnstus,prdnsite,prdnunit FROM prdn_t WHERE  
       prdnent=? AND prdn001=? AND prdn002=? AND prdn003=? AND prdn004=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprm211_01_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   
   #add-point:input段修改前
   LET g_errshow = 1
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_prdm_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL aprm211_01_b_fill(g_wc)
            END IF
            LET g_detail_cnt = g_prdm_d.getLength()
            #add-point:資料輸入前
            #CALL cl_set_combo_scc_part('prdn003','6517','1,2')   #150324-00004#1--mark by dongsz
            CALL aprm211_01_prdn003_display()                     #150324-00004#1--add by dongsz
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_prdm_d[l_ac].*
            LET g_master.* = g_prdm_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_prdm_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_prdm_d[l_ac].prdm001 IS NOT NULL
               AND g_prdm_d[l_ac].prdm002 IS NOT NULL
               AND g_prdm_d[l_ac].prdm004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prdm_d_t.* = g_prdm_d[l_ac].*  #BACKUP
               IF NOT aprm211_01_lock_b("prdm_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_01_bcl INTO g_prdm_d[l_ac].prdm004,g_prdm_d[l_ac].prdm002,g_prdm_d[l_ac].prdm003, 
                      g_prdm_d[l_ac].prdm005,g_prdm_d[l_ac].prdmstus,g_prdm_d[l_ac].prdm001,g_prdm_d[l_ac].prdmsite, 
                      g_prdm_d[l_ac].prdmunit
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_prdm_d_t.prdm001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL aprm211_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aprm211_01_set_entry_b(l_cmd)
            CALL aprm211_01_set_no_entry_b(l_cmd)
            #add-point:input段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            #讀取對應的單身資料
            CALL aprm211_01_fetch()
            CALL aprm211_01_idx_chk('m')
        
         BEFORE INSERT
            
            #判斷能否在此頁面進行資料新增
            
            #清空下層單身
                        CALL g_prdm2_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdm_d[l_ac].* TO NULL 
                  LET g_prdm_d[l_ac].prdmstus = "Y"
 
 
            LET g_prdm_d_t.* = g_prdm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_01_set_entry_b("a")
            CALL aprm211_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdm_d[li_reproduce_target].* = g_prdm_d[li_reproduce].*
 
               LET g_prdm_d[g_prdm_d.getLength()].prdm001 = NULL
               LET g_prdm_d[g_prdm_d.getLength()].prdm002 = NULL
               LET g_prdm_d[g_prdm_d.getLength()].prdm004 = NULL
 
            END IF
            #公用欄位給值(單身)
            #此段落由子樣板a14產生    
      #LET .prdmownid = g_user
      #LET .prdmowndp = g_dept
      #LET .prdmcrtid = g_user
      #LET .prdmcrtdp = g_dept 
      #LET .prdmcrtdt = cl_get_current()
      #LET .prdmmodid = ""
      #LET .prdmmoddt = ""
      #LET g_prdm_d[l_ac].prdmstus = ""
 
 
            #add-point:input段before insert
            LET g_prdm_d[l_ac].prdmunit = g_site
            LET g_prdm_d[l_ac].prdmsite = g_site
            LET g_prdm_d[l_ac].prdm001 = g_prdm001
            IF g_type1 <> 'Y' THEN
               LET g_prdm_d[l_ac].prdm004 = 0
            END IF
            SELECT MAX(prdm002)+1 INTO g_prdm_d[l_ac].prdm002
              FROM prdm_t
             WHERE prdment = g_enterprise
               AND prdm001 = g_prdm001
               AND prdm004 = g_prdm_d[l_ac].prdm004 
            IF cl_null(g_prdm_d[l_ac].prdm002) THEN
               LET g_prdm_d[l_ac].prdm002 = 1
            END IF
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdm_t 
             WHERE prdment = g_enterprise AND prdm001 = g_prdm_d[l_ac].prdm001 
                                       AND prdm002 = g_prdm_d[l_ac].prdm002 
                                       AND prdm004 = g_prdm_d[l_ac].prdm004 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys[3] = g_prdm_d[g_detail_idx].prdm004
               CALL aprm211_01_insert_b('prdm_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prdm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdm_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm211_01_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_prdm_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' AND g_prdm_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prdm_d.deleteElement(l_ac)
               NEXT FIELD prdm001
            END IF
            IF g_prdm_d[l_ac].prdm001 IS NOT NULL
               AND g_prdm_d_t.prdm002 IS NOT NULL
               AND g_prdm_d_t.prdm004 IS NOT NULL
 
               THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前

               #end add-point
               
               DELETE FROM prdm_t
                WHERE prdment = g_enterprise AND 
                      prdm001 = g_prdm_d_t.prdm001
                      AND prdm002 = g_prdm_d_t.prdm002
                      AND prdm004 = g_prdm_d_t.prdm004
 
                      
               #add-point:單身刪除中

               #end add-point
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdm_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprm211_01_bcl
               LET l_count = g_prdm_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys[3] = g_prdm_d[g_detail_idx].prdm004
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL aprm211_01_delete_b('prdm_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<prdm004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm004
            #add-point:BEFORE FIELD prdm004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm004
            
            #add-point:AFTER FIELD prdm004
            #此段落由子樣板a05產生

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdm004
            #add-point:ON CHANGE prdm004

            #END add-point
 
         #----<<prdm002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm002
            #add-point:BEFORE FIELD prdm002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm002
            
            #add-point:AFTER FIELD prdm002
            #此段落由子樣板a05產生
#            IF g_prdmdocno IS NOT NULL AND g_prdm_d[g_detail_idx].prdm002 IS NOT NULL AND g_prdm_d[g_detail_idx].prdm004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdm_d[g_detail_idx].prdm002 != g_prdm_d_t.prdm002 OR g_prdm_d[g_detail_idx].prdm004 != g_prdm_d_t.prdm004)) THEN 
#                  IF NOT ap_chk_notDup(g_prdm_d[l_ac].prdm002,"SELECT COUNT(*) FROM prdm_t WHERE "||"prdment = '" ||g_enterprise|| "' AND "||"prdmdocno = '"||g_prdmdocno ||"' AND "|| "prdm002 = '"||g_prdm_d[g_detail_idx].prdm002 ||"' AND "|| "prdm004 = '"||g_prdm_d[g_detail_idx].prdm004 ||"'",'std-00004',1) THEN 
#                     LET g_prdm_d[l_ac].prdm002 = g_prdm_d_t.prdm002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdm002
            #add-point:ON CHANGE prdm002

            #END add-point
 
         #----<<prdm003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm003
            #add-point:BEFORE FIELD prdm003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm003
            
            #add-point:AFTER FIELD prdm003
#            IF NOT cl_null(g_prdm_d[l_ac].prdm003) THEN
#               IF g_prdm_d[l_ac].prdm003 = '1' THEN
#                  LET l_n1 = 0
#                  SELECT COUNT(*) INTO l_n1
#                    FROM prdm_t
#                   WHERE prdment = g_enterprise
#                     AND prdmdocno = g_prdmdocno
#                     AND prdm004 = g_prdm_d[l_ac].prdm004
#                     AND prdm002 <> g_prdm_d[l_ac].prdm002
#                     AND prdm003 = '1'
#                  IF l_n1 > 0 THEN
#                     CALL cl_err(g_prdm_d[l_ac].prdm003,'apr-00195',1)
#                     LET g_prdm_d[l_ac].prdm003 = g_prdm_d_t.prdm003
#                     NEXT FIELD prdm003
#                  END IF
#               END IF
#               IF l_cmd = 'u' AND g_prdm_d[l_ac].prdm003 <>　g_prdm_d_t.prdm003 THEN
#                  LET l_n1 = 0
#                  SELECT COUNT(*) INTO l_n1
#                    FROM prdn_t
#                   WHERE prdnent = g_enterprise
#                     AND prdcdocno = g_prdmdocno
#                     AND prdn002 = g_prdm_d[l_ac].prdm002
#                  IF l_n1 > 0 THEN
#                     IF NOT cl_ask_confirm('apr-00196') THEN
#                        LET g_prdm_d[l_ac].prdm003 = g_prdm_d_t.prdm003
#                        NEXT FIELD prdm003
#                     ELSE
#                        DELETE FROM prdn_t
#                         WHERE prdnent = g_enterprise
#                           AND prdcdocno = g_prdmdocno
#                           AND prdn002 = g_prdm_d[l_ac].prdm002
#                        CALL aprm211_01_fetch()   
#                     END IF
#                  END IF
#               END IF
#            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdm003
            #add-point:ON CHANGE prdm003

            #END add-point
 
         #----<<prdm005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm005
            #add-point:BEFORE FIELD prdm005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm005
            
            #add-point:AFTER FIELD prdm005
#            IF l_prdl024 = '2' THEN
#               IF g_prdm_d[l_ac].prdm005 < 0 OR g_prdm_d[l_ac].prdm005 > 100 THEN
#                  CALL cl_err(g_prdm_d[l_ac].prdm005,'apr-00077',1)
#                  LET g_prdm_d[l_ac].prdm005 = g_prdm_d_t.prdm005
#                  NEXT FIELD prdm005
#               END IF
#            END IF
#            IF l_prdl024 = '3' THEN
#               IF g_prdm_d[l_ac].prdm005 <= 0 THEN
#                  CALL cl_err(g_prdm_d[l_ac].prdm005,'apr-00078',1)
#                  LET g_prdm_d[l_ac].prdm005 = g_prdm_d_t.prdm005
#                  NEXT FIELD prdm005
#               END IF
#            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdm005
            #add-point:ON CHANGE prdm005

            #END add-point
 
         #----<<prdmstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdmstus
            #add-point:BEFORE FIELD prdmstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdmstus
            
            #add-point:AFTER FIELD prdmstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdmstus
            #add-point:ON CHANGE prdmstus

            #END add-point
 
         #----<<prdm001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdm001
            #add-point:BEFORE FIELD prdm001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdm001
            
            #add-point:AFTER FIELD prdm001
            #此段落由子樣板a05產生
            IF  g_prdm_d[g_detail_idx].prdm001 IS NOT NULL AND g_prdm_d[g_detail_idx].prdm002 IS NOT NULL AND g_prdm_d[g_detail_idx].prdm004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdm_d[g_detail_idx].prdm001 != g_prdm_d_t.prdm001 OR g_prdm_d[g_detail_idx].prdm002 != g_prdm_d_t.prdm002 OR g_prdm_d[g_detail_idx].prdm004 != g_prdm_d_t.prdm004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdm_t WHERE "||"prdment = '" ||g_enterprise|| "' AND "||"prdm001 = '"||g_prdm_d[g_detail_idx].prdm001 ||"' AND "|| "prdm002 = '"||g_prdm_d[g_detail_idx].prdm002 ||"' AND "|| "prdm004 = '"||g_prdm_d[g_detail_idx].prdm004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdm001
            #add-point:ON CHANGE prdm001

            #END add-point
 
         #----<<prdmsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdmsite
            #add-point:BEFORE FIELD prdmsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdmsite
            
            #add-point:AFTER FIELD prdmsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdmsite
            #add-point:ON CHANGE prdmsite

            #END add-point
 
         #----<<prdmunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdmunit
            #add-point:BEFORE FIELD prdmunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdmunit
            
            #add-point:AFTER FIELD prdmunit

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdmunit
            #add-point:ON CHANGE prdmunit

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<prdm004>>----
         #Ctrlp:input.c.page1.prdm004
         ON ACTION controlp INFIELD prdm004
            #add-point:ON ACTION controlp INFIELD prdm004
 
            #END add-point
 
         #----<<prdm002>>----
         #Ctrlp:input.c.page1.prdm002
         ON ACTION controlp INFIELD prdm002
            #add-point:ON ACTION controlp INFIELD prdm002

            #END add-point
 
         #----<<prdm003>>----
         #Ctrlp:input.c.page1.prdm003
         ON ACTION controlp INFIELD prdm003
            #add-point:ON ACTION controlp INFIELD prdm003

            #END add-point
 
         #----<<prdm005>>----
         #Ctrlp:input.c.page1.prdm005
         ON ACTION controlp INFIELD prdm005
            #add-point:ON ACTION controlp INFIELD prdm005

            #END add-point
 
         #----<<prdmstus>>----
         #Ctrlp:input.c.page1.prdmstus
         ON ACTION controlp INFIELD prdmstus
            #add-point:ON ACTION controlp INFIELD prdmstus

            #END add-point
 
         #----<<prdm001>>----
         #Ctrlp:input.c.page1.prdm001
         ON ACTION controlp INFIELD prdm001
            #add-point:ON ACTION controlp INFIELD prdm001

            #END add-point
 
         #----<<prdmsite>>----
         #Ctrlp:input.c.page1.prdmsite
         ON ACTION controlp INFIELD prdmsite
            #add-point:ON ACTION controlp INFIELD prdmsite

            #END add-point
 
         #----<<prdmunit>>----
         #Ctrlp:input.c.page1.prdmunit
         ON ACTION controlp INFIELD prdmunit
            #add-point:ON ACTION controlp INFIELD prdmunit

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prdm_d[l_ac].* = g_prdm_d_t.*
               CLOSE aprm211_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_prdm_d[l_ac].prdm001
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prdm_d[l_ac].* = g_prdm_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               #LET .prdmmodid = g_user 
#LET .prdmmoddt = cl_get_current()
 
               
               #add-point:單身修改前

               #end add-point
               
               UPDATE prdm_t SET (prdm004,prdm002,prdm003,prdm005,prdmstus,prdm001,prdmsite,prdmunit) = (g_prdm_d[l_ac].prdm004, 
                   g_prdm_d[l_ac].prdm002,g_prdm_d[l_ac].prdm003,g_prdm_d[l_ac].prdm005,g_prdm_d[l_ac].prdmstus, 
                   g_prdm_d[l_ac].prdm001,g_prdm_d[l_ac].prdmsite,g_prdm_d[l_ac].prdmunit)
                WHERE prdment = g_enterprise AND
                  prdm001 = g_prdm_d_t.prdm001 #項次   
                  AND prdm002 = g_prdm_d_t.prdm002  
                  AND prdm004 = g_prdm_d_t.prdm004  
 
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdm_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prdm_d[l_ac].* = g_prdm_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdm_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prdm_d[l_ac].* = g_prdm_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys_bak[1] = g_prdm_d_t.prdm001
               LET gs_keys[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys_bak[2] = g_prdm_d_t.prdm002
               LET gs_keys[3] = g_prdm_d[g_detail_idx].prdm004
               LET gs_keys_bak[3] = g_prdm_d_t.prdm004
               CALL aprm211_01_update_b('prdm_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_prdm_d[l_ac].*
               CALL aprm211_01_key_update_b()
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aprm211_01_unlock_b("prdm_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_prdm_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prdm_d.getLength()+1
              
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_prdm2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdm2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_detail_cnt = g_prdm2_d.getLength()
            LET g_current_page = 2
            #add-point:資料輸入前
            IF g_prdm_d[g_detail_idx].prdm003 = '1' THEN
               NEXT FIELD prdm003
            END IF
            IF g_prdm_d[g_detail_idx].prdm003 = '2' THEN
               #CALL cl_set_combo_scc_part('prdn003','6517','1,2')   #150324-00004#1--mark by dongsz
               CALL aprm211_01_prdn003_display()                     #150324-00004#1--add by dongsz
            END IF
            IF g_prdm_d[g_detail_idx].prdm003 = '3' THEN
               CALL cl_set_combo_scc('prdn003','6535')
            END IF
            #end add-point
 
         BEFORE INSERT
            IF g_prdm_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00013'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               NEXT FIELD prdm001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdm2_d[l_ac].* TO NULL 
                  LET g_prdm2_d[l_ac].prdnstus = "Y"
 
 
            LET g_prdm2_d_t.* = g_prdm2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm211_01_set_entry_b("a")
            CALL aprm211_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdm2_d[li_reproduce_target].* = g_prdm2_d[li_reproduce].*
 
               LET g_prdm2_d[li_reproduce_target].prdn003 = NULL
               LET g_prdm2_d[li_reproduce_target].prdn004 = NULL
            END IF
            #公用欄位給值(單身2)
            #此段落由子樣板a14產生    
      #LET .prdnownid = g_user
      #LET .prdnowndp = g_dept
      #LET .prdncrtid = g_user
      #LET .prdncrtdp = g_dept 
      #LET .prdncrtdt = cl_get_current()
      #LET .prdnmodid = ""
      #LET .prdnmoddt = ""
      #LET g_prdm2_d[l_ac].prdnstus = ""
 
 
            #add-point:input段before insert
            IF g_prdm_d[g_detail_idx].prdm003 = '1' THEN
               NEXT FIELD prdm003
            END IF 
            LET g_prdm2_d[l_ac].prdn002 = g_prdm_d[g_detail_idx].prdm002
            LET l_prdm003 = ''
            SELECT prdm003 INTO l_prdm003 
              FROM prdm_t
             WHERE prdment = g_enterprise
               AND prdm001 = g_prdm001
               AND prdm002 = g_prdm2_d[l_ac].prdn002
            IF l_prdm003 = '2' THEN
               #CALL cl_set_combo_scc_part('prdn003','6517','1,2')   #150324-00004#1--mark by dongsz
               CALL aprm211_01_prdn003_display()                     #150324-00004#1--add by dongsz
            END IF
            IF l_prdm003 = '3' THEN
               CALL cl_set_combo_scc('prdn003','6035')
            END IF
            LET g_prdm2_d[l_ac].prdnunit = g_site
            LET g_prdm2_d[l_ac].prdnsite = g_site
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_prdm2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_prdm2_d[l_ac].prdn003 IS NOT NULL
               AND g_prdm2_d[l_ac].prdn004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdm2_d_t.* = g_prdm2_d[l_ac].*  #BACKUP
               IF NOT aprm211_01_lock_b("prdn_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm211_01_bcl2 INTO g_prdm2_d[l_ac].prdn002,g_prdm2_d[l_ac].prdn003,g_prdm2_d[l_ac].prdn004, 
                      g_prdm2_d[l_ac].prdn004_desc,g_prdm2_d[l_ac].prdnstus,g_prdm2_d[l_ac].prdnsite, 
                      g_prdm2_d[l_ac].prdnunit
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  CALL aprm211_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aprm211_01_set_entry_b(l_cmd)
            CALL aprm211_01_set_no_entry_b(l_cmd)
            #add-point:input段before row
            CALL aprm211_01_prdn_desc()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL aprm211_01_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prdm2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prdm2_d.deleteElement(l_ac)
               NEXT FIELD prdn003
            END IF
            IF g_prdm2_d[l_ac].prdn003 IS NOT NULL
               AND g_prdm2_d_t.prdn004 IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前

               #end add-point  
               
               DELETE FROM prdn_t
                WHERE prdnent = g_enterprise AND
                   prdn001 = g_master.prdm001
                   AND prdn002 = g_master.prdm002
                   AND prdn003 = g_prdm2_d_t.prdn003
                   AND prdn004 = g_prdm2_d_t.prdn004
                   
               #add-point:單身2刪除中

               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdm_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprm211_01_bcl
               LET l_count = g_prdm_d.getLength()
            END IF 
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys[3] = g_prdm2_d[g_detail_idx2].prdn003
               LET gs_keys[4] = g_prdm2_d[g_detail_idx2].prdn004
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point
                           CALL aprm211_01_delete_b('prdn_t',gs_keys,"'2'")
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdn_t 
             WHERE prdnent = g_enterprise AND
                   prdn001 = g_master.prdm001
                   AND prdn002 = g_master.prdm002
                   AND prdn003 = g_prdm2_d[g_detail_idx2].prdn003
                   AND prdn004 = g_prdm2_d[g_detail_idx2].prdn004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys[3] = g_prdm2_d[g_detail_idx2].prdn003
               LET gs_keys[4] = g_prdm2_d[g_detail_idx2].prdn004
               CALL aprm211_01_insert_b('prdn_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_prdm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdn_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm211_01_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_prdm2_d[l_ac].* = g_prdm2_d_t.*
               CLOSE aprm211_01_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_prdm2_d[l_ac].* = g_prdm2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身2)
               #LET .prdnmodid = g_user 
#LET .prdnmoddt = cl_get_current()
 
               
               #add-point:單身page2修改前

               #end add-point
               
               UPDATE prdn_t SET (prdn002,prdn003,prdn004,prdnstus,prdnsite,prdnunit) = (g_prdm2_d[l_ac].prdn002, 
                   g_prdm2_d[l_ac].prdn003,g_prdm2_d[l_ac].prdn004,g_prdm2_d[l_ac].prdnstus,g_prdm2_d[l_ac].prdnsite, 
                   g_prdm2_d[l_ac].prdnunit) #自訂欄位頁簽
                WHERE prdnent = g_enterprise AND
                   prdn001 = g_master.prdm001
                   AND prdn002 = g_master.prdm002
                   AND prdn003 = g_prdm2_d_t.prdn003
                   AND prdn004 = g_prdm2_d_t.prdn004
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdn_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_prdm2_d[l_ac].* = g_prdm2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdn_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prdm2_d[l_ac].* = g_prdm2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys_bak[1] = g_prdm_d[g_detail_idx].prdm001
               LET gs_keys[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys_bak[2] = g_prdm_d[g_detail_idx].prdm002
               LET gs_keys[3] = g_prdm2_d[g_detail_idx2].prdn003
               LET gs_keys_bak[3] = g_prdm2_d_t.prdn003
               LET gs_keys[4] = g_prdm2_d[g_detail_idx2].prdn004
               LET gs_keys_bak[4] = g_prdm2_d_t.prdn004
               CALL aprm211_01_update_b('prdn_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<prdn002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdn002
            #add-point:BEFORE FIELD prdn002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdn002
            
            #add-point:AFTER FIELD prdn002


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdn002
            #add-point:ON CHANGE prdn002

            #END add-point
 
         #----<<prdn003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdn003
            #add-point:BEFORE FIELD prdn003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdn003
            
            #add-point:AFTER FIELD prdn003
            #此段落由子樣板a05產生
#            IF g_prdm2_d[l_ac].prdn002 IS NOT NULL AND g_prdm2_d[l_ac].prdn003 IS NOT NULL AND g_prdm2_d[l_ac].prdn004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdm2_d[l_ac].prdn002 != g_prdm2_d_t.prdn002 OR g_prdm2_d[l_ac].prdn003 != g_prdm2_d_t.prdn003 OR g_prdm2_d[l_ac].prdn004 != g_prdm2_d_t.prdn004)) THEN 
#                  IF NOT ap_chk_notDup(g_prdm2_d[l_ac].prdn003,"SELECT COUNT(*) FROM prdn_t WHERE "||"prdnent = '" ||g_enterprise|| "' AND "||"prdcdocno = '"||g_prdmdocno ||"' AND "|| "prdn002 = '"||g_prdm2_d[l_ac].prdn002 ||"' AND "|| "prdn003 = '"||g_prdm2_d[l_ac].prdn003 ||"' AND "|| "prdn004 = '"||g_prdm2_d[l_ac].prdn004 ||"'",'std-00004',1) THEN 
#                     LET g_prdm2_d[l_ac].prdn003 = g_prdm2_d_t.prdn003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prdm2_d[l_ac].prdn003 <> g_prdm2_d_t.prdn003) THEN
#               LET g_prdm2_d[l_ac].prdn004 = ""
#               LET g_prdm2_d[l_ac].prdn004_desc = ""
#               DISPLAY BY NAME g_prdm2_d[l_ac].prdn004,g_prdm2_d[l_ac].prdn004_desc
#            END IF
#            IF NOT cl_null(g_prdm2_d[l_ac].prdn004) THEN
#               IF g_prdm2_d[l_ac].prdn003 = '1' THEN
#                  IF NOT s_azzi650_chk_exist('2024',g_prdm2_d[l_ac].prdn004) THEN
#                     LET g_prdm2_d[l_ac].prdn003 = g_prdm2_d_t.prdn003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = '2' THEN
#                  IF NOT s_azzi650_chk_exist('2025',g_prdm2_d[l_ac].prdn004) THEN
#                     LET g_prdm2_d[l_ac].prdn003 = g_prdm2_d_t.prdn003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = 'X' THEN
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_prdm2_d[l_ac].prdn004
#                  #呼叫檢查存在並帶值的library
#                  IF NOT cl_chk_exist("v_pmaa001_10") THEN
#                     LET g_prdm2_d[l_ac].prdn003 = g_prdm2_d_t.prdn003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = 'Y' THEN
#                  IF NOT s_azzi650_chk_exist('281',g_prdm2_d[l_ac].prdn004) THEN
#                     LET g_prdm2_d[l_ac].prdn003 = g_prdm2_d_t.prdn003
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF  
#
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdn003
            #add-point:ON CHANGE prdn003

            #END add-point
 
         #----<<prdn004>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdn004
            
            #add-point:AFTER FIELD prdn004
            #此段落由子樣板a05產生
#            CALL aprm211_01_prdn_desc()
#            IF g_prdm2_d[l_ac].prdn002 IS NOT NULL AND g_prdm2_d[l_ac].prdn003 IS NOT NULL AND g_prdm2_d[l_ac].prdn004 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdm2_d[l_ac].prdn002 != g_prdm2_d_t.prdn002 OR g_prdm2_d[l_ac].prdn003 != g_prdm2_d_t.prdn003 OR g_prdm2_d[l_ac].prdn004 != g_prdm2_d_t.prdn004)) THEN 
#                  IF NOT ap_chk_notDup(g_prdm2_d[l_ac].prdn004,"SELECT COUNT(*) FROM prdn_t WHERE "||"prdnent = '" ||g_enterprise|| "' AND "||"prdcdocno = '"||g_prdmdocno ||"' AND "|| "prdn002 = '"||g_prdm2_d[l_ac].prdn002 ||"' AND "|| "prdn003 = '"||g_prdm2_d[l_ac].prdn003 ||"' AND "|| "prdn004 = '"||g_prdm2_d[l_ac].prdn004 ||"'",'std-00004',1) THEN 
#                     LET g_prdm2_d[l_ac].prdn004 = g_prdm2_d_t.prdn004
#                     CALL aprm211_01_prdn_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            IF NOT cl_null(g_prdm2_d[l_ac].prdn004) THEN
#               IF g_prdm2_d[l_ac].prdn003 = '1' THEN
#                  IF NOT s_azzi650_chk_exist('2024',g_prdm2_d[l_ac].prdn004) THEN
#                     LET g_prdm2_d[l_ac].prdn004 = g_prdm2_d_t.prdn004
#                     CALL aprm211_01_prdn_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = '2' THEN
#                  IF NOT s_azzi650_chk_exist('2025',g_prdm2_d[l_ac].prdn004) THEN
#                     LET g_prdm2_d[l_ac].prdn004 = g_prdm2_d_t.prdn004
#                     CALL aprm211_01_prdn_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = 'X' THEN
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_prdm2_d[l_ac].prdn004
#                  #呼叫檢查存在並帶值的library
#                  IF NOT cl_chk_exist("v_pmaa001_10") THEN
#                     LET g_prdm2_d[l_ac].prdn004 = g_prdm2_d_t.prdn004
#                     CALL aprm211_01_prdn_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = 'Y' THEN
#                  IF NOT s_azzi650_chk_exist('281',g_prdm2_d[l_ac].prdn004) THEN
#                     LET g_prdm2_d[l_ac].prdn004 = g_prdm2_d_t.prdn004
#                     CALL aprm211_01_prdn_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF   
#

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdn004
            #add-point:BEFORE FIELD prdn004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdn004
            #add-point:ON CHANGE prdn004

            #END add-point
 
         #----<<prdn004_desc>>----
         #----<<prdnstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdnstus
            #add-point:BEFORE FIELD prdnstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdnstus
            
            #add-point:AFTER FIELD prdnstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdnstus
            #add-point:ON CHANGE prdnstus

            #END add-point
 
         #----<<prdnsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdnsite
            #add-point:BEFORE FIELD prdnsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdnsite
            
            #add-point:AFTER FIELD prdnsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdnsite
            #add-point:ON CHANGE prdnsite

            #END add-point
 
         #----<<prdnunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdnunit
            #add-point:BEFORE FIELD prdnunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdnunit
            
            #add-point:AFTER FIELD prdnunit

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdnunit
            #add-point:ON CHANGE prdnunit

            #END add-point
 
 
         #---------------------<  Detail: page2  >---------------------
         #----<<prdn002>>----
         #Ctrlp:input.c.page2.prdn002
         ON ACTION controlp INFIELD prdn002
            #add-point:ON ACTION controlp INFIELD prdn002
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_prdm2_d[l_ac].prdn002             #給予default值
#
#            #給予arg
#            LET g_qryparam.arg1 = g_prdmdocno
#            CALL q_prdm002()                                #呼叫開窗
#
#            LET g_prdm2_d[l_ac].prdn002 = g_qryparam.return1              #將開窗取得的值回傳到變數
#
#            DISPLAY g_prdm2_d[l_ac].prdn002 TO prdn002              #顯示到畫面上
#            
#            NEXT FIELD prdn002                          #返回原欄位
            #END add-point
 
         #----<<prdn003>>----
         #Ctrlp:input.c.page2.prdn003
         ON ACTION controlp INFIELD prdn003
            #add-point:ON ACTION controlp INFIELD prdn003

            #END add-point
 
         #----<<prdn004>>----
         #Ctrlp:input.c.page2.prdn004
         ON ACTION controlp INFIELD prdn004
            #add-point:ON ACTION controlp INFIELD prdn004
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdm2_d[l_ac].prdn004             #給予default值

            #給予arg
            IF g_prdm_d[g_detail_idx].prdm003 = '2' THEN
               #150324-00004#1--mark by dongsz--str---
#               IF g_prdm2_d[l_ac].prdn003 = '1' THEN #会员等级
#                  LET g_qryparam.arg1 = '2024'
#                  CALL q_oocq002()
#               END IF
#               IF g_prdm2_d[l_ac].prdn003 = '2' THEN #会员类型
#                  LET g_qryparam.arg1 = '2025'
#                  CALL q_oocq002()
#               END IF
               #150324-00004#1--mark by dongsz--end---
               #150324-00004#1--add by dongsz--str--- 
               SELECT oocq004 INTO l_oocq004
                 FROM oocq_t
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2049'
                  AND oocq002 = g_prdm2_d[l_ac].prdn003
               LET g_qryparam.arg1 = l_oocq004
               CALL q_oocq002()
               #150324-00004#1--add by dongsz--end---
            END IF
            
            IF g_prdm_d[g_detail_idx].prdm003 = '3' THEN
               CASE g_prdm2_d[l_ac].prdn003
                  WHEN '1'
                     LET g_qryparam.arg1 = 'ALL'
                     CALL q_pmaa001_6()
                  WHEN '2'
                     LET g_qryparam.arg1 =281
                     CALL q_oocq002()
                  WHEN '3'
                     LET g_qryparam.arg1=2061
                     CALL q_oocq002()
                  WHEN '4'
                     LET g_qryparam.arg1=2062
                     CALL q_oocq002()
                  WHEN '5'
                     LET g_qryparam.arg1=2063
                     CALL q_oocq002()
                  WHEN '6'
                     LET g_qryparam.arg1=2064
                     CALL q_oocq002()
                  WHEN '7'
                     LET g_qryparam.arg1=2065
                     CALL q_oocq002()
                  WHEN '8'
                     LET g_qryparam.arg1=2066
                     CALL q_oocq002()
                  WHEN '9'
                     LET g_qryparam.arg1=2067
                     CALL q_oocq002()
                  WHEN '10'
                     LET g_qryparam.arg1=2068
                     CALL q_oocq002()
                  WHEN '11'
                     LET g_qryparam.arg1=2069
                     CALL q_oocq002()
                  WHEN '12'
                     LET g_qryparam.arg1=2070
                     CALL q_oocq002()
               END CASE
            END IF


            LET g_prdm2_d[l_ac].prdn004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prdm2_d[l_ac].prdn004 TO prdn004              #顯示到畫面上
            CALL aprm211_01_prdn_desc()
            NEXT FIELD prdn004                          #返回原欄位


            #END add-point
 
         #----<<prdn004_desc>>----
         #----<<prdnstus>>----
         #Ctrlp:input.c.page2.prdnstus
         ON ACTION controlp INFIELD prdnstus
            #add-point:ON ACTION controlp INFIELD prdnstus

            #END add-point
 
         #----<<prdnsite>>----
         #Ctrlp:input.c.page2.prdnsite
         ON ACTION controlp INFIELD prdnsite
            #add-point:ON ACTION controlp INFIELD prdnsite

            #END add-point
 
         #----<<prdnunit>>----
         #Ctrlp:input.c.page2.prdnunit
         ON ACTION controlp INFIELD prdnunit
            #add-point:ON ACTION controlp INFIELD prdnunit

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdm2_d[l_ac].* = g_prdm2_d_t.*
               END IF
               CLOSE aprm211_01_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aprm211_01_unlock_b("prdn_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_prdm2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prdm2_d.getLength()+1
 
      END INPUT
 
      
 
    
 
      
      #add-point:input段input_array"

      #end add-point
      
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_prdm_d.getLength() THEN
               LET g_detail_idx = g_prdm_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array"

         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_prdm_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prdm004
               WHEN "s_detail2"
                  NEXT FIELD prdn002
 
            END CASE
         ELSE
            NEXT FIELD prdm004
         END IF
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
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
   
   #add-point:input段修改後

   #end add-point
 
   CLOSE aprm211_01_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprm211_01_b_fill(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num5
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE prdmstus,prdm004,prdm002,prdm003,prdm005,prdm001,prdmsite,prdmunit FROM prdm_t", 
 
 
               " LEFT JOIN prdn_t ON prdnent = prdment AND prdm001 = prdn001 AND prdm002 = prdn002",
 
 
               "",
               " WHERE prdment= ? AND 1=1 AND ", p_wc2
    
   LET g_sql = g_sql, #,cl_get_extra_cond('zzuser', 'zzgrup')
                      " ORDER BY prdm_t.prdm001,prdm_t.prdm002,prdm_t.prdm004"
  
   #add-point:b_fill段sql_after
   LET g_sql = "SELECT  UNIQUE prdmstus,prdm004,prdm002,prdm003,prdm005,prdm001,prdmsite,prdmunit FROM prdm_t",  
               " LEFT JOIN prdn_t ON prdnent = prdment AND prdm001 = prdn001 AND prdm002 = prdn002 ",
               " WHERE prdment= ? AND prdm001 = '",g_prdm001,"' AND ", p_wc2
    
   LET g_sql = g_sql, " ORDER BY prdm_t.prdm004,prdm_t.prdm002"
   #end add-point
  
   PREPARE aprm211_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aprm211_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_prdm_d.clear()
   CALL g_prdm2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_prdm_d[l_ac].prdmstus,g_prdm_d[l_ac].prdm004,g_prdm_d[l_ac].prdm002,g_prdm_d[l_ac].prdm003,g_prdm_d[l_ac].prdm005, 
       g_prdm_d[l_ac].prdm001,g_prdm_d[l_ac].prdmsite,g_prdm_d[l_ac].prdmunit 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL aprm211_01_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_prdm_d.deleteElement(g_prdm_d.getLength())   
   CALL g_prdm2_d.deleteElement(g_prdm2_d.getLength())
 
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_prdm_d.getLength()
      #LET g_prdm2_d[g_detail_idx2].prdn003 = g_prdm_d[g_detail_idx].prdm001 
      #LET g_prdm2_d[g_detail_idx2].prdn004 = g_prdm_d[g_detail_idx].prdm002 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aprm211_01_pb
   
   LET l_ac = 1
   IF g_prdm_d.getLength() > 0 THEN
      CALL aprm211_01_fetch()
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprm211_01_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define

   #end add-point
   
   #判定單頭是否有資料
   IF cl_null(g_prdm_d[g_detail_idx].prdm001) THEN
      RETURN
   END IF
   
   CALL g_prdm2_d.clear()
 
   
   LET li_ac = l_ac 
   
   LET g_sql = "SELECT  UNIQUE prdnstus,prdn002,prdn003,prdn004,'',prdnsite,prdnunit FROM prdn_t",   
         
               "",
               " WHERE prdnent=? AND prdn001=? AND prdn002=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY prdn_t.prdn003,prdn_t.prdn004" 
                      
   #add-point:單身填充前
   IF g_prdm_d[g_detail_idx].prdm003 = '2' THEN
      #CALL cl_set_combo_scc_part('prdn003','6517','1,2')   #150324-00004#1--mark by dongsz
      CALL aprm211_01_prdn003_display()                     #150324-00004#1--add by dongsz
   END IF
   IF g_prdm_d[g_detail_idx].prdm003 = '3' THEN
      CALL cl_set_combo_scc('prdn003','6035')
   END IF
   #end add-point
   
   PREPARE aprm211_01_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aprm211_01_pb2
   
   OPEN b_fill_curs2 USING g_enterprise,g_prdm_d[g_detail_idx].prdm001
                                  ,g_prdm_d[g_detail_idx].prdm002
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_prdm2_d[l_ac].prdnstus,g_prdm2_d[l_ac].prdn002,g_prdm2_d[l_ac].prdn003,g_prdm2_d[l_ac].prdn004, 
       g_prdm2_d[l_ac].prdn004_desc,g_prdm2_d[l_ac].prdnsite,g_prdm2_d[l_ac].prdnunit 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      CALL aprm211_01_prdn_desc()
      #end add-point
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
 
 
   #add-point:單身填充後

   #end add-point
   
   CALL g_prdm2_d.deleteElement(g_prdm2_d.getLength())   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aprm211_01_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   #此段落由子樣板a12產生
      ##LET .prdnownid_desc = cl_get_username(.prdnownid)
      ##LET .prdnowndp_desc = cl_get_deptname(.prdnowndp)
      ##LET .prdncrtid_desc = cl_get_username(.prdncrtid)
      ##LET .prdncrtdp_desc = cl_get_deptname(.prdncrtdp)
      ##LET .prdnmodid_desc = cl_get_username(.prdnmodid)
      ##LET .prdncnfid_desc = cl_get_deptname(.prdncnfid)
      ##LET .prdnpstid_desc = cl_get_deptname(.prdnpstid)
      
 
 
    
   #帶出公用欄位reference值page2
   #此段落由子樣板a12產生
      ##LET .prdmownid_desc = cl_get_username(.prdmownid)
      ##LET .prdmowndp_desc = cl_get_deptname(.prdmowndp)
      ##LET .prdmcrtid_desc = cl_get_username(.prdmcrtid)
      ##LET .prdmcrtdp_desc = cl_get_deptname(.prdmcrtdp)
      ##LET .prdmmodid_desc = cl_get_username(.prdmmodid)
      ##LET .prdmcnfid_desc = cl_get_deptname(.prdmcnfid)
      ##LET .prdmpstid_desc = cl_get_deptname(.prdmpstid)
      
 
 
 
   
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
   
   #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc

   #end add-point
 
   
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprm211_01_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="aprm211_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprm211_01_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="aprm211_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprm211_01_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " prdm001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " prdm002 = ", g_argv[02], " AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " prdm004 = ", g_argv[03], " AND "
   END IF
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprm211_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "prdm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM prdm_t
       WHERE prdment = g_enterprise AND
         prdm001 = ps_keys_bak[1] AND prdm002 = ps_keys_bak[2] AND prdm004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "prdn_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM prdn_t
       WHERE prdnent = g_enterprise AND
         prdn001 = ps_keys_bak[1] AND prdn002 = ps_keys_bak[2] AND prdn003 = ps_keys_bak[3] AND prdn004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdn_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "prdm_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM prdn_t
       WHERE prdnent = g_enterprise AND
         prdn001 = ps_keys_bak[1] AND prdn002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdn_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprm211_01_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point
 
   #判斷是否是同一群組的table
   LET ls_group = "prdm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO prdm_t
                  (prdment,
                   prdm001,prdm002,prdm004
                   ,prdm003,prdm005,prdmstus,prdmsite,prdmunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_prdm_d[g_detail_idx].prdm003,g_prdm_d[g_detail_idx].prdm005,g_prdm_d[g_detail_idx].prdmstus, 
                       g_prdm_d[g_detail_idx].prdmsite,g_prdm_d[g_detail_idx].prdmunit)
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdm_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "prdn_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO prdn_t
                  (prdnent,
                   prdn001,prdn002,prdn003,prdn004
                   ,prdnstus,prdnsite,prdnunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prdm2_d[g_detail_idx2].prdnstus,g_prdm2_d[g_detail_idx2].prdnsite,g_prdm2_d[g_detail_idx2].prdnunit) 
 
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
 
{<section id="aprm211_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprm211_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "prdm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "prdm_t" THEN
   
      #add-point:update_b段修改前

      #end add-point     
   
      UPDATE prdm_t 
         SET (prdm001,prdm002,prdm004
              ,prdm003,prdm005,prdmstus,prdmsite,prdmunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_prdm_d[g_detail_idx].prdm003,g_prdm_d[g_detail_idx].prdm005,g_prdm_d[g_detail_idx].prdmstus, 
                  g_prdm_d[g_detail_idx].prdmsite,g_prdm_d[g_detail_idx].prdmunit) 
         #WHERE prdm001 = ps_keys_bak[1] AND prdm002 = ps_keys_bak[2] AND prdm004 = ps_keys_bak[3] #160905-00007#12 mark
         WHERE prdm001 = ps_keys_bak[1] AND prdm002 = ps_keys_bak[2] AND prdm004 = ps_keys_bak[3] AND prdment = g_enterprise  #160905-00007#12 add
 
      #add-point:update_b段修改中

      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdm_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdm_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
 
      #add-point:update_b段修改後

      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "prdn_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "prdn_t" THEN
   
      #add-point:update_b段修改前

      #end add-point    
      
      UPDATE prdn_t 
         SET (prdn001,prdn002,prdn003,prdn004
              ,prdnstus,prdnsite,prdnunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prdm2_d[g_detail_idx2].prdnstus,g_prdm2_d[g_detail_idx2].prdnsite,g_prdm2_d[g_detail_idx2].prdnunit)  
 
         #WHERE prdn001 = ps_keys_bak[1] AND prdn002 = ps_keys_bak[2] AND prdn003 = ps_keys_bak[3] AND prdn004 = ps_keys_bak[4] #160905-00007#12 mark
         WHERE prdn001 = ps_keys_bak[1] AND prdn002 = ps_keys_bak[2] AND prdn003 = ps_keys_bak[3] AND prdn004 = ps_keys_bak[4] AND prdnent = g_enterprise #160905-00007#12 add
 
      #add-point:update_b段修改中

      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "prdn_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prdn_t"
            LET g_errparam.popup = TRUE
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
 
{<section id="aprm211_01.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION aprm211_01_key_update_b()
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point
 
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.prdm001 <> g_master_t.prdm001 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.prdm002 <> g_master_t.prdm002 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.prdm004 <> g_master_t.prdm004 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前

   #end add-point
   
   #160905-00007#12-S
   #UPDATE prdn_t 
   #   SET (prdn001,prdn002) 
   #        = 
   #       (g_master.prdm001,g_master.prdm002) 
   #   WHERE 
   #        prdn001 = g_master_t.prdm001
   #        AND prdn002 = g_master_t.prdm002
    UPDATE prdn_t 
      SET (prdn001,prdn002) 
           = 
          (g_master.prdm001,g_master.prdm002) 
      WHERE 
           prdn001 = g_master_t.prdm001
           AND prdn002 = g_master_t.prdm002
           AND prdnent = g_enterprise
   #160905-00007#12-E
   
   #add-point:update_b段修改中

   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   CALL cl_err("prdn_t","std-00009",1)
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後

   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprm211_01_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL aprm211_01_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "prdm_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm211_01_bcl USING g_enterprise,
                                       g_prdm_d[g_detail_idx].prdm001,g_prdm_d[g_detail_idx].prdm002, 
                                           g_prdm_d[g_detail_idx].prdm004
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprm211_01_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "prdn_t,"
   #僅鎖定自身table
   LET ls_group = "prdn_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprm211_01_bcl2 USING g_enterprise,
                                             g_master.prdm001,g_master.prdm002,
                                             g_prdm2_d[g_detail_idx2].prdn003,g_prdm2_d[g_detail_idx2].prdn004 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprm211_01_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprm211_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aprm211_01_bcl
   END IF
   
 
    
   LET ls_group = "prdn_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aprm211_01_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION aprm211_01_idx_chk(ps_loc)
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prdm_d.getLength() THEN
         LET g_detail_idx = g_prdm_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdm_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_prdm_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_prdm2_d.getLength() THEN
         LET g_detail_idx2 = g_prdm2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_prdm2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_prdm2_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_prdm2_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_prdm2_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprm211_01.state_change" >}
    
 
{</section>}
 
{<section id="aprm211_01.func_signature" >}
   
 
{</section>}
 
{<section id="aprm211_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aprm211_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 對象組別檢查
# Memo...........:
# Usage..........: CALL aprm211_01_chk_prdn002
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_01_chk_prdn002()
DEFINE l_n           LIKE type_t.num5
#
#   LET g_errno = ""
#   LET l_n = 0
#   SELECT COUNT(*) INTO l_n
#     FROM prdm_t
#    WHERE prdment = g_enterprise
#      AND prdmdocno = g_prdmdocno
#      AND prdm002 = g_prdm2_d[l_ac].prdn002
#   IF l_n = 0 THEN
#      LET g_errno = 'apr-00093'
#   END IF
#   LET l_n = 0
#   SELECT COUNT(*) INTO l_n
#     FROM prdm_t
#    WHERE prdment = g_enterprise
#      AND prdmdocno = g_prdmdocno
#      AND prdm002 = g_prdm2_d[l_ac].prdn002
#      AND prdm003 <> '1'
#   IF l_n = 0 THEN
#      LET g_errno = 'apr-00094'
#   END IF
END FUNCTION
################################################################################
# Descriptions...: 屬性名稱帶值
# Memo...........:
# Usage..........: CALL aprm211_01_prdn_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_01_prdn_desc()
DEFINE l_oocq004      LIKE oocq_t.oocq004

   IF g_prdm_d[g_detail_idx].prdm003 = '2' THEN
      #150324-00004#1--mark by dongsz--str---
#      IF g_prdm2_d[l_ac].prdn003 = '1' THEN #会员等级
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
#         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
#         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
#      END IF
#      
#      IF g_prdm2_d[l_ac].prdn003 = '2' THEN #会员类型
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
#         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2025' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
#         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
#      END IF  
      #150324-00004#1--mark by dongsz--end---
      #150324-00004#1--add by dongsz--str---
      SELECT oocq004 INTO l_oocq004
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = '2049'
         AND oocq002 = g_prdm2_d[l_ac].prdn003
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_oocq004
      LET g_ref_fields[2] = g_prdm2_d[l_ac].prdn004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      #150324-00004#1--add by dongsz--end---
   END IF
   
   IF g_prdm_d[g_detail_idx].prdm003 = '3' THEN
      IF g_prdm2_d[l_ac].prdn003 = '1' THEN #客戶編號
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF
      
      IF g_prdm2_d[l_ac].prdn003 = '2' THEN #客戶分類
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF 
      
      IF g_prdm2_d[l_ac].prdn003 = '3' THEN 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2061' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF
      
      IF g_prdm2_d[l_ac].prdn003 = '4' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2062' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF     

      IF g_prdm2_d[l_ac].prdn003 = '5' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2063' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdm2_d[l_ac].prdn003 = '6' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2064' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdm2_d[l_ac].prdn003 = '7' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2065' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdm2_d[l_ac].prdn003 = '8' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2066' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdm2_d[l_ac].prdn003 = '9' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2067' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      
      IF g_prdm2_d[l_ac].prdn003 = '10' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2068' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdm2_d[l_ac].prdn003 = '11' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2069' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdm2_d[l_ac].prdn003 = '12' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdm2_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2070' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdm2_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdm2_d[l_ac].prdn004_desc
      END IF  
      
   END IF      
END FUNCTION

################################################################################
# Descriptions...: 顯示會員的對象屬性
# Memo...........:
# Usage..........: CALL aprm211_01_prdn003_display()
# Date & Author..: 20150326 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm211_01_prdn003_display()
DEFINE l_oocq002      LIKE oocq_t.oocq002
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE cb004          ui.ComboBox
   
   LET cb004 = ui.ComboBox.forName('prdn003')
   CALL cb004.clear()
   
   LET l_cnt = 0
   LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
               "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
               "  WHERE oocqent = ",g_enterprise," ",
               "    AND oocq001 = '2049' ",
               "    AND oocqstus = 'Y' ",
               "  ORDER BY oocq002 "
   PREPARE sel_oocq_pre FROM l_sql
   DECLARE sel_oocq_cs  CURSOR FOR sel_oocq_pre
   LET l_cnt = 1
   FOREACH sel_oocq_cs  INTO l_oocq002,l_oocql004
      LET l_oocql004 = l_oocq002,':',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION

 
{</section>}
 
