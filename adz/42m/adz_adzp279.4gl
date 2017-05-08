#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp270
#+ 設計人員......: cch
#+ 功能名稱說明...: 程式與規格複製
#+ 除錯模式....:  執行方式 r.r adzp270 debug
#+ 修改歷程......: 2014/03/12 by madey : 調整adzp270_gen_replace_sql_str對於子畫面的還原規則


IMPORT os
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 

#單身 type 宣告
PRIVATE TYPE type_col_relation   RECORD
      old_table_id   LIKE dzea_t.dzea001,
      old_col_id     LIKE dzeb_t.dzeb002,
      old_col_key    LIKE type_t.chr20,
      old_col_name   LIKE dzebl_t.dzebl003,
      relation_no    LIKE type_t.num5,
      new_table_id   LIKE dzea_t.dzea001,
      new_col_id     LIKE dzeb_t.dzeb002,
      new_col_key    LIKE type_t.chr20,
      new_col_name   LIKE dzebl_t.dzebl003
       END RECORD
 
DEFINE   g_erp                STRING,              　    #TIPTOP起始目錄
         g_main_or_sub_prog   STRING,              　    #主程式和畫面/子程式和畫面/子畫面
         g_prog_class         STRING,              　    #程式類別
         g_prog_module        STRING,              　    #模組代碼
         
         g_copy_source        LIKE dzaa_t.dzaa001, 　    #複製來源
         g_source_ver         LIKE dzaa_t.dzaa002, 　    #來源建構版次
         g_source_spec_ver    LIKE dzaa_t.dzaa002,       #來源規格版次
         g_source_code_ver    LIKE dzaa_t.dzaa002,       #來源代碼版次
         g_copy_source_name   LIKE gzzal_t.gzzal003,     #來源程式名稱
         ms_dgenv             LIKE type_t.chr1,          #環境變數DGENV (s:標準/ c:客製)
         g_gen_prog           LIKE dzaa_t.dzaa001, 　    #產生程式
         g_gen_spec_ver           LIKE dzaa_t.dzaa002, 　    #產生程式的規格版次
         g_design_point_ver         LIKE dzaa_t.dzaa004, #生程式的設計點版次
         g_gen_prog_name      LIKE gzzal_t.gzzal003,     #產生程式名稱
         g_pro_msg            STRING,                    #處理過程訊息
         g_source_4fd_path    STRING,              　    #來源的4FD檔的檔案路徑
         g_gen_4fd_path       STRING,              　    #產生的4FD檔的檔案路徑
         gr_gzza   　　　　　　 RECORD
            gzza003     　　　　　LIKE gzza_t.gzza003      #模組編號
          　　　　　　　　　　　  END RECORD,
         ga_gzzd_t            DYNAMIC ARRAY OF RECORD    #畫面元件多語言記錄檔    
            source_label　　　　  LIKE gzzd_t.gzzd003,      #來源程式的標籤
            gen_label            LIKE gzzd_t.gzzd003       #產生程式的標籤
                              END RECORD,
         ga_gzzq_t            DYNAMIC ARRAY OF RECORD    #ACTION多語言對照檔
            gzzq002     　　　　  LIKE gzzq_t.gzzq002     #功能編號
                              END RECORD,
         g_use_table_replace  LIKE type_t.chr1,          #是否啟用表格替換功能
         g_rm_excluded_col_4fd  LIKE type_t.chr1,        #是否自動移除4fd中的要排除的元件
         g_not_copy_appoint    LIKE type_t.chr1,         #是否不複製appoint的內容
         g_use_current_sub_prog LIKE type_t.chr1,        #是否使用原本的子程式
         gwin_curr             ui.Window,                     #Current Window
         gfrm_curr             ui.Form,                       #Current Form
         g_copy_source_data   STRING,                    #說明來源程式的表格主從關係
         g_no_1               LIKE type_t.num5,
         g_no_2               LIKE type_t.num5,
         g_dzaa_t_exculded_wc   STRING,   #設計資料的排除條件
         g_dzba_t_exculded_wc   STRING,   #appint的排除資料
         g_gzzd_t_exculded_wc   STRING,   #appint的排除資料
         #ga_excluded_node DYNAMIC ARRAY OF om.DomNode, #要排除的節點陣列
         g_is_import_setting_date LIKE type_t.num5,
         ga_dzag_tree  DYNAMIC ARRAY OF RECORD  #表格的主從關係
            table_id    LIKE dzag_t.dzag002,
            table_name  LIKE dzebl_t.dzebl003,
            expanded    LIKE type_t.chr1,
            parent_id   LIKE type_t.chr10,
            current_id  LIKE type_t.chr10
         END RECORD,
         ga_dzag  DYNAMIC ARRAY OF RECORD        #新舊表格對應表
            old_table_id       LIKE dzag_t.dzag002,
            old_table_name     LIKE dzeal_t.dzeal003,
            old_table_parent   LIKE dzag_t.dzag004,
            old_table_main     LIKE dzag_t.dzag005,
            new_table_id       LIKE dzag_t.dzag002,
            new_table_name     LIKE dzeal_t.dzeal003,
            new_table_parent   LIKE dzag_t.dzag004,
            new_table_main     LIKE dzag_t.dzag005,
            pair_no            LIKE type_t.num5
         END RECORD,
         ga_dzeb DYNAMIC ARRAY OF type_col_relation,          #編輯用新舊欄位對應表
  
         ga_dzeb_stored DYNAMIC ARRAY OF type_col_relation,   #儲存用新舊欄位對應表

         ga_excluded_col DYNAMIC ARRAY OF RECORD  #沒有對應到要排除的欄位
            table_id       LIKE dzea_t.dzea001,
            col_id         LIKE dzeb_t.dzeb002,
            col_name       LIKE dzebl_t.dzebl003,
            table_id_tmp   LIKE dzea_t.dzea001,
            col_id_tmp     LIKE dzea_t.dzea001
         END RECORD,         
         g_multi_lang_table DYNAMIC ARRAY OF RECORD #所用到的多語言表格
            table_id       LIKE dzea_t.dzea001,
            table_name     LIKE dzeal_t.dzeal003
          END RECORD,
         ga_sub_prog  DYNAMIC ARRAY OF RECORD #此主程式會用到的子元件或作業
            sub_prog_id    LIKE dzaa_t.dzaa001,
            sub_prog_name  LIKE dzaa_t.dzaa001,
            sub_prog_tmp_id LIKE dzaa_t.dzaa001,
            sub_prog_type LIKE type_t.chr1    #類別: S子程式  F子畫面  B應用元件 add by madey 20140312
          END RECORD,
         ga_dzca      DYNAMIC ARRAY OF RECORD #存放開窗識別碼
            origin         LIKE dzca_t.dzca001,
            replace        STRING
          END RECORD,
         ga_dzcd      DYNAMIC ARRAY OF RECORD #存放校驗帶值識別碼
            origin         LIKE dzcd_t.dzcd001,
            replace        STRING
          END RECORD,
         g_run_mode LIKE type_t.chr20,
         g_source_free_style LIKE gzza_t.gzza007, #判斷來源程式是否是free style
         g_gen_free_style LIKE gzza_t.gzza007,     #判斷目標程式是否是free style
         g_free_style_flag LIKE type_t.chr1   #判斷是否改變目標程式的free style設定
#+ 作業開始
MAIN

   OPTIONS
     INPUT WRAP
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz","")

   CALL cl_tool_init()   

   #切換至使用者所需要的資料庫 (營運中心)  #to do
   DISCONNECT CURRENT #todo
   CONNECT TO "ds" #todo
   #DISPLAY 'connect:ds->',STATUS

 
   IF g_bgjob = "Y" THEN
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzp270 WITH FORM cl_ap_formpath("adz",g_prog)

      #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
      CALL cl_load_4ad_interface(NULL)

      #UI畫面初始化
      CALL cl_ui_init()

      CALL adzp270_init()
     
      CALL adzp270_input()
 
      #畫面關閉
      CLOSE WINDOW w_adzp270
   END IF
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN


#+ 初始化變數
PRIVATE FUNCTION adzp270_init()
   LET g_run_mode = ARG_VAL(2)
   IF NOT cl_null(g_run_mode) THEN
      DISPLAY "˙adzp270執行模式:",g_run_mode
   END IF
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED  #環境變數DGENV (s:標準/ c:客製)
   LET g_main_or_sub_prog = "M"
   LET g_erp = FGL_GETENV("ERP")
   CALL ui.Interface.loadStyles(os.Path.join(g_erp,os.Path.join("cfg",os.Path.join("4st","adzp270.4st"))))
   LET g_source_ver = ""   #預設來源版次為1
   LET g_is_import_setting_date = FALSE
   LET g_gen_spec_ver   = "1"   #預設產生程式的規格版次為1
   LET g_design_point_ver = "1"   #預設產生程式的設計點版次為1
   LET g_free_style_flag = "N"    #判斷是否改變目標程式的free style設定
   LET g_copy_source = ""
   LET g_gen_prog = ""
   LET g_gen_free_style = "N"
   LET g_free_style_flag = "N"
   #LET g_idle_seconds = 120
   #LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   #LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   CALL cl_set_comp_visible("page_table_replace",FALSE)#隱藏表格替換設定區
   
   IF g_run_mode = "debug" THEN
      CALL cl_set_comp_visible("page_table_replace2",TRUE)
   END IF
   
   LET g_use_table_replace = "N" ###測試用：預設表格替換功能啟動
   LET g_rm_excluded_col_4fd = "N" ###測試用：
   LET g_not_copy_appoint = "N" ###測試用：
   LET g_use_current_sub_prog = "Y" ###測試用：
   --LET g_copy_source = "artt300" ###測試用：
   --LET g_gen_prog = "aiti002"    ###測試用：
   
   # 產生表格主從結構和表格對應關係
   --CALL adzp270_gen_table_relation()###測試用：
   #CALL adzp270_gen_col_relation(DIALOG.getCurrentRow("s_dzag_t"))###測試用：
   LET g_no_1 = NULL
   LET g_no_2 = NULL
   CASE g_use_table_replace
      WHEN "Y"
         #CALL gfrm_curr.setElementHidden("page_table_replace",0)
         CALL cl_set_comp_visible("page_table_replace",TRUE)#出現
         #NEXT FIELD lbl_new_table
      WHEN "N"
         #CALL gfrm_curr.setElementHidden("page_table_replace",1)
         CALL cl_set_comp_visible("page_table_replace",FALSE)#隱藏
         #NEXT FIELD s_copy_source
      END CASE

   #CALL adzp270_select_q_id_and_v_id()#測試
   
END FUNCTION


