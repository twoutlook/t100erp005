#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp600
#+ 設計人員......: madey
#+ 功能名稱說明...: 行業規格與程式產生工具
#+ 修改歷程......: 2014/04/10 by madey : 建立程式
#                  2014/07/16 by madey : 配合cl_err改版調整
#                  2014/08/14 by madey : 新增dzax_t時dzaxstus給Y
#                  2014/09/02 by madey : 1.修正inset dzfs_t.dzfs001沒給1的bug
#                                        2.目標程式是free style但來源程式不是free style不提示
#                                        3.r.c3參數調整
#                                        4.複製dzbc_t增加欄位dzbc009,dzbc010,dzbc011
#                  2014/09/03 by madey : adzp600_delete_file改寫法,全砍
#                  2014/09/15 by madey : 1.因應一些DATE型態欄位改成TIMESTAMP調整sql,將l_dagte換成SYSTIMESTAMP
#                                        2.調整copy sql 寫法以增加閱讀性幫助除錯
#                  2014/09/22 by madey : 因應版次欄物型態改變而調整(varchar -> number)
#                  2014/09/26 by madey : r.f帶參數tiptop不自動關聯42s
#                  2014/10/03 by madey  :調整gzde008,gzdf003,gzza011的條件判斷:Y-->c;N-->s
#                  2014/10/06 by madey  :dzax_t增加欄位dzax007
#                  2014/10/16 by madey  :1.新增debug mode:不檢查簽出權限
#                                        2.調整檢查目標程式權限及版次順序，先版次再權限
#                  2014/11/20 by madey  :刪除設計資料由sadzp062_1_del_spec_data()改用sadzp063_1_del_all_design_data()
#                  2014/12/18 by madey  :新增dzax_t時,dzax004(本版次異動)給N
#                  2015/01/05 by madey  :r.f後多串azzp191產生多語言
#                  2015/01/29 by madey  :來源程式不可以為free style
#                  2015/05/05 by madey  :針對:取替代dzbb098時還原來源程式的子程式/子畫面/應用元件id這條規則-> 停用
#                  2015/09/08 by Hiko   :錯誤訊息'來源程式不可以為free style'傳遞的參數調整.
#                  2016/02/23 by elena  :更改複製來源程式、規格是否有設計資料檢核條件
#                  20160523   by elena  :freestyle開放複製
#                  20160729   by elena  :subPara增加g_source_type資料內容

IMPORT os
 
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp270.inc"
&include "../4gl/sadzp000_type.inc"
 
DEFINE   g_source_prog        LIKE dzaa_t.dzaa001, 　    #來源程式
         g_source_prog_name   LIKE gzzal_t.gzzal003,     #來源程式名稱
         g_source_type        LIKE gzde_t.gzde003,       #來源程式類型
         g_source_module      LIKE gzde_t.gzde002,       #來源程式模組別  
        #g_source_ver         LIKE dzaa_t.dzaa002, 　    #來源建構版次    #20140922:mark
         g_source_ver         STRING, 　                 #來源建構版次    #20140922:edit
         g_source_ver_desc    STRING,              　    #來源建構版次
        #g_source_spec_ver    LIKE dzaa_t.dzaa002,       #來源規格版次    #20140922:mark
         g_source_spec_ver    STRING,                    #來源規格版次    #20140922:edit
         g_source_spec_ver_col LIKE dzaa_t.dzaa002,      #來源規格版次    #20140922:add
        #g_source_code_ver    LIKE dzaa_t.dzaa002,       #來源代碼版次    #20140922:mark
         g_source_code_ver    STRING,                    #來源代碼版次    #20140922:edit
         g_source_code_ver_col LIKE dzaa_t.dzaa002,      #來源代碼版次    #20140922:add
         g_source_identity    LIKE dzaf_t.dzaf010,       #來源識別標示 
         g_source_4fd_path    STRING,              　    #來源程式的4FD檔的檔案路徑
         g_source_4rp_path    STRING,              　    #來源程式的4RP檔的檔案路徑
         g_source_free_style  LIKE dzax_t.dzax003,       #來源程式是否是free style
         g_gen_prog           LIKE dzaa_t.dzaa001, 　    #目標程式
         g_gen_prog_name      LIKE gzzal_t.gzzal003,     #目標程式名稱
         g_gen_type           LIKE gzde_t.gzde003,       #目標程式類型
         g_gen_module         LIKE gzde_t.gzde002,       #目標程式模組別  
        #g_gen_ver            LIKE dzaa_t.dzaa002, 　    #目標建構版次       #20140922:mark
         g_gen_ver            STRING,              　    #目標建構版次       #20140922:edit
         g_gen_ver_desc       STRING,              　    #目標建構版次 #20140410:madey
        #g_gen_code_ver       LIKE dzaa_t.dzaa002,       #目標程式代碼版次   #20140922:mark
         g_gen_code_ver       STRING,                    #目標程式代碼版次   #20140922:edit
        #g_gen_spec_ver       LIKE dzaa_t.dzaa002, 　    #目標程式的規格版次 #20140922:mark
         g_gen_spec_ver       STRING, 　                 #目標程式的規格版次 #20140922:edit
         g_gen_identity       LIKE dzaf_t.dzaf010,       #目標程式識別標示
        #g_gen_design_point_ver  LIKE dzaa_t.dzaa004,    #目標程式的設計點版次(識別碼版次)  #20140922:mark
         g_gen_design_point_ver  STRING,                 #目標程式的設計點版次(識別碼版次)  #20140922:edit
         g_gen_4fd_path       STRING,              　    #目標程式的4FD檔的檔案路徑
         g_gen_4rp_path       STRING,              　    #目標程式的4RP檔的檔案路徑
         g_gen_free_style     LIKE dzax_t.dzax003,       #目標程式是否是free style
         g_gen_role           STRING,                    #目標程式角色SD/PR/ALL
         g_gen_delete_kind    STRING,                    #目標程式刪除哪些資料SPEC/CODE/ALL #20140725:madey

         g_main_or_sub_prog   STRING,              　    #主程式和畫面/子程式和畫面/子畫面
         ms_dgenv             LIKE dzaf_t.dzaf010,       #環境變數DGENV (s:標準/ c:客製)
         ms_cust              LIKE dzaf_t.dzaf009,       #環境變數CUST (客戶代號)  
         ms_erp               STRING,              　    #TIPTOP起始目錄
         ms_erpver            STRING,              　    #TIPTOP版本
         ms_zone              STRING,              　    #執行區域
         g_pro_msg            STRING,                    #處理過程訊息
         ga_gzzd_t            DYNAMIC ARRAY OF RECORD    #畫面元件多語言記錄檔    
            source_label　　  LIKE gzzd_t.gzzd003,       #來源程式的標籤
            gen_label         LIKE gzzd_t.gzzd003        #產生程式的標籤
                              END RECORD,
         ga_gzzq_t            DYNAMIC ARRAY OF RECORD    #ACTION多語言對照檔
            gzzq002     　　　　  LIKE gzzq_t.gzzq002    #功能編號
                              END RECORD,
         g_use_current_sub_prog LIKE type_t.chr1,        #是否使用原本的子程式
         ga_dzag  DYNAMIC ARRAY OF RECORD                #新舊表格對應表
            old_table_id       LIKE dzag_t.dzag002,
            old_table_name     LIKE dzeal_t.dzeal003,
            old_table_parent   LIKE dzag_t.dzag004,
            old_table_main     LIKE dzag_t.dzag005,
            new_table_id       LIKE dzag_t.dzag002,
            new_table_name     LIKE dzeal_t.dzeal003,
            new_table_parent   LIKE dzag_t.dzag004,
            new_table_main     LIKE dzag_t.dzag005,
            pair_no            LIKE type_t.num5
         END RECORD
        #20150505 將ga_sub_prog停用 :mark -Begin-
        #ga_sub_prog  DYNAMIC ARRAY OF RECORD            #此主程式會用到的子元件或作業
        #   sub_prog_id    LIKE dzaa_t.dzaa001,
        #   sub_prog_name  LIKE dzaa_t.dzaa001,
        #   sub_prog_tmp_id LIKE dzaa_t.dzaa001,
        #   sub_prog_type LIKE type_t.chr1               #類別: S子程式  F子畫面  B應用元件 add by madey 20140312
        # END RECORD 
        #20150505 將ga_sub_prog停用 :mark -End-

DEFINE    g_run_mode LIKE type_t.chr20 #20141016

DEFINE subPara type_para,                                    #20150525
       sub_dzag DYNAMIC ARRAY OF dzag_type,
       sub_dzeb_stored DYNAMIC ARRAY OF type_col_relation

#+ 作業開始
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS
     INPUT WRAP
   
   CALL cl_tool_init()   

   #20150519 elena add
   IF FGL_GETENV("DGENV") = "c" OR g_account ="topstd" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00525"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF

   #Begin:20160324 by elena  行業區域才可執行
   IF NOT sadzp060_ind_check_area() THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00811"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   #End:20160324 by elena

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzp600 WITH FORM cl_ap_formpath("adz",g_prog)

   CLOSE WINDOW screen

   CALL adzp600_init()

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   
   CALL adzp600_input()
 
   #畫面關閉
   CLOSE WINDOW w_adzp600
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN


#+ 初始化變數
PRIVATE FUNCTION adzp600_init()
   LET g_run_mode = ARG_VAL(2)
   IF NOT cl_null(g_run_mode) THEN
      DISPLAY "執行模式:",g_run_mode
   END IF

   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED    #環境變數DGENV  (s:標準/ c:客製)
   LET ms_cust = FGL_GETENV("CUST") CLIPPED      #環境變數CUST   (客戶代號)
   LET ms_erp = FGL_GETENV("ERP") CLIPPED        #環境變數ERP    (TIPTOP起始目錄)
   LET ms_erpver = FGL_GETENV("ERPVER") CLIPPED  #環境變數ERPVER (TIPTOP版本)
   LET ms_zone = FGL_GETENV("ZONE") CLIPPED      #環境變數ZONE   (執行區域)
   CALL cl_set_comp_visible("page_table_replace",FALSE)#隱藏表格替換設定區
   LET g_use_current_sub_prog = "Y" ###測試用：

   LET g_main_or_sub_prog = ''
   LET g_source_prog      = ''
   LET g_source_prog_name = ''
   LET g_source_type      = ''
   LET g_source_module    = ''
   LET g_source_ver       = ''
   LET g_source_ver_desc  = ''
   LET g_source_spec_ver  = ''
   LET g_source_code_ver  = ''
   LET g_source_free_style= 'N'
   LET g_gen_prog         = ''
   LET g_gen_prog_name    = ''
   LET g_gen_type         = ''
   LET g_gen_module       = ''
   LET g_gen_ver          = ''
   LET g_gen_ver_desc     = ''
   LET g_gen_code_ver     = ''
   LET g_gen_spec_ver     = ''
   LET g_gen_free_style   = 'N'
   LET g_gen_design_point_ver = '1'
   LET g_gen_role         = 'ALL'
   LET g_gen_delete_kind  = 'ALL' #20140725:madey
  
   LET g_action_choice = ''
   CALL adzp600_show()
   
END FUNCTION


#+ 資料輸入
PRIVATE FUNCTION adzp600_input()
   DEFINE lb_result BOOLEAN,
          ln_cnt    LIKE type_t.num5,
          ls_str    STRING 


      INPUT g_gen_prog FROM s_gen_prog   ATTRIBUTE(UNBUFFERED,WITHOUT DEFAULTS)

         BEFORE INPUT
            CALL cl_set_act_visible("accept,cancel", FALSE)
           #display 'before input'

         ON CHANGE s_gen_prog
           #display 'on change'

         #複製目標 
         BEFORE FIELD s_gen_prog
           #display 'before field'

         #複製目標 欄位的校驗
         AFTER FIELD s_gen_prog
            IF NOT cl_null(g_gen_prog) THEN
              IF NOT adzp600_prog_validate() THEN
                    CALL adzp600_init() 
                    NEXT FIELD s_gen_prog
              ELSE 
                #CALL adzp600_get_prog_relation()  #copy from adzp270_gen_table_relation #20150505:mark
                 CALL adzp600_show()
              END IF
            END IF

         AFTER INPUT
            CASE g_action_choice
               #開始複製
               WHEN "btn_begin_copy"
                  #做來源程式的free style和 產生程式的 free style檢驗:
                  #--如果產生程式不是Free Style 而 來源程式是 Free Style,詢問是否在複製過程自動將 產生程式 改 Free Style
                  IF g_gen_free_style = "N" AND g_source_free_style = "Y" THEN
                     IF cl_ask_confirm_parm("adz-00246","") THEN
                     ELSE
                        CONTINUE INPUT
                     END IF 
                  END IF
                ###--如果產生程式是Free Style 而 來源程式不是 Free Style,詢問是否在複製過程自動將 產生程式 改 Free Style
                ##IF g_gen_free_style = "Y" AND g_source_free_style = "N" THEN
                ##   IF cl_ask_confirm_parm("adz-00247","") THEN 
                ##   ELSE
                ##      CONTINUE INPUT
                ##   END IF
                ##END IF

                  #儲存底稿
                  #CALL adzp600_save_setting_data()

                 ##確認有無權限(含簽出)
                 ##指定g_gen_role:有些類型要防呆(給正確的role),因為check_out給ALL寫入dzlm時會同時寫入SD及PR欄位 IF p_role="ALL" THEN 
                 #CASE g_gen_type
                 #  WHEN "F" #子畫面只有規格
                 #     LET g_gen_role = "SD"
                 #  OTHERWISE
                 #     LET g_gen_role = "ALL"
                 #END CASE
                 #IF sadzp060_2_check_out_prog(g_gen_prog,g_gen_prog_name,g_gen_module,g_gen_type,g_gen_role) THEN
                     #如果設計資料存在詢問是否刪除？
                     IF adzp600_check_design_data_exist() THEN
                        #設計資料確實存在 
                        IF cl_ask_confirm_parm("adz-00049",g_gen_prog) THEN  #是否清除此版本的規格和版本相關資料
                           IF cl_ask_confirm_parm("adz-00145","") THEN       #再次確認是否刪除
                              #選擇是
                              #刪除設計資料
                              CALL sadzp063_1_del_all_design_data(g_gen_prog) RETURNING lb_result,ls_str #20141120
                              IF lb_result THEN
                                 #開始複製規格與程式流程
                                 IF adzp600_copy_process() THEN
                                   #CALL FGL_WINMESSAGE( "", "Process succeeded!", "" )
                                   #行業別程式已成功產生，請再透過設計器依需求進行微調
                                    CALL cl_ask_pressanykey("adz-00280")
                                 ELSE
                                    CALL FGL_WINMESSAGE( "", "Process failed!", "" )
                                 END IF
                                 
                                 #顯示複製程序有無錯誤
                                 DISPLAY g_pro_msg
                              ELSE
                                 DISPLAY "刪除設計資料失敗:",ls_str
                                 CALL FGL_WINMESSAGE( "",ls_str, "" ) #20141120
                              END IF
                           ELSE
                              #再次確認是否刪除設計資料時,選擇否
                           END IF
                        END IF
                     ELSE
                        #設計資料不存在
                     
                        #複製規格與程式流程
                        IF adzp600_copy_process() THEN
                          #CALL FGL_WINMESSAGE( "", "Process succeeded!", "" )
                          #行業別程式已成功產生，請再透過設計器依需求進行微調
                           CALL cl_ask_pressanykey("adz-00280")
                        ELSE
                           CALL FGL_WINMESSAGE( "", "Process failed!", "" )
                        END IF
                        DISPLAY g_pro_msg
                     END IF
                 #ELSE 
                 #   #無權限或簽出失敗
                 #END IF

               OTHERWISE 
                  CONTINUE INPUT
            END CASE

            CONTINUE INPUT

         #複製目標 欄位的開窗
         ON ACTION controlp INFIELD s_gen_prog
            #clear
            CALL adzp600_init() 

            #開窗
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzb001()
            LET g_gen_prog = g_qryparam.return1
            LET g_gen_prog_name = g_qryparam.return2
            LET g_source_prog = g_qryparam.return3
           #CALL DIALOG.setFieldTouched("s_gen_prog", TRUE)

            IF NOT cl_null(g_gen_prog) THEN
             ##除了show(),其他留給AFTER FIELD處理
             ##IF NOT adzp600_prog_validate() THEN
             ##      CALL adzp600_init() 
             ##      NEXT FIELD s_gen_prog
             ##ELSE 
             ##   CALL adzp600_get_prog_relation()  #copy from adzp270_gen_table_relation
                  CALL adzp600_show()
             ##END IF
            END IF
     
 
         ON ACTION btn_begin_copy #開始複製
           LET g_pro_msg = ""

           #檢查產生的程式是否有輸入,
           IF cl_null(g_gen_prog) THEN
              CALL adzp600_init() 
              NEXT FIELD s_gen_prog
           END IF
        
           LET g_action_choice = "btn_begin_copy"
           ACCEPT INPUT
           #此處寫ACCEPT INPUT的原因,是因為
           #1.user輸入g_gen_prog後就直接點選action ,而沒有先按enter鍵,
           #2.user並非且透過開窗程式選g_gen_prog
           #以上兩個原因都會造成無法觸發adzp600_prog_validate()段,所以透過ACCEPT INPUT觸發ON CHANGE及AFTER FIELD

         ON ACTION btn_cancel     #離開
            EXIT INPUT
         
         ON ACTION close          #在dialog 右上角 (X)
            EXIT INPUT
         
         ON ACTION exit           #toolbar 離開
            EXIT INPUT
         
         #交談指令共用ACTION
          &include "common_action.4gl" 
               
      END INPUT
    
END FUNCTION


