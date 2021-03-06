#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt590_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-04-20 14:07:59), PR版次:0003(2017-01-23 10:04:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: aapt590_02
#+ Description: 產生沖帳資料
#+ Creator....: 02097(2016-04-20 14:07:02)
#+ Modifier...: 02097 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt590_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#170123-00010#1   2017/01/23  By 06821    SQL中缺乏ent條件
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apda_m        RECORD
       apdadocno LIKE apda_t.apdadocno, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apda003 LIKE apda_t.apda003, 
   l_apda003_desc LIKE type_t.chr80, 
   apde008 LIKE apde_t.apde008, 
   l_apde008_desc LIKE type_t.chr80, 
   apde011 LIKE apde_t.apde011, 
   l_apde011_desc LIKE type_t.chr80, 
   apde012 LIKE apde_t.apde012, 
   l_apde012_desc LIKE type_t.chr80, 
   apdald LIKE apda_t.apdald
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apgncomp    LIKE apgn_t.apgncomp
DEFINE g_apgndocno   LIKE apgn_t.apgndocno
DEFINE g_glaald      LIKE glaa_t.glaald
DEFINE g_glaa005     LIKE glaa_t.glaa005
DEFINE g_glaa024     LIKE glaa_t.glaa024
DEFINE g_sql_bank    STRING
#end add-point
 
DEFINE g_apda_m        type_g_apda_m
 
   DEFINE g_apdadocno_t LIKE apda_t.apdadocno
