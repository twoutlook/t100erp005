#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt540_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-06-14 10:22:27), PR版次:0009(2017-01-09 15:38:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: aapt540_01
#+ Description: 轉融資資料
#+ Creator....: 03080(2016-03-24 14:15:52)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aapt540_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161104-00024#4  2016/11/09 By 08729     處理DEFINE有星號
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#161208-00026#12 2016/12/12 By 08729     針對SELECT有星號的部分進行展開
#161104-00046#7  2016/01/04 By 08171     單別預設值;資料依照單別user dept權限過濾單號
#161230-00058#1  2017/01/06 By 06694     付款帳戶開窗(q_nmas_01)增加部門設限資料(nmlm_t)的where條件
#170109-00035#1  170109     By albireo   1.修正先前修改.*造成的錯誤 2.帳戶需融資類型
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
PRIVATE type type_g_fmcj_m        RECORD
       fmcjdocno LIKE fmcj_t.fmcjdocno, 
   fmcjdocdt LIKE fmcj_t.fmcjdocdt, 
   fmcj005 LIKE fmcj_t.fmcj005, 
   fmcj001 LIKE fmcj_t.fmcj001, 
   fmcj009 LIKE fmcj_t.fmcj009, 
   fmcj003 LIKE fmcj_t.fmcj003, 
   l_fmck003 LIKE type_t.chr30, 
   l_fmcrdocno LIKE type_t.chr20, 
   l_fmcrdocdt LIKE type_t.dat, 
   l_fmcs006 LIKE type_t.chr10, 
   l_fmcs006_desc LIKE type_t.chr80, 
   l_fmcs016 LIKE type_t.chr10, 
   l_fmcs016_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apgkcomp  LIKE apgk_t.apgkcomp
DEFINE g_apgkdocno LIKE apgk_t.apgkdocno
#161104-00046#7 --s add
DEFINE g_user_slip_wc      STRING
DEFINE g_ap_slip           LIKE ooba_t.ooba002
#161104-00046#7 --e add
#end add-point
 
