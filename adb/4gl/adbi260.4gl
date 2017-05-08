#該程式已解開Section, 不再透過樣板產出!
{<section id="adbi260.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:2,PR版次:2) Build-000069
#+ 
#+ Filename...: adbi260
#+ Description: 庫存組織出貨範圍設定作業
#+ Creator....: 02749(2014/07/11)
#+ Modifier...: 02749(2014/08/08) -SD/PR- 00000
#+ Buildtype..: 應用 t02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="adbi260.global" >}
#170120-00038#1   2017/01/23  By 06814       修正WHERE 條件沒下ent
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_inaa_d RECORD
       inaastus LIKE inaa_t.inaastus, 
   inaasite LIKE inaa_t.inaasite, 
   inaasite_desc LIKE type_t.chr500, 
   inaa001 LIKE inaa_t.inaa001, 
   inaa001_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_inaa2_d RECORD
       dbbdstus LIKE dbbd_t.dbbdstus, 
   dbbd002 LIKE dbbd_t.dbbd002, 
   dbbd003 LIKE dbbd_t.dbbd003, 
   dbbd003_desc LIKE type_t.chr80
       END RECORD
PRIVATE TYPE type_g_inaa3_d RECORD
       dbbd002 LIKE dbbd_t.dbbd002, 
   dbbd003 LIKE dbbd_t.dbbd003, 
   dbbdownid LIKE dbbd_t.dbbdownid, 
   dbbdownid_desc LIKE type_t.chr500, 
   dbbdowndp LIKE dbbd_t.dbbdowndp, 
   dbbdowndp_desc LIKE type_t.chr500, 
   dbbdcrtid LIKE dbbd_t.dbbdcrtid, 
   dbbdcrtid_desc LIKE type_t.chr500, 
   dbbdcrtdp LIKE dbbd_t.dbbdcrtdp, 
   dbbdcrtdp_desc LIKE type_t.chr500, 
   dbbdcrtdt DATETIME YEAR TO SECOND, 
   dbbdmodid LIKE dbbd_t.dbbdmodid, 
   dbbdmodid_desc LIKE type_t.chr500, 
   dbbdmoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_inaa4_d RECORD
       dbbestus LIKE dbbe_t.dbbestus, 
   dbbe002 LIKE dbbe_t.dbbe002, 
   dbbe002_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_inaa5_d RECORD
       dbbe002 LIKE dbbe_t.dbbe002, 
   dbbeownid LIKE dbbe_t.dbbeownid, 
   dbbeownid_desc LIKE type_t.chr500, 
   dbbeowndp LIKE dbbe_t.dbbeowndp, 
   dbbeowndp_desc LIKE type_t.chr500, 
   dbbecrtid LIKE dbbe_t.dbbecrtid, 
   dbbecrtid_desc LIKE type_t.chr500, 
   dbbecrtdp LIKE dbbe_t.dbbecrtdp, 
   dbbecrtdp_desc LIKE type_t.chr500, 
   dbbecrtdt DATETIME YEAR TO SECOND, 
   dbbemodid LIKE dbbe_t.dbbemodid, 
   dbbemodid_desc LIKE type_t.chr500, 
   dbbemoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_inaa6_d RECORD
       dbbfstus LIKE dbbf_t.dbbfstus, 
   dbbf002 LIKE dbbf_t.dbbf002, 
   dbbf003 LIKE dbbf_t.dbbf003, 
   dbbf003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_inaa7_d RECORD
       dbbf002 LIKE dbbf_t.dbbf002, 
   dbbf003 LIKE dbbf_t.dbbf003, 
   dbbfsite LIKE dbbf_t.dbbfsite, 
   dbbfownid LIKE dbbf_t.dbbfownid, 
   dbbfownid_desc LIKE type_t.chr500, 
   dbbfowndp LIKE dbbf_t.dbbfowndp, 
   dbbfowndp_desc LIKE type_t.chr500, 
   dbbfcrtid LIKE dbbf_t.dbbfcrtid, 
   dbbfcrtid_desc LIKE type_t.chr500, 
   dbbfcrtdp LIKE dbbf_t.dbbfcrtdp, 
   dbbfcrtdp_desc LIKE type_t.chr500, 
   dbbfcrtdt DATETIME YEAR TO SECOND, 
   dbbfmodid LIKE dbbf_t.dbbfmodid, 
   dbbfmodid_desc LIKE type_t.chr500, 
   dbbfmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      inayl001 LIKE inayl_t.inayl001,
      inayl002 LIKE inayl_t.inayl002,
      inaa001_desc LIKE inayl_t.inayl003
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_inaa_d
DEFINE g_master_t                   type_g_inaa_d
DEFINE g_inaa_d          DYNAMIC ARRAY OF type_g_inaa_d
DEFINE g_inaa_d_t        type_g_inaa_d
DEFINE g_inaa_d_o        type_g_inaa_d
DEFINE g_inaa2_d   DYNAMIC ARRAY OF type_g_inaa2_d
DEFINE g_inaa2_d_t type_g_inaa2_d
DEFINE g_inaa2_d_o type_g_inaa2_d
DEFINE g_inaa3_d   DYNAMIC ARRAY OF type_g_inaa3_d
DEFINE g_inaa3_d_t type_g_inaa3_d
DEFINE g_inaa3_d_o type_g_inaa3_d
DEFINE g_inaa4_d   DYNAMIC ARRAY OF type_g_inaa4_d
DEFINE g_inaa4_d_t type_g_inaa4_d
DEFINE g_inaa4_d_o type_g_inaa4_d
DEFINE g_inaa5_d   DYNAMIC ARRAY OF type_g_inaa5_d
DEFINE g_inaa5_d_t type_g_inaa5_d
DEFINE g_inaa5_d_o type_g_inaa5_d
DEFINE g_inaa6_d   DYNAMIC ARRAY OF type_g_inaa6_d
DEFINE g_inaa6_d_t type_g_inaa6_d
DEFINE g_inaa6_d_o type_g_inaa6_d
DEFINE g_inaa7_d   DYNAMIC ARRAY OF type_g_inaa7_d
DEFINE g_inaa7_d_t type_g_inaa7_d
DEFINE g_inaa7_d_o type_g_inaa7_d
 
      
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
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adbi260.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
 
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi260 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi260_init()   
 
      #進入選單 Menu (="N")
      CALL adbi260_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi260
      
   END IF 
   
   
   
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="adbi260.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi260_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show = 1
   
      CALL cl_set_combo_scc('dbbd002','6077') 
   CALL cl_set_combo_scc('dbbf002','6701') 
 
   LET l_ac = 1
   
   
   
   
   
   
   
 
   #避免USER直接進入第二單身時無資料
   IF g_inaa_d.getLength() > 0 THEN
      LET g_master_t.* = g_inaa_d[1].*
      LET g_master.* = g_inaa_d[1].*
   END IF
 
   #add-point:畫面資料初始化
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   LET g_errshow = 1
   CALL cl_set_combo_scc('dbbd002_3','6077') 
   CALL cl_set_combo_scc('dbbf002_7','6701')    
   #end add-point
   
   CALL adbi260_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi260.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi260_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num5
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
   
      CALL adbi260_b_fill(g_wc)
   
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
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               CALL adbi260_fetch()
               CALL adbi260_idx_chk('m')
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
   CALL adbi260_set_pk_array()
   #add-point:ON ACTION agendum
   LET g_loc = 'd'
   CALL adbi260_detail_show()
   LET g_loc = 'm'
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_inaa2_d TO s_detail2.*
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
               CALL adbi260_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
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
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL adbi260_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         DISPLAY ARRAY g_inaa4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 4
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               CALL adbi260_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_4)
            
               
         END DISPLAY
         DISPLAY ARRAY g_inaa5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 5
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               CALL adbi260_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_5)
            
               
         END DISPLAY
         DISPLAY ARRAY g_inaa6_d TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 6
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx2
               CALL adbi260_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_6)
            
               
         END DISPLAY
         DISPLAY ARRAY g_inaa7_d TO s_detail7.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 7
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx2
               CALL adbi260_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_7)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
    
         BEFORE DIALOG
            CALL cl_set_act_visible("insert,delete,reproduce",FALSE)   #unstrandard：新增/刪除/複製,按鈕失效並灰階顯示
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
            NEXT FIELD CURRENT
         
         AFTER DIALOG
            #add-point:ui_dialog段after dialog

            #end add-point
         
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adbi260_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi260_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
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
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbi260_query()
               #add-point:ON ACTION query

               #END add-point
               #此段落由子樣板a59產生  
               CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
            END IF
 
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
               LET g_export_node[4] = base.typeInfo.create(g_inaa4_d)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_inaa5_d)
               LET g_export_id[5]   = "s_detail5"
               LET g_export_node[6] = base.typeInfo.create(g_inaa6_d)
               LET g_export_id[6]   = "s_detail6"
               LET g_export_node[7] = base.typeInfo.create(g_inaa7_d)
               LET g_export_id[7]   = "s_detail7"
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            EXIT DIALOG
         
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
           
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL adbi260_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbi260_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbi260_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi260_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_inaa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON inaastus,inaasite,inaa001,inaa001_desc
           FROM s_detail1[1].inaastus,s_detail1[1].inaasite,s_detail1[1].inaa001,s_detail1[1].inaa001_desc 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<inaacrtdt>>----
         
         #----<<inaamoddt>>----
         
         #----<<inaacnfdt>>----
         
         #----<<inaapstdt>>----
 
 
         
       #單身一般欄位開窗相關處理
                #此段落由子樣板a01產生
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.inaastus
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus
            
            #END add-point
 
         #Ctrlp:construct.c.page1.inaasite
         ON ACTION controlp INFIELD inaasite
            #add-point:ON ACTION controlp INFIELD inaasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inaasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO inaasite          #顯示到畫面上
            NEXT FIELD inaasite                             #返回原欄位  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD inaasite
            #add-point:BEFORE FIELD inaasite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD inaasite
            
            #add-point:AFTER FIELD inaasite
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.inaa001
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上
            NEXT FIELD inaa001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD inaa001_desc
            #add-point:BEFORE FIELD inaa001_desc
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD inaa001_desc
            
            #add-point:AFTER FIELD inaa001_desc
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.inaa001_desc
         ON ACTION controlp INFIELD inaa001_desc
            #add-point:ON ACTION controlp INFIELD inaa001_desc
            
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON dbbdstus,dbbd002,dbbd003,dbbd003_desc,dbbdownid,dbbdowndp,dbbdcrtid, 
          dbbdcrtdp,dbbdcrtdt,dbbdmodid,dbbdmoddt
           FROM s_detail2[1].dbbdstus,s_detail2[1].dbbd002,s_detail2[1].dbbd003,s_detail2[1].dbbd003_desc, 
               s_detail3[1].dbbdownid,s_detail3[1].dbbdowndp,s_detail3[1].dbbdcrtid,s_detail3[1].dbbdcrtdp, 
               s_detail3[1].dbbdcrtdt,s_detail3[1].dbbdmodid,s_detail3[1].dbbdmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<dbbdcrtdt>>----
         AFTER FIELD dbbdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbdmoddt>>----
         AFTER FIELD dbbdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbdcnfdt>>----
         
         #----<<dbbdpstdt>>----
 
 
       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD dbbdstus
            #add-point:BEFORE FIELD dbbdstus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdstus
            
            #add-point:AFTER FIELD dbbdstus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dbbdstus
         ON ACTION controlp INFIELD dbbdstus
            #add-point:ON ACTION controlp INFIELD dbbdstus
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbd002
            #add-point:BEFORE FIELD dbbd002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbd002
            
            #add-point:AFTER FIELD dbbd002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dbbd002
         ON ACTION controlp INFIELD dbbd002
            #add-point:ON ACTION controlp INFIELD dbbd002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbd003
            #add-point:BEFORE FIELD dbbd003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbd003
            
            #add-point:AFTER FIELD dbbd003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dbbd003
         ON ACTION controlp INFIELD dbbd003
            #add-point:ON ACTION controlp INFIELD dbbd003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbd003_desc
            #add-point:BEFORE FIELD dbbd003_desc
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbd003_desc
            
            #add-point:AFTER FIELD dbbd003_desc
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dbbd003_desc
         ON ACTION controlp INFIELD dbbd003_desc
            #add-point:ON ACTION controlp INFIELD dbbd003_desc
            
            #END add-point
 
         #Ctrlp:construct.c.page3.dbbdownid
         ON ACTION controlp INFIELD dbbdownid
            #add-point:ON ACTION controlp INFIELD dbbdownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbdownid  #顯示到畫面上
            NEXT FIELD dbbdownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdownid
            #add-point:BEFORE FIELD dbbdownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdownid
            
            #add-point:AFTER FIELD dbbdownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.dbbdowndp
         ON ACTION controlp INFIELD dbbdowndp
            #add-point:ON ACTION controlp INFIELD dbbdowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbdowndp  #顯示到畫面上
            NEXT FIELD dbbdowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdowndp
            #add-point:BEFORE FIELD dbbdowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdowndp
            
            #add-point:AFTER FIELD dbbdowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.dbbdcrtid
         ON ACTION controlp INFIELD dbbdcrtid
            #add-point:ON ACTION controlp INFIELD dbbdcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbdcrtid  #顯示到畫面上
            NEXT FIELD dbbdcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdcrtid
            #add-point:BEFORE FIELD dbbdcrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdcrtid
            
            #add-point:AFTER FIELD dbbdcrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.dbbdcrtdp
         ON ACTION controlp INFIELD dbbdcrtdp
            #add-point:ON ACTION controlp INFIELD dbbdcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbdcrtdp  #顯示到畫面上
            NEXT FIELD dbbdcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdcrtdp
            #add-point:BEFORE FIELD dbbdcrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdcrtdp
            
            #add-point:AFTER FIELD dbbdcrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdcrtdt
            #add-point:BEFORE FIELD dbbdcrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.page3.dbbdmodid
         ON ACTION controlp INFIELD dbbdmodid
            #add-point:ON ACTION controlp INFIELD dbbdmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbdmodid  #顯示到畫面上
            NEXT FIELD dbbdmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdmodid
            #add-point:BEFORE FIELD dbbdmodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdmodid
            
            #add-point:AFTER FIELD dbbdmodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbdmoddt
            #add-point:BEFORE FIELD dbbdmoddt
            
            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON dbbestus,dbbe002,dbbeownid,dbbeowndp,dbbecrtid,dbbecrtdp,dbbecrtdt,dbbemodid, 
          dbbemoddt
           FROM s_detail4[1].dbbestus,s_detail4[1].dbbe002,s_detail5[1].dbbeownid,s_detail5[1].dbbeowndp, 
               s_detail5[1].dbbecrtid,s_detail5[1].dbbecrtdp,s_detail5[1].dbbecrtdt,s_detail5[1].dbbemodid, 
               s_detail5[1].dbbemoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<dbbecrtdt>>----
         AFTER FIELD dbbecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbemoddt>>----
         AFTER FIELD dbbemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbecnfdt>>----
         
         #----<<dbbepstdt>>----
 
 
       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD dbbestus
            #add-point:BEFORE FIELD dbbestus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbestus
            
            #add-point:AFTER FIELD dbbestus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page4.dbbestus
         ON ACTION controlp INFIELD dbbestus
            #add-point:ON ACTION controlp INFIELD dbbestus
            
            #END add-point
 
         #Ctrlp:construct.c.page4.dbbe002
         ON ACTION controlp INFIELD dbbe002
            #add-point:ON ACTION controlp INFIELD dbbe002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbe002  #顯示到畫面上
            NEXT FIELD dbbe002                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbe002
            #add-point:BEFORE FIELD dbbe002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbe002
            
            #add-point:AFTER FIELD dbbe002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page5.dbbeownid
         ON ACTION controlp INFIELD dbbeownid
            #add-point:ON ACTION controlp INFIELD dbbeownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbeownid  #顯示到畫面上
            NEXT FIELD dbbeownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbeownid
            #add-point:BEFORE FIELD dbbeownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbeownid
            
            #add-point:AFTER FIELD dbbeownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page5.dbbeowndp
         ON ACTION controlp INFIELD dbbeowndp
            #add-point:ON ACTION controlp INFIELD dbbeowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbeowndp  #顯示到畫面上
            NEXT FIELD dbbeowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbeowndp
            #add-point:BEFORE FIELD dbbeowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbeowndp
            
            #add-point:AFTER FIELD dbbeowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.page5.dbbecrtid
         ON ACTION controlp INFIELD dbbecrtid
            #add-point:ON ACTION controlp INFIELD dbbecrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbecrtid  #顯示到畫面上
            NEXT FIELD dbbecrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbecrtid
            #add-point:BEFORE FIELD dbbecrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbecrtid
            
            #add-point:AFTER FIELD dbbecrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page5.dbbecrtdp
         ON ACTION controlp INFIELD dbbecrtdp
            #add-point:ON ACTION controlp INFIELD dbbecrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbecrtdp  #顯示到畫面上
            NEXT FIELD dbbecrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbecrtdp
            #add-point:BEFORE FIELD dbbecrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbecrtdp
            
            #add-point:AFTER FIELD dbbecrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbecrtdt
            #add-point:BEFORE FIELD dbbecrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.page5.dbbemodid
         ON ACTION controlp INFIELD dbbemodid
            #add-point:ON ACTION controlp INFIELD dbbemodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbemodid  #顯示到畫面上
            NEXT FIELD dbbemodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbemodid
            #add-point:BEFORE FIELD dbbemodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbemodid
            
            #add-point:AFTER FIELD dbbemodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbemoddt
            #add-point:BEFORE FIELD dbbemoddt
            
            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON dbbfstus,dbbf002,dbbf003,dbbfownid,dbbfowndp,dbbfcrtid,dbbfcrtdp,dbbfcrtdt, 
          dbbfmodid,dbbfmoddt
           FROM s_detail6[1].dbbfstus,s_detail6[1].dbbf002,s_detail6[1].dbbf003,s_detail7[1].dbbfownid, 
               s_detail7[1].dbbfowndp,s_detail7[1].dbbfcrtid,s_detail7[1].dbbfcrtdp,s_detail7[1].dbbfcrtdt, 
               s_detail7[1].dbbfmodid,s_detail7[1].dbbfmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<dbbfcrtdt>>----
         AFTER FIELD dbbfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbfmoddt>>----
         AFTER FIELD dbbfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbfcnfdt>>----
         
         #----<<dbbfpstdt>>----
 
 
       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD dbbfstus
            #add-point:BEFORE FIELD dbbfstus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfstus
            
            #add-point:AFTER FIELD dbbfstus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page6.dbbfstus
         ON ACTION controlp INFIELD dbbfstus
            #add-point:ON ACTION controlp INFIELD dbbfstus
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbf002
            #add-point:BEFORE FIELD dbbf002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbf002
            
            #add-point:AFTER FIELD dbbf002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page6.dbbf002
         ON ACTION controlp INFIELD dbbf002
            #add-point:ON ACTION controlp INFIELD dbbf002
            
            #END add-point
 
         #Ctrlp:construct.c.page6.dbbf003
         ON ACTION controlp INFIELD dbbf003
            #add-point:ON ACTION controlp INFIELD dbbf003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbf003  #顯示到畫面上
            NEXT FIELD dbbf003                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbf003
            #add-point:BEFORE FIELD dbbf003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbf003
            
            #add-point:AFTER FIELD dbbf003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page7.dbbfownid
         ON ACTION controlp INFIELD dbbfownid
            #add-point:ON ACTION controlp INFIELD dbbfownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbfownid  #顯示到畫面上
            NEXT FIELD dbbfownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfownid
            #add-point:BEFORE FIELD dbbfownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfownid
            
            #add-point:AFTER FIELD dbbfownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page7.dbbfowndp
         ON ACTION controlp INFIELD dbbfowndp
            #add-point:ON ACTION controlp INFIELD dbbfowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbfowndp  #顯示到畫面上
            NEXT FIELD dbbfowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfowndp
            #add-point:BEFORE FIELD dbbfowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfowndp
            
            #add-point:AFTER FIELD dbbfowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.page7.dbbfcrtid
         ON ACTION controlp INFIELD dbbfcrtid
            #add-point:ON ACTION controlp INFIELD dbbfcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbfcrtid  #顯示到畫面上
            NEXT FIELD dbbfcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfcrtid
            #add-point:BEFORE FIELD dbbfcrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfcrtid
            
            #add-point:AFTER FIELD dbbfcrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page7.dbbfcrtdp
         ON ACTION controlp INFIELD dbbfcrtdp
            #add-point:ON ACTION controlp INFIELD dbbfcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbfcrtdp  #顯示到畫面上
            NEXT FIELD dbbfcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfcrtdp
            #add-point:BEFORE FIELD dbbfcrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfcrtdp
            
            #add-point:AFTER FIELD dbbfcrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfcrtdt
            #add-point:BEFORE FIELD dbbfcrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.page7.dbbfmodid
         ON ACTION controlp INFIELD dbbfmodid
            #add-point:ON ACTION controlp INFIELD dbbfmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbfmodid  #顯示到畫面上
            NEXT FIELD dbbfmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfmodid
            #add-point:BEFORE FIELD dbbfmodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfmodid
            
            #add-point:AFTER FIELD dbbfmodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbfmoddt
            #add-point:BEFORE FIELD dbbfmoddt
            
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
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
              , " AND ", g_wc2_table3
 
              , " AND ", g_wc2_table4
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
               , " AND ", g_wc2_table3
 
               , " AND ", g_wc2_table4
 
 
        
   #add-point:cs段after_construct
   
   #end add-point
   
   LET g_error_show = 1
   CALL adbi260_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL adbi260_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="adbi260.insert" >}
