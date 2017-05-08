#+ 程式版本......: T6 Version 1.00.00 Build-0317 at 12/09/21
#
#+ 程式代碼......: adzp160 
#+ 設計人員......: cch
#+ 功能描述......: 針對單一表格資料的分鏡檔進行解析,擷取其中的資料匯入資料庫(dzeh_t),
#+                再將此表格在資料庫(dzeh_t)中的所有歷史資料取出,逐一匯到表格設計器的相關表格內(dzeb_t,dzebl_t,dzed_t,dzep_t)
#+ 修改歷程......: 2014/05/30 by madey : insert dzebl_t先讓使用者挑選語系
#................: 2014/08/22 by Hiko : 增加轉換簡繁的功能
#................: 2014/09/16 by Hiko : 1.增加預設值的設定:dzeb012,dzep012
#                                       2.塞入dzeb_t的陣列改成g_dzeh_d2
#................: 2014/11/18 by Hiko : 調整dzeb_t,dzec_t,dzed_t
#................: 20150414 by Hiko : 調整畫面
#................: 2015/04/28 by Hiko : 將init內的g_sco_id改成local變數,以免混淆.
#................: 2015/07/09 by Ernest : dzebl_t 加入表格名稱欄位 dzebl000
#................: 2015/12/08 by Hiko : 增加預設值(dzeb012)的設定
#................: 20160413 by Hiko : 增加欄位大小寫(dzep023)的設定
#................: 20160505 160505-00006 by madey :匯入分鏡資料表要檢查欄位合法性
#................: 20160704 160704-00015 by Ernest : 移除檢查欄位合法性最後的 exit program
#................: 20160714 160714-00023 by madey :dzep005給值

#IMPORT JAVA ConvertRTFintoString  #用於讀出rtf格式的純文字,JAVA檔案放於/u1/t10dit/utl/java/bin和/u1/t10dit/utl/java/src
#IMPORT JAVA java.lang.Character   #用於將utf的10進位內碼轉為中文之用
#IMPORT JAVA java.lang.Integer     #用於將utf的10進位內碼轉為中文之用
#IMPORT JAVA java.lang.String      #java的字串

IMPORT os
IMPORT util #用於genero內建的亂數產生器之用

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#分鏡匯入中介檔 type 宣告
PRIVATE TYPE type_g_dzeh_d        RECORD #dzeh_t為分鏡匯入介面檔
   dzeh001 LIKE dzeh_t.dzeh001, 
   dzeh002 LIKE dzeh_t.dzeh002, 
   dzeh003 LIKE dzeh_t.dzeh003, 
   dzeh004 LIKE dzeh_t.dzeh004, 
   dzeh005 LIKE dzeh_t.dzeh005, 
   dzeh006 LIKE dzeh_t.dzeh006, 
   dzeh007 LIKE dzeh_t.dzeh007, 
   dzeh008 LIKE dzeh_t.dzeh008, 
   dzeh009 LIKE dzeh_t.dzeh009, 
   dzeh010 LIKE dzeh_t.dzeh010, 
   dzeh011 LIKE dzeh_t.dzeh011, 
   dzeh012 LIKE dzeh_t.dzeh012, 
   dzeh013 LIKE dzeh_t.dzeh013, 
   dzeh014 LIKE dzeh_t.dzeh014,
   dzeh015 LIKE dzeh_t.dzeh015,
   #Begin:2014/09/16 by Hiko
   gztd005 LIKE gztd_t.gztd005, #預設控件
   gztd010 LIKE gztd_t.gztd010, #畫面寬度
   gztd013 LIKE gztd_t.gztd013, #資料大小寫 #20160413
   dzej003 LIKE dzej_t.dzej003  #預設值
   #End:2014/09/16 by Hiko
       END RECORD
       
DEFINE g_dzeh_d          DYNAMIC ARRAY OF type_g_dzeh_d       #存放表格資料的RECORD ARRAY
DEFINE g_dzeh_d2         DYNAMIC ARRAY OF type_g_dzeh_d       #存放表格資料的RECORD ARRAY
DEFINE g_file_path_str   STRING                               #分鏡檔檔案路徑
DEFINE g_xml_str         STRING                               #分鏡的xml格式字串
DEFINE g_dom_doc         om.DomDocument                       #Dom文件   
DEFINE g_dom_root        om.DomNode                           #Dom的根節點
DEFINE g_table_name      LIKE    dzeh_t.dzeh007               #表格名稱
DEFINE g_sco_id          LIKE    type_t.chr100                #分鏡檔代號(不含.sco)
#DEFINE g_module_id       STRING                               #模組代號
DEFINE g_cnt             LIKE type_t.num5                     #dzeh_t中的資料筆數
DEFINE g_dzek_d          DYNAMIC ARRAY OF RECORD
         dzek001            LIKE   dzek_t.dzek001,
         dzek002            LIKE   dzek_t.dzek002
      END RECORD


#定義分鏡檔中使用的tag名稱常數
CONSTANT G_TABLE_TAG  = "EntityRole"                          #分鏡檔中表格node的tag  
CONSTANT G_COLUMN_TAG = "Col"                                 #分鏡檔中欄位node的tag
DEFINE g_env LIKE dzeb_t.dzeb029 #2014/11/18 by Hiko

MAIN
   DEFINE l_dzeh006 LIKE dzeh_t.dzeh006
    
   #測試轉換中文之用
   #DEFINE l_ch_out base.Channel #Genero寫入的檔案物件變數

   #設定SQL錯誤記錄方式 (模組內定義有效)
   #WHENEVER ERROR CALL cl_err_msg_log #20150414 by Hiko

   #CLOSE WINDOW SCREEN
      
   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()

   DISPLAY "Info: Starting the process of adzp160"

   CALL adzp160_init()

   ###### 1. 讀取分鏡檔並逐行處理分鏡檔內容、utf8內碼轉換成中文、產生合法的XML格式的字串g_xml_str - 呼叫函式 ######
   CALL adzp160_read_sco_file(g_file_path_str)
   DISPLAY "[Purpose1]:Import TABLE specifications from sco file into dzeh_t"
   DISPLAY "Info: Read sco file and generate xml format......OK"

   TRY   
      #從分鏡的xml格式字串來建立Dom文件
      LET g_dom_doc = om.DomDocument.createFromString(g_xml_str)
      #由Dom文件取得根節點給FUNCTION adzp160_get_table_colume_data使用
      LET g_dom_root = g_dom_doc.getDocumentElement()
   CATCH
      IF STATUS THEN
         DISPLAY "Info: Parse dom node of XML format......ERROR"
         EXIT PROGRAM
      END IF
   END TRY
   
   ###### 2.利用g_dom_root根節點擷取表格欄位資料 - 呼叫函式 ######
   CALL adzp160_get_table_colume_data(G_TABLE_TAG)

   #Begin: 160505-00006
   ###### 2.1 檢查欄位名稱的合法性 - 呼叫函式 ######
   CALL adzp160_chk_table_colume_data()
   #End: 160505-00006

   ###### 3.新增分鏡檔內的表格欄位資料到資料庫(dzeh_t)中 - 呼叫函式 ######
   CALL adzp160_insert_data_to_dzeh_t()
   DISPLAY "Info: Adjust data and then insert data into dzeh_t......OK"
   DISPLAY "Info: Parse sco file and insert data into dzeh_t......SUCCESS"
   LET l_dzeh006 = g_sco_id
   SELECT COUNT(*) INTO g_cnt FROM dzeh_t WHERE dzeh006 = l_dzeh006 
   #DISPLAY "g_cnt = ",g_cnt 
   IF g_cnt = 0 THEN
      DISPLAY "[Hing]:Find no the data of the table (",g_sco_id,") from dzeh_t "
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00216"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_sco_id
      CALL cl_err()
   ELSE
      ##### 4.進行將dzeh_t表格內的資料匯入r.t的相關表格內 - 呼叫函式 ######
      DISPLAY "[Purpose2]:Import TABLE specifications from dzeh_t into dzeb_t,dzebl_t,dzed_t,dzep_t"
      CALL adzp160_data_ins_rt_from_dzeh_t()
      DISPLAY "Info: Import TABLE specifications from dzeh_t into dzeb_t,dzebl_t,dzed_t,dzep_t......SUCCESS"
   END IF

   #CALL cl_ask_pressanykey("adz-00221")

