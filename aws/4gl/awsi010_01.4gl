#該程式未解開Section, 採用最新樣板產出!
{<section id="awsi010_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-08-22 15:53:19), PR版次:0001(2014-08-22 16:55:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: awsi010_01
#+ Description: 整批修改
#+ Creator....: 00544(2014-08-21 14:23:31)
#+ Modifier...: 00544 -SD/PR- 00544
 
{</section>}
 
{<section id="awsi010_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="awsi010_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="awsi010_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
 TYPE type_wsae_option RECORD
         ooef200                     LIKE ooef_t.ooef200,
         ooef200_desc                LIKE type_t.chr500,
         rdg_1                       LIKE type_t.chr1,
         rdg_2                       LIKE type_t.chr1,
         rdg_3                       LIKE type_t.chr1         
       END RECORD
DEFINE g_wsae_option   type_wsae_option       
#end add-point
 
{</section>}
 
{<section id="awsi010_01.other_dialog" >}

 
{</section>}
 
{<section id="awsi010_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsi010_01()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsi010_01()
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT

   WHENEVER ERROR CALL cl_err_msg_log 
   
   OPEN WINDOW w_awsi010_01 WITH FORM cl_ap_formpath("aws", "awsi010_01")
    
   CALL cl_ui_init()
   
   CALL awsi010_01_dialog()
   
   CLOSE WINDOW w_awsi010_01
   
     
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsi010_01_dialog()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsi010_01_dialog()
   DEFINE l_success   BOOLEAN
   
   INITIALIZE g_qryparam.return1 TO NULL
   INITIALIZE g_qryparam.return2 TO NULL
   INITIALIZE g_qryparam.return3 TO NULL
   INITIALIZE g_qryparam.return4 TO NULL

   LET g_wsae_option.ooef200 = ""
   
   #預設不異動
   LET g_wsae_option.rdg_1 = "3" 
   LET g_wsae_option.rdg_2 = "3"
   LET g_wsae_option.rdg_3 = "3"
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_wsae_option.ooef200 , g_wsae_option.rdg_1 , g_wsae_option.rdg_2 , g_wsae_option.rdg_3
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD ooef200
            LET l_success = TRUE
            IF cl_null(g_wsae_option.ooef200) THEN
               LET l_success = FALSE               
            ELSE
               LET g_wsae_option.ooef200_desc = awsi010_ooef200_desc(g_wsae_option.ooef200)  
               IF cl_null(g_wsae_option.ooef200_desc) THEN
                  LET l_success = FALSE
               ELSE
                  DISPLAY BY NAME g_wsae_option.ooef200_desc               
               END IF
            END IF
            
            IF l_success = FALSE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'aws-00021'
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               
               NEXT FIELD ooef200
            END IF  
            
         ON ACTION controlp INFIELD ooef200            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooei001()                       #呼叫開窗
            
            LET g_wsae_option.ooef200 = g_qryparam.return1 
            LET g_wsae_option.ooef200_desc = awsi010_ooef200_desc(g_wsae_option.ooef200)  
            DISPLAY BY NAME g_wsae_option.ooef200 ,g_wsae_option.ooef200_desc 
            
         AFTER INPUT
            LET  g_qryparam.return1 = g_wsae_option.rdg_1         
            LET  g_qryparam.return2 = g_wsae_option.rdg_2
            LET  g_qryparam.return3 = g_wsae_option.rdg_3
            LET  g_qryparam.return4 = g_wsae_option.ooef200 
            
      END INPUT
            
      ON ACTION accept  
         ACCEPT DIALOG
         
      ON ACTION cancel     
         LET  g_qryparam.return1 = ""         
         LET  g_qryparam.return2 = ""         
         LET  g_qryparam.return3 = ""         
         LET  g_qryparam.return4 = ""
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
   END DIALOG

END FUNCTION

 
{</section>}
 
