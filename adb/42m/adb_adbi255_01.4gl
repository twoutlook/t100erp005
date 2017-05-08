#該程式已解開Section, 不再透過樣板產出!
{<section id="adbi255_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000104
#+ 
#+ Filename...: adbi255_01
#+ Description: ...
#+ Creator....: 02749(2014/05/02)
#+ Modifier...: 02749(2014/05/13)
#+ Buildtype..: 應用 i02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="adbi255_01.global" >}
#160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01,adbi255_01_reorder ——> adbi255_tmp02
#170120-00038#1   17/01/23 By 06814 修正WHERE 條件沒下ent
 
IMPORT os
IMPORT util
#add-point:增加匯入項目
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_dbaf_d RECORD
       dbaf0041 LIKE type_t.chr80, 
   dbaf004 LIKE dbaf_t.dbaf004, 
   dbaf001 LIKE dbaf_t.dbaf001, 
   dbaf002 LIKE dbaf_t.dbaf002, 
   dbaf003 LIKE dbaf_t.dbaf003, 
   dbaf003_desc LIKE type_t.chr500, 
   dbad002 LIKE type_t.chr80, 
   dbad002_desc LIKE type_t.chr500, 
   dbaf011 LIKE dbaf_t.dbaf011, 
   dbaf012 LIKE dbaf_t.dbaf012, 
   dbaf013 LIKE dbaf_t.dbaf013, 
   dbaf014 LIKE dbaf_t.dbaf014, 
   dbaf015 LIKE dbaf_t.dbaf015
       END RECORD
 
 
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_dbaf_d          DYNAMIC ARRAY OF type_g_dbaf_d
DEFINE g_dbaf_d_t        type_g_dbaf_d
 
      
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
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_dbaf001      LIKE dbaf_t.dbaf001
DEFINE g_dbaf002      LIKE dbaf_t.dbaf002
DEFINE g_dbaf003      LIKE dbaf_t.dbaf003   #Special UI,最後選取筆的KEY值紀錄,資料移動後,重新指向該筆
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adbi255_01.main" >}
#+ 此段落由子樣板a27產生
#+ 資料輸入
PUBLIC FUNCTION adbi255_01(--)
   #add-point:main段變數傳入
   p_dbaf001,p_dbaf002
   #end add-point
   )
   #add-point:main段define
   DEFINE p_dbaf001   LIKE dbaf_t.dbaf001   #路線編號
   DEFINE p_dbaf002   LIKE dbaf_t.dbaf002   #類型
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   IF cl_null(p_dbaf001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00043'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   LET g_dbaf001 = p_dbaf001
   LET g_dbaf002 = p_dbaf002
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
 
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   DECLARE adbi255_01_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE adbi255_01_master_referesh FROM g_sql
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_adbi255_01 WITH FORM cl_ap_formpath("adb","adbi255_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL adbi255_01_init()   
 
   #進入選單 Menu (="N")
   CALL adbi255_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_adbi255_01
 
   CLOSE adbi255_01_cl
   
   
 
   #add-point:離開前
   
   #end add-point
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="adbi255_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi255_01_init()
   #add-point:init段define
   DEFINE l_sql   STRING
   #end add-point   
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
   WHENEVER ERROR CONTINUE
   
   DROP TABLE adbi255_01_tmp
   DROP TABLE adbi255_01_sel
   DROP TABLE adbi255_tmp01   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
   DROP TABLE adbi255_tmp02   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02

   CREATE TEMP TABLE adbi255_01_tmp(
      dbafent    SMALLINT,
      dbaf001    VARCHAR(10),
      dbaf002    VARCHAR(1),
      dbaf003    VARCHAR(10),
      dbaf004    SMALLINT, 
      dbaf011    DECIMAL(15,3),
      dbaf012    DECIMAL(15,3),
      dbaf013    DECIMAL(20,6),
      dbaf014    DECIMAL(20,6),
      dbaf015    DECIMAL(20,6))
   
   INSERT INTO adbi255_01_tmp
   SELECT dbafent,dbaf001,dbaf002,dbaf003,dbaf004,
          dbaf011,dbaf012,dbaf013,dbaf014,dbaf015
     FROM dbaf_t
    WHERE dbafent = g_enterprise
      AND dbaf001 = g_dbaf001
      AND dbaf002 = g_dbaf002      

   CREATE TEMP TABLE adbi255_01_sel(
      dbaf001    VARCHAR(10),
      dbaf002    VARCHAR(1),
      dbaf003    VARCHAR(10),
      dbaf004    SMALLINT)

   CREATE TEMP TABLE adbi255_tmp01(  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
      dbaf001    VARCHAR(10),
      dbaf002    VARCHAR(1),
      dbaf003    VARCHAR(10),
      dbaf004    SMALLINT)

   CREATE TEMP TABLE adbi255_tmp02(  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
      dbaf001    VARCHAR(10),
      dbaf002    VARCHAR(1),
      dbaf003    VARCHAR(10),
      dbaf004    SMALLINT,
      dbaf0041   SMALLINT)
      
   LET l_sql = "INSERT INTO adbi255_01_sel VALUES (?,?,?,?)"
   PREPARE adbi255_01_sel_ins FROM l_sql
   
   LET l_sql = "DELETE FROM adbi255_01_sel WHERE dbaf003 = ?"
   PREPARE adbi255_01_sel_del FROM l_sql

   LET l_sql = "INSERT INTO adbi255_tmp01 VALUES (?,?,?,?)"   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
   PREPARE adbi255_tmp01_ins FROM l_sql    #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01

   LET l_sql = "DELETE FROM adbi255_tmp01 WHERE dbaf003 = ?"  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
   PREPARE adbi255_tmp01_del FROM l_sql   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01

   LET l_sql = "INSERT INTO adbi255_tmp02 VALUES (?,?,?,?,?)"  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
   PREPARE adbi255_tmp02_ins FROM l_sql  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
   #end add-point
   
   CALL adbi255_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi255_01_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   #Special UIt--begin---
   DEFINE l_sel_st         LIKE type_t.num5      #多選時的起始路線順序,用於調整後重新顯示資料
   DEFINE l_sel_end        LIKE type_t.num5      #多選時的結束路線順序,用於調整後重新顯示資料
   DEFINE l_sel_cnt        LIKE type_t.num5      #選取的筆數
   DEFINE l_set_rec        LIKE type_t.num5      #設定指標,用於調整後重新顯示資料
   DEFINE l_dbaf003_st     LIKE dbaf_t.dbaf003   #多選時的起始路線順序的站點,用於調整後重新顯示資料
   DEFINE l_dbaf003_end    LIKE dbaf_t.dbaf003   #多選時的結束路線順序的站點,用於調整後重新顯示資料
   #Special UI--end---
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 
 
   #end add-point
   
   WHILE TRUE
   
      CALL adbi255_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dbaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #Special UI--begin---
               IF l_sel_cnt = 0 THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)   #standard                               
               ELSE
                  CALL DIALOG.setSelectionRange("s_detail1",l_sel_st,l_sel_end,1)   #有多選時,要將選取的畫面都反藍
                  LET l_sel_cnt = 0                                                 #重新顯示後,要將選取筆數歸零
               END IF
               #Special UI--end---               
            BEFORE ROW
               #Special UI--begin---
               IF l_sel_cnt = 0 THEN
                  LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")   #standard          
               ELSE
                  LET g_detail_idx =l_set_rec
               END IF
               #Special UI--end---   
               
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #add-point:display array-before row

               #end add-point                        
 
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG
            #Special UI--begin---Standard
            #IF g_temp_idx > 0 THEN
            #   LET l_ac = g_temp_idx
            #   CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            #   LET g_temp_idx = 1
            #END IF
            #Special UI--end---
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before
            #Special UI--begin---
            LET l_sel_st  = 0    
            LET l_sel_end = 0    
            LET l_sel_cnt = 0    
            LET l_set_rec = 0    
            LET l_dbaf003_st  = NULL
            LET l_dbaf003_end = NULL
            
              SELECT COUNT(*) INTO l_sel_cnt FROM adbi255_01_sel
              SELECT dbaf003 INTO l_dbaf003_st FROM adbi255_01_sel WHERE dbaf004 = (SELECT MIN(dbaf004)FROM adbi255_01_sel)
              SELECT dbaf003 INTO l_dbaf003_END FROM adbi255_01_sel WHERE dbaf004 = (SELECT MAX(dbaf004)FROM adbi255_01_sel)
              IF l_sel_cnt > 0 THEN
                 FOR li_idx = 1 TO g_dbaf_d.getLength()
                     IF g_dbaf_d[li_idx].dbaf003 = l_dbaf003_st THEN
                        LET l_sel_st = li_idx
                     END IF
                     IF g_dbaf_d[li_idx].dbaf003 = l_dbaf003_end THEN
                        LET l_sel_end = li_idx
                     END IF
                     IF g_dbaf_d[li_idx].dbaf003 = g_dbaf003 THEN
                        LET l_set_rec = li_idx
                     END IF
                 END FOR
              END IF    

            IF l_sel_cnt > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1",l_set_rec)
            ELSE
               IF g_temp_idx > 0 THEN
                  LET l_ac = g_temp_idx
                  CALL DIALOG.setCurrentRow("s_detail1",l_ac)
                  LET g_temp_idx = 1
               END IF
            END IF
            #Special UI--end---
            #end add-point
            NEXT FIELD CURRENT
      
         
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
               
               #add-point:ON ACTION output
 
               #END add-point
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION move_down
            LET g_action_choice="move_down"
            IF cl_auth_chk_act("move_down") THEN
               
               #add-point:ON ACTION move_down
               LET l_sel_cnt = 0       
               LET g_dbaf003 = NULL    
               #逐筆判斷畫面上的資料有無被選取,並寫到對應的暫存檔
               CALL adbi255_01_reorder_del()   
               FOR li_idx = 1 TO g_dbaf_d.getLength()
                  IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                     LET l_sel_cnt = l_sel_cnt + 1   
                     EXECUTE adbi255_01_sel_ins USING g_dbaf_d[li_idx].dbaf001,g_dbaf_d[li_idx].dbaf002,
                                                      g_dbaf_d[li_idx].dbaf003,g_dbaf_d[li_idx].dbaf0041  
                  ELSE   
                     EXECUTE adbi255_tmp01_ins USING g_dbaf_d[li_idx].dbaf001,g_dbaf_d[li_idx].dbaf002,   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
                                                        g_dbaf_d[li_idx].dbaf003,g_dbaf_d[li_idx].dbaf0041                       
                  END IF
               END FOR 
               IF l_sel_cnt > 0 THEN    
                  #Special UI--begin---
                  LET g_dbaf003 = NULL
                  #判斷游標所在的資料有無被選取
                  #選取   >> dbaf003 = 游標所在的dbaf003
                  #未選取 >> dbaf003 = 所有選取資料中的路線順序最小的dbaf003
                  IF DIALOG.isRowSelected("s_detail1", DIALOG.getCurrentRow("s_detail1")) THEN
                     LET g_dbaf003 = g_dbaf_d[l_ac].dbaf003
                  ELSE
                     SELECT dbaf003 INTO g_dbaf003 FROM adbi255_01_sel
                      WHERE dbaf004 = (SELECT MIN(dbaf004) FROM adbi255_01_sel)
                  END IF                  
                  #Special UI--end---                  
                  IF adbi255_01_move(-1) THEN
                     CALL adbi255_01_b_fill('')               
                  END IF   
               END IF   
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION cancel_update
            LET g_action_choice="cancel_update"
            IF cl_auth_chk_act("cancel_update") THEN
               
               #add-point:ON ACTION cancel_update
               LET g_action_choice = "exit"
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION conf_update
            LET g_action_choice="conf_update"
            IF cl_auth_chk_act("conf_update") THEN
               
               #add-point:ON ACTION conf_update
               CALL adbi255_01_reorder_upd()   
               LET g_action_choice = "exit"
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adbi255_01_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi255_01_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
               
               #add-point:ON ACTION insert

               #END add-point
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
               
               #add-point:ON ACTION delete

               #END add-point
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION move_up
            LET g_action_choice="move_up"
            IF cl_auth_chk_act("move_up") THEN
               
               #add-point:ON ACTION move_up
               LET l_sel_cnt = 0       
               LET g_dbaf003 = NULL    
               #逐筆判斷畫面上的資料有無被選取,並寫到對應的暫存檔
               CALL adbi255_01_reorder_del()   
               FOR li_idx = 1 TO g_dbaf_d.getLength()
                  IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                     LET l_sel_cnt = l_sel_cnt + 1   
                     EXECUTE adbi255_01_sel_ins USING g_dbaf_d[li_idx].dbaf001,g_dbaf_d[li_idx].dbaf002,
                                                      g_dbaf_d[li_idx].dbaf003,g_dbaf_d[li_idx].dbaf0041
                  ELSE   
                     EXECUTE adbi255_tmp01_ins USING g_dbaf_d[li_idx].dbaf001,g_dbaf_d[li_idx].dbaf002,   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
                                                        g_dbaf_d[li_idx].dbaf003,g_dbaf_d[li_idx].dbaf0041                       
                  END IF
               END FOR 
               IF l_sel_cnt > 0 THEN    
                  #Special UI--begin---
                  LET g_dbaf003 = NULL
                  #判斷游標所在的資料有無被選取
                  #選取   >> dbaf003 = 游標所在的dbaf003
                  #未選取 >> dbaf003 = 所有選取資料中的路線順序最小的dbaf003
                  IF DIALOG.isRowSelected("s_detail1", DIALOG.getCurrentRow("s_detail1")) THEN
                     LET g_dbaf003 = g_dbaf_d[l_ac].dbaf003
                  ELSE
                     SELECT dbaf003 INTO g_dbaf003 FROM adbi255_01_sel
                      WHERE dbaf004 = (SELECT MIN(dbaf004) FROM adbi255_01_sel)
                  END IF                  
                  #Special UI--end---                  
                  IF adbi255_01_move(1) THEN
                     CALL adbi255_01_b_fill('')               
                  END IF   
               END IF  
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
               
               #add-point:ON ACTION reproduce

               #END add-point
 
 
      
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
 
{<section id="adbi255_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi255_01_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_dbaf_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dbaf0041,dbaf003,dbad002,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015 
 
         FROM s_detail1[1].dbaf0041,s_detail1[1].dbaf003,s_detail1[1].dbad002,s_detail1[1].dbaf011,s_detail1[1].dbaf012, 
             s_detail1[1].dbaf013,s_detail1[1].dbaf014,s_detail1[1].dbaf015 
      
         
      
         #---------------------<  Detail: page1  >---------------------
         #----<<dbaf0041>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf0041
            #add-point:BEFORE FIELD dbaf0041
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf0041
            
            #add-point:AFTER FIELD dbaf0041
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf0041
         ON ACTION controlp INFIELD dbaf0041
            #add-point:ON ACTION controlp INFIELD dbaf0041
            
            #END add-point
 
         #----<<dbaf004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf004
            #add-point:BEFORE FIELD dbaf004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf004
            
            #add-point:AFTER FIELD dbaf004
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf004
         ON ACTION controlp INFIELD dbaf004
            #add-point:ON ACTION controlp INFIELD dbaf004
            
            #END add-point
 
         #----<<dbaf001>>----
         #----<<dbaf002>>----
         #----<<dbaf003>>----
         #Ctrlp:construct.c.page1.dbaf003
         ON ACTION controlp INFIELD dbaf003
            #add-point:ON ACTION controlp INFIELD dbaf003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaf003  #顯示到畫面上
            NEXT FIELD dbaf003                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf003
            #add-point:BEFORE FIELD dbaf003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf003
            
            #add-point:AFTER FIELD dbaf003
            
            #END add-point
            
 
         #----<<dbaf003_desc>>----
         #----<<dbad002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbad002
            #add-point:BEFORE FIELD dbad002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbad002
            
            #add-point:AFTER FIELD dbad002
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbad002
         ON ACTION controlp INFIELD dbad002
            #add-point:ON ACTION controlp INFIELD dbad002
            
            #END add-point
 
         #----<<dbad002_desc>>----
         #----<<dbaf011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf011
            #add-point:BEFORE FIELD dbaf011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf011
            
            #add-point:AFTER FIELD dbaf011
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf011
         ON ACTION controlp INFIELD dbaf011
            #add-point:ON ACTION controlp INFIELD dbaf011
            
            #END add-point
 
         #----<<dbaf012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf012
            #add-point:BEFORE FIELD dbaf012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf012
            
            #add-point:AFTER FIELD dbaf012
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf012
         ON ACTION controlp INFIELD dbaf012
            #add-point:ON ACTION controlp INFIELD dbaf012
            
            #END add-point
 
         #----<<dbaf013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf013
            #add-point:BEFORE FIELD dbaf013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf013
            
            #add-point:AFTER FIELD dbaf013
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf013
         ON ACTION controlp INFIELD dbaf013
            #add-point:ON ACTION controlp INFIELD dbaf013
            
            #END add-point
 
         #----<<dbaf014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf014
            #add-point:BEFORE FIELD dbaf014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf014
            
            #add-point:AFTER FIELD dbaf014
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf014
         ON ACTION controlp INFIELD dbaf014
            #add-point:ON ACTION controlp INFIELD dbaf014
            
            #END add-point
 
         #----<<dbaf015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf015
            #add-point:BEFORE FIELD dbaf015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf015
            
            #add-point:AFTER FIELD dbaf015
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dbaf015
         ON ACTION controlp INFIELD dbaf015
            #add-point:ON ACTION controlp INFIELD dbaf015
            
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
         EXIT DIALOG
      
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
   END IF
    
   LET g_error_show = 1
   CALL adbi255_01_b_fill(g_wc2)
   
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbi255_01_insert()
   DEFINE li_ac LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point 
   
   #輸入前動作  
   LET li_ac = l_ac 
   LET l_ac = 1   
   LET g_before_input_done = FALSE                                        
   CALL adbi255_01_set_entry_b("a")  
   
   CALL adbi255_01_set_no_entry_b("a")                                          
   LET g_before_input_done = TRUE                                            
   
   #append欄位         
      
 
 
   
   #add-point:insert段before insert
   
   #end add-point  
 
   #資料輸入
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      INPUT g_dbaf_d[1].* FROM s_detail1[1].*
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
         
      END INPUT
      
 
      
      BEFORE DIALOG 
   
   END DIALOG
   
   #輸入後動作
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      LET INT_FLAG = 1
      RETURN
   END IF
   
   CALL s_transaction_begin()                    
   
   #add-point:單身新增前
   
   #end add-point
   
   
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbi255_01_modify()
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
   DEFINE  l_set_ac               LIKE type_t.num5
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:modify段define_sql
 
#   #end add-point 
#   LET g_forupd_sql = "SELECT '',dbaf004,dbaf001,dbaf002,dbaf003,'','','',dbaf011,dbaf012,dbaf013,dbaf014, 
#       dbaf015 FROM dbaf_t WHERE dbafent=? AND dbaf001=? AND dbaf002=? AND dbaf003=? FOR UPDATE"
   #add-point:modify段define_sql
   LET g_forupd_sql = "SELECT '',dbaf004,dbaf001,dbaf002,dbaf003,'','','',dbaf011,dbaf012, ",
                      "       dbaf013,dbaf014,dbaf015 ",
                      "  FROM adbi255_01_tmp ",
                      " WHERE dbafent=? AND dbaf001=? AND dbaf002=? AND dbaf003=? FOR UPDATE"                       
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi255_01_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
 
   #add-point:modify段修改前

   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbaf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbi255_01_b_fill(g_wc2)
            LET g_detail_cnt = g_dbaf_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            LET l_set_ac = DIALOG.getCurrentRow("s_detail1")            
            IF g_dbaf_d[l_set_ac].dbaf0041 = 0 THEN   
               IF l_set_ac = g_dbaf_d.getLength() THEN
                  LET l_set_ac = l_set_ac - 1
               ELSE
                  LET l_set_ac = l_set_ac + 1
               END IF               
               CALL DIALOG.setCurrentRow("s_detail1",l_set_ac)
            END IF
            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_dbaf_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbaf_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbaf_d[l_ac].dbaf001 IS NOT NULL
               AND g_dbaf_d[l_ac].dbaf002 IS NOT NULL
               AND g_dbaf_d[l_ac].dbaf003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbaf_d_t.* = g_dbaf_d[l_ac].*  #BACKUP
               IF NOT adbi255_01_lock_b("dbaf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi255_01_bcl INTO g_dbaf_d[l_ac].dbaf0041,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf001, 
                      g_dbaf_d[l_ac].dbaf002,g_dbaf_d[l_ac].dbaf003,g_dbaf_d[l_ac].dbaf003_desc,g_dbaf_d[l_ac].dbad002, 
                      g_dbaf_d[l_ac].dbad002_desc,g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013, 
                      g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_dbaf_d_t.dbaf001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL adbi255_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            LET g_dbaf_d[l_ac].dbaf0041 = g_dbaf_d_t.dbaf0041
            CALL adbi255_01_set_entry_b(l_cmd)  
            CALL adbi255_01_set_no_entry_b(l_cmd) 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbaf_d_t.* TO NULL
            INITIALIZE g_dbaf_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            
            LET g_dbaf_d_t.* = g_dbaf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi255_01_set_entry_b("a")
            CALL adbi255_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbaf_d[li_reproduce_target].* = g_dbaf_d[li_reproduce].*
 
               LET g_dbaf_d[g_dbaf_d.getLength()].dbaf001 = NULL
               LET g_dbaf_d[g_dbaf_d.getLength()].dbaf002 = NULL
               LET g_dbaf_d[g_dbaf_d.getLength()].dbaf003 = NULL
 
            END IF
            
            #add-point:modify段before insert

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
            SELECT COUNT(*) INTO l_count FROM dbaf_t 
             WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_d[l_ac].dbaf001
                                       AND dbaf002 = g_dbaf_d[l_ac].dbaf002
                                       AND dbaf003 = g_dbaf_d[l_ac].dbaf003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaf_d[g_detail_idx].dbaf001
               LET gs_keys[2] = g_dbaf_d[g_detail_idx].dbaf002
               LET gs_keys[3] = g_dbaf_d[g_detail_idx].dbaf003
               CALL adbi255_01_insert_b('dbaf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_dbaf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbaf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi255_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (dbaf001 = '", g_dbaf_d[l_ac].dbaf001, "' "
                                  ," AND dbaf002 = '", g_dbaf_d[l_ac].dbaf002, "' "
                                  ," AND dbaf003 = '", g_dbaf_d[l_ac].dbaf003, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_dbaf_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_dbaf_d.deleteElement(l_ac)
               NEXT FIELD dbaf001
            END IF
            IF g_dbaf_d[l_ac].dbaf001 IS NOT NULL
               AND g_dbaf_d_t.dbaf002 IS NOT NULL
               AND g_dbaf_d_t.dbaf003 IS NOT NULL
 
               THEN     
            
               #add-point:單身刪除ask前

               #end add-point   
               
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
               
               DELETE FROM dbaf_t
                WHERE dbafent = g_enterprise AND 
                      dbaf001 = g_dbaf_d_t.dbaf001
                      AND dbaf002 = g_dbaf_d_t.dbaf002
                      AND dbaf003 = g_dbaf_d_t.dbaf003
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbaf_t"
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
               CLOSE adbi255_01_bcl
               LET l_count = g_dbaf_d.getLength()
            END IF 
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaf_d[g_detail_idx].dbaf001
               LET gs_keys[2] = g_dbaf_d[g_detail_idx].dbaf002
               LET gs_keys[3] = g_dbaf_d[g_detail_idx].dbaf003
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL adbi255_01_delete_b('dbaf_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dbaf0041>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf0041
            #add-point:BEFORE FIELD dbaf0041

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf0041
            
            #add-point:AFTER FIELD dbaf0041

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf0041
            #add-point:ON CHANGE dbaf0041

            #END add-point
 
         #----<<dbaf004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf004
            #add-point:BEFORE FIELD dbaf004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf004
            
            #add-point:AFTER FIELD dbaf004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf004
            #add-point:ON CHANGE dbaf004

            #END add-point
 
         #----<<dbaf001>>----
         #----<<dbaf002>>----
         #----<<dbaf003>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbaf003
            
            #add-point:AFTER FIELD dbaf003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbaf_d[l_ac].dbaf003
            CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbaf_d[l_ac].dbaf003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbaf_d[l_ac].dbaf003_desc


            #此段落由子樣板a05產生
            IF  g_dbaf_d[g_detail_idx].dbaf001 IS NOT NULL AND g_dbaf_d[g_detail_idx].dbaf002 IS NOT NULL AND g_dbaf_d[g_detail_idx].dbaf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbaf_d[g_detail_idx].dbaf001 != g_dbaf_d_t.dbaf001 OR g_dbaf_d[g_detail_idx].dbaf002 != g_dbaf_d_t.dbaf002 OR g_dbaf_d[g_detail_idx].dbaf003 != g_dbaf_d_t.dbaf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbaf_t WHERE "||"dbafent = '" ||g_enterprise|| "' AND "||"dbaf001 = '"||g_dbaf_d[g_detail_idx].dbaf001 ||"' AND "|| "dbaf002 = '"||g_dbaf_d[g_detail_idx].dbaf002 ||"' AND "|| "dbaf003 = '"||g_dbaf_d[g_detail_idx].dbaf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf003
            #add-point:BEFORE FIELD dbaf003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf003
            #add-point:ON CHANGE dbaf003

            #END add-point
 
         #----<<dbaf003_desc>>----
         #----<<dbad002>>----
         #此段落由子樣板a02產生
         AFTER FIELD dbad002
            
            #add-point:AFTER FIELD dbad002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbaf_d[l_ac].dbad002
            CALL ap_ref_array2(g_ref_fields,"SELECT dbacl003 FROM dbacl_t WHERE dbaclent='"||g_enterprise||"' AND dbacl001=? AND dbacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbaf_d[l_ac].dbad002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbaf_d[l_ac].dbad002_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dbad002
            #add-point:BEFORE FIELD dbad002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE dbad002
            #add-point:ON CHANGE dbad002

            #END add-point
 
         #----<<dbad002_desc>>----
         #----<<dbaf011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf011
            #add-point:BEFORE FIELD dbaf011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf011
            
            #add-point:AFTER FIELD dbaf011
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf011) 
               AND (g_dbaf_d[l_ac].dbaf011 != g_dbaf_d_t.dbaf011 OR cl_null(g_dbaf_d_t.dbaf011)) THEN
               IF g_dbaf_d[l_ac].dbaf011 <= 0 THEN
                  LET g_dbaf_d[l_ac].dbaf011 = g_dbaf_d_t.dbaf011
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD dbaf011
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf011
            #add-point:ON CHANGE dbaf011

            #END add-point
 
         #----<<dbaf012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf012
            #add-point:BEFORE FIELD dbaf012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf012
            
            #add-point:AFTER FIELD dbaf012
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf012) 
               AND (g_dbaf_d[l_ac].dbaf012 != g_dbaf_d_t.dbaf012 OR cl_null(g_dbaf_d[l_ac].dbaf013)) THEN
               IF g_dbaf_d[l_ac].dbaf012 <= 0 THEN
                  LET g_dbaf_d[l_ac].dbaf012 = g_dbaf_d_t.dbaf012
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD dbaf012
               END IF   
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf012
            #add-point:ON CHANGE dbaf012

            #END add-point
 
         #----<<dbaf013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf013
            #add-point:BEFORE FIELD dbaf013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf013
            
            #add-point:AFTER FIELD dbaf013
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf013) 
               AND (g_dbaf_d[l_ac].dbaf013 != g_dbaf_d_t.dbaf013 OR cl_null(g_dbaf_d[l_ac].dbaf013)) THEN
               IF g_dbaf_d[l_ac].dbaf013 <= 0 THEN
                  LET g_dbaf_d[l_ac].dbaf013 = g_dbaf_d_t.dbaf013
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD dbaf013
               END IF
               CALL adbi255_01_default_dbaf015()
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf013
            #add-point:ON CHANGE dbaf013

            #END add-point
 
         #----<<dbaf014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf014
            #add-point:BEFORE FIELD dbaf014
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf014
            
            #add-point:AFTER FIELD dbaf014
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf014) 
               AND (g_dbaf_d[l_ac].dbaf014 != g_dbaf_d_t.dbaf014 OR cl_null(g_dbaf_d_t.dbaf014))THEN
               IF g_dbaf_d[l_ac].dbaf014 <= 0 THEN
                  LET g_dbaf_d[l_ac].dbaf014 = g_dbaf_d_t.dbaf014
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD dbaf014
               END IF 
               CALL adbi255_01_default_dbaf015()
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf014
            #add-point:ON CHANGE dbaf014

            #END add-point
 
         #----<<dbaf015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dbaf015
            #add-point:BEFORE FIELD dbaf015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dbaf015
            
            #add-point:AFTER FIELD dbaf015
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf015) 
               AND (g_dbaf_d[l_ac].dbaf015 != g_dbaf_d_t.dbaf015 OR cl_null(g_dbaf_d_t.dbaf015)) THEN
               IF g_dbaf_d[l_ac].dbaf015 <= 0 THEN
                  LET g_dbaf_d[l_ac].dbaf015 = g_dbaf_d_t.dbaf015
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD dbaf015
               END IF 
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dbaf015
            #add-point:ON CHANGE dbaf015

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dbaf0041>>----
         #Ctrlp:input.c.page1.dbaf0041
         ON ACTION controlp INFIELD dbaf0041
            #add-point:ON ACTION controlp INFIELD dbaf0041

            #END add-point
 
         #----<<dbaf004>>----
         #Ctrlp:input.c.page1.dbaf004
         ON ACTION controlp INFIELD dbaf004
            #add-point:ON ACTION controlp INFIELD dbaf004

            #END add-point
 
         #----<<dbaf001>>----
         #----<<dbaf002>>----
         #----<<dbaf003>>----
         #Ctrlp:input.c.page1.dbaf003
         ON ACTION controlp INFIELD dbaf003
            #add-point:ON ACTION controlp INFIELD dbaf003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbaf_d[l_ac].dbaf003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dbad001()                                #呼叫開窗

            LET g_dbaf_d[l_ac].dbaf003 = g_qryparam.return1              

            DISPLAY g_dbaf_d[l_ac].dbaf003 TO dbaf003              #

            NEXT FIELD dbaf003                          #返回原欄位


            #END add-point
 
         #----<<dbaf003_desc>>----
         #----<<dbad002>>----
         #Ctrlp:input.c.page1.dbad002
         ON ACTION controlp INFIELD dbad002
            #add-point:ON ACTION controlp INFIELD dbad002

            #END add-point
 
         #----<<dbad002_desc>>----
         #----<<dbaf011>>----
         #Ctrlp:input.c.page1.dbaf011
         ON ACTION controlp INFIELD dbaf011
            #add-point:ON ACTION controlp INFIELD dbaf011

            #END add-point
 
         #----<<dbaf012>>----
         #Ctrlp:input.c.page1.dbaf012
         ON ACTION controlp INFIELD dbaf012
            #add-point:ON ACTION controlp INFIELD dbaf012

            #END add-point
 
         #----<<dbaf013>>----
         #Ctrlp:input.c.page1.dbaf013
         ON ACTION controlp INFIELD dbaf013
            #add-point:ON ACTION controlp INFIELD dbaf013

            #END add-point
 
         #----<<dbaf014>>----
         #Ctrlp:input.c.page1.dbaf014
         ON ACTION controlp INFIELD dbaf014
            #add-point:ON ACTION controlp INFIELD dbaf014

            #END add-point
 
         #----<<dbaf015>>----
         #Ctrlp:input.c.page1.dbaf015
         ON ACTION controlp INFIELD dbaf015
            #add-point:ON ACTION controlp INFIELD dbaf015

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_dbaf_d[l_ac].* = g_dbaf_d_t.*
               CLOSE adbi255_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dbaf_d[l_ac].dbaf001
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_dbaf_d[l_ac].* = g_dbaf_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前
                UPDATE adbi255_01_tmp 
                   SET dbaf011 = g_dbaf_d[l_ac].dbaf011,
                       dbaf012 = g_dbaf_d[l_ac].dbaf012,
                       dbaf013 = g_dbaf_d[l_ac].dbaf013,
                       dbaf014 = g_dbaf_d[l_ac].dbaf014,
                       dbaf015 = g_dbaf_d[l_ac].dbaf015
                WHERE dbafent = g_enterprise 
                  AND dbaf001 = g_dbaf_d_t.dbaf001 
                  AND dbaf002 = g_dbaf_d_t.dbaf002  
                  AND dbaf003 = g_dbaf_d_t.dbaf003 
#               #end add-point
#               
#               UPDATE dbaf_t SET (dbaf004,dbaf001,dbaf002,dbaf003,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015) = (g_dbaf_d[l_ac].dbaf004, 
#                   g_dbaf_d[l_ac].dbaf001,g_dbaf_d[l_ac].dbaf002,g_dbaf_d[l_ac].dbaf003,g_dbaf_d[l_ac].dbaf011, 
#                   g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013,g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015) 
#
#                WHERE dbafent = g_enterprise AND
#                  dbaf001 = g_dbaf_d_t.dbaf001 #項次   
#                  AND dbaf002 = g_dbaf_d_t.dbaf002  
#                  AND dbaf003 = g_dbaf_d_t.dbaf003  
# 
#                  
               #add-point:單身修改中

               #end add-point
              #因為是UPDATE tmp,無須執行標準流程    
              # CASE
              #    WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
              #       CALL cl_err("dbaf_t","std-00009",1)
              #       CALL s_transaction_end('N','0')
              #      WHEN SQLCA.sqlcode #其他錯誤
              #       INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbaf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
              #       CALL s_transaction_end('N','0')
              #    OTHERWISE
              #                      INITIALIZE gs_keys TO NULL 
              # LET gs_keys[1] = g_dbaf_d[g_detail_idx].dbaf001
              # LET gs_keys_bak[1] = g_dbaf_d_t.dbaf001
              # LET gs_keys[2] = g_dbaf_d[g_detail_idx].dbaf002
              # LET gs_keys_bak[2] = g_dbaf_d_t.dbaf002
              # LET gs_keys[3] = g_dbaf_d[g_detail_idx].dbaf003
              # LET gs_keys_bak[3] = g_dbaf_d_t.dbaf003
              # CALL adbi255_01_update_b('dbaf_t',gs_keys,gs_keys_bak,"'1'")
              #       #資料多語言用-增/改
              #       
              # END CASE
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adbi255_01_unlock_b("dbaf_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_dbaf_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dbaf_d.getLength()+1
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input

      #end add-point
      
      BEFORE DIALOG 
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog

         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD dbaf0041
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
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
   
   #add-point:modify段修改後

   #end add-point
 
   CLOSE adbi255_01_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi255_01_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define

   #end add-point 
   
   IF NOT cl_ask_delete() THEN
      LET INT_FLAG = 1 #不刪除
   ELSE
      LET INT_FLAG = 0 #要刪除
   END IF
   
   LET li_ac = ARR_CURR()
   
   CALL s_transaction_begin()  
 
   #add-point:delete段刪除前

   #end add-point 
   DELETE FROM dbaf_t 
         #WHERE dbaf001 = g_dbaf_d[li_ac].dbaf001   #170120-00038#1 20170123 mark by beckxie
         WHERE dbafent = g_enterprise               #170120-00038#1 20170123 add by beckxie
           AND dbaf001 = g_dbaf_d[li_ac].dbaf001    #170120-00038#1 20170123 add by beckxie
           AND dbaf002 = g_dbaf_d[li_ac].dbaf002
           AND dbaf003 = g_dbaf_d[li_ac].dbaf003
 
   #add-point:delete段刪除中

   #end add-point 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dbaf_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後

   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi255_01_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2           STRING
   #add-point:b_fill段define
   DEFINE l_order_sql  STRING
   DEFINE l_tmp_cnt    LIKE type_t.num5    #調整路線順序的tmp table有無資料
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前
   LET l_order_sql = " ORDER BY dbaf004 " 

   SELECT COUNT(*) INTO l_tmp_cnt FROM adbi255_tmp02   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
   IF cl_null(l_tmp_cnt) THEN
      LET l_tmp_cnt = 0
   END IF   
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE '',dbaf004,dbaf001,dbaf002,dbaf003,'','','',dbaf011,dbaf012,dbaf013,dbaf014, 
       dbaf015 FROM dbaf_t",
               "",
               " WHERE dbafent= ? AND 1=1 AND ", p_wc2 
    
   LET g_sql = g_sql, #,cl_get_extra_cond('zzuser', 'zzgrup') 
                      " ORDER BY dbaf_t.dbaf001,dbaf_t.dbaf002,dbaf_t.dbaf003"
  
   #add-point:b_fill段sql之後
   IF l_tmp_cnt = 0 THEN
      #LET g_sql = cl_replace_str(g_sql, " ORDER BY dbaf_t.dbaf001,dbaf_t.dbaf002,dbaf_t.dbaf003", l_order_sql)              
      LET g_sql = "SELECT  UNIQUE dbaf004 dbaf0041,dbaf004,dbaf001,dbaf002,dbaf003,'','','',dbaf011,dbaf012, ",
                  "               dbaf013,dbaf014,dbaf015 ",
                  "  FROM adbi255_01_tmp ",
                  " WHERE dbafent= ? ",
                  " ORDER BY dbaf004 "
   ELSE
    
      LET g_sql = "SELECT  UNIQUE reo.dbaf0041,sc.dbaf004,sc.dbaf001,sc.dbaf002,sc.dbaf003,'','','',sc.dbaf011,sc.dbaf012, ",
                  "               sc.dbaf013,sc.dbaf014,sc.dbaf015 ",
                  "  FROM adbi255_01_tmp sc ,adbi255_tmp02 reo ",  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                  " WHERE sc.dbaf001 = reo.dbaf001 AND sc.dbaf002 = reo.dbaf002 AND sc.dbaf003 = reo.dbaf003 ",
                  "   AND sc.dbafent= ? AND sc.dbaf001 = '",g_dbaf001,"' AND sc.dbaf002 = '",g_dbaf002,"' ",
                  " ORDER BY reo.dbaf0041 "
   END IF
   #end add-point
  
   PREPARE adbi255_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi255_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dbaf_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dbaf_d[l_ac].dbaf0041,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf001,g_dbaf_d[l_ac].dbaf002, 
       g_dbaf_d[l_ac].dbaf003,g_dbaf_d[l_ac].dbaf003_desc,g_dbaf_d[l_ac].dbad002,g_dbaf_d[l_ac].dbad002_desc, 
       g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013,g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      #IF cl_null(g_dbaf_d[l_ac].dbaf0041) THEN
      #   LET g_dbaf_d[l_ac].dbaf0041 = g_dbaf_d[l_ac].dbaf004
      #END IF
      
      
      IF g_dbaf_d[l_ac].dbaf0041 = 0 THEN
         LET g_dbaf_d[l_ac].dbaf011 = 0
         LET g_dbaf_d[l_ac].dbaf012 = 0
         LET g_dbaf_d[l_ac].dbaf013 = 0 
         LET g_dbaf_d[l_ac].dbaf014 = 0
         LET g_dbaf_d[l_ac].dbaf015 = 0
      END IF      
      
      #end add-point
      
      CALL adbi255_01_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
      END IF
   END IF 
   LET g_error_show = 0
   
 
  
   
   CALL g_dbaf_d.deleteElement(g_dbaf_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dbaf_d.getLength()
 
   END FOR
   
   IF g_cnt > g_dbaf_d.getLength() THEN
      LET l_ac = g_dbaf_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
 
   LET g_detail_cnt = g_dbaf_d.getLength() 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE adbi255_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi255_01_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference

   LET g_dbaf_d[l_ac].dbaf003_desc = adbi255_dbaf003_ref(g_dbaf_d[l_ac].dbaf003)
   DISPLAY BY NAME g_dbaf_d[l_ac].dbaf003_desc
   
   LET g_dbaf_d[l_ac].dbad002 = adbi255_get_dbad002(g_dbaf_d[l_ac].dbaf003)
   LET g_dbaf_d[l_ac].dbad002_desc = adbi255_dbad002_ref(g_dbaf_d[l_ac].dbad002)
   DISPLAY BY NAME g_dbaf_d[l_ac].dbad002,g_dbaf_d[l_ac].dbad002_desc
   #end add-point
   
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi255_01_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段control
   CALL cl_set_comp_entry('dbaf011,dbaf012,dbaf013,dbaf014,dbaf015',TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="adbi255_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi255_01_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point  
 
   #add-point:set_no_entry_b段control
   IF g_dbaf_d[l_ac].dbaf0041 = 0 THEN
      CALL cl_set_comp_entry('dbaf011,dbaf012,dbaf013,dbaf014,dbaf015',FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="adbi255_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi255_01_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dbaf001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dbaf002 = ", g_argv[02], " AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " dbaf003 = ", g_argv[03], " AND "
   END IF
 
 
   #add-point:default_search段after sql
   IF cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dbaf001 = '", g_dbaf001, "' AND "
   END IF
   
   IF cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dbaf002 = ",g_dbaf002, " AND "
   END IF
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi255_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dbaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
   
      #add-point:delete_b段刪除前
      
      #end add-point     
   
      DELETE FROM dbaf_t
       WHERE dbafent = g_enterprise AND
         dbaf001 = ps_keys_bak[1] AND dbaf002 = ps_keys_bak[2] AND dbaf003 = ps_keys_bak[3]
 
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
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi255_01_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dbaf_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
      
      #end add-point    
      INSERT INTO dbaf_t
                  (dbafent,
                   dbaf001,dbaf002,dbaf003
                   ,dbaf004,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013, 
                       g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015)
      #add-point:insert_b段新增中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi255_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "dbaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbaf_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE dbaf_t 
         SET (dbaf001,dbaf002,dbaf003
              ,dbaf004,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013, 
                  g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015) 
         WHERE dbafent = g_enterprise   #160905-00003#4 160905 by lori add:ENT過濾條件
           AND dbaf001 = ps_keys_bak[1] AND dbaf002 = ps_keys_bak[2] AND dbaf003 = ps_keys_bak[3]
      #add-point:update_b段修改中
 
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "dbaf_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "dbaf_t"
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
 
{<section id="adbi255_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi255_01_lock_b(ps_table)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL adbi255_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dbaf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi255_01_bcl USING g_enterprise,
                                       g_dbaf_d[g_detail_idx].dbaf001,g_dbaf_d[g_detail_idx].dbaf002, 
                                           g_dbaf_d[g_detail_idx].dbaf003
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adbi255_01_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi255_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi255_01_bcl
   #END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION adbi255_01_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "dbaf0041"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255_01.state_change" >}
   
 
{</section>}
 
{<section id="adbi255_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="adbi255_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 清除調整路線順序的相關暫存檔資料
# Memo...........: adbi255_01_tmp 是顯示資料的來源,勿刪
#                : adbi255_01_reorder 是顯示資料的參考來源, 需要重新寫入時才做刪除
# Usage..........: CALL adbi255_01_reorder_del()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/05/12 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_01_reorder_del()
    
   DELETE FROM adbi255_01_sel
   DELETE FROM adbi255_tmp01   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
          
END FUNCTION

################################################################################
# Descriptions...: 路線順序調整
# Memo...........:
# Usage..........: CALL adbi255_01_move(p_move)
#                  RETURN r_refresh 
# Input parameter: p_move     1.上移 -1.下移
# Return code....: r_refresh  是否需要刷新
# Date & Author..: 2014/05/12 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_01_move(p_move)
   DEFINE p_move        LIKE type_t.num5
   DEFINE r_refresh     LIKE type_t.num5
   DEFINE l_sel_min     LIKE dbaf_t.dbaf004
   DEFINE l_unsel_min   LIKE dbaf_t.dbaf004
   DEFINE l_unsel_max   LIKE dbaf_t.dbaf004   
   DEFINE l_reorder     RECORD
            dbaf001   LIKE dbaf_t.dbaf001,
            dbaf002   LIKE dbaf_t.dbaf002,
            dbaf003   LIKE dbaf_t.dbaf003,
            dbaf004   LIKE dbaf_t.dbaf004
                        END RECORD
   DEFINE l_sql         STRING
   DEFINE l_sel_sql     STRING
   DEFINE l_sel_table   STRING
   DEFINE l_unsel_table STRING
   DEFINE l_order_sql   STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE i             LIKE type_t.num5
   DEFINE l_seq         LIKE type_t.num5

   LET r_refresh = TRUE
   LET l_sel_min = NULL
   LET l_unsel_min = NULL
   LET l_unsel_max = NULL 
   LET l_cnt = NULL 
   
   SELECT MIN(dbaf004) INTO l_sel_min   FROM adbi255_01_sel
   SELECT MIN(dbaf004) INTO l_unsel_min FROM adbi255_tmp01  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
   SELECT MAX(dbaf004) INTO l_unsel_max FROM adbi255_tmp01  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01        
   SELECT COUNT(*) INTO l_cnt  FROM adbi255_01_sel
   
   LET l_sel_sql = " SELECT dbaf001,dbaf002,dbaf003,dbaf004 "
   LET l_sel_table  = " FROM adbi255_01_sel "
   LET l_unsel_table  = " FROM adbi255_tmp01 "   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_unsel ——> adbi255_tmp01
   LET l_order_sql = " ORDER BY dbaf004 "

   LET l_sql = l_sel_sql,l_sel_table,l_order_sql
   PREPARE adbi255_01_pre1 FROM l_sql
   DECLARE adbi255_01_cur1 CURSOR FOR adbi255_01_pre1
   
   #路線順序的調整均以挑選的第一筆作為上下移動的依據   
   IF p_move = 1 THEN   #上移
      LET l_seq = 0
      
      #資料若已經在第一筆(畫面的最上方)時,畫面的資料無須異動,所以直接Return
      IF l_sel_min < l_unsel_min AND l_cnt = 1 THEN
         LET r_refresh = FALSE
         RETURN r_refresh
      END IF
      
      DELETE FROM adbi255_tmp02  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
      
      LET l_sql = l_sel_sql,l_unsel_table,
                  " WHERE dbaf004 < (SELECT MAX(dbaf004) ",l_unsel_table," WHERE dbaf004 < ",l_sel_min,")",
                  l_order_sql
      PREPARE adbi255_01_pre2 FROM l_sql
      DECLARE adbi255_01_cur2 CURSOR FOR adbi255_01_pre2
      FOREACH adbi255_01_cur2 INTO l_reorder.*
         EXECUTE adbi255_tmp02_ins USING l_reorder.dbaf001,l_reorder.dbaf002,  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                                              l_reorder.dbaf003,l_reorder.dbaf004,l_seq
         LET l_seq = l_seq + 1         
      END FOREACH    

      FOREACH adbi255_01_cur1 INTO l_reorder.*
         EXECUTE adbi255_tmp02_ins USING l_reorder.dbaf001,l_reorder.dbaf002,  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                                              l_reorder.dbaf003,l_reorder.dbaf004,l_seq
         LET l_seq = l_seq + 1         
      END FOREACH

      IF l_sel_min = 0 THEN
         LET l_sql = l_sel_sql,l_unsel_table,l_order_sql
      ELSE   
         LET l_sql = l_sel_sql,l_unsel_table,
                     " WHERE dbaf004 >= (SELECT MAX(dbaf004) ",l_unsel_table," WHERE dbaf004 < ",l_sel_min,")",
                     l_order_sql
      END IF
      PREPARE adbi255_01_pre3 FROM l_sql
      DECLARE adbi255_01_cur3 CURSOR FOR adbi255_01_pre3
      FOREACH adbi255_01_cur3 INTO l_reorder.*
         EXECUTE adbi255_tmp02_ins USING l_reorder.dbaf001,l_reorder.dbaf002,  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                                              l_reorder.dbaf003,l_reorder.dbaf004,l_seq
         LET l_seq = l_seq + 1         
      END FOREACH                
   END IF

   IF p_move = -1 THEN   #下移
      LET l_seq = 0
      
      #資料若已經在最後一筆(畫面的最下方)時,畫面的資料無須異動,所以直接Return
      IF l_sel_min >= l_unsel_max THEN
         LET r_refresh = FALSE
         RETURN r_refresh
      END IF
      
      DELETE FROM adbi255_tmp02  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02

      LET l_sql = l_sel_sql,l_unsel_table,
                  " WHERE dbaf004 <= (SELECT MIN(dbaf004) ",l_unsel_table," WHERE dbaf004 > ",l_sel_min,")",
                  l_order_sql
      PREPARE adbi255_01_pre4 FROM l_sql
      DECLARE adbi255_01_cur4 CURSOR FOR adbi255_01_pre4
      FOREACH adbi255_01_cur4 INTO l_reorder.*
         EXECUTE adbi255_tmp02_ins USING l_reorder.dbaf001,l_reorder.dbaf002,   #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                                              l_reorder.dbaf003,l_reorder.dbaf004,l_seq
         LET l_seq = l_seq + 1         
      END FOREACH
      
      FOREACH adbi255_01_cur1 INTO l_reorder.*
         EXECUTE adbi255_tmp02_ins USING l_reorder.dbaf001,l_reorder.dbaf002,  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                                              l_reorder.dbaf003,l_reorder.dbaf004,l_seq
         LET l_seq = l_seq + 1         
      END FOREACH
      
      LET l_sql = l_sel_sql,l_unsel_table,
                  " WHERE dbaf004 > (SELECT MIN(dbaf004) ",l_unsel_table," WHERE dbaf004 > ",l_sel_min,")",
                  l_order_sql
      PREPARE adbi255_01_pre5 FROM l_sql
      DECLARE adbi255_01_cur5 CURSOR FOR adbi255_01_pre5
      FOREACH adbi255_01_cur5 INTO l_reorder.*
         EXECUTE adbi255_tmp02_ins USING l_reorder.dbaf001,l_reorder.dbaf002,  #160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adbi255_01_reorder ——> adbi255_tmp02
                                              l_reorder.dbaf003,l_reorder.dbaf004,l_seq
         LET l_seq = l_seq + 1         
      END FOREACH 
   END IF   
   
   RETURN r_refresh
END FUNCTION

################################################################################
# Descriptions...: 更新路線順序
# Memo...........:
# Usage..........: CALL adbi255_01_reorder_upd()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/05/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_01_reorder_upd()
   DEFINE l_sql       STRING
   DEFINE l_dbaf  RECORD
             dbafent   LIKE dbaf_t.dbafent,   
             dbaf001   LIKE dbaf_t.dbaf001,
             dbaf002   LIKE dbaf_t.dbaf002,
             dbaf003   LIKE dbaf_t.dbaf003,
             dbaf004   LIKE dbaf_t.dbaf004,
             dbaf011   LIKE dbaf_t.dbaf011,
             dbaf012   LIKE dbaf_t.dbaf012,
             dbaf013   LIKE dbaf_t.dbaf013,
             dbaf014   LIKE dbaf_t.dbaf014,
             dbaf015   LIKE dbaf_t.dbaf015,
             dbaf0041  LIKE dbaf_t.dbaf004
                  END RECORD

   DEFINE  l_sum_dbaf011   LIKE dbaf_t.dbaf011
   DEFINE  l_sum_dbaf012   LIKE dbaf_t.dbaf012
   DEFINE  l_sum_dbaf013   LIKE dbaf_t.dbaf013
   DEFINE  l_sum_dbaf014   LIKE dbaf_t.dbaf014
   DEFINE  l_sum_dbaf015   LIKE dbaf_t.dbaf015
   
   CALL s_transaction_begin()
   
   LET l_sql = "SELECT sc.dbafent,sc.dbaf001,sc.dbaf002,sc.dbaf003,sc.dbaf004, ",
               "       sc.dbaf011,sc.dbaf012,sc.dbaf013,sc.dbaf014,sc.dbaf015, ",
               "       reo.dbaf0041 ",
               "  FROM adbi255_01_tmp sc LEFT JOIN adbi255_tmp02 reo ",
               "                                ON reo.dbaf001 = sc.dbaf001 AND reo.dbaf002 = sc.dbaf002 AND reo.dbaf003 = sc.dbaf003 "
   PREPARE adbi255_tmp_pre FROM l_sql
   DECLARE adbi255_tmp_cur CURSOR FOR adbi255_tmp_pre
   FOREACH adbi255_tmp_cur INTO l_dbaf.dbafent,l_dbaf.dbaf001,l_dbaf.dbaf002,l_dbaf.dbaf003,l_dbaf.dbaf004,
                                l_dbaf.dbaf011,l_dbaf.dbaf012,l_dbaf.dbaf013,l_dbaf.dbaf014,l_dbaf.dbaf015,
                                l_dbaf.dbaf0041   
     IF cl_null(l_dbaf.dbaf0041) THEN
        LET l_dbaf.dbaf0041 = l_dbaf.dbaf004
     END IF
     
     IF l_dbaf.dbaf0041 = 0 THEN
        LET l_dbaf.dbaf011 = 0
        LET l_dbaf.dbaf012 = 0
        LET l_dbaf.dbaf013 = 0
        LET l_dbaf.dbaf014 = 0
        LET l_dbaf.dbaf015 = 0   
     END IF
     
     UPDATE dbaf_t
        SET dbaf004 = l_dbaf.dbaf0041,
            dbaf011 = l_dbaf.dbaf011,
            dbaf012 = l_dbaf.dbaf012,
            dbaf013 = l_dbaf.dbaf013,
            dbaf014 = l_dbaf.dbaf014,
            dbaf015 = l_dbaf.dbaf015
      WHERE dbafent = l_dbaf.dbafent
        AND dbaf001 = l_dbaf.dbaf001
        AND dbaf002 = l_dbaf.dbaf002
        AND dbaf003 = l_dbaf.dbaf003
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
         RETURN 
      END IF   
   END FOREACH
   
   SELECT SUM(dbaf011),SUM(dbaf012),SUM(dbaf013),SUM(dbaf014),SUM(dbaf015)
     INTO l_sum_dbaf011,l_sum_dbaf012,l_sum_dbaf013,l_sum_dbaf014,l_sum_dbaf015
     FROM dbaf_t
    WHERE dbafent = g_enterprise
      AND dbaf001 = g_dbaf001
      AND dbaf002 = g_dbaf002

   IF g_dbaf002 = '1' THEN
      UPDATE dbab_t
         SET dbab011 = l_sum_dbaf011,
             dbab012 = l_sum_dbaf012,
             dbab013 = l_sum_dbaf013,
             dbab014 = l_sum_dbaf014,
             dbab015 = l_sum_dbaf015
       WHERE dbabent = g_enterprise
         AND dbab001 = g_dbaf001       
   END IF

   IF g_dbaf002 = '2' THEN
      UPDATE dbab_t
         SET dbab021 = l_sum_dbaf011,
             dbab022 = l_sum_dbaf012,
             dbab023 = l_sum_dbaf013,
             dbab024 = l_sum_dbaf014,
             dbab025 = l_sum_dbaf015
       WHERE dbabent = g_enterprise
         AND dbab001 = g_dbaf001       
   END IF
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
      CALL s_transaction_end('N','0')
      RETURN 
   END IF 

   CALL s_transaction_end('Y','0')
END FUNCTION

################################################################################
# Descriptions...: 計算總花費費用的預設值
# Memo...........:
# Usage..........: CALL adbi255_01_default_dbaf015()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/05/14 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_01_default_dbaf015()
   DEFINE l_dbaf013   LIKE dbaf_t.dbaf013
   DEFINE l_dbaf014   LIKE dbaf_t.dbaf014
   
   IF cl_null(g_dbaf_d[l_ac].dbaf013) AND cl_null(g_dbaf_d[l_ac].dbaf014) THEN
      RETURN
   END IF
   
   IF cl_null(g_dbaf_d[l_ac].dbaf013) THEN
      LET l_dbaf013 = 0
   ELSE
      LET l_dbaf013 = g_dbaf_d[l_ac].dbaf013
   END IF  
   
   IF cl_null(g_dbaf_d[l_ac].dbaf014) THEN
      LET l_dbaf014 = 0
   ELSE
      LET l_dbaf014 = g_dbaf_d[l_ac].dbaf014
   END IF 
   
   LET g_dbaf_d[l_ac].dbaf015 = l_dbaf013 + l_dbaf014   
END FUNCTION

 
{</section>}
 
