#該程式未解開Section, 採用最新樣板產出!
{<section id="aini910_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-10-22 14:21:20), PR版次:0001(2014-10-22 14:23:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: aini910_01
#+ Description: 檢視ABC分類料件
#+ Creator....: 02295(2014-10-21 15:21:27)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="aini910_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
 
#單頭 type 宣告
PRIVATE type type_g_inpi_m        RECORD
       inpi001 LIKE inpi_t.inpi001
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_inpi_d RECORD
       inpi002 LIKE inpi_t.inpi002,
       inpi002_desc LIKE type_t.chr500,
       imaa001 LIKE imaa_t.imaa001,       
       imaa001_desc LIKE type_t.chr500, 
       imaa001_desc_1 LIKE type_t.chr500, 
       imaa003 LIKE imaa_t.imaa003,
       imaa003_desc LIKE type_t.chr500,
       imaa004 LIKE imaa_t.imaa004
       END RECORD
DEFINE g_inpi_d          DYNAMIC ARRAY OF type_g_inpi_d 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_sql                 STRING
DEFINE g_error_show          LIKE type_t.num5
#end add-point
 
DEFINE g_inpi_m        type_g_inpi_m
 
   DEFINE g_inpi001_t LIKE inpi_t.inpi001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aini910_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aini910_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aini910_01 WITH FORM cl_ap_formpath("ain","aini910_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc("inpi001",'36')
   
   LET g_error_show = 1
   
   LET g_inpi_m.inpi001 = 'A'

   CALL aini910_01_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_inpi_m.inpi001 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpi001
            #add-point:BEFORE FIELD inpi001 name="input.b.inpi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpi001
            
            #add-point:AFTER FIELD inpi001 name="input.a.inpi001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpi001
            #add-point:ON CHANGE inpi001 name="input.g.inpi001"
            CALL aini910_01_b_fill()
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inpi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpi001
            #add-point:ON ACTION controlp INFIELD inpi001 name="input.c.inpi001"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_inpi_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.h_index
            
      END DISPLAY  
      #end add-point
    
      #公用action
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aini910_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aini910_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aini910_01.other_function" readonly="Y" >}

PRIVATE FUNCTION aini910_01_b_fill()

   CALL g_inpi_d.clear()
   LET l_ac = 1
   LET g_sql = " SELECT DISTINCT inpi002,rtaxl003,imaa001,imaal003,imaal004,imaa003,oocql004,imaa004 ",
               "   FROM inpi_t ",
               "        LEFT OUTER JOIN rtaxl_t ON rtaxlent = inpient AND rtaxl001 = inpi002 AND rtaxl002 = '",g_dlang,"'",
               "        LEFT OUTER JOIN imaa_t ON imaaent = inpient AND imaa009 = inpi002 ",
               "        LEFT OUTER JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
               "        LEFT OUTER JOIN oocql_t ON oocqlent = imaaent AND oocql001 = '200' AND oocql002 = imaa003 AND oocql003 = '",g_dlang,"'",
               "  WHERE inpient = '",g_enterprise,"'",
               "    AND inpisite = '",g_site,"'",
               "    AND inpi001 = '",g_inpi_m.inpi001,"'"
   PREPARE b_fill_pre FROM g_sql
   DECLARE b_fill_cs CURSOR FOR b_fill_pre  
   FOREACH b_fill_cs INTO g_inpi_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
         EXIT FOREACH
      END IF
     
      LET l_ac = l_ac + 1   
   END FOREACH 
   LET g_detail_cnt = l_ac - 1
   CALL g_inpi_d.deleteElement(g_inpi_d.getLength())
   DISPLAY g_detail_cnt TO FORMONLY.h_count   
   
#   DISPLAY ARRAY g_inpi_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)  
#   
#      BEFORE ROW
#         LET l_ac = DIALOG.getCurrentRow("s_detail1")
#         LET g_detail_idx = l_ac
#         DISPLAY g_detail_idx TO FORMONLY.h_index
#
#   END DISPLAY   
END FUNCTION

 
{</section>}
 