END MAIN

#+初始化變數值
PRIVATE FUNCTION adzp160_init()
   #DEFINE l_dzca003 LIKE dzea_t.dzea003
   DEFINE l_client_file_path_str STRING
   DEFINE l_table_name LIKE type_t.chr100 #2015/04/28 by Hiko:此FUNCTION內的g_sco_id都改成l_table_name,以免和真正的g_sco_id混淆.
   
   #取得表格分鏡檔名
   LET l_table_name = ARG_VAL(2) CLIPPED
   DISPLAY "l_table_name = ",l_table_name
   #
   #SELECT dzea003 INTO l_dzca003 
      #FROM dzea_t 
      #WHERE dzea001=l_table_name
#
   #取得模組
   #LET g_module_id = l_dzca003 CLIPPED
   #LET g_module_id = g_module_id.toUpperCase()

   #如果外部參數為null,則出現使用此隻程式的說明 - 防呆
   IF cl_null(l_table_name) THEN
      DISPLAY "Info: Found no parameter......ERROR"
      DISPLAY "[Purpose1]:Import TABLE specifications from sco file into dzeh_t"
      DISPLAY "[Purpose2]:Import TABLE specifications from dzeh_t into dzeb_t,dzebl_t,dzed_t,dzep_t"
      DISPLAY "Ex. : r.r adzp160      ooxx_t  "
      DISPLAY "                     [table ID]"
      EXIT PROGRAM
   END IF

   #結合模組和檔名產生絕對檔案路徑
   #LET g_file_path_str = os.path.join(os.path.join(os.path.join(FGL_GETENV(g_module_id),"sa"),"tsc"),l_table_name||".sco")
   LET g_file_path_str = os.path.join(FGL_GETENV("TEMPDIR"),l_table_name||".sco")
   
   #檢查分鏡檔是否存在,存在的話更名
   IF os.path.exists(g_file_path_str) THEN
      IF os.path.rename(g_file_path_str,g_file_path_str||".bak") THEN
         DISPLAY "Info: Rename existent sco file! -->",g_file_path_str||".bak"
      END IF
   END IF
   
   #開啟client端檔案選取視窗
   LET l_client_file_path_str = adzp160_client_browse_file()

   DISPLAY "Info: The path of sco file for client = ",l_client_file_path_str
   #選擇的分鏡檔不符合預設的分鏡檔名稱,停止繼續執行下去
   IF NOT l_client_file_path_str MATCHES "*"||l_table_name||".sco" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00223"
      LET g_errparam.extend = l_client_file_path_str
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_table_name
      CALL cl_err()
      DISPLAY "Selected a wrong file !"
      EXIT PROGRAM
   END IF

   #從前端傳檔案到SERVER端
   CALL fgl_getfile(l_client_file_path_str, g_file_path_str)
   
   DISPLAY "Info: The path of sco file for server = ",g_file_path_str
   
   #檢查分鏡檔是否存在 - 防呆
   IF NOT os.path.exists(g_file_path_str) THEN
      DISPLAY "Info: Found no sco file......ERROR"
      EXIT PROGRAM
   END IF

   LET g_env = FGL_GETENV("DGENV") CLIPPED #2014/11/18 by Hiko
END FUNCTION

#+進行將dzeh_t表格內的資料匯入r.t的相關表格內
PRIVATE FUNCTION adzp160_data_ins_rt_from_dzeh_t()
   DEFINE l_cnt LIKE type_t.num5   #筆數
   DEFINE   lb_flag    BOOLEAN

   #檢查此表格在dzea_t中是否有註冊
   SELECT COUNT(*) INTO l_cnt FROM dzea_t WHERE dzea001 = g_sco_id
 
   #如果沒有被註冊則顯示錯誤訊息，提醒使用者需先至表格設計器(r.t)做註冊動作
   IF l_cnt = 0 THEN
      # 表格設計器無此表格的設計資料,請至表格設計器註冊此表格
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00065"
      LET g_errparam.extend = g_sco_id #2015/04/28 by Hiko:增加g_sco_id的顯現,才知道問題出在哪邊
      LET g_errparam.popup = TRUE
      CALL cl_err()
      DISPLAY "Info: Found no data of ",g_sco_id," from r.t......ERROR"
      EXIT PROGRAM
   ELSE
      #+ 分批擷取表格欄位資料並進行資料處理
      CALL adzp160_get_column_data_from_dzeh_t_dzek_t()
   END IF

   LET lb_flag = TRUE
   BEGIN WORK

   #插入資料到_dzep_t
   CALL adzp160_insert_data_to_dzep_t() RETURNING lb_flag
   IF lb_flag = FALSE THEN
      DISPLAY "Info: FAILED:insert to dzep_t......ERROR" 
      ROLLBACK WORK
      EXIT PROGRAM
   END IF
   DISPLAY "Info: insert to dzep_t......OK" 

   #插入資料到_dzed_t
   CALL adzp160_insert_data_to_dzed_t() RETURNING lb_flag
   IF lb_flag = FALSE THEN
      DISPLAY "Info: FAILED:insert to dzed_t......ERROR" 
      ROLLBACK WORK
      EXIT PROGRAM
   END IF
   DISPLAY "Info: insert to dzed_t......OK" 

   #插入資料到_dzebl_t
   CALL adzp160_insert_data_to_dzebl_t() RETURNING lb_flag
   IF lb_flag = FALSE THEN
      DISPLAY "Info: FAILED:insert to dzebl_t......ERROR" 
      ROLLBACK WORK
      EXIT PROGRAM
   END IF
   DISPLAY "Info: insert to dzebl_t......OK" 

   #插入資料到_dzeb_t
   CALL adzp160_insert_data_to_dzeb_t() RETURNING lb_flag
   IF lb_flag = FALSE THEN
      DISPLAY "Info: FAILED:insert to dzeb_t......ERROR" 
      ROLLBACK WORK
      EXIT PROGRAM
   END IF
   DISPLAY "Info: insert to dzeb_t......OK" 

   COMMIT WORK

END FUNCTION


