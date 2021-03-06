#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi001_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-05-12 11:18:00), PR版次:0003(2016-06-22 13:52:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000634
#+ Filename...: azzi001_01
#+ Description: 系統流程選單的子程式
#+ Creator....: 01274(2014-04-18 18:12:42)
#+ Modifier...: 01274 -SD/PR- 01274
 
{</section>}
 
{<section id="azzi001_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
IMPORT com
IMPORT FGL azz_azzi001_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="azzi001_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 type type_g_gzbd_m     RECORD
       gzbd001             LIKE gzbd_t.gzbd001, 
       gzbd002             LIKE gzbd_t.gzbd002, 
       gzbdl003            LIKE gzbdl_t.gzbdl003, 
       gzbd003             LIKE gzbd_t.gzbd003, 
       gzbdstus            LIKE gzbd_t.gzbdstus, 
       gzbdownid           LIKE gzbd_t.gzbdownid, 
       gzbdownid_desc      LIKE type_t.chr80, 
       gzbdowndp           LIKE gzbd_t.gzbdowndp, 
       gzbdowndp_desc      LIKE type_t.chr80, 
       gzbdcrtid           LIKE gzbd_t.gzbdcrtid, 
       gzbdcrtid_desc      LIKE type_t.chr80, 
       gzbdcrtdp           LIKE gzbd_t.gzbdcrtdp, 
       gzbdcrtdp_desc      LIKE type_t.chr80, 
       gzbdcrtdt           LIKE gzbd_t.gzbdcrtdt, 
       gzbdmodid           LIKE gzbd_t.gzbdmodid, 
       gzbdmodid_desc      LIKE type_t.chr80, 
       gzbdmoddt           LIKE gzbd_t.gzbdmoddt
                        END RECORD
TYPE type_g_detail1     RECORD
         gzbd001           LIKE gzbd_t.gzbd001,
         gzbd002           LIKE gzbd_t.gzbd002,
         gzbd003_img       LIKE gzbd_t.gzbd003,
         gzbd003           LIKE gzbd_t.gzbd003,
         gzbdl003          LIKE gzbdl_t.gzbdl003
                        END RECORD
DEFINE g_master_multi_table_t    RECORD
         gzbdl001          LIKE gzbdl_t.gzbdl001,
         gzbdl003          LIKE gzbdl_t.gzbdl003
                        END RECORD

DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_gzbd_m         type_g_gzbd_m
DEFINE g_gzbd_m_t       type_g_gzbd_m
DEFINE g_gzbd_m_o       type_g_gzbd_m
DEFINE g_detail1        DYNAMIC ARRAY OF type_g_detail1
DEFINE g_gzbd001_t      LIKE gzbd_t.gzbd001
DEFINE g_master_insert  BOOLEAN

DEFINE g_log1           STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2           STRING                        #cl_log_modified_record用(新值)
DEFINE g_current_idx    INTEGER
#end add-point
 
{</section>}
 
{<section id="azzi001_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_forupd_sql     STRING
DEFINE g_res_img_path   STRING
#end add-point
 
{</section>}
 
{<section id="azzi001_01.other_dialog" >}

 
{</section>}
 
{<section id="azzi001_01.other_function" readonly="Y" >}

PUBLIC FUNCTION azzi001_01()
   DEFINE l_sql         STRING
   DEFINE l_gzbd002_cb  ui.ComboBox
   
   WHENEVER ERROR CALL cl_err_msg_log
   
   LET g_res_img_path = os.Path.join(FGL_GETENV("RES"), "img")
   LET g_res_img_path = os.Path.join(g_res_img_path, "ui"), os.Path.separator()
   
   LET g_forupd_sql = " SELECT '','',gzbd001,gzbd002,gzbd003,gzbdstus,gzbdownid,'',gzbdcrtid,'',gzbdowndp, '',",
                      " gzbdcrtdp,'',gzbdcrtdt,gzbdmodid,'',gzbdmoddt", 
                      " FROM gzbd_t",
                      " WHERE gzbdent= ? AND gzbd001=? FOR UPDATE"
                      
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi001_01_cl CURSOR FROM g_forupd_sql   
   
   LET l_sql = " SELECT UNIQUE t0.gzbd001, t0.gzbd002, t0.gzbd003, t0.gzbdstus, t0.gzbdownid ,t0.gzbdcrtid, ",
               " t0.gzbdowndp,t0.gzbdcrtdp,t0.gzbdcrtdt,t0.gzbdmodid,t0.gzbdmoddt,t1.oofa011 ,t2.oofa011 ,t3.ooefl003, ",
               " t4.ooefl003 ,t5.oofa011",
               " FROM gzbd_t t0",
               " LEFT JOIN oofa_t  t1 ON t1.oofaent ='"||g_enterprise||"' AND t1.oofa002 ='2' AND t1.oofa003=t0.gzbdownid  ",
               " LEFT JOIN oofa_t  t2 ON t2.oofaent ='"||g_enterprise||"' AND t2.oofa002 ='2' AND t2.oofa003=t0.gzbdcrtid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.gzbdowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.gzbdcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t  t5 ON t5.oofaent ='"||g_enterprise||"' AND t5.oofa002 ='2' AND t5.oofa003=t0.gzbdmodid  ",
               " WHERE t0.gzbdent = '" ||g_enterprise|| "' AND t0.gzbd001 = ?"
                
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE azzi001_01_master_referesh FROM l_sql
   
   LET l_sql = "SELECT gzbd001, gzbd002, gzbd003, gzbd003, gzbdl003 ",
               " FROM gzbd_t LEFT JOIN gzbdl_t",
               " ON gzbd001 = gzbdl001 AND gzbdl002 = '",g_dlang,"'  AND gzbdent = gzbdlent WHERE gzbdent = '", g_enterprise, "' "
   PREPARE azzi001_01_detail_pre FROM l_sql
   DECLARE azzi001_01_detail_cur CURSOR FOR azzi001_01_detail_pre
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi001_01 WITH FORM cl_ap_formpath("azz","azzi001_01")
                                 ATTRIBUTE(STYLE="layoutwin")
                                 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #狀態碼初始化
   CALL cl_set_combo_scc_part('gzbdstus','17','N,Y')
   
   #節點類型目前只限定image
   LET l_gzbd002_cb = ui.ComboBox.forName("gzbd002")
   IF l_gzbd002_cb IS NOT NULL THEN
      CALL l_gzbd002_cb.clear()
      CALL l_gzbd002_cb.addItem("image", "Image")
      CALL l_gzbd002_cb.addItem("program", "Program")
   END IF
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()  
   
   CALL azzi001_01_show()

   CALL azzi001_01_dialog()

   #畫面關閉
   CLOSE WINDOW w_azzi001_01
END FUNCTION

PUBLIC FUNCTION azzi001_01_input(p_cmd)
   DEFINE p_cmd            LIKE type_t.chr5
   DEFINE l_ac_t           LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert   LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete   LIKE type_t.num5        #可刪除否
   DEFINE l_count          LIKE type_t.num5
   DEFINE l_insert         LIKE type_t.num5
   DEFINE l_var_keys       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak   DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys     DYNAMIC ARRAY OF STRING
   DEFINE l_vars           DYNAMIC ARRAY OF STRING
   DEFINE l_fields         DYNAMIC ARRAY OF STRING
   DEFINE l_upload         STRING
   DEFINE l_res_img_path   STRING
   DEFINE l_img_fullpath   STRING
   DEFINE l_up_filename    STRING
   DEFINE l_dst_filename   STRING
   
   #輸入前處理
   #add-point:單頭前置處理

   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED)
      
      #輸入開始
      INPUT g_gzbd_m.gzbd002,g_gzbd_m.gzbdl003,g_gzbd_m.gzbd003,g_gzbd_m.gzbdstus, l_upload
            FROM gzbd002, gzbdl003, gzbd003, gzbdstus, l_upload
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            LET g_master_multi_table_t.gzbdl001 = g_gzbd_m.gzbd001
            LET g_master_multi_table_t.gzbdl003 = g_gzbd_m.gzbdl003
            
         ON ACTION controlp
            CASE FGL_DIALOG_GETFIELDNAME()
               WHEN "gzbd003"
                  LET l_img_fullpath = os.Path.join(g_res_img_path, g_gzbd_m.gzbd003)
                  CALL azz_azzi001_02.azzi001_02(l_img_fullpath, g_res_img_path) RETURNING l_img_fullpath
                  IF l_img_fullpath IS NOT NULL THEN
                     LET g_gzbd_m.gzbd003 = l_img_fullpath.subString(g_res_img_path.getLength()+1, l_img_fullpath.getLength())
                     DISPLAY l_img_fullpath TO formonly.gzbd003_img
                  ELSE
                     DISPLAY NULL TO formonly.gzbd003_img
                  END IF
                  
            END CASE

            
         #AFTER FIELD gzbd001
         #   #確認資料無重複
         #   IF  NOT cl_null(g_gzbd_m.gzbd001) THEN
         #      IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzbd_m.gzbd001 != g_gzbd001_t )) THEN
         #         IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzbd_t WHERE "||"gzbdent = '" ||g_enterprise|| "' AND "||"gzbd001 = '"||g_gzbd_m.gzbd001 ||"'",'std-00004',0) THEN
         #            NEXT FIELD CURRENT
         #         END IF
         #      END IF
         #   END IF
            
         ON ACTION open_file
            LET l_upload = azzi001_01_win_open_file("C:\\", "Image Type", "*.jpg;*.png", "Select a Image")
            LET l_up_filename = os.Path.basename(l_upload)
            DISPLAY l_up_filename
            
         ON ACTION upload
            IF l_upload IS NOT NULL THEN
               LET l_dst_filename = os.Path.join(l_res_img_path, l_up_filename)
               #檢查Server是否已有同名
               IF (os.Path.exists( l_dst_filename ) ) THEN
                  IF cl_ask_confirm( sfmt(cl_getmsg('azz-00327', g_lang), l_up_filename)) == FALSE THEN
                     CONTINUE DIALOG
                  END IF
               END IF
               CALL FGL_GETFILE(l_upload, l_dst_filename)
            END IF
            
         ON ACTION update_item
            IF cl_auth_chk_act("update_item") THEN               
               CALL n_gzbdl(g_gzbd_m.gzbd001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzbd_m.gzbd001
               CALL ap_ref_array2(g_ref_fields," SELECT gzbdl003 FROM gzbdl_t WHERE gzbdl001 = ? AND gzbdl002 = '"||g_lang||"' AND gzbdlent = '"||g_enterprise||"' ","") RETURNING g_rtn_fields
               LET g_gzbd_m.gzbdl003 = g_rtn_fields[1]
               DISPLAY BY NAME g_gzbd_m.gzbdl003
            END IF
            
         ON ACTION statechange
            CALL azzi001_01_statechange()
            
         #此段落由子樣板a04產生
         ON CHANGE gzbd003
            #add-point:ON CHANGE gzbd003
            DISPLAY g_gzbd_m.gzbd003 TO gzbd003
            #END add-point

         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM gzbd_t WHERE gzbdent = g_enterprise AND gzbd001 = g_gzbd_m.gzbd001

               IF l_count = 0 THEN               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO gzbd_t (gzbd001,gzbd002,gzbd003,gzbdstus,gzbdent,
                                      gzbdownid,gzbdcrtid,gzbdowndp,gzbdcrtdp,gzbdcrtdt)
                              VALUES (g_gzbd_m.gzbd001,g_gzbd_m.gzbd002,g_gzbd_m.gzbd003,g_gzbd_m.gzbdstus,g_enterprise,
                                      g_gzbd_m.gzbdownid,g_gzbd_m.gzbdcrtid,g_gzbd_m.gzbdowndp,g_gzbd_m.gzbdcrtdp,g_gzbd_m.gzbdcrtdt)  

                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzbd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     CONTINUE DIALOG
                  END IF
                  
                  #資料多語言用-增/改
                  INITIALIZE l_var_keys TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  INITIALIZE l_vars TO NULL 
                  INITIALIZE l_fields TO NULL 
                  IF g_gzbd_m.gzbd001 = g_master_multi_table_t.gzbdl001 AND
                     g_gzbd_m.gzbdl003 = g_master_multi_table_t.gzbdl003  THEN
                  ELSE 
                     LET l_var_keys[01] = g_gzbd_m.gzbd001
                     LET l_field_keys[01] = 'gzbdl001'
                     LET l_var_keys_bak[01] = g_master_multi_table_t.gzbdl001
                     LET l_var_keys[02] = g_dlang
                     LET l_field_keys[02] = 'gzbdl002'
                     LET l_var_keys_bak[02] = g_dlang
                     LET l_vars[01] = g_gzbd_m.gzbdl003
                     LET l_fields[01] = 'gzbdl003'
                     LET l_vars[02] = g_enterprise 
                     LET l_fields[02] = 'gzbdlent'
                     CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzbdl_t')
                  END IF 
                  CALL s_transaction_end('Y','0')
                  LET g_master_insert = TRUE
                  LET p_cmd = 'u'
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  "g_gzbd_m.gzbd001" 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE

               UPDATE gzbd_t SET (gzbd003,  gzbd001,   gzbd002, 
                                  gzbdstus, gzbdownid, gzbdcrtid,
                                  gzbdowndp,gzbdcrtdp, gzbdcrtdt ) = (
                                  g_gzbd_m.gzbd003,   g_gzbd_m.gzbd001,   g_gzbd_m.gzbd002, 
                                  g_gzbd_m.gzbdstus,  g_gzbd_m.gzbdownid, g_gzbd_m.gzbdcrtid,
                                  g_gzbd_m.gzbdowndp, g_gzbd_m.gzbdcrtdp, g_gzbd_m.gzbdcrtdt) 
                WHERE gzbdent = g_enterprise AND gzbd001 = g_gzbd001_t 

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzbd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzbd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     CALL s_transaction_end('N','0')
                  OTHERWISE                     
                     #資料多語言用-增/改
                     INITIALIZE l_var_keys TO NULL 
                     INITIALIZE l_field_keys TO NULL 
                     INITIALIZE l_vars TO NULL 
                     INITIALIZE l_fields TO NULL 
                     IF g_gzbd_m.gzbd001 = g_master_multi_table_t.gzbdl001 AND
                        g_gzbd_m.gzbdl003 = g_master_multi_table_t.gzbdl003  THEN
                     ELSE 
                        LET l_var_keys[01] = g_gzbd_m.gzbd001
                        LET l_field_keys[01] = 'gzbdl001'
                        LET l_var_keys_bak[01] = g_master_multi_table_t.gzbdl001
                        LET l_var_keys[02] = g_dlang
                        LET l_field_keys[02] = 'gzbdl002'
                        LET l_var_keys_bak[02] = g_dlang
                        LET l_vars[01] = g_gzbd_m.gzbdl003
                        LET l_fields[01] = 'gzbdl003'
                        LET l_vars[02] = g_enterprise 
                        LET l_fields[02] = 'gzbdlent'
                        CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzbdl_t')
                     END IF 
 
                     #紀錄資料更動
                     LET g_log1 = util.JSON.stringify(g_gzbd_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzbd_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            END IF
            
      END INPUT

      #公用action
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG


END FUNCTION

PRIVATE FUNCTION azzi001_01_modify()
   #先確定key值無遺漏
   IF g_gzbd_m.gzbd001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_gzbd001_t = g_gzbd_m.gzbd001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN azzi001_01_cl USING g_enterprise,g_gzbd_m.gzbd001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi001_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi001_01_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi001_01_master_referesh USING g_gzbd_m.gzbd001 INTO g_gzbd_m.gzbd001,g_gzbd_m.gzbd002,g_gzbd_m.gzbd003, 
       g_gzbd_m.gzbdstus,g_gzbd_m.gzbdownid,g_gzbd_m.gzbdcrtid,g_gzbd_m.gzbdowndp,g_gzbd_m.gzbdcrtdp, 
       g_gzbd_m.gzbdcrtdt,g_gzbd_m.gzbdmodid,g_gzbd_m.gzbdmoddt,g_gzbd_m.gzbdownid_desc,g_gzbd_m.gzbdcrtid_desc, 
       g_gzbd_m.gzbdowndp_desc,g_gzbd_m.gzbdcrtdp_desc,g_gzbd_m.gzbdmodid_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzbd_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE azzi001_01_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   #顯示資料
   CALL azzi001_01_show()
   
   WHILE TRUE
      LET g_gzbd_m.gzbd001 = g_gzbd001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_gzbd_m.gzbdmodid = g_user 
      LET g_gzbd_m.gzbdmoddt = cl_get_current()
      LET g_gzbd_m.gzbdmodid_desc = cl_get_username(g_gzbd_m.gzbdmodid)
      
      #add-point:modify段修改前

      #end add-point
 
      #資料輸入
      CALL azzi001_01_input("u")     
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzbd_m.* = g_gzbd_m_t.*
         CALL azzi001_01_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE gzbd_t SET (gzbdmodid,gzbdmoddt) = (g_gzbd_m.gzbdmodid,g_gzbd_m.gzbdmoddt)
       WHERE gzbdent = g_enterprise AND gzbd001 = g_gzbd001_t
 
 
      EXIT WHILE
      
   END WHILE
   
   CLOSE azzi001_01_cl
   CALL s_transaction_end('Y','0')
   
   CALL azzi001_01_show()
   CALL azzi001_01_fill_master()
   #流程通知預埋點-U(暫時無用)
   #CALL cl_flow_notify(g_gzbd_m.gzbd001,"U")
   
END FUNCTION

PRIVATE FUNCTION azzi001_01_show()
   DEFINE l_detail1     type_g_detail1
   DEFINE l_len         INTEGER
   
   CALL g_detail1.clear()

   OPEN azzi001_01_detail_cur
   FOREACH azzi001_01_detail_cur INTO l_detail1.*
      CALL g_detail1.appendElement()
      LET l_len = g_detail1.getLength()
      LET g_detail1[l_len].* = l_detail1.*
   END FOREACH
   IF g_current_idx > g_detail1.getLength() THEN
      LET g_current_idx = g_detail1.getLength()
   END IF
   
   CLOSE azzi001_01_detail_cur
   
END FUNCTION

PRIVATE FUNCTION azzi001_01_insert()
   
   #清畫面欄位內容
   CLEAR FORM

   INITIALIZE g_gzbd_m.* TO NULL

   LET g_master_insert = FALSE

   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生
      #公用欄位新增給值
      LET g_gzbd_m.gzbdownid = g_user
      LET g_gzbd_m.gzbdowndp = g_dept
      LET g_gzbd_m.gzbdcrtid = g_user
      LET g_gzbd_m.gzbdcrtdp = g_dept
      LET g_gzbd_m.gzbdcrtdt = cl_get_current()
      LET g_gzbd_m.gzbdmodid = ""
      LET g_gzbd_m.gzbdmoddt = ""
      LET g_gzbd_m.gzbdstus = "Y"
      
      #一般欄位給值
      LET g_gzbd_m.gzbd001 = azzi001_01_gen_gzbd001()
      LET g_gzbd_m.gzbd002 = "image"

      #顯示狀態(stus)圖片
      CASE g_gzbd_m.gzbdstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      END CASE

      CALL azzi001_01_input("a")
      IF INT_FLAG AND NOT g_master_insert THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 9001
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0

         INITIALIZE g_gzbd_m.* TO NULL

         CALL azzi001_01_show()
         RETURN
      END IF

      LET INT_FLAG = 0

      CALL s_transaction_end('Y','0')
      EXIT WHILE

   END WHILE

   CLOSE azzi001_01_cl
   CALL azzi001_01_show()
   CALL azzi001_01_fill_master()
   
   
END FUNCTION

PRIVATE FUNCTION azzi001_01_dialog()
   DIALOG ATTRIBUTES(UNBUFFERED)
      DISPLAY ARRAY g_detail1 TO s_detail1.*
         BEFORE ROW
            LET g_current_idx = ARR_CURR()
            CALL azzi001_01_fill_master()
         BEFORE DISPLAY
            CALL dialog.setCurrentRow("s_detail1", g_current_idx)
            
      END DISPLAY
      
      ON ACTION insert
         IF cl_auth_chk_act("insert") THEN
            CALL azzi001_01_insert()
         END IF
         
      ON ACTION modify
         IF cl_auth_chk_act("modify") THEN
            CALL azzi001_01_modify()
         END IF
         
      ON ACTION delete
         IF cl_auth_chk_act("delete") THEN
            CALL azzi001_01_delete()
         END IF
         
      ON ACTION exit
         EXIT DIALOG
         
      ON ACTION close
         EXIT DIALOG
         
      #主選單用ACTION
      &include "main_menu.4gl"
      &include "relating_action.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
         
   END DIALOG
END FUNCTION

PRIVATE FUNCTION azzi001_01_fill_master()
   DEFINE l_img_path    STRING
   
   #根據選定的筆數給予key欄位值
   IF g_current_idx == 0 THEN 
      IF g_detail1.getLength() == 0 THEN RETURN END IF
      LET g_current_idx = 1
   END IF
   LET g_gzbd_m.gzbd001 = g_detail1[g_current_idx].gzbd001
   
   #顯示最新的資料
   EXECUTE azzi001_01_master_referesh USING g_gzbd_m.gzbd001 INTO g_gzbd_m.gzbd001,g_gzbd_m.gzbd002,g_gzbd_m.gzbd003, 
       g_gzbd_m.gzbdstus,g_gzbd_m.gzbdownid,g_gzbd_m.gzbdcrtid,g_gzbd_m.gzbdowndp,g_gzbd_m.gzbdcrtdp, 
       g_gzbd_m.gzbdcrtdt,g_gzbd_m.gzbdmodid,g_gzbd_m.gzbdmoddt,g_gzbd_m.gzbdownid_desc,g_gzbd_m.gzbdcrtid_desc, 
       g_gzbd_m.gzbdowndp_desc,g_gzbd_m.gzbdcrtdp_desc,g_gzbd_m.gzbdmodid_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzbd_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE azzi001_01_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #保存單頭舊值
   LET g_gzbd_m_t.* = g_gzbd_m.*
   LET g_gzbd_m_o.* = g_gzbd_m.*
   
   LET g_data_owner = g_gzbd_m.gzbdownid      
   LET g_data_dept  = g_gzbd_m.gzbdowndp

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzbd_m.gzbd001
   CALL ap_ref_array2(g_ref_fields," SELECT gzbdl003 FROM gzbdl_t WHERE gzbdlent = '"||g_enterprise||"' AND gzbdl001 = ? AND gzbdl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzbd_m.gzbdl003 = g_rtn_fields[1] 
   DISPLAY g_gzbd_m.gzbdl003 TO gzbdl003
   #end add-point
 
   LET l_img_path = os.Path.join(g_res_img_path, g_gzbd_m.gzbd003)
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzbd_m.gzbd001,g_gzbd_m.gzbd002,g_gzbd_m.gzbd003, 
       g_gzbd_m.gzbdstus,g_gzbd_m.gzbdownid,g_gzbd_m.gzbdcrtid,g_gzbd_m.gzbdowndp,g_gzbd_m.gzbdcrtdp, 
       g_gzbd_m.gzbdcrtdt,g_gzbd_m.gzbdmodid,g_gzbd_m.gzbdmoddt,g_gzbd_m.gzbdownid_desc,g_gzbd_m.gzbdcrtid_desc, 
       g_gzbd_m.gzbdowndp_desc,g_gzbd_m.gzbdcrtdp_desc,g_gzbd_m.gzbdmodid_desc
   DISPLAY l_img_path TO gzbd003_img
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_gzbd_m.gzbdstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
END FUNCTION

PRIVATE FUNCTION azzi001_01_win_open_file(p_dir,p_type,p_exts,p_caption)
   DEFINE p_dir STRING
   DEFINE p_type STRING
   DEFINE p_exts STRING
   DEFINE p_caption STRING
   DEFINE fn STRING
   
   WHENEVER ERROR CONTINUE
   CALL ui.Interface.frontcall("standard","openfile",
           [p_dir,p_type,p_exts,p_caption],[fn])
   WHENEVER ERROR STOP
   IF STATUS=0 THEN RETURN fn ELSE RETURN NULL END IF
END FUNCTION

PRIVATE FUNCTION azzi001_01_statechange()
   DEFINE lc_state LIKE type_t.chr5
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzbd_m.gzbd001 IS NULL
 
   THEN
      #INITIALIZE g_errparam TO NULL 
      #LET g_errparam.extend = "" 
      #LET g_errparam.code   = "std-00003" 
      #LET g_errparam.popup  = FALSE 
      #CALL cl_err()
 
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU

         CASE g_gzbd_m.gzbdstus
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"            
         END CASE
      
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
         END IF
         EXIT MENU

   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF

   UPDATE gzbd_t SET gzbdstus = lc_state 
    WHERE gzbdent = g_enterprise AND gzbd001 = g_gzbd_m.gzbd001 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err() 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")         
      END CASE
      LET g_gzbd_m.gzbdstus = lc_state
      DISPLAY BY NAME g_gzbd_m.gzbdstus
   END IF
 
END FUNCTION

PRIVATE FUNCTION azzi001_01_gen_gzbd001()
   DEFINE l_gzbd001     LIKE gzbd_t.gzbd001
   DEFINE l_cnt         INTEGER
   
   WHILE TRUE
      LET l_gzbd001 = com.Util.CreateUUIDString()
      SELECT COUNT(*) INTO l_cnt FROM gzbd_t WHERE gzbd001 = l_gzbd001
      IF l_cnt == 0 THEN
         EXIT WHILE
      END IF
   END WHILE
   RETURN l_gzbd001
END FUNCTION

PRIVATE FUNCTION azzi001_01_delete()
   DEFINE l_idx      INTEGER
   DEFINE l_gzbd001  LIKE gzbd_t.gzbd001
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   
   LET l_gzbd001 = g_gzbd_m.gzbd001
   
   IF l_gzbd001 IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   OPEN azzi001_01_cl USING g_enterprise, l_gzbd001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi001_01_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi001_01_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   IF cl_ask_delete() THEN 
      FOR l_idx = 1 TO 1
         #刪除節點
         DELETE FROM gzbd_t
            WHERE gzbdent = g_enterprise AND gzbd001 = l_gzbd001
         IF SQLCA.sqlcode THEN EXIT FOR END IF
         
         #刪除相關的多語言
         DELETE FROM gzbdl_t
               WHERE gzbdlent = g_enterprise AND gzbdl001 = l_gzbd001
         IF SQLCA.sqlcode THEN EXIT FOR END IF         
      END FOR
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzbd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err() 
         CALL s_transaction_end('N','0')
      ELSE
         #刪除相關文件
         CALL g_pk_array.clear()
         INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys   TO NULL          
         LET g_pk_array[1].values = l_gzbd001
         LET g_pk_array[1].column = 'gzbd001'
         CALL cl_doc_remove()    
         CLEAR FORM
      END IF
   END IF
   
   CLOSE azzi001_01_cl
   CALL s_transaction_end('Y','0')
   
   CALL azzi001_01_show()
   CALL azzi001_01_fill_master()
END FUNCTION

 
{</section>}
 