#+ 資料輸入
PRIVATE FUNCTION adzp270_input()
   DEFINE l_chk    LIKE type_t.num5, #程式代碼基本資料檢查
          ln_cnt   LIKE type_t.num5,
          l_action STRING,
          l_cmd    STRING,
          l_ac     LIKE type_t.num5,
          l_cnt    LIKE type_t.num5,
          l_i      LIKE type_t.num5,
          l_j    LIKE type_t.num5,
          l_k    LIKE type_t.num5,
          l_old_prefix STRING,
          l_allow_insert LIKE type_t.num5,
          l_allow_delete LIKE type_t.num5,
          l_allow_append LIKE type_t.num5,
          l_dzed002 LIKE dzed_t.dzed002,
          l_dzed004 LIKE dzed_t.dzed004,
          l_str     STRING,
          l_is_exchange LIKE type_t.num5,
          l_del_table   LIKE dzea_t.dzea001,
          l_pk LIKE dzed_t.dzed004,
          l_fk LIKE dzed_t.dzed004,
          l_pk_num LIKE type_t.num5,
          l_fk_num LIKE type_t.num5

   LET l_allow_insert = TRUE
   LET l_allow_delete = TRUE
   LET l_allow_append = TRUE
   LET l_is_exchange = FALSE
   CALL adzp270_set_comp_entry( "formonly.lbl_old_table", FALSE)

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT g_main_or_sub_prog,g_copy_source,g_gen_prog,g_copy_source_name,g_gen_prog_name,g_use_table_replace,g_rm_excluded_col_4fd,g_not_copy_appoint,g_use_current_sub_prog
            FROM
            s_main_or_sub_prog,s_copy_source,s_gen_prog,s_copy_source_name,s_gen_prog_name,s_use_table_replace,s_rm_excluded_col_4fd,s_not_copy_appoint,s_use_current_sub_prog
            ATTRIBUTE(WITHOUT DEFAULTS)

         ON CHANGE s_main_or_sub_prog
            #清空設定資料
            LET g_copy_source = ""
            LET g_copy_source_name = ""
            LET g_gen_prog = ""
            LET g_gen_prog_name = ""
            LET g_source_ver =""
            LET g_source_spec_ver=""
            LET g_source_code_ver=""
            DISPLAY g_source_ver,g_source_spec_ver,g_source_code_ver TO s_source_ver,s_spec_ver,s_code_ver
            CALL ga_sub_prog.clear()
            CALL g_multi_lang_table.clear()
            CALL ga_excluded_col.clear()
            CALL ga_dzeb_stored.clear()
            CALL ga_dzeb.clear()
            CALL ga_dzag.clear()
            CALL ga_dzag_tree.clear()
            CALL cl_set_act_visible("btn_test", FALSE)
            

            CASE g_main_or_sub_prog
               WHEN "M"
                  CALL adzp270_set_comp_entry( "formonly.lbl_old_table", FALSE)
                  CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
                  #CALL cl_ui_init()
               WHEN "S"
                  CALL adzp270_set_comp_entry( "formonly.lbl_old_table", FALSE)
                  CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
                  #CALL cl_ui_init()
               WHEN "F"
                  CALL adzp270_set_comp_entry( "formonly.lbl_old_table", TRUE)
                  CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
                  #CALL cl_ui_init()
                  
               WHEN "LIB"
                  CALL adzp270_set_comp_entry( "formonly.lbl_old_table", TRUE)
                  CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",FALSE)

                  
               WHEN "SUB"
                  CALL adzp270_set_comp_entry( "formonly.lbl_old_table", TRUE)
                  CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",FALSE)

            END CASE

         ON CHANGE s_use_table_replace 
            CASE g_use_table_replace
               WHEN "Y"
                  #CALL gfrm_curr.setElementHidden("page_table_replace",0)
                  IF NOT g_main_or_sub_prog = "LIB" OR NOT g_main_or_sub_prog = "SUB" AND ga_dzag.getLength()=0 THEN
                     #DISPLAY "g_is_import_setting_date = ",g_is_import_setting_date
                     LET g_is_import_setting_date = FALSE
                     # 產生表格主從結構和表格對應關係
                     CALL adzp270_gen_table_relation()
                  END IF
                  CALL DIALOG.nextField("lbl_new_table")
                  CALL cl_set_comp_visible("page_table_replace",TRUE)#出現
                  CALL cl_set_act_visible("btn_test", FALSE)

                  --NEXT FIELD lbl_new_table
                  #CALL DIALOG.setFieldTouched("s_copy_source",TRUE)

            
               WHEN "N"
                  #CALL gfrm_curr.setElementHidden("page_table_replace",1)
                  CALL DIALOG.nextField("s_copy_source")
                  CALL cl_set_comp_visible("page_table_replace",FALSE)#隱藏
                  --NEXT FIELD s_copy_source
   
            END CASE

         ON CHANGE s_rm_excluded_col_4fd
            DISPLAY g_rm_excluded_col_4fd

         #ON CHANGE CURRENT
            #CALL cl_set_act_visible("btn_test", FALSE)

         #來源版次 欄位值的校驗
         #AFTER FIELD s_source_ver
            #IF NOT cl_null(g_source_ver) THEN
               #[檢查輸入字串是否符合格式]
               #N: Numeric 0123456789
               #U: 大寫的 A-Z
               #L:  小寫的 a-z
               #_:  底線 underline
               #若檢查NL_,則檢查字串是否只包含數字,小寫的 a-z,底斜線
               #IF  NOT cl_chk_num(g_source_ver,"N") THEN
                  #CALL cl_err(g_source_ver,"adz-00147",g_errshow)
                  #NEXT FIELD s_source_ver
               #END IF
            #END IF

         ON CHANGE s_copy_source
         
            LET l_str = g_copy_source
            LET g_copy_source = l_str.trim()
            CALL ga_dzeb.clear()
            CALL ga_dzeb_stored.clear()
            CALL ga_excluded_col.clear()

            #清空設定資料
            LET g_source_ver =""
            LET g_source_spec_ver=""
            LET g_source_code_ver=""
            DISPLAY g_source_ver,g_source_spec_ver,g_source_code_ver TO s_source_ver,s_spec_ver,s_code_ver
            CALL ga_sub_prog.clear()
            CALL g_multi_lang_table.clear()
            CALL ga_excluded_col.clear()
            CALL ga_dzeb_stored.clear()
            CALL ga_dzeb.clear()
            CALL ga_dzag.clear()
            CALL ga_dzag_tree.clear()
            CALL cl_set_act_visible("btn_test", FALSE)


            SELECT COUNT(*) INTO l_cnt FROM dzaf_t WHERE dzaf001=g_copy_source
            IF l_cnt = 0 THEN # to do : 因應沒有在dzaf註冊的程式
               LET g_source_ver = ""
               LET g_source_spec_ver = "1"
               LET g_source_code_ver = "1"
            ELSE
               #選取該程式最大的建構版次
               SELECT MAX(dzaf002) INTO g_source_ver 
                  FROM dzaf_t WHERE dzaf001=g_copy_source
               #選取該程式和最大的建構版次對應的規格版次和代碼版次
               SELECT dzaf003,dzaf004 INTO g_source_spec_ver,g_source_code_ver 
                  FROM dzaf_t WHERE dzaf001=g_copy_source AND dzaf002=g_source_ver
            END IF

            DISPLAY g_source_ver,g_source_spec_ver,g_source_code_ver TO s_source_ver,s_spec_ver,s_code_ver

            IF NOT g_main_or_sub_prog = "LIB" OR NOT g_main_or_sub_prog = "SUB" THEN
               # 產生表格主從結構和表格對應關係
               CALL adzp270_gen_table_relation() 
            END IF
         #複製來源 欄位的校驗
         AFTER FIELD s_copy_source
            LET l_str = g_copy_source
            LET g_copy_source = l_str.trim()
            IF NOT cl_null(g_copy_source) THEN
            
               LET g_copy_source = g_copy_source CLIPPED

               #做來源程式的free style的檢驗 --> 提醒：此來源程式為Free  Style
               CASE g_main_or_sub_prog
                   WHEN "M"
                     SELECT gzza007 INTO g_source_free_style
                        FROM gzza_t
                        WHERE gzza001 = g_copy_source
                     IF g_source_free_style = "N" THEN
                        CALL cl_ask_pressanykey("adz-00248")
                     END IF
                  WHEN "S"
                     SELECT gzde004 INTO g_source_free_style
                       FROM gzde_t
                      WHERE gzde001 = g_copy_source
                     IF g_source_free_style = "N" THEN
                        CALL cl_ask_pressanykey("adz-00248")
                     END IF
               END CASE

               #檢查程式是否存在於基礎資料中
               IF NOT adzp270_chk_prog_id_exist(g_copy_source) THEN
                  #CALL ga_dzag_tree.clear()
                  #CALL ga_dzag.clear()
                  NEXT FIELD s_copy_source
               ELSE
                  #若程式存在於基礎資料則帶出程式的名稱
                  CASE g_main_or_sub_prog
                     WHEN "M"
                        SELECT gzzal003 INTO g_copy_source_name
                           FROM gzzal_t 
                           WHERE gzzal001 = g_copy_source AND gzzal002 = g_lang
                     WHEN "S"
                        SELECT gzdel003  INTO g_copy_source_name
                           FROM gzde_t 
                           LEFT JOIN gzdel_t 
                           ON gzde001 = gzdel001 AND gzdel002 = g_lang
                           WHERE gzde001=g_copy_source AND gzdestus = 'Y' AND gzde003 = 'S'
                    WHEN "F"
                        SELECT gzdfl003 INTO g_copy_source_name
                           FROM gzdf_t
                           LEFT JOIN gzdfl_t
                           ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
                           WHERE gzdf002 = g_copy_source
                     WHEN "SUB"
                        SELECT gzdel003  INTO g_copy_source_name
                           FROM gzde_t 
                           LEFT JOIN gzdel_t 
                           ON gzde001 = gzdel001 AND gzdel002 = g_lang
                           WHERE gzde001=g_copy_source AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'
                     WHEN "LIB"
                        SELECT gzdel003  INTO g_copy_source_name
                           FROM gzde_t 
                           LEFT JOIN gzdel_t 
                           ON gzde001 = gzdel001 AND gzdel002 = g_lang
                           WHERE gzde001=g_copy_source AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'
                  END CASE
                  DISPLAY g_copy_source_name TO s_copy_source_name
               END IF

               LET g_copy_source_data = g_copy_source," ",g_copy_source_name
               DISPLAY g_copy_source_data TO s_copy_source_data
               
               LET g_copy_source = g_copy_source CLIPPED
               #檢查來源程式是否有設計資料
               CASE g_main_or_sub_prog

                  WHEN "M"
                     SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_copy_source AND dzaa002 = g_source_spec_ver
                  WHEN "S"   #子程式與畫面azzi901
                     SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_copy_source AND dzaa002 = g_source_spec_ver
                  WHEN "F"   #子畫面azzi901
                     #SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_copy_source AND dzaa002 = g_source_spec_ver
                     LET ln_cnt =1
                  WHEN "LIB"
                     SELECT COUNT(*) INTO ln_cnt FROM  dzba_t WHERE dzba001 = g_copy_source AND dzba002 = g_source_code_ver
                  WHEN "SUB"
                     SELECT COUNT(*) INTO ln_cnt FROM  dzba_t WHERE dzba001 = g_copy_source AND dzba002 = g_source_code_ver
               END CASE

               IF ln_cnt = 0 THEN
                  CALL cl_err(g_copy_source,"adz-00144",g_errshow)
                  NEXT FIELD s_copy_source
               END IF
               
            END IF

         #複製來源 欄位的開窗
         ON ACTION controlp INFIELD s_copy_source

            CASE g_main_or_sub_prog

               WHEN "M"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_copy_source
                  LET g_qryparam.where = "gzzastus = 'Y' AND gzza003 <> 'ADZ'"
                  CALL q_gzza001()

               WHEN "S"   #子程式與畫面azzi901
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "gzde003 <> 'ADZ'"
                  CALL q_gzde001()

               WHEN "F"   #子畫面azzi901
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "gzde003 <> 'ADZ'"
                  CALL q_gzdf002()

               WHEN "LIB"  #共用程式
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1="B"
                  LET g_qryparam.arg2="LIB"
                  CALL q_gzde002()

               WHEN "SUB"  #副程式
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1="B"
                  LET g_qryparam.arg2="SUB"
                  CALL q_gzde002()

            END CASE
            LET g_copy_source = g_qryparam.return2
            LET g_copy_source_name = g_qryparam.return3
            DISPLAY g_copy_source_name TO s_copy_source_name
            CALL DIALOG.setFieldTouched("s_copy_source", TRUE)
            LET g_copy_source_data = g_copy_source," ",g_copy_source_name
            DISPLAY g_copy_source_data TO s_copy_source_data

            IF g_main_or_sub_prog = "LIB" OR g_main_or_sub_prog = "SUB" THEN
               ELSE
                  # 產生表格主從結構和表格對應關係
                  CALL adzp270_gen_table_relation() 
            END IF

         ON CHANGE s_gen_prog
         
        
            LET l_str = g_gen_prog
            LET g_gen_prog = l_str.trim()
            CALL cl_set_act_visible("btn_test", FALSE)

         #複製目標 欄位的校驗
         AFTER FIELD s_gen_prog
            LET l_str = g_gen_prog
            LET g_gen_prog = l_str.trim()
            IF NOT cl_null(g_gen_prog) THEN
               LET g_gen_prog = g_gen_prog CLIPPED

               #做來源程式的free style和 目標程式的 free style檢驗 -
               LET g_free_style_flag = "N"
               CASE g_main_or_sub_prog
                   WHEN "M"
                     SELECT gzza007 INTO g_gen_free_style
                        FROM gzza_t
                        WHERE gzza001 = g_gen_prog

                     #如果目標程式不是Free Style 而 來源程式是 Free Style,詢問是否在複製過程自動將 目標程式 改 Free Style
                     IF g_gen_free_style = "Y" AND g_source_free_style = "N" THEN
                        IF cl_ask_confirm_parm("adz-00246","") THEN
                           LET g_free_style_flag = "Y"
                        ELSE
                           NEXT FIELD s_gen_prog
                        END IF 
                     END IF

                     #如果目標程式是Free Style 而 來源程式不是 Free Style,詢問是否在複製過程自動將 目標程式 改 Free Style
                     IF g_gen_free_style = "N" AND g_source_free_style = "Y" THEN
                        IF cl_ask_confirm_parm("adz-00247","") THEN 
                           LET g_free_style_flag = "Y"
                        ELSE
                           NEXT FIELD s_gen_prog
                        END IF
                     END IF
                     
                  WHEN "S"
                     SELECT gzde004 INTO g_gen_free_style
                       FROM gzde_t
                       WHERE gzde001 = g_gen_prog

                     #如果目標程式不是Free Style 而 來源程式是 Free Style,詢問是否在複製過程自動將 目標程式 改 Free Style
                     IF g_gen_free_style = "Y" AND g_source_free_style = "N" THEN
                        IF cl_ask_confirm_parm("adz-00246","") THEN
                           LET g_free_style_flag = "Y"
                        ELSE
                           NEXT FIELD s_gen_prog
                        END IF
                     END IF

                     #如果目標程式是Free Style 而 來源程式不是 Free Style,詢問是否在複製過程自動將 目標程式 改 Free Style
                     IF g_gen_free_style = "N" AND g_source_free_style = "Y" THEN
                        IF cl_ask_confirm_parm("adz-00247","") THEN 
                           LET g_free_style_flag = "Y"
                        ELSE
                           NEXT FIELD s_gen_prog
                        END IF
                     END IF
               END CASE
               
               #檢查程式是否存在於基礎資料中
               IF NOT adzp270_chk_prog_id_exist(g_gen_prog) THEN
                  NEXT FIELD s_gen_prog
               ELSE

                  #檢查程式的最大規格版次是否大於1
                  SELECT MAX(dzaa002) INTO l_cnt 
                     FROM dzaa_t WHERE dzaa001=g_gen_prog

                  IF l_cnt > 1 THEN 
                     CALL cl_err_msg("","adz-00232",g_gen_prog,1)
                     NEXT FIELD s_gen_prog
                  END IF
                     
                  #檢查程式的最大代碼版次是否大於1
                  SELECT MAX(dzba002) INTO l_cnt 
                     FROM dzba_t WHERE dzba001=g_gen_prog

                  IF l_cnt > 1 THEN 
                     CALL cl_err_msg("","adz-00232",g_gen_prog,1)
                     NEXT FIELD s_gen_prog
                  END IF
                  
                  #若程式存在於基礎資料則帶出程式的名稱
                  CASE g_main_or_sub_prog
                     WHEN "M"
                        SELECT gzzal003 INTO g_gen_prog_name
                           FROM gzzal_t 
                           WHERE gzzal001 = g_gen_prog AND gzzal002 = g_lang
                     WHEN "S"
                        SELECT gzdel003  INTO g_gen_prog_name
                           FROM gzde_t 
                           LEFT JOIN gzdel_t 
                           ON gzde001 = gzdel001 AND gzdel002 = g_lang
                           WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'S'
                     WHEN "F"
                        SELECT gzdfl003 INTO g_gen_prog_name
                           FROM gzdf_t
                           LEFT JOIN gzdfl_t
                           ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
                           WHERE gzdf002 = g_gen_prog 
                     WHEN "SUB"
                        SELECT gzdel003  INTO g_gen_prog_name
                           FROM gzde_t 
                           LEFT JOIN gzdel_t 
                           ON gzde001 = gzdel001 AND gzdel002 = g_lang
                           WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'
                     WHEN "LIB"
                        SELECT gzdel003  INTO g_gen_prog_name
                           FROM gzde_t 
                           LEFT JOIN gzdel_t 
                           ON gzde001 = gzdel001 AND gzdel002 = g_lang
                           WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'
                  END CASE
                  DISPLAY g_gen_prog_name TO s_gen_prog_name
               END IF

            END IF
       
         #複製目標 欄位的開窗
         ON ACTION controlp INFIELD s_gen_prog
         
            CASE g_main_or_sub_prog

               WHEN "M"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_gen_prog
                  LET g_qryparam.where = "gzzastus = 'Y' AND gzza003 <> 'ADZ'"
                  CALL q_gzza001()

               WHEN "S"   #子程式與畫面azzi901
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "gzde003 <> 'ADZ'"
                  CALL q_gzde001()

               WHEN "F"   #子畫面azzi901
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "gzde003 <> 'ADZ'"
                  CALL q_gzdf002()

               WHEN "LIB"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1="B"
                  LET g_qryparam.arg2="LIB"
                  CALL q_gzde002()

               WHEN "SUB"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1="B"
                  LET g_qryparam.arg2="SUB"
                  CALL q_gzde002()
               END CASE
            LET g_gen_prog = g_qryparam.return2
            LET g_gen_prog_name = g_qryparam.return3
            DISPLAY g_gen_prog_name TO s_gen_prog_name
            CALL DIALOG.setFieldTouched("s_gen_prog", TRUE)
            
      END INPUT

      #顯示來源程式的表格的主從關係
      DISPLAY ARRAY ga_dzag_tree TO s_dzag_t_tree.*

      END DISPLAY

      #顯示用到的多語言表格
      DISPLAY ARRAY g_multi_lang_table TO s_multi_lang_table.*
      
      END DISPLAY

      #顯示來源程式會用到的元件或程式
      DISPLAY ARRAY ga_sub_prog TO s_sub_prog.*
     #DISPLAY ARRAY ga_sub_prog.sub_prog_id, ga_sub_prog.sub_prog_name, ga_sub_prog.sub_prog_tmp_id TO s_sub_prog.lbl_sub_prog_id, s_sub_prog.lbl_sub_prog_name ,s_sub_prog.lbl_sub_prog_tmp_id

      END DISPLAY

      #定義表格的取代關係
      INPUT ARRAY ga_dzag FROM s_dzag_t.*
         ATTRIBUTE(INSERT ROW = l_allow_insert,DELETE ROW = l_allow_delete ,APPEND ROW = l_allow_append )

         BEFORE INPUT
            #IF NOT g_main_or_sub_prog = "LIB" OR NOT g_main_or_sub_prog = "SUB" AND ga_dzag.getLength()=0 AND ga_dzag_tree.getLength() >0 THEN
               # 產生表格主從結構和表格對應關係
               #CALL adzp270_gen_table_relation() 
            #END IF
         
         BEFORE DELETE
            CASE g_main_or_sub_prog
               WHEN "M"
                  CANCEL DELETE
               WHEN "S"
                  CANCEL DELETE
            END CASE
            LET l_del_table = ga_dzag[l_ac].old_table_id
            #DISPLAY "l_del_table = ",l_del_table
         
         AFTER DELETE
            FOR l_i = 1 TO ga_dzeb.getLength()
               IF ga_dzeb[l_i].old_table_id = l_del_table THEN
                  CALL ga_dzeb.deleteElement(l_i)
                  LET l_i = l_i-1
               END IF
            END FOR

            FOR l_i = 1 TO ga_dzeb_stored.getLength()
               IF ga_dzeb_stored[l_i].old_table_id = l_del_table THEN
                  CALL ga_dzeb_stored.deleteElement(l_i)
                  LET l_i = l_i-1
               END IF
            END FOR
            CALL ga_excluded_col.clear()

         ON CHANGE lbl_old_table
            IF NOT cl_null(ga_dzag[l_ac].old_table_id) THEN
               #檢查表格是否有重複
               FOR l_i = 1 TO ga_dzag.getLength()
                  IF l_i = l_ac THEN
                     CONTINUE FOR
                  END IF
                  IF ga_dzag[l_i].old_table_id = ga_dzag[l_ac].old_table_id THEN
                     CALL cl_err_msg("","adz-00095",ga_dzag[l_ac].old_table_id,g_errshow)
                     NEXT FIELD lbl_old_table
                  END IF
               END FOR

               ## 檢查表格編號存在否### start ###
               SELECT COUNT(1) INTO l_cnt FROM dzea_t 
                  WHERE dzea001= ga_dzag[l_ac].old_table_id
               IF l_cnt = 0 THEN
                  CALL cl_err(ga_dzag[l_ac].old_table_id,"-6001",g_errshow)
                  NEXT FIELD lbl_old_table
               ELSE
                  ## 帶回表格名稱### start ###
                  SELECT dzeal003 INTO ga_dzag[l_ac].old_table_name
                     FROM dzeal_t 
                     WHERE dzeal001 = ga_dzag[l_ac].old_table_id AND dzeal002=g_lang
                  ## 帶回表格名稱### end ###
               END IF
               ## 檢查表格編號存在否### end ###
            ELSE
               LET  ga_dzag[l_ac].old_table_name = ""
            END IF
            
            CALL ga_excluded_col.clear()
            IF ga_dzag[l_ac].new_table_id IS NOT NULL AND ga_dzag[l_ac].old_table_id IS NOT NULL THEN

               #產生欄位對應關係
               CALL adzp270_gen_col_relation(DIALOG.getCurrentRow("s_dzag_t"))
               #CALL DIALOG.nextField("lbl_new_col")
            END IF

            #將編輯用的新舊欄位對應表中的資料加入儲存用的新舊欄位對應表
            CALL adzp270_filter_column_data()
            
         
         AFTER FIELD lbl_old_table
            
            IF NOT cl_null(ga_dzag[l_ac].old_table_id) THEN
               #檢查表格是否有重複
               FOR l_i = 1 TO ga_dzag.getLength()
                  IF l_i = l_ac THEN
                     CONTINUE FOR
                  END IF
                  IF ga_dzag[l_i].old_table_id = ga_dzag[l_ac].old_table_id THEN
                     CALL cl_err_msg("","adz-00095",ga_dzag[l_ac].old_table_id,g_errshow)
                     NEXT FIELD lbl_old_table
                  END IF
               END FOR

               ## 檢查表格編號存在否### start ###
               SELECT COUNT(1) INTO l_cnt FROM dzea_t 
                  WHERE dzea001= ga_dzag[l_ac].old_table_id
               IF l_cnt = 0 THEN
                  CALL cl_err(ga_dzag[l_ac].old_table_id,"-6001",g_errshow)
                  NEXT FIELD lbl_old_table
               ELSE
                  ## 帶回表格名稱### start ###
                  SELECT dzeal003 INTO ga_dzag[l_ac].old_table_name
                     FROM dzeal_t 
                     WHERE dzeal001 = ga_dzag[l_ac].old_table_id AND dzeal002=g_lang
                  ## 帶回表格名稱### end ###
               END IF
               ## 檢查表格編號存在否### end ###
            ELSE
               LET  ga_dzag[l_ac].old_table_name = ""
            END IF
            

         ON ACTION controlp INFIELD lbl_old_table
            ## 表格查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ga_dzag[l_ac].old_table_id
            LET g_qryparam.default2 = ga_dzag[l_ac].old_table_name
            LET g_qryparam.where = "1=1"
            CALL q_dzea002()
            LET ga_dzag[l_ac].old_table_id = g_qryparam.return1
            LET ga_dzag[l_ac].old_table_name = g_qryparam.return2
            DISPLAY ga_dzag[l_ac].old_table_id TO s_dzag_t[l_ac].lbl_old_table
            DISPLAY ga_dzag[l_ac].old_table_name TO s_dzag_t[l_ac].lbl_old_table_name
            ## 表格查詢### end ###
            CALL DIALOG.setFieldTouched("lbl_old_table", TRUE)

         BEFORE FIELD lbl_new_table
            #如果為子程式和主程式的話,一定要先輸入第一行的主資料表才可以往下繼續輸入
            IF g_main_or_sub_prog = "M" OR g_main_or_sub_prog = "S" THEN
               IF cl_null(ga_dzag[1].new_table_id) AND ga_dzag[1].old_table_main ="Y" THEN
                  CALL DIALOG.setCurrentRow("s_dzag_t", 1)
                  LET l_ac = 1
               END IF
            END IF

         AFTER FIELD lbl_new_table
            
            IF NOT cl_null(ga_dzag[l_ac].new_table_id) THEN
               
               #檢查表格是否有重複
               FOR l_i = 1 TO ga_dzag.getLength()
                  IF l_i = l_ac THEN
                     CONTINUE FOR
                  END IF
                  IF ga_dzag[l_i].new_table_id = ga_dzag[l_ac].new_table_id THEN
                     CALL cl_err_msg("","adz-00095",ga_dzag[l_ac].new_table_id,g_errshow)
                     NEXT FIELD lbl_new_table
                  END IF
               END FOR
            
               ## 檢查表格編號存在否### start ###
               SELECT COUNT(1) INTO l_cnt FROM dzea_t 
                  WHERE dzea001= ga_dzag[l_ac].new_table_id
               IF l_cnt = 0 THEN
                  CALL cl_err(ga_dzag[l_ac].new_table_id,"-6001",g_errshow)
                  NEXT FIELD lbl_new_table
               ELSE
                  ## 帶回表格名稱### start ###
                  SELECT dzeal003 INTO ga_dzag[l_ac].new_table_name
                     FROM dzeal_t 
                     WHERE dzeal001 = ga_dzag[l_ac].new_table_id AND dzeal002=g_lang
                  ## 帶回表格名稱### end ###
               END IF
               ## 檢查表格編號存在否### end ###

               IF g_main_or_sub_prog = "M" OR g_main_or_sub_prog = "S" THEN
               
                  ### 預設子資料表的上層表格為主資料表 ###
                  #IF ga_dzag[l_ac].old_table_main = "Y" THEN
                  FOR l_i = 1 TO ga_dzag.getLength()
                     IF ga_dzag[l_i].old_table_main = "N" AND ga_dzag[l_i].old_table_parent = ga_dzag[l_ac].old_table_id THEN
                        LET ga_dzag[l_i].new_table_parent =ga_dzag[l_ac].new_table_id
                     END IF
                  END FOR
                  #END IF
                 
                  #檢查子資料表和主資料表的FK和PK關係
                  IF ga_dzag[l_ac].new_table_main = "N" AND ga_dzag[l_ac].new_table_parent = ga_dzag[1].new_table_id THEN
                  
                     IF NOT adzp270_table_fkchk(ga_dzag[l_ac].new_table_id,ga_dzag[1].new_table_id,"F",TRUE) THEN
                        NEXT FIELD lbl_new_table
                     END IF

                  END IF

                  #檢查副資料表和主資料表的FK和PK關係
                  IF ga_dzag[l_ac].new_table_main = "N" AND ga_dzag[l_ac].new_table_parent IS NULL OR ga_dzag[l_ac].new_table_parent<>ga_dzag[1].new_table_id THEN
                  
                     IF NOT adzp270_table_fkchk(ga_dzag[l_ac].new_table_id,ga_dzag[1].new_table_id,"F",FALSE) THEN
                        NEXT FIELD lbl_new_table
                     END IF

                  END IF

               END IF
               
            ELSE
               LET ga_dzag[l_ac].new_table_name = ""
            END IF
            

         ON ACTION controlp INFIELD lbl_new_table
            ## 表格查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ga_dzag[l_ac].new_table_id
            LET g_qryparam.default2 = ga_dzag[l_ac].new_table_name
            LET g_qryparam.where = "1=1"
            CALL q_dzea002()
            LET ga_dzag[l_ac].new_table_id = g_qryparam.return1
            LET ga_dzag[l_ac].new_table_name = g_qryparam.return2
            DISPLAY ga_dzag[l_ac].new_table_id TO s_dzag_t[l_ac].lbl_new_table
            DISPLAY ga_dzag[l_ac].new_table_name TO s_dzag_t[l_ac].lbl_new_table_name
            ## 表格查詢### end ###
            CALL DIALOG.setFieldTouched("lbl_new_table", TRUE)

         ON CHANGE lbl_new_table
         
            IF g_main_or_sub_prog = "M" OR g_main_or_sub_prog = "S" THEN
               IF ga_dzag[l_ac].new_table_main = "Y" THEN
                  FOR l_i = 1 TO ga_dzag.getLength()
                     IF ga_dzag[l_i ].new_table_main = "N" THEN
                        LET ga_dzag[l_i ].new_table_id = ""
                        LET ga_dzag[l_i ].new_table_name = ""
                     END IF
                  END FOR
               END IF
            END IF
         
            IF NOT cl_null(ga_dzag[l_ac].new_table_id) THEN
               #檢查表格是否有重複
               FOR l_i = 1 TO ga_dzag.getLength()
                  IF l_i = l_ac THEN
                     CONTINUE FOR
                  END IF
                  IF ga_dzag[l_i].new_table_id = ga_dzag[l_ac].new_table_id THEN
                     CALL cl_err_msg("","adz-00095",ga_dzag[l_ac].new_table_id,g_errshow)
                     NEXT FIELD lbl_new_table
                  END IF
               END FOR

            
               ## 檢查表格編號存在否### start ###
               SELECT COUNT(1) INTO l_cnt FROM dzea_t 
                  WHERE dzea001= ga_dzag[l_ac].new_table_id
               IF l_cnt = 0 THEN
                  CALL cl_err(ga_dzag[l_ac].new_table_id,"-6001",g_errshow)
                  NEXT FIELD lbl_new_table
               ELSE
                  ## 帶回表格名稱### start ###
                  SELECT dzeal003 INTO ga_dzag[l_ac].new_table_name
                     FROM dzeal_t 
                     WHERE dzeal001 = ga_dzag[l_ac].new_table_id AND dzeal002=g_lang
                  ## 帶回表格名稱### end ###
               END IF
               ## 檢查表格編號存在否### end ###
            ELSE
               LET ga_dzag[l_ac].new_table_name = ""
            END IF
            
            CALL ga_excluded_col.clear()

            IF ga_dzag[l_ac].new_table_id IS NOT NULL AND ga_dzag[l_ac].old_table_id IS NOT NULL THEN
               #產生欄位對應關係
               CALL adzp270_gen_col_relation(DIALOG.getCurrentRow("s_dzag_t"))
            END IF
            #CALL DIALOG.nextField("lbl_new_col")
            #將編輯用的新舊欄位對應表中的資料加入儲存用的新舊欄位對應表
            CALL adzp270_filter_column_data()
         

            IF ga_dzeb.getLength() = 0 THEN
               CALL cl_set_act_visible("item_exchange", FALSE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",FALSE)
            ELSE
               CALL cl_set_act_visible("item_exchange", TRUE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",TRUE)
            END IF 

         ON ACTION btm_pair_col
            
            #CALL adzp270_filter_q_id_and_v_id()#測試

            IF ga_dzag[l_ac].new_table_id IS NOT NULL AND ga_dzag[l_ac].old_table_id IS NOT NULL THEN
               #產生欄位對應關係
               CALL adzp270_gen_col_relation(DIALOG.getCurrentRow("s_dzag_t"))
            END IF

            #CALL DIALOG.nextField("lbl_new_col")
            #將編輯用的新舊欄位對應表中的資料加入儲存用的新舊欄位對應表
            CALL adzp270_filter_column_data()

            IF ga_dzeb.getLength() = 0 THEN
               CALL cl_set_act_visible("item_exchange", FALSE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",FALSE)
            ELSE
               CALL cl_set_act_visible("item_exchange", TRUE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",TRUE)
            END IF
            
         BEFORE ROW
            IF g_is_import_setting_date = TRUE THEN
               LET g_is_import_setting_date = FALSE
               NEXT FIELD s_gen_prog
            END IF


            #取出編輯用的新舊欄位對應表
            LET l_ac = DIALOG.getCurrentRow("s_dzag_t")
           
            CALL ga_dzeb.clear()
            
            FOR l_i = 1 TO ga_dzeb_stored.getLength()
               #DISPLAY ga_dzeb_stored[l_i].old_col_id
               IF ga_dzeb_stored[l_i].old_table_id = ga_dzag[l_ac].old_table_id THEN
                  CALL ga_dzeb.appendElement()
                  LET ga_dzeb[ga_dzeb.getLength()].* = ga_dzeb_stored[l_i].*
               END IF
            END FOR

            IF ga_dzeb.getLength() = 0 THEN
               CALL cl_set_act_visible("item_exchange", FALSE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",FALSE)
            ELSE
               CALL cl_set_act_visible("item_exchange", TRUE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",TRUE)
            END IF
            LET g_no_1 = NULL
            LET g_no_2 = NULL

            
      END INPUT

      #定義欄位的取代關係
      INPUT ARRAY ga_dzeb FROM s_dzeb_t.* ATTRIBUTES(DELETE ROW =FALSE)

         BEFORE INPUT
            CALL DIALOG.setCurrentRow("s_dzeb_t",1)
            IF ga_dzeb.getLength()=0 THEN
                CALL cl_set_act_visible("item_down,item_up", FALSE)
            END IF

        
         BEFORE ROW
            IF g_is_import_setting_date = TRUE THEN
               LET g_is_import_setting_date = FALSE
               NEXT FIELD s_gen_prog
            END IF

            LET l_ac = DIALOG.getCurrentRow("s_dzeb_t")
            IF l_is_exchange = TRUE THEN
               CALL DIALOG.setCurrentRow("s_dzeb_t",g_no_2)
               LET l_is_exchange = FALSE
            END IF
            CALL cl_set_act_visible("item_down,item_up", TRUE)

            IF l_ac = ga_dzeb.getLength() THEN
               CALL cl_set_act_visible("item_down", FALSE)
            END IF

            IF l_ac = 1 THEN
               CALL cl_set_act_visible("item_up", FALSE)
            END IF

         AFTER INPUT
            #將編輯用的新舊欄位對應表中的資料加入儲存用的新舊欄位對應表
            CALL adzp270_filter_column_data()


         ON CHANGE lbl_new_col
            CALL ga_excluded_col.clear()

         AFTER FIELD lbl_new_col
            IF NOT cl_null(ga_dzeb[l_ac].new_col_id) THEN

               #檢查表格是否有重複
               FOR l_i = 1 TO ga_dzeb.getLength()
                  IF l_i = l_ac THEN
                     CONTINUE FOR
                  END IF
                  IF ga_dzeb[l_i].new_col_id = ga_dzeb[l_ac].new_col_id THEN
                     CALL cl_err_msg("","adz-00182",ga_dzeb[l_i].new_col_id,g_errshow)
                     NEXT FIELD lbl_new_col
                  END IF
               END FOR
            
               ## 檢查欄位編號存在否### start ###
               SELECT COUNT(1) INTO l_cnt FROM dzeb_t
                  WHERE dzeb001= ga_dzeb[l_ac].new_table_id AND
                        dzeb002= ga_dzeb[l_ac].new_col_id
               IF l_cnt = 0 THEN
                  CALL cl_err_msg("","lib-00021",ga_dzeb[l_ac].new_col_id||"|"||ga_dzeb[l_ac].new_table_id ,g_errshow)
                  NEXT FIELD lbl_new_col
               ELSE
                  ## 帶回欄位名稱### start ###
                  SELECT dzebl003 INTO ga_dzeb[l_ac].new_col_name
                     FROM dzebl_t
                     WHERE dzebl001 = ga_dzeb[l_ac].new_col_id AND
                           dzebl002 = g_lang
                  ## 帶回欄位名稱### end ###

                  #LET ga_dzeb[l_ac].new_col_key = " "

                  #尋找新欄位的pk
                  LET l_str = ga_dzeb[l_ac].new_table_id CLIPPED
                  LET l_str = l_str.subString(1,l_str.getLength()-2),"_pk"
                  LET l_dzed002 = l_str
                  LET l_dzed004 = "%",ga_dzeb[l_ac].new_col_id,"%"


                  LET l_cnt = 0
               
                  SELECT COUNT(1) INTO l_cnt FROM dzed_t
                     WHERE dzed001=ga_dzeb[l_ac].new_table_id AND 
                           dzed002= l_dzed002 AND 
                           dzed004 LIKE l_dzed004 
                  #DISPLAY "l_cnt = ",l_cnt
                  IF l_cnt > 0 THEN
                     LET  ga_dzeb[l_ac].new_col_key = " PK"
                  END IF

                  #尋找新欄位的fk
                  LET l_str = ga_dzeb[l_ac].new_table_id CLIPPED
                  LET l_str = l_str.subString(1,l_str.getLength()-2),"_fk"
                  LET l_dzed002 = l_str
                  LET l_dzed004 = "%",ga_dzeb[l_ac].new_col_id,"%"
                  LET l_cnt = 0
               
                  SELECT COUNT(1) INTO l_cnt FROM dzed_t
                     WHERE dzed001=ga_dzeb[l_ac].new_table_id AND 
                           dzed002= l_dzed002 AND 
                           dzed004 LIKE l_dzed004 
                  #DISPLAY "l_cnt = ",l_cnt
                  IF l_cnt > 0 THEN
                     LET  ga_dzeb[l_ac].new_col_key = ga_dzeb[l_ac].new_col_key ,",FK"
                  END IF

               END IF
               ## 檢查欄位編號存在否### end ###
            ELSE
               LET ga_dzeb[l_ac].new_col_name = ""
               LET ga_dzeb[l_ac].new_col_key = ""
            END IF

         ON ACTION controlp INFIELD lbl_new_col
            
            ### 資料表欄位查詢(調整順序)### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  ga_dzeb[l_ac].new_col_id
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = ga_dzeb[l_ac].new_table_id
            CALL q_dzeb003()
            LET ga_dzeb[l_ac].new_col_id = g_qryparam.return1
            LET ga_dzeb[l_ac].new_col_name = g_qryparam.return2
            DISPLAY ga_dzeb[l_ac].new_col_id TO s_dzeb_t[l_ac].lbl_new_col
            DISPLAY ga_dzeb[l_ac].new_col_name TO s_dzag_t[l_ac].lbl_new_col_name
            #DISPLAY [var*] TO [s_var*]
            ### 資料表欄位查詢(調整順序)### end ###

            #尋找新欄位的pk
            LET l_str = ga_dzeb[l_ac].new_table_id CLIPPED
            LET l_str = l_str.subString(1,l_str.getLength()-2),"_pk"
            LET l_dzed002 = l_str
            LET l_dzed004 = "%",ga_dzeb[l_ac].new_col_id,"%"


            LET l_cnt = 0
         
            SELECT COUNT(1) INTO l_cnt FROM dzed_t
               WHERE dzed001=ga_dzeb[l_ac].new_table_id AND 
                     dzed002= l_dzed002 AND 
                     dzed004 LIKE l_dzed004 
            #DISPLAY "l_cnt = ",l_cnt
            IF l_cnt > 0 THEN
               LET  ga_dzeb[l_ac].new_col_key = " PK"
            END IF

            #尋找新欄位的fk
            LET l_str = ga_dzeb[l_ac].new_table_id CLIPPED
            LET l_str = l_str.subString(1,l_str.getLength()-2),"_fk"
            LET l_dzed002 = l_str
            LET l_dzed004 = "%",ga_dzeb[l_ac].new_col_id,"%"
            LET l_cnt = 0
         
            SELECT COUNT(1) INTO l_cnt FROM dzed_t
               WHERE dzed001=ga_dzeb[l_ac].new_table_id AND 
                     dzed002= l_dzed002 AND 
                     dzed004 LIKE l_dzed004 
            #DISPLAY "l_cnt = ",l_cnt
            IF l_cnt > 0 THEN
               LET  ga_dzeb[l_ac].new_col_key = ga_dzeb[l_ac].new_col_key ,",FK"
            END IF
            CALL DIALOG.setFieldTouched("lbl_new_col", TRUE)

            
         ON ACTION item_up
            LET l_cnt = DIALOG.getCurrentRow("s_dzeb_t")
            CALL adzp270_adjust_col_relation(l_cnt,0,"up")
            CALL DIALOG.setCurrentRow("s_dzeb_t",l_cnt-1)
            CALL ga_excluded_col.clear()

         ON ACTION item_down
            LET l_cnt = DIALOG.getCurrentRow("s_dzeb_t")
            CALL adzp270_adjust_col_relation(l_cnt,0,"down")
            CALL DIALOG.setCurrentRow("s_dzeb_t",l_cnt+1)
            CALL ga_excluded_col.clear()

      END INPUT

      #已儲存要轉換的欄位字串陣列
      DISPLAY ARRAY ga_dzeb_stored TO s_dzeb_stored.*
      

      END DISPLAY

      #要排除的欄位字串陣列
      DISPLAY ARRAY ga_excluded_col TO s_excluded_column.*

      END DISPLAY

      

      #要調換的欄位配對關係
      INPUT g_no_1,g_no_2 FROM s_no_1,s_no_2 ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD s_no_1
            IF  g_no_1<1 OR g_no_1>ga_dzeb.getLength() THEN
               NEXT FIELD s_no_1
            END IF

         AFTER FIELD s_no_2
            IF  g_no_2<1 OR g_no_2>ga_dzeb.getLength() THEN
               NEXT FIELD s_no_2
            END IF
         
         ON ACTION item_exchange
            IF  g_no_1<1 OR g_no_1>ga_dzeb.getLength() OR cl_null(g_no_1) THEN
               NEXT FIELD s_no_1
            END IF

            IF  g_no_2<1 OR g_no_2>ga_dzeb.getLength() OR cl_null(g_no_2) THEN
               NEXT FIELD s_no_2
            END IF
         
            CALL adzp270_adjust_col_relation(g_no_1,g_no_2,"exchange")
            LET l_is_exchange = TRUE
            CALL ga_excluded_col.clear()
            CALL DIALOG.nextField("s_dzeb_t.lbl_new_col")

            
      END INPUT
      
      #預設 測試已複製的程式 的功能失效
      BEFORE DIALOG
         CALL cl_set_act_visible("btn_test", FALSE)
         CALL cl_set_act_visible("item_exchange", FALSE)
         CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",FALSE)
         #CALL DIALOG.setFieldActive( "s_dzag_t.lbl_old_table", 0)
         
      ON ACTION select_excluded_column
         LET l_action = "select_excluded_column"
         ACCEPT DIALOG


      ON ACTION btm_save_setting_data #儲存底稿
         LET l_action = "btm_save_setting_data"
         ACCEPT DIALOG


      ON ACTION btm_import_setting_data #開啟底稿
         #CALL DIALOG.nextField("s_gen_prog")

         ### 規格與程式複製底稿查詢### start ###
         INITIALIZE g_qryparam.* TO NULL 
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = ""
         LET g_qryparam.default2 = ""
         LET g_qryparam.default3 = ""
         LET g_qryparam.default4 = ""
         LET g_qryparam.where = "1=1"
         
         IF g_run_mode = 'debug' THEN
            CALL q_dzcl002()
         ELSE
            CALL q_dzcl001()
         END IF
         ### 規格與程式複製底稿查詢### end ###

         IF g_qryparam.return1 IS NULL AND 
         g_qryparam.return2 IS NULL AND
         g_qryparam.return3 IS NULL AND
         g_qryparam.return4 IS NULL THEN

         ELSE
            CALL adzp270_import_setting_data()
            #CALL DIALOG.setFieldTouched("s_copy_source",TRUE)
            #CALL DIALOG.setFieldTouched("s_gen_prog",TRUE)

            SELECT COUNT(*) INTO l_cnt FROM dzaf_t WHERE dzaf001=g_copy_source
            IF l_cnt = 0 THEN # to do : 因應沒有在dzaf註冊的程式
               LET g_source_ver = ""
               LET g_source_spec_ver = "1"
               LET g_source_code_ver = "1"
            ELSE
               #選取該程式最大的建構版次
               SELECT MAX(dzaf002) INTO g_source_ver 
                  FROM dzaf_t WHERE dzaf001=g_copy_source
               #選取該程式和最大的建構版次對應的規格版次和代碼版次
               SELECT dzaf003,dzaf004 INTO g_source_spec_ver,g_source_code_ver 
                  FROM dzaf_t WHERE dzaf001=g_copy_source AND dzaf002=g_source_ver
            END IF

            LET g_is_import_setting_date = TRUE
            CALL adzp270_gen_table_relation()
            --LET g_is_import_setting_date = FALSE

            DISPLAY g_source_ver,g_source_spec_ver,g_source_code_ver TO s_source_ver,s_spec_ver,s_code_ver
            CALL DIALOG.setFieldTouched("s_copy_source",FALSE)
         END IF


         CASE g_use_table_replace
            WHEN "Y"
               #CALL gfrm_curr.setElementHidden("page_table_replace",0)
               --CALL DIALOG.nextField("lbl_new_table")

               CALL cl_set_comp_visible("page_table_replace",TRUE)#出現
               #CALL DIALOG.nextField("lbl_new_table")
               --NEXT FIELD s_gen_prog
               --NEXT FIELD lbl_new_table
               --CALL DIALOG.nextField("lbl_new_table")
            WHEN "N"
               CALL ga_dzag.clear()
               CALL ga_dzeb.clear()
               CALL ga_dzeb_stored.clear()
               CALL ga_excluded_col.clear()
               #CALL gfrm_curr.setElementHidden("page_table_replace",1)

               CALL cl_set_comp_visible("page_table_replace",FALSE)#隱藏
               --NEXT FIELD s_gen_prog
               --CALL DIALOG.nextField("s_copy_source")
         END CASE

         IF ga_dzag.getLength() > 0  AND g_use_table_replace ="Y" THEN
            LET g_is_import_setting_date = FALSE
            CALL DIALOG.setCurrentRow("s_dzag_t",1)
            #取出編輯用的新舊欄位對應表
            LET l_ac = DIALOG.getCurrentRow("s_dzag_t")
           
            CALL ga_dzeb.clear()
            
            FOR l_i = 1 TO ga_dzeb_stored.getLength()
               #DISPLAY ga_dzeb_stored[l_i].old_col_id
               IF ga_dzeb_stored[l_i].old_table_id = ga_dzag[l_ac].old_table_id THEN
                  CALL ga_dzeb.appendElement()
                  LET ga_dzeb[ga_dzeb.getLength()].* = ga_dzeb_stored[l_i].*
               END IF
            END FOR

            IF ga_dzeb.getLength() = 0 THEN
               CALL cl_set_act_visible("item_exchange", FALSE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",FALSE)
            ELSE
               CALL cl_set_act_visible("item_exchange", TRUE)
               CALL adzp270_set_comp_entry("formonly.s_no_1,formonly.s_no_2",TRUE)
            END IF
            LET g_no_1 = NULL
            LET g_no_2 = NULL
         END IF

         
         #CALL DIALOG.setFieldTouched("s_gen_prog",TRYE)
         #CALL DIALOG.nextField("s_gen_prog")
         #NEXT FIELD s_gen_prog

         
      ON ACTION btn_begin_copy #開始複製
        
        LET g_pro_msg = ""
        LET g_copy_source = g_copy_source CLIPPED

         #檢查來源的程式是否存在於基本資料 
         IF cl_null(g_copy_source) OR NOT adzp270_chk_prog_id_exist(g_copy_source) THEN
            NEXT FIELD s_copy_source
         ELSE
           #檢查來源程式是否有設計資料
           CASE g_main_or_sub_prog

               WHEN "M"
                  SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_copy_source AND dzaa002 = g_source_spec_ver
               WHEN "S"   #子程式與畫面azzi901
                  SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_copy_source AND dzaa002 = g_source_spec_ver
               WHEN "F"   #子畫面azzi901
                  #SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_copy_source AND dzaa002 = g_source_spec_ver
                  LET ln_cnt =1
               WHEN "LIB"
                  SELECT COUNT(*) INTO ln_cnt FROM  dzba_t WHERE dzba001 = g_copy_source AND dzba002 = g_source_code_ver
               WHEN "SUB"
                  SELECT COUNT(*) INTO ln_cnt FROM  dzba_t WHERE dzba001 = g_copy_source AND dzba002 = g_source_code_ver
            END CASE

            IF ln_cnt = 0 THEN
               CALL cl_err(g_copy_source,"adz-00144",g_errshow)
               NEXT FIELD s_copy_source
            END IF
         END IF

         
         #檢查產生的程式是否存在於基本資料 
         #DISPLAY "g_gen_prog = ",g_gen_prog
         IF cl_null(g_gen_prog) OR NOT adzp270_chk_prog_id_exist(g_gen_prog) THEN
            NEXT FIELD s_gen_prog
         END IF
         LET l_action = "btn_begin_copy"
         ACCEPT DIALOG

      AFTER DIALOG   

         CASE l_action
            #開始複製
            WHEN "btn_begin_copy"

               #主程式和子程式的主資料表.子資料和副資料表必須有對應的表格才可通過
               IF g_use_table_replace = "Y"  THEN
                  IF g_main_or_sub_prog = "M" OR g_main_or_sub_prog = "S" THEN
                     FOR l_i = 1 TO ga_dzag.getLength()

                        IF ga_dzag[l_i].new_table_main = "Y" AND cl_null(ga_dzag[l_i].new_table_id) THEN
                           CALL DIALOG.setCurrentRow("s_dzag_t", l_i)
                           NEXT FIELD lbl_new_table
                        END IF

                        IF ga_dzag[l_i].new_table_main = "N" AND cl_null(ga_dzag[l_i].new_table_id) THEN
                           CALL DIALOG.setCurrentRow("s_dzag_t", l_i)
                           NEXT FIELD lbl_new_table
                        END IF
         
                     END FOR
                  END IF
               END IF
               
               CALL adzp270_save_setting_data()
               LET g_gen_prog = g_gen_prog CLIPPED
               LET g_copy_source = g_copy_source CLIPPED
               #檢查程式是否存在於基本資料  
               IF adzp270_chk_prog_id_exist(g_gen_prog) THEN
                  #程式存在於基本資料表
                  
                  #如果設計資料存在詢問是否刪除？
                  IF adzp270_check_design_date_exist() THEN
                     #設計資料確實存在 

                     IF cl_ask_confirm_parm("adz-00049",g_gen_prog) THEN   #todo按鈕多語言
                        #再次確認是否刪除？
                        IF cl_ask_confirm_parm("adz-00145","") THEN
                           #選擇是
                           #刪除設計資料
                           IF adzp270_delete_database_data() THEN
                           
                              #開始複製規格與程式流程
                              IF adzp270_copy_process() THEN
                                 IF g_use_table_replace = "Y" THEN
                                    #請下載至規格設計器,移除無對應關係的舊欄位資料,並重新上傳規格,完成表格欄位的轉換
                                    CALL cl_ask_pressanykey("adz-00234")
                                 ELSE
                                    CALL FGL_WINMESSAGE( "", "Process succeeded!", "" )
                                 END IF

                                 #啟動 測試已複製的主程式 按鈕
                                 IF g_main_or_sub_prog = "M" AND g_use_table_replace ="N" THEN
                                    CALL cl_set_act_visible("btn_test", TRUE)
                                 END IF
                              ELSE

                                 #IF g_use_table_replace = "Y" THEN
                                    #[複製失敗]欄位KEY值沒有對應,可能導致複製失敗,請檢查欄位的KEY值欄位的對應
                                    #CALL cl_err("","adz-00236",1)
                                 #ELSE
                                    CALL FGL_WINMESSAGE( "", "Process failed!", "" )
                                 #END IF
                              END IF
                              
                              #顯示複製程序有無錯誤
                              DISPLAY g_pro_msg
                           ELSE
                              #刪除設計資料失敗
                           END IF
                        ELSE
                           #再次確認是否刪除設計資料時,選擇否
                        END IF
                     END IF
                  ELSE
                     #設計資料不存在

                     #複製規格與程式流程
                     IF adzp270_copy_process() THEN
                        IF g_use_table_replace = "Y" THEN
                           #請下載至規格設計器,移除無對應關係的舊欄位資料,並重新上傳規格,完成表格欄位的轉換
                           CALL cl_ask_pressanykey("adz-00234")
                        ELSE
                           CALL FGL_WINMESSAGE( "", "Process succeeded!", "" )
                        END IF
                        IF g_main_or_sub_prog = "M" AND g_use_table_replace ="N"  THEN
                           CALL cl_set_act_visible("btn_test", TRUE)
                        END IF
                     ELSE
                        #IF g_use_table_replace = "Y" THEN
                           #[複製失敗]欄位KEY值沒有對應,可能導致複製失敗,請檢查欄位的KEY值欄位的對應
                           #CALL cl_err("","adz-00236",1)
                        #ELSE
                           CALL FGL_WINMESSAGE( "", "Process failed!", "" )
                        #END IF
                     END IF
                     DISPLAY g_pro_msg
                  END IF
                  
               ELSE
                  #程式不存在於基本資料表
                  NEXT FIELD s_gen_prog
               END IF


            #測試已複製的主程式
            WHEN "btn_test"
               LET l_cmd = "r.r ",g_gen_prog
               IF NOT adzp270_run_cmd(l_cmd) THEN
                  CALL FGL_WINMESSAGE( "", "cmd failed!", "" )
               END IF

            WHEN "select_excluded_column"
               CALL adzp270_select_excluded_column()
               LET  g_dzaa_t_exculded_wc = adzp270_gen_excluded_where_condition("dzaa003")
               LET  g_dzba_t_exculded_wc = adzp270_gen_excluded_where_condition("dzba003")
               LET  g_gzzd_t_exculded_wc = adzp270_gen_excluded_where_condition("gzzd003")
            WHEN "btm_save_setting_data"
               CALL adzp270_save_setting_data()
         END CASE

         CONTINUE DIALOG

      ON ACTION btn_test
         LET g_pro_msg = "" 
         LET l_action = "btn_test"
         ACCEPT DIALOG
         
      ON ACTION btn_cancel     #取消複製
         EXIT DIALOG

      ON ACTION close          #在dialog 右上角 (X)
         EXIT DIALOG
 
      ON ACTION exit           #toolbar 離開
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
      CONTINUE DIALOG 
         
   END DIALOG
    
END FUNCTION

PRIVATE FUNCTION adzp270_token_num(p_str,p_delim)
   DEFINE tok base.StringTokenizer,
          p_str STRING,
          p_delim STRING,
          l_cnt LIKE type_t.num5

   LET tok = base.StringTokenizer.create(p_str,p_delim)

   LET l_cnt = 0
   WHILE tok.hasMoreTokens()
      DISPLAY tok.nextToken()
      LET l_cnt = l_cnt +1
   END WHILE
   
   RETURN l_cnt
END FUNCTION

#+ 調整欄位的對應關係
PRIVATE FUNCTION adzp270_adjust_col_relation(p_index,p_index2,p_state)
   DEFINE p_index        LIKE type_t.num5
   DEFINE p_index2       LIKE type_t.num5
   DEFINE p_state        LIKE type_t.chr12
   DEFINE la_dzeb_tmp    type_col_relation
   DEFINE l_next_i       LIKE type_t.num5
   DEFINE l_previous_i   LIKE type_t.num5
   
   CALL cl_set_act_visible("item_down,item_up", TRUE)
   
   CASE p_state 
      WHEN "exchange"
         #DISPLAY p_state
         #DISPLAY p_index
         #DISPLAY p_index2
         LET la_dzeb_tmp.* = ga_dzeb[p_index].*
         LET ga_dzeb[p_index].new_col_id = ga_dzeb[p_index2].new_col_id
         LET ga_dzeb[p_index].new_col_key = ga_dzeb[p_index2].new_col_key
         LET ga_dzeb[p_index].new_col_name = ga_dzeb[p_index2].new_col_name

         LET ga_dzeb[p_index2].new_col_id = la_dzeb_tmp.new_col_id
         LET ga_dzeb[p_index2].new_col_key = la_dzeb_tmp.new_col_key
         LET ga_dzeb[p_index2].new_col_name = la_dzeb_tmp.new_col_name
         
      WHEN "down"
         #DISPLAY p_state
         LET l_next_i = p_index + 1
         LET la_dzeb_tmp.* = ga_dzeb[p_index].*
         LET ga_dzeb[p_index].new_col_id = ga_dzeb[l_next_i].new_col_id
         LET ga_dzeb[p_index].new_col_key = ga_dzeb[l_next_i].new_col_key
         LET ga_dzeb[p_index].new_col_name = ga_dzeb[l_next_i].new_col_name

         LET ga_dzeb[l_next_i].new_col_id = la_dzeb_tmp.new_col_id
         LET ga_dzeb[l_next_i].new_col_key = la_dzeb_tmp.new_col_key
         LET ga_dzeb[l_next_i].new_col_name = la_dzeb_tmp.new_col_name
         
         IF l_next_i = ga_dzeb.getLength() THEN
            CALL cl_set_act_visible("item_down", FALSE)
            RETURN
         END IF
      WHEN "up"
         #DISPLAY p_state
         LET l_previous_i = p_index - 1
         LET la_dzeb_tmp.* = ga_dzeb[p_index].*
         LET ga_dzeb[p_index].new_col_id = ga_dzeb[l_previous_i].new_col_id
         LET ga_dzeb[p_index].new_col_key = ga_dzeb[l_previous_i].new_col_key
         LET ga_dzeb[p_index].new_col_name = ga_dzeb[l_previous_i].new_col_name

         LET ga_dzeb[l_previous_i].new_col_id = la_dzeb_tmp.new_col_id
         LET ga_dzeb[l_previous_i].new_col_key = la_dzeb_tmp.new_col_key
         LET ga_dzeb[l_previous_i].new_col_name = la_dzeb_tmp.new_col_name
         
         IF l_previous_i = 1 THEN
            CALL cl_set_act_visible("item_up", FALSE)
            RETURN
         END IF
   END CASE
   
END FUNCTION

#+ 檢查程式是否存在在基本資料中
PRIVATE FUNCTION adzp270_chk_prog_id_exist(p_prog)
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE p_prog LIKE gzza_t.gzza001

   LET p_prog = p_prog CLIPPED
   #DISPLAY "p_prog = ",p_prog

   LET l_cnt = 0

  
   CASE g_main_or_sub_prog
        WHEN "M"
         SELECT COUNT(*) INTO l_cnt FROM gzza_t WHERE gzza001 = p_prog
      WHEN "S"
         SELECT COUNT(*) INTO l_cnt FROM gzde_t WHERE gzde001 = p_prog
      WHEN "F"
         SELECT COUNT(*) INTO l_cnt FROM gzdf_t WHERE gzdf002 = p_prog
      WHEN "LIB"
         SELECT COUNT(*) INTO l_cnt FROM gzde_t WHERE gzde001 = p_prog
      WHEN "SUB"
         SELECT COUNT(*) INTO l_cnt FROM gzde_t WHERE gzde001 = p_prog
   END CASE

   #DISPLAY "l_cnt = ",l_cnt
   
   IF l_cnt = 0 THEN
      CALL cl_err("", "adz-00050", g_errshow)
      #CALL adzq250_clear_ui_data()
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 複製規格與程式流程
PRIVATE FUNCTION adzp270_copy_process()
   DEFINE lb_flag        LIKE type_t.num5,
          ls_form_style  LIKE dzfq_t.dzfq001,
          l_cmd          STRING,
          lb_del         LIKE type_t.num5,
          ls_path        STRING,
          l_cnt          LIKE type_t.num5,
          l_i            LIKE type_t.num5,
          l_j            LIKE type_t.num5

   #### 變更 Free Style 的設定,來源程式和目標程式的 Free Style 設定需一致 ####
   CASE g_main_or_sub_prog
      WHEN "M"
         IF g_free_style_flag = "Y" THEN
            UPDATE gzza_t SET (gzza007) = (g_source_free_style)
               WHERE gzza001 = g_gen_prog
         END IF
      WHEN "S"
         IF g_free_style_flag = "Y" THEN
            UPDATE gzza_t SET (gzza007) = (g_source_free_style)
               WHERE gzza001 = g_gen_prog
         END IF
   END CASE

   CALL cl_progress_bar(6)
   LET g_pro_msg = "############################################################",ASCII 10
   LET g_pro_msg = g_pro_msg,"[Message]adzp270複製規格與程式過程:",ASCII 10
   

   ############ 1.刪除原有的相關的檔案 ############
   IF NOT adzp270_delete_file() THEN
      LET g_pro_msg = g_pro_msg,"清除相關的檔案 .................... ERROR!",ASCII 10
      CALL cl_progress_bar_close()
      RETURN FALSE
   END IF
   LET g_pro_msg = g_pro_msg,"清除相關的檔案 .................... OK!",ASCII 10
   CALL cl_progress_ing("[Message]adzp270複製規格與程式過程")

   ############ 2.複製設計資料 ############
   CASE g_use_table_replace

      #不執行表格轉換的複製設計資料
      WHEN "N" 
         IF NOT adzp270_copy_database_data() THEN
            LET g_pro_msg = g_pro_msg,"複製設計資料 .................... ERROR!",ASCII 10
            CALL cl_progress_bar_close()
            RETURN FALSE
         END IF
         
      #執行表格轉換的複製設計資料
      WHEN "Y"
         # 篩選會影響到的開窗和校驗帶值識別值
         CALL adzp270_filter_q_id_and_v_id()
         #產生要排除的欄位資料陣列
         CALL adzp270_select_excluded_column()
         LET  g_dzaa_t_exculded_wc = adzp270_gen_excluded_where_condition("dzaa003")
         #DISPLAY "g_dzaa_t_exculded_wc = ",g_dzaa_t_exculded_wc
         LET  g_dzba_t_exculded_wc = adzp270_gen_excluded_where_condition("dzba003")
         #DISPLAY "g_dzba_t_exculded_wc = ",g_dzba_t_exculded_wc
         LET  g_gzzd_t_exculded_wc = adzp270_gen_excluded_where_condition("gzzd003")
         #DISPLAY "g_gzzd_t_exculded_wc = ",g_gzzd_t_exculded_wc
           
         IF NOT adzp270_copy_database_data_for_table_exchange() THEN
            LET g_pro_msg = g_pro_msg,"複製設計資料 .................... ERROR!",ASCII 10
            CALL cl_progress_bar_close()
            RETURN FALSE
         END IF

   END CASE
   CALL cl_progress_ing("[Message]adzp270複製規格與程式過程")
      
   LET g_pro_msg = g_pro_msg,"複製設計資料 .................... OK!",ASCII 10

   #來源的4fd檔的檔案路徑
   LET g_source_4fd_path = os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_copy_source)), "4fd"), g_copy_source||".4fd")

   #產生的4fd檔的檔案路徑
   LET g_gen_4fd_path  = os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "4fd"), g_gen_prog||".4fd")

   ############ 3.如果來源的4fd檔存在的話在進行產生4fd檔 ############
   IF os.Path.exists(g_source_4fd_path) THEN
      LET g_pro_msg = g_pro_msg,"來源的4fd檔的檔案路徑:",g_source_4fd_path,ASCII 10
      LET g_pro_msg = g_pro_msg,"產生的4fd檔的檔案路徑:",g_gen_4fd_path,ASCII 10

      ###### 產生畫面檔
      IF NOT adzp270_gen_4fd() THEN
         LET g_pro_msg = g_pro_msg,"產生畫面檔 .................... ERROR!",ASCII 10
         CALL cl_progress_bar_close()
         RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"產生畫面檔 .................... OK!",ASCII 10
         #切換要產生的程式模組中的4fd目錄
      CALL os.Path.chdir(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "4fd")) 
      RETURNING lb_flag

   　　###### 編譯畫面檔
      LET l_cmd = "r.f ",g_gen_prog
      IF NOT adzp270_run_cmd(l_cmd) THEN
          LET g_pro_msg = g_pro_msg,"編譯畫面檔 .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
          CALL cl_progress_bar_close()
          RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"編譯畫面檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
   　　###### 

      
      ###### 解析4fd檔
      IF NOT sadzp168_3(adzp270_find_module(g_gen_prog), g_gen_prog,g_gen_spec_ver) THEN
         LET g_pro_msg = g_pro_msg,"解析畫面檔 .................... ERROR!",ASCII 10
         CALL cl_progress_bar_close()
         RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"解析畫面檔 .................... OK!",ASCII 10
      ###### 解析
   ELSE
      LET g_pro_msg = g_pro_msg,"來源程式無畫面檔 .................... OK!",ASCII 10
   END IF
   CALL cl_progress_ing("[Message]adzp270複製規格與程式過程")

   ############ 4.產生tab檔 ############
   #取得UI版型
   #SELECT dzae004 INTO ls_form_style FROM dzae_t WHERE dzae001 = g_gen_prog
   SELECT dzfq001 INTO ls_form_style FROM dzfq_t WHERE dzfq004 = g_gen_prog
   LET ls_form_style = ls_form_style CLIPPED

   DISPLAY "取得UI版型 = ",ls_form_style

   IF NOT sadzp030_tab_gen(g_gen_prog,g_gen_spec_ver,ls_form_style) THEN
      LET g_pro_msg = g_pro_msg,"產生tab檔 .................... ERROR!",ASCII 10
      LET g_pro_msg = g_pro_msg,"CALL sadzp030_tab_gen('",g_gen_prog,"','",g_gen_spec_ver,"','",ls_form_style,"')",ASCII 10
      CALL cl_progress_bar_close()
      RETURN FALSE
   END IF
   LET g_pro_msg = g_pro_msg,"產生tab檔 .................... OK!",ASCII 10
   LET g_pro_msg = g_pro_msg,"CALL sadzp030_tab_gen('",g_gen_prog,"','",g_gen_spec_ver,"','",ls_form_style,"')",ASCII 10


   ############ 5.執行r.c3 ############
   IF g_main_or_sub_prog <> "F" THEN #目前子畫面(F)不用產生tgl檔和4gl檔,所以不用執行r.c3
      #切換要產生的程式模組中的4gl目錄
      CALL os.Path.chdir(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)),"4gl"))
         RETURNING lb_flag

      IF g_use_table_replace = "Y" THEN
         ###### 產生tgl檔(執行gencode)
         --LET l_cmd = "gencode ",DOWNSHIFT(adzp270_find_module(g_gen_prog))," ",g_gen_prog
         --IF NOT adzp270_run_cmd(l_cmd) THEN
            --LET g_pro_msg = g_pro_msg,"產生tgl檔(執行gencode) .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
            --CALL cl_progress_bar_close()
            --RETURN FALSE
         --END IF
         --LET g_pro_msg = g_pro_msg,"產生tgl檔(執行gencode) .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
