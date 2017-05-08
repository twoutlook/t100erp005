#+ Version....: T6-ERP-1.00.00 Build-000005
#+
#+ Filename...: adzi888全域變數
#+ Buildtype..:
#+ Memo.......:

SCHEMA ds

GLOBALS
   CONSTANT g_dgenv_s = "s"
   CONSTANT g_dgenv_c = "c"
   CONSTANT g_pack_dir_env = "TEMPDIR"          #匯出檔打包工作目錄
   CONSTANT g_gen42s_arg2 = "tiptop"            #第二參數傳入tiptop就不會做關聯42s檔
   CONSTANT g_table_list = "table_list.xml"     #有patch data的table代碼
   CONSTANT g_sys_schema = "ds"                 #系統參照的DB schema
   CONSTANT g_patch_schema = "dspatch"          #patch參照的DB schema
   CONSTANT g_gzzq_standard = "gzzq_standard.unl"         #gzzq_t內standard屬於程式代碼內的所有ACTION多語言對照表
   CONSTANT g_patch_file_path = "/u6/scm"       #patch時tgz預設產生路徑
   CONSTANT g_patch_standard_source_path ="standard_source" #patch時標準程式source目錄  #160223-00028 add

   #####patch task流程順序定義
   CONSTANT gc_empty_dspatch = 1
   CONSTANT gc_imp_file = 2
   CONSTANT gc_imp_base_data = 3
   CONSTANT gc_imp_dmp = 4
   CONSTANT gc_del_data = 5
   CONSTANT gc_merge_data = 6
   CONSTANT gc_gen_pattern = 7
   CONSTANT gc_gen_base_prog = 8
   CONSTANT gc_gen_06_prog_init = 9
   CONSTANT gc_gen_06_prog_merge = 10   #160223-00028 add
   CONSTANT gc_gen_06_prog_gen = 11     #160223-00028 modify
   CONSTANT gc_gen_06_sub_compile = 12  #160223-00028 modify
   CONSTANT gc_gen_06_sub_link = 13     #160223-00028 modify
   CONSTANT gc_gen_06_prog_compile = 14 #160223-00028 modify
   CONSTANT gc_gen_06_prog_link = 15    #160223-00028 modify
   CONSTANT gc_gen_final_prog = 16      #160223-00028 modify
   CONSTANT gc_gen_final_patch = 17     #160223-00028 modify

   CONSTANT g_all_main_tasks = 17       #160223-00028 modify
   #########################
   
   #單頭 type 宣告
   TYPE type_g_master_m       RECORD
          master001         LIKE dzld_t.dzld001,         #GUID
          master002         LIKE type_t.chr50,           #匯出主題 
          master003         LIKE type_t.chr10,           #匯出人員
          master003_desc    LIKE type_t.chr80, 
          master004         LIKE type_t.chr10,           #自動產生類型(依1.prog:程式代號; 2.date:異動日期)
          master005         LIKE type_t.chr1,            #程式類型(GZCB001=114)
          master006         LIKE type_t.chr50,           #作業代號
          master007         LIKE type_t.dat,             #資料起始時間  #DATETIME YEAR TO SECOND
          master008         LIKE type_t.dat,             #資料結束時間 
          master009         LIKE type_t.dat,             #匯出時間
          master010         LIKE type_t.dat,             #匯入時間
          master011         LIKE type_t.chr1,            #自動產生註冊資料清單否
          master012         LIKE type_t.chr20,           #註冊資訊資料清單建立區域
          master013         LIKE type_t.chr20,           #需求單號
          master014         LIKE type_t.num5             #作業項次
          END RECORD
    
   #單身 type 宣告
   TYPE type_g_ddata_d        RECORD
          #ddata001          LIKE type_t.chr50,          #GUID
          ddata002          LIKE type_t.num5,            #序號
          ddata003          LIKE dzld_t.dzld003,         #作業代號(註冊資訊相關維護作業dzyb_t)
          ddata004          LIKE dzld_t.dzld004,         #匯入動作(1:Merge; 2:Insert; 3:Delete)
          ddata005          LIKE dzld_t.dzld005,         #維護作業
          ddata015          LIKE dzld_t.dzld015,         #過單項目(m:單頭主項; d:單身子項)
          ddata006          LIKE dzld_t.dzld006,         #條件式1
          ddata007          LIKE dzld_t.dzld007,         #條件式2
          ddata008          LIKE dzld_t.dzld008,         #匯出狀態(0:建立; 1:成功; 2:失敗)
          ddata009          LIKE dzld_t.dzld009,         #匯入狀態(0:建立; 1:成功; 2:失敗)
          ddata010          LIKE dzld_t.dzld010          #清單資料產生方式(0:手動建立; 1:依程式代號; 2:依異動日期)
          #ddata011          LIKE type_t.chr20,          #需求單號
          #ddata012          LIKE type_t.num5            #作業項次
          END RECORD
   
   TYPE type_g_dfile_d        RECORD
          #dfile001          LIKE type_t.chr50,          #GUID
          dfile002          LIKE type_t.num5,            #序號
          dfile003          LIKE dzlf_t.dzlf003,         #路徑(exp:/u1/{ZONE}/erp/cfg/4st)
          dfile004          LIKE dzlf_t.dzlf004,         #類型(f:檔案; d:整個目錄結構)
          dfile005          LIKE dzlf_t.dzlf005,         #檔名
          dfile006          LIKE dzlf_t.dzlf006,         #匯出狀態(0:建立; 1:成功; 2:失敗)
          dfile007          LIKE dzlf_t.dzlf007          #匯入狀態(0:建立; 1:成功; 2:失敗)
          END RECORD
   
   TYPE type_g_dtool_d        RECORD
          #dtool001          LIKE type_t.chr50,          #GUID
          dtool002          LIKE type_t.num5,             #序號
          dtool003          LIKE dzlt_t.dzlt003,         #模組(adz; azz; lib; sub; oth)
          dtool004          LIKE dzlt_t.dzlt004,         #匯入類型(4gl:4gl檔案; 4fd:4fd檔案; 42m:42m檔案; cp:cp file; del:delete data; load:load data)
          dtool005          LIKE dzlt_t.dzlt005,         #主程式否
          dtool006          LIKE dzlt_t.dzlt006,         #檔名
          dtool007          LIKE dzlt_t.dzlt007,         #no use
          dtool008          LIKE dzlt_t.dzlt008,         #匯出狀態(0:建立; 1:成功; 2:失敗)
          dtool009          LIKE dzlt_t.dzlt009          #匯入狀態(0:建立; 1:成功; 2:失敗)
          END RECORD
   
   TYPE type_g_dzyb           RECORD
          dzyb001           LIKE dzyb_t.dzyb001,         #作業名稱
          dzyb002           LIKE dzyb_t.dzyb002,         #資料表名稱
          dzyb003           LIKE dzyb_t.dzyb003,         #主表否
          dzyb004           LIKE dzyb_t.dzyb004,         #主要資料條件欄位
          dzyb005           LIKE dzyb_t.dzyb005,         #創建日欄位名稱
          dzyb006           LIKE dzyb_t.dzyb006,         #修改日欄位名稱
          dzyb007           LIKE dzyb_t.dzyb007,         #匯入動作(1.update/insert(merge), 2.delete/insert, 3.insert(update), 4.insert)
          dzyb008           LIKE dzyb_t.dzyb008,         #次要資料條件欄位
          dzyb009           LIKE dzyb_t.dzyb009,         #客製欄位代號
          dzyc002           LIKE dzyc_t.dzyc002,         #patch動作(1.update/insert(merge), 2.delete/insert, 3.insert(update), 4.insert)
          dzyc003           LIKE dzyc_t.dzyc003,         #客製欄位代號
          dzyc004           LIKE dzyc_t.dzyc004,         #patch條件
          dzyc005           LIKE dzyc_t.dzyc005          #資料多語言欄位代號
          END RECORD
   
   #ALM 註冊資訊清單
   TYPE type_g_dzld_d        RECORD
          dzld001          LIKE dzld_t.dzld001,          #GUID
          dzld002          LIKE type_t.num5,             #序號
          dzld003          LIKE dzld_t.dzld003,          #作業代號(註冊資訊相關維護作業dzyb_t)
          dzld004          LIKE dzld_t.dzld004,          #匯入動作(1:Merge; 2:Insert; 3:Delete)
          dzld005          LIKE dzld_t.dzld005,          #維護作業
          dzld006          LIKE dzld_t.dzld006,          #條件式1
          dzld007          LIKE dzld_t.dzld007,          #條件式2
          dzld008          LIKE dzld_t.dzld008,          #匯出狀態(0:建立; 1:成功; 2:失敗)
          dzld009          LIKE dzld_t.dzld009,          #匯入狀態(0:建立; 1:成功; 2:失敗)
          dzld010          LIKE dzld_t.dzld010,          #清單資料產生方式(0:手動建立; 1:依程式代號; 2:依異動日期)
          dzld011          LIKE dzld_t.dzld011,          #需求單號
          dzld012          LIKE dzld_t.dzld012,          #產品代號
          dzld013          LIKE dzld_t.dzld013,          #產品版本
          dzld014          LIKE dzld_t.dzld014,          #作業項次
          dzld015          LIKE type_t.chr1              #過單項目(M:單頭主項; D:單身子項)
          END RECORD

   #ALM 檔案匯出清單
   TYPE type_g_dzlf_d        RECORD
          dzlf001          LIKE dzlf_t.dzlf001,          #GUID
          dzlf002          LIKE type_t.num5,             #序號
          dzlf003          LIKE dzlf_t.dzlf003,          #路徑
          dzlf004          LIKE dzlf_t.dzlf004,          #類型(f:檔案; d:目錄)
          dzlf005          LIKE dzlf_t.dzlf005,          #檔名
          dzlf006          LIKE dzlf_t.dzlf006,          #匯出狀態(0:建立; 1:成功; 2:失敗)
          dzlf007          LIKE dzlf_t.dzlf007,          #匯入狀態(0:建立; 1:成功; 2:失敗)
          dzlf008          LIKE dzlf_t.dzlf008,          #需求單號
          dzlf009          LIKE dzlf_t.dzlf009,          #產品代號
          dzlf010          LIKE dzlf_t.dzlf010,          #產品版本
          dzlf011          LIKE dzlf_t.dzlf011           #作業項次
          END RECORD

   #IT工具類匯出清單
   TYPE type_g_dzlt_d        RECORD
          dzlt001          LIKE dzlt_t.dzlt001,          #GUID
          dzlt002          LIKE type_t.num5,             #序號
          dzlt003          LIKE dzlt_t.dzlt003,          #模組(adz; azz; lib; sub; oth)
          dzlt004          LIKE dzlt_t.dzlt004,          #匯入類型(4gl:4gl檔案; 4fd:4fd檔案; cp:cp file; del:delete data; load:load data)
          dzlt005          LIKE dzlt_t.dzlt005,          #主程式否
          dzlt006          LIKE dzlt_t.dzlt006,          #檔名
          dzlt007          LIKE dzlt_t.dzlt007,          #no use
          dzlt008          LIKE dzlt_t.dzlt008,          #匯出狀態(0:建立; 1:成功; 2:失敗)
          dzlt009          LIKE dzlt_t.dzlt009,          #匯入狀態(0:建立; 1:成功; 2:失敗)
          dzlt011          LIKE dzlt_t.dzlt011,          #需求單號
          dzlt012          LIKE dzlt_t.dzlt012,          #產品代號
          dzlt013          LIKE dzlt_t.dzlt013,          #產品版本
          dzlt014          LIKE dzlt_t.dzlt014           #作業項次
          END RECORD

   #ALM 註冊資訊清單
   TYPE type_g_dzld_browser  RECORD
          dzld001          LIKE dzld_t.dzld001,          #GUID
          dzld011          LIKE dzld_t.dzld011,          #需求單號
          dzld012          LIKE dzld_t.dzld012,          #產品代號
          dzld013          LIKE dzld_t.dzld013,          #產品版本
          dzld014          LIKE dzld_t.dzld014           #作業項次
          END RECORD

   #patch 單頭 type 宣告
   TYPE type_g_patch_m       RECORD
          patch001          LIKE dzld_t.dzld001,         #GUID
          patch002          LIKE type_t.chr50,           #patch號
          patch003          LIKE type_t.chr100,          #patch包來源路徑         ###patch包所在路徑
          patch004          LIKE type_t.chr20,           #dspatch user密碼(Oracle DB User)
          patch005          LIKE type_t.chr1,            #只重做程式patch(不做設計資料匯入及合併)
          patch006          LIKE type_t.chr100,          #patch解包檔路徑
          patch007          LIKE type_t.chr1,            #是否gen 42s
          patch008          LIKE type_t.chr1,            #是否merge標準程式
          patch009          LIKE type_t.chr1             #是否為快速更新 160816-00047
          END RECORD
   
   #patch 單頭 type 宣告
   TYPE type_g_load_data     RECORD
          dzea001           LIKE dzea_t.dzea001,         #資料表代碼
          wc                STRING                       #where條件
          END RECORD

   #設計資料執行結果記錄表
   TYPE type_g_dzye_d        RECORD
          dzye001          LIKE dzye_t.dzye001,          #匯入包編號
          dzye002          LIKE dzye_t.dzye002,          #程式代碼
          dzye003          LIKE dzye_t.dzye003,          #建構類型
          dzye004          LIKE dzye_t.dzye004,          #已執行項目
          dzye005          LIKE dzye_t.dzye005,          #模組
          dzye006          LIKE dzye_t.dzye006,          #完成patch否
          dzye007          LIKE dzye_t.dzye007,          #錯誤訊息(簡單)
          dzye008          LIKE dzye_t.dzye008,          #PID
          dzye009          LIKE dzye_t.dzye009,          #目的建構版次
          dzye010          LIKE dzye_t.dzye010,          #目的規格版次
          dzye011          LIKE dzye_t.dzye011,          #目的程式版次
          dzye012          LIKE dzye_t.dzye012,          #目的程式客製否
          dzye013          LIKE dzye_t.dzye013,          #順序
          dzye014          LIKE dzye_t.dzye014,          #no use
          dzye015          LIKE dzye_t.dzye015,          #執行merge否
          dzye016          LIKE dzye_t.dzye016,          #執行階段
          dzye017          LIKE dzye_t.dzye017,          #執行日期
          dzye018          LIKE dzye_t.dzye018,          #錯誤訊息(完整)
          dzye019          LIKE dzye_t.dzye019,          #來源程式客制否
          dzye020          LIKE dzye_t.dzye020,          #來源規格版次
          dzye021          LIKE dzye_t.dzye021,          #來源程式版次
          dzye022          LIKE dzye_t.dzye022,          #目的程式簽出否
          dzye023          LIKE dzye_t.dzye023,          #patch狀態
          dzye024          LIKE dzye_t.dzye024           #執行使用者
          END RECORD

   DEFINE g_alm_jb          LIKE type_t.chr1        #是否與ALM綁定
   DEFINE g_show_msg        LIKE type_t.chr1        #是否顯示錯誤訊息視窗
   DEFINE g_dzld012         LIKE dzld_t.dzld012     #產品代號
   DEFINE g_dzld013         LIKE dzld_t.dzld013     #產品版本
   DEFINE g_error_message   STRING                  #錯誤訊息
   DEFINE g_gen42s_flag     LIKE type_t.chr1        #是否自動產生所有的關聯的42s檔
   DEFINE g_batch_flag      LIKE type_t.chr1        #是否整批import data
   DEFINE g_patch_mode      LIKE type_t.chr1        #是否為patch流程
   DEFINE g_patch_pwd       STRING
   DEFINE g_unload_file     LIKE type_t.chr1        #是否在export data過程中UNLOAD TO FILE
   DEFINE g_exp_para        STRING
   DEFINE g_dmp_mode        LIKE type_t.chr1        #是否為exp/imp dmp模式
   DEFINE g_run_mode        LIKE type_t.chr1        #adzp999運行模式(1:過單打包; 2:過單解包; 3:patch打包; 4:patch解包; 5:需求單打包; 6:需求單解包)
   DEFINE g_import_dapatch  LIKE type_t.chr1        #是否import dspatch
   DEFINE g_top_alm         LIKE type_t.chr1        #是否串接ALM
   DEFINE g_top_checkout    LIKE type_t.chr1        #是否允許簽出
   DEFINE g_curr_tasks      LIKE type_t.num5        #目前執行階段
   DEFINE g_adzp999_01_s01  LIKE type_t.chr1        #adzp999_01_s01是否有open window
   DEFINE g_patch005        LIKE type_t.chr1        #只重做程式重產(不做設計資料匯入及合併)
   DEFINE g_backfile        LIKE type_t.num5        #重新產出程式時，舊程式備份版數 (0表示不留備份) #160223-00028 add
   DEFINE g_patch_standard_source_path_full STRING  #patch時標準程式source目錄  #new 160223-00028 add
   DEFINE g_quick_patch     LIKE type_t.chr1        #是否為快速patch (Y/N) 預設為N  #160816-00047
  
   DEFINE g_patch_info RECORD
       info001 LIKE type_t.chr10,     #T100版本(目前固定1.0)
       info002 LIKE type_t.chr10,     #Patch包版本(目前也是1.0)
       info003 LIKE type_t.chr20,     #Oracle版本(exp)
       info004 LIKE type_t.chr20,     #Oracle版本(imp)
       info005 LIKE type_t.chr50,     #匯出環境資訊(FGLASIP)
       info006 LIKE type_t.chr20,     #匯出環境資訊(行業別TOPIND)
       info007 LIKE type_t.chr20,     #區域名稱(ERPID)
       info008 LIKE type_t.chr500,    #patch目的說明
       info009 LIKE type_t.chr1,      #datafix1 - Y/N 170301
       info010 LIKE type_t.chr1,      #datafix2 - Y/N 170301
       info011 LIKE type_t.chr1,      #datafix3 - Y/N 170301
       info012 LIKE type_t.num10,      #ut所需空間(MB) 170301
       info013 LIKE type_t.num10,     #dsblob所需空間(MB) 170301
       info014 LIKE type_t.num10,     #dsdata所需空間(MB) 170301
       prog DYNAMIC ARRAY OF RECORD            
          prog001 LIKE type_t.chr1,   #是否解開section
          prog002 LIKE type_t.chr1,   #是否為freestyle
          prog003 LIKE type_t.chr5    #歸屬行業
       END RECORD
   END RECORD

   DEFINE g_stop_chk_sd_ver_freestyle BOOLEAN  #DEFAULT=FALSE
   
END GLOBALS
