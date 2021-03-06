#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt510_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-03-04 10:37:31), PR版次:0004(2017-01-23 10:01:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: aapt510_03
#+ Description: 自備款轉預付購料
#+ Creator....: 03080(2016-03-04 10:35:55)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt510_03.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#22 2016/03/24 By Jessy     修正azzi920重複定義之錯誤訊息
#160318-00025#25 2016/04/27 BY 07900     校验代码重复错误讯息的修改
#161104-00024#4  2016/11/09 By 08729     處理DEFINE有星號
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#170123-00010#1  2017/01/23 By 06821     SQL中缺乏ent條件
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
   apdadocdt LIKE type_t.dat, 
   apda003 LIKE apda_t.apda003, 
   apda003_desc LIKE type_t.chr80, 
   l_apde008 LIKE type_t.chr20, 
   l_apcadocno LIKE type_t.chr20, 
   l_apde011 LIKE type_t.chr10, 
   l_apde012 LIKE type_t.chr10, 
   apdald LIKE apda_t.apdald
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apgacomp   LIKE apga_t.apgacomp
DEFINE g_apgadocno  LIKE apga_t.apgadocno
DEFINE g_apga100    LIKE apga_t.apga100
DEFINE g_apga101    LIKE apga_t.apga101
DEFINE g_apga104    LIKE apga_t.apga104
DEFINE g_apga003    LIKE apga_t.apga003
DEFINE g_apga004    LIKE apga_t.apga004
DEFINE g_apga005    LIKE apga_t.apga005
DEFINE g_apga007    LIKE apga_t.apga007
DEFINE g_apga108    LIKE apga_t.apga108
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
 
