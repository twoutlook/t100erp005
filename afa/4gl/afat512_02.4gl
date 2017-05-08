#該程式未解開Section, 採用最新樣板產出!
{<section id="afat512_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-07-13 14:46:43), PR版次:0001(2015-07-14 14:47:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: afat512_02
#+ Description: 資產部門轉移產生
#+ Creator....: 02114(2015-07-13 14:45:53)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="afat512_02.global" >}
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
PRIVATE type type_g_faba_m        RECORD
       fabadocno LIKE faba_t.fabadocno, 
   fabadocdt LIKE faba_t.fabadocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_faba_m        type_g_faba_m
 
   DEFINE g_fabadocno_t LIKE faba_t.fabadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afat512_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat512_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_comp
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
   DEFINE p_comp          LIKE fabr_t.fabrcomp
   DEFINE r_success       LIKE type_t.num10
   DEFINE r_errno         LIKE gzze_t.gzze001 
   DEFINE l_ld            LIKE glaa_t.glaald
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat512_02 WITH FORM cl_ap_formpath("afa","afat512_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_faba_m.fabadocdt = g_today
   SELECT glaald,glaa024 INTO l_ld,l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_comp
      AND glaa014 = 'Y'
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_faba_m.fabadocno,g_faba_m.fabadocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocno
            #add-point:BEFORE FIELD fabadocno name="input.b.fabadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocno
            
            #add-point:AFTER FIELD fabadocno name="input.a.fabadocno"
            IF NOT cl_null(g_faba_m.fabadocno) THEN            
               IF NOT s_aooi200_fin_chk_slip(l_ld,l_glaa024,g_faba_m.fabadocno,'afat421') THEN
                  LET g_faba_m.fabadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabadocno
            #add-point:ON CHANGE fabadocno name="input.g.fabadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocdt
            #add-point:BEFORE FIELD fabadocdt name="input.b.fabadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocdt
            
            #add-point:AFTER FIELD fabadocdt name="input.a.fabadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabadocdt
            #add-point:ON CHANGE fabadocdt name="input.g.fabadocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocno
            #add-point:ON ACTION controlp INFIELD fabadocno name="input.c.fabadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faba_m.fabadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "afat421"

            CALL q_ooba002_1()                            #呼叫開窗

            LET g_faba_m.fabadocno = g_qryparam.return1              

            DISPLAY g_faba_m.fabadocno TO fabadocno              #

            NEXT FIELD fabadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocdt
            #add-point:ON ACTION controlp INFIELD fabadocdt name="input.c.fabadocdt"
            
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
   IF INT_FLAG THEN
      LET g_faba_m.fabadocno = ''
      LET g_faba_m.fabadocdt = ''
      LET INT_FLAG = 0
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_afat512_02 
   
   #add-point:input段after input name="input.post_input"
   RETURN l_ld,g_faba_m.fabadocno,g_faba_m.fabadocdt
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat512_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat512_02.other_function" readonly="Y" >}

 
{</section>}
 