#+ 分批擷取表格欄位資料並進行資料處理
PRIVATE FUNCTION adzp160_get_column_data_from_dzeh_t_dzek_t()
   DEFINE   l_sql      STRING
   DEFINE   l_cnt      LIKE   type_t.num5
   
   ### start ### 撈出dzeh_t的資料 ###
   LET l_sql = "SELECT dzeh001,dzeh002,dzeh003,dzeh004,dzeh005,dzeh006,dzeh007,",
                       "dzeh008,dzeh009,dzeh010,dzeh011,dzeh012,dzeh013,dzeh014,dzeh015,",
                       "NVL(gztd005,'05'),NVL(gztd010,'10'),NVL(gztd013,''),NVL(dzej003,'')", #2014/09/16 by Hiko #2015/12/08 by Hiko:dzej003加上NVL #20160413:增加gztd013
                " FROM dzeh_t",
                #Begin:2014/09/16 by Hiko
                " LEFT JOIN gztd_t ON gztd001=dzeh015",
                " LEFT JOIN dzej_t ON dzej001='adzi150_default_value' AND dzej002=gztd001",
                #End:2014/09/16 by Hiko
                " WHERE dzeh006 = '",g_sco_id,"'",
                "   AND dzeh008 is not null",
                " ORDER BY TO_NUMBER(dzeh005)"
   CALL g_dzeh_d2.clear()

   PREPARE load_dzeh_t FROM l_sql   #組合SQL條件

   DECLARE load_dzeh_t_curs CURSOR FOR load_dzeh_t   #指標指向PREPARE

   LET l_cnt = 1

   FOREACH load_dzeh_t_curs INTO g_dzeh_d2[l_cnt].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "get data from dzeh_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_dzeh_d2.deleteElement(l_cnt)   #刪除內容為空的元素
   LET l_cnt = l_cnt - 1

   FREE load_dzeh_t_curs
   ### end ### 撈出dzeh_t的資料 ###

   ### start ### 撈出dzek_t的資料 ###
   LET l_sql = "SELECT dzek001,dzek002 ",
                " FROM dzek_t WHERE dzek001 LIKE 'cdf%'"

   CALL g_dzek_d.clear()

   PREPARE load_dzek_t FROM l_sql   #組合SQL條件

   DECLARE load_dzek_t_curs CURSOR FOR load_dzek_t   #指標指向PREPARE

   LET l_cnt = 1

   FOREACH load_dzek_t_curs INTO g_dzek_d[l_cnt].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "get data from dzek_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_cnt = l_cnt + 1
   END FOREACH

   CALL g_dzek_d.deleteElement(l_cnt)   #刪除內容為空的元素
   LET l_cnt = l_cnt - 1

   FREE load_dzek_t_curs
   ### end ### 撈出dzek_t的資料 ###


END FUNCTION


#+ 插入資料至資料庫(dzeb_t)
PRIVATE FUNCTION adzp160_insert_data_to_dzeb_t()
   DEFINE l_cnt          LIKE type_t.num5             #筆數
   DEFINE l_pk_cnt       LIKE type_t.num5             #key值重複筆數
   DEFINE l_sql          STRING                       #要執行的sql語句
   DEFINE l_update_sql   STRING
   DEFINE l_dzebownid    LIKE   dzeb_t.dzebownid      #資料所有者
   DEFINE l_dzebowndp    LIKE   dzeb_t.dzebowndp      #資料所有部門
   DEFINE l_dzebcrtid    LIKE   dzeb_t.dzebcrtid      #資料建立者
   DEFINE l_dzebcrtdp    LIKE   dzeb_t.dzebcrtdp      #資料建立部門
   DEFINE l_dzebcrtdt    DATETIME YEAR TO SECOND      #資料創建日
   DEFINE l_data_type    LIKE   dzeb_t.dzeb007
   DEFINE l_primary_key  LIKE   dzeb_t.dzeb004
   DEFINE l_dzeb022      LIKE   dzeb_t.dzeb022        #欄位類別定義代號
   DEFINE l_dzeb023      LIKE   type_t.num5           #序號欄位號碼
   DEFINE l_tmp_str      STRING
   DEFINE lb_flag        BOOLEAN                      #檢查transation的過程式否有錯誤

   #設定要加入的共用欄位值
   LET l_dzebownid = g_user
   LET l_dzebowndp = g_dept
   LET l_dzebcrtid = g_user
   LET l_dzebcrtdp = g_dept
   LET l_dzebcrtdt = cl_get_current()

   #預設dzeb005='N'
       
   #插入用的sql語句
   LET l_sql = "INSERT INTO dzeb_t(dzeb001,dzeb002,dzeb003,dzeb004,dzeb005,dzeb006,",
                                  "dzeb007,dzeb008,dzeb024,dzeb021,dzeb022,dzeb023,",
                                  "dzeb027,dzeb028,dzeb029,dzeb012,dzeb030,dzeb031,", #2014/11/18 by Hiko #2015/12/08 by Hiko:dzeb012
                                  "dzebownid,dzebowndp,dzebcrtid,dzebcrtdp,dzebcrtdt)", 
                                  " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

                                  
   PREPARE insert_data_to_dzeb_t FROM l_sql


   LET lb_flag = TRUE

   
   FOR l_cnt = 1 TO g_dzeh_d2.getLength()
      #判斷dzeb_t中有無key值重複的資料,沒有重複才進行INSERT資料
      LET l_pk_cnt = 0 
      SELECT COUNT(1) INTO l_pk_cnt FROM dzeb_t WHERE dzeb001=g_dzeh_d2[l_cnt].dzeh006 AND dzeb002=g_dzeh_d2[l_cnt].dzeh008

      IF l_pk_cnt = 0 THEN
      
         CALL adzp160_set_dzeb022_dzeb023(g_dzeh_d2[l_cnt].dzeh008) 
         RETURNING l_dzeb022,l_dzeb023

         TRY
            EXECUTE insert_data_to_dzeb_t USING g_dzeh_d2[l_cnt].dzeh006,g_dzeh_d2[l_cnt].dzeh008,g_dzeh_d2[l_cnt].dzeh009,
                                                g_dzeh_d2[l_cnt].dzeh010,g_dzeh_d2[l_cnt].dzeh010,g_dzeh_d2[l_cnt].dzeh015, #dzeb004='Y',則dzeb005='Y'
                                                g_dzeh_d2[l_cnt].dzeh012,g_dzeh_d2[l_cnt].dzeh013,g_dzeh_d2[l_cnt].dzeh014,
                                                g_dzeh_d2[l_cnt].dzeh005,l_dzeb022,l_dzeb023,
                                                g_dzeh_d2[l_cnt].dzeh001,'N',g_env,g_dzeh_d2[l_cnt].dzej003,g_env,'N', #2014/11/18 by Hiko #2015/12/08 by Hiko:dzej003
                                                l_dzebownid,l_dzebowndp,l_dzebcrtid,l_dzebcrtdp,l_dzebcrtdt
         CATCH

            IF SQLCA.sqlcode THEN
                  #DISPLAY "SQLCA.sqlcode = ",SQLCA.sqlcode
                  #DISPLAY "SQLCA.SQLERRD[2] = ",SQLCA.SQLERRD[2]
                  #DISPLAY "SQLERRMESSAGE = ", SQLERRMESSAGE
                  #CALL cl_err("dzeb_t_insert for "||g_dzeh_d2[l_cnt].dzeh008,"std-00004",g_errshow)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00149"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = "dzeb_t"
                  LET g_errparam.replace[2] = g_sco_id
                  CALL cl_err()
            END IF

            LET lb_flag = FALSE
            EXIT FOR
         END TRY

      END IF

   END FOR

   RETURN lb_flag
END FUNCTION