#+ 複製規格與程式流程
PRIVATE FUNCTION adzp600_copy_process()
   DEFINE lb_flag        LIKE type_t.num5,
          ls_form_style  LIKE dzfq_t.dzfq001,
          l_cmd          STRING,
          lb_del         LIKE type_t.num5,
          ls_path        STRING,
          ls_retinfo     STRING,
          l_cnt          LIKE type_t.num5,
          l_i            LIKE type_t.num5,
          l_j            LIKE type_t.num5
   DEFINE ld_lng_type    DYNAMIC ARRAY OF RECORD #20150101 多語言
       gzzy001           LIKE gzzy_t.gzzy001
                         END RECORD

   CALL cl_progress_bar(5)
   LET g_pro_msg = "############################################################",ASCII 10
   LET g_pro_msg = g_pro_msg,"[Message]adzp600複製規格與程式過程:",ASCII 10
   

   ############ 1.刪除原有的相關的檔案 ############
   IF NOT adzp600_delete_file() THEN
      LET g_pro_msg = g_pro_msg,"清除相關的檔案 .................... ERROR!",ASCII 10
      CALL cl_progress_bar_close()
      RETURN FALSE
   END IF
   LET g_pro_msg = g_pro_msg,"清除相關的檔案 .................... OK!",ASCII 10
   CALL cl_progress_ing("[Message]清除相關的檔案 .................... OK!")

   ############ 2.複製設計資料 ############
   #IF NOT adzp600_copy_database_data() THEN
   
   ##寫入傳值資訊
   #傳遞參數給子程式

   LET subPara.ms_dgenv = ms_dgenv
   LET subPara.ms_erpid = ""
   LET subPara.ms_erpver = ms_erpver
   LET subPara.ms_cust = ms_cust

   LET subPara.g_gen_prog = g_gen_prog
   LET subPara.g_copy_source = g_source_prog
   LET subPara.g_source_ver = g_source_ver
   LET subPara.g_source_spec_ver = g_source_spec_ver
   LET subPara.g_source_code_ver = g_source_code_ver
   LET subPara.g_source_identity = g_source_identity
   LET subPara.g_use_table_replace = "N"
   LET subPara.g_not_copy_appoint = "N"
   LET subPara.g_source_type = g_source_type  #20160729 add by elena
 
   CALL sadzp270_copy_database_data_ALL(subPara.*, sub_dzag, sub_dzeb_stored, g_prog) RETURNING lb_flag
   IF NOT lb_flag THEN
      LET g_pro_msg = g_pro_msg,"複製設計資料 .................... ERROR!",ASCII 10
      CALL cl_progress_bar_close()
      RETURN FALSE
   END IF
   LET g_pro_msg = g_pro_msg,"複製設計資料 .................... OK!",ASCII 10
   CALL cl_progress_ing("[Message]複製設計資料 .................... OK!")
      

   ############ 3.如果來源的4fd檔存在的話在進行產生4fd檔 ############
   #來源的4fd檔的檔案路徑
   LET g_source_4fd_path = os.path.join(os.path.join(FGL_GETENV(g_source_module), "4fd"), g_source_prog||".4fd")
   #產生的4fd檔的檔案路徑
   LET g_gen_4fd_path  = os.path.join(os.path.join(FGL_GETENV(g_gen_module), "4fd"), g_gen_prog||".4fd")
   IF os.Path.exists(g_source_4fd_path) THEN
      LET g_pro_msg = g_pro_msg,"來源的4fd檔的檔案路徑:",g_source_4fd_path,ASCII 10
      LET g_pro_msg = g_pro_msg,"產生的4fd檔的檔案路徑:",g_gen_4fd_path,ASCII 10

      ###### 產生畫面檔
      IF NOT adzp600_gen_4fd() THEN
         LET g_pro_msg = g_pro_msg,"產生畫面檔 .................... ERROR!",ASCII 10
         CALL cl_progress_bar_close()
         RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"產生畫面檔 .................... OK!",ASCII 10
         #切換要產生的程式模組中的4fd目錄
      CALL os.Path.chdir(os.path.join(FGL_GETENV(g_gen_module), "4fd")) 
      RETURNING lb_flag

   　　###### 編譯畫面檔
     #LET l_cmd = "r.f ",g_gen_prog
      LET l_cmd = "r.f ",g_gen_prog," tiptop" #20140926
      IF NOT adzp600_run_cmd(l_cmd) THEN
          LET g_pro_msg = g_pro_msg,"編譯畫面檔 .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
          CALL cl_progress_bar_close()
          RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"編譯畫面檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10

      #20140105 -Begin-
      #取得語言別清單
      CALL ld_lng_type.CLEAR()
      LET ld_lng_type = s_azzi070_get_gzzy()
      #產生畫面42s語系檔案
      FOR l_i = 1 TO ld_lng_type.getLength()
         LET l_cmd = "r.r azzp191 ", g_gen_prog CLIPPED, " ", ld_lng_type[l_i].gzzy001 CLIPPED
         RUN l_cmd WITHOUT WAITING 
         LET g_pro_msg = g_pro_msg,"(",l_cmd,")",ASCII 10
      END FOR
      #20140105 -End-
   　　###### 
      
      ###### 解析4fd畫面成設計資料
      DISPLAY "CALL sadzp168_3('",g_gen_module,"','",g_gen_prog,"','",g_gen_spec_ver,"','",ms_dgenv,"')"
      LET g_pro_msg = g_pro_msg,"CALL sadzp168_3('",g_gen_module,"','",g_gen_prog,"','",g_gen_spec_ver,"','",ms_dgenv,"')",ASCII 10
      CALL sadzp168_3(g_gen_module, g_gen_prog,g_gen_spec_ver,ms_dgenv) RETURNING lb_flag,ls_retinfo
      IF NOT lb_flag THEN 
         LET g_pro_msg = g_pro_msg,"解析4fd畫面成設計資料 .................... ERROR! ",ls_retinfo,ASCII 10
         CALL cl_progress_bar_close()
         RETURN FALSE
      END IF
      LET g_pro_msg = g_pro_msg,"解析4fd畫面成設計資料 .................... OK!",ASCII 10

      ###### 解析欄位設計定義資訊
      DISPLAY "CALL sadzp168_4('",g_gen_prog,"','",g_gen_spec_ver,"','",ms_dgenv,"')"
      CALL sadzp168_4(g_gen_prog,g_gen_spec_ver,ms_dgenv) RETURNING lb_flag,ls_retinfo
      LET g_pro_msg = g_pro_msg,"CALL sadzp168_4('",g_gen_prog,"','",g_gen_spec_ver,"','",ms_dgenv,"')",ASCII 10
    ##此functin 有錯誤可by pass
    ##IF NOT lb_flag THEN 
    ##   LET g_pro_msg = g_pro_msg,"解析欄位設計定義資訊 .................... ERROR! ",ls_retinfo,ASCII 10
    ##   CALL cl_progress_bar_close()
    ##   RETURN FALSE
    ##END IF
      LET g_pro_msg = g_pro_msg,"解析欄位設計定義資訊 .................... OK!",ASCII 10
   ELSE
      LET g_pro_msg = g_pro_msg,"來源程式無畫面檔 .................... OK!",ASCII 10
   END IF
   CALL cl_progress_ing("[Message]產生/編譯/解析畫面檔 .................... OK!")

   ############ 4.產生tab檔 ############
   #取得UI版型
  #SELECT dzfq001 INTO ls_form_style FROM dzfq_t WHERE dzfq004 = g_gen_prog
  #LET ls_form_style = ls_form_style CLIPPED
   LET ls_form_style ='' #已改成不需要傳入此參數
  #DISPLAY "取得UI版型 = ",ls_form_style
   DISPLAY "CALL sadzp030_tab_gen('",g_gen_prog,"','",g_gen_spec_ver,"','",ls_form_style,"','",ms_dgenv,"')"
   LET g_pro_msg = g_pro_msg,"CALL sadzp030_tab_gen('",g_gen_prog,"','",g_gen_spec_ver,"','",ls_form_style,"','",ms_dgenv,"')",ASCII 10
   IF NOT sadzp030_tab_gen(g_gen_prog,g_gen_spec_ver,ls_form_style,ms_dgenv) THEN
      LET g_pro_msg = g_pro_msg,"產生tab檔 .................... ERROR!",ASCII 10
      CALL cl_progress_bar_close()
      RETURN FALSE
   END IF
   LET g_pro_msg = g_pro_msg,"產生tab檔 .................... OK!",ASCII 10
   CALL cl_progress_ing("[Message]產生tab檔 .................... OK!")


   ############ 5.執行r.c3 ############
   IF g_gen_type="F" THEN #目前子畫面(F)不用產生tgl檔和4gl檔,所以不用執行r.c3
   ELSE
      #切換要產生的程式模組中的4gl目錄
      CALL os.Path.chdir(os.path.join(FGL_GETENV(g_gen_module),"4gl"))
         RETURNING lb_flag

      ###### 產生tgl檔和4gl檔(執行r.c3)   
      #不自動r.c及r.l 因為預期可能仍會有錯,參數四給1
     #LET l_cmd = "r.c3 ",g_gen_prog," '' 1 1 N ",ms_dgenv  #程式版次固定為1 #20140902
      LET l_cmd = "r.c3 ",g_gen_prog," '' 1 1 ",ms_dgenv  #程式版次固定為1
      DISPLAY 'RUN:',l_cmd
      IF NOT adzp600_run_cmd(l_cmd) THEN
         LET g_pro_msg = g_pro_msg,"產生tgl檔和4gl檔(執行r.c3) .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
      ELSE
         LET g_pro_msg = g_pro_msg,"產生tgl檔和4gl檔(執行r.c3) .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
      END IF

   END IF
   CALL cl_progress_ing("[Message]產生tgl檔和4gl檔(執行r.c3) .................... OK!")

 #20140603:madey marked: r.c3參數4帶0時會自動呼叫以下程序,否則透過code editor上傳程式時也會自動呼叫
 ############## 6.產生4ad檔和4tm檔 ############
 ##IF g_gen_type = "M" THEN #目前主程式才能產生4ad檔和4tm檔
 ##
 ##   ###### 解析4gl中的ACTION到gzzr_t
 ##   LET l_cmd = "r.r azzp195 ",g_gen_prog
 ##   IF NOT adzp600_run_cmd(l_cmd) THEN
 ##      LET g_pro_msg = g_pro_msg,"解析4gl中的ACTION到gzzr_t .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##      CALL cl_progress_bar_close()
 ##      RETURN FALSE
 ##   END IF
 ##   LET g_pro_msg = g_pro_msg,"解析4gl中的ACTION到gzzr_t .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##
 ##   #確認gzzr_t有設計資料,再產生4ad檔
 ##   SELECT COUNT(*) INTO l_cnt FROM gzzr_t WHERE gzzr001=g_gen_prog
 ##   IF l_cnt>0 THEN
 ##      LET l_cmd = "r.r azzp193 ",g_gen_prog," 4ad ",g_lang
 ##      IF NOT adzp600_run_cmd(l_cmd) THEN
 ##         LET g_pro_msg = g_pro_msg,"產生4ad檔.................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##         CALL cl_progress_bar_close()
 ##         RETURN FALSE
 ##      END IF
 ##      LET g_pro_msg = g_pro_msg,"產生4ad檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##   END IF
 ##
 ##   ###### 確認gzzp_t有設計資料,再產生4tm檔
 ##   SELECT COUNT(*) INTO l_cnt FROM gzzp_t WHERE gzzp001=g_gen_prog
 ##   IF l_cnt>0 THEN
 ##      LET l_cmd = "r.r azzp193 ",g_gen_prog," 4tm ",g_lang
 ##      IF NOT adzp600_run_cmd(l_cmd) THEN
 ##         LET g_pro_msg = g_pro_msg,"產生4tm檔 .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##         CALL cl_progress_bar_close()   
 ##         RETURN FALSE
 ##      END IF
 ##      LET g_pro_msg = g_pro_msg,"產生4tm檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##   END IF
 ##END IF
 ##CALL cl_progress_ing("[Message]產生4tm/4ad檔 .................... OK!")
 ##
 ############## 7.如果複製目標存在畫面檔則進行產生42s檔###########
 ##IF os.Path.exists(g_gen_4fd_path) THEN
 ##   LET l_cmd = "r.r azzp191 ",g_gen_prog," ",g_lang
 ##   IF NOT adzp600_run_cmd(l_cmd) THEN
 ##      LET g_pro_msg = g_pro_msg,"產生42s檔 .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##      CALL cl_progress_bar_close()
 ##      RETURN FALSE
 ##   END IF
 ##   LET g_pro_msg = g_pro_msg,"產生42s檔 .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10  
 ##END IF
 ##CALL cl_progress_ing("[Message]產生42s檔 .................... OK!")

 #報表是adzp270才要處理,程式碼先留著供adzp270參考
 ############## 8.複製報表樣版rdd/4rp ###########
 ##IF g_gen_type MATCHES "[GX]" THEN #目前報表元件才要處理
 ##   #切換要產生rdd的程式模組中的4gl目錄
 ##   IF os.Path.chdir(os.path.join(FGL_GETENV(g_gen_module),"4gl")) THEN
 ##  
 ##      ###### 產生rdd檔(執行r.c rdd)    
 ##      #不自動r.c及r.l 因為預期可能仍會有錯,參數四給1
 ##      LET l_cmd = "r.c ",g_gen_prog," rdd" #帶參數rdd
 ##      IF NOT adzp600_run_cmd(l_cmd) THEN
 ##         LET g_pro_msg = g_pro_msg,"產生rdd檔(執行r.c rdd) .................... ERROR!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##      ELSE
 ##         LET g_pro_msg = g_pro_msg,"產生rdd檔(執行r.c rdd) .................... OK!",ASCII 10,"(",l_cmd,")",ASCII 10
 ##      END IF
 ##   END IF
 ##
 ##   ###### 複製4rp檔######
 ##   IF NOT adzp600_gen_4rp() THEN
 ##      LET g_pro_msg = g_pro_msg,"產生畫面檔 .................... ERROR!",ASCII 10
 ##      CALL cl_progress_bar_close()
 ##      RETURN FALSE
 ##   ELSE
 ##      LET g_pro_msg = g_pro_msg,"產生畫面檔 .................... OK!",ASCII 10
 ##   END IF
 ##
 ##END IF
 ##CALL cl_progress_ing("[Message]產生rdd/4rp檔 .................... OK!")
   
   RETURN TRUE
   
END FUNCTION

#+ 清除相關的檔案
PRIVATE FUNCTION adzp600_delete_file()
   DEFINE ls_path STRING
   DEFINE ls_cmd  STRING

   #20140903 add
   LET ls_path = FGL_GETENV(g_gen_module) 
   IF cl_change_dir(ls_path) THEN
      LET ls_cmd = "rm -rf ","*/*",g_gen_prog,".* ",
                            "*/*/*",g_gen_prog,".* ",
                            "*/*/*/*",g_gen_prog,".* ",
                            " >/dev/null 2>&1"
      DISPLAY ls_cmd
      RUN ls_cmd  
   END IF
  
  #20140903 mark
  #### 刪除4fd
  #LET ls_path=os.path.join(os.path.join(FGL_GETENV(g_gen_module), "4fd"), g_gen_prog||".4fd")
  ##檔案如果已經存在則先刪除
  #IF os.Path.exists(ls_path) THEN
  #   IF NOT os.Path.delete(ls_path) THEN
  #      LET g_pro_msg = g_pro_msg,"刪除4fd檔失敗",ASCII 10
  #      RETURN FALSE
  #   END IF
  #END IF
  #
  #### 刪除tab
  #LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(g_gen_module), "dzx"), "tab"),g_gen_prog||".tab")
  ##檔案如果已經存在則先刪除
  #IF os.Path.exists(ls_path) THEN
  #   IF NOT os.Path.delete(ls_path) THEN
  #      LET g_pro_msg = g_pro_msg,"刪除tab檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
  #      RETURN FALSE
  #   END IF
  #END IF

  #### 刪除tgl
  #LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(g_gen_module), "dzx"), "tgl"),g_gen_prog||".tgl")
  ##檔案如果已經存在則先刪除
  #IF os.Path.exists(ls_path) THEN
  #   IF NOT os.Path.delete(ls_path) THEN
  #      LET g_pro_msg = g_pro_msg,"刪除tgl檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
  #      RETURN FALSE
  #   END IF
  #END IF

  #### 刪除4gl
  #LET ls_path=os.path.join(os.path.join(FGL_GETENV(g_gen_module), "4gl"), g_gen_prog||".4gl")
  ##檔案如果已經存在則先刪除
  #IF os.Path.exists(ls_path) THEN
  #   IF NOT os.Path.delete(ls_path) THEN
  #      LET g_pro_msg = g_pro_msg,"刪除4gl檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
  #      RETURN FALSE
  #   END IF
  #END IF

  #### 刪除4tm
  #LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(g_gen_module), "4tm"), g_lang),g_gen_prog||".4tm")
  ##檔案如果已經存在則先刪除
  #IF os.Path.exists(ls_path) THEN
  #   IF NOT os.Path.delete(ls_path) THEN
  #      LET g_pro_msg = g_pro_msg,"刪除4tm檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
  #      RETURN FALSE
  #   END IF
  #END IF

  #### 刪除4ad
  #LET ls_path=os.path.join(os.path.join(os.path.join(FGL_GETENV(g_gen_module), "4ad"), g_lang),g_gen_prog||".4ad")
  ##檔案如果已經存在則先刪除
  #IF os.Path.exists(ls_path) THEN
  #   IF NOT os.Path.delete(ls_path) THEN
  #      LET g_pro_msg = g_pro_msg,"刪除4ad檔失敗",ASCII 10,"(",ls_path,")",ASCII 10
  #      RETURN FALSE
  #   END IF
  #END IF

   RETURN TRUE
END FUNCTION


#+ 產生4fd檔
PRIVATE FUNCTION adzp600_gen_4fd()
   DEFINE ls_sql      STRING,
          lt_4fd_str  TEXT,
          lb_buf      base.StringBuffer,
          lb_flag     LIKE type_t.num5,
          l_i         LIKE type_t.num5,
          l_old_str   STRING,
          l_new_str   STRING,
          l_4fd_doc   om.DomDocument,
          l_4fd_root  om.DomNode

   LOCATE lt_4fd_str IN FILE

   #檢查來源檔的存在和檔案權限
   IF os.Path.exists(g_source_4fd_path) AND adzp600_chk_file_permisson(g_source_4fd_path) THEN

      LET lt_4fd_str = adzp600_read_file(g_source_4fd_path,lt_4fd_str)
      LET lb_buf = base.StringBuffer.create()
      
      LET l_4fd_doc = om.DomDocument.createFromString(lt_4fd_str)
      LET l_4fd_root = l_4fd_doc.getDocumentElement()

      CALL lb_buf.append(lt_4fd_str)

      #Begin:20160627 mark by elena 行業不轉換
      ##置換4fd檔內的程式代號字串
      #LET l_old_str = g_source_prog
      #LET l_new_str = g_gen_prog
      #
      #CALL lb_buf.replace(l_old_str, l_new_str, 0)
      #End:20160627
      LET lt_4fd_str = lb_buf.toString()

      CALL adzp600_write_file(g_gen_4fd_path,lt_4fd_str)

      #檢查檔案是否產生成功
      IF os.Path.exists(g_gen_4fd_path) THEN
   　　   LET lb_flag = TRUE
      ELSE
         LET lb_flag = FALSE
      END IF

   ELSE
      LET lb_flag = FALSE
   END IF

   FREE lt_4fd_str
   
   RETURN lb_flag
