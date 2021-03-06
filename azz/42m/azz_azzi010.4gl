#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2013-11-26 18:18:30), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000221
#+ Filename...: azzi010
#+ Description: WEB登入作業
#+ Creator....: 01856(2013-11-22 16:49:22)
#+ Modifier...: 01856 -SD/PR- 00000
 
{</section>}
 
{<section id="azzi010.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.160318-00005#55  2016/3/31   pengxin  修正azzi902重复定义之错误讯息
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
GLOBALS
   DEFINE g_ad_server      LIKE  type_t.chr30
   DEFINE g_ad_addr        LIKE  type_t.chr30 
   DEFINE g_ad_domain      LIKE  type_t.chr30
   DEFINE g_account_domain LIKE  type_t.chr30
END GLOBALS  

#單頭 type 宣告
PRIVATE TYPE type_g_gzxd_m RECORD
    gzxd001     LIKE gzxd_t.gzxd001,
    gzxd002     LIKE gzxd_t.gzxd002,
    domain      LIKE type_t.chr50
         END RECORD

#模組變數(Module Variables)
DEFINE g_gzxd_m      type_g_gzxd_m
DEFINE g_gzxd_m_t    type_g_gzxd_m                #備份舊值
DEFINE g_gzxd001_t   LIKE gzxd_t.gzxd001    #Key值備份

DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位
         b_statepic     LIKE type_t.chr50,
            b_gzxd001 LIKE gzxd_t.gzxd001
         #,rank           LIKE type_t.num10
      END RECORD

#無單頭append欄位定義

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING                        #組 sql 用
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num5   #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數(所有資料)
DEFINE g_tmp_page            LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN

DEFINE gc_status   LIKE type_t.chr1 #T:tiptop A:window ad  Q:QQ
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzi010.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT gzxd001,gzxd002 FROM gzxd_t WHERE gzxdent= ? AND gzxd001=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzi010_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi010 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzi010_init()
 
      #進入選單 Menu (='N')
      CALL azzi010_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzi010
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzi010.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzi010_init()
   CALL azzi010_default_search()

END FUNCTION

PRIVATE FUNCTION azzi010_ui_dialog()
   {<Local define>}
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}

   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_current_row = 0
   LET g_current_idx = 1

   CALL azzi010_input("a")

END FUNCTION

PRIVATE FUNCTION azzi010_fetch(p_fl)
   {<Local define>}
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}

   CASE p_fl
      WHEN "F" LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF
      WHEN "L"
         LET g_current_idx = g_header_cnt
      WHEN "/"
         IF (NOT g_no_ask) THEN
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE
   END CASE

   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()

   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   #該樣板不需此段落CALL cl_navigator_setting(g_browser_idx, g_current_cnt)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_gzxd_m.gzxd001 = g_browser[g_current_idx].b_gzxd001


   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE gzxd001,gzxd002
      INTO g_gzxd_m.gzxd001,g_gzxd_m.gzxd002
      FROM gzxd_t
     WHERE gzxdent = g_enterprise AND gzxd001 = g_gzxd_m.gzxd001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxd_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      INITIALIZE g_gzxd_m.* TO NULL
      RETURN
   END IF

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange", TRUE)
   END IF

   #重新顯示
   CALL azzi010_show()

END FUNCTION