#+ 插入資料至資料庫(dzebl_t)
PRIVATE FUNCTION adzp160_insert_data_to_dzebl_t()
   DEFINE l_cnt          LIKE type_t.num5            #筆數
   DEFINE l_pk_cnt       LIKE type_t.num5            #key值重複筆數
   DEFINE l_sql          STRING                      #要執行的sql語句
   DEFINE l_update_sql   STRING
   DEFINE l_dzebl002     LIKE    dzebl_t.dzebl002
   DEFINE lb_flag        BOOLEAN #檢查transation的過程式否有錯誤
   #Begin:2014/08/22 by Hiko:另外一個語系
   DEFINE l_dzeh009      LIKE    dzeh_t.dzeh009,
          l_dzeh014      LIKE    dzeh_t.dzeh014,
          l_dzebl002_x   LIKE    dzebl_t.dzebl002,
          l_dzeh009_x    LIKE    dzeh_t.dzeh009,
          l_dzeh014_x    LIKE    dzeh_t.dzeh014
   #End:2014/08/22 by Hiko

   #設定要加入的共用欄位值
   #20140530:madey  -start-
   #原本抓g_lang,改為g_dlang,並出現視窗供review語系
  #LET l_dzebl002  = g_lang #20140530: marked by madey
   LET l_dzebl002  = g_dlang 
   LET l_dzebl002 = adzp160_choose_lang(l_dzebl002,"adz-00305")
   #20140530:madey  -end-

   #Begin:2014/08/22 by Hiko
   IF l_dzebl002 = "zh_TW" THEN
      LET l_dzebl002_x = "zh_CN"
   ELSE
      LET l_dzebl002_x = "zh_TW"
   END IF
   #End:2014/08/22 by Hiko

   #插入用的sql語句
   #2015/07/09 by Ernest
   LET l_sql = "INSERT INTO dzebl_t(dzebl001,dzebl002,dzebl003,dzebl004,dzebl000)", 
                                  " VALUES(?,?,?,?,?)"

   PREPARE insert_data_to_dzebl_t FROM l_sql

   LET lb_flag = TRUE
   
   FOR l_cnt = 1 TO g_dzeh_d2.getLength()
      #判斷dzebl_t中有無key值重複的資料,沒有重複才進行INSERT資料
      LET l_pk_cnt = 0 
      SELECT COUNT(1) INTO l_pk_cnt FROM dzebl_t WHERE dzebl001=g_dzeh_d2[l_cnt].dzeh008 AND dzebl002=l_dzebl002 AND dzebl000=g_dzeh_d2[l_cnt].dzeh006 
      
      IF l_pk_cnt = 0 THEN
         TRY
            LET l_dzeh009 = cl_trans_code_tw_cn(l_dzebl002, g_dzeh_d2[l_cnt].dzeh009) #此段是避免選錯語系,所以特地再轉一次
            LET l_dzeh014 = cl_trans_code_tw_cn(l_dzebl002, g_dzeh_d2[l_cnt].dzeh014) 
            EXECUTE insert_data_to_dzebl_t USING g_dzeh_d2[l_cnt].dzeh008,l_dzebl002,l_dzeh009,l_dzeh014,g_dzeh_d2[l_cnt].dzeh006
         CATCH
            GOTO _RTN_ERR #2014/08/22 by Hiko
            LET lb_flag = FALSE
            EXIT FOR
         END TRY
      END IF
      
      #Begin:2014/08/22 by Hiko
      #判斷dzebl_t中有無key值重複的資料,沒有重複才進行INSERT資料
      LET l_pk_cnt = 0 
      SELECT COUNT(1) INTO l_pk_cnt FROM dzebl_t WHERE dzebl001=g_dzeh_d2[l_cnt].dzeh008 AND dzebl002=l_dzebl002_x AND dzebl000=g_dzeh_d2[l_cnt].dzeh006 
      
      IF l_pk_cnt = 0 THEN
         TRY
            LET l_dzeh009_x = cl_trans_code_tw_cn(l_dzebl002_x, g_dzeh_d2[l_cnt].dzeh009)
            LET l_dzeh014_x = cl_trans_code_tw_cn(l_dzebl002_x, g_dzeh_d2[l_cnt].dzeh014)
            EXECUTE insert_data_to_dzebl_t USING g_dzeh_d2[l_cnt].dzeh008,l_dzebl002_x,l_dzeh009_x,l_dzeh014_x,g_dzeh_d2[l_cnt].dzeh006
         CATCH
            GOTO _RTN_ERR
            LET lb_flag = FALSE
            EXIT FOR
         END TRY
      END IF
      #End:2014/08/22 by Hiko
   END FOR

   RETURN lb_flag

   LABEL _RTN_ERR :
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00149"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = "dzebl_t"
         LET g_errparam.replace[2] = g_dzeh_d2[l_cnt].dzeh008
         CALL cl_err()
         RETURN lb_flag
      END IF
END FUNCTION

#+ 插入資料至資料庫(dzep_t)
PRIVATE FUNCTION adzp160_insert_data_to_dzep_t()
   DEFINE l_cnt          LIKE type_t.num5             #筆數
   DEFINE l_pk_cnt       LIKE type_t.num5             #key值重複筆數
   DEFINE l_sql          STRING                       #要執行的sql語句
   DEFINE l_update_sql   STRING
   DEFINE l_dzepownid    LIKE   dzep_t.dzepownid      #資料所有者
   DEFINE l_dzepowndp    LIKE   dzep_t.dzepowndp      #資料所有部門
   DEFINE l_dzepcrtid    LIKE   dzep_t.dzepcrtid      #資料建立者
   DEFINE l_dzepcrtdp    LIKE   dzep_t.dzepcrtdp      #資料建立部門
   DEFINE l_dzepcrtdt    DATETIME YEAR TO SECOND     #資料創建日
   DEFINE l_data_type    LIKE   dzep_t.dzep007
   DEFINE l_primary_key  LIKE   dzep_t.dzep004
   DEFINE lb_flag        BOOLEAN #檢查transation的過程式否有錯誤

   #設定要加入的共用欄位值
   LET l_dzepownid = g_user
   LET l_dzepowndp = g_dept
   LET l_dzepcrtid = g_user
   LET l_dzepcrtdp = g_dept
   LET l_dzepcrtdt = cl_get_current()


   #插入用的sql語句
  #Begin :160714-00023 modify
  #LET l_sql = "INSERT INTO dzep_t(dzep001,dzep002,dzep009,dzep010,dzep012,dzep023,", #2014/09/16 by Hiko:這時候都還不知道欄位和SCC的對應關係(dzep011)
  #                               "dzepownid,dzepowndp,dzepcrtid,dzepcrtdp,dzepcrtdt)", 
  #                               " VALUES(?,?,?,?,?,?,?,?,?,?,?)"
   LET l_sql = "INSERT INTO dzep_t(dzep001,dzep002,dzep009,dzep010,dzep012,dzep023,", #2014/09/16 by Hiko:這時候都還不知道欄位和SCC的對應關係(dzep011)
                                  "dzepownid,dzepowndp,dzepcrtid,dzepcrtdp,dzepcrtdt,dzep005)", 
                                  " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"
  #End :160714-00023 modify

   PREPARE insert_data_to_dzep_t FROM l_sql

   LET lb_flag = TRUE
   
   FOR l_cnt = 1 TO g_dzeh_d2.getLength()
      #判斷dzep_t中有無key值重複的資料,沒有重複才進行INSERT資料
      LET l_pk_cnt = 0
   
      SELECT COUNT(1) INTO l_pk_cnt FROM dzep_t WHERE dzep001=g_dzeh_d2[l_cnt].dzeh006 AND dzep002=g_dzeh_d2[l_cnt].dzeh008

      IF l_pk_cnt = 0 THEN
         TRY
            EXECUTE insert_data_to_dzep_t USING g_dzeh_d2[l_cnt].dzeh006,g_dzeh_d2[l_cnt].dzeh008,g_dzeh_d2[l_cnt].gztd010,g_dzeh_d2[l_cnt].gztd005,g_dzeh_d2[l_cnt].dzej003,g_dzeh_d2[l_cnt].gztd013,
                                               #Begin: 160714-00023 modify
                                               #l_dzepownid,l_dzepowndp,l_dzepcrtid,l_dzepcrtdp,l_dzepcrtdt
                                                l_dzepownid,l_dzepowndp,l_dzepcrtid,l_dzepcrtdp,l_dzepcrtdt,g_dzeh_d2[l_cnt].dzeh010
                                               #End: 160714-00023 modify
         CATCH

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00149"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = "dzep_t"
               LET g_errparam.replace[2] = g_sco_id
               CALL cl_err()
            END IF

            LET lb_flag = FALSE
            EXIT FOR
         END TRY

      END IF

   END FOR

   RETURN lb_flag
