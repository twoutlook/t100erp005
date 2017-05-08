#該程式已解開Section, 不再透過樣板產出!
{<section id="aimp400.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000069
#+ 
#+ Filename...: aimp400
#+ Description: 料件引入營運據點批次作業
#+ Creator....: 02295(2014/08/25)
#+ Modifier...: 02295(2014/08/29) -SD/PR- 06948
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aimp400.global" >}
#160728-00010#1 2016/07/28 By 06948 撈取料號時依據登入企業的ENT
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
 
#模組變數(Module Variables)
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
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)
       sel      LIKE type_t.chr1,
       imaa001  LIKE imaa_t.imaa001,
       imaal003 LIKE imaal_t.imaal003,
       imaal004 LIKE imaal_t.imaal004,
       imaa009  LIKE imaa_t.imaa009,
       rtaxl003 LIKE rtaxl_t.rtaxl003
      END RECORD 
DEFINE g_imaa    RECORD
          imaa001 STRING, 
          imaa009 STRING,
          imaacrtdt LIKE type_t.dat,
          a LIKE type_t.chr1,
          b LIKE type_t.chr1
       END RECORD
DEFINE g_detail_idx         LIKE type_t.num5         
#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明
TYPE type_g_detail2_d RECORD
       sel      LIKE type_t.chr1,
       ooef001  LIKE ooef_t.ooef001,
       ooefl003 LIKE ooefl_t.ooefl004
      END RECORD
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d 
DEFINE g_detail2_idx         LIKE type_t.num5
DEFINE g_count1      LIKE type_t.num5
DEFINE g_count2      LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="aimp400.main" >}
#+ 作業開始 
MAIN
   DEFINE ls_js  STRING
   #add-point:main段define
   
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aim","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   CREATE TEMP TABLE aimp400_tmp
   (
      imaa001    VARCHAR(40)
   );
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimp400 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimp400_init()   
 
      #進入選單 Menu (="N")
      CALL aimp400_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aimp400
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aimp400_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aimp400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aimp400_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc("b",'5435')
   LET g_count1 = 0
   LET g_count2 = 0
   LET g_imaa.a = 'N'
   CALL cl_set_comp_entry("b",FALSE)
   LET g_imaa.b = ''
   LET g_imaa.imaacrtdt = ''  
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimp400_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE ls_result   STRING
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   #2015/06/30 by stellar add ----- (S)
   IF NOT cl_null(g_argv[1]) THEN
      LET g_imaa.imaa001 = g_argv[1]
      DISPLAY g_imaa.imaa001 TO imaa001
      LET g_wc = " imaa001 = '",g_argv[1],"'"
      CALL aimp400_query()
   END IF
   #2015/06/30 by stellar add ----- (E)
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         CONSTRUCT BY NAME g_wc ON imaa001,imaa009,imaacrtdt
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_imaa.imaa001,g_imaa.imaa009,g_imaa.imaacrtdt
   
            AFTER FIELD imaa001
               LET g_imaa.imaa001 = GET_FLDBUF(imaa001)
   
            AFTER FIELD imaa009
               LET g_imaa.imaa009 = GET_FLDBUF(imaa009)

            AFTER FIELD imaacrtdt
               LET g_imaa.imaacrtdt = GET_FLDBUF(imaacrtdt)
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)
               
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                    #返回原欄位
   
            ON ACTION controlp INFIELD imaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa001      #顯示到畫面上
               NEXT FIELD imaa001                         #返回原欄位

         END CONSTRUCT
         INPUT BY NAME g_imaa.a,g_imaa.b ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT 
                        
            ON CHANGE a
               IF g_imaa.a = 'Y' THEN 
                  LET g_imaa.b = '1'
                  CALL cl_set_comp_entry("b",TRUE)
               ELSE
                  CALL cl_set_comp_entry("b",FALSE)
                  LET g_imaa.b = ''
               END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段input
         INPUT ARRAY g_detail_d FROM s_detail1.* ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
            BEFORE INPUT

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
                  
            ON CHANGE sel
              IF g_detail_d[l_ac].sel = 'Y' THEN 
                 LET g_count1 = g_count1 + 1
              ELSE
                 LET g_count1 = g_count1 - 1
              END IF                   
         END INPUT
         
         INPUT ARRAY g_detail2_d FROM s_detail2.* ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
            BEFORE INPUT

            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail2_idx
               DISPLAY g_detail2_idx TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
                                 
            ON CHANGE l_sel
              IF g_detail2_d[l_ac].sel = 'Y' THEN 
                 LET g_count2 = g_count2 + 1
              ELSE
                 LET g_count2 = g_count2 - 1
              END IF            
         END INPUT          
         #end add-point
         #add-point:ui_dialog段自定義display array
       
         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)     
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall
             LET g_count1 = g_detail_d.getLength()
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone
             LET g_count1 = 0
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
            LET g_count1 = g_count1 + 1
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel
            LET g_count1 = g_count1 - 1
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aimp400_filter()
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
 
         ON ACTION accept
            #CALL aimp400_query() 
            ACCEPT DIALOG            
                         
         # 條件清除
         ON ACTION qbeclear
            LET g_imaa.imaa001 = ''
            LET g_imaa.imaa009 = ''
            DISPLAY BY NAME g_imaa.*
            
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aimp400_b_fill()
            CALL aimp400_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION site_all
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx].sel = "Y"
            END FOR
        
         ON ACTION site_unall
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx].sel = "N"
            END FOR
            
         ON ACTION batch_execute
            CALL aimp400_execute()
            CALL aimp400_query()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
            
         AFTER DIALOG
            CALL aimp400_query()         
      END DIALOG
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aimp400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimp400_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   DEFINE l_date  DATETIME YEAR TO SECOND
   #end add-point 
   
   #add-point:cs段after_construct
   #DISPLAY BY NAME g_imaa.imaa001,g_imaa.imaa009,g_imaa.imaacrtdt
   LET l_date = cl_get_current()
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
   IF NOT cl_null(g_wc_filter) THEN 
      LET g_wc = g_wc," AND ",g_wc_filter
   END IF
   
   DELETE FROM aimp400_tmp;
   
   
   LET g_sql = " INSERT INTO aimp400_tmp SELECT imaa001 FROM imaa_t ",
               "  WHERE imaaent = '",g_enterprise,"' AND ",g_wc," AND imaastus='Y' AND rownum < = ",g_max_rec
   PREPARE aimp200_pre1 FROM g_sql
   EXECUTE aimp200_pre1 

   IF g_imaa.a = 'Y' THEN 
      IF g_imaa.b = '1' THEN 
         LET g_sql = " INSERT INTO aimp400_tmp ",
                     " SELECT bmba003 FROM bmba_t,bmaa_t ",
                     "  WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
                     "  START WITH bmba001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND ",g_wc,")",
                     "         AND bmbaent = '",g_enterprise,"' AND bmbasite = 'ALL' ",
                     "         AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= '",l_date,"'",
                     "         AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > '",l_date,"' OR bmba006 IS NULL)",
                     " CONNECT BY PRIOR bmba001 = bmba003 AND PRIOR bmba002 = bmba002 AND PRIOR bmbaent = bmbaent ",
                     "   AND PRIOR bmbasite = bmbasite "                      
      ELSE
         LET g_sql = " INSERT INTO aimp400_tmp",
                     " SELECT bmba003 FROM bmba_t,bmaa_t ",
                     "  WHERE bmbaent = bmaaent AND bmbasite = bmaasite AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
                     "  START WITH bmba001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND ",g_wc,")",
                     "         AND bmbaent = '",g_enterprise,"' AND bmbasite = 'ALL' ",
                     "         AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= '",l_date,"'",
                     "         AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > '",l_date,"' OR bmba006 IS NULL)",
                     " CONNECT BY bmba001 = PRIOR bmba003 AND bmba002 = PRIOR bmba002 AND bmbaent = PRIOR bmbaent ",
                     "   AND bmbasite = PRIOR bmbasite "        
      END IF
      PREPARE aimp200_pre2 FROM g_sql
      EXECUTE aimp200_pre2       
   END IF  
   #end add-point
        
   LET g_error_show = 1
   CALL aimp400_b_fill()
   LET l_ac = g_master_idx
   CALL aimp400_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aimp400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aimp400_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
 
   #end add-point
 
   #add-point:b_fill段sql_before

   LET g_sql = " SELECT DISTINCT 'N',aimp400_tmp.imaa001,imaal003,imaal004,imaa009,rtaxl003 ",
               "   FROM aimp400_tmp,imaa_t ",
               "   LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND imaal001 = imaa_t.imaa001 AND imaal002 ='",g_dlang,"'",
               "   LEFT OUTER JOIN rtaxl_t ON rtaxlent = ? AND rtaxl001 = imaa009 AND rtaxl002 ='",g_dlang,"'",
               "  WHERE aimp400_tmp.imaa001 = imaa_t.imaa001",
               "    AND imaaent = '",g_enterprise,"' ",     #160728-00010#1 add
               " ORDER BY aimp400_tmp.imaa001 "               
   #end add-point
 
   PREPARE aimp400_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aimp400_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into
        g_detail_d[l_ac].sel,g_detail_d[l_ac].imaa001,g_detail_d[l_ac].imaal003,
        g_detail_d[l_ac].imaal004,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].rtaxl003
   #end add-point
   
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
      
      CALL aimp400_detail_show()      
 
      LET l_ac = l_ac + 1
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
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身)
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aimp400_sel
   
   LET l_ac = 1
   CALL aimp400_fetch()
   #add-point:b_fill段資料填充(其他單身)
  
   CALL g_detail2_d.clear()
   LET l_ac = 1  
   LET g_sql = " SELECT 'N',ooef001,ooefl004 ",
               "   FROM ooef_t ",
               "   LEFT OUTER JOIN ooefl_t ON ooefent = ooeflent AND ooef001 = ooefl001 AND ooefl002 = '",g_dlang,"'",
               " WHERE ooefent = '",g_enterprise,"' AND ooef201 = 'Y' AND ooefstus = 'Y' AND ooef001 <> 'ALL' ",
               " ORDER BY ooef001"
   PREPARE aimp400_sel2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aimp400_sel2
   FOREACH b_fill_curs2 INTO g_detail2_d[l_ac].sel,g_detail2_d[l_ac].ooef001,g_detail2_d[l_ac].ooefl003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF   
      LET l_ac = l_ac + 1
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
   END FOREACH
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimp400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aimp400_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aimp400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aimp400_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimp400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aimp400_filter()
   #add-point:filter段define

   #end add-point    
  
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define
   CONSTRUCT g_wc_filter ON imaa001,imaa009 FROM s_detail1[1].b_imaa001,s_detail1[1].b_imaa009
     
      BEFORE CONSTRUCT
  
      ON ACTION controlp INFIELD b_imaa009
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_rtax001()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
         NEXT FIELD b_imaa009                    #返回原欄位
   
      ON ACTION controlp INFIELD b_imaa001
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaa001()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaa001      #顯示到畫面上
         NEXT FIELD b_imaa001                         #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aimp400_query()
   CALL aimp400_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aimp400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aimp400_filter_parser(ps_field)
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
 