PRIVATE FUNCTION azzi010_input(p_cmd)
   {<Local define>}
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_n             LIKE type_t.num5        #檢查重複用
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   {</Local define>}
   
   DEFINE ls_value      STRING 
   DEFINE li_chk        LIKE type_t.num5
   DEFINE lc_gzxd001    LIKE gzxd_t.gzxd001

   CALL cl_set_head_visible("","YES")

   IF p_cmd = "r" THEN
      #此段落的r動作等同於a
      LET p_cmd = "a"
   END IF

   LET l_insert = FALSE
   LET g_action_choice = ""
   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL azzi010_set_entry(p_cmd)
   CALL azzi010_set_no_entry(p_cmd)
   CALL azzi010_set_lang()

   DISPLAY BY NAME g_gzxd_m.gzxd001,g_gzxd_m.gzxd002,g_gzxd_m.domain

      #單頭段
      INPUT BY NAME g_gzxd_m.gzxd001,g_gzxd_m.gzxd002,g_gzxd_m.domain WITHOUT DEFAULTS
         ATTRIBUTE(UNBUFFERED)

         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF

            #其他table資料備份(確定是否更改用)
            #預設執行狀態 T
            LET gc_status = "T"
            CALL cl_set_act_visible("cancel",FALSE)
            CALL azzi010_set_visible()

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT INPUT
            ELSE 
               CONTINUE INPUT    
            END IF
               
         ON ACTION accept
            IF cl_null(g_gzxd_m.gzxd001) OR cl_null(g_gzxd_m.gzxd002) THEN 
               DISPLAY "ERROR: 帳號或密碼錯誤"
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00104"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CASE 
                  WHEN cl_null(g_gzxd_m.gzxd001) 
                     NEXT FIELD gzxd001
                  WHEN cl_null(g_gzxd_m.gzxd002)
                     NEXT FIELD gzxd002
               END CASE  
            END IF 
              
            CALL azzi010_chk_login() RETURNING li_chk,lc_gzxd001
            IF li_chk = 1 THEN 
               CALL FGL_SETENV("WEBUSER",lc_gzxd001)
               DISPLAY "WEBUSER:",FGL_GETENV("WEBUSER")
               EXIT INPUT 
            ELSE
 
               CASE 
                  WHEN li_chk = 0 
                     CALL FGL_SETENV("WEBUSER","") 
                     DISPLAY FGL_GETENV("WEBUSER")
                     DISPLAY "ERROR 帳號或密碼錯誤"
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-00104"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err() 
                     
               END CASE
               IF li_chk < 0 THEN 
                  LET li_chk = 0
               END IF             
            END IF 
           
          ON ACTION tiptop
             LET gc_status = "T" 
             CALL azzi010_set_visible()

          ON ACTION window_ad
             LET gc_status = "A"
             CALL azzi010_set_visible()
             LET g_ad_server = "Y"              
             #LET g_gzxd_m.domain = "digiwin.biz"
             #DISPLAY BY NAME g_gzxd_m.domain     

          ON ACTION mail_chk
             LET gc_status = "M"
             CALL azzi010_set_visible()

          ON ACTION send_mail
             CALL azzi010_send_mail()

          ON ACTION qq
             LET gc_status = "Q"           
             CALL azzi010_set_visible()

          ON ACTION close       #在dialog 右上角 (X)
             LET INT_FLAG = TRUE
             EXIT INPUT  
      END INPUT

      IF li_chk THEN 
         #執行 azzi000
         CALL cl_cmdrun("azzi000")
      END IF   

END FUNCTION

PRIVATE FUNCTION azzi010_show()
   LET g_gzxd_m_t.* = g_gzxd_m.*      #保存單頭舊值

   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzxd_m.gzxd001,g_gzxd_m.gzxd002

END FUNCTION

PRIVATE FUNCTION azzi010_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzxd001 = g_gzxd_m.gzxd001 THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR

   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF

END FUNCTION

PRIVATE FUNCTION azzi010_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzxd001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

END FUNCTION

PRIVATE FUNCTION azzi010_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("gzxd001",FALSE)
   END IF

END FUNCTION

PRIVATE FUNCTION azzi010_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}

   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " gzxd001 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi010_set_lang()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi010_set_lang()
   IF cl_null(g_lang) THEN
      LET g_lang = "zh_TW"
   END IF