#+ 資料修改
PRIVATE FUNCTION adbi260_insert()
   #add-point:insert段define
   
   #end add-point 
 
   #add-point:insert段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL g_inaa_d.clear() 
   CALL g_inaa2_d.clear() 
   CALL g_inaa3_d.clear() 
   CALL g_inaa4_d.clear() 
   CALL g_inaa5_d.clear() 
   CALL g_inaa6_d.clear() 
   CALL g_inaa7_d.clear() 
 
   CALL adbi260_input('a')
   
   CALL adbi260_b_fill(g_wc)
   
   #add-point:insert段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.modify" >}
#+ 資料新增
PRIVATE FUNCTION adbi260_modify()
   #add-point:modify段define
   
   #end add-point 
 
   #add-point:modify段新增前
   
   #end add-point 
   
   #進入資料輸入段落
   CALL adbi260_input('u')
   
   #add-point:modify段新增後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi260_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define
   
   #end add-point 
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_inaa_d_t.* = g_inaa_d[li_ac].*
   LET g_inaa_d_o.* = g_inaa_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前
 
#   #end add-point 
#   
#   #刪除單頭
#   DELETE FROM inaa_t 
#         WHERE inaasite = g_inaa_d_t.inaasite
#           AND inaa001 = g_inaa_d_t.inaa001
# 
#           
#   #add-point:delete段刪除中
   #160905-00003#4 160905 by lori add---(S)
   #ENT過濾條件
   DELETE FROM inaa_t 
         WHERE inaaent = g_enterprise
           AND inaasite = g_inaa_d_t.inaasite
           AND inaa001 = g_inaa_d_t.inaa001
   #160905-00003#4 160905 by lori add---(E)        
   #end add-point 
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "inaa_t" 
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
 
#   #end add-point 
#   DELETE FROM dbbd_t 
#         WHERE dbbdsite = g_inaa_d_t.inaasite
#           AND dbbd001 = g_inaa_d_t.inaa001
# 
#   #add-point:delete段刪除中
   #160905-00003#4 160905 by lori add---(S)
   #ENT過濾條件
   DELETE FROM dbbd_t 
         WHERE dbdent = g_enterprise
           AND dbbdsite = g_inaa_d_t.inaasite
           AND dbbd001 = g_inaa_d_t.inaa001   
   #160905-00003#4 160905 by lori add---()
   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbbd_t" 
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
 
   #add-point:delete段刪除前
 
#   #end add-point 
#   DELETE FROM dbbd_t 
#         WHERE dbbesite = g_inaa_d_t.inaasite
#           AND dbbe001 = g_inaa_d_t.inaa001
# 
#   #add-point:delete段刪除中
   #160905-00003#4 160905 by lori add---(S)
   #ENT過濾條件
   DELETE FROM dbbe_t 
         WHERE dbbeent = g_enterprise
           AND dbbesite = g_inaa_d_t.inaasite
           AND dbbe001 = g_inaa_d_t.inaa001
   #160905-00003#4 160905 by lori add---(E)
   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbbd_t" 
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
 
   #add-point:delete段刪除前
 
#   #end add-point 
#   DELETE FROM dbbe_t 
#         WHERE dbbfsite = g_inaa_d_t.inaasite
#           AND dbbf001 = g_inaa_d_t.inaa001
# 
#   #add-point:delete段刪除中
   #160905-00003#4 160905 by lori add---(S)
   #ENT過濾條件
   DELETE FROM dbbf_t 
         WHERE dbbfent = g_enterprise
           AND dbbfsite = g_inaa_d_t.inaasite
           AND dbbf001 = g_inaa_d_t.inaa001
   #160905-00003#4 160905 by lori add---(E)
   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbbe_t" 
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
 
{<section id="adbi260.input" >}
#+ 資料輸入
PRIVATE FUNCTION adbi260_input(p_cmd)
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
   DEFINE  l_acc_code            LIKE oocq_t.oocq001
   DEFINE  l_imaal004            LIKE imaal_t.imaal004
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT inaastus,inaasite,inaa001 FROM inaa_t WHERE inaaent=? AND inaa001=? FOR  
       UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi260_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT dbbdstus,dbbd002,dbbd003,dbbd002,dbbd003,dbbdownid,dbbdowndp,dbbdcrtid, 
       dbbdcrtdp,dbbdcrtdt,dbbdmodid,dbbdmoddt FROM dbbd_t WHERE dbbdent=? AND dbbdsite=? AND dbbd001=?  
       AND dbbd002=? AND dbbd003=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi260_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT dbbestus,dbbe002,dbbe002,dbbeownid,dbbeowndp,dbbecrtid,dbbecrtdp,dbbecrtdt, 
       dbbemodid,dbbemoddt FROM dbbe_t WHERE dbbeent=? AND dbbesite=? AND dbbe001=? AND dbbe002=? FOR  
       UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi260_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT dbbfstus,dbbf002,dbbf003,dbbf002,dbbf003,dbbfsite,dbbfownid,dbbfowndp, 
       dbbfcrtid,dbbfcrtdp,dbbfcrtdt,dbbfmodid,dbbfmoddt FROM dbbf_t WHERE dbbfent=? AND dbbfsite=?  
       AND dbbf001=? AND dbbf002=? AND dbbf003=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi260_bcl4 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   
   #add-point:input段修改前

   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
#Modify Begin-----
#註：因資料階層與規格關係,需改成DISPLAY(inaa_t Display Only,But s_detail1 not support)
       DISPLAY ARRAY g_inaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
             LET g_master.* = g_inaa_d[g_detail_idx].*
             CALL cl_show_fld_cont()
             CALL adbi260_fetch()
             CALL adbi260_idx_chk('m')
             CALL adbi260_set_pk_array()
             CALL cl_user_overview_set_follow_pic()
       END DISPLAY
#Modify End-----
 
#Standard Begin------
#
#      #Page1 預設值產生於此處
#      INPUT ARRAY g_inaa_d FROM s_detail1.*
#          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                  INSERT ROW = l_allow_insert,
#                  DELETE ROW = l_allow_delete,
#                  APPEND ROW = l_allow_insert)
# 
#         #自訂ACTION(detail_input,page_1)
#         
# 
#         #+ 此段落由子樣板a43產生
#         ON ACTION update_item
#            LET g_action_choice="update_item"
#            IF cl_auth_chk_act("update_item") THEN
#               
#               #add-point:ON ACTION update_item

#               #END add-point
#            END IF
# 
# 
#         
#         BEFORE INPUT
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_inaa_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            LET g_current_page = 1
#            IF p_cmd = 'u' THEN
#               CALL adbi260_b_fill(g_wc)
#            END IF
#            LET g_loc = 'm'
#            LET g_detail_cnt = g_inaa_d.getLength()
#            #add-point:資料輸入前