DEFINE g_fmcj_m        type_g_fmcj_m
 
   DEFINE g_fmcjdocno_t LIKE fmcj_t.fmcjdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt540_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt540_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_lsjs
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
   DEFINE p_lsjs   STRING
   DEFINE lc_param        RECORD
                       apgkcomp LIKE apgk_t.apgkcomp,
                       apgkdocno LIKE apgk_t.apgkdocno
                             END RECORD
   DEFINE r_afmt035    LIKE apga_t.apgadocno
   DEFINE r_afmt140    LIKE apga_t.apgadocno
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_ld         LIKE glaa_t.glaald
   DEFINE l_glaa024    LIKE glaa_t.glaa024
   DEFINE l_apga007    LIKE apga_t.apga007
   DEFINE l_glaa005    LIKE glaa_t.glaa005
   DEFINE l_flag1      LIKE type_t.num5 #161104-00046#7
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt540_01 WITH FORM cl_ap_formpath("aap","aapt540_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('fmcj005','8854')
   LET r_success = TRUE
   LET r_afmt035 = NULL    LET r_afmt140 = NULL
   CALL util.JSON.parse(p_lsjs,lc_param)
   LET g_apgkdocno = lc_param.apgkdocno
   LET g_apgkcomp  = lc_param.apgkcomp
   
   #給予預設-----s
   LET l_apga007 = NULL
   SELECT apga003,apga007 
     INTO g_fmcj_m.fmcjdocdt,l_apga007
     FROM apga_t,apgk_t
    WHERE apgaent = g_enterprise
      AND apgacomp = g_apgkcomp
      AND apgadocno = apgk005
      AND apgaent = apgkent
      AND apgacomp = apgkcomp
      ANd apgkdocno = g_apgkdocno
   SELECT apgk006 INTO g_fmcj_m.l_fmcrdocdt FROM apgk_t
    WHERE apgkent = g_enterprise
      AND apgkcomp = g_apgkcomp
      AND apgkdocno = g_apgkdocno
      
   LET g_fmcj_m.fmcj009 = 360
   #給予預設-----e
   #161104-00046#7 --s add
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#7 --e add
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj005,g_fmcj_m.fmcj001,g_fmcj_m.fmcj009, 
          g_fmcj_m.fmcj003,g_fmcj_m.l_fmck003,g_fmcj_m.l_fmcrdocno,g_fmcj_m.l_fmcrdocdt,g_fmcj_m.l_fmcs006, 
          g_fmcj_m.l_fmcs016 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjdocno
            #add-point:BEFORE FIELD fmcjdocno name="input.b.fmcjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjdocno
            
            #add-point:AFTER FIELD fmcjdocno name="input.a.fmcjdocno"
            LET l_ld = NULL   LET l_glaa024 = NULL
            SELECT glaald,glaa024 INTO l_ld,l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014=  'Y'
            IF NOT cl_null(g_fmcj_m.fmcjdocno) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcj_t WHERE "||"fmcjent = '" ||g_enterprise|| "' AND "||"fmcjdocno = '"||g_fmcj_m.fmcjdocno ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               CALL s_aooi200_fin_chk_slip(l_ld,l_glaa024,g_fmcj_m.fmcjdocno,'afmt035') RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fmcj_m.fmcjdocno = ''
                  NEXT FIELD fmcjdocno
               END IF
               #161104-00046#7 --s add
               CALL s_control_chk_doc('1',g_fmcj_m.fmcjdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
               IF g_sub_success AND l_flag1 THEN             
               ELSE
                  LET g_fmcj_m.fmcjdocno = ''
                  NEXT FIELD CURRENT                
               END IF
               #161104-00046#7 --e add
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjdocno
            #add-point:ON CHANGE fmcjdocno name="input.g.fmcjdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjdocdt
            #add-point:BEFORE FIELD fmcjdocdt name="input.b.fmcjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjdocdt
            
            #add-point:AFTER FIELD fmcjdocdt name="input.a.fmcjdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjdocdt
            #add-point:ON CHANGE fmcjdocdt name="input.g.fmcjdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj005
            #add-point:BEFORE FIELD fmcj005 name="input.b.fmcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj005
            
            #add-point:AFTER FIELD fmcj005 name="input.a.fmcj005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj005
            #add-point:ON CHANGE fmcj005 name="input.g.fmcj005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj001
            
            #add-point:AFTER FIELD fmcj001 name="input.a.fmcj001"
            IF NOT cl_null(g_fmcj_m.fmcj001) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj_m.fmcj001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_fmcj_m.fmcj001
#            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_fmcj_m.fmcj001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_fmcj_m.fmcj001_desc
#

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj001
            #add-point:BEFORE FIELD fmcj001 name="input.b.fmcj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj001
            #add-point:ON CHANGE fmcj001 name="input.g.fmcj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj009
            #add-point:BEFORE FIELD fmcj009 name="input.b.fmcj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj009
            
            #add-point:AFTER FIELD fmcj009 name="input.a.fmcj009"
            IF NOT cl_null(g_fmcj_m.fmcj009)THEN
               IF NOT cl_ap_chk_range(g_fmcj_m.fmcj009,"1","1","365","1","azz-00087",1) THEN
                  NEXT FIELD fmcj009
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj009
            #add-point:ON CHANGE fmcj009 name="input.g.fmcj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj003
            #add-point:BEFORE FIELD fmcj003 name="input.b.fmcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj003
            
            #add-point:AFTER FIELD fmcj003 name="input.a.fmcj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj003
            #add-point:ON CHANGE fmcj003 name="input.g.fmcj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmck003
            #add-point:BEFORE FIELD l_fmck003 name="input.b.l_fmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmck003
            
            #add-point:AFTER FIELD l_fmck003 name="input.a.l_fmck003"
            IF NOT cl_null(g_fmcj_m.l_fmck003) THEN
               LET g_chkparam.arg1 = g_fmcj_m.l_fmck003
               LET g_chkparam.arg2 = g_apgkcomp
               #LET g_chkparam.arg3 = '5'    #aapt5系列皆付現  所以帳戶為零用金類型(比照aapt420現金類處理)   #170109-00035#1 mark
               LET g_chkparam.arg3 = '2'     #原規格未寫,SA提醒應為融資     #170109-00035#1
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
               IF cl_chk_exist("v_nmas002_4") THEN
                  IF NOT s_anmi120_nmll002_chk(g_fmcj_m.l_fmck003,g_user) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'anm-00574'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmck003
            #add-point:ON CHANGE l_fmck003 name="input.g.l_fmck003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcrdocno
            #add-point:BEFORE FIELD l_fmcrdocno name="input.b.l_fmcrdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcrdocno
            
            #add-point:AFTER FIELD l_fmcrdocno name="input.a.l_fmcrdocno"
            LET l_ld = NULL   LET l_glaa024 = NULL
            SELECT glaald,glaa024 INTO l_ld,l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014=  'Y'
            IF NOT cl_null(g_fmcj_m.l_fmcrdocno) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcr_t WHERE "||"fmcrent = '" ||g_enterprise|| "' AND "||"fmcrdocno = '"||g_fmcj_m.l_fmcrdocno ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               CALL s_aooi200_fin_chk_slip(l_ld,l_glaa024,g_fmcj_m.l_fmcrdocno,'afmt140') RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fmcj_m.l_fmcrdocno = ''
                  NEXT FIELD l_fmcrdocno
               END IF
               #161104-00046#7 --s add
               CALL s_control_chk_doc('1',g_fmcj_m.l_fmcrdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
               IF g_sub_success AND l_flag1 THEN             
               ELSE
                  LET g_fmcj_m.l_fmcrdocno = ''
                  NEXT FIELD CURRENT                
               END IF
               #161104-00046#7 --e add
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcrdocno
            #add-point:ON CHANGE l_fmcrdocno name="input.g.l_fmcrdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcrdocdt
            #add-point:BEFORE FIELD l_fmcrdocdt name="input.b.l_fmcrdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcrdocdt
            
            #add-point:AFTER FIELD l_fmcrdocdt name="input.a.l_fmcrdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcrdocdt
            #add-point:ON CHANGE l_fmcrdocdt name="input.g.l_fmcrdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcs006
            
            #add-point:AFTER FIELD l_fmcs006 name="input.a.l_fmcs006"
            #160428-00001#4-----s
            LET g_fmcj_m.l_fmcs006_desc = ''
            IF NOT cl_null(g_fmcj_m.l_fmcs006) THEN
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent  = g_enterprise
                  AND glaacomp = g_apgkcomp
                  AND glaa014  = 'Y'
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_glaa005
               LET g_chkparam.arg2 = g_fmcj_m.l_fmcs006
               LET g_errshow = TRUE
               LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
               IF cl_chk_exist("v_nmad002") THEN
                  IF cl_null(g_fmcj_m.l_fmcs006) THEN
                     SELECT nmad003 INTO g_fmcj_m.l_fmcs016
                       FROM nmad_t
                      WHERE nmadent = g_enterprise
                        AND nmad001 = l_glaa005
                        AND nmad002 = g_fmcj_m.l_fmcs006
                     CALL s_desc_get_nmail004_desc(l_glaa005,g_fmcj_m.l_fmcs016) RETURNING g_fmcj_m.l_fmcs016_desc
                     DISPLAY BY NAME g_fmcj_m.l_fmcs016,g_fmcj_m.l_fmcs016_desc
                  END IF
               ELSE
                  LET g_fmcj_m.l_fmcs006 = NULL
                  CALL s_desc_get_nmajl003_desc(g_fmcj_m.l_fmcs006) RETURNING g_fmcj_m.l_fmcs006_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_nmajl003_desc(g_fmcj_m.l_fmcs006) RETURNING g_fmcj_m.l_fmcs006_desc
            DISPLAY BY NAME g_fmcj_m.l_fmcs006_desc               
             #160428-00001#4-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcs006
            #add-point:BEFORE FIELD l_fmcs006 name="input.b.l_fmcs006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcs006
            #add-point:ON CHANGE l_fmcs006 name="input.g.l_fmcs006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcs016
            
            #add-point:AFTER FIELD l_fmcs016 name="input.a.l_fmcs016"
            #160428-00001#4-----s
            IF NOT cl_null(g_fmcj_m.l_fmcs016) THEN
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent  = g_enterprise
                  AND glaacomp = g_apgkcomp
                  AND glaa014  = 'Y'
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_fmcj_m.l_fmcs016
               LET g_chkparam.arg2 = l_glaa005
               IF cl_chk_exist("v_nmai002") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET g_fmcj_m.l_fmcs016 = ''
                  CALL s_desc_get_nmail004_desc(l_glaa005,g_fmcj_m.l_fmcs016 ) RETURNING g_fmcj_m.l_fmcs016_desc
                  DISPLAY BY NAME g_fmcj_m.l_fmcs016_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            CALL s_desc_get_nmail004_desc(l_glaa005,g_fmcj_m.l_fmcs016 ) RETURNING g_fmcj_m.l_fmcs016_desc
            DISPLAY BY NAME g_fmcj_m.l_fmcs016_desc
            #160428-00001#4-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcs016
            #add-point:BEFORE FIELD l_fmcs016 name="input.b.l_fmcs016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcs016
            #add-point:ON CHANGE l_fmcs016 name="input.g.l_fmcs016"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmcjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjdocno
            #add-point:ON ACTION controlp INFIELD fmcjdocno name="input.c.fmcjdocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014 = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj_m.fmcjdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",l_glaa024,"' AND oobx003 = 'afmt035'"
            #161104-00046#7 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#7 --e add
            CALL q_ooba002_4()                             
            LET g_fmcj_m.fmcjdocno = g_qryparam.return1
            DISPLAY g_fmcj_m.fmcjdocno TO fmcjdocno             
            NEXT FIELD fmcjdocno   
            #END add-point
 
 
         #Ctrlp:input.c.fmcjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjdocdt
            #add-point:ON ACTION controlp INFIELD fmcjdocdt name="input.c.fmcjdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj005
            #add-point:ON ACTION controlp INFIELD fmcj005 name="input.c.fmcj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj001
            #add-point:ON ACTION controlp INFIELD fmcj001 name="input.c.fmcj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj_m.fmcj001             
            CALL q_fmaa001_1()                                
            LET g_fmcj_m.fmcj001 = g_qryparam.return1
            DISPLAY g_fmcj_m.fmcj001 TO fmcj001              
            NEXT FIELD fmcj001                         
            #END add-point
 
 
         #Ctrlp:input.c.fmcj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj009
            #add-point:ON ACTION controlp INFIELD fmcj009 name="input.c.fmcj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj003
            #add-point:ON ACTION controlp INFIELD fmcj003 name="input.c.fmcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmck003
            #add-point:ON ACTION controlp INFIELD l_fmck003 name="input.c.l_fmck003"
            #161004-00019#1 mark-----s
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_fmcj_m.l_fmck003  
            #LET g_qryparam.arg1 = g_apgkcomp
            #LET g_qryparam.arg2 = l_apga007
            #CALL q_nmas002_1()                               
            #LET g_fmcj_m.l_fmck003   = g_qryparam.return1
            #DISPLAY BY NAME g_fmcj_m.l_fmck003              
            #NEXT FIELD l_fmck003             
            #161004-00019#1 mark-----e
            
            #161004-00019#1-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj_m.l_fmck003
            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                                   "              AND ooef017 = '", g_apgkcomp,"')",
                                   " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                   " AND nmagent = nmaaent ",   
                                   " AND nmaa004 = '",l_apga007,"' ",
                                   #" AND nmag002 IN ('1','5'))",     #170109-00035#1 mark
                                   " AND nmag002 IN ('1','2'))",     #170109-00035#1 
#                                  " AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')"     #161230-00058#1 mark
                                   #161230-00058#1 add (S)
                                   " AND ( nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')",
                                   "  OR nmas002 IN (SELECT nmlm001 FROM nmlm_t WHERE nmlment=",g_enterprise, " AND nmlm002 = '",g_dept,"') )"
                                   #161230-00058#1 add (E) 
            CALL q_nmas_01()
            LET g_fmcj_m.l_fmck003   = g_qryparam.return1
            DISPLAY BY NAME g_fmcj_m.l_fmck003              
            NEXT FIELD l_fmck003  
            #161004-00019#1-----e
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcrdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcrdocno
            #add-point:ON ACTION controlp INFIELD l_fmcrdocno name="input.c.l_fmcrdocno"
            #160428-00001#4-----s
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014 = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj_m.l_fmcrdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",l_glaa024,"' AND oobx003 = 'afmt140'"
            #161104-00046#7 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#7 --e add
            CALL q_ooba002_4()                             
            LET g_fmcj_m.l_fmcrdocno  = g_qryparam.return1
            DISPLAY g_fmcj_m.l_fmcrdocno TO l_fmcrdocno             
            NEXT FIELD l_fmcrdocno 
            #160428-00001#4-----e
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcrdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcrdocdt
            #add-point:ON ACTION controlp INFIELD l_fmcrdocdt name="input.c.l_fmcrdocdt"
 
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcs006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcs006
            #add-point:ON ACTION controlp INFIELD l_fmcs006 name="input.c.l_fmcs006"
            #160428-00001#4-----s
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj_m.l_fmcs006             #給予default值
            LET g_qryparam.arg1 = l_glaa005
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='1'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()
            LET g_fmcj_m.l_fmcs006 = g_qryparam.return1
            DISPLAY BY NAME g_fmcj_m.l_fmcs006
            NEXT FIELD l_fmcs006
            #160428-00001#4-----e
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcs016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcs016
            #add-point:ON ACTION controlp INFIELD l_fmcs016 name="input.c.l_fmcs016"
            #160428-00001#4-----s
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj_m.l_fmcs016 
            LET g_qryparam.arg1 = ""
            LET g_qryparam.where = " nmai001='",l_glaa005,"' "
            CALL q_nmai002()
            LET g_fmcj_m.l_fmcs016  = g_qryparam.return1
            DISPLAY BY NAME g_fmcj_m.l_fmcs016 
            NEXT FIELD l_fmcs016
            #160428-00001#4-----e
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
   CLOSE WINDOW w_aapt540_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET r_success = FALSE
   ELSE
      CALL aapt540_01_ins_afm() RETURNING g_sub_success,r_afmt035,r_afmt140
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_afmt035 = ''
         LET r_afmt140 = ''
      END IF
   END IF

   RETURN r_success,r_afmt035,r_afmt140
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt540_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt540_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION aapt540_01_ins_afm()
   #161104-00024#4-mark(s)
   #DEFINE l_fmcj RECORD LIKE fmcj_t.*
   #DEFINE l_fmck RECORD LIKE fmck_t.*
   #DEFINE l_fmcl RECORD LIKE fmcl_t.*
   #DEFINE l_fmcm RECORD LIKE fmcm_t.*
   #DEFINE l_fmcn RECORD LIKE fmcn_t.*
   #DEFINE l_fmco RECORD LIKE fmco_t.*
   #
   #DEFINE l_apgk RECORD LIKE apgk_t.*
   #DEFINE l_apga RECORD LIKE apga_t.*
   #161104-00024#4-mark(e)
   #161104-00024#4-add(s)
   DEFINE l_fmcj  RECORD  #融資合約單頭檔
          fmcjent   LIKE fmcj_t.fmcjent, #企業編號
          fmcjownid LIKE fmcj_t.fmcjownid, #資料所屬者
          fmcjowndp LIKE fmcj_t.fmcjowndp, #資料所屬部門
          fmcjcrtid LIKE fmcj_t.fmcjcrtid, #資料建立者
          fmcjcrtdp LIKE fmcj_t.fmcjcrtdp, #資料建立部門
          fmcjcrtdt LIKE fmcj_t.fmcjcrtdt, #資料創建日
          fmcjmodid LIKE fmcj_t.fmcjmodid, #資料修改者
          fmcjmoddt LIKE fmcj_t.fmcjmoddt, #最近修改日
          fmcjcnfid LIKE fmcj_t.fmcjcnfid, #資料確認者
          fmcjcnfdt LIKE fmcj_t.fmcjcnfdt, #資料確認日
          fmcjstus  LIKE fmcj_t.fmcjstus, #狀態碼
          fmcjdocno LIKE fmcj_t.fmcjdocno, #融資合約編號
          fmcjsite  LIKE fmcj_t.fmcjsite, #融資組織
          fmcjcomp  LIKE fmcj_t.fmcjcomp, #法人
          fmcjdocdt LIKE fmcj_t.fmcjdocdt, #簽訂日期
          fmcj001   LIKE fmcj_t.fmcj001, #融資類型
          fmcj002   LIKE fmcj_t.fmcj002, #貸款銀行
          fmcj003   LIKE fmcj_t.fmcj003, #銀行貸款合約編號
          fmcj004   LIKE fmcj_t.fmcj004, #合約編號
          fmcj005   LIKE fmcj_t.fmcj005, #擔保方式
          fmcj006   LIKE fmcj_t.fmcj006, #貸款期限起
          fmcj007   LIKE fmcj_t.fmcj007, #貸款期限止
          fmcj008   LIKE fmcj_t.fmcj008, #不定日分次劃付
          fmcj009   LIKE fmcj_t.fmcj009, #計息基礎
          fmcjud001 LIKE fmcj_t.fmcjud001, #自定義欄位(文字)001
          fmcjud002 LIKE fmcj_t.fmcjud002, #自定義欄位(文字)002
          fmcjud003 LIKE fmcj_t.fmcjud003, #自定義欄位(文字)003
          fmcjud004 LIKE fmcj_t.fmcjud004, #自定義欄位(文字)004
          fmcjud005 LIKE fmcj_t.fmcjud005, #自定義欄位(文字)005
          fmcjud006 LIKE fmcj_t.fmcjud006, #自定義欄位(文字)006
          fmcjud007 LIKE fmcj_t.fmcjud007, #自定義欄位(文字)007
          fmcjud008 LIKE fmcj_t.fmcjud008, #自定義欄位(文字)008
          fmcjud009 LIKE fmcj_t.fmcjud009, #自定義欄位(文字)009
          fmcjud010 LIKE fmcj_t.fmcjud010, #自定義欄位(文字)010
          fmcjud011 LIKE fmcj_t.fmcjud011, #自定義欄位(數字)011
          fmcjud012 LIKE fmcj_t.fmcjud012, #自定義欄位(數字)012
          fmcjud013 LIKE fmcj_t.fmcjud013, #自定義欄位(數字)013
          fmcjud014 LIKE fmcj_t.fmcjud014, #自定義欄位(數字)014
          fmcjud015 LIKE fmcj_t.fmcjud015, #自定義欄位(數字)015
          fmcjud016 LIKE fmcj_t.fmcjud016, #自定義欄位(數字)016
          fmcjud017 LIKE fmcj_t.fmcjud017, #自定義欄位(數字)017
          fmcjud018 LIKE fmcj_t.fmcjud018, #自定義欄位(數字)018
          fmcjud019 LIKE fmcj_t.fmcjud019, #自定義欄位(數字)019
          fmcjud020 LIKE fmcj_t.fmcjud020, #自定義欄位(數字)020
          fmcjud021 LIKE fmcj_t.fmcjud021, #自定義欄位(日期時間)021
          fmcjud022 LIKE fmcj_t.fmcjud022, #自定義欄位(日期時間)022
          fmcjud023 LIKE fmcj_t.fmcjud023, #自定義欄位(日期時間)023
          fmcjud024 LIKE fmcj_t.fmcjud024, #自定義欄位(日期時間)024
          fmcjud025 LIKE fmcj_t.fmcjud025, #自定義欄位(日期時間)025
          fmcjud026 LIKE fmcj_t.fmcjud026, #自定義欄位(日期時間)026
          fmcjud027 LIKE fmcj_t.fmcjud027, #自定義欄位(日期時間)027
          fmcjud028 LIKE fmcj_t.fmcjud028, #自定義欄位(日期時間)028
          fmcjud029 LIKE fmcj_t.fmcjud029, #自定義欄位(日期時間)029
          fmcjud030 LIKE fmcj_t.fmcjud030  #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_fmck  RECORD  #融資明細檔
          fmckent   LIKE fmck_t.fmckent, #企業編號
          fmckdocno LIKE fmck_t.fmckdocno, #融資合約編號
          fmckseq   LIKE fmck_t.fmckseq, #合約項次
          fmck001   LIKE fmck_t.fmck001, #貨款銀行
          fmck002   LIKE fmck_t.fmck002, #幣別
          fmck003   LIKE fmck_t.fmck003, #貸款帳戶
          fmck004   LIKE fmck_t.fmck004, #金額
          fmck005   LIKE fmck_t.fmck005, #利率方式
          fmck006   LIKE fmck_t.fmck006, #浮動方式
          fmck007   LIKE fmck_t.fmck007, #固定利率/浮動利率(年%)
          fmck008   LIKE fmck_t.fmck008, #逾期罰息率(年%)
          fmck009   LIKE fmck_t.fmck009, #挪用罰息率(年%)
          fmck010   LIKE fmck_t.fmck010, #複利計算
          fmck011   LIKE fmck_t.fmck011, #融資稽覈單號
          fmck012   LIKE fmck_t.fmck012, #融資稽覈單項次
          fmckud001 LIKE fmck_t.fmckud001, #自定義欄位(文字)001
          fmckud002 LIKE fmck_t.fmckud002, #自定義欄位(文字)002
          fmckud003 LIKE fmck_t.fmckud003, #自定義欄位(文字)003
          fmckud004 LIKE fmck_t.fmckud004, #自定義欄位(文字)004
          fmckud005 LIKE fmck_t.fmckud005, #自定義欄位(文字)005
          fmckud006 LIKE fmck_t.fmckud006, #自定義欄位(文字)006
          fmckud007 LIKE fmck_t.fmckud007, #自定義欄位(文字)007
          fmckud008 LIKE fmck_t.fmckud008, #自定義欄位(文字)008
          fmckud009 LIKE fmck_t.fmckud009, #自定義欄位(文字)009
          fmckud010 LIKE fmck_t.fmckud010, #自定義欄位(文字)010
          fmckud011 LIKE fmck_t.fmckud011, #自定義欄位(數字)011
          fmckud012 LIKE fmck_t.fmckud012, #自定義欄位(數字)012
          fmckud013 LIKE fmck_t.fmckud013, #自定義欄位(數字)013
          fmckud014 LIKE fmck_t.fmckud014, #自定義欄位(數字)014
          fmckud015 LIKE fmck_t.fmckud015, #自定義欄位(數字)015
          fmckud016 LIKE fmck_t.fmckud016, #自定義欄位(數字)016
          fmckud017 LIKE fmck_t.fmckud017, #自定義欄位(數字)017
          fmckud018 LIKE fmck_t.fmckud018, #自定義欄位(數字)018
          fmckud019 LIKE fmck_t.fmckud019, #自定義欄位(數字)019
          fmckud020 LIKE fmck_t.fmckud020, #自定義欄位(數字)020
          fmckud021 LIKE fmck_t.fmckud021, #自定義欄位(日期時間)021
          fmckud022 LIKE fmck_t.fmckud022, #自定義欄位(日期時間)022
          fmckud023 LIKE fmck_t.fmckud023, #自定義欄位(日期時間)023
          fmckud024 LIKE fmck_t.fmckud024, #自定義欄位(日期時間)024
          fmckud025 LIKE fmck_t.fmckud025, #自定義欄位(日期時間)025
          fmckud026 LIKE fmck_t.fmckud026, #自定義欄位(日期時間)026
          fmckud027 LIKE fmck_t.fmckud027, #自定義欄位(日期時間)027
          fmckud028 LIKE fmck_t.fmckud028, #自定義欄位(日期時間)028
          fmckud029 LIKE fmck_t.fmckud029, #自定義欄位(日期時間)029
          fmckud030 LIKE fmck_t.fmckud030  #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_fmcl  RECORD  #融資付息還本設定檔
          fmclent   LIKE fmcl_t.fmclent, #企業編號
          fmcldocno LIKE fmcl_t.fmcldocno, #融資合約編號
          fmclseq   LIKE fmcl_t.fmclseq, #融資清單項次
          fmclseq2  LIKE fmcl_t.fmclseq2, #項次
          fmcl001   LIKE fmcl_t.fmcl001, #還款性質
          fmcl002   LIKE fmcl_t.fmcl002, #還款週期
          fmcl003   LIKE fmcl_t.fmcl003, #起始付息期別
          fmcl004   LIKE fmcl_t.fmcl004, #付息日
          fmcl005   LIKE fmcl_t.fmcl005, #約定還本日期
          fmcl006   LIKE fmcl_t.fmcl006, #還本金額
          fmclud001 LIKE fmcl_t.fmclud001, #自定義欄位(文字)001
          fmclud002 LIKE fmcl_t.fmclud002, #自定義欄位(文字)002
          fmclud003 LIKE fmcl_t.fmclud003, #自定義欄位(文字)003
          fmclud004 LIKE fmcl_t.fmclud004, #自定義欄位(文字)004
          fmclud005 LIKE fmcl_t.fmclud005, #自定義欄位(文字)005
          fmclud006 LIKE fmcl_t.fmclud006, #自定義欄位(文字)006
          fmclud007 LIKE fmcl_t.fmclud007, #自定義欄位(文字)007
          fmclud008 LIKE fmcl_t.fmclud008, #自定義欄位(文字)008
          fmclud009 LIKE fmcl_t.fmclud009, #自定義欄位(文字)009
          fmclud010 LIKE fmcl_t.fmclud010, #自定義欄位(文字)010
          fmclud011 LIKE fmcl_t.fmclud011, #自定義欄位(數字)011
          fmclud012 LIKE fmcl_t.fmclud012, #自定義欄位(數字)012
          fmclud013 LIKE fmcl_t.fmclud013, #自定義欄位(數字)013
          fmclud014 LIKE fmcl_t.fmclud014, #自定義欄位(數字)014
          fmclud015 LIKE fmcl_t.fmclud015, #自定義欄位(數字)015
          fmclud016 LIKE fmcl_t.fmclud016, #自定義欄位(數字)016
          fmclud017 LIKE fmcl_t.fmclud017, #自定義欄位(數字)017
          fmclud018 LIKE fmcl_t.fmclud018, #自定義欄位(數字)018
          fmclud019 LIKE fmcl_t.fmclud019, #自定義欄位(數字)019
          fmclud020 LIKE fmcl_t.fmclud020, #自定義欄位(數字)020
          fmclud021 LIKE fmcl_t.fmclud021, #自定義欄位(日期時間)021
          fmclud022 LIKE fmcl_t.fmclud022, #自定義欄位(日期時間)022
          fmclud023 LIKE fmcl_t.fmclud023, #自定義欄位(日期時間)023
          fmclud024 LIKE fmcl_t.fmclud024, #自定義欄位(日期時間)024
          fmclud025 LIKE fmcl_t.fmclud025, #自定義欄位(日期時間)025
          fmclud026 LIKE fmcl_t.fmclud026, #自定義欄位(日期時間)026
          fmclud027 LIKE fmcl_t.fmclud027, #自定義欄位(日期時間)027
          fmclud028 LIKE fmcl_t.fmclud028, #自定義欄位(日期時間)028
          fmclud029 LIKE fmcl_t.fmclud029, #自定義欄位(日期時間)029
          fmclud030 LIKE fmcl_t.fmclud030  #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_fmcm  RECORD  #融資資金划付明細檔
          fmcment   LIKE fmcm_t.fmcment, #企業編號
          fmcmdocno LIKE fmcm_t.fmcmdocno, #融資合約編號
          fmcmseq   LIKE fmcm_t.fmcmseq, #合約項次
          fmcmseq2  LIKE fmcm_t.fmcmseq2, #項次
          fmcm001   LIKE fmcm_t.fmcm001, #幣別
          fmcm002   LIKE fmcm_t.fmcm002, #划付日期
          fmcm003   LIKE fmcm_t.fmcm003, #貸款帳戶
          fmcm004   LIKE fmcm_t.fmcm004, #金額
          fmcmud001 LIKE fmcm_t.fmcmud001, #自定義欄位(文字)001
          fmcmud002 LIKE fmcm_t.fmcmud002, #自定義欄位(文字)002
          fmcmud003 LIKE fmcm_t.fmcmud003, #自定義欄位(文字)003
          fmcmud004 LIKE fmcm_t.fmcmud004, #自定義欄位(文字)004
          fmcmud005 LIKE fmcm_t.fmcmud005, #自定義欄位(文字)005
          fmcmud006 LIKE fmcm_t.fmcmud006, #自定義欄位(文字)006
          fmcmud007 LIKE fmcm_t.fmcmud007, #自定義欄位(文字)007
          fmcmud008 LIKE fmcm_t.fmcmud008, #自定義欄位(文字)008
          fmcmud009 LIKE fmcm_t.fmcmud009, #自定義欄位(文字)009
          fmcmud010 LIKE fmcm_t.fmcmud010, #自定義欄位(文字)010
          fmcmud011 LIKE fmcm_t.fmcmud011, #自定義欄位(數字)011
          fmcmud012 LIKE fmcm_t.fmcmud012, #自定義欄位(數字)012
          fmcmud013 LIKE fmcm_t.fmcmud013, #自定義欄位(數字)013
          fmcmud014 LIKE fmcm_t.fmcmud014, #自定義欄位(數字)014
          fmcmud015 LIKE fmcm_t.fmcmud015, #自定義欄位(數字)015
          fmcmud016 LIKE fmcm_t.fmcmud016, #自定義欄位(數字)016
          fmcmud017 LIKE fmcm_t.fmcmud017, #自定義欄位(數字)017
          fmcmud018 LIKE fmcm_t.fmcmud018, #自定義欄位(數字)018
          fmcmud019 LIKE fmcm_t.fmcmud019, #自定義欄位(數字)019
          fmcmud020 LIKE fmcm_t.fmcmud020, #自定義欄位(數字)020
          fmcmud021 LIKE fmcm_t.fmcmud021, #自定義欄位(日期時間)021
          fmcmud022 LIKE fmcm_t.fmcmud022, #自定義欄位(日期時間)022
          fmcmud023 LIKE fmcm_t.fmcmud023, #自定義欄位(日期時間)023
          fmcmud024 LIKE fmcm_t.fmcmud024, #自定義欄位(日期時間)024
          fmcmud025 LIKE fmcm_t.fmcmud025, #自定義欄位(日期時間)025
          fmcmud026 LIKE fmcm_t.fmcmud026, #自定義欄位(日期時間)026
          fmcmud027 LIKE fmcm_t.fmcmud027, #自定義欄位(日期時間)027
          fmcmud028 LIKE fmcm_t.fmcmud028, #自定義欄位(日期時間)028
          fmcmud029 LIKE fmcm_t.fmcmud029, #自定義欄位(日期時間)029
          fmcmud030 LIKE fmcm_t.fmcmud030  #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_fmcn  RECORD  #融資利率確定檔
          fmcnent   LIKE fmcn_t.fmcnent, #企業編號
          fmcndocno LIKE fmcn_t.fmcndocno, #融資合約編號
          fmcnseq   LIKE fmcn_t.fmcnseq, #融資合約項次
          fmcnseq2  LIKE fmcn_t.fmcnseq2, #項次
          fmcn001   LIKE fmcn_t.fmcn001, #幣別
          fmcn002   LIKE fmcn_t.fmcn002, #利率確定日
          fmcn003   LIKE fmcn_t.fmcn003, #利率方式
          fmcn004   LIKE fmcn_t.fmcn004, #基準利率(年%)
          fmcn005   LIKE fmcn_t.fmcn005, #浮動方式
          fmcn006   LIKE fmcn_t.fmcn006, #浮動利率(%)
          fmcn007   LIKE fmcn_t.fmcn007, #執行利率(年%)
          fmcnud001 LIKE fmcn_t.fmcnud001, #自定義欄位(文字)001
          fmcnud002 LIKE fmcn_t.fmcnud002, #自定義欄位(文字)002
          fmcnud003 LIKE fmcn_t.fmcnud003, #自定義欄位(文字)003
          fmcnud004 LIKE fmcn_t.fmcnud004, #自定義欄位(文字)004
          fmcnud005 LIKE fmcn_t.fmcnud005, #自定義欄位(文字)005
          fmcnud006 LIKE fmcn_t.fmcnud006, #自定義欄位(文字)006
          fmcnud007 LIKE fmcn_t.fmcnud007, #自定義欄位(文字)007
          fmcnud008 LIKE fmcn_t.fmcnud008, #自定義欄位(文字)008
          fmcnud009 LIKE fmcn_t.fmcnud009, #自定義欄位(文字)009
          fmcnud010 LIKE fmcn_t.fmcnud010, #自定義欄位(文字)010
          fmcnud011 LIKE fmcn_t.fmcnud011, #自定義欄位(數字)011
          fmcnud012 LIKE fmcn_t.fmcnud012, #自定義欄位(數字)012
          fmcnud013 LIKE fmcn_t.fmcnud013, #自定義欄位(數字)013
          fmcnud014 LIKE fmcn_t.fmcnud014, #自定義欄位(數字)014
          fmcnud015 LIKE fmcn_t.fmcnud015, #自定義欄位(數字)015
          fmcnud016 LIKE fmcn_t.fmcnud016, #自定義欄位(數字)016
          fmcnud017 LIKE fmcn_t.fmcnud017, #自定義欄位(數字)017
          fmcnud018 LIKE fmcn_t.fmcnud018, #自定義欄位(數字)018
          fmcnud019 LIKE fmcn_t.fmcnud019, #自定義欄位(數字)019
          fmcnud020 LIKE fmcn_t.fmcnud020, #自定義欄位(數字)020
          fmcnud021 LIKE fmcn_t.fmcnud021, #自定義欄位(日期時間)021
          fmcnud022 LIKE fmcn_t.fmcnud022, #自定義欄位(日期時間)022
          fmcnud023 LIKE fmcn_t.fmcnud023, #自定義欄位(日期時間)023
          fmcnud024 LIKE fmcn_t.fmcnud024, #自定義欄位(日期時間)024
          fmcnud025 LIKE fmcn_t.fmcnud025, #自定義欄位(日期時間)025
          fmcnud026 LIKE fmcn_t.fmcnud026, #自定義欄位(日期時間)026
          fmcnud027 LIKE fmcn_t.fmcnud027, #自定義欄位(日期時間)027
          fmcnud028 LIKE fmcn_t.fmcnud028, #自定義欄位(日期時間)028
          fmcnud029 LIKE fmcn_t.fmcnud029, #自定義欄位(日期時間)029
          fmcnud030 LIKE fmcn_t.fmcnud030  #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_fmco  RECORD  #融資費用檔
          fmcoent   LIKE fmco_t.fmcoent, #企業編號
          fmcodocno LIKE fmco_t.fmcodocno, #融資合約編號
          fmcoseq   LIKE fmco_t.fmcoseq, #融資合約項次
          fmcoseq2  LIKE fmco_t.fmcoseq2, #項次
          fmco001   LIKE fmco_t.fmco001, #費用種類
          fmco002   LIKE fmco_t.fmco002, #幣別
          fmco003   LIKE fmco_t.fmco003, #費率
          fmco004   LIKE fmco_t.fmco004, #金額
          fmco005   LIKE fmco_t.fmco005, #LC票號
          fmcoud001 LIKE fmco_t.fmcoud001, #自定義欄位(文字)001
          fmcoud002 LIKE fmco_t.fmcoud002, #自定義欄位(文字)002
          fmcoud003 LIKE fmco_t.fmcoud003, #自定義欄位(文字)003
          fmcoud004 LIKE fmco_t.fmcoud004, #自定義欄位(文字)004
          fmcoud005 LIKE fmco_t.fmcoud005, #自定義欄位(文字)005
          fmcoud006 LIKE fmco_t.fmcoud006, #自定義欄位(文字)006
          fmcoud007 LIKE fmco_t.fmcoud007, #自定義欄位(文字)007
          fmcoud008 LIKE fmco_t.fmcoud008, #自定義欄位(文字)008
          fmcoud009 LIKE fmco_t.fmcoud009, #自定義欄位(文字)009
          fmcoud010 LIKE fmco_t.fmcoud010, #自定義欄位(文字)010
          fmcoud011 LIKE fmco_t.fmcoud011, #自定義欄位(數字)011
          fmcoud012 LIKE fmco_t.fmcoud012, #自定義欄位(數字)012
          fmcoud013 LIKE fmco_t.fmcoud013, #自定義欄位(數字)013
          fmcoud014 LIKE fmco_t.fmcoud014, #自定義欄位(數字)014
          fmcoud015 LIKE fmco_t.fmcoud015, #自定義欄位(數字)015
          fmcoud016 LIKE fmco_t.fmcoud016, #自定義欄位(數字)016
          fmcoud017 LIKE fmco_t.fmcoud017, #自定義欄位(數字)017
          fmcoud018 LIKE fmco_t.fmcoud018, #自定義欄位(數字)018
          fmcoud019 LIKE fmco_t.fmcoud019, #自定義欄位(數字)019
          fmcoud020 LIKE fmco_t.fmcoud020, #自定義欄位(數字)020
          fmcoud021 LIKE fmco_t.fmcoud021, #自定義欄位(日期時間)021
          fmcoud022 LIKE fmco_t.fmcoud022, #自定義欄位(日期時間)022
          fmcoud023 LIKE fmco_t.fmcoud023, #自定義欄位(日期時間)023
          fmcoud024 LIKE fmco_t.fmcoud024, #自定義欄位(日期時間)024
          fmcoud025 LIKE fmco_t.fmcoud025, #自定義欄位(日期時間)025
          fmcoud026 LIKE fmco_t.fmcoud026, #自定義欄位(日期時間)026
          fmcoud027 LIKE fmco_t.fmcoud027, #自定義欄位(日期時間)027
          fmcoud028 LIKE fmco_t.fmcoud028, #自定義欄位(日期時間)028
          fmcoud029 LIKE fmco_t.fmcoud029, #自定義欄位(日期時間)029
          fmcoud030 LIKE fmco_t.fmcoud030  #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_apgk  RECORD  #外購到單主檔
          apgkent   LIKE apgk_t.apgkent, #企業編號
          apgkownid LIKE apgk_t.apgkownid, #資料所有者
          apgkowndp LIKE apgk_t.apgkowndp, #資料所屬部門
          apgkcrtid LIKE apgk_t.apgkcrtid, #資料建立者
          apgkcrtdp LIKE apgk_t.apgkcrtdp, #資料建立部門
          apgkcrtdt LIKE apgk_t.apgkcrtdt, #資料創建日
          apgkmodid LIKE apgk_t.apgkmodid, #資料修改者
          apgkmoddt LIKE apgk_t.apgkmoddt, #最近修改日
          apgkcnfid LIKE apgk_t.apgkcnfid, #資料確認者
          apgkcnfdt LIKE apgk_t.apgkcnfdt, #資料確認日
          apgkpstid LIKE apgk_t.apgkpstid, #資料過帳者
          apgkpstdt LIKE apgk_t.apgkpstdt, #資料過帳日
          apgkstus  LIKE apgk_t.apgkstus, #狀態碼
          apgkcomp  LIKE apgk_t.apgkcomp, #法人
          apgkdocno LIKE apgk_t.apgkdocno, #到單單號
          apgkdocdt LIKE apgk_t.apgkdocdt, #到單日期
          apgk001   LIKE apgk_t.apgk001, #供應商編號
          apgk002   LIKE apgk_t.apgk002, #付款類型
          apgk003   LIKE apgk_t.apgk003, #L/C NO
          apgk004   LIKE apgk_t.apgk004, #業務人員
          apgk005   LIKE apgk_t.apgk005, #申請單號
          apgk006   LIKE apgk_t.apgk006, #押匯日期
          apgk007   LIKE apgk_t.apgk007, #融資天數
          apgk008   LIKE apgk_t.apgk008, #融資應還款日期
          apgk009   LIKE apgk_t.apgk009, #融資合約編號
          apgk010   LIKE apgk_t.apgk010, #融資到帳單號
          apgk011   LIKE apgk_t.apgk011, #自備款應付到期日
          apgk012   LIKE apgk_t.apgk012, #應付待抵單號
          apgk013   LIKE apgk_t.apgk013, #裝運單號
          apgk014   LIKE apgk_t.apgk014, #到貨單號
          apgk015   LIKE apgk_t.apgk015, #到單核銷
          apgk100   LIKE apgk_t.apgk100, #幣別
          apgk101   LIKE apgk_t.apgk101, #還款匯率
          apgk103   LIKE apgk_t.apgk103, #押匯原幣金額
          apgk113   LIKE apgk_t.apgk113, #押匯本幣金額
          apgk114   LIKE apgk_t.apgk114, #應攤還自備款本幣
          apgkud001 LIKE apgk_t.apgkud001, #自定義欄位(文字)001
          apgkud002 LIKE apgk_t.apgkud002, #自定義欄位(文字)002
          apgkud003 LIKE apgk_t.apgkud003, #自定義欄位(文字)003
          apgkud004 LIKE apgk_t.apgkud004, #自定義欄位(文字)004
          apgkud005 LIKE apgk_t.apgkud005, #自定義欄位(文字)005
          apgkud006 LIKE apgk_t.apgkud006, #自定義欄位(文字)006
          apgkud007 LIKE apgk_t.apgkud007, #自定義欄位(文字)007
          apgkud008 LIKE apgk_t.apgkud008, #自定義欄位(文字)008
          apgkud009 LIKE apgk_t.apgkud009, #自定義欄位(文字)009
          apgkud010 LIKE apgk_t.apgkud010, #自定義欄位(文字)010
          apgkud011 LIKE apgk_t.apgkud011, #自定義欄位(數字)011
          apgkud012 LIKE apgk_t.apgkud012, #自定義欄位(數字)012
          apgkud013 LIKE apgk_t.apgkud013, #自定義欄位(數字)013
          apgkud014 LIKE apgk_t.apgkud014, #自定義欄位(數字)014
          apgkud015 LIKE apgk_t.apgkud015, #自定義欄位(數字)015
          apgkud016 LIKE apgk_t.apgkud016, #自定義欄位(數字)016
          apgkud017 LIKE apgk_t.apgkud017, #自定義欄位(數字)017
          apgkud018 LIKE apgk_t.apgkud018, #自定義欄位(數字)018
          apgkud019 LIKE apgk_t.apgkud019, #自定義欄位(數字)019
          apgkud020 LIKE apgk_t.apgkud020, #自定義欄位(數字)020
          apgkud021 LIKE apgk_t.apgkud021, #自定義欄位(日期時間)021
          apgkud022 LIKE apgk_t.apgkud022, #自定義欄位(日期時間)022
          apgkud023 LIKE apgk_t.apgkud023, #自定義欄位(日期時間)023
          apgkud024 LIKE apgk_t.apgkud024, #自定義欄位(日期時間)024
          apgkud025 LIKE apgk_t.apgkud025, #自定義欄位(日期時間)025
          apgkud026 LIKE apgk_t.apgkud026, #自定義欄位(日期時間)026
          apgkud027 LIKE apgk_t.apgkud027, #自定義欄位(日期時間)027
          apgkud028 LIKE apgk_t.apgkud028, #自定義欄位(日期時間)028
          apgkud029 LIKE apgk_t.apgkud029, #自定義欄位(日期時間)029
          apgkud030 LIKE apgk_t.apgkud030, #自定義欄位(日期時間)030
          apgk104   LIKE apgk_t.apgk104, #應攤還自備款原幣金額
          apgk016   LIKE apgk_t.apgk016, #支付帳戶
          apgk017   LIKE apgk_t.apgk017, #存提碼
          apgk018   LIKE apgk_t.apgk018, #現金變動碼
          apgk019   LIKE apgk_t.apgk019  #融資還款單號
              END RECORD
   DEFINE l_apga  RECORD  #信用狀申請單主檔
          apgaent   LIKE apga_t.apgaent, #企業編號
          apgaownid LIKE apga_t.apgaownid, #資料所有者
          apgaowndp LIKE apga_t.apgaowndp, #資料所屬部門
          apgacrtid LIKE apga_t.apgacrtid, #資料建立者
          apgacrtdp LIKE apga_t.apgacrtdp, #資料建立部門
          apgacrtdt LIKE apga_t.apgacrtdt, #資料創建日
          apgamodid LIKE apga_t.apgamodid, #資料修改者
          apgamoddt LIKE apga_t.apgamoddt, #最近修改日
          apgacnfid LIKE apga_t.apgacnfid, #資料確認者
          apgacnfdt LIKE apga_t.apgacnfdt, #資料確認日
          apgapstid LIKE apga_t.apgapstid, #資料過帳者
          apgapstdt LIKE apga_t.apgapstdt, #資料過帳日
          apgastus  LIKE apga_t.apgastus, #狀態碼
          apgacomp  LIKE apga_t.apgacomp, #法人
          apgadocno LIKE apga_t.apgadocno, #申請單號
          apgadocdt LIKE apga_t.apgadocdt, #申請日期
          apga001   LIKE apga_t.apga001, #L/C NO
          apga002   LIKE apga_t.apga002, #版次
          apga003   LIKE apga_t.apga003, #開狀日期
          apga004   LIKE apga_t.apga004, #供應商(受益人)
          apga005   LIKE apga_t.apga005, #業務人員
          apga006   LIKE apga_t.apga006, #付款類型
          apga007   LIKE apga_t.apga007, #開狀銀行
          apga008   LIKE apga_t.apga008, #信用狀類別
          apga009   LIKE apga_t.apga009, #保兌信用狀否
          apga010   LIKE apga_t.apga010, #信用狀有效日期
          apga011   LIKE apga_t.apga011, #許可證號
          apga012   LIKE apga_t.apga012, #承兌日期
          apga013   LIKE apga_t.apga013, #保兌費用支付方
          apga014   LIKE apga_t.apga014, #可否分批交運
          apga015   LIKE apga_t.apga015, #自備款比率
          apga016   LIKE apga_t.apga016, #融資利率
          apga017   LIKE apga_t.apga017, #融資天數
          apga018   LIKE apga_t.apga018, #融資合約編號
          apga019   LIKE apga_t.apga019, #最後裝運日
          apga020   LIKE apga_t.apga020, #運送方式
          apga021   LIKE apga_t.apga021, #裝載港/機場
          apga022   LIKE apga_t.apga022, #卸載港/機場
          apga023   LIKE apga_t.apga023, #E.T.D
          apga024   LIKE apga_t.apga024, #E.T.A
          apga025   LIKE apga_t.apga025, #備註
          apga026   LIKE apga_t.apga026, #開狀時支付自備款
          apga027   LIKE apga_t.apga027, #NO USE
          apga028   LIKE apga_t.apga028, #帳務單號
          apga029   LIKE apga_t.apga029, #結案否
          apga030   LIKE apga_t.apga030, #通知銀行
          apga031   LIKE apga_t.apga031, #開狀時支付自備款
          apga100   LIKE apga_t.apga100, #幣別
          apga101   LIKE apga_t.apga101, #開狀匯率
          apga103   LIKE apga_t.apga103, #開狀原幣金額
          apga104   LIKE apga_t.apga104, #自備款原幣金額
          apga105   LIKE apga_t.apga105, #融資原幣金額
          apga106   LIKE apga_t.apga106, #到單原幣金額
          apga107   LIKE apga_t.apga107, #到貨原幣金額
          apga108   LIKE apga_t.apga108, #保證金原幣金額
          apga113   LIKE apga_t.apga113, #開狀本幣金額
          apga114   LIKE apga_t.apga114, #自備款本幣金額
          apga115   LIKE apga_t.apga115, #融資本幣金額
          apgaud001 LIKE apga_t.apgaud001, #自定義欄位(文字)001
          apgaud002 LIKE apga_t.apgaud002, #自定義欄位(文字)002
          apgaud003 LIKE apga_t.apgaud003, #自定義欄位(文字)003
          apgaud004 LIKE apga_t.apgaud004, #自定義欄位(文字)004
          apgaud005 LIKE apga_t.apgaud005, #自定義欄位(文字)005
          apgaud006 LIKE apga_t.apgaud006, #自定義欄位(文字)006
          apgaud007 LIKE apga_t.apgaud007, #自定義欄位(文字)007
          apgaud008 LIKE apga_t.apgaud008, #自定義欄位(文字)008
          apgaud009 LIKE apga_t.apgaud009, #自定義欄位(文字)009
          apgaud010 LIKE apga_t.apgaud010, #自定義欄位(文字)010
          apgaud011 LIKE apga_t.apgaud011, #自定義欄位(數字)011
          apgaud012 LIKE apga_t.apgaud012, #自定義欄位(數字)012
          apgaud013 LIKE apga_t.apgaud013, #自定義欄位(數字)013
          apgaud014 LIKE apga_t.apgaud014, #自定義欄位(數字)014
          apgaud015 LIKE apga_t.apgaud015, #自定義欄位(數字)015
          apgaud016 LIKE apga_t.apgaud016, #自定義欄位(數字)016
          apgaud017 LIKE apga_t.apgaud017, #自定義欄位(數字)017
          apgaud018 LIKE apga_t.apgaud018, #自定義欄位(數字)018
          apgaud019 LIKE apga_t.apgaud019, #自定義欄位(數字)019
          apgaud020 LIKE apga_t.apgaud020, #自定義欄位(數字)020
          apgaud021 LIKE apga_t.apgaud021, #自定義欄位(日期時間)021
          apgaud022 LIKE apga_t.apgaud022, #自定義欄位(日期時間)022
          apgaud023 LIKE apga_t.apgaud023, #自定義欄位(日期時間)023
          apgaud024 LIKE apga_t.apgaud024, #自定義欄位(日期時間)024
          apgaud025 LIKE apga_t.apgaud025, #自定義欄位(日期時間)025
          apgaud026 LIKE apga_t.apgaud026, #自定義欄位(日期時間)026
          apgaud027 LIKE apga_t.apgaud027, #自定義欄位(日期時間)027
          apgaud028 LIKE apga_t.apgaud028, #自定義欄位(日期時間)028
          apgaud029 LIKE apga_t.apgaud029, #自定義欄位(日期時間)029
          apgaud030 LIKE apga_t.apgaud030, #自定義欄位(日期時間)030
          apga102   LIKE apga_t.apga102, #預付款原幣金額
          apga109   LIKE apga_t.apga109, #初開狀原幣金額
          apga112   LIKE apga_t.apga112, #預付款本幣金額
          apga117   LIKE apga_t.apga117, #到貨本幣金額
          apga118   LIKE apga_t.apga118, #保證金本幣金額
          apga032   LIKE apga_t.apga032, #保證金待抵單號
          apga033   LIKE apga_t.apga033, #預付款待抵單號
          apga034   LIKE apga_t.apga034, #保證金存提碼
          apga035   LIKE apga_t.apga035, #保證金現變碼
          apga040   LIKE apga_t.apga040, #支付帳戶
          apga041   LIKE apga_t.apga041, #多幣別採購單
          apga036   LIKE apga_t.apga036, #自備款存提碼
          apga037   LIKE apga_t.apga037, #自備款現變碼
          apga038   LIKE apga_t.apga038, #預付款存提碼
          apga039   LIKE apga_t.apga039  #預付款現變碼
              END RECORD
   #161104-00024#4-add(e)
   DEFINE r_success LIKE type_t.num5
   DEFINE r_afmt035 LIKE apga_t.apgadocno
   DEFINE r_afmt140 LIKE apga_t.apgadocno
   DEFINE l_ld      LIKE glaa_t.glaald
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET r_afmt035 = NULL
   LET r_afmt140 = NULL
   INITIALIZE l_apgk.* TO NULL
   #SELECT * INTO l_apgk.* FROM apgk_t   #161208-00026#12 mark
   #161208-00026#12-add(s)
   SELECT apgkent,apgkownid,apgkowndp,apgkcrtid,apgkcrtdp,
          apgkcrtdt,apgkmodid,apgkmoddt,apgkcnfid,apgkcnfdt,
          apgkpstid,apgkpstdt,apgkstus,apgkcomp,apgkdocno,
          apgkdocdt,apgk001,apgk002,apgk003,apgk004,
          apgk005,apgk006,apgk007,apgk008,apgk009,
          apgk010,apgk011,apgk012,apgk013,apgk014,
          apgk015,apgk100,apgk101,apgk103,apgk113,
          apgk114,apgkud001,apgkud002,apgkud003,apgkud004,
          apgkud005,apgkud006,apgkud007,apgkud008,apgkud009,
          apgkud010,apgkud011,apgkud012,apgkud013,apgkud014,
          apgkud015,apgkud016,apgkud017,apgkud018,apgkud019,
          apgkud020,apgkud021,apgkud022,apgkud023,apgkud024,
          apgkud025,apgkud026,apgkud027,apgkud028,apgkud029,
          apgkud030,apgk104,apgk016,apgk017,apgk018,
          apgk019 
     INTO l_apgk.* 
     FROM apgk_t
   #161208-00026#12-add(e)
    WHERE apgkent = g_enterprise
      AND apgkcomp = g_apgkcomp
      AND apgkdocno = g_apgkdocno
   
   INITIALIZE l_apga.* TO NULL
   #SELECT * INTO l_apga.* FROM apga_t   #161208-00026#12 mark
   #161208-00026#12-add(s)
   SELECT apgaent,apgaownid,apgaowndp,apgacrtid,apgacrtdp,
          apgacrtdt,apgamodid,apgamoddt,apgacnfid,apgacnfdt,
          apgapstid,apgapstdt,apgastus,apgacomp,apgadocno,
          apgadocdt,apga001,apga002,apga003,apga004,
          apga005,apga006,apga007,apga008,apga009,
          apga010,apga011,apga012,apga013,apga014,
          apga015,apga016,apga017,apga018,apga019,
          apga020,apga021,apga022,apga023,apga024,
          apga025,apga026,apga027,apga028,apga029,
          apga030,apga031,apga100,apga101,apga103,
          apga104,apga105,apga106,apga107,apga108,
          apga113,apga114,apga115,apgaud001,apgaud002,
          apgaud003,apgaud004,apgaud005,apgaud006,apgaud007,
          apgaud008,apgaud009,apgaud010,apgaud011,apgaud012,
          apgaud013,apgaud014,apgaud015,apgaud016,apgaud017,
          apgaud018,apgaud019,apgaud020,apgaud021,apgaud022,
          apgaud023,apgaud024,apgaud025,apgaud026,apgaud027,
          apgaud028,apgaud029,apgaud030,apga102,apga109,
          apga112,apga117,apga118,apga032,apga033,
          apga034,apga035,apga040,apga041,apga036,
          apga037,apga038,apga039 
     INTO l_apga.* 
     FROM apga_t
   #161208-00026#12-add(e)
    WHERE apgaent = g_enterprise
      AND apgacomp = g_apgkcomp
      AND apgadocno = l_apgk.apgk005
      
   LET l_ld = NULL
   SELECT glaald INTO l_ld FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_apgk.apgkcomp
      AND glaa014 = 'Y'
   
   INITIALIZE l_fmcj.* TO NULL
   LET l_fmcj.fmcjent   = g_enterprise
   LET l_fmcj.fmcjstus  = 'N'
   LET l_fmcj.fmcjdocno = g_fmcj_m.fmcjdocno
   LET l_fmcj.fmcjsite  = l_apgk.apgkcomp
   LET l_fmcj.fmcjcomp  = l_apgk.apgkcomp
   LET l_fmcj.fmcjdocdt = l_apgk.apgkdocdt
   LET g_prog = 'afmt035'
   CALL s_aooi200_fin_gen_docno(l_ld,'','',l_fmcj.fmcjdocno ,l_fmcj.fmcjdocdt,g_prog)
      RETURNING g_sub_success,l_fmcj.fmcjdocno
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   LET g_prog = 'aapt540'
   LET l_fmcj.fmcj001 = g_fmcj_m.fmcj001
   LET l_fmcj.fmcj002 = l_apga.apga007
   LET l_fmcj.fmcj003 = g_fmcj_m.fmcj003
   LET l_fmcj.fmcj004 = l_apga.apga018
   LET l_fmcj.fmcj005 = g_fmcj_m.fmcj005
   LET l_fmcj.fmcj006 = l_apgk.apgk006
   LET l_fmcj.fmcj007 = l_apgk.apgk008
   LET l_fmcj.fmcj008 = 'N'
   LET l_fmcj.fmcj009 = g_fmcj_m.fmcj009
   #INSERT INTO fmcj_t VALUES(l_fmcj.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcj_t (fmcjent,fmcjownid,fmcjowndp,fmcjcrtid,fmcjcrtdp,
                       fmcjcrtdt,fmcjmodid,fmcjmoddt,fmcjcnfid,fmcjcnfdt,
                       fmcjstus,fmcjdocno,fmcjsite,fmcjcomp,fmcjdocdt,
                       fmcj001,fmcj002,fmcj003,fmcj004,fmcj005,
                       fmcj006,fmcj007,fmcj008,fmcj009,
                       fmcjud001,fmcjud002,fmcjud003,fmcjud004,fmcjud005,
                       fmcjud006,fmcjud007,fmcjud008,fmcjud009,fmcjud010,
                       fmcjud011,fmcjud012,fmcjud013,fmcjud014,fmcjud015,
                       fmcjud016,fmcjud017,fmcjud018,fmcjud019,fmcjud020,
                       fmcjud021,fmcjud022,fmcjud023,fmcjud024,fmcjud025,
                       fmcjud026,fmcjud027,fmcjud028,fmcjud029,fmcjud030
                      )
   VALUES (l_fmcj.fmcjent,l_fmcj.fmcjownid,l_fmcj.fmcjowndp,l_fmcj.fmcjcrtid,l_fmcj.fmcjcrtdp,
           l_fmcj.fmcjcrtdt,l_fmcj.fmcjmodid,l_fmcj.fmcjmoddt,l_fmcj.fmcjcnfid,l_fmcj.fmcjcnfdt,
           l_fmcj.fmcjstus,l_fmcj.fmcjdocno,l_fmcj.fmcjsite,l_fmcj.fmcjcomp,l_fmcj.fmcjdocdt,
           l_fmcj.fmcj001,l_fmcj.fmcj002,l_fmcj.fmcj003,l_fmcj.fmcj004,l_fmcj.fmcj005,
           l_fmcj.fmcj006,l_fmcj.fmcj007,l_fmcj.fmcj008,l_fmcj.fmcj009,
           l_fmcj.fmcjud001,l_fmcj.fmcjud002,l_fmcj.fmcjud003,l_fmcj.fmcjud004,l_fmcj.fmcjud005,
           l_fmcj.fmcjud006,l_fmcj.fmcjud007,l_fmcj.fmcjud008,l_fmcj.fmcjud009,l_fmcj.fmcjud010,
           l_fmcj.fmcjud011,l_fmcj.fmcjud012,l_fmcj.fmcjud013,l_fmcj.fmcjud014,l_fmcj.fmcjud015,
           l_fmcj.fmcjud016,l_fmcj.fmcjud017,l_fmcj.fmcjud018,l_fmcj.fmcjud019,l_fmcj.fmcjud020,
           l_fmcj.fmcjud021,l_fmcj.fmcjud022,l_fmcj.fmcjud023,l_fmcj.fmcjud024,l_fmcj.fmcjud025,
           l_fmcj.fmcjud026,l_fmcj.fmcjud027,l_fmcj.fmcjud028,l_fmcj.fmcjud029,l_fmcj.fmcjud030
          )
   #161108-00017#4 add end---
   
   INITIALIZE l_fmck.* TO NULL
   LET l_fmck.fmckent   = g_enterprise
   LET l_fmck.fmckdocno = l_fmcj.fmcjdocno
   LET l_fmck.fmckseq   = 1
   LET l_fmck.fmck001   = l_apga.apga007
   LET l_fmck.fmck002   = l_apgk.apgk100
   LET l_fmck.fmck003   = g_fmcj_m.l_fmck003
   LET l_fmck.fmck004   = l_apga.apga105
   LET l_fmck.fmck005   = '1'
   LET l_fmck.fmck006   = 'N'
   LET l_fmck.fmck007   = 1
   LET l_fmck.fmck008   = 0
   LET l_fmck.fmck009   = 0
   LET l_fmck.fmck010   = 'N'
   #INSERT INTO fmck_t VALUES(l_fmck.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmck_t (fmckent,fmckdocno,fmckseq,
                       fmck001,fmck002,fmck003,fmck004,fmck005,
                       fmck006,fmck007,fmck008,fmck009,fmck010,
                       fmck011,fmck012,
                       fmckud001,fmckud002,fmckud003,fmckud004,fmckud005,
                       fmckud006,fmckud007,fmckud008,fmckud009,fmckud010,
                       fmckud011,fmckud012,fmckud013,fmckud014,fmckud015,
                       fmckud016,fmckud017,fmckud018,fmckud019,fmckud020,
                       fmckud021,fmckud022,fmckud023,fmckud024,fmckud025,
                       fmckud026,fmckud027,fmckud028,fmckud029,fmckud030
                      )
   VALUES (l_fmck.fmckent,l_fmck.fmckdocno,l_fmck.fmckseq,
           l_fmck.fmck001,l_fmck.fmck002,l_fmck.fmck003,l_fmck.fmck004,l_fmck.fmck005,
           l_fmck.fmck006,l_fmck.fmck007,l_fmck.fmck008,l_fmck.fmck009,l_fmck.fmck010,
           l_fmck.fmck011,l_fmck.fmck012,
           l_fmck.fmckud001,l_fmck.fmckud002,l_fmck.fmckud003,l_fmck.fmckud004,l_fmck.fmckud005,
           l_fmck.fmckud006,l_fmck.fmckud007,l_fmck.fmckud008,l_fmck.fmckud009,l_fmck.fmckud010,
           l_fmck.fmckud011,l_fmck.fmckud012,l_fmck.fmckud013,l_fmck.fmckud014,l_fmck.fmckud015,
           l_fmck.fmckud016,l_fmck.fmckud017,l_fmck.fmckud018,l_fmck.fmckud019,l_fmck.fmckud020,
           l_fmck.fmckud021,l_fmck.fmckud022,l_fmck.fmckud023,l_fmck.fmckud024,l_fmck.fmckud025,
           l_fmck.fmckud026,l_fmck.fmckud027,l_fmck.fmckud028,l_fmck.fmckud029,l_fmck.fmckud030
          )
   #161108-00017#4 add end---
   
   INITIALIZE l_fmcl.* TO NULL
   LET l_fmcl.fmclent   = g_enterprise
   LET l_fmcl.fmcldocno = l_fmcj.fmcjdocno
   LET l_fmcl.fmclseq   = 1
   LET l_fmcl.fmclseq2  = 1
   LET l_fmcl.fmcl001   = '1'
   LET l_fmcl.fmcl002   = '1'
   LET l_fmcl.fmcl003   = 1
   LET l_fmcl.fmcl004   = ''   #160824-00049#4
   LET l_fmcl.fmcl005   = l_apgk.apgk008
   LET l_fmcl.fmcl006   = l_apga.apga105
   #INSERT INTO fmcl_t VALUES(l_fmcl.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcl_t (fmclent,fmcldocno,fmclseq,fmclseq2,
                       fmcl001,fmcl002,fmcl003,fmcl004,fmcl005,
                       fmcl006,
                       fmclud001,fmclud002,fmclud003,fmclud004,fmclud005,
                       fmclud006,fmclud007,fmclud008,fmclud009,fmclud010,
                       fmclud011,fmclud012,fmclud013,fmclud014,fmclud015,
                       fmclud016,fmclud017,fmclud018,fmclud019,fmclud020,
                       fmclud021,fmclud022,fmclud023,fmclud024,fmclud025,
                       fmclud026,fmclud027,fmclud028,fmclud029,fmclud030
                      )
   VALUES (l_fmcl.fmclent,l_fmcl.fmcldocno,l_fmcl.fmclseq,l_fmcl.fmclseq2,
           l_fmcl.fmcl001,l_fmcl.fmcl002,l_fmcl.fmcl003,l_fmcl.fmcl004,l_fmcl.fmcl005,
           l_fmcl.fmcl006,
           l_fmcl.fmclud001,l_fmcl.fmclud002,l_fmcl.fmclud003,l_fmcl.fmclud004,l_fmcl.fmclud005,
           l_fmcl.fmclud006,l_fmcl.fmclud007,l_fmcl.fmclud008,l_fmcl.fmclud009,l_fmcl.fmclud010,
           l_fmcl.fmclud011,l_fmcl.fmclud012,l_fmcl.fmclud013,l_fmcl.fmclud014,l_fmcl.fmclud015,
           l_fmcl.fmclud016,l_fmcl.fmclud017,l_fmcl.fmclud018,l_fmcl.fmclud019,l_fmcl.fmclud020,
           l_fmcl.fmclud021,l_fmcl.fmclud022,l_fmcl.fmclud023,l_fmcl.fmclud024,l_fmcl.fmclud025,
           l_fmcl.fmclud026,l_fmcl.fmclud027,l_fmcl.fmclud028,l_fmcl.fmclud029,l_fmcl.fmclud030
          )
   #161108-00017#4 add end---

   INITIALIZE l_fmcm.* TO NULL
   LET l_fmcm.fmcment = g_enterprise
   LET l_fmcm.fmcmdocno = l_fmcj.fmcjdocno
   LET l_fmcm.fmcmseq   = 1
   LET l_fmcm.fmcmseq2  = 1
   LET l_fmcm.fmcm001   = l_apgk.apgk100
   LET l_fmcm.fmcm002   = l_apgk.apgk008
   LET l_fmcm.fmcm003   = g_fmcj_m.l_fmck003
   LET l_fmcm.fmcm004   = l_apga.apga105
   #INSERT INTO fmcm_t VALUES(l_fmcm.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcm_t (fmcment,fmcmdocno,fmcmseq,fmcmseq2,
                       fmcm001,fmcm002,fmcm003,fmcm004,
                       fmcmud001,fmcmud002,fmcmud003,fmcmud004,fmcmud005,
                       fmcmud006,fmcmud007,fmcmud008,fmcmud009,fmcmud010,
                       fmcmud011,fmcmud012,fmcmud013,fmcmud014,fmcmud015,
                       fmcmud016,fmcmud017,fmcmud018,fmcmud019,fmcmud020,
                       fmcmud021,fmcmud022,fmcmud023,fmcmud024,fmcmud025,
                       fmcmud026,fmcmud027,fmcmud028,fmcmud029,fmcmud030
                      )
   VALUES (l_fmcm.fmcment,l_fmcm.fmcmdocno,l_fmcm.fmcmseq,l_fmcm.fmcmseq2,
           l_fmcm.fmcm001,l_fmcm.fmcm002,l_fmcm.fmcm003,l_fmcm.fmcm004,
           l_fmcm.fmcmud001,l_fmcm.fmcmud002,l_fmcm.fmcmud003,l_fmcm.fmcmud004,l_fmcm.fmcmud005,
           l_fmcm.fmcmud006,l_fmcm.fmcmud007,l_fmcm.fmcmud008,l_fmcm.fmcmud009,l_fmcm.fmcmud010,
           l_fmcm.fmcmud011,l_fmcm.fmcmud012,l_fmcm.fmcmud013,l_fmcm.fmcmud014,l_fmcm.fmcmud015,
           l_fmcm.fmcmud016,l_fmcm.fmcmud017,l_fmcm.fmcmud018,l_fmcm.fmcmud019,l_fmcm.fmcmud020,
           l_fmcm.fmcmud021,l_fmcm.fmcmud022,l_fmcm.fmcmud023,l_fmcm.fmcmud024,l_fmcm.fmcmud025,
           l_fmcm.fmcmud026,l_fmcm.fmcmud027,l_fmcm.fmcmud028,l_fmcm.fmcmud029,l_fmcm.fmcmud030
          )
   #161108-00017#4 add end---
   
   INITIALIZE l_fmcn.* TO NULL
   LET l_fmcn.fmcnent = g_enterprise
   LET l_fmcn.fmcndocno = l_fmcj.fmcjdocno
   LET l_fmcn.fmcnseq   = 1
   LET l_fmcn.fmcnseq2  = 1
   LET l_fmcn.fmcn001   = l_apgk.apgk100
   LET l_fmcn.fmcn002   = l_apgk.apgkdocdt
   LET l_fmcn.fmcn003   = '1'
   LET l_fmcn.fmcn004   = l_apga.apga016
   #INSERT INTO fmcn_t VALUES(l_fmcn.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcn_t (fmcnent,fmcndocno,fmcnseq,fmcnseq2,
                       fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,
                       fmcn006,fmcn007,
                       fmcnud001,fmcnud002,fmcnud003,fmcnud004,fmcnud005,
                       fmcnud006,fmcnud007,fmcnud008,fmcnud009,fmcnud010,
                       fmcnud011,fmcnud012,fmcnud013,fmcnud014,fmcnud015,
                       fmcnud016,fmcnud017,fmcnud018,fmcnud019,fmcnud020,
                       fmcnud021,fmcnud022,fmcnud023,fmcnud024,fmcnud025,
                       fmcnud026,fmcnud027,fmcnud028,fmcnud029,fmcnud030
                      )
   VALUES (l_fmcn.fmcnent,l_fmcn.fmcndocno,l_fmcn.fmcnseq,l_fmcn.fmcnseq2,
           l_fmcn.fmcn001,l_fmcn.fmcn002,l_fmcn.fmcn003,l_fmcn.fmcn004,l_fmcn.fmcn005,
           l_fmcn.fmcn006,l_fmcn.fmcn007,
           l_fmcn.fmcnud001,l_fmcn.fmcnud002,l_fmcn.fmcnud003,l_fmcn.fmcnud004,l_fmcn.fmcnud005,
           l_fmcn.fmcnud006,l_fmcn.fmcnud007,l_fmcn.fmcnud008,l_fmcn.fmcnud009,l_fmcn.fmcnud010,
           l_fmcn.fmcnud011,l_fmcn.fmcnud012,l_fmcn.fmcnud013,l_fmcn.fmcnud014,l_fmcn.fmcnud015,
           l_fmcn.fmcnud016,l_fmcn.fmcnud017,l_fmcn.fmcnud018,l_fmcn.fmcnud019,l_fmcn.fmcnud020,
           l_fmcn.fmcnud021,l_fmcn.fmcnud022,l_fmcn.fmcnud023,l_fmcn.fmcnud024,l_fmcn.fmcnud025,
           l_fmcn.fmcnud026,l_fmcn.fmcnud027,l_fmcn.fmcnud028,l_fmcn.fmcnud029,l_fmcn.fmcnud030
          )
   #161108-00017#4 add end---
    
   LET r_afmt035 = l_fmcj.fmcjdocno
   CALL aapt540_01_ins_afm2()RETURNING g_sub_success,r_afmt140    #160428-00001#4
   RETURN r_success,r_afmt035,r_afmt140
