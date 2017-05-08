#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: azzi600_syn
#+ 設計人員......: cch
#+ 功能名稱說明...: 同步系統狀態碼(gzcb_t同步到gzcc_t)
 

IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
 
#單身 type 宣告
PRIVATE TYPE type_g_dzcb_t        RECORD
   checkbox LIKE type_t.chr1, 
   gzcb002  LIKE gzcb_t.gzcb002,
   gzcbl004 LIKE gzcbl_t.gzcbl004
      END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_gzcb_d         DYNAMIC ARRAY OF type_g_dzcb_t
DEFINE g_gzcb_d_t       type_g_dzcb_t
DEFINE g_rec_b          LIKE type_t.num5           
DEFINE l_ac             LIKE type_t.num5
DEFINE g_input_str      STRING             #輸入的字串
DEFINE g_output_str     STRING             #輸出的字串
DEFINE g_table_id       LIKE dzeb_t.dzeb001

DEFINE g_sys_type_code2 LIKE gzcb_t.gzcb001
DEFINE g_enable_disable STRING
DEFINE g_forupd_sql     STRING


#+ 作業開始
PUBLIC FUNCTION azzi600_synchro_status()
   #DEFINE p_sys_type_code LIKE gzcb_t.gzcb001

   ###初始化顯示的record 陣列
   CALL g_gzcb_d.clear()

  
   #避免cl_ap_init中CALL cl_user時,重新CONNECT TO "ds" 後造成問題
   DISCONNECT CURRENT
 
   #切換至使用者所需要的資料庫 (營運中心)  #to do
   #DISCONNECT CURRENT #todo
   #CONNECT TO "ds" #todo
   #DISPLAY 'connect:ds->',STATUS

   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi600_syn WITH FORM cl_ap_formpath("azz","azzi600_syn") 

   #ui畫面初始化
   #CALL cl_ui_init()

   #DISPLAY "p_sys_type_code = ",p_sys_type_code

   CALL azzi600_syn_initial()
   
   #設定
   CALL azzi600_syn_input()

   #畫面關閉
   CLOSE WINDOW w_azzi600_syn
 
END FUNCTION


FUNCTION azzi600_syn_initial()
   #DEFINE p_sys_type_code LIKE gzcb_t.gzcb001
   DEFINE lo_combobox  ui.combobox
   DEFINE ls_combo_sql STRING

   CALL ui.Dialog.setDefaultUnbuffered(TRUE)


   #CLOSE WINDOW SCREEN
  
   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()

  LET ls_combo_sql = "SELECT gzca001,gzca001||'. '||gzcal003  WIDGETS_TYPES_DESC FROM ds.gzca_t ",
                                 "LEFT JOIN ds.gzcal_t ON gzca001=gzcal001 AND gzcal002='",g_lang,"' ",
                                 " WHERE gzca001 IN ('13','17')"

   LET lo_combobox = ui.combobox.forName("formonly.cb_systemtypecode2")
   CALL azzi600_syn_fill_combobox(lo_combobox,ls_combo_sql)

   LET g_sys_type_code2 = 13
   LET g_enable_disable = "Y"
   DISPLAY g_sys_type_code2 TO cb_systemtypecode2
   DISPLAY g_enable_disable TO ra_enable_disable
   
   DISPLAY "g_sys_type_code2 = ",g_sys_type_code2
   CALL azzi600_syn_fill_g_gzcb_t(g_sys_type_code2)

   #DISPLAY "azzi600_syn_fill_g_gzcb_t"

   LET g_forupd_sql = "SELECT gzcc001",
                      " FROM ds.gzcc_t WHERE gzcc001 = ? AND gzcc004 = ? ",
                      " FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   #DISPLAY "g_forupd_sql = ",g_forupd_sql
   
   DECLARE azzi600_syn_gzcc_lock_cur CURSOR FROM g_forupd_sql   #cursor lock for dzeh_t
END FUNCTION



