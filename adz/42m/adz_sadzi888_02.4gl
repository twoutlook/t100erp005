#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzi888_02
#+ 設計人員......: madey
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzi888_02.4gl 
# Description    : 設計資料匯出
# Memo           : 2014/07/17 by madey : 支持特定單號(888888-88888)+項次(8)可讀取table程式清單做批次過單
#                  2014/07/22 by madey : 增加欄位ddata015
#                  2014/07/24 by madey : 重大錯誤時DISPLAY ERROR固定為BREAK_ERROR
#                  2014/07/28 by madey : sadzi888_02_insert_temp_table_for_design_data()增加參數:kind
#                  2014/07/29 by madey : BREAK_ERROR改放到字串最後
#                  2014/08/04 by madey : insert adzi888_ddata/adzi888_dfile前先過濾重覆資料
#                  2014/08/26 by madey : 將sadzi444_01_chk_spec_type換成sadzp060_2_chk_spec_type 
#                  2014/08/28 by madey : p_kind=3時,撈程式清單增加where條件:過單否 dzlm022=Y
#                  2014/10/13 by madey : 1.支持單號輸入xxx_design_data時可讀取temp table程式清單做批次過單
#                                        2.支持設計資料匯出匯入功能(adzp990)
#                  2014/12/01 by madey : 1.設計資料匯出匯入底層function增加參數:ds密碼
#                                        2.匯出檔naming原本用pid,改用random亂數
#                  2015/02/13 by madey : 處理dynamic array殘留
#                  2015/03/18 by madey : 1.guid取得統一先從temp table adzi888_master抓
#                                        2.p_kind不使用了,改抓global變數g_run_mode
#                                        3.adzp444字眼改成design_data
#                  2015/03/30 by madey : where條件dzlm022=Y改成dzlm022 IS NOT NULL
#                  2015/04/09 by madey : 設計資料匯出入:補設g_run_mode,並設定走過單模式g_run_mode=1,2
#                  2015/05/21 by madey : 呼叫4rp打包後，不自動替換tar檔所在路徑，由該function自行處理
#                  2015/06/15 by madey : 設計資料匯出入增加控卡規則 
#                  2015/07/30 by madey : 修正匯入時bug (master003,master013)
#                  2015/08/17 by madey : sadzi888_02_export_by_prog強制將g_bgjob設成Y,避免一些彈窗無法出來,例如cl_ask
#                  2015/09/23 by madey : 設計資料匯出入
#                                        1.新增外部參數處理
#                                        2.匯入前，自動備份舊資料
#                                        3.顯示狀態列
#                  2015/11/23 by madey : 因應dzlm001增加MT/MV/MG調整sql以避免被當作design_data包進去
#                  2015/12/07 by madey : 模組變數m_alm_tar_path換成全域g_tar_path
#                  2015/12/20 by madey : 調整設計資料匯入功能,卡控放行以下條件:c to s 及 目標版次>來源版次
#                  20160223 160223-00028 by madey :patch優化專案
#                                        1.打包時,多包4gl/4fd/tab/tgl檔案
#                                        2.設計器匯出入:調整folder取得方式,解決自行更改匯出檔名時出錯問題
#                  20160316 160407-00009 by madey :設計資料匯出入模式:在行業主機上執行匯入功能後，要能啟動同步行業別程式adzp640
#                  20160504 160504-00007 by madey :過單模式:已經簽入/釋出的程式不打包
#                  20160504 160407-00015 by madey :設計資料匯出入模式:匯出時，遇到G/X類時,自動booking azzi301/azzi300於ddata
#                  20160620 160620-00020 by madey :設計資料匯出入模式:匯入時，增加串diff工具
#                  20160902 160902-00033 by madey :設計器匯出入:讓adzp990不會因為找不到4ad而crash
#                  20160907 160907-00064 by madey :沒有dzaf資料就不包(因應過測後釋出，但沒有過正)
#                  20161117 161117-00029 by madey :設計器匯出入:匯出前檢查若沒有註冊資料則擋下來
#                  20161128 161128-00074 by madey :工作目錄不寫死TEMPDIR而改吃g_pack_dir_env

IMPORT os
IMPORT security
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi888_global.inc"

&include "../4gl/sadzp200_type.inc" 
&include "../4gl/sadzi888_06_type.inc" 

#Begin: 160504-00007
&include "../4gl/sadzp200_cnst.inc" 
#End: 160504-00007

#Begin: 160620-00020
&include "../4gl/adzq991_module.inc"
#End: 160620-00020

#DEFINE m_alm_tar_path       STRING           #ALM執行匯出/入時,tar放置完整路徑 20151207 mark 換成global變數g_tar_path