END FUNCTION

#+ 插入資料至資料庫(dzed_t)
PRIVATE FUNCTION adzp160_insert_data_to_dzed_t()
   DEFINE l_cnt       LIKE type_t.num5            #筆數
   DEFINE l_pk_cnt    LIKE type_t.num5            #key值重複筆數
   DEFINE l_sql       STRING                      #要執行的sql語句
   DEFINE l_dzedownid LIKE dzed_t.dzedownid      #資料所有者
   DEFINE l_dzedowndp LIKE dzed_t.dzedowndp      #資料所有部門
   DEFINE l_dzedcrtid LIKE dzed_t.dzedcrtid      #資料建立者
   DEFINE l_dzedcrtdp LIKE dzed_t.dzedcrtdp      #資料建立部門
   DEFINE l_dzedcrtdt DATETIME YEAR TO SECOND   #資料創建日
   DEFINE ls_tmp_str STRING                    #處理字串用
   DEFINE l_table_id LIKE dzed_t.dzed001       #表格代碼
   DEFINE l_pk_id    LIKE dzed_t.dzed002       #primary key的代碼
   DEFINE l_pk_type  LIKE dzed_t.dzed003       #primary key的型態
   DEFINE ls_pk_str  LIKE dzed_t.dzed004       #primary key的欄位字串
   DEFINE lb_flag    BOOLEAN                   #檢查transation的過程式否有錯誤

   LET lb_flag = TRUE #2014/08/22 by Hiko
   LET l_table_id = g_sco_id
   LET ls_tmp_str = g_sco_id
   LET l_pk_id    = ls_tmp_str.subString(1,ls_tmp_str.getLength()-1),"pk"
   LET l_pk_type  = "P"

   #判斷dzed_t中有無key值重複的資料,沒有重複才進行INSERT資料
   LET l_pk_cnt = 0 
   SELECT COUNT(1) INTO l_pk_cnt FROM dzed_t WHERE dzed001=l_table_id AND dzed002=l_pk_id

   IF l_pk_cnt = 0 THEN
   
      #設定要加入的共用欄位值
      LET l_dzedownid = g_user
      LET l_dzedowndp = g_dept
      LET l_dzedcrtid = g_user
      LET l_dzedcrtdp = g_dept
      LET l_dzedcrtdt = cl_get_current()


      LET l_sql = "INSERT INTO dzed_t(dzed001,dzed002,dzed003,dzed004,",
                                     "dzed005,dzed006,dzed007,dzed008,dzed009,dzed010,", #2014/11/18 by Hiko
                                     "dzedownid,dzedowndp,dzedcrtid,dzedcrtdp,dzedcrtdt)", 
                                     " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

      PREPARE insert_data_to_dzed_t FROM l_sql
      
      #Begin:2014/11/18 by Hiko
      LET l_sql = "INSERT INTO dzec_t(dzec001,dzec002,dzec003,dzec004,",
                                     "dzec005,dzec006,dzec007,dzec008,",
                                     "dzecownid,dzecowndp,dzeccrtid,dzeccrtdp,dzeccrtdt)", 
                                     " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"

      PREPARE insert_data_to_dzec_t FROM l_sql
      #End:2014/11/18 by Hiko

      LET ls_tmp_str = ""

      #組合primary key的欄位字串
      FOR l_cnt = 1 TO g_dzeh_d2.getLength()
         IF g_dzeh_d2[l_cnt].dzeh010 = "Y" THEN
            LET ls_tmp_str = ls_tmp_str,g_dzeh_d2[l_cnt].dzeh008,","
         END IF
      END FOR
      

      #判斷dzeh_t中有無設定pk的資料
      IF ls_tmp_str.getLength ()> 0 THEN
         #去掉欄位字串的尾巴的逗點
         LET ls_tmp_str = ls_tmp_str.subString(1,ls_tmp_str.getLength()-1)
      END IF

      LET ls_pk_str = ls_tmp_str
   
      TRY
         #判斷dzeh_t中有無設定pk的資料,如果無則加入pk資料到dzed_t
         IF ls_tmp_str.getLength() > 0 THEN
            EXECUTE insert_data_to_dzed_t USING l_table_id,l_pk_id,l_pk_type,ls_pk_str,'','',
                                                'N',g_env,g_env,'N', #2014/11/18 by Hiko
                                                l_dzedownid,l_dzedowndp,l_dzedcrtid,l_dzedcrtdp,l_dzedcrtdt
            #Begin:2014/11/18 by Hiko
            EXECUTE insert_data_to_dzec_t USING l_table_id,l_pk_id,'U',ls_pk_str,
                                                'N',g_env,g_env,'N',
                                                l_dzedownid,l_dzedowndp,l_dzedcrtid,l_dzedcrtdp,l_dzedcrtdt #資料相同,所以直接拿來用
            #End:2014/11/18 by Hiko
         END IF
      CATCH
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00088" 
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzec_t or dzed_t"
            LET g_errparam.replace[2] = SQLCA.SQLCODE
            CALL cl_err()
         END IF

         LET lb_flag = FALSE
      END TRY

   END IF

   RETURN lb_flag
END FUNCTION