#+ 資料輸入
PRIVATE FUNCTION azzi600_syn_input()
   DEFINE  l_n             LIKE type_t.num5
   DEFINE  l_cnt           LIKE type_t.num5
   DEFINE  ls_str          STRING

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT g_sys_type_code2,g_enable_disable FROM cb_systemtypecode2,ra_enable_disable 
         ATTRIBUTE(WITHOUT DEFAULTS)
      
         ON CHANGE ra_enable_disable
            #DISPLAY "g_enable_disable = ",g_enable_disable

         ON CHANGE cb_systemtypecode2
            #DISPLAY "g_sys_type_code2 = ",g_sys_type_code2
            CALL azzi600_syn_fill_g_gzcb_t(g_sys_type_code2)

      END INPUT
   
      INPUT ARRAY g_gzcb_d FROM s_gzcb.* ATTRIBUTE(WITHOUT DEFAULTS,AUTO APPEND = FALSE)
            
         BEFORE ROW
            LET l_ac = ARR_CURR()

      END INPUT

      
      ON ACTION btn_confirm
         IF g_gzcb_d.getLength() > 0 THEN
            CALL azzi600_syn_gzcb_to_gzcc()
         END IF

         ACCEPT DIALOG
        
      ON ACTION btn_cancel
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET g_output_str = g_input_str
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_output_str = g_input_str
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
      CONTINUE DIALOG 
         
   END DIALOG
    
END FUNCTION