--
         ###### 產生4gl檔(執行gencompose)   
         --LET l_cmd = "gencompose ",DOWNSHIFT(adzp270_find_module(g_gen_prog))," ",g_gen_prog
         --IF NOT adzp270_run_cmd(l_cmd) THEN
            --LET g_pro_msg = g_pro_msg,"產生4gl檔(執行gencompose) .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
            --CALL cl_progress_bar_close()
            --RETURN FALSE
         --END IF
         --LET g_pro_msg = g_pro_msg,"產生4gl檔(執行gencompose) .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10

         ###### 產生tgl檔和4gl檔(執行r.c3)
         LET l_cmd = "r.c3 ",g_gen_prog," '' 1 1" #程式版次固定為1
         IF NOT adzp270_run_cmd(l_cmd) THEN
            LET g_pro_msg = g_pro_msg,"產生tgl檔和4gl檔(執行r.c3) .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
            #CALL cl_progress_bar_close()
            #RETURN FALSE
         ELSE
            LET g_pro_msg = g_pro_msg,"產生tgl檔和4gl檔(執行r.c3) .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
         END IF

      ELSE
         ###### 產生tgl檔和4gl檔(執行r.c3)   
         LET l_cmd = "r.c3 ",g_gen_prog," '' 1 0" #程式版次固定為1
         IF NOT adzp270_run_cmd(l_cmd) THEN
            LET g_pro_msg = g_pro_msg,"產生tgl檔和4gl檔(執行r.c3) .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
            #CALL cl_progress_bar_close()
            #RETURN FALSE
         ELSE
            LET g_pro_msg = g_pro_msg,"產生tgl檔和4gl檔(執行r.c3) .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
         END IF
      END IF

   END IF
   CALL cl_progress_ing("[Message]adzp270複製規格與程式過程")

   ############ 6.產生4ad檔和4tm檔 ############
   IF g_main_or_sub_prog = "M" THEN #目前主程式才能產生4ad檔和4tm檔
   
      ###### 解析4gl中的ACTION到gzzr_t
      LET l_cmd = "r.r azzp195 ",g_gen_prog
      IF NOT adzp270_run_cmd(l_cmd) THEN
         LET g_pro_msg = g_pro_msg,"解析4gl中的ACTION到gzzr_t .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
         CALL cl_progress_bar_close()
         RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"解析4gl中的ACTION到gzzr_t .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10

      #確認gzzr_t有設計資料,再產生4ad檔
      SELECT COUNT(*) INTO l_cnt FROM gzzr_t WHERE gzzr001=g_copy_source
      IF l_cnt>0 THEN
         LET l_cmd = "r.r azzp193 ",g_gen_prog," 4ad ",g_lang
         IF NOT adzp270_run_cmd(l_cmd) THEN
            LET g_pro_msg = g_pro_msg,"產生4ad檔.................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
            CALL cl_progress_bar_close()
            RETURN FALSE
         END IF
         LET g_pro_msg = g_pro_msg,"產生4ad檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
      END IF

      ###### 確認gzzp_t有設計資料,再產生4tm檔
      SELECT COUNT(*) INTO l_cnt FROM gzzp_t WHERE gzzp001=g_copy_source
      IF l_cnt>0 THEN
         LET l_cmd = "r.r azzp193 ",g_gen_prog," 4tm ",g_lang
         IF NOT adzp270_run_cmd(l_cmd) THEN
            LET g_pro_msg = g_pro_msg,"產生4tm檔 .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
            CALL cl_progress_bar_close()   
            RETURN FALSE
         END IF
         LET g_pro_msg = g_pro_msg,"產生4tm檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
      END IF
   END IF
   CALL cl_progress_ing("[Message]adzp270複製規格與程式過程")

   #如果複製目標存在畫面檔則進行產生42s檔
   IF os.Path.exists(g_gen_4fd_path) THEN
      LET l_cmd = "r.r azzp191 ",g_gen_prog," ",g_lang
      IF NOT adzp270_run_cmd(l_cmd) THEN
         LET g_pro_msg = g_pro_msg,"產生42s檔 .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
         CALL cl_progress_bar_close()
         RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"產生42s檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10  
   END IF
   CALL cl_progress_ing("[Message]adzp270複製規格與程式過程")
   
   RETURN TRUE
   
END FUNCTION

#+ 清除相關的檔案
PRIVATE FUNCTION adzp270_delete_file()
   DEFINE ls_path STRING
  
   ### 刪除4fd
   LET ls_path=os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "4fd"), g_gen_prog||".4fd")
   #檔案如果已經存在則先刪除
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         LET g_pro_msg = g_pro_msg,"刪除4fd檔失敗",ASCII 10
         RETURN FALSE
      END IF
   END IF
   
   ### 刪除tab
   LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "dzx"), "tab"),g_gen_prog||".tab")
   #檔案如果已經存在則先刪除
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         LET g_pro_msg = g_pro_msg,"刪除tab檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
         RETURN FALSE
      END IF
   END IF

   ### 刪除tgl
   LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "dzx"), "tgl"),g_gen_prog||".tgl")
   #檔案如果已經存在則先刪除
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         LET g_pro_msg = g_pro_msg,"刪除tgl檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
         RETURN FALSE
      END IF
   END IF

   ### 刪除4gl
   LET ls_path=os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "4gl"), g_gen_prog||".4gl")
   #檔案如果已經存在則先刪除
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         LET g_pro_msg = g_pro_msg,"刪除4gl檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
         RETURN FALSE
      END IF
   END IF

   ### 刪除4tm
   LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "4tm"), g_lang),g_gen_prog||".4tm")
   #檔案如果已經存在則先刪除
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         LET g_pro_msg = g_pro_msg,"刪除4tm檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
         RETURN FALSE
      END IF
   END IF

   ### 刪除4ad
   LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(adzp270_find_module(g_gen_prog)), "4ad"), g_lang),g_gen_prog||".4ad")
   #檔案如果已經存在則先刪除
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         LET g_pro_msg = g_pro_msg,"刪除4ad檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE
END FUNCTION


#+ 尋找模組
PRIVATE FUNCTION adzp270_find_module(p_prog)
   DEFINE p_prog   LIKE dzaa_t.dzaa001,
          ls_sql   STRING,
          l_cnt    LIKE type_t.num5

   CASE g_main_or_sub_prog 

      #尋找模組的sql
      WHEN "M"
         #資料來源作業azzi900
         LET ls_sql = "SELECT gzza003",
                      " FROM gzza_t",
                      " WHERE gzza001='",p_prog,"'"
      WHEN "S"
         #資料來源作業azzi901
         LET ls_sql = "SELECT gzde002",
                      " FROM gzde_t",
                      " WHERE gzde001='",p_prog,"'"
      WHEN "F"
         #尋找子程式的子畫面有無資料存在
         SELECT COUNT(*) INTO l_cnt 
            FROM gzde_t
            LEFT JOIN gzdf_t ON gzde001=gzdf001
            WHERE gzdf002= p_prog

         IF l_cnt >0 THEN 
            #資料來源作業azzi901_代表子程式的子畫面
            LET ls_sql = "SELECT gzde002",
                         " FROM gzde_t",
                         " LEFT JOIN gzdf_t ON gzde001=gzdf001 ",
                         " WHERE gzdf002='",p_prog,"'"
         ELSE
            #資料來源作業azzi900_代表主程式的子畫面
            LET ls_sql = "SELECT gzza003",
                         " FROM gzza_t",
                         " LEFT JOIN gzdf_t ON gzza001=gzdf001 ",
                         " WHERE gzdf002='",p_prog,"'"  
         END IF
      WHEN "LIB"
         #資料來源作業azzi901
         LET ls_sql = "SELECT gzde002",
                      " FROM gzde_t",
                      " WHERE gzde001='",p_prog,"'"            
      WHEN "SUB"
         #資料來源作業azzi901
         LET ls_sql = "SELECT gzde002",
                      " FROM gzde_t",
                      " WHERE gzde001='",p_prog,"'"
   END CASE
   
   PREPARE gzza_prep FROM ls_sql

   #尋找模組
   EXECUTE gzza_prep INTO gr_gzza.gzza003

   FREE gzza_prep

   LET gr_gzza.gzza003=gr_gzza.gzza003 CLIPPED
   
   #DISPLAY "回傳模組為：",gr_gzza.gzza003

   RETURN gr_gzza.gzza003
   
END FUNCTION

#+ 移除4df檔中有關被排除欄位的節點
PRIVATE FUNCTION adzp270_rm_excluded_col_4fd(p_node)
   DEFINE p_node            om.DomNode,
          l_parent_node     om.DomNode,
          l_next_node      om.DomNode,
          l_previous_node   om.DomNode,
          l_ndoe_name       STRING,
          l_i               LIKE type_t.num5

   LET l_ndoe_name = p_node.getAttribute("name")
   LET l_parent_node = p_node.getParent()
   FOR l_i = 1 TO ga_excluded_col.getLength()
      IF ga_excluded_col[l_i].col_id IS NULL OR 
         ga_excluded_col[l_i].col_id_tmp IS NULL OR 
         ga_excluded_col[l_i].table_id IS NULL OR 
         ga_excluded_col[l_i].table_id_tmp IS NULL THEN
      END IF
   
      IF l_ndoe_name MATCHES ga_excluded_col[l_i].col_id||"*"  OR
         l_ndoe_name MATCHES "*"||ga_excluded_col[l_i].col_id OR
         l_ndoe_name MATCHES "*"||ga_excluded_col[l_i].col_id||"*" THEN
         #DISPLAY "name = ",l_ndoe_name,":",p_node.getTagName()
         CALL l_parent_node.removeChild(p_node)
         LET p_node = l_parent_node
         EXIT FOR 
      END IF
   END FOR
   
   LET p_node = p_node.getFirstChild()   
   
   WHILE p_node IS NOT NULL
      CALL adzp270_rm_excluded_col_4fd(p_node)
      LET p_node = p_node.getNext() ###
    
   END WHILE
   
END FUNCTION

#+
PRIVATE FUNCTION adzp270_replace_col_tab_str_4fd(p_node)
   DEFINE p_node            om.DomNode,
          l_parent_node     om.DomNode,
          l_next_node       om.DomNode,
          l_previous_node   om.DomNode,
          l_ndoe_name       STRING,
          l_i               LIKE type_t.num5,
          l_j               LIKE type_t.num5,
          l_k               LIKE type_t.num5,
          l_l               LIKE type_t.num5,
          l_old_str         STRING,
          l_new_str         STRING,
          lb_buf             base.StringBuffer,
          l_old_table_prefix STRING,
          l_modify          LIKE type_t.num5,#是否修改此節點內的屬性值
          l_cnt             LIKE type_t.num5,
          l_col_id          LIKE dzeb_t.dzeb002,
          l_colName         STRING,
          l_fieldType       STRING

   LET lb_buf = base.StringBuffer.create()
   LET l_ndoe_name = p_node.getAttribute("name")
   LET l_colName = p_node.getAttribute("colName")
   LET l_fieldType = p_node.getAttribute("fieldType")

   #預設修改此節點內的屬性值
   LET l_modify = TRUE

   #排除沒對應的欄位不改其內容值
   FOR l_i  = 1 TO ga_excluded_col.getLength()

      IF l_ndoe_name MATCHES ga_excluded_col[l_i].col_id||"*"  OR
         l_ndoe_name MATCHES "*"||ga_excluded_col[l_i].col_id OR
         l_ndoe_name MATCHES "*"||ga_excluded_col[l_i].col_id||"*" THEN

         #不修改此節點內的屬性值
         LET l_modify = FALSE

         EXIT FOR
      END IF
   END FOR

   IF l_modify = TRUE THEN
   
      #DISPLAY "name = ",l_ndoe_name,":",p_node.getTagName()
      FOR l_i = 1 TO ga_dzeb_stored.getLength()
         IF ga_dzeb_stored[l_i].new_col_id IS NULL OR ga_dzeb_stored[l_i].old_col_id IS NULL THEN
            CONTINUE FOR
         END IF
         IF l_ndoe_name MATCHES ga_dzeb_stored[l_i].old_col_id||"*"  OR
            l_ndoe_name MATCHES "*"||ga_dzeb_stored[l_i].old_col_id OR
            l_ndoe_name MATCHES "*"||ga_dzeb_stored[l_i].old_col_id||"*" THEN
            #DISPLAY "name = ",l_ndoe_name,":",p_node.getTagName()

            #換置屬性值
            FOR l_j=1 TO p_node.getAttributesCount()
               #DISPLAY p_node.getAttributeValue(i)
               CALL lb_buf.clear()
               CALL lb_buf.append(p_node.getAttributeValue(l_j))

               #轉換欄位代號的字串
               FOR l_k = 1 TO ga_dzeb_stored.getLength()
                  IF ga_dzeb_stored[l_k].new_col_id IS NULL OR ga_dzeb_stored[l_k].old_col_id IS NULL THEN
                     CONTINUE FOR
                  END IF

                  IF lb_buf.toString() MATCHES ga_dzeb_stored[l_k].old_col_id||"*" OR 
                     lb_buf.toString() MATCHES "*"||ga_dzeb_stored[l_k].old_col_id OR
                     lb_buf.toString() MATCHES "*"||ga_dzeb_stored[l_k].old_col_id||"*" THEN
                     #原本的欄位代號
                     LET l_old_str = ga_dzeb_stored[l_k].old_col_id
                     LET l_old_str = l_old_str.trim()
                     
                     #要轉換的欄位代號
                     LET l_new_str = ga_dzeb_stored[l_k].new_col_id
                     LET l_new_str = l_new_str.trim()
                     
                     CALL lb_buf.replace(l_old_str, l_new_str, 0)
                     EXIT FOR
                  END IF
               END FOR
               
               #產生轉換表格代號的相關字串
               FOR l_k = 1 TO ga_dzag.getLength()
                  IF ga_dzag[l_k].new_table_id IS NULL OR 
                     ga_dzag[l_k].old_table_id IS NULL THEN
                     CONTINUE FOR
                  END IF

                  IF lb_buf.toString() MATCHES ga_dzag[l_k].old_table_id||"*" OR 
                     lb_buf.toString() MATCHES "*"||ga_dzag[l_k].old_table_id OR
                     lb_buf.toString() MATCHES "*"||ga_dzag[l_k].old_table_id||"*" THEN

                     #原本的表格代號
                     LET l_old_str = ga_dzag[l_k].old_table_id
                     LET l_old_str = l_old_str.trim()

                     #要轉換的表格代號
                     LET l_new_str = ga_dzag[l_k].new_table_id
                     LET l_new_str = l_new_str.trim()
                     
                     CALL lb_buf.replace(l_old_str, l_new_str, 0)
                     EXIT FOR
                  END IF
               END FOR

               CALL p_node.setAttribute(p_node.getAttributeName(l_j),lb_buf.toString())
            END FOR
            EXIT FOR 
         END IF
       
      END FOR
   END IF

   LET l_ndoe_name = p_node.getAttribute("name")
   LET l_colName = p_node.getAttribute("colName")
   LET l_fieldType = p_node.getAttribute("fieldType")
   #預先檢查屬性 colName 的節點 , 經轉換之後的 屬性 colName 的屬性值 , 在資料庫中是 不存在的欄位 ,此種節點需要被 排除在修改之外
   IF l_modify = TRUE THEN
      IF l_fieldType <> "NON_DATABASE" AND  l_colName IS NOT NULL THEN

         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR ga_dzag[l_i].old_table_id IS NULL THEN
               CONTINUE FOR
            END IF

            LET l_old_table_prefix = ga_dzag[l_i].old_table_id CLIPPED
            LET l_old_table_prefix = l_old_table_prefix.subString(1,l_old_table_prefix.getLength()-2)
            
            IF l_ndoe_name MATCHES l_old_table_prefix||"*"  OR
               l_ndoe_name MATCHES "*"||l_old_table_prefix OR
               l_ndoe_name MATCHES "*"||l_old_table_prefix||"*" THEN

               CALL lb_buf.clear()
               CALL lb_buf.append(l_colName)
               #原本的表格代號前綴
               LET l_old_str = ga_dzag[l_i].old_table_id CLIPPED
               LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
                     
               #要轉換的表格代號前綴
               LET l_new_str = ga_dzag[l_i].new_table_id CLIPPED
               LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)
               IF lb_buf.toString() MATCHES l_old_str||"*" OR 
                  lb_buf.toString() MATCHES "*"||l_old_str OR
                  lb_buf.toString() MATCHES "*"||l_old_str||"*" THEN
                  
                  CALL lb_buf.replace(l_old_str, l_new_str, 0)
                  EXIT FOR
               END IF
               
            END IF
            
         END FOR

         IF l_ndoe_name MATCHES l_old_table_prefix||"*"  OR
            l_ndoe_name MATCHES "*"||l_old_table_prefix OR
            l_ndoe_name MATCHES "*"||l_old_table_prefix||"*" THEN
         
            LET l_col_id = lb_buf.toString()
            SELECT COUNT(1) INTO l_cnt FROM dzeb_t WHERE dzeb002=l_col_id
            
            IF l_cnt = 0 THEN
               DISPLAY "####轉換後為不存在的欄位："
               DISPLAY "l_ndoe_name = ",l_ndoe_name,":",l_colName,":",l_col_id
               #不修改此節點內的屬性值
               LET l_modify = FALSE
            END IF

         END IF

      END IF
   END IF
      
   IF l_modify = TRUE THEN
      FOR l_i = 1 TO ga_dzag.getLength()
         IF ga_dzag[l_i].new_table_id IS NULL OR ga_dzag[l_i].old_table_id IS NULL THEN
            CONTINUE FOR
         END IF

         LET l_old_table_prefix = ga_dzag[l_i].old_table_id CLIPPED
         LET l_old_table_prefix = l_old_table_prefix.subString(1,l_old_table_prefix.getLength()-2)
         
         IF l_ndoe_name MATCHES l_old_table_prefix||"*"  OR
            l_ndoe_name MATCHES "*"||l_old_table_prefix OR
            l_ndoe_name MATCHES "*"||l_old_table_prefix||"*" THEN

            

            #換置屬性值
            FOR l_j=1 TO p_node.getAttributesCount()
               #DISPLAY p_node.getAttributeValue(i)
               CALL lb_buf.clear()
               CALL lb_buf.append(p_node.getAttributeValue(l_j))

               #轉換表格代號前綴的字串
               FOR l_k = 1 TO ga_dzag.getLength()
                  IF ga_dzag[l_k].new_table_id IS NULL OR ga_dzag[l_k].old_table_id IS NULL THEN
                     CONTINUE FOR
                  END IF

                  #原本的表格代號前綴
                  LET l_old_str = ga_dzag[l_k].old_table_id CLIPPED
                  LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
                  
                  #要轉換的表格代號前綴
                  LET l_new_str = ga_dzag[l_k].new_table_id CLIPPED
                  LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)
                  
                  IF lb_buf.toString() MATCHES l_old_str||"*" OR 
                     lb_buf.toString() MATCHES "*"||l_old_str OR
                     lb_buf.toString() MATCHES "*"||l_old_str||"*" THEN
                     
                     CALL lb_buf.replace(l_old_str, l_new_str, 0)
                     EXIT FOR
                  END IF
               END FOR

               CALL p_node.setAttribute(p_node.getAttributeName(l_j),lb_buf.toString())
            END FOR
            
         END IF
         
      END FOR

   END IF

   
   LET p_node = p_node.getFirstChild()   
   
   WHILE p_node IS NOT NULL
      CALL adzp270_replace_col_tab_str_4fd(p_node)
      LET p_node = p_node.getNext() ###
    
   END WHILE
   