END FUNCTION
################################################################################
# Descriptions...: #T:tiptop A:window ad  Q:QQ  #檢查從哪一入口 
# Memo...........:
# Usage..........: CALL azzi010_chk_login()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi010_chk_login()
   DEFINE lc_gzxd001    LIKE gzxd_t.gzxd001
   DEFINE li_ok         LIKE type_t.num5  
   DEFINE ls_err_str    STRING 
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE ld_login_time DATETIME YEAR TO SECOND 
   DEFINE ls_gzxd001    STRING 
   DEFINE li_type       LIKE type_t.num5
   DEFINE lc_gzxl001    LIKE gzxl_t.gzxl001
   DEFINE lc_gzxl001_1  LIKE gzxl_t.gzxl001
   DEFINE lc_gzxl002    LIKE gzxl_t.gzxl002
   DEFINE lc_gzxd001_t  LIKE gzxd_t.gzxd001

   
   #LET li_ok = FALSE 
   LET li_ok = 0 
   CASE 
      WHEN gc_status = "T"   #傳統TIPTOP帳號密碼登入
         SELECT gzxd001 INTO lc_gzxd001 FROM gzxd_t 
          WHERE gzxd001 = g_gzxd_m.gzxd001
            AND gzxd002 = g_gzxd_m.gzxd002
            AND gzxdstus = "Y"

         IF NOT cl_null(lc_gzxd001) THEN 
            LET li_ok = 1
         END IF 
    
      WHEN gc_status = "A"   #window ad 
         LET ls_gzxd001 = g_gzxd_m.gzxd001 
         LET lc_gzxd001_t = g_gzxd_m.gzxd001

         #當輸入的ad 帳號有三種 
         #1. gzxd001 = tiptop\hjwang 
         #   gzxd001 = digiwin\hjwang 
         #   domain is null 
         #2. gzxd001 = hjwang@digiwin.biz
         #   domain is null 
         #3. gzxd001 = hjwang
         #   domain is not null (ex:digiwin.biz)
         
         #域名沒設
         IF cl_null(g_gzxd_m.domain) THEN 

            CASE 
               #當輸入tiptop\hjwang
               WHEN ls_gzxd001.getIndexOf("\\",1)
                  LET lc_gzxl001 = ls_gzxd001.subString(1,ls_gzxd001.getIndexOf("\\",1)-1)
                  #LET g_ad_domain = "DC=",lc_gzxl001 
                  #先以 \之前取server ip
                  CALL azzi010_get_adserverip(lc_gzxl001) RETURNING li_ok,lc_gzxl001_1,lc_gzxl002,g_ad_addr
                  #假如取不到，再用 取lc_gzxl001加上"." 取server ip
                  IF NOT li_ok THEN 
                     CALL azzi010_get_adserverip2(lc_gzxl001||".") RETURNING li_ok,lc_gzxl001_1,lc_gzxl002,g_ad_addr
                     #組成 hjwang@digiwin.biz
                     LET g_gzxd_m.gzxd001 = ls_gzxd001.subString(ls_gzxd001.getIndexOf("\\",1)+1,ls_gzxd001.getLength()) ,"@",lc_gzxl001_1
                  END IF
                  LET g_ad_domain = lc_gzxl002 #ex:DC=digiwin,DC=biz or DC=tiptop 
                  #LET g_account_domain = lc_gzxl002
                  
               #當輸入 hjwang@digiwin.biz  
               WHEN ls_gzxd001.getIndexOf("@",1)
                  LET lc_gzxl001 = ls_gzxd001.subString(ls_gzxd001.getIndexOf("@",1)+1,ls_gzxd001.getLength())
                  #組識別名 DC=xxx,DC=xxx ..... 
                  LET g_ad_domain = azzi010_str_token(lc_gzxl001)
                  #取ad server ip
                  CALL azzi010_get_adserverip(lc_gzxl001) RETURNING li_ok,lc_gzxl001_1,lc_gzxl002,g_ad_addr 
                  
               OTHERWISE
                  LET lc_gzxl001 = ls_gzxd001
                  #組識別名 DC=xxx,DC=xxx .....
                  LET g_ad_domain = azzi010_str_token(lc_gzxl001) 
                  #取ad server ip
                  #lc_gzxl002 = DC=digiwin,DC=biz
                  #g_ad_addr = 10.20.96.6:389
                  CALL azzi010_get_adserverip(lc_gzxl001) RETURNING li_ok,lc_gzxl001_1,lc_gzxl002,g_ad_addr 
                  #LET g_account_domain = lc_gzxl002
                  
            END CASE  
 
         ELSE #domain is not null
            #域名有設  digiwin.biz
            #g_ad_addr = 10.20.96.6:389
            #取ad server ip 
            CALL azzi010_get_adserverip(g_gzxd_m.domain) RETURNING li_ok,lc_gzxl001_1,g_account_domain,g_ad_addr
            #組識別名 DC=xxx,DC=xxx .....
            LET g_ad_domain = azzi010_str_token(g_gzxd_m.domain)
            LET g_gzxd_m.gzxd001 = g_gzxd_m.gzxd001,"@",lc_gzxl001_1 #hjwang@digiwin.biz
            #@digiwin.biz
            #LET g_account_domain = "@", g_gzxd_m.domain CLIPPED
         END IF
         
         IF NOT li_ok THEN 
            LET g_gzxd_m.gzxd001 = lc_gzxd001_t  
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00374"
            LET g_errparam.extend = lc_gzxl001
            LET g_errparam.popup = TRUE
            CALL cl_err()
                  
            LET li_ok = -1 
            RETURN li_ok,lc_gzxd001
         END IF  
         
         IF g_ad_server = "Y" THEN
               CALL azzi010_login_javaad() RETURNING ls_err_str #透過AD SERVER驗證帳號、密碼
               IF cl_null(ls_err_str) THEN 
                  LET li_ok = 1  
               ELSE 
                  LET g_gzxd_m.gzxd001 = lc_gzxd001_t 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = ls_err_str
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET li_ok = -2 
               END IF
         END IF

      WHEN gc_status = "M"   #Mail帳號檢核
         LET ld_login_time = cl_get_current()
         #DISPLAY "ld_login_time:",ld_login_time
         SELECT COUNT(*) INTO li_cnt  FROM gzxf_t
           WHERE gzxfent = g_enterprise 
             AND gzxf001 = g_gzxd_m.gzxd001
             AND gzxf004 = g_gzxd_m.gzxd002
             AND gzxf002 <=  ld_login_time 
             AND gzxf003 >=  ld_login_time
         IF li_cnt > 0 THEN 
            LET li_ok = 1
         ELSE 
            LET li_ok = 0    
         END IF

      WHEN gc_status = "Q"   #QQ
            
   END CASE 

   RETURN li_ok,lc_gzxd001
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi010_set_visible(li_boolean)
################################################################################
PRIVATE FUNCTION azzi010_set_visible()
   DEFINE lc_field    STRING 
   DEFINE lc_status   LIKE type_t.chr1 
   DEFINE ls_value    STRING 

   CASE 
      WHEN gc_status = "T"   #傳統TIPTOP帳號密碼登入
         CALL cl_set_comp_visible("domain",FALSE)
         CALL cl_set_comp_visible("send_mail",FALSE)         
         LET ls_value = cl_getmsg("azz-00103",g_lang) 
         CALL cl_set_comp_att_text("lbl_gzxd001",ls_value) 

      WHEN gc_status = "A"   #MS Windows AD/LDAP方式登入
         CALL cl_set_comp_visible("domain",TRUE)
         CALL cl_set_comp_visible("send_mail",FALSE)
         LET ls_value = cl_getmsg("azz-00103",g_lang)
         CALL cl_set_comp_att_text("lbl_gzxd001",ls_value)

      WHEN gc_status = "M"   #Mail check檢核方式登入
         CALL cl_set_comp_visible("domain",FALSE)
         CALL cl_set_comp_visible("send_mail",TRUE) 
         LET ls_value = cl_getmsg("azz-00103",g_lang) 
         CALL cl_set_comp_att_text("lbl_gzxd001",ls_value)

      WHEN gc_status = "Q"   #QQ帳號登入
         CALL cl_set_comp_visible("domain",FALSE)
         CALL cl_set_comp_visible("send_mail",FALSE)
         LET ls_value = cl_getmsg("azz-00102",g_lang)
         CALL cl_set_comp_att_text("lbl_gzxd001",ls_value) 
   END CASE 
   