FUNCTION azzi600_syn_gzcb_to_gzcc()
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_cnt2        LIKE type_t.num5
   DEFINE l_syn_tables DYNAMIC ARRAY OF RECORD
      gzcc001 LIKE gzcc_t.gzcc001
   END RECORD 
   DEFINE l_sql        STRING
   DEFINE l_str        STRING

   DEFINE l_gzcc001  LIKE gzcc_t.gzcc001  #Table編號 pk
   DEFINE l_gzcc002  LIKE gzcc_t.gzcc002  #狀態碼欄位
   DEFINE l_gzcc003  LIKE gzcc_t.gzcc003  #系統分類碼
   DEFINE l_gzcc004  LIKE gzcc_t.gzcc004  #系統分類值 pk
   DEFINE l_gzcc005  LIKE gzcc_t.gzcc005  #客製否
   DEFINE l_gzcc006  LIKE gzcc_t.gzcc006  #顯示順序
   
   DEFINE l_gzcccrtdt LIKE gzcc_t.gzcccrtdt #資料創建日
   #DEFINE l_gzccmoddt LIKE gzcc_t.gzccmoddt #最近修改日
   DEFINE l_gzcccrtdp LIKE gzcc_t.gzcccrtdp #資料建立部門
   #DEFINE l_gzccmodid LIKE gzcc_t.gzccmodid #資料修改者
   DEFINE l_gzccowndp LIKE gzcc_t.gzccowndp #資料所有部門
   DEFINE l_gzccownid LIKE gzcc_t.gzccownid #資料所有者
   DEFINE l_gzccstus LIKE gzcc_t.gzccstus #狀態碼
   DEFINE l_gzcccrtid LIKE gzcc_t.gzcccrtid #資料建立者

   #篩選要更新的表格 ### start ###
   LET l_sql = "SELECT DISTINCT gzcc001 FROM gzcc_t ",
               " WHERE gzcc003 = '",g_sys_type_code2,"'"
   #DISPLAY "ls_sql = ",l_sql

   PREPARE lpre_table FROM l_sql
   DECLARE lcur_table CURSOR FOR lpre_table

   CALL l_syn_tables.clear()
  
   LET l_cnt = 1
  
   #DISPLAY ls_gzcb001
   FOREACH lcur_table INTO l_syn_tables[l_cnt].* 
     
      IF SQLCA.sqlcode THEN
         #DISPLAY "SQLCA.sqlcode = ",SQLCA.sqlcode
         EXIT FOREACH
      END IF

      #DISPLAY l_syn_tables[l_cnt].gzcc001
     
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_syn_tables.deleteElement(l_cnt)
   #篩選要更新的表格 ### ent ###


   #插入用的sql語句
   LET l_sql = "INSERT INTO gzcc_t(gzcc001,gzcc002,gzcc003,gzcc004,gzcc005,gzcc006,",
                  "gzcccrtdt,gzcccrtdp,gzccowndp,gzccownid,gzccstus,gzcccrtid)", 
                  " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"

   PREPARE insert_to_gzcc_t FROM l_sql

   LET l_sql = "UPDATE gzcc_t SET(gzcc001,gzcc002,gzcc003,gzcc004,gzcc005,gzcc006,",
                  "gzcccrtdt,gzcccrtdp,gzccowndp,gzccownid,gzccstus,gzcccrtid)",
                  " = (?,?,?,?,?,?,?,?,?,?,?,?)",
                  " WHERE gzcc001 = ? AND gzcc004 = ?"

   PREPARE update_to_gzcc_t FROM l_sql


   LET l_gzcccrtdt = cl_get_current()
   LET l_gzcccrtdp = g_dept
   LET l_gzccowndp = g_dept
   LET l_gzccownid = g_user
   LET l_gzccstus = g_enable_disable
   LET l_gzcccrtid = g_user

   #BEGIN WORK

   CALL cl_progress_bar(l_syn_tables.getLength())
   
   FOR  l_cnt = 1 TO l_syn_tables.getLength()
      CALL cl_progress_ing("Processing Data")
      #DISPLAY "TABLE = ",l_syn_tables[l_cnt].gzcc001
      FOR l_cnt2 = 1 TO g_gzcb_d.getLength()
         IF g_gzcb_d[l_cnt2].checkbox = "Y" THEN
            DISPLAY g_gzcb_d[l_cnt2].gzcb002
               TRY
                  LET l_gzcc001 = l_syn_tables[l_cnt].gzcc001
                  LET l_str = l_syn_tables[l_cnt].gzcc001
                  LET l_str = l_str.subString(1,l_str.getLength()-2)
                  LET l_gzcc002 = l_str,"stus"
                  LET l_gzcc003 = g_sys_type_code2
                  LET l_gzcc004 = g_gzcb_d[l_cnt2].gzcb002
                  LET l_gzcc005 = "s" #預設為標準
                  SELECT COUNT(*) INTO l_gzcc006 FROM ds.gzcc_t WHERE gzcc003 = g_sys_type_code2 AND gzcc001 = l_gzcc001
                  LET l_gzcc006 = l_gzcc006 + 1
                  
                  EXECUTE insert_to_gzcc_t USING l_gzcc001,l_gzcc002,l_gzcc003,l_gzcc004,l_gzcc005,l_gzcc006,
                                                 l_gzcccrtdt,l_gzcccrtdp,l_gzccowndp,l_gzccownid,l_gzccstus,l_gzcccrtid
               CATCH
                  #若偵測到key值重複的錯誤訊息（-268）,則使用更新的方式更新資料
                  IF SQLCA.sqlcode = -268 THEN

                     TRY
                        IF azzi600_syn_lock_gzzc_t(l_gzcc001,l_gzcc004) THEN
                           SELECT gzcc006 INTO l_gzcc006 FROM ds.gzcc_t WHERE gzcc004 = l_gzcc004 AND gzcc001 = l_gzcc001 
                           EXECUTE update_to_gzcc_t USING l_gzcc001,l_gzcc002,l_gzcc003,l_gzcc004,l_gzcc005,l_gzcc006,
                                                           l_gzcccrtdt,l_gzcccrtdp,l_gzccowndp,l_gzccownid,l_gzccstus,l_gzcccrtid,
                                                           l_gzcc001,l_gzcc004
                        END IF
                     CATCH
                        IF SQLCA.sqlcode THEN
                           CALL cl_err("gzcc_update_failed",SQLCA.sqlcode,g_errshow)
                           ROLLBACK WORK
                        END IF
                     END TRY
                  END IF

                  #CLOSE azzi600_syn_gzcc_lock_cur

                  IF SQLCA.sqlcode AND SQLCA.sqlcode != -268 THEN
                        CALL cl_err("gzcc_insert_failed",SQLCA.sqlcode,g_errshow)
                        ROLLBACK WORK
                  END IF
                  
               END TRY
         END IF
      END FOR

   END FOR

   COMMIT WORK
   
END FUNCTION

