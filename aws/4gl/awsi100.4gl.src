#該程式已解開Section, 不再透過樣板產出!
{<section id="awsi100.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000097
#+ 
#+ Filename...: awsi100
#+ Description: 整合產品設定維護作業
#+ Creator....: 07847(2016-04-06 10:18:12)
#+ Modifier...: 07847(2016-04-06 10:18:12) -SD/PR- 07375
{</section>}
 
{<section id="awsi100.global" >}
#應用 i00 樣板自動產生(Version:6)
#add-point:填寫註解說明
#161102-00047#11 By nikoybeat 新增調整權限過濾段落
#161102-00047#15 By nikoybeat 1. 新增測試twiddle功能
#                             2. 測試首頁功能
#                             3. 新增啟用MES/SMES整合設定
#                             4. 新增Portal整合設定頁籤 
#                             5. 寫入權限控制調整
#(元件的資料、目前的資料)
#
#BPM設定(step01)
#BPM_0001：g_wset_t[11].wset002、c_wset_t[11].wset002
#BPM_0002：g_wset_t[12].wset002、c_wset_t[12].wset002
#BPM_0003：g_wset_t[13].wset002、c_wset_t[13].wset002
#BPM_0004：g_wset_t[14].wset002、c_wset_t[14].wset002
#BPM_0005：g_wset_t[15].wset002、c_wset_t[15].wset002
#BPM_0006：g_wset_t[16].wset002
#
#互聯中台設定(step02)
#EAI_0001：g_wset_t[21].wset002、c_wset_t[21].wset002
#EAI_0002：g_wset_t[22].wset002、c_wset_t[22].wset002
#EAI_0003：g_wset_t[23].wset002、c_wset_t[23].wset002
#EAI_0004：g_wset_t[24].wset002、c_wset_t[24].wset002
#EAI_0005：g_wset_t[25].wset002、c_wset_t[25].wset002
#
#M-Cloud設定(step03)
#MCD_0001：g_wset_t[31].wset002、c_wset_t[31].wset002
#MCD_0002：g_wset_t[32].wset002、c_wset_t[32].wset002
#
#PLM整合設定(step04)
#PLM_0001：g_wset_t[41].wset002、c_wset_t[41].wset002
#PLM_0002：g_wset_t[42].wset002、c_wset_t[42].wset002
#
#EC_B2B設定(step05)
#ECB_0001：g_wset_t[51].wset002、c_wset_t[51].wset002
#ECB_0002：g_wset_t[52].wset002、c_wset_t[52].wset002
#ECB_0003：g_wset_t[53].wset002、c_wset_t[53].wset002
#
#MES設定(step06)
#MES_0001：g_wset_t[61].wset002、c_wset_t[61].wset002
#MES_0002：g_wset_t[62].wset002、c_wset_t[62].wset002
#
#Portal整合設定(step07)
#PORTAL_0001：g_wset_t[71].wset002、c_wset_t[71].wset002
#PORTAL_0002：g_wset_t[72].wset002、c_wset_t[72].wset002
#
#JSON檔案
#bpm_code：j_param[1].prod_code   、j_param[11].prod_code
#bpm_addr：j_param[1].prod_address、j_param[11].prod_address
#eai_code：j_param[2].prod_code   、j_param[21].prod_code
#eai_addr：j_param[2].prod_address、j_param[21].prod_address
#mcd_code：j_param[3].prod_code   、j_param[31].prod_code
#mcd_addr：j_param[3].prod_address、j_param[31].prod_address
#plm_code：j_param[4].prod_code   、j_param[41].prod_code
#plm_addr：j_param[4].prod_address、j_param[41].prod_address
#ecb_code：j_param[5].prod_code   、j_param[51].prod_code
#ecb_addr：j_param[5].prod_address、j_param[51].prod_address
#portal_code：j_param[7].prod_code   、j_param[71].prod_code
#portal_addr：j_param[7].prod_address、j_param[71].prod_address
#end add-point
 
IMPORT os
IMPORT util
#161102-00047#15 by nikoybeat add S
IMPORT JAVA com.dsc.nana.user_interface.business_delegate.SysGateWayDelegate
IMPORT JAVA com.dsc.bpm.user_interface.business_delegate.api.BpmServiceAPIDelegate
IMPORT JAVA java.lang.System
IMPORT JAVA java.lang.Object
#161102-00047#15 by nikoybeat add E
 
SCHEMA ds
GLOBALS "../../cfg/top_global.inc"
 

 

 
DEFINE wset_t DYNAMIC ARRAY OF RECORD  		#DB的資料
   wsetent       LIKE wset_t.wsetent,
   wset001       LIKE wset_t.wset001,
   wset002       LIKE wset_t.wset002,
   wset003       LIKE wset_t.wset003,
   wsetownid     LIKE wset_t.wsetownid,
   wsetowndp     LIKE wset_t.wsetowndp,
   wsetcrtid     LIKE wset_t.wsetcrtid,
   wsetcrtdp     LIKE wset_t.wsetcrtdp,
   wsetcrtdt     LIKE wset_t.wsetcrtdt,
   wsetmodid     LIKE wset_t.wsetmodid,
   wsetmoddt     LIKE wset_t.wsetmoddt
END RECORD

DEFINE c_wset_t DYNAMIC ARRAY OF RECORD  	#目前的資料
   wset001       LIKE wset_t.wset001,
   wset002       LIKE wset_t.wset002
END RECORD

DEFINE g_wset_t DYNAMIC ARRAY OF RECORD  	#元件的資料
   wset001       LIKE wset_t.wset001,
   wset002       LIKE wset_t.wset002
END RECORD

DEFINE j_param DYNAMIC ARRAY OF RECORD  	#JSON的資料(元件的資料、目前的資料)
   entID         LIKE wset_t.wsetent,
   prod_code     LIKE wset_t.wset001,
   prod_address  LIKE wset_t.wset002
END RECORD

DEFINE g_return_stus BOOLEAN          #檢查寫入檔案權限

DEFINE gwin_curr   ui.Window
DEFINE gfrm_curr   ui.Form

DEFINE g_parameter         DYNAMIC ARRAY OF RECORD
   id            LIKE type_t.chr50,   #參數ID ( Action ID )      
   img           LIKE type_t.chr200,  #圖片路徑 (主要給pictureFlow用)
   comp          LIKE type_t.chr50    #對應畫面檔元件(參數群組包起來的container)
END RECORD
 
{</section>}
 
{<section id="awsi100.main" >}
MAIN

 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化

   #end add-point
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
	  
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsi100 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
	  
      #程式初始化
      CALL awsi100_init()
 
      #進入選單 Menu (='N')
      CALL awsi100_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_awsi100
   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 

 
 
 

 

 

 

 

END MAIN
{</section>}
 
{<section id="awsi100.other_function" >}
#add-point:自定義元件(Function)

################################################################################
#判斷DB是否有資料
################################################################################
PRIVATE FUNCTION awsi100_new_item(p_TYPE,p_db_name)
   DEFINE p_TYPE         STRING              #INSERT時分成兩種類型，因為「互聯中台設定」的企業編號，固定是0
   DEFINE p_db_name      LIKE wset_t.wset001 #表格wset_t的wset001
   DEFINE ls_sql         STRING              #要處理的SQL資料
   DEFINE li_cnt         INTEGER             #FOR迴圈計數用
   
   LET ls_sql = " SELECT COUNT(*) FROM wset_t WHERE wsetent = ? AND wset001 = ? "
   LET ls_sql = ls_sql, cl_sql_add_filter("wset_t")      #161102-00047#11  by nikoybeat add
   PREPARE awsi100_new_item_cs FROM ls_sql
   
   IF p_TYPE == "1" THEN
      EXECUTE awsi100_new_item_cs USING g_enterprise,p_db_name INTO li_cnt
   ELSE
      EXECUTE awsi100_new_item_cs USING "0",p_db_name INTO li_cnt
   END IF   
   
   FREE awsi100_new_item_cs   
   
   IF li_cnt == 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
#切換參數區塊 & 更換參數Title圖示文字
################################################################################
PRIVATE FUNCTION awsi100_parameter_switch(ps_paramid)
   DEFINE ps_paramid   STRING           #目前的頁面id
   DEFINE li_cnt       LIKE type_t.num5 #FOR迴圈計數用
   
   FOR li_cnt = 1 TO g_parameter.getLength()
       #傳入的id代表開啟, 其他都隱藏
       IF ps_paramid != g_parameter[li_cnt].id THEN          
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitem")		            
          CALL gfrm_curr.setElementHidden(g_parameter[li_cnt].comp, TRUE)
       ELSE
          CALL gfrm_curr.setElementStyle(g_parameter[li_cnt].id, "menuitemfocus")          
          CALL gfrm_curr.setElementHidden(g_parameter[li_cnt].comp, FALSE)		  
       END IF
   END FOR
END FUNCTION

################################################################################
#顯示一個MessageBox
################################################################################
PRIVATE FUNCTION awsi100_MessageBox(p_mes)
   DEFINE p_mes          STRING

   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = p_mes
   LET g_errparam.popup = TRUE
   CALL cl_err()
END FUNCTION

################################################################################
#檢查輸入的格式是否正確
################################################################################
PRIVATE FUNCTION awsi100_check_parameter()
   DEFINE li_cnt       INTEGER
   DEFINE tok          base.StringTokenizer
   DEFINE ls_IP        DYNAMIC ARRAY OF STRING
   DEFINE ls_website   STRING

   #檢查IP位置的限制
   IF g_wset_t[11].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
      IF j_param[1].prod_address == "127.0.0.1" THEN              
         CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
         RETURN 0
      END IF
   END IF
   
   #檢查IP位置的格式           
   IF j_param[1].prod_address MATCHES "*.*.*.*" THEN                            
      LET tok =  base.StringTokenizer.create(j_param[1].prod_address,".") 		   
      LET li_cnt = 1
			   
      WHILE tok.hasMoreTokens()
         LET ls_IP[li_cnt] = tok.nextToken()
         LET li_cnt = li_cnt + 1
      END WHILE		   
             			   
      IF li_cnt == 5 THEN
         IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
            ls_IP[2]>=0 AND ls_IP[2]<=255 AND
            ls_IP[3]>=0 AND ls_IP[3]<=255 AND
            ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
            --DISPLAY "IP位置的格式OK"
            LET j_param[1].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
            --DISPLAY "數字0~255有問題"
            RETURN 0
         END IF
      ELSE
         CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
         --DISPLAY "太多節點了"
         RETURN 0
      END IF			   
   ELSE
      CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
      --DISPLAY "格式不符合"
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[12].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[bpm_ip]" THEN
      CALL awsi100_MessageBox("aws-00047") #aws-00047：網址的格式，開頭必須是http://[bpm_ip]
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[14].wset002
   IF ls_website.getLength() < 8 OR ls_website.subString(1,8) != "[bpm_ip]" THEN
      CALL awsi100_MessageBox("aws-00052") #aws-00052：BPM接口URL的格式，開頭必須是[bpm_ip]
      RETURN 0
   END IF
   
   #檢查IP位置的限制
   IF g_wset_t[21].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
      IF j_param[2].prod_address == "127.0.0.1" THEN              
         CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
         RETURN 0
      END IF
   END IF
   
   #檢查IP位置的格式
   IF j_param[2].prod_address MATCHES "*.*.*.*" THEN                            
      LET tok =  base.StringTokenizer.create(j_param[2].prod_address,".") 		   
      LET li_cnt = 1
			   
      WHILE tok.hasMoreTokens()
         LET ls_IP[li_cnt] = tok.nextToken()
         LET li_cnt = li_cnt + 1
      END WHILE		   
             			   
      IF li_cnt == 5 THEN
         IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
            ls_IP[2]>=0 AND ls_IP[2]<=255 AND
            ls_IP[3]>=0 AND ls_IP[3]<=255 AND
            ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
            --DISPLAY "IP位置的格式OK"
            LET j_param[2].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
            --DISPLAY "數字0~255有問題"
            RETURN 0
         END IF
      ELSE
         CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
         --DISPLAY "太多節點了"
         RETURN 0
      END IF			   
   ELSE
      CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
      --DISPLAY "格式不符合"
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[22].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[eai_ip]" THEN
      CALL awsi100_MessageBox("aws-00048") #aws-00048：網址的格式，開頭必須是http://[eai_ip]
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[23].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[eai_ip]" THEN
      CALL awsi100_MessageBox("aws-00048") #aws-00048：網址的格式，開頭必須是http://[eai_ip]
      RETURN 0
   END IF

   #檢查Website的格式
   LET ls_website = g_wset_t[24].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[eai_ip]" THEN
      CALL awsi100_MessageBox("aws-00048") #aws-00048：網址的格式，開頭必須是http://[eai_ip]
      RETURN 0
   END IF
   
   #檢查IP位置的限制
   IF g_wset_t[31].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
      IF j_param[3].prod_address == "127.0.0.1" THEN              
         CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
         RETURN 0
      END IF
   END IF
   
   #檢查IP位置的格式
   IF j_param[3].prod_address MATCHES "*.*.*.*" THEN                            
      LET tok =  base.StringTokenizer.create(j_param[3].prod_address,".") 		   
      LET li_cnt = 1
			   
      WHILE tok.hasMoreTokens()
         LET ls_IP[li_cnt] = tok.nextToken()
         LET li_cnt = li_cnt + 1
      END WHILE		   
             			   
      IF li_cnt == 5 THEN
         IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
            ls_IP[2]>=0 AND ls_IP[2]<=255 AND
            ls_IP[3]>=0 AND ls_IP[3]<=255 AND
            ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
            --DISPLAY "IP位置的格式OK"
            LET j_param[3].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
            --DISPLAY "數字0~255有問題"
            RETURN 0
         END IF
      ELSE
         CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
         --DISPLAY "太多節點了"
         RETURN 0
      END IF			   
   ELSE
      CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
      --DISPLAY "格式不符合"
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[32].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[mcd_ip]" THEN
      CALL awsi100_MessageBox("aws-00049") #aws-00049：網址的格式，開頭必須是http://[mcd_ip]
      RETURN 0
   END IF
   
   #檢查IP位置的限制
   IF g_wset_t[41].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
      IF j_param[4].prod_address == "127.0.0.1" THEN              
         CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
         RETURN 0
      END IF
   END IF
   
   #檢查IP位置的格式
   IF j_param[4].prod_address MATCHES "*.*.*.*" THEN                            
      LET tok =  base.StringTokenizer.create(j_param[4].prod_address,".") 		   
      LET li_cnt = 1
			   
      WHILE tok.hasMoreTokens()
         LET ls_IP[li_cnt] = tok.nextToken()
         LET li_cnt = li_cnt + 1
      END WHILE		   
             			   
      IF li_cnt == 5 THEN
         IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
            ls_IP[2]>=0 AND ls_IP[2]<=255 AND
            ls_IP[3]>=0 AND ls_IP[3]<=255 AND
            ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
            --DISPLAY "IP位置的格式OK"
            LET j_param[4].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
            --DISPLAY "數字0~255有問題"
            RETURN 0
         END IF
      ELSE
         CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
         --DISPLAY "太多節點了"
         RETURN 0
      END IF			   
   ELSE
      CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
      --DISPLAY "格式不符合"
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[42].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[plm_ip]" THEN
      CALL awsi100_MessageBox("aws-00050") #aws-00050：網址的格式，開頭必須是http://[plm_ip]
      RETURN 0
   END IF
   
   #檢查IP位置的限制
   IF g_wset_t[51].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
      IF j_param[5].prod_address == "127.0.0.1" THEN              
         CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
         RETURN 0
      END IF
   END IF
   
   #檢查IP位置的格式
   IF j_param[5].prod_address MATCHES "*.*.*.*" THEN                            
      LET tok =  base.StringTokenizer.create(j_param[5].prod_address,".") 		   
      LET li_cnt = 1
			   
      WHILE tok.hasMoreTokens()
         LET ls_IP[li_cnt] = tok.nextToken()
         LET li_cnt = li_cnt + 1
      END WHILE		   
             			   
      IF li_cnt == 5 THEN
         IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
            ls_IP[2]>=0 AND ls_IP[2]<=255 AND
            ls_IP[3]>=0 AND ls_IP[3]<=255 AND
            ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
            --DISPLAY "IP位置的格式OK"
            LET j_param[5].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
            --DISPLAY "數字0~255有問題"
            RETURN 0
         END IF
      ELSE
         CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
         --DISPLAY "太多節點了"
         RETURN 0
      END IF			   
   ELSE
      CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
      --DISPLAY "格式不符合"
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[52].wset002
   IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[ecb_ip]" THEN
      CALL awsi100_MessageBox("aws-00051") #aws-00051：網址的格式，開頭必須是http://[ecb_ip]
      RETURN 0
   END IF

   #161102-00047#15-S
   #檢查IP位置的限制
   IF g_wset_t[71].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
      IF j_param[7].prod_address == "127.0.0.1" THEN              
         CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
         RETURN 0
      END IF
   END IF
   
   #檢查IP位置的格式
   IF j_param[7].prod_address MATCHES "*.*.*.*" THEN                            
      LET tok =  base.StringTokenizer.create(j_param[7].prod_address,".") 		   
      LET li_cnt = 1
			   
      WHILE tok.hasMoreTokens()
         LET ls_IP[li_cnt] = tok.nextToken()
         LET li_cnt = li_cnt + 1
      END WHILE		   
             			   
      IF li_cnt == 5 THEN
         IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
            ls_IP[2]>=0 AND ls_IP[2]<=255 AND
            ls_IP[3]>=0 AND ls_IP[3]<=255 AND
            ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
            --DISPLAY "IP位置的格式OK"
            LET j_param[7].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
            --DISPLAY "數字0~255有問題"
            RETURN 0
         END IF
      ELSE
         CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
         --DISPLAY "太多節點了"
         RETURN 0
      END IF			   
   ELSE
      CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
      --DISPLAY "格式不符合"
      RETURN 0
   END IF
   
   #檢查Website的格式
   LET ls_website = g_wset_t[72].wset002
   IF ls_website.getLength() < 18 OR ls_website.subString(1,18) != "http://[portal_ip]" THEN
      CALL awsi100_MessageBox("aws-00124") #aws-00050：網址的格式，開頭必須是http://[portal_ip]
      RETURN 0
   END IF
   #161102-00047#15-E
   
   RETURN 1
END FUNCTION

################################################################################
#新增參數資料
################################################################################
PRIVATE FUNCTION awsi100_insert_DB(ls_TYPE,ls_sql,ls_wset001)
   DEFINE ls_TYPE          STRING                #INSERT時分成兩種類型，因為「互聯中台設定」的企業編號，固定是0
   DEFINE ls_sql           STRING                #要處理的SQL資料
   DEFINE ls_wset001       LIKE wset_t.wset001   #表格wset_t的wset001
   DEFINE ls_date          LIKE wset_t.wsetcrtdt #現在的日期時間
	
   LET ls_date = cl_get_current()
	
   PREPARE awsi100_INSERT_cs FROM ls_sql
	
   IF ls_TYPE == "1" THEN
      EXECUTE awsi100_INSERT_cs USING g_enterprise,ls_wset001,g_user,g_dept,g_user,g_dept,ls_date,g_user,ls_date
   END IF
	
   IF ls_TYPE == "2" THEN
      EXECUTE awsi100_INSERT_cs USING ls_wset001,g_user,g_dept,g_user,g_dept,ls_date,g_user,ls_date
   END IF
	
   FREE awsi100_INSERT_cs
END FUNCTION

################################################################################
#更新參數資料
################################################################################
PRIVATE FUNCTION awsi100_update_DB(ls_TYPE,ls_sql,ls_wset002,ls_wset001)
   DEFINE ls_TYPE         STRING              #INSERT時分成兩種類型，因為「互聯中台設定」的企業編號，固定是0
   DEFINE ls_sql          STRING              #要處理的SQL資料
   DEFINE ls_wset002      LIKE wset_t.wset002 #表格wset_t的wset002
   DEFINE ls_wset001      LIKE wset_t.wset001 #表格wset_t的wset001
	
   PREPARE awsi100_update_cs FROM ls_sql
    
   IF ls_TYPE == "1" THEN
      EXECUTE awsi100_update_cs USING ls_wset002,ls_wset001,g_enterprise
   END IF
	
   IF ls_TYPE == "2" THEN
      EXECUTE awsi100_update_cs USING ls_wset002,ls_wset001
   END IF
	   
   FREE awsi100_update_cs
END FUNCTION

################################################################################
#讀取JSON檔案(匯入)
################################################################################
PRIVATE FUNCTION awsi100_load_from_JSON(p_ent,p_code)
   DEFINE p_ent             STRING
   DEFINE p_code            LIKE wset_t.wset001
   DEFINE ls_channel        base.Channel
   DEFINE ls_path_name      STRING
   DEFINE obj_import        STRING	
   DEFINE obj_b             util.JSONArray
   DEFINE li_cnt            INTEGER
	
   DEFINE j_param_d DYNAMIC ARRAY OF RECORD  	#JSON的資料
      ent_id                LIKE wset_t.wsetent,
      prod_code             LIKE wset_t.wset001,
      prod_address          LIKE wset_t.wset002
   END RECORD
	
   LET ls_channel = base.Channel.create()
   LET ls_path_name = FGL_GETENV("TOP_BASE"),"/etc/","awsi100_",FGL_GETENV("ZONE"),".param"
   --LET ls_path_name = FGL_GETENV("AWS"),"/4gl/","awsi100_",FGL_GETENV("ZONE"),".param"  
   
   CALL ls_channel.setDelimiter("")
   CALL ls_channel.openFile(ls_path_name,"r")      
   LET obj_import = ls_channel.readLine()
   CALL ls_channel.close()

   LET obj_b = util.JSONArray.parse(obj_import)
   CALL obj_b.toFGL(j_param_d)
     
   IF j_param_d.getLength() == 0 THEN  #讀取不到資料
      RETURN 0,0
   END IF
	
   FOR li_cnt = 1 TO j_param_d.getLength()
      IF j_param_d[li_cnt].ent_id == p_ent AND j_param_d[li_cnt].prod_code == p_code THEN
         RETURN 1,j_param_d[li_cnt].prod_address
      END IF
   END FOR
   
   RETURN 0,0
END FUNCTION

################################################################################
#儲存JSON檔案(匯出)
################################################################################
PRIVATE FUNCTION awsi100_save_to_JSON(ls_TYPE,p_ent,p_code,p_address)
   DEFINE ls_TYPE          STRING
   DEFINE p_ent            STRING
   DEFINE p_code           LIKE wset_t.wset001
   DEFINE p_address        LIKE wset_t.wset002
   DEFINE li_cnt           INTEGER
   DEFINE obj_b            util.JSONArray
   DEFINE ls_path_name     STRING
   DEFINE obj_import       STRING
   DEFINE obj_export       STRING   
   DEFINE ls_channel       base.Channel
   
   DEFINE j_param_d DYNAMIC ARRAY OF RECORD  	#JSON的資料
      ent_id               LIKE wset_t.wsetent,
      prod_code            LIKE wset_t.wset001,
      prod_address         LIKE wset_t.wset002
   END RECORD
   
   IF ls_TYPE == "1" THEN  #資料不存在，使用新增 
      LET ls_channel = base.Channel.create()
      LET ls_path_name = FGL_GETENV("TOP_BASE"),"/etc/","awsi100_",FGL_GETENV("ZONE"),".param"
      --LET ls_path_name = FGL_GETENV("AWS"),"/4gl/","awsi100_",FGL_GETENV("ZONE"),".param" 
   
      CALL ls_channel.setDelimiter("")
      CALL ls_channel.openFile(ls_path_name,"r")      
      LET obj_import = ls_channel.readLine()
      CALL ls_channel.close()

      LET obj_b = util.JSONArray.parse(obj_import)
      CALL obj_b.toFGL(j_param_d)  
   
      LET j_param_d[j_param_d.getLength()+1].ent_id = p_ent
      LET j_param_d[j_param_d.getLength()].prod_code = p_code
      LET j_param_d[j_param_d.getLength()].prod_address = p_address    
   END IF
   
   IF ls_TYPE == "2" THEN  #資料已存在，使用更新
      LET ls_channel = base.Channel.create()
      LET ls_path_name = FGL_GETENV("TOP_BASE"),"/etc/","awsi100_",FGL_GETENV("ZONE"),".param"
      --LET ls_path_name = FGL_GETENV("AWS"),"/4gl/","awsi100_",FGL_GETENV("ZONE"),".param" 
   
      CALL ls_channel.setDelimiter("")
      CALL ls_channel.openFile(ls_path_name,"r")      
      LET obj_import = ls_channel.readLine()
      CALL ls_channel.close()

      LET obj_b = util.JSONArray.parse(obj_import)
      CALL obj_b.toFGL(j_param_d)
      
      FOR li_cnt = 1 TO j_param_d.getLength()
         IF j_param_d[li_cnt].ent_id == p_ent AND j_param_d[li_cnt].prod_code == p_code THEN
            LET j_param_d[li_cnt].prod_address = p_address
         END IF
      END FOR
   END IF
   
   LET ls_channel = base.Channel.create()
   LET ls_path_name = FGL_GETENV("TOP_BASE"),"/etc/","awsi100_",FGL_GETENV("ZONE"),".param"
   LET obj_b = util.JSONArray.fromFGL(j_param_d)
   LET obj_export = obj_b.toString()  
 
   #帳號無權限寫入
   ##161102-00047#15-S
   IF os.Path.exists(ls_path_name) THEN
      IF NOT os.Path.writable(ls_path_name) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "aws-00089"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   #161102-00047#15-E
   
   CALL ls_channel.setDelimiter("")
   CALL ls_channel.openFile(ls_path_name,"w")
   CALL ls_channel.write(obj_export)
   CALL ls_channel.close()
   
   LET ls_channel = base.Channel.create()
   LET ls_path_name = FGL_GETENV("AWS"),"/4gl/","awsi100_",FGL_GETENV("ZONE"),".param"
   LET obj_b = util.JSONArray.fromFGL(j_param_d)
   LET obj_export = obj_b.toString()  
 
   CALL ls_channel.setDelimiter("")
   CALL ls_channel.openFile(ls_path_name,"w")
   CALL ls_channel.write(obj_export)
   CALL ls_channel.close()
      
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 測試jboss連接狀況
# Memo...........:
# Usage..........: CALL awsi100_twiddle_test()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/12/21 By nikoybeat
# Modify.........: 161102-00047#15 
################################################################################
PRIVATE FUNCTION awsi100_twiddle_test()
DEFINE l_cmd      STRING
DEFINE l_zone     STRING
DEFINE channel_l  base.Channel
DEFINE l_bpm_ip   STRING
DEFINE l_chk      STRING
  
   LET l_zone = FGL_GETENV("ZONE")
   LET l_zone = l_zone, "jboss/"
   
   LET l_bpm_ip = cl_aws_prod_para(g_enterprise, "bpm-0004")

   LET l_cmd = "cd ", FGL_GETENV("TOP_BASE"),"/topjboss/", l_zone, "bin"
   LET l_cmd = l_cmd, "; twiddle.sh -s ", l_bpm_ip, " get jboss.system:type=ServerInfo HostAddress TotalMemory"
   LET channel_l = base.Channel.create()
   CALL channel_l.setDelimiter("")
   CALL channel_l.openPipe( l_cmd, "r" )
      
   WHILE channel_l.read(l_chk)
      IF l_chk.trim() IS NULL THEN CONTINUE WHILE END IF
         DISPLAY l_chk #顯示背景訊息
         IF l_chk LIKE "HostAddress%" THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "aws-00104"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_bpm_ip 
            CALL cl_err()
            RETURN
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "aws-00105"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_chk 
            CALL cl_err()
            RETURN
         END IF
   END WHILE
   
END FUNCTION

################################################################################
# Descriptions...: 測試BPM首頁網址
# Memo...........:
# Usage..........: CALL awsi100_test_bpm_hmpage()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/12/21 By nikoybeat
# Modify.........: 161102-00047#15 
################################################################################
PRIVATE FUNCTION awsi100_test_bpm_hmpage()
   DEFINE l_url STRING

   LET l_url = cl_aws_prod_para(g_enterprise,"bpm-0002")
   CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [] )