END FUNCTION
################################################################################
# Descriptions...: #將使用者輸入之帳號、密碼透過java程式送到AD SERVER驗證
#                  傳回結果:(1)0:失敗. (2)1:成功. (3)還有其他錯誤代碼
# Memo...........:
# Usage..........: CALL azzi010_javaad()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi010_login_javaad()
   DEFINE l_gzze001  LIKE gzze_t.gzze001
   DEFINE l_cmd      STRING
   DEFINE lch_cmd    base.Channel
   DEFINE l_status   STRING
   DEFINE l_str      STRING
   DEFINE l_xml      STRING
   DEFINE l_err_str  STRING
   DEFINE l_ch       base.Channel,
          l_xmlFile  STRING,
          l_doc      om.DomDocument,
          l_root     om.DomNode,
          l_list     om.NodeList,
          l_node     om.DomNode
   DEFINE l_ip       STRING
   DEFINE l_port     STRING
   DEFINE l_domain   STRING
   DEFINE l_file     STRING
   DEFINE channel    base.Channel
   DEFINE l_desc     STRING
   DEFINE l_err_code STRING

   #ip 
   LET l_ip = g_ad_addr  #ip+port
   LET l_domain = g_gzxd_m.domain
   IF cl_null(g_gzxd_m.domain) THEN 
      LET l_domain = g_ad_domain
   END IF

   #抓取AD server port
   LET l_port = l_ip.subString(l_ip.getIndexOf(':', 1) + 1, l_ip.getLength())
   #抓取AD server IP
   LET l_ip = l_ip.subString(1, l_ip.getIndexOf(':', 1) - 1)
   IF cl_null(l_ip) OR cl_null(l_port) OR cl_null(l_domain) THEN
      #LET l_err_str = 'seiichi'
      LET l_err_code = 'azz-00375' #azz-00374 AD主機註冊作業(azzi919) 沒有設定，請確認
   ELSE
     
      #階層式AD Server驗證
      LET l_xmlFile = fgl_getenv("TEMPDIR"), "/",
                      "ldap_login_", FGL_GETPID() USING '<<<<<<<<<<', ".xml"

      #LET l_cmd = "p_ldap_login '", g_acct001, "' '", g_acct006, "' '", l_xmlFile, "'"

      #執行呼叫ldap驗證程序
      #不使用 cl_cmdrun_wait 改用 呼叫 sub 方式呼叫
      #CALL cl_cmdrun_wait(l_cmd)
      CALL s_azzi010(g_gzxd_m.gzxd001, g_gzxd_m.gzxd002, l_xmlFile)

      #CALL cl_ldap_login(g_gzxd_m.gzxd001, g_gzxd_m.gzxd002, l_xmlFile)

      IF NOT cl_null(l_xmlFile) THEN 
         # 讀取 XML 文件
         LET l_doc = om.DomDocument.createFromXmlFile(l_xmlFile)
         RUN "rm -f " || l_xmlFile || " >/dev/null 2>&1"

         INITIALIZE l_root TO NULL
         IF l_doc IS NULL THEN
            LET l_err_str = cl_getmsg('azz-00105', g_lang)     #讀取XML檔錯誤
         ELSE
            LET l_root = l_doc.getDocumentElement()
            LET l_list = l_root.selectByTagName("status")
            IF l_list.getLength() > 0 THEN
               LET l_node = l_list.item(1)
               LET l_node = l_node.getFirstChild()
               IF l_node IS NOT NULL THEN 
                  LET l_status = l_node.getattribute("@chars")
               END IF 
            END IF
            
            LET l_list = l_root.selectByTagName("description")
            IF l_list.getLength() > 0 THEN
               LET l_node = l_list.item(1)
               LET l_node = l_node.getFirstChild()
               IF l_node IS NOT NULL THEN 
                  LET l_desc = l_node.getattribute("@chars")
               END IF 
            END IF

            #l_status驗證回傳結果:(1)0:失敗. (2)1:成功. (3)還有其他錯誤代碼
            #帳號驗證成功
            IF l_status = '1' THEN
               RETURN ''
            END IF

            CASE l_status
                 WHEN '0'
                      LET l_err_code = 'azz-00106'     #AD帳號驗證失敗
                 WHEN '2'
                      LET l_err_code = 'azz-00107'     #呼叫java程式參數不足或過多
                 WHEN '3'
                      LET l_err_code = 'azz-00108'     #AD Server Connection refused
                 WHEN '525'
                      LET l_err_code = 'azz-00109'     #user not found
                 WHEN '52e'
                      LET l_err_code = 'azz-00110'     #nvalid credentials(密碼錯誤)
                 WHEN '530'
                      LET l_err_code = 'azz-00111'     #not permitted to logon at this time
                 WHEN '532'
                      LET l_err_code = 'azz-00112'     #password expired
                 WHEN '533'
                      LET l_err_code = 'azz-00113'     #account disabled
                 WHEN '701'
                      LET l_err_code = 'azz-00114'     #account expired
                 WHEN '773'
                      LET l_err_code = 'azz-00115'     #user must reset password
                 # 下面訊息還沒設定 azzi920
                 WHEN '4'
                      LET l_err_code = 'azz-00116'     #AD Server port指定錯誤
                 WHEN '5'
                      LET l_err_code = 'azz-00117'     #LDAP 管理帳號DN未輸入
                 WHEN '6'
                      LET l_err_code = 'azz-00118'     #LDAP Base DN未指定
                 WHEN '7'
                      LET l_err_code = 'azz-00119'     #java取得SSL Class失敗.
                 WHEN '8'
                      LET l_err_code = 'azz-00120'     #LDAP 管理者帳號DN連接失敗
                 WHEN '9'
                      LET l_err_code = 'azz-00121'     #LDAP管理者帳號輸入錯誤
                 WHEN '10'
                      LET l_err_code = 'azz-00122'     #LDAP管理者密碼輸入錯誤
                 WHEN '11'
                      LET l_err_code = 'azz-00123'     #LDAP 搜尋使用者帳號時發生錯誤
                 WHEN '12'
                      LET l_err_code = 'azz-00124'     #儲存AD Server管理者密碼的acct_t帳號不存在
                 WHEN '13'
                      LET l_err_code = 'azz-00125'     #使用者帳號或密碼未傳遞.
                 OTHERWISE
                     LET l_err_code = l_status
                     LET l_list = l_root.selectByTagName("status")
                     IF l_list.getLength() > 0 THEN
                        LET l_node = l_list.item(1)
                        LET l_err_str = l_node.getattribute("description")
                     END IF
            END CASE

            IF cl_null(l_err_str) THEN
               LET l_err_str = cl_getmsg(l_gzze001, g_lang)
            END IF
            
            IF cl_null(l_err_str) THEN
               #LET l_err_str = "azzi010 no error message description.\n(appi900:", l_gzze001, "; lang: ", g_lang, "; User account: ", g_acct001, ")"
            END IF

            IF l_status = "525" THEN
               LET l_err_str = l_err_str, " ", l_desc.substring(l_desc.getindexof("filter:", 1), l_desc.getindexof("))", 1) + 1)
            END IF
         END IF
      END IF
   END IF

   #理論上執行到這裡應該要有err msg,如果沒有則是可能FUNCTION有什麼地方出錯
   IF cl_null(l_err_str) THEN
      LET l_err_str = 'web_javaad run failed!'
      DISPLAY l_err_str
   END IF

   RETURN l_err_code
