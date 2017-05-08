#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt530_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-24 11:05:19), PR版次:0001(2015-11-26 14:44:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: afmt530_02
#+ Description: 產生計提投資收益單別
#+ Creator....: 06821(2015-11-24 11:03:38)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="afmt530_02.global" >}
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
PRIVATE type type_g_fmms_m        RECORD
       fmmsdocno LIKE fmms_t.fmmsdocno
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ar             DYNAMIC ARRAY OF RECORD
                  chr   LIKE type_t.chr100,
                  #dat   LIKE type_t.dat,
                  num   LIKE type_t.num5
                    END RECORD
#end add-point
 
DEFINE g_fmms_m        type_g_fmms_m
 
   DEFINE g_fmmsdocno_t LIKE fmms_t.fmmsdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmt530_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION afmt530_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_docno,p_ld,p_comp
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
   DEFINE p_docno     LIKE fmmj_t.fmmjdocno
   DEFINE p_ld        LIKE glaa_t.glaald
   DEFINE p_comp      LIKE glaa_t.glaacomp
   DEFINE g_docno     LIKE fmmj_t.fmmjdocno
   DEFINE g_ld        LIKE glaa_t.glaald
   DEFINE g_comp      LIKE glaa_t.glaacomp
   DEFINE l_chr       LIKE type_t.chr1
   DEFINE l_fmmjdocdt LIKE fmmj_t.fmmjdocdt #單據日期
   DEFINE l_num       LIKE type_t.num5      #接元件回傳值
   DEFINE l_glav004   LIKE glav_t.glav004   #接元件回傳值
   DEFINE g_glaa024   LIKE glaa_t.glaa024   #單據別參照表號
   DEFINE g_glaa003   LIKE glaa_t.glaa003   #會計週期參照表號
   DEFINE g_accdate_s LIKE glav_t.glav004   #當期起始日
   DEFINE g_accdate_e LIKE glav_t.glav004   #當期起始日
   DEFINE g_yy        LIKE glav_t.glav002   #單據年度
   DEFINE g_mm        LIKE glav_t.glav006   #單據期別  
   DEFINE r_success   LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afmt530_02 WITH FORM cl_ap_formpath("afm","afmt530_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_docno = p_docno 
   LET g_ld    = p_ld    
   LET g_comp  = p_comp  
   
   CALL s_ld_sel_glaa(g_ld,'glaa003|glaa024') RETURNING g_sub_success,g_glaa003,g_glaa024

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fmms_m.fmmsdocno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsdocno
            #add-point:BEFORE FIELD fmmsdocno name="input.b.fmmsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsdocno
            
            #add-point:AFTER FIELD fmmsdocno name="input.a.fmmsdocno"
            #應用 a05 樣板自動產生(Version:2)
            IF NOT cl_null(g_fmms_m.fmmsdocno) THEN
               IF NOT s_aooi200_fin_chk_docno(p_ld,'','',g_fmms_m.fmmsdocno,g_today,'afmt560') THEN
                  LET g_fmms_m.fmmsdocno = ''
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_get_doc_para(p_ld,g_comp,g_fmms_m.fmmsdocno,'D-FIN-0032') RETURNING l_chr
                IF l_chr = 'Y' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aap-00237'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_fmms_m.fmmsdocno = ''
                   NEXT FIELD CURRENT                  
                END IF
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmsdocno
            #add-point:ON CHANGE fmmsdocno name="input.g.fmmsdocno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsdocno
            #add-point:ON ACTION controlp INFIELD fmmsdocno name="input.c.fmmsdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmms_m.fmmsdocno
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = "afmt560"
            LET g_qryparam.where =  " EXISTS ( SELECT 1 FROM ooac_t ",
                                    "  WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                    "    AND ooac003 = 'D-FIN-0032' AND (ooac004 <> 'Y' OR ooac004 IS NULL)) "  #只能選不產生傳票的單別
            CALL q_ooba002_1()
            LET g_fmms_m.fmmsdocno = g_qryparam.return1   
            DISPLAY BY NAME g_fmms_m.fmmsdocno               #顯示到畫面上
            NEXT FIELD CURRENT                               #返回原欄位
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
   CLOSE WINDOW w_afmt530_02 
   
   #add-point:input段after input name="input.post_input"
   LET r_success= TRUE
   IF INT_FLAG THEN
      LET g_errno = 'sub-00678'
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      IF NOT cl_null(g_docno)THEN
         #取得單據日期
         SELECT fmmjdocdt INTO l_fmmjdocdt FROM fmmj_t WHERE fmmjent = g_enterprise AND fmmjdocno = g_docno

         #取得會計當期起始日
         CALL s_get_accdate(g_glaa003,l_fmmjdocdt,'','')
               RETURNING g_sub_success,g_errno,g_yy,
                         l_num,l_glav004,l_glav004,
                         g_mm,g_accdate_s,g_accdate_e,
                         l_num,l_glav004,l_glav004

         CALL g_ar.clear()
         LET g_ar[1].num = g_yy
         LET g_ar[2].num = g_mm
         LET g_ar[1].chr = g_comp
         LET g_ar[2].chr = g_ld

         CALL s_afmt530_ins_fmms(g_ar,g_fmms_m.fmmsdocno,g_docno) RETURNING g_sub_success,g_errno          
      END IF
      IF NOT g_sub_success THEN
         LET r_success = FALSE        
      END IF
   END IF
   
   RETURN r_success,g_errno
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt530_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afmt530_02.other_function" readonly="Y" >}

 
{</section>}
 