#+擷取表格欄位資料
PRIVATE FUNCTION adzp160_get_table_colume_data(p_tag)
   DEFINE l_cnt           LIKE type_t.num5    #筆數
   DEFINE p_tag           LIKE type_t.chr30   #要搜尋的xml的tag
   DEFINE l_node_set      om.NodeList         #tag的集合
   DEFINE l_node          om.DomNode          #要操作的節點
   DEFINE l_yn            LIKE type_t.chr1    #用來設定Y/N的變數
   DEFINE ln_cnt          LIKE type_t.num5    #筆數
   DEFINE l_gztd003       LIKE gztd_t.gztd003
   DEFINE l_gztd008       LIKE gztd_t.gztd008
   DEFINE l_table_prefix  STRING
   
   LET l_node_set = g_dom_root.selectByTagName(p_tag) #取得tag的集合

   #針對table的節點,進行資料的抓取
   IF p_tag = G_TABLE_TAG THEN

      #確認表格資料唯一
      IF l_node_set.getLength() = 1 THEN
         LET l_node = l_node_set.item(1)

         #設定表格代碼
         LET g_sco_id   = l_node.getAttribute("physicalName")CLIPPED

         #設定表格名稱
         LET g_table_name = l_node.getAttribute("displayName")


         #呼叫本身FUNCTION擷取欄位資料
         CALL adzp160_get_table_colume_data(G_COLUMN_TAG)
      ELSE
         #針對表格的資料不唯一要提醒 - 防呆
         DISPLAY "Info: The number of table data is not unique!......ERROR"
         EXIT PROGRAM
      END IF

   END IF

   #針對column的節點,進行資料的抓取g_dzeh_d的array of record
   IF p_tag = G_COLUMN_TAG THEN

      #擷取每個欄位節點的屬性質到g_dzeh_d的array of record
      FOR l_cnt = 1 TO l_node_set.getLength()
      
         LET l_node = l_node_set.item(l_cnt)

         #擷取處理狀態
         LET g_dzeh_d[l_cnt].dzeh002  = NULL

         #擷取處理結果說明
         LET g_dzeh_d[l_cnt].dzeh003  = NULL

         
         #擷取欄位序號
         LET g_dzeh_d[l_cnt].dzeh005  = l_cnt
         
         #擷取表格代碼
         LET g_dzeh_d[l_cnt].dzeh006  = g_sco_id CLIPPED
         
         #擷取表格名稱
         LET g_dzeh_d[l_cnt].dzeh007  = g_table_name CLIPPED
         
         #擷取欄位代碼
         LET g_dzeh_d[l_cnt].dzeh008  = l_node.getAttribute("physicalName") CLIPPED

         LET l_table_prefix = g_sco_id
         LET l_table_prefix = l_table_prefix.subString(1,l_table_prefix.getLength()-2)

        #Begin: 160505-00006 mark 移到新functon一併檢查
        #IF NOT g_dzeh_d[l_cnt].dzeh008 MATCHES l_table_prefix||"*" THEN
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = "adz-00267"
        #   LET g_errparam.extend = ""
        #   LET g_errparam.popup = TRUE
        #   LET g_errparam.replace[1] = g_dzeh_d[l_cnt].dzeh008
        #   LET g_errparam.replace[2] = g_sco_id
        #   CALL cl_err()
        #   EXIT PROGRAM
        #END IF
        #End: 160505-00006 mark 移到新functon一併檢查
         
         #擷取欄位名稱
         LET g_dzeh_d[l_cnt].dzeh009  = l_node.getAttribute("displayName") CLIPPED

         #轉換TRUE/FALSE為Y/N
         IF l_node.getAttribute("key") = "true" THEN LET l_yn = "Y" ELSE LET l_yn = "N" END IF
         #擷取KEY值
         LET g_dzeh_d[l_cnt].dzeh010  = l_yn

         #轉換TRUE/FALSE為Y/N
         IF l_node.getAttribute("index") = "true" THEN LET l_yn = "Y" ELSE LET l_yn = "N" END IF
         #擷取索引
         LET g_dzeh_d[l_cnt].dzeh011  = l_yn

         #擷取欄位屬性
         LET g_dzeh_d[l_cnt].dzeh015  = adzp160_token_str(l_node.getAttribute("dataType"),1) CLIPPED
         
         SELECT gztd003 INTO l_gztd003 FROM gztd_t WHERE gztd001 = g_dzeh_d[l_cnt].dzeh015
         #擷取資料型態
         LET g_dzeh_d[l_cnt].dzeh012  = l_gztd003

         SELECT gztd008 INTO l_gztd008 FROM gztd_t WHERE gztd001 = g_dzeh_d[l_cnt].dzeh015
         #擷取資料長度
         LET g_dzeh_d[l_cnt].dzeh013  = l_gztd008
         
         #擷取欄位說明
         LET g_dzeh_d[l_cnt].dzeh014  = l_node.getAttribute("colComment") CLIPPED

         LET ln_cnt = 1
         SELECT COUNT(*) INTO ln_cnt FROM gztd_t WHERE gztd001 = g_dzeh_d[l_cnt].dzeh015
         #欄位屬性不存在azzi090內(gztd_t)
         IF ln_cnt = 0 THEN
            DISPLAY "Info: The type ",g_dzeh_d[l_cnt].dzeh015," of the field don't exist!......ERROR"
            #EXIT PROGRAM #2014/08/22 by Hiko : 匯入只是給方便,屬性不存在也沒關係.
         END IF
         
      END FOR
      
   END IF
   
END FUNCTION

#+設定欄位類別定義代號(dzeb022)和序號欄位號碼(dzeb023)
PRIVATE FUNCTION adzp160_set_dzeb022_dzeb023(p_dzeh008)
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE p_dzeh008   LIKE dzeh_t.dzeh008
   DEFINE l_dzeb022    LIKE dzeb_t.dzeb022
   DEFINE l_dzeb023    LIKE dzeb_t.dzeb023
   DEFINE l_tmp_str   STRING
   DEFINE l_match_str STRING

   IF p_dzeh008 MATCHES "*[0-9]" THEN
      LET l_dzeb022 = "cdfSerialNumber"

      LET l_tmp_str = p_dzeh008
      LET l_tmp_str = l_tmp_str.subString(l_tmp_str.getLength()-2,l_tmp_str.getLength())
      LET l_dzeb023 = l_tmp_str
      RETURN l_dzeb022,l_dzeb023
   END IF

   FOR l_cnt = 1 TO g_dzek_d.getLength()
      
      LET l_match_str = "*",g_dzek_d[l_cnt].dzek002

      IF p_dzeh008 MATCHES l_match_str THEN
         LET l_dzeb022 = g_dzek_d[l_cnt].dzek001
         LET l_dzeb023 = ""
         EXIT FOR
      END IF

   END FOR

   RETURN l_dzeb022,l_dzeb023
END FUNCTION


#+ 新增分鏡檔內的表格欄位資料到資料庫(dzeh_t)中
PRIVATE FUNCTION adzp160_insert_data_to_dzeh_t()
   DEFINE l_cnt       LIKE type_t.num5            #筆數
   DEFINE l_cnt2      LIKE type_t.num5
   DEFINE l_sql       STRING                      #要執行的sql語句
   DEFINE l_user      LIKE dzeh_t.dzehownid
   DEFINE l_dept      LIKE dzeh_t.dzehowndp
   DEFINE l_date      LIKE dzeh_t.dzehcrtdt
   DEFINE lb_flag     BOOLEAN #檢查transation的過程式否有錯誤
   DEFINE l_table_id  LIKE dzeh_t.dzeh006
   DEFINE ls_err      STRING

   LET l_user = g_user
   LET l_dept = g_dept
   LET l_date = cl_get_current()

   LET l_table_id = g_sco_id

   LET l_cnt = 0

   #判斷dzeh_t中是否已有相關資料
   SELECT COUNT(*) INTO l_cnt FROM dzeh_t WHERE dzeh006 = l_table_id

   LET lb_flag = FALSE
   
 
   LET lb_flag = TRUE
   BEGIN WORK

   TRY

      IF l_cnt > 0 THEN
         #預先鎖住資料庫中要刪除的資料
         IF adzp165_lock_dzeh_t(l_table_id) THEN
            LET ls_err = "delete_data_from_dzeh_t"
            DELETE FROM dzeh_t WHERE dzeh006 = l_table_id
            #表示可以新增資料到資料庫
            LET lb_flag = TRUE
         ELSE
            #解析XML格式發生錯誤
            DISPLAY "Info: Lock dzeh_t......ERROR"
            EXIT PROGRAM
         END IF
      ELSE
         #表示可以新增資料到資料庫
         LET lb_flag = TRUE
      END IF

   IF lb_flag THEN
   
      FOR l_cnt = 1 TO g_dzeh_d.getLength()

         LET l_cnt2=0
         #插入資料前先檢查key值有無重複
         SELECT COUNT(*) INTO l_cnt2 FROM dzeh_t 
            WHERE dzeh006=g_dzeh_d[l_cnt].dzeh006 AND dzeh008=g_dzeh_d[l_cnt].dzeh008

         #key值沒有重複再進行插入資料到dzeh_t
         IF l_cnt2=0 THEN

            LET l_sql = "INSERT INTO dzeh_t(",
                        " dzeh001,dzeh002,dzeh003,dzeh004,dzeh005,",
                        " dzeh006,dzeh007,dzeh008,dzeh009,dzeh010,",
                        " dzeh011,dzeh015,dzeh012,dzeh013,dzeh014,",
                        " dzehownid,dzehowndp,dzehcrtid,dzehcrtdp,dzehcrtdt) ",
                        " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

            LET ls_err = "insert_data_to_dzeh_t(",g_dzeh_d[l_cnt].dzeh006,"|",g_dzeh_d[l_cnt].dzeh008,")"
                        
            PREPARE insert_column_date FROM l_sql
         
            #因為g_dzeh_d[l_cnt].dzeh001存放隨機產生的亂數,所以插入前不先檢查存在
            EXECUTE insert_column_date USING g_dzeh_d[l_cnt].dzeh001,g_dzeh_d[l_cnt].dzeh002,
                                             g_dzeh_d[l_cnt].dzeh003,g_dzeh_d[l_cnt].dzeh004,
                                             g_dzeh_d[l_cnt].dzeh005,g_dzeh_d[l_cnt].dzeh006,
                                             g_dzeh_d[l_cnt].dzeh007,g_dzeh_d[l_cnt].dzeh008,
                                             g_dzeh_d[l_cnt].dzeh009,g_dzeh_d[l_cnt].dzeh010,
                                             g_dzeh_d[l_cnt].dzeh011,g_dzeh_d[l_cnt].dzeh015,g_dzeh_d[l_cnt].dzeh012,
                                             g_dzeh_d[l_cnt].dzeh013,g_dzeh_d[l_cnt].dzeh014,
                                             l_user,l_dept,l_user,l_dept,l_date
         END IF

      END FOR

   END IF

   CATCH             
      IF SQLCA.sqlcode THEN

         IF SQLCA.sqlcode = -268 THEN
            
            #Key值重複出現的訊息
            DISPLAY "Info: ",ls_err,"-->Key value is not unique......ERROR"

         ELSE
            #非Key值重複出現的訊息
            DISPLAY "Info: SQL_err for ",ls_err,"......ERROR"
         END IF
         ROLLBACK WORK
         EXIT PROGRAM
      END IF
      
   END TRY

   COMMIT WORK