DEFINE g_apdald_t LIKE apda_t.apdald
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt590_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt590_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_comp,p_docno
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
   DEFINE p_comp           LIKE apgn_t.apgncomp
   DEFINE p_docno          LIKE apgn_t.apgndocno
   
   DEFINE lc_param_apgn    RECORD
            apdadocno      LIKE apda_t.apdadocno,
            apdadocdt      LIKE apda_t.apdadocdt,
            apda003        LIKE apda_t.apda003,
            apde008        LIKE apde_t.apde008,
            apde011        LIKE apde_t.apde011,
            apde012        LIKE apde_t.apde012
                       END RECORD
   DEFINE l_str_apgn       STRING
   DEFINE l_apgn100        LIKE apgn_t.apgn100
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt590_02 WITH FORM cl_ap_formpath("aap","aapt590_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_apgncomp = p_comp
   LET g_apgndocno= p_docno
   CALL s_fin_get_major_ld(g_apgncomp) RETURNING g_glaald
   CALL s_ld_sel_glaa(g_glaald,'glaa005|glaa024')
        RETURNING g_sub_success,g_glaa005,g_glaa024
   LET g_sql_bank = NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda003,g_apda_m.apde008,g_apda_m.apde011, 
          g_apda_m.apde012,g_apda_m.apdald ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF g_sys = 'AAP' THEN
               SELECT apgn002,apgndocdt,apgn100
                 INTO g_apda_m.apdadocno,g_apda_m.apdadocdt,l_apgn100
                 FROM apgn_t
                WHERE apgnent = g_enterprise
                  AND apgncomp= g_apgncomp AND apgndocno = g_apgndocno
            END IF
            IF g_sys = 'AXR' THEN
               SELECT xrgf009,xrgfdocdt,xrgf100
                 INTO g_apda_m.apdadocno,g_apda_m.apdadocdt,l_apgn100
                 FROM xrgf_t
                WHERE xrgfent = g_enterprise
                  AND xrgfcomp= g_apgncomp AND xrgfdocno = g_apgndocno
            END IF
            LET g_apda_m.apda003 = g_user
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.l_apda003_desc
            DISPLAY BY NAME g_apda_m.l_apda003_desc
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="input.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="input.a.apdadocno"
            IF NOT cl_null(g_apda_m.apdadocno) THEN
               IF g_sys = 'AAP' THEN
                  IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,'aapt420') THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF g_sys = 'AXR' THEN
                  IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,'axrt400') THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocno
            #add-point:ON CHANGE apdadocno name="input.g.apdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="input.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="input.a.apdadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocdt
            #add-point:ON CHANGE apdadocdt name="input.g.apdadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="input.a.apda003"
            LET g_apda_m.l_apda003_desc = ''
            IF NOT cl_null(g_apda_m.apda003) THEN
               LET g_errno = ''
               CALL s_employee_chk(g_apda_m.apda003) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_apda_m.apda003 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.l_apda003_desc
            DISPLAY BY NAME g_apda_m.l_apda003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="input.b.apda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda003
            #add-point:ON CHANGE apda003 name="input.g.apda003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="input.a.apde008"
            IF NOT cl_null(g_apda_m.apde008) THEN
               LET g_chkparam.arg1 = g_apda_m.apde008
               LET g_chkparam.arg2 = g_apgncomp
               LET g_chkparam.arg3 = '1'
               IF cl_chk_exist("v_nmas002_4") THEN
                   IF NOT s_anmi120_nmll002_chk(g_apda_m.apde008,g_user) THEN
                      LET g_apda_m.apde008 = ''
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.code   = 'anm-00574' 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      NEXT FIELD CURRENT
                   END IF
               ELSE
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_apda_m.l_apde008_desc = s_desc_get_nmas002_desc(g_apda_m.apde008)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="input.b.apde008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde008
            #add-point:ON CHANGE apde008 name="input.g.apde008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="input.a.apde011"
            LET g_apda_m.l_apde011_desc = ''
            IF NOT cl_null(g_apda_m.apde011) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apda_m.apde011
               LET g_chkparam.arg2 = '2'
               LET g_errshow = TRUE
               IF NOT cl_chk_exist("v_nmaj001_1") THEN
                  NEXT FIELD CURRENT
               END IF
               LET g_apda_m.apde012 = s_anm_get_nmad003(g_glaa005,g_apda_m.apde011)
               LET g_apda_m.l_apde011_desc = s_desc_get_nmajl003_desc(g_apda_m.apde011)
               LET g_apda_m.l_apde012_desc = s_desc_get_nmail004_desc(g_glaa005,g_apda_m.apde012)
               DISPLAY BY NAME g_apda_m.apde011,g_apda_m.apde012,g_apda_m.l_apde011_desc,g_apda_m.l_apde012_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="input.b.apde011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde011
            #add-point:ON CHANGE apde011 name="input.g.apde011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="input.a.apde012"
            LET g_apda_m.l_apde012_desc = ''
            IF NOT cl_null(g_apda_m.apde012) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apda_m.apde012
               LET g_chkparam.arg2 = g_glaa005
               LET g_errshow = TRUE
               IF NOT cl_chk_exist("v_nmai002") THEN
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_apda_m.l_apde012_desc = s_desc_get_nmail004_desc(g_glaa005,g_apda_m.apde012)
            DISPLAY BY NAME g_apda_m.l_apde012_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="input.b.apde012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde012
            #add-point:ON CHANGE apde012 name="input.g.apde012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_apda_m.apdald) AND NOT cl_null(g_apda_m.apdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t  OR g_apda_m.apdadocno != g_apdadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apda_t WHERE "||"apdaent = '" ||g_enterprise|| "' AND "||"apdald = '"||g_apda_m.apdald ||"' AND "|| "apdadocno = '"||g_apda_m.apdadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdald
            #add-point:ON CHANGE apdald name="input.g.apdald"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="input.c.apdadocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdadocno
            LET g_qryparam.arg1 = g_glaa024
            IF g_sys = 'AAP' THEN
               LET g_qryparam.arg2 = 'aapt420'
            END IF
            IF g_sys = 'AXR' THEN
               LET g_qryparam.arg2 = 'axrt400'
            END IF
            LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                          "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                          "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'Y') "  #只能選產生傳票的單別
            CALL q_ooba002_1()
            LET g_apda_m.apdadocno = g_qryparam.return1
            DISPLAY g_apda_m.apdadocno TO apdadocno
            NEXT FIELD apdadocno
            #END add-point
 
 
         #Ctrlp:input.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="input.c.apdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="input.c.apda003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda003
            CALL q_ooag001()                          
            LET g_apda_m.apda003 = g_qryparam.return1    
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.l_apda003_desc
            DISPLAY BY NAME g_apda_m.apda003,g_apda_m.l_apda003_desc
            NEXT FIELD apda003
            #END add-point
 
 
         #Ctrlp:input.c.apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="input.c.apde008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE                  
            LET g_qryparam.default1 = g_apda_m.apde008
            LET g_qryparam.where =  " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                    "              AND ooef017 = '",g_apgncomp,"')",                  
                                    #" AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",                                  #170123-00010#1 mark
                                    " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmagent = '",g_enterprise,"' AND nmag001 = nmaa003 ",  #170123-00010#1 add
                                    " AND nmag002 IN ('1','5'))",
                                    " AND nmas002 IN (",g_sql_bank,")",
                                    " AND nmas003 ='",l_apgn100,"'"
            CALL q_nmas_01()                                #呼叫開窗
            LET g_apda_m.apde008 = g_qryparam.return1
            DISPLAY g_apda_m.apde008 TO apde008
            NEXT FIELD apde008
            #END add-point
 
 
         #Ctrlp:input.c.apde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="input.c.apde011"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_apda_m.apde011
            CALL q_nmaj001()                                             #呼叫開窗
            LET g_apda_m.apde011 = g_qryparam.return1
            LET g_apda_m.apde012 = s_anm_get_nmad003(g_glaa005,g_apda_m.apde011)
            LET g_apda_m.l_apde011_desc = s_desc_get_nmajl003_desc(g_apda_m.apde011)            
            LET g_apda_m.l_apde012_desc = s_desc_get_nmail004_desc(g_glaa005,g_apda_m.apde012)
            DISPLAY BY NAME g_apda_m.apde011,g_apda_m.apde012,g_apda_m.l_apde011_desc,g_apda_m.l_apde012_desc
            #END add-point
 
 
         #Ctrlp:input.c.apde012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="input.c.apde012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",g_glaa005,"' "
            LET g_qryparam.default1 = g_apda_m.apde012
            CALL q_nmai002()
            LET g_apda_m.apde012 = g_qryparam.return1
            DISPLAY g_apda_m.apde012 TO apde012              
            LET g_apda_m.l_apde012_desc = s_desc_get_nmail004_desc(g_glaa005,g_apda_m.apde012)
            DISPLAY BY NAME g_apda_m.l_apde012_desc
            NEXT FIELD apde012                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apdald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            LET lc_param_apgn.apdadocno = g_apda_m.apdadocno
            LET lc_param_apgn.apdadocdt = g_apda_m.apdadocdt
            LET lc_param_apgn.apda003 = g_apda_m.apda003
            LET lc_param_apgn.apde008 = g_apda_m.apde008
            LET lc_param_apgn.apde011 = g_apda_m.apde011
            LET lc_param_apgn.apde012 = g_apda_m.apde012
            
            LET l_str_apgn = util.JSON.stringify(lc_param_apgn)
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
   CLOSE WINDOW w_aapt590_02 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      RETURN FALSE,''
   END IF
   
   RETURN TRUE,l_str_apgn
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt590_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt590_02.other_function" readonly="Y" >}

 
{</section>}
 