END FUNCTION

################################################################################
# Descriptions...: 測試對方(BPM)是否正確回傳訊息
# Memo...........:
# Usage..........: CALL awsi100_test_bpm()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/12/21 By nikoybeat
# Modify.........: 161102-00047#15 
################################################################################
PRIVATE FUNCTION awsi100_test_bpm()
   DEFINE p_request_xml          STRING
   DEFINE l_nana_home            STRING
   DEFINE l_gateway              com.dsc.nana.user_interface.business_delegate.SysGateWayDelegate
   DEFINE l_bpm_service          com.dsc.bpm.user_interface.business_delegate.api.BpmServiceAPIDelegate
   DEFINE l_obj                  java.lang.Object
   DEFINE l_result               BOOLEAN
   DEFINE l_i                    LIKE type_t.num5
   DEFINE l_response             STRING
   DEFINE l_bpm_ip               LIKE ooaa_t.ooaa002   
   
   LET l_response = ""
   
   #取得BPM jar檔安裝路徑
   LET l_nana_home = FGL_GETENV("UTL")
   LET l_nana_home = os.path.join(l_nana_home, "java/jar/bpm")
   CALL System.setProperty("nana.home", l_nana_home)

   #取得BPM接口URL
   LET l_bpm_ip = cl_aws_prod_para(g_enterprise,"bpm-0004")    
      
   ##建立呼叫BPM api閘道
   #LET l_gateway = SysGateWayDelegate.create()
   #LET l_result = l_gateway.isAnySysIntegrated()

   #建立service delegate
   LET l_bpm_service = BpmServiceAPIDelegate.create()
   LET l_obj = Object.create()
  
   #傳送test string
   LET l_obj = l_bpm_service.bpmGateWay(l_bpm_ip,"Test")  
   
   #取得response 
   LET l_response = l_obj.toString()
   
   #顯示回傳結果
   IF l_response != "OK" OR cl_null(l_response) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aws-00097"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_bpm_ip
      CALL awsi100_twiddle_test()     
      CALL cl_err()
      RETURN
   ELSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aws-00096"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_bpm_ip 
      CALL cl_err()
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
{<section id="awsi100.init" >}
PRIVATE FUNCTION awsi100_init()
{<point name="init.define_customerization" edit="c" mark="Y"/>}
 
   DEFINE ls_sql          STRING   
   DEFINE li_cnt          INTEGER
   DEFINE li_for          INTEGER
   DEFINE ls_globalFile   STRING
   DEFINE ls_wset001      LIKE wset_t.wset001   
   DEFINE li_JSON1        INTEGER
   DEFINE li_JSON2        LIKE wset_t.wset002
     
   #設定畫面的背景色及背景圖片
   LET ls_globalFile = FGL_GETENV("TOP"),"/erp/cfg/4st/","awsi100.4st"
   CALL ui.Interface.loadStyles(ls_globalFile)
   DISPLAY "INFO: 4st for Interface Level = " || ls_globalFile

   CALL cl_set_act_visible("bpm_hmpage", FALSE)
   #是否進入共用函式, 共用變數
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET g_parameter[1].id = "step01"
   LET g_parameter[1].comp = "folder_01"
   LET g_parameter[2].id = "step02"  
   LET g_parameter[2].comp = "folder_02"
   LET g_parameter[3].id = "step03"  
   LET g_parameter[3].comp = "folder_03"
   LET g_parameter[4].id = "step04"  
   LET g_parameter[4].comp = "folder_04"
   LET g_parameter[5].id = "step05"  
   LET g_parameter[5].comp = "folder_05"
   LET g_parameter[6].id = "step06"  
   LET g_parameter[6].comp = "folder_06"
   LET g_parameter[7].id = "step07"       #161102-00047#15
   LET g_parameter[7].comp = "folder_07"  #161102-00047#15
  
   
   CALL awsi100_parameter_switch("step01")
   
   #判斷DB是否有資料，若沒有INSERT資料(BPM)
   IF awsi100_new_item("1","bpm-0001") THEN	
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0001")
   END IF
	
   IF awsi100_new_item("1","bpm-0002") THEN	
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'http://[bpm_ip]:8086/NaNaWeb/','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0002")
   END IF
	
   IF awsi100_new_item("1","bpm-0003") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'1','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0003")
   END IF
	
   IF awsi100_new_item("1","bpm-0004") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'[bpm_ip]:1099','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0004")
   END IF
	
   IF awsi100_new_item("1","bpm-0005") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,' ','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0005")
   END IF
   
   IF awsi100_new_item("1","bpm-0006") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'1','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0006")
   END IF
   
   IF awsi100_new_item("1","bpm-0007") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-0007")
   END IF
	
   #判斷DB是否有資料，若沒有INSERT資料(EAI)
   IF awsi100_new_item("2","eai-0001") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES ('0',?,'N','Y',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("2",ls_sql,"eai-0001")
   END IF
	
   IF awsi100_new_item("2","eai-0002") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES ('0',?,'http://[eai_ip]:9999/IntegrationEntry','Y',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("2",ls_sql,"eai-0002")
   END IF
	
   IF awsi100_new_item("2","eai-0003") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES ('0',?,'http://[eai_ip]:9990/OCIIS','Y',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("2",ls_sql,"eai-0003")
   END IF
	
   IF awsi100_new_item("2","eai-0004") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES ('0',?,'http://[eai_ip]:9990/OCIIS/tranviewer/TransLogViewer.zul','Y',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("2",ls_sql,"eai-0004")
   END IF
	
   IF awsi100_new_item("2","eai-0005") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES ('0',?,'N','Y',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("2",ls_sql,"eai-0005")   
   END IF
   
   #判斷DB是否有資料，若沒有INSERT資料(MCD)
   IF awsi100_new_item("1","mcd-0001") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"mcd-0001")
   END IF
	
   IF awsi100_new_item("1","mcd-0002") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'http://[mcd_ip]/','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"mcd-0002")
   END IF
	
   #判斷DB是否有資料，若沒有INSERT資料(PLM)
   IF awsi100_new_item("1","plm-0001") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"plm-0001")
   END IF
	
   IF awsi100_new_item("1","plm-0002") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'http://[plm_ip]:8000/axis2/services/ERPIService?wsdl','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"plm-0002")
   END IF
 
   #判斷DB是否有資料，若沒有INSERT資料(ECB)
   IF awsi100_new_item("1","ecb-0001") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"ecb-0001")
   END IF
	
   IF awsi100_new_item("1","ecb-0002") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'http://[ecb_ip]/','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"ecb-0002")
   END IF
	
   IF awsi100_new_item("1","ecb-0003") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,' ','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"ecb-0003")
   END IF
   
   #判斷DB是否有資料，若沒有INSERT資料(MES)
   IF awsi100_new_item("1","mes-0001") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"mes-0001")
   END IF
   
   #161102-00047#15-S
   IF awsi100_new_item("1","mes-0002") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"mes-0002")
   END IF
   
   #判斷DB是否有資料，若沒有INSERT資料(Portal)
   IF awsi100_new_item("1","portal-0001") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'N','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"portal-0001")
   END IF
	
   IF awsi100_new_item("1","portal-0002") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'http://[portal_ip]:8081//cas-web/WebService/IssueandValidateTicketWS','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"portal-0002")
   END IF
   #161102-00047#15-E

   #判斷DB是否有資料，若沒有INSERT資料(有關IP位置代碼的資料)
   IF awsi100_new_item("1","bpm-code") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'bpm_ip','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"bpm-code")
   END IF
	
   IF awsi100_new_item("2","eai-code") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES ('0',?,'eai_ip','Y',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("2",ls_sql,"eai-code")
   END IF
	
   IF awsi100_new_item("1","mcd-code") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'mcd_ip','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"mcd-code")
   END IF
	  
   IF awsi100_new_item("1","plm-code") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'plm_ip','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"plm-code")
   END IF
	   
   IF awsi100_new_item("1","ecb-code") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'ecb_ip','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"ecb-code")
   END IF
   
   #161102-00047#15-S
   IF awsi100_new_item("1","portal-code") THEN
      LET ls_sql = " INSERT INTO wset_t (wsetent,wset001,wset002,wset003,wsetownid,wsetowndp,wsetcrtid,wsetcrtdp,wsetcrtdt,wsetmodid,wsetmoddt) ",
						 " VALUES (?,?,'portal_ip','N',?,?,?,?,?,?,?) "
      CALL awsi100_insert_DB("1",ls_sql,"portal-code")
   END IF
   #161102-00047#15-E

   LET ls_sql = " SELECT * FROM wset_t WHERE wsetent = ? "
   DECLARE awsi100_init_data_cs CURSOR FROM ls_sql

   LET li_cnt = 1
   FOREACH awsi100_init_data_cs USING g_enterprise INTO wset_t[li_cnt].*
      LET li_cnt = li_cnt + 1			
   END FOREACH
   
   #DB已經有全部資料
   FOR li_for = 1 TO (li_cnt - 1)
      LET ls_wset001 = wset_t[li_for].wset001
	
      #更新目前的資料、更新元件的資料(BPM)
      IF ls_wset001 == "bpm-0001" THEN			
         LET c_wset_t[11].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO BPM_0001
      END IF
		
      IF ls_wset001 == "bpm-0002" THEN			
         LET c_wset_t[12].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO BPM_0002
      END IF
		
      IF ls_wset001 == "bpm-0003" THEN			
         LET c_wset_t[13].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO BPM_0003
      END IF
		
      IF ls_wset001 == "bpm-0004" THEN			
         LET c_wset_t[14].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO BPM_0004
      END IF
		
      IF ls_wset001 == "bpm-0005" THEN			
         LET c_wset_t[15].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO BPM_0005
      END IF
      
      IF ls_wset001 == "bpm-0006" THEN			
         LET c_wset_t[16].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO bpm_0006
      END IF
      
      IF ls_wset001 == "bpm-0007" THEN			
         LET c_wset_t[17].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO bpm_0007
      END IF
		
      #更新目前的資料、更新元件的資料(MCD)
      IF ls_wset001 == "mcd-0001" THEN			
         LET c_wset_t[31].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO MCD_0001
      END IF
		
      IF ls_wset001 == "mcd-0002" THEN			
         LET c_wset_t[32].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO MCD_0002
      END IF	

      #更新目前的資料、更新元件的資料(PLM)
      IF ls_wset001 == "plm-0001" THEN			
         LET c_wset_t[41].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO PLM_0001
      END IF
		
      IF ls_wset001 == "plm-0002" THEN			
         LET c_wset_t[42].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO PLM_0002
      END IF	

      #更新目前的資料、更新元件的資料(ECB)
      IF ls_wset001 == "ecb-0001" THEN			
         LET c_wset_t[51].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO ECB_0001
      END IF
		
      IF ls_wset001 == "ecb-0002" THEN			
         LET c_wset_t[52].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO ECB_0002
      END IF	

      IF ls_wset001 == "ecb-0003" THEN			
         LET c_wset_t[53].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO ECB_0003
      END IF		

      #更新目前的資料、更新元件的資料(MES)
      IF ls_wset001 == "mes-0001" THEN			
         LET c_wset_t[61].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO MES_0001
      END IF
      
      #161102-00047#15-S
      IF ls_wset001 == "mes-0002" THEN			
         LET c_wset_t[62].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO MES_0002
      END IF
      
      
      #更新目前的資料、更新元件的資料(Portal)
      IF ls_wset001 == "portal-0001" THEN			
         LET c_wset_t[71].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO PORTAL_0001
      END IF
		
      IF ls_wset001 == "portal-0002" THEN			
         LET c_wset_t[72].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO PORTAL_0002
      END IF
      #161102-00047#15-E
   END FOR

   LET li_cnt = 1
   FOREACH awsi100_init_data_cs USING '0' INTO wset_t[li_cnt].*
      LET li_cnt = li_cnt + 1			
   END FOREACH
   
   FREE awsi100_init_data_cs
   
   FOR li_for = 1 TO (li_cnt - 1)
      LET ls_wset001 = wset_t[li_for].wset001

      #更新目前的資料、更新元件的資料(EAI)
      IF ls_wset001 == "eai-0001" THEN			
         LET c_wset_t[21].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO EAI_0001
      END IF
		
      IF ls_wset001 == "eai-0002" THEN			
         LET c_wset_t[22].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO EAI_0002
      END IF
		
      IF ls_wset001 == "eai-0003" THEN			
         LET c_wset_t[23].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO EAI_0003
      END IF
		
      IF ls_wset001 == "eai-0004" THEN			
         LET c_wset_t[24].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO EAI_0004
      END IF
		
      IF ls_wset001 == "eai-0005" THEN			
         LET c_wset_t[25].wset002 = wset_t[li_for].wset002
         DISPLAY wset_t[li_for].wset002 TO EAI_0005
      END IF
      
   END FOR
  
   #判斷JSON是否有資料，若沒有就產生初始值
   CALL awsi100_load_from_JSON(g_enterprise,"bpm_ip") RETURNING li_JSON1,li_JSON2
   IF li_JSON1 == 0 THEN
      LET j_param[11].entID = g_enterprise
      LET j_param[11].prod_code = "bpm_ip"
      LET j_param[11].prod_address = "127.0.0.1"
      CALL awsi100_save_to_JSON("1",j_param[11].entID,j_param[11].prod_code,j_param[11].prod_address) RETURNING g_return_stus
   ELSE
      LET j_param[11].entID = g_enterprise
      LET j_param[11].prod_code = "bpm_ip"
      LET j_param[11].prod_address = li_JSON2      
   END IF
   
   DISPLAY j_param[11].prod_code TO bpm_code
   DISPLAY j_param[11].prod_address TO bpm_addr
   
   CALL awsi100_load_from_JSON("0","eai_ip") RETURNING li_JSON1,li_JSON2
   IF li_JSON1 == 0 THEN
      LET j_param[21].entID = '0'
      LET j_param[21].prod_code = "eai_ip"
      LET j_param[21].prod_address = "127.0.0.1"
      CALL awsi100_save_to_JSON("1",j_param[21].entID,j_param[21].prod_code,j_param[21].prod_address) RETURNING g_return_stus
   ELSE
      LET j_param[21].entID = '0'
      LET j_param[21].prod_code = "eai_ip"
      LET j_param[21].prod_address = li_JSON2      
   END IF
   
   DISPLAY j_param[21].prod_code TO eai_code
   DISPLAY j_param[21].prod_address TO eai_addr
   
   CALL awsi100_load_from_JSON(g_enterprise,"mcd_ip") RETURNING li_JSON1,li_JSON2
   IF li_JSON1 == 0 THEN
      LET j_param[31].entID = g_enterprise
      LET j_param[31].prod_code = "mcd_ip"
      LET j_param[31].prod_address = "127.0.0.1"
      CALL awsi100_save_to_JSON("1",j_param[31].entID,j_param[31].prod_code,j_param[31].prod_address) RETURNING g_return_stus
   ELSE
      LET j_param[31].entID = g_enterprise
      LET j_param[31].prod_code = "mcd_ip"
      LET j_param[31].prod_address = li_JSON2      
   END IF
   
   DISPLAY j_param[31].prod_code TO mcd_code
   DISPLAY j_param[31].prod_address TO mcd_addr
   
   CALL awsi100_load_from_JSON(g_enterprise,"plm_ip") RETURNING li_JSON1,li_JSON2
   IF li_JSON1 == 0 THEN
      LET j_param[41].entID = g_enterprise
      LET j_param[41].prod_code = "plm_ip"
      LET j_param[41].prod_address = "127.0.0.1"
      CALL awsi100_save_to_JSON("1",j_param[41].entID,j_param[41].prod_code,j_param[41].prod_address) RETURNING g_return_stus
   ELSE
      LET j_param[41].entID = g_enterprise
      LET j_param[41].prod_code = "plm_ip"
      LET j_param[41].prod_address = li_JSON2      
   END IF
   
   DISPLAY j_param[41].prod_code TO plm_code
   DISPLAY j_param[41].prod_address TO plm_addr
   
   CALL awsi100_load_from_JSON(g_enterprise,"ecb_ip") RETURNING li_JSON1,li_JSON2
   IF li_JSON1 == 0 THEN
      LET j_param[51].entID = g_enterprise
      LET j_param[51].prod_code = "ecb_ip"
      LET j_param[51].prod_address = "127.0.0.1"
      CALL awsi100_save_to_JSON("1",j_param[51].entID,j_param[51].prod_code,j_param[51].prod_address) RETURNING g_return_stus
   ELSE
      LET j_param[51].entID = g_enterprise
      LET j_param[51].prod_code = "ecb_ip"
      LET j_param[51].prod_address = li_JSON2      
   END IF
   
   DISPLAY j_param[51].prod_code TO ecb_code
   DISPLAY j_param[51].prod_address TO ecb_addr

   #161102-00047#15-S
   CALL awsi100_load_from_JSON(g_enterprise,"portal_ip") RETURNING li_JSON1,li_JSON2
   IF li_JSON1 == 0 THEN
      LET j_param[71].entID = g_enterprise
      LET j_param[71].prod_code = "portal_ip"
      LET j_param[71].prod_address = "127.0.0.1"
      CALL awsi100_save_to_JSON("1",j_param[71].entID,j_param[71].prod_code,j_param[71].prod_address) RETURNING g_return_stus
   ELSE
      LET j_param[71].entID = g_enterprise
      LET j_param[71].prod_code = "portal_ip"
      LET j_param[71].prod_address = li_JSON2      
   END IF
   
   DISPLAY j_param[71].prod_code TO plm_code
   DISPLAY j_param[71].prod_address TO plm_addr
   #161102-00047#15-E
 
   #初始化SCC
   CALL cl_set_combo_scc('bpm_0006','228')
   CALL cl_set_combo_scc('bpm_0003','229')
   CALL cl_set_combo_scc('mes_0002','265')   #161102-00047#15
 
{<point name="init.init" />}
END FUNCTION
{</section>}
 
{<section id="awsi100.ui_dialog" >}
PRIVATE FUNCTION awsi100_ui_dialog() 
{<point name="ui_dialog.define_customerization" edit="c" mark="Y"/>}
   MENU ""     
      ON ACTION modify
         LET g_action_choice="modify"
         IF cl_auth_chk_act("modify") THEN
            CALL awsi100_modify()
         END IF
		 
      ON ACTION step01
         CALL awsi100_parameter_switch("step01")
		 
      ON ACTION step02
         CALL awsi100_parameter_switch("step02")
		 
      ON ACTION step03
         CALL awsi100_parameter_switch("step03")
		 
      ON ACTION step04
         CALL awsi100_parameter_switch("step04")
		 
      ON ACTION step05
         CALL awsi100_parameter_switch("step05")
         
      ON ACTION step06
         CALL awsi100_parameter_switch("step06")
      
      #161102-00047#15-S
      ON ACTION step07
         CALL awsi100_parameter_switch("step07")
         
      ON ACTION bpm_test
		   IF cl_aws_prod_para(g_enterprise, "bpm-0001") != "Y" THEN
		      INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "aws-00081"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE 
		      CALL awsi100_test_bpm()
		   END IF
		   
		ON ACTION bpm_test_hmpage
		   CALL awsi100_test_bpm_hmpage()
	   #161102-00047#15-E
		   
      ON ACTION exit
         LET g_action_choice = "exit"
         EXIT MENU
      ON ACTION close
         LET g_action_choice = "exit"
         EXIT MENU      	 
   END MENU
{<point name="ui_dialog.define"/>}
  
{<point name="ui_dialog.pre_function"/>}
 
{<point name="menu.default.insert" />}
 
{<point name="ui_dialog.action_default"/>}
 
{<point name="ui_dialog.before_dialog"/>}
 
{<point name="ui_dialog.before_menu"/>}
 
{<point name="menu2.modify" mark="Y"/>}
 
{<point name="menu2.delete" mark="Y"/>}
 
{<point name="menu2.insert" mark="Y"/>}
 
{<point name="menu2.output" mark="Y"/>}
 
{<point name="menu2.reproduce" mark="Y"/>}
 
{<point name="menu2.query" mark="Y"/>}
 
{<point name="ui_dialog.menu.related_document"/>}
 
{<point name="ui_dialog.menu.agendum"/>}
 
{<point name="ui_dialog.menu.followup"/>}
 
{<point name="ui_dialog.more_displayarray"/>}
 
{<point name="ui_dialog.b_dialog"/>}
 
{<point name="ui_dialog.after_dialog"/>}
 
{<point name="menu.modify" mark="Y"/>}
 
{<point name="menu.delete" mark="Y"/>}
 
{<point name="menu.insert" mark="Y"/>}
 
{<point name="menu.output" mark="Y"/>}
 
{<point name="menu.reproduce" mark="Y"/>}
 
{<point name="menu.query" mark="Y"/>}
 
{<point name="ui_dialog.dialog.related_document"/>}
 
{<point name="ui_dialog.dialog.agendum"/>}
 
{<point name="ui_dialog.dialog.followup"/>}
 
{<point name="ui_dialog.exit_dialog"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.browser_fill" >}
PRIVATE FUNCTION awsi100_browser_fill(p_wc,ps_page_action) 
{<point name="browser_fill.define_customerization" edit="c" mark="Y"/>}
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
{<point name="browser_fill.define"/>}
 
{<point name="browser_fill.pre_function"/>}
 
{<point name="browser_fill.wc"/>}
   
{<point name="browser_fill.cnt_sql"/>}
   
{<point name="browser_fill.fill_wc"/>}
  
{<point name="browser_fill.before_pre"/>}
 
{<point name="browser_fill.reference"/>}
 
 
END FUNCTION
{</section>}
 
{<section id="awsi100.construct" >}
PRIVATE FUNCTION awsi100_construct()
{<point name="cs.define_customerization" edit="c" mark="Y"/>}
 
{<point name="cs.define"/>}
 
{<point name="cs.pre_function"/>}
 
{<point name="cs.before_construct"/>}
 
{<point name="construct.b.wset001" />}
 
{<point name="construct.a.wset001" />}
 
{<point name="construct.c.wset001" />}
 
 
 
{<point name="construct.b.wsetownid" />}
 
{<point name="construct.a.wsetownid" />}
 
 
 
{<point name="construct.b.wsetowndp" />}
 
{<point name="construct.a.wsetowndp" />}
 
 
 
{<point name="construct.b.wsetcrtid" />}
 
{<point name="construct.a.wsetcrtid" />}
 
 
 
{<point name="construct.b.wsetcrtdp" />}
 
{<point name="construct.a.wsetcrtdp" />}
 
{<point name="construct.b.wsetcrtdt" />}
 
 
 
{<point name="construct.b.wsetmodid" />}
 
{<point name="construct.a.wsetmodid" />}
 
{<point name="construct.b.wsetmoddt" />}
 
{<point name="cs.more_construct"/>}
 
{<point name="cs.b_dialog"/>}
 
{<point name="cs.after_construct"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.query" >}
PRIVATE FUNCTION awsi100_query()
{<point name="query.define_customerization" edit="c" mark="Y"/>}
 
{<point name="query.define"/>}
 
{<point name="query.pre_function"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.fetch" >}
PRIVATE FUNCTION awsi100_fetch(p_fl)
{<point name="fetch.define_customerization" edit="c" mark="Y"/>}
   DEFINE p_fl      LIKE type_t.chr1
{<point name="fetch.define"/>}
 
{<point name="fetch.pre_function"/>}
 
{<point name="fetch.action_control"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.insert" >}
PRIVATE FUNCTION awsi100_insert()
{<point name="insert.define_customerization" edit="c" mark="Y"/>}
 
{<point name="insert.define"/>}
 
{<point name="insert.pre_function"/>}
 
{<point name="insert.before"/>}
 
{<point name="insert.default"/>}
 
{<point name="insert.after_insert"/>}
 
{<point name="insert.after"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.modify" >}
PRIVATE FUNCTION awsi100_modify()
{<point name="modify.define_customerization" edit="c" mark="Y"/>}
 
   DEFINE ls_sql       STRING
   DEFINE ls_name      STRING
   DEFINE li_cnt       INTEGER
   DEFINE tok          base.StringTokenizer
   DEFINE ls_IP        DYNAMIC ARRAY OF STRING
   DEFINE ls_website   STRING
   DEFINE l_orgsync    STRING
   DEFINE l_value      STRING

   #161102-00047#15-S
   INPUT g_wset_t[11].wset002,g_wset_t[12].wset002,g_wset_t[13].wset002,g_wset_t[14].wset002,g_wset_t[15].wset002,g_wset_t[16].wset002,g_wset_t[17].wset002,j_param[1].prod_code,j_param[1].prod_address,
         g_wset_t[21].wset002,g_wset_t[22].wset002,g_wset_t[23].wset002,g_wset_t[24].wset002,g_wset_t[25].wset002,j_param[2].prod_code,j_param[2].prod_address,
         g_wset_t[31].wset002,g_wset_t[32].wset002,j_param[3].prod_code,j_param[3].prod_address,
         g_wset_t[41].wset002,g_wset_t[42].wset002,j_param[4].prod_code,j_param[4].prod_address,
         g_wset_t[51].wset002,g_wset_t[52].wset002,g_wset_t[53].wset002,j_param[5].prod_code,j_param[5].prod_address,
         g_wset_t[61].wset002,g_wset_t[62].wset002,
         g_wset_t[71].wset002,g_wset_t[72].wset002,j_param[7].prod_code,j_param[7].prod_address
   FROM  BPM_0001,BPM_0002,BPM_0003,BPM_0004,BPM_0005,bpm_0006,bpm_0007,bpm_code,bpm_addr,
         EAI_0001,EAI_0002,EAI_0003,EAI_0004,EAI_0005,eai_code,eai_addr,
         MCD_0001,MCD_0002,mcd_code,mcd_addr,
         PLM_0001,PLM_0002,plm_code,plm_addr,
         ECB_0001,ECB_0002,ECB_0003,ecb_code,ecb_addr,
         MES_0001,MES_0002,
         PORTAL_0001,PORTAL_0002,portal_code,portal_addr
   #161102-00047#15-E
   
      ATTRIBUTE(UNBUFFERED)		
			
      BEFORE INPUT
         #更新元件的資料
         FOR li_cnt = 11 TO 17
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
				
         LET j_param[1].prod_code = j_param[11].prod_code
         LET j_param[1].prod_address = j_param[11].prod_address
            
         FOR li_cnt = 21 TO 25
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
				
         LET j_param[2].prod_code = j_param[21].prod_code
         LET j_param[2].prod_address = j_param[21].prod_address
         
         FOR li_cnt = 31 TO 32
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
				
         LET j_param[3].prod_code = j_param[31].prod_code
         LET j_param[3].prod_address = j_param[31].prod_address
         
         FOR li_cnt = 41 TO 42
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
				
         LET j_param[4].prod_code = j_param[41].prod_code
         LET j_param[4].prod_address = j_param[41].prod_address
         
         FOR li_cnt = 51 TO 53
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
								
         LET j_param[5].prod_code = j_param[51].prod_code
         LET j_param[5].prod_address = j_param[51].prod_address
        
         #161102-00047#15-S
         FOR li_cnt = 61 TO 62
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
         
         FOR li_cnt = 71 TO 72
            LET g_wset_t[li_cnt].wset002 = c_wset_t[li_cnt].wset002
         END FOR
				
         LET j_param[7].prod_code = j_param[71].prod_code
         LET j_param[7].prod_address = j_param[71].prod_address
         #161102-00047#15-E
         
      AFTER FIELD BPM_0001
         #檢查IP位置的限制
         IF g_wset_t[11].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[1].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD BPM_0001
            END IF
         END IF

      AFTER FIELD bpm_addr
         #檢查IP位置的限制
         IF g_wset_t[11].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[1].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD bpm_addr
            END IF
         END IF            
         
         #檢查IP位置的格式           
         IF j_param[1].prod_address MATCHES "*.*.*.*" THEN                            
            LET tok =  base.StringTokenizer.create(j_param[1].prod_address,".") 		   
            LET li_cnt = 1
			   
            WHILE tok.hasMoreTokens()
               LET ls_IP[li_cnt] = tok.nextToken()
               LET li_cnt = li_cnt + 1
            END WHILE		   
             			   
            IF li_cnt == 5 THEN
               IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
                  ls_IP[2]>=0 AND ls_IP[2]<=255 AND
                  ls_IP[3]>=0 AND ls_IP[3]<=255 AND
                  ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
                  --DISPLAY "IP位置的格式OK"
                  LET j_param[1].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
               ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "數字0~255有問題"
                  NEXT FIELD bpm_addr
               END IF
            ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
               --DISPLAY "太多節點了"
               NEXT FIELD bpm_addr
            END IF			   
         ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
               --DISPLAY "格式不符合"
               NEXT FIELD bpm_addr
         END IF
            
      AFTER FIELD BPM_0002      
         #檢查Website的格式
         LET ls_website = g_wset_t[12].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[bpm_ip]" THEN
            CALL awsi100_MessageBox("aws-00047") #aws-00047：網址的格式，開頭必須是http://[bpm_ip]
            NEXT FIELD BPM_0002
         END IF

      AFTER FIELD BPM_0004      
         #檢查Website的格式
         LET ls_website = g_wset_t[14].wset002
         IF ls_website.getLength() < 8 OR ls_website.subString(1,8) != "[bpm_ip]" THEN
            CALL awsi100_MessageBox("aws-00052") #aws-00052：BPM接口URL的格式，開頭必須是[bpm_ip]
            NEXT FIELD BPM_0004
         END IF
         
      ON CHANGE bpm_0006
         #模式為 1.單一 時，資料不可多選
         LET l_orgsync = g_wset_t[15].wset002
         IF l_orgsync.getIndexOf("|", 1) != 0 AND g_wset_t[16].wset002 = "1" THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "aws-00069"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_wset_t[16].wset002 = "2"
            DISPLAY g_wset_t[16].wset002 TO bpm_0006
            NEXT FIELD BPM_0005
         END IF
      
      AFTER FIELD BPM_0005
         #模式為 1.單一 時，資料不可多選
         LET l_orgsync = g_wset_t[15].wset002
         IF l_orgsync.getIndexOf("|", 1) != 0 AND g_wset_t[16].wset002 = "1" THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "aws-00069"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD BPM_0005
         END IF
         
      AFTER FIELD EAI_0001
         #檢查IP位置的限制
         IF g_wset_t[21].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[2].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD EAI_0001
            END IF
         END IF
            
      AFTER FIELD eai_addr
         #檢查IP位置的限制
         IF g_wset_t[21].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[2].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD eai_addr
            END IF
         END IF
            
         #檢查IP位置的格式
         IF j_param[2].prod_address MATCHES "*.*.*.*" THEN                            
            LET tok =  base.StringTokenizer.create(j_param[2].prod_address,".") 		   
            LET li_cnt = 1
			   
            WHILE tok.hasMoreTokens()
               LET ls_IP[li_cnt] = tok.nextToken()
               LET li_cnt = li_cnt + 1
            END WHILE		   
             			   
            IF li_cnt == 5 THEN
               IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
                  ls_IP[2]>=0 AND ls_IP[2]<=255 AND
                  ls_IP[3]>=0 AND ls_IP[3]<=255 AND
                  ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
                  --DISPLAY "IP位置的格式OK"
                  LET j_param[2].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
               ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "數字0~255有問題"
                  NEXT FIELD eai_addr
               END IF
            ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "太多節點了"
                  NEXT FIELD eai_addr
            END IF			   
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
            --DISPLAY "格式不符合"
            NEXT FIELD eai_addr
         END IF
            
      AFTER FIELD EAI_0002
         #檢查Website的格式
         LET ls_website = g_wset_t[22].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[eai_ip]" THEN
            CALL awsi100_MessageBox("aws-00048") #aws-00048：網址的格式，開頭必須是http://[eai_ip]
            NEXT FIELD EAI_0002
         END IF

      AFTER FIELD EAI_0003
         #檢查Website的格式
         LET ls_website = g_wset_t[23].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[eai_ip]" THEN
            CALL awsi100_MessageBox("aws-00048") #aws-00048：網址的格式，開頭必須是http://[eai_ip]
            NEXT FIELD EAI_0003
         END IF 
            
      AFTER FIELD EAI_0004
         #檢查Website的格式
         LET ls_website = g_wset_t[24].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[eai_ip]" THEN
            CALL awsi100_MessageBox("aws-00048") #aws-00048：網址的格式，開頭必須是http://[eai_ip]
            NEXT FIELD EAI_0004
         END IF
         
      AFTER FIELD MCD_0001
         #檢查IP位置的限制
         IF g_wset_t[31].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[3].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD MCD_0001
            END IF
         END IF     
          
      AFTER FIELD mcd_addr
         #檢查IP位置的限制
         IF g_wset_t[31].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[3].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD mcd_addr
            END IF
         END IF

         #檢查IP位置的格式
         IF j_param[3].prod_address MATCHES "*.*.*.*" THEN                            
            LET tok =  base.StringTokenizer.create(j_param[3].prod_address,".") 		   
            LET li_cnt = 1
			   
            WHILE tok.hasMoreTokens()
               LET ls_IP[li_cnt] = tok.nextToken()
               LET li_cnt = li_cnt + 1
            END WHILE		   
             			   
            IF li_cnt == 5 THEN
               IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
                  ls_IP[2]>=0 AND ls_IP[2]<=255 AND
                  ls_IP[3]>=0 AND ls_IP[3]<=255 AND
                  ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
                  --DISPLAY "IP位置的格式OK"
                  LET j_param[3].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
               ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "數字0~255有問題"
                  NEXT FIELD mcd_addr
               END IF
            ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
               --DISPLAY "太多節點了"
               NEXT FIELD mcd_addr
            END IF			   
         ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
               --DISPLAY "格式不符合"
               NEXT FIELD mcd_addr
         END IF
         
      AFTER FIELD MCD_0002
         #檢查Website的格式
         LET ls_website = g_wset_t[32].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[mcd_ip]" THEN
            CALL awsi100_MessageBox("aws-00049") #aws-00049：網址的格式，開頭必須是http://[mcd_ip]
            NEXT FIELD MCD_0002
         END IF
         
      AFTER FIELD PLM_0001
         #檢查IP位置的限制
         IF g_wset_t[41].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[4].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD PLM_0001
            END IF
         END IF
         
      AFTER FIELD plm_addr
         #檢查IP位置的限制
         IF g_wset_t[41].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[4].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD plm_addr
            END IF
         END IF

         #檢查IP位置的格式
         IF j_param[4].prod_address MATCHES "*.*.*.*" THEN                            
            LET tok =  base.StringTokenizer.create(j_param[4].prod_address,".") 		   
            LET li_cnt = 1
			   
            WHILE tok.hasMoreTokens()
               LET ls_IP[li_cnt] = tok.nextToken()
               LET li_cnt = li_cnt + 1
            END WHILE		   
             			   
            IF li_cnt == 5 THEN
               IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
                  ls_IP[2]>=0 AND ls_IP[2]<=255 AND
                  ls_IP[3]>=0 AND ls_IP[3]<=255 AND
                  ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
                  --DISPLAY "IP位置的格式OK"
                  LET j_param[4].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
               ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "數字0~255有問題"
                  NEXT FIELD plm_addr
               END IF
            ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
               --DISPLAY "太多節點了"
               NEXT FIELD plm_addr
            END IF			   
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
            --DISPLAY "格式不符合"
            NEXT FIELD plm_addr
         END IF
                  
      AFTER FIELD PLM_0002
         #檢查Website的格式
         LET ls_website = g_wset_t[42].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[plm_ip]" THEN
            CALL awsi100_MessageBox("aws-00050") #aws-00050：網址的格式，開頭必須是http://[plm_ip]
            NEXT FIELD PLM_0002
         END IF
         
      AFTER FIELD ECB_0001
         #檢查IP位置的限制
         IF g_wset_t[51].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[5].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD ECB_0001
            END IF
         END IF
         
      AFTER FIELD ecb_addr
         #檢查IP位置的限制
         IF g_wset_t[51].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[5].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD ecb_addr
            END IF
         END IF

         #檢查IP位置的格式
         IF j_param[5].prod_address MATCHES "*.*.*.*" THEN                            
            LET tok =  base.StringTokenizer.create(j_param[5].prod_address,".") 		   
            LET li_cnt = 1
			   
            WHILE tok.hasMoreTokens()
               LET ls_IP[li_cnt] = tok.nextToken()
               LET li_cnt = li_cnt + 1
            END WHILE		   
             			   
            IF li_cnt == 5 THEN
               IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
                  ls_IP[2]>=0 AND ls_IP[2]<=255 AND
                  ls_IP[3]>=0 AND ls_IP[3]<=255 AND
                  ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
                  --DISPLAY "IP位置的格式OK"
                  LET j_param[5].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
               ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "數字0~255有問題"
                  NEXT FIELD ecb_addr
               END IF
            ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
               --DISPLAY "太多節點了"
               NEXT FIELD ecb_addr
            END IF			   
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
            --DISPLAY "格式不符合"
            NEXT FIELD ecb_addr
         END IF
         
      AFTER FIELD ECB_0002
         #檢查Website的格式
         LET ls_website = g_wset_t[52].wset002
         IF ls_website.getLength() < 15 OR ls_website.subString(1,15) != "http://[ecb_ip]" THEN
            CALL awsi100_MessageBox("aws-00051") #aws-00051：網址的格式，開頭必須是http://[ecb_ip]
            NEXT FIELD ECB_0002
         END IF
      
      #161102-00047#15-S
      AFTER FIELD PORTAL_0001
         #檢查IP位置的限制
         IF g_wset_t[71].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[7].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD PORTAL_0001
            END IF
         END IF
         
      AFTER FIELD portal_addr
         #檢查IP位置的限制
         IF g_wset_t[71].wset002 == 'Y' THEN #若有啟用協同，IP位置不可為127.0.0.1
            IF j_param[7].prod_address == "127.0.0.1" THEN              
               CALL awsi100_MessageBox("aws-00044") #aws-00044：啟用協同時，IP位置不可為127.0.0.1！
               NEXT FIELD portal_addr
            END IF
         END IF

         #檢查IP位置的格式
         IF j_param[7].prod_address MATCHES "*.*.*.*" THEN                            
            LET tok =  base.StringTokenizer.create(j_param[7].prod_address,".") 		   
            LET li_cnt = 1
			   
            WHILE tok.hasMoreTokens()
               LET ls_IP[li_cnt] = tok.nextToken()
               LET li_cnt = li_cnt + 1
            END WHILE		   
             			   
            IF li_cnt == 5 THEN
               IF ls_IP[1]>=0 AND ls_IP[1]<=255 AND
                  ls_IP[2]>=0 AND ls_IP[2]<=255 AND
                  ls_IP[3]>=0 AND ls_IP[3]<=255 AND
                  ls_IP[4]>=0 AND ls_IP[4]<=255 THEN
					 
                  --DISPLAY "IP位置的格式OK"
                  LET j_param[7].prod_address = ls_IP[1].trim(),".",ls_IP[2].trim(),".",ls_IP[3].trim(),".",ls_IP[4].trim()
               ELSE
                  CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
                  --DISPLAY "數字0~255有問題"
                  NEXT FIELD portal_addr
               END IF
            ELSE
               CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！
               --DISPLAY "太多節點了"
               NEXT FIELD portal_addr
            END IF			   
         ELSE
            CALL awsi100_MessageBox("aws-00045") #aws-00045：IP位置的格式為*.*.*.* (其中的*是0~255的數字)！			
            --DISPLAY "格式不符合"
            NEXT FIELD portal_addr
         END IF
                  
      AFTER FIELD PORTAL_0002
         #檢查Website的格式
         LET ls_website = g_wset_t[72].wset002
         IF ls_website.getLength() < 18 OR ls_website.subString(1,18) != "http://[portal_ip]" THEN
            CALL awsi100_MessageBox("aws-00124") #aws-00050：網址的格式，開頭必須是http://[portal_ip]
            NEXT FIELD PORTAL_0002
         END IF
      #161102-00047#15-E
 
      AFTER INPUT
         IF INT_FLAG THEN  #取消
            LET INT_FLAG = FALSE #按下「取消」時，INT_FLAG會變成TRUE，此時要手動改回FLALSE，方便下次再使用
               
            #更新元件的資料
            DISPLAY c_wset_t[11].wset002 TO BPM_0001
            DISPLAY c_wset_t[12].wset002 TO BPM_0002
            DISPLAY c_wset_t[13].wset002 TO BPM_0003
            DISPLAY c_wset_t[14].wset002 TO BPM_0004
            DISPLAY c_wset_t[15].wset002 TO BPM_0005
            DISPLAY c_wset_t[16].wset002 TO bpm_0006            
            DISPLAY j_param[11].prod_code TO bpm_code
            DISPLAY j_param[11].prod_address TO bpm_addr    

            DISPLAY c_wset_t[21].wset002 TO EAI_0001
            DISPLAY c_wset_t[22].wset002 TO EAI_0002
            DISPLAY c_wset_t[23].wset002 TO EAI_0003
            DISPLAY c_wset_t[24].wset002 TO EAI_0004
            DISPLAY c_wset_t[25].wset002 TO EAI_0005
            DISPLAY j_param[21].prod_code TO eai_code
            DISPLAY j_param[21].prod_address TO eai_addr
            
            DISPLAY c_wset_t[31].wset002 TO MCD_0001
            DISPLAY c_wset_t[32].wset002 TO MCD_0002
            DISPLAY j_param[31].prod_code TO mcd_cdoe
            DISPLAY j_param[31].prod_address TO mcd_addr
            
            DISPLAY c_wset_t[41].wset002 TO PLM_0001
            DISPLAY c_wset_t[42].wset002 TO PLM_0002
            DISPLAY j_param[41].prod_code TO plm_code
            DISPLAY j_param[41].prod_address TO plm_addr
            
            DISPLAY c_wset_t[51].wset002 TO ECB_0001
            DISPLAY c_wset_t[52].wset002 TO ECB_0002
            DISPLAY c_wset_t[53].wset002 TO ECB_0003
            DISPLAY j_param[51].prod_code TO ecb_code
            DISPLAY j_param[51].prod_address TO ecb_addr

            DISPLAY c_wset_t[61].wset002 TO MES_0001
            #161102-00047#15-S
            DISPLAY c_wset_t[62].wset002 TO MES_0002 
            
            DISPLAY c_wset_t[71].wset002 TO PORTAL_0001
            DISPLAY c_wset_t[72].wset002 TO PORTAL_0002
            DISPLAY j_param[71].prod_code TO portal_code
            DISPLAY j_param[71].prod_address TO portal_addr
            #161102-00047#15-E
            
            RETURN
         END IF

         #檢查BPM_0005的格式
         IF c_wset_t[15].wset002 IS NULL THEN #當資料是NULL的時候，使用判斷式會有誤判，所以設為空格
            LET c_wset_t[15].wset002 = " "
         END IF
				
         IF g_wset_t[15].wset002 IS NULL THEN #當資料是NULL的時候，使用判斷式會有誤判，所以設為空格
            LET g_wset_t[15].wset002 = " "
         END IF
         
         #檢查ECB_0003的格式
         IF c_wset_t[53].wset002 IS NULL THEN #當資料是NULL的時候，使用判斷式會有誤判，所以設為空格
            LET c_wset_t[53].wset002 = " "
         END IF
				
         IF g_wset_t[53].wset002 IS NULL THEN #當資料是NULL的時候，使用判斷式會有誤判，所以設為空格
            LET g_wset_t[53].wset002 = " "
         END IF
         
         #若有修改，更新DB的資料
         FOR li_cnt = 11 TO 17				
            LET ls_name = li_cnt - 10 
            LET ls_name = ls_name.trim()
            LET ls_name = "bpm-000",ls_name

            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? AND wsetent = ? "
               CALL awsi100_update_DB(1,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF					
         END FOR
            
         FOR li_cnt = 21 TO 25				
            LET ls_name = li_cnt - 20 
            LET ls_name = ls_name.trim()
            LET ls_name = "eai-000",ls_name
				
            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? "
               CALL awsi100_update_DB(2,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF				
         END FOR
                
         FOR li_cnt = 31 TO 32				
            LET ls_name = li_cnt - 30 
            LET ls_name = ls_name.trim()
            LET ls_name = "mcd-000",ls_name
				
            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? AND wsetent = ? "                             
               CALL awsi100_update_DB(1,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF				
         END FOR
         
         FOR li_cnt = 41 TO 42				
            LET ls_name = li_cnt - 40 
            LET ls_name = ls_name.trim()
            LET ls_name = "plm-000",ls_name
				
            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? AND wsetent = ? "
               CALL awsi100_update_DB(1,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF				
         END FOR
         
         FOR li_cnt = 51 TO 53				
            LET ls_name = li_cnt - 50 
            LET ls_name = ls_name.trim()
            LET ls_name = "ecb-000",ls_name
				
            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? AND wsetent = ? "
               CALL awsi100_update_DB(1,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF				
         END FOR
         
         #161102-00047#15-S
         FOR li_cnt = 61 TO 62				
            LET ls_name = li_cnt - 60 
            LET ls_name = ls_name.trim()
            LET ls_name = "mes-000",ls_name
				
            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? AND wsetent = ? "
               CALL awsi100_update_DB(1,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF
         END FOR 

         FOR li_cnt = 71 TO 72				
            LET ls_name = li_cnt - 70 
            LET ls_name = ls_name.trim()
            LET ls_name = "portal-000",ls_name
				
            IF g_wset_t[li_cnt].wset002 != c_wset_t[li_cnt].wset002 THEN  #若有修改，更新DB的資料
               LET ls_sql = " UPDATE wset_t SET wset002 = ? WHERE wset001 = ? AND wsetent = ? "
               CALL awsi100_update_DB(1,ls_sql,g_wset_t[li_cnt].wset002,ls_name)
						
               LET c_wset_t[li_cnt].wset002 = g_wset_t[li_cnt].wset002   #若有修改，更新目前的資料
            END IF				
         END FOR
         #161102-00047#15-E
         
         #若有修改，更新JSON檔案的資料
         IF j_param[1].prod_address != j_param[11].prod_address THEN		
            LET l_value = j_param[11].prod_address
            LET j_param[11].prod_address = j_param[1].prod_address
            CALL awsi100_save_to_JSON("2",j_param[11].entID,j_param[11].prod_code,j_param[11].prod_address) RETURNING g_return_stus 
            IF g_return_stus = FALSE THEN
               LET j_param[1].prod_address  = l_value
               LET j_param[11].prod_address = l_value
               NEXT FIELD bpm_addr
            END IF               
         END IF

         IF j_param[2].prod_address != j_param[21].prod_address THEN		
            LET l_value = j_param[21].prod_address 
            LET j_param[21].prod_address = j_param[2].prod_address
            CALL awsi100_save_to_JSON("2",j_param[21].entID,j_param[21].prod_code,j_param[21].prod_address) RETURNING g_return_stus 
            IF g_return_stus = FALSE THEN
               LET j_param[2].prod_address  = l_value
               LET j_param[21].prod_address = l_value
               NEXT FIELD eai_addr
            END IF           
         END IF
         
         IF j_param[3].prod_address != j_param[31].prod_address THEN		
            LET l_value = j_param[31].prod_address
            LET j_param[31].prod_address = j_param[3].prod_address
            CALL awsi100_save_to_JSON("2",j_param[31].entID,j_param[31].prod_code,j_param[31].prod_address)	RETURNING g_return_stus 
            IF g_return_stus = FALSE THEN
               LET j_param[3].prod_address  = l_value
               LET j_param[31].prod_address = l_value
               NEXT FIELD mcd_addr
            END IF          
         END IF
         
         IF j_param[4].prod_address != j_param[41].prod_address THEN		
            LET l_value = j_param[41].prod_address
            LET j_param[41].prod_address = j_param[4].prod_address
            CALL awsi100_save_to_JSON("2",j_param[41].entID,j_param[41].prod_code,j_param[41].prod_address)	RETURNING g_return_stus 
            IF g_return_stus = FALSE THEN
               LET j_param[4].prod_address  = l_value
               LET j_param[41].prod_address = l_value
               NEXT FIELD plm_addr
            END IF           
         END IF
         
         IF j_param[5].prod_address != j_param[51].prod_address THEN		
            LET l_value = j_param[51].prod_address
            LET j_param[51].prod_address = j_param[5].prod_address
            CALL awsi100_save_to_JSON("2",j_param[51].entID,j_param[51].prod_code,j_param[51].prod_address)	RETURNING g_return_stus 
            IF g_return_stus = FALSE THEN
               LET j_param[5].prod_address  = l_value
               LET j_param[51].prod_address = l_value
               NEXT FIELD ecb_addr
            END IF         
         END IF
         
         #161102-00047#15-S
         IF j_param[7].prod_address != j_param[71].prod_address THEN		
            LET l_value = j_param[71].prod_address
            LET j_param[71].prod_address = j_param[7].prod_address
            CALL awsi100_save_to_JSON("2",j_param[71].entID,j_param[71].prod_code,j_param[71].prod_address)	RETURNING g_return_stus 
            IF g_return_stus = FALSE THEN
               LET j_param[7].prod_address  = l_value
               LET j_param[71].prod_address = l_value
               NEXT FIELD portal_addr
            END IF           
         END IF
         #161102-00047#15-E
         
      ON ACTION controlp INFIELD BPM_0005
         IF g_wset_t[16].wset002 = "1" THEN
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_ooej002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO BPM_0005 #顯示到畫面上
            LET g_wset_t[15].wset002 = g_qryparam.return1
         ELSE
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooej002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO BPM_0005 #顯示到畫面上
            LET g_wset_t[15].wset002 = g_qryparam.return1
         END IF
 
      ON ACTION step01      
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step01")
            NEXT FIELD BPM_0001
         END IF
		 
      ON ACTION step02
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step02")
            NEXT FIELD EAI_0001
         END IF
               
      ON ACTION step03
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step03")
            NEXT FIELD MCD_0001
         END IF
		 
      ON ACTION step04
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step04")
            NEXT FIELD PLM_0001
         END IF
		 
      ON ACTION step05
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step05")
            NEXT FIELD ECB_0001
         END IF
         
      ON ACTION step06
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step06")
            NEXT FIELD MES_0001
         END IF
      #161102-00047#15-S
      ON ACTION step07
         IF awsi100_check_parameter() THEN
            CALL awsi100_parameter_switch("step07")
            NEXT FIELD PORTAL_0001
         END IF
      #161102-00047#15-E
   END INPUT
 
{<point name="modify.pre_function"/>}
 
{<point name="modify.before_input"/>}
      
{<point name="modify.after_input"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.input" >}
PRIVATE FUNCTION awsi100_input(p_cmd)
{<point name="input.define_customerization" edit="c" mark="Y"/>}
   DEFINE p_cmd     LIKE type_t.chr1
{<point name="input.define"/>}
 
 
 
{<point name="input.after_set_entry"/>}
 
{<point name="input.before_input"/>}
 
{<point name="input.before.input"/>}
 
{<point name="input.b.wset001" />}
 
 
 
{<point name="input.g.wset001" />}
 
{<point name="input.c.wset001" />}
 
{<point name="input.head.b_insert" mark="Y"/>}
 
{<point name="input.head.m_insert"/>}
 
{<point name="input.head.a_insert"/>}
 
{<point name="input.head.b_update" mark="Y"/>}
 
{<point name="input.head.m_update"/>}
 
{<point name="input.head.a_update"/>}
 
{<point name="input.more_input"/>}
 
{<point name="input.before_dialog"/>}
 
{<point name="input.after_input"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.reproduce" >}
PRIVATE FUNCTION awsi100_reproduce()
{<point name="reproduce.define_customerization" edit="c" mark="Y"/>}
 
{<point name="reproduce.define"/>}
 
{<point name="reproduce.pre_function"/>}
 
{<point name="reproduce.head.b_input"/>}
 
{<point name="reproduce.head.b_insert" mark="Y"/>}
 
{<point name="reproduce.head.m_insert"/>}
 
{<point name="reproduce.head.a_insert"/>}
 
{<point name="reproduce.after_reproduce" />}
END FUNCTION
{</section>}
 
{<section id="awsi100.show" >}
PRIVATE FUNCTION awsi100_show()
{<point name="show.define_customerization" edit="c" mark="Y"/>}
 
{<point name="show.define"/>}
 
{<point name="show.before"/>}
 
{<point name="show.follow_pic"/>}
 
{<point name="show.head.reference"/>}
 
{<point name="show.after"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.delete" >}
PRIVATE FUNCTION awsi100_delete()
{<point name="delete.define_customerization" edit="c" mark="Y"/>}
 
{<point name="delete.define"/>}
 
{<point name="delete.pre_function"/>}
 
{<point name="delete.head.b_delete" mark="Y"/>}
 
{<point name="delete.befroe.related_document_remove"/>}
 
{<point name="delete.head.m_delete"/>}
 
{<point name="delete.head.a_delete"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.ui_browser_refresh" >}
PRIVATE FUNCTION awsi100_ui_browser_refresh()
{<point name="ui_browser_refresh.define_customerization" edit="c" mark="Y"/>}
 
{<point name="ui_browser_refresh.define"/>}
 
{<point name="ui_browser_refresh.pre_function"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.set_entry" >}
PRIVATE FUNCTION awsi100_set_entry(p_cmd)
{<point name="set_entry.define_customerization" edit="c" mark="Y"/>}
   DEFINE p_cmd     LIKE type_t.chr1
{<point name="set_entry.define"/>}
 
{<point name="set_entry.pre_function"/>}
 
{<point name="set_entry.field_control"/>}
 
{<point name="set_entry.after_control"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.set_no_entry" >}
PRIVATE FUNCTION awsi100_set_no_entry(p_cmd)
{<point name="set_no_entry.define_customerization" edit="c" mark="Y"/>}
   DEFINE p_cmd     LIKE type_t.chr1
{<point name="set_no_entry.define"/>}
 
{<point name="set_no_entry.pre_function"/>}
 
{<point name="set_no_entry.field_control"/>}
 
{<point name="set_no_entry.after_control"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.set_act_visible" >}
PRIVATE FUNCTION awsi100_set_act_visible()
{<point name="set_act_visible.define_customerization" edit="c" mark="Y"/>}
 
{<point name="set_act_visible.define"/>}
 
{<point name="set_act_visible.set_act_visible"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.set_act_no_visible" >}
PRIVATE FUNCTION awsi100_set_act_no_visible()
{<point name="set_act_no_visible.define_customerization" edit="c" mark="Y"/>}
 
{<point name="set_act_no_visible.define"/>}
 
{<point name="set_act_no_visible.set_act_no_visible"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.default_search" >}
PRIVATE FUNCTION awsi100_default_search()
{<point name="default_search.define_customerization" edit="c" mark="Y"/>}
 
{<point name="default_search.define"/>}
 
{<point name="default_search.pre_function"/>}
 
{<point name="default_search.before"/>}
 
{<point name="default_search.after_sql"/>}
 
{<point name="default_search.after"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.mask_functions" >}
 
{</section>}
 
{<section id="awsi100.state_change" >}
 
{</section>}
 
{<section id="awsi100.signature" >}
 
{</section>}
 
{<section id="awsi100.set_pk_array" >}
PRIVATE FUNCTION awsi100_set_pk_array()
{<point name="set_pk_array.define_customerization" edit="c" mark="Y"/>}
 
{<point name="set_pk_array.define"/>}
 
{<point name="set_pk_array.before"/>}
 
{<point name="set_pk_array.after"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.msgcentre_notify" >}
PRIVATE FUNCTION awsi100_msgcentre_notify(lc_state)
{<point name="msgcentre_notify.define_customerization" edit="c" mark="Y"/>}
   DEFINE lc_state LIKE type_t.chr80
{<point name="msgcentre_notify.define"/>}
 
{<point name="msgcentre_notify.pre_function"/>}
 
{<point name="msgcentre_notify.process"/>}
END FUNCTION
{</section>}
 
{<section id="awsi100.action_chk" >}
PRIVATE FUNCTION awsi100_action_chk()
{<point name="action_chk.define_customerization" edit="c" mark="Y"/>}
 
{<point name="action_chk.define"/>}
 
{<point name="action_chk.action_chk"/>}
END FUNCTION
{</section>}
 