END FUNCTION

PRIVATE FUNCTION azzi010_browser_fill(p_wc,ps_page_action)
   {<Local define>}
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   {</Local define>}

   CLEAR FORM
   INITIALIZE g_gzxd_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "gzxd001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF

   LET g_sql = " SELECT COUNT(*) FROM gzxd_t ",
               " WHERE gzxdent = '" ||g_enterprise|| "' AND ",
               p_wc CLIPPED

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre

   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count

   LET g_wc = p_wc

   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF

   CASE ps_page_action

      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE

      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump
            LET g_errparam.popup = FALSE
            CALL cl_err()

         END IF

      OTHERWISE
   END CASE

   LET l_sql_rank = "SELECT gzxdstus,gzxd001,RANK() OVER(ORDER BY gzxd001 ",

                    g_order,
                    ") AS RANK ",
                    " FROM gzxd_t ",
                    "  ",
                    "  ",
                    " WHERE gzxdent = '" ||g_enterprise|| "' AND ", g_wc

   #定義翻頁CURSOR
   LET g_sql= " SELECT gzxdstus,gzxd001 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) ,
              "  ORDER BY ",l_searchcol," ",g_order

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzxd001   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic)
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   #該樣板不需此段落LET g_header_cnt = g_browser.getLength()
   LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   #該樣板不需此段落LET g_current_cnt = g_rec_b
   LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0

   FREE browse_pre
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Usage..........: CALL s_aooi150_ins (传入参数)
################################################################################
PRIVATE FUNCTION azzi010_send_mail()
   DEFINE lc_channel  base.Channel
   DEFINE lc_gzxa004   LIKE gzxa_t.gzxa004
   DEFINE ls_file      STRING
   DEFINE ls_tmp       STRING
   DEFINE ls_text      STRING
   DEFINE li_max       LIKE type_t.num5
   DEFINE li_random1   LIKE type_t.num5
   DEFINE li_random2   LIKE type_t.num5
   DEFINE lc_pw        LIKE gzxf_t.gzxf004 
   DEFINE l_gzxf RECORD 
            gzxf002 DATETIME YEAR TO SECOND,
            gzxf003 DATETIME YEAR TO SECOND,
            gzxf004 LIKE gzxf_t.gzxf004
                     END RECORD 
   DEFINE l_interval_time   INTERVAL MINUTE TO SECOND
   DEFINE li_cnt  LIKE type_t.num5

   INITIALIZE g_xml.* TO NULL
   INITIALIZE l_gzxf.* TO NULL

   LET l_interval_time = 10 UNITS MINUTE  #轉成分鐘

   #初始亂數 
   CALL util.Math.srand()

   LET lc_pw = util.Math.rand( 32767 ) USING "<<<<<", util.Math.rand( 32767 ) USING "<<<<<"

   #寫入臨時密碼紀錄表
   LET l_gzxf.gzxf002 = cl_get_current() 
   LET l_gzxf.gzxf003 = cl_get_current() + l_interval_time
   LET l_gzxf.gzxf004 = lc_pw

   SELECT COUNT(*) INTO li_cnt
     FROM gzxf_t 
    WHERE gzxfent = g_enterprise AND gzxf001 = g_gzxd_m.gzxd001

   IF li_cnt > 0 THEN
      DELETE FROM gzxf_t
       WHERE gzxfent = g_enterprise 
         AND gzxf001 = g_gzxd_m.gzxd001
   END IF
    
   INSERT INTO gzxf_t(gzxfent,gzxf001,gzxf002,gzxf003,gzxf004)
     VALUES(g_enterprise,g_gzxd_m.gzxd001,l_gzxf.gzxf002,l_gzxf.gzxf003,l_gzxf.gzxf004) # DISK WRITE
   IF SQLCA.SQLCODE THEN
      display SQLCA.SQLCODE
   ELSE
      COMMIT WORK
   END IF

   #信件暫存檔案路徑
   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),"chkmail_"),FGL_GETPID() USING "<<<<<",".txt"
   IF os.Path.delete(ls_file) THEN END IF

   #信件檔案
   LET lc_channel = base.Channel.create()
   CALL lc_channel.openFile( ls_file CLIPPED, "a" )
   CALL lc_channel.setDelimiter("")
   LET ls_text = "T100 ERP用戶您好,\n您的臨時登入密碼為", lc_pw,"\n密碼於10分鐘內有效\n",
                 "若密碼非為您本人申請,請立即刪除本信,並通知資管人員\n",
                 "謝謝您的協助\n"
   CALL lc_channel.write(ls_text)
   CALL lc_channel.close()
   #信件主旨
   LET g_xml.subject = "寄送密碼信函"
   #信件本文
   LET g_xml.body = ls_file
   #寄信人
   LET g_xml.sender = "top18@digiwin.biz:TOP18_Admin"
   #郵件重要等級
   LET g_xml.priority = "1"
   #收件者
   IF g_gzxd_m.gzxd001 IS NOT NULL THEN
      SELECT gzxa004 INTO lc_gzxa004
        FROM gzxa_t
       WHERE gzxaent = g_enterprise
         AND gzxa001 = g_gzxd_m.gzxd001
         AND gzxastus = "Y"
      IF NOT SQLCA.SQLCODE AND lc_gzxa004 IS NOT NULL THEN
         LET g_xml.recipient = lc_gzxa004

         #寄發mail
         CALL cl_jmail() RETURNING ls_tmp
         #IF ls_tmp.getIndexOf("successfully",1) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "!"
            LET g_errparam.extend = "密碼信件已寄出,請依照信件密碼登入!"
            LET g_errparam.popup = TRUE
            CALL cl_err()

         #ELSE  
         #   CALL cl_err_msg('', "std-00008", ls_tmp CLIPPED, 1)
         #END IF 
         IF os.Path.delete( ls_file CLIPPED) THEN END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "!"
         LET g_errparam.extend = "資料不足,無法寄發"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "!"
         LET g_errparam.extend = "資料不足,無法寄發"
         LET g_errparam.popup = TRUE
         CALL cl_err()

   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi010_get_adserverip(lc_gzxl001)
