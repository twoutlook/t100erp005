#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp330_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-03-23 11:56:42), PR版次:0004(2017-01-17 12:27:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000217
#+ Filename...: aapp330_01
#+ Description: 拋轉傳票
#+ Creator....: 02097(2014-05-21 15:05:28)
#+ Modifier...: 04152 -SD/PR- 06694
 
{</section>}
 
{<section id="aapp330_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150416-00004#2   2015/04/27  By Belle    選總帳單別時,迴轉傳票性質 應開aglt350的開窗
#161208-00065#1   2016/12/09  By 01531    單別有設定預設傳票單別, 卻沒有帶出來预设的单别 
#161213-00023#2   2017/01/12  By 06694    新增aapp330_01元件單別參數，默認拋轉單別
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
       glapdocno LIKE glap_t.glapdocno, 
   glapdocdt LIKE glap_t.glapdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004      LIKE ooef_t.ooef004
#end add-point
 
DEFINE g_glap_m        type_g_glap_m
 
   DEFINE g_glapdocno_t LIKE glap_t.glapdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp330_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapp330_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ld,p_docdt,p_cate,p_slip           #161213-00023#2 add p_slip
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
   DEFINE p_ld             LIKE apca_t.apcald
   DEFINE p_docdt          LIKE apca_t.apcadocdt
   DEFINE p_cate           LIKE gzza_t.gzza001     #150416-00004#2
   DEFINE p_wc             STRING
   DEFINE l_glaacomp       LIKE glaa_t.glaacomp
   DEFINE l_glaa100        LIKE glaa_t.glaa100
   DEFINE l_glaa024        LIKE glaa_t.glaa024
   DEFINE l_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_chr            LIKE type_t.chr1        #150416-00004#2
   DEFINE l_glca002        LIKE glca_t.glca002     #150416-00004#2
   DEFINE l_prog           LIKE gzza_t.gzza001     #150416-00004#2
   DEFINE l_gl_slip        LIKE ooba_t.ooba002        #161208-00065#1  
   DEFINE l_slip           LIKE ooba_t.ooba002        #161208-00065#1 
   DEFINE l_success        LIKE type_t.num5           #161208-00065#1    
   DEFINE p_slip           LIKE glap_t.glapdocno      #161213-00023#2
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapp330_01 WITH FORM cl_ap_formpath("aap","aapp330_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   SELECT glaacomp,glaa100,glaa024
     INTO l_glaacomp,l_glaa100,l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
   SELECT ooef004 INTO g_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = l_glaacomp

   IF l_glaa100 = 'Y' THEN
      CALL cl_set_comp_visible('cont_no',FALSE)
   ELSE
      CALL cl_set_comp_visible('cont_no',TRUE)
   END IF
   LET l_glapdocno = ''
   
   #傳票日期預帶t920單據日期
   LET g_glap_m.glapdocdt = p_docdt
   
   
   #取得單別
   CALL s_aooi200_fin_get_slip(p_slip) RETURNING l_success,l_slip   #161213-00023#2
   
   #161208-00065#1 add s---
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(p_ld,l_glaacomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip  #161213-00023#2 modi p_cate -> l_slip
   IF NOT cl_null(l_gl_slip) THEN 
      LET g_glap_m.glapdocno = l_gl_slip
   END IF
   #161208-00065#1 add e---   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glap_m.glapdocno,g_glap_m.glapdocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         ON ACTION cont_no
            IF cl_null(g_glap_m.glapdocdt) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00331'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            IF cl_null(g_glap_m.glapdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00332'
               LET g_errparam.extend = s_fin_get_colname('aapp330','glapdocno')
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            IF NOT cl_null(g_glap_m.glapdocdt) AND NOT  cl_null(g_glap_m.glapdocno) THEN
               CALL s_transaction_begin()
               CALL s_fin_continue_no_input(p_ld,'',g_glap_m.glapdocno,g_glap_m.glapdocdt,'3')
               CALL s_transaction_end('Y','Y')
           END IF
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocno
            #add-point:BEFORE FIELD glapdocno name="input.b.glapdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocno
            
            #add-point:AFTER FIELD glapdocno name="input.a.glapdocno"
            IF NOT cl_null(g_glap_m.glapdocno) THEN
               LET l_chr = 'N'      #不迴轉
               CASE p_cate
                    WHEN 'P40'       #重評價(t920)
                         SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
                           FROM glca_t
                          WHERE glcaent = g_enterprise
                            AND glcald  = p_ld AND glca001 = 'AP'
                    WHEN 'P60'       #壞帳(t940)
                         SELECT (CASE WHEN glcb002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
                           FROM glcb_t
                          WHERE glcbent = g_enterprise
                            AND glcbld  = p_ld AND glcb001 = 'AP'
               END CASE
               IF l_chr = 'Y' THEN
                  LET l_prog = 'aglt350'
               ELSE
                  LET l_prog = 'aglt310'
               END IF
               IF NOT s_aooi200_fin_chk_docno(p_ld,'','',g_glap_m.glapdocno,g_glap_m.glapdocdt,l_prog) THEN
                  IF l_glaa100 = 'Y' THEN
                     IF cl_null(l_glapdocno) OR l_glapdocno <> g_glap_m.glapdocno THEN
                        DELETE FROM s_fin_tmp_conti_no
                     END IF
                  END IF
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET l_glapdocno = g_glap_m.glapdocno
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
                  #Ctrlp:input.c.glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocno
            #add-point:ON ACTION controlp INFIELD glapdocno name="input.c.glapdocno"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
   			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glap_m.glapdocno
            LET g_qryparam.arg1 = l_glaa024
            LET l_chr = 'N'      #不迴轉
            CASE p_cate
                 WHEN 'P40'       #重評價(t920)
                      SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
                        FROM glca_t
                       WHERE glcaent = g_enterprise
                         AND glcald  = p_ld AND glca001 = 'AP'
                 WHEN 'P60'       #壞帳(t940)
                      SELECT (CASE WHEN glcb002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
                        FROM glcb_t
                       WHERE glcbent = g_enterprise
                         AND glcbld  = p_ld AND glcb001 = 'AP'
            END CASE
            IF l_chr = 'Y' THEN
               LET g_qryparam.arg2 = 'aglt350'
            ELSE
               LET g_qryparam.arg2 = 'aglt310'
            END IF
            CALL q_ooba002_1()
            LET g_glap_m.glapdocno = g_qryparam.return1
            DISPLAY g_glap_m.glapdocno TO glapdocno
            NEXT FIELD glapdocno
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapp330_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      RETURN '',''
   END IF
   
   RETURN g_glap_m.glapdocno,g_glap_m.glapdocdt
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapp330_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapp330_01.other_function" readonly="Y" >}

 
{</section>}
 
