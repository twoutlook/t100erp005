#該程式已解開Section, 不再透過樣板產出!
{<section id="apsp502.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(1900-01-01 00:00:00), PR版次:0001(2015-12-18 17:43:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: apsp502
#+ Description: 進階APS執行作業
#+ Creator....: 03079(2015-12-15 16:01:47)
#+ Modifier...: 00000 -SD/PR- 03079
 
{</section>}
 
{<section id="apsp502.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT com
IMPORT xml
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

DEFINE g_aps RECORD
                command_id     STRING,     #指令 
                enterprise     STRING,     #企業編號 
                site           STRING,     #營運據點 
                aps_version    STRING,     #APS版本 
                datetime       STRING,     #執行日期時間  
                dp_ip          STRING,     #TIPTOP資料庫ip 
                db_account     STRING,     #TIPTOP資料庫帳號 
                db_password    STRING      #TIPTOP資料庫密碼  
             END RECORD

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="apsp502.main" >}
MAIN
   #add-point:main段define (客製用)

   #end add-point 
   DEFINE ls_js    STRING
   #add-point:main段define 
   DEFINE l_command_id  STRING     #指令  
   DEFINE l_aps_version STRING     #aps版本  
   DEFINE l_datetime    STRING     #執行日期  
   DEFINE l_account     STRING     #帳號  
   DEFINE l_password    STRING     #密碼  
   DEFINE l_success     LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   LET l_command_id = g_argv[1]
   LET l_aps_version = g_argv[2]
   LET l_datetime = g_argv[3]
   LET l_account = g_argv[4]
   LET l_password = g_argv[5]

   CALL s_apsp502_insert_command(l_command_id,l_aps_version,l_datetime,l_account,l_password)
        RETURNING l_success
   #end add-point
 

 

 

 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp502.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp502_init()
 
   #add-point:init段define (客製用)

   #end add-point
   #add-point:ui_dialog段define 

   #end add-point
 
   #add-point:畫面資料初始化

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp502.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
{<section id="apsp502.ui_dialog" >}

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="apsp502.transfer_argv" >}

 

 

 
{</section>}
 
{<section id="apsp502.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp502_process(ls_js)
 
   #add-point:process段define (客製用)

   #end add-point
   DEFINE ls_js         STRING
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define 

   #end add-point
 

 

 

 

 

 
END FUNCTION
 
{</section>}
 
{<section id="apsp502.get_buffer" >}

 

 

 
 
{</section>}
 
{<section id="apsp502.msgcentre_notify" >}

 

 

 
{</section>}
 