#+將設計資料相關需要打包的資料建立至TEMP TABLE (ddata / dfile)
PUBLIC FUNCTION sadzi888_02_insert_temp_table_for_design_data(p_kind,p_master013, p_master014) #20140728:madey
   DEFINE p_kind            LIKE type_t.chr1      #種類:1:一般過單  3:patch過單 (對照adzp999打包參數1/3) , a:設計資料匯出(from:adzp990)
   DEFINE p_master013       LIKE type_t.chr20,    #需求單號
          p_master014       LIKE type_t.num5      #作業項次

   DEFINE l_ddata_d         type_g_ddata_d,       #程式註冊資料匯出單身-設計資料
          l_dfile_d         type_g_dfile_d        #程式註冊資料匯出單身-檔案資料
   
   DEFINE l_guid             VARCHAR(50),    
          l_ddata_prog       VARCHAR(20),
          l_temp001          VARCHAR(20),
          l_ddata_serial_num INTEGER,             #序號
          l_dfile_serial_num INTEGER
   
   DEFINE la_dzlm DYNAMIC ARRAY OF RECORD
            dzlm001    LIKE dzlm_t.dzlm001,  #建構類型
            dzlm002    LIKE dzlm_t.dzlm002   #建構代號
          END RECORD

   DEFINE l_tar_path        STRING,          #tar檔完整路徑(含名稱)
          l_tar_name        STRING,          #tar檔名稱
          l_tar_dirname     STRING,          #tar檔所在目錄
          l_ZONE            STRING           #環境變數ZONE值

   DEFINE sbuf_path base.StringBuffer,       #轉換路徑用
          ls_err_msg        STRING,
          lb_result         BOOLEAN,
          ls_trigger        STRING,
          ls_sql            STRING,
          ls_where          STRING,
          ls_order          STRING,
          li_idx            INTEGER,
          li_cnt            INTEGER

  #DEFINE ls_master013        STRING
          
          

   TRY

      LET l_guid = NULL
      LET l_ddata_serial_num = NULL
      LET l_dFILE_serial_num = NULL
       
     
       
      LET l_ZONE = FGL_GETENV("ZONE")
      LET sbuf_path = base.StringBuffer.CREATE()
 
      #20140728:madey patch過單時,會先塞一筆資料到adzi888_master,因為此時可能沒有adzi888_ddata,guid以adzi888_master為主
      #               而一般過單會先塞adzi888_ddata,再用adzi888_data回塞adzi888_master,所以檢查ddata就可以拿到guid了
      #一定會有TEMP TABLE(adzi888_master),但不一定會有TEMP TABLE(adzi888_ddata)(adzi888_dfile)
      #確認TEMP TABLE(adzi888_master)有無資料
      LET ls_trigger="check temp table(adzi888_master) count(*) "

      SELECT DISTINCT master001 INTO l_guid
        FROM adzi888_master
      IF SQLCA.sqlcode THEN 
         #抓不到就算了,可忽略
      END IF

      #一定會有TEMP TABLE(adzi888_ddata),但不一定會有TEMP TABLE(adzi888_dfile)
      #確認TEMP TABLE(adzi888_ddata)有無資料,取最大序號
      LET ls_trigger="check temp table(adzi888_ddata) count(*) "
      SELECT MAX(ddata002) INTO l_ddata_serial_num
        FROM adzi888_ddata
      IF SQLCA.sqlcode OR cl_null(l_ddata_serial_num) THEN 
         #若沒有任何資料,則取新的GUID及重編序號
         LET l_ddata_serial_num = 0
         IF cl_null(l_guid) THEN 
            LET l_guid = security.RandomGenerator.CreateUUIDString()
         END IF
      ELSE
         #取得guid
         IF cl_null(l_guid) THEN 
            SELECT DISTINCT ddata001 INTO l_guid
              FROM adzi888_ddata
         END IF

      END IF
      
      #確認TEMP TABLE(adzi888_dfile)有無資料,dfile的GUID應該與ddata一致
      LET ls_trigger="check temp table(adzi888_dfile) count(*)"
      SELECT MAX(dfile002) INTO l_dfile_serial_num
        FROM adzi888_dfile
      IF SQLCA.sqlcode OR cl_null(l_dfile_serial_num) THEN
         #若沒有任何資料,則取新的GUID及重編序號
         LET l_dfile_serial_num = 0
         IF cl_null(l_guid) THEN 
            LET l_guid = security.RandomGenerator.CreateUUIDString()
         END IF
      END IF

      #取得程式清單
     #LET ls_master013 = p_master013 CLIPPED #20141013
      CALL la_dzlm.CLEAR()
      CASE 
        #WHEN ls_master013.getIndexOf("design_data",1) > 0 #name:02785-design_data#20167.tgz  (人員-design_data#random.tgz)
         WHEN g_run_mode = 'a' #from adzp990 設計資料匯入
            LET l_ddata_prog="design_data"
           
            LET ls_trigger="get data from temp table(sadzi888_02_prog) "
            LET ls_sql= "SELECT design001 ",
                       "  FROM sadzi888_02_prog"
            PREPARE sadzi888_02_design_query_prep  FROM ls_sql 
            DECLARE sadzi888_02_design_query_cs CURSOR FOR sadzi888_02_design_query_prep
            LET li_idx = 1
            FOREACH sadzi888_02_design_query_cs INTO la_dzlm[li_idx].dzlm002
              LET la_dzlm[li_idx].dzlm001 =  sadzp060_2_chk_spec_type(la_dzlm[li_idx].dzlm002 CLIPPED)
              IF la_dzlm[li_idx].dzlm001 = "N" THEN
                #Begin: 161117-00029 modify
                #DISPLAY "WARNING:程式",la_dzlm[li_idx].dzlm002,"找不到類別,請確認是否已經註冊","\n","中斷此程式的匯出過程","\n"
                #CONTINUE FOREACH
                 LET g_error_message = cl_replace_err_msg(cl_getmsg("adz-00378", g_lang),la_dzlm[li_idx].dzlm002) #請確認是否已經註冊
                 LET ls_trigger = g_error_message
                 GOTO _RTN_ERR
                #End: 161117-00029 modify
              END IF
              LET li_idx = li_idx + 1
            END FOREACH
            CALL la_dzlm.deleteElement(li_idx)                                                                        
        
         OTHERWISE #一般過單 or patch
            LET l_ddata_prog="design_data"  #20140707
           
           #由需求單、項次,讀取dzlm_t取得程式清單及類別,並INSERT至TEMP TABLE(adzi888_ddata)
           #INSERT時,若原本(ddate)無任何資料則自行取得GUID,否則應該用相同的GUID
            LET ls_trigger="get data from dzlm_t"
            LET ls_sql= "SELECT dzlm001,dzlm002 ",
                       "  FROM DZLM_T "
            LET ls_where =
                       "  WHERE dzlm012 = ? ",
                       "    AND dzlm013 = ? ",
                       "    AND dzlm014 = ? ",
                       "    AND dzlm015 = ? ",
                      #"    AND dzlm001 <> 'T'"
                       "    AND dzlm001 NOT IN ('T','MT','MV','MG')", #20151123
                       "    AND EXISTS (SELECT 1 FROM dzaf_t where dzaf001=dzlm002)" #160907-00064
            IF g_run_mode = "3" THEN
               LET ls_where  = ls_where ,
                       "    AND dzlm022 IS NOT NULL"
            END IF
           #Begin: 160504-00007
            IF g_run_mode = "1" THEN
               LET ls_where  = ls_where ,
                       "    AND (dzlm008 = '",cs_check_out,"' OR dzlm011 = '",cs_check_out,"')"  #過單模式下:排除已簽入的
            END IF
           #End: 160504-00007
            LET ls_order = "  ORDER BY dzlm002 "
            LET ls_sql = ls_sql , ls_where , ls_order
           
            PREPARE sadzi888_02_dzlm_query_prep  FROM ls_sql 
            DECLARE sadzi888_02_dzlm_query_cs CURSOR FOR sadzi888_02_dzlm_query_prep
            LET li_idx = 1
            FOREACH sadzi888_02_dzlm_query_cs USING p_master013,g_dzld012,g_dzld013,p_master014 INTO la_dzlm[li_idx].dzlm001,la_dzlm[li_idx].dzlm002
               LET li_idx = li_idx + 1
            END FOREACH
            CALL la_dzlm.deleteElement(li_idx)                                                                        
      END CASE 
      
      #INSERT TEMP TABLE(adzi888_ddata)
      LET ls_trigger="insert temp table(adzi888_ddata)"
      FOR li_idx = 1 TO la_dzlm.getLength()
          LET l_ddata_d.ddata003 = "design_data"           #20151123
          LET l_ddata_d.ddata006 = la_dzlm[li_idx].dzlm002

         #先檢查是否有已存在，已存在就不要重覆新增了
         LET li_cnt =0
         SELECT COUNT(1) INTO li_cnt FROM adzi888_ddata 
          WHERE ddata003="design_data" AND ddata005 = l_ddata_prog AND ddata006 = l_ddata_d.ddata006 #20151123
         IF li_cnt =0 THEN 
            LET l_ddata_serial_num = l_ddata_serial_num + 1  #目前最大序號+1
            LET l_ddata_d.ddata002 = l_ddata_serial_num 
            INSERT INTO adzi888_ddata(ddata001, ddata002, ddata003, ddata004, ddata005,
                                      ddata006, ddata007, ddata008, ddata009, ddata010,ddata015) 
            VALUES (l_guid, l_ddata_d.ddata002, l_ddata_d.ddata003 , "1" ,l_ddata_prog,
                    l_ddata_d.ddata006, NULL, "1", "0", "1","m")
                  
            IF SQLCA.sqlcode THEN
               LET g_error_message = "ERROR:insert adzi888_ddata:", cl_getmsg(SQLCA.sqlcode, g_lang)
               LET ls_trigger  = g_error_message
               GOTO _RTN_ERR
            END IF
         ELSE
            LET ls_trigger = "WARNING:data duplicate in adzi888_ddata,skip "
            DISPLAY ls_trigger
         END IF

         #Begin: 160407-00015
         #在匯出入模式下，遇到g/x類,自動booking azzi300/azzi301
         IF g_run_mode = "a" THEN
            IF la_dzlm[li_idx].dzlm001 = "G" OR la_dzlm[li_idx].dzlm001 = "X" THEN 
               CASE la_dzlm[li_idx].dzlm001
                  WHEN "G"
                     LET l_ddata_d.ddata003 = "azzi301"
                     LET l_ddata_d.ddata005 = "azzi301"
                  WHEN "X"
                     LET l_ddata_d.ddata003 = "azzi300"
                     LET l_ddata_d.ddata005 = "azzi300"
               END CASE
               LET l_ddata_d.ddata006 = la_dzlm[li_idx].dzlm002
            
               #先檢查是否有已存在，已存在就不要重覆新增了
               LET li_cnt =0
               SELECT COUNT(1) INTO li_cnt FROM adzi888_ddata 
                WHERE ddata005 = l_ddata_d.ddata005  AND ddata006 = l_ddata_d.ddata006
               IF li_cnt =0 THEN 
                  LET l_ddata_serial_num = l_ddata_serial_num + 1  #目前最大序號+1
                  LET l_ddata_d.ddata002 = l_ddata_serial_num 
                  INSERT INTO adzi888_ddata(ddata001, ddata002, ddata003, ddata004, ddata005,
                                            ddata006, ddata007, ddata008, ddata009, ddata010,ddata015) 
                  VALUES (l_guid, l_ddata_d.ddata002, l_ddata_d.ddata003 , "1" ,l_ddata_d.ddata005,
                          l_ddata_d.ddata006, NULL, "1", "0", "1","m")
                        
                  IF SQLCA.sqlcode THEN
                     LET g_error_message = "ERROR:insert adzi888_ddata:", cl_getmsg(SQLCA.sqlcode, g_lang)
                     LET ls_trigger  = g_error_message
                     GOTO _RTN_ERR
                  END IF
               ELSE
                 #LET ls_trigger = "WARNING:data duplicate in adzi888_ddata,skip "
                 #DISPLAY ls_trigger
               END IF
            END IF
         END IF
         #End: 160407-00015
      END FOR    
      
      #INSERT TEMP TABLE(dfile)
      LET ls_trigger="insert temp table adzi888_dfile)"
      FOR li_idx = 1 TO la_dzlm.getLength()
       　#類別為=G時,要呼叫打包4rp functoin,並將打包產生的tar檔INSERT至TEMP TABLE(dfile)
         IF la_dzlm[li_idx].dzlm001 = "G" THEN
            LET ls_trigger = "call sadzp188_rep_pack(", la_dzlm[li_idx].dzlm002, ")"
            DISPLAY ls_trigger

            #先檢查是否有已存在，已存在就不要重覆新增了
            LET li_cnt =0
            SELECT COUNT(*) INTO li_cnt FROM adzi888_dfile
             WHERE dfile004 = "f" AND dfile005 LIKE la_dzlm[li_idx].dzlm002||"%.tar"
            IF li_cnt =0 THEN
               CALL sadzp188_rep_pack(la_dzlm[li_idx].dzlm002) RETURNING lb_result,ls_err_msg
               IF NOT lb_result THEN
                  LET g_error_message = "ERROR:call sadzp188_rep_pack() fail ", ls_err_msg
                  LET ls_trigger = g_error_message
                  GOTO _RTN_ERR
               ELSE
                  LET l_tar_path = ls_err_msg.trim() #沒錯誤時,ls_err_msg回傳的是tar檔
                  LET l_tar_name = os.Path.basename(l_tar_path)
                  LET l_tar_dirname = os.Path.dirname(l_tar_path)
                  LET l_dfile_serial_num = l_dfile_serial_num + 1  #目前最大序號+1
                  LET l_dfile_d.dfile002 = l_dfile_serial_num 
                  LET l_dfile_d.dfile003 = l_tar_dirname
                  LET l_dfile_d.dfile005 = l_tar_name
                  INSERT INTO adzi888_dfile(dfile001, dfile002, dfile003, dfile004, dfile005, dfile006, dfile007)
                         VALUES (l_guid, l_dfile_d.dfile002, l_dfile_d.dfile003, "f", l_dfile_d.dfile005, "1", "0")
                  IF SQLCA.sqlcode THEN
                     LET g_error_message = "ERROR:insert adzi888_dfile:", cl_getmsg(SQLCA.sqlcode, g_lang)
                     LET ls_trigger = g_error_message
                     GOTO _RTN_ERR
                  END IF
               END IF
            ELSE
               LET ls_trigger = "WARNING:data duplicate in adzi888_dfile,skip "
               DISPLAY ls_trigger
            END IF

         END IF
      END FOR

      #回傳結果
      RETURN TRUE,NULL


   CATCH

     LABEL _RTN_ERR:
      CALL sadzi888_02_err_catch(ls_trigger, NULL)                                                            
      RETURN FALSE,ls_trigger
   END TRY
  