#            #end add-point
#            
#         BEFORE ROW
#            LET l_cmd = ''
#            LET l_ac = ARR_CURR()
#            LET g_detail_idx = l_ac
#            LET g_master_t.* = g_inaa_d[l_ac].*
#            LET g_master.* = g_inaa_d[l_ac].*
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            LET g_detail_idx = l_ac
#         
#            CALL s_transaction_begin()
#            LET g_detail_cnt = g_inaa_d.getLength()
#            
#            IF g_detail_cnt >= l_ac 
#               AND g_inaa_d[l_ac].inaasite IS NOT NULL
#               AND g_inaa_d[l_ac].inaa001 IS NOT NULL
# 
#            THEN
#               LET l_cmd='u'
#               LET g_inaa_d_t.* = g_inaa_d[l_ac].*  #BACKUP
#               LET g_inaa_d_o.* = g_inaa_d[l_ac].*  #BACKUP
#               IF NOT adbi260_lock_b("inaa_t") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH adbi260_bcl INTO g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001 
#
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_inaa_d_t.inaasite 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     LET l_lock_sw = "Y"
#                  END IF
#                  CALL cl_show_fld_cont()
#                  #CALL adbi260_detail_show()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            CALL adbi260_set_entry_b(l_cmd)
#            CALL adbi260_set_no_entry_b(l_cmd)
#            #add-point:input段before row

#            #end add-point  
#            #其他table資料備份(確定是否更改用)
#            
#            #其他table進行lock
#            
#            #讀取對應的單身資料
#            CALL adbi260_fetch()
#            CALL adbi260_idx_chk('m')
# 
#         BEFORE INSERT
#            
#            #判斷能否在此頁面進行資料新增
#            
#            #清空下層單身
#                        CALL g_inaa2_d.clear()
#            CALL g_inaa3_d.clear()
#            CALL g_inaa4_d.clear()
#            CALL g_inaa5_d.clear()
#            CALL g_inaa6_d.clear()
#            CALL g_inaa7_d.clear()
# 
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_inaa_d[l_ac].* TO NULL 
#            INITIALIZE g_inaa_d_t.* TO NULL 
#            INITIALIZE g_inaa_d_o.* TO NULL 
#            #公用欄位給值(單身)
#            #此段落由子樣板a14產生    
#      #公用欄位新增給值
#      LET g_inaa_d[l_ac].inaastus = ""
# 
# 
#                  LET g_inaa_d[l_ac].inaastus = "Y"
# 
#            #add-point:modify段before備份

#            #end add-point
#            LET g_inaa_d_t.* = g_inaa_d[l_ac].*     #新輸入資料
#            LET g_inaa_d_o.* = g_inaa_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL adbi260_set_entry_b("a")
#            CALL adbi260_set_no_entry_b("a")
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_inaa_d[li_reproduce_target].* = g_inaa_d[li_reproduce].*
# 
#               LET g_inaa_d[g_inaa_d.getLength()].inaasite = NULL
#               LET g_inaa_d[g_inaa_d.getLength()].inaa001 = NULL
# 
#            END IF
#            #add-point:input段before insert

#            #end add-point  
#  
#         AFTER INSERT
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
# 
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#            
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM inaa_t 
#             WHERE inaaent = g_enterprise AND inaasite = g_inaa_d[l_ac].inaasite 
#                                       AND inaa001 = g_inaa_d[l_ac].inaa001 
# 
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身新增前

#               #end add-point
#            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
#               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
#               CALL adbi260_insert_b('inaa_t',gs_keys,"'1'")
#                           
#               #add-point:單身新增後

#               #end add-point
#            ELSE    
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               INITIALIZE g_inaa_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "inaa_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#               #CALL adbi260_b_fill(g_wc)
#               #資料多語言用-增/改
#               
#               #add-point:input段-after_insert

#               #end add-point
#               CALL s_transaction_end('Y','0')
#               ERROR 'INSERT O.K'
#               LET g_detail_cnt = g_detail_cnt + 1
#               LET g_master.* = g_inaa_d[l_ac].*
#            END IF
#              
#         BEFORE DELETE  #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   =  -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身刪除前

#               #end add-point
#               
#               DELETE FROM inaa_t
#                WHERE inaaent = g_enterprise AND 
#                      inaasite = g_inaa_d_t.inaasite
#                      AND inaa001 = g_inaa_d_t.inaa001
# 
#                      
#               #add-point:單身刪除中

#               #end add-point
#                      
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "inaa_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_detail_cnt = g_detail_cnt-1
#                  
#                  #add-point:單身刪除後

#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE adbi260_bcl
#               LET l_count = g_inaa_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
#               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
#    
#               #+ 此段落由子樣板a47產生
#      #刪除相關文件
#      CALL adbi260_set_pk_array()
#      #add-point:相關文件刪除前

#      #end add-point   
#      CALL cl_doc_remove()  
# 
#        
#            END IF 
#              
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身刪除後2

#               #end add-point
#                              CALL adbi260_delete_b('inaa_t',gs_keys,"'1'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_inaa_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
# 
#                  #此段落由子樣板a01產生
#         BEFORE FIELD inaastus
#            #add-point:BEFORE FIELD inaastus

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD inaastus
#            
#            #add-point:AFTER FIELD inaastus

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE inaastus
#            #add-point:ON CHANGE inaastus

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD inaasite
#            
#            #add-point:AFTER FIELD inaasite
#            #此段落由子樣板a05產生
#            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d_t.inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d_t.inaa001)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inaa_t WHERE "||"inaaent = '" ||g_enterprise|| "' AND "||"inaasite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "inaa001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#
#
#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD inaasite
#            #add-point:BEFORE FIELD inaasite

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE inaasite
#            #add-point:ON CHANGE inaasite

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD inaa001
#            #add-point:BEFORE FIELD inaa001

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD inaa001
#            
#            #add-point:AFTER FIELD inaa001
#            #此段落由子樣板a05產生
#            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d_t.inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d_t.inaa001)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inaa_t WHERE "||"inaaent = '" ||g_enterprise|| "' AND "||"inaasite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "inaa001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#
#
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE inaa001
#            #add-point:ON CHANGE inaa001

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD inaa001_desc
#            #add-point:BEFORE FIELD inaa001_desc

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD inaa001_desc
#            
#            #add-point:AFTER FIELD inaa001_desc

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE inaa001_desc
#            #add-point:ON CHANGE inaa001_desc

#            #END add-point
# 
# 
#                  #Ctrlp:input.c.page1.inaastus
#         ON ACTION controlp INFIELD inaastus
#            #add-point:ON ACTION controlp INFIELD inaastus

#            #END add-point
# 
#         #Ctrlp:input.c.page1.inaasite
#         ON ACTION controlp INFIELD inaasite
#            #add-point:ON ACTION controlp INFIELD inaasite
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_inaa_d[l_ac].inaasite             #給予default值
#            LET g_qryparam.default2 = "" #g_inaa_d[l_ac].ooefl003 #說明(簡稱)
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#            LET g_qryparam.arg2 = "" #
#            
#            CALL q_ooed004()                                #呼叫開窗
#
#            LET g_inaa_d[l_ac].inaasite = g_qryparam.return1              
#            #LET g_inaa_d[l_ac].ooefl003 = g_qryparam.return2 
#            DISPLAY g_inaa_d[l_ac].inaasite TO inaasite              #
#            #DISPLAY g_inaa_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
#            NEXT FIELD inaasite                          #返回原欄位
#
#
#            #END add-point
# 
#         #Ctrlp:input.c.page1.inaa001
#         ON ACTION controlp INFIELD inaa001
#            #add-point:ON ACTION controlp INFIELD inaa001

#            #END add-point
# 
#         #Ctrlp:input.c.page1.inaa001_desc
#         ON ACTION controlp INFIELD inaa001_desc
#            #add-point:ON ACTION controlp INFIELD inaa001_desc

#            #END add-point
# 
# 
# 
#         ON ROW CHANGE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
# 
#               LET INT_FLAG = 0
#               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
#               CLOSE adbi260_bcl
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#              
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = g_inaa_d[l_ac].inaasite 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
#            ELSE
#               
#               #寫入修改者/修改日期資訊(單身)
# 
#               
#               #add-point:單身修改前

#               #end add-point
#               
#               UPDATE inaa_t SET (inaastus,inaasite,inaa001) = (g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaasite, 
#                   g_inaa_d[l_ac].inaa001)
#                WHERE inaaent = g_enterprise AND
#                  inaasite = g_inaa_d_t.inaasite #項次   
#                  AND inaa001 = g_inaa_d_t.inaa001  
# 
#                  
#               #add-point:單身修改中

#               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "inaa_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CALL s_transaction_end('N','0')
#                     LET g_inaa_d[l_ac].* = g_inaa_d_t.*
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "inaa_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CALL s_transaction_end('N','0')
#                     LET g_inaa_d[l_ac].* = g_inaa_d_t.*
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
#               LET gs_keys_bak[1] = g_inaa_d_t.inaasite
#               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
#               LET gs_keys_bak[2] = g_inaa_d_t.inaa001
#               CALL adbi260_update_b('inaa_t',gs_keys,gs_keys_bak,"'1'")
#                     #資料多語言用-增/改
#                     
#                     
#                     LET g_log1 = util.JSON.stringify(g_inaa_d_t)
#                     LET g_log2 = util.JSON.stringify(g_inaa_d[l_ac])
#                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                        CALL s_transaction_end('N','0')
#                     END IF
#               END CASE
#               
#               #若Key欄位有變動
#               LET g_master.* = g_inaa_d[l_ac].*
#               CALL adbi260_key_update_b()
#               
#               #add-point:單身修改後

#               #end add-point
# 
#            END IF
#            
#         AFTER ROW
#            CALL adbi260_unlock_b("inaa_t")
#            CALL s_transaction_end('Y','0')
#            #其他table進行unlock
#            
#              
#         AFTER INPUT
#            #add-point:input段after input 