END FUNCTION


#+ 為了之後的處理鎖住資料庫(dzeh_t)的資料
PRIVATE FUNCTION adzp165_lock_dzeh_t(p_table_id)
   DEFINE l_forupd_sql STRING,
          p_table_id    LIKE dzea_t.dzea001,
          l_dzeh006    LIKE dzeh_t.dzeh006
   
   LET l_forupd_sql = "SELECT dzeh006",
                      " FROM dzeh_t WHERE dzeh006 = '",p_table_id,"'",
                      " FOR UPDATE"
   LET l_forupd_sql = cl_forupd_sql(l_forupd_sql)
   DECLARE adzp165_dzeh_lock_cur CURSOR FROM l_forupd_sql   #cursor lock for dzeh_t

   ### 2.鎖住dzep_t的相關資料 ###
   OPEN adzp165_dzeh_lock_cur

   #用於Oracle的lock偵測 
   IF STATUS THEN
      DISPLAY "l_forupd_sql = ",l_forupd_sql
      RETURN FALSE
   END IF

   FETCH adzp165_dzeh_lock_cur INTO l_dzeh006

   #用於Informix的lock偵測 
   IF SQLCA.sqlcode THEN
      DISPLAY "l_forupd_sql = ",l_forupd_sql
      RETURN FALSE
   END IF

   RETURN TRUE

END FUNCTION


#+ 做token，回傳指定順序的字串
PRIVATE FUNCTION adzp160_token_str(p_str,p_cnt)
   DEFINE p_str      LIKE type_t.chr200     #要做token的字串
   DEFINE p_cnt      LIKE type_t.num5       #要回傳字串的順序
   DEFINE l_tok      base.StringTokenizer   #token的物件
   DEFINE ls_tmp     LIKE type_t.chr100     #存放nextToken()的物件
   DEFINE l_cnt      LIKE type_t.num5       #筆數
   DEFINE l_return   LIKE type_t.chr100     #回傳值
   
   LET l_tok = base.StringTokenizer.create(p_str,":.()")

   LET l_cnt = 1
   
   WHILE l_tok.hasMoreTokens()

      LET ls_tmp = l_tok.nextToken()

      #筆數和指定要回傳的順序相同,則回傳該字串
      IF l_cnt = p_cnt THEN
         LET l_return = ls_tmp
         EXIT WHILE
      END IF
      
      LET l_cnt = l_cnt + 1

   END WHILE

   RETURN l_return

END FUNCTION


#+讀取分鏡檔並逐行處理分鏡檔內容
PRIVATE FUNCTION adzp160_read_sco_file(p_file)
   DEFINE p_file      STRING,            #分鏡檔的檔案路徑
          l_lineStr   STRING,            #分鏡檔的每行字串
          l_ch_in     base.Channel,      #Genero讀取的檔案物件變數
          l_replace   STRING,            #要置換的資料
          l_flag      BOOLEAN,           #判斷需要資料處理的時機
          l_str_buf   base.StringBuffer  #用來組合完整的xml結構字串給g_xml_str

   #建立Genero讀取的檔案物件
   LET l_ch_in = base.Channel.create()


   TRY 
      #指定來源的的檔案路徑
      CALL l_ch_in.openFile(p_file,"r")
   CATCH
      IF STATUS THEN
         #因應ALM註解彈出視窗
         DISPLAY "Info: No permission for sco file......ERROR"
         EXIT PROGRAM
      END IF 
   END TRY

   LET l_flag = FALSE

   LET l_str_buf = base.StringBuffer.create()

   WHILE TRUE
      #分鏡檔每行讀出
      LET l_lineStr = l_ch_in.readLine()

      IF l_ch_in.isEof() THEN EXIT WHILE END IF
      
      #因為只要處理前幾行的資料,所以處理完就不再判斷,增加效率
      IF l_flag = FALSE THEN
         #為轉成xml的標準格式需要做的處理
         IF l_lineStr.getIndexOf("SoftScore",1)! = 0 THEN
            LET l_replace = ""
            LET l_lineStr = l_replace
         END IF

         IF l_lineStr.getIndexOf("<ScenarioNode version=",1)! = 0 THEN
            LET l_replace = ""
            LET l_lineStr = l_replace
         END IF

         IF l_lineStr.getIndexOf("<Scenario versionNo=",1)! = 0 THEN
            LET l_replace = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n","  <ScenarioNode version=\"x.xx.xxxx\">\n  ",l_lineStr
            LET l_lineStr = l_replace
            LET l_flag = TRUE
         END IF
      END IF

      #每行後面加上換行符號
      LET l_lineStr = l_lineStr,ASCII 10
      CALL l_str_buf.append(l_lineStr)

      #此WHILE的結束條件
      IF l_lineStr.getIndexOf("</ScenarioNode>",1)!=0 THEN
         EXIT WHILE
      END IF
      
   END WHILE

   LET g_xml_str = l_str_buf.toString()

   CALL l_ch_in.close()
   
END FUNCTION