END FUNCTION

################################################################################
# Descriptions...: 融資到帳
# Memo...........:
# Usage..........: 
# Date & Author..: 160613 By albireo
# Modify.........: #160428-00001#4 
################################################################################
PRIVATE FUNCTION aapt540_01_ins_afm2()
   #161104-00024#4 mark(s)
   #DEFINE l_fmcr RECORD LIKE fmcr_t.*
   #DEFINE l_fmcs RECORD LIKE fmcs_t.*
   #DEFINE l_apga RECORD LIKE apga_t.*
   #DEFINE l_apgk RECORD LIKE apgk_t.*
   #161104-00024#4 mark(e)
   #161104-00024#4-add(s)
   DEFINE l_fmcr  RECORD  #融資資金到帳單頭檔
          fmcrent   LIKE fmcr_t.fmcrent, #企業編號
          fmcrdocno LIKE fmcr_t.fmcrdocno, #融資資金到帳單編號
          fmcrsite  LIKE fmcr_t.fmcrsite, #融資組織
          fmcrdocdt LIKE fmcr_t.fmcrdocdt, #到帳日期
          fmcrcomp  LIKE fmcr_t.fmcrcomp, #法人
          fmcrownid LIKE fmcr_t.fmcrownid, #資料所屬者
          fmcrowndp LIKE fmcr_t.fmcrowndp, #資料所屬部門
          fmcrcrtid LIKE fmcr_t.fmcrcrtid, #資料建立者
          fmcrcrtdp LIKE fmcr_t.fmcrcrtdp, #資料建立部門
          fmcrcrtdt LIKE fmcr_t.fmcrcrtdt, #資料創建日
          fmcrmodid LIKE fmcr_t.fmcrmodid, #資料修改者
          fmcrmoddt LIKE fmcr_t.fmcrmoddt, #最近修改日
          fmcrstus  LIKE fmcr_t.fmcrstus, #狀態碼
          fmcrud001 LIKE fmcr_t.fmcrud001, #自定義欄位(文字)001
          fmcrud002 LIKE fmcr_t.fmcrud002, #自定義欄位(文字)002
          fmcrud003 LIKE fmcr_t.fmcrud003, #自定義欄位(文字)003
          fmcrud004 LIKE fmcr_t.fmcrud004, #自定義欄位(文字)004
          fmcrud005 LIKE fmcr_t.fmcrud005, #自定義欄位(文字)005
          fmcrud006 LIKE fmcr_t.fmcrud006, #自定義欄位(文字)006
          fmcrud007 LIKE fmcr_t.fmcrud007, #自定義欄位(文字)007
          fmcrud008 LIKE fmcr_t.fmcrud008, #自定義欄位(文字)008
          fmcrud009 LIKE fmcr_t.fmcrud009, #自定義欄位(文字)009
          fmcrud010 LIKE fmcr_t.fmcrud010, #自定義欄位(文字)010
          fmcrud011 LIKE fmcr_t.fmcrud011, #自定義欄位(數字)011
          fmcrud012 LIKE fmcr_t.fmcrud012, #自定義欄位(數字)012
          fmcrud013 LIKE fmcr_t.fmcrud013, #自定義欄位(數字)013
          fmcrud014 LIKE fmcr_t.fmcrud014, #自定義欄位(數字)014
          fmcrud015 LIKE fmcr_t.fmcrud015, #自定義欄位(數字)015
          fmcrud016 LIKE fmcr_t.fmcrud016, #自定義欄位(數字)016
          fmcrud017 LIKE fmcr_t.fmcrud017, #自定義欄位(數字)017
          fmcrud018 LIKE fmcr_t.fmcrud018, #自定義欄位(數字)018
          fmcrud019 LIKE fmcr_t.fmcrud019, #自定義欄位(數字)019
          fmcrud020 LIKE fmcr_t.fmcrud020, #自定義欄位(數字)020
          fmcrud021 LIKE fmcr_t.fmcrud021, #自定義欄位(日期時間)021
          fmcrud022 LIKE fmcr_t.fmcrud022, #自定義欄位(日期時間)022
          fmcrud023 LIKE fmcr_t.fmcrud023, #自定義欄位(日期時間)023
          fmcrud024 LIKE fmcr_t.fmcrud024, #自定義欄位(日期時間)024
          fmcrud025 LIKE fmcr_t.fmcrud025, #自定義欄位(日期時間)025
          fmcrud026 LIKE fmcr_t.fmcrud026, #自定義欄位(日期時間)026
          fmcrud027 LIKE fmcr_t.fmcrud027, #自定義欄位(日期時間)027
          fmcrud028 LIKE fmcr_t.fmcrud028, #自定義欄位(日期時間)028
          fmcrud029 LIKE fmcr_t.fmcrud029, #自定義欄位(日期時間)029
          fmcrud030 LIKE fmcr_t.fmcrud030, #自定義欄位(日期時間)030
          fmcrcnfid LIKE fmcr_t.fmcrcnfid, #資料確認者
          fmcrcnfdt LIKE fmcr_t.fmcrcnfdt  #資料確認日
              END RECORD
   DEFINE l_fmcs  RECORD  #融資資金到帳單身檔
          fmcscomp  LIKE fmcs_t.fmcscomp, #法人
          fmcsent   LIKE fmcs_t.fmcsent, #企業編號
          fmcsdocno LIKE fmcs_t.fmcsdocno, #融資資金到帳單編號
          fmcsseq   LIKE fmcs_t.fmcsseq, #項次
          fmcs001   LIKE fmcs_t.fmcs001, #融資合約號
          fmcs002   LIKE fmcs_t.fmcs002, #融資合約項次
          fmcs003   LIKE fmcs_t.fmcs003, #融資組織
          fmcs004   LIKE fmcs_t.fmcs004, #貸款帳戶
          fmcs005   LIKE fmcs_t.fmcs005, #異動別
          fmcs006   LIKE fmcs_t.fmcs006, #存提碼
          fmcs007   LIKE fmcs_t.fmcs007, #幣別
          fmcs008   LIKE fmcs_t.fmcs008, #金額
          fmcs009   LIKE fmcs_t.fmcs009, #匯率
          fmcs010   LIKE fmcs_t.fmcs010, #本幣金額
          fmcs011   LIKE fmcs_t.fmcs011, #匯率二
          fmcs012   LIKE fmcs_t.fmcs012, #本幣金額二
          fmcs013   LIKE fmcs_t.fmcs013, #匯率 三
          fmcs014   LIKE fmcs_t.fmcs014, #本幣金額三
          fmcs015   LIKE fmcs_t.fmcs015, #執行利率
          fmcs016   LIKE fmcs_t.fmcs016, #現金變動碼
          fmcs017   LIKE fmcs_t.fmcs017, #已還本金
          fmcs018   LIKE fmcs_t.fmcs018, #已還本幣一
          fmcs019   LIKE fmcs_t.fmcs019, #已還本幣二
          fmcs020   LIKE fmcs_t.fmcs020, #已還本幣三
          fmcsud001 LIKE fmcs_t.fmcsud001, #自定義欄位(文字)001
          fmcsud002 LIKE fmcs_t.fmcsud002, #自定義欄位(文字)002
          fmcsud003 LIKE fmcs_t.fmcsud003, #自定義欄位(文字)003
          fmcsud004 LIKE fmcs_t.fmcsud004, #自定義欄位(文字)004
          fmcsud005 LIKE fmcs_t.fmcsud005, #自定義欄位(文字)005
          fmcsud006 LIKE fmcs_t.fmcsud006, #自定義欄位(文字)006
          fmcsud007 LIKE fmcs_t.fmcsud007, #自定義欄位(文字)007
          fmcsud008 LIKE fmcs_t.fmcsud008, #自定義欄位(文字)008
          fmcsud009 LIKE fmcs_t.fmcsud009, #自定義欄位(文字)009
          fmcsud010 LIKE fmcs_t.fmcsud010, #自定義欄位(文字)010
          fmcsud011 LIKE fmcs_t.fmcsud011, #自定義欄位(數字)011
          fmcsud012 LIKE fmcs_t.fmcsud012, #自定義欄位(數字)012
          fmcsud013 LIKE fmcs_t.fmcsud013, #自定義欄位(數字)013
          fmcsud014 LIKE fmcs_t.fmcsud014, #自定義欄位(數字)014
          fmcsud015 LIKE fmcs_t.fmcsud015, #自定義欄位(數字)015
          fmcsud016 LIKE fmcs_t.fmcsud016, #自定義欄位(數字)016
          fmcsud017 LIKE fmcs_t.fmcsud017, #自定義欄位(數字)017
          fmcsud018 LIKE fmcs_t.fmcsud018, #自定義欄位(數字)018
          fmcsud019 LIKE fmcs_t.fmcsud019, #自定義欄位(數字)019
          fmcsud020 LIKE fmcs_t.fmcsud020, #自定義欄位(數字)020
          fmcsud021 LIKE fmcs_t.fmcsud021, #自定義欄位(日期時間)021
          fmcsud022 LIKE fmcs_t.fmcsud022, #自定義欄位(日期時間)022
          fmcsud023 LIKE fmcs_t.fmcsud023, #自定義欄位(日期時間)023
          fmcsud024 LIKE fmcs_t.fmcsud024, #自定義欄位(日期時間)024
          fmcsud025 LIKE fmcs_t.fmcsud025, #自定義欄位(日期時間)025
          fmcsud026 LIKE fmcs_t.fmcsud026, #自定義欄位(日期時間)026
          fmcsud027 LIKE fmcs_t.fmcsud027, #自定義欄位(日期時間)027
          fmcsud028 LIKE fmcs_t.fmcsud028, #自定義欄位(日期時間)028
          fmcsud029 LIKE fmcs_t.fmcsud029, #自定義欄位(日期時間)029
          fmcsud030 LIKE fmcs_t.fmcsud030, #自定義欄位(日期時間)030
          fmcs021   LIKE fmcs_t.fmcs021  #摘要
              END RECORD
   DEFINE l_apga  RECORD  #信用狀申請單主檔
          apgaent   LIKE apga_t.apgaent, #企業編號
          apgaownid LIKE apga_t.apgaownid, #資料所有者
          apgaowndp LIKE apga_t.apgaowndp, #資料所屬部門
          apgacrtid LIKE apga_t.apgacrtid, #資料建立者
          apgacrtdp LIKE apga_t.apgacrtdp, #資料建立部門
          apgacrtdt LIKE apga_t.apgacrtdt, #資料創建日
          apgamodid LIKE apga_t.apgamodid, #資料修改者
          apgamoddt LIKE apga_t.apgamoddt, #最近修改日
          apgacnfid LIKE apga_t.apgacnfid, #資料確認者
          apgacnfdt LIKE apga_t.apgacnfdt, #資料確認日
          apgapstid LIKE apga_t.apgapstid, #資料過帳者
          apgapstdt LIKE apga_t.apgapstdt, #資料過帳日
          apgastus  LIKE apga_t.apgastus, #狀態碼
          apgacomp  LIKE apga_t.apgacomp, #法人
          apgadocno LIKE apga_t.apgadocno, #申請單號
          apgadocdt LIKE apga_t.apgadocdt, #申請日期
          apga001   LIKE apga_t.apga001, #L/C NO
          apga002   LIKE apga_t.apga002, #版次
          apga003   LIKE apga_t.apga003, #開狀日期
          apga004   LIKE apga_t.apga004, #供應商(受益人)
          apga005   LIKE apga_t.apga005, #業務人員
          apga006   LIKE apga_t.apga006, #付款類型
          apga007   LIKE apga_t.apga007, #開狀銀行
          apga008   LIKE apga_t.apga008, #信用狀類別
          apga009   LIKE apga_t.apga009, #保兌信用狀否
          apga010   LIKE apga_t.apga010, #信用狀有效日期
          apga011   LIKE apga_t.apga011, #許可證號
          apga012   LIKE apga_t.apga012, #承兌日期
          apga013   LIKE apga_t.apga013, #保兌費用支付方
          apga014   LIKE apga_t.apga014, #可否分批交運
          apga015   LIKE apga_t.apga015, #自備款比率
          apga016   LIKE apga_t.apga016, #融資利率
          apga017   LIKE apga_t.apga017, #融資天數
          apga018   LIKE apga_t.apga018, #融資合約編號
          apga019   LIKE apga_t.apga019, #最後裝運日
          apga020   LIKE apga_t.apga020, #運送方式
          apga021   LIKE apga_t.apga021, #裝載港/機場
          apga022   LIKE apga_t.apga022, #卸載港/機場
          apga023   LIKE apga_t.apga023, #E.T.D
          apga024   LIKE apga_t.apga024, #E.T.A
          apga025   LIKE apga_t.apga025, #備註
          apga026   LIKE apga_t.apga026, #開狀時支付自備款
          apga027   LIKE apga_t.apga027, #NO USE
          apga028   LIKE apga_t.apga028, #帳務單號
          apga029   LIKE apga_t.apga029, #結案否
          apga030   LIKE apga_t.apga030, #通知銀行
          apga031   LIKE apga_t.apga031, #開狀時支付自備款
          apga100   LIKE apga_t.apga100, #幣別
          apga101   LIKE apga_t.apga101, #開狀匯率
          apga103   LIKE apga_t.apga103, #開狀原幣金額
          apga104   LIKE apga_t.apga104, #自備款原幣金額
          apga105   LIKE apga_t.apga105, #融資原幣金額
          apga106   LIKE apga_t.apga106, #到單原幣金額
          apga107   LIKE apga_t.apga107, #到貨原幣金額
          apga108   LIKE apga_t.apga108, #保證金原幣金額
          apga113   LIKE apga_t.apga113, #開狀本幣金額
          apga114   LIKE apga_t.apga114, #自備款本幣金額
          apga115   LIKE apga_t.apga115, #融資本幣金額
          apgaud001 LIKE apga_t.apgaud001, #自定義欄位(文字)001
          apgaud002 LIKE apga_t.apgaud002, #自定義欄位(文字)002
          apgaud003 LIKE apga_t.apgaud003, #自定義欄位(文字)003
          apgaud004 LIKE apga_t.apgaud004, #自定義欄位(文字)004
          apgaud005 LIKE apga_t.apgaud005, #自定義欄位(文字)005
          apgaud006 LIKE apga_t.apgaud006, #自定義欄位(文字)006
          apgaud007 LIKE apga_t.apgaud007, #自定義欄位(文字)007
          apgaud008 LIKE apga_t.apgaud008, #自定義欄位(文字)008
          apgaud009 LIKE apga_t.apgaud009, #自定義欄位(文字)009
          apgaud010 LIKE apga_t.apgaud010, #自定義欄位(文字)010
          apgaud011 LIKE apga_t.apgaud011, #自定義欄位(數字)011
          apgaud012 LIKE apga_t.apgaud012, #自定義欄位(數字)012
          apgaud013 LIKE apga_t.apgaud013, #自定義欄位(數字)013
          apgaud014 LIKE apga_t.apgaud014, #自定義欄位(數字)014
          apgaud015 LIKE apga_t.apgaud015, #自定義欄位(數字)015
          apgaud016 LIKE apga_t.apgaud016, #自定義欄位(數字)016
          apgaud017 LIKE apga_t.apgaud017, #自定義欄位(數字)017
          apgaud018 LIKE apga_t.apgaud018, #自定義欄位(數字)018
          apgaud019 LIKE apga_t.apgaud019, #自定義欄位(數字)019
          apgaud020 LIKE apga_t.apgaud020, #自定義欄位(數字)020
          apgaud021 LIKE apga_t.apgaud021, #自定義欄位(日期時間)021
          apgaud022 LIKE apga_t.apgaud022, #自定義欄位(日期時間)022
          apgaud023 LIKE apga_t.apgaud023, #自定義欄位(日期時間)023
          apgaud024 LIKE apga_t.apgaud024, #自定義欄位(日期時間)024
          apgaud025 LIKE apga_t.apgaud025, #自定義欄位(日期時間)025
          apgaud026 LIKE apga_t.apgaud026, #自定義欄位(日期時間)026
          apgaud027 LIKE apga_t.apgaud027, #自定義欄位(日期時間)027
          apgaud028 LIKE apga_t.apgaud028, #自定義欄位(日期時間)028
          apgaud029 LIKE apga_t.apgaud029, #自定義欄位(日期時間)029
          apgaud030 LIKE apga_t.apgaud030, #自定義欄位(日期時間)030
          apga102   LIKE apga_t.apga102, #預付款原幣金額
          apga109   LIKE apga_t.apga109, #初開狀原幣金額
          apga112   LIKE apga_t.apga112, #預付款本幣金額
          apga117   LIKE apga_t.apga117, #到貨本幣金額
          apga118   LIKE apga_t.apga118, #保證金本幣金額
          apga032   LIKE apga_t.apga032, #保證金待抵單號
          apga033   LIKE apga_t.apga033, #預付款待抵單號
          apga034   LIKE apga_t.apga034, #保證金存提碼
          apga035   LIKE apga_t.apga035, #保證金現變碼
          apga040   LIKE apga_t.apga040, #支付帳戶
          apga041   LIKE apga_t.apga041, #多幣別採購單
          apga036   LIKE apga_t.apga036, #自備款存提碼
          apga037   LIKE apga_t.apga037, #自備款現變碼
          apga038   LIKE apga_t.apga038, #預付款存提碼
          apga039   LIKE apga_t.apga039  #預付款現變碼
              END RECORD
   DEFINE l_apgk  RECORD  #外購到單主檔
          apgkent   LIKE apgk_t.apgkent, #企業編號
          apgkownid LIKE apgk_t.apgkownid, #資料所有者
          apgkowndp LIKE apgk_t.apgkowndp, #資料所屬部門
          apgkcrtid LIKE apgk_t.apgkcrtid, #資料建立者
          apgkcrtdp LIKE apgk_t.apgkcrtdp, #資料建立部門
          apgkcrtdt LIKE apgk_t.apgkcrtdt, #資料創建日
          apgkmodid LIKE apgk_t.apgkmodid, #資料修改者
          apgkmoddt LIKE apgk_t.apgkmoddt, #最近修改日
          apgkcnfid LIKE apgk_t.apgkcnfid, #資料確認者
          apgkcnfdt LIKE apgk_t.apgkcnfdt, #資料確認日
          apgkpstid LIKE apgk_t.apgkpstid, #資料過帳者
          apgkpstdt LIKE apgk_t.apgkpstdt, #資料過帳日
          apgkstus  LIKE apgk_t.apgkstus, #狀態碼
          apgkcomp  LIKE apgk_t.apgkcomp, #法人
          apgkdocno LIKE apgk_t.apgkdocno, #到單單號
          apgkdocdt LIKE apgk_t.apgkdocdt, #到單日期
          apgk001   LIKE apgk_t.apgk001, #供應商編號
          apgk002   LIKE apgk_t.apgk002, #付款類型
          apgk003   LIKE apgk_t.apgk003, #L/C NO
          apgk004   LIKE apgk_t.apgk004, #業務人員
          apgk005   LIKE apgk_t.apgk005, #申請單號
          apgk006   LIKE apgk_t.apgk006, #押匯日期
          apgk007   LIKE apgk_t.apgk007, #融資天數
          apgk008   LIKE apgk_t.apgk008, #融資應還款日期
          apgk009   LIKE apgk_t.apgk009, #融資合約編號
          apgk010   LIKE apgk_t.apgk010, #融資到帳單號
          apgk011   LIKE apgk_t.apgk011, #自備款應付到期日
          apgk012   LIKE apgk_t.apgk012, #應付待抵單號
          apgk013   LIKE apgk_t.apgk013, #裝運單號
          apgk014   LIKE apgk_t.apgk014, #到貨單號
          apgk015   LIKE apgk_t.apgk015, #到單核銷
          apgk100   LIKE apgk_t.apgk100, #幣別
          apgk101   LIKE apgk_t.apgk101, #還款匯率
          apgk103   LIKE apgk_t.apgk103, #押匯原幣金額
          apgk113   LIKE apgk_t.apgk113, #押匯本幣金額
          apgk114   LIKE apgk_t.apgk114, #應攤還自備款本幣
          apgkud001 LIKE apgk_t.apgkud001, #自定義欄位(文字)001
          apgkud002 LIKE apgk_t.apgkud002, #自定義欄位(文字)002
          apgkud003 LIKE apgk_t.apgkud003, #自定義欄位(文字)003
          apgkud004 LIKE apgk_t.apgkud004, #自定義欄位(文字)004
          apgkud005 LIKE apgk_t.apgkud005, #自定義欄位(文字)005
          apgkud006 LIKE apgk_t.apgkud006, #自定義欄位(文字)006
          apgkud007 LIKE apgk_t.apgkud007, #自定義欄位(文字)007
          apgkud008 LIKE apgk_t.apgkud008, #自定義欄位(文字)008
          apgkud009 LIKE apgk_t.apgkud009, #自定義欄位(文字)009
          apgkud010 LIKE apgk_t.apgkud010, #自定義欄位(文字)010
          apgkud011 LIKE apgk_t.apgkud011, #自定義欄位(數字)011
          apgkud012 LIKE apgk_t.apgkud012, #自定義欄位(數字)012
          apgkud013 LIKE apgk_t.apgkud013, #自定義欄位(數字)013
          apgkud014 LIKE apgk_t.apgkud014, #自定義欄位(數字)014
          apgkud015 LIKE apgk_t.apgkud015, #自定義欄位(數字)015
          apgkud016 LIKE apgk_t.apgkud016, #自定義欄位(數字)016
          apgkud017 LIKE apgk_t.apgkud017, #自定義欄位(數字)017
          apgkud018 LIKE apgk_t.apgkud018, #自定義欄位(數字)018
          apgkud019 LIKE apgk_t.apgkud019, #自定義欄位(數字)019
          apgkud020 LIKE apgk_t.apgkud020, #自定義欄位(數字)020
          apgkud021 LIKE apgk_t.apgkud021, #自定義欄位(日期時間)021
          apgkud022 LIKE apgk_t.apgkud022, #自定義欄位(日期時間)022
          apgkud023 LIKE apgk_t.apgkud023, #自定義欄位(日期時間)023
          apgkud024 LIKE apgk_t.apgkud024, #自定義欄位(日期時間)024
          apgkud025 LIKE apgk_t.apgkud025, #自定義欄位(日期時間)025
          apgkud026 LIKE apgk_t.apgkud026, #自定義欄位(日期時間)026
          apgkud027 LIKE apgk_t.apgkud027, #自定義欄位(日期時間)027
          apgkud028 LIKE apgk_t.apgkud028, #自定義欄位(日期時間)028
          apgkud029 LIKE apgk_t.apgkud029, #自定義欄位(日期時間)029
          apgkud030 LIKE apgk_t.apgkud030, #自定義欄位(日期時間)030
          apgk104   LIKE apgk_t.apgk104, #應攤還自備款原幣金額
          apgk016   LIKE apgk_t.apgk016, #支付帳戶
          apgk017   LIKE apgk_t.apgk017, #存提碼
          apgk018   LIKE apgk_t.apgk018, #現金變動碼
          apgk019   LIKE apgk_t.apgk019  #融資還款單號
              END RECORD
   #161104-00024#4-add(e)
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_afmt140     LIKE nmcr_t.nmcrdocno
   DEFINE l_ld          LIKE glaa_t.glaald
   DEFINE l_dummy1      LIKE type_t.num20_6
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004,
            ooib001     LIKE ooib_t.ooib001        
                    END RECORD
   DEFINE ls_js         STRING   
   WHENEVER ERROR CONTINUE
   
   LET r_success  = TRUE  LET r_afmt140 = NULL
   INITIALIZE l_apgk.* TO NULL
   #SELECT * INTO l_apgk.* FROM apgk_t    #161208-00026#12 mark
   #161208-00026#12-add(s)
   SELECT apgkent,apgkownid,apgkowndp,apgkcrtid,apgkcrtdp,
          apgkcrtdt,apgkmodid,apgkmoddt,apgkcnfid,apgkcnfdt,
          apgkpstid,apgkpstdt,apgkstus,apgkcomp,apgkdocno,
          apgkdocdt,apgk001,apgk002,apgk003,apgk004,
          apgk005,apgk006,apgk007,apgk008,apgk009,
          apgk010,apgk011,apgk012,apgk013,apgk014,
          apgk015,apgk100,apgk101,apgk103,apgk113,
          apgk114,apgkud001,apgkud002,apgkud003,apgkud004,
          apgkud005,apgkud006,apgkud007,apgkud008,apgkud009,
          apgkud010,apgkud011,apgkud012,apgkud013,apgkud014,
          apgkud015,apgkud016,apgkud017,apgkud018,apgkud019,
          apgkud020,apgkud021,apgkud022,apgkud023,apgkud024,
          apgkud025,apgkud026,apgkud027,apgkud028,apgkud029,
          apgkud030,apgk104,apgk016,apgk017,apgk018,
          apgk019  
     INTO l_apgk.* 
     FROM apgk_t
   #161208-00026#12-add(e)
    WHERE apgkent = g_enterprise
      AND apgkcomp = g_apgkcomp
      AND apgkdocno = g_apgkdocno
   
   INITIALIZE l_apga.* TO NULL
   #SELECT * INTO l_apga.* FROM apga_t   #161208-00026#12 mark
   #161208-00026#12-add(s)
   SELECT apgaent,apgaownid,apgaowndp,apgacrtid,apgacrtdp,
          apgacrtdt,apgamodid,apgamoddt,apgacnfid,apgacnfdt,
          apgapstid,apgapstdt,apgastus,apgacomp,apgadocno,
          apgadocdt,apga001,apga002,apga003,apga004,
          apga005,apga006,apga007,apga008,apga009,
          apga010,apga011,apga012,apga013,apga014,
          apga015,apga016,apga017,apga018,apga019,
          apga020,apga021,apga022,apga023,apga024,
          apga025,apga026,apga027,apga028,apga029,
          apga030,apga031,apga100,apga101,apga103,
          apga104,apga105,apga106,apga107,apga108,
          apga113,apga114,apga115,apgaud001,apgaud002,
          apgaud003,apgaud004,apgaud005,apgaud006,apgaud007,
          apgaud008,apgaud009,apgaud010,apgaud011,apgaud012,
          apgaud013,apgaud014,apgaud015,apgaud016,apgaud017,
          apgaud018,apgaud019,apgaud020,apgaud021,apgaud022,
          apgaud023,apgaud024,apgaud025,apgaud026,apgaud027,
          apgaud028,apgaud029,apgaud030,apga102,apga109,
          apga112,apga117,apga118,apga032,apga033,
          apga034,apga035,apga040,apga041,apga036,
          apga037,apga038,apga039 
     INTO l_apga.* 
     FROM apga_t
   #161208-00026#12-add(e)
    WHERE apgaent = g_enterprise
      AND apgacomp = g_apgkcomp
      AND apgadocno = l_apgk.apgk005
      
      LET l_ld = NULL
   SELECT glaald INTO l_ld FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_apgk.apgkcomp
      AND glaa014 = 'Y'   
      
   INITIALIZE l_fmcr.* TO NULL
   LET l_fmcr.fmcrent = g_enterprise
   LET l_fmcr.fmcrcomp = l_apgk.apgkcomp
   LET l_fmcr.fmcrsite = l_apgk.apgkcomp
   LET l_fmcr.fmcrdocdt = g_fmcj_m.l_fmcrdocdt
   LET l_fmcr.fmcrdocno = g_fmcj_m.l_fmcrdocno
   LET g_prog = 'afmt140'
   CALL s_aooi200_fin_gen_docno(l_ld,'','', l_fmcr.fmcrdocno ,g_fmcj_m.l_fmcrdocdt,g_prog)
      RETURNING g_sub_success, l_fmcr.fmcrdocno
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   LET g_prog = 'aapt540'
   LET l_fmcr.fmcrstus = 'N'
   #INSERT INTO fmcr_t VALUES(l_fmcr.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcr_t (fmcrent,fmcrdocno,fmcrsite,fmcrdocdt,fmcrcomp,
                       fmcrownid,fmcrowndp,fmcrcrtid,fmcrcrtdp,fmcrcrtdt,
                       fmcrmodid,fmcrmoddt,fmcrstus,
                       fmcrud001,fmcrud002,fmcrud003,fmcrud004,fmcrud005,fmcrud006,fmcrud007,fmcrud008,fmcrud009,fmcrud010,fmcrud011,fmcrud012,fmcrud013,fmcrud014,fmcrud015,fmcrud016,fmcrud017,fmcrud018,fmcrud019,fmcrud020,fmcrud021,fmcrud022,fmcrud023,fmcrud024,fmcrud025,fmcrud026,fmcrud027,fmcrud028,fmcrud029,fmcrud030,fmcrcnfid,fmcrcnfdt
                      )
                     #170109-00035#1-----s
                VALUES(l_fmcr.fmcrent,l_fmcr.fmcrdocno,l_fmcr.fmcrsite,l_fmcr.fmcrdocdt,l_fmcr.fmcrcomp,
                       l_fmcr.fmcrownid,l_fmcr.fmcrowndp,l_fmcr.fmcrcrtid,l_fmcr.fmcrcrtdp,l_fmcr.fmcrcrtdt,
                       l_fmcr.fmcrmodid,l_fmcr.fmcrmoddt,l_fmcr.fmcrstus,
                       l_fmcr.fmcrud001,l_fmcr.fmcrud002,l_fmcr.fmcrud003,l_fmcr.fmcrud004,l_fmcr.fmcrud005,l_fmcr.fmcrud006,l_fmcr.fmcrud007,l_fmcr.fmcrud008,l_fmcr.fmcrud009,l_fmcr.fmcrud010,l_fmcr.fmcrud011,l_fmcr.fmcrud012,l_fmcr.fmcrud013,l_fmcr.fmcrud014,l_fmcr.fmcrud015,l_fmcr.fmcrud016,l_fmcr.fmcrud017,l_fmcr.fmcrud018,l_fmcr.fmcrud019,l_fmcr.fmcrud020,l_fmcr.fmcrud021,l_fmcr.fmcrud022,l_fmcr.fmcrud023,l_fmcr.fmcrud024,l_fmcr.fmcrud025,l_fmcr.fmcrud026,l_fmcr.fmcrud027,l_fmcr.fmcrud028,l_fmcr.fmcrud029,l_fmcr.fmcrud030,l_fmcr.fmcrcnfid,l_fmcr.fmcrcnfdt
                      )   
                     #170109-00035#1-----e
   #170109-00035#1 mark-----s
   #VALUES (l_fmcn.fmcnent,l_fmcn.fmcndocno,l_fmcn.fmcnseq,l_fmcn.fmcnseq2,
   #        l_fmcn.fmcn001,l_fmcn.fmcn002,l_fmcn.fmcn003,l_fmcn.fmcn004,l_fmcn.fmcn005,
   #        l_fmcn.fmcn006,l_fmcn.fmcn007,
   #        l_fmcn.fmcnud001,l_fmcn.fmcnud002,l_fmcn.fmcnud003,l_fmcn.fmcnud004,l_fmcn.fmcnud005,
   #        l_fmcn.fmcnud006,l_fmcn.fmcnud007,l_fmcn.fmcnud008,l_fmcn.fmcnud009,l_fmcn.fmcnud010,
   #        l_fmcn.fmcnud011,l_fmcn.fmcnud012,l_fmcn.fmcnud013,l_fmcn.fmcnud014,l_fmcn.fmcnud015,
   #        l_fmcn.fmcnud016,l_fmcn.fmcnud017,l_fmcn.fmcnud018,l_fmcn.fmcnud019,l_fmcn.fmcnud020,
   #        l_fmcn.fmcnud021,l_fmcn.fmcnud022,l_fmcn.fmcnud023,l_fmcn.fmcnud024,l_fmcn.fmcnud025,
   #        l_fmcn.fmcnud026,l_fmcn.fmcnud027,l_fmcn.fmcnud028,l_fmcn.fmcnud029,l_fmcn.fmcnud030
   #       )
   #170109-00035#1 mark-----e
   #161108-00017#4 add end---
   
   INITIALIZE l_fmcs.* TO NULL   
   LET l_fmcs.fmcsent = g_enterprise
   LET l_fmcs.fmcscomp = l_apgk.apgkcomp
   LET l_fmcs.fmcsdocno =  l_fmcr.fmcrdocno
   LET l_fmcs.fmcsseq = 1
   LET l_fmcs.fmcs001 = l_apga.apga018
   LET l_fmcs.fmcs002 = 1
   LET l_fmcs.fmcs003 = l_apgk.apgkcomp
   LET l_fmcs.fmcs004 = g_fmcj_m.l_fmck003
   LET l_fmcs.fmcs005 = '1'
   LET l_fmcs.fmcs006 = g_fmcj_m.l_fmcs006
   LET l_fmcs.fmcs007 = l_apga.apga100
   LET l_fmcs.fmcs008 = l_apga.apga105 
   LET l_fmcs.fmcs009 = l_apgk.apgk101
   LET l_fmcs.fmcs010 = l_fmcs.fmcs008 * l_fmcs.fmcs009
   #多幣別
   LET lc_param.apca004 = l_apgk.apgk001
   LET ls_js = util.JSON.stringify(lc_param)
   CALL s_fin_get_curr_rate(l_apgk.apgkcomp,l_ld,l_apgk.apgkdocdt,l_apgk.apgk100,ls_js)
        RETURNING l_dummy1, l_fmcs.fmcs011 , l_fmcs.fmcs013
   LET l_fmcs.fmcs012 = l_fmcs.fmcs008 * l_fmcs.fmcs011
   LET l_fmcs.fmcs014 = l_fmcs.fmcs008 * l_fmcs.fmcs013
   LET l_fmcs.fmcs015 = l_apga.apga016
   LET l_fmcs.fmcs016 = l_fmcs.fmcs016
   LET l_fmcs.fmcs017 = 0
   LET l_fmcs.fmcs018 = 0
   LET l_fmcs.fmcs019 = 0
   LET l_fmcs.fmcs020 = 0
   #INSERT INTO fmcs_t VALUES(l_fmcs.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcs_t (fmcscomp,fmcsent,fmcsdocno,fmcsseq,
                       fmcs001,fmcs002,fmcs003,fmcs004,fmcs005,
                       fmcs006,fmcs007,fmcs008,fmcs009,fmcs010,
                       fmcs011,fmcs012,fmcs013,fmcs014,fmcs015,
                       fmcs016,fmcs017,fmcs018,fmcs019,fmcs020,
                       fmcsud001,fmcsud002,fmcsud003,fmcsud004,fmcsud005,
                       fmcsud006,fmcsud007,fmcsud008,fmcsud009,fmcsud010,
                       fmcsud011,fmcsud012,fmcsud013,fmcsud014,fmcsud015,
                       fmcsud016,fmcsud017,fmcsud018,fmcsud019,fmcsud020,
                       fmcsud021,fmcsud022,fmcsud023,fmcsud024,fmcsud025,
                       fmcsud026,fmcsud027,fmcsud028,fmcsud029,fmcsud030,
                       fmcs021
                      )
   VALUES (l_fmcs.fmcscomp,l_fmcs.fmcsent,l_fmcs.fmcsdocno,l_fmcs.fmcsseq,
           l_fmcs.fmcs001,l_fmcs.fmcs002,l_fmcs.fmcs003,l_fmcs.fmcs004,l_fmcs.fmcs005,
           l_fmcs.fmcs006,l_fmcs.fmcs007,l_fmcs.fmcs008,l_fmcs.fmcs009,l_fmcs.fmcs010,
           l_fmcs.fmcs011,l_fmcs.fmcs012,l_fmcs.fmcs013,l_fmcs.fmcs014,l_fmcs.fmcs015,
           l_fmcs.fmcs016,l_fmcs.fmcs017,l_fmcs.fmcs018,l_fmcs.fmcs019,l_fmcs.fmcs020,
           l_fmcs.fmcsud001,l_fmcs.fmcsud002,l_fmcs.fmcsud003,l_fmcs.fmcsud004,l_fmcs.fmcsud005,
           l_fmcs.fmcsud006,l_fmcs.fmcsud007,l_fmcs.fmcsud008,l_fmcs.fmcsud009,l_fmcs.fmcsud010,
           l_fmcs.fmcsud011,l_fmcs.fmcsud012,l_fmcs.fmcsud013,l_fmcs.fmcsud014,l_fmcs.fmcsud015,
           l_fmcs.fmcsud016,l_fmcs.fmcsud017,l_fmcs.fmcsud018,l_fmcs.fmcsud019,l_fmcs.fmcsud020,
           l_fmcs.fmcsud021,l_fmcs.fmcsud022,l_fmcs.fmcsud023,l_fmcs.fmcsud024,l_fmcs.fmcsud025,
           l_fmcs.fmcsud026,l_fmcs.fmcsud027,l_fmcs.fmcsud028,l_fmcs.fmcsud029,l_fmcs.fmcsud030,
           l_fmcs.fmcs021
          )
   #161108-00017#4 add end---
   
   LET r_afmt140 = l_fmcs.fmcsdocno
   RETURN r_success,r_afmt140
END FUNCTION

 
{</section>}
 
