#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp001.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(1900-01-01 00:00:00), PR版次:0004(2016-05-04 16:17:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000133
#+ Filename...: awsp001
#+ Description: BPM開啟附件作業
#+ Creator....: 00544(2014-05-20 10:59:22)
#+ Modifier...: 00000 -SD/PR- 07375
 
{</section>}
 
{<section id="awsp001.global" >}
#Memos
 
IMPORT os
IMPORT xml
IMPORT FGL lib_cl_dlg
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
 
{<section id="awsp001.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE l_key         STRING
   DEFINE l_loaa        RECORD
            loaa001       LIKE loaa_t.loaa001,
            loaa006       LIKE loaa_t.loaa006,
            loaa007       LIKE loaa_t.loaa007
            END RECORD  

   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化
 
        
   #add-point:SQL_define
   MENU
   
   BEFORE MENU
      CALL cl_chksec_data() RETURNING l_loaa.*   
   
      IF cl_null(l_loaa.loaa001) THEN    #找不到附件
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aws-00012'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()    
         EXIT MENU         
      ELSE   
         #IF NOT cl_doc_open_file(l_loaa.loaa001,l_loaa.loaa006,l_loaa.loaa007) THEN
         IF NOT cl_doc_open_attach(l_loaa.loaa001,l_loaa.loaa006,l_loaa.loaa007,'1') THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aws-00012'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT MENU            
         END IF
      END IF
      
   ON ACTION close
      EXIT MENU
   
   ON IDLE 5
      EXIT MENU
      
   END MENU
   #end add-point
  
   #add-point:Service Call

   #end add-point
  
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="awsp001.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