END FUNCTION
 

#+ 產生4rp檔
PRIVATE FUNCTION adzp600_gen_4rp()
   DEFINE ls_sql                STRING,
          ls_path               STRING,
          ls_filename           STRING,
          lt_4rp_str            TEXT,
          lb_buf                base.StringBuffer,
          lb_flag               LIKE type_t.num5,
          li_idx                LIKE type_t.num5,
          li_idy                LIKE type_t.num5,
          l_old_str             STRING,
          l_new_str             STRING,
          l_4rp_doc             om.DomDocument,
          l_4rp_root            om.DomNode

   DEFINE ld_lng_type   DYNAMIC ARRAY OF RECORD
       gzzy001 LIKE gzzy_t.gzzy001
                        END RECORD

  LET lb_flag = TRUE
  LOCATE lt_4rp_str IN FILE
  
  #取得語言別清單
  LET ld_lng_type = s_azzi070_get_gzzy()
  
  #依語言別清單 讀取目錄檔案清單,並過濾檔名為g_gen_prog開頭的.4rp檔
  FOR li_idx = 1 TO ld_lng_type.getLength()
     LET ls_path = os.path.join(os.path.join(FGL_GETENV(g_gen_module), "4rp"),ld_lng_type[li_idx].gzzy001)
     IF os.Path.chdir(ls_path) THEN #切換目錄
        LET li_idy = os.Path.diropen(ls_path)
        WHILE li_idy > 0
          LET ls_filename = os.Path.dirnext(li_idy) #讀取檔案名稱
          IF ls_filename IS NULL THEN EXIT WHILE END IF
          IF ls_filename == "." OR ls_filename == ".." OR os.Path.isdirectory(ls_filename)  THEN CONTINUE WHILE END IF
          IF os.Path.extension(ls_filename) == "4rp" THEN
             IF (ls_filename MATCHES g_source_prog||"*") AND  (ls_filename NOT MATCHES g_gen_prog||"*") THEN #例如如果同時有aiti004.4rp 跟aiti004_ic.4rp的話,不加NOT都會被挑出來
                LET g_source_4rp_path = os.path.join(ls_path,ls_filename) #來源的4rp檔的檔案路徑
                LET g_gen_4rp_path = os.path.join(ls_path,cl_str_replace(ls_filename,g_source_prog,g_gen_prog)) #產生的4rp檔的檔案路徑
                #檢查來源檔的存在和檔案權限 madeyq 此處需要檢查權限嗎??
                #IF os.Path.exists(g_source_4rp_path) AND adzp600_chk_file_permisson(g_source_4rp_path) THEN

                #讀取來源4rp檔案內容，並取代其中的程式代號字串
                LET lt_4rp_str = adzp600_read_file(g_source_4rp_path,lt_4rp_str)
                LET lb_buf = base.StringBuffer.create()
                LET l_4rp_doc = om.DomDocument.createFromString(lt_4rp_str)
                LET l_4rp_root = l_4rp_doc.getDocumentElement()
                CALL lb_buf.append(lt_4rp_str)
                LET l_old_str = g_source_prog
                LET l_new_str = g_gen_prog
                CALL lb_buf.replace(l_old_str, l_new_str, 0) #置換4rp檔內的程式代號字串
                LET lt_4rp_str = lb_buf.toString()
                CALL adzp600_write_file(g_gen_4rp_path,lt_4rp_str) #產生4rp檔
                LET g_pro_msg = g_pro_msg,"來源的4rp檔的檔案路徑:",g_source_4rp_path,ASCII 10
                IF os.Path.exists(g_gen_4rp_path) THEN #檢查檔案是否產生成功
                   LET g_pro_msg = g_pro_msg,"產生的4rp檔的檔案路徑:",g_gen_4rp_path,'  -->ok',ASCII 10
                ELSE
                   LET g_pro_msg = g_pro_msg,"產生的4rp檔的檔案路徑:",g_gen_4rp_path,'  -->fail',ASCII 10
                   LET lb_flag = FALSE
                END IF
             END IF
          END IF
        END WHILE
        CALL os.Path.dirclose(li_idy)
     END IF
  END FOR

  FREE lt_4rp_str
  RETURN lb_flag
END FUNCTION


#+ 進行 command line 的程式執行
PRIVATE FUNCTION adzp600_run_cmd(p_cmd)
   DEFINE p_cmd          STRING    
   DEFINE l_msg          STRING
   DEFINE l_chk          LIKE type_t.num5
  
   #DISPLAY "l_cmd = ",l_cmd 
   CALL cl_cmdrun_openpipe(p_cmd,p_cmd,FALSE) RETURNING l_chk,l_msg

   RETURN  l_chk
END FUNCTION


#+檢查檔案權限是否能讀取
PRIVATE FUNCTION adzp600_chk_file_permisson(p_file)
   DEFINE p_file      STRING         #檔案路徑
   DEFINE l_ch_in     base.Channel   #Genero讀取的檔案物件變數

   LET l_ch_in = base.Channel.create()

   TRY
      #指定來源的的檔案路徑
      CALL l_ch_in.openFile(p_file,"r")
   CATCH
      IF STATUS THEN
         #對此檔案的權限不足
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00156"
         LET g_errparam.extend = "ERROR:permission"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_file
         CALL cl_err()
         RETURN FALSE
      END IF 
   END TRY
   
   CALL l_ch_in.close()

   RETURN TRUE
END FUNCTION


#+ 取出檔案內的字串(使用TEXT的內建FUNCTION讀檔)
FUNCTION adzp600_read_file(p_file_path,pt_str)
   DEFINE p_file_path   STRING,
          pt_str        TEXT

   #讀取檔案內容
   CALL pt_str.readFile(p_file_path)
   #DISPLAY "pt_str = ",pt_str
   
   RETURN pt_str
END FUNCTION


#+ 寫入出檔案內的字串(使用TEXT的內建FUNCTION寫檔)
FUNCTION adzp600_write_file(p_file_path,pt_str)
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



#+ 檢查是否有設計資料
PRIVATE FUNCTION adzp600_check_design_data_exist()
   DEFINE ln_cnt         LIKE type_t.num5,
          l_table_id     STRING,
          ln_total_cnt   LIKE type_t.num5,
          ls_exist_table STRING

   LET ln_total_cnt = 0
   LET ls_exist_table = ""

   TRY
      # dzaa_t-- 尋找設計資料在(規格與內容版本對應表)的SQL.
      LET l_table_id = "dzaa_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzaa_t WHERE dzaa001= g_gen_prog AND dzaa002 = '1' AND dzaa009 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzba_t -- 尋找設計資料在(程式與內容版本對應表)的SQL.
      LET l_table_id = "dzba_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzba_t WHERE dzba001= g_gen_prog AND dzba002 = '1' AND dzba010 = ms_dgenv 
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
     #20140724:madey -Begin-
     #再度增加check資源池table,因為有可能樹頭沒資料,但是資源持殘留資料，若此處沒check出來,會造成後面insert失敗
      # dzab_t-- 尋找設計資料在(規格整體設計表)的SQL.
      LET l_table_id = "dzab_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzab_t WHERE dzab001= g_gen_prog AND dzab002 = '1' AND dzab003 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzac_t-- 尋找設計資料在(欄位規格設計表)的SQL.
      LET l_table_id = "dzac_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzac_t WHERE dzac001= g_gen_prog AND dzac004 = '1' AND dzac012 = ms_dgenv 
      LET ln_total_cnt = ln_total_cnt + ln_cnt
 
      # dzak_t-- 尋找設計資料在(欄位助記碼設計表)的SQL.
      LET l_table_id = "dzak_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzak_t WHERE dzak001= g_gen_prog AND dzak003 = '1' AND dzak004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzad_t-- 尋找設計資料在(Action規格設計表)的SQL.
      LET l_table_id = "dzad_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzad_t WHERE dzad001= g_gen_prog AND dzad003 = '1' AND dzad005 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzag_t--  尋找設計資料在(規格Table設定表)的SQL.
      LET l_table_id = "dzag_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzag_t WHERE dzag001= g_gen_prog AND dzag003 = '1' AND dzag006 = ms_dgenv 
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzfs_t--  尋找設計資料在(程式Table與Screen Record對應檔)的SQL.
      LET l_table_id = "dzfs_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzfs_t WHERE dzfs002= g_gen_prog AND dzfs003 = '1' AND dzfs005 = ms_dgenv 
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzai_t-- 尋找設計資料在(欄位參考設計表)的SQL.
      LET l_table_id = "dzai_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzai_t WHERE dzai001= g_gen_prog AND dzai003 = '1' AND dzai004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
   
      # dzaj_t-- 尋找設計資料在(欄位資料多語言設計表)的SQL.
      LET l_table_id = "dzaj_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzaj_t WHERE dzaj001= g_gen_prog AND dzaj003 = '1' AND dzaj004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzal_t-- 尋找設計資料在(程式串查設計表)的SQL.
      LET l_table_id = "dzal_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzal_t WHERE dzal001= g_gen_prog AND dzal003 = '1' AND dzal004 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt
      
      # dzff_t-- 尋找設計資料在(樹狀結構屬性設定檔)的SQL.
      LET l_table_id = "dzff_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzff_t WHERE dzff001= g_gen_prog AND dzff002 = '1' AND dzff008 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzbb_t -- 尋找設計資料在(程式設計點設計表)的SQL.
      LET l_table_id = "dzbb_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzbb_t WHERE dzbb001= g_gen_prog  AND dzbb003 ='1' AND dzbb004 = ms_dgenv #AND dzbb003 = g_design_point_ver
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzbc_t -- 尋找設計資料在(代碼與內容版本對應表)的SQL.
      LET l_table_id = "dzbc_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzbc_t WHERE dzbc001= g_gen_prog AND dzbc002 = '1' AND dzbc007 = ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt

      # dzbd_t -- 尋找設計資料在(代碼設計點設計表)的SQL.
      LET l_table_id = "dzbd_t"
      SELECT COUNT(*)  INTO ln_cnt  FROM dzbd_t WHERE dzbd001= g_gen_prog AND dzbd003 = '1' AND dzbd004 =ms_dgenv
      LET ln_total_cnt = ln_total_cnt + ln_cnt

     #20140724:madey -End-

   CATCH
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "design data exist table:"||l_table_id
         LET g_errparam.popup = g_errshow
         CALL cl_err()
      END IF
   END TRY

   IF ln_total_cnt = 0 THEN
      RETURN FALSE
   END IF 

   RETURN TRUE

END FUNCTION


###+ 刪除資料庫資料
##PRIVATE FUNCTION adzp600_delete_database_data()
##   DEFINE l_table_id      STRING,
##          l_tsd_file_path STRING,
##          l_tap_file_path STRING,
##          ls_sql          STRING
##
##
##   LET g_gen_prog = g_gen_prog CLIPPED
##   LET g_gen_spec_ver = g_gen_spec_ver CLIPPED
##   LET g_gen_design_point_ver = g_gen_design_point_ver CLIPPED
##   
##   TRY
##      # dzaa_t-- 刪除(規格與內容版本對應表)的SQL.
##      LET l_table_id = "dzaa_t"
##      DELETE FROM dzaa_t WHERE dzaa001= g_gen_prog ##AND dzaa002 = g_gen_spec_ver AND dzaa004 = g_gen_design_point_ver #AND dzaa006 = ms_dgenv
##               
##      # dzab_t-- 刪除(規格整體設計表)的SQL.
##      LET l_table_id = "dzab_t"
##      DELETE FROM dzab_t WHERE dzab001= g_gen_prog ##AND dzab002 = g_gen_design_point_ver #AND dzab003 = ms_dgenv
##         
##      # dzac_t-- 刪除(欄位規格設計表)的SQL.
##      LET l_table_id = "dzac_t"
##      DELETE FROM dzac_t WHERE dzac001= g_gen_prog ##AND dzac004 = g_gen_design_point_ver #AND dzac012 = ms_dgenv 
##         
##      # dzak_t-- 刪除(欄位助記碼設計表)的SQL.
##      LET l_table_id = "dzak_t"
##      DELETE FROM dzak_t WHERE dzak001= g_gen_prog ##AND dzak003 = g_gen_design_point_ver #AND dzak004 = ms_dgenv
##         
##      # dzad_t-- 刪除(Action規格設計表)的SQL.
##      LET l_table_id = "dzad_t"
##      DELETE FROM dzad_t WHERE dzad001= g_gen_prog ##AND dzad003 = g_gen_design_point_ver #AND dzad005 = ms_dgenv
##
##      # dzag_t--  刪除(規格Table設定表)的SQL.
##      LET l_table_id = "dzag_t"
##      DELETE FROM dzag_t WHERE dzag001= g_gen_prog #AND dzag003 = g_gen_design_point_ver #AND dzag006 = ms_dgenv #ms_dgenv自訂
##
##      # dzfs_t--  刪除(程式Table與Screen Record對應檔)的SQL.
##      LET l_table_id = "dzfs_t"
##      DELETE FROM dzfs_t WHERE dzfs002= g_gen_prog #AND dzfs001 = g_gen_design_point_ver #AND dzfs005 = ms_dgenv #ms_dgenv自訂
##
##      # dzai_t-- 刪除(欄位參考設計表)的SQL.
##      LET l_table_id = "dzai_t"
##      DELETE FROM dzai_t WHERE dzai001= g_gen_prog ##AND dzai003 = g_gen_design_point_ver #AND dzai004 = ms_dgenv
##         
##      # dzaj_t-- 刪除(欄位資料多語言設計表)的SQL.
##      LET l_table_id = "dzaj_t"
##      DELETE FROM dzaj_t WHERE dzaj001= g_gen_prog ##AND dzaj003 = g_gen_design_point_ver #AND dzaj004 = ms_dgenv
##
##      # dzal_t-- 刪除(程式串查設計表)的SQL.
##      LET l_table_id = "dzal_t"
##      DELETE FROM dzal_t WHERE dzal001= g_gen_prog ##AND dzal003 = g_gen_design_point_ver #AND dzal004 = ms_dgenv
##
##      # dzff_t-- 刪除(樹狀結構屬性設定檔)的SQL.
##      LET l_table_id = "dzff_t"
##      DELETE FROM dzff_t WHERE dzff001= g_gen_prog ##AND dzff002 = g_gen_design_point_ver #AND dzff008 = ms_dgenv #ms_dgenv自訂
##     
##      # dzfq_t -- 刪除(畫面結構設計主檔)的SQL.
##      LET l_table_id = "dzfq_t"
##      DELETE FROM dzfq_t WHERE dzfq004= g_gen_prog ##AND dzfq003 = g_gen_design_point_ver
##         
##      # gzzd_t -- 刪除(畫面元件多語言記錄檔)的SQL.
##      LET l_table_id = "gzzd_t"
##      DELETE FROM gzzd_t WHERE gzzd001= g_gen_prog ##AND gzzd004 = ms_dgenv #ms_dgenv自訂
##
##      # gzzq_t -- 刪除(ACTION多語言對照檔)的SQL.
##       LET l_table_id = "gzzq_t"
##       DELETE FROM gzzq_t WHERE gzzq001= g_gen_prog #AND gzzq006 = ms_dgenv #ms_dgenv自訂
##
##      #gzzp_t -- 刪除(階層式選單設定檔)的SQL.
##      LET l_table_id = "gzzp_t"
##      DELETE FROM gzzp_t WHERE gzzp001= g_gen_prog #自訂
##
##      # dzba_t -- 刪除(程式與內容版本對應表)的SQL.
##      LET l_table_id = "dzba_t"
##      DELETE FROM dzba_t WHERE dzba001= g_gen_prog ##AND dzba005 = ms_dgenv#AND dzba002 = g_gen_spec_ver #AND dzba004 = g_gen_design_point_ver #
##
##      # dzbb_t -- 刪除(程式設計點設計表)的SQL.
##      LET l_table_id = "dzbb_t"
##      DELETE FROM dzbb_t WHERE dzbb001= g_gen_prog ##AND dzbb004 = ms_dgenv #AND dzbb003 = g_gen_design_point_ver
##
##      # dzam_t -- 刪除(規格畫面元件排除設定)的SQL.
##      LET l_table_id = "dzam_t"
##      DELETE FROM dzam_t WHERE dzam001= g_gen_prog
##
##      # dzbc_t -- 刪除(代碼與內容版本對應表)的SQL.
##      LET l_table_id = "dzbc_t"
##      DELETE FROM dzbc_t WHERE dzbc001= g_gen_prog
##
##      # dzbd_t -- 刪除(代碼設計點設計表)的SQL.
##      LET l_table_id = "dzbd_t"
##      DELETE FROM dzbd_t WHERE dzbd001= g_gen_prog
##
##      # dzax_t -- 刪除(程式設計基本設定表)的SQL.
##      LET l_table_id = "dzax_t"
##      DELETE FROM dzax_t WHERE dzax001= g_gen_prog
##   
##   CATCH
##      IF SQLCA.sqlcode THEN
##         CALL cl_err("del_error table:"||l_table_id,SQLCA.sqlcode,g_errshow)
##         ROLLBACK WORK
##         RETURN FALSE
##      END IF
##   END TRY
##
##   RETURN TRUE
##END FUNCTION


