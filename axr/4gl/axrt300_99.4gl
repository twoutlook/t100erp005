#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt300_99.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-05-06 00:00:00), PR版次:0001(2014-05-06 14:37:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: axrt300_99
#+ Description: 拋轉傳票
#+ Creator....: 01727(2014-05-06 09:42:52)
#+ Modifier...: 01727 -SD/PR- 01727
 
{</section>}
 
{<section id="axrt300_99.global" >}
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
PRIVATE type type_g_glap_m        RECORD
       glapld LIKE glap_t.glapld, 
   glapdocno LIKE glap_t.glapdocno, 
   glapdocdt LIKE glap_t.glapdocdt, 
   lbl_check LIKE type_t.chr500, 
   b_xrca038 LIKE type_t.chr500, 
   e_xrca038 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald              LIKE glaa_t.glaald
#end add-point
 
DEFINE g_glap_m        type_g_glap_m
 
   DEFINE g_glapld_t LIKE glap_t.glapld
DEFINE g_glapdocno_t LIKE glap_t.glapdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt300_99.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt300_99(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ld
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
   DEFINE p_ld            LIKE glaa_t.glaald
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt300_99 WITH FORM cl_ap_formpath("axr","axrt300_99")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_glaald = p_ld
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glap_m.glapld,g_glap_m.glapdocno,g_glap_m.glapdocdt ATTRIBUTE(WITHOUT DEFAULTS) 
 
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapld
            #add-point:BEFORE FIELD glapld name="input.b.glapld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapld
            
            #add-point:AFTER FIELD glapld name="input.a.glapld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glap_m.glapld) AND NOT cl_null(g_glap_m.glapdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glap_m.glapld != g_glapld_t  OR g_glap_m.glapdocno != g_glapdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glap_t WHERE "||"glapent = '" ||g_enterprise|| "' AND "||"glapld = '"||g_glap_m.glapld ||"' AND "|| "glapdocno = '"||g_glap_m.glapdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapld
            #add-point:ON CHANGE glapld name="input.g.glapld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocno
            #add-point:BEFORE FIELD glapdocno name="input.b.glapdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocno
            
            #add-point:AFTER FIELD glapdocno name="input.a.glapdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glap_m.glapld) AND NOT cl_null(g_glap_m.glapdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glap_m.glapld != g_glapld_t  OR g_glap_m.glapdocno != g_glapdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glap_t WHERE "||"glapent = '" ||g_enterprise|| "' AND "||"glapld = '"||g_glap_m.glapld ||"' AND "|| "glapdocno = '"||g_glap_m.glapdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocno
            #add-point:ON CHANGE glapdocno name="input.g.glapdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocdt
            #add-point:BEFORE FIELD glapdocdt name="input.b.glapdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocdt
            
            #add-point:AFTER FIELD glapdocdt name="input.a.glapdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocdt
            #add-point:ON CHANGE glapdocdt name="input.g.glapdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glapld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapld
            #add-point:ON ACTION controlp INFIELD glapld name="input.c.glapld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glap_m.glapld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glap_m.glapld = g_qryparam.return1              

            DISPLAY g_glap_m.glapld TO glapld              #

            NEXT FIELD glapld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocno
            #add-point:ON ACTION controlp INFIELD glapdocno name="input.c.glapdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glap_m.glapdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooba002()                                #呼叫開窗

            LET g_glap_m.glapdocno = g_qryparam.return1              

            DISPLAY g_glap_m.glapdocno TO glapdocno              #

            NEXT FIELD glapdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocdt
            #add-point:ON ACTION controlp INFIELD glapdocdt name="input.c.glapdocdt"
            
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
   DISPLAY 'start','end' TO b_xrca038,e_xrca038
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CALL cl_set_act_visible('close,exit',TRUE)

   #  ON ACTION cancel
   #     LET INT_FLAG = TRUE 
   #     EXIT MENU
   #
   #  ON ACTION close
   #     LET INT_FLAG = TRUE 
   #     EXIT MENU
   #
   #  ON ACTION exit
   #     LET INT_FLAG = TRUE 
   #     EXIT MENU

   END MENU
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axrt300_99 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_99.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt300_99.other_function" readonly="Y" >}

 
{</section>}
 