#+ 開啟client端的檔案選擇視窗
FUNCTION adzp160_client_browse_file()
  DEFINE ls_file   STRING

  CALL ui.Interface.frontCall("standard",
                              "openfile",
                              ["C:", "SCO File", "*.sco", "adzp160 - Choose A Sco File"],
                              [ls_file])

  IF STATUS THEN
     RETURN NULL
  END IF

  RETURN ls_file
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 列出目前資料語系清單供選擇
# Input parameter : p_lang      預設語系
#                   p_msg_code  說明訊息
# Return code     : r_lang      語系
# Date & Author   : 2014/05/30 by madey
##########################################################################
#+ 選擇資料語系
PRIVATE FUNCTION adzp160_choose_lang(p_lang,p_msg_code)
  DEFINE p_lang       LIKE gzzy_t.gzzy001,
         p_msg_code   LIKE gzze_t.gzze001,
         l_lang       LIKE gzzy_t.gzzy001,
         ls_text      STRING
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPEN WINDOW w_adzp160_lang WITH FORM cl_ap_formpath("adz","adzp160_lang")
   #Begin:20150414 by Hiko
   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   #End:20150414 by Hiko

  CURRENT WINDOW IS w_adzp160_lang

  INPUT l_lang FROM cbo_lang ATTRIBUTE(WITHOUT DEFAULTS)
    BEFORE INPUT 
       CALL cl_set_act_visible("accept,cancel", FALSE)
       #填入語言別資料
       CALL cl_set_combo_dlang("cbo_lang") 
       #給預設值
       LET l_lang = p_lang
       #訊息欄
       LET ls_text  = cl_getmsg(p_msg_code, g_lang)
       DISPLAY ls_text TO formonly.textedit1
        
    AFTER INPUT
       CALL cl_set_act_visible("accept,cancel", TRUE)

    ON ACTION btn_ok
       ACCEPT INPUT
      
    ON ACTION btn_cancel
       EXIT INPUT
    
    ON ACTION CLOSE
       EXIT INPUT

  END INPUT

  
  #畫面關閉                                                                                                
  CLOSE WINDOW w_adzp160_lang

  RETURN l_lang
END FUNCTION

#160505-00006 add
#+檢查欄位合法性
PRIVATE FUNCTION adzp160_chk_table_colume_data()
   DEFINE ls_sql            STRING
   DEFINE li_idx            LIKE type_t.num5   
   DEFINE li_loop           LIKE type_t.num5
   DEFINE la_duplicate      DYNAMIC ARRAY OF RECORD
             col_id         LIKE type_t.chr20,
             cnt            LIKE type_t.num5 
          END RECORD
   DEFINE ls_duplicate      STRING
   DEFINE lb_duplicate      BOOLEAN
   DEFINE ls_table_name     STRING
   DEFINE ls_table_pre_name STRING
   DEFINE ls_column_name    STRING
   DEFINE ls_column_char    STRING
   DEFINE ls_naming_illegal STRING
   DEFINE lb_naming_illegal BOOLEAN
   DEFINE ls_other_unicode  STRING
   DEFINE lb_other_unicode  STRING
   DEFINE ls_msg_001        STRING
   DEFINE ls_msg_002        STRING
   DEFINE ls_msg_003        STRING
   DEFINE ls_msg_all        STRING
   

   #1.判斷輸入欄位名稱是否重複
   LET lb_duplicate = FALSE

   #建立暫存表
   CREATE TEMP TABLE tmp_adzp160_chk
   (
    col_id       VARCHAR(20)   #欄位代號
   )
   
   FOR li_idx = 1 TO g_dzeh_d.getLength()
     INSERT INTO tmp_adzp160_chk VALUES(g_dzeh_d[li_idx].dzeh008)
   END FOR

   LET ls_sql = "SELECT col_id, COUNT(*)",
                "  FROM tmp_adzp160_chk",
                " GROUP BY col_id ",
                "HAVING COUNT(*) > 1"
   PREPARE adzp160_chk_prep FROM ls_sql
   DECLARE adzp160_chk_cs CURSOR FOR adzp160_chk_prep
   LET li_idx = 1
   FOREACH adzp160_chk_cs INTO la_duplicate[li_idx].col_id ,la_duplicate[li_idx].cnt
      IF NOT cl_null(la_duplicate[li_idx].col_id) THEN
         LET lb_duplicate = TRUE
         IF cl_null(ls_duplicate) THEN
            LET ls_duplicate = la_duplicate[li_idx].col_id
         ELSE
            LET ls_duplicate = ls_duplicate ,",",la_duplicate[li_idx].col_id
         END IF
      END IF
      LET li_idx = li_idx + 1
   END FOREACH
   CALL la_duplicate.deleteElement(li_idx)
   #刪除暫存表
   DROP TABLE tmp_adzp160_chk


   #2.判斷輸入欄位名稱是否含有其他 Unicode
   #3.判斷輸入欄位名稱是否符合命名原則(和TableName比對)
   LET lb_naming_illegal= FALSE
   LET lb_other_unicode = FALSE
   LET ls_table_name = g_sco_id
   LET ls_table_pre_name = ls_table_name.subString(1,ls_table_name.getIndexOf('_t',1)-1)
   FOR li_idx = 1 TO g_dzeh_d.getLength()
     LET ls_column_name = g_dzeh_d[li_idx].dzeh008
     IF ls_column_name NOT LIKE (ls_table_pre_name||"%") THEN
        LET lb_naming_illegal = TRUE
        IF cl_null(ls_naming_illegal) THEN
           LET ls_naming_illegal = g_dzeh_d[li_idx].dzeh008
        ELSE
           LET ls_naming_illegal = ls_naming_illegal ,",",g_dzeh_d[li_idx].dzeh008
        END IF
     END IF 
     FOR li_loop = 1 TO ls_column_name.getLength()
       LET ls_column_char = NVL(ls_column_name.subString(li_loop,li_loop),"@")
       IF ls_column_char NOT MATCHES "[a-z]" AND ls_column_char NOT MATCHES "[0-9]" THEN
          LET lb_other_unicode = TRUE
          IF cl_null(ls_other_unicode) THEN
             LET ls_other_unicode = g_dzeh_d[li_idx].dzeh008
          ELSE
             LET ls_other_unicode = ls_other_unicode ,",",g_dzeh_d[li_idx].dzeh008
          END IF
          EXIT FOR
       END IF
     END FOR
   END FOR

   IF lb_duplicate THEN
      LET ls_msg_001 = cl_replace_err_msg(cl_getmsg("adz-01011", g_lang),ls_duplicate)
      IF cl_null(ls_msg_all) THEN
         LET ls_msg_all = ls_msg_001
      ELSE
         LET ls_msg_all = ls_msg_all , ASCII 10 ,ls_msg_001
      END IF
   END IF
   IF lb_other_unicode THEN
      LET ls_msg_002 = cl_replace_err_msg(cl_getmsg("adz-01012", g_lang),ls_other_unicode)
      IF cl_null(ls_msg_all) THEN
         LET ls_msg_all = ls_msg_002
      ELSE
         LET ls_msg_all = ls_msg_all , ASCII 10 ,ls_msg_002
      END IF
   END IF

   IF lb_naming_illegal THEN
      LET ls_msg_003 = cl_replace_err_msg(cl_getmsg("adz-00267", g_lang),ls_naming_illegal||"|"||g_sco_id)
      IF cl_null(ls_msg_all) THEN
         LET ls_msg_all = ls_msg_003
      ELSE
         LET ls_msg_all = ls_msg_all , ASCII 10 ,ls_msg_003
      END IF
   END IF

   IF NOT cl_null(ls_msg_ALL) THEN
      LET ls_msg_all = cl_getmsg("adz-00625",g_lang),ASCII 10,
                       ls_msg_all
      CALL sadzi140_rev_view_logresult(ls_msg_all)
      EXIT PROGRAM
   END IF 

   #160704-00015 begin
   #EXIT PROGRAM
   #160704-00015 end

END FUNCTION 