#+ 複製資料庫的設計資料
PRIVATE FUNCTION adzp600_copy_database_data()
   DEFINE ls_sql   STRING,
          l_user   LIKE dzaa_t.dzaaownid,
          l_dept   LIKE dzaa_t.dzaaowndp,
          l_date   LIKE dzaa_t.dzaacrtdt,
          ls_err   STRING,
          ln_cnt   LIKE type_t.num5,
          lb_flag  BOOLEAN  #檢查transation的過程式否有錯誤

   DEFINE l_dzaxstus LIKE dzax_t.dzaxstus,
          l_dzax002  LIKE dzax_t.dzax002,
          l_dzax003  LIKE dzax_t.dzax003 
          
   LET l_user        = g_user
   LET l_dept        = g_dept
   LET l_date        = cl_get_current()
   
   LET lb_flag = TRUE

   #複製時,目標程式的版次應該都reset由1開始
   LET g_gen_ver      = '1'                
   LET g_gen_spec_ver = '1'                
   LET g_gen_code_ver = '1'                
   LET g_gen_design_point_ver='1'
   LET g_gen_identity = ms_dgenv

   BEGIN WORK
   TRY

      ###### 行業別規格/程式資料的複製
      ######-- dzaa_t-- 自訂sql 複製dzaa_t(規格與內容版本對應表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzaa_t(",
      "  dzaastus,",
      "  dzaa001,",
      "  dzaa002,",
      "  dzaa003,",
      "  dzaa004,",
      "  dzaa005,",
      "  dzaa006,",
      "  dzaa007,",
      "  dzaa008,",
      "  dzaa009,",
      "  dzaa010,",
      "  dzaaownid,dzaaowndp,dzaacrtid,dzaacrtdp,dzaacrtdt",
      "  )SELECT",
      "     dzaastus,",
      "     '",g_gen_prog,"' dzaa001,",
      "     '",g_gen_spec_ver,"' dzaa002,",
      "     dzaa003,",
      "     '",g_gen_design_point_ver,"' dzaa004,",
      "     dzaa005,",
      "     '",ms_dgenv,"' dzaa006,",
      "     dzaa007,",
      "     '",ms_erpver,"' dzaa008,",
      "     '",ms_dgenv,"' dzaa009,",
      "     '",ms_cust,"' dzaa010,",
      "     '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp, SYSTIMESTAMP dzaacrtdt",
      "     FROM dzaa_t",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "     ORDER BY dzaa005,dzaa003"

      PREPARE insert_data_to_dzaa_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzaa_t"
      EXECUTE insert_data_to_dzaa_t

      #dzaa要引用(dzaa007=Y),但是dzag,dzfs,dzam除外,
      #作法:上面insert時不動dzaa007,insert後再將有引用的table之dzaa007更新為Y
       LET ls_sql = 
       "UPDATE dzaa_t ",
       "   SET dzaa007='Y'",
       " WHERE dzaa001 ='",g_gen_prog,"'",
       "   AND dzaa002 ='",g_gen_spec_ver,"'",
       "   AND dzaa004 ='",g_gen_design_point_ver,"'",
       "   AND dzaa009='",g_source_identity,"'",
       "   AND dzaa005 IN ('1','2','3','5','6','7')"
       PREPARE update_data_to_dzaa_t FROM ls_sql
       LET ls_err = "error:update_data_to_dzaa_t"
       EXECUTE update_data_to_dzaa_t

      ######-- dzab_t-- sql參考 sadzp030_tsd_get_dzab_sql(g_code, g_ver) 複製dzab_t(規格整體設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzab_t(",
      "  dzabstus,",
      "  dzab001,",
      "  dzab002,",
      "  dzab099,",
      "  dzab003,",
      "  dzab004,",
      "  dzab005,",
      "  dzab006,",
      "  dzabownid,dzabowndp,dzabcrtid,dzabcrtdp,dzabcrtdt",
      "  )SELECT ",
      "     dzabstus,",
      "     '",g_gen_prog,"' dzab001,",
      "     '",g_gen_design_point_ver,"' dzab002,",
      "     REPLACE(dzab099,'",g_source_prog,"','",g_gen_prog,"') dzab099,",
      "     '",ms_dgenv,"' dzab003,",
      "     dzab004,",
      "     '",ms_cust,"' dzab005,",
      "     dzab006,",
      "     '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp,'",l_date USING "yyyy/mm/dd","' dzaacrtdt",
      "     FROM dzab_t",
      "     INNER JOIN dzaa_t ON dzaa001=dzab001 AND dzaa003=dzab004 AND dzaa004=dzab002 AND dzaa006=dzab003",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='3' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'"
      
      PREPARE insert_data_to_dzab_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzab_t"
      EXECUTE insert_data_to_dzab_t 
      
      
      ######-- dzac_t-- sql參考 sadzp030_tsd_get_dzac_sql(g_code, g_ver) 複製dzac_t(欄位規格設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzac_t(",
      "  dzacstus,",
      "  dzac001,",
      "  dzac002,",
      "  dzac003,",
      "  dzac004,",
      "  dzac005,",
      "  dzac006,",
      "  dzac007,",
      "  dzac008,",
      "  dzac009,",
      "  dzac010,",
      "  dzac011,",
      "  dzac012,",
      "  dzac013,",
      "  dzac014,",
      "  dzac015,",
      "  dzac016,",
      "  dzac017,",
      "  dzac018,",
      "  dzac019,",
      "  dzac099,",
      "  dzac020,",
      "  dzac021,", 
      "  dzacownid,dzacowndp,dzaccrtid,dzaccrtdp,dzaccrtdt",
      "  )SELECT ",
      "     dzacstus,",
      "     '",g_gen_prog,"' dzac001,",
      "     dzac002,",
      "     dzac003,",
      "     '",g_gen_design_point_ver,"' dzac004,",
      "     dzac005,",
      "     dzac006,",
      "     dzac007,",
      "     dzac008,",
      "     dzac009,",
      "     dzac010,",
      "     dzac011,",
      "     '",ms_dgenv,"' dzac012,",
      "     '",ms_cust,"' dzac013,",
      "     dzac014,",
      "     dzac015,",
      "     dzac016,",
      "     dzac017,",
      "     dzac018,",
      "     dzac019,",
      "     REPLACE(dzac099,'",g_source_prog,"','",g_gen_prog,"') dzac099,",
      "     dzac020,",
      "     dzac021,",
      "     '",l_user,"' dzaaownid,'",l_dept,"' dzaaowndp,'",l_user,"' dzaacrtid,'",l_dept,"' dzaacrtdp, SYSTIMESTAMP dzaacrtdt", 
      "     FROM dzac_t",
      "     INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'"
      
      PREPARE insert_data_to_dzac_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzac_t"
      EXECUTE insert_data_to_dzac_t 
      
      
      ######-- dzak_t-- sql參考 sadzp030_tsd_get_dzak_sql(g_code, g_ver) 複製dzak_t(欄位助記碼設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzak_t(",
      "  dzakstus,",
      "  dzak001,",
      "  dzak002,",
      "  dzak003,",
      "  dzak004,",
      "  dzak005,",
      "  dzak007,",
      "  dzak008,",
      "  dzak009,",
      "  dzak010,",
      "  dzak011,",
      "  dzak012,",
      "  dzakownid,dzakowndp,dzakcrtid,dzakcrtdp,dzakcrtdt",
      "  )SELECT ",
      "     dzakstus,",
      "     '",g_gen_prog,"' dzak001,",
      "     dzak002,",
      "     '",g_gen_design_point_ver,"' dzak003,",
      "     '",ms_dgenv,"' dzak004,",
      "     dzak005,",
      "     dzak007,",
      "     dzak008,",
      "     dzak009,",
      "     dzak010,",
      "     dzak011,",
      "     '",ms_cust,"' dzak012,",
      "     '",l_user,"' dzakownid,'",l_dept,"' dzakowndp,'",l_user,"' dzakcrtid,'",l_dept,"' dzakcrtdp, SYSTIMESTAMP dzakcrtdt",
      "     FROM dzak_t",
      "     INNER JOIN dzac_t ON dzac001=dzak001 AND dzac003=dzak002 AND dzac004=dzak003 AND dzac012=dzak004",
      "     INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "       AND dzacstus='Y'",
      "       AND dzakstus='Y'"
      
      PREPARE insert_data_to_dzak_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzak_t"
      EXECUTE insert_data_to_dzak_t 


      ######-- dzad_t-- sql參考 sadzp030_tsd_get_dzad_sql(g_code, g_ver) 複製dzad_t(Action規格設計表)的SQL.
      LET ls_sql = 
      "INSERT INTO dzad_t(",
      "  dzadstus,",
      "  dzad001,",
      "  dzad002,",
      "  dzad003,",
      "  dzad099,",
      "  dzad005,",
      "  dzad006,",
      "  dzad007,",
      "  dzad008,",
      "  dzadownid,dzadowndp,dzadcrtid,dzadcrtdp,dzadcrtdt",
      "  )SELECT ",
      "     dzadstus,",
      "     '",g_gen_prog,"' dzad001,",
      "     dzad002,",
      "     '",g_gen_design_point_ver,"' dzad003,",
      "     REPLACE(dzad099,'",g_source_prog,"','",g_gen_prog,"') dzad099,",
      "     '",ms_dgenv,"' dzad005,",
      "     dzad006,",
      "     dzad007,",
      "     '",ms_cust,"' dzad008,",
      "     '",l_user,"' dzadownid,'",l_dept,"' dzadowndp,'",l_user,"' dzadcrtid,'",l_dept,"' dzadcrtdp, SYSTIMESTAMP dzadcrtdt",
      "     FROM dzad_t ",
      "     INNER JOIN dzaa_t ON dzaa001=dzad001 AND dzaa003=dzad002 AND dzaa004=dzad003 AND dzaa006=dzad005",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='2' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'"
      
      PREPARE insert_data_to_dzad_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzad_t"
      EXECUTE insert_data_to_dzad_t 


      ######-- dzag_t--  sql參考 sadzp030_tsd_get_dzag_sql(p_code, p_ver) 複製dzag_t(規格Table設定表)的SQL.
      LET ls_sql =
      "INSERT INTO dzag_t(",
      "  dzagstus,",
      "  dzag001,",
      "  dzag002,",
      "  dzag003,",
      "  dzag004,",
      "  dzag005,",
      "  dzag006,",
      "  dzag007,",
      "  dzag008,",
      "  dzag009,",
      "  dzag010,",
      "  dzag011,",
      "  dzag012,",
      "  dzagownid,dzagowndp,dzagcrtid,dzagcrtdp,dzagcrtdt",
      "  )SELECT ",
      "     dzagstus,",
      "     '",g_gen_prog,"' dzag001,",
      "     dzag002,",
      "     '",g_gen_design_point_ver,"' dzag003,",
      "     dzag004,",
      "     dzag005,",
      "     '",ms_dgenv,"' dzag006,",
      "     dzag007,",
      "     dzag008,",
      "     dzag009,",
      "     dzag010,",
      "     '",ms_cust,"' dzag011,",
      "     dzag012,",
      "     '",l_user,"' dzagownid,'",l_dept,"' dzagowndp,'",l_user,"' dzagcrtid,'",l_dept,"' dzagcrtdp, SYSTIMESTAMP dzagcrtdt",
      "     FROM dzag_t ",
      "     INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa004=dzag003 AND dzaa006=dzag006",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TABLE' AND dzaa005='4' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "       AND dzagstus='Y'"

      PREPARE insert_data_to_dzag_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzag_t"
      EXECUTE insert_data_to_dzag_t 


      ######-- dzfs_t--  自訂sql 複製dzfs_t(程式Table與Screen Record對應檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzfs_t(",
      "  dzfsstus,",
      "  dzfs001,",
      "  dzfs002,",
      "  dzfs003,",
      "  dzfs004,",
      "  dzfs005,",
      "  dzfs006,",
      "  dzfs007,",
      "  dzfs008,",
      "  dzfs009,",
      "  dzfs010,",
      "  dzfs011,",
      "  dzfs012,",
      "  dzfsownid,dzfsowndp,dzfscrtid,dzfscrtdp,dzfscrtdt",
      "  )SELECT ",
      "     dzfsstus,",
      "     '",g_gen_design_point_ver,"' dzfs001,",
      "     '",g_gen_prog,"' dzfs002,",
      "     REPLACE(dzfs003,'",g_source_prog,"','",g_gen_prog,"') dzfs003,",
      "     dzfs004,",
      "     '",ms_dgenv,"' dzfs005,",
      "     dzfs006,",
      "     dzfs007,",
      "     dzfs008,",
      "     dzfs009,",
      "     dzfs010,",
      "     '",ms_cust,"' dzfs011,",
      "     dzfs012,",
      "     '",l_user,"' dzfsownid,'",l_dept,"' dzfsowndp,'",l_user,"' dzfscrtid,'",l_dept,"' dzfscrtdp, SYSTIMESTAMP dzfscrtdt",
      "     FROM dzfs_t",
      "     INNER JOIN dzag_t ON dzag001=dzfs002 AND dzag002=dzfs004 AND dzag003=dzfs001 AND dzag006=dzfs005",
      "     INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa004=dzag003 AND dzaa006=dzag006",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TABLE' AND dzaa005='4' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "       AND dzagstus='Y'",
      "       AND dzfsstus='Y'"

      PREPARE insert_data_to_dzfs_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzfs_t"
      EXECUTE insert_data_to_dzfs_t 

      ######-- dzai_t-- sql參考 sadzp030_tsd_get_dzai_sql(g_code, g_ver) 複製dzai_t(欄位參考設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzai_t(",
      "  dzaistus,",
      "  dzai001,",
      "  dzai002,",
      "  dzai003,",
      "  dzai004,",
      "  dzai005,",
      "  dzai007,",
      "  dzai008,",
      "  dzai009,",
      "  dzai010,",
      "  dzai011,", 
      "  dzai012,", 
      "  dzaiownid,dzaiowndp,dzaicrtid,dzaicrtdp,dzaicrtdt",
      "  )SELECT ",
      "     dzaistus,",
      "     '",g_gen_prog,"' dzai001,",
      "     dzai002,",
      "     '",g_gen_design_point_ver,"' dzai003,",
      "     '",ms_dgenv,"' dzai004,",
      "     dzai005,",
      "     dzai007,",
      "     dzai008,",
      "     dzai009,",
      "     dzai010,",
      "     dzai011,",
      "     '",ms_cust,"' dzai012,",
      "     '",l_user,"' dzaiownid,'",l_dept,"' dzaiowndp,'",l_user,"' dzaicrtid,'",l_dept,"' dzaicrtdp, SYSTIMESTAMP dzaicrtdt",
      "     FROM dzai_t",
      "     INNER JOIN dzaa_t ON dzaa001=dzai001 AND dzaa003=dzai002 AND dzaa004=dzai003 AND dzaa006=dzai004",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='6' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'"
         
      PREPARE insert_data_to_dzai_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzai_t"
      EXECUTE insert_data_to_dzai_t 
      
      
      ######-- dzaj_t-- sql參考 sadzp030_tsd_get_dzaj_sql(p_code, p_ver) 複製dzaj_t(欄位資料多語言設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzaj_t(",
      "  dzajstus,",
      "  dzaj001,",
      "  dzaj002,",
      "  dzaj003,",
      "  dzaj004,",
      "  dzaj005,",
      "  dzaj007,",
      "  dzaj008,",
      "  dzaj009,",
      "  dzaj010,",
      "  dzaj011,", 
      "  dzaj012,", 
      "  dzajownid,dzajowndp,dzajcrtid,dzajcrtdp,dzajcrtdt",
      "  )SELECT ",
      "     dzajstus,",
      "     '",g_gen_prog,"' dzaj001,",
      "     dzaj002,",
      "     '",g_gen_design_point_ver,"' dzaj003,",
      "     '",ms_dgenv,"' dzaj004,",
      "     dzaj005,",
      "     dzaj007,",
      "     dzaj008,",
      "     dzaj009,",
      "     dzaj010,",
      "     dzaj011,",
      "     '",ms_cust,"' dzaj012,",
      "     '",l_user,"' dzajownid,'",l_dept,"' dzajowndp,'",l_user,"' dzajcrtid,'",l_dept,"' dzajcrtdp, SYSTIMESTAMP dzajcrtdt",
      "     FROM dzaj_t",
      "     INNER JOIN dzaa_t ON dzaa001=dzaj001 AND dzaa003=dzaj002 AND dzaa004=dzaj003 AND dzaa006=dzaj004",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='7' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'"
      
      PREPARE insert_data_to_dzaj_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzaj_t"
      EXECUTE insert_data_to_dzaj_t 
      

      ######-- dzal_t-- sql參考 sadzp030_tsd_get_dzal_sql(p_code, p_ver) 複製dzal_t(程式串查設計表)的SQL.
      LET ls_sql =
      "INSERT INTO dzal_t(",
      "  dzalstus,",
      "  dzal001,",
      "  dzal002,",
      "  dzal003,",
      "  dzal004,",
      "  dzal005,",
      "  dzal006,",
      "  dzal007,",
      "  dzal008,",
      "  dzal009,",
      "  dzalownid,dzalowndp,dzalcrtid,dzalcrtdp,dzalcrtdt",
      "  )SELECT ",
      "     dzalstus,",
      "     '",g_gen_prog,"' dzal001,",
      "     dzal002,",
      "     '",g_gen_design_point_ver,"' dzal003,",
      "     '",ms_dgenv,"' dzal004,",
      "     dzal005,",
      "     dzal006,",
      "     dzal007,",
      "     dzal008,",
      "     '",ms_cust,"' dzal009,",
      "     '",l_user,"' dzalownid,'",l_dept,"' dzalowndp,'",l_user,"' dzalcrtid,'",l_dept,"' dzalcrtdp, SYSTIMESTAMP dzalcrtdt",
      "     FROM dzal_t",
      "     INNER JOIN dzac_t ON dzac001=dzal001 AND dzac003=dzal005 AND dzac004=dzal003 AND dzac012=dzal004",
      "     INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "       AND dzacstus='Y'",
      "       AND dzalstus='Y'"
      
      PREPARE insert_data_to_dzal_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzal_t"
      EXECUTE insert_data_to_dzal_t 
      

      ######-- dzff_t-- sql參考 sadzp030_tsd_get_dzff_sql(g_code, g_ver) 複製dzff_t(樹狀結構屬性設定檔)的SQL.
      LET ls_sql =
      "INSERT INTO dzff_t(",
      "  dzffstus,",
      "  dzff001,",
      "  dzff002,",
      "  dzff003,",
      "  dzff004,",
      "  dzff005,",
      "  dzff006,",
      "  dzff007,",
      "  dzff008,", 
      "  dzff009,", 
      "  dzffownid,dzffowndp,dzffcrtid,dzffcrtdp,dzffcrtdt",
      "  )SELECT", 
      "     dzffstus,'",g_gen_prog,"' dzff001,",
      "     '",g_gen_design_point_ver,"' dzff002,",
      "     dzff003,",
      "     dzff004,",
      "     dzff005,",
      "     dzff006,",
      "     dzff007,",
      "     '",ms_dgenv,"' dzff008,",
      "     '",ms_cust,"' dzff009,",
      "     '",l_user,"' dzffownid,'",l_dept,"' dzffowndp,'",l_user,"' dzffcrtid,'",l_dept,"' dzffcrtdp, SYSTIMESTAMP dzffcrtdt",
      "     FROM dzff_t",
      "     INNER JOIN dzaa_t ON dzaa001=dzff001 AND dzaa003=dzff003 AND dzaa004=dzff002 AND dzaa006=dzff008",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='5' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "       AND dzffstus='Y'",
      "     ORDER BY dzff003,dzff004"
      
      PREPARE insert_data_to_dzff_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzff_t"
      EXECUTE insert_data_to_dzff_t 

      ######-- dzfq_t -- 自訂sql 複製dzfq_t(畫面結構設計主檔)的SQL.
    ##行業別產生不從r.a, 後面要用dzfq時應該要自己去取標準程式的內容 from hiko ;
    ##LET ls_sql =
    ##"INSERT INTO dzfq_t(
    ##   dzfqstus,
    ##   dzfq001,
    ##   dzfq002,
    ##   dzfq003,
    ##   dzfq004,
    ##   dzfq005,
    ##   dzfq006,
    ##   dzfq007,
    ##   dzfq008,
    ##   dzfq009,
    ##   dzfq010,
    ##   dzfq011,
    ##   dzfq012,
    ##   dzfq013,
    ##   dzfq014,
    ##   dzfq015,
    ##   dzfq016,
    ##   dzfqownid,dzfqowndp,dzfqcrtid,dzfqcrtdp,dzfqcrtdt
    ##   )SELECT DISTINCT
    ##      dzfqstus,
    ##      dzfq001,
    ##      dzfq002,
    ##      '",g_gen_design_point_ver,"' dzfq003,
    ##      '",g_gen_prog,"' dzfq004,
    ##      dzfq005,
    ##      dzfq006,
    ##      dzfq007,
    ##      dzfq008,
    ##      dzfq009,
    ##      dzfq010,
    ##      dzfq011,
    ##      dzfq012,
    ##      dzfq013,
    ##      dzfq014,
    ##      dzfq015,
    ##      dzfq016, 
    ##      '",l_user,"' dzfqownid,'",l_dept,"' dzfqowndp,'",l_user,"' dzfqcrtid,'",l_dept,"' dzfqcrtdp,'",l_date USING "yyyy/mm/dd","' dzfqcrtdt
    ##      FROM dzfq_t 
    ##      WHERE dzfq001 = '",g_source_prog,"' AND dzfq003 ='",g_source_spec_ver,"' AND dzfqstus='Y'"
    ##   
    ##PREPARE insert_data_to_dzfq_t FROM ls_sql
    ##LET ls_err = "error:insert_data_to_dzfq_t"
    ##EXECUTE insert_data_to_dzfq_t 

     
      ######-- gzzd_t -- 自訂sql 複製gzzd_t(畫面元件多語言記錄檔)的SQL.
      #gzzd004(使用標示)不置換
      #因為刪除設計資料function時並沒有包含此table, 所以要判斷是否存在,存在先刪除(暫時作法)
      LET ls_sql = 
      "SELECT COUNT(*) FROM gzzd_t
        WHERE gzzd001 = '",g_gen_prog,"'"
      PREPARE query_data_to_gzzd_t  FROM ls_sql
      LET ls_err = "error:query_data_to_gzzd_t"
      EXECUTE query_data_to_gzzd_t INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM gzzd_t WHERE gzzd001='",g_gen_prog,"'"
          EXECUTE IMMEDIATE ls_sql
      END IF
    
      LET ls_sql =
      "INSERT INTO gzzd_t(",
      "  gzzdstus,",
      "  gzzd001,",
      "  gzzd002,",
      "  gzzd003,",
      "  gzzd004,",
      "  gzzd005,",
      "  gzzd006,", 
      "  gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt",
      "  )SELECT ",
      "     gzzdstus,",
      "     '",g_gen_prog,"' gzzd001,",
      "     gzzd002,",
      "     REPLACE(gzzd003,'",g_source_prog,"','",g_gen_prog,"') gzzd003,",
      "     gzzd004,",
      "     gzzd005,",
      "     gzzd006,",
      "     '",l_user,"' gzzdownid,'",l_dept,"' gzzdowndp,'",l_user,"' gzzdcrtid,'",l_dept,"' gzzdcrtdp, SYSTIMESTAMP gzzdcrtdt",
      "     FROM gzzd_t",
      "     WHERE gzzd001 = '",g_source_prog,"' AND gzzdstus='Y'"
         
      PREPARE insert_data_to_gzzd_t FROM ls_sql
      LET ls_err = "error:insert_data_to_gzzd_t"
      EXECUTE insert_data_to_gzzd_t 
 
         
      #####-- gzzq_t -- 自訂sql 複製gzzq_t(ACTION多語言對照檔)的SQL.
      #gzzq006(使用標示)不置換
      #因為刪除設計資料function時並沒有包含此table, 所以要判斷是否存在,存在先刪除(暫時作法)
      LET ls_sql = 
      "SELECT COUNT(*) FROM gzzq_t
        WHERE gzzq001 = '",g_gen_prog,"'"
      PREPARE query_data_to_gzzq_t  FROM ls_sql
      LET ls_err = "error:query_data_to_gzzq_t"
      EXECUTE query_data_to_gzzq_t INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM gzzq_t WHERE gzzq001='",g_gen_prog,"'"
          EXECUTE IMMEDIATE ls_sql
      END IF

    ##20140710:madey modify -start-
    ##LET ls_sql =
    ##"SELECT gzzq002 
    ##      FROM gzzq_t
    ##      WHERE gzzq001 = '",g_source_prog,"'"
      LET ls_sql =
      "SELECT REPLACE(gzzq002,'",
       g_source_prog,"','",
       g_gen_prog,"') gzzq002",
      "  FROM gzzq_t",
      " WHERE gzzq001 = '",g_source_prog,"'"
    ##20140710:madey modify -end-

      LET ls_err = "error:insert_data_to_gzzq_t"
      CALL adzp600_insert_gzzq_t(ls_sql)

      
      #####-- gzzp_t -- 自訂sql 複製gzzp_t(階層式選單設定檔)的SQL.
      #因為刪除設計資料function時並沒有包含此table, 所以要判斷是否存在,存在先刪除(暫時作法)
      LET ls_sql = 
      "SELECT COUNT(*) FROM gzzp_t
        WHERE gzzp001 = '",g_gen_prog,"'"
      PREPARE query_data_to_gzzp_t  FROM ls_sql
      LET ls_err = "error:query_data_to_gzzp_t"
      EXECUTE query_data_to_gzzp_t INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM gzzp_t WHERE gzzp001='",g_gen_prog,"'"
          EXECUTE IMMEDIATE ls_sql
      END IF

      LET ls_sql =
      "INSERT INTO gzzp_t(",
      "  gzzpstus,",
      "  gzzp001,",
      "  gzzp002,",
      "  gzzp003,",
      "  gzzp004,",
      "  gzzp005,", 
      "  gzzpownid,gzzpowndp,gzzpcrtid,gzzpcrtdp,gzzpcrtdt",
      "  )SELECT ",
      "     gzzpstus,",
      "     '",g_gen_prog,"' gzzp001,",
      "     gzzp002,",
      "     gzzp003,",
      "     gzzp004,", 
      "     gzzp005,",
      "     '",l_user,"' gzzpownid,'",l_dept,"' gzzpowndp,'",l_user,"' gzzpcrtid,'",l_dept,"' gzzpcrtdp, SYSTIMESTAMP gzzpcrtdt",
      "     FROM gzzp_t",
      "     WHERE gzzp001='",g_source_prog,"' AND gzzpstus='Y'"
         
      PREPARE insert_data_to_gzzp_t FROM ls_sql
      LET ls_err = "error:insert_data_to_gzzp_t"
      EXECUTE insert_data_to_gzzp_t


      ######-- dzba_t -- 自訂sql 複製dzba_t(程式與內容版本對應表)的SQL.
      #dzba007 程式引用否=Y

      #拆成兩個動作
      #1. dzba003(add point name)不是.function .dialog .report 開頭的才可以置換dzba003
      LET ls_sql =
      "INSERT INTO dzba_t(",
      "  dzbastus,",
      "  dzba001,",
      "  dzba002,",
      "  dzba003,",
      "  dzba004,",
      "  dzba005,",
      "  dzba006,",
      "  dzba007,",
      "  dzba008,",
      "  dzba009,",
      "  dzba010,",
      "  dzba011,",
      "  dzbaownid,dzbaowndp,dzbacrtid,dzbacrtdp,dzbacrtdt",
      "  )SELECT ",
      "     dzbastus,",
      "     '",g_gen_prog,"' dzba001,",
      "     '",g_gen_spec_ver,"' dzba002,",
      "     REPLACE(dzba003,'",g_source_prog,"','",g_gen_prog,"') dzba003,",
      "     '",g_gen_design_point_ver,"' dzba004,",
      "     '",ms_dgenv,"' dzba005,",
      "     dzba006,",
      "     'Y' dzba007,",
      "     '",ms_erpver,"' dzba008,",
      "     dzba009,",
      "     '",ms_dgenv,"' dzba010,",
      "     '",ms_cust,"' dzba011,",
      "     '",l_user,"' dzbaownid,'",l_dept,"' dzbaowndp,'",l_user,"' dzbacrtid,'",l_dept,"' dzbacrtdp, SYSTIMESTAMP dzbacrtdt",
      "     FROM dzba_t",
      "     WHERE dzba001='",g_source_prog,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y'",
      "       AND (dzba003 NOT LIKE 'function.%' AND dzba003 NOT LIKE 'dialog.%' AND dzba003 NOT LIKE 'report.%')"
         
      PREPARE insert_data_to_dzba_t1 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzba_t"
      EXECUTE insert_data_to_dzba_t1 

      #2. dzba003(add point name)是.function .dialog .report 開頭的不可以置換dzba003
      LET ls_sql =
      "INSERT INTO dzba_t(",
      "  dzbastus,",
      "  dzba001,",
      "  dzba002,",
      "  dzba003,",
      "  dzba004,",
      "  dzba005,",
      "  dzba006,",
      "  dzba007,",
      "  dzba008,",
      "  dzba009,",
      "  dzba010,",
      "  dzba011,",
      "  dzbaownid,dzbaowndp,dzbacrtid,dzbacrtdp,dzbacrtdt",
      "  )SELECT ",
      "     dzbastus,",
      "     '",g_gen_prog,"' dzba001,",
      "     '",g_gen_spec_ver,"' dzba002,",
      "     dzba003,",
      "     '",g_gen_design_point_ver,"' dzba004,",
      "     '",ms_dgenv,"' dzba005,",
      "     dzba006,",
      "     'Y' dzba007,",
      "     '",ms_erpver,"' dzba008,",
      "     dzba009,",
      "     '",ms_dgenv,"' dzba010,",
      "     '",ms_cust,"' dzba011,",
      "     '",l_user,"' dzbaownid,'",l_dept,"' dzbaowndp,'",l_user,"' dzbacrtid,'",l_dept,"' dzbacrtdp, SYSTIMESTAMP dzbacrtdt",
      "     FROM dzba_t",
      "     WHERE dzba001='",g_source_prog,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y'",
      "       AND (dzba003 LIKE 'function.%' OR dzba003 LIKE 'dialog.%' OR dzba003 LIKE 'report.%')"
         
      PREPARE insert_data_to_dzba_t2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzba_t"
      EXECUTE insert_data_to_dzba_t2 
 

      ######-- dzbb_t -- 自訂sql 複製dzbb_t(程式設計點設計表)的SQL.
      #另外,所有add point 內容dzbb098也都不應該置換

      #拆成兩個動作
      #1. dzbb002(add point name)不是.function .dialog .report 開頭的才可以置換dzbb002,但dzbb098一律不置換
      LET ls_sql =
      "INSERT INTO dzbb_t(",
      "  dzbbstus,",
      "  dzbb001,",
      "  dzbb002,",
      "  dzbb003,",
      "  dzbb004,",
      "  dzbb098,",
      "  dzbb005,",
      "  dzbb006,", 
      "  dzbbownid,dzbbowndp,dzbbcrtid,dzbbcrtdp,dzbbcrtdt",
      "  )SELECT ",
      "     dzbbstus,",
      "     '",g_gen_prog,"' dzbb001,",
      "     REPLACE(dzbb002,'",g_source_prog,"','",g_gen_prog,"') dzbb002,",
      "     '",g_gen_design_point_ver,"' dzbb003,",
      "     '",ms_dgenv,"' dzbb004,",
      "     dzbb098,",
      "     '",ms_cust,"' dzbb005,",
      "     dzbb006,",
      "     '",l_user,"' dzbbownid,'",l_dept,"' dzbbowndp,'",l_user,"' dzbbcrtid,'",l_dept,"' dzbbcrtdp, SYSTIMESTAMP dzbbcrtdt",
      "     FROM dzbb_t",
      "     INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzba005 = dzbb004",
      "     WHERE dzba001='",g_source_prog,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y'",
      "       AND (dzbb002 NOT LIKE 'function.%' AND dzbb002 NOT LIKE 'dialog.%' AND dzbb002 NOT LIKE 'report.%')"
         
      PREPARE insert_data_to_dzbb_t1 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbb_t"
      EXECUTE insert_data_to_dzbb_t1 

      #2. dzbb002(add point name)是.function .dialog .report 開頭的不可以置換dzbb002,但dzbb098一律不置換
      LET ls_sql =
      "INSERT INTO dzbb_t(",
      "  dzbbstus,",
      "  dzbb001,",
      "  dzbb002,",
      "  dzbb003,",
      "  dzbb004,",
      "  dzbb098,",
      "  dzbb005,",
      "  dzbb006,", 
      "  dzbbownid,dzbbowndp,dzbbcrtid,dzbbcrtdp,dzbbcrtdt",
      "  )SELECT ",
      "     dzbbstus,",
      "     '",g_gen_prog,"' dzbb001,",
      "     dzbb002,",
      "     '",g_gen_design_point_ver,"' dzbb003,",
      "     '",ms_dgenv,"' dzbb004,",
      "     dzbb098,",
      "     '",ms_cust,"' dzbb005,",
      "     dzbb006,",
      "     '",l_user,"' dzbbownid,'",l_dept,"' dzbbowndp,'",l_user,"' dzbbcrtid,'",l_dept,"' dzbbcrtdp, SYSTIMESTAMP dzbbcrtdt",
      "     FROM dzbb_t",
      "     INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzba005 = dzbb004",
      "     WHERE dzba001='",g_source_prog,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y'", 
      "       AND (dzbb002 LIKE 'function.%' OR dzbb002 LIKE 'dialog.%' OR dzbb002 LIKE 'report.%')"
         
      PREPARE insert_data_to_dzbb_t2 FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbb_t"
      EXECUTE insert_data_to_dzbb_t2 


      ######-- dzam_t -- 自訂sql 複製dzam_t(規格畫面元件排除設定)的SQL
      LET ls_sql =
      "INSERT INTO dzam_t(",
      "  dzamstus,",
      "  dzam001,",
      "  dzam002,",
      "  dzam003,",
      "  dzam004,",
      "  dzam005,",
      "  dzam006,",
      "  dzamownid,dzamowndp,dzamcrtid,dzamcrtdp,dzamcrtdt",
      "  )SELECT",
      "     dzamstus,",
      "     '",g_gen_prog,"' dzam001,",
      "     '",ms_dgenv,"' dzam002,",
      "     dzam003,",
      "     '",g_gen_design_point_ver,"' dzam004,",
      "     '",ms_dgenv,"' dzam005,",
      "     '",ms_cust,"' dzam006,",
      "     '",l_user,"' dzamownid,'",l_dept,"' dzamowndp,'",l_user,"' dzamcrtid,'",l_dept,"' dzamcrtdp, SYSTIMESTAMP dzamcrtdt",
      "     FROM dzam_t",
      "     INNER JOIN dzaa_t ON dzaa001=dzam001 AND dzaa004=dzam004 AND dzaa006=dzam005",
      "     WHERE dzaa001='",g_source_prog,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='EXCLUDE' AND dzaa005='a' AND dzaa009='",g_source_identity,"' AND dzaastus='Y'",
      "       AND dzamstus='Y'"

      PREPARE insert_data_to_dzam_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzam_t"
      EXECUTE insert_data_to_dzam_t 


      ######-- dzbc_t -- 自訂sql 複製dzbc_t(代碼與內容版本對應表)的SQL
      #補充:1.dzbc005不更新為ms_dgenv的原因是section一但有動過就會給c,因此應該保留原值
      #     2.dzbc004(section版次)不更新,因為跟程式樣版有關,因此保留原值
      
      LET ls_sql =
      "INSERT INTO dzbc_t(",
      "  dzbcstus,",
      "  dzbc001,",
      "  dzbc002,",
      "  dzbc003,",
      "  dzbc004,",
      "  dzbc005,",
      "  dzbc006,",
      "  dzbc007,",
      "  dzbc008,",
      "  dzbc009,",
      "  dzbc010,",
      "  dzbc011 ",
      "  )SELECT ",
      "     dzbcstus,",
      "     '",g_gen_prog,"' dzbc001,",
      "     '",g_gen_spec_ver,"' dzbc002,",
      "     REPLACE(dzbc003,'",g_source_prog,"','",g_gen_prog,"') dzbc003,",
      "     dzbc004,",
      "     dzbc005,",
      "     '",ms_erpver,"' dzbc006,",
      "     '",ms_dgenv,"' dzbc007,",
      "     '",ms_cust,"' dzbc008,",
      "     dzbc009,",
      "     dzbc010,",
      "     dzbc011 ",
      "     FROM dzbc_t",
      "     WHERE dzbc001='",g_source_prog,"' AND dzbc002='",g_source_code_ver,"' AND dzbc007='",g_source_identity,"' AND dzbcstus='Y'"
      
      PREPARE insert_data_to_dzbc_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbc_t"
      EXECUTE insert_data_to_dzbc_t

      ######-- dzbd_t -- 自訂sql 複製dzbd_t(代碼設計點設計表)的SQL
      #補充:1.dzbd004不更新為ms_dgenv的原因是section一但有動過就會給c,因此保留原本的值
      #     2.dzbd003(section版次)不更新,因為跟樣版有關,因此保留原值
      #     3.dzbd098不置換
      LET ls_sql =
      "INSERT INTO dzbd_t(",
      "  dzbdstus,",
      "  dzbd001,",
      "  dzbd002,",
      "  dzbd003,",
      "  dzbd004,",
      "  dzbd005,",
      "  dzbd098",
      "  )SELECT",
      "     dzbdstus,",
      "     '",g_gen_prog,"' dzbd001,",
      "     REPLACE(dzbd002,'",g_source_prog,"','",g_gen_prog,"') dzbd002,",
      "     dzbd003,",
      "     dzbd004,",
      "     '",ms_cust,"' dzbd005,",
      "     dzbd098",
      "     FROM dzbd_t",
      "     INNER JOIN dzbc_t ON dzbc001 = dzbd001 AND dzbc003 = dzbd002 AND dzbc004 = dzbd003 AND dzbc005 = dzbd004",
      "     WHERE dzbc001='",g_source_prog,"' AND dzbc002='",g_source_code_ver,"' AND dzbc007='",g_source_identity,"' AND dzbcstus='Y'"

      PREPARE insert_data_to_dzbd_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzbd_t"
      EXECUTE insert_data_to_dzbd_t


      ######-- dzax_t -- 自訂sql 複製dzax_t(程式設計基本設定表)的SQL
      #因為刪除設計資料function時並沒有包含此table, 所以要判斷是否存在,存在先刪除(暫時作法)
      LET ls_sql = 
      "SELECT COUNT(*) FROM dzax_t",
      " WHERE dzax001 = '",g_gen_prog,"' AND dzax006 = '",ms_dgenv,"'" 
      PREPARE query_data_to_dzax_t  FROM ls_sql
      LET ls_err = "error:query_data_to_dzax_t"
      EXECUTE query_data_to_dzax_t INTO ln_cnt

      IF ln_cnt > 0  THEN
         LET ls_sql = "DELETE FROM dzax_t WHERE dzax001='",g_gen_prog,"' AND dzax006 = '",ms_dgenv,"'" 
         EXECUTE IMMEDIATE ls_sql
      END IF

      LET ls_sql =
      "INSERT INTO dzax_t(",
      "  dzaxstus,",
      "  dzax001,",
      "  dzax002,",
      "  dzax003,",
      "  dzax004,",
      "  dzax005,",
      "  dzax006,",
      "  dzax007 ",
      "  )SELECT",
      "     'Y' dzaxstus,",
      "     '",g_gen_prog,"' dzax001,",
      "     dzax002,",
      "     dzax003,",
      "     'N' dzax004,", #20141208 modify
      "     '",ms_cust,"' dzax005,",
      "     '",ms_dgenv,"' dzax006,",
      "     dzax007",
      "     FROM dzax_t",
      "     WHERE dzax001 = '",g_source_prog,"'",
      "       AND dzax006 = '",g_source_identity,"'"
      
      PREPARE insert_data_to_dzax_t FROM ls_sql
      LET ls_err = "error:insert_data_to_dzax_t"
      EXECUTE insert_data_to_dzax_t

   CATCH
      IF SQLCA.sqlcode THEN
         DISPLAY "############### SQL ERROR ###############"
         DISPLAY "sql = ",ls_sql
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ls_err||" sql="||ls_sql
         LET g_errparam.popup = TRUE
         CALL cl_err()
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
      FREE insert_data_to_dzag_t
      FREE insert_data_to_dzfs_t
      FREE insert_data_to_dzai_t
      FREE insert_data_to_dzaj_t
      FREE insert_data_to_dzal_t
      FREE insert_data_to_dzff_t
    ##FREE insert_data_to_dzfq_t
      FREE insert_data_to_gzzd_t
      FREE insert_data_to_gzzp_t
      FREE insert_data_to_dzba_t1
      FREE insert_data_to_dzba_t2
      FREE insert_data_to_dzbb_t1
      FREE insert_data_to_dzbb_t2
      FREE insert_data_to_dzam_t
    ##FREE insert_data_to_dzbc_t
    ##FREE insert_data_to_dzbd_t
      FREE insert_data_to_dzax_t
      FREE query_data_to_gzzd_t
      FREE query_data_to_gzzp_t
      FREE query_data_to_gzzq_t
      FREE query_data_to_dzax_t
   ELSE
      ROLLBACK WORK
   END IF
 
   RETURN lb_flag