END FUNCTION

#+ 產生4fd檔
PRIVATE FUNCTION adzp270_gen_4fd()
   DEFINE ls_sql      STRING,
          lt_4fd_str  TEXT,
          lb_buf      base.StringBuffer,
          lb_flag     LIKE type_t.num5,
          l_i         LIKE type_t.num5,
          l_old_str   STRING,
          l_new_str   STRING,
          l_4fd_doc   om.DomDocument,
          l_4fd_root  om.DomNode

   LET g_copy_source = g_copy_source CLIPPED
   LET g_gen_prog    = g_gen_prog CLIPPED
   
   LOCATE lt_4fd_str IN FILE

   #檢查來源檔的存在和檔案權限
   IF os.Path.exists(g_source_4fd_path) AND adzp270_chk_file_permisson(g_source_4fd_path) THEN

      LET lt_4fd_str = adzp270_read_file(g_source_4fd_path,lt_4fd_str)
      LET lb_buf = base.StringBuffer.create()
      
      LET l_4fd_doc = om.DomDocument.createFromString(lt_4fd_str)
      LET l_4fd_root = l_4fd_doc.getDocumentElement()

      #如果有啟動表格轉換的話,置換4fd檔內的表格的相關字串
      IF g_use_table_replace = "Y" THEN
         CALL adzp270_replace_col_tab_str_4fd(l_4fd_root)
         #CALL l_4fd_root.writeXml(g_gen_4fd_path||".xml")
         #CALL lb_buf.append(l_4fd_root.toString())
      END IF
      

      #自動移除4df檔中有關被排除欄位的節點
      #IF g_rm_excluded_col_4fd = "Y" AND g_use_table_replace = "Y" THEN
         #CALL adzp270_rm_excluded_col_4fd(l_4fd_root)
         #CALL l_4fd_root.writeXml(g_gen_4fd_path||".xml")
         #CALL lb_buf.append(l_4fd_root.toString())
      #END IF

      IF g_use_table_replace = "Y" THEN 
         CALL lb_buf.append(l_4fd_root.toString())
      ELSE
         CALL lb_buf.append(lt_4fd_str)
      END IF

      #置換4fd檔內的程式代號字串
      LET l_old_str = g_copy_source
      LET l_new_str = g_gen_prog

      CALL lb_buf.replace(l_old_str, l_new_str, 0)

      LET lt_4fd_str = lb_buf.toString()

      CALL adzp270_write_file(g_gen_4fd_path,lt_4fd_str)

      #檢查檔案是否產生成功
      IF os.Path.exists(g_gen_4fd_path) THEN
   　　   LET lb_flag = TRUE
      ELSE
         LET lb_flag = FALSE
      END IF

   ELSE
      LET lb_flag = FALSE
   END IF

   FREE gzza_prep
   
   FREE lt_4fd_str
   
   RETURN lb_flag
END FUNCTION


#+ 進行 command line 的程式執行
PRIVATE FUNCTION adzp270_run_cmd(p_cmd)
   DEFINE p_cmd          STRING    
   DEFINE l_msg          STRING
   DEFINE l_chk          LIKE type_t.num5
  
   #DISPLAY "l_cmd = ",l_cmd 
   CALL cl_cmdrun_openpipe(p_cmd,p_cmd,FALSE) RETURNING l_chk,l_msg

   RETURN  l_chk
END FUNCTION


#+檢查檔案權限是否能讀取
PRIVATE FUNCTION adzp270_chk_file_permisson(p_file)
   DEFINE p_file      STRING         #檔案路徑
   DEFINE l_ch_in     base.Channel   #Genero讀取的檔案物件變數

   LET l_ch_in = base.Channel.create()

   TRY
      #指定來源的的檔案路徑
      CALL l_ch_in.openFile(p_file,"r")
   CATCH
      IF STATUS THEN
         #對此檔案的權限不足
         CALL cl_err_msg("ERROR:permission","adz-00156",p_file,1)
         RETURN FALSE
      END IF 
   END TRY
   
   CALL l_ch_in.close()

   RETURN TRUE
END FUNCTION


#+ 取出檔案內的字串(使用TEXT的內建FUNCTION讀檔)
FUNCTION adzp270_read_file(p_file_path,pt_str)
   DEFINE p_file_path   STRING,
          pt_str        TEXT

   #讀取檔案內容
   CALL pt_str.readFile(p_file_path)
   #DISPLAY "pt_str = ",pt_str
   
   RETURN pt_str
END FUNCTION


#+ 寫入出檔案內的字串(使用TEXT的內建FUNCTION寫檔)
FUNCTION adzp270_write_file(p_file_path,pt_str)
   DEFINE p_file_path      STRING,
          pt_str           TEXT,
          lb_chrwx_return  LIKE type_t.num5,
          lb_del           LIKE type_t.num5
          
   #檔案如果已經存在則先刪除
   IF os.Path.exists(p_file_path) THEN
      CALL os.Path.delete(p_file_path) RETURNING lb_del
   END IF

   #DISPLAY "pt_str = ",

   CALL pt_str.writeFile(p_file_path)

   IF os.Path.exists(p_file_path) THEN
      DISPLAY "檔案存在:",p_file_path
   END IF
   
   CALL os.Path.chrwx(p_file_path, 511) RETURNING lb_chrwx_return
END FUNCTION


#+ 複製資料庫的設計資料
PRIVATE FUNCTION adzp270_copy_database_data()
   DEFINE ls_sql   STRING,
          l_user   LIKE dzaa_t.dzaaownid,
          l_dept   LIKE dzaa_t.dzaaowndp,
          l_date   LIKE dzaa_t.dzaacrtdt,
          ls_err   STRING,
          ln_cnt   LIKE type_t.num5,
          lb_flag  BOOLEAN #檢查transation的過程式否有錯誤
          
   LET l_user        = g_user
   LET l_dept        = g_dept
   LET l_date        = cl_get_current()
   
   LET g_gen_prog    = g_gen_prog CLIPPED
   LET g_gen_spec_ver    = g_gen_spec_ver CLIPPED
   LET g_design_point_ver  = g_design_point_ver CLIPPED
   LET g_copy_source = g_copy_source CLIPPED
   LET g_source_ver  = g_source_ver CLIPPED
   
   LET lb_flag = TRUE
   BEGIN WORK

   TRY
      ######-- dzaa_t-- 自訂sql 複製dzaa_t(規格與內容版本對應表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzaa_t(
         dzaastus,
         dzaa001,
         dzaa002,
         dzaa003,
         dzaa004,
         dzaa005,
         dzaa006,
         dzaa007,
         dzaa008,
         dzaaownid,dzaaowndp,dzaacrtid,dzaacrtdp,dzaacrtdt
         )SELECT
            dzaastus,
            '",g_gen_prog,"' dzaa001,
            '",g_gen_spec_ver,"' dzaa002,
            dzaa003,
            '",g_design_point_ver,"' dzaa004,
            dzaa005,
            '",ms_dgenv,"' dzaa006,
            dzaa007,
            dzaa008,
            '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt
            FROM dzaa_t
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaastus='Y' 
            ORDER BY dzaa005,dzaa003"

      PREPARE insert_data_to_dzaa_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzaa_t"
      EXECUTE insert_data_to_dzaa_t

      
      ######-- dzab_t-- sql參考 sadzp030_tsd_get_dzab_sql(g_code, g_ver) 複製dzab_t(規格整體設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzab_t(
         dzabstus,
         dzab001,
         dzab002,
         dzab099,
         dzab003,
         dzab004,
         dzab005,
         dzab006,
         dzabownid,dzabowndp,dzabcrtid,dzabcrtdp,dzabcrtdt
         )SELECT 
            dzabstus,
            '",g_gen_prog,"' dzab001,
            '",g_design_point_ver,"' dzab002,
            REPLACE(dzab099,'",g_copy_source,"','",g_gen_prog,"') dzab099,
            '",ms_dgenv,"' dzab003,
            dzab004,
            dzab005,
            dzab006,
            '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt 
            FROM dzab_t
            INNER JOIN dzaa_t ON dzaa001=dzab001 AND dzaa003=dzab004 AND dzaa004=dzab002 AND dzaa006 = dzab003
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='3' AND dzaastus='Y'"

      PREPARE insert_data_to_dzab_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzab_t"
      EXECUTE insert_data_to_dzab_t 


      ######-- dzac_t-- sql參考 sadzp030_tsd_get_dzac_sql(g_code, g_ver) 複製dzac_t(欄位規格設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzac_t(
         dzacstus,
         dzac001,
         dzac002,
         dzac003,
         dzac004,
         dzac005,
         dzac006,
         dzac007,
         dzac008,
         dzac009,
         dzac010,
         dzac011,
         dzac012,
         dzac013,
         dzac014,
         dzac015,
         dzac016,
         dzac017,
         dzac018,
         dzac019,
         dzac099,
         dzac020,
         dzac021, 
         dzacownid,dzacowndp,dzaccrtid,dzaccrtdp,dzaccrtdt
         )SELECT 
            dzacstus,
            '",g_gen_prog,"' dzac001,
            dzac002,
            dzac003,
            '",g_design_point_ver,"' dzac004,
            dzac005,
            dzac006,
            dzac007,
            dzac008,
            dzac009,
            dzac010,
            dzac011,
            '",ms_dgenv,"' dzac012,
            dzac013,
            dzac014,
            dzac015,
            dzac016,
            dzac017,
            dzac018,
            dzac019,
            REPLACE(dzac099,'",g_copy_source,"','",g_gen_prog,"') dzac099,
            dzac020,
            dzac021, 
            '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt 
            FROM dzac_t
            INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaastus='Y'"

      PREPARE insert_data_to_dzac_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzac_t"
      EXECUTE insert_data_to_dzac_t 

      #END IF

      
      ######-- dzak_t-- sql參考 sadzp030_tsd_get_dzak_sql(g_code, g_ver) 複製dzak_t(欄位助記碼設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzak_t(
         dzakstus,
         dzak001,
         dzak002,
         dzak003,
         dzak004,
         dzak005,
         dzak007,
         dzak008,
         dzak009,
         dzak010,
         dzak011,
         dzakownid,dzakowndp,dzakcrtid,dzakcrtdp,dzakcrtdt
         )SELECT 
            dzakstus,
            '",g_gen_prog,"' dzak001,
            dzak002,
            '",g_design_point_ver,"' dzak003,
            '",ms_dgenv,"' dzak004,
            dzak005,
            dzak007,
            dzak008,
            dzak009,
            dzak010,
            dzak011,
            '",l_user,"' dzakownid,'",l_dept,"' dzakowndp,'",l_user,"' dzakcrtid,'",l_dept,"' dzakcrtdp,'",l_date USING "yyyy/mm/dd","' dzakcrtdt
            FROM dzak_t
            INNER JOIN dzac_t ON dzac001=dzak001 AND dzac003=dzak002 AND dzac004=dzak003 AND dzac012=dzak004
            INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaastus='Y'"

      PREPARE insert_data_to_dzak_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzak_t"
      EXECUTE insert_data_to_dzak_t 

      ######-- dzad_t-- sql參考 sadzp030_tsd_get_dzad_sql(g_code, g_ver) 複製dzad_t(Action規格設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzad_t(
         dzadstus,
         dzad001,
         dzad002,
         dzad003,
         dzad099,
         dzad005,
         dzad006,
         dzad007,
         dzadownid,dzadowndp,dzadcrtid,dzadcrtdp,dzadcrtdt
         )SELECT 
            dzadstus,
            '",g_gen_prog,"' dzad001,
            dzad002,
            '",g_design_point_ver,"' dzad003,
            REPLACE(dzad099,'",g_copy_source,"','",g_gen_prog,"') dzad099,
            '",ms_dgenv,"' dzad005,
            dzad006,
            dzad007,
            '",l_user,"' dzadownid,'",l_dept,"' dzadowndp,'",l_user,"' dzadcrtid,'",l_dept,"' dzadcrtdp,'",l_date USING "yyyy/mm/dd","' dzadcrtdt
            FROM dzad_t 
            INNER JOIN dzaa_t ON dzaa001=dzad001 AND dzaa003=dzad002 AND dzaa004=dzad003 AND dzaa006=dzad005
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='2' AND dzaastus='Y'"

      PREPARE insert_data_to_dzad_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzad_t"
      EXECUTE insert_data_to_dzad_t 


      ######-- dzah_t-- 自訂sql 複製dzah_t(Action觸發時機設計表)的SQL.
      #LET ls_sql = 
      #"INSERT INTO dzah_t(
         #dzahstus,
         #dzah001,
         #dzah002,
         #dzah003,
         #dzah004,
         #dzah005,
         #dzah006, 
         #dzahownid,dzahowndp,dzahcrtid,dzahcrtdp,dzahcrtdt
         #)SELECT 
            #dzahstus,
            #'",g_gen_prog,"' dzah001,
            #dzah002,'",g_design_point_ver,"' dzah003,'",ms_dgenv,"' dzah004,dzah005,dzah006, 
            #'",l_user,"' dzahownid,'",l_dept,"' dzahowndp,'",l_user,"' dzahcrtid,'",l_dept,"' dzahcrtdp,'",l_date USING "yyyy/mm/dd","' dzahcrtdt
            #FROM dzah_t
            #INNER JOIN dzad_t ON dzad001=dzah001 AND dzad002=dzah002 AND dzad003=dzah003 AND dzad005=dzah004 
            #WHERE dzad001 = '",g_copy_source,"' AND dzadstus='Y'"
      #
      #PREPARE insert_data_to_dzah_t FROM ls_sql
      #LET ls_err = "error:insert_data_to_dzah_t"
      #EXECUTE insert_data_to_dzah_t 


      ######-- dzae_t--  sql參考 sadzp030_tsd_get_dzae_sql(p_code, p_ver) 複製dzae_t(設計器程式基本資料表)的SQL.
      #LET ls_sql =
      #"INSERT INTO dzae_t(
         #dzaestus,
         #dzae001,
         #dzae002,
         #dzae003,
         #dzae004, 
         #dzaeownid,dzaeowndp,dzaecrtid,dzaecrtdp,dzaecrtdt
         #)SELECT 
            #dzaestus,
            #'",g_gen_prog,"' dzae001,
            #'",g_gen_spec_ver,"' dzae002,
            #dzae003,
            #dzae004,
            #'",l_user,"' dzaeownid,'",l_dept,"' dzaeowndp,'",l_user,"' dzaecrtid,'",l_dept,"' dzaecrtdp,'",l_date USING "yyyy/mm/dd","' dzaecrtdt
            #FROM dzae_t
            #WHERE dzae001='",g_copy_source,"' AND dzae002='",g_source_code_ver,"'"
#
      #PREPARE insert_data_to_dzae_t FROM ls_sql
      #LET ls_err = "error:insert_data_to_dzae_t"
      #EXECUTE insert_data_to_dzae_t 


      ######-- dzag_t--  sql參考 sadzp030_tsd_get_dzag_sql(p_code, p_ver) 複製dzag_t(規格Table設定表)的SQL.
      LET ls_sql =
      "INSERT INTO dzag_t(
         dzagstus,
         dzag001,
         dzag002,
         dzag003,
         dzag004,
         dzag005,
         dzag006,
         dzag007,
         dzag008,
         dzag009,
         dzag010,
         dzagownid,dzagowndp,dzagcrtid,dzagcrtdp,dzagcrtdt
         )SELECT 
            dzagstus,
            '",g_gen_prog,"' dzag001,
            dzag002,
            '",g_design_point_ver,"' dzag003,
            dzag004,
            dzag005,
            '",ms_dgenv,"' dzag006,
            dzag007,
            dzag008,
            dzag009,
            dzag010,
            '",l_user,"' dzagownid,'",l_dept,"' dzagowndp,'",l_user,"' dzagcrtid,'",l_dept,"' dzagcrtdp,'",l_date USING "yyyy/mm/dd","' dzagcrtdt
            FROM dzaa_t 
            INNER JOIN dzag_t ON dzag001=dzaa001 AND dzag003=dzaa004 AND dzagstus='Y'
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TABLE' AND dzaa005='4' AND dzaastus='Y'"

      PREPARE insert_data_to_dzag_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzag_t"
      EXECUTE insert_data_to_dzag_t 


      ######-- dzfs_t--  自訂sql 複製dzfs_t(程式Table與Screen Record對應檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzfs_t(
         dzfsstus,
         dzfs001,
         dzfs002,
         dzfs003,
         dzfs004,
         dzfs005,
         dzfs006,
         dzfs007,
         dzfs008,
         dzfs009,
         dzfs010,
         dzfsownid,dzfsowndp,dzfscrtid,dzfscrtdp,dzfscrtdt
         )SELECT 
            dzfsstus,
            dzfs001,
            '",g_gen_prog,"' dzfs002,
            dzfs003,
            dzfs004,
            '",ms_dgenv,"' dzfs005,
            dzfs006,
            dzfs007,
            dzfs008,
            dzfs009,
            dzfs010,
            '",l_user,"' dzfsownid,'",l_dept,"' dzfsowndp,'",l_user,"' dzfscrtid,'",l_dept,"' dzfscrtdp,'",l_date USING "yyyy/mm/dd","' dzfscrtdt
            FROM dzfs_t
            INNER JOIN dzag_t ON dzag001 = dzfs002 AND dzag002 = dzfs004 AND dzag003 = dzfs001 AND dzagstus='Y'
            WHERE  dzfs002 = '",g_copy_source,"' AND dzfsstus='Y'"

      PREPARE insert_data_to_dzfs_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzfs_t"
      EXECUTE insert_data_to_dzfs_t 


      ######-- dzai_t-- sql參考 sadzp030_tsd_get_dzai_sql(g_code, g_ver) 複製dzai_t(欄位參考設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzai_t(
         dzaistus,
         dzai001,
         dzai002,
         dzai003,
         dzai004,
         dzai005,
         dzai007,
         dzai008,
         dzai009,
         dzai010,
         dzai011, 
         dzaiownid,dzaiowndp,dzaicrtid,dzaicrtdp,dzaicrtdt
         )SELECT 
            dzaistus,
            '",g_gen_prog,"' dzai001,
            dzai002,
            '",g_design_point_ver,"' dzai003,
            '",ms_dgenv,"' dzai004,
            dzai005,
            dzai007,
            dzai008,
            dzai009,
            dzai010,
            dzai011,
            '",l_user,"' dzaiownid,'",l_dept,"' dzaiowndp,'",l_user,"' dzaicrtid,'",l_dept,"' dzaicrtdp,'",l_date USING "yyyy/mm/dd","' dzaicrtdt
            FROM dzai_t
            INNER JOIN dzaa_t ON dzaa001=dzai001 AND dzaa003=dzai002 AND dzaa004=dzai003 AND dzaa006=dzai004 
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='6' AND dzaastus='Y'"
         
      PREPARE insert_data_to_dzai_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzai_t"
      EXECUTE insert_data_to_dzai_t 

      
      ######-- dzaj_t-- sql參考 sadzp030_tsd_get_dzaj_sql(p_code, p_ver) 複製dzaj_t(欄位資料多語言設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzaj_t(
         dzajstus,
         dzaj001,
         dzaj002,
         dzaj003,
         dzaj004,
         dzaj005,
         dzaj007,
         dzaj008,
         dzaj009,
         dzaj010,
         dzaj011, 
         dzajownid,dzajowndp,dzajcrtid,dzajcrtdp,dzajcrtdt
         )SELECT 
            dzajstus,
            '",g_gen_prog,"' dzaj001,
            dzaj002,
            '",g_design_point_ver,"' dzaj003,
            '",ms_dgenv,"' dzaj004,
            dzaj005,
            dzaj007,
            dzaj008,
            dzaj009,
            dzaj010,
            dzaj011,
            '",l_user,"' dzajownid,'",l_dept,"' dzajowndp,'",l_user,"' dzajcrtid,'",l_dept,"' dzajcrtdp,'",l_date USING "yyyy/mm/dd","' dzajcrtdt
            FROM dzaj_t 
            INNER JOIN dzaa_t ON dzaa001=dzaj001 AND dzaa003=dzaj002 AND dzaa004=dzaj003 AND dzaa006=dzaj004
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='7' AND dzaastus='Y'"

      PREPARE insert_data_to_dzaj_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzaj_t"
      EXECUTE insert_data_to_dzaj_t 


      ######-- dzal_t-- sql參考 sadzp030_tsd_get_dzal_sql(p_code, p_ver) 複製dzal_t(程式串查設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzal_t(
         dzalstus,
         dzal001,
         dzal002,
         dzal003,
         dzal004,
         dzal005,
         dzal006,
         dzal007,
         dzalownid,dzalowndp,dzalcrtid,dzalcrtdp,dzalcrtdt
         )SELECT 
            dzalstus,
            '",g_gen_prog,"' dzal001,
            dzal002,
            '",g_design_point_ver,"' dzal003,
            '",ms_dgenv,"' dzal004,
            dzal005,
            dzal006,
            dzal007,
            '",l_user,"' dzalownid,'",l_dept,"' dzalowndp,'",l_user,"' dzalcrtid,'",l_dept,"' dzalcrtdp,'",l_date USING "yyyy/mm/dd","' dzalcrtdt
            FROM dzal_t
            INNER JOIN dzaa_t ON dzaa001=dzal001 AND dzaa003=dzal002 AND dzaa004=dzal003 AND dzaa006=dzal004
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='9' AND dzaastus='Y'"

      PREPARE insert_data_to_dzal_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzal_t"
      EXECUTE insert_data_to_dzal_t 

      
      ######-- dzff_t-- sql參考 sadzp030_tsd_get_dzff_sql(g_code, g_ver) 複製dzff_t(樹狀結構屬性設定檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzff_t(
         dzffstus,
         dzff001,
         dzff002,
         dzff003,
         dzff004,
         dzff005,
         dzff006,
         dzff007,
         dzff008, 
         dzffownid,dzffowndp,dzffcrtid,dzffcrtdp,dzffcrtdt
         )SELECT 
            dzffstus,'",g_gen_prog,"' dzff001,'",g_design_point_ver,"' dzff002,dzff003,dzff004,dzff005,dzff006,dzff007,'",ms_dgenv,"' dzff008, 
            '",l_user,"' dzffownid,'",l_dept,"' dzffowndp,'",l_user,"' dzffcrtid,'",l_dept,"' dzffcrtdp,'",l_date USING "yyyy/mm/dd","' dzffcrtdt
            FROM dzaa_t
            INNER JOIN dzff_t ON dzff001=dzaa001 AND dzff002=dzaa004 AND dzffstus='Y'
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TREE' AND dzaa005='5' AND dzaastus='Y'
            ORDER BY dzff003,dzff004"

      PREPARE insert_data_to_dzff_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzff_t"
      EXECUTE insert_data_to_dzff_t 


      ######-- dzfr_t -- 自訂sql 複製dzfr_t(畫面結構設計內容檔)的SQL.
      #LET ls_sql =
      #"INSERT INTO dzfr_t(
         #dzfr001,
         #dzfr002,
         #dzfr003,
         #dzfr004,
         #dzfr005,
         #dzfr006,
         #dzfr007,
         #dzfr008,
         #dzfr009,
         #dzfr010,
         #dzfr011,
         #dzfr012
         #)SELECT DISTINCT
            #'",g_design_point_ver,"' dzfr001,
            #'",g_gen_prog,"' dzfr002,
            #dzfr003,
            #dzfr004,
            #dzfr005,
            #dzfr006,
            #dzfr007,
            #dzfr008,
            #dzfr009,
            #dzfr010,
            #dzfr011,
            #dzfr012
            #FROM dzaa_t 
            #INNER JOIN dzfr_t ON dzaa001=dzfr002 AND dzaa004=dzfr001
            #WHERE dzaa001 = '",g_copy_source,"' AND dzaa002 ='",g_source_spec_ver,"'"
         #
      #PREPARE insert_data_to_dzfr_t FROM ls_sql
      #LET ls_err = "error:insert_data_to_dzfr_t"
      #EXECUTE insert_data_to_dzfr_t 

      
      ######-- dzfq_t -- 自訂sql 複製dzfq_t(畫面結構設計主檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzfq_t(
         dzfqstus,
         dzfq001,
         dzfq002,
         dzfq003,
         dzfq004,
         dzfq005,
         dzfq006,
         dzfq007,
         dzfq008,
         dzfq009,
         dzfq010,
         dzfq011,
         dzfq012,
         dzfq013,
         dzfq014,
         dzfq015,
         dzfq016,
         dzfqownid,dzfqowndp,dzfqcrtid,dzfqcrtdp,dzfqcrtdt
         )SELECT DISTINCT
            dzfqstus,
            dzfq001,
            dzfq002,
            '",g_design_point_ver,"' dzfq003,
            '",g_gen_prog,"' dzfq004,
            dzfq005,
            dzfq006,
            dzfq007,
            dzfq008,
            dzfq009,
            dzfq010,
            dzfq011,
            dzfq012,
            dzfq013,
            dzfq014,
            dzfq015,
            dzfq016, 
            '",l_user,"' dzfqownid,'",l_dept,"' dzfqowndp,'",l_user,"' dzfqcrtid,'",l_dept,"' dzfqcrtdp,'",l_date USING "yyyy/mm/dd","' dzfqcrtdt
            FROM dzaa_t 
            INNER JOIN dzfq_t ON dzaa001=dzfq004 AND dzaa004=dzfq003
            WHERE dzaa001 = '",g_copy_source,"' AND dzaa002 ='",g_source_spec_ver,"'"
         
      PREPARE insert_data_to_dzfq_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzfq_t"
      EXECUTE insert_data_to_dzfq_t 

      
      ######-- gzzd_t -- 自訂sql 複製gzzd_t(畫面元件多語言記錄檔)的SQL.
      LET ls_sql =
      "INSERT INTO gzzd_t(
         gzzdstus,gzzd001,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006, 
         gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt
         )SELECT 
            gzzdstus,'",g_gen_prog,"' gzzd001,gzzd002,gzzd003, gzzd004,gzzd005,gzzd006,
            '",l_user,"' gzzdownid,'",l_dept,"' gzzdowndp,'",l_user,"' gzzdcrtid,'",l_dept,"' gzzdcrtdp,'",l_date USING "yyyy/mm/dd","' gzzdcrtdt
            FROM gzzd_t
            WHERE gzzd001 = '",g_copy_source,"' AND gzzd004 = '",ms_dgenv,"'"
         
      PREPARE insert_data_to_gzzd_t FROM ls_sql
      LET ls_err = "error:insert_data_to_gzzd_t"
      EXECUTE insert_data_to_gzzd_t 

         #
      ######-- gzzq_t -- 自訂sql 複製gzzq_t(ACTION多語言對照檔)的SQL.
      #LET ls_sql =
      #"INSERT INTO gzzq_t(
         #gzzq001,gzzq002,gzzq003,gzzq004,gzzq005,gzzq006
         #)SELECT 
            #'",g_gen_prog,"' gzzq001,gzzq002,gzzq003,gzzq004,gzzq005,'",ms_dgenv,"' gzzq006
            #FROM gzzq_t
            #WHERE gzzq001 = '",g_copy_source,"'"
         #
      #PREPARE insert_data_to_gzzq_t FROM ls_sql
      #LET ls_err = "error:insert_data_to_gzzq_t"
      #EXECUTE insert_data_to_gzzq_t 


      #####-- gzzd_t -- 自訂sql 複製gzzd_t(畫面元件多語言記錄檔)的SQL.
      #LET ls_sql =
      #"SELECT gzzd003,gzzd003  
            #FROM gzzd_t
            #WHERE gzzd001 = '",g_copy_source,"' AND gzzdstus='Y'"
#
      #LET ls_err = "error:insert_data_to_gzzd_t"
      #CALL adzp270_insert_gzzd_t(ls_sql)
 
         
      #####-- gzzq_t -- 自訂sql 複製gzzq_t(ACTION多語言對照檔)的SQL.
      LET ls_sql =
      "SELECT gzzq002 
            FROM gzzq_t
            WHERE gzzq001 = '",g_copy_source,"'"

      LET ls_err = "error:insert_data_to_gzzq_t"
      CALL adzp270_insert_gzzq_t(ls_sql)

      #####-- gzzp_t -- 自訂sql 複製gzzp_t(階層式選單設定檔)的SQL.
      LET ls_sql =
      "INSERT INTO gzzp_t(
         gzzpstus,
         gzzp001,
         gzzp002,
         gzzp003,
         gzzp004,
         gzzp005, 
         gzzpownid,gzzpowndp,gzzpcrtid,gzzpcrtdp,gzzpcrtdt
         )SELECT 
            gzzpstus,
            '",g_gen_prog,"' gzzp001,
            gzzp002,
            gzzp003,
            gzzp004, 
            gzzp005,
            '",l_user,"' gzzpownid,'",l_dept,"' gzzpowndp,'",l_user,"' gzzpcrtid,'",l_dept,"' gzzpcrtdp,'",l_date USING "yyyy/mm/dd","' gzzpcrtdt
            FROM gzzp_t
            WHERE gzzp001='",g_copy_source,"' AND gzzpstus='Y'"
         
      PREPARE insert_data_to_gzzp_t FROM ls_sql
      LET ls_err = "error:insert_data_to_gzzp_t"
      EXECUTE insert_data_to_gzzp_t
      

      ######-- dzba_t -- 自訂sql 複製dzba_t(程式與內容版本對應表)的SQL.
      LET ls_sql =
      "INSERT INTO dzba_t(
         dzbastus,
         dzba001,
         dzba002,
         dzba003,
         dzba004,
         dzba005,
         dzba006,
         dzba007,
         dzba008,
         dzba009,
         dzbaownid,dzbaowndp,dzbacrtid,dzbacrtdp,dzbacrtdt
         )SELECT 
            dzbastus,
            '",g_gen_prog,"' dzba001,
            '",g_gen_spec_ver,"' dzba002,
            REPLACE(dzba003,'",g_copy_source,"','",g_gen_prog,"') dzba003,
            '",g_design_point_ver,"' dzba004,
            '",ms_dgenv,"' dzba005,
            dzba006,
            dzba007,
            dzba008,
            dzba009,
            '",l_user,"' dzbaownid,'",l_dept,"' dzbaowndp,'",l_user,"' dzbacrtid,'",l_dept,"' dzbacrtdp,'",l_date USING "yyyy/mm/dd","' dzbacrtdt
            FROM dzba_t
            WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzbastus='Y'"
         
      PREPARE insert_data_to_dzba_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzba_t"
      EXECUTE insert_data_to_dzba_t 


      ######-- dzbb_t -- 自訂sql 複製dzbb_t(程式設計點設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzbb_t(
         dzbbstus,
         dzbb001,
         dzbb002,
         dzbb003,
         dzbb004,
         dzbb098,
         dzbb005,
         dzbb006, 
         dzbbownid,dzbbowndp,dzbbcrtid,dzbbcrtdp,dzbbcrtdt
         )SELECT 
            dzbbstus,
            '",g_gen_prog,"' dzbb001,
            REPLACE(dzbb002,'",g_copy_source,"','",g_gen_prog,"') dzbb002,
            '",g_design_point_ver,"' dzbb003,
            '",ms_dgenv,"' dzbb004,
            ",adzp270_gen_replace_sql_str("dzbb098","dzbb_t")," dzbb098,
            dzbb005,
            dzbb006,
            '",l_user,"' dzbbownid,'",l_dept,"' dzbbowndp,'",l_user,"' dzbbcrtid,'",l_dept,"' dzbbcrtdp,'",l_date USING "yyyy/mm/dd","' dzbbcrtdt
            FROM dzbb_t
            INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzbastus = 'Y' AND dzba005 = dzbb004 
            WHERE dzbb001='",g_copy_source,"' AND dzbb003='",g_design_point_ver,"' AND dzba002='",g_source_code_ver,"'"
         
      PREPARE insert_data_to_dzbb_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbb_t"
      EXECUTE insert_data_to_dzbb_t 
  display 'update dzbb098 sql=',ls_sql #madey

      ######-- dzam_t -- 自訂sql 複製dzam_t(規格畫面元件排除設定)的SQL
      LET ls_sql =
      "INSERT INTO dzam_t(
         dzamstus,
         dzam001,
         dzam002,
         dzam003,
         dzam004,
         dzam005,
         dzamownid,dzamowndp,dzamcrtid,dzamcrtdp,dzamcrtdt
         )SELECT
            dzamstus,
            '",g_gen_prog,"' dzam001,
            dzam002,
            dzam003,
            dzam004,
            dzam005,
            '",l_user,"' dzamownid,'",l_dept,"' dzamowndp,'",l_user,"' dzamcrtid,'",l_dept,"' dzamcrtdp,'",l_date USING "yyyy/mm/dd","' dzamcrtdt 
            FROM dzam_t
            WHERE dzam001 = '",g_copy_source,"' "

      PREPARE insert_data_to_dzam_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzam_t"
      EXECUTE insert_data_to_dzam_t 

      ######-- dzbc_t -- 自訂sql 複製dzbc_t(代碼與內容版本對應表)的SQL
      LET ls_sql =
      "INSERT INTO dzbc_t(
         dzbcstus,
         dzbc001,
         dzbc002,
         dzbc003,
         dzbc004,
         dzbc005,
         dzbc006
         )SELECT
            dzbcstus,
            '",g_gen_prog,"' dzbc001,
            '",g_gen_spec_ver,"' dzbc002,
            REPLACE(dzbc003,'",g_copy_source,"','",g_gen_prog,"') dzbc003,
            dzbc004,
            dzbc005,
            dzbc006
            FROM dzbc_t
            WHERE dzbc001 = '",g_copy_source,"'"

      PREPARE insert_data_to_dzbc_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbc_t"
      EXECUTE insert_data_to_dzbc_t

      ######-- dzbd_t -- 自訂sql 複製dzbd_t(代碼設計點設計表)的SQL
      LET ls_sql =
      "INSERT INTO dzbd_t(
         dzbdstus,
         dzbd001,
         dzbd002,
         dzbd003,
         dzbd004,
         dzbd098
         )SELECT
            dzbdstus,
            '",g_gen_prog,"' dzbd001,
            REPLACE(dzbd002,'",g_copy_source,"','",g_gen_prog,"') dzbd002,
            dzbd003,
            dzbd004,
            ",adzp270_gen_replace_sql_str("dzbd098","dzbd_t")," dzbd098
            FROM dzbd_t
            INNER JOIN dzbc_t ON dzbc001 = dzbd001 AND dzbc003 = dzbd002 AND dzbc004 = dzbd003 AND dzbc005 = dzbd004
            WHERE dzbd001 = '",g_copy_source,"'"

      PREPARE insert_data_to_dzbd_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbd_t"
      EXECUTE insert_data_to_dzbd_t

      ######-- dzax_t -- 自訂sql 複製dzax_t(程式設計基本設定表)的SQL
      LET ls_sql =
      "INSERT INTO dzax_t(
         dzaxstus,
         dzax001,
         dzax002,
         dzax003,
         dzax004
         )SELECT
            dzaxstus,
            '",g_gen_prog,"' dzax001,
            dzax002,
            dzax003,
            'Y' dzax004
            FROM dzax_t
            WHERE dzax001 = '",g_copy_source,"'"

      PREPARE insert_data_to_dzax_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzax_t"
      EXECUTE insert_data_to_dzax_t

   CATCH
      IF SQLCA.sqlcode THEN
         DISPLAY "############### SQL ERROR ###############"
         DISPLAY "sql = ",ls_sql
         CALL cl_err(ls_err||" sql="||ls_sql,SQLCA.sqlcode,1)
         LET lb_flag = FALSE
         #RETURN FALSE
      END IF
   END TRY
    
   
   IF lb_flag THEN
      COMMIT WORK
      FREE insert_data_to_dzaa_t
      FREE insert_data_to_dzab_t
      FREE insert_data_to_dzac_t
      FREE insert_data_to_dzak_t
      FREE insert_data_to_dzad_t
      #FREE insert_data_to_dzae_t
      FREE insert_data_to_dzag_t
      FREE insert_data_to_dzfs_t
      FREE insert_data_to_dzai_t
      FREE insert_data_to_dzaj_t
      FREE insert_data_to_dzal_t
      FREE insert_data_to_dzff_t
      #FREE insert_data_to_dzfr_t
      FREE insert_data_to_dzfq_t
      FREE insert_data_to_gzzp_t
      FREE insert_data_to_dzba_t
      FREE insert_data_to_dzbb_t
      FREE insert_data_to_dzam_t
      FREE insert_data_to_dzbc_t
      FREE insert_data_to_dzbd_t
      FREE insert_data_to_dzax_t
   ELSE
      ROLLBACK WORK
   END IF
 
   RETURN lb_flag