END FUNCTION

#-擷取錯誤訊息
PRIVATE FUNCTION sadzi888_02_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING
   DEFINE l_err_msg STRING

   LET l_err_msg = NULL
  #LET l_err_msg =  "BREAK_ERROR: ls_trigger=",p_trigger ," \n", "SQLCA.SQLCODE=",SQLCA.SQLCODE , " \n", "ls_sql=",p_sql,"<<"
   LET l_err_msg =  "ERROR: ls_trigger=",p_trigger ," \n", "SQLCA.SQLCODE=",SQLCA.SQLCODE , " \n", "ls_sql=",p_sql,"<<"
   LET l_err_msg =  l_err_msg , "\n ", "BREAK_ERROR" #20140729
   DISPLAY l_err_msg

END FUNCTION

#20141013
#+ 單獨匯出設計資料by temp table程式清單
FUNCTION sadzi888_02_export_by_prog(p_prog_list)
   DEFINE p_prog_list       DYNAMIC ARRAY OF STRING   #程式清單
   DEFINE l_design001       VARCHAR(20)
   DEFINE l_result          BOOLEAN
   DEFINE l_error_message   STRING
   DEFINE ls_trigger        STRING
   DEFINE ls_err_msg        STRING
   DEFINE li_i              SMALLINT
   DEFINE ls_sql            STRING
   DEFINE l_pack_dir        STRING     #打包檔置放路徑
  #DEFINE ls_g_bgjob_tmp    STRING #20150817
   DEFINE ls_code_id        STRING
   DEFINE l_master_m        type_g_master_m     #程式註冊資料匯出主檔

  TRY 

   LET g_show_msg = "Y" #20150923 確保g_bgjob不會被設成Y

   IF p_prog_list.getLength() = 0 THEN
      LET ls_err_msg = "sadzi888_02_export_by_prog : no prog list data"
      DISPLAY  ls_err_msg
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00196"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   #create暫存表格
   LET ls_trigger = "sadzi888_02_export_by_prog : create_temp_table"
   DISPLAY ls_trigger
   CALL sadzi888_02_create_temp_table()

   #insert匯出清單至暫存表格
   LET ls_trigger = "sadzi888_02_export_by_prog : insert temp table"
   DISPLAY ls_trigger
   LET ls_sql = "INSERT INTO sadzi888_02_prog(design001) ",
                " VALUES (?)"
   PREPARE ins_temp_prep1 FROM ls_sql
   FOR li_i = 1 TO p_prog_list.getLength()
      LET l_design001 = p_prog_list[li_i] CLIPPED
      EXECUTE ins_temp_prep1 USING l_design001
   END FOR
   FREE ins_temp_prep1

   #====================產生匯出檔
   LET l_master_m.master013= l_design001 #程式號碼
   CALL util.Math.srand()       #20141201
   CALL util.math.rand(32767) RETURNING l_master_m.master014 #20141201
   CALL sadzi888_02_get_ds_password() RETURNING g_exp_para #20141201 ds密碼
   LET g_dmp_mode = TRUE       #20141201
   LET g_patch_mode = FALSE    #20141201
   LET ls_trigger = "sadzi888_02_export_by_prog : call sadzi888_01_alm_export(1,",l_master_m.master013,",",l_master_m .master014,")"
   DISPLAY ls_trigger
   IF NOT sadzi888_01_create_temp_table() THEN
      CALL sadzi888_01_drop_temp_table()
      RETURN
   END IF

   #顯示進度 #20150923
   IF gb_bak_mode THEN LET ls_code_id = "adz-00710" ELSE LET ls_code_id = "adz-00708" END IF
   CALL cl_progress_bar(2) 
   CALL cl_progress_ing(cl_getmsg(ls_code_id,g_lang))
   LET g_run_mode='a'#正名匯出模式為a, sadzi888_01_export的第一個參數無用,已改成用g_run_mode
   CALL sadzi888_01_alm_export("a", l_master_m.master013, l_master_m.master014)
      RETURNING l_result, l_error_message  #如果正常的話,回傳的l_error_message會放打包的tar檔路徑
   CALL cl_progress_bar_close()

  #LET ls_g_bgjob_tmp = g_bgjob #20150817
  #LET g_bgjob='N'              #強制先切換g_bgjob,離開再還原  20150817

   IF l_result THEN #成功
      LET g_tar_path = l_error_message CLIPPED #20151207
      DISPLAY "export success."
   ELSE
      DISPLAY "export_fail!"
      DISPLAY l_error_message
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00218"
      LET g_errparam.popup = TRUE
      LET g_errparam.EXTEND = l_error_message
      CALL cl_err()
      GOTO _RTN_ERR
   END IF

   #======================下載匯出檔至client端
  #LET g_show_msg = "Y" #20150923 確保g_bgjob不會被設成Y
   IF gb_bak_mode THEN  #20150923
      #備份匯出僅顯示tar檔路徑，不用下載
      DISPLAY "Info:bak file path=", g_tar_path #20151207
   ELSE
      DISPLAY "Info:exp file path=", g_tar_path #20151207
      #切換到$TEMPDIR工作目錄下
      LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
      
      IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
         GOTO _RTN_ERR
      END IF
      
      #匯出檔下載至client端
      CALL sadzi888_02_download_data(l_pack_dir)
   END IF
   
   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      GOTO _RTN_ERR
   END IF

  LABEL _RTN_ERR: 
  #LET g_bgjob = ls_g_bgjob_tmp #還原g_bgjob 20150817

   #drop暫存表格
   LET ls_trigger = "sadzi888_02_export_by_prog : drop temp table"
   DISPLAY ls_trigger
   CALL sadzi888_01_drop_temp_table()
   CALL sadzi888_02_drop_temp_table()
   RETURN

  CATCH
      LET ls_trigger = ls_trigger ," SQLCA.sqlcode=",cl_getmsg(SQLCA.sqlcode, g_lang)
      DISPLAY ls_trigger
      RETURN 

  END TRY


