#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt310_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-06-30 17:55:37), PR版次:0003(2016-03-29 15:55:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000176
#+ Filename...: aglt310_01
#+ Description: 切換帳套
#+ Creator....: 01258(2013-08-16 10:39:15)
#+ Modifier...: 02599 -SD/PR- 07675
 
{</section>}
 
{<section id="aglt310_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#17  2016/03/29 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
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
PRIVATE type type_g_glap_m        RECORD
       glapld LIKE glap_t.glapld, 
   glapld_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_glap_m        type_g_glap_m
 
   DEFINE g_glapld_t LIKE glap_t.glapld
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt310_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt310_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glapld
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
   DEFINE p_glapld        LIKE glap_t.glapld
   DEFINE l_pass          LIKE type_t.chr5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt310_01 WITH FORM cl_ap_formpath("agl","aglt310_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glap_m.glapld ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_glap_m.glapld = p_glapld
            CALL aglt310_01_glapld_desc(g_glap_m.glapld) RETURNING g_glap_m.glapld_desc
            DISPLAY BY NAME g_glap_m.glapld_desc
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapld
            
            #add-point:AFTER FIELD glapld name="input.a.glapld"
            #此段落由子樣板a05產生
            DISPLAY '' TO glapld_desc
            IF NOT cl_null(g_glap_m.glapld) THEN
               CALL aglt310_01_glapld_chk(g_glap_m.glapld)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glap_m.glapld
                  #160318-00005#17  --add--str
                   LET g_errparam.replace[1] ='agli010'
                   LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                   LET g_errparam.exeprog    ='agli010'
                   #160318-00005#17 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glapld = p_glapld
                  CALL aglt310_01_glapld_desc(g_glap_m.glapld) RETURNING g_glap_m.glapld_desc
                  DISPLAY BY NAME g_glap_m.glapld_desc 
                  NEXT FIELD glapld
               END IF
               #检查使用者是否有权限使用当前账别
               CALL s_ld_chk_authorization(g_user,g_glap_m.glapld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = g_glap_m.glapld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glapld = p_glapld
                  CALL aglt310_01_glapld_desc(g_glap_m.glapld) RETURNING g_glap_m.glapld_desc
                  DISPLAY BY NAME g_glap_m.glapld_desc 
                  NEXT FIELD glapld
               END IF 
            END IF 
            CALL aglt310_01_glapld_desc(g_glap_m.glapld) RETURNING g_glap_m.glapld_desc
            DISPLAY BY NAME g_glap_m.glapld_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapld
            #add-point:BEFORE FIELD glapld name="input.b.glapld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapld
            #add-point:ON CHANGE glapld name="input.g.glapld"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glapld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapld
            #add-point:ON ACTION controlp INFIELD glapld name="input.c.glapld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glap_m.glapld
            #CALL q_glaald()                           #呼叫開窗
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_glap_m.glapld = g_qryparam.return1
            CALL aglt310_01_glapld_desc(g_glap_m.glapld) RETURNING g_glap_m.glapld_desc
            DISPLAY BY NAME g_glap_m.glapld_desc
            DISPLAY g_qryparam.return1 TO glapld  #顯示到畫面上            
            NEXT FIELD glapld                     #返回原欄位


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
   CLOSE WINDOW w_aglt310_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      RETURN p_glapld
   END IF 
   RETURN g_glap_m.glapld
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt310_01.other_function" readonly="Y" >}
#账别说明
PRIVATE FUNCTION aglt310_01_glapld_desc(p_glapld)
   DEFINE p_glapld    LIKE glap_t.glapld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glapld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
            
END FUNCTION
#检查账套资料
PRIVATE FUNCTION aglt310_01_glapld_chk(p_glapld)
   DEFINE p_glapld    LIKE glap_t.glapld
   DEFINE l_glaastus      LIKE glaa_t.glaastus

  LET g_errno = ''

  SELECT glaastus INTO l_glaastus FROM glaa_t
   WHERE glaaent = g_enterprise
     AND glaald = p_glapld

  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00017'
     WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#17 mod #'agl-00051'
  END CASE
END FUNCTION

 
{</section>}
 
