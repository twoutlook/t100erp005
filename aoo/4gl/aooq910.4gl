#該程式已解開Section, 不再透過樣板產出!
{<section id="aooq910.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-02-12 11:53:59), PR版次:0011(2016-10-24 16:55:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: aooq910
#+ Description: 歷史報表查詢作業
#+ Creator....: 00742(2014-12-24 14:32:33)
#+ Modifier...: 00742 -SD/PR- 01534
 
{</section>}
 
{<section id="aooq910.global" >}
#應用 q01 樣板自動產生(Version:6)
#+ Modifier...: No.150916-00003#1 15/10/21 Candice  調整系統管理員的控卡,加入superuser群組的判斷
#+ Modifier...: No.151103-00005#1 15/11/03 Candice  移除報表環境變數
#+ Modifier...: No.160225-00033#1 16/02/25 Cynthia  歷史報表URL路徑分隔符號調整
#160727-00019#10 2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aooq910_time_tmp -->aooq910_tmp01
#161019-00017#1   2016/10/20  By lixh  组织类型调整 q_ooef001 => q_ooef001_1
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
         name           STRING,                 #節點名稱          
         pid            STRING,                 #父節點id
         id             STRING,                 #節點id
         has_children   BOOLEAN,                #1:有子節點 null:無子節點          
         exp            BOOLEAN,                #0:不展開 1:展開
         level          LIKE type_t.num5,       #階層
         path           STRING,                 #節點路徑，以"."隔開
         values         LIKE type_t.chr1000,    #此節點的值
         site           LIKE ooef_t.ooef001,    #此節點歸屬的營運中心(最上階)
         bdate          LIKE type_t.dat,        #起始日 (for時間查詢)
         edate          LIKE type_t.dat         #截止日 (for時間查詢)                
         END RECORD
 
#user-define add
PRIVATE TYPE type_g_detail2 RECORD
         oojpent        LIKE oojp_t.oojpent,    #企業編號
         oojpsite       LIKE oojp_t.oojpsite,   #營運據點
         oojp001        LIKE oojp_t.oojp001,    #作業編號
         oojp001_desc   LIKE gzzal_t.gzzal003,  #程式名稱
         oojp002        LIKE oojp_t.oojp002,    #製表人
         oojp002_desc   LIKE ooag_t.ooag011,    #製表人全名
         oojp003        LIKE oojp_t.oojp003,    #角色
         oojp004        LIKE oojp_t.oojp004,    #建立時間
         filesize       LIKE type_t.num20,      #檔案大小
         oojp005        LIKE oojp_t.oojp005,    #歷史報表檔名
         gzzz005        LIKE gzzz_t.gzzz005,    #模組
         filedat        like type_t.dat         #檔案日期
         END RECORD
 
#end user-define add
 
#模組變數(Module Variables)
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
 DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER   #root資料所在
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num5              #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-標準(Module Variable)
DEFINE g_items             STRING
DEFINE g_texts             STRING
DEFINE g_detail2           DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_cnt       LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail2_idx       LIKE type_t.num5
DEFINE g_sel               LIKE type_t.chr1
#end add-point
#add-point:自定義模組變數-客製(Module Variable)

##end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aooq910.main" >}
#應用 a26 樣板自動產生(Version:2)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define

   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
 
   #end add-point
 
   #add-point:SQL_define

   #end add-point
 
   #add-point:SQL_define
 
   #end add-point
 
 
   #add-point:main段define_sql

   #end add-point 
 
   #add-point:main段define_sql

   #end add-point
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooq910 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooq910_init()   
 
      #進入選單 Menu (="N")
      CALL aooq910_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooq910
      
   END IF
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="aooq910.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 建立Temp table
# Memo...........:
# Usage..........: CALL aooq910_create_tmp ()
# Input parameter: None   
# Return code....: None
################################################################################
PRIVATE FUNCTION aooq910_create_tmp()
   DROP TABLE aooq910_tmp
   CREATE TEMP TABLE aooq910_tmp(
      oojpent        LIKE oojp_t.oojpent,    #企業編號
      oojpsite       LIKE oojp_t.oojpsite,   #營運據點
      oojp001        LIKE oojp_t.oojp001,    #作業編號
      oojp001_desc   LIKE gzzal_t.gzzal003,  #程式名稱
      oojp002        LIKE oojp_t.oojp002,    #製表人
      oojp002_desc   LIKE ooag_t.ooag011,    #製表人全名
      oojp003        LIKE oojp_t.oojp003,    #角色
      oojp004        LIKE type_t.typeud021,  #建立時間
      filesize       LIKE type_t.num20,      #檔案大小
      oojp005        LIKE oojp_t.oojp005,    #歷史報表檔名
      gzzz005        LIKE gzzz_t.gzzz005,    #歸屬模組
      filedat        LIKE type_t.dat)        #檔案日期
   TRUNCATE TABLE aooq910_tmp

   DROP TABLE aooq910_tmp01            #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01
   CREATE TEMP TABLE aooq910_tmp01(    #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01
      sn             LIKE type_t.num5,      #排序
      time_value     LIKE type_t.chr100,    #時間代號
      bdate          LIKE type_t.dat,       #起始日
      edate          LIKE type_t.dat)       #截止日
   TRUNCATE TABLE aooq910_tmp01        #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01
END FUNCTION

################################################################################
# Descriptions...: 檢查用戶或角色是否為系統管理員
# Memo...........:
# Usage..........: CALL aooq910_chkadmin()
#                  RETURNING l_flag
# Input parameter: None
# Return code....: l_flag    是否為系統管理員
################################################################################
PRIVATE FUNCTION aooq910_chkadmin()
   #用戶為tiptop或角色屬於superuser時為系統管理員，傳回TRUE，否則傳回FALSE
   #IF g_user = "tiptop" OR g_roles.getIndexOf("admin-01", 1) > 0 THEN  #150916-00003#1 mark
   IF g_account = "tiptop" OR aooq910_chksuperuser() THEN               #150916-00003#1 add
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立日期暫存表
# Memo...........:
# Usage..........: CALL aooq910_ins_time_tmp()
################################################################################
PRIVATE FUNCTION aooq910_ins_time_tmp()
   DEFINE l_time_value     LIKE type_t.chr100
   DEFINE i                LIKE type_t.num5
   DEFINE l_yy,l_mm        LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_bdate,l_edate  LIKE type_t.dat
   DEFINE l_time_tmp       RECORD 
          sn               LIKE type_t.num5,      #排序
          time_value       LIKE type_t.chr100,    #時間代號
          bdate            LIKE type_t.dat,       #起始日
          edate            LIKE type_t.dat        #截止日
          END RECORD
   
   TRUNCATE TABLE aooq910_tmp01        #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01

   #取得上週日的日期
   LET l_sql = "SELECT CASE WHEN TO_CHAR(sysdate,'D')=1 THEN ",
             " NEXT_DAY( TO_DATE ('",g_today-14,"','YY/MM/DD'),'SUNDAY') ",
             "  ELSE  NEXT_DAY( TO_DATE ('",g_today-7,"','YY/MM/DD'),'SUNDAY') END FROM DUAL "
   PREPARE aooq910_time_tmp01 FROM l_sql
   EXECUTE aooq910_time_tmp01 INTO l_bdate
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "aooq910_tmp01:"         #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF
   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   
   FOR i = 1 TO 18
      LET l_time_tmp.sn = i
      CASE i
         WHEN "1"  #今天
            LET l_time_tmp.time_value = cl_getmsg('azz-00723',g_lang) #今天
            LET l_time_tmp.bdate = g_today
            LET l_time_tmp.edate = g_today
         WHEN "2"  #昨天
            LET l_time_tmp.time_value = cl_getmsg('azz-00724',g_lang) #昨天
            LET l_time_tmp.bdate = g_today -1
            LET l_time_tmp.edate = g_today -1
         WHEN "3"  #前天
            LET l_time_tmp.time_value = cl_getmsg('azz-00725',g_lang) #前天
            LET l_time_tmp.bdate = g_today -2
            LET l_time_tmp.edate = g_today -2
         WHEN "4"  #本週
            LET l_time_tmp.time_value = cl_getmsg('azz-00726',g_lang) #本週
            LET l_time_tmp.bdate = l_bdate
            LET l_time_tmp.edate = g_today
         WHEN "5"  #上週
            LET l_bdate = l_bdate - 7
            LET l_time_tmp.time_value = cl_getmsg('azz-00727',g_lang) #上週
            LET l_time_tmp.bdate = l_bdate 
            LET l_time_tmp.edate = l_bdate + 6
         WHEN "6"  #二週前
            LET l_bdate = l_bdate - 7
            LET l_time_tmp.time_value = cl_getmsg('azz-00728',g_lang) #二週前
            LET l_time_tmp.bdate = l_bdate 
            LET l_time_tmp.edate = l_bdate + 6
         WHEN "7"  #三週前
            LET l_bdate = l_bdate - 7
            LET l_time_tmp.time_value = cl_getmsg('azz-00729',g_lang) #三週前
            LET l_time_tmp.bdate = l_bdate 
            LET l_time_tmp.edate = l_bdate + 6
         WHEN "8"  #上1個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-1) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "9"  #上2個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-2) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "10"  #上3個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-3) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "11"  #上4個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-4) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "12"  #上5個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-5) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "13"  #上6個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-6) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "14"  #上7個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-7) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "15"  #上8個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-8) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "16"  #上9個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-9) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "17"  #上10個月(YYYY年MM月)
            CALL aooq910_month_days(l_yy,l_mm,-10) RETURNING
               l_time_tmp.time_value,l_time_tmp.bdate,l_time_tmp.edate
         WHEN "18"  #其它
            LET l_time_tmp.time_value = cl_getmsg('azz-00730',g_lang)
            LET l_time_tmp.edate = l_time_tmp.bdate - 1
            LET l_time_tmp.bdate = '01/01/01'
         OTHERWISE CONTINUE FOR
      END CASE
      
      INSERT INTO aooq910_tmp01 VALUES(l_time_tmp.*)      #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01
      
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_aooq910_tmp01:"       #160727-00019#10 Mod   ins_time_tmp -->aooq910_tmp01
         LET g_errparam.code   = STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOR 
      END IF
   
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_month_days(p_yy, p_mm, p_add_month)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
################################################################################
PRIVATE FUNCTION aooq910_month_days(p_yy,p_mm,p_add_month)
   DEFINE p_yy,p_mm,p_add_month  LIKE type_t.num5
   DEFINE l_date                 LIKE type_t.dat
   DEFINE l_yy,l_mm              LIKE type_t.num5
   DEFINE l_first_date           LIKE type_t.dat
   DEFINE l_last_date            LIKE type_t.dat
   DEFINE l_time_value           LIKE type_t.chr1000
   
   IF (p_mm + p_add_month > 0) AND (p_mm + p_add_month < 13) THEN #加減月份後落在合理範圍時
      LET l_date = MDY(p_mm + p_add_month, 1, p_yy)
      CALL aooq910_monthchk(l_date) RETURNING l_first_date, l_last_date
      LET l_time_value = p_yy USING '&&&&',cl_getmsg('agl-00274',g_lang),p_mm + p_add_month USING '&&',cl_getmsg('agl-00275',g_lang)
   ELSE
      IF (p_mm + p_add_month) <= 0 THEN
         LET l_date = MDY(p_mm + p_add_month + 12, 1, p_yy - 1)
         CALL aooq910_monthchk(l_date) RETURNING l_first_date, l_last_date
         LET l_time_value = p_yy - 1 USING '&&&&',cl_getmsg('agl-00274',g_lang),
                            p_mm + p_add_month + 12 USING '&&',cl_getmsg('agl-00275', g_lang)
      ELSE
         LET l_date = MDY(p_mm + p_add_month - 12, 1, p_yy + 1)
         CALL aooq910_monthchk(l_date) RETURNING l_first_date, l_last_date
         LET l_time_value = p_yy + 1 USING '&&&&',cl_getmsg('agl-00274', g_lang),
                            p_mm + p_add_month-12 USING '&&',cl_getmsg('agl-00275', g_lang)
   
      END IF
   END IF

   RETURN l_time_value, l_first_date, l_last_date
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_ins_tmp()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
################################################################################
PRIVATE FUNCTION aooq910_ins_tmp()
   DEFINE l_size        LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_file_path   STRING
   DEFINE l_msg         STRING
   Define l_rec         type_g_detail2
   
   TRUNCATE TABLE aooq910_tmp
   
   #直接從oojp_t抓資料存入tmp檔
   
   LET g_sql = "INSERT INTO aooq910_tmp ",
               "(SELECT oojpent, oojpsite, oojp001, gzzal003, oojp002, ooag011,",
               "        oojp003, oojp004, '', oojp005, gzzz005, trunc(oojp004,'DDD') filedat ",
               "  FROM oojp_t ",
               "  LEFT JOIN gzzal_t ON oojp001 = gzzal001 AND gzzal002 = '",g_dlang,"'",
               "  LEFT JOIN ooag_t ON oojp002 = ooag001",
               "  LEFT JOIN gzzz_t ON oojp001 = gzzz001",
               " WHERE oojp006 = 'Y' AND oojpent = '",g_enterprise,"'"         

   #若非管理員權限只能看到用戶自己產生的歷史報表
   IF NOT aooq910_chkadmin() THEN
      LET g_sql = g_sql," AND oojp002 = '",g_user,"'"
   END IF   

   LET g_sql = g_sql,")"
   
   EXECUTE IMMEDIATE g_sql
   
   LET g_sql = "SELECT * FROM aooq910_tmp"

   PREPARE aooq910_ins_tmp_pre FROM g_sql
   DECLARE aooq910_ins_tmp_cur CURSOR FOR aooq910_ins_tmp_pre
   FOREACH aooq910_ins_tmp_cur INTO l_rec.*       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #檢查檔案是否存在
      IF NOT cl_null(l_rec.oojp005) THEN
         #LET l_file_path = os.path.join(FGL_GETENV("MNT4RP"), os.Path.join("history", l_rec.oojp005))           #151103-00005#1 mark
         LET l_file_path = os.path.join(cl_rpt_get_env_global("MNT4RP"), os.Path.join("history", l_rec.oojp005)) #151103-00005#1 add
         IF os.Path.exists(l_file_path) THEN
            #檔案存在，取得檔案大小
            CALL os.Path.size(l_file_path) RETURNING l_size
            LET l_rec.filesize = l_size/1000      #轉成kb
            
            #檔案大小更新到暫存表中
            UPDATE aooq910_tmp SET filesize = l_rec.filesize
             WHERE oojpent = l_rec.oojpent
               AND oojpsite = l_rec.oojpsite
               AND oojp001 = l_rec.oojp001
               AND oojp002 = l_rec.oojp002
               AND oojp004 = l_rec.oojp004
         ELSE
            #
            UPDATE oojp_t SET oojp006 = 'N'
             WHERE oojpent = l_rec.oojpent
               AND oojpsite = l_rec.oojpsite
               AND oojp001 = l_rec.oojp001
               AND oojp002 = l_rec.oojp002
               AND oojp004 = l_rec.oojp004
            
            DELETE FROM aooq910_tmp
             WHERE oojpent = l_rec.oojpent
               AND oojpsite = l_rec.oojpsite
               AND oojp001 = l_rec.oojp001
               AND oojp002 = l_rec.oojp002
               AND oojp004 = l_rec.oojp004
         END IF
      END IF
   END FOREACH
   
   call aooq910_detail_show(NULL)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_query()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
################################################################################
PRIVATE FUNCTION aooq910_query()
   DEFINE ls_wc   STRING
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_detail_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面
   CLEAR FORM 
   CALL g_detail.clear() 
   CALL g_detail2.clear() 
   #清空畫面 Tree的部份
   DISPLAY ARRAY g_detail TO s_detail1.*
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY
   
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aooq910_ins_time_tmp()   
   CALL aooq910_construct()
   
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      RETURN
   END IF
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   
   #掃描TEMPDIR檔案資訊存入TEMP TABLE
   CALL aooq910_ins_tmp()
   CALL aooq910_b_fill()
   
   IF g_detail_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
################################################################################
PRIVATE FUNCTION aooq910_construct()
   DEFINE l_i        LIKE type_t.num5
   DEFINE ls_wc      STRING
   
   #清除畫面
   CLEAR FORM
   LET g_action_choice = ""
   INITIALIZE g_wc TO NULL

   CALL g_detail.clear() 
   CALL g_detail2.clear() 
   LET g_sel = '1'

   #清空畫面 Tree的部份
   DISPLAY ARRAY g_detail TO s_detail1.*
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY
                                                                                     
   DIALOG ATTRIBUTE(unbuffered)
      
      CONSTRUCT BY NAME g_wc ON oojp001, oojpsite, filedat, oojp002, oojp003     
         BEFORE CONSTRUCT                                                         
             CALL cl_qbe_init()  

         ON ACTION CONTROLP INFIELD oojpsite
            #營運據點查詢開窗
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()        #161019-00017#1
            CALL q_ooef001_1()      #161019-00017#1
            DISPLAY g_qryparam.return1 TO oojpsite             #顯示到畫面上
            NEXT FIELD filedat                                 #返回原欄位
            #end 營運據點查詢開窗
            
         ON ACTION CONTROLP INFIELD oojp001
            #作業編號查詢開窗
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            #給予arg
            CALL q_gzzz001()                                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojp001              #顯示到畫面上
            NEXT FIELD oojpsite                                #返回原欄位
            #end 作業編號查詢開窗
            
         ON ACTION CONTROLP INFIELD oojp002
            #用戶查詢開窗
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzxa003_2()
            DISPLAY g_qryparam.return1 TO oojp002
            #end 用戶查詢開窗
            
         ON ACTION CONTROLP INFIELD oojp003
            #部門查詢開窗
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            #CALL q_ooef001_17() #140731 mark
            CALL q_gzya001()          
            DISPLAY g_qryparam.return1 TO oojp003
            #end 部門查詢開窗
            
      END CONSTRUCT

      INPUT g_sel FROM sel ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD sel
            IF NOT cl_null(g_sel) THEN
               IF g_sel NOT MATCHES '[1234]' THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
      END INPUT
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG

   END DIALOG
   IF INT_FLAG THEN
      RETURN
   END IF
   
   IF cl_null(g_wc) THEN
      LET g_wc = "1=1"
   END IF
      
   IF NOT aooq910_chkadmin() THEN #非tiptop只能查詢自己的報表
      LET g_wc = g_wc , " AND oojp002 = '",g_user,"'"
   END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_view(p_filepath)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aooq910_view(p_filepath)
   DEFINE p_filepath STRING
   DEFINE l_url      STRING
   DEFINE l_res      LIKE type_t.num10
   
   #LET l_url = FGL_GETENV("XTRAGRIDIP"),"history/gr/",p_filepath            #151103-00005#1 mark
#   LET l_url = cl_rpt_get_env_global("XTRAGRIDIP"),"history/gr/",p_filepath  #151103-00005#1 add   #160225-00033#1 mark
   LET l_url = os.Path.join(os.Path.join(os.Path.join(cl_rpt_get_env_global("XTRAGRIDIP"),"history"),"gr"),p_filepath)  #151103-00005#1 add   #160225-00033#1 add
   CALL ui.Interface.frontCall("standard","launchurl",l_url,l_res)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_rolename(p_key)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
################################################################################
PRIVATE FUNCTION aooq910_rolename(p_key)
   DEFINE p_key   LIKE gzya_t.gzya001
   DEFINE l_res   LIKE gzyal_t.gzyal003
   
   SELECT gzyal003 INTO l_res FROM gzyal_t
    WHERE gzyal001 = p_key AND gzyal002 = g_dlang AND gzyalent = g_enterprise
   
   RETURN l_res
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_monthchk(p_date)
#                  RETURNING l_bdate,l_edate
# Input parameter: p_date         日期
# Return code....: l_bdate        該月之第一天
#                : l_edate        該月之最後一天
################################################################################
PRIVATE FUNCTION aooq910_monthchk(p_date)
   DEFINE   p_date     LIKE type_t.dat,           #No.FUN-680147 DATE
            p_bdate    LIKE type_t.dat,           #No.FUN-680147 DATE
            p_edate    LIKE type_t.dat,           #No.FUN-680147 DATE
            l_date     LIKE type_t.dat,           #No.FUN-680147 DATE
            b_date     LIKE type_t.chr8,          #No.FUN-680147 VARCHAR(8)
            l_tmp      LIKE type_t.num5           #No.FUN-680147 SMALLINT
 
    IF p_date IS NULL OR p_date=' ' THEN
       RETURN '',''
    END IF
    LET b_date=p_date USING "yyyymmdd"
    IF b_date[7,8]<>'01' THEN
       LET b_date=b_date[1,4],b_date[5,6],b_date[7,8]*0+1 USING '&&'
    END IF
    LET p_bdate = MDY(b_date[5,6],b_date[7,8],b_date[1,4])    #該月第一天
    #將月份加一, 再將日期減一, 即可得到上月的最後一天
    LET b_date=b_date[1,4],b_date[5,6]+1 USING '&&',b_date[7,8]
    IF b_date[5,6]='13' THEN
       LET b_date=b_date[1,4]+1 USING '&&&&',b_date[5,6]*0+1
                   USING '&&',b_date[7,8]
    END IF
    LET l_date = MDY(b_date[5,6],b_date[7,8],b_date[1,4]) #該月之最後一天
    LET p_edate=l_date-1
    RETURN p_bdate,p_edate
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_b_fill3(p_pid,p_level,p_path,p_site,p_key1,p_bdate,p_edate)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
################################################################################
PRIVATE FUNCTION aooq910_b_fill3(p_pid,p_level,p_path,p_site,p_key1,p_bdate,p_edate)
   DEFINE p_pid         STRING                  #父節點id
   DEFINE p_level       LIKE type_t.num5        #階層
   DEFINE p_site        LIKE ooef_t.ooef001     #營運中心
   DEFINE p_path        STRING                  #節點路徑
   DEFINE p_bdate       LIKE type_t.dat
   DEFINE p_edate       LIKE type_t.dat
   DEFINE p_key1        STRING            
   DEFINE l_child       INTEGER
   DEFINE l_str         STRING
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_sql         STRING 
   DEFINE l_prog_id     LIKE oojp_t.oojp001
   DEFINE l_prog_name   LIKE gzzal_t.gzzal003


   LET p_level = p_level + 1   #下一階層
   CASE g_sel
      WHEN "1" #by時間列出程式代號
         LET l_sql = "SELECT UNIQUE oojp001, oojp001_desc FROM aooq910_tmp ",
                     " WHERE ",g_wc, 
                     "   AND oojpsite = '",p_site,"'",
                     "   AND filedat >='",p_bdate,"'", 
                     "   AND filedat <='",p_edate,"'",
                     " ORDER BY oojp001"
      WHEN "2" #by模組列出程式代號
         LET l_sql = "SELECT UNIQUE oojp001, oojp001_desc FROM aooq910_tmp ",
                     " WHERE ",g_wc, 
                     "   AND oojpsite = '",p_site,"'",
                     "   AND gzzz005 = '",p_key1,"'",
                     " ORDER BY oojp001"
      WHEN "3" #by角色列出程式代號
         LET l_sql = "SELECT UNIQUE oojp001, oojp001_desc FROM aooq910_tmp ",
                     " WHERE ",g_wc, 
                     "   AND oojpsite = '",p_site,"'",
                     "   AND oojp003 = '",p_key1,"'",
                     " ORDER BY oojp001"
      WHEN "4" #by用戶列出程式代號
         LET l_sql = "SELECT UNIQUE oojp001, oojp001_desc FROM aooq910_tmp ",
                     " WHERE ",g_wc, 
                     "   AND oojpsite = '",p_site,"'",
                     "   AND oojp002 = '",p_key1,"'",
                     " ORDER BY oojp001"
   END CASE

   PREPARE aooq910_tree_pr2 FROM l_sql
   DECLARE aooq910_tree_cs2 CURSOR FOR aooq910_tree_pr2
   LET l_cnt = 1
   FOREACH aooq910_tree_cs2 INTO l_prog_id,l_prog_name
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_detail_idx = g_detail_idx + 1
      LET g_detail[g_detail_idx].exp = 0          #0:不展開 1:展開
      LET g_detail[g_detail_idx].name = l_prog_name,"(",l_prog_id,")"
      LET l_str = l_cnt
      LET g_detail[g_detail_idx].id = p_pid,'.',l_str
      LET g_detail[g_detail_idx].level = p_level
      LET g_detail[g_detail_idx].pid = p_pid
      LET g_detail[g_detail_idx].path = p_path CLIPPED,'.',l_prog_id
      LET g_detail[g_detail_idx].has_children = FALSE
      LET g_detail[g_detail_idx].values = l_prog_id
      LET g_detail[g_detail_idx].site = p_site
      LET g_detail[g_detail_idx].bdate = p_bdate
      LET g_detail[g_detail_idx].edate = p_edate
      LET l_cnt = l_cnt + 1

   END FOREACH
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'list_tree2:' 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooq910_getpnode(p_pid)
#                  RETURNING 回传参数
# Input parameter: p_pid          父節點識別碼
# Return code....: 回传参数变量1   回传参数变量说明1
################################################################################
PRIVATE FUNCTION aooq910_getpnode(p_pid)
   DEFINE p_pid   STRING
   DEFINE l_i     LIKE type_t.num5
   DEFINE l_res   STRING
   
   LET l_res = NULL
   FOR l_i = 1 TO g_detail.getLength()
      IF g_detail[l_i].id = p_pid THEN
         LET l_res = g_detail[l_i].values
         EXIT FOR
      END IF
   END FOR
   RETURN l_res
END FUNCTION

PRIVATE FUNCTION aooq910_init()
   #add-point:init段define-標準

   #end add-point
   #add-point:init段define-客製

   #end add-point

   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"



   #add-point:畫面資料初始化
   IF aooq910_chkadmin() THEN    #tiptop帳號才提供全部種類查詢,其餘使用者僅能查1.時間2.模組
      LET g_items = "1,2,3,4"
      LET g_texts = cl_getmsg('azz-00731',g_lang)
      CALL cl_set_comp_visible('oojp002,oojp003',TRUE) #tiptop才看的見 QBE的製表者和svg檔名欄位  #FUN-C80015 add
   ELSE
      LET g_items = "1,2"
      LET g_texts = cl_getmsg('azz-00732',g_lang)
      CALL cl_set_comp_visible('oojp002,oojp003',FALSE)   #FUN-C80015 add
   END IF
   CALL cl_set_combo_items("sel",g_items,g_texts CLIPPED)

   CALL aooq910_create_tmp()
   #end add-point

   CALL aooq910_default_search()
END FUNCTION

PRIVATE FUNCTION aooq910_default_search()
   #add-point:default_search段define-標準

   #end add-point
   #add-point:default_search段define-客製

   #end add-point


   #add-point:default_search段開始前

   #end add-point



   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF

   #add-point:default_search段結束前

   #end add-point

END FUNCTION

################################################################################
# Descriptions...: 取得模組名稱
# Memo...........:
# Usage..........: CALL aooq910_modulename(p_key)
#                  RETURNING l_res
# Input parameter: p_key   模組編號
# Return code....: l_res   模組名稱
# Date & Author..: 15/06/23 By Candice
# Modify.........:
################################################################################
PRIVATE FUNCTION aooq910_modulename(p_key)
   DEFINE p_key   LIKE gzzol_t.gzzol001
   DEFINE l_res   LIKE gzzol_t.gzzol003
   
   SELECT gzzol003 INTO l_res FROM gzzol_t
     WHERE gzzol001 = p_key AND gzzol002 = g_dlang
   
   RETURN l_res
END FUNCTION

################################################################################
# Descriptions...: 檢查角色是否屬於superuser群組
# Memo...........:
# Usage..........: CALL aooq910_chksuperuser()
#                  RETURNING l_flag
# Input parameter: 
# Return code....: l_flag  是否屬於superuser群組
# Date & Author..: 2015/10/22 By Candice
# Modify.........: 150916-00003#1 add
################################################################################
PRIVATE FUNCTION aooq910_chksuperuser()
   DEFINE l_sql     STRING
   DEFINE l_roles   STRING
   DEFINE l_cnt     LIKE type_t.num5
   
   LET l_roles = cl_replace_str(g_roles,",","','")
   LET l_roles = "('",l_roles,"')"
   
   LET l_sql = "SELECT count(1) FROM gzya_t ",
               " WHERE gzyaent = '",g_enterprise,"'",
               " AND gzya001 IN ",l_roles CLIPPED,
               " AND gzya003 = 'Y'"
   DECLARE aooq910_chksuperuser_cs1 CURSOR FROM l_sql
   EXECUTE aooq910_chksuperuser_cs1 INTO l_cnt  
   
   IF l_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
{<section id="aooq910.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aooq910_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   #add-point:ui_dialog段define-標準
   DEFINE l_tmp     STRING
   #end add-point
   #add-point:ui_dialog段define-客製
{<point name="ui_dialog.define_customerization" edit="c"/>}
   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 
   
   #end add-point
 
  
   WHILE li_exit = FALSE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
{<point name="ui_dialog.input"/>}
         #end add-point
 
         #add-point:construct段落
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
 
            BEFORE ROW
 
               #add-point:input段before row
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               
               #根據樹狀結構目前所在節點重新產生右方清單
               CASE g_detail[g_detail_idx].level
                  WHEN "1" #營運據點LEVEL1
                     LET g_wc2 = "oojpsite = '",g_detail[g_detail_idx].site, "'"
                     CALL aooq910_detail_show("d") 
                  WHEN "2"
                     CASE g_sel
                        WHEN "1" #日期LEVEL2
                           LET g_wc2 = "oojpsite = '",g_detail[g_detail_idx].site, "'",
                                       " AND filedat BETWEEN '",g_detail[g_detail_idx].bdate,"'",
                                       " AND '",g_detail[g_detail_idx].edate,"'"
                        WHEN "2" #模組LEVEL2
                           LET g_wc2 = "oojpsite = '",g_detail[g_detail_idx].site, "'",
                                       " AND gzzz005 = '",g_detail[g_detail_idx].values,"'" 
                        WHEN "3" #角色LEVEL2
                           LET g_wc2 = "oojpsite = '",g_detail[g_detail_idx].site, "'",
                                       " AND oojp003 = '",g_detail[g_detail_idx].values,"'"
                        WHEN "4" #用戶LEVEL2
                           LET g_wc2 = "oojpsite = '",g_detail[g_detail_idx].site, "'",
                                       " AND oojp002 = '",g_detail[g_detail_idx].values,"'"
                     END CASE
                     CALL aooq910_detail_show("d")                      
                  WHEN "3"
                     IF g_detail[g_detail_idx].has_children = FALSE THEN
                        LET g_wc2 = "oojpsite = '",g_detail[g_detail_idx].site, "'",
                                    " AND oojp001 = '",g_detail[g_detail_idx].values,"'"
                        
                        LET l_tmp = aooq910_getpnode(g_detail[g_detail_idx].pid)
                        CASE g_sel
                           WHEN "1" #日期
                              LET g_wc2 = g_wc2," AND filedat BETWEEN '",g_detail[g_detail_idx].bdate,"'",
                                          " AND '",g_detail[g_detail_idx].edate,"'"
                           WHEN "2" #模組
                              IF l_tmp IS NOT NULL THEN
                                 LET g_wc2 = g_wc2," AND gzzz005 = '",l_tmp,"'"
                              END IF
                           When "3" #角色
                              IF l_tmp IS NOT NULL THEN
                                 LET g_wc2 = g_wc2," AND oojp003 = '",l_tmp,"'"
                              END IF
                           when "4" #用戶
                              IF l_tmp IS NOT NULL THEN
                                 LET g_wc2 = g_wc2," AND oojp002 = '",l_tmp,"'"
                              END IF
                        END CASE
                        CALL aooq910_detail_show("d")   
                     END IF
               END CASE
               #end add-point
 
            #應用 qs20 樣板自動產生(Version:2)
            ON EXPAND (g_detail_idx)
               #樹展開
 
            ON COLLAPSE (g_detail_idx)
               #樹關閉
 
 
 
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_detail2 TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY
               CALL cl_navigator_setting( g_detail2_idx, g_detail2_cnt )

            BEFORE ROW
               CALL cl_show_fld_cont()
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail2_idx
               DISPLAY g_detail2_idx TO FORMONLY.h_index
               DISPLAY g_detail2_cnt TO FORMONLY.h_count

            AFTER DISPLAY
               CONTINUE DIALOG   #因為外層是DIALOG  
             
            ON ACTION VIEW_SVG
               #IF cl_chk_act_auth() THEN #權限控管 
               CALL aooq910_view(g_detail2[g_detail2_idx].oojp005)
         END DISPLAY
         #end add-point
      
         BEFORE DIALOG
            #CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog
{<point name="ui_dialog.bef_dialog"/>}
            #end add-point
            #NEXT FIELD oojp001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
{<point name="ui_dialog.after_dialog"/>}
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum
{<point name="ui_dialog.agendum"/>}
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail2)
               LET g_export_id[1]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel
{<point name="menu.exporttoexcel" />}
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         
         
         
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION insert
#            LET g_action_choice="insert"
#            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert
              
               #END add-point
               
#               EXIT DIALOG
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION refresh
            LET g_action_choice="refresh"
            IF cl_auth_chk_act("refresh") THEN
               
               #add-point:ON ACTION refresh
               CALL aooq910_ins_tmp()
               CALL aooq910_b_fill()
               #END add-point
               
               EXIT DIALOG
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION output
#            LET g_action_choice="output"
#            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
{<point name="menu.output" />}
               #END add-point
               
#               EXIT DIALOG
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               CALL aooq910_query()
               CALL DIALOG.setCurrentRow("s_detail1", 1)
               CALL DIALOG.setCurrentRow("s_detail2", 1)
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo
{<point name="menu.datainfo" />}
               #END add-point
               
               EXIT DIALOG
            END IF
 
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
 
         #add-point:查詢方案相關ACTION設定前
{<point name="ui_dialog.set_qbe_action_before" mark="Y"/>}
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後
{<point name="ui_dialog.set_qbe_action_after"/>}
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aooq910.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooq910_b_fill()
   DEFINE l_sql      STRING
   DEFINE l_ooef001  LIKE ooef_t.ooef001
   DEFINE l_id       LIKE type_t.chr100
   DEFINE l_ooefl004 LIKE ooefl_t.ooefl004
 
{<point name="b_fill.define_customerization" edit="c"/>}
 
   INITIALIZE g_detail TO NULL
   LET g_detail_idx = 0
   LET l_id = 1
 
 
 
{<point name="b_fill.sql"/>}
   #無論用哪一種排序, 最上層的節點都是營運中心
   LET l_sql = "SELECT DISTINCT ooef001, ooefl004 ",
               "  FROM ooef_t ",
               "  JOIN oojp_t ON ooef001 = oojpsite",
               "  LEFT JOIN ooefl_t ON ooef001 = ooefl001 AND ooefl002 = '",g_dlang,"'",
               " WHERE ooef201 = 'Y'",
               "   AND ooefstus = 'Y'",
               "   AND ooefent = '",g_enterprise,"'",
               " ORDER BY ooef001"
               
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
    
   PREPARE aooq910_b_fill_pr1 FROM l_sql
   DECLARE aooq910_b_fill_c1 CURSOR FOR aooq910_b_fill_pr1
   FOREACH aooq910_b_fill_c1 INTO l_ooef001, l_ooefl004
      IF NOT cl_null(l_ooef001) THEN            #FUN-C80015 add 營運中心不為null才做
         LET g_detail_idx = g_detail_idx + 1
         LET g_detail[g_detail_idx].exp = 1     #0:不展開 1:展開
         LET g_detail[g_detail_idx].name = l_ooef001 CLIPPED,"(",l_ooefl004 CLIPPED,")" 
         LET g_detail[g_detail_idx].id = l_id
         LET g_detail[g_detail_idx].values = l_ooef001
         LET g_detail[g_detail_idx].site = l_ooef001
         LET g_detail[g_detail_idx].pid = NULL  #父節點
         LET g_detail[g_detail_idx].level = 1
         LET g_detail[g_detail_idx].path = l_ooef001
         LET g_detail[g_detail_idx].has_children = TRUE
         #往下列出子節點
         CALL aooq910_b_fill2(l_id,1,l_ooef001)
         LET l_id = l_id + 1
      END IF
   END FOREACH
   LET g_detail_cnt = g_detail_idx - 1
 
{<point name="b_fill.array_deleteElement" />}
END FUNCTION
 
{</section>}
 
{<section id="aooq910.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aooq910_b_fill2(p_pid,p_level,p_site)
   DEFINE p_site            LIKE ooef_t.ooef001
   DEFINE p_level           LIKE type_t.num5
   DEFINE p_pid             STRING
   DEFINE l_child           INTEGER
   DEFINE l_loop            INTEGER
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_str             STRING
   DEFINE l_sql             STRING
   DEFINE l_value           LIKE type_t.chr1000
   DEFINE l_bdate,l_edate   LIKE type_t.dat
   DEFINE l_key1            LIKE type_t.chr1000
    

   CASE g_sel
      WHEN "1" #時間
         LET l_sql = "SELECT time_value,bdate,edate FROM aooq910_tmp01",    #160727-00019#10 Mod   aooq910_time_tmp -->aooq910_tmp01
                     " ORDER BY sn " 
      
      WHEN "2" #模組
         LET l_sql = "SELECT UNIQUE gzzz005 FROM aooq910_tmp",
                     " WHERE ",g_wc,
                     "   AND oojpent = '",g_enterprise,"'",
                     "   AND oojpsite = '",p_site,"'"
      WHEN "3" #角色
         LET l_sql = "SELECT UNIQUE oojp003 FROM aooq910_tmp ",
                     " WHERE ",g_wc,
                     "   AND oojpent = '",g_enterprise,"'",
                     "   AND oojpsite = '",p_site,"'"
      WHEN "4" #用戶
         LET l_sql = "SELECT UNIQUE oojp002 FROM aooq910_tmp ",
                     " WHERE ",g_wc,
                     "   AND oojpent = '",g_enterprise,"'",
                     "   AND oojpsite = '",p_site,"'"
   END CASE
   PREPARE aooq910_fill_pr2 FROM l_sql
   DECLARE aooq910_fill_cs2 CURSOR FOR aooq910_fill_pr2

   LET l_loop = 1
   LET l_cnt = 1
   LET p_level = p_level + 1
   IF g_sel = '1' THEN
      FOREACH aooq910_fill_cs2 INTO l_value,l_bdate,l_edate
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET g_detail_idx = g_detail_idx + 1
         LET g_detail[g_detail_idx].exp = 1          #0:不展開 1:展開
         LET g_detail[g_detail_idx].name = l_value
         LET l_str = l_cnt
         LET g_detail[g_detail_idx].id = p_pid,'.',l_str
         LET g_detail[g_detail_idx].pid = p_pid
         LET g_detail[g_detail_idx].path = p_site CLIPPED,'.',l_value
         LET g_detail[g_detail_idx].has_children = TRUE
         LET g_detail[g_detail_idx].values = l_value
         LET g_detail[g_detail_idx].level = p_level
         LET g_detail[g_detail_idx].site = p_site
         LET g_detail[g_detail_idx].bdate = l_bdate
         LET g_detail[g_detail_idx].edate = l_edate
         CALL aooq910_b_fill3(g_detail[g_detail_idx].id,p_level,g_detail[g_detail_idx].path,p_site,l_key1,l_bdate,l_edate) 
         LET l_cnt = l_cnt + 1
      END FOREACH
   ELSE
      FOREACH aooq910_fill_cs2 INTO l_key1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET g_detail_idx = g_detail_idx + 1
         LET g_detail[g_detail_idx].exp = 1          #0:不展開 1:展開
         LET g_detail[g_detail_idx].name = aooq910_desc_show(l_key1)
         LET l_str = l_cnt
         LET g_detail[g_detail_idx].id = p_pid,'.',l_str
         LET g_detail[g_detail_idx].pid = p_pid
         LET g_detail[g_detail_idx].path = p_site CLIPPED,'.',l_key1
         LET g_detail[g_detail_idx].has_children = TRUE
         LET g_detail[g_detail_idx].level = p_level
         LET g_detail[g_detail_idx].values = l_key1
         LET g_detail[g_detail_idx].site = p_site
         LET l_cnt = l_cnt + 1
         CALL aooq910_b_fill3(g_detail[g_detail_idx].id,p_level,g_detail[g_detail_idx].path,p_site,l_key1,NULL,NULL) 
      
      END FOREACH
   END IF
 
{<point name="b_fill2.define_customerization" edit="c"/>}
 
{<point name="b_fill2.fill" />}
 
{<point name="b_fill2.after_fill" />}
END FUNCTION
 
{</section>}
 
{<section id="aooq910.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooq910_detail_show(p_act)
   DEFINE p_act   STRING
   DEFINE l_msg   STRING
   
   LET g_sql = "SELECT * FROM aooq910_tmp",
               " WHERE ",g_wc
   
   IF p_act = "d" THEN
      LET g_sql = g_sql," AND ",g_wc2
   END IF
   
   LET g_sql = g_sql," ORDER BY oojp001, oojp002, oojp004 desc"
   PREPARE aooq910_dshow_pre FROM g_sql
   DECLARE aooq910_dshow_cur CURSOR FOR aooq910_dshow_pre
   CALL g_detail2.clear()
   LET g_detail2_idx = 1
   FOREACH aooq910_dshow_cur INTO g_detail2[g_detail2_idx].*       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET g_detail2_idx = g_detail2_idx + 1
   END FOREACH
   
   CALL g_detail2.deleteElement(g_detail2.getLength())
   LET g_detail2_cnt = g_detail2.getLength()
   DISPLAY g_detail2_cnt TO h_count
   IF g_detail2_cnt >= 1 THEN
      LET g_detail2_idx = 1
      DISPLAY g_detail2_idx TO h_index
   END IF
   
   LET l_msg = cl_getmsg('azz-00734',g_lang),g_detail2_cnt USING '<<<<<<&'
   MESSAGE l_msg
   CALL ui.Interface.refresh()
 
{<point name="detail_show.define_customerization" edit="c"/>}
 
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aooq910.tree_expand" >}
#應用 qs21 樣板自動產生(Version:3)
#+ tree節點展開程式段
PRIVATE FUNCTION aooq910_tree_expand()
#不使用
{<point name="tree_expand.define" edit="s"/>}
 
{<point name="tree_expand.define_customerization" edit="c"/>}
 
 
 
{<point name="tree_expand.expcode_2"/>}
 
{<point name="tree_expand.sql"/>}
END FUNCTION
 
{</section>}
 
{<section id="aooq910.desc_show" >}
#應用 qs22 樣板自動產生(Version:3)
#+ tree節點名稱顯示程式段
PRIVATE FUNCTION aooq910_desc_show(p_key1)
#不使用
   DEFINE p_key1  LIKE type_t.chr1000
   DEFINE l_name  LIKE type_t.chr1000
   DEFINE l_desc  LIKE type_t.chr1000

   CASE g_sel
     WHEN "2" #模組
       LET l_desc = aooq910_modulename(p_key1)
     WHEN "3" #角色
       LET l_desc = aooq910_rolename(p_key1)
     WHEN "4" #用戶
       LET l_desc = cl_get_username(p_key1)
   END CASE

   LET l_desc = l_desc CLIPPED,"(",p_key1,")"
   RETURN l_desc
 
{<point name="desc_show.define_customerization" edit="c"/>}
 
{<point name="desc_show.name"/>}
END FUNCTION
 
{</section>}
 
{<section id="aooq910.chk_isnode" >}
#應用 qs23 樣板自動產生(Version:3)
#+ 搜尋該節點下是否還有子節點
PRIVATE FUNCTION aooq910_chk_isnode()
#不使用
{<point name="chk_isnode.define" edit="s"/>}
 
{<point name="chk_isnode.define_customerization" edit="c"/>}
 
{<point name="chk_isnode.row_count_sql"/>}
 
{<point name="chk_isnode.execute_sql_1"/>}
 
{<point name="chk_isnode.execute_sql_2"/>}
END FUNCTION
 
{</section>}
 