END FUNCTION


#+ 錯誤訊息顯示
PRIVATE FUNCTION adzp600_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00001"
      LET g_errparam.extend = p_trigger
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  SQLCA.SQLCODE
      CALL cl_err()
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00001"
      LET g_errparam.extend = p_trigger
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  NULL
      CALL cl_err()
   END IF
END FUNCTION


#+ 複製gzzd_t(畫面元件多語言記錄檔)
PRIVATE FUNCTION adzp600_insert_gzzd_t(ps_sql)
   DEFINE ln_cnt      LIKE type_t.num5,
          ps_sql      STRING,
          ls_text     STRING,
          ls_comment  STRING
          
   #DISPLAY "### adzp600_insert_gzzd_t ### start ###"

   PREPARE insert_data_to_gzzd_t_3 FROM ps_sql
   DECLARE gzzd_curs CURSOR FOR insert_data_to_gzzd_t_3

   CALL ga_gzzd_t.clear()
   LET ln_cnt = 1
   
   FOREACH gzzd_curs INTO ga_gzzd_t[ln_cnt].source_label,ga_gzzd_t[ln_cnt].gen_label
      DISPLAY "ga_gzzd_t[ln_cnt].source_label = ",ga_gzzd_t[ln_cnt].source_label

      #取出來源程式的轉換的多語言和註解
      CALL s_azzi902_get_gzzd(g_source_prog, ga_gzzd_t[ln_cnt].source_label) RETURNING ls_text,ls_comment


      #DISPLAY "ga_gzzd_t[ln_cnt].gen_label = ",ga_gzzd_t[ln_cnt].gen_label
      #塞入產生程式的多語言和註解
      IF NOT s_azzi902_ins_gzzd(g_gen_prog, ga_gzzd_t[ln_cnt].gen_label, ls_text,ls_comment) THEN
         DISPLAY "ERROR: insert gzzd_t :",ga_gzzd_t[ln_cnt].gen_label
      END IF
      
      LET ln_cnt = ln_cnt + 1
   END FOREACH

   CALL ga_gzzd_t.deleteElement(ln_cnt)
   LET ln_cnt = ln_cnt - 1
  
   #DISPLAY "### adzp600_insert_gzzd_t ### end ###"