END FUNCTION

#+ 找出沒有對應關係的表格欄位
PRIVATE FUNCTION adzp270_select_excluded_column()
   DEFINE  l_i            LIKE type_t.num5,
           l_ac           LIKE type_t.num5,
           l_new_prefix   STRING,
           l_old_prefix   STRING,
           l_str_buff     base.StringBuffer

   CALL ga_excluded_col.clear()
   
   FOR l_i = 1 TO ga_dzeb_stored.getLength()

      #若對應的新欄位值為空表示,欲轉換的舊欄位字串沒有對應到要轉換的新欄位字串,
      IF cl_null(ga_dzeb_stored[l_i].new_col_id) THEN

      CALL ga_excluded_col.appendElement()
         LET l_ac = ga_excluded_col.getLength()
         LET ga_excluded_col[l_ac].col_id = ga_dzeb_stored[l_i].old_col_id
         LET ga_excluded_col[l_ac].table_id = ga_dzeb_stored[l_i].old_table_id
         LET ga_excluded_col[l_ac].col_name = ga_dzeb_stored[l_i].old_col_name

         #暫存欲轉換的表格代號
         LET ga_excluded_col[l_ac].table_id_tmp = ga_dzeb_stored[l_i].new_table_id
         
         #去除新表格表格代號的'_t',產生新表格的前綴
         LET l_new_prefix = ga_excluded_col[l_ac].table_id_tmp
         LET l_new_prefix = l_new_prefix.trim()
         LET l_new_prefix = l_new_prefix.subString(1,l_new_prefix.getLength()-2)

         #去除舊表格代號的'_t',產生舊表格的前綴
         LET l_old_prefix = ga_excluded_col[l_ac].table_id
         LET l_old_prefix = l_old_prefix.trim()
         LET l_old_prefix = l_old_prefix.subString(1,l_old_prefix.getLength()-2)

         LET l_str_buff = base.StringBuffer.create()
         CALL l_str_buff.append(ga_excluded_col[l_ac].col_id )
         CALL l_str_buff.replace(l_old_prefix,l_new_prefix,0)

         #產生要替換回來的欄位字串（包含欲轉換的新表格代號的前綴）
         LET ga_excluded_col[l_ac].col_id_tmp = l_str_buff.toString()
         
      END IF
   END FOR
END FUNCTION

#+ 產生排除欄位的where條件
PRIVATE FUNCTION adzp270_gen_excluded_where_condition(p_column_id)
   DEFINE p_column_id     LIKE dzeb_t.dzeb002,
          l_i             LIKE type_t.num5,
          l_exculded_wc   STRING

   #CALL ga_excluded_col.clear()

   IF ga_excluded_col.getLength() = 0 THEN
      LET l_exculded_wc = " AND 1=1"
      RETURN l_exculded_wc
   END IF

   #select * from dzaa_t where dzaa001 = 'aiti003' 
   #AND NOT dzaa003 LIKE '%bgad001%'
   #AND NOT dzaa003 LIKE '%bgad002
   
   #LET l_exculded_wc = " AND NOT ",p_column_id," LIKE "
   LET l_exculded_wc = ASCII 10
   
   FOR l_i = 1 TO ga_excluded_col.getLength()
      IF ga_excluded_col[l_i].col_id IS NULL OR 
         ga_excluded_col[l_i].col_id_tmp IS NULL OR 
         ga_excluded_col[l_i].table_id IS NULL OR 
         ga_excluded_col[l_i].table_id_tmp IS NULL THEN
      END IF
      
      LET l_exculded_wc = l_exculded_wc," AND NOT ",p_column_id," LIKE '%",ga_excluded_col[l_i].col_id CLIPPED,"%' ",ASCII 10
   END FOR
          
   RETURN l_exculded_wc
END FUNCTION