#                  RETURNING 回传参数
# Input parameter: lc_gzxl001 短 domain 
# Return code....: li_chk,lc_gzxl002,lc_gzxl003
# Date & Author..: 2016/01/15 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi010_get_adserverip(lc_gzxl001)
   DEFINE lc_gzxl001   LIKE gzxl_t.gzxl001
   DEFINE lc_gzxl001_1 LIKE gzxl_t.gzxl001
   DEFINE lc_gzxl002   LIKE gzxl_t.gzxl002
   DEFINE lc_gzxl003   LIKE gzxl_t.gzxl003
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE li_type      LIKE type_t.num5
   DEFINE li_chk       LIKE type_t.num5

   LET li_chk = FALSE 
   
   SELECT COUNT(*) INTO li_cnt FROM gzxl_t 
    WHERE gzxl001 = lc_gzxl001

   IF li_cnt > 0 THEN
      LET li_chk = TRUE
   END IF


   IF li_chk THEN 
      #取得 AD server ip+port
      SELECT gzxl001,gzxl002,gzxl003 INTO lc_gzxl001_1,lc_gzxl002,lc_gzxl003 FROM gzxl_t 
       WHERE gzxl001 = lc_gzxl001
   END IF 

   RETURN li_chk,lc_gzxl001_1,lc_gzxl002,lc_gzxl003 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi010_str_token(ps_domain)
