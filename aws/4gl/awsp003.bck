#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp003.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000000
#+ 
#+ Filename...: awsp003
#+ Description: MCloud訊息推播
#+ Creator....: 04182(2015-10-23 10:01:58)
#+ Modifier...: 00000() -SD/PR- 04182
 
{</section>}
 
{<section id="awsp003.global" >}
#應用 p01 樣板自動產生(Version:10)

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目
IMPORT xml
IMPORT com
IMPORT security
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
 
 
   #add-point:自定背景執行須傳遞的參數(Module Variable)

   #end add-point
 
 
#模組變數(Module Variables)
 
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="awsp003.main" >}
MAIN
   DEFINE ls_js    STRING
 
   #add-point:main段define 

   #end add-point 
   #add-point:main段define (客製用)

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("aws","")
   CALL cl_tool_init()
   CONNECT TO g_dbs
   
   #設定時區
   DISPLAY "time_zone:" , cl_time_trans_by_tz("system_time") 
   
   
 

   LET ls_js = g_argv[1]
   CALL awsp900_05_push_msg(ls_js)
   
   CLOSE WINDOW screen

 

 
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp003.init" >}

 

 

 
{</section>}
 
{<section id="awsp003.ui_dialog" >}

 

 

 

 

 

 

 

 

 

 

 

 

 
 
{</section>}
 
{<section id="awsp003.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
 

 

 

 
{</section>}
 
{<section id="awsp003.process" >}

 

 

 

 

 

 

 
{</section>}
 
{<section id="awsp003.get_buffer" >}

 
{</section>}
 
{<section id="awsp003.msgcentre_notify" >}

 
{</section>}
 
{<section id="awsp003.other_function" >}
#add-point:自定義元件(Function)

#end add-point
 
{</section>}
 
