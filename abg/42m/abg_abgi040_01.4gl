#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi040_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2017-01-05 10:04:26), PR版次:0001(2017-01-11 11:23:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi040_01
#+ Description: 批次修改預算類別
#+ Creator....: 05016(2017-01-05 10:02:23)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi040_01.global" >}
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
PRIVATE type type_g_bgae_m        RECORD
       l_type LIKE type_t.chr500, 
   bgae005 LIKE bgae_t.bgae005, 
   bgae008 LIKE bgae_t.bgae008
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE r_success LIKE type_t.num5
#end add-point
 
DEFINE g_bgae_m        type_g_bgae_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi040_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi040_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_bgae006,p_wc,p_bgae005,p_cnt
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
   DEFINE p_wc      STRING
   DEFINE p_bgae006 LIKE bgae_t.bgae006
   DEFINE p_bgae005 LIKE bgae_t.bgae005
   DEFINE l_sql     STRING  
   DEFINE p_cnt     LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi040_01 WITH FORM cl_ap_formpath("abg","abgi040_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CASE 
      WHEN p_cnt >= 2 
      
      WHEN p_bgae005 =4
        CALL cl_set_combo_scc_part('bgae008','9418','1,2,3,4,5')  
      WHEN p_bgae005 =7
        CALL cl_set_combo_scc_part('bgae008','9418','71,72,73,74,75')  
      OTHERWISE
   END CASE             
   CALL cl_set_combo_scc('bgae005','9407')
   LET g_bgae_m.l_type = '0'
   CALL cl_set_comp_entry('bgae008,bgae005',TRUE)
   CALL cl_set_comp_entry('bgae008',FALSE)
   LET r_success = TRUE
   LET g_bgae_m.bgae005 = '1'
   LET g_bgae_m.bgae008 = ''

   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgae_m.l_type,g_bgae_m.bgae005,g_bgae_m.bgae008 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_type
            #add-point:BEFORE FIELD l_type name="input.b.l_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_type
            
            #add-point:AFTER FIELD l_type name="input.a.l_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_type
            #add-point:ON CHANGE l_type name="input.g.l_type"
            CALL cl_set_comp_entry('bgae008,bgae005',TRUE)
            IF g_bgae_m.l_type = '0' THEN
               LET g_bgae_m.bgae005 = '1' 
               CALL cl_set_comp_entry('bgae008',FALSE)
               LET g_bgae_m.bgae008 = ''
            ELSE
               CALL cl_set_comp_entry('bgae005',FALSE)
               LET g_bgae_m.bgae005 = ''
               IF p_cnt >= 2 THEN  
                  LET g_success= FALSE 
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'abg-00326' #符合條件的預算大類超過兩種以上，不可執行。
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                                            
                  LET g_bgae_m.l_type = '0' 
                  CALL cl_set_comp_entry('bgae005',TRUE)
                  LET g_bgae_m.bgae005 = '1'
                  DISPLAY BY NAME g_bgae_m.l_type,g_bgae_m.bgae005                   
                  NEXT FIELD CURRENT
               END IF                               
               IF p_bgae005 NOT MATCHES '[47]' THEN
                  LET g_success= FALSE 
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'abg-00327' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()         
                  LET g_bgae_m.l_type = '0' 
                  CALL cl_set_comp_entry('bgae005',TRUE)
                  LET g_bgae_m.bgae005 = '1'
                  DISPLAY BY NAME g_bgae_m.l_type,g_bgae_m.bgae005 
                  NEXT FIELD CURRENT
               END IF                  
            END IF
  
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae005
            #add-point:BEFORE FIELD bgae005 name="input.b.bgae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae005
            
            #add-point:AFTER FIELD bgae005 name="input.a.bgae005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgae005
            #add-point:ON CHANGE bgae005 name="input.g.bgae005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae008
            #add-point:BEFORE FIELD bgae008 name="input.b.bgae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae008
            
            #add-point:AFTER FIELD bgae008 name="input.a.bgae008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgae008
            #add-point:ON CHANGE bgae008 name="input.g.bgae008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.l_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_type
            #add-point:ON ACTION controlp INFIELD l_type name="input.c.l_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae005
            #add-point:ON ACTION controlp INFIELD bgae005 name="input.c.bgae005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgae008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae008
            #add-point:ON ACTION controlp INFIELD bgae008 name="input.c.bgae008"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
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
   CLOSE WINDOW w_abgi040_01 
   
   #add-point:input段after input name="input.post_input"
   
   
   
   LET g_success = TRUE
   IF INT_FLAG THEN
      LET g_success= FALSE
      LET INT_FLAG = 0
   ELSE           
      CASE g_bgae_m.l_type
         WHEN 0
            LET l_sql = " UPDATE bgae_t SET bgae005 = '",g_bgae_m.bgae005,"',bgae008 = ''  ",
                        "  WHERE bgaeent = ",g_enterprise," AND bgae006 = '",p_bgae006,"' AND ",p_wc
         WHEN 1
            LET l_sql = " UPDATE bgae_t SET bgae008 = '",g_bgae_m.bgae008,"'  ",
                        "  WHERE bgaeent = ",g_enterprise," AND bgae006 = '",p_bgae006,"' AND ",p_wc
      END CASE
      PREPARE abgi040_01_upd FROM l_sql
      EXECUTE abgi040_01_upd  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgae_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE
         RETURN 
      END IF
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi040_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi040_01.other_function" readonly="Y" >}

 
{</section>}
 