#                  RETURNING 回传参数
# Input parameter: ps_domain 域名
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi010_str_token(ps_domain)
      DEFINE ps_domain STRING 
   DEFINE tok       base.StringTokenizer
   DEFINE li_pos    LIKE type_t.num5
   DEFINE l_token   base.StringTokenizer
   DEFINE ls_tmp    STRING 
   DEFINE ls_domain STRING 


   LET tok = base.StringTokenizer.create(ps_domain,".")

   #組網域 DC=xxx,DC=xxx ..... 
   WHILE tok.hasMoreTokens()
      LET ls_tmp = tok.nextToken()
      LET ls_domain = ls_domain,"DC=",ls_tmp,","

   END WHILE 
   LET ls_domain = ls_domain.subString(1,ls_domain.getLength()-1) 

   RETURN ls_domain
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi010_get_adserverip2(lc_gzxl001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi010_get_adserverip2(lc_gzxl001)
      DEFINE lc_gzxl001   LIKE gzxl_t.gzxl001
   DEFINE lc_gzxl001_1 LIKE gzxl_t.gzxl001
   DEFINE lc_gzxl002   LIKE gzxl_t.gzxl002
   DEFINE lc_gzxl003   LIKE gzxl_t.gzxl003
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE li_type      LIKE type_t.num5
   DEFINE li_chk       LIKE type_t.num5
   DEFINE ls_sql       STRING 
   
   LET li_chk = FALSE 
   LET ls_sql = "SELECT COUNT(*) FROM gzxl_t ",
                " WHERE gzxl001 LIKE '",lc_gzxl001,"%'"

   PREPARE azzi010_adserver_pre FROM ls_sql

   EXECUTE azzi010_adserver_pre INTO li_cnt

   FREE azzi010_adserver_pre
   IF li_cnt > 0 THEN
      LET li_chk = TRUE
   END IF

   IF li_chk THEN 
      #取得 AD server ip+port
      LET ls_sql = "SELECT gzxl001,gzxl002,gzxl003 FROM gzxl_t ",
                   " WHERE gzxl001 LIKE '",lc_gzxl001,"%'"
      PREPARE azzi010_adserver_pre2 FROM ls_sql 
      EXECUTE azzi010_adserver_pre2 INTO lc_gzxl001_1,lc_gzxl002,lc_gzxl003

      FREE azzi010_adserver_pre2 
   END IF 

   RETURN li_chk,lc_gzxl001_1,lc_gzxl002,lc_gzxl003

END FUNCTION

#end add-point
 
{</section>}
 