{<section id="aapt510_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt510_03(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_lsjs,p_comp,p_docno,p_apga004,p_apga100,p_apga101
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
   DEFINE p_comp          LIKE apga_t.apgacomp    #NO USE
   DEFINE p_docno         LIKE apga_t.apgadocno   #NO USE
   DEFINE p_apga004       LIKE apga_t.apga004     #NO USE
   DEFINE p_apga100       LIKE apga_t.apga100     #NO USE
   DEFINE p_apga101       LIKE apga_t.apga101     #NO USE
   DEFINE p_apga104       LIKE apga_t.apga104     #NO USE
   DEFINE p_apga003       LIKE apga_t.apga003     #NO USE
   DEFINE p_apga005       LIKE apga_t.apga005     #NO USE
   DEFINE p_apga007       LIKE apga_t.apga007     #NO USE
   DEFINE p_lsjs          STRING                  #備用入口  
   DEFINE lc_param        RECORD
                          comp          LIKE apga_t.apgacomp,    
                          docno         LIKE apga_t.apgadocno,   
                          apga004       LIKE apga_t.apga004,   
                          apga100       LIKE apga_t.apga100,     
                          apga101       LIKE apga_t.apga101,     
                          apga104       LIKE apga_t.apga104, 
                          apga108       LIKE apga_t.apga108,                          
                          apga003       LIKE apga_t.apga003,     
                          apga005       LIKE apga_t.apga005,     
                          apga007       LIKE apga_t.apga007                              
                          END RECORD
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_glaa005       LIKE glaa_t.glaa005
   DEFINE l_apdald        LIKE apda_t.apdald
   DEFINE l_apdadocno     LIKE apda_t.apdadocno
   DEFINE r_docnoself     LIKE apca_t.apcadocno    #自備款待扺
   DEFINE r_docnobail     LIKE apca_t.apcadocno    #保證金待扺
   DEFINE l_chr           LIKE type_t.chr1
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt510_03 WITH FORM cl_ap_formpath("aap","aapt510_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET r_success = TRUE
   LET r_docnoself = ''
   LET r_docnobail = ''
   
   CALL util.JSON.parse(p_lsjs,lc_param)
   
   LET g_apgacomp  = lc_param.comp
   LET g_apgadocno = lc_param.docno
   LET g_apga004   = lc_param.apga004
   LET g_apga100   = lc_param.apga100
   LET g_apga101   = lc_param.apga101
   LET g_apga104   = lc_param.apga104
   LET g_apga108   = lc_param.apga108
   LET g_apga003   = lc_param.apga003
   LET g_apga005   = lc_param.apga005
   LET g_apga007   = lc_param.apga007
   
   SELECT glaald INTO g_apda_m.apdald FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apgacomp
      AND glaa014 = 'Y'
      
   LET g_apda_m.apdadocdt = g_today
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda003,g_apda_m.l_apde008,g_apda_m.l_apcadocno, 
          g_apda_m.l_apde011,g_apda_m.l_apde012,g_apda_m.apdald ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="input.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="input.a.apdadocno"
            #因系統允許登打缺號的完整單號故要檢查核理性
            IF NOT cl_null(g_apda_m.apdald) AND NOT cl_null(g_apda_m.apdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t  OR g_apda_m.apdadocno != g_apdadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apda_t WHERE "||"apdaent = '" ||g_enterprise|| "' AND "||"apdald = '"||g_apda_m.apdald ||"' AND "|| "apdadocno = '"||g_apda_m.apdadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_apda_m.apdadocno)THEN
               IF NOT s_aooi200_fin_chk_docno(g_apda_m.apdald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,'aapt420') THEN
                  LET g_apda_m.apdadocno = ''
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_fin_get_doc_para(g_apda_m.apdald,p_comp,g_apda_m.apdadocno,'D-FIN-0030') RETURNING l_chr
               IF l_chr = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00532'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apda_m.apdadocno = ''
                  NEXT FIELD CURRENT
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
            IF NOT cl_null(g_apda_m.apda003)THEN
               CALL s_voucher_glaq013_chk(g_apda_m.apda003)
               IF NOT cl_null(g_errno)THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#22 --s add
                  LET g_errparam.replace[1] = 'aooi130'
                  LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi130'
                  #160321-00016#22 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  LET g_apda_m.apda003 = ''
                  LET g_apda_m.apda003_desc =''
                  DISPLAY BY NAME g_apda_m.apda003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="input.b.apda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda003
            #add-point:ON CHANGE apda003 name="input.g.apda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apde008
            #add-point:BEFORE FIELD l_apde008 name="input.b.l_apde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apde008
            
            #add-point:AFTER FIELD l_apde008 name="input.a.l_apde008"
            IF NOT cl_null(g_apda_m.l_apde008) THEN
               INITIALIZE g_chkparam.* TO NULL               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_apda_m.l_apde008
               LET g_chkparam.arg2 = g_apgacomp
               LET g_chkparam.arg3 = '5'
               #160318-00025#25  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
               #160318-00025#25  by 07900 --add-end
               IF cl_chk_exist("v_nmas002_4") THEN
                  #檢查成功時後續處理
                   IF NOT s_anmi120_nmll002_chk(g_apda_m.l_apde008,g_user) THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_apda_m.l_apde008
                      LET g_errparam.code   = 'anm-00574' 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET g_apda_m.l_apde008 = ''
                      DISPLAY BY NAME g_apda_m.l_apde008
                      NEXT FIELD CURRENT
                   END IF 
               ELSE
                  LET g_apda_m.l_apde008 = ''
                  #檢查失敗時後續處理
                  DISPLAY BY NAME g_apda_m.l_apde008
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apde008
            #add-point:ON CHANGE l_apde008 name="input.g.l_apde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcadocno
            #add-point:BEFORE FIELD l_apcadocno name="input.b.l_apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcadocno
            
            #add-point:AFTER FIELD l_apcadocno name="input.a.l_apcadocno"
            #因系統允許登打缺號的完整單號故要檢查核理性
            IF NOT cl_null(g_apda_m.apdald) AND NOT cl_null(g_apda_m.l_apcadocno) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apca_t WHERE "||"apcaent = '" ||g_enterprise|| "' AND "||"apcald = '"||g_apda_m.apdald ||"' AND "|| "apcadocno = '"||g_apda_m.l_apcadocno ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            IF NOT cl_null(g_apda_m.apdadocno)THEN
               IF NOT s_aooi200_fin_chk_docno(g_apda_m.apdald,'','',g_apda_m.l_apcadocno,g_apda_m.apdadocdt,'aapq343') THEN
                  LET g_apda_m.l_apcadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcadocno
            #add-point:ON CHANGE l_apcadocno name="input.g.l_apcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apde011
            #add-point:BEFORE FIELD l_apde011 name="input.b.l_apde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apde011
            
            #add-point:AFTER FIELD l_apde011 name="input.a.l_apde011"
            IF NOT cl_null(g_apda_m.l_apde011) THEN
              
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apda_m.l_apde011
               LET g_chkparam.arg2 = 2
               LET g_errshow = TRUE
                
               IF NOT cl_chk_exist("v_nmaj001_1") THEN
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_apgacomp
                     AND glaa014  = 'Y'
                  #檢查失敗時後續處理
                  LET g_apda_m.l_apde011 = ''
                  LET g_apda_m.l_apde012 = ''
                  DISPLAY BY NAME g_apda_m.l_apde011,g_apda_m.l_apde012
                  NEXT FIELD CURRENT
               END IF

               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_apgacomp
                  AND glaa014 = 'Y'
               LET g_apda_m.l_apde012 = s_anm_get_nmad003(l_glaa005,g_apda_m.l_apde011)
               DISPLAY BY NAME g_apda_m.l_apde012
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apde011
            #add-point:ON CHANGE l_apde011 name="input.g.l_apde011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apde012
            #add-point:BEFORE FIELD l_apde012 name="input.b.l_apde012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apde012
            
            #add-point:AFTER FIELD l_apde012 name="input.a.l_apde012"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apda_m.l_apde012) THEN             
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apda_m.l_apde012
               LET g_chkparam.arg2 = l_glaa005
               LET g_errshow = TRUE

               IF NOT cl_chk_exist("v_nmai002") THEN
                  LET g_apda_m.l_apde012 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF      
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apde012
            #add-point:ON CHANGE l_apde012 name="input.g.l_apde012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
 
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
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgacomp
               AND glaa014 = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdadocno            
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aapt420'
            LET g_qryparam.where = "      EXISTS (SELECT 1 FROM ooac_t ",
                                   "               WHERE ooacent = oobaent ",
                                   "                 AND ooac001 = '",l_glaa024,"' ",
                                   "                 AND ooac002 = ooba002 ",
                                   "                 AND ooac003 = 'D-FIN-5001' ",
                                   "                 AND ooac004 ='Y') ",
                                   " AND EXISTS (SELECT 1 FROM ooac_t ",
                                   "               WHERE ooacent = oobaent ",
                                   "                 AND ooac001 = '",l_glaa024,"' ",
                                   "                 AND ooac002 = ooba002 ",
                                   "                 AND ooac003 = 'D-FIN-0030' ",
                                   "                 AND ooac004 ='Y') "
            CALL q_ooba002_1()                              
            LET g_apda_m.apdadocno = g_qryparam.return1          
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
            DISPLAY BY NAME g_apda_m.apda003
            NEXT FIELD apda003
            #END add-point
 
 
         #Ctrlp:input.c.l_apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apde008
            #add-point:ON ACTION controlp INFIELD l_apde008 name="input.c.l_apde008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE             
            LET g_qryparam.default1 = g_apda_m.l_apde008             #給予default值
            LET g_qryparam.where =  " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                    "              AND ooef017 = '",g_apgacomp,"')",
                                    #" AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",                                  #170123-00010#1 mark
                                    " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmagent = '",g_enterprise,"' AND nmag001 = nmaa003 ",  #170123-00010#1 add
                                    " AND nmag002 IN ('1','5'))",
                                    " AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')",
                                    " AND nmas003 = '",g_apga100,"' "
            CALL q_nmas_01()                                #呼叫開窗
            LET g_apda_m.l_apde008 = g_qryparam.return1
            DISPLAY BY NAME g_apda_m.l_apde008
            NEXT FIELD l_apde008
            #END add-point
 
 
         #Ctrlp:input.c.l_apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcadocno
            #add-point:ON ACTION controlp INFIELD l_apcadocno name="input.c.l_apcadocno"
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgacomp
               AND glaa014 = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.l_apcadocno            
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aapq343'
            CALL q_ooba002_1()                              
            LET g_apda_m.l_apcadocno = g_qryparam.return1          
            NEXT FIELD l_apcadocno              
            #END add-point
 
 
         #Ctrlp:input.c.l_apde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apde011
            #add-point:ON ACTION controlp INFIELD l_apde011 name="input.c.l_apde011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_apda_m.l_apde011
            CALL q_nmaj001()                                       
            LET g_apda_m.l_apde011  = g_qryparam.return1

            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apgacomp
               AND glaa014  = 'Y'
            LET g_apda_m.l_apde012   = s_anm_get_nmad003(l_glaa005,g_apda_m.l_apde011)
            DISPLAY BY NAME g_apda_m.l_apde011 ,g_apda_m.l_apde012
            NEXT FIELD l_apde011
            #END add-point
 
 
         #Ctrlp:input.c.l_apde012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apde012
            #add-point:ON ACTION controlp INFIELD l_apde012 name="input.c.l_apde012"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
            LET g_qryparam.default1 = g_apda_m.l_apde012
            CALL q_nmai002()                                  #呼叫開窗
            LET g_apda_m.l_apde012 = g_qryparam.return1
            DISPLAY BY NAME g_apda_m.l_apde012
            NEXT FIELD l_apde012
            #END add-point
 
 
         #Ctrlp:input.c.apdald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            
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
   CLOSE WINDOW w_aapt510_03 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET r_success = FALSE
   ELSE
      CALL aapt510_03_ins_apda() RETURNING g_sub_success,l_apdald,l_apdadocno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
   END IF
   
   IF r_success THEN
      SELECT apde014 INTO r_docnoself FROM apde_t
       WHERE apdeent = g_enterprise
         AND apdeld  = l_apdald
         AND apdedocno = l_apdadocno
         AND apdeseq = 2
      SELECT apde014 INTO r_docnobail FROM apde_t
       WHERE apdeent = g_enterprise
         AND apdeld  = l_apdald
         AND apdedocno = l_apdadocno
         AND apdeseq = 3
   END IF
   RETURN r_success,r_docnoself,r_docnobail
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt510_03.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_03_ins_apda()
   #DEFINE l_apda    RECORD LIKE apda_t.* #161104-00024#4 mark
   #161104-00024#4-add(s)
   DEFINE l_apda  RECORD  #付款核銷單單頭檔
          apdaent   LIKE apda_t.apdaent, #企業編號
          apdacomp  LIKE apda_t.apdacomp, #法人
          apdald    LIKE apda_t.apdald, #帳套
          apdadocno LIKE apda_t.apdadocno, #單號
          apdadocdt LIKE apda_t.apdadocdt, #單據日期
          apdasite  LIKE apda_t.apdasite, #帳務組織
          apda001   LIKE apda_t.apda001, #帳款單性質
          apda002   LIKE apda_t.apda002, #NO USE
          apda003   LIKE apda_t.apda003, #帳務人員
          apda004   LIKE apda_t.apda004, #帳款核銷對象
          apda005   LIKE apda_t.apda005, #付款對象
          apda006   LIKE apda_t.apda006, #一次性交易識別碼
          apda007   LIKE apda_t.apda007, #產生方式
          apda008   LIKE apda_t.apda008, #來源參考單號
          apda009   LIKE apda_t.apda009, #沖帳批序號
          apda010   LIKE apda_t.apda010, #集團代付付單號
          apda011   LIKE apda_t.apda011, #差異處理
          apda012   LIKE apda_t.apda012, #退款類型
          apda013   LIKE apda_t.apda013, #分錄底稿是否可重新產生
          apda014   LIKE apda_t.apda014, #拋轉傳票號碼
          apda015   LIKE apda_t.apda015, #作廢理由碼
          apda016   LIKE apda_t.apda016, #列印次數
          apda017   LIKE apda_t.apda017, #MEMO備註
          apda018   LIKE apda_t.apda018, #付款(攤銷)理由碼
          apda019   LIKE apda_t.apda019, #攤銷目的方式
          apda020   LIKE apda_t.apda020, #分攤金額方式
          apda021   LIKE apda_t.apda021, #目的成本要素
          apda113   LIKE apda_t.apda113, #應核銷本幣金額
          apda123   LIKE apda_t.apda123, #應核銷本幣二金額
          apda133   LIKE apda_t.apda133, #應核銷本幣三金額
          apdaownid LIKE apda_t.apdaownid, #資料所有者
          apdaowndp LIKE apda_t.apdaowndp, #資料所屬部門
          apdacrtid LIKE apda_t.apdacrtid, #資料建立者
          apdacrtdp LIKE apda_t.apdacrtdp, #資料建立部門
          apdacrtdt LIKE apda_t.apdacrtdt, #資料創建日
          apdamodid LIKE apda_t.apdamodid, #資料修改者
          apdamoddt LIKE apda_t.apdamoddt, #最近修改日
          apdacnfid LIKE apda_t.apdacnfid, #資料確認者
          apdacnfdt LIKE apda_t.apdacnfdt, #資料確認日
          apdapstid LIKE apda_t.apdapstid, #資料過帳者
          apdapstdt LIKE apda_t.apdapstdt, #資料過帳日
          apdastus  LIKE apda_t.apdastus, #狀態碼
          apdaud001 LIKE apda_t.apdaud001, #自定義欄位(文字)001
          apdaud002 LIKE apda_t.apdaud002, #自定義欄位(文字)002
          apdaud003 LIKE apda_t.apdaud003, #自定義欄位(文字)003
          apdaud004 LIKE apda_t.apdaud004, #自定義欄位(文字)004
          apdaud005 LIKE apda_t.apdaud005, #自定義欄位(文字)005
          apdaud006 LIKE apda_t.apdaud006, #自定義欄位(文字)006
          apdaud007 LIKE apda_t.apdaud007, #自定義欄位(文字)007
          apdaud008 LIKE apda_t.apdaud008, #自定義欄位(文字)008
          apdaud009 LIKE apda_t.apdaud009, #自定義欄位(文字)009
          apdaud010 LIKE apda_t.apdaud010, #自定義欄位(文字)010
          apdaud011 LIKE apda_t.apdaud011, #自定義欄位(數字)011
          apdaud012 LIKE apda_t.apdaud012, #自定義欄位(數字)012
          apdaud013 LIKE apda_t.apdaud013, #自定義欄位(數字)013
          apdaud014 LIKE apda_t.apdaud014, #自定義欄位(數字)014
          apdaud015 LIKE apda_t.apdaud015, #自定義欄位(數字)015
          apdaud016 LIKE apda_t.apdaud016, #自定義欄位(數字)016
          apdaud017 LIKE apda_t.apdaud017, #自定義欄位(數字)017
          apdaud018 LIKE apda_t.apdaud018, #自定義欄位(數字)018
          apdaud019 LIKE apda_t.apdaud019, #自定義欄位(數字)019
          apdaud020 LIKE apda_t.apdaud020, #自定義欄位(數字)020
          apdaud021 LIKE apda_t.apdaud021, #自定義欄位(日期時間)021
          apdaud022 LIKE apda_t.apdaud022, #自定義欄位(日期時間)022
          apdaud023 LIKE apda_t.apdaud023, #自定義欄位(日期時間)023
          apdaud024 LIKE apda_t.apdaud024, #自定義欄位(日期時間)024
          apdaud025 LIKE apda_t.apdaud025, #自定義欄位(日期時間)025
          apdaud026 LIKE apda_t.apdaud026, #自定義欄位(日期時間)026
          apdaud027 LIKE apda_t.apdaud027, #自定義欄位(日期時間)027
          apdaud028 LIKE apda_t.apdaud028, #自定義欄位(日期時間)028
          apdaud029 LIKE apda_t.apdaud029, #自定義欄位(日期時間)029
          apdaud030 LIKE apda_t.apdaud030, #自定義欄位(日期時間)030
          apda104   LIKE apda_t.apda104, #原幣借方金額合計
          apda105   LIKE apda_t.apda105, #原幣貸方金額合計
          apda114   LIKE apda_t.apda114, #本幣借方金額合計
          apda115   LIKE apda_t.apda115, #本幣貸方金額合計
          apda124   LIKE apda_t.apda124, #本位幣二借方金額合計
          apda125   LIKE apda_t.apda125, #本位幣二貸方金額合計
          apda134   LIKE apda_t.apda134, #本位幣三借方金額合計
          apda135   LIKE apda_t.apda135, #本位幣三貸方金額合計
          apda022   LIKE apda_t.apda022, #經營方式
          apda023   LIKE apda_t.apda023  #請款單號
              END RECORD
   #161104-00024#4-add(e)
   DEFINE l_prog_t  LIKE type_t.chr100
   DEFINE l_dummy1  LIKE type_t.chr100
   DEFINE l_pmab055 LIKE pmab_t.pmab055
   #DEFINE l_apde    RECORD LIKE apde_t.* #161104-00024#4 mark
   #161104-00024#4-add(s)
   DEFINE l_apde  RECORD  #付款及差異處理明細檔
          apdeent   LIKE apde_t.apdeent, #企業編號
          apdecomp  LIKE apde_t.apdecomp, #法人
          apdeld    LIKE apde_t.apdeld, #帳套
          apdedocno LIKE apde_t.apdedocno, #沖銷單單號
          apdeseq   LIKE apde_t.apdeseq, #項次
          apdesite  LIKE apde_t.apdesite, #帳務中心
          apdeorga  LIKE apde_t.apdeorga, #帳務歸屬組織
          apde001   LIKE apde_t.apde001, #來源作業
          apde002   LIKE apde_t.apde002, #沖銷帳款類型
          apde003   LIKE apde_t.apde003, #已付款單號
          apde004   LIKE apde_t.apde004, #沖銷單項次
          apde006   LIKE apde_t.apde006, #款別編號
          apde008   LIKE apde_t.apde008, #帳戶/票券號碼
          apde009   LIKE apde_t.apde009, #已轉資料
          apde010   LIKE apde_t.apde010, #摘要說明
          apde011   LIKE apde_t.apde011, #銀行存提碼
          apde012   LIKE apde_t.apde012, #現金變動碼
          apde013   LIKE apde_t.apde013, #轉入客商碼
          apde014   LIKE apde_t.apde014, #轉入帳款單編號
          apde015   LIKE apde_t.apde015, #沖銷加減項
          apde016   LIKE apde_t.apde016, #沖銷會科
          apde017   LIKE apde_t.apde017, #業務人員
          apde018   LIKE apde_t.apde018, #業務部門
          apde019   LIKE apde_t.apde019, #責任中心
          apde020   LIKE apde_t.apde020, #產品類別
          apde021   LIKE apde_t.apde021, #票據類型
          apde022   LIKE apde_t.apde022, #專案編號
          apde023   LIKE apde_t.apde023, #WBS編號
          apde024   LIKE apde_t.apde024, #票據號碼
          apde028   LIKE apde_t.apde028, #產生方式
          apde029   LIKE apde_t.apde029, #傳票號碼
          apde030   LIKE apde_t.apde030, #傳票項次
          apde032   LIKE apde_t.apde032, #付款日
          apde035   LIKE apde_t.apde035, #區域
          apde036   LIKE apde_t.apde036, #客群
          apde038   LIKE apde_t.apde038, #對象
          apde039   LIKE apde_t.apde039, #受款銀行
          apde040   LIKE apde_t.apde040, #受款帳號
          apde041   LIKE apde_t.apde041, #受款人全名
          apde042   LIKE apde_t.apde042, #經營方式
          apde043   LIKE apde_t.apde043, #通路
          apde044   LIKE apde_t.apde044, #品牌
          apde045   LIKE apde_t.apde045, #摘要
          apde046   LIKE apde_t.apde046, #付款申請單
          apde047   LIKE apde_t.apde047, #付款申請單項次
          apde051   LIKE apde_t.apde051, #自由核算項一
          apde052   LIKE apde_t.apde052, #自由核算項二
          apde053   LIKE apde_t.apde053, #自由核算項三
          apde054   LIKE apde_t.apde054, #自由核算項四
          apde055   LIKE apde_t.apde055, #自由核算項五
          apde056   LIKE apde_t.apde056, #自由核算項六
          apde057   LIKE apde_t.apde057, #自由核算項七
          apde058   LIKE apde_t.apde058, #自由核算項八
          apde059   LIKE apde_t.apde059, #自由核算項九
          apde060   LIKE apde_t.apde060, #自由核算項十
          apde100   LIKE apde_t.apde100, #幣別
          apde101   LIKE apde_t.apde101, #匯率
          apde104   LIKE apde_t.apde104, #原幣應稅折抵稅額
          apde109   LIKE apde_t.apde109, #原幣沖帳金額
          apde119   LIKE apde_t.apde119, #本幣沖帳金額
          apde120   LIKE apde_t.apde120, #本位幣二幣別
          apde121   LIKE apde_t.apde121, #本位幣二匯率
          apde129   LIKE apde_t.apde129, #本位幣二沖帳金額
          apde130   LIKE apde_t.apde130, #本位幣三幣別
          apde131   LIKE apde_t.apde131, #本位幣三匯率
          apde139   LIKE apde_t.apde139, #本位幣三沖帳金額
          apdeud001 LIKE apde_t.apdeud001, #自定義欄位(文字)001
          apdeud002 LIKE apde_t.apdeud002, #自定義欄位(文字)002
          apdeud003 LIKE apde_t.apdeud003, #自定義欄位(文字)003
          apdeud004 LIKE apde_t.apdeud004, #自定義欄位(文字)004
          apdeud005 LIKE apde_t.apdeud005, #自定義欄位(文字)005
          apdeud006 LIKE apde_t.apdeud006, #自定義欄位(文字)006
          apdeud007 LIKE apde_t.apdeud007, #自定義欄位(文字)007
          apdeud008 LIKE apde_t.apdeud008, #自定義欄位(文字)008
          apdeud009 LIKE apde_t.apdeud009, #自定義欄位(文字)009
          apdeud010 LIKE apde_t.apdeud010, #自定義欄位(文字)010
          apdeud011 LIKE apde_t.apdeud011, #自定義欄位(數字)011
          apdeud012 LIKE apde_t.apdeud012, #自定義欄位(數字)012
          apdeud013 LIKE apde_t.apdeud013, #自定義欄位(數字)013
          apdeud014 LIKE apde_t.apdeud014, #自定義欄位(數字)014
          apdeud015 LIKE apde_t.apdeud015, #自定義欄位(數字)015
          apdeud016 LIKE apde_t.apdeud016, #自定義欄位(數字)016
          apdeud017 LIKE apde_t.apdeud017, #自定義欄位(數字)017
          apdeud018 LIKE apde_t.apdeud018, #自定義欄位(數字)018
          apdeud019 LIKE apde_t.apdeud019, #自定義欄位(數字)019
          apdeud020 LIKE apde_t.apdeud020, #自定義欄位(數字)020
          apdeud021 LIKE apde_t.apdeud021, #自定義欄位(日期時間)021
          apdeud022 LIKE apde_t.apdeud022, #自定義欄位(日期時間)022
          apdeud023 LIKE apde_t.apdeud023, #自定義欄位(日期時間)023
          apdeud024 LIKE apde_t.apdeud024, #自定義欄位(日期時間)024
          apdeud025 LIKE apde_t.apdeud025, #自定義欄位(日期時間)025
          apdeud026 LIKE apde_t.apdeud026, #自定義欄位(日期時間)026
          apdeud027 LIKE apde_t.apdeud027, #自定義欄位(日期時間)027
          apdeud028 LIKE apde_t.apdeud028, #自定義欄位(日期時間)028
          apdeud029 LIKE apde_t.apdeud029, #自定義欄位(日期時間)029
          apdeud030 LIKE apde_t.apdeud030, #自定義欄位(日期時間)030
          apde061   LIKE apde_t.apde061  #應付來源
              END RECORD
   #161104-00024#4-add(e)
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sfin3008 LIKE type_t.chr100
   DEFINE r_apdald   LIKE apda_t.apdald
   DEFINE r_apdadocno LIKE apda_t.apdadocno
   DEFINE l_glaa121   LIKE glaa_t.glaa121
   DEFINE l_glaa016   LIKE glaa_t.glaa016
   DEFINE l_glaa020   LIKE glaa_t.glaa020
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   DEFINE ls_js       STRING
   DEFINE lc_param      RECORD
         type           LIKE type_t.chr1,       #類型
         apca004        LIKE apca_t.apca004,
         sfin2009       LIKE type_t.chr1        #汇率基本    
         END RECORD
   DEFINE l_chr         LIKE type_t.chr1
   DEFINE l_slip        LIKE apca_t.apcadocno
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_apdald  = ''
   LET r_apdadocno = ''
   
   INITIALIZE l_apda.* TO NULL
   LET l_apda.apdaent = g_enterprise
   LET l_apda.apdald  = NULL
   SELECT glaald INTO l_apda.apdald FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apgacomp
      AND glaa014 = 'Y'
   LET l_apda.apdacomp = g_apgacomp
   LET l_apda.apdadocdt = g_apda_m.apdadocdt
   LET l_prog_t = g_prog
   LET g_prog = 'aapt420'
   CALL s_aooi200_fin_gen_docno(l_apda.apdald,'','',g_apda_m.apdadocno,l_apda.apdadocdt,g_prog)
      RETURNING g_sub_success,l_apda.apdadocno
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   LET g_prog = l_prog_t
   LET l_apda.apdasite = g_apgacomp
   LET l_apda.apda001  = '45'
   LET l_apda.apda003  = g_apda_m.apda003
   LET l_apda.apda004  = g_apga004
   LET l_apda.apda005  = g_apga004
   LET l_apda.apda007  = '1'
   LET l_apda.apda008  = g_apgadocno
   LET l_apda.apdastus = 'N'
   LET l_apda.apda104  = 0
   LET l_apda.apda105  = 0
   LET l_apda.apda114  = 0
   LET l_apda.apda115  = 0
   LET l_apda.apda124  = 0
   LET l_apda.apda125  = 0
   LET l_apda.apda134  = 0
   LET l_apda.apda135  = 0
   LET l_apda.apdaownid = g_user
   LET l_apda.apdaowndp = g_dept
   LET l_apda.apdacrtid = g_user
   LET l_apda.apdacrtdp = g_dept
   LET l_apda.apdacrtdt = cl_get_current()
   LET l_apda.apdamodid = g_user
   LET l_apda.apdamoddt = cl_get_current()
   LET l_apda.apdastus = 'N'
   #INSERT INTO apda_t VALUES(l_apda.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO apda_t (apdaent,apdacomp,apdald,apdadocno,apdadocdt,apdasite,
                       apda001,apda002,apda003,apda004,apda005,
                       apda006,apda007,apda008,apda009,apda010,
                       apda011,apda012,apda013,apda014,apda015,
                       apda016,apda017,apda018,apda019,apda020,
                       apda021,apda113,apda123,apda133,
                       apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,
                       apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid,
                       apdapstdt,apdastus,
                       apdaud001,apdaud002,apdaud003,apdaud004,apdaud005,
                       apdaud006,apdaud007,apdaud008,apdaud009,apdaud010,
                       apdaud011,apdaud012,apdaud013,apdaud014,apdaud015,
                       apdaud016,apdaud017,apdaud018,apdaud019,apdaud020,
                       apdaud021,apdaud022,apdaud023,apdaud024,apdaud025,
                       apdaud026,apdaud027,apdaud028,apdaud029,apdaud030,
                       apda104,apda105,apda114,apda115,apda124,
                       apda125,apda134,apda135,apda022,apda023
                      )
   VALUES (l_apda.apdaent,l_apda.apdacomp,l_apda.apdald,l_apda.apdadocno,l_apda.apdadocdt,l_apda.apdasite,
           l_apda.apda001,l_apda.apda002,l_apda.apda003,l_apda.apda004,l_apda.apda005,
           l_apda.apda006,l_apda.apda007,l_apda.apda008,l_apda.apda009,l_apda.apda010,
           l_apda.apda011,l_apda.apda012,l_apda.apda013,l_apda.apda014,l_apda.apda015,
           l_apda.apda016,l_apda.apda017,l_apda.apda018,l_apda.apda019,l_apda.apda020,
           l_apda.apda021,l_apda.apda113,l_apda.apda123,l_apda.apda133,
           l_apda.apdaownid,l_apda.apdaowndp,l_apda.apdacrtid,l_apda.apdacrtdp,l_apda.apdacrtdt,
           l_apda.apdamodid,l_apda.apdamoddt,l_apda.apdacnfid,l_apda.apdacnfdt,l_apda.apdapstid,
           l_apda.apdapstdt,l_apda.apdastus,
           l_apda.apdaud001,l_apda.apdaud002,l_apda.apdaud003,l_apda.apdaud004,l_apda.apdaud005,
           l_apda.apdaud006,l_apda.apdaud007,l_apda.apdaud008,l_apda.apdaud009,l_apda.apdaud010,
           l_apda.apdaud011,l_apda.apdaud012,l_apda.apdaud013,l_apda.apdaud014,l_apda.apdaud015,
           l_apda.apdaud016,l_apda.apdaud017,l_apda.apdaud018,l_apda.apdaud019,l_apda.apdaud020,
           l_apda.apdaud021,l_apda.apdaud022,l_apda.apdaud023,l_apda.apdaud024,l_apda.apdaud025,
           l_apda.apdaud026,l_apda.apdaud027,l_apda.apdaud028,l_apda.apdaud029,l_apda.apdaud030,
           l_apda.apda104,l_apda.apda105,l_apda.apda114,l_apda.apda115,l_apda.apda124,
           l_apda.apda125,l_apda.apda134,l_apda.apda135,l_apda.apda022,l_apda.apda023
          )
   #161108-00017#4 add end---
   
   LET l_glaa121 = NULL LET l_glaa016 = NULL
   LET l_glaa020 = NULL LET l_glaa019 = NULL
   LET l_glaa015 = NULL
   SELECT glaa121,glaa016,glaa020 ,
          glaa015,glaa019
     INTO l_glaa121,l_glaa016,l_glaa020,
          l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = l_apda.apdald
   
   
   INITIALIZE l_apde.* TO NULL
   LET l_apde.apdeent   = g_enterprise
   LET l_apde.apdecomp  = l_apda.apdacomp
   LET l_apde.apdeld    = l_apda.apdald
   LET l_apde.apdedocno = l_apda.apdadocno
   LET l_apde.apdeseq   = 1
   LET l_apde.apdesite  = l_apda.apdasite
   LET l_apde.apdeorga  = l_apda.apdasite
   LET l_apde.apde001   = 'aapt420'
   LET l_apde.apde002   = '10'
   LET l_apde.apde006   = '10'
   LET l_apde.apde008   = g_apda_m.l_apde008
   LET l_apde.apde009 = 'N'
   LET l_apde.apde011 = g_apda_m.l_apde011
   LET l_apde.apde012 = g_apda_m.l_apde012
   LET l_apde.apde015 = s_fin_get_scc_value('8506',l_apde.apde002,'1')
   LET l_apde.apde016 = NULL
   SELECT glab005 INTO l_apde.apde016 FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld = l_apde.apdeld
      AND glab001 = '41'
      AND glab002 = '8718'
      AND glab003 = '2'
   LET l_apde.apde017 = g_apga005
   LET l_apde.apde018 = NULL
   SELECT ooag003 INTO l_apde.apde018 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = l_apde.apde017
   #LET l_apde.apde019 =          
   CALL s_department_get_respon_center(l_apde.apde018,l_apda.apdadocdt)
              RETURNING g_sub_success,g_errno,l_apde.apde019,l_dummy1
   LET l_apde.apde028 = '2'
   LET l_apde.apde032 = g_apga003
   LET l_apde.apde038 = l_apda.apda005
   LET l_apde.apde039 = g_apga007
   SELECT nmabl004 INTO l_apde.apde041 FROM nmabl_t
    WHERE nmablent = g_enterprise
      AND nmabl001 = l_apde.apde039
   LET l_apde.apde100 = g_apga100
   LET l_apde.apde101 = g_apga101
   LET l_apde.apde104 = 0 
   LET l_apde.apde109 = g_apga104 + g_apga108
   LET l_apde.apde119 = l_apde.apde109 * l_apde.apde101
   #s_curr_round
   CALL s_curr_round_ld('1',l_apda.apdald,l_glaa001,l_apde.apde119,2) RETURNING g_sub_success,g_errno,l_apde.apde119
   LET lc_param.apca004 = l_apda.apda005
   LET ls_js = util.JSON.stringify(lc_param)
   CALL s_fin_get_curr_rate(l_apda.apdacomp,l_apda.apdald,l_apda.apdadocdt,l_apde.apde100,ls_js)
        RETURNING l_apde.apde101,l_apde.apde121,l_apde.apde131
   #s_curr_round
   LET l_apde.apde101 = g_apga101
   LET l_apde.apde120 = l_glaa016
   
   IF l_glaa015 = 'Y' THEN
      LET l_apde.apde129 = l_apde.apde109 * l_apde.apde121
      CALL s_curr_round_ld('1',l_apda.apdald,l_apde.apde120,l_apde.apde129,2) RETURNING g_sub_success,g_errno,l_apde.apde129
   END IF
   
   LET l_apde.apde130 = l_glaa020
   IF l_glaa019 = 'Y' THEN
      LET l_apde.apde139 = l_apde.apde109 * l_apde.apde131
      CALL s_curr_round_ld('1',l_apda.apdald,l_apde.apde130,l_apde.apde139,2) RETURNING g_sub_success,g_errno,l_apde.apde139
   END IF
   #INSERT INTO apde_t VALUES(l_apde.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO apde_t (apdeent,apdecomp,apdeld,apdedocno,apdeseq,
                       apdesite,apdeorga,
                       apde001,apde002,apde003,apde004,apde006,
                       apde008,apde009,apde010,apde011,apde012,
                       apde013,apde014,apde015,apde016,apde017,
                       apde018,apde019,apde020,apde021,apde022,
                       apde023,apde024,apde028,apde029,apde030,
                       apde032,apde035,apde036,apde038,apde039,
                       apde040,apde041,apde042,apde043,apde044,
                       apde045,apde046,apde047,apde051,apde052,
                       apde053,apde054,apde055,apde056,apde057,
                       apde058,apde059,apde060,apde100,apde101,
                       apde104,apde109,apde119,apde120,apde121,
                       apde129,apde130,apde131,apde139,
                       apdeud001,apdeud002,apdeud003,apdeud004,apdeud005,
                       apdeud006,apdeud007,apdeud008,apdeud009,apdeud010,
                       apdeud011,apdeud012,apdeud013,apdeud014,apdeud015,
                       apdeud016,apdeud017,apdeud018,apdeud019,apdeud020,
                       apdeud021,apdeud022,apdeud023,apdeud024,apdeud025,
                       apdeud026,apdeud027,apdeud028,apdeud029,apdeud030,
                       apde061
                      )
   VALUES (l_apde.apdeent,l_apde.apdecomp,l_apde.apdeld,l_apde.apdedocno,l_apde.apdeseq,
           l_apde.apdesite,l_apde.apdeorga,
           l_apde.apde001,l_apde.apde002,l_apde.apde003,l_apde.apde004,l_apde.apde006,
           l_apde.apde008,l_apde.apde009,l_apde.apde010,l_apde.apde011,l_apde.apde012,
           l_apde.apde013,l_apde.apde014,l_apde.apde015,l_apde.apde016,l_apde.apde017,
           l_apde.apde018,l_apde.apde019,l_apde.apde020,l_apde.apde021,l_apde.apde022,
           l_apde.apde023,l_apde.apde024,l_apde.apde028,l_apde.apde029,l_apde.apde030,
           l_apde.apde032,l_apde.apde035,l_apde.apde036,l_apde.apde038,l_apde.apde039,
           l_apde.apde040,l_apde.apde041,l_apde.apde042,l_apde.apde043,l_apde.apde044,
           l_apde.apde045,l_apde.apde046,l_apde.apde047,l_apde.apde051,l_apde.apde052,
           l_apde.apde053,l_apde.apde054,l_apde.apde055,l_apde.apde056,l_apde.apde057,
           l_apde.apde058,l_apde.apde059,l_apde.apde060,l_apde.apde100,l_apde.apde101,
           l_apde.apde104,l_apde.apde109,l_apde.apde119,l_apde.apde120,l_apde.apde121,
           l_apde.apde129,l_apde.apde130,l_apde.apde131,l_apde.apde139,
           l_apde.apdeud001,l_apde.apdeud002,l_apde.apdeud003,l_apde.apdeud004,l_apde.apdeud005,
           l_apde.apdeud006,l_apde.apdeud007,l_apde.apdeud008,l_apde.apdeud009,l_apde.apdeud010,
           l_apde.apdeud011,l_apde.apdeud012,l_apde.apdeud013,l_apde.apdeud014,l_apde.apdeud015,
           l_apde.apdeud016,l_apde.apdeud017,l_apde.apdeud018,l_apde.apdeud019,l_apde.apdeud020,
           l_apde.apdeud021,l_apde.apdeud022,l_apde.apdeud023,l_apde.apdeud024,l_apde.apdeud025,
           l_apde.apdeud026,l_apde.apdeud027,l_apde.apdeud028,l_apde.apdeud029,l_apde.apdeud030,
           l_apde.apde061
          )
   #161108-00017#4 add end---
   
   INITIALIZE l_apde.* TO NULL
   LET l_apde.apdeent   = g_enterprise
   LET l_apde.apdecomp  = l_apda.apdacomp
   LET l_apde.apdeld    = l_apda.apdald
   LET l_apde.apdedocno = l_apda.apdadocno
   LET l_apde.apdeseq   = 2
   LET l_apde.apdesite  = l_apda.apdasite
   LET l_apde.apdeorga  = l_apda.apdasite
   LET l_apde.apde001   = 'aapt420'
   LET l_apde.apde002   = '20'
   LET l_apde.apde006   = '10'
   LET l_apde.apde008   = g_apda_m.l_apde008
   LET l_apde.apde009 = 'N'
   LET l_apde.apde013 = l_apda.apda005
   LET l_apde.apde014 = g_apda_m.l_apcadocno
   LET l_apde.apde015 = s_fin_get_scc_value('8506',l_apde.apde002,'1')
   LET l_apde.apde016 = NULL
   
   LET l_pmab055 = NULL
   SELECT pmab055 INTO l_pmab055 FROM pmab_t
    WHERE pmabsite = l_apde.apdeorga
      AND pmab001 = l_apda.apda004
      AND pmabent = g_enterprise
   
   SELECT glab005 INTO l_apde.apde016 FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld = l_apde.apdeld
      AND glab001 = '13'
      AND glab002 = l_pmab055
      AND glab003 = '8504_13'
   LET l_apde.apde017 = g_apga005
   LET l_apde.apde018 = NULL
   SELECT ooag003 INTO l_apde.apde018 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = l_apde.apde017
   #LET l_apde.apde019 =          
   CALL s_department_get_respon_center(l_apde.apde018,l_apda.apdadocdt)
              RETURNING g_sub_success,g_errno,l_apde.apde019,l_dummy1
   LET l_apde.apde028 = '2'
   LET l_apde.apde032 = g_apga003
   LET l_apde.apde038 = l_apda.apda005
   LET l_apde.apde039 = g_apga007
   SELECT nmabl004 INTO l_apde.apde041 FROM nmabl_t
    WHERE nmablent = g_enterprise
      AND nmabl001 = l_apde.apde039
   LET l_apde.apde100 = g_apga100
   LET l_apde.apde101 = g_apga101
   LET l_apde.apde104 = 0 
   LET l_apde.apde109 = g_apga104
   LET l_apde.apde119 = l_apde.apde109 * l_apde.apde101
   #s_curr_round
   CALL s_curr_round_ld('1',l_apda.apdald,l_glaa001,l_apde.apde119,2) RETURNING g_sub_success,g_errno,l_apde.apde119
   LET lc_param.apca004 = l_apda.apda005
   LET ls_js = util.JSON.stringify(lc_param)
   CALL s_fin_get_curr_rate(l_apda.apdacomp,l_apda.apdald,l_apda.apdadocdt,l_apde.apde100,ls_js)
        RETURNING l_apde.apde101,l_apde.apde121,l_apde.apde131
   #s_curr_round
   LET l_apde.apde101 = g_apga101
   LET l_apde.apde120 = l_glaa016
   
   IF l_glaa015 = 'Y' THEN
      LET l_apde.apde129 = l_apde.apde109 * l_apde.apde121
      CALL s_curr_round_ld('1',l_apda.apdald,l_apde.apde120,l_apde.apde129,2) RETURNING g_sub_success,g_errno,l_apde.apde129
   END IF
   
   LET l_apde.apde130 = l_glaa020
   IF l_glaa019 = 'Y' THEN
      LET l_apde.apde139 = l_apde.apde109 * l_apde.apde131
      CALL s_curr_round_ld('1',l_apda.apdald,l_apde.apde130,l_apde.apde139,2) RETURNING g_sub_success,g_errno,l_apde.apde139
   END IF
   IF l_apde.apde109 > 0 THEN
      #INSERT INTO apde_t VALUES(l_apde.*)  #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO apde_t (apdeent,apdecomp,apdeld,apdedocno,apdeseq,
                          apdesite,apdeorga,
                          apde001,apde002,apde003,apde004,apde006,
                          apde008,apde009,apde010,apde011,apde012,
                          apde013,apde014,apde015,apde016,apde017,
                          apde018,apde019,apde020,apde021,apde022,
                          apde023,apde024,apde028,apde029,apde030,
                          apde032,apde035,apde036,apde038,apde039,
                          apde040,apde041,apde042,apde043,apde044,
                          apde045,apde046,apde047,apde051,apde052,
                          apde053,apde054,apde055,apde056,apde057,
                          apde058,apde059,apde060,apde100,apde101,
                          apde104,apde109,apde119,apde120,apde121,
                          apde129,apde130,apde131,apde139,
                          apdeud001,apdeud002,apdeud003,apdeud004,apdeud005,
                          apdeud006,apdeud007,apdeud008,apdeud009,apdeud010,
                          apdeud011,apdeud012,apdeud013,apdeud014,apdeud015,
                          apdeud016,apdeud017,apdeud018,apdeud019,apdeud020,
                          apdeud021,apdeud022,apdeud023,apdeud024,apdeud025,
                          apdeud026,apdeud027,apdeud028,apdeud029,apdeud030,
                          apde061
                         )
      VALUES (l_apde.apdeent,l_apde.apdecomp,l_apde.apdeld,l_apde.apdedocno,l_apde.apdeseq,
              l_apde.apdesite,l_apde.apdeorga,
              l_apde.apde001,l_apde.apde002,l_apde.apde003,l_apde.apde004,l_apde.apde006,
              l_apde.apde008,l_apde.apde009,l_apde.apde010,l_apde.apde011,l_apde.apde012,
              l_apde.apde013,l_apde.apde014,l_apde.apde015,l_apde.apde016,l_apde.apde017,
              l_apde.apde018,l_apde.apde019,l_apde.apde020,l_apde.apde021,l_apde.apde022,
              l_apde.apde023,l_apde.apde024,l_apde.apde028,l_apde.apde029,l_apde.apde030,
              l_apde.apde032,l_apde.apde035,l_apde.apde036,l_apde.apde038,l_apde.apde039,
              l_apde.apde040,l_apde.apde041,l_apde.apde042,l_apde.apde043,l_apde.apde044,
              l_apde.apde045,l_apde.apde046,l_apde.apde047,l_apde.apde051,l_apde.apde052,
              l_apde.apde053,l_apde.apde054,l_apde.apde055,l_apde.apde056,l_apde.apde057,
              l_apde.apde058,l_apde.apde059,l_apde.apde060,l_apde.apde100,l_apde.apde101,
              l_apde.apde104,l_apde.apde109,l_apde.apde119,l_apde.apde120,l_apde.apde121,
              l_apde.apde129,l_apde.apde130,l_apde.apde131,l_apde.apde139,
              l_apde.apdeud001,l_apde.apdeud002,l_apde.apdeud003,l_apde.apdeud004,l_apde.apdeud005,
              l_apde.apdeud006,l_apde.apdeud007,l_apde.apdeud008,l_apde.apdeud009,l_apde.apdeud010,
              l_apde.apdeud011,l_apde.apdeud012,l_apde.apdeud013,l_apde.apdeud014,l_apde.apdeud015,
              l_apde.apdeud016,l_apde.apdeud017,l_apde.apdeud018,l_apde.apdeud019,l_apde.apdeud020,
              l_apde.apdeud021,l_apde.apdeud022,l_apde.apdeud023,l_apde.apdeud024,l_apde.apdeud025,
              l_apde.apdeud026,l_apde.apdeud027,l_apde.apdeud028,l_apde.apdeud029,l_apde.apdeud030,
              l_apde.apde061
             )
      #161108-00017#4 add end---
   END IF
   

   
   INITIALIZE l_apde.* TO NULL
   LET l_apde.apdeent   = g_enterprise
   LET l_apde.apdecomp  = l_apda.apdacomp
   LET l_apde.apdeld    = l_apda.apdald
   LET l_apde.apdedocno = l_apda.apdadocno
   LET l_apde.apdeseq   = 3
   LET l_apde.apdesite  = l_apda.apdasite
   LET l_apde.apdeorga  = l_apda.apdasite
   LET l_apde.apde001   = 'aapt420'
   LET l_apde.apde002   = '20'
   LET l_apde.apde006   = '10'
   LET l_apde.apde008   = g_apda_m.l_apde008
   LET l_apde.apde009 = 'N'
   LET l_apde.apde013 = l_apda.apda005
   LET l_apde.apde014 = g_apda_m.l_apcadocno
   LET l_apde.apde015 = s_fin_get_scc_value('8506',l_apde.apde002,'1')
   LET l_apde.apde016 = NULL
   
   LET l_pmab055 = NULL
   SELECT pmab055 INTO l_pmab055  FROM pmab_t
    WHERE pmabsite = l_apda.apdacomp
      AND pmab001 = l_apda.apda004
      AND pmabent = g_enterprise
   
   SELECT glab005 INTO l_apde.apde016 FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld = l_apde.apdeld
      AND glab001 = '13'
      AND glab002 = l_pmab055
      AND glab003 = '8504_31'
   LET l_apde.apde017 = g_apga005
   LET l_apde.apde018 = NULL
   SELECT ooag003 INTO l_apde.apde018 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = l_apde.apde017
   #LET l_apde.apde019 =          
   CALL s_department_get_respon_center(l_apde.apde018,l_apda.apdadocdt)
              RETURNING g_sub_success,g_errno,l_apde.apde019,l_dummy1
   LET l_apde.apde028 = '2'
   LET l_apde.apde032 = g_apga003
   LET l_apde.apde038 = l_apda.apda005
   LET l_apde.apde039 = g_apga007
   SELECT nmabl004 INTO l_apde.apde041 FROM nmabl_t
    WHERE nmablent = g_enterprise
      AND nmabl001 = l_apde.apde039
   LET l_apde.apde100 = g_apga100
   LET l_apde.apde101 = g_apga101
   LET l_apde.apde104 = 0 
   LET l_apde.apde109 = g_apga108
   LET l_apde.apde119 = l_apde.apde109 * l_apde.apde101
   CALL s_curr_round_ld('1',l_apda.apdald,l_glaa001,l_apde.apde119,2) RETURNING g_sub_success,g_errno,l_apde.apde119
   LET lc_param.apca004 = l_apda.apda005
   LET ls_js = util.JSON.stringify(lc_param)
   CALL s_fin_get_curr_rate(l_apda.apdacomp,l_apda.apdald,l_apda.apdadocdt,l_apde.apde100,ls_js)
        RETURNING l_apde.apde101,l_apde.apde121,l_apde.apde131
   #s_curr_round
   LET l_apde.apde101 = g_apga101
   LET l_apde.apde120 = l_glaa016
   
   IF l_glaa015 = 'Y' THEN
      LET l_apde.apde129 = l_apde.apde109 * l_apde.apde121
      CALL s_curr_round_ld('1',l_apda.apdald,l_apde.apde120,l_apde.apde129,2) RETURNING g_sub_success,g_errno,l_apde.apde129
   END IF
   
   LET l_apde.apde130 = l_glaa020
   IF l_glaa019 = 'Y' THEN
      LET l_apde.apde139 = l_apde.apde109 * l_apde.apde131
      CALL s_curr_round_ld('1',l_apda.apdald,l_apde.apde130,l_apde.apde139,2) RETURNING g_sub_success,g_errno,l_apde.apde139
   END IF
    
   
   IF l_apde.apde109 > 0 THEN
      #INSERT INTO apde_t VALUES(l_apde.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO apde_t (apdeent,apdecomp,apdeld,apdedocno,apdeseq,
                          apdesite,apdeorga,
                          apde001,apde002,apde003,apde004,apde006,
                          apde008,apde009,apde010,apde011,apde012,
                          apde013,apde014,apde015,apde016,apde017,
                          apde018,apde019,apde020,apde021,apde022,
                          apde023,apde024,apde028,apde029,apde030,
                          apde032,apde035,apde036,apde038,apde039,
                          apde040,apde041,apde042,apde043,apde044,
                          apde045,apde046,apde047,apde051,apde052,
                          apde053,apde054,apde055,apde056,apde057,
                          apde058,apde059,apde060,apde100,apde101,
                          apde104,apde109,apde119,apde120,apde121,
                          apde129,apde130,apde131,apde139,
                          apdeud001,apdeud002,apdeud003,apdeud004,apdeud005,
                          apdeud006,apdeud007,apdeud008,apdeud009,apdeud010,
                          apdeud011,apdeud012,apdeud013,apdeud014,apdeud015,
                          apdeud016,apdeud017,apdeud018,apdeud019,apdeud020,
                          apdeud021,apdeud022,apdeud023,apdeud024,apdeud025,
                          apdeud026,apdeud027,apdeud028,apdeud029,apdeud030,
                          apde061
                         )
      VALUES (l_apde.apdeent,l_apde.apdecomp,l_apde.apdeld,l_apde.apdedocno,l_apde.apdeseq,
              l_apde.apdesite,l_apde.apdeorga,
              l_apde.apde001,l_apde.apde002,l_apde.apde003,l_apde.apde004,l_apde.apde006,
              l_apde.apde008,l_apde.apde009,l_apde.apde010,l_apde.apde011,l_apde.apde012,
              l_apde.apde013,l_apde.apde014,l_apde.apde015,l_apde.apde016,l_apde.apde017,
              l_apde.apde018,l_apde.apde019,l_apde.apde020,l_apde.apde021,l_apde.apde022,
              l_apde.apde023,l_apde.apde024,l_apde.apde028,l_apde.apde029,l_apde.apde030,
              l_apde.apde032,l_apde.apde035,l_apde.apde036,l_apde.apde038,l_apde.apde039,
              l_apde.apde040,l_apde.apde041,l_apde.apde042,l_apde.apde043,l_apde.apde044,
              l_apde.apde045,l_apde.apde046,l_apde.apde047,l_apde.apde051,l_apde.apde052,
              l_apde.apde053,l_apde.apde054,l_apde.apde055,l_apde.apde056,l_apde.apde057,
              l_apde.apde058,l_apde.apde059,l_apde.apde060,l_apde.apde100,l_apde.apde101,
              l_apde.apde104,l_apde.apde109,l_apde.apde119,l_apde.apde120,l_apde.apde121,
              l_apde.apde129,l_apde.apde130,l_apde.apde131,l_apde.apde139,
              l_apde.apdeud001,l_apde.apdeud002,l_apde.apdeud003,l_apde.apdeud004,l_apde.apdeud005,
              l_apde.apdeud006,l_apde.apdeud007,l_apde.apdeud008,l_apde.apdeud009,l_apde.apdeud010,
              l_apde.apdeud011,l_apde.apdeud012,l_apde.apdeud013,l_apde.apdeud014,l_apde.apdeud015,
              l_apde.apdeud016,l_apde.apdeud017,l_apde.apdeud018,l_apde.apdeud019,l_apde.apdeud020,
              l_apde.apdeud021,l_apde.apdeud022,l_apde.apdeud023,l_apde.apdeud024,l_apde.apdeud025,
              l_apde.apdeud026,l_apde.apdeud027,l_apde.apdeud028,l_apde.apdeud029,l_apde.apdeud030,
              l_apde.apde061
             )
      #161108-00017#4 add end---
   END IF 
   
   CALL s_aapt420_upd_dc_money(l_apda.apdald,l_apda.apdadocno) RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   
   CALL cl_get_para(g_enterprise,l_apda.apdacomp,'S-FIN-3008') RETURNING l_sfin3008
   
   CALL s_aooi200_fin_get_slip(l_apda.apdadocno) RETURNING g_sub_success,l_slip
   CALL s_fin_get_doc_para(l_apda.apdald,l_apda.apdacomp,l_slip,'D-FIN-0030') RETURNING l_chr
   IF l_glaa121 = 'Y' THEN
      CALL s_pre_voucher_ins('AP','P20',l_apda.apdald,l_apda.apdadocno,l_apda.apdadocdt,'2')
        RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
   END IF
   
   IF r_success THEN
      IF NOT s_aapt420_conf_chk(l_apda.apdald,l_apda.apdadocno) THEN
         LET r_success = FALSE
      ELSE
         IF NOT s_aapt420_conf_upd(l_apda.apdald,l_apda.apdadocno,l_sfin3008) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF r_success THEN
      LET r_apdald = l_apda.apdald
      LET r_apdadocno = l_apda.apdadocno
   END IF
   RETURN r_success,r_apdald,r_apdadocno
END FUNCTION

 
{</section>}
 
