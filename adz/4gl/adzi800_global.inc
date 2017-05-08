#+ Version....: T6-ERP-1.00.00 Build-000005
#+
#+ Filename...: adzi800全域變數
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
   CONSTANT g_patch_file_path = "/u6/scm/t10/erp/adz"     #patch時tgz預設產生路徑
   
   #單頭 type 宣告
   TYPE type_g_master_m       RECORD
          master001         LIKE type_t.chr50,           #GUID
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
          #ddata001          LIKE type_t.chr50,           #GUID
          ddata002          LIKE type_t.num5,            #序號
          ddata003          LIKE type_t.chr20,           #作業代號(註冊資訊相關維護作業dzyb_t)
          ddata004          LIKE type_t.chr1,            #匯入動作(1:Merge; 2:Insert; 3:Delete)
          ddata005          LIKE type_t.chr20,           #維護作業
          ddata015          LIKE type_t.chr1,            #過單項目(m:單頭主項; d:單身子項)
          ddata006          LIKE type_t.chr50,           #條件式1
          ddata007          LIKE type_t.chr50,           #條件式2
          ddata008          LIKE type_t.chr1,            #匯出狀態(0:建立; 1:成功; 2:失敗)
          ddata009          LIKE type_t.chr1,            #匯入狀態(0:建立; 1:成功; 2:失敗)
          ddata010          LIKE type_t.chr1             #清單資料產生方式(0:手動建立; 1:依程式代號; 2:依異動日期)
          #ddata011          LIKE type_t.chr20,           #需求單號
          #ddata012          LIKE type_t.num5             #作業項次
          END RECORD
   
   TYPE type_g_dfile_d        RECORD
          #dfile001          LIKE type_t.chr50,           #GUID
          dfile002          LIKE type_t.num5,            #序號
          dfile003          LIKE type_t.chr200,          #路徑(exp:/u1/{ZONE}/erp/cfg/4st)
          dfile004          LIKE type_t.chr1,            #類型(f:檔案; d:整個目錄結構)
          dfile005          LIKE type_t.chr50,           #檔名
          dfile006          LIKE type_t.chr1,            #匯出狀態(0:建立; 1:成功; 2:失敗)
          dfile007          LIKE type_t.chr1             #匯入狀態(0:建立; 1:成功; 2:失敗)
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
          dzld002          LIKE dzld_t.dzld002,          #序號
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
          dzlf002          LIKE dzlf_t.dzlf002,          #序號
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
          patch001          LIKE type_t.chr50,           #GUID
          patch002          LIKE type_t.chr50,           #patch包 
          patch003          LIKE type_t.chr100           #patch包所在路徑
          END RECORD
    
   #Patch 清單
   TYPE type_g_pdata_d        RECORD
          #pdata001          LIKE type_t.chr50,           #GUID
          pdata002          LIKE type_t.num5,            #序號
          pdata003          LIKE type_t.chr1,            #匯入狀態(0:建立; 1:成功; 2:失敗)
          pdata004          LIKE type_t.chr1,            #簽出狀態(N:未簽出; Y:簽出; E:錯誤)
          pdata005          LIKE type_t.chr20,           #維護作業
          pdata006          LIKE type_t.chr50,           #條件式1
          pdata007          LIKE type_t.chr50,           #條件式2
          pdata008          LIKE type_t.chr300           #說明
          END RECORD

   #Patch 檔案清單
   TYPE type_g_pfile_d        RECORD
          #pfile001          LIKE type_t.chr50,           #GUID
          pfile002          LIKE type_t.num5,            #序號
          pfile003          LIKE type_t.chr1,            #匯入狀態(0:建立; 1:成功; 2:失敗)
          pfile004          LIKE type_t.chr200,          #路徑(exp:/u1/{ZONE}/erp/cfg/4st)
          pfile005          LIKE type_t.chr1,            #類型(f:檔案; d:整個目錄結構)
          pfile006          LIKE type_t.chr50,           #檔名
          pfile007          LIKE type_t.chr300           #說明
          END RECORD
   
   DEFINE g_alm_jb          LIKE type_t.chr1        #是否與ALM綁定
   DEFINE g_show_msg        LIKE type_t.chr1        #是否顯示錯誤訊息視窗
   DEFINE g_dzld012         LIKE dzld_t.dzld012     #產品代號
   DEFINE g_dzld013         LIKE dzld_t.dzld013     #產品版本
   DEFINE g_error_message   STRING                  #錯誤訊息
   DEFINE g_gen42s_flag     LIKE type_t.chr1        #是否自動產生所有的關聯的42s檔
   DEFINE g_batch_flag      LIKE type_t.chr1        #是否整批import data
   DEFINE g_patch_mode      LIKE type_t.chr1        #是否為patch流程
   DEFINE g_unload_file     LIKE type_t.chr1        #是否在export data過程中UNLOAD TO FILE
   DEFINE g_exp_para        STRING
   DEFINE g_dmp_mode        LIKE type_t.chr1        #是否為exp/imp dmp模式
   DEFINE g_run_mode        LIKE type_t.chr1        #adzp999運行模式(1:過單打包; 2:過單解包; 3:patch打包; 4:patch解包; 5:需求單打包; 6:需求單解包)
   
END GLOBALS