END FUNCTION

#+ 複製gzzq_t(ACTION多語言對照檔)
PRIVATE FUNCTION adzp600_insert_gzzq_t(ps_sql)
   DEFINE ln_cnt     LIKE type_t.num5,
          ps_sql     STRING,
          ls_text    STRING,
          ls_comment STRING,
          ls_standard STRING
          
   #DISPLAY "### adzp600_insert_gzzq_t ### start ###"

   PREPARE insert_data_to_gzzq_t FROM ps_sql
   DECLARE gzzq_curs CURSOR FOR insert_data_to_gzzq_t

   CALL ga_gzzq_t.clear()
   LET ln_cnt = 1
   
   FOREACH gzzq_curs INTO ga_gzzq_t[ln_cnt].*

      CALL s_azzi903_get_gzzq(g_source_prog,ga_gzzq_t[ln_cnt].gzzq002) RETURNING ls_text,ls_comment,ls_standard
   
      IF NOT s_azzi903_ins_gzzq(g_gen_prog, ga_gzzq_t[ln_cnt].gzzq002,ls_text,ls_comment) THEN
         #DISPLAY "ERROR: insert gzzq_t :",ga_gzzq_t[ln_cnt].gzzq002
      END IF
      
      LET ln_cnt = ln_cnt + 1
   END FOREACH

   CALL ga_gzzq_t.deleteElement(ln_cnt)
   LET ln_cnt = ln_cnt - 1
  
   DISPLAY "### adzp600_insert_gzzq_t ### end ###"
   FREE insert_data_to_gzzq_t

END FUNCTION

#+ 控制欄位可否輸入
PUBLIC FUNCTION adzp600_set_comp_entry(ps_fields, pi_entry)
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


#+ 顯示資料
PRIVATE FUNCTION adzp600_show()
  
   #顯示相關欄位值在form上
   DISPLAY g_gen_prog_name,g_main_or_sub_prog,g_gen_ver,g_gen_ver_desc,g_gen_spec_ver,g_gen_code_ver,g_source_prog,g_source_prog_name,g_source_ver,g_source_ver_desc,g_source_spec_ver,g_source_code_ver
        TO s_gen_prog_name,s_main_or_sub_prog,s_gen_ver,s_gen_ver_desc,s_gen_spec_ver,s_gen_code_ver,s_source_prog,s_source_prog_name,s_source_ver,s_source_ver_desc,s_source_spec_ver,s_source_code_ver

END FUNCTION


