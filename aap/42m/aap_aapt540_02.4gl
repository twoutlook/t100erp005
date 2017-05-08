#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt540_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-06-14 11:20:00), PR版次:0005(2017-01-04 17:41:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aapt540_02
#+ Description: 融資還款
#+ Creator....: 03080(2016-06-13 20:11:18)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="aapt540_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161104-00024#4  2016/11/09 By 08729     處理DEFINE有星號
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#161208-00026#12 2016/12/12 By 08729     針對SELECT有星號的部分進行展開
#161104-00046#7  2016/01/04 By 08171     單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_fmcv_m        RECORD
       fmcvdocno LIKE fmcv_t.fmcvdocno, 
   fmcvdocdt LIKE fmcv_t.fmcvdocdt, 
   l_fmcw009 LIKE type_t.chr10, 
   l_fmcw009_desc LIKE type_t.chr80, 
   l_fmcw016 LIKE type_t.chr10, 
   l_fmcw016_desc LIKE type_t.chr80, 
   l_fmcw010 LIKE type_t.num26_10
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apgkcomp   LIKE apgk_t.apgkcomp
DEFINE g_apgkdocno  LIKE apgk_t.apgkdocno
#161104-00046#7 --s add
DEFINE g_user_slip_wc      STRING
#161104-00046#7 --e add
#end add-point
 
