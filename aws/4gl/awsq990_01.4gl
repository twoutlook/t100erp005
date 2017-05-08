#該程式未解開Section, 採用最新樣板產出!
{<section id="awsq990_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-08-11 10:56:25), PR版次:0001(2016-12-05 10:28:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: awsq990_01
#+ Description: 訊息內容開窗
#+ Creator....: 08163(2016-08-11 10:52:37)
#+ Modifier...: 08163 -SD/PR- 08163
 
{</section>}
 
{<section id="awsq990_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160810-00029  by Hank Wu
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE type type_g_wsfa_m        RECORD
       wsfa003 LIKE wsfa_t.wsfa003,
       wsfa002 LIKE wsfa_t.wsfa002,
       wsfa001 LIKE wsfa_t.wsfa001,
       wsfa007 STRING,
       wsfa008 STRING,
       wsfa004 LIKE wsfa_t.wsfa004
       END RECORD
DEFINE g_wsfa_m            type_g_wsfa_m
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="awsq990_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION awsq990_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   l_wsfa001,
   l_wsfa003,
   l_wsfa004
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE l_wsfa007       LIKE wsfa_t.wsfa007
   DEFINE l_wsfa008       LIKE wsfa_t.wsfa008
   DEFINE l_wsfa001       LIKE wsfa_t.wsfa001
   DEFINE l_wsfa001_01    LIKE wsfa_t.wsfa001
   DEFINE l_wsfa003       LIKE wsfa_t.wsfa003
   DEFINE l_wsfa004       LIKE wsfa_t.wsfa004
   DEFINE l_result        LIKE wsfa_t.wsfa006
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_awsq990_01 WITH FORM cl_ap_formpath("aws","awsq990_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON wsfa007,wsfa008,wsfa001,wsfa002,wsfa003,wsfa004 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            SELECT wsfa007,wsfa008,wsfa001
               INTO l_wsfa007,l_wsfa008,l_wsfa001_01
            FROM wsfa_t
            WHERE wsfa001 = l_wsfa001 OR wsfa003 = l_wsfa003 OR wsfa004 = l_wsfa004 --OR l_result = wsfa006
            --LET g_wsfa_m.wsfa007 = l_wsfa007
            --LET g_wsfa_m.wsfa008 = l_wsfa008
            CALL awsq990_01_readRequestFile(l_wsfa007) RETURNING g_wsfa_m.wsfa007
            CALL awsq990_01_readResponseFile(l_wsfa008) RETURNING g_wsfa_m.wsfa008
            DISPLAY BY NAME  g_wsfa_m.wsfa007,g_wsfa_m.wsfa008           
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      
      #end add-point
      
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
 
   #add-point:畫面關閉前 name="construct.before_close"
   
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_awsq990_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="awsq990_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="awsq990_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_01_readRequestFile(l_request07)
   DEFINE l_return_str STRING
   DEFINE l_request07  LIKE wsfa_t.wsfa007
   DEFINE cmd STRING
   DEFINE cmd2 STRING
   DEFINE l_object TEXT
   DEFINE l_cmd STRING
   
   LET cmd = "/ut/t10dev/tmp/ttsrv_request_17:49:56.610_14120.xml"
   LET cmd2 = "/ut/t10dev/tmp/ttsrv_request_17:49:56.610_14120.xml1"
   DISPLAY "cmd = ",cmd
   
   LET l_cmd = "iconv -f UNICODE -t UTF-8 ",cmd CLIPPED, " > ",cmd2 CLIPPED
   RUN l_cmd
   
   IF os.Path.size(cmd2.trim()) > 0 THEN
      LOCATE l_object IN FILE
      CALL l_object.readFile(cmd2)
      LET l_return_str = l_object
      DISPLAY 'test1:',l_return_str
      FREE l_object
   END IF
#   IF cl_null(l_return_str) THEN
#      LET l_cmd = "iconv -f UNICODE -t UTF-8 ",cmd CLIPPED, " > ",cmd2 CLIPPED
#      RUN l_cmd
#      LOCATE l_object IN FILE
#      CALL l_object.readFile(cmd2)
#      LET l_return_str = l_object
#      DISPLAY 'test2:',l_return_str
#      FREE l_object
#   END IF      
   LET l_cmd = "rm ",cmd2
   RUN l_cmd
   RETURN l_return_str
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_01_readResponseFile(l_response08)
   DEFINE l_return_str STRING
   DEFINE l_response08  LIKE wsfa_t.wsfa008
   DEFINE cmd STRING
   DEFINE cmd2 STRING
   DEFINE l_object TEXT
   DEFINE l_cmd STRING
   DEFINE ch base.Channel 
   DEFINE s STRING
   
   LET ch = base.Channel.create()
   LET cmd = "/ut/t10dev/tmp/ttsrv_response_17:49:56.610_14120.xml"
   LET cmd2 = "/ut/t10dev/tmp/ttsrv_response_17:49:56.610_14120.xml1"
   --LET cmd = l_response08
   --LET cmd2 = l_response08,"1"
   DISPLAY "cmd = ",cmd
   
   LET l_cmd = "iconv -f us-ascii -t unicode ",cmd CLIPPED, " -o ",cmd2 CLIPPED ,";iconv -f utf-16le -t UTF-8 ",cmd2 CLIPPED, " -o ",cmd2 CLIPPED
   --LET l_cmd = "iconv -f UNICODE -t UTF-8 ",cmd CLIPPED, " > ",cmd2 CLIPPED
   RUN l_cmd

   IF os.Path.size(cmd2.trim()) > 0 THEN
      LOCATE l_object IN FILE
      CALL l_object.readFile(cmd2)
      LET l_return_str = l_object
      DISPLAY 'test1:',l_return_str
      FREE l_object
   END IF
#   IF cl_null(l_return_str) THEN
#      LET l_cmd = "iconv -f UNICODE -t UTF-8 ",cmd CLIPPED, " > ",cmd2 CLIPPED
#      RUN l_cmd
#      LOCATE l_object IN FILE
#      CALL l_object.readFile(cmd2)
#      LET l_return_str = l_object
#      DISPLAY 'test2:',l_return_str
#      FREE l_object
#   END IF      
   LET l_cmd = "rm ",cmd2
   RUN l_cmd
   RETURN l_return_str
   
END FUNCTION

 
{</section>}
 