#+ 檢查資料
#+ TRUE:正常 FALSE:異常
PRIVATE FUNCTION adzp600_prog_validate()
   DEFINE ls_sql     STRING,
          ln_cnt     LIKE type_t.num5,
          lb_result  BOOLEAN,
          l_gzcb002  LIKE gzcb_t.gzcb002,
          l_gzcbl004 LIKE gzcbl_t.gzcbl004,
          l_gzzb002  LIKE gzzb_t.gzzb002,
          l_gzzb003  LIKE gzzb_t.gzzb003

   DEFINE ls_err_msg STRING ,
          lo_DZAF_T T_DZAF_T,
          l_identity LIKE dzaf_t.dzaf010 

   DEFINE lo_program_info DYNAMIC ARRAY OF T_PROGRAM_INFO,  #程式的動態陣列物件
          lb_result_SD    BOOLEAN,                          #回傳布林值
          lb_result_PR    BOOLEAN,                          #回傳布林值
          ls_owner        STRING,
          ls_replace_msg  STRING                            #來源程式是否簽出錯誤訊息用


   #檢查目標程式是否存在於行業別table,是的話set g_source_prog
   SELECT gzzb002,gzzb003 INTO l_gzzb002,l_gzzb003 FROM gzzb_t
           WHERE gzzb001=g_gen_prog
   IF SQLCA.sqlcode THEN
      #顯示訊息告知沒有在gzzb_t註冊，請重新輸入
      DISPLAY '程式代號%1不存在表格%2中',g_gen_prog," gzzb_t"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00282'
      LET g_errparam.extend = NULL
      LET g_errparam.popup = FALSE
      LET g_errparam.replace[1] = g_gen_prog #20150129
      LET g_errparam.replace[2] = "gzzb_t"   #20150129
      CALL cl_err()
      RETURN FALSE
   ELSE 
      IF l_gzzb002 = 'sd' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00278'
         LET g_errparam.extend = NULL
         LET g_errparam.popup = FALSE
         LET g_errparam.replace[1] = g_gen_prog #20150129
         CALL cl_err()
         DISPLAY '此程式%並非行業別程式，請重新輸入:',g_gen_prog
         RETURN FALSE
      ELSE
        LET g_source_prog = l_gzzb003
      END IF
   END IF

   #確認來源程式存在並取得相關資訊
   CALL adzp600_get_prog_data(g_source_prog,"g_source_prog") RETURNING lb_result,g_source_type,g_source_module,g_source_prog_name
   IF NOT lb_result THEN
       RETURN FALSE
   END IF

   #確認目標程式存在並取得相關資訊
   CALL adzp600_get_prog_data(g_gen_prog,"g_gen_prog") RETURNING lb_result,g_gen_type,g_gen_module,g_gen_prog_name
   IF NOT lb_result THEN
       RETURN FALSE
   END IF


   #取得目標程式的建構版次，並檢查建構版次不可大於1
   CALL sadzp060_2_get_curr_ver_info(g_gen_prog, g_gen_type , g_gen_module) RETURNING lo_DZAF_T.*,ls_err_msg
   IF cl_null(ls_err_msg) THEN
      LET g_gen_ver_desc = ''
      LET g_gen_ver      = lo_DZAF_T.dzaf002
      LET g_gen_spec_ver = lo_DZAF_T.dzaf003
      LET g_gen_code_ver = lo_DZAF_T.dzaf004
      LET g_gen_identity = lo_DZAF_T.dzaf010 

     #20140922 add -Begin-
      LET g_gen_ver      = g_gen_ver.trim()
      LET g_gen_spec_ver = g_gen_spec_ver.trim()
      LET g_gen_code_ver = g_gen_code_ver.trim()
     #20140922 add -End-

      #檢查目標程式的建構版次不可大於1
      IF g_gen_ver > '1' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00273"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_gen_prog #20141016
         CALL cl_err()
         RETURN FALSE
      END IF
   ELSE
      #目標程式有可能是新註冊且尚未簽出,此時不會有dzaf資料,by pass
      LET g_gen_ver_desc = '找不到版次資料'
      LET g_gen_ver      = ''                
      LET g_gen_spec_ver = ''                
      LET g_gen_code_ver = ''                
      LET g_gen_identity = ''                 
    ##CALL cl_err_msg(ls_err_msg,'adz-00302',g_gen_prog,1)
    ##RETURN FALSE
   END IF

   #判斷是否已經簽出
   #指定g_gen_role:有些類型要防呆(給正確的role) 
   CASE 
     WHEN g_gen_type ="F" #只有規格
        LET g_gen_role = "SD"
        LET g_gen_delete_kind = "SPEC" #20140725:madey
     WHEN g_main_or_sub_prog MATCHES "WZ" #只有程式
        LET g_gen_role = "PR"
        LET g_gen_delete_kind = "CODE" #20140725:madey
     OTHERWISE
        LET g_gen_role = "ALL"
        LET g_gen_delete_kind = "ALL" #20140725:madey
   END CASE
   IF g_run_mode = "debug" THEN #20141016
   ELSE
      CALL sadzp060_2_have_checked_out(g_gen_prog,g_gen_type,g_gen_role,'1') RETURNING ls_err_msg
      IF NOT cl_null(ls_err_msg) THEN
         RETURN FALSE
      END IF
   END IF


   #取得來源程式的建構版次
   CALL sadzp060_2_get_curr_ver_info(g_source_prog, g_source_type, g_source_module) RETURNING lo_DZAF_T.*,ls_err_msg
   IF cl_null(ls_err_msg) THEN
      LET g_source_ver      = lo_DZAF_T.dzaf002
      LET g_source_spec_ver = lo_DZAF_T.dzaf003
      LET g_source_code_ver = lo_DZAF_T.dzaf004
      LET g_source_identity = lo_DZAF_T.dzaf010

     #20140922 add -Begin-
      LET g_source_ver      = g_source_ver.trim()
      LET g_source_spec_ver = g_source_spec_ver.trim()
      LET g_source_code_ver = g_source_code_ver.trim()
     #20140922 add -End-
      CASE
         WHEN g_source_prog MATCHES "[MSGXF]"
            IF cl_null(g_source_spec_ver) THEN 
               LET ls_err_msg = "ERROR : ",g_source_prog," spec revision is NULL or 0"
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adz-00303'
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_source_prog
               CALL cl_err()
               RETURN FALSE
            END IF
         WHEN g_source_prog MATCHES "[BWZ]"
            IF cl_null(g_source_code_ver) THEN 
               LET ls_err_msg = "ERROR : ",g_source_prog," code revision is NULL or 0"
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adz-00304'
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_source_prog
               CALL cl_err()
               RETURN FALSE
            END IF
      END CASE
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00302'
      LET g_errparam.extend = ls_err_msg
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_source_prog
      CALL cl_err()
      RETURN FALSE
   END IF

 ##舊寫法 -start- 
 ###取得目標程式的建構版次，並檢查建構版次不可大於1
 ##SELECT MAX(dzaf002) INTO g_gen_ver FROM dzaf_t WHERE dzaf001=g_gen_prog
 ##IF g_gen_ver > 1 THEN
 ##   CALL cl_err_msg("","adz-00273",g_gen_prog,1)
 ##   RETURN FALSE
 ##ELSE
 ##  #沒在alm註冊/ 或是建構版次=1，不管是哪一種，規格版次及代碼版次都只會是1,所以by pass
 ##  #此時l_dzaf002可能是1或null , null表示沒有在alm註冊
 ##  IF cl_null(g_gen_ver) THEN 
 ##     LET g_gen_ver = '1'
 ##     LET g_gen_ver_desc = '找不到版次資料，預設版次為1'
 ##  ELSE 
 ##     LET g_gen_ver_desc = ''
 ##  END IF
 ##  LET g_gen_spec_ver = '1'
 ##  LET g_gen_code_ver = '1'
 ##END IF
 ##
 ###取得來源程式的建構版次
 ##SELECT MAX(dzaf002) INTO g_source_ver FROM dzaf_t WHERE dzaf001=g_source_prog
 ##IF g_source_ver > 0 THEN
 ##   SELECT dzaf003,dzaf004 INTO g_source_spec_ver,g_source_code_ver
 ##      FROM dzaf_t WHERE dzaf001=g_source_prog AND dzaf002=g_source_ver
 ##   LET g_source_ver_desc = ''
 ##ELSE
 ##  #沒在alm註冊，規格版次及代碼版次當做1
 ##  LET g_source_ver = '1'
 ##  LET g_source_ver_desc = '找不到版次資料，預設版次為1'
 ##  LET g_source_spec_ver = '1'
 ##  LET g_source_code_ver = '1'
 ##END IF
 ##舊寫法 -end-

   #取得來源程式free_style flag
   SELECT dzax003 INTO g_source_free_style
    FROM dzax_t
    WHERE dzax001 = g_source_prog AND dzax006 = g_source_identity
   #Begin:20160523 mark by elena
   #20150129 -Begin-
   #IF g_source_free_style='Y' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'adz-00521'
   #   LET g_errparam.extend = NULL
   #   LET g_errparam.popup = TRUE
   #   #LET g_errparam.replace[1] = g_gen_prog 
   #   LET g_errparam.replace[1] = g_source_prog #2015/09/08 by Hiko
   #   CALL cl_err()
   #   DISPLAY '此來源程式%1為Free Style,無法執行行業規格及程式產生:',g_gen_prog
   #   RETURN FALSE
   #END IF
   #20150129 -End-
   #End:20160523 mark by elena
   #取得目標程式free_style flag
   SELECT dzax003 INTO g_gen_free_style
    FROM dzax_t
    WHERE dzax001 = g_gen_prog AND dzax006 = g_gen_identity

   #檢查來源程式是否已有設計資料,若沒有設計資料則無法複製
   CASE 
       WHEN g_source_type MATCHES "[MSF]"
         #SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_source_prog AND dzaa002 = g_source_spec_ver
          LET g_source_spec_ver_col = g_source_spec_ver  #20140922 add
          SELECT COUNT(*) INTO ln_cnt FROM  dzaa_t WHERE dzaa001 = g_source_prog AND dzaa002 = g_source_spec_ver_col
       OTHERWISE 
          LET ln_cnt =0
    END CASE
    IF ln_cnt = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00144"
       LET g_errparam.extend = g_source_prog
       LET g_errparam.popup = g_errshow
       CALL cl_err()
       RETURN FALSE
    END IF
 

   #elena 20150529 End#確認來源程式、規格是否簽出，已簽出顯示提示訊息
   #elena 20150529 Begin
   #設定程式資訊(有多支程式時請用For迴圈給定)
   LET g_main_or_sub_prog = g_gen_type
   LET lo_program_info[1].pi_NAME = g_source_prog #程式代碼
   LET lo_program_info[1].pi_TYPE = g_main_or_sub_prog #類別
   IF g_main_or_sub_prog = "M" OR g_main_or_sub_prog = "S" OR g_main_or_sub_prog = "F" OR g_main_or_sub_prog = "Q" THEN
      CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "SD") RETURNING lb_result_SD,ls_owner
   END IF
   IF g_main_or_sub_prog = "M" OR g_main_or_sub_prog = "S" OR g_main_or_sub_prog = "B" OR g_main_or_sub_prog = "Q" THEN
      CALL sadzp200_alm_get_alm_owner_by_role(lo_program_info[1].*, "PR") RETURNING lb_result_PR,ls_owner
   END IF

   IF lb_result_SD IS NOT NULL THEN
      IF lb_result_PR IS NOT NULL THEN
         IF lb_result_SD AND lb_result_PR THEN
            LET ls_replace_msg = "規格與程式"
         ELSE
            IF lb_result_SD AND NOT lb_result_PR THEN
               LET ls_replace_msg = "規格"
            ELSE
               LET ls_replace_msg = "程式"
            END IF
         END IF
      ELSE
          IF lb_result_SD THEN
             LET ls_replace_msg = "規格"
          END IF
      END IF
   ELSE
      IF lb_result_PR THEN
         LET ls_replace_msg = "程式"
      END IF
   END IF

   IF lb_result_SD OR lb_result_PR THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00623"
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ls_replace_msg
      CALL cl_err()
   END IF

   #elena 20150529 End

   #Begin:20160223 by elena
   IF g_source_type MATCHES "[MSFQ]" THEN
      LET g_source_spec_ver_col = g_source_spec_ver
      SELECT COUNT(*) INTO ln_cnt FROM dzfi_t WHERE dzfi001 = g_source_prog AND dzfi002 = g_source_spec_ver_col AND dzfi009 = g_source_identity

      IF ln_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00144"
         LET g_errparam.extend = g_source_prog
         LET g_errparam.popup = g_errshow
         CALL cl_err()
      END IF
   END IF
   IF g_main_or_sub_prog <> "F" THEN
      LET g_source_code_ver_col = g_source_code_ver
      SELECT COUNT(*) INTO ln_cnt FROM dzbc_t WHERE dzbc001 = g_source_prog AND dzbc002 = g_source_code_ver_col AND dzbc007 = g_source_identity

      IF ln_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00144"
         LET g_errparam.extend = g_source_prog
         LET g_errparam.popup = g_errshow
         CALL cl_err()
      END IF
   END IF
   #End:20160223 by elena

 

   #轉換產生程式的類型說明
   LET ls_sql = " SELECT gzcb002 ,gzcbl004 ",
                " FROM  gzcb_t cb ",
                " LEFT OUTER JOIN gzcbl_t",
                "       ON gzcb001 = gzcbl001",
                "      AND gzcb002 = gzcbl002",
                "      AND gzcbl003 = '",g_lang,"'",
                "    WHERE gzcb001 = 114",
                "      AND gzcb002 = '",g_gen_type,"'"
   PREPARE gzzb_cs1 FROM ls_sql
   EXECUTE gzzb_cs1 INTO l_gzcb002,l_gzcbl004
   FREE gzzb_cs1
   LET g_main_or_sub_prog = l_gzcb002 || '. ' || l_gzcbl004

   
   RETURN TRUE
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 判斷程式是否存在/是否有效,並取得程式的類型,模組,名稱
# Input parameter : p_prog 程式代號
#                   p_tag  區分是來源或目標程式呼叫的, (g_copy_source/g_gen_prog)
#                          目標程式的檢核邏輯更嚴格,
# Return code     : flag  :TRUE:有註冊且正常  FALSE:沒有註冊或異常 
#                   prog_type  :規格類型
#                   prog_module:歸屬模組代號
#                   prog_name  :程式名稱 
# Date & Author   : 2014/05/22 by madey
##########################################################################
#+ 判斷程式是否存在/是否有效,並取得程式的類型,模組,名稱
PRIVATE FUNCTION adzp600_get_prog_data(p_prog,p_tag)
   DEFINE p_prog         LIKE dzaa_t.dzaa001,#程式id
          p_tag          STRING

   DEFINE lr_prog_data    RECORD
             msg          STRING,
             type    LIKE gzde_t.gzde003,   #類別
             module  LIKE gzde_t.gzde002,   #模組別
             name    LIKE gzdel_t.gzdel003, #名稱
             cust_fg LIKE gzza_t.gzza011,   #客製否
             stus    LIKE gzza_t.gzzastus   #有效否
          END RECORD

   DEFINE lc_fg    LIKE type_t.chr1
   DEFINE lc_fg2   LIKE type_t.chr1 #20141003
              
   INITIALIZE lr_prog_data.* TO NULL
   
   #1.是否為主程式   
   SELECT gzza003,gzzastus,gzza011,gzzal003 
     INTO lr_prog_data.module, lr_prog_data.stus, lr_prog_data.cust_fg, lr_prog_data.name
     FROM gzza_t
     LEFT JOIN gzzal_t
       ON gzza001 = gzzal001 AND gzzal002 = g_lang
    WHERE gzza001 = p_prog
   IF SQLCA.sqlcode = 0  THEN  #找到
      LET lr_prog_data.type= "M" 
      IF lr_prog_data.stus = "N" THEN
         DISPLAY "此程式為失效:",p_prog
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00172'
         LET g_errparam.extend = NULL
         LET g_errparam.popup = FALSE
         LET g_errparam.replace[1] = p_prog
         CALL cl_err()
         RETURN FALSE,'','',''
      END IF
   ELSE	  

      #2.是否為子程式/元件
      SELECT gzde002,gzde003,gzdestus,gzde008,gzdel003
        INTO lr_prog_data.module, lr_prog_data.type, lr_prog_data.stus, lr_prog_data.cust_fg, lr_prog_data.name
        FROM gzde_t
        LEFT JOIN gzdel_t
          ON gzde001 = gzdel001 AND gzdel002 = g_lang
       WHERE gzde001 = p_prog
       IF SQLCA.sqlcode =0 THEN  #找到
          CASE 
             WHEN lr_prog_data.stus = "N" 
                DISPLAY "此程式為失效:",p_prog
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'adz-00172'
                LET g_errparam.extend = NULL
                LET g_errparam.popup = FALSE
                LET g_errparam.replace[1] = p_prog
                CALL cl_err()
                RETURN FALSE,'','',''
            #WHEN lr_prog_data.type MATCHES "[BGXW]"
             WHEN lr_prog_data.type MATCHES "[SFBGXW]"
                DISPLAY "此作業%1的類別為%2類，目前不支持產生行業別程式",p_prog,"(",lr_prog_data.type,")"
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'adz-00279'
                LET g_errparam.extend = NULL
                LET g_errparam.replace[1] = p_prog
                LET g_errparam.replace[2] = lr_prog_data.type
                LET g_errparam.popup = FALSE
                CALL cl_err()
                RETURN FALSE,'','',''
          END CASE	   
       ELSE

          #3.1是否為子畫面(主程式的)(azzi900)
          SELECT gzdf003,gzza003,gzzastus,gzdfl003
            INTO lr_prog_data.cust_fg, lr_prog_data.module, lr_prog_data.stus, lr_prog_data.name
            FROM gzdf_t
           INNER JOIN gzza_t
              ON gzdf001 = gzza001
            LEFT JOIN gzdfl_t
              ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
           WHERE gzdf002 = p_prog

          IF SQLCA.sqlcode =0 THEN #找到
             LET lr_prog_data.type   = "F" 
             IF lr_prog_data.stus = "N" THEN
                DISPLAY "此程式為失效:",p_prog
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'adz-00172'
                LET g_errparam.extend = NULL
                LET g_errparam.popup = FALSE
                LET g_errparam.replace[1] = p_prog
                CALL cl_err()
                RETURN FALSE,'','',''
             END IF
          ELSE 

             #3.2是否為子畫面(子程式或元件的)(azzi901)
             SELECT gzdf003,gzde002,gzdestus,gzdfl003 
               INTO lr_prog_data.cust_fg, lr_prog_data.module, lr_prog_data.stus, lr_prog_data.name
               FROM gzdf_t
              INNER JOIN gzde_t
                 ON gzdf001 = gzde001
               LEFT JOIN gzdfl_t
                 ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
              WHERE gzdf002 = p_prog

             IF SQLCA.sqlcode =0  THEN #找到
                LET lr_prog_data.type   = "F" 
                IF lr_prog_data.stus = "N" THEN
                   DISPLAY "此程式為失效:",p_prog
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'adz-00172'
                   LET g_errparam.extend = NULL
                   LET g_errparam.popup = FALSE
                   LET g_errparam.replace[1] = p_prog
                   CALL cl_err()
                   RETURN FALSE,'','',''
                END IF
             ELSE #所有地方都找不到				

                DISPLAY "友善提醒 : 在 azzi900 與 azzi901 都找不到此程式代號的註冊資料",p_prog
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'adz-00171'
                LET g_errparam.extend = NULL
                LET g_errparam.popup = FALSE
                LET g_errparam.replace[1] = p_prog
                CALL cl_err()
                RETURN FALSE,'','',''
             END IF
          END IF
       END IF
   END IF
   
   #目標程式的檢核邏輯更嚴格:
   #DGENV=s時不允許挑選客製=Y的程式;反之,DGENV=c時不允許挑選標準程式
   IF p_tag = "g_gen_prog" THEN
      LET lc_fg = IIF( ms_dgenv == "s","N","Y")  #ms_dgenv=s時回傳N,否則傳Y
      LET lc_fg2 = IIF( ms_dgenv == "s","s","c") #20141003
     #IF lc_fg == lr_prog_data.cust_fg THEN
      IF lc_fg == lr_prog_data.cust_fg OR lc_fg2== lr_prog_data.cust_fg THEN #20141003
      ELSE 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'adz-00300'
        LET g_errparam.extend = NULL
        LET g_errparam.popup = FALSE
        LET g_errparam.replace[1] = p_prog
        LET g_errparam.replace[1] = lr_prog_data.cust_fg
        CALL cl_err()
        RETURN FALSE,'','',''
      END IF
   END IF

   #客製註記為Y時要REVIEW實際模組別
  #IF lr_prog_data.cust_fg='Y' THEN 
   IF lr_prog_data.cust_fg='Y' OR lr_prog_data.cust_fg ='c'  THEN #20141003 
      CALL sadzp062_1_translate_cust_module(lr_prog_data.module) RETURNING lr_prog_data.module
   END IF 

   RETURN TRUE,lr_prog_data.type,lr_prog_data.module,lr_prog_data.name
 
END FUNCTION 


#20150505 :mark ,此function完全沒用到,停用
#+ 置換對應的表格和欄位名稱
##PRIVATE FUNCTION adzp600_gen_replace_sql_str(p_col_id,p_table_id)
##   DEFINE p_col_id       STRING,
##          p_table_id     STRING,
##          l_return_str   STRING,
##          l_i            LIKE type_t.num5,
##          l_old_str      STRING,
##          l_new_str      STRING,
##          l_buf          base.StringBuffer
##
##   LET l_buf = base.StringBuffer.create()
##
##   #不使用表格轉換的appoint的處理
##   LET l_return_str = p_col_id
##   #生轉換程式代號的SQL片段
##   IF p_col_id = "dzbb098" OR  p_col_id = "dzbd098"  THEN
##      #來源程式代號
##      LET l_old_str = g_source_prog
##      LET l_old_str = l_old_str.trim()
##
##      #產生程式代號
##      LET l_new_str = g_gen_prog
##      LET l_new_str = l_new_str.trim()
##         
##      LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
##
##      #使用當前的子元件/子畫面/子程式
##      IF g_use_current_sub_prog = "Y" THEN
##         FOR l_i = 1 TO ga_sub_prog.getLength()
##            CALL l_buf.clear()
##            CALL l_buf.append(ga_sub_prog[l_i].sub_prog_id)
##            CALL l_buf.replace(g_source_prog,g_gen_prog,0)
##            LET ga_sub_prog[l_i].sub_prog_tmp_id = l_buf.toString()
##            LET l_old_str = l_buf.toString()
##            LET l_new_str = ga_sub_prog[l_i].sub_prog_id
##           #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')" #mark by madey 20140312
##           #add by madey 20140312 --start--
##           #還原子畫面時的條件要更精準,以免因為子畫面id與functoin name重覆時,整個都被還原
##            CASE ga_sub_prog[l_i].sub_prog_type
##               WHEN 'F' #子畫面
##                  LET l_return_str = "REPLACE (",l_return_str,",'w_",l_old_str,"','w_",l_new_str,"')"
##                  LET l_return_str = "REPLACE (",l_return_str,",'""",l_old_str,"""','""",l_new_str,"""')"
##                  LET l_return_str = "REPLACE (",l_return_str,",'''",l_old_str,"''','''",l_new_str,"''')"
##               OTHERWISE 
##                  LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
##            END CASE
##           #add by madey 20140312 --end --
##         END FOR
##      END IF
##   END IF
##   
##   RETURN l_return_str
##END FUNCTION


#20150505 :mark ,此function停用
#+ 產生程式與子程式/子畫面的關係
##PRIVATE FUNCTION adzp600_get_prog_relation()
##   DEFINE ls_trigger STRING,
##          ls_sql     STRING,
##          li_cnt     LIKE type_t.num5,
##          l_i     LIKE type_t.num5,
##          l_j     LIKE type_t.num5 
##
##   TRY
##
##      IF g_source_type = "M" THEN
##         #找出此作業有用到的副程式
##         LET ls_trigger = "gen_prog_relation : get ",g_source_prog," sub prog"
##         LET ls_sql = "SELECT gzde001, gzdel003
##                          FROM gzde_t
##                          LEFT JOIN gzdel_t
##                            ON gzde001 = gzdel001
##                            AND gzdel002 = '",g_lang,"'
##                          WHERE gzdestus = 'Y'
##                            AND gzde003 = 'S'
##                            AND gzde001 LIKE '%",g_source_prog,"%'"
##         #DISPLAY "ls_sql = ",ls_sql
##         PREPARE sub_prog_prep FROM ls_sql
##         DECLARE sub_prog_curs CURSOR FOR sub_prog_prep
##         CALL ga_sub_prog.clear()
##         LET li_cnt = 1
##         
##         FOREACH sub_prog_curs INTO ga_sub_prog[li_cnt].sub_prog_id,ga_sub_prog[li_cnt].sub_prog_name
##            LET ga_sub_prog[li_cnt].sub_prog_type = 'S'  #子作業 add by madey 20140312
##            LET li_cnt = li_cnt + 1
##         END FOREACH
##         
##         #找出此作業有用到的子畫面
##         LET ls_sql = "SELECT gzdf002, gzcbl004
##                          FROM ((SELECT gzza003, gzza001, gzzastus, gzcbl004, gzdf002
##                                   FROM (SELECT gzza003, gzza001, gzzastus, 'M' AS gzde003
##                                           FROM gzza_t)
##                                   LEFT JOIN gzdf_t
##                                     ON gzza001 = gzdf001
##                                   LEFT JOIN gzcbl_t
##                                     ON gzde003 = gzcbl002
##                                    AND gzcbl001 = '91'
##                                    AND gzcbl003 = '",g_lang,"') UNION
##                                (SELECT gzde002  AS gzza003,
##                                        gzde001  AS gzza001,
##                                        gzdestus AS gzzastus,
##                                        gzcbl004,
##                                        gzdf002
##                                   FROM gzde_t
##                                   LEFT JOIN gzdf_t
##                                     ON gzde001 = gzdf001
##                                   LEFT JOIN gzcbl_t
##                                     ON gzde003 = gzcbl002
##                                    AND gzcbl001 = '91'
##                                    AND gzcbl003 = '",g_lang,"'))
##                         WHERE gzzastus = 'Y'
##                           AND gzdf002 IS NOT NULL
##                           AND gzdf002 LIKE '%",g_source_prog,"%'"
##         #DISPLAY "ls_sql = ",ls_sql
##         PREPARE sub_prog_prep2 FROM ls_sql
##         DECLARE sub_prog_curs2 CURSOR FOR sub_prog_prep2
##
##         FOREACH sub_prog_curs2 INTO ga_sub_prog[li_cnt].sub_prog_id,ga_sub_prog[li_cnt].sub_prog_name
##            LET ga_sub_prog[li_cnt].sub_prog_type = 'F'  #子畫面 add by madey 20140312
##            LET li_cnt = li_cnt + 1
##         END FOREACH
##
##         #找出此作業有用到的子元件
##         LET ls_sql = "SELECT gzde001, gzdel003
##                          FROM gzde_t
##                          LEFT JOIN gzdel_t
##                            ON gzde001 = gzdel001
##                           AND gzdel002 = '",g_lang,"'
##                         WHERE gzdestus = 'Y'
##                           AND gzde003 = 'B'
##                           AND gzde002 = 'SUB'
##                           AND gzde001 LIKE '%",g_source_prog,"%'"
##         #DISPLAY "ls_sql = ",ls_sql
##         PREPARE sub_prog_prep3 FROM ls_sql
##         DECLARE sub_prog_curs3 CURSOR FOR sub_prog_prep3
##
##         FOREACH sub_prog_curs3 INTO ga_sub_prog[li_cnt].sub_prog_id,ga_sub_prog[li_cnt].sub_prog_name
##            LET ga_sub_prog[li_cnt].sub_prog_type = 'B'  #元件 add by madey 20140312
##            LET li_cnt = li_cnt + 1
##         END FOREACH
##         CALL ga_sub_prog.deleteElement(li_cnt)
##         LET li_cnt = li_cnt - 1
##      END IF
##      
##   CATCH 
##      CALL adzp600_err_catch(ls_trigger, ls_sql) 
##   END TRY
##END FUNCTION