#+ 篩選會影響到的開窗和校驗帶值識別值
PRIVATE FUNCTION adzp270_filter_q_id_and_v_id()
   DEFINE l_sql STRING,
          l_i   LIKE type_t.num5,
          l_j   LIKE type_t.num5,
          l_origin STRING,
          l_replace STRING,
          l_str    STRING

   
   CALL ga_dzca.clear()
   LET l_i = 1
   LET l_j = 1
   
   FOR l_i = 1 TO ga_dzag.getLength()

      IF ga_dzag[l_i].new_table_id IS NULL OR ga_dzag[l_i].old_table_id IS NULL THEN
         CONTINUE FOR
      END IF

      LET l_str = ga_dzag[l_i].old_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzca001 FROM dzca_t WHERE dzca001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzca001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzca001_pre2 FROM l_sql
      DECLARE dzca001_curs2 CURSOR FOR dzca001_pre2
      FOREACH dzca001_curs2 INTO ga_dzca[l_j].origin 
         LET l_replace = ga_dzca[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzca[l_j].replace = l_replace
         #DISPLAY ga_dzca[l_j].origin,":",ga_dzca[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      
      LET l_str = ga_dzag[l_i].new_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzca001 FROM dzca_t WHERE dzca001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzca001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzca001_pre3 FROM l_sql
      DECLARE dzca001_curs3 CURSOR FOR dzca001_pre2
      FOREACH dzca001_curs3 INTO ga_dzca[l_j].origin 
         LET l_replace = ga_dzca[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzca[l_j].replace = l_replace
         #DISPLAY ga_dzca[l_j].origin,":",ga_dzca[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      FREE dzca001_pre2
      FREE dzca001_curs2
      FREE dzca001_pre3
      FREE dzca001_curs3
   END FOR

   CALL ga_dzca.deleteElement(l_j)
   LET l_j = l_j -1


   CALL ga_dzcd.clear()
   LET l_i = 1
   LET l_j = 1
   
   FOR l_i = 1 TO ga_dzag.getLength()

      IF ga_dzag[l_i].new_table_id IS NULL OR ga_dzag[l_i].old_table_id IS NULL THEN
         CONTINUE FOR
      END IF

      LET l_str = ga_dzag[l_i].old_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzcd001 FROM dzcd_t WHERE dzcd001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzcd001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzcd001_pre2 FROM l_sql
      DECLARE dzcd001_curs2 CURSOR FOR dzcd001_pre2
      FOREACH dzcd001_curs2 INTO ga_dzcd[l_j].origin 
         LET l_replace = ga_dzcd[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzcd[l_j].replace = l_replace
         #DISPLAY ga_dzcd[l_j].origin,":",ga_dzcd[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      
      LET l_str = ga_dzag[l_i].new_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzcd001 FROM dzcd_t WHERE dzcd001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzcd001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzcd001_pre3 FROM l_sql
      DECLARE dzcd001_curs3 CURSOR FOR dzcd001_pre2
      FOREACH dzcd001_curs3 INTO ga_dzcd[l_j].origin 
         LET l_replace = ga_dzcd[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzcd[l_j].replace = l_replace
         #DISPLAY ga_dzcd[l_j].origin,":",ga_dzcd[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      FREE dzcd001_pre2
      FREE dzcd001_curs2
      FREE dzcd001_pre3
      FREE dzcd001_curs3
   END FOR

   CALL ga_dzcd.deleteElement(l_j)
   LET l_j = l_j -1
   
   
END FUNCTION

#PRIVATE FUNCTION adzp270_select_q_id_and_v_id()
   #DEFINE l_sql STRING,
          #l_i   LIKE type_t.num5,
          #l_origin STRING,
          #l_replace STRING
          #
   #LET l_sql = "SELECT dzca001 FROM dzca_t"
   #PREPARE dzca001_pre FROM l_sql
   #DECLARE dzca001_curs CURSOR FOR dzca001_pre
#
   #CALL ga_dzca.clear()
   #LET l_i = 1
   #
   #FOREACH dzca001_curs INTO ga_dzca[l_i].origin
      #LET l_replace = ga_dzca[l_i].origin
      #LET l_replace = l_replace.trim()
#
      #LET l_replace = l_replace.subString(1,4),"#",l_replace.subString(5,l_replace.getLength())
      #LET ga_dzca[l_i].replace = l_replace
      #DISPLAY ga_dzca[l_i].origin,":",ga_dzca[l_i].replace
      #
      #LET l_i = l_i + 1
   #END FOREACH
#
   #CALL ga_dzca.deleteElement(l_i)
#
   #FREE dzca001_pre
   #FREE dzca001_curs
#
   #LET l_sql = "SELECT dzcd001 FROM dzcd_t"
   #PREPARE dzcd001_pre FROM l_sql
   #DECLARE dzcd001_curs CURSOR FOR dzcd001_pre
#
   #CALL ga_dzcd.clear()
   #LET l_i = 1
   #
   #FOREACH dzcd001_curs INTO ga_dzcd[l_i].origin
      #LET l_replace = ga_dzcd[l_i].origin
      #LET l_replace = l_replace.trim()
#
      #LET l_replace = l_replace.subString(1,4),"#",l_replace.subString(5,l_replace.getLength())
      #LET ga_dzcd[l_i].replace = l_replace
      #DISPLAY ga_dzcd[l_i].origin,":",ga_dzcd[l_i].replace
      #
      #LET l_i = l_i + 1
   #END FOREACH
#
   #CALL ga_dzcd.deleteElement(l_i)
#
   #FREE dzcd001_pre
   #FREE dzcd001_curs
   #
#END FUNCTION

#+ 置換對應的表格和欄位名稱
PRIVATE FUNCTION adzp270_gen_replace_sql_str(p_col_id,p_table_id)
   DEFINE p_col_id       STRING,
          p_table_id     STRING,
          l_return_str   STRING,
          l_i            LIKE type_t.num5,
          l_old_str      STRING,
          l_new_str      STRING,
          l_buf          base.StringBuffer

   LET l_buf = base.StringBuffer.create()

   #使用表格欄位轉換時的取代方式
   IF g_use_table_replace = "Y" THEN
   
      #不複製appint的內容
      IF p_col_id = "dzbb098" AND g_not_copy_appoint = "Y" THEN
         RETURN "''"
      END IF

      LET l_return_str = p_col_id

      IF p_col_id <> "dzbb098" AND p_col_id <> "dzbd098" THEN
         #產生轉換欄位代號的SQL片段
         FOR l_i = 1 TO ga_dzeb_stored.getLength()
            IF ga_dzeb_stored[l_i].new_col_id IS NULL OR ga_dzeb_stored[l_i].old_col_id IS NULL THEN
               CONTINUE FOR
            END IF
         
            #原本的欄位代號
            LET l_old_str = ga_dzeb_stored[l_i].old_col_id
            LET l_old_str = l_old_str.trim()
            
            #要轉換的欄位代號
            LET l_new_str = ga_dzeb_stored[l_i].new_col_id
            LET l_new_str = l_new_str.trim()

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         END FOR

         #產生轉換表格代號的SQL片段
         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR 
               ga_dzag[l_i].old_table_id IS NULL THEN
                  CONTINUE FOR
            END IF
            
            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
            

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         END FOR
      END IF

      #轉換程式代號的SQL片段
      IF p_col_id = "dzab099" OR 
         p_col_id = "dzac099" OR 
         p_col_id = "dzad099" OR
         p_col_id = "dzba003" OR
         p_col_id = "dzbb002"     THEN
         #來源程式代號
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         #產生程式代號
         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
      END IF

      IF p_col_id = "dzbb098" OR p_col_id = "dzbd098"  THEN
         #轉換程式代號的SQL片段
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         #排除會影響到的開窗識別碼
         FOR l_i = 1 TO ga_dzca.getLength()

            LET l_old_str = ga_dzca[l_i].origin
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzca[l_i].replace
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         END FOR

         #排除會影響到的校驗帶值識別碼
         FOR l_i = 1 TO ga_dzcd.getLength()

            LET l_old_str = ga_dzcd[l_i].origin
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzcd[l_i].replace
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         END FOR
         
         #產生轉換欄位代號的SQL片段
         FOR l_i = 1 TO ga_dzeb_stored.getLength()
            IF ga_dzeb_stored[l_i].new_col_id IS NULL OR ga_dzeb_stored[l_i].old_col_id IS NULL  THEN
               CONTINUE FOR
            END IF


            #原本的欄位代號
            LET l_old_str = ga_dzeb_stored[l_i].old_col_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str
            
            #要轉換的欄位代號
            LET l_new_str = ga_dzeb_stored[l_i].new_col_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         END FOR

         #產生轉換表格代號的SQL片段
         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR 
               ga_dzag[l_i].old_table_id IS NULL THEN
                  CONTINUE FOR
            END IF

            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            
            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
            LET l_old_str = "_",l_old_str

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)
            LET l_new_str = "_",l_new_str

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
            LET l_old_str = l_old_str,"_"

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)
            LET l_new_str = l_new_str,"_"

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         END FOR
      
         #產生轉換表格代號g_前綴的SQL片段
         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR 
               ga_dzag[l_i].old_table_id IS NULL THEN
                  CONTINUE FOR
            END IF
            
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = "g_",l_old_str.subString(1,l_old_str.getLength()-2)
            
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = "g_",l_new_str.subString(1,l_new_str.getLength()-2)

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         END FOR    
      
         #還原被錯誤取代的字串,比如：imaa_t.imba001 還原成 imba_t.imba001
         FOR l_i = 1 TO ga_excluded_col.getLength()
            IF ga_excluded_col[l_i].col_id IS NULL OR 
               ga_excluded_col[l_i].col_id_tmp IS NULL OR 
               ga_excluded_col[l_i].table_id IS NULL OR 
               ga_excluded_col[l_i].table_id_tmp IS NULL THEN
            END IF
         
            LET l_old_str = ga_excluded_col[l_i].table_id_tmp CLIPPED ,".",ga_excluded_col[l_i].col_id CLIPPED,""
            LET l_old_str = l_old_str.trim()

            LET l_new_str = ga_excluded_col[l_i].table_id CLIPPED ,".",ga_excluded_col[l_i].col_id CLIPPED,""
            LET l_new_str = l_new_str.trim()

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         END FOR

         #恢復會影響到的開窗識別碼
         FOR l_i = 1 TO ga_dzca.getLength()

            LET l_old_str = ga_dzca[l_i].replace
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzca[l_i].origin
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         END FOR

         #恢復會影響到的校驗帶值識別碼
         FOR l_i = 1 TO ga_dzcd.getLength()

            LET l_old_str = ga_dzcd[l_i].replace
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzcd[l_i].origin
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         END FOR


         #使用當前的子元件/子畫面/子程式
         IF g_use_current_sub_prog = "Y" THEN
            FOR l_i = 1 TO ga_sub_prog.getLength()
               CALL l_buf.clear()
               CALL l_buf.append(ga_sub_prog[l_i].sub_prog_id)
               CALL l_buf.replace(g_copy_source,g_gen_prog,0)
               LET ga_sub_prog[l_i].sub_prog_tmp_id = l_buf.toString()
               LET l_old_str = l_buf.toString()
               LET l_new_str = ga_sub_prog[l_i].sub_prog_id
              #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')" #mark by madey 20140312
              #add by madey 20140312 --start--
              #還原子畫面時的條件要更精準,以免因為子畫面id與functoin name重覆時,整個都被還原 add by madey --start--
               CASE ga_sub_prog[l_i].sub_prog_type
                  WHEN 'F' #子畫面
                     LET l_return_str = "REPLACE (",l_return_str,",'w_",l_old_str,"','w_",l_new_str,"')"
                     LET l_return_str = "REPLACE (",l_return_str,",'""",l_old_str,"""','""",l_new_str,"""')"
                     LET l_return_str = "REPLACE (",l_return_str,",'''",l_old_str,"''','''",l_new_str,"''')"
                  OTHERWISE 
                     LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
               END CASE
              #add by madey 20140312 --end --
            END FOR
         END IF
         
      END IF
   ELSE
      #不使用表格轉換的appoint的處理
      LET l_return_str = p_col_id
      #生轉換程式代號的SQL片段
      IF p_col_id = "dzbb098" OR  p_col_id = "dzbd098"  THEN
         #來源程式代號
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         #產生程式代號
         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"

         #使用當前的子元件/子畫面/子程式
         IF g_use_current_sub_prog = "Y" THEN

            FOR l_i = 1 TO ga_sub_prog.getLength()
               CALL l_buf.clear()
               CALL l_buf.append(ga_sub_prog[l_i].sub_prog_id)
               CALL l_buf.replace(g_copy_source,g_gen_prog,0)
               LET ga_sub_prog[l_i].sub_prog_tmp_id = l_buf.toString()
               LET l_old_str = l_buf.toString()
               LET l_new_str = ga_sub_prog[l_i].sub_prog_id
              #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')" #mark by madey 20140312
              #add by madey 20140312 --start--
              #還原子畫面時的條件要更精準,以免因為子畫面id與functoin name重覆時,整個都被還原 add by madey --start--
               CASE ga_sub_prog[l_i].sub_prog_type
                  WHEN 'F' #子畫面
                     LET l_return_str = "REPLACE (",l_return_str,",'w_",l_old_str,"','w_",l_new_str,"')"
                     LET l_return_str = "REPLACE (",l_return_str,",'""",l_old_str,"""','""",l_new_str,"""')"
                     LET l_return_str = "REPLACE (",l_return_str,",'''",l_old_str,"''','''",l_new_str,"''')"
                  OTHERWISE 
                     LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
               END CASE
              #add by madey 20140312 --end --
            END FOR
         END IF
      END IF
   END IF
   
   RETURN l_return_str
END FUNCTION


#+ 複製資料庫的設計資料支援表格轉換
PRIVATE FUNCTION adzp270_copy_database_data_for_table_exchange()
   DEFINE ls_sql   STRING,
          l_user   LIKE dzaa_t.dzaaownid,
          l_dept   LIKE dzaa_t.dzaaowndp,
          l_date   LIKE dzaa_t.dzaacrtdt,
          ls_err   STRING,
          ln_cnt   LIKE type_t.num5,
          lb_flag  BOOLEAN #檢查transation的過程式否有錯誤
          
   LET l_user        = g_user
   LET l_dept        = g_dept
   LET l_date        = cl_get_current()
   
   LET g_gen_prog    = g_gen_prog CLIPPED
   LET g_gen_spec_ver    = g_gen_spec_ver CLIPPED
   LET g_design_point_ver  = g_design_point_ver CLIPPED
   LET g_copy_source = g_copy_source CLIPPED
   LET g_source_ver  = g_source_ver CLIPPED
   
   LET lb_flag = TRUE
   BEGIN WORK

   TRY
      ######-- dzaa_t-- 自訂sql 複製dzaa_t(規格與內容版本對應表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzaa_t(
         dzaastus,
         dzaa001,
         dzaa002,
         dzaa003,
         dzaa004,
         dzaa005,
         dzaa006,
         dzaa007,
         dzaa008,
         dzaaownid,dzaaowndp,dzaacrtid,dzaacrtdp,dzaacrtdt
         )SELECT
            dzaastus,
            '",g_gen_prog,"' dzaa001,
            '",g_gen_spec_ver,"' dzaa002,
            ",adzp270_gen_replace_sql_str("dzaa003","dzaa_t")," dzaa003,
            '",g_design_point_ver,"' dzaa004,
            dzaa005,
            '",ms_dgenv,"' dzaa006,
            dzaa007,
            dzaa008,
            '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt 
            FROM dzaa_t
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaastus='Y' ",g_dzaa_t_exculded_wc,"
            ORDER BY dzaa005,dzaa003"

      #DISPLAY "insert_data_to_dzaa_t_2 = ",ls_sql
            
      PREPARE insert_data_to_dzaa_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzaa_t_2"
      EXECUTE insert_data_to_dzaa_t_2

      
      ######-- dzab_t-- sql參考 sadzp030_tsd_get_dzab_sql(g_code, g_ver) 複製dzab_t(規格整體設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzab_t(
         dzabstus,
         dzab001,
         dzab002,
         dzab099,         
         dzab003,
         dzab004,
         dzab005,
         dzab006,
         dzabownid,dzabowndp,dzabcrtid,dzabcrtdp,dzabcrtdt
         )SELECT 
            dzabstus,
            '",g_gen_prog,"' dzab001,
            '",g_design_point_ver,"' dzab002,
            ",adzp270_gen_replace_sql_str("dzab099","dzab_t")," dzab099,
            '",ms_dgenv,"' dzab003,
            dzab004,
            dzab005,
            dzab006,
            '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt 
            FROM dzab_t
            INNER JOIN dzaa_t ON dzaa001=dzab001 AND dzaa003=dzab004 AND dzaa004=dzab002 AND dzaa006 = dzab003
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='3' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzab_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzab_t_2"
      EXECUTE insert_data_to_dzab_t_2 


      ######-- dzac_t-- sql參考 sadzp030_tsd_get_dzac_sql(g_code, g_ver) 複製dzac_t(欄位規格設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzac_t(
         dzacstus,
         dzac001,
         dzac002,
         dzac003,
         dzac004,
         dzac005,
         dzac006,
         dzac007,
         dzac008,
         dzac009,
         dzac010,
         dzac011,
         dzac012,
         dzac013,
         dzac014,
         dzac015,
         dzac016,
         dzac017,
         dzac018,
         dzac019,
         dzac099,
         dzac020,
         dzac021, 
         dzacownid,dzacowndp,dzaccrtid,dzaccrtdp,dzaccrtdt
         )SELECT 
            dzacstus,
            '",g_gen_prog,"' dzac001,
            ",adzp270_gen_replace_sql_str("dzac002","dzac_t")," dzac002,
            ",adzp270_gen_replace_sql_str("dzac003","dzac_t")," dzac003,
            '",g_design_point_ver,"' dzac004,
            ",adzp270_gen_replace_sql_str("dzac005","dzac_t")," dzac005,
            dzac006,
            dzac007,
            dzac008,
            dzac009,
            dzac010,
            dzac011,
            '",ms_dgenv,"' dzac012,
            dzac013,
            dzac014,
            dzac015,
            dzac016,
            dzac017,
            dzac018,
            dzac019,
            ",adzp270_gen_replace_sql_str("dzac099","dzac_t")," dzac099,
            dzac020,
            dzac021, 
            '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt 
            FROM dzac_t
            INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzac_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzac_t_2"
      EXECUTE insert_data_to_dzac_t_2 

      
      ######-- dzak_t-- sql參考 sadzp030_tsd_get_dzak_sql(g_code, g_ver) 複製dzak_t(欄位助記碼設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzak_t(
         dzakstus,
         dzak001,
         dzak002,
         dzak003,
         dzak004,
         dzak005,
         dzak007,
         dzak008,
         dzak009,
         dzak010,
         dzak011,
         dzakownid,dzakowndp,dzakcrtid,dzakcrtdp,dzakcrtdt
         )SELECT 
            dzakstus,
            '",g_gen_prog,"' dzak001,
            ",adzp270_gen_replace_sql_str("dzak002","dzak_t")," dzak002,
            '",g_design_point_ver,"' dzak003,
            '",ms_dgenv,"' dzak004,
            dzak005,
            dzak007,
            dzak008,
            dzak009,
            dzak010,
            dzak011,
            '",l_user,"' dzakownid,'",l_dept,"' dzakowndp,'",l_user,"' dzakcrtid,'",l_dept,"' dzakcrtdp,'",l_date USING "yyyy/mm/dd","' dzakcrtdt
            FROM dzak_t
            INNER JOIN dzac_t ON dzac001=dzak001 AND dzac003=dzak002 AND dzac004=dzak003 AND dzac012=dzak004
            INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzak_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzak_t_2"
      EXECUTE insert_data_to_dzak_t_2 

      ######-- dzad_t-- sql參考 sadzp030_tsd_get_dzad_sql(g_code, g_ver) 複製dzad_t(Action規格設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzad_t(
         dzadstus,
         dzad001,
         dzad002,
         dzad003,
         dzad099,
         dzad005,
         dzad006,
         dzad007,
         dzadownid,dzadowndp,dzadcrtid,dzadcrtdp,dzadcrtdt
         )SELECT 
            dzadstus,
            '",g_gen_prog,"' dzad001,
            dzad002,
            '",g_design_point_ver,"' dzad003,
            ",adzp270_gen_replace_sql_str("dzad099","dzad_t")," dzad099,
            '",ms_dgenv,"' dzad005,
            dzad006,
            dzad007,
            '",l_user,"' dzadownid,'",l_dept,"' dzadowndp,'",l_user,"' dzadcrtid,'",l_dept,"' dzadcrtdp,'",l_date USING "yyyy/mm/dd","' dzadcrtdt
            FROM dzad_t 
            INNER JOIN dzaa_t ON dzaa001=dzad001 AND dzaa003=dzad002 AND dzaa004=dzad003 AND dzaa006=dzad005
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='2' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzad_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzad_t_2"
      EXECUTE insert_data_to_dzad_t_2 

      #
      ######-- dzah_t-- 自訂sql 複製dzah_t(Action觸發時機設計表)的SQL.
      #LET ls_sql = 
      #"INSERT INTO dzah_t(
         #dzahstus,
         #dzah001,
         #dzah002,
         #dzah003,
         #dzah004,
         #dzah005,
         #dzah006, 
         #dzahownid,dzahowndp,dzahcrtid,dzahcrtdp,dzahcrtdt
         #)SELECT 
            #dzahstus,
            #'",g_gen_prog,"' dzah001,
            #dzah002,'",g_design_point_ver,"' dzah003,'",ms_dgenv,"' dzah004,dzah005,dzah006, 
            #'",l_user,"' dzahownid,'",l_dept,"' dzahowndp,'",l_user,"' dzahcrtid,'",l_dept,"' dzahcrtdp,'",l_date USING "yyyy/mm/dd","' dzahcrtdt
            #FROM dzah_t
            #INNER JOIN dzad_t ON dzad001=dzah001 AND dzad002=dzah002 AND dzad003=dzah003 AND dzad005=dzah004 
            #WHERE dzad001 = '",g_copy_source,"' AND dzadstus='Y'"
      #
      #PREPARE insert_data_to_dzah_t_2 FROM ls_sql
      #LET ls_err = "error:insert_data_to_dzah_t_2"
      #EXECUTE insert_data_to_dzah_t_2 


      ######-- dzae_t--  sql參考 sadzp030_tsd_get_dzae_sql(p_code, p_ver) 複製dzae_t(設計器程式基本資料表)的SQL.
      #LET ls_sql =
      #"INSERT INTO dzae_t(
         #dzaestus,
         #dzae001,
         #dzae002,
         #dzae003,
         #dzae004, 
         #dzaeownid,dzaeowndp,dzaecrtid,dzaecrtdp,dzaecrtdt
         #)SELECT 
            #dzaestus,
            #'",g_gen_prog,"' dzae001,
            #'",g_gen_spec_ver,"' dzae002,
            #dzae003,
            #dzae004,
            #'",l_user,"' dzaeownid,'",l_dept,"' dzaeowndp,'",l_user,"' dzaecrtid,'",l_dept,"' dzaecrtdp,'",l_date USING "yyyy/mm/dd","' dzaecrtdt
            #FROM dzae_t
            #WHERE dzae001='",g_copy_source,"' AND dzae002='",g_source_code_ver,"'"
#
      #PREPARE insert_data_to_dzae_t_2 FROM ls_sql
      #LET ls_err = "error:insert_data_to_dzae_t_2"
      #EXECUTE insert_data_to_dzae_t_2 


      ######-- dzag_t--  sql參考 sadzp030_tsd_get_dzag_sql(p_code, p_ver) 複製dzag_t(規格Table設定表)的SQL.
      LET ls_sql =
      "INSERT INTO dzag_t(
         dzagstus,
         dzag001,
         dzag002,
         dzag003,
         dzag004,
         dzag005,
         dzag006,
         dzag007,
         dzag008,
         dzag009,
         dzag010,
         dzagownid,dzagowndp,dzagcrtid,dzagcrtdp,dzagcrtdt
         )SELECT 
            dzagstus,
            '",g_gen_prog,"' dzag001,
            ",adzp270_gen_replace_sql_str("dzag002","dzag_t")," dzag002,
            '",g_design_point_ver,"' dzag003,
            ",adzp270_gen_replace_sql_str("dzag004","dzag_t")," dzag004,
            dzag005,
            '",ms_dgenv,"' dzag006,
            dzag007,
            dzag008,
            dzag009,
            dzag010,
            '",l_user,"' dzagownid,'",l_dept,"' dzagowndp,'",l_user,"' dzagcrtid,'",l_dept,"' dzagcrtdp,'",l_date USING "yyyy/mm/dd","' dzagcrtdt
            FROM dzaa_t 
            INNER JOIN dzag_t ON dzag001=dzaa001 AND dzag003=dzaa004 AND dzagstus='Y'
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TABLE' AND dzaa005='4' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzag_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzag_t_2"
      EXECUTE insert_data_to_dzag_t_2 


      ######-- dzfs_t--  自訂sql 複製dzfs_t(程式Table與Screen Record對應檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzfs_t(
         dzfsstus,
         dzfs001,
         dzfs002,
         dzfs003,
         dzfs004,
         dzfs005,
         dzfs006,
         dzfs007,
         dzfs008,
         dzfs009,
         dzfs010,
         dzfsownid,dzfsowndp,dzfscrtid,dzfscrtdp,dzfscrtdt
         )SELECT 
            dzfsstus,
            dzfs001,
            '",g_gen_prog,"' dzfs002,
            dzfs003,
            ",adzp270_gen_replace_sql_str("dzfs004","dzfs_t")," dzfs004,
            '",ms_dgenv,"' dzfs005,
            dzfs006,
            dzfs007,
            dzfs008,
            dzfs009,
            dzfs010,
            '",l_user,"' dzfsownid,'",l_dept,"' dzfsowndp,'",l_user,"' dzfscrtid,'",l_dept,"' dzfscrtdp,'",l_date USING "yyyy/mm/dd","' dzfscrtdt
            FROM dzfs_t
            INNER JOIN dzag_t ON dzag001 = dzfs002 AND dzag002 = dzfs004 AND dzag003 = dzfs001 AND dzagstus='Y'
            WHERE  dzfs002 = '",g_copy_source,"' AND dzfsstus='Y' "

      PREPARE insert_data_to_dzfs_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzfs_t_2"
      EXECUTE insert_data_to_dzfs_t_2 


      ######-- dzai_t-- sql參考 sadzp030_tsd_get_dzai_sql(g_code, g_ver) 複製dzai_t(欄位參考設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzai_t(
         dzaistus,
         dzai001,
         dzai002,
         dzai003,
         dzai004,
         dzai005,
         dzai007,
         dzai008,
         dzai009,
         dzai010,
         dzai011, 
         dzaiownid,dzaiowndp,dzaicrtid,dzaicrtdp,dzaicrtdt
         )SELECT 
            dzaistus,
            '",g_gen_prog,"' dzai001,
            ",adzp270_gen_replace_sql_str("dzai002","dzai_t")," dzai002,
            '",g_design_point_ver,"' dzai003,
            '",ms_dgenv,"' dzai004,
            ",adzp270_gen_replace_sql_str("dzai005","dzai_t")," dzai005,
            ",adzp270_gen_replace_sql_str("dzai007","dzai_t")," dzai007,
            ",adzp270_gen_replace_sql_str("dzai008","dzai_t")," dzai008,
            ",adzp270_gen_replace_sql_str("dzai009","dzai_t")," dzai009,
            ",adzp270_gen_replace_sql_str("dzai010","dzai_t")," dzai010,
            ",adzp270_gen_replace_sql_str("dzai011","dzai_t")," dzai011,
            '",l_user,"' dzaiownid,'",l_dept,"' dzaiowndp,'",l_user,"' dzaicrtid,'",l_dept,"' dzaicrtdp,'",l_date USING "yyyy/mm/dd","' dzaicrtdt
            FROM dzai_t
            INNER JOIN dzaa_t ON dzaa001=dzai001 AND dzaa003=dzai002 AND dzaa004=dzai003 AND dzaa006=dzai004 
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='6' AND dzaastus='Y' ",g_dzaa_t_exculded_wc
         
      PREPARE insert_data_to_dzai_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzai_t_2"
      EXECUTE insert_data_to_dzai_t_2 


      ######-- dzaj_t-- sql參考 sadzp030_tsd_get_dzaj_sql(p_code, p_ver) 複製dzaj_t(欄位資料多語言設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzaj_t(
         dzajstus,
         dzaj001,
         dzaj002,
         dzaj003,
         dzaj004,
         dzaj005,
         dzaj007,
         dzaj008,
         dzaj009,
         dzaj010,
         dzaj011, 
         dzajownid,dzajowndp,dzajcrtid,dzajcrtdp,dzajcrtdt
         )SELECT 
            dzajstus,
            '",g_gen_prog,"' dzaj001,
            ",adzp270_gen_replace_sql_str("dzaj002","dzaj_t")," dzaj002,
            '",g_design_point_ver,"' dzaj003,
            '",ms_dgenv,"' dzaj004,
            ",adzp270_gen_replace_sql_str("dzaj005","dzaj_t")," dzaj005,
            ",adzp270_gen_replace_sql_str("dzaj007","dzaj_t")," dzaj007,
            ",adzp270_gen_replace_sql_str("dzaj008","dzaj_t")," dzaj008,
            ",adzp270_gen_replace_sql_str("dzaj009","dzaj_t")," dzaj009,
            ",adzp270_gen_replace_sql_str("dzaj010","dzaj_t")," dzaj010,
            ",adzp270_gen_replace_sql_str("dzaj011","dzaj_t")," dzaj011,
            '",l_user,"' dzajownid,'",l_dept,"' dzajowndp,'",l_user,"' dzajcrtid,'",l_dept,"' dzajcrtdp,'",l_date USING "yyyy/mm/dd","' dzajcrtdt
            FROM dzaj_t 
            INNER JOIN dzaa_t ON dzaa001=dzaj001 AND dzaa003=dzaj002 AND dzaa004=dzaj003 AND dzaa006=dzaj004
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='7' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzaj_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzaj_t_2"
      EXECUTE insert_data_to_dzaj_t_2 


      ######-- dzal_t-- sql參考 sadzp030_tsd_get_dzal_sql(p_code, p_ver) 複製dzal_t(程式串查設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzal_t(
         dzalstus,
         dzal001,
         dzal002,
         dzal003,
         dzal004,
         dzal005,
         dzal006,
         dzal007,
         dzalownid,dzalowndp,dzalcrtid,dzalcrtdp,dzalcrtdt
         )SELECT 
            dzalstus,
            '",g_gen_prog,"' dzal001,
            ",adzp270_gen_replace_sql_str("dzal002","dzal_t")," dzal002,
            '",g_design_point_ver,"' dzal003,
            '",ms_dgenv,"' dzal004,
            ",adzp270_gen_replace_sql_str("dzal005","dzal_t")," dzal005,
            dzal006,
            dzal007,
            '",l_user,"' dzalownid,'",l_dept,"' dzalowndp,'",l_user,"' dzalcrtid,'",l_dept,"' dzalcrtdp,'",l_date USING "yyyy/mm/dd","' dzalcrtdt
            FROM dzal_t
            INNER JOIN dzaa_t ON dzaa001=dzal001 AND dzaa003=dzal002 AND dzaa004=dzal003 AND dzaa006=dzal004
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='9' AND dzaastus='Y' ",g_dzaa_t_exculded_wc

      PREPARE insert_data_to_dzal_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzal_t_2"
      EXECUTE insert_data_to_dzal_t_2 

      
      ######-- dzff_t-- sql參考 sadzp030_tsd_get_dzff_sql(g_code, g_ver) 複製dzff_t(樹狀結構屬性設定檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzff_t(
         dzffstus,
         dzff001,
         dzff002,
         dzff003,
         dzff004,
         dzff005,
         dzff006,
         dzff007,
         dzff008,
         dzffownid,dzffowndp,dzffcrtid,dzffcrtdp,dzffcrtdt
         )SELECT 
            dzffstus,
            '",g_gen_prog,"' dzff001,
            '",g_design_point_ver,"' dzff002,
            dzff003,
            dzff004,
            dzff005,
            ",adzp270_gen_replace_sql_str("dzff006","dzff_t")," dzff006,
            ",adzp270_gen_replace_sql_str("dzff007","dzff_t")," dzff007,
            '",ms_dgenv,"' dzff008, 
            '",l_user,"' dzffownid,'",l_dept,"' dzffowndp,'",l_user,"' dzffcrtid,'",l_dept,"' dzffcrtdp,'",l_date USING "yyyy/mm/dd","' dzffcrtdt
            FROM dzaa_t
            INNER JOIN dzff_t ON dzff001=dzaa001 AND dzff002=dzaa004 AND dzffstus='Y' AND dzff008=dzaa006 AND dzff008=dzaa006 
            WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TREE' AND dzaa005='5' AND dzaastus='Y' ",g_dzaa_t_exculded_wc," 
            ORDER BY dzff003,dzff004"

      PREPARE insert_data_to_dzff_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzff_t_2"
      EXECUTE insert_data_to_dzff_t_2 


      ######-- dzfr_t -- 自訂sql 複製dzfr_t(畫面結構設計內容檔)的SQL.
      #LET ls_sql =
      #"INSERT INTO dzfr_t(
         #dzfr001,
         #dzfr002,
         #dzfr003,
         #dzfr004,
         #dzfr005,
         #dzfr006,
         #dzfr007,
         #dzfr008,
         #dzfr009,
         #dzfr010,
         #dzfr011,
         #dzfr012
         #)SELECT DISTINCT
            #'",g_design_point_ver,"' dzfr001,
            #'",g_gen_prog,"' dzfr002,
            #dzfr003,
            #dzfr004,
            #dzfr005,
            #dzfr006,
            #dzfr007,
            #dzfr008,
            #",adzp270_gen_replace_sql_str("dzfr009","dzfr_t")," dzfr009,
            #",adzp270_gen_replace_sql_str("dzfr010","dzfr_t")," dzfr010,
            #dzfr011,
            #dzfr012
            #FROM dzaa_t 
            #INNER JOIN dzfr_t ON dzaa001=dzfr002 AND dzaa004=dzfr001
            #WHERE dzaa001 = '",g_copy_source,"' AND dzaa002 ='",g_source_spec_ver,"' ",g_dzaa_t_exculded_wc
         #
      #PREPARE insert_data_to_dzfr_t_2 FROM ls_sql
      #LET ls_err = "error:insert_data_to_dzfr_t_2"
      #EXECUTE insert_data_to_dzfr_t_2 

      
      ######-- dzfq_t -- 自訂sql 複製dzfq_t(畫面結構設計主檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzfq_t(
         dzfqstus,
         dzfq001,
         dzfq002,
         dzfq003,
         dzfq004,
         dzfq005,
         dzfq006,
         dzfq007,
         dzfq008,
         dzfq009,
         dzfq010,
         dzfq011,
         dzfq012,
         dzfq013,
         dzfq014,
         dzfq015,
         dzfq016,
         dzfqownid,dzfqowndp,dzfqcrtid,dzfqcrtdp,dzfqcrtdt
         )SELECT DISTINCT
            dzfqstus,
            dzfq001,
            dzfq002,
            '",g_design_point_ver,"' dzfq003,
            '",g_gen_prog,"' dzfq004,
            dzfq005,
            dzfq006,
            dzfq007,
            dzfq008,
            dzfq009,
            dzfq010,
            dzfq011,
            dzfq012,
            dzfq013,
            dzfq014,
            dzfq015,
            dzfq016, 
            '",l_user,"' dzfqownid,'",l_dept,"' dzfqowndp,'",l_user,"' dzfqcrtid,'",l_dept,"' dzfqcrtdp,'",l_date USING "yyyy/mm/dd","' dzfqcrtdt
            FROM dzaa_t 
            INNER JOIN dzfq_t ON dzaa001=dzfq004 AND dzaa004=dzfq003
            WHERE dzaa001 = '",g_copy_source,"' AND dzaa002 ='",g_source_spec_ver,"' ",g_dzaa_t_exculded_wc
         
      PREPARE insert_data_to_dzfq_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzfq_t_2"
      EXECUTE insert_data_to_dzfq_t_2 


      #####-- gzzd_t -- 自訂sql 複製gzzd_t(畫面元件多語言記錄檔)的SQL.
      #LET ls_sql =
      #"SELECT gzzd003,
            #",adzp270_gen_replace_sql_str("gzzd003","gzzd_t")," gzzd003, 
            #FROM gzzd_t
            #WHERE gzzd001 = '",g_copy_source,"' AND gzzdstus='Y' ",g_gzzd_t_exculded_wc
#
      #LET ls_err = "error:insert_data_to_gzzd_t"
      #CALL adzp270_insert_gzzd_t(ls_sql)

      ######-- gzzd_t -- 自訂sql 複製gzzd_t(畫面元件多語言記錄檔)的SQL.
      LET ls_sql =
      "INSERT INTO gzzd_t(
         gzzdstus,
         gzzd001,
         gzzd002,
         gzzd003,
         gzzd004,
         gzzd005,
         gzzd006, 
         gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt
         )SELECT 
            gzzdstus,
            '",g_gen_prog,"' gzzd001,
            gzzd002,
            ",adzp270_gen_replace_sql_str("gzzd003","gzzd_t")," gzzd003, 
            '",ms_dgenv,"' gzzd004,
            gzzd005,
            gzzd006,
            '",l_user,"' gzzdownid,'",l_dept,"' gzzdowndp,'",l_user,"' gzzdcrtid,'",l_dept,"' gzzdcrtdp,'",l_date USING "yyyy/mm/dd","' gzzdcrtdt
            FROM gzzd_t
            WHERE gzzd001 = '",g_copy_source,"' AND gzzd004 = '",ms_dgenv,"'"
         
      PREPARE insert_data_to_gzzd_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_gzzd_t_2"
      EXECUTE insert_data_to_gzzd_t_2 
 
         
      #####-- gzzq_t -- 自訂sql 複製gzzq_t(ACTION多語言對照檔)的SQL.
      LET ls_sql =
      "SELECT gzzq002 
            FROM gzzq_t
            WHERE gzzq001 = '",g_copy_source,"'"

      LET ls_err = "error:insert_data_to_gzzq_t_2"
      CALL adzp270_insert_gzzq_t(ls_sql)

      #####-- gzzp_t -- 自訂sql 複製gzzp_t(階層式選單設定檔)的SQL.
      LET ls_sql =
      "INSERT INTO gzzp_t(
         gzzpstus,
         gzzp001,
         gzzp002,
         gzzp003,
         gzzp004,
         gzzp005, 
         gzzpownid,gzzpowndp,gzzpcrtid,gzzpcrtdp,gzzpcrtdt
         )SELECT 
            gzzpstus,
            '",g_gen_prog,"' gzzp001,
            gzzp002,
            gzzp003,
            gzzp004, 
            gzzp005,
            '",l_user,"' gzzpownid,'",l_dept,"' gzzpowndp,'",l_user,"' gzzpcrtid,'",l_dept,"' gzzpcrtdp,'",l_date USING "yyyy/mm/dd","' gzzpcrtdt
            FROM gzzp_t
            WHERE gzzp001='",g_copy_source,"' AND gzzpstus='Y'"
         
      PREPARE insert_data_to_gzzp_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_gzzp_t_2"
      EXECUTE insert_data_to_gzzp_t_2
      

      ######-- dzba_t -- 自訂sql 複製dzba_t(程式與內容版本對應表)的SQL.
      LET ls_sql =
      "INSERT INTO dzba_t(
         dzbastus,
         dzba001,
         dzba002,
         dzba003,
         dzba004,
         dzba005,
         dzba006,
         dzba007,
         dzba008,
         dzba009,
         dzbaownid,dzbaowndp,dzbacrtid,dzbacrtdp,dzbacrtdt
         )SELECT 
            dzbastus,
            '",g_gen_prog,"' dzba001,
            '",g_gen_spec_ver,"' dzba002,
            ",adzp270_gen_replace_sql_str("dzba003","dzba_t")," dzba003,
            '",g_design_point_ver,"' dzba004,
            '",ms_dgenv,"' dzba005,
            dzba006,
            dzba007,
            dzba008,
            dzba009,
            '",l_user,"' dzbaownid,'",l_dept,"' dzbaowndp,'",l_user,"' dzbacrtid,'",l_dept,"' dzbacrtdp,'",l_date USING "yyyy/mm/dd","' dzbacrtdt
            FROM dzba_t
            WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzbastus='Y' ",g_dzba_t_exculded_wc
         
      PREPARE insert_data_to_dzba_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzba_t_2"
      EXECUTE insert_data_to_dzba_t_2 


      ######-- dzbb_t -- 自訂sql 複製dzbb_t(程式設計點設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzbb_t(
         dzbbstus,
         dzbb001,
         dzbb002,
         dzbb003,
         dzbb004,
         dzbb098,
         dzbb005,
         dzbb006, 
         dzbbownid,dzbbowndp,dzbbcrtid,dzbbcrtdp,dzbbcrtdt
         )SELECT 
            dzbbstus,
            '",g_gen_prog,"' dzbb001,
            ",adzp270_gen_replace_sql_str("dzbb002","dzbb_t")," dzbb002,
            '",g_design_point_ver,"' dzbb003,
            '",ms_dgenv,"' dzbb004,
            ",adzp270_gen_replace_sql_str("dzbb098","dzbb_t")," dzbb098,
            dzbb005,
            dzbb006,
            '",l_user,"' dzbbownid,'",l_dept,"' dzbbowndp,'",l_user,"' dzbbcrtid,'",l_dept,"' dzbbcrtdp,'",l_date USING "yyyy/mm/dd","' dzbbcrtdt
            FROM dzbb_t
            INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzbastus = 'Y' AND dzba005 = dzbb004
            WHERE dzbb001='",g_copy_source,"' AND dzbb003='",g_design_point_ver,"'  AND dzba002='",g_source_code_ver,"' ",g_dzba_t_exculded_wc 
  display 'update dzbb098 sql=',ls_sql #madey

      PREPARE insert_data_to_dzbb_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbb_t_2"
      EXECUTE insert_data_to_dzbb_t_2 

      ######-- dzam_t -- 自訂sql 複製dzam_t(規格畫面元件排除設定)的SQL
      LET ls_sql =
      "INSERT INTO dzam_t(
         dzamstus,
         dzam001,
         dzam002,
         dzam003,
         dzam004,
         dzam005,
         dzamownid,dzamowndp,dzamcrtid,dzamcrtdp,dzamcrtdt
         )SELECT
            dzamstus,
            '",g_gen_prog,"' dzam001,
            dzam002,
            ",adzp270_gen_replace_sql_str("dzam003","dzam_t")," dzam003,
            dzam004,
            dzam005,
            '",l_user,"' dzamownid,'",l_dept,"' dzamowndp,'",l_user,"' dzamcrtid,'",l_dept,"' dzamcrtdp,'",l_date USING "yyyy/mm/dd","' dzamcrtdt 
            FROM dzam_t
            WHERE dzam001 = '",g_copy_source,"' "

      PREPARE insert_data_to_dzam_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzam_t_2"
      EXECUTE insert_data_to_dzam_t_2

      ######-- dzbc_t -- 自訂sql 複製dzbc_t(代碼與內容版本對應表)的SQL
      LET ls_sql =
      "INSERT INTO dzbc_t(
         dzbcstus,
         dzbc001,
         dzbc002,
         dzbc003,
         dzbc004,
         dzbc005,
         dzbc006
         )SELECT
            dzbcstus,
            '",g_gen_prog,"' dzbc001,
            '",g_gen_spec_ver,"' dzbc002,
            REPLACE(dzbc003,'",g_copy_source,"','",g_gen_prog,"') dzbc003,
            dzbc004,
            dzbc005,
            dzbc006
            FROM dzbc_t
            WHERE dzbc001 = '",g_copy_source,"'"

      PREPARE insert_data_to_dzbc_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbc_t_2"
      EXECUTE insert_data_to_dzbc_t_2

      ######-- dzbd_t -- 自訂sql 複製dzbd_t(代碼設計點設計表)的SQL
      LET ls_sql =
      "INSERT INTO dzbd_t(
         dzbdstus,
         dzbd001,
         dzbd002,
         dzbd003,
         dzbd004,
         dzbd098
         )SELECT
            dzbdstus,
            '",g_gen_prog,"' dzbd001,
            REPLACE(dzbd002,'",g_copy_source,"','",g_gen_prog,"') dzbd002,
            dzbd003,
            dzbd004,
            ",adzp270_gen_replace_sql_str("dzbd098","dzbd_t")," dzbd098
            FROM dzbd_t
            INNER JOIN dzbc_t ON dzbc001 = dzbd001 AND dzbc003 = dzbd002 AND dzbc004 = dzbd003 AND dzbc005 = dzbd004
            WHERE dzbd001 = '",g_copy_source,"'"

      PREPARE insert_data_to_dzbd_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbd_t_2"
      EXECUTE insert_data_to_dzbd_t_2

      ######-- dzax_t -- 自訂sql 複製dzax_t(程式設計基本設定表)的SQL
      LET ls_sql =
      "INSERT INTO dzax_t(
         dzaxstus,
         dzax001,
         dzax002,
         dzax003,
         dzax004
         )SELECT
            dzaxstus,
            '",g_gen_prog,"' dzax001,
            dzax002,
            dzax003,
            'Y' dzax004
            FROM dzax_t
            WHERE dzax001 = '",g_copy_source,"'"

      PREPARE insert_data_to_dzax_t_2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzax_t_2"
      EXECUTE insert_data_to_dzax_t_2
      
   CATCH
      IF SQLCA.sqlcode THEN
         DISPLAY "############### SQL ERROR ###############"
         DISPLAY "sql = ",ls_sql
         CALL cl_err(ls_err||" sql="||ls_sql,SQLCA.sqlcode,1)
         LET lb_flag = FALSE
      END IF
   END TRY
    
   
   IF lb_flag THEN
      COMMIT WORK
      FREE insert_data_to_dzaa_t_2
      FREE insert_data_to_dzab_t_2
      FREE insert_data_to_dzac_t_2
      FREE insert_data_to_dzak_t_2
      FREE insert_data_to_dzad_t_2
      #FREE insert_data_to_dzae_t_2
      FREE insert_data_to_dzag_t_2
      FREE insert_data_to_dzfs_t_2
      FREE insert_data_to_dzai_t_2
      FREE insert_data_to_dzaj_t_2
      FREE insert_data_to_dzal_t_2
      FREE insert_data_to_dzff_t_2
      #FREE insert_data_to_dzfr_t_2
      FREE insert_data_to_dzfq_t_2
      FREE insert_data_to_gzzp_t_2
      FREE insert_data_to_dzba_t_2
      FREE insert_data_to_dzbb_t_2
      FREE insert_data_to_dzam_t_2
      FREE insert_data_to_dzbc_t_2
      FREE insert_data_to_dzbd_t_2
      FREE insert_data_to_dzax_t_2
   ELSE
      ROLLBACK WORK
   END IF
 
   RETURN lb_flag
END FUNCTION

#+ 複製gzzd_t(畫面元件多語言記錄檔)
PRIVATE FUNCTION adzp270_insert_gzzd_t(ps_sql)
   DEFINE ln_cnt      LIKE type_t.num5,
          ps_sql      STRING,
          ls_text     STRING,
          ls_comment  STRING
          
   #DISPLAY "### adzp270_insert_gzzd_t ### start ###"

   PREPARE insert_data_to_gzzd_t_3 FROM ps_sql
   DECLARE gzzd_curs CURSOR FOR insert_data_to_gzzd_t_3

   CALL ga_gzzd_t.clear()
   LET ln_cnt = 1
   
   FOREACH gzzd_curs INTO ga_gzzd_t[ln_cnt].source_label,ga_gzzd_t[ln_cnt].gen_label
      DISPLAY "ga_gzzd_t[ln_cnt].source_label = ",ga_gzzd_t[ln_cnt].source_label

      #取出來源程式的轉換的多語言和註解
      CALL s_azzi902_get_gzzd(g_copy_source, ga_gzzd_t[ln_cnt].source_label) RETURNING ls_text,ls_comment


      #DISPLAY "ga_gzzd_t[ln_cnt].gen_label = ",ga_gzzd_t[ln_cnt].gen_label
      #塞入產生程式的多語言和註解
      IF NOT s_azzi902_ins_gzzd(g_gen_prog, ga_gzzd_t[ln_cnt].gen_label, ls_text,ls_comment) THEN
         DISPLAY "ERROR: insert gzzd_t :",ga_gzzd_t[ln_cnt].gen_label
      END IF
      
      LET ln_cnt = ln_cnt + 1
   END FOREACH

   CALL ga_gzzd_t.deleteElement(ln_cnt)
   LET ln_cnt = ln_cnt - 1
  
   #DISPLAY "### adzp270_insert_gzzd_t ### end ###"

END FUNCTION

#+ 複製gzzq_t(ACTION多語言對照檔)
PRIVATE FUNCTION adzp270_insert_gzzq_t(ps_sql)
   DEFINE ln_cnt     LIKE type_t.num5,
          ps_sql     STRING,
          ls_text    STRING,
          ls_comment STRING,
          ls_standard STRING
          
   #DISPLAY "### adzp270_insert_gzzq_t ### start ###"

   PREPARE insert_data_to_gzzq_t FROM ps_sql
   DECLARE gzzq_curs CURSOR FOR insert_data_to_gzzq_t

   CALL ga_gzzq_t.clear()
   LET ln_cnt = 1
   
   FOREACH gzzq_curs INTO ga_gzzq_t[ln_cnt].*

      CALL s_azzi903_get_gzzq(g_copy_source,ga_gzzq_t[ln_cnt].gzzq002) RETURNING ls_text,ls_comment,ls_standard
   
      IF NOT s_azzi903_ins_gzzq(g_gen_prog, ga_gzzq_t[ln_cnt].gzzq002,ls_text,ls_comment) THEN
         #DISPLAY "ERROR: insert gzzq_t :",ga_gzzq_t[ln_cnt].gzzq002
      END IF
      
      LET ln_cnt = ln_cnt + 1
   END FOREACH

   CALL ga_gzzq_t.deleteElement(ln_cnt)
   LET ln_cnt = ln_cnt - 1
  
   DISPLAY "### adzp270_insert_gzzq_t ### end ###"

END FUNCTION

#+ 檢查是否有設計資料
PRIVATE FUNCTION adzp270_check_design_date_exist()
   DEFINE ln_cnt         LIKE type_t.num5,
          l_table_id     STRING,
          ln_total_cnt   LIKE type_t.num5,
          ls_exist_table STRING

   LET ln_total_cnt = 0
   LET ls_exist_table = ""

   TRY
      # dzaa_t-- 尋找設計資料在(規格與內容版本對應表)的SQL.
      LET l_table_id = "dzaa_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzaa_t WHERE dzaa001= g_gen_prog AND dzaa002 = g_gen_spec_ver AND dzaa004 = g_design_point_ver AND dzaa006 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      
      # dzab_t-- 尋找設計資料在(規格整體設計表)的SQL.
      LET l_table_id = "dzab_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzab_t WHERE dzab001= g_gen_prog AND dzab002 = g_design_point_ver AND dzab003 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzac_t-- 尋找設計資料在(欄位規格設計表)的SQL.
      LET l_table_id = "dzac_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzac_t WHERE dzac001= g_gen_prog AND dzac004 = g_design_point_ver AND dzac012 = ms_dgenv 
      LET ln_total_cnt = ln_total_cnt + ln_cnt
 
      # dzak_t-- 尋找設計資料在(欄位助記碼設計表)的SQL.
      LET l_table_id = "dzak_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzak_t WHERE dzak001= g_gen_prog AND dzak003 = g_design_point_ver AND dzak004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzad_t-- 尋找設計資料在(Action規格設計表)的SQL.
      LET l_table_id = "dzad_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzad_t WHERE dzad001= g_gen_prog AND dzad003 = g_design_point_ver AND dzad005 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzah_t-- 尋找設計資料在(Action觸發時機設計表)的SQL.
      #LET l_table_id = "dzah_t"
      #SELECT COUNT(*)  INTO ln_cnt  FROM dzah_t WHERE dzah001= g_gen_prog AND dzah003 = g_design_point_ver AND dzah004 = ms_dgenv
      #LET ln_total_cnt = ln_total_cnt + ln_cnt
   
      # dzae_t--  尋找設計資料在(設計器程式基本資料表)的SQL.
      #LET l_table_id = "dzae_t"
      #SELECT COUNT(*)  INTO ln_cnt  FROM dzae_t WHERE dzae001= g_gen_prog AND dzae002 = g_gen_spec_ver
      #LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzag_t--  尋找設計資料在(規格Table設定表)的SQL.
      LET l_table_id = "dzag_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzag_t WHERE dzag001= g_gen_prog AND dzag006 = ms_dgenv #AND dzag003 = g_design_point_ver  #ms_dgenv自訂
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzfs_t--  尋找設計資料在(程式Table與Screen Record對應檔)的SQL.
      LET l_table_id = "dzfs_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzfs_t WHERE dzfs002= g_gen_prog AND dzfs005 = ms_dgenv #AND dzfs001 = g_design_point_ver  #ms_dgenv自訂
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzai_t-- 尋找設計資料在(欄位參考設計表)的SQL.
      LET l_table_id = "dzai_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzai_t WHERE dzai001= g_gen_prog AND dzai003 = g_design_point_ver AND dzai004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
   
      # dzaj_t-- 尋找設計資料在(欄位資料多語言設計表)的SQL.
      LET l_table_id = "dzaj_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzaj_t WHERE dzaj001= g_gen_prog AND dzaj003 = g_design_point_ver AND dzaj004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzal_t-- 尋找設計資料在(程式串查設計表)的SQL.
      LET l_table_id = "dzal_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzal_t WHERE dzal001= g_gen_prog AND dzal003 = g_design_point_ver AND dzal004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzff_t-- 尋找設計資料在(樹狀結構屬性設定檔)的SQL.
      LET l_table_id = "dzff_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzff_t WHERE dzff001= g_gen_prog AND dzff002 = g_design_point_ver AND dzff008 = ms_dgenv #ms_dgenv自訂
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzfr_t -- 尋找設計資料在(畫面結構設計內容檔)的SQL.
      LET l_table_id = "dzfr_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzfr_t WHERE dzfr002= g_gen_prog AND dzfr001 = g_design_point_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt
   
      # dzfq_t -- 尋找設計資料在(畫面結構設計主檔)的SQL.
      LET l_table_id = "dzfq_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzfq_t WHERE dzfq004= g_gen_prog AND dzfq003 = g_design_point_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt
   
      # gzzd_t -- 尋找設計資料在(畫面元件多語言記錄檔)的SQL.
      LET l_table_id = "gzzd_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM gzzd_t WHERE gzzd001= g_gen_prog AND gzzd004 = ms_dgenv #ms_dgenv自訂
      LET ln_total_cnt = ln_total_cnt + ln_cnt
    
      # gzzq_t -- 尋找設計資料在(ACTION多語言對照檔)的SQL.
      LET l_table_id = "gzzq_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM gzzq_t WHERE gzzq001= g_gen_prog AND gzzq006 = ms_dgenv #ms_dgenv自訂
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # gzzp_t -- 尋找設計資料在(階層式選單設定檔)的SQL.
      LET l_table_id = "gzzp_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM gzzp_t WHERE gzzp001= g_gen_prog #m
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzba_t -- 尋找設計資料在(程式與內容版本對應表)的SQL.
      LET l_table_id = "dzba_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzba_t WHERE dzba001= g_gen_prog  AND dzba005 = ms_dgenv #AND dzba002 = g_gen_spec_ver AND dzba004 = g_design_point_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzbb_t -- 尋找設計資料在(程式設計點設計表)的SQL.
      LET l_table_id = "dzbb_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzbb_t WHERE dzbb001= g_gen_prog  AND dzbb004 = ms_dgenv #AND dzbb003 = g_design_point_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzam_t -- 尋找設計資料在(規格畫面元件排除設定)的SQL.
      LET l_table_id = "dzam_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzam_t WHERE dzam001= g_gen_prog AND dzam005 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzbc_t -- 尋找設計資料在(代碼與內容版本對應表)的SQL.
      LET l_table_id = "dzbc_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzbc_t WHERE dzbc001= g_gen_prog AND dzbc002 = g_gen_spec_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzbd_t -- 尋找設計資料在(代碼設計點設計表)的SQL.
      LET l_table_id = "dzbd_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzbd_t WHERE dzbd001= g_gen_prog AND dzbd003 = g_design_point_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzax_t -- 尋找設計資料在(程式設計基本設定表)的SQL.
      LET l_table_id = "dzax_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzax_t WHERE dzax001= g_gen_prog
      LET ln_total_cnt = ln_total_cnt + ln_cnt

   CATCH
      IF SQLCA.sqlcode THEN
         CALL cl_err("design data exist table:"||l_table_id,SQLCA.sqlcode,g_errshow)
      END IF
   END TRY

   IF ln_total_cnt = 0 THEN
      RETURN FALSE
   END IF 

   RETURN TRUE

END FUNCTION

#+ 刪除資料庫資料
PRIVATE FUNCTION adzp270_delete_database_data()
   DEFINE l_table_id      STRING,
          l_tsd_file_path STRING,
          l_tap_file_path STRING,
          ls_sql          STRING


   LET g_gen_prog = g_gen_prog CLIPPED
   LET g_gen_spec_ver = g_gen_spec_ver CLIPPED
   LET g_design_point_ver = g_design_point_ver CLIPPED
   

   TRY
      # dzaa_t-- 刪除(規格與內容版本對應表)的SQL.
      LET l_table_id = "dzaa_t"
      DELETE FROM dzaa_t WHERE dzaa001= g_gen_prog AND dzaa002 = g_gen_spec_ver AND dzaa004 = g_design_point_ver #AND dzaa006 = ms_dgenv
               
      # dzab_t-- 刪除(規格整體設計表)的SQL.
      LET l_table_id = "dzab_t"
      DELETE FROM dzab_t WHERE dzab001= g_gen_prog AND dzab002 = g_design_point_ver #AND dzab003 = ms_dgenv
         
      # dzac_t-- 刪除(欄位規格設計表)的SQL.
      LET l_table_id = "dzac_t"
      DELETE FROM dzac_t WHERE dzac001= g_gen_prog AND dzac004 = g_design_point_ver #AND dzac012 = ms_dgenv 
         
      # dzak_t-- 刪除(欄位助記碼設計表)的SQL.
      LET l_table_id = "dzak_t"
      DELETE FROM dzak_t WHERE dzak001= g_gen_prog AND dzak003 = g_design_point_ver #AND dzak004 = ms_dgenv
         
      # dzad_t-- 刪除(Action規格設計表)的SQL.
      LET l_table_id = "dzad_t"
      DELETE FROM dzad_t WHERE dzad001= g_gen_prog AND dzad003 = g_design_point_ver #AND dzad005 = ms_dgenv

      # dzah_t-- 刪除(Action觸發時機設計表)的SQL.
      #LET l_table_id = "dzah_t"
      #DELETE FROM dzah_t WHERE dzah001= g_gen_prog AND dzah003 = g_design_point_ver #AND dzah004 = ms_dgenv
         
      # dzae_t--  刪除(設計器程式基本資料表)的SQL.
      #LET l_table_id = "dzae_t"
      #DELETE FROM dzae_t WHERE dzae001= g_gen_prog AND dzae002 = g_gen_spec_ver

      # dzag_t--  刪除(規格Table設定表)的SQL.
      LET l_table_id = "dzag_t"
      DELETE FROM dzag_t WHERE dzag001= g_gen_prog #AND dzag003 = g_design_point_ver #AND dzag006 = ms_dgenv #ms_dgenv自訂

      # dzfs_t--  刪除(程式Table與Screen Record對應檔)的SQL.
      LET l_table_id = "dzfs_t"
      DELETE FROM dzfs_t WHERE dzfs002= g_gen_prog #AND dzfs001 = g_design_point_ver #AND dzfs005 = ms_dgenv #ms_dgenv自訂

      # dzai_t-- 刪除(欄位參考設計表)的SQL.
      LET l_table_id = "dzai_t"
      DELETE FROM dzai_t WHERE dzai001= g_gen_prog AND dzai003 = g_design_point_ver #AND dzai004 = ms_dgenv
         
      # dzaj_t-- 刪除(欄位資料多語言設計表)的SQL.
      LET l_table_id = "dzaj_t"
      DELETE FROM dzaj_t WHERE dzaj001= g_gen_prog AND dzaj003 = g_design_point_ver #AND dzaj004 = ms_dgenv

      # dzal_t-- 刪除(程式串查設計表)的SQL.
      LET l_table_id = "dzal_t"
      DELETE FROM dzal_t WHERE dzal001= g_gen_prog AND dzal003 = g_design_point_ver #AND dzal004 = ms_dgenv

      # dzff_t-- 刪除(樹狀結構屬性設定檔)的SQL.
      LET l_table_id = "dzff_t"
      DELETE FROM dzff_t WHERE dzff001= g_gen_prog AND dzff002 = g_design_point_ver #AND dzff008 = ms_dgenv #ms_dgenv自訂

      # dzfr_t -- 刪除(畫面結構設計內容檔)的SQL.
      LET l_table_id = "dzfr_t"
      DELETE FROM dzfr_t WHERE dzfr002= g_gen_prog AND dzfr001 = g_design_point_ver
         
      # dzfq_t -- 刪除(畫面結構設計主檔)的SQL.
      LET l_table_id = "dzfq_t"
      DELETE FROM dzfq_t WHERE dzfq004= g_gen_prog AND dzfq003 = g_design_point_ver
         
      # gzzd_t -- 刪除(畫面元件多語言記錄檔)的SQL.
      LET l_table_id = "gzzd_t"
      DELETE FROM gzzd_t WHERE gzzd001= g_gen_prog AND gzzd004 = ms_dgenv #ms_dgenv自訂
         #
      # gzzq_t -- 刪除(ACTION多語言對照檔)的SQL.
      #LET l_table_id = "gzzq_t"
      #DELETE FROM gzzq_t WHERE gzzq001= g_gen_prog #AND gzzq006 = ms_dgenv #ms_dgenv自訂

      #gzzp_t -- 刪除(階層式選單設定檔)的SQL.
      LET l_table_id = "gzzp_t"
      DELETE FROM gzzp_t WHERE gzzp001= g_gen_prog #自訂

      # dzba_t -- 刪除(程式與內容版本對應表)的SQL.
      LET l_table_id = "dzba_t"
      DELETE FROM dzba_t WHERE dzba001= g_gen_prog AND dzba005 = ms_dgenv#AND dzba002 = g_gen_spec_ver #AND dzba004 = g_design_point_ver #

      # dzbb_t -- 刪除(程式設計點設計表)的SQL.
      LET l_table_id = "dzbb_t"
      DELETE FROM dzbb_t WHERE dzbb001= g_gen_prog AND dzbb004 = ms_dgenv #AND dzbb003 = g_design_point_ver

      # dzam_t -- 刪除(規格畫面元件排除設定)的SQL.
      LET l_table_id = "dzam_t"
      DELETE FROM dzam_t WHERE dzam001= g_gen_prog

      # dzbc_t -- 刪除(代碼與內容版本對應表)的SQL.
      LET l_table_id = "dzbc_t"
      DELETE FROM dzbc_t WHERE dzbc001= g_gen_prog AND dzbc002 = g_gen_spec_ver

      # dzbd_t -- 刪除(代碼設計點設計表)的SQL.
      LET l_table_id = "dzbd_t"
      DELETE FROM dzbd_t WHERE dzbd001= g_gen_prog AND dzbd003 = g_design_point_ver

      # dzax_t -- 刪除(程式設計基本設定表)的SQL.
      LET l_table_id = "dzax_t"
      DELETE FROM dzax_t WHERE dzax001= g_gen_prog
   
   CATCH
      IF SQLCA.sqlcode THEN
         CALL cl_err("del_error table:"||l_table_id,SQLCA.sqlcode,g_errshow)
         ROLLBACK WORK
         RETURN FALSE
      END IF
   END TRY

   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION adzp270_gen_tree_view(pa_dzag,p_parent_table,p_parent_id)
   DEFINE pa_dzag          DYNAMIC ARRAY OF RECORD LIKE dzag_t.*,
          l_i              LIKE type_t.num5,
          l_index          LIKE type_t.num5,
          l_cnt            LIKE type_t.num5,
          p_parent_id      STRING,
          p_parent_table   LIKE dzea_t.dzea001,
          l_parent_id      STRING,
          l_parent_table   LIKE dzea_t.dzea001,
          l_cnt_str        STRING

   IF  p_parent_table = "root" THEN
      #DISPLAY p_parent_id
      FOR l_i = 1 TO pa_dzag.getLength()
         #找主資料格
         IF pa_dzag[l_i].dzag005 = "Y" THEN
            CALL ga_dzag_tree.appendElement()
            LET l_index = ga_dzag_tree.getLength()
            LET ga_dzag_tree[l_index].table_id = pa_dzag[l_i].dzag002

            SELECT dzeal003 INTO ga_dzag_tree[l_index].table_name
               FROM dzeal_t
               WHERE dzeal001 = ga_dzag_tree[l_index].table_id AND dzeal002 = g_lang

         #匯入資料到 表格對應關係設定表      
         IF g_is_import_setting_date = FALSE THEN
            CALL ga_dzag.clear()
            CALL ga_dzag.appendElement()
            LET ga_dzag[ga_dzag.getLength()].old_table_id = ga_dzag_tree[l_index].table_id
            LET ga_dzag[ga_dzag.getLength()].old_table_name = ga_dzag_tree[l_index].table_name
            LET ga_dzag[ga_dzag.getLength()].old_table_parent = pa_dzag[l_i].dzag004 #
            LET ga_dzag[ga_dzag.getLength()].old_table_main = pa_dzag[l_i].dzag005 #是否為主資料表
            LET ga_dzag[ga_dzag.getLength()].new_table_main = pa_dzag[l_i].dzag005 #是否為主資料表
         END IF            
         
            LET ga_dzag_tree[l_index].parent_id = p_parent_id
            LET ga_dzag_tree[l_index].current_id = p_parent_id,".1"
            LET ga_dzag_tree[l_index].expanded = '1'
            LET l_parent_table = ga_dzag_tree[l_index].table_id
            LET l_parent_id = ga_dzag_tree[l_index].current_id
            CALL pa_dzag.deleteElement(l_i)
            LET l_i = l_i - 1 
         END IF      
      END FOR

      #遞回尋找主資料表的子資料表
      CALL adzp270_gen_tree_view(pa_dzag,l_parent_table,l_parent_id)

      #尋找副資料表
      LET l_cnt = 1

      FOR l_i = 1 TO pa_dzag.getLength()
         IF pa_dzag[l_i].dzag005 = "N" AND pa_dzag[l_i].dzag004 IS NULL THEN
            LET l_cnt = l_cnt + 1
            LET l_cnt_str = l_cnt
            LET l_cnt_str = l_cnt_str.trim()
            CALL ga_dzag_tree.appendElement()
            LET l_index = ga_dzag_tree.getLength()
            LET ga_dzag_tree[l_index].table_id = pa_dzag[l_i].dzag002

            SELECT dzeal003 INTO ga_dzag_tree[l_index].table_name
               FROM dzeal_t
               WHERE dzeal001 = ga_dzag_tree[l_index].table_id AND dzeal002 = g_lang

            #匯入資料到 表格對應關係設定表      
            IF g_is_import_setting_date = FALSE THEN
               CALL ga_dzag.appendElement()
               LET ga_dzag[ga_dzag.getLength()].old_table_id = ga_dzag_tree[l_index].table_id
               LET ga_dzag[ga_dzag.getLength()].old_table_name = ga_dzag_tree[l_index].table_name
               LET ga_dzag[ga_dzag.getLength()].old_table_parent = pa_dzag[l_i].dzag004 #上層表格
               LET ga_dzag[ga_dzag.getLength()].old_table_main = pa_dzag[l_i].dzag005 #是否為主資料表
               LET ga_dzag[ga_dzag.getLength()].new_table_main = pa_dzag[l_i].dzag005 #是否為主資料表
            END IF
            
            LET ga_dzag_tree[l_index].parent_id = p_parent_id
            LET ga_dzag_tree[l_index].current_id = p_parent_id,".",l_cnt_str
            #DISPLAY ga_dzag_tree[l_index].current_id
            LET ga_dzag_tree[l_index].expanded = '1'
            CALL pa_dzag.deleteElement(l_i)
            LET l_i = l_i - 1 
         END IF
      END FOR 

   ELSE
      #尋找主資料表下的子資料表
      LET l_cnt = 0
      
      FOR l_i = 1 TO pa_dzag.getLength()
         IF pa_dzag[l_i].dzag004 = p_parent_table THEN
            LET l_cnt = l_cnt + 1
            LET l_cnt_str = l_cnt
            LET l_cnt_str = l_cnt_str.trim()
            CALL ga_dzag_tree.appendElement()
            LET l_index = ga_dzag_tree.getLength()
            LET ga_dzag_tree[l_index].table_id = pa_dzag[l_i].dzag002

            SELECT dzeal003 INTO ga_dzag_tree[l_index].table_name
               FROM dzeal_t
               WHERE dzeal001 = ga_dzag_tree[l_index].table_id AND dzeal002 = g_lang

            #匯入資料到 表格對應關係設定表      
            IF g_is_import_setting_date = FALSE THEN
               CALL ga_dzag.appendElement()
               LET ga_dzag[ga_dzag.getLength()].old_table_id = ga_dzag_tree[l_index].table_id
               LET ga_dzag[ga_dzag.getLength()].old_table_name = ga_dzag_tree[l_index].table_name
               LET ga_dzag[ga_dzag.getLength()].old_table_parent = pa_dzag[l_i].dzag004 #上層表格
               LET ga_dzag[ga_dzag.getLength()].old_table_main = pa_dzag[l_i].dzag005   #是否為主資料表
               LET ga_dzag[ga_dzag.getLength()].new_table_main = pa_dzag[l_i].dzag005   #是否為主資料表
            END IF


            
            LET ga_dzag_tree[l_index].parent_id = p_parent_id
            LET ga_dzag_tree[l_index].current_id = p_parent_id,".",l_cnt_str
            #DISPLAY ga_dzag_tree[l_index].current_id
            LET ga_dzag_tree[l_index].expanded = '1'
            CALL pa_dzag.deleteElement(l_i)
            LET l_i = l_i - 1 
            LET l_parent_table = ga_dzag_tree[l_index].table_id
            LET l_parent_id = ga_dzag_tree[l_index].current_id
            #遞回搜尋子資料表
            CALL adzp270_gen_tree_view(pa_dzag,l_parent_table,l_parent_id)
         END IF
      END FOR

      #遞回的終止搜尋條件
      IF l_cnt = 0 THEN
         RETURN
      END IF
      
   END IF
END FUNCTION


#+ 產生表格主從結構和表格對應關係
PRIVATE FUNCTION adzp270_gen_table_relation()
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          li_cnt     LIKE type_t.num5,
          l_i     LIKE type_t.num5,
          l_j     LIKE type_t.num5,
          la_dzag    DYNAMIC ARRAY OF RECORD LIKE dzag_t.*

   TRY
      LET ls_trigger = "get_tsd : get ",g_copy_source," table setting"

      #CALL sadzp030_tsd_get_dzag_sql(g_copy_source, g_source_spec_ver) RETURNING ls_sql
      LET ls_sql = "SELECT dzag_t.*
                       FROM dzaa_t
                      INNER JOIN dzag_t
                         ON dzag001 = dzaa001
                        AND dzag003 = dzaa004
                        AND dzagstus = 'Y'
                      WHERE dzaa001 = '",g_copy_source,"'
                        AND dzaa002 = '",g_source_spec_ver,"'
                        AND dzaa003 = 'TABLE'
                        AND dzaa005 = '4'
                        AND dzaastus = 'Y' "
                        
      
      DISPLAY "ls_sql for Tree View = ",ls_sql
      PREPARE dzag_prep FROM ls_sql
      DECLARE dzag_curs CURSOR FOR dzag_prep

      #IF g_is_import_setting_date = FALSE THEN
         #CALL ga_dzag.clear()
      #END IF
      
      CALL ga_dzag_tree.clear()
      LET li_cnt = 1
      FOREACH dzag_curs INTO la_dzag[li_cnt].*
         #IF g_is_import_setting_date = FALSE THEN
            #
            #LET ga_dzag[li_cnt].old_table_id = la_dzag[li_cnt].dzag002
#
            #SELECT dzeal003 INTO ga_dzag[li_cnt].old_table_name
               #FROM dzeal_t 
               #WHERE dzeal001 = ga_dzag[li_cnt].old_table_id AND dzeal002=g_lang
         #END IF

         #LET ga_dzag_tree[li_cnt].table_id = la_dzag[li_cnt].dzag002
#
         #SELECT dzeal003 INTO ga_dzag_tree[li_cnt].table_name
            #FROM dzeal_t
            #WHERE dzeal001 = ga_dzag_tree[li_cnt].table_id AND dzeal002 = g_lang
#
         #IF la_dzag[li_cnt].dzag004 IS NULL THEN
            #LET ga_dzag_tree[li_cnt].parent_id = NULL
            #LET ga_dzag_tree[li_cnt].current_id = "1"
            #LET ga_dzag_tree[li_cnt].expanded = '1'
         #ELSE
            #LET ga_dzag_tree[li_cnt].parent_id = adzp270_search_parent_id( la_dzag[li_cnt].dzag004)
            #LET ga_dzag_tree[li_cnt].current_id = ga_dzag_tree[li_cnt].parent_id,".1"
            #LET ga_dzag_tree[li_cnt].expanded = '1'
         #END IF
         
         LET li_cnt = li_cnt + 1
      END FOREACH
      CALL la_dzag.deleteElement(li_cnt)
      LET li_cnt = li_cnt - 1

      #建立tree view
      CALL ga_dzag_tree.clear()
      #建立tree view的根節點
      CALL ga_dzag_tree.appendElement()
      LET ga_dzag_tree[ga_dzag_tree.getLength()].table_id = "root"
      LET ga_dzag_tree[ga_dzag_tree.getLength()].parent_id = NULL
      LET ga_dzag_tree[ga_dzag_tree.getLength()].current_id = "1"
      LET ga_dzag_tree[ga_dzag_tree.getLength()].expanded = '1'
      
      #呼叫遞回建立tree view      
      CALL adzp270_gen_tree_view(la_dzag,ga_dzag_tree[ga_dzag_tree.getLength()].table_id,ga_dzag_tree[ga_dzag_tree.getLength()].current_id)

      #CALL ga_dzag_tree.clear()
      #FOR l_i = 1 TO la_dzag.getLength()
         #IF la_dzag[l_i].dzag004 IS NULL THEN
            #CALL ga_dzag_tree.appendElement()

            #LET ga_dzag_tree[ga_dzag_tree.getLength()].table_id = la_dzag[l_i].dzag002

            #SELECT dzeal003 INTO ga_dzag_tree[ga_dzag_tree.getLength()].table_name
               #FROM dzeal_t
               #WHERE dzeal001 = ga_dzag_tree[l_i].table_id AND dzeal002 = g_lang
            #
            #LET ga_dzag_tree[ga_dzag_tree.getLength()].parent_id = NULL
            #LET ga_dzag_tree[ga_dzag_tree.getLength()].current_id = "1"
            #LET ga_dzag_tree[ga_dzag_tree.getLength()].expanded = '1'

            #FOR l_j = 1 TO la_dzag.getLength()
               #IF la_dzag[l_j].dzag004 = ga_dzag_tree[ga_dzag_tree.getLength()].table_id THEN
                  #CALL ga_dzag_tree.appendElement()

                  #LET ga_dzag_tree[ga_dzag_tree.getLength()].table_id = la_dzag[l_j].dzag002

                  #SELECT dzeal003 INTO ga_dzag_tree[ga_dzag_tree.getLength()].table_name
                     #FROM dzeal_t
                     #WHERE dzeal001 = ga_dzag_tree[l_j].table_id AND dzeal002 = g_lang
                  #
                  #LET ga_dzag_tree[ga_dzag_tree.getLength()].parent_id = la_dzag[l_j].dzag004
                  #LET ga_dzag_tree[ga_dzag_tree.getLength()].current_id = "1.1"
                  #LET ga_dzag_tree[ga_dzag_tree.getLength()].expanded = '1'
                  #
                  #EXIT FOR
               #END IF
             #END FOR
         #END IF
      #END FOR

      #找出來源作業有使用的多語言表
      LET ls_trigger = "get_tsd : get ",g_copy_source," multi lang table"
      LET ls_sql="SELECT DISTINCT dzaj008
                     FROM dzaj_t
                     WHERE dzaj001 = '",g_copy_source,"'"

      PREPARE multi_lang_table_prep FROM ls_sql
      DECLARE multi_lang_table_curs CURSOR FOR multi_lang_table_prep
      CALL g_multi_lang_table.clear()
      LET li_cnt = 1
      
      FOREACH multi_lang_table_curs INTO g_multi_lang_table[li_cnt].table_id

         SELECT dzeal003 INTO g_multi_lang_table[li_cnt].table_name
            FROM dzeal_t 
            WHERE dzeal001 = g_multi_lang_table[li_cnt].table_id AND dzeal002=g_lang

         IF g_is_import_setting_date = FALSE THEN
            CALL ga_dzag.appendElement()
            LET ga_dzag[ga_dzag.getLength()].old_table_id = g_multi_lang_table[li_cnt].table_id
            LET ga_dzag[ga_dzag.getLength()].old_table_name = g_multi_lang_table[li_cnt].table_name
         END IF
         #測試用：
         --IF ga_dzag[ga_dzag.getLength()].old_table_id = "imbal_t" THEN
            --LET ga_dzag[ga_dzag.getLength()].new_table_id = "imaal_t"         END IF
--
         --SELECT dzeal003 INTO ga_dzag[ga_dzag.getLength()].new_table_name
               --FROM dzeal_t 
               --WHERE dzeal001 = ga_dzag[ga_dzag.getLength()].new_table_id AND dzeal002=g_lang
         #測試用：
         
         LET li_cnt = li_cnt + 1
      END FOREACH
      CALL g_multi_lang_table.deleteElement(li_cnt)
      LET li_cnt = li_cnt - 1

      IF g_main_or_sub_prog = "M" THEN
         #找出此作業有用到的副程式
         LET ls_trigger = "get_tsd : get ",g_copy_source," sub prog"
         LET ls_sql = "SELECT gzde001, gzdel003
                          FROM gzde_t
                          LEFT JOIN gzdel_t
                            ON gzde001 = gzdel001
                            AND gzdel002 = '",g_lang,"'
                          WHERE gzdestus = 'Y'
                            AND gzde003 = 'S'
                            AND gzde001 LIKE '%",g_copy_source,"%'"
         #DISPLAY "ls_sql = ",ls_sql
         PREPARE sub_prog_prep FROM ls_sql
         DECLARE sub_prog_curs CURSOR FOR sub_prog_prep
         CALL ga_sub_prog.clear()
         LET li_cnt = 1
         
         FOREACH sub_prog_curs INTO ga_sub_prog[li_cnt].sub_prog_id,ga_sub_prog[li_cnt].sub_prog_name
            LET ga_sub_prog[li_cnt].sub_prog_type = 'S'  #子作業 add by madey 20140312
            LET li_cnt = li_cnt + 1
         END FOREACH
         
         #找出此作業有用到的子畫面
         LET ls_sql = "SELECT gzdf002, gzcbl004
                          FROM ((SELECT gzza003, gzza001, gzzastus, gzcbl004, gzdf002
                                   FROM (SELECT gzza003, gzza001, gzzastus, 'M' AS gzde003
                                           FROM gzza_t)
                                   LEFT JOIN gzdf_t
                                     ON gzza001 = gzdf001
                                   LEFT JOIN gzcbl_t
                                     ON gzde003 = gzcbl002
                                    AND gzcbl001 = '91'
                                    AND gzcbl003 = '",g_lang,"') UNION
                                (SELECT gzde002  AS gzza003,
                                        gzde001  AS gzza001,
                                        gzdestus AS gzzastus,
                                        gzcbl004,
                                        gzdf002
                                   FROM gzde_t
                                   LEFT JOIN gzdf_t
                                     ON gzde001 = gzdf001
                                   LEFT JOIN gzcbl_t
                                     ON gzde003 = gzcbl002
                                    AND gzcbl001 = '91'
                                    AND gzcbl003 = '",g_lang,"'))
                         WHERE gzzastus = 'Y'
                           AND gzdf002 IS NOT NULL
                           AND gzdf002 LIKE '%",g_copy_source,"%'"
         #DISPLAY "ls_sql = ",ls_sql
         PREPARE sub_prog_prep2 FROM ls_sql
         DECLARE sub_prog_curs2 CURSOR FOR sub_prog_prep2

         FOREACH sub_prog_curs2 INTO ga_sub_prog[li_cnt].sub_prog_id,ga_sub_prog[li_cnt].sub_prog_name
            LET ga_sub_prog[li_cnt].sub_prog_type = 'F'  #子畫面 add by madey 20140312
            LET li_cnt = li_cnt + 1
         END FOREACH

         #找出此作業有用到的子元件
         LET ls_sql = "SELECT gzde001, gzdel003
                          FROM gzde_t
                          LEFT JOIN gzdel_t
                            ON gzde001 = gzdel001
                           AND gzdel002 = '",g_lang,"'
                         WHERE gzdestus = 'Y'
                           AND gzde003 = 'B'
                           AND gzde002 = 'SUB'
                           AND gzde001 LIKE '%",g_copy_source,"%'"
         #DISPLAY "ls_sql = ",ls_sql
         PREPARE sub_prog_prep3 FROM ls_sql
         DECLARE sub_prog_curs3 CURSOR FOR sub_prog_prep3

         FOREACH sub_prog_curs3 INTO ga_sub_prog[li_cnt].sub_prog_id,ga_sub_prog[li_cnt].sub_prog_name
            LET ga_sub_prog[li_cnt].sub_prog_type = 'B'  #元件 add by madey 20140312
            LET li_cnt = li_cnt + 1
         END FOREACH
         CALL ga_sub_prog.deleteElement(li_cnt)
         LET li_cnt = li_cnt - 1
      END IF
      
   CATCH 
      CALL adzp270_err_catch(ls_trigger, ls_sql) 
   END TRY
END FUNCTION


PRIVATE FUNCTION adzp270_gen_col_relation(p_i)
   DEFINE ls_trigger     STRING,
          ls_sql         STRING,
          l_j            LIKE type_t.num5,
          p_i            LIKE type_t.num5,
          l_i            LIKE type_t.num5,
          la_dzag        DYNAMIC ARRAY OF RECORD LIKE dzag_t.*,
          l_str_buf      base.StringBuffer,
          l_dzeb002      LIKE dzeb_t.dzeb001,
          l_old_prefix   STRING,
          l_new_prefix   STRING,
          l_cnt          LIKE type_t.num5,
          l_dzed002      LIKE dzed_t.dzed002,
          l_dzed004      LIKE dzed_t.dzed004,
          l_dzeb_tmp     DYNAMIC ARRAY OF type_col_relation #暫存沒有對應到的pk/fk的欄位資料


   TRY

      #判斷在dzag的第幾筆資料
      CALL ga_dzeb.clear()
      LET l_i = p_i
      LET ls_trigger = "get_tsd : get col relation"

      LET ls_sql = "SELECT dzeb002,dzebl003 
                     FROM dzeb_t 
                     LEFT JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002='",g_lang,"' 
                     WHERE dzeb001='",ga_dzag[l_i].old_table_id,"' 
                     ORDER BY dzeb002"
      #DISPLAY "ls_sql = ",ls_sql
      PREPARE dzeb_prep FROM ls_sql
      DECLARE dzeb_curs CURSOR FOR dzeb_prep

      #去除舊表格代號的'_t'
      LET l_old_prefix = ga_dzag[l_i].old_table_id
      LET l_old_prefix = l_old_prefix.trim()
      LET l_old_prefix = l_old_prefix.subString(1,l_old_prefix.getLength()-2)

      #去除新表格代的'_t'
      LET l_new_prefix = ga_dzag[l_i].new_table_id
      LET l_new_prefix = l_new_prefix.trim()
      LET l_new_prefix = l_new_prefix.subString(1,l_new_prefix.getLength()-2)

      LET l_j = 1
      
      FOREACH dzeb_curs INTO ga_dzeb[l_j].old_col_id,ga_dzeb[l_j].old_col_name
         
         LET ga_dzeb[l_j].relation_no = l_j
         LET ga_dzeb[l_j].new_table_id = ga_dzag[l_i].new_table_id
         LET ga_dzeb[l_j].old_table_id = ga_dzag[l_i].old_table_id
         #自動配對原有欄位和新欄位的對應關係        
         LET l_str_buf = base.StringBuffer.create()
         CALL l_str_buf.append(ga_dzeb[l_j].old_col_id)
         CALL l_str_buf.replace(l_old_prefix,l_new_prefix,0) 
         LET l_dzeb002 = l_str_buf.toString()
         
         SELECT dzeb002,dzebl003 INTO ga_dzeb[l_j].new_col_id,ga_dzeb[l_j].new_col_name
            FROM dzeb_t
            LEFT JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002=g_lang
            WHERE dzeb001=ga_dzag[l_i].new_table_id AND dzeb002 = l_dzeb002



         #尋找新欄位的pk
         LET l_dzed002 = l_new_prefix.trim(),"_pk"
         LET l_dzed004 = "%",ga_dzeb[l_j].new_col_id,"%"
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzag[l_i].new_table_id AND 
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004 

         IF l_cnt > 0 THEN
            LET  ga_dzeb[l_j].new_col_key = ga_dzeb[l_j].new_col_key , "PK"
         END IF

         #尋找新欄位的fk
         LET l_dzed002 = l_new_prefix.trim(),"_fk"
         LET l_dzed004 = "%",ga_dzeb[l_j].new_col_id,"%"
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzag[l_i].new_table_id AND 
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004 

         IF l_cnt > 0 THEN
            LET  ga_dzeb[l_j].new_col_key = ga_dzeb[l_j].new_col_key ,",FK"
         END IF
         
         #尋找舊欄位的pk
         LET l_dzed002 = l_old_prefix.trim(),"_pk"
         LET l_dzed004 =  "%",ga_dzeb[l_j].old_col_id,"%" 
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzag[l_i].old_table_id AND 
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004

         IF l_cnt > 0 THEN
            LET  ga_dzeb[l_j].old_col_key = ga_dzeb[l_j].old_col_key , "PK"
         END IF
         
         #尋找舊欄位的fk
         LET l_dzed002 = l_old_prefix.trim(),"_fk"
         LET l_dzed004 =  "%",ga_dzeb[l_j].old_col_id,"%" 
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzag[l_i].old_table_id AND 
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004 

         IF l_cnt > 0 THEN
            LET  ga_dzeb[l_j].old_col_key = ga_dzeb[l_j].old_col_key , ",FK"
         END IF

         #暫存沒有對應到的pk/fk的欄位資料
         IF ga_dzeb[l_j].old_col_key IS NOT NULL AND ga_dzeb[l_j].new_col_key IS NULL THEN
            CALL l_dzeb_tmp.appendElement()
            LET l_dzeb_tmp[l_dzeb_tmp.getLength()].* = ga_dzeb[l_j].*
         END IF

         
         LET l_j = l_j + 1
      END FOREACH

      CALL ga_dzeb.deleteElement(l_j)
      
   CATCH 
      CALL adzp270_err_catch(ls_trigger, ls_sql) 
   END TRY

   LET l_j = l_j - 1
   #DISPLAY "共",l_j,"筆資料"

   #DISPLAY "l_dzeb_tmp.getLength() = ",l_dzeb_tmp.getLength()
   #自動配對有pk/fk的欄位,卻沒有對應的pk/fk欄位
   #FOR l_i = 1 TO l_dzeb_tmp.getLength()
      #DISPLAY l_dzeb_tmp[l_i].old_col_id
      #FOR l_j = 1 TO ga_dzeb.getLength()
         #IF ga_dzeb[l_j].old_col_key IS NULL AND ga_dzeb[l_j].new_col_key IS NOT NULL  THEN
            #DISPLAY  ga_dzeb[l_j].new_col_id
            #IF l_dzeb_tmp[l_i].old_col_key = ga_dzeb[l_j].new_col_key THEN
               #LET l_dzeb_tmp[l_i].new_col_id = ga_dzeb[l_j].new_col_id
               #LET l_dzeb_tmp[l_i].new_col_name = ga_dzeb[l_j].new_col_name
               #LET l_dzeb_tmp[l_i].new_col_key = ga_dzeb[l_j].new_col_key
               #LET ga_dzeb[l_j].new_col_id = NULL
               #LET ga_dzeb[l_j].new_col_name = NULL
               #LET ga_dzeb[l_j].new_col_key = NULL
            #ELSE
               #LET l_dzeb_tmp[l_i].new_col_id = ga_dzeb[l_j].new_col_id
               #LET l_dzeb_tmp[l_i].new_col_name = ga_dzeb[l_j].new_col_name
               #LET l_dzeb_tmp[l_i].new_col_key = ga_dzeb[l_j].new_col_key
               #LET ga_dzeb[l_j].new_col_id = NULL
               #LET ga_dzeb[l_j].new_col_name = NULL
               #LET ga_dzeb[l_j].new_col_key = NULL
            #END IF
            #EXIT FOR
         #END IF
      #END FOR
   #END FOR
#
   #FOR l_i = 1 TO l_dzeb_tmp.getLength()
      #FOR l_j = 1 TO ga_dzeb.getLength()
         #IF l_dzeb_tmp[l_i].old_col_id = ga_dzeb[l_j].old_col_id THEN
            #LET ga_dzeb[l_j].* = l_dzeb_tmp[l_i].*
         #END IF
      #END FOR
   #END FOR
   
END FUNCTION

#+ 搜尋父節點的ip
PRIVATE FUNCTION adzp270_search_parent_id(p_dzag004)
   DEFINE p_dzag004 LIKE dzag_t.dzag004,
          ls_return LIKE dzag_t.dzag002,
          l_cnt     LIKE type_t.num5

   FOR  l_cnt = 1 TO  ga_dzag_tree.getLength()
      IF ga_dzag_tree[l_cnt].table_id = p_dzag004 THEN
         LET  ls_return = ga_dzag_tree[l_cnt].current_id
         EXIT FOR
      END IF
   END FOR

   RETURN ls_return
END FUNCTION

#+ 錯誤訊息顯示
PRIVATE FUNCTION adzp270_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   #todo : 這段程式之後要改.
   DISPLAY "ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
   IF SQLCA.SQLCODE THEN
      CALL cl_err_msg(p_trigger, "adz-00001", SQLCA.SQLCODE, 1)
   ELSE
      CALL cl_err_msg(p_trigger, "adz-00001", NULL, 1)
   END IF
END FUNCTION

#+ 控制欄位可否輸入
PUBLIC FUNCTION adzp270_set_comp_entry(ps_fields, pi_entry)
  DEFINE ps_fields     STRING
  DEFINE pi_entry      LIKE type_t.num5
  DEFINE lst_fields    base.StringTokenizer
  DEFINE ls_field_name STRING
  DEFINE lwin_curr     ui.Window
  DEFINE lnode_win     om.DomNode
  DEFINE llst_items    om.NodeList
  DEFINE li_i          LIKE type_t.num5
  DEFINE lnode_item    om.DomNode
  DEFINE ls_item_name  STRING

  #IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]" THEN 
     #RETURN
  #END IF

  IF (ps_fields IS NULL) THEN
     RETURN
  END IF

  LET ps_fields = ps_fields.toLowerCase()

  LET lst_fields = base.StringTokenizer.create(ps_fields, ",")

  LET lwin_curr = ui.Window.getCurrent()
  LET lnode_win = lwin_curr.getNode()

  LET llst_items = lnode_win.selectByPath("//Form//*")

  WHILE lst_fields.hasMoreTokens()
    LET ls_field_name = lst_fields.nextToken()
    LET ls_field_name = ls_field_name.trim()

    #T6 只可以鎖定主要輸入頁面
    #IF NOT ls_field_name.getIndexOf("_t",1) OR NOT ls_field_name.getIndexOf("formonly.",1) THEN
       #LET ls_field_name = ls_field_name.subString(1,4),"_t.",ls_field_name
    #END IF

    IF (ls_field_name.getLength() > 0) THEN
       FOR li_i = 1 TO llst_items.getLength()
           LET lnode_item = llst_items.item(li_i)

           #先抓取Name (有含table.colname) 不存在再試抓 colName (不含table name)
           LET ls_item_name = lnode_item.getAttribute("name")

           IF (ls_item_name IS NULL) THEN
              LET ls_item_name = lnode_item.getAttribute("colName")

              IF (ls_item_name IS NULL) THEN
                 CONTINUE FOR
              END IF
           END IF

           LET ls_item_name = ls_item_name.trim()
           #DISPLAY "@@@@@@@@@@@@@@@@@@@@@@@@"
           #DISPLAY "ls_item_name = ",ls_item_name
           #DISPLAY "ls_field_name = ",ls_field_name
           IF (ls_item_name.equals(ls_field_name)) THEN
              IF (pi_entry) THEN
                 #DISPLAY "ls_item_name = ",ls_item_name,pi_entry
                 CALL lnode_item.setAttribute("noEntry", "0")
                 CALL lnode_item.setAttribute("active", "1")
              ELSE
                 #DISPLAY "ls_item_name = ",ls_item_name,pi_entry
                 CALL lnode_item.setAttribute("noEntry", "1")
                 CALL lnode_item.setAttribute("active", "0")
              END IF

              EXIT FOR
           END IF
       END FOR
    END IF
  END WHILE
END FUNCTION

#+ 儲存底稿設定
PRIVATE FUNCTION adzp270_save_setting_data()
   DEFINE l_cnt              LIKE type_t.num10,
          l_i                LIKE type_t.num10,
          l_prog_type        LIKE dzcl_t.dzcl001,
          l_source_prog      LIKE dzcl_t.dzcl002,
          l_gen_prog         LIKE dzcl_t.dzcl003,
          l_is_convert_table LIKE dzcl_t.dzcl004,
          l_dzclcrtid        LIKE dzcl_t.dzclcrtid,
          l_dzclcrtdp        LIKE dzcl_t.dzclcrtdp,
          l_dzclcrtdt        LIKE dzcl_t.dzclcrtdt,
          l_dzclownid        LIKE dzcl_t.dzclownid,
          l_dzclowndp        LIKE dzcl_t.dzclowndp,
          l_dzclmodid        LIKE dzcl_t.dzclmodid,
          l_dzclmoddt        LIKE dzcl_t.dzclmoddt

   LET l_prog_type =g_main_or_sub_prog CLIPPED
   LET l_source_prog = g_copy_source CLIPPED
   LET l_gen_prog = g_gen_prog CLIPPED
   LET l_is_convert_table = g_use_table_replace CLIPPED

   LET l_dzclcrtid = g_user
   LET l_dzclcrtdp = g_dept
   LET l_dzclcrtdt = cl_get_current()
   LET l_dzclownid = g_user
   LET l_dzclowndp = g_dept
   LET l_dzclmodid = g_user
   LET l_dzclmoddt = cl_get_current()

   SELECT COUNT(1) INTO l_cnt FROM dzcl_t
      WHERE dzcl001 = l_prog_type AND
            dzcl002 = l_source_prog AND
            dzcl003 = l_gen_prog AND
            dzcl004 = l_is_convert_table 
            AND dzclcrtid = g_user

   #DISPLAY "l_cnt l_cnt= ",l_cnt
   #DISPLAY "l_is_convert_table =",l_is_convert_table
   #DISPLAY "l_prog_type = ",l_prog_type
   #DISPLAY "l_source_prog = ",l_source_prog
   #DISPLAY "l_gen_prog = ",g_gen_prog

   IF l_cnt > 0 THEN
      DELETE FROM dzcl_t
         WHERE dzcl001 = l_prog_type AND
               dzcl002 = l_source_prog AND
               dzcl003 = l_gen_prog AND
               dzcl004 = l_is_convert_table 
               AND dzclcrtid = g_user

      DELETE FROM dzcm_t
         WHERE dzcm001 = l_prog_type AND
               dzcm002 = l_source_prog AND
               dzcm003 = l_gen_prog AND
               dzcm004 = l_is_convert_table 
               AND dzcmcrtid = g_user

      DELETE FROM dzcn_t
         WHERE dzcn001 = l_prog_type AND
               dzcn002 = l_source_prog AND
               dzcn003 = l_gen_prog AND
               dzcn004 = l_is_convert_table 
               AND dzcncrtid = g_user
   END IF

   INSERT INTO dzcl_t (dzcl001,dzcl002,dzcl003,dzcl004,dzclcrtid ,dzclcrtdp ,dzclcrtdt ,dzclownid ,dzclowndp ,dzclmodid ,dzclmoddt)
      VALUES (l_prog_type,l_source_prog,l_gen_prog,l_is_convert_table ,l_dzclcrtid ,l_dzclcrtdp ,l_dzclcrtdt ,l_dzclownid ,l_dzclowndp ,l_dzclmodid ,l_dzclmoddt)

   IF g_use_table_replace = "Y" THEN

      FOR l_i=1 TO ga_dzag.getLength()
         INSERT INTO dzcm_t (dzcm001,dzcm002,dzcm003,dzcm004,dzcm005,dzcm006,dzcmcrtid,dzcm007,dzcm008,dzcm009,dzcm010,dzcm011)
            VALUES (l_prog_type,l_source_prog,l_gen_prog,l_is_convert_table, 
                    ga_dzag[l_i].old_table_id ,ga_dzag[l_i].new_table_id ,l_dzclcrtid,
                    ga_dzag[l_i].old_table_parent,ga_dzag[l_i].old_table_main,ga_dzag[l_i].new_table_parent,ga_dzag[l_i].new_table_main,l_i)
      END FOR

      FOR l_i=1 TO ga_dzeb_stored.getLength()
         INSERT INTO dzcn_t (dzcn001,dzcn002,dzcn003,dzcn004,dzcn005,dzcn006,dzcn007,dzcn008,dzcn009,dzcncrtid)
         VALUES (l_prog_type,l_source_prog,l_gen_prog,l_is_convert_table,
                 ga_dzeb_stored[l_i].old_table_id,ga_dzeb_stored[l_i].old_col_id,
                 ga_dzeb_stored[l_i].relation_no,
                 ga_dzeb_stored[l_i].new_table_id,ga_dzeb_stored[l_i].new_col_id ,l_dzclcrtid)
      END FOR
   END IF
END FUNCTION

#+ 載入底稿設定
PRIVATE FUNCTION adzp270_import_setting_data()
   DEFINE l_cnt              LIKE type_t.num10,
          l_i                LIKE type_t.num10,
          l_prog_type        LIKE dzcl_t.dzcl001,
          l_source_prog      LIKE dzcl_t.dzcl002,
          l_gen_prog         LIKE dzcl_t.dzcl003,
          l_is_convert_table LIKE dzcl_t.dzcl004,
          l_sql              STRING,
          l_str_buf      base.StringBuffer,
          l_dzeb002      LIKE dzeb_t.dzeb001,
          l_old_prefix   STRING,
          l_new_prefix   STRING,
          l_dzed002      LIKE dzed_t.dzed002,
          l_dzed004      LIKE dzed_t.dzed004,
          l_dzclcrtid        LIKE dzcl_t.dzclcrtid

   LET l_prog_type = g_qryparam.return1
   LET l_source_prog = g_qryparam.return2
   LET l_gen_prog = g_qryparam.return3
   LET l_is_convert_table = g_qryparam.return4
   LET l_dzclcrtid = g_qryparam.return5

   #SELECT dzcl001,dzcl002,dzcl003,dzcl004 INTO l_prog_type,l_source_prog,l_gen_prog,l_is_convert_table
      #FROM dzcl_t
      #WHERE dzcl001 = l_prog_type AND 
            #dzcl002 = l_source_prog AND
            #dzcl003 = l_gen_prog AND 
            #dzcl004 = l_is_convert_table

   LET g_main_or_sub_prog = l_prog_type
   LET g_copy_source = l_source_prog
   LET g_gen_prog = l_gen_prog
   LET g_use_table_replace = l_is_convert_table

   #若程式存在於基礎資料則帶出程式的名稱
   CASE g_main_or_sub_prog
      WHEN "M"
         SELECT gzzal003 INTO g_copy_source_name
            FROM gzzal_t 
            WHERE gzzal001 = g_copy_source AND gzzal002 = g_lang

         SELECT gzzal003 INTO g_gen_prog_name
            FROM gzzal_t 
            WHERE gzzal001 = g_gen_prog AND gzzal002 = g_lang
            
         CALL adzp270_set_comp_entry( "formonly.lbl_old_table", FALSE)
         CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
         #CALL cl_ui_init()
         
      WHEN "S"
         SELECT gzdel003  INTO g_copy_source_name
            FROM gzde_t 
            LEFT JOIN gzdel_t 
            ON gzde001 = gzdel001 AND gzdel002 = g_lang
            WHERE gzde001=g_copy_source AND gzdestus = 'Y' AND gzde003 = 'S'

         SELECT gzdel003  INTO g_gen_prog_name
            FROM gzde_t 
            LEFT JOIN gzdel_t 
            ON gzde001 = gzdel001 AND gzdel002 = g_lang
            WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'S'
            
         CALL adzp270_set_comp_entry( "formonly.lbl_old_table", FALSE)
         CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
         #CALL cl_ui_init()
         
      WHEN "F"
         SELECT gzdfl003 INTO g_copy_source_name
            FROM gzdf_t
            LEFT JOIN gzdfl_t
            ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
            WHERE gzdf002 = g_copy_source

         SELECT gzdfl003 INTO g_gen_prog_name
            FROM gzdf_t
            LEFT JOIN gzdfl_t
            ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
            WHERE gzdf002 = g_gen_prog
            
         CALL adzp270_set_comp_entry( "formonly.lbl_old_table", TRUE)
         CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
         #CALL cl_ui_init()
         
      WHEN "SUB"
         SELECT gzdel003  INTO g_copy_source_name
            FROM gzde_t 
            LEFT JOIN gzdel_t 
            ON gzde001 = gzdel001 AND gzdel002 = g_lang
            WHERE gzde001=g_copy_source AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'

         SELECT gzdel003  INTO g_gen_prog_name
            FROM gzde_t 
            LEFT JOIN gzdel_t 
            ON gzde001 = gzdel001 AND gzdel002 = g_lang
            WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'
            
         CALL adzp270_set_comp_entry( "formonly.lbl_old_table", TRUE)
         CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",FALSE)

      WHEN "LIB"
         SELECT gzdel003  INTO g_copy_source_name
            FROM gzde_t 
            LEFT JOIN gzdel_t 
            ON gzde001 = gzdel001 AND gzdel002 = g_lang
            WHERE gzde001=g_copy_source AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'

         SELECT gzdel003  INTO g_gen_prog_name
            FROM gzde_t 
            LEFT JOIN gzdel_t 
            ON gzde001 = gzdel001 AND gzdel002 = g_lang
            WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'
            
         CALL adzp270_set_comp_entry( "formonly.lbl_old_table", TRUE)
         CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",FALSE)
         
   END CASE

   
   DISPLAY g_copy_source_name TO s_copy_source_name
   DISPLAY g_gen_prog_name TO s_gen_prog_name

   #若程式存在於基礎資料則帶出程式的名稱
   #CASE g_main_or_sub_prog
      #WHEN "M"
         #SELECT gzzal003 INTO g_gen_prog_name
            #FROM gzzal_t 
            #WHERE gzzal001 = g_gen_prog AND gzzal002 = g_lang
      #WHEN "S"
         #SELECT gzdel003  INTO g_gen_prog_name
            #FROM gzde_t 
            #LEFT JOIN gzdel_t 
            #ON gzde001 = gzdel001 AND gzdel002 = g_lang
            #WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'S'
      #WHEN "F"
         #SELECT gzdfl003 INTO g_gen_prog_name
            #FROM gzdf_t
            #LEFT JOIN gzdfl_t
            #ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
            #WHERE gzdf002 = g_gen_prog
      #WHEN "SUB"
         #SELECT gzdel003  INTO g_gen_prog_name
            #FROM gzde_t 
            #LEFT JOIN gzdel_t 
            #ON gzde001 = gzdel001 AND gzdel002 = g_lang
            #WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'
      #WHEN "LIB"
         #SELECT gzdel003  INTO g_gen_prog_name
            #FROM gzde_t 
            #LEFT JOIN gzdel_t 
            #ON gzde001 = gzdel001 AND gzdel002 = g_lang
            #WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'
   #END CASE
   #DISPLAY g_gen_prog_name TO s_gen_prog_name

   #匯入表格設定資料
   LET l_sql = "SELECT dzcm005 ,dzcm006 ,dzcm007 ,dzcm008 ,dzcm009 ,dzcm010,dzcm011",
               "  FROM dzcm_t ",
               "  WHERE dzcm001 = '",l_prog_type,"' AND dzcm002 = '",l_source_prog,
               "' AND dzcm003 = '",l_gen_prog,"' AND dzcm004 = '",l_is_convert_table,"' ",
               "  AND dzcmcrtid = '",l_dzclcrtid,"' ",
               "  ORDER BY CAST(dzcm011 AS INTEGER)"
               
   PREPARE adzp270_table_pre FROM l_sql
   DECLARE adzp270_table_cs CURSOR FOR adzp270_table_pre

   CALL ga_dzag.clear()

   LET l_i = 1
   FOREACH adzp270_table_cs INTO ga_dzag[l_i].old_table_id,ga_dzag[l_i].new_table_id,ga_dzag[l_i].old_table_parent,ga_dzag[l_i].old_table_main,ga_dzag[l_i].new_table_parent,ga_dzag[l_i].new_table_main,ga_dzag[l_i].pair_no
 
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF

      SELECT dzeal003 INTO ga_dzag[l_i].old_table_name
               FROM dzeal_t 
               WHERE dzeal001 = ga_dzag[l_i].old_table_id AND dzeal002=g_lang

      SELECT dzeal003 INTO ga_dzag[l_i].new_table_name
               FROM dzeal_t 
               WHERE dzeal001 = ga_dzag[l_i].new_table_id AND dzeal002=g_lang

      LET l_i = l_i + 1
   END FOREACH
   
   CALL ga_dzag.deleteElement(l_i)

   #匯入欄位設定資料
   LET l_sql = "SELECT dzcn005,dzcn006,dzcn007,dzcn008,dzcn009 ",
               "  FROM dzcn_t ",
               "  WHERE dzcn001 = '",l_prog_type,"' AND dzcn002 = '",l_source_prog,
               "' AND dzcn003 = '",l_gen_prog,"' AND dzcn004 = '",l_is_convert_table,"' ",
               "  AND dzcncrtid = '",l_dzclcrtid,"' ",
               "  ORDER BY dzcn005,cast(dzcn007 as integer)"
               
   PREPARE adzp270_column_pre FROM l_sql
   DECLARE adzp270_column_cs CURSOR FOR adzp270_column_pre

   CALL ga_dzeb_stored.clear()
   CALL ga_dzeb.clear()
   CALL ga_excluded_col.clear()

   LET l_i = 1
   FOREACH adzp270_column_cs INTO ga_dzeb_stored[l_i].old_table_id,ga_dzeb_stored[l_i].old_col_id,ga_dzeb_stored[l_i].relation_no,ga_dzeb_stored[l_i].new_table_id,ga_dzeb_stored[l_i].new_col_id
 
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF

      SELECT dzebl003 INTO ga_dzeb_stored[l_i].new_col_name
         FROM dzeb_t
         LEFT JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002=g_lang
         WHERE dzeb001=ga_dzeb_stored[l_i].new_table_id AND dzeb002 = ga_dzeb_stored[l_i].new_col_id

      SELECT dzebl003 INTO ga_dzeb_stored[l_i].old_col_name
         FROM dzeb_t
         LEFT JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002=g_lang
         WHERE dzeb001=ga_dzeb_stored[l_i].old_table_id AND dzeb002 = ga_dzeb_stored[l_i].old_col_id

         #去除舊表格代號的'_t'
         LET l_old_prefix = ga_dzeb_stored[l_i].old_table_id
         LET l_old_prefix = l_old_prefix.trim()
         LET l_old_prefix = l_old_prefix.subString(1,l_old_prefix.getLength()-2)

         #去除新表格代的'_t'
         LET l_new_prefix = ga_dzeb_stored[l_i].new_table_id
         LET l_new_prefix = l_new_prefix.trim()
         LET l_new_prefix = l_new_prefix.subString(1,l_new_prefix.getLength()-2)

         #尋找新欄位的pk
         LET l_dzed002 = l_new_prefix.trim(),"_pk"
         LET l_dzed004 = "%",ga_dzeb_stored[l_i].new_col_id,"%"
         LET l_cnt = 0

         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzeb_stored[l_i].new_table_id AND
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004 

         IF l_cnt > 0 THEN
            LET  ga_dzeb_stored[l_i].new_col_key = ga_dzeb_stored[l_i].new_col_key , "PK"
         END IF

         #尋找新欄位的fk
         LET l_dzed002 = l_new_prefix.trim(),"_fk"
         LET l_dzed004 = "%",ga_dzeb_stored[l_i].new_col_id,"%"
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzeb_stored[l_i].new_table_id AND
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004 

         IF l_cnt > 0 THEN
            LET  ga_dzeb_stored[l_i].new_col_key = ga_dzeb_stored[l_i].new_col_key ,",FK"
         END IF
--
         #尋找舊欄位的pk
         LET l_dzed002 = l_old_prefix.trim(),"_pk"
         LET l_dzed004 =  "%",ga_dzeb_stored[l_i].old_col_id,"%"
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzeb_stored[l_i].old_table_id AND
                  dzed002= l_dzed002 AND 
                  dzed004 LIKE l_dzed004

         IF l_cnt > 0 THEN
            LET  ga_dzeb_stored[l_i].old_col_key = ga_dzeb_stored[l_i].old_col_key , "PK"
         END IF

         #尋找舊欄位的fk
         LET l_dzed002 = l_old_prefix.trim(),"_fk"
         LET l_dzed004 =  "%",ga_dzeb_stored[l_i].old_col_id,"%"
         LET l_cnt = 0
      
         SELECT COUNT(1) INTO l_cnt FROM dzed_t
            WHERE dzed001=ga_dzeb_stored[l_i].old_table_id AND
                  dzed002= l_dzed002 AND
                  dzed004 LIKE l_dzed004 

         IF l_cnt > 0 THEN
            LET  ga_dzeb_stored[l_i].old_col_key = ga_dzeb_stored[l_i].old_col_key , ",FK"
         END IF

      LET l_i = l_i + 1
   END FOREACH
   
   CALL ga_dzeb_stored.deleteElement(l_i)

END FUNCTION


#+ 載入底稿設定
PRIVATE FUNCTION adzp270_filter_column_data()
   DEFINE l_i LIKE type_t.num10,
          l_j LIKE type_t.num10,
          l_k LIKE type_t.num10,
          l_cnt LIKE type_t.num10
   
   

   #將編輯用的新舊欄位對應表中的資料加入儲存用的新舊欄位對應表
   FOR l_i =1 TO ga_dzeb.getLength()

      #篩選可以加入儲存用的新舊欄位對應表的資料
      FOR l_j=1 TO ga_dzeb_stored.getLength()
         #刪除儲存用的新舊欄位對應表中與編輯用的新舊欄位對應表中重複的資料
         IF ga_dzeb_stored[l_j].old_col_id = ga_dzeb[l_i].old_col_id THEN
            CALL ga_dzeb_stored.deleteElement(l_j)
            EXIT FOR
         END IF
      END FOR

      #新舊欄位對應表中的舊表格名稱必須與表格對應關係表中存在,再放入編輯用的新舊欄位對應表中
      FOR l_j=1 TO ga_dzag.getLength()
         LET l_cnt = 0
         IF ga_dzag[l_j].old_table_id = ga_dzeb[l_i].old_table_id THEN
            LET l_cnt = 1
            EXIT FOR
         END IF
      END FOR

      IF l_cnt = 1 THEN
         #加入編輯用的新舊欄位對應表的資料到儲存用的新舊欄位對應表,
         #保持儲存用的新舊欄位對應表
         CALL ga_dzeb_stored.appendElement()
         LET ga_dzeb_stored[ga_dzeb_stored.getLength()].* = ga_dzeb[l_i].*
      END IF
      
   END FOR

   #去除在儲存用的新舊欄位對應表中與表格對應關係表中沒有對應的資料
   FOR l_i =1 TO ga_dzeb_stored.getLength()
      LET l_cnt = 0
      FOR l_j = 1 TO ga_dzag.getLength()
         
         IF ga_dzeb_stored[l_i].old_table_id = ga_dzag[l_j].old_table_id AND ga_dzeb_stored[l_i].new_table_id = ga_dzag[l_j].new_table_id THEN
            LET l_cnt = 1 
            EXIT FOR
         END IF
      END FOR
      IF l_cnt = 0 THEN
         CALL ga_dzeb_stored.deleteElement( l_i)
         LET l_i = l_i - 1 
      END IF
   END FOR

   FOR l_i =1 TO ga_dzeb.getLength()
      LET l_cnt = 0
      FOR l_j = 1 TO ga_dzag.getLength()
         
         IF ga_dzeb[l_i].old_table_id = ga_dzag[l_j].old_table_id AND ga_dzeb[l_i].new_table_id = ga_dzag[l_j].new_table_id THEN
            LET l_cnt = 1 
            EXIT FOR
         END IF
      END FOR
      IF l_cnt = 0 THEN
         CALL ga_dzeb.deleteElement( l_i)
         LET l_i = l_i - 1 
      END IF
   END FOR
END FUNCTION

#+ 檢查父子Table之間的外來鍵是否設定完整 -程式來源 ： r.a
PRIVATE FUNCTION adzp270_table_fkchk(p_tb1,p_tb2,p_type,p_ischild)
   DEFINE p_tb1       LIKE dzed_t.dzed001   #table代號 (子)
   DEFINE p_tb2       LIKE dzed_t.dzed005   #外來鍵表格 (父)
   DEFINE p_type      LIKE dzed_t.dzed003   #鍵值形式
   DEFINE l_type_msg  LIKE dzed_t.dzed003   #鍵值形式 for msg
   DEFINE p_ischild   BOOLEAN               #table代號是否為外來鍵表格的下階層
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_j         LIKE type_t.num5
   DEFINE l_tb1_idx   LIKE type_t.num5
   DEFINE l_tb2_idx   LIKE type_t.num5      #外來鍵表格index
   DEFINE l_dzed004   LIKE dzed_t.dzed004   #鍵值欄位
   DEFINE l_dzed006   LIKE dzed_t.dzed006   #外來鍵欄位
   DEFINE l_str       STRING
   DEFINE l_tok       base.StringTokenizer
   DEFINE l_tmp       STRING
   DEFINE l_chk       BOOLEAN
   DEFINE l_sql       STRING

   DEFINE l_pk            DYNAMIC ARRAY OF RECORD
      dzeb001   LIKE dzeb_t.dzeb001,         #table代號
      dzeb002   LIKE dzeb_t.dzeb002,         #欄位代號
      l_chk     BOOLEAN
      END RECORD

   #PK,需要和FK比對時使用
   LET l_sql = "SELECT dzeb002 FROM dzeb_t WHERE dzeb001 = ? AND dzeb004 = 'Y'"
   PREPARE adzp270_col_pk_pre2 FROM l_sql
   DECLARE adzp270_col_pk_cur2 CURSOR FOR adzp270_col_pk_pre2

   

   #資料表鍵值檔by 鍵值形式P,F - 鍵值欄位
   LET l_sql = "SELECT dzed004 FROM dzed_t WHERE dzed001 = ? AND dzed003 = ? AND dzed005 = ?"
   PREPARE adzp270_col_pkfk_2 FROM l_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('PREPARE:',SQLCA.sqlcode,0)
   END IF
   DECLARE adzp270_col_pkfkcur_2 CURSOR FOR adzp270_col_pkfk_2


   #資料表鍵值檔by 鍵值形式P,F - 外來鍵欄位
   LET l_sql = "SELECT dzed006 FROM dzed_t WHERE dzed001 = ? AND dzed003 = ? AND dzed005 = ?"
   PREPARE adzp270_col_pkfk_3 FROM l_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('PREPARE:',SQLCA.sqlcode,0)
   END IF
   DECLARE adzp270_col_pkfkcur_3 CURSOR FOR adzp270_col_pkfk_3

   
   LET l_chk = FALSE

   LET l_sql = "SELECT COUNT(dzed002) FROM dzed_t WHERE dzed001 = ? AND dzed003 = ? AND dzed005 = ?"
   PREPARE adzp270_table_fkchk_fk FROM l_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('PREPARE:',SQLCA.sqlcode,0)
   END IF
   EXECUTE adzp270_table_fkchk_fk USING p_tb1,p_type,p_tb2 INTO l_cnt

   CASE p_type
      WHEN "F"
         LET l_type_msg = "Foreign"
      #WHEN "P"
      #   LET l_type_msg = "Primary Key"
   END CASE

   IF l_cnt = 0 THEN
      CALL cl_err_msg(NULL, "adz-00051", p_tb1 CLIPPED || "|" || p_tb2 CLIPPED , 1)  #%1中沒有設來自於%2的外來鍵
   ELSE
      LET l_tb2_idx = 0
      FOR l_i = 2 TO ga_dzag.getLength()
         IF ga_dzag[l_i].new_table_parent = p_tb2 THEN
            LET l_tb2_idx = l_i
         END IF
      END FOR

      #DISPLAY "l_tb2_idx = ",l_tb2_idx

      #父PK是否都有設在子的FK
      LET l_cnt = 0
      LET l_j = 1
      CALL l_pk.clear()
      FOREACH adzp270_col_pk_cur2 USING p_tb2 INTO l_pk[l_j].dzeb002   #父PK
         LET l_pk[l_j].dzeb001 = p_tb2 CLIPPED
         LET l_pk[l_j].l_chk = FALSE

         FOREACH adzp270_col_pkfkcur_3 USING p_tb1,'F',p_tb2 INTO l_dzed006
            LET l_str = l_dzed006 CLIPPED
            LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
            WHILE l_tok.hasMoreTokens()	#依序取得子字串
               LET l_tmp = l_tok.nextToken()
               LET l_tmp = l_tmp.trim()

               IF l_tmp = l_pk[l_j].dzeb002 THEN
                  LET l_pk[l_j].l_chk = TRUE
                  EXIT WHILE
               END IF
            END WHILE
         END FOREACH

         #父PK沒設於子FK
         IF NOT l_pk[l_j].l_chk THEN
            LET l_chk = FALSE
            EXIT FOREACH
         ELSE
            LET l_chk = TRUE
         END IF

         LET l_j = l_pk.getLength() + 1
      END FOREACH
      CALL l_pk.deleteElement(l_j)

      LET l_cnt = l_pk.getLength()

      IF NOT l_chk THEN
         CALL cl_err_msg(NULL, "adz-00079", p_tb1 CLIPPED || "|" || p_tb2 CLIPPED , 1)  #%1的外來鍵需要包含%2的全部主鍵
      END IF

      #PK數量與FK數量比對
      IF l_chk THEN
         LET l_cnt = 0
         LET l_j = 1
         CALL l_pk.clear()

         FOREACH adzp270_col_pk_cur2 USING p_tb1 INTO l_pk[l_j].dzeb002   #單身PK
            LET l_pk[l_j].dzeb001 = p_tb1 CLIPPED
            LET l_pk[l_j].l_chk = FALSE

            FOREACH adzp270_col_pkfkcur_2 USING p_tb1,'F',p_tb2 INTO l_dzed004
               LET l_str = l_dzed004 CLIPPED
               LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
               WHILE l_tok.hasMoreTokens()	#依序取得子字串
                  LET l_tmp = l_tok.nextToken()
                  LET l_tmp = l_tmp.trim()

                  IF l_tmp = l_pk[l_j].dzeb002 THEN #排除PK = FK
                     CALL l_pk.deleteElement(l_j)
                     EXIT WHILE
                  END IF
               END WHILE
            END FOREACH

            LET l_j = l_pk.getLength() + 1
         END FOREACH
         CALL l_pk.deleteElement(l_j)

         LET l_cnt = l_pk.getLength()


         #主Table的下階層Table,要有自己的PK(PK數量多於FK)
         IF p_ischild THEN
            IF l_cnt > 0 THEN    #PK數量 > FK數量
               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
               CALL cl_err_msg(NULL, "adz-00080", p_tb1 CLIPPED || "|" || p_tb2 CLIPPED , 1)  #主Table的下階層Table %1,要有自己的主鍵(非屬於來自%2的外來鍵)
            END IF
         ELSE
         #主Table的同階層Table,外來鍵必須完全等於主Table
            IF l_cnt = 0 THEN    #PK數量 = FK數量
               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
               CALL cl_err_msg(NULL, "adz-00081", p_tb1 CLIPPED || "|" || p_tb2 CLIPPED , 1)  #主Table的同階層Table %1,外來鍵必須完全等於主Table %2的主鍵
            END IF
         END IF

      END IF

   END IF

   RETURN l_chk
END FUNCTION
