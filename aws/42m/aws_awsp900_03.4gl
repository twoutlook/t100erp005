#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp900_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-07-03 09:50:59), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000087
#+ Filename...: awsp900_03
#+ Description: 
#+ Creator....: 00509(2014-05-21 16:44:51)
#+ Modifier...: 00509 -SD/PR- 00000
 
{</section>}
 
{<section id="awsp900_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT xml
IMPORT com
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_ws.inc"            #TIPTOP Service Gateway 使用的全域變數檔
#end add-point
 
{</section>}
 
{<section id="awsp900_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="awsp900_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="awsp900_03.other_dialog" >}

 
{</section>}
 
{<section id="awsp900_03.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 自動產生呼叫確認的4GL, 不需自行維護
# Memo...........: #此段落由 awsi011 自動產生，不需要手動補上，謝謝!!
# Usage..........: CALL awsp900_03_ws_confirm(p_docno)
#                  RETURNING 回传参数
# Input parameter: p_docno   單據編號
#                :  
# Return code....: r_success 處理狀況
#                :
# Date & Author..: 2014/07/03 By echolinlc
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_03_ws_confirm(p_docno)
DEFINE p_docno      STRING
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
      
   #確認段由 awsi011 產生於 inc/erp/aws/awsp900_03_confirm.4gl
   &include "erp/aws/awsp900_03_confirm.4gl"   

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp900_03_state_change(p_docno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_03_state_change(p_docno)
DEFINE p_docno      STRING
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
      
   #確認段由 awsi011 產生於 inc/erp/aws/awsp900_03_state_change.4gl
   &include "erp/aws/awsp900_03_state_change.4gl"   

   RETURN r_success
   
END FUNCTION

 
{</section>}
 