{<section id="aimp400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aimp400_filter_show(ps_field,ps_object)
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
   LET ls_condition = aimp400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimp400.other_function" >}
#add-point:自定義元件(Function)

PRIVATE FUNCTION aimp400_execute()
DEFINE l_imafsite   LIKE imaf_t.imafsite
DEFINE l_imaa001    LIKE imaa_t.imaa001
DEFINE l_imaa003    LIKE imaa_t.imaa003
DEFINE l_success    LIKE type_t.num5
DEFINE l_chr        STRING
DEFINE l_count      LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_j          LIKE type_t.num5
DEFINE l_idx        LIKE type_t.num5
DEFINE l_stagecomplete LIKE type_t.num10

#   CALL s_transaction_begin()
   LET l_success = TRUE
   LET l_count = 0
   LET l_count = g_count1 * g_count2
   LET l_idx = 1
   IF l_count > 0 THEN 
      FOR l_i = 1 TO g_detail_d.getLength()
         IF g_detail_d[l_i].sel = 'Y' THEN 
            FOR l_j = 1 TO g_detail2_d.getLength()
               IF g_detail2_d[l_j].sel = 'Y' THEN   
                  LET l_chr = g_detail_d[l_i].imaa001," INTO ",g_detail2_d[l_j].ooef001     
                  DISPLAY l_chr TO stagenow
                  LET l_stagecomplete = l_idx* 100/l_count
                  DISPLAY l_stagecomplete TO stagecomplete
                  
                  SELECT imaa003 INTO l_imaa003 FROM imaa_t where imaaent = g_enterprise AND imaa001 = g_detail_d[l_i].imaa001
                  CALL s_aimm200_ins_imaf(g_detail_d[l_i].imaa001,l_imaa003,g_detail2_d[l_j].ooef001) RETURNING l_success,g_errno
                  IF NOT l_success THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_detail_d[l_i].imaa001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()         
                     EXIT FOR
                  END IF
                  LET l_idx = l_idx + 1
               END IF
            END FOR
         END IF
      END FOR      
      
      IF l_success THEN 
         LET l_stagecomplete = 100
         DISPLAY l_stagecomplete TO stagecomplete   
   #      CALL s_transaction_end('Y','0')
         CALL cl_ask_confirm3("std-00012","")
      ELSE  
   #      CALL s_transaction_end('N','0')
         CALL cl_ask_confirm3("adz-00218","")
   END IF
   END IF
   LET l_chr = ''     
   DISPLAY l_chr TO stagenow
   LET l_stagecomplete = 0
   DISPLAY l_stagecomplete TO stagecomplete   
END FUNCTION

#end add-point
 
{</section>}
 