END FUNCTION


#20141013
#+ 建立temp table
PUBLIC FUNCTION sadzi888_02_create_temp_table()
   #Create temp table 程式清單
   CREATE TEMP TABLE sadzi888_02_prog
   (
      design001       VARCHAR(20)   
   )
END FUNCTION


#20141013
#+ 刪除 temp table
PUBLIC FUNCTION sadzi888_02_drop_temp_table()

   DROP TABLE sadzi888_02_prog

END FUNCTION


#20141013
#+ 匯出檔下載
PRIVATE FUNCTION sadzi888_02_download_data(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
   
   DEFINE l_src             STRING     #來源文件
   DEFINE l_dst             STRING     #目的
   DEFINE l_work_dir        STRING     #目前程式執行路徑
   DEFINE l_folder          STRING     #匯出檔目錄
   DEFINE l_tar_name        STRING     #匯出包名稱
   DEFINE l_cmd             STRING
   
   
   LET l_tar_name = os.Path.basename(g_tar_path)  #20151207

   #檢查tar是否存在
   IF NOT os.Path.EXISTS(l_tar_name) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00328"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name.trim()
      CALL cl_err()
      RETURN
   END IF

   #Server下載檔案路徑/檔名
   LET l_src = os.Path.JOIN(p_pack_dir, l_tar_name)

   #選擇本地端下載資料夾
   LET l_dst = cl_client_browse_dir()
   IF cl_null(l_dst) THEN #20150923 
      #取消或離開,沒挑選
      #do thing
   ELSE
      LET l_dst = os.Path.JOIN(l_dst, l_tar_name)
      
      #下載檔案至Client端 
      IF NOT cl_client_download_file(l_src, l_dst) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00329"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         CALL cl_ask_confirm3("adz-00330", l_tar_name.trim())
      
         #下載成功後,從Server端刪除相關檔案
         #刪除目錄
         IF os.Path.EXISTS(l_folder) THEN
            LET l_cmd = "rm -rf ", l_folder
            RUN l_cmd
         END IF
         
         #刪除tar檔
         IF os.Path.EXISTS(l_tar_name) THEN
            LET l_cmd = "rm ", l_tar_name
            RUN l_cmd
         END IF
      END IF
   END IF

END FUNCTION


#20141013
#+ 單獨匯入設計資料
FUNCTION sadzi888_02_upload_and_import_by_prog()
   DEFINE l_pack_dir         STRING     #打包檔置放路徑
   DEFINE l_folder           STRING     #匯出檔目錄
   DEFINE l_result           BOOLEAN    
   DEFINE l_error_message    STRING
   DEFINE l_msg              STRING
                             
   DEFINE l_master_m         type_g_master_m       #程式註冊資料匯出主檔
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_tar_name         STRING                #匯出包名稱
   DEFINE l_idx              LIKE type_t.num5
   DEFINE l_cmd              STRING
   DEFINE l_file             STRING
   DEFINE l_sql              STRING
   DEFINE l_temp             STRING
   DEFINE l_success          LIKE type_t.chr1 
   DEFINE l_str              STRING
   DEFINE lb_result          BOOLEAN
   DEFINE ls_code_id         STRING 
   DEFINE lb_auto_bak_result BOOLEAN #20150923 自動備份結果
   DEFINE l_channel          base.Channel #160223-00028
   DEFINE lb_sync_ind        BOOLEAN #160407-00009

   #Begin: 160620-00020
   DEFINE l_source_folder    STRING #來源程式原始檔所在目錄
   DEFINE obj_prog_list util.JSONArray,
          la_prog_list  T_DIFF_PROG_LIST,
          la_param     RECORD
                 prog  STRING,
                 param DYNAMIC ARRAY OF STRING
                       END RECORD,
          ls_js        STRING
   #End: 160620-00020
   

   LET g_show_msg = "Y" #20150923 確保g_bgjob不會被設成Y
   LET lb_sync_ind = FALSE #160407-00009

   #====================上傳到server===============
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      DISPLAY "ERROR:sadzi888_01_change_pack_dir(",l_pack_dir,") fail"
      GOTO _RTN_ERR
   END IF

   #匯出檔上傳:成功的話g_tar_path會有值,代表上傳後檔案所在完整路徑 #20151207
   IF NOT sadzi888_02_upload_data(l_pack_dir) THEN
      DISPLAY "Warning:sadzi888_02_upload_data(",l_pack_dir,") fail"
      GOTO _RTN_ERR
   END IF

   #====================第1次將tar檔解開,只為了取得dzye_t資訊做卡控及備份舊資料=====
   IF NOT sadzi888_01_create_temp_table() THEN
      CALL sadzi888_01_drop_temp_table()
      DISPLAY "ERROR:sadzi888_01_create_temp_table() fail"
      GOTO _RTN_ERR
   END IF

   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(g_tar_path.trim()) #20151207

   #Begin: 160223-00028 修改
   #取得匯出檔的目錄名稱
  #LET l_idx = l_tar_name.getIndexOf(".tgz", 1)          #160223-00028 mark
  #IF l_idx > 1 THEN                                     #160223-00028 mark
  #   LET l_folder = l_tar_name.subString(1, l_idx - 1)  #160223-00028 mark
  #END IF                                                #160223-00028 mark

   #解包成tar檔範例:tar xvf $FOLDER.tgz
   LET l_cmd = "tar zxvf ", g_tar_path.trim() #20151207
  #RUN l_cmd                                             #160223-00028 mark

   #解tgz檔並取得實際目錄名稱
   LET lb_result = FALSE
   CALL sadzi888_01_tar_extract_and_get_folder(l_cmd) 
     RETURNING lb_result,l_folder
   IF NOT lb_result THEN
      GOTO _RTN_ERR
   END IF 
   #End: 160223-00028 修改

   #匯入[程式註冊資料匯出主檔]
   LET l_file = os.Path.join(l_folder.trim(), "Temp-adzi888_master.unl")
   LET l_sql = "INSERT INTO adzi888_master "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      DISPLAY "ERROR:LOAD FROM ", l_file.trim(), ":", cl_getmsg(STATUS, g_lang)
      GOTO _RTN_ERR
   END IF

   #取得[程式註冊資料匯出主檔]
   SELECT COUNT(*) INTO l_cnt FROM adzi888_master
   IF l_cnt <> 1 THEN
      DISPLAY  "ERROR:SELECT adzi888_master cnt:", cl_getmsg("adz-00335", g_lang)
      GOTO _RTN_ERR
   END IF

   SELECT master001, master002, master003, master004, master005, 
          master006, master007, master008, master009, master010, 
          master011, master012, master013, master014
     INTO l_master_m.master001, l_master_m.master002, l_master_m.master003, l_master_m.master004, l_master_m.master005, 
          l_master_m.master006, l_master_m.master007, l_master_m.master008, l_master_m.master009, l_master_m.master010, 
          l_master_m.master011, l_master_m.master012, l_master_m.master013, l_master_m.master014
     FROM adzi888_master

   IF cl_null(l_master_m.master001) THEN
      DISPLAY "ERROR:SELECT adzi888_ddata master001:", cl_getmsg("adz-00335", g_lang)
      GOTO _RTN_ERR
   END IF

   #取得dzye_t資訊
   IF NOT sadzi888_01_imp_get_dzye(l_master_m.master002, l_folder) THEN
      DISPLAY "ERROR:sadzi888_01_imp_get_dzye() fail"
      GOTO _RTN_ERR
   END IF

   #匯入前檢核
   LET l_temp = NULL
   LET lb_result = FALSE
   #todo: 在before_imp要擋:標準平台不可以匯入行業別程式; 行業別平台不可以匯入標準程式/非該行業別的程式
   CALL sadzi888_06_before_imp() RETURNING lb_result, l_temp
   IF NOT lb_result THEN
      CALL sadzi888_01_drop_temp_table()
      CALL sadzi140_rev_view_logresult(l_temp)
      DISPLAY "Info:sadzi888_06_before_imp() return false."
      GOTO _RTN_ERR
   ELSE
      #20151220 -Begin-
      #回傳true,但有訊息，表示需要彈窗詢問
      IF NOT cl_null(l_temp) THEN
         LET l_temp = l_temp.trim() ,"\n", "##########################################################","\n"
         LET l_temp = l_temp.trim() ,"\n", cl_getmsg('lib-005',g_lang) #是否繼續
         IF NOT cl_ask_type1(l_temp, "Info") THEN
            CALL sadzi888_01_drop_temp_table()
            DISPLAY "Info:sadzi888_06_before_imp() return false."
            GOTO _RTN_ERR
         END IF
      END IF
      #20151220 -End-
   END IF

   #Begin: 160620-00020
   #匯入前diff
   IF cl_ask_confirm("adz-00882") THEN #請問是否要預覽程式差異?
     #LET l_source_folder = os.path.JOIN(os.path.JOIN(FGL_GETENV("TEMPDIR"),l_folder),l_folder||"-source")
      LET l_source_folder = os.path.JOIN(os.path.JOIN(FGL_GETENV(g_pack_dir_env),l_folder),l_folder||"-source") #161128-00074
      LET la_prog_list[1].prog= g_imp_progid 
      LET la_prog_list[1].prog_name= cl_get_progname(g_imp_progid,g_lang,"1")
      LET la_prog_list[1].cons_type= g_imp_progtype
      LET la_prog_list[1].auth="N"
      
      LET obj_prog_list = util.JSONArray.CREATE()
      LET obj_prog_list = util.JSONArray.fromFGL(la_prog_list)
      
      LET la_param.prog = "adzq991"
      LET la_param.param[1] = cs_before_imp
      LET la_param.param[2] = obj_prog_list.toString()
      LET la_param.param[3] = l_source_folder
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
      IF NOT cl_ask_confirm("adz-00881") THEN #已結束預覽程式差異，請問是否繼續匯入?
        GOTO _RTN_ERR
      END IF
   END IF
   #End: 160620-00020

   #自動備份舊資料
   CALL sadzi888_06_auto_bak() RETURNING lb_auto_bak_result, l_temp
   IF NOT lb_auto_bak_result THEN
      LET l_temp = ASCII 10 , ASCII 10, l_temp #排版
      IF NOT cl_ask_confirm2("adz-00712",l_temp) THEN #顯示錯誤訊息,並詢問是否繼續
         CALL sadzi888_01_drop_temp_table()
         DISPLAY "ERROR:sadzi888_06_auto_bakis fail."
         GOTO _RTN_ERR
      END IF
   END IF

   #====================第2次將tar檔解開,for匯入
   #====================匯入===============
   #註冊資訊[清單]+[資料]匯入作業
   CALL sadzi888_02_get_ds_password() RETURNING g_exp_para #20141201 ds密碼
   LET g_dmp_mode = TRUE       #20141201
   LET g_patch_mode = FALSE    #20141201
   LET g_batch_flag = FALSE    #20141201
   CALL sadzi888_01_drop_temp_table()
   IF NOT sadzi888_01_create_temp_table() THEN
      CALL sadzi888_01_drop_temp_table()
      DISPLAY "ERROR:sadzi888_01_create_temp_table() fail"
      GOTO _RTN_ERR
   END IF

   CALL cl_progress_bar(2) 
   CALL cl_progress_ing(cl_getmsg("adz-00709",g_lang))
   LET g_run_mode= 'b'         
   CALL sadzi888_01_alm_import("b", g_tar_path, "") #20151207
        RETURNING l_result, l_error_message
   CALL cl_progress_bar_close()

   #Begin: #160407-00009
   IF sadzi888_02_read_dzye_and_ins_dzaq() THEN #此處靠tmp_dzye_t溝通,用完才能drop
      LET lb_sync_ind = TRUE
   END IF
   #End: #160407-00009

   CALL sadzi888_01_drop_temp_table()
  #LET g_bgjob = "N"
   IF l_result THEN #成功
      DISPLAY "import_success!"

      LET l_msg = cl_getmsg("adz-00346",g_lang)
      #20150923 :  
      #自動備份結果正常-->代表:有版次資料且有備份成功 or 無版次資料不備份
      #自動備份結果異常-->代表:有版次資料但備份失敗
      IF lb_auto_bak_result THEN  #20150923
         IF NOT cl_null(g_bak_tar_path) THEN 
            LET ls_code_id = "adz-00707"
         ELSE
            LET ls_code_id = "adz-00711"
         END IF
         LET l_msg = l_msg , ASCII 10, cl_replace_err_msg(cl_getmsg(ls_code_id, g_lang), g_bak_tar_path.trim())
      END IF
      CALL sadzi140_rev_view_logresult(l_msg)
      
      #提醒：請記透過型管開立需求單並過單，以免patch包不到最新程式。
      IF cl_null(g_sys_dgenv) THEN                                                                                 
         LET g_sys_dgenv=FGL_GETENV("DGENV")                                                                       
         IF cl_null(g_sys_dgenv) THEN LET g_sys_dgenv= g_dgenv_c END IF
      END IF
      IF g_sys_dgenv= g_dgenv_s THEN
         CALL cl_ask_pressanykey("adz-00639")
      END IF

      #Begin: 160407-00009
      #提醒:偵測到在行業平台匯入標準程式，將自動開啟%1以利進行後續動作。
      IF lb_sync_ind THEN
         CALL cl_ask_pressanykey("adz-01001")
         LET l_cmd = "r.r adzp640 &"  #呼叫 行業同步批次作業
         RUN l_cmd WITHOUT WAITING
      END IF
      #End: 160407-00009
     

   ELSE
      DISPLAY "import with fail!"
      DISPLAY l_error_message
      IF NOT cl_null(g_bak_tar_path) THEN #20150923  
         LET l_msg = cl_replace_err_msg(cl_getmsg("adz-00707", g_lang), g_bak_tar_path.trim()),
                     ASCII 10,
                     l_error_message
      ELSE
         LET l_msg = l_error_message
      END IF
      CALL sadzi140_rev_view_logresult(l_msg)

      #Begin: 160407-00009
      #提醒:偵測到在行業平台匯入標準程式，將自動開啟%1以利進行後續動作。
      IF lb_sync_ind THEN
         CALL cl_ask_pressanykey("adz-01001")
         LET l_cmd = "r.r adzp640 &"  #呼叫 行業同步批次作業
         RUN l_cmd WITHOUT WAITING
      END IF
      #End: 160407-00009

      GOTO _RTN_ERR
   END IF

   #切換回正確程式執行路徑 
   IF NOT sadzi888_01_change_work_dir() THEN 
      GOTO _RTN_ERR
   END IF 

 LABEL _RTN_ERR: 
   RETURN
   
END FUNCTION


#20141013
#+ 匯出檔上傳
PRIVATE FUNCTION sadzi888_02_upload_data(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
   
   DEFINE l_src             STRING     #來源文件
   DEFINE l_dst             STRING     #目的
   DEFINE l_work_dir        STRING     #目前程式執行路徑
   DEFINE l_folder          STRING     #匯出檔目錄
   DEFINE l_tar_name        STRING     #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_idy             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_msg             STRING
   DEFINE lb_result         BOOLEAN
   DEFINE ls_4ad_file       STRING


   LET lb_result = TRUE

   #load 4ad
   LET ls_4ad_file = os.Path.JOIN(os.Path.JOIN(FGL_GETENV("ADZ"),"4ad"),g_lang CLIPPED)
   LET ls_4ad_file = os.Path.JOIN(ls_4ad_file, g_prog CLIPPED ||".4ad")
  #Begin: 160902-00033 -modify
  #CALL ui.interface.loadactiondefaults(ls_4ad_file)
   IF os.path.EXISTS(ls_4ad_file) THEN
      CALL ui.interface.loadactiondefaults(ls_4ad_file)
   END IF
  #End: 160902-00033 -modify
   LET l_src = NULL

   MENU
      #Client選擇上傳匯出檔案
      ON ACTION choice_tgz_file
             CALL ui.Interface.frontCall("standard",
                                         "openfile",
                                         ["C:\\", "TGZ File", "*.tgz", "adzp990 - Choose A Tgz File"],
                                         [l_src])
         EXIT MENU
   
      ON ACTION CLOSE
         LET l_src = ''
         EXIT MENU
   
   END MENU


   IF cl_null(l_src) THEN
      LET lb_result = FALSE
      GOTO _RTN_ERR
   END IF

   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(l_src.trim())

   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tgz", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF


   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00331"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name.trim()
      CALL cl_err()
      LET lb_result = FALSE
      GOTO _RTN_ERR
   END IF

   #檢查目錄是否存在,若存在先砍掉,以確保待會解tar時資料最新
   IF NOT sadzi888_01_delete_pack(l_folder, l_tar_name) THEN
      LET lb_result = FALSE
      GOTO _RTN_ERR
   END IF

   #Server上傳檔案路徑/檔名
   LET l_dst = os.Path.JOIN(p_pack_dir, l_tar_name)
   
   #上傳檔案至Server端
   IF NOT cl_client_upload_file(l_src, l_dst) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00332"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET lb_result = FALSE
      GOTO _RTN_ERR
   ELSE
     #CALL cl_ask_pressanykey("adz-00333")
     LET g_tar_path = l_dst #20151207
   END IF
   
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(l_tar_name) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00328"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name.trim()
      CALL cl_err()
      LET lb_result = FALSE
      GOTO _RTN_ERR
   END IF
   
  ##20151207 mark :直接改傳遞g_tar_path即可
  ##20150923 mark :直接改傳遞m_tar_path即可
  ##20150730 modify -Begin-
  ##範例 匯出人-程式代號-亂數
  ##     02785-cl_chk_validate#1686
  #LET l_idx= l_folder.getIndexOf("#",1)
  #IF l_idx > 1 THEN
  #   LET g_master_m.master014 = l_folder.subString(l_idx+1,l_folder.getLength())
  #   LET l_msg= l_folder.subString(1, l_idx - 1) 
  #
  #   #範例02785-cl_chk_validate
  #   LET l_idy= l_msg.getIndexOf("-",1)
  #   IF l_idy > 1 THEN
  #      LET g_master_m.master003 = l_msg.subString(1, l_idy - 1) #匯出者 
  #      LET g_master_m.master013 = l_msg.subString(l_idy+1,l_msg.getLength())
  #      LET lb_result = TRUE
  #   END IF
  #END IF
  ##20150730 modify -Begin-

  LABEL _RTN_ERR:
   RETURN lb_result
   
END FUNCTION


#20141013
#+ 匯入此次打包清單資訊
PRIVATE FUNCTION sadzi888_02_import_pack_list()
   DEFINE l_cmd             STRING
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_cnt             LIKE type_t.num5

   #因採用temp table運作,所以每次先清空temp table裡的資料
   #刪除所有temp table內的資料
   DELETE FROM adzi888_master WHERE 1 = 1
   DELETE FROM adzi888_ddata WHERE 1 = 1
   DELETE FROM adzi888_dfile WHERE 1 = 1
 
   #匯出[程式註冊資料匯出主檔]
   LET l_file = "Temp-", "adzi888_master.unl"
   LET l_sql = "INSERT INTO adzi888_master "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "LOAD FROM " || l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
      
   #匯入[設計資料匯出清單]
   LET l_file = "Temp-", "adzi888_ddata.unl"
   LET l_sql = "INSERT INTO adzi888_ddata "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "LOAD FROM " || l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #匯入[檔案匯出清單]
   LET l_file = "Temp-", "adzi888_dfile.unl"
   LET l_sql = "INSERT INTO adzi888_dfile "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "LOAD FROM " || l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #取得[程式註冊資料匯出主檔]
   SELECT COUNT(*) INTO l_cnt FROM adzi888_master
   IF l_cnt <> 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00335"
      LET g_errparam.extend = "cnt"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE

END FUNCTION


#+取得ds密碼
PUBLIC FUNCTION sadzi888_02_get_ds_password()
  DEFINE ls_privacy_word STRING,
         ls_password     STRING,
         lb_success      BOOLEAN

    CALL sadzi140_db_get_privacy_word() RETURNING lb_success,ls_privacy_word
    IF lb_success THEN 
      LET ls_password = cl_hashkey_base65_anti(ls_privacy_word)
    ELSE 
      LET ls_password = "ds"
    END IF 

    RETURN ls_password

END FUNCTION

#+同步行業別程式-取得門票 #160407-00009 add
PRIVATE FUNCTION sadzi888_02_read_dzye_and_ins_dzaq()
   DEFINE l_dzye_d           type_g_dzye_d                                                                            
   DEFINE ls_sql             STRING
   DEFINE ls_err_msg         STRING
   DEFINE lb_result          BOOLEAN
   DEFINE lb_return          BOOLEAN
   DEFINE lo_std_dzaf        T_DZAF_T
   
   LET lb_return = FALSE

   IF sadzp060_ind_check_area() THEN #行業平台才做
      #為了知道類別,所以取dzye_t資料, g_run_mode = a/b匯出入模式下，只會有1筆資料
      LET ls_sql = "SELECT dzye001, dzye002, dzye003, dzye004, dzye005, ",
                  "        dzye006, dzye007, dzye008, dzye009, dzye010, ", 
                  "        dzye011, dzye012, dzye013, dzye014, dzye015, ", 
                  "        dzye016, dzye017, dzye018, dzye019, dzye020, ", 
                  "        dzye021, dzye022, dzye023, dzye024 ", 
                  "  FROM tmp_dzye_t " 
      
      PREPARE get_tmp_dzye FROM ls_sql
      EXECUTE get_tmp_dzye INTO l_dzye_d.dzye001, l_dzye_d.dzye002, l_dzye_d.dzye003, l_dzye_d.dzye004, l_dzye_d.dzye005,
                                l_dzye_d.dzye006, l_dzye_d.dzye007, l_dzye_d.dzye008, l_dzye_d.dzye009, l_dzye_d.dzye010,
                                l_dzye_d.dzye011, l_dzye_d.dzye012, l_dzye_d.dzye013, l_dzye_d.dzye014, l_dzye_d.dzye015,
                                l_dzye_d.dzye016, l_dzye_d.dzye017, l_dzye_d.dzye018, l_dzye_d.dzye019, l_dzye_d.dzye020,
                                l_dzye_d.dzye021, l_dzye_d.dzye022, l_dzye_d.dzye023, l_dzye_d.dzye024 
      INITIALIZE lo_std_dzaf TO NULL
      LET lo_std_dzaf.dzaf001 = l_dzye_d.dzye002 #程式代碼
      LET lo_std_dzaf.dzaf002 = l_dzye_d.dzye014 #來源建構版次
      LET lo_std_dzaf.dzaf003 = l_dzye_d.dzye020 #來源規格版次
      LET lo_std_dzaf.dzaf004 = l_dzye_d.dzye021 #來源程式版次
      LET lo_std_dzaf.dzaf005 = l_dzye_d.dzye003 #建構類型
      LET lo_std_dzaf.dzaf006 = l_dzye_d.dzye005 #模組
      LET lo_std_dzaf.dzaf010 = l_dzye_d.dzye019 #來源程式客制否
      IF lo_std_dzaf.dzaf005 = "M" AND sadzp060_ind_is_cite(lo_std_dzaf.dzaf001)     #是否被強制引用
      THEN
        CALL sadzp060_4_ins_dzaq_t(lo_std_dzaf.*, "", "") RETURNING lb_result,ls_err_msg
         IF NOT lb_result THEN
            DISPLAY "ERROR:call sadzp060_4_ins_dzaq_t() fail:",ls_err_msg
         ELSE
            LET lb_return = TRUE
         END IF
      END IF
   END IF

   RETURN lb_return

END FUNCTION