#            #end add-point   
#              
#         ON ACTION controlo   
#            CALL FGL_SET_ARR_CURR(g_inaa_d.getLength()+1)
#            LET lb_reproduce = TRUE
#            LET li_reproduce = l_ac
#            LET li_reproduce_target = g_inaa_d.getLength()+1
#              
#      END INPUT
#Standard End-----       
 
      
      #實際單身段落
      INPUT ARRAY g_inaa2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
 
         #+ 此段落由子樣板a43產生
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item

               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inaa2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_inaa2_d.getLength()
            LET g_current_page = 2
            #add-point:資料輸入前

            #end add-point
 
         BEFORE INSERT
            IF g_inaa_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'std-00013' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD inaasite
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inaa2_d[l_ac].* TO NULL 
            INITIALIZE g_inaa2_d_t.* TO NULL 
            INITIALIZE g_inaa2_d_o.* TO NULL 
                  LET g_inaa2_d[l_ac].dbbdstus = "Y"
      LET g_inaa2_d[l_ac].dbbd002 = "1"
 
            #add-point:modify段before備份
            LET g_inaa3_d[l_ac].dbbdownid = g_user
            LET g_inaa3_d[l_ac].dbbdowndp = g_dept
            LET g_inaa3_d[l_ac].dbbdcrtid = g_user
            LET g_inaa3_d[l_ac].dbbdcrtdp = g_dept 
            LET g_inaa3_d[l_ac].dbbdcrtdt = cl_get_current()
            LET g_inaa3_d[l_ac].dbbdmodid = ""
            LET g_inaa3_d[l_ac].dbbdmoddt = ""
            #end add-point
            LET g_inaa2_d_t.* = g_inaa2_d[l_ac].*     #新輸入資料
            LET g_inaa2_d_o.* = g_inaa2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi260_set_entry_b("a")
            CALL adbi260_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inaa2_d[li_reproduce_target].* = g_inaa2_d[li_reproduce].*
               LET g_inaa3_d[li_reproduce_target].* = g_inaa3_d[li_reproduce].*
 
               LET g_inaa2_d[li_reproduce_target].dbbd002 = NULL
               LET g_inaa2_d[li_reproduce_target].dbbd003 = NULL
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
            LET g_detail_cnt = g_inaa2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inaa2_d[l_ac].dbbd002 IS NOT NULL
               AND g_inaa2_d[l_ac].dbbd003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_inaa2_d_t.* = g_inaa2_d[l_ac].*  #BACKUP
               LET g_inaa2_d_o.* = g_inaa2_d[l_ac].*  #BACKUP
               IF NOT adbi260_lock_b("dbbd_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi260_bcl2 INTO g_inaa2_d[l_ac].dbbdstus,g_inaa2_d[l_ac].dbbd002,g_inaa2_d[l_ac].dbbd003, 
                      g_inaa3_d[l_ac].dbbd002,g_inaa3_d[l_ac].dbbd003,g_inaa3_d[l_ac].dbbdownid,g_inaa3_d[l_ac].dbbdowndp, 
                      g_inaa3_d[l_ac].dbbdcrtid,g_inaa3_d[l_ac].dbbdcrtdp,g_inaa3_d[l_ac].dbbdcrtdt, 
                      g_inaa3_d[l_ac].dbbdmodid,g_inaa3_d[l_ac].dbbdmoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL adbi260_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi260_set_entry_b(l_cmd)
            CALL adbi260_set_no_entry_b(l_cmd)
            #add-point:input段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL adbi260_idx_chk('d')
            
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
               
               DELETE FROM dbbd_t
                WHERE dbbdent = g_enterprise AND
                   dbbdsite = g_master.inaasite
                   AND dbbd001 = g_master.inaa001
                   AND dbbd002 = g_inaa2_d_t.dbbd002
                   AND dbbd003 = g_inaa2_d_t.dbbd003
                   
               #add-point:單身2刪除中

               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaa_t" 
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
               CLOSE adbi260_bcl
               LET l_count = g_inaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa2_d[g_detail_idx2].dbbd002
               LET gs_keys[4] = g_inaa2_d[g_detail_idx2].dbbd003
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
                              CALL adbi260_delete_b('dbbd_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inaa2_d.getLength() + 1) THEN
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
            SELECT COUNT(*) INTO l_count FROM dbbd_t 
             WHERE dbbdent = g_enterprise AND
                   dbbdsite = g_master.inaasite
                   AND dbbd001 = g_master.inaa001
                   AND dbbd002 = g_inaa2_d[g_detail_idx2].dbbd002
                   AND dbbd003 = g_inaa2_d[g_detail_idx2].dbbd003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa2_d[g_detail_idx2].dbbd002
               LET gs_keys[4] = g_inaa2_d[g_detail_idx2].dbbd003
               CALL adbi260_insert_b('dbbd_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_inaa_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbbd_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi260_b_fill(g_wc)
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
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_inaa2_d[l_ac].* = g_inaa2_d_t.*
               CLOSE adbi260_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_inaa2_d[l_ac].* = g_inaa2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身2)
               LET g_inaa3_d[l_ac].dbbdmodid = g_user 
LET g_inaa3_d[l_ac].dbbdmoddt = cl_get_current()
 
               
               #add-point:單身page2修改前

               #end add-point
               
               UPDATE dbbd_t SET (dbbdstus,dbbd002,dbbd003,dbbdownid,dbbdowndp,dbbdcrtid,dbbdcrtdp,dbbdcrtdt, 
                   dbbdmodid,dbbdmoddt) = (g_inaa2_d[l_ac].dbbdstus,g_inaa2_d[l_ac].dbbd002,g_inaa2_d[l_ac].dbbd003, 
                   g_inaa3_d[l_ac].dbbdownid,g_inaa3_d[l_ac].dbbdowndp,g_inaa3_d[l_ac].dbbdcrtid,g_inaa3_d[l_ac].dbbdcrtdp, 
                   g_inaa3_d[l_ac].dbbdcrtdt,g_inaa3_d[l_ac].dbbdmodid,g_inaa3_d[l_ac].dbbdmoddt) #自訂欄位頁簽 
 
                WHERE dbbdent = g_enterprise AND
                   dbbdsite = g_master.inaasite
                   AND dbbd001 = g_master.inaa001
                   AND dbbd002 = g_inaa2_d_t.dbbd002
                   AND dbbd003 = g_inaa2_d_t.dbbd003
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_inaa2_d[l_ac].* = g_inaa2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_inaa2_d[l_ac].* = g_inaa2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys_bak[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys_bak[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa2_d[g_detail_idx2].dbbd002
               LET gs_keys_bak[3] = g_inaa2_d_t.dbbd002
               LET gs_keys[4] = g_inaa2_d[g_detail_idx2].dbbd003
               LET gs_keys_bak[4] = g_inaa2_d_t.dbbd003
               CALL adbi260_update_b('dbbd_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_inaa2_d_t)
                     LET g_log2 = util.JSON.stringify(g_inaa2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a01產生
         BEFORE FIELD dbbdstus
            #add-point:BEFORE FIELD dbbdstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbdstus
            
            #add-point:AFTER FIELD dbbdstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbbdstus
            #add-point:ON CHANGE dbbdstus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbd002
            #add-point:BEFORE FIELD dbbd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbd002
            
            #add-point:AFTER FIELD dbbd002
            #此段落由子樣板a05產生
            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL AND g_inaa2_d[g_detail_idx2].dbbd002 IS NOT NULL AND g_inaa2_d[g_detail_idx2].dbbd003 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa2_d[g_detail_idx2].dbbd002 != g_inaa2_d_t.dbbd002 OR g_inaa2_d[g_detail_idx2].dbbd003 != g_inaa2_d_t.dbbd003)) THEN  #160824-00007#10 Mark By Ken 160830
               IF (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa2_d[g_detail_idx2].dbbd002 != g_inaa2_d_o.dbbd002 OR g_inaa2_d[g_detail_idx2].dbbd003 != g_inaa2_d_o.dbbd003) THEN #160824-00007#10 Add By Ken 160830
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbbd_t WHERE "||"dbbdent = '" ||g_enterprise|| "' AND "||"dbbdsite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "dbbd001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"' AND "|| "dbbd002 = '"||g_inaa2_d[g_detail_idx2].dbbd002 ||"' AND "|| "dbbd003 = '"||g_inaa2_d[g_detail_idx2].dbbd003 ||"'",'std-00004',0) THEN 
                     #LET g_inaa2_d[l_ac].dbbd002 = g_inaa2_d_t.dbbd002 #160824-00007#10 Mark By Ken 160830
                     LET g_inaa2_d[l_ac].dbbd002 = g_inaa2_d_o.dbbd002  #160824-00007#10 Add By Ken 160830
                     NEXT FIELD CURRENT
                  ELSE
                     #IF g_inaa2_d[l_ac].dbbd002 <> g_inaa2_d_t.dbbd002 THEN #160824-00007#10 Mark By Ken 160830
                     IF g_inaa2_d[l_ac].dbbd002 <> g_inaa2_d_o.dbbd002 THEN  #160824-00007#10 Add By Ken 160830
                        LET g_inaa2_d[l_ac].dbbd003 = ''
                        LET g_inaa2_d[l_ac].dbbd003_desc = ''
                     END IF
                  END IF
               END IF
            END IF
            LET g_inaa2_d_o.* = g_inaa2_d[l_ac].*  #160824-00007#10 Add By Ken 160830

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbbd002
            #add-point:ON CHANGE dbbd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbd003
            
            #add-point:AFTER FIELD dbbd003
            #此段落由子樣板a05產生
            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL AND g_inaa2_d[g_detail_idx2].dbbd002 IS NOT NULL AND g_inaa2_d[g_detail_idx2].dbbd003 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa2_d[g_detail_idx2].dbbd002 != g_inaa2_d_t.dbbd002 OR g_inaa2_d[g_detail_idx2].dbbd003 != g_inaa2_d_t.dbbd003)) THEN   #160824-00007#10 Mark By Ken 160830
               IF (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa2_d[g_detail_idx2].dbbd002 != g_inaa2_d_o.dbbd002 OR g_inaa2_d[g_detail_idx2].dbbd003 != g_inaa2_d_o.dbbd003) THEN   #160824-00007#10 Add By Ken 160830
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbbd_t WHERE "||"dbbdent = '" ||g_enterprise|| "' AND "||"dbbdsite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "dbbd001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"' AND "|| "dbbd002 = '"||g_inaa2_d[g_detail_idx2].dbbd002 ||"' AND "|| "dbbd003 = '"||g_inaa2_d[g_detail_idx2].dbbd003 ||"'",'std-00004',0) THEN 
                     #LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_t.dbbd003  #160824-00007#10 Mark By Ken 160830
                     LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_o.dbbd003   #160824-00007#10 Add By Ken 160830
                     CALL adbi260_dbbd003_ref() 
                     NEXT FIELD CURRENT
                  ELSE
                     CASE g_inaa2_d[l_ac].dbbd002
                        WHEN '3'   #品牌
                           LET l_acc_code = '2002'
                        WHEN '4'   #系列
                           LET l_acc_code = '2003'
                        WHEN '5'   #型別 
                           LET l_acc_code = '2004'
                        WHEN '6'   #功能 
                           LET l_acc_code = '2005'
                        WHEN '7'   #價格帶
                           LET l_acc_code = '2001'
                        WHEN '8'   #其他屬性一
                           LET l_acc_code = '2006'
                        WHEN '9'   #其他屬性二
                           LET l_acc_code = '2007'
                        WHEN '10'  #其他屬性三
                           LET l_acc_code = '2008'
                        WHEN '11'  #其他屬性四
                           LET l_acc_code = '2009'
                        WHEN '12'  #其他屬性五
                           LET l_acc_code = '2010'
                        WHEN '13'  #其他屬性六
                           LET l_acc_code = '2011'
                        WHEN '14'  #其他屬性七
                           LET l_acc_code = '2012'
                        WHEN '15'  #其他屬性八
                           LET l_acc_code = '2013'
                        WHEN '16'  #其他屬性九
                           LET l_acc_code = '2014'
                        WHEN '17'  #其他屬性十
                           LET l_acc_code = '2015'                  
                     END CASE

                     CASE g_inaa2_d[l_ac].dbbd002
                        WHEN '1'   #產品編號
                           LET g_chkparam.arg1 = g_inaa2_d[l_ac].dbbd003
                           IF NOT cl_chk_exist("v_imaa001") THEN
                              #LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_t.dbbd003  #160824-00007#10 Mark By Ken 160830
                              LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_o.dbbd003   #160824-00007#10 Add By Ken 160830                              
                              #CALL s_desc_get_item_desc(g_inaa2_d[l_ac].dbbd003)
                              #   RETURNING g_inaa2_d[l_ac].dbbd003_desc,l_imaal004
                              #DISPLAY BY NAME g_inaa2_d[l_ac].dbbd003,g_inaa2_d[l_ac].dbbd003_desc
                              CALL adbi260_dbbd003_ref() 
                              NEXT FIELD CURRENT                            
                           END IF
                        WHEN '2'   #產品品類
                           LET g_chkparam.arg1 = g_inaa2_d[l_ac].dbbd003
                           IF NOT cl_chk_exist("v_rtax001_1") THEN
                              #LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_t.dbbd003  #160824-00007#10 Mark By Ken 160830
                              LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_o.dbbd003   #160824-00007#10 Add By Ken 160830                               
                              #CALL s_desc_get_rtaxl003_desc(g_inaa2_d[l_ac].dbbd003)
                              #   RETURNING g_inaa2_d[l_ac].dbbd003_desc
                              #DISPLAY BY NAME g_inaa2_d[l_ac].dbbd003,g_inaa2_d[l_ac].dbbd003_desc
                              CALL adbi260_dbbd003_ref() 
                              NEXT FIELD CURRENT                            
                           END IF
                        OTHERWISE
                           IF NOT s_azzi650_chk_exist(l_acc_code,g_inaa2_d[l_ac].dbbd003) THEN
                              #LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_t.dbbd003  #160824-00007#10 Mark By Ken 160830
                              LET g_inaa2_d[l_ac].dbbd003 = g_inaa2_d_o.dbbd003   #160824-00007#10 Add By Ken 160830                               
                              #CALL s_desc_get_acc_desc(l_acc_code,g_inaa2_d[l_ac].dbbd003)
                              #   RETURNING g_inaa2_d[l_ac].dbbd003_desc
                              #DISPLAY BY NAME g_inaa2_d[l_ac].dbbd003,g_inaa2_d[l_ac].dbbd003_desc
                              CALL adbi260_dbbd003_ref() 
                              NEXT FIELD CURRENT                           
                           END IF                           
                     END CASE
                  END IF
               END IF
            END IF
            CALL adbi260_dbbd003_ref() 
            LET g_inaa2_d_o.* = g_inaa2_d[l_ac].*  #160824-00007#10 Add By Ken 160830            

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbd003
            #add-point:BEFORE FIELD dbbd003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbbd003
            #add-point:ON CHANGE dbbd003

            #END add-point
 
 
                  #Ctrlp:input.c.page2.dbbdstus
         ON ACTION controlp INFIELD dbbdstus
            #add-point:ON ACTION controlp INFIELD dbbdstus

            #END add-point
 
         #Ctrlp:input.c.page2.dbbd002
         ON ACTION controlp INFIELD dbbd002
            #add-point:ON ACTION controlp INFIELD dbbd002

            #END add-point
 
         #Ctrlp:input.c.page2.dbbd003
         ON ACTION controlp INFIELD dbbd003
            #add-point:ON ACTION controlp INFIELD dbbd003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inaa2_d[l_ac].dbbd003            
            
            CASE g_inaa2_d[l_ac].dbbd002
               WHEN '1'   #產品編號
                  CALL q_imaa001()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  CALL s_desc_get_item_desc(g_inaa2_d[l_ac].dbbd003) RETURNING g_inaa2_d[l_ac].dbbd003_desc, l_imaal004
               WHEN '2'   #產品品類
                  CALL q_rtax001()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_rtaxl003_desc(g_inaa2_d[l_ac].dbbd003)                  
               WHEN '3'   #品牌
                  LET g_qryparam.arg1 = "2002"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2002',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '4'   #系列
                  LET g_qryparam.arg1 = "2003"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2003',g_inaa2_d[l_ac].dbbd003)                    
               WHEN '5'   #型別
                  LET g_qryparam.arg1 = "2004"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2004',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '6'   #功能
                  LET g_qryparam.arg1 = "2005"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2005',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '7'   #價格帶
                  LET g_qryparam.arg1 = "2001"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2001',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '8'   #其他屬性一
                  LET g_qryparam.arg1 = "2006"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2006',g_inaa2_d[l_ac].dbbd003)                   
               WHEN '9'   #其他屬性二
                  LET g_qryparam.arg1 = "2007"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2007',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '10'  #其他屬性三
                  LET g_qryparam.arg1 = "2008"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2008',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '11'  #其他屬性四
                  LET g_qryparam.arg1 = "2009"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1  
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2009',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '12'  #其他屬性五
                  LET g_qryparam.arg1 = "2010"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2010',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '13'  #其他屬性六
                  LET g_qryparam.arg1 = "2011"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1  
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2011',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '14'  #其他屬性七
                  LET g_qryparam.arg1 = "2012"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1   
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2012',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '15'  #其他屬性八
                  LET g_qryparam.arg1 = "2013"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2013',g_inaa2_d[l_ac].dbbd003)                   
               WHEN '16'  #其他屬性九
                  LET g_qryparam.arg1 = "2014"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1 
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2014',g_inaa2_d[l_ac].dbbd003)                  
               WHEN '17'  #其他屬性十
                  LET g_qryparam.arg1 = "2015"
                  CALL q_oocq002()
                  LET g_inaa2_d[l_ac].dbbd003 = g_qryparam.return1   
                  LET g_inaa2_d[l_ac].dbbd003_desc = s_desc_get_acc_desc('2015',g_inaa2_d[l_ac].dbbd003)                  
            END CASE

            
            #DISPLAY g_inaa2_d[l_ac].dbbd003 TO dbbd003   
            NEXT FIELD dbbd003                   
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
                  LET g_inaa2_d[l_ac].* = g_inaa2_d_t.*
               END IF
               CLOSE adbi260_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL adbi260_unlock_b("dbbd_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_inaa2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_inaa2_d.getLength()+1
 
      END INPUT
      #實際單身段落
      INPUT ARRAY g_inaa4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
 
         #+ 此段落由子樣板a43產生
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item

               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inaa4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_inaa4_d.getLength()
            LET g_current_page = 4
            #add-point:資料輸入前

            #end add-point
 
         BEFORE INSERT
            IF g_inaa_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'std-00013' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD inaasite
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inaa4_d[l_ac].* TO NULL 
            INITIALIZE g_inaa4_d_t.* TO NULL 
            INITIALIZE g_inaa4_d_o.* TO NULL 
                  LET g_inaa4_d[l_ac].dbbestus = "Y"
 
            #add-point:modify段before備份
            LET g_inaa5_d[l_ac].dbbeownid = g_user
            LET g_inaa5_d[l_ac].dbbeowndp = g_dept
            LET g_inaa5_d[l_ac].dbbecrtid = g_user
            LET g_inaa5_d[l_ac].dbbecrtdp = g_dept 
            LET g_inaa5_d[l_ac].dbbecrtdt = cl_get_current()
            LET g_inaa5_d[l_ac].dbbemodid = ""
            LET g_inaa5_d[l_ac].dbbemoddt = ""
            #end add-point
            LET g_inaa4_d_t.* = g_inaa4_d[l_ac].*     #新輸入資料
            LET g_inaa4_d_o.* = g_inaa4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi260_set_entry_b("a")
            CALL adbi260_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inaa4_d[li_reproduce_target].* = g_inaa4_d[li_reproduce].*
               LET g_inaa5_d[li_reproduce_target].* = g_inaa5_d[li_reproduce].*
 
               LET g_inaa4_d[li_reproduce_target].dbbe002 = NULL
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
            LET g_detail_cnt = g_inaa4_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inaa4_d[l_ac].dbbe002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_inaa4_d_t.* = g_inaa4_d[l_ac].*  #BACKUP
               LET g_inaa4_d_o.* = g_inaa4_d[l_ac].*  #BACKUP
               IF NOT adbi260_lock_b("dbbe_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi260_bcl3 INTO g_inaa4_d[l_ac].dbbestus,g_inaa4_d[l_ac].dbbe002,g_inaa5_d[l_ac].dbbe002, 
                      g_inaa5_d[l_ac].dbbeownid,g_inaa5_d[l_ac].dbbeowndp,g_inaa5_d[l_ac].dbbecrtid, 
                      g_inaa5_d[l_ac].dbbecrtdp,g_inaa5_d[l_ac].dbbecrtdt,g_inaa5_d[l_ac].dbbemodid, 
                      g_inaa5_d[l_ac].dbbemoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL adbi260_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi260_set_entry_b(l_cmd)
            CALL adbi260_set_no_entry_b(l_cmd)
            #add-point:input段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL adbi260_idx_chk('d')
            
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
               
               #add-point:單身4刪除前

               #end add-point  
               
               DELETE FROM dbbe_t
                WHERE dbbeent = g_enterprise AND
                   dbbesite = g_master.inaasite
                   AND dbbe001 = g_master.inaa001
                   AND dbbe002 = g_inaa4_d_t.dbbe002
                   
               #add-point:單身4刪除中

               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaa_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身4刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adbi260_bcl
               LET l_count = g_inaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa4_d[g_detail_idx2].dbbe002
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
                              CALL adbi260_delete_b('dbbe_t',gs_keys,"'4'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inaa4_d.getLength() + 1) THEN
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
            SELECT COUNT(*) INTO l_count FROM dbbe_t 
             WHERE dbbeent = g_enterprise AND
                   dbbesite = g_master.inaasite
                   AND dbbe001 = g_master.inaa001
                   AND dbbe002 = g_inaa4_d[g_detail_idx2].dbbe002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa4_d[g_detail_idx2].dbbe002
               CALL adbi260_insert_b('dbbe_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_inaa_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbbe_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi260_b_fill(g_wc)
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
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_inaa4_d[l_ac].* = g_inaa4_d_t.*
               CLOSE adbi260_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_inaa4_d[l_ac].* = g_inaa4_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身4)
               LET g_inaa5_d[l_ac].dbbemodid = g_user 
LET g_inaa5_d[l_ac].dbbemoddt = cl_get_current()
 
               
               #add-point:單身page4修改前

               #end add-point
               
               UPDATE dbbe_t SET (dbbestus,dbbe002,dbbeownid,dbbeowndp,dbbecrtid,dbbecrtdp,dbbecrtdt, 
                   dbbemodid,dbbemoddt) = (g_inaa4_d[l_ac].dbbestus,g_inaa4_d[l_ac].dbbe002,g_inaa5_d[l_ac].dbbeownid, 
                   g_inaa5_d[l_ac].dbbeowndp,g_inaa5_d[l_ac].dbbecrtid,g_inaa5_d[l_ac].dbbecrtdp,g_inaa5_d[l_ac].dbbecrtdt, 
                   g_inaa5_d[l_ac].dbbemodid,g_inaa5_d[l_ac].dbbemoddt) #自訂欄位頁簽
                WHERE dbbeent = g_enterprise AND
                   dbbesite = g_master.inaasite
                   AND dbbe001 = g_master.inaa001
                   AND dbbe002 = g_inaa4_d_t.dbbe002
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbe_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_inaa4_d[l_ac].* = g_inaa4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbe_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_inaa4_d[l_ac].* = g_inaa4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys_bak[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys_bak[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa4_d[g_detail_idx2].dbbe002
               LET gs_keys_bak[3] = g_inaa4_d_t.dbbe002
               CALL adbi260_update_b('dbbe_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_inaa4_d_t)
                     LET g_log2 = util.JSON.stringify(g_inaa4_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page4修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a01產生
         BEFORE FIELD dbbestus
            #add-point:BEFORE FIELD dbbestus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbestus
            
            #add-point:AFTER FIELD dbbestus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbbestus
            #add-point:ON CHANGE dbbestus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbe002
            
            #add-point:AFTER FIELD dbbe002
            #此段落由子樣板a05產生
            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL AND g_inaa4_d[g_detail_idx2].dbbe002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa4_d[g_detail_idx2].dbbe002 != g_inaa4_d_t.dbbe002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbbe_t WHERE "||"dbbeent = '" ||g_enterprise|| "' AND "||"dbbesite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "dbbe001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"' AND "|| "dbbe002 = '"||g_inaa4_d[g_detail_idx2].dbbe002 ||"'",'std-00004',0) THEN 
                     LET g_inaa4_d[l_ac].dbbe002 = g_inaa4_d_t.dbbe002
                     LET g_inaa4_d[l_ac].dbbe002_desc = s_desc_get_oojdl003_desc(g_inaa4_d[l_ac].dbbe002)
                     NEXT FIELD CURRENT
                  ELSE   
                     LET g_inaa4_d[l_ac].dbbe002_desc = ' '
                     DISPLAY BY NAME g_inaa4_d[l_ac].dbbe002_desc
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_inaa4_d[l_ac].dbbe002
                     LET g_chkparam.arg2 = '1'
                     IF NOT cl_chk_exist("v_oojd001") THEN
                        LET g_inaa4_d[l_ac].dbbe002 = g_inaa4_d_t.dbbe002
                        LET g_inaa4_d[l_ac].dbbe002_desc = s_desc_get_oojdl003_desc(g_inaa4_d[l_ac].dbbe002)
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

            LET g_inaa4_d[l_ac].dbbe002_desc = s_desc_get_oojdl003_desc(g_inaa4_d[l_ac].dbbe002)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbe002
            #add-point:BEFORE FIELD dbbe002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbbe002
            #add-point:ON CHANGE dbbe002

            #END add-point
 
 
                  #Ctrlp:input.c.page4.dbbestus
         ON ACTION controlp INFIELD dbbestus
            #add-point:ON ACTION controlp INFIELD dbbestus

            #END add-point
 
         #Ctrlp:input.c.page4.dbbe002
         ON ACTION controlp INFIELD dbbe002
            #add-point:ON ACTION controlp INFIELD dbbe002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inaa4_d[l_ac].dbbe002             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "1" #
            CALL q_oojd001()                                #呼叫開窗

            LET g_inaa4_d[l_ac].dbbe002 = g_qryparam.return1              
            LET g_inaa4_d[l_ac].dbbe002_desc = s_desc_get_oojdl003_desc(g_inaa4_d[l_ac].dbbe002) 
            DISPLAY g_inaa4_d[l_ac].dbbe002 TO dbbe002              #

            NEXT FIELD dbbe002                          #返回原欄位
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
                  LET g_inaa4_d[l_ac].* = g_inaa4_d_t.*
               END IF
               CLOSE adbi260_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL adbi260_unlock_b("dbbe_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_inaa4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_inaa4_d.getLength()+1
 
      END INPUT
      #實際單身段落
      INPUT ARRAY g_inaa6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_6)
         
 
         #+ 此段落由子樣板a43產生
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item

               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inaa6_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_inaa6_d.getLength()
            LET g_current_page = 6
            #add-point:資料輸入前

            #end add-point
 
         BEFORE INSERT
            IF g_inaa_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'std-00013' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD inaasite
            END IF 
            #判斷能否在此頁面進行資料新增
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inaa6_d[l_ac].* TO NULL 
            INITIALIZE g_inaa6_d_t.* TO NULL 
            INITIALIZE g_inaa6_d_o.* TO NULL 
                  LET g_inaa6_d[l_ac].dbbfstus = "Y"
 
            #add-point:modify段before備份
            LET g_inaa7_d[l_ac].dbbfownid = g_user
            LET g_inaa7_d[l_ac].dbbfowndp = g_dept
            LET g_inaa7_d[l_ac].dbbfcrtid = g_user
            LET g_inaa7_d[l_ac].dbbfcrtdp = g_dept 
            LET g_inaa7_d[l_ac].dbbfcrtdt = cl_get_current()
            LET g_inaa7_d[l_ac].dbbfmodid = ""
            LET g_inaa7_d[l_ac].dbbfmoddt = ""
            #end add-point
            LET g_inaa6_d_t.* = g_inaa6_d[l_ac].*     #新輸入資料
            LET g_inaa6_d_o.* = g_inaa6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi260_set_entry_b("a")
            CALL adbi260_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inaa6_d[li_reproduce_target].* = g_inaa6_d[li_reproduce].*
               LET g_inaa7_d[li_reproduce_target].* = g_inaa7_d[li_reproduce].*
 
               LET g_inaa6_d[li_reproduce_target].dbbf002 = NULL
               LET g_inaa6_d[li_reproduce_target].dbbf003 = NULL
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
            LET g_detail_cnt = g_inaa6_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inaa6_d[l_ac].dbbf002 IS NOT NULL
               AND g_inaa6_d[l_ac].dbbf003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_inaa6_d_t.* = g_inaa6_d[l_ac].*  #BACKUP
               LET g_inaa6_d_o.* = g_inaa6_d[l_ac].*  #BACKUP
               IF NOT adbi260_lock_b("dbbf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi260_bcl4 INTO g_inaa6_d[l_ac].dbbfstus,g_inaa6_d[l_ac].dbbf002,g_inaa6_d[l_ac].dbbf003, 
                      g_inaa7_d[l_ac].dbbf002,g_inaa7_d[l_ac].dbbf003,g_inaa7_d[l_ac].dbbfsite,g_inaa7_d[l_ac].dbbfownid, 
                      g_inaa7_d[l_ac].dbbfowndp,g_inaa7_d[l_ac].dbbfcrtid,g_inaa7_d[l_ac].dbbfcrtdp, 
                      g_inaa7_d[l_ac].dbbfcrtdt,g_inaa7_d[l_ac].dbbfmodid,g_inaa7_d[l_ac].dbbfmoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
                  #CALL adbi260_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi260_set_entry_b(l_cmd)
            CALL adbi260_set_no_entry_b(l_cmd)
            #add-point:input段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            CALL adbi260_idx_chk('d')
            
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
               
               #add-point:單身6刪除前

               #end add-point  
               
               DELETE FROM dbbf_t
                WHERE dbbfent = g_enterprise AND
                   dbbfsite = g_master.inaasite
                   AND dbbf001 = g_master.inaa001
                   AND dbbf002 = g_inaa6_d_t.dbbf002
                   AND dbbf003 = g_inaa6_d_t.dbbf003
                   
               #add-point:單身6刪除中

               #end add-point  
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaa_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身6刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adbi260_bcl
               LET l_count = g_inaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa6_d[g_detail_idx2].dbbf002
               LET gs_keys[4] = g_inaa6_d[g_detail_idx2].dbbf003
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
                              CALL adbi260_delete_b('dbbf_t',gs_keys,"'6'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inaa6_d.getLength() + 1) THEN
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
            SELECT COUNT(*) INTO l_count FROM dbbf_t 
             WHERE dbbfent = g_enterprise AND
                   dbbfsite = g_master.inaasite
                   AND dbbf001 = g_master.inaa001
                   AND dbbf002 = g_inaa6_d[g_detail_idx2].dbbf002
                   AND dbbf003 = g_inaa6_d[g_detail_idx2].dbbf003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身6新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa6_d[g_detail_idx2].dbbf002
               LET gs_keys[4] = g_inaa6_d[g_detail_idx2].dbbf003
               CALL adbi260_insert_b('dbbf_t',gs_keys,"'6'")
                           
               #add-point:單身新增後6

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_inaa_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbbf_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi260_b_fill(g_wc)
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
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_inaa6_d[l_ac].* = g_inaa6_d_t.*
               CLOSE adbi260_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_inaa6_d[l_ac].* = g_inaa6_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身6)
               LET g_inaa7_d[l_ac].dbbfmodid = g_user 
LET g_inaa7_d[l_ac].dbbfmoddt = cl_get_current()
 
               
               #add-point:單身page6修改前

               #end add-point
               
               UPDATE dbbf_t SET (dbbfstus,dbbf002,dbbf003,dbbfsite,dbbfownid,dbbfowndp,dbbfcrtid,dbbfcrtdp, 
                   dbbfcrtdt,dbbfmodid,dbbfmoddt) = (g_inaa6_d[l_ac].dbbfstus,g_inaa6_d[l_ac].dbbf002, 
                   g_inaa6_d[l_ac].dbbf003,g_inaa7_d[l_ac].dbbfsite,g_inaa7_d[l_ac].dbbfownid,g_inaa7_d[l_ac].dbbfowndp, 
                   g_inaa7_d[l_ac].dbbfcrtid,g_inaa7_d[l_ac].dbbfcrtdp,g_inaa7_d[l_ac].dbbfcrtdt,g_inaa7_d[l_ac].dbbfmodid, 
                   g_inaa7_d[l_ac].dbbfmoddt) #自訂欄位頁簽
                WHERE dbbfent = g_enterprise AND
                   dbbfsite = g_master.inaasite
                   AND dbbf001 = g_master.inaa001
                   AND dbbf002 = g_inaa6_d_t.dbbf002
                   AND dbbf003 = g_inaa6_d_t.dbbf003
                   
               #add-point:單身修改中

               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_inaa6_d[l_ac].* = g_inaa6_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbf_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_inaa6_d[l_ac].* = g_inaa6_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys_bak[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys_bak[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[3] = g_inaa6_d[g_detail_idx2].dbbf002
               LET gs_keys_bak[3] = g_inaa6_d_t.dbbf002
               LET gs_keys[4] = g_inaa6_d[g_detail_idx2].dbbf003
               LET gs_keys_bak[4] = g_inaa6_d_t.dbbf003
               CALL adbi260_update_b('dbbf_t',gs_keys,gs_keys_bak,"'6'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_inaa6_d_t)
                     LET g_log2 = util.JSON.stringify(g_inaa6_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page6修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a01產生
         BEFORE FIELD dbbfstus
            #add-point:BEFORE FIELD dbbfstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbfstus
            
            #add-point:AFTER FIELD dbbfstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbbfstus
            #add-point:ON CHANGE dbbfstus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbf002
            #add-point:BEFORE FIELD dbbf002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbf002
            
            #add-point:AFTER FIELD dbbf002
            #此段落由子樣板a05產生
            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL AND g_inaa6_d[g_detail_idx2].dbbf002 IS NOT NULL AND g_inaa6_d[g_detail_idx2].dbbf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa6_d[g_detail_idx2].dbbf002 != g_inaa6_d_t.dbbf002 OR g_inaa6_d[g_detail_idx2].dbbf003 != g_inaa6_d_t.dbbf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbbf_t WHERE "||"dbbfent = '" ||g_enterprise|| "' AND "||"dbbfsite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "dbbf001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"' AND "|| "dbbf002 = '"||g_inaa6_d[g_detail_idx2].dbbf002 ||"' AND "|| "dbbf003 = '"||g_inaa6_d[g_detail_idx2].dbbf003 ||"'",'std-00004',0) THEN 
                     LET g_inaa6_d[l_ac].dbbf002 = g_inaa6_d_t.dbbf002
                     NEXT FIELD CURRENT
                  ELSE
                     IF g_inaa6_d[l_ac].dbbf002 <> g_inaa6_d_t.dbbf002 THEN
                        LET g_inaa6_d[l_ac].dbbf003 = ''
                        LET g_inaa6_d[l_ac].dbbf003_desc = ''
                     END IF
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbbf002
            #add-point:ON CHANGE dbbf002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbbf003
            
            #add-point:AFTER FIELD dbbf003
            #此段落由子樣板a05產生
            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL AND g_inaa6_d[g_detail_idx2].dbbf002 IS NOT NULL AND g_inaa6_d[g_detail_idx2].dbbf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d[g_detail_idx].inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d[g_detail_idx].inaa001 OR g_inaa6_d[g_detail_idx2].dbbf002 != g_inaa6_d_t.dbbf002 OR g_inaa6_d[g_detail_idx2].dbbf003 != g_inaa6_d_t.dbbf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbbf_t WHERE "||"dbbfent = '" ||g_enterprise|| "' AND "||"dbbfsite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "dbbf001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"' AND "|| "dbbf002 = '"||g_inaa6_d[g_detail_idx2].dbbf002 ||"' AND "|| "dbbf003 = '"||g_inaa6_d[g_detail_idx2].dbbf003 ||"'",'std-00004',0) THEN 
                     LET g_inaa6_d[l_ac].dbbf003 = g_inaa6_d_t.dbbf003
                     LET g_inaa6_d[l_ac].dbbf003_desc = s_desc_get_dbaa001_desc(g_inaa6_d[l_ac].dbbf003) 
                     NEXT FIELD CURRENT
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_inaa6_d[l_ac].dbbf003
                     LET g_chkparam.arg2 = g_inaa6_d[l_ac].dbbf002
                     LET g_chkparam.err_str[1] = "acr-00004|",g_inaa6_d[l_ac].dbbf002                      
                     IF NOT cl_chk_exist("v_dbaa001_1") THEN
                        LET g_inaa6_d[l_ac].dbbf003 = g_inaa6_d_t.dbbf003
                        LET g_inaa6_d[l_ac].dbbf003_desc = s_desc_get_dbaa001_desc(g_inaa6_d[l_ac].dbbf003) 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            LET g_inaa6_d[l_ac].dbbf003_desc = s_desc_get_dbaa001_desc(g_inaa6_d[l_ac].dbbf003) 
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_inaa6_d[l_ac].dbbf003
            #CALL ap_ref_array2(g_ref_fields,"SELECT dbaal003 FROM dbaal_t WHERE dbaalent='"||g_enterprise||"' AND dbaal001=? AND dbaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_inaa6_d[l_ac].dbbf003_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_inaa6_d[l_ac].dbbf003_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbbf003
            #add-point:BEFORE FIELD dbbf003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbbf003
            #add-point:ON CHANGE dbbf003

            #END add-point
 
 
                  #Ctrlp:input.c.page6.dbbfstus
         ON ACTION controlp INFIELD dbbfstus
            #add-point:ON ACTION controlp INFIELD dbbfstus

            #END add-point
 
         #Ctrlp:input.c.page6.dbbf002
         ON ACTION controlp INFIELD dbbf002
            #add-point:ON ACTION controlp INFIELD dbbf002

            #END add-point
 
         #Ctrlp:input.c.page6.dbbf003
         ON ACTION controlp INFIELD dbbf003
            #add-point:ON ACTION controlp INFIELD dbbf003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa6_d[l_ac].dbbf003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_inaa6_d[l_ac].dbbf002 #
            CALL q_dbaa001_1()                               #呼叫開窗
            LET g_inaa6_d[l_ac].dbbf003 = g_qryparam.return1   
            LET g_inaa6_d[l_ac].dbbf003_desc = s_desc_get_dbaa001_desc(g_inaa6_d[l_ac].dbbf003)            
            DISPLAY g_inaa6_d[l_ac].dbbf003 TO dbbf003              #

            NEXT FIELD dbbf003                          #返回原欄位


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
                  LET g_inaa6_d[l_ac].* = g_inaa6_d_t.*
               END IF
               CLOSE adbi260_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL adbi260_unlock_b("dbbf_t")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
 
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_inaa6_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_inaa6_d.getLength()+1
 
      END INPUT
 
      
 
    
      DISPLAY ARRAY g_inaa3_d TO s_detail3.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            CALL adbi260_fetch()
            LET g_current_page = 3
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL adbi260_idx_chk('d')
            
         #add-point:page3自定義行為

         #end add-point
            
      END DISPLAY
      DISPLAY ARRAY g_inaa5_d TO s_detail5.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            CALL adbi260_fetch()
            LET g_current_page = 5
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL adbi260_idx_chk('d')
            
         #add-point:page5自定義行為

         #end add-point
            
      END DISPLAY
      DISPLAY ARRAY g_inaa7_d TO s_detail7.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            CALL adbi260_fetch()
            LET g_current_page = 7
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail7")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL adbi260_idx_chk('d')
            
         #add-point:page7自定義行為

         #end add-point
            
      END DISPLAY
 
      
      #add-point:input段input_array"

      #end add-point
      
      BEFORE DIALOG 
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_inaa_d.getLength() THEN
               LET g_detail_idx = g_inaa_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array"

         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_inaa_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inaastus
               WHEN "s_detail2"
                  NEXT FIELD dbbdstus
               WHEN "s_detail3"
                  NEXT FIELD dbbd002_3
               WHEN "s_detail4"
                  NEXT FIELD dbbestus
               WHEN "s_detail5"
                  NEXT FIELD dbbe002_5
               WHEN "s_detail6"
                  NEXT FIELD dbbfstus
               WHEN "s_detail7"
                  NEXT FIELD dbbf002_7
 
            END CASE
         ELSE
            NEXT FIELD inaastus
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
 
   CLOSE adbi260_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi260.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi260_b_fill(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num5
   #add-point:b_fill段define
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before
   LET l_where = s_aooi500_sql_where(g_prog,'inaasite')
   IF cl_null(p_wc2) THEN
      LET p_wc2 = l_where
   ELSE
      LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   END IF
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE t0.inaastus,t0.inaasite,t0.inaa001 ,t1.ooefl003 FROM inaa_t t0",
 
               " LEFT JOIN dbbd_t ON dbbdent = inaaent AND inaasite = dbbdsite AND inaa001 = dbbd001",
 
               " LEFT JOIN dbbe_t ON dbbeent = inaaent AND inaasite = dbbesite AND inaa001 = dbbe001",
 
               " LEFT JOIN dbbf_t ON dbbfent = inaaent AND inaasite = dbbfsite AND inaa001 = dbbf001",
 
 
               " LEFT JOIN inayl_t ON inaylent = '"||g_enterprise||"' AND inaa001 = inayl001 AND inayl002 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.inaasite AND t1.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.inaaent= ?  AND  1=1 AND (", p_wc2, ") "
    
   LET g_sql = g_sql, cl_sql_add_filter("inaa_t"),
                      " ORDER BY t0.inaasite,t0.inaa001"
  
   #add-point:b_fill段sql_after
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"inaa_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE adbi260_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi260_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_inaa_d.clear()
   CALL g_inaa2_d.clear()   
   CALL g_inaa3_d.clear()   
   CALL g_inaa4_d.clear()   
   CALL g_inaa5_d.clear()   
   CALL g_inaa6_d.clear()   
   CALL g_inaa7_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaasite_desc 
 
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
   
 
   CALL g_inaa_d.deleteElement(g_inaa_d.getLength())   
   CALL g_inaa2_d.deleteElement(g_inaa2_d.getLength())
   CALL g_inaa3_d.deleteElement(g_inaa3_d.getLength())
   CALL g_inaa4_d.deleteElement(g_inaa4_d.getLength())
   CALL g_inaa5_d.deleteElement(g_inaa5_d.getLength())
   CALL g_inaa6_d.deleteElement(g_inaa6_d.getLength())
   CALL g_inaa7_d.deleteElement(g_inaa7_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_inaa_d.getLength() THEN
      LET g_detail_idx = g_inaa_d.getLength()
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_inaa_d.getLength()
      #LET g_inaa2_d[g_detail_idx2].dbbd002 = g_inaa_d[g_detail_idx].inaasite 
      #LET g_inaa2_d[g_detail_idx2].dbbd003 = g_inaa_d[g_detail_idx].inaa001 
      #LET g_inaa3_d[g_detail_idx2].dbbd002 = g_inaa_d[g_detail_idx].inaasite 
      #LET g_inaa3_d[g_detail_idx2].dbbd003 = g_inaa_d[g_detail_idx].inaa001 
      #LET g_inaa4_d[g_detail_idx2].dbbe002 = g_inaa_d[g_detail_idx].inaasite 
      #LET g_inaa5_d[g_detail_idx2].dbbe002 = g_inaa_d[g_detail_idx].inaasite 
      #LET g_inaa6_d[g_detail_idx2].dbbf002 = g_inaa_d[g_detail_idx].inaasite 
      #LET g_inaa6_d[g_detail_idx2].dbbf003 = g_inaa_d[g_detail_idx].inaa001 
      #LET g_inaa7_d[g_detail_idx2].dbbf002 = g_inaa_d[g_detail_idx].inaasite 
      #LET g_inaa7_d[g_detail_idx2].dbbf003 = g_inaa_d[g_detail_idx].inaa001 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adbi260_pb
   
   LET g_loc = 'm'
   CALL adbi260_detail_show() 
   
   LET l_ac = 1
   IF g_inaa_d.getLength() > 0 THEN
      CALL adbi260_fetch()
   END IF
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi260.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbi260_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_inaa_d.getLength() = 0 THEN
      RETURN
   END IF
   
   CALL g_inaa2_d.clear()
   CALL g_inaa3_d.clear()
   CALL g_inaa4_d.clear()
   CALL g_inaa5_d.clear()
   CALL g_inaa6_d.clear()
   CALL g_inaa7_d.clear()
 
   
   LET li_ac = l_ac 
   
   LET g_sql = "SELECT  UNIQUE t0.dbbdstus,t0.dbbd002,t0.dbbd003,t0.dbbd002,t0.dbbd003,t0.dbbdownid, 
       t0.dbbdowndp,t0.dbbdcrtid,t0.dbbdcrtdp,t0.dbbdcrtdt,t0.dbbdmodid,t0.dbbdmoddt ,t2.oofa011 ,t3.ooefl003 , 
       t4.oofa011 ,t5.ooefl003 ,t6.oofa011 FROM dbbd_t t0",    
               "",
                              " LEFT JOIN oofa_t t2 ON t2.oofaent='"||g_enterprise||"' AND t2.oofa002='2' AND t2.oofa003=t0.dbbdownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.dbbdowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t4 ON t4.oofaent='"||g_enterprise||"' AND t4.oofa002='2' AND t4.oofa003=t0.dbbdcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.dbbdcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t6 ON t6.oofaent='"||g_enterprise||"' AND t6.oofa002='2' AND t6.oofa003=t0.dbbdmodid  ",
 
               " WHERE t0.dbbdent=?  AND t0. dbbdsite=?  AND t0. dbbd001=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY t0.dbbd002,t0.dbbd003" 
                      
   #add-point:單身填充前
   
   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
   PREPARE adbi260_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR adbi260_pb2
   
   LET l_ac = g_detail_idx
   OPEN b_fill_curs2 USING g_enterprise,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001
   
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_inaa2_d[l_ac].dbbdstus,g_inaa2_d[l_ac].dbbd002,g_inaa2_d[l_ac].dbbd003, 
       g_inaa3_d[l_ac].dbbd002,g_inaa3_d[l_ac].dbbd003,g_inaa3_d[l_ac].dbbdownid,g_inaa3_d[l_ac].dbbdowndp, 
       g_inaa3_d[l_ac].dbbdcrtid,g_inaa3_d[l_ac].dbbdcrtdp,g_inaa3_d[l_ac].dbbdcrtdt,g_inaa3_d[l_ac].dbbdmodid, 
       g_inaa3_d[l_ac].dbbdmoddt,g_inaa3_d[l_ac].dbbdownid_desc,g_inaa3_d[l_ac].dbbdowndp_desc,g_inaa3_d[l_ac].dbbdcrtid_desc, 
       g_inaa3_d[l_ac].dbbdcrtdp_desc,g_inaa3_d[l_ac].dbbdmodid_desc
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
 
   LET g_sql = "SELECT  UNIQUE t0.dbbestus,t0.dbbe002,t0.dbbe002,t0.dbbeownid,t0.dbbeowndp,t0.dbbecrtid, 
       t0.dbbecrtdp,t0.dbbecrtdt,t0.dbbemodid,t0.dbbemoddt ,t7.oojdl003 ,t8.oofa011 ,t9.ooefl003 ,t10.oofa011 , 
       t11.ooefl003 ,t12.oofa011 FROM dbbe_t t0",    
               "",
                              " LEFT JOIN oojdl_t t7 ON t7.oojdlent='"||g_enterprise||"' AND t7.oojdl001=t0.dbbe002 AND t7.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t8 ON t8.oofaent='"||g_enterprise||"' AND t8.oofa002='2' AND t8.oofa003=t0.dbbeownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.dbbeowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t10 ON t10.oofaent='"||g_enterprise||"' AND t10.oofa002='2' AND t10.oofa003=t0.dbbecrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent='"||g_enterprise||"' AND t11.ooefl001=t0.dbbecrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t12 ON t12.oofaent='"||g_enterprise||"' AND t12.oofa002='2' AND t12.oofa003=t0.dbbemodid  ",
 
               " WHERE t0.dbbeent=?  AND t0. dbbesite=?  AND t0. dbbe001=?"
 
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY t0.dbbe002" 
                      
   #add-point:單身填充前
   
   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
   PREPARE adbi260_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR adbi260_pb3
   
   LET l_ac = g_detail_idx
   OPEN b_fill_curs3 USING g_enterprise,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001
   
   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_inaa4_d[l_ac].dbbestus,g_inaa4_d[l_ac].dbbe002,g_inaa5_d[l_ac].dbbe002, 
       g_inaa5_d[l_ac].dbbeownid,g_inaa5_d[l_ac].dbbeowndp,g_inaa5_d[l_ac].dbbecrtid,g_inaa5_d[l_ac].dbbecrtdp, 
       g_inaa5_d[l_ac].dbbecrtdt,g_inaa5_d[l_ac].dbbemodid,g_inaa5_d[l_ac].dbbemoddt,g_inaa4_d[l_ac].dbbe002_desc, 
       g_inaa5_d[l_ac].dbbeownid_desc,g_inaa5_d[l_ac].dbbeowndp_desc,g_inaa5_d[l_ac].dbbecrtid_desc, 
       g_inaa5_d[l_ac].dbbecrtdp_desc,g_inaa5_d[l_ac].dbbemodid_desc
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
 
   LET g_sql = "SELECT  UNIQUE t0.dbbfstus,t0.dbbf002,t0.dbbf003,t0.dbbf002,t0.dbbf003,t0.dbbfsite,t0.dbbfownid, 
       t0.dbbfowndp,t0.dbbfcrtid,t0.dbbfcrtdp,t0.dbbfcrtdt,t0.dbbfmodid,t0.dbbfmoddt ,t13.dbaal003 , 
       t14.oofa011 ,t15.ooefl003 ,t16.oofa011 ,t17.ooefl003 ,t18.oofa011 FROM dbbf_t t0",    
               "",
                              " LEFT JOIN dbaal_t t13 ON t13.dbaalent='"||g_enterprise||"' AND t13.dbaal001=t0.dbbf003 AND t13.dbaal002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t14 ON t14.oofaent='"||g_enterprise||"' AND t14.oofa002='2' AND t14.oofa003=t0.dbbfownid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent='"||g_enterprise||"' AND t15.ooefl001=t0.dbbfowndp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t16 ON t16.oofaent='"||g_enterprise||"' AND t16.oofa002='2' AND t16.oofa003=t0.dbbfcrtid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent='"||g_enterprise||"' AND t17.ooefl001=t0.dbbfcrtdp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t18 ON t18.oofaent='"||g_enterprise||"' AND t18.oofa002='2' AND t18.oofa003=t0.dbbfmodid  ",
 
               " WHERE t0.dbbfent=?  AND t0. dbbfsite=?  AND t0. dbbf001=?"
 
   IF NOT cl_null(g_wc2_table4) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY t0.dbbf002,t0.dbbf003" 
                      
   #add-point:單身填充前
   
   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
   PREPARE adbi260_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR adbi260_pb4
   
   LET l_ac = g_detail_idx
   OPEN b_fill_curs4 USING g_enterprise,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001
   
   LET l_ac = 1
   FOREACH b_fill_curs4 INTO g_inaa6_d[l_ac].dbbfstus,g_inaa6_d[l_ac].dbbf002,g_inaa6_d[l_ac].dbbf003, 
       g_inaa7_d[l_ac].dbbf002,g_inaa7_d[l_ac].dbbf003,g_inaa7_d[l_ac].dbbfsite,g_inaa7_d[l_ac].dbbfownid, 
       g_inaa7_d[l_ac].dbbfowndp,g_inaa7_d[l_ac].dbbfcrtid,g_inaa7_d[l_ac].dbbfcrtdp,g_inaa7_d[l_ac].dbbfcrtdt, 
       g_inaa7_d[l_ac].dbbfmodid,g_inaa7_d[l_ac].dbbfmoddt,g_inaa6_d[l_ac].dbbf003_desc,g_inaa7_d[l_ac].dbbfownid_desc, 
       g_inaa7_d[l_ac].dbbfowndp_desc,g_inaa7_d[l_ac].dbbfcrtid_desc,g_inaa7_d[l_ac].dbbfcrtdp_desc, 
       g_inaa7_d[l_ac].dbbfmodid_desc
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
   
   CALL g_inaa2_d.deleteElement(g_inaa2_d.getLength())   
   CALL g_inaa3_d.deleteElement(g_inaa3_d.getLength())   
   CALL g_inaa4_d.deleteElement(g_inaa4_d.getLength())   
   CALL g_inaa5_d.deleteElement(g_inaa5_d.getLength())   
   CALL g_inaa6_d.deleteElement(g_inaa6_d.getLength())   
   CALL g_inaa7_d.deleteElement(g_inaa7_d.getLength())   
 
   
   #LET g_loc = 'd'
   CALL adbi260_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adbi260.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi260_detail_show()
   DEFINE l_ac_t LIKE type_t.num5
   #add-point:show段define
   DEFINE l_acc_code   LIKE oocq_t.oocq001
   DEFINE l_imaal004   LIKE imaal_t.imaal004
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   
 
   #帶出公用欄位reference值page4
   
   #帶出公用欄位reference值page5
   
 
   #帶出公用欄位reference值page6
   
   #帶出公用欄位reference值page7
   
 
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_inaa_d.getLength()
         #add-point:show段單頭reference
         LET g_inaa_d[l_ac].inaa001_desc = s_desc_get_stock_desc(g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001)
         
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_inaa2_d.getLength()
        #add-point:show段單身reference
        CALL adbi260_dbbd003_ref()   
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_inaa3_d.getLength()
        #add-point:show段單身reference
   
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_inaa4_d.getLength()
        #add-point:show段單身reference
        
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_inaa5_d.getLength()
        #add-point:show段單身reference
        
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_inaa6_d.getLength()
        #add-point:show段單身reference
        
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_inaa7_d.getLength()
        #add-point:show段單身reference
        
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後
      IF g_loc = 'm' THEN      
         LET g_loc = 'd'
         CALL adbi260_detail_show() 
      END IF   
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi260_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="adbi260.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi260_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="adbi260.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi260_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " inaasite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inaa001 = ", g_argv[02], " AND "
   END IF
 
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi260_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM inaa_t
       WHERE inaaent = g_enterprise AND
         inaasite = ps_keys_bak[1] AND inaa001 = ps_keys_bak[2]
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
   
 
   
   LET ls_group = "dbbd_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM dbbd_t
       WHERE dbbdent = g_enterprise AND
         dbbdsite = ps_keys_bak[1] AND dbbd001 = ps_keys_bak[2] AND dbbd002 = ps_keys_bak[3] AND dbbd003 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
   LET ls_group = "dbbe_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM dbbe_t
       WHERE dbbeent = g_enterprise AND
         dbbesite = ps_keys_bak[1] AND dbbe001 = ps_keys_bak[2] AND dbbe002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbe_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
   LET ls_group = "dbbf_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM dbbf_t
       WHERE dbbfent = g_enterprise AND
         dbbfsite = ps_keys_bak[1] AND dbbf001 = ps_keys_bak[2] AND dbbf002 = ps_keys_bak[3] AND dbbf003 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "inaa_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM dbbd_t
       WHERE dbbdent = g_enterprise AND
         dbbdsite = ps_keys_bak[1] AND dbbd001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
   #單頭刪除, 連帶刪除單身
   LET ls_group = "inaa_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM dbbe_t
       WHERE dbbeent = g_enterprise AND
         dbbesite = ps_keys_bak[1] AND dbbe001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbe_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point  
      RETURN
   END IF
 
   #單頭刪除, 連帶刪除單身
   LET ls_group = "inaa_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point  
      DELETE FROM dbbf_t
       WHERE dbbfent = g_enterprise AND
         dbbfsite = ps_keys_bak[1] AND dbbf001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbf_t" 
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
 
{<section id="adbi260.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi260_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point
 
   #判斷是否是同一群組的table
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO inaa_t
                  (inaaent,
                   inaasite,inaa001
                   ,inaastus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inaa_d[g_detail_idx].inaastus)
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inaa_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "dbbd_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO dbbd_t
                  (dbbdent,
                   dbbdsite,dbbd001,dbbd002,dbbd003
                   ,dbbdstus,dbbdownid,dbbdowndp,dbbdcrtid,dbbdcrtdp,dbbdcrtdt,dbbdmodid,dbbdmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_inaa2_d[g_detail_idx2].dbbdstus,g_inaa3_d[g_detail_idx2].dbbdownid,g_inaa3_d[g_detail_idx2].dbbdowndp, 
                       g_inaa3_d[g_detail_idx2].dbbdcrtid,g_inaa3_d[g_detail_idx2].dbbdcrtdp,g_inaa3_d[g_detail_idx2].dbbdcrtdt, 
                       g_inaa3_d[g_detail_idx2].dbbdmodid,g_inaa3_d[g_detail_idx2].dbbdmoddt)
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         RETURN
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
 
   LET ls_group = "dbbe_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO dbbe_t
                  (dbbeent,
                   dbbesite,dbbe001,dbbe002
                   ,dbbestus,dbbeownid,dbbeowndp,dbbecrtid,dbbecrtdp,dbbecrtdt,dbbemodid,dbbemoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_inaa4_d[g_detail_idx2].dbbestus,g_inaa5_d[g_detail_idx2].dbbeownid,g_inaa5_d[g_detail_idx2].dbbeowndp, 
                       g_inaa5_d[g_detail_idx2].dbbecrtid,g_inaa5_d[g_detail_idx2].dbbecrtdp,g_inaa5_d[g_detail_idx2].dbbecrtdt, 
                       g_inaa5_d[g_detail_idx2].dbbemodid,g_inaa5_d[g_detail_idx2].dbbemoddt)
      #add-point:insert_b段新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         RETURN
      END IF
      #add-point:insert_b段新增後
      
      #end add-point
   END IF
 
   LET ls_group = "dbbf_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前
      
      #end add-point
      INSERT INTO dbbf_t
                  (dbbfent,
                   dbbfsite,dbbf001,dbbf002,dbbf003
                   ,dbbfstus,dbbfownid,dbbfowndp,dbbfcrtid,dbbfcrtdp,dbbfcrtdt,dbbfmodid,dbbfmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_inaa6_d[g_detail_idx2].dbbfstus,g_inaa7_d[g_detail_idx2].dbbfownid,g_inaa7_d[g_detail_idx2].dbbfowndp, 
                       g_inaa7_d[g_detail_idx2].dbbfcrtid,g_inaa7_d[g_detail_idx2].dbbfcrtdp,g_inaa7_d[g_detail_idx2].dbbfcrtdt, 
                       g_inaa7_d[g_detail_idx2].dbbfmodid,g_inaa7_d[g_detail_idx2].dbbfmoddt)
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
 
{<section id="adbi260.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi260_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inaa_t" THEN
   
      #add-point:update_b段修改前
 
#      #end add-point     
#   
#      UPDATE inaa_t 
#         SET (inaasite,inaa001
#              ,inaastus) 
#              = 
#             (ps_keys[1],ps_keys[2]
#              ,g_inaa_d[g_detail_idx].inaastus) 
#         WHERE inaasite = ps_keys_bak[1] AND inaa001 = ps_keys_bak[2]
# 
#      #add-point:update_b段修改中
      #160905-00003#4 160905 by lori add---(S)
      #加ENT過濾條件
      UPDATE inaa_t 
         SET (inaasite,inaa001,inaastus) 
           = (ps_keys[1],ps_keys[2],g_inaa_d[g_detail_idx].inaastus) 
         WHERE inaanet = g_enterprise AND inaasite = ps_keys_bak[1] AND inaa001 = ps_keys_bak[2]
      #160905-00003#4 160905 by lori add---(E)   
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t" 
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
   
 
   
   LET ls_group = "dbbd_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbbd_t" THEN
   
      #add-point:update_b段修改前
 
#      #end add-point    
#      
#      UPDATE dbbd_t 
#         SET (dbbdsite,dbbd001,dbbd002,dbbd003
#              ,dbbdstus,dbbdownid,dbbdowndp,dbbdcrtid,dbbdcrtdp,dbbdcrtdt,dbbdmodid,dbbdmoddt) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
#              ,g_inaa2_d[g_detail_idx2].dbbdstus,g_inaa3_d[g_detail_idx2].dbbdownid,g_inaa3_d[g_detail_idx2].dbbdowndp, 
#                  g_inaa3_d[g_detail_idx2].dbbdcrtid,g_inaa3_d[g_detail_idx2].dbbdcrtdp,g_inaa3_d[g_detail_idx2].dbbdcrtdt, 
#                  g_inaa3_d[g_detail_idx2].dbbdmodid,g_inaa3_d[g_detail_idx2].dbbdmoddt) 
#         WHERE dbbdsite = ps_keys_bak[1] AND dbbd001 = ps_keys_bak[2] AND dbbd002 = ps_keys_bak[3] AND dbbd003 = ps_keys_bak[4]
# 
#      #add-point:update_b段修改中
      #160905-00003#4 160905 by lori add---(S)  
      #加ENT過濾條件
      UPDATE dbbd_t 
         SET (dbbdsite,dbbd001,dbbd002,dbbd003
              ,dbbdstus,dbbdownid,dbbdowndp,dbbdcrtid,dbbdcrtdp,dbbdcrtdt,dbbdmodid,dbbdmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_inaa2_d[g_detail_idx2].dbbdstus,g_inaa3_d[g_detail_idx2].dbbdownid,g_inaa3_d[g_detail_idx2].dbbdowndp, 
                  g_inaa3_d[g_detail_idx2].dbbdcrtid,g_inaa3_d[g_detail_idx2].dbbdcrtdp,g_inaa3_d[g_detail_idx2].dbbdcrtdt, 
                  g_inaa3_d[g_detail_idx2].dbbdmodid,g_inaa3_d[g_detail_idx2].dbbdmoddt) 
         WHERE dbbdent = g_enterprise
           AND dbbdsite = ps_keys_bak[1] AND dbbd001 = ps_keys_bak[2] 
           AND dbbd002 = ps_keys_bak[3] AND dbbd003 = ps_keys_bak[4]
      
      #160905-00003#4 160905 by lori add---(E) 
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbd_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbd_t" 
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
 
   LET ls_group = "dbbe_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbbe_t" THEN
   
      #add-point:update_b段修改前
 
#      #end add-point    
#      
#      UPDATE dbbe_t 
#         SET (dbbesite,dbbe001,dbbe002
#              ,dbbestus,dbbeownid,dbbeowndp,dbbecrtid,dbbecrtdp,dbbecrtdt,dbbemodid,dbbemoddt) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3]
#              ,g_inaa4_d[g_detail_idx2].dbbestus,g_inaa5_d[g_detail_idx2].dbbeownid,g_inaa5_d[g_detail_idx2].dbbeowndp, 
#                  g_inaa5_d[g_detail_idx2].dbbecrtid,g_inaa5_d[g_detail_idx2].dbbecrtdp,g_inaa5_d[g_detail_idx2].dbbecrtdt, 
#                  g_inaa5_d[g_detail_idx2].dbbemodid,g_inaa5_d[g_detail_idx2].dbbemoddt) 
#         WHERE dbbesite = ps_keys_bak[1] AND dbbe001 = ps_keys_bak[2] AND dbbe002 = ps_keys_bak[3]
# 
#      #add-point:update_b段修改中
      #160905-00003#4 160905 by lori add---(S)  
      #加ENT過濾條件
      UPDATE dbbe_t 
         SET (dbbesite,dbbe001,dbbe002
              ,dbbestus,dbbeownid,dbbeowndp,dbbecrtid,dbbecrtdp,dbbecrtdt,dbbemodid,dbbemoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_inaa4_d[g_detail_idx2].dbbestus,g_inaa5_d[g_detail_idx2].dbbeownid,g_inaa5_d[g_detail_idx2].dbbeowndp, 
                  g_inaa5_d[g_detail_idx2].dbbecrtid,g_inaa5_d[g_detail_idx2].dbbecrtdp,g_inaa5_d[g_detail_idx2].dbbecrtdt, 
                  g_inaa5_d[g_detail_idx2].dbbemodid,g_inaa5_d[g_detail_idx2].dbbemoddt) 
         WHERE dbbeent = g_enterprise
           AND dbbesite = ps_keys_bak[1] AND dbbe001 = ps_keys_bak[2] AND dbbe002 = ps_keys_bak[3]      
      #160905-00003#4 160905 by lori add---(E)  
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbe_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbe_t" 
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
 
   LET ls_group = "dbbf_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbbf_t" THEN
   
      #add-point:update_b段修改前
      #170120-00038#1 mark by beckxie(將下方剛性註解)
#      #end add-point    
#      
#      UPDATE dbbf_t 
#         SET (dbbfsite,dbbf001,dbbf002,dbbf003
#              ,dbbfstus,dbbfownid,dbbfowndp,dbbfcrtid,dbbfcrtdp,dbbfcrtdt,dbbfmodid,dbbfmoddt) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
#              ,g_inaa6_d[g_detail_idx2].dbbfstus,g_inaa7_d[g_detail_idx2].dbbfownid,g_inaa7_d[g_detail_idx2].dbbfowndp, 
#                  g_inaa7_d[g_detail_idx2].dbbfcrtid,g_inaa7_d[g_detail_idx2].dbbfcrtdp,g_inaa7_d[g_detail_idx2].dbbfcrtdt, 
#                  g_inaa7_d[g_detail_idx2].dbbfmodid,g_inaa7_d[g_detail_idx2].dbbfmoddt) 
#         WHERE dbbfsite = ps_keys_bak[1] AND dbbf001 = ps_keys_bak[2] AND dbbf002 = ps_keys_bak[3] AND dbbf003 = ps_keys_bak[4]
# 
#      #add-point:update_b段修改中
      #160905-00003#4 160905 by lori add---(S)  
      #加ENT過濾條件
      UPDATE dbbf_t 
         SET (dbbfsite,dbbf001,dbbf002,dbbf003
              ,dbbfstus,dbbfownid,dbbfowndp,dbbfcrtid,dbbfcrtdp,dbbfcrtdt,dbbfmodid,dbbfmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_inaa6_d[g_detail_idx2].dbbfstus,g_inaa7_d[g_detail_idx2].dbbfownid,g_inaa7_d[g_detail_idx2].dbbfowndp, 
                  g_inaa7_d[g_detail_idx2].dbbfcrtid,g_inaa7_d[g_detail_idx2].dbbfcrtdp,g_inaa7_d[g_detail_idx2].dbbfcrtdt, 
                  g_inaa7_d[g_detail_idx2].dbbfmodid,g_inaa7_d[g_detail_idx2].dbbfmoddt) 
         WHERE dbbfent = g_enterprise
           AND dbbfsite = ps_keys_bak[1] AND dbbf001 = ps_keys_bak[2] 
           AND dbbf002 = ps_keys_bak[3] AND dbbf003 = ps_keys_bak[4]
      #160905-00003#4 160905 by lori add---(E) 
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbf_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbf_t" 
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
 
{<section id="adbi260.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION adbi260_key_update_b()
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
   #end add-point
 
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.inaasite <> g_master_t.inaasite THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.inaa001 <> g_master_t.inaa001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前
 
#   #end add-point
#   
#   UPDATE dbbd_t 
#      SET (dbbdsite,dbbd001) 
#           = 
#          (g_master.inaasite,g_master.inaa001) 
#      WHERE 
#           dbbdsite = g_master_t.inaasite
#           AND dbbd001 = g_master_t.inaa001
# 
#           
#   #add-point:update_b段修改中
   #160905-00003#4 160905 by lori add---(S)  
   #加ENT過濾條件
   UPDATE dbbd_t 
      SET (dbbdsite,dbbd001) 
           = 
          (g_master.inaasite,g_master.inaa001) 
      WHERE dbbdent = g_enterprise
        AND dbbdsite = g_master_t.inaasite
        AND dbbd001 = g_master_t.inaa001   
   #160905-00003#4 160905 by lori add---(E) 
   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "dbbd_t" 
      #   LET g_errparam.code   = "std-00009" 
      #   LET g_errparam.popup  = TRUE 
      #   CALL cl_err()
 
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後
   
   #end add-point
 
   #add-point:update_b段修改前
 
#   #end add-point
#   
#   UPDATE dbbe_t 
#      SET (dbbesite,dbbe001) 
#           = 
#          (g_master.inaasite,g_master.inaa001) 
#      WHERE 
#           dbbesite = g_master_t.inaasite
#           AND dbbe001 = g_master_t.inaa001
# 
#           
#   #add-point:update_b段修改中
   #160905-00003#4 160905 by lori add---(S)  
   #加ENT過濾條件
   UPDATE dbbe_t 
      SET (dbbesite,dbbe001) 
           = 
          (g_master.inaasite,g_master.inaa001) 
      WHERE dbbeent = g_enterprise
        AND dbbesite = g_master_t.inaasite
        AND dbbe001 = g_master_t.inaa001   
   #160905-00003#4 160905 by lori add---(E)  
   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "dbbe_t" 
      #   LET g_errparam.code   = "std-00009" 
      #   LET g_errparam.popup  = TRUE 
      #   CALL cl_err()
 
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbe_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後
   
   #end add-point
 
   #add-point:update_b段修改前
 
#   #end add-point
#   
#   UPDATE dbbf_t 
#      SET (dbbfsite,dbbf001) 
#           = 
#          (g_master.inaasite,g_master.inaa001) 
#      WHERE 
#           dbbfsite = g_master_t.inaasite
#           AND dbbf001 = g_master_t.inaa001
# 
#           
#   #add-point:update_b段修改中
   #160905-00003#4 160905 by lori add---(S)  
   #加ENT過濾條件
   UPDATE dbbf_t 
      SET (dbbfsite,dbbf001) 
           = 
          (g_master.inaasite,g_master.inaa001) 
      WHERE dbbfent = g_enterprise
        AND dbbfsite = g_master_t.inaasite
        AND dbbf001 = g_master_t.inaa001   
   #160905-00003#4 160905 by lori add---(E)        
   #end add-point
           
   CASE
      #WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "dbbf_t" 
      #   LET g_errparam.code   = "std-00009" 
      #   LET g_errparam.popup  = TRUE 
      #   CALL cl_err()
 
      #   CALL s_transaction_end('N','0')
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbf_t" 
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
 
{<section id="adbi260.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi260_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL adbi260_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "inaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi260_bcl USING g_enterprise,
                                       g_inaa_d[g_detail_idx].inaasite,g_inaa_d[g_detail_idx].inaa001 
 
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi260_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "dbbd_t,"
   #僅鎖定自身table
   LET ls_group = "dbbd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbi260_bcl2 USING g_enterprise,
                                             g_master.inaasite,g_master.inaa001,
                                             g_inaa2_d[g_detail_idx2].dbbd002,g_inaa2_d[g_detail_idx2].dbbd003 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi260_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "dbbe_t,"
   #僅鎖定自身table
   LET ls_group = "dbbe_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbi260_bcl3 USING g_enterprise,
                                             g_master.inaasite,g_master.inaa001,
                                             g_inaa4_d[g_detail_idx2].dbbe002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi260_bcl3" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "dbbf_t,"
   #僅鎖定自身table
   LET ls_group = "dbbf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbi260_bcl4 USING g_enterprise,
                                             g_master.inaasite,g_master.inaa001,
                                             g_inaa6_d[g_detail_idx2].dbbf002,g_inaa6_d[g_detail_idx2].dbbf003 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi260_bcl4" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi260_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi260_bcl
   END IF
   
 
    
   LET ls_group = "dbbd_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi260_bcl2
   END IF
 
   LET ls_group = "dbbe_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi260_bcl3
   END IF
 
   LET ls_group = "dbbf_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi260_bcl4
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi260.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION adbi260_idx_chk(ps_loc)
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num5
   DEFINE li_cnt   LIKE type_t.num5
   #add-point:idx_chk段define
   
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
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_inaa2_d.getLength() THEN
         LET g_detail_idx2 = g_inaa2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inaa2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
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
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_inaa4_d.getLength() THEN
         LET g_detail_idx2 = g_inaa4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inaa4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_inaa4_d.getLength()
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx2 > g_inaa5_d.getLength() THEN
         LET g_detail_idx2 = g_inaa5_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inaa5_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_inaa5_d.getLength()
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx2 > g_inaa6_d.getLength() THEN
         LET g_detail_idx2 = g_inaa6_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inaa6_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_inaa6_d.getLength()
   END IF
   IF g_current_page = 7 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail7")
      IF g_detail_idx2 > g_inaa7_d.getLength() THEN
         LET g_detail_idx2 = g_inaa7_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inaa7_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_inaa7_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_inaa2_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa2_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_inaa3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa3_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_inaa4_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa4_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_inaa5_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa5_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_inaa6_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa6_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_inaa7_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa7_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbi260.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION adbi260_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_inaa_d[l_ac].inaasite
   LET g_pk_array[1].column = 'inaasite'
   LET g_pk_array[2].values = g_inaa_d[l_ac].inaa001
   LET g_pk_array[2].column = 'inaa001'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="adbi260.state_change" >}
    
 
{</section>}
 
{<section id="adbi260.func_signature" >}
   
 
{</section>}
 
{<section id="adbi260.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adbi260.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取屬性值說明
# Memo...........:
# Usage..........: CALL adbi260_dbbd003_ref()
# Date & Author..: 2014/07/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi260_dbbd003_ref()
   DEFINE l_acc_code   LIKE oocq_t.oocq001
   DEFINE l_imaal004   LIKE imaal_t.imaal004
   
   CASE g_inaa2_d[l_ac].dbbd002
      WHEN '3'   #品牌
         LET l_acc_code = '2002'
      WHEN '4'   #系列
         LET l_acc_code = '2003'
      WHEN '5'   #型別 
         LET l_acc_code = '2004'
      WHEN '6'   #功能 
         LET l_acc_code = '2005'
      WHEN '7'   #價格帶
         LET l_acc_code = '2001'
      WHEN '8'   #其他屬性一
         LET l_acc_code = '2006'
      WHEN '9'   #其他屬性二
         LET l_acc_code = '2007'
      WHEN '10'  #其他屬性三
         LET l_acc_code = '2008'
      WHEN '11'  #其他屬性四
         LET l_acc_code = '2009'
      WHEN '12'  #其他屬性五
         LET l_acc_code = '2010'
      WHEN '13'  #其他屬性六
         LET l_acc_code = '2011'
      WHEN '14'  #其他屬性七
         LET l_acc_code = '2012'
      WHEN '15'  #其他屬性八
         LET l_acc_code = '2013'
      WHEN '16'  #其他屬性九
         LET l_acc_code = '2014'
      WHEN '17'  #其他屬性十
         LET l_acc_code = '2015'                  
   END CASE
   
   CASE g_inaa2_d[l_ac].dbbd002
      WHEN '1'   #產品編號
         CALL s_desc_get_item_desc(g_inaa2_d[l_ac].dbbd003)
            RETURNING g_inaa2_d[l_ac].dbbd003_desc,l_imaal004
      WHEN '2'   #產品品類
         CALL s_desc_get_rtaxl003_desc(g_inaa2_d[l_ac].dbbd003)
            RETURNING g_inaa2_d[l_ac].dbbd003_desc 
      OTHERWISE
         CALL s_desc_get_acc_desc(l_acc_code,g_inaa2_d[l_ac].dbbd003)
            RETURNING g_inaa2_d[l_ac].dbbd003_desc  
   END CASE
   DISPLAY BY NAME g_inaa2_d[l_ac].dbbd003_desc
END FUNCTION

 
{</section>}
 