#+先lock資料庫中(dzeh_t)要處理的資料
PRIVATE FUNCTION azzi600_syn_lock_gzzc_t(p_gzcc001,p_gzcc004)
   DEFINE p_gzcc001  LIKE   gzcc_t.gzcc001
   DEFINE p_gzcc004  LIKE   gzcc_t.gzcc004
   DEFINE l_gzcc001  LIKE   gzcc_t.gzcc001
   DEFINE l_cnt      LIKE     type_t.num5

   #BEGIN WORK

   SELECT COUNT(*) INTO l_cnt FROM gzcc_t WHERE gzcc001 = p_gzcc001 AND gzcc004 = p_gzcc004
   #DISPLAY "l_cnt = ",l_cnt

   IF l_cnt > 0 THEN

      TRY
         OPEN azzi600_syn_gzcc_lock_cur USING p_gzcc001,p_gzcc004
      CATCH 
         #用於Oracle的lock偵測
         IF STATUS THEN
            CALL cl_err("OPEN azzi600_syn_gzcc_lock_cur:Oracle:"||p_gzcc001, STATUS, 1)
            #CLOSE azzi600_syn_gzcc_lock_cur
            #ROLLBACK WORK
            RETURN FALSE
         END IF

         FETCH azzi600_syn_gzcc_lock_cur INTO l_gzcc001

         #用於Informix的lock偵測 
         IF SQLCA.sqlcode THEN
            CALL cl_err("OPEN azzi600_syn_gzcc_lock_cur:Informix:"||p_gzcc001, SQLCA.sqlcode, 1)
            #CLOSE azzi600_syn_gzcc_lock_cur
            #ROLLBACK WORK
            RETURN FALSE
         END IF
      END TRY
   END IF

   #COMMIT WORK
   
   RETURN TRUE
   
END FUNCTION

FUNCTION azzi600_syn_fill_combobox(p_combobox,p_sql)
   DEFINE 
     p_combobox ui.combobox,
     p_sql      STRING
   DEFINE
     ls_sql      STRING,
     li_index    INTEGER,
     li_count    INTEGER, 
     ls_combobox RECORD 
                   combobox_NAME VARCHAR(50),
                   combobox_DESC VARCHAR(255)
                 END RECORD  
  
   LET li_index = 0
   LET ls_sql = p_sql

   #DISPLAY "ls_sql = ",ls_sql
  
   PREPARE lpre_combobox FROM ls_sql
   DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

   CALL p_combobox.clear()
   INITIALIZE ls_combobox.* TO NULL

   LET li_count = 1

   FOREACH lcur_combobox INTO ls_combobox.*  
      IF SQLCA.sqlcode THEN
         EXIT FOREACH
      END IF

      CALL p_combobox.addItem(ls_combobox.combobox_NAME,ls_combobox.combobox_DESC)
      INITIALIZE ls_combobox.* TO NULL
      LET li_count = li_count + 1
   END FOREACH

   FREE lcur_combobox
   FREE lpre_combobox
END FUNCTION

FUNCTION azzi600_syn_fill_g_gzcb_t(p_gzcb001)

  DEFINE p_gzcb001   LIKE gzcb_t.gzcb001,  
         ls_gzcb001 LIKE gzcb_t.gzcb001,
         ls_sql         STRING,
         li_count       LIKE type_t.num5,
         l_gzcbl004     LIKE gzcbl_t.gzcbl004,
         lo_combobox    ui.combobox,
         #g_sys_type_code2 STRING,
         l_cb_text      STRING

   CALL g_gzcb_d.clear()

   IF NOT cl_null(p_gzcb001) THEN

      LET ls_gzcb001 = p_gzcb001

      DISPLAY "ls_gzcb001 = ",ls_gzcb001
      
      LET ls_sql = "SELECT 'N',gzcb002,gzcbl004 ",
                   " FROM ds.gzcb_t LEFT JOIN ds.gzcbl_t     ", 
                   " ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003='",g_lang,"'",
                   " WHERE gzcb001 = ",ls_gzcb001," ORDER BY gzcb002"
      DISPLAY "ls_sql = ",ls_sql

      PREPARE lpre_gzcb_t FROM ls_sql
      DECLARE lcur_gzcb_t CURSOR FOR lpre_gzcb_t

      
      LET li_count = 1
     
      #DISPLAY ls_gzcb001
      FOREACH lcur_gzcb_t INTO g_gzcb_d[li_count].* 

      
         
         IF SQLCA.sqlcode THEN
            #DISPLAY "SQLCA.sqlcode = ",SQLCA.sqlcode
            EXIT FOREACH
         END IF

         DISPLAY g_gzcb_d[li_count].checkbox," ",
         g_gzcb_d[li_count].gzcb002," ",
         g_gzcb_d[li_count].gzcbl004
        
         LET li_count = li_count + 1
      END FOREACH
      CALL g_gzcb_d.deleteElement(li_count)
      
   END IF

END FUNCTION