DEFINE g_fmcv_m        type_g_fmcv_m
 
   DEFINE g_fmcvdocno_t LIKE fmcv_t.fmcvdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt540_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt540_02(--)
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
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_afmt170   LIKE fmcv_t.fmcvdocno
   DEFINE l_ld         LIKE glaa_t.glaald
   DEFINE l_glaa024    LIKE glaa_t.glaa024
   DEFINE l_apga007    LIKE apga_t.apga007
   DEFINE l_glaa005    LIKE glaa_t.glaa005
   DEFINE l_flag       LIKE type_t.num5 #161104-00046#7
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt540_02 WITH FORM cl_ap_formpath("aap","aapt540_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET r_success = TRUE LET r_afmt170 = NULL
   
   CALL util.JSON.parse(p_lsjs,lc_param)
   LET g_apgkdocno = lc_param.apgkdocno
   LET g_apgkcomp  = lc_param.apgkcomp
   #給予預設-----s
   SELECT apgkdocdt,apgk101
     INTO g_fmcv_m.fmcvdocdt,g_fmcv_m.l_fmcw010
     FROM apgk_t
    WHERE apgkent   = g_enterprise
      AND apgkcomp  = g_apgkcomp
      AND apgkdocno = g_apgkdocno
   #給予預設-----e   
   #161104-00046#7 --s add
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#7 --e add
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fmcv_m.fmcvdocno,g_fmcv_m.fmcvdocdt,g_fmcv_m.l_fmcw009,g_fmcv_m.l_fmcw016,g_fmcv_m.l_fmcw010  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcvdocno
            #add-point:BEFORE FIELD fmcvdocno name="input.b.fmcvdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcvdocno
            
            #add-point:AFTER FIELD fmcvdocno name="input.a.fmcvdocno"
            #應用 a05 樣板自動產生(Version:3)
            LET l_ld = NULL   LET l_glaa024 = NULL
            SELECT glaald,glaa024 INTO l_ld,l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014=  'Y'
            IF NOT cl_null(g_fmcv_m.fmcvdocno) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcv_t WHERE "||"fmcvent = '" ||g_enterprise|| "' AND "||"fmcvdocno = '"||g_fmcv_m.fmcvdocno ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               CALL s_aooi200_fin_chk_slip(l_ld,l_glaa024,g_fmcv_m.fmcvdocno,'afmt170') RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fmcv_m.fmcvdocno = ''
                  NEXT FIELD fmcvdocno
               END IF
               #161104-00046#7 --s add
               CALL s_control_chk_doc('1',g_fmcv_m.fmcvdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_fmcv_m.fmcvdocno = ''
                  NEXT FIELD CURRENT                
               END IF
               #161104-00046#7 --e add
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcvdocno
            #add-point:ON CHANGE fmcvdocno name="input.g.fmcvdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcvdocdt
            #add-point:BEFORE FIELD fmcvdocdt name="input.b.fmcvdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcvdocdt
            
            #add-point:AFTER FIELD fmcvdocdt name="input.a.fmcvdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcvdocdt
            #add-point:ON CHANGE fmcvdocdt name="input.g.fmcvdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcw009
            
            #add-point:AFTER FIELD l_fmcw009 name="input.a.l_fmcw009"
            LET g_fmcv_m.l_fmcw009_desc = ''
            IF NOT cl_null(g_fmcv_m.l_fmcw009) THEN
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent  = g_enterprise
                  AND glaacomp = g_apgkcomp
                  AND glaa014  = 'Y'
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_glaa005
               LET g_chkparam.arg2 = g_fmcv_m.l_fmcw009
               LET g_errshow = TRUE
               LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
               IF cl_chk_exist("v_nmad002") THEN
                  IF cl_null(g_fmcv_m.l_fmcw009) THEN
                     SELECT nmad003 INTO g_fmcv_m.l_fmcw016
                       FROM nmad_t
                      WHERE nmadent = g_enterprise
                        AND nmad001 = l_glaa005
                        AND nmad002 = g_fmcv_m.l_fmcw009
                     CALL s_desc_get_nmail004_desc(l_glaa005,g_fmcv_m.l_fmcw016) RETURNING g_fmcv_m.l_fmcw016_desc
                     DISPLAY BY NAME g_fmcv_m.l_fmcw016,g_fmcv_m.l_fmcw016_desc
                  END IF
               ELSE
                  LET g_fmcv_m.l_fmcw009 = NULL
                  CALL s_desc_get_nmajl003_desc(g_fmcv_m.l_fmcw009) RETURNING g_fmcv_m.l_fmcw009_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_nmajl003_desc(g_fmcv_m.l_fmcw009) RETURNING g_fmcv_m.l_fmcw009_desc
            DISPLAY BY NAME g_fmcv_m.l_fmcw009_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcw009
            #add-point:BEFORE FIELD l_fmcw009 name="input.b.l_fmcw009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcw009
            #add-point:ON CHANGE l_fmcw009 name="input.g.l_fmcw009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcw016
            
            #add-point:AFTER FIELD l_fmcw016 name="input.a.l_fmcw016"
            IF NOT cl_null(g_fmcv_m.l_fmcw016) THEN
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent  = g_enterprise
                  AND glaacomp = g_apgkcomp
                  AND glaa014  = 'Y'
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_fmcv_m.l_fmcw016
               LET g_chkparam.arg2 = l_glaa005
               IF cl_chk_exist("v_nmai002") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET g_fmcv_m.l_fmcw016 = ''
                  CALL s_desc_get_nmail004_desc(l_glaa005,g_fmcv_m.l_fmcw016 ) RETURNING g_fmcv_m.l_fmcw016_desc
                  DISPLAY BY NAME g_fmcv_m.l_fmcw016_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            CALL s_desc_get_nmail004_desc(l_glaa005,g_fmcv_m.l_fmcw016 ) RETURNING g_fmcv_m.l_fmcw016_desc
            DISPLAY BY NAME g_fmcv_m.l_fmcw016_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcw016
            #add-point:BEFORE FIELD l_fmcw016 name="input.b.l_fmcw016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcw016
            #add-point:ON CHANGE l_fmcw016 name="input.g.l_fmcw016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmcw010
            #add-point:BEFORE FIELD l_fmcw010 name="input.b.l_fmcw010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmcw010
            
            #add-point:AFTER FIELD l_fmcw010 name="input.a.l_fmcw010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmcw010
            #add-point:ON CHANGE l_fmcw010 name="input.g.l_fmcw010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmcvdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcvdocno
            #add-point:ON ACTION controlp INFIELD fmcvdocno name="input.c.fmcvdocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014 = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcv_m.fmcvdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",l_glaa024,"' AND oobx003 = 'afmt170'"
            #161104-00046#7 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#7 --e add
            CALL q_ooba002_4()                             
            LET g_fmcv_m.fmcvdocno = g_qryparam.return1
            DISPLAY g_fmcv_m.fmcvdocno TO fmcvdocno             
            NEXT FIELD fmcvdocno   
            #END add-point
 
 
         #Ctrlp:input.c.fmcvdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcvdocdt
            #add-point:ON ACTION controlp INFIELD fmcvdocdt name="input.c.fmcvdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcw009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcw009
            #add-point:ON ACTION controlp INFIELD l_fmcw009 name="input.c.l_fmcw009"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcv_m.l_fmcw009             #給予default值
            LET g_qryparam.arg1 = l_glaa005
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()
            LET g_fmcv_m.l_fmcw009 = g_qryparam.return1
            DISPLAY BY NAME g_fmcv_m.l_fmcw009
            NEXT FIELD l_fmcw009
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcw016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcw016
            #add-point:ON ACTION controlp INFIELD l_fmcw016 name="input.c.l_fmcw016"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apgkcomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcv_m.l_fmcw016 
            LET g_qryparam.arg1 = ""
            LET g_qryparam.where = " nmai001='",l_glaa005,"' "
            CALL q_nmai002()
            LET g_fmcv_m.l_fmcw016  = g_qryparam.return1
            DISPLAY BY NAME g_fmcv_m.l_fmcw016 
            NEXT FIELD l_fmcw016
            #END add-point
 
 
         #Ctrlp:input.c.l_fmcw010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmcw010
            #add-point:ON ACTION controlp INFIELD l_fmcw010 name="input.c.l_fmcw010"
            
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
   CLOSE WINDOW w_aapt540_02 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET r_success = FALSE
   ELSE
      CALL aapt540_02_ins_afm() RETURNING g_sub_success,r_afmt170
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_afmt170 = ''
      END IF
   END IF

   RETURN r_success,r_afmt170
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt540_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt540_02.other_function" readonly="Y" >}

PRIVATE FUNCTION aapt540_02_ins_afm()
   DEFINE r_success LIKE type_t.num5
   DEFINE r_afmt170 LIKE fmcv_t.fmcvdocno
   #DEFINE l_fmcv    RECORD LIKE fmcv_t.* #161104-00024#4 mark
   #DEFINE l_fmcw    RECORD LIKE fmcw_t.* #161104-00024#4 mark
   #DEFINE l_apga    RECORD LIKE apga_t.* #161104-00024#4 mark
   #DEFINE l_apgk    RECORD LIKE apgk_t.* #161104-00024#4 mark
   #161104-00024#4-add(s)
   DEFINE l_fmcv  RECORD  #償還本息單頭檔
          fmcvent   LIKE fmcv_t.fmcvent, #企業編號
          fmcvdocno LIKE fmcv_t.fmcvdocno, #還款單號
          fmcvsite  LIKE fmcv_t.fmcvsite, #資金中心
          fmcvcomp  LIKE fmcv_t.fmcvcomp, #法人
          fmcvdocdt LIKE fmcv_t.fmcvdocdt, #還款日期
          fmcvownid LIKE fmcv_t.fmcvownid, #資料所屬者
          fmcvowndp LIKE fmcv_t.fmcvowndp, #資料所屬部門
          fmcvcrtid LIKE fmcv_t.fmcvcrtid, #資料建立者
          fmcvcrtdp LIKE fmcv_t.fmcvcrtdp, #資料建立部門
          fmcvcrtdt LIKE fmcv_t.fmcvcrtdt, #資料創建日
          fmcvmodid LIKE fmcv_t.fmcvmodid, #資料修改者
          fmcvmoddt LIKE fmcv_t.fmcvmoddt, #最近修改日
          fmcvcnfid LIKE fmcv_t.fmcvcnfid, #資料確認者
          fmcvcnfdt LIKE fmcv_t.fmcvcnfdt, #資料確認日
          fmcvstus  LIKE fmcv_t.fmcvstus, #狀態碼
          fmcvud001 LIKE fmcv_t.fmcvud001, #自定義欄位(文字)001
          fmcvud002 LIKE fmcv_t.fmcvud002, #自定義欄位(文字)002
          fmcvud003 LIKE fmcv_t.fmcvud003, #自定義欄位(文字)003
          fmcvud004 LIKE fmcv_t.fmcvud004, #自定義欄位(文字)004
          fmcvud005 LIKE fmcv_t.fmcvud005, #自定義欄位(文字)005
          fmcvud006 LIKE fmcv_t.fmcvud006, #自定義欄位(文字)006
          fmcvud007 LIKE fmcv_t.fmcvud007, #自定義欄位(文字)007
          fmcvud008 LIKE fmcv_t.fmcvud008, #自定義欄位(文字)008
          fmcvud009 LIKE fmcv_t.fmcvud009, #自定義欄位(文字)009
          fmcvud010 LIKE fmcv_t.fmcvud010, #自定義欄位(文字)010
          fmcvud011 LIKE fmcv_t.fmcvud011, #自定義欄位(數字)011
          fmcvud012 LIKE fmcv_t.fmcvud012, #自定義欄位(數字)012
          fmcvud013 LIKE fmcv_t.fmcvud013, #自定義欄位(數字)013
          fmcvud014 LIKE fmcv_t.fmcvud014, #自定義欄位(數字)014
          fmcvud015 LIKE fmcv_t.fmcvud015, #自定義欄位(數字)015
          fmcvud016 LIKE fmcv_t.fmcvud016, #自定義欄位(數字)016
          fmcvud017 LIKE fmcv_t.fmcvud017, #自定義欄位(數字)017
          fmcvud018 LIKE fmcv_t.fmcvud018, #自定義欄位(數字)018
          fmcvud019 LIKE fmcv_t.fmcvud019, #自定義欄位(數字)019
          fmcvud020 LIKE fmcv_t.fmcvud020, #自定義欄位(數字)020
          fmcvud021 LIKE fmcv_t.fmcvud021, #自定義欄位(日期時間)021
          fmcvud022 LIKE fmcv_t.fmcvud022, #自定義欄位(日期時間)022
          fmcvud023 LIKE fmcv_t.fmcvud023, #自定義欄位(日期時間)023
          fmcvud024 LIKE fmcv_t.fmcvud024, #自定義欄位(日期時間)024
          fmcvud025 LIKE fmcv_t.fmcvud025, #自定義欄位(日期時間)025
          fmcvud026 LIKE fmcv_t.fmcvud026, #自定義欄位(日期時間)026
          fmcvud027 LIKE fmcv_t.fmcvud027, #自定義欄位(日期時間)027
          fmcvud028 LIKE fmcv_t.fmcvud028, #自定義欄位(日期時間)028
          fmcvud029 LIKE fmcv_t.fmcvud029, #自定義欄位(日期時間)029
          fmcvud030 LIKE fmcv_t.fmcvud030 #自定義欄位(日期時間)030
              END RECORD
   DEFINE l_fmcw  RECORD  #償還本息單身檔
          fmcwent   LIKE fmcw_t.fmcwent, #企業編號
          fmcwdocno LIKE fmcw_t.fmcwdocno, #還款單編號
          fmcwseq   LIKE fmcw_t.fmcwseq, #項次
          fmcw001   LIKE fmcw_t.fmcw001, #融資組織
          fmcw002   LIKE fmcw_t.fmcw002, #融資合約號
          fmcw003   LIKE fmcw_t.fmcw003, #融資合約項次
          fmcw004   LIKE fmcw_t.fmcw004, #還款性質
          fmcw005   LIKE fmcw_t.fmcw005, #幣別
          fmcw006   LIKE fmcw_t.fmcw006, #本/息金額
          fmcw007   LIKE fmcw_t.fmcw007, #還款帳戶
          fmcw008   LIKE fmcw_t.fmcw008, #異動別
          fmcw009   LIKE fmcw_t.fmcw009, #存提碼
          fmcw010   LIKE fmcw_t.fmcw010, #匯率
          fmcw011   LIKE fmcw_t.fmcw011, #本幣
          fmcw012   LIKE fmcw_t.fmcw012, #匯率二
          fmcw013   LIKE fmcw_t.fmcw013, #本幣二
          fmcw014   LIKE fmcw_t.fmcw014, #匯率三
          fmcw015   LIKE fmcw_t.fmcw015, #本幣三
          fmcw016   LIKE fmcw_t.fmcw016, #現金變動碼
          fmcw017   LIKE fmcw_t.fmcw017, #已計提未支付利息
          fmcw018   LIKE fmcw_t.fmcw018, #歷史匯率
          fmcw019   LIKE fmcw_t.fmcw019, #歷史匯率二
          fmcw020   LIKE fmcw_t.fmcw020, #歷史匯率三
          fmcw021   LIKE fmcw_t.fmcw021, #融資到帳單號
          fmcw022   LIKE fmcw_t.fmcw022, #融資到帳單項次
          fmcw023   LIKE fmcw_t.fmcw023, #本幣匯差
          fmcw024   LIKE fmcw_t.fmcw024, #本幣匯差二
          fmcw025   LIKE fmcw_t.fmcw025, #本幣匯差三
          fmcwud001 LIKE fmcw_t.fmcwud001, #自定義欄位(文字)001
          fmcwud002 LIKE fmcw_t.fmcwud002, #自定義欄位(文字)002
          fmcwud003 LIKE fmcw_t.fmcwud003, #自定義欄位(文字)003
          fmcwud004 LIKE fmcw_t.fmcwud004, #自定義欄位(文字)004
          fmcwud005 LIKE fmcw_t.fmcwud005, #自定義欄位(文字)005
          fmcwud006 LIKE fmcw_t.fmcwud006, #自定義欄位(文字)006
          fmcwud007 LIKE fmcw_t.fmcwud007, #自定義欄位(文字)007
          fmcwud008 LIKE fmcw_t.fmcwud008, #自定義欄位(文字)008
          fmcwud009 LIKE fmcw_t.fmcwud009, #自定義欄位(文字)009
          fmcwud010 LIKE fmcw_t.fmcwud010, #自定義欄位(文字)010
          fmcwud011 LIKE fmcw_t.fmcwud011, #自定義欄位(數字)011
          fmcwud012 LIKE fmcw_t.fmcwud012, #自定義欄位(數字)012
          fmcwud013 LIKE fmcw_t.fmcwud013, #自定義欄位(數字)013
          fmcwud014 LIKE fmcw_t.fmcwud014, #自定義欄位(數字)014
          fmcwud015 LIKE fmcw_t.fmcwud015, #自定義欄位(數字)015
          fmcwud016 LIKE fmcw_t.fmcwud016, #自定義欄位(數字)016
          fmcwud017 LIKE fmcw_t.fmcwud017, #自定義欄位(數字)017
          fmcwud018 LIKE fmcw_t.fmcwud018, #自定義欄位(數字)018
          fmcwud019 LIKE fmcw_t.fmcwud019, #自定義欄位(數字)019
          fmcwud020 LIKE fmcw_t.fmcwud020, #自定義欄位(數字)020
          fmcwud021 LIKE fmcw_t.fmcwud021, #自定義欄位(日期時間)021
          fmcwud022 LIKE fmcw_t.fmcwud022, #自定義欄位(日期時間)022
          fmcwud023 LIKE fmcw_t.fmcwud023, #自定義欄位(日期時間)023
          fmcwud024 LIKE fmcw_t.fmcwud024, #自定義欄位(日期時間)024
          fmcwud025 LIKE fmcw_t.fmcwud025, #自定義欄位(日期時間)025
          fmcwud026 LIKE fmcw_t.fmcwud026, #自定義欄位(日期時間)026
          fmcwud027 LIKE fmcw_t.fmcwud027, #自定義欄位(日期時間)027
          fmcwud028 LIKE fmcw_t.fmcwud028, #自定義欄位(日期時間)028
          fmcwud029 LIKE fmcw_t.fmcwud029, #自定義欄位(日期時間)029
          fmcwud030 LIKE fmcw_t.fmcwud030, #自定義欄位(日期時間)030
          fmcw026   LIKE fmcw_t.fmcw026 #摘要
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
          apga039   LIKE apga_t.apga039 #預付款現變碼
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
          apgk019   LIKE apgk_t.apgk019 #融資還款單號
              END RECORD
   #161104-00024#4-add(e)
   DEFINE l_ld      LIKE glaa_t.glaald
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004,
            ooib001     LIKE ooib_t.ooib001        
                    END RECORD
   DEFINE ls_js         STRING   
   DEFINE l_dummy1   LIKE type_t.num20_6
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE LET r_afmt170 = NULL
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
   INITIALIZE l_fmcv.* TO NULL
   LET l_fmcv.fmcvent   = g_enterprise
   LET l_fmcv.fmcvdocno = g_fmcv_m.fmcvdocno
   LET l_fmcv.fmcvdocdt = g_fmcv_m.fmcvdocdt
   LET g_prog = 'afmt170'
   CALL s_aooi200_fin_gen_docno(l_ld,'','',l_fmcv.fmcvdocno ,l_fmcv.fmcvdocdt ,g_prog)
      RETURNING g_sub_success,l_fmcv.fmcvdocno
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   LET g_prog = 'aapt540'   
   LET l_fmcv.fmcvcomp  = l_apgk.apgkcomp   
   LET l_fmcv.fmcvsite  = l_apgk.apgkcomp
   LET l_fmcv.fmcvstus = 'N'
   #INSERT INTO fmcv_t VALUES(l_fmcv.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcv_t (fmcvent,fmcvdocno,fmcvsite,fmcvcomp,fmcvdocdt,
                       fmcvownid,fmcvowndp,fmcvcrtid,fmcvcrtdp,fmcvcrtdt,
                       fmcvmodid,fmcvmoddt,fmcvcnfid,fmcvcnfdt,fmcvstus,
                       fmcvud001,fmcvud002,fmcvud003,fmcvud004,fmcvud005,
                       fmcvud006,fmcvud007,fmcvud008,fmcvud009,fmcvud010,
                       fmcvud011,fmcvud012,fmcvud013,fmcvud014,fmcvud015,
                       fmcvud016,fmcvud017,fmcvud018,fmcvud019,fmcvud020,
                       fmcvud021,fmcvud022,fmcvud023,fmcvud024,fmcvud025,
                       fmcvud026,fmcvud027,fmcvud028,fmcvud029,fmcvud030
                      )
   VALUES (l_fmcv.fmcvent,l_fmcv.fmcvdocno,l_fmcv.fmcvsite,l_fmcv.fmcvcomp,l_fmcv.fmcvdocdt,
           l_fmcv.fmcvownid,l_fmcv.fmcvowndp,l_fmcv.fmcvcrtid,l_fmcv.fmcvcrtdp,l_fmcv.fmcvcrtdt,
           l_fmcv.fmcvmodid,l_fmcv.fmcvmoddt,l_fmcv.fmcvcnfid,l_fmcv.fmcvcnfdt,l_fmcv.fmcvstus,
           l_fmcv.fmcvud001,l_fmcv.fmcvud002,l_fmcv.fmcvud003,l_fmcv.fmcvud004,l_fmcv.fmcvud005,
           l_fmcv.fmcvud006,l_fmcv.fmcvud007,l_fmcv.fmcvud008,l_fmcv.fmcvud009,l_fmcv.fmcvud010,
           l_fmcv.fmcvud011,l_fmcv.fmcvud012,l_fmcv.fmcvud013,l_fmcv.fmcvud014,l_fmcv.fmcvud015,
           l_fmcv.fmcvud016,l_fmcv.fmcvud017,l_fmcv.fmcvud018,l_fmcv.fmcvud019,l_fmcv.fmcvud020,
           l_fmcv.fmcvud021,l_fmcv.fmcvud022,l_fmcv.fmcvud023,l_fmcv.fmcvud024,l_fmcv.fmcvud025,
           l_fmcv.fmcvud026,l_fmcv.fmcvud027,l_fmcv.fmcvud028,l_fmcv.fmcvud029,l_fmcv.fmcvud030
          )
   #161108-00017#4 add end---
   
   INITIALIZE l_fmcw.* TO NULL
   LET l_fmcw.fmcwent = g_enterprise
   LET l_fmcw.fmcwdocno = l_fmcv.fmcvdocno
   LET l_fmcw.fmcwseq   = 1
   LET l_fmcw.fmcw001   = l_apgk.apgkcomp
   LET l_fmcw.fmcw002 = l_apga.apga018   #融資合約號,(融資到帳單號相關)
   LET l_fmcw.fmcw003 = 1                #融資合約項次,(融資到帳單號相關)
   LET l_fmcw.fmcw004 = '1'
   LET l_fmcw.fmcw005 = l_apgk.apgk100
   LET l_fmcw.fmcw006 = l_apga.apga105   #融資合同貸款金額
   #LET l_fmcw.fmcw007 = 還款帳戶,(融資到帳單號相關)
   #LET l_fmcw.fmcw018 = 取到帳(afmt140)的匯率
   #LET l_fmcw.fmcw019 = 取到帳(afmt140)的匯率
   #LET l_fmcw.fmcw020 = 取到帳(afmt140)的匯率
   SELECT fmcs004,fmcs009,fmcs011,fmcs013
     INTO l_fmcw.fmcw007,l_fmcw.fmcw018,l_fmcw.fmcw019,l_fmcw.fmcw020
     FROM fmcs_t
    WHERE fmcsent = g_enterprise
      AND fmcscomp = l_apgk.apgkcomp
      AND fmcsdocno = l_apgk.apgkdocno
   LET l_fmcw.fmcw008 = '2'
   LET l_fmcw.fmcw009 = g_fmcv_m.l_fmcw009
   LET l_fmcw.fmcw010 = g_fmcv_m.l_fmcw010
   LET l_fmcw.fmcw011 = l_fmcw.fmcw006 * l_fmcw.fmcw010
   #多幣別
   LET lc_param.apca004 = l_apgk.apgk001
   LET ls_js = util.JSON.stringify(lc_param)   
   CALL s_fin_get_curr_rate(l_apgk.apgkcomp,l_ld,l_apgk.apgkdocdt,l_apgk.apgk100,ls_js)
       RETURNING l_dummy1, l_fmcw.fmcw012 , l_fmcw.fmcw014
       
   LET l_fmcw.fmcw013 = l_fmcw.fmcw006 * l_fmcw.fmcw012
   LET l_fmcw.fmcw015 = l_fmcw.fmcw006 * l_fmcw.fmcw014
   LET l_fmcw.fmcw016 = g_fmcv_m.l_fmcw016
   #LET l_fmcw.fmcw017 = 已計提未支付利息(依到帳單號取afmt180未還利息fmcz007合計)

   LET l_fmcw.fmcw021 = l_apgk.apgk010
   LET l_fmcw.fmcw022 = 1
   LET l_fmcw.fmcw023 = l_fmcw.fmcw006 * (l_fmcw.fmcw010-l_fmcw.fmcw018)
   LET l_fmcw.fmcw024 = l_fmcw.fmcw006 * (l_fmcw.fmcw012-l_fmcw.fmcw019)
   LET l_fmcw.fmcw025 = l_fmcw.fmcw006 * (l_fmcw.fmcw014-l_fmcw.fmcw020)
   #INSERT INTO fmcw_t VALUES(l_fmcw.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO fmcw_t (fmcwent,fmcwdocno,fmcwseq,
                       fmcw001,fmcw002,fmcw003,fmcw004,fmcw005,
                       fmcw006,fmcw007,fmcw008,fmcw009,fmcw010,
                       fmcw011,fmcw012,fmcw013,fmcw014,fmcw015,
                       fmcw016,fmcw017,fmcw018,fmcw019,fmcw020,
                       fmcw021,fmcw022,fmcw023,fmcw024,fmcw025,
                       fmcwud001,fmcwud002,fmcwud003,fmcwud004,fmcwud005,
                       fmcwud006,fmcwud007,fmcwud008,fmcwud009,fmcwud010,
                       fmcwud011,fmcwud012,fmcwud013,fmcwud014,fmcwud015,
                       fmcwud016,fmcwud017,fmcwud018,fmcwud019,fmcwud020,
                       fmcwud021,fmcwud022,fmcwud023,fmcwud024,fmcwud025,
                       fmcwud026,fmcwud027,fmcwud028,fmcwud029,fmcwud030,
                       fmcw026
                      )
   VALUES (l_fmcw.fmcwent,l_fmcw.fmcwdocno,l_fmcw.fmcwseq,
           l_fmcw.fmcw001,l_fmcw.fmcw002,l_fmcw.fmcw003,l_fmcw.fmcw004,l_fmcw.fmcw005,
           l_fmcw.fmcw006,l_fmcw.fmcw007,l_fmcw.fmcw008,l_fmcw.fmcw009,l_fmcw.fmcw010,
           l_fmcw.fmcw011,l_fmcw.fmcw012,l_fmcw.fmcw013,l_fmcw.fmcw014,l_fmcw.fmcw015,
           l_fmcw.fmcw016,l_fmcw.fmcw017,l_fmcw.fmcw018,l_fmcw.fmcw019,l_fmcw.fmcw020,
           l_fmcw.fmcw021,l_fmcw.fmcw022,l_fmcw.fmcw023,l_fmcw.fmcw024,l_fmcw.fmcw025,
           l_fmcw.fmcwud001,l_fmcw.fmcwud002,l_fmcw.fmcwud003,l_fmcw.fmcwud004,l_fmcw.fmcwud005,
           l_fmcw.fmcwud006,l_fmcw.fmcwud007,l_fmcw.fmcwud008,l_fmcw.fmcwud009,l_fmcw.fmcwud010,
           l_fmcw.fmcwud011,l_fmcw.fmcwud012,l_fmcw.fmcwud013,l_fmcw.fmcwud014,l_fmcw.fmcwud015,
           l_fmcw.fmcwud016,l_fmcw.fmcwud017,l_fmcw.fmcwud018,l_fmcw.fmcwud019,l_fmcw.fmcwud020,
           l_fmcw.fmcwud021,l_fmcw.fmcwud022,l_fmcw.fmcwud023,l_fmcw.fmcwud024,l_fmcw.fmcwud025,
           l_fmcw.fmcwud026,l_fmcw.fmcwud027,l_fmcw.fmcwud028,l_fmcw.fmcwud029,l_fmcw.fmcwud030,
           l_fmcw.fmcw026
          )
   #161108-00017#4 add end---
   
   LET r_afmt170 = l_fmcw.fmcwdocno
   RETURN r_success,r_afmt170
END FUNCTION

 
{</section>}
 
