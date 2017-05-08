#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(1900-01-01 00:00:00), PR版次:0004(2016-06-06 11:39:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000065
#+ Filename...: awsp901
#+ Description: JAVA API 中介程式
#+ Creator....: 00544(2014-05-23 09:07:11)
#+ Modifier...: 00000 -SD/PR- 07375
 
{</section>}
 
{<section id="awsp901.global" >}
#Memos
 
IMPORT os
IMPORT xml
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_ws.inc"
 
#add-point:free_style模組變數(Module Variable)

#end add-point
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
{</section>}
 
{<section id="awsp901.main" >}
#+ 作業開始
MAIN
   #add-point:main段define

   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
  
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("aws","")
   CALL cl_db_connect("ds",FALSE)   
   
   CALL awsp900_01_init()  #初始變數
 
   #add-point:作業初始化
   CALL cl_log_service_start ("J", "")   #JAVA_API_start
   #end add-point
  

   #中介程式主要處理段
   CALL awsp901_process()

   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="awsp901.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION awsp901_process()
   DEFINE l_request_str        STRING
   DEFINE l_output_str         STRING
   DEFINE l_master             util.JSONObject
   DEFINE l_param              util.JSONArray
   DEFINE l_argv01             STRING
   DEFINE l_argv02             STRING
   DEFINE l_start              DATETIME HOUR TO FRACTION(3),
          l_end                DATETIME HOUR TO FRACTION(3),
          l_interval           INTERVAL SECOND TO FRACTION(3)

   #LET l_master = util.JSONObject.parse(ARG_VAL(1)) #parse json
   #LET l_param = l_master.get("param")
   #LET l_argv01 = l_param.get(1) 
   #LET l_argv02 = l_param.get(2)
   #add-point:process段define
   #輸入檔案路徑
   LET g_request_file_path = ARG_VAL(1) #g_argv[1]
   DISPLAY "request_file_path = ",g_request_file_path

   #輸出檔案路徑
   LET g_response_file_path = ARG_VAL(2) #g_argv[2]
   DISPLAY "response_file_path = ",g_response_file_path
   

   
   #呼叫 invokeSrv 程式
   LET l_start = CURRENT HOUR TO FRACTION(3)
   DISPLAY "awsp900_02_invokeSrv start:", l_start
   CALL awsp900_02_invokeSrv()
   LET l_end = CURRENT HOUR TO FRACTION(3)
   DISPLAY "awsp900_02_invokeSrv end:", l_end
   LET l_interval = l_end - l_start
   DISPLAY "invokSrv process:", l_interval
   
   #end add-point

   
END FUNCTION

#end add-point
 
{</section>}
 