#+ 儲存底稿設定
##PRIVATE FUNCTION adzp600_save_setting_data()
## DEFINE l_cnt              LIKE type_t.num10,
##        l_i                LIKE type_t.num10,
##        l_prog_type        LIKE dzcl_t.dzcl001,
##        l_source_prog      LIKE dzcl_t.dzcl002,
##        l_gen_prog         LIKE dzcl_t.dzcl003,
##        l_is_convert_table LIKE dzcl_t.dzcl004,
##        l_dzclcrtid        LIKE dzcl_t.dzclcrtid,
##        l_dzclcrtdp        LIKE dzcl_t.dzclcrtdp,
##        l_dzclcrtdt        LIKE dzcl_t.dzclcrtdt,
##        l_dzclownid        LIKE dzcl_t.dzclownid,
##        l_dzclowndp        LIKE dzcl_t.dzclowndp,
##        l_dzclmodid        LIKE dzcl_t.dzclmodid,
##        l_dzclmoddt        LIKE dzcl_t.dzclmoddt

## LET l_prog_type =g_gen_type CLIPPED
## LET l_source_prog = g_source_prog CLIPPED
## LET l_gen_prog = g_gen_prog CLIPPED
## LET l_is_convert_table = ''

## LET l_dzclcrtid = g_user
## LET l_dzclcrtdp = g_dept
## LET l_dzclcrtdt = cl_get_current()
## LET l_dzclownid = g_user
## LET l_dzclowndp = g_dept
## LET l_dzclmodid = g_user
## LET l_dzclmoddt = cl_get_current()

## SELECT COUNT(1) INTO l_cnt FROM dzcl_t
##    WHERE dzcl001 = l_prog_type AND
##          dzcl002 = l_source_prog AND
##          dzcl003 = l_gen_prog AND
##          dzcl004 = l_is_convert_table 
##          AND dzclcrtid = g_user

## IF l_cnt > 0 THEN
##    DELETE FROM dzcl_t
##       WHERE dzcl001 = l_prog_type AND
##             dzcl002 = l_source_prog AND
##             dzcl003 = l_gen_prog AND
##             dzcl004 = l_is_convert_table 
##             AND dzclcrtid = g_user

##    DELETE FROM dzcm_t
##       WHERE dzcm001 = l_prog_type AND
##             dzcm002 = l_source_prog AND
##             dzcm003 = l_gen_prog AND
##             dzcm004 = l_is_convert_table 
##             AND dzcmcrtid = g_user

##    DELETE FROM dzcn_t
##       WHERE dzcn001 = l_prog_type AND
##             dzcn002 = l_source_prog AND
##             dzcn003 = l_gen_prog AND
##             dzcn004 = l_is_convert_table 
##             AND dzcncrtid = g_user
## END IF

## INSERT INTO dzcl_t (dzcl001,dzcl002,dzcl003,dzcl004,dzclcrtid ,dzclcrtdp ,dzclcrtdt ,dzclownid ,dzclowndp ,dzclmodid ,dzclmoddt)
##    VALUES (l_prog_type,l_source_prog,l_gen_prog,l_is_convert_table ,l_dzclcrtid ,l_dzclcrtdp ,l_dzclcrtdt ,l_dzclownid ,l_dzclowndp ,l_dzclmodid ,l_dzclmoddt)

##END FUNCTION


#+ 載入底稿設定
##PRIVATE FUNCTION adzp600_import_setting_data()
## DEFINE l_cnt              LIKE type_t.num10,
##        l_i                LIKE type_t.num10,
##        l_prog_type        LIKE dzcl_t.dzcl001,
##        l_source_prog      LIKE dzcl_t.dzcl002,
##        l_gen_prog         LIKE dzcl_t.dzcl003,
##        l_is_convert_table LIKE dzcl_t.dzcl004,
##        l_sql              STRING,
##        l_str_buf      base.StringBuffer,
##        l_dzeb002      LIKE dzeb_t.dzeb001,
##        l_old_prefix   STRING,
##        l_new_prefix   STRING,
##        l_dzed002      LIKE dzed_t.dzed002,
##        l_dzed004      LIKE dzed_t.dzed004,
##        l_dzclcrtid        LIKE dzcl_t.dzclcrtid

## LET l_prog_type = g_qryparam.return1
## LET l_source_prog = g_qryparam.return2
## LET l_gen_prog = g_qryparam.return3
## LET l_is_convert_table = g_qryparam.return4
## LET l_dzclcrtid = g_qryparam.return5

## LET g_gen_type = l_prog_type
## LET g_source_prog = l_source_prog
## LET g_gen_prog = l_gen_prog

## #若程式存在於基礎資料則帶出程式的名稱
## CASE g_gen_type
##    WHEN "M"
##       SELECT gzzal003 INTO g_source_prog_name
##          FROM gzzal_t 
##          WHERE gzzal001 = g_source_prog AND gzzal002 = g_lang

##       SELECT gzzal003 INTO g_gen_prog_name
##          FROM gzzal_t 
##          WHERE gzzal001 = g_gen_prog AND gzzal002 = g_lang
##          
##       CALL adzp600_set_comp_entry( "formonly.lbl_old_table", FALSE)
##       CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
##       #CALL cl_ui_init()
##       
##    WHEN "S"
##       SELECT gzdel003  INTO g_source_prog_name
##          FROM gzde_t 
##          LEFT JOIN gzdel_t 
##          ON gzde001 = gzdel001 AND gzdel002 = g_lang
##          WHERE gzde001=g_source_prog AND gzdestus = 'Y' AND gzde003 = 'S'

##       SELECT gzdel003  INTO g_gen_prog_name
##          FROM gzde_t 
##          LEFT JOIN gzdel_t 
##          ON gzde001 = gzdel001 AND gzdel002 = g_lang
##          WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'S'
##          
##       CALL adzp600_set_comp_entry( "formonly.lbl_old_table", FALSE)
##       CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
##       #CALL cl_ui_init()
##       
##    WHEN "F"
##       SELECT gzdfl003 INTO g_source_prog_name
##          FROM gzdf_t
##          LEFT JOIN gzdfl_t
##          ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
##          WHERE gzdf002 = g_source_prog

##       SELECT gzdfl003 INTO g_gen_prog_name
##          FROM gzdf_t
##          LEFT JOIN gzdfl_t
##          ON gzdf002 = gzdfl001 AND gzdfl002 = g_lang
##          WHERE gzdf002 = g_gen_prog
##          
##       CALL adzp600_set_comp_entry( "formonly.lbl_old_table", TRUE)
##       CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",TRUE)
##       #CALL cl_ui_init()
##       
##    WHEN "SUB"
##       SELECT gzdel003  INTO g_source_prog_name
##          FROM gzde_t 
##          LEFT JOIN gzdel_t 
##          ON gzde001 = gzdel001 AND gzdel002 = g_lang
##          WHERE gzde001=g_source_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'

##       SELECT gzdel003  INTO g_gen_prog_name
##          FROM gzde_t 
##          LEFT JOIN gzdel_t 
##          ON gzde001 = gzdel001 AND gzdel002 = g_lang
##          WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'SUB'
##          
##       CALL adzp600_set_comp_entry( "formonly.lbl_old_table", TRUE)
##       CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",FALSE)

##    WHEN "LIB"
##       SELECT gzdel003  INTO g_source_prog_name
##          FROM gzde_t 
##          LEFT JOIN gzdel_t 
##          ON gzde001 = gzdel001 AND gzdel002 = g_lang
##          WHERE gzde001=g_source_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'

##       SELECT gzdel003  INTO g_gen_prog_name
##          FROM gzde_t 
##          LEFT JOIN gzdel_t 
##          ON gzde001 = gzdel001 AND gzdel002 = g_lang
##          WHERE gzde001=g_gen_prog AND gzdestus = 'Y' AND gzde003 = 'B' AND gzde002 = 'LIB'
##          
##       CALL adzp600_set_comp_entry( "formonly.lbl_old_table", TRUE)
##       CALL cl_set_comp_visible("lbl_parent_table,lbl_main_table,lbl_parent_table2,lbl_main_table2",FALSE)
##       
## END CASE

## 
## DISPLAY g_source_prog_name TO s_copy_source_name
## DISPLAY g_gen_prog_name TO s_gen_prog_name

## #匯入表格設定資料
## LET l_sql = "SELECT dzcm005 ,dzcm006 ,dzcm007 ,dzcm008 ,dzcm009 ,dzcm010,dzcm011",
##             "  FROM dzcm_t ",
##             "  WHERE dzcm001 = '",l_prog_type,"' AND dzcm002 = '",l_source_prog,
##             "' AND dzcm003 = '",l_gen_prog,"' AND dzcm004 = '",l_is_convert_table,"' ",
##             "  AND dzcmcrtid = '",l_dzclcrtid,"' ",
##             "  ORDER BY CAST(dzcm011 AS INTEGER)"
##             
## PREPARE adzp600_table_pre FROM l_sql
## DECLARE adzp600_table_cs CURSOR FOR adzp600_table_pre

## CALL ga_dzag.clear()

## LET l_i = 1
## FOREACH adzp600_table_cs INTO ga_dzag[l_i].old_table_id,ga_dzag[l_i].new_table_id,ga_dzag[l_i].old_table_parent,ga_dzag[l_i].old_table_main,ga_dzag[l_i].new_table_parent,ga_dzag[l_i].new_table_main,ga_dzag[l_i].pair_no
#
##    IF SQLCA.sqlcode THEN
##       CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
##       EXIT FOREACH
##    END IF

##    SELECT dzeal003 INTO ga_dzag[l_i].old_table_name
##             FROM dzeal_t 
##             WHERE dzeal001 = ga_dzag[l_i].old_table_id AND dzeal002=g_lang

##    SELECT dzeal003 INTO ga_dzag[l_i].new_table_name
##             FROM dzeal_t 
##             WHERE dzeal001 = ga_dzag[l_i].new_table_id AND dzeal002=g_lang

##    LET l_i = l_i + 1
## END FOREACH
## 
## CALL ga_dzag.deleteElement(l_i)

## #匯入欄位設定資料
## LET l_sql = "SELECT dzcn005,dzcn006,dzcn007,dzcn008,dzcn009 ",
##             "  FROM dzcn_t ",
##             "  WHERE dzcn001 = '",l_prog_type,"' AND dzcn002 = '",l_source_prog,
##             "' AND dzcn003 = '",l_gen_prog,"' AND dzcn004 = '",l_is_convert_table,"' ",
##             "  AND dzcncrtid = '",l_dzclcrtid,"' ",
##             "  ORDER BY dzcn005,cast(dzcn007 as integer)"
##             
## PREPARE adzp600_column_pre FROM l_sql
## DECLARE adzp600_column_cs CURSOR FOR adzp600_column_pre

## CALL ga_dzeb_stored.clear()
## CALL ga_dzeb.clear()
## CALL ga_excluded_col.clear()

## LET l_i = 1
## FOREACH adzp600_column_cs INTO ga_dzeb_stored[l_i].old_table_id,ga_dzeb_stored[l_i].old_col_id,ga_dzeb_stored[l_i].relation_no,ga_dzeb_stored[l_i].new_table_id,ga_dzeb_stored[l_i].new_col_id
#
##    IF SQLCA.sqlcode THEN
##       CALL .l_err("FOREACH:",SQLCA.sqlcode,1)
##       EXIT FOREACH
##    END IF

##    SELECT dzebl003 INTO ga_dzeb_stored[l_i].new_col_name
##       FROM dzeb_t
##       LEFT JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002=g_lang
##       WHERE dzeb001=ga_dzeb_stored[l_i].new_table_id AND dzeb002 = ga_dzeb_stored[l_i].new_col_id

##    SELECT dzebl003 INTO ga_dzeb_stored[l_i].old_col_name
##       FROM dzeb_t
##       LEFT JOIN dzebl_t ON dzebl001=dzeb002 AND dzebl002=g_lang
##       WHERE dzeb001=ga_dzeb_stored[l_i].old_table_id AND dzeb002 = ga_dzeb_stored[l_i].old_col_id

##       #去除舊表格代號的'_t'
##       LET l_old_prefix = ga_dzeb_stored[l_i].old_table_id
##       LET l_old_prefix = l_old_prefix.trim()
##       LET l_old_prefix = l_old_prefix.subString(1,l_old_prefix.getLength()-2)

##       #去除新表格代的'_t'
##       LET l_new_prefix = ga_dzeb_stored[l_i].new_table_id
##       LET l_new_prefix = l_new_prefix.trim()
##       LET l_new_prefix = l_new_prefix.subString(1,l_new_prefix.getLength()-2)

##       #尋找新欄位的pk
##       LET l_dzed002 = l_new_prefix.trim(),"_pk"
##       LET l_dzed004 = "%",ga_dzeb_stored[l_i].new_col_id,"%"
##       LET l_cnt = 0

##       SELECT COUNT(1) INTO l_cnt FROM dzed_t
##          WHERE dzed001=ga_dzeb_stored[l_i].new_table_id AND
##                dzed002= l_dzed002 AND 
##                dzed004 LIKE l_dzed004 

##       IF l_cnt > 0 THEN
##          LET  ga_dzeb_stored[l_i].new_col_key = ga_dzeb_stored[l_i].new_col_key , "PK"
##       END IF

##       #尋找新欄位的fk
##       LET l_dzed002 = l_new_prefix.trim(),"_fk"
##       LET l_dzed004 = "%",ga_dzeb_stored[l_i].new_col_id,"%"
##       LET l_cnt = 0
##    
##       SELECT COUNT(1) INTO l_cnt FROM dzed_t
##          WHERE dzed001=ga_dzeb_stored[l_i].new_table_id AND
##                dzed002= l_dzed002 AND 
##                dzed004 LIKE l_dzed004 

##       IF l_cnt > 0 THEN
##          LET  ga_dzeb_stored[l_i].new_col_key = ga_dzeb_stored[l_i].new_col_key ,",FK"
##       END IF
##--
##       #尋找舊欄位的pk
##       LET l_dzed002 = l_old_prefix.trim(),"_pk"
##       LET l_dzed004 =  "%",ga_dzeb_stored[l_i].old_col_id,"%"
##       LET l_cnt = 0
##    
##       SELECT COUNT(1) INTO l_cnt FROM dzed_t
##          WHERE dzed001=ga_dzeb_stored[l_i].old_table_id AND
##                dzed002= l_dzed002 AND 
##                dzed004 LIKE l_dzed004

##       IF l_cnt > 0 THEN
##          LET  ga_dzeb_stored[l_i].old_col_key = ga_dzeb_stored[l_i].old_col_key , "PK"
##       END IF

##       #尋找舊欄位的fk
##       LET l_dzed002 = l_old_prefix.trim(),"_fk"
##       LET l_dzed004 =  "%",ga_dzeb_stored[l_i].old_col_id,"%"
##       LET l_cnt = 0
##    
##       SELECT COUNT(1) INTO l_cnt FROM dzed_t
##          WHERE dzed001=ga_dzeb_stored[l_i].old_table_id AND
##                dzed002= l_dzed002 AND
##                dzed004 LIKE l_dzed004 

##       IF l_cnt > 0 THEN
##          LET  ga_dzeb_stored[l_i].old_col_key = ga_dzeb_stored[l_i].old_col_key , ",FK"
##       END IF

##    LET l_i = l_i + 1
## END FOREACH
## 
## CALL ga_dzeb_stored.deleteElement(l_i)

##END FUNCTION


#+ 載入底稿設定
##PRIVATE FUNCTION adzp600_filter_column_data()
## DEFINE l_i LIKE type_t.num10,
##        l_j LIKE type_t.num10,
##        l_k LIKE type_t.num10,
##        l_cnt LIKE type_t.num10
## 
## 

## #將編輯用的新舊欄位對應表中的資料加入儲存用的新舊欄位對應表
## FOR l_i =1 TO ga_dzeb.getLength()

##    #篩選可以加入儲存用的新舊欄位對應表的資料
##    FOR l_j=1 TO ga_dzeb_stored.getLength()
##       #刪除儲存用的新舊欄位對應表中與編輯用的新舊欄位對應表中重複的資料
##       IF ga_dzeb_stored[l_j].old_col_id = ga_dzeb[l_i].old_col_id THEN
##          CALL ga_dzeb_stored.deleteElement(l_j)
##          EXIT FOR
##       END IF
##    END FOR

##    #新舊欄位對應表中的舊表格名稱必須與表格對應關係表中存在,再放入編輯用的新舊欄位對應表中
##    FOR l_j=1 TO ga_dzag.getLength()
##       LET l_cnt = 0
##       IF ga_dzag[l_j].old_table_id = ga_dzeb[l_i].old_table_id THEN
##          LET l_cnt = 1
##          EXIT FOR
##       END IF
##    END FOR

##    IF l_cnt = 1 THEN
##       #加入編輯用的新舊欄位對應表的資料到儲存用的新舊欄位對應表,
##       #保持儲存用的新舊欄位對應表
##       CALL ga_dzeb_stored.appendElement()
##       LET ga_dzeb_stored[ga_dzeb_stored.getLength()].* = ga_dzeb[l_i].*
##    END IF
##    
## END FOR

## #去除在儲存用的新舊欄位對應表中與表格對應關係表中沒有對應的資料
## FOR l_i =1 TO ga_dzeb_stored.getLength()
##    LET l_cnt = 0
##    FOR l_j = 1 TO ga_dzag.getLength()
##       
##       IF ga_dzeb_stored[l_i].old_table_id = ga_dzag[l_j].old_table_id AND ga_dzeb_stored[l_i].new_table_id = ga_dzag[l_j].new_table_id THEN
##          LET l_cnt = 1 
##          EXIT FOR
##       END IF
##    END FOR
##    IF l_cnt = 0 THEN
##       CALL ga_dzeb_stored.deleteElement( l_i)
##       LET l_i = l_i - 1 
##    END IF
## END FOR

## FOR l_i =1 TO ga_dzeb.getLength()
##    LET l_cnt = 0
##    FOR l_j = 1 TO ga_dzag.getLength()
##       
##       IF ga_dzeb[l_i].old_table_id = ga_dzag[l_j].old_table_id AND ga_dzeb[l_i].new_table_id = ga_dzag[l_j].new_table_id THEN
##          LET l_cnt = 1 
##          EXIT FOR
##       END IF
##    END FOR
##    IF l_cnt = 0 THEN
##       CALL ga_dzeb.deleteElement( l_i)
##       LET l_i = l_i - 1 
##    END IF
## END FOR
##END FUNCTION




