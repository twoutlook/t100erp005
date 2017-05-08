#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt420_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-04-09 09:40:39), PR版次:0001(2016-03-30 10:37:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000116
#+ Filename...: aglt420_01
#+ Description: 傳票拋轉
#+ Creator....: 02599(2014-12-07 22:04:04)
#+ Modifier...: 02599 -SD/PR- 07675
 
{</section>}
 
{<section id="aglt420_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#19  2016/03/29 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
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
       glapdocno_01 LIKE type_t.chr20, 
   glapdocdt LIKE glap_t.glapdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa013             LIKE glaa_t.glaa013
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_glaa121             LIKE glaa_t.glaa121
DEFINE g_glaa100             LIKE glaa_t.glaa100
DEFINE g_glapdocdt_t         LIKE glap_t.glapdocdt
#end add-point
 
DEFINE g_glap_m        type_g_glap_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt420_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt420_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glceld,p_glcecomp,p_glce001,p_glce002
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
   DEFINE p_glceld        LIKE glce_t.glceld
   DEFINE p_glcecomp      LIKE glce_t.glcecomp
   DEFINE p_glce001       LIKE glce_t.glce001
   DEFINE p_glce002       LIKE glce_t.glce002
   DEFINE l_wc            STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_glcedocno     LIKE glce_t.glcedocno
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_flag_qs       LIKE type_t.num5 #标记是否已选取了缺省传票号
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt420_01 WITH FORM cl_ap_formpath("agl","aglt420_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET l_flag_qs = FALSE 
   
   SELECT glaa013,glaa024,glaa100,glaa121 
     INTO g_glaa013,g_glaa024,g_glaa100,g_glaa121
     FROM glaa_t 
   WHERE glaaent = g_enterprise AND glaald = p_glceld
   CALL cl_set_comp_visible("docno",FALSE)
   IF g_glaa100 = 'Y' THEN
      CALL cl_set_comp_visible('cont_no',FALSE)
    ELSE
      CALL cl_set_comp_visible('cont_no',TRUE)
    END IF
   #抓取当期最后一天
   SELECT MAX(glav004) INTO g_glap_m.glapdocdt FROM glav_t
    WHERE glavent=g_enterprise 
      AND glav001=(SELECT glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_glceld)
      AND glav002=p_glce001 AND glav006=p_glce002
   DISPLAY BY NAME g_glap_m.glapdocdt   
   LET g_glapdocdt_t = g_glap_m.glapdocdt 
   LET r_start_no = ''
   LET r_end_no = ''
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glap_m.glapdocno_01,g_glap_m.glapdocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocno_01
            #add-point:BEFORE FIELD glapdocno_01 name="input.b.glapdocno_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocno_01
            
            #add-point:AFTER FIELD glapdocno_01 name="input.a.glapdocno_01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocno_01
            #add-point:ON CHANGE glapdocno_01 name="input.g.glapdocno_01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocdt
            #add-point:BEFORE FIELD glapdocdt name="input.b.glapdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocdt
            
            #add-point:AFTER FIELD glapdocdt name="input.a.glapdocdt"
            IF NOT cl_null(g_glap_m.glapdocdt) THEN
               IF g_glap_m.glapdocdt < g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00160'
                  LET g_errparam.extend = g_glap_m.glapdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glapdocdt = ''
                  NEXT FIELD glapdocdt
               END IF 
               SELECT DISTINCT glav002,glav006 INTO l_glav002,l_glav006
                 FROM glav_t
                WHERE glavent=g_enterprise 
                  AND glav001=(SELECT glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_glceld)
                  AND glav004=g_glap_m.glapdocdt
               IF l_glav002 <> p_glce001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00321'
                  LET g_errparam.extend = g_glap_m.glapdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glap_m.glapdocdt = ''
                  NEXT FIELD glapdocdt
               END IF
               IF l_glav006 <> p_glce002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00322'
                  LET g_errparam.extend = g_glap_m.glapdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glap_m.glapdocdt = ''
                  NEXT FIELD glapdocdt
               END IF
               IF g_glapdocdt_t <> g_glap_m.glapdocdt THEN
                  DELETE FROM s_fin_tmp_conti_no
                  IF l_flag_qs = TRUE THEN
                     IF cl_ask_confirm("agl-00333") THEN
                        LET g_glapdocdt_t = g_glap_m.glapdocdt
                        NEXT FIELD glapdocdt
                     END IF
                  END IF
               END IF
               LET g_glapdocdt_t = g_glap_m.glapdocdt
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocdt
            #add-point:ON CHANGE glapdocdt name="input.g.glapdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glapdocno_01
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocno_01
            #add-point:ON ACTION controlp INFIELD glapdocno_01 name="input.c.glapdocno_01"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glap_m.glapdocno_01             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = 'aglt310'

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_glap_m.glapdocno_01 = g_qryparam.return1              

            DISPLAY g_glap_m.glapdocno_01 TO glapdocno_01              #

            NEXT FIELD glapdocno_01                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocdt
            #add-point:ON ACTION controlp INFIELD glapdocdt name="input.c.glapdocdt"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            ELSE
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               LET r_success = TRUE
               IF g_glaa121 = 'Y' THEN 
                  SELECT glcedocno INTO l_glcedocno FROM glce_t
                  WHERE glceent=g_enterprise AND glceld=p_glceld AND glce001=p_glce001 AND glce002=p_glce002
                  LET l_wc=" glgadocno = '",l_glcedocno,"' "
                  CALL s_pre_voucher_ins_glap('GL','TH',p_glceld,g_glap_m.glapdocdt,g_glap_m.glapdocno_01,'1',l_wc) 
                  RETURNING r_success,r_start_no,r_end_no
               ELSE
                  #總帳期末調匯
                  LET l_wc = "glce001 = ",p_glce001," AND glce002 =",p_glce002
                  CALL s_aglt420_gen_ar('1',p_glceld,g_glap_m.glapdocdt,g_glap_m.glapdocno_01,1,l_wc,'N') 
                  RETURNING r_success,r_start_no,r_end_no
               END IF
               IF r_success = TRUE AND NOT cl_null(r_start_no) THEN
                  UPDATE glce_t SET glce005=r_start_no 
                   WHERE glceent = g_enterprise AND glceld = p_glceld
                     AND glce001 = p_glce001 AND glce002 = p_glce002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "update glce_t"
                     LET g_errparam.code   = SQLCA.SQLCODE
                     LET g_errparam.popup  = TRUE      
                     CALL cl_err()
                     LET r_success = FALSE 
                  END IF 
               END IF
               
               IF r_success = FALSE THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      ON ACTION cont_no
         IF cl_null(g_glap_m.glapdocno_01) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00332'
            LET g_errparam.extend = s_fin_get_colname('','glapdocno')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CONTINUE DIALOG
         END IF
         IF cl_null(g_glap_m.glapdocdt) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00331'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CONTINUE DIALOG
         END IF
         
         CALL s_transaction_begin()
         CALL s_fin_continue_no_input(p_glceld,'',g_glap_m.glapdocno_01,g_glap_m.glapdocdt,'3')
         CALL s_transaction_end('Y','Y')
         LET l_cnt = 0
         #判断是否选取缺省传票编号
         SELECT COUNT(*) INTO l_cnt FROM s_fin_tmp_conti_no WHERE sel='Y'
         IF l_cnt > 0 THEN
            LET l_flag_qs = TRUE
         ELSE
            LET l_flag_qs = FALSE
         END IF
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
   IF r_success AND NOT cl_null(r_start_no) THEN
      CALL cl_set_comp_visible("docno",TRUE)
      DISPLAY r_start_no TO FORMONLY.docno
   END IF
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CALL cl_set_act_visible('close,exit',TRUE)
   END MENU

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aglt420_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN r_start_no
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt420_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt420_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單據別檢查
# Memo...........:
# Usage..........: CALL aglt420_01_glapdocno_chk(p_glapdocno)
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt420_01_glapdocno_chk(p_glapdocno)
   DEFINE p_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_oobastus       LIKE ooba_t.oobastus
   
   LET g_errno = '' 
   SELECT oobastus INTO l_oobastus 
     FROM ooba_t LEFT OUTER JOIN oobx_t ON (oobaent=oobxent AND ooba002=oobx001)
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024      #单据别参照表号
      AND ooba002 = p_glapdocno    #单据别
      AND oobx002 = 'AGL'          #模组 
      AND oobx003 = 'aglt310'      #单据性质
   CASE
      WHEN SQLCA.SQLCODE =100  LET g_errno = 'aim-00056'
      WHEN l_oobastus = 'N'    LET g_errno = 'sub-01302'  #160318-00005#19 mod#'aim-00057'
   END CASE
END FUNCTION

 
{</section>}
 
