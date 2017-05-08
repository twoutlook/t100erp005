#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt550_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-03-11 13:22:14), PR版次:0006(2017-01-04 18:16:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: aapt550_01
#+ Description: 到貨轉收貨入庫單
#+ Creator....: 05016(2016-03-10 17:24:02)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aapt550_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#26 2016/04/28 BY 07900     校验代码重复错误讯息的修改
#160428-00001#5  2016/06/08 By Hans      產生發票明細檔(pmdw)
#160705-00042#11 2016/07/14 By sakura    程式中寫死g_prog部分改寫MATCHES方式
#160719-00014#1  2016/08/01 By albireo   依QC反映內容修正
#161104-00024#4  2016/11/09 By 08729     處理DEFINE有星號
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#161208-00026#12 2016/12/13 By 08729     針對SELECT有星號的部分進行展開
#161104-00046#7  2016/01/04 By 08171     單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_pmds_m        RECORD
       pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdsdocno_desc LIKE type_t.chr80, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmds002 LIKE pmds_t.pmds002, 
   pmds002_desc LIKE type_t.chr80, 
   pmds003 LIKE pmds_t.pmds003, 
   pmds003_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_count          LIKE type_t.num5
DEFINE g_ooef004        LIKE ooef_t.ooef004
DEFINE g_program        STRING 
DEFINE g_apgldocno      LIKE apgl_t.apgldocno
DEFINE g_apglcomp       LIKE apgl_t.apglcomp
#161104-00046#7 --s add
DEFINE g_user_slip_wc   STRING
#161104-00046#7 --e add
#end add-point
 
DEFINE g_pmds_m        type_g_pmds_m
 
   DEFINE g_pmdsdocno_t LIKE pmds_t.pmdsdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt550_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt550_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_apglcomp,p_apgldocno
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
   DEFINE p_apglcomp      LIKE apgl_t.apglcomp
   DEFINE p_apgldocno     LIKE apgl_t.apgldocno
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_flag2         LIKE type_t.chr1
   DEFINE l_field         STRING
   DEFINE r_apgl029       LIKE apgl_t.apgl029
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_ld            LIKE glaa_t.glaald    #160719-00014#1
   DEFINE l_flag          LIKE type_t.num5 #161104-00046#7
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt550_01 WITH FORM cl_ap_formpath("aap","aapt550_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   #161104-00046#7 --s add
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#7 --e add
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pmds_m.pmdsdocno,g_pmds_m.pmdsdocdt,g_pmds_m.pmds002,g_pmds_m.pmds003 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_count = 0 #有採購單
            SELECT COUNT(*) INTO g_count FROM apgm_t 
             WHERE apgment = g_enterprise  AND apgmcomp = p_apglcomp
               AND apgmdocno = p_apgldocno AND apgm001 IS NOT NULL
            IF cl_null(g_count) THEN LET g_count = 0 END IF
            
            LET g_ooef004 = ''
            #SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   #160719-00014#1 mark
  
            SELECT glaa024,glaald INTO g_ooef004,l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = p_apglcomp AND glaa014 = 'Y'   #160719-00014#1 
            LET g_pmds_m.pmdsdocdt = g_today
            LET g_pmds_m.pmds002 = g_user
            LET g_pmds_m.pmdsdocno = ''
            LET g_pmds_m.pmds003   = ''
            LET g_apgldocno = p_apgldocno LET g_apglcomp = p_apglcomp
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmds_m.pmds002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmds_m.pmds002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmds_m.pmds002_desc
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdsdocno
            
            #add-point:AFTER FIELD pmdsdocno name="input.a.pmdsdocno"
            IF NOT cl_null(g_pmds_m.pmdsdocno) THEN
               LET l_flag1 = 'Y' LET l_flag2 = 'Y'
               IF g_count >0 THEN #有採購單
                  CALL cl_err_collect_init()
                  #IF NOT s_aooi200_chk_slip(g_site,'',g_pmds_m.pmdsdocno,'apmt520') THEN     #160719-00014#1 mark
                  IF NOT s_aooi200_fin_chk_docno(l_ld,'','',g_pmds_m.pmdsdocno,g_pmds_m.pmdsdocdt,'apmt520') THEN   #160719-00014#1 add
                     LET l_flag1 = 'N'
                  ELSE
                    LET g_program = 'apmt520'
                  END IF
                  #IF NOT s_aooi200_chk_slip(g_site,'',g_pmds_m.pmdsdocno,'apmt530') THEN     #160719-00014#1 mark
                  IF NOT s_aooi200_fin_chk_docno(l_ld,'','',g_pmds_m.pmdsdocno,g_pmds_m.pmdsdocdt,'apmt530') THEN   #160719-00014#1 add                  
                     LET l_flag2 = 'N'
                  ELSE
                     LET g_program = 'apmt530'
                  END IF
                  #兩者都是失敗
                  IF l_flag1 = 'N' AND l_flag2 = 'N' THEN
                     CALL cl_err_collect_show()
                     LET g_pmds_m.pmdsdocno = ''
                     NEXT FIELD CURRENT
                  END IF
                  IF l_flag1 = 'Y' OR l_flag2 = 'Y' THEN #其中一種成功
                     CALL cl_err_collect_init()
                     CALL cl_err_collect_show()
                  END IF
               ELSE #無採購單
                  CALL cl_err_collect_init()
                  #IF NOT s_aooi200_chk_slip(g_site,'',g_pmds_m.pmdsdocno,'apmt522') THEN
                  IF NOT s_aooi200_fin_chk_docno(l_ld,'','',g_pmds_m.pmdsdocno,g_pmds_m.pmdsdocdt,'apmt522') THEN   #160719-00014#1 add                  
                     LET l_flag1 = 'N'
                  ELSE
                     LET g_program = 'apmt522'
                  END IF
                  #IF NOT s_aooi200_chk_slip(g_site,'',g_pmds_m.pmdsdocno,'apmt532') THEN
                  IF NOT s_aooi200_fin_chk_docno(l_ld,'','',g_pmds_m.pmdsdocno,g_pmds_m.pmdsdocdt,'apmt532') THEN   #160719-00014#1 add                  
                     LET l_flag2 = 'N'
                  ELSE
                     LET g_program = 'apmt532'
                  END IF
                  #兩者都是失敗
                  IF l_flag1 = 'N' AND l_flag2 = 'N' THEN
                     CALL cl_err_collect_show()
                     LET g_pmds_m.pmdsdocno = ''
                     NEXT FIELD CURRENT
                  END IF
                  IF l_flag1 = 'Y' OR l_flag2 = 'Y' THEN #其中一種成功
                     CALL cl_err_collect_init()
                     CALL cl_err_collect_show()
                  END IF
                  #161104-00046#7 --s add
                  CALL s_control_chk_doc('1',g_pmds_m.pmdsdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     LET g_pmds_m.pmdsdocno = ''
                     NEXT FIELD CURRENT                
                  END IF
                  #161104-00046#7 --e add           
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmds_m.pmdsdocno
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl003 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmds_m.pmdsdocno_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmds_m.pmdsdocno_desc



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdsdocno
            #add-point:BEFORE FIELD pmdsdocno name="input.b.pmdsdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdsdocno
            #add-point:ON CHANGE pmdsdocno name="input.g.pmdsdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdsdocdt
            #add-point:BEFORE FIELD pmdsdocdt name="input.b.pmdsdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdsdocdt
            
            #add-point:AFTER FIELD pmdsdocdt name="input.a.pmdsdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdsdocdt
            #add-point:ON CHANGE pmdsdocdt name="input.g.pmdsdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds002
            
            #add-point:AFTER FIELD pmds002 name="input.a.pmds002"
            IF NOT cl_null(g_pmds_m.pmds002) THEN 
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.arg1 = g_pmds_m.pmds002
               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#26  by 07900 --add-end                 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN               
                  #160719-00014#1-----s
                  SELECT ooag003 INTO g_pmds_m.pmds003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_pmds_m.pmds002
                  CALL s_desc_get_department_desc(g_pmds_m.pmds003) RETURNING g_pmds_m.pmds003_desc
                  DISPLAY BY NAME g_pmds_m.pmds003_desc, g_pmds_m.pmds003_desc
                  #160719-00014#1-----e
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmds_m.pmds002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmds_m.pmds002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmds_m.pmds002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds002
            #add-point:BEFORE FIELD pmds002 name="input.b.pmds002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds002
            #add-point:ON CHANGE pmds002 name="input.g.pmds002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds003
            
            #add-point:AFTER FIELD pmds003 name="input.a.pmds003"
            IF NOT cl_null(g_pmds_m.pmds003) THEN 
               INITIALIZE g_chkparam.* TO NULL 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmds_m.pmds003
               LET g_chkparam.arg2 = ''
               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#26  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmds_m.pmds003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmds_m.pmds003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmds_m.pmds003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds003
            #add-point:BEFORE FIELD pmds003 name="input.b.pmds003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmds003
            #add-point:ON CHANGE pmds003 name="input.g.pmds003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdsdocno
            #add-point:ON ACTION controlp INFIELD pmdsdocno name="input.c.pmdsdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmds_m.pmdsdocno
            LET g_qryparam.arg1 = g_ooef004
            IF g_count > 0 THEN #有採購單
               LET g_qryparam.arg2 = "('apmt520','apmt530')"            
            ELSE
               LET g_qryparam.arg2 = "('apmt522','apmt532')"  
            END IF
            #161104-00046#7 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#7 --e add
            CALL q_ooba002_13()
            LET g_pmds_m.pmdsdocno = g_qryparam.return1
            DISPLAY BY NAME g_pmds_m.pmdsdocno
            NEXT FIELD pmdsdocno
            #END add-point
 
 
         #Ctrlp:input.c.pmdsdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdsdocdt
            #add-point:ON ACTION controlp INFIELD pmdsdocdt name="input.c.pmdsdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmds002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds002
            #add-point:ON ACTION controlp INFIELD pmds002 name="input.c.pmds002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_pmds_m.pmds002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_pmds_m.pmds002 = g_qryparam.return1              

            DISPLAY g_pmds_m.pmds002 TO pmds002              #

            NEXT FIELD pmds002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.pmds003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds003
            #add-point:ON ACTION controlp INFIELD pmds003 name="input.c.pmds003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_pmds_m.pmds003             #給予default值
            LET g_qryparam.default2 = "" #g_pmds_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_pmds_m.pmdsdocdt

 
            CALL q_ooeg001()                                #呼叫開窗
 
            LET g_pmds_m.pmds003 = g_qryparam.return1              
            #LET g_pmds_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmds_m.pmds003 TO pmds003              #
            #DISPLAY g_pmds_m.ooeg001 TO ooeg001 #部門編號
            NEXT FIELD pmds003                          #返回原欄位



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
      LET r_success = FALSE
      LET INT_FLAG = FALSE
      LET r_apgl029 = ''
      CLOSE WINDOW w_aapt550_01
      RETURN r_success,r_apgl029
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt550_01 
   
   #add-point:input段after input name="input.post_input"
   CALL aapt550_01_gen_pmds() RETURNING r_success,r_apgl029
   CALL aapt550_01_ins_pmdw(r_apgl029)RETURNING r_success
   
   RETURN r_success,r_apgl029
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt550_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt550_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 產生收貨/入庫單頭
# Memo...........:
# Usage..........: CALL aapt550_01_gen_pmds()
# Date & Author..: 2016/03/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt550_01_gen_pmds()
#161104-00024#4 mark(s)
#DEFINE l_pmds      RECORD LIKE pmds_t.*
#DEFINE l_pmdl      RECORD LIKE pmdl_t.*
#DEFINE l_apgl      RECORD LIKE apgl_t.*
#161104-00024#4 mark(e)
#161104-00024#4-add(e)
DEFINE l_pmds  RECORD  #收貨/入庫單頭檔
       pmdsent   LIKE pmds_t.pmdsent, #企業編號
       pmdssite  LIKE pmds_t.pmdssite, #營運據點
       pmdsdocno LIKE pmds_t.pmdsdocno, #單據單號
       pmdsdocdt LIKE pmds_t.pmdsdocdt, #單據日期
       pmds000   LIKE pmds_t.pmds000, #單據性質
       pmds001   LIKE pmds_t.pmds001, #扣帳日期
       pmds002   LIKE pmds_t.pmds002, #申請人員
       pmds003   LIKE pmds_t.pmds003, #申請部門
       pmds006   LIKE pmds_t.pmds006, #來源單號
       pmds007   LIKE pmds_t.pmds007, #採購供應商
       pmds008   LIKE pmds_t.pmds008, #帳款供應商
       pmds009   LIKE pmds_t.pmds009, #送貨供應商
       pmds010   LIKE pmds_t.pmds010, #供應商送貨單號
       pmds011   LIKE pmds_t.pmds011, #採購性質
       pmds012   LIKE pmds_t.pmds012, #採購通路
       pmds013   LIKE pmds_t.pmds013, #採購分類
       pmds014   LIKE pmds_t.pmds014, #多角性質
       pmds021   LIKE pmds_t.pmds021, #LC進口
       pmds022   LIKE pmds_t.pmds022, #進口日期
       pmds023   LIKE pmds_t.pmds023, #進口報單
       pmds024   LIKE pmds_t.pmds024, #進口號碼
       pmds028   LIKE pmds_t.pmds028, #一次性交易對象識別碼
       pmds031   LIKE pmds_t.pmds031, #付款條件
       pmds032   LIKE pmds_t.pmds032, #交易條件
       pmds033   LIKE pmds_t.pmds033, #稅別
       pmds034   LIKE pmds_t.pmds034, #稅率
       pmds035   LIKE pmds_t.pmds035, #單價含稅否
       pmds036   LIKE pmds_t.pmds036, #交易類型
       pmds037   LIKE pmds_t.pmds037, #幣別
       pmds038   LIKE pmds_t.pmds038, #匯率
       pmds039   LIKE pmds_t.pmds039, #取價方式
       pmds040   LIKE pmds_t.pmds040, #付款優惠條件
       pmds041   LIKE pmds_t.pmds041, #多角序號
       pmds042   LIKE pmds_t.pmds042, #整合單號
       pmds043   LIKE pmds_t.pmds043, #採購總未稅金額
       pmds044   LIKE pmds_t.pmds044, #採購總含稅金額
       pmds045   LIKE pmds_t.pmds045, #備註
       pmds046   LIKE pmds_t.pmds046, #採購總稅額
       pmds047   LIKE pmds_t.pmds047, #多角貿易中斷點
       pmds048   LIKE pmds_t.pmds048, #內外購
       pmds049   LIKE pmds_t.pmds049, #匯率計算基準
       pmds050   LIKE pmds_t.pmds050, #多角貿易已拋轉
       pmds051   LIKE pmds_t.pmds051, #出貨單號
       pmds052   LIKE pmds_t.pmds052, #供應商出貨日
       pmds053   LIKE pmds_t.pmds053, #多角流程編號
       pmds081   LIKE pmds_t.pmds081, #取回日期
       pmds100   LIKE pmds_t.pmds100, #倉退方式
       pmds101   LIKE pmds_t.pmds101, #折讓日期
       pmds102   LIKE pmds_t.pmds102, #折讓原始發票
       pmdsownid LIKE pmds_t.pmdsownid, #資料所屬者
       pmdsowndp LIKE pmds_t.pmdsowndp, #資料所有部門
       pmdscrtid LIKE pmds_t.pmdscrtid, #資料建立者
       pmdscrtdp LIKE pmds_t.pmdscrtdp, #資料建立部門
       pmdscrtdt LIKE pmds_t.pmdscrtdt, #資料創建日
       pmdsmodid LIKE pmds_t.pmdsmodid, #資料修改者
       pmdsmoddt LIKE pmds_t.pmdsmoddt, #最近修改日
       pmdscnfid LIKE pmds_t.pmdscnfid, #資料確認者
       pmdscnfdt LIKE pmds_t.pmdscnfdt, #資料確認日
       pmdspstid LIKE pmds_t.pmdspstid, #資料過帳者
       pmdspstdt LIKE pmds_t.pmdspstdt, #資料過帳日
       pmdsstus  LIKE pmds_t.pmdsstus, #狀態碼
       pmdsud001 LIKE pmds_t.pmdsud001, #自定義欄位(文字)001
       pmdsud002 LIKE pmds_t.pmdsud002, #自定義欄位(文字)002
       pmdsud003 LIKE pmds_t.pmdsud003, #自定義欄位(文字)003
       pmdsud004 LIKE pmds_t.pmdsud004, #自定義欄位(文字)004
       pmdsud005 LIKE pmds_t.pmdsud005, #自定義欄位(文字)005
       pmdsud006 LIKE pmds_t.pmdsud006, #自定義欄位(文字)006
       pmdsud007 LIKE pmds_t.pmdsud007, #自定義欄位(文字)007
       pmdsud008 LIKE pmds_t.pmdsud008, #自定義欄位(文字)008
       pmdsud009 LIKE pmds_t.pmdsud009, #自定義欄位(文字)009
       pmdsud010 LIKE pmds_t.pmdsud010, #自定義欄位(文字)010
       pmdsud011 LIKE pmds_t.pmdsud011, #自定義欄位(數字)011
       pmdsud012 LIKE pmds_t.pmdsud012, #自定義欄位(數字)012
       pmdsud013 LIKE pmds_t.pmdsud013, #自定義欄位(數字)013
       pmdsud014 LIKE pmds_t.pmdsud014, #自定義欄位(數字)014
       pmdsud015 LIKE pmds_t.pmdsud015, #自定義欄位(數字)015
       pmdsud016 LIKE pmds_t.pmdsud016, #自定義欄位(數字)016
       pmdsud017 LIKE pmds_t.pmdsud017, #自定義欄位(數字)017
       pmdsud018 LIKE pmds_t.pmdsud018, #自定義欄位(數字)018
       pmdsud019 LIKE pmds_t.pmdsud019, #自定義欄位(數字)019
       pmdsud020 LIKE pmds_t.pmdsud020, #自定義欄位(數字)020
       pmdsud021 LIKE pmds_t.pmdsud021, #自定義欄位(日期時間)021
       pmdsud022 LIKE pmds_t.pmdsud022, #自定義欄位(日期時間)022
       pmdsud023 LIKE pmds_t.pmdsud023, #自定義欄位(日期時間)023
       pmdsud024 LIKE pmds_t.pmdsud024, #自定義欄位(日期時間)024
       pmdsud025 LIKE pmds_t.pmdsud025, #自定義欄位(日期時間)025
       pmdsud026 LIKE pmds_t.pmdsud026, #自定義欄位(日期時間)026
       pmdsud027 LIKE pmds_t.pmdsud027, #自定義欄位(日期時間)027
       pmdsud028 LIKE pmds_t.pmdsud028, #自定義欄位(日期時間)028
       pmdsud029 LIKE pmds_t.pmdsud029, #自定義欄位(日期時間)029
       pmdsud030 LIKE pmds_t.pmdsud030, #自定義欄位(日期時間)030
       pmds200   LIKE pmds_t.pmds200, #收貨預約單號
       pmds054   LIKE pmds_t.pmds054, #資料來源
       pmds055   LIKE pmds_t.pmds055, #來源單號
       pmds201   LIKE pmds_t.pmds201, #來源單號
       pmds202   LIKE pmds_t.pmds202, #來源類型
       pmdsunit  LIKE pmds_t.pmdsunit, #應用執行組織物件
       pmds056   LIKE pmds_t.pmds056, #No use
       pmds057   LIKE pmds_t.pmds057, #整合來源
       pmds058   LIKE pmds_t.pmds058, #倒扣領料單號
       pmds103   LIKE pmds_t.pmds103  #折讓證明單開立方式
           END RECORD
DEFINE l_pmdl  RECORD  #採購單頭檔
       pmdlent   LIKE pmdl_t.pmdlent, #企業編號
       pmdlsite  LIKE pmdl_t.pmdlsite, #營運據點
       pmdlunit  LIKE pmdl_t.pmdlunit, #應用組織
       pmdldocno LIKE pmdl_t.pmdldocno, #採購單號
       pmdldocdt LIKE pmdl_t.pmdldocdt, #採購日期
       pmdl001   LIKE pmdl_t.pmdl001, #版次
       pmdl002   LIKE pmdl_t.pmdl002, #採購人員
       pmdl003   LIKE pmdl_t.pmdl003, #採購部門
       pmdl004   LIKE pmdl_t.pmdl004, #供應商編號
       pmdl005   LIKE pmdl_t.pmdl005, #採購性質
       pmdl006   LIKE pmdl_t.pmdl006, #多角性質
       pmdl007   LIKE pmdl_t.pmdl007, #資料來源類型
       pmdl008   LIKE pmdl_t.pmdl008, #來源單號
       pmdl009   LIKE pmdl_t.pmdl009, #付款條件
       pmdl010   LIKE pmdl_t.pmdl010, #交易條件
       pmdl011   LIKE pmdl_t.pmdl011, #稅別
       pmdl012   LIKE pmdl_t.pmdl012, #稅率
       pmdl013   LIKE pmdl_t.pmdl013, #單價含稅否
       pmdl015   LIKE pmdl_t.pmdl015, #幣別
       pmdl016   LIKE pmdl_t.pmdl016, #匯率
       pmdl017   LIKE pmdl_t.pmdl017, #取價方式
       pmdl018   LIKE pmdl_t.pmdl018, #付款優惠條件
       pmdl019   LIKE pmdl_t.pmdl019, #納入APS計算
       pmdl020   LIKE pmdl_t.pmdl020, #運送方式
       pmdl021   LIKE pmdl_t.pmdl021, #付款供應商
       pmdl022   LIKE pmdl_t.pmdl022, #送貨供應商
       pmdl023   LIKE pmdl_t.pmdl023, #採購分類一
       pmdl024   LIKE pmdl_t.pmdl024, #採購分類二
       pmdl025   LIKE pmdl_t.pmdl025, #送貨地址
       pmdl026   LIKE pmdl_t.pmdl026, #帳款地址
       pmdl027   LIKE pmdl_t.pmdl027, #供應商連絡人
       pmdl028   LIKE pmdl_t.pmdl028, #一次性交易對象識別碼
       pmdl029   LIKE pmdl_t.pmdl029, #收貨部門
       pmdl030   LIKE pmdl_t.pmdl030, #多角貿易已拋轉
       pmdl031   LIKE pmdl_t.pmdl031, #多角序號
       pmdl032   LIKE pmdl_t.pmdl032, #最終客戶
       pmdl033   LIKE pmdl_t.pmdl033, #發票類型
       pmdl040   LIKE pmdl_t.pmdl040, #採購總未稅金額
       pmdl041   LIKE pmdl_t.pmdl041, #採購總含稅金額
       pmdl042   LIKE pmdl_t.pmdl042, #採購總稅額
       pmdl043   LIKE pmdl_t.pmdl043, #留置原因
       pmdl044   LIKE pmdl_t.pmdl044, #備註
       pmdl046   LIKE pmdl_t.pmdl046, #預付款發票開立方式
       pmdl047   LIKE pmdl_t.pmdl047, #物流結案
       pmdl048   LIKE pmdl_t.pmdl048, #帳流結案
       pmdl049   LIKE pmdl_t.pmdl049, #金流結案
       pmdl050   LIKE pmdl_t.pmdl050, #多角最終站否
       pmdl051   LIKE pmdl_t.pmdl051, #多角流程編號
       pmdl052   LIKE pmdl_t.pmdl052, #最終供應商
       pmdl053   LIKE pmdl_t.pmdl053, #兩角目的據點
       pmdl054   LIKE pmdl_t.pmdl054, #內外購
       pmdl055   LIKE pmdl_t.pmdl055, #匯率計算基準
       pmdl200   LIKE pmdl_t.pmdl200, #採購中心
       pmdl201   LIKE pmdl_t.pmdl201, #聯絡電話
       pmdl202   LIKE pmdl_t.pmdl202, #傳真號碼
       pmdl203   LIKE pmdl_t.pmdl203, #採購方式
       pmdl204   LIKE pmdl_t.pmdl204, #配送中心
       pmdl900   LIKE pmdl_t.pmdl900, #保留欄位str
       pmdl999   LIKE pmdl_t.pmdl999, #保留欄位end
       pmdlownid LIKE pmdl_t.pmdlownid, #資料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #資料所屬部門
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #資料建立者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #資料建立部門
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #資料創建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #資料修改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近修改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #資料確認者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #資料確認日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #資料過帳者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #資料過帳日
       pmdlstus  LIKE pmdl_t.pmdlstus, #狀態碼
       pmdlud001 LIKE pmdl_t.pmdlud001, #自定義欄位(文字)001
       pmdlud002 LIKE pmdl_t.pmdlud002, #自定義欄位(文字)002
       pmdlud003 LIKE pmdl_t.pmdlud003, #自定義欄位(文字)003
       pmdlud004 LIKE pmdl_t.pmdlud004, #自定義欄位(文字)004
       pmdlud005 LIKE pmdl_t.pmdlud005, #自定義欄位(文字)005
       pmdlud006 LIKE pmdl_t.pmdlud006, #自定義欄位(文字)006
       pmdlud007 LIKE pmdl_t.pmdlud007, #自定義欄位(文字)007
       pmdlud008 LIKE pmdl_t.pmdlud008, #自定義欄位(文字)008
       pmdlud009 LIKE pmdl_t.pmdlud009, #自定義欄位(文字)009
       pmdlud010 LIKE pmdl_t.pmdlud010, #自定義欄位(文字)010
       pmdlud011 LIKE pmdl_t.pmdlud011, #自定義欄位(數字)011
       pmdlud012 LIKE pmdl_t.pmdlud012, #自定義欄位(數字)012
       pmdlud013 LIKE pmdl_t.pmdlud013, #自定義欄位(數字)013
       pmdlud014 LIKE pmdl_t.pmdlud014, #自定義欄位(數字)014
       pmdlud015 LIKE pmdl_t.pmdlud015, #自定義欄位(數字)015
       pmdlud016 LIKE pmdl_t.pmdlud016, #自定義欄位(數字)016
       pmdlud017 LIKE pmdl_t.pmdlud017, #自定義欄位(數字)017
       pmdlud018 LIKE pmdl_t.pmdlud018, #自定義欄位(數字)018
       pmdlud019 LIKE pmdl_t.pmdlud019, #自定義欄位(數字)019
       pmdlud020 LIKE pmdl_t.pmdlud020, #自定義欄位(數字)020
       pmdlud021 LIKE pmdl_t.pmdlud021, #自定義欄位(日期時間)021
       pmdlud022 LIKE pmdl_t.pmdlud022, #自定義欄位(日期時間)022
       pmdlud023 LIKE pmdl_t.pmdlud023, #自定義欄位(日期時間)023
       pmdlud024 LIKE pmdl_t.pmdlud024, #自定義欄位(日期時間)024
       pmdlud025 LIKE pmdl_t.pmdlud025, #自定義欄位(日期時間)025
       pmdlud026 LIKE pmdl_t.pmdlud026, #自定義欄位(日期時間)026
       pmdlud027 LIKE pmdl_t.pmdlud027, #自定義欄位(日期時間)027
       pmdlud028 LIKE pmdl_t.pmdlud028, #自定義欄位(日期時間)028
       pmdlud029 LIKE pmdl_t.pmdlud029, #自定義欄位(日期時間)029
       pmdlud030 LIKE pmdl_t.pmdlud030, #自定義欄位(日期時間)030
       pmdl205   LIKE pmdl_t.pmdl205, #採購最終有效日
       pmdl206   LIKE pmdl_t.pmdl206, #長效期訂單否
       pmdl207   LIKE pmdl_t.pmdl207, #所屬品類
       pmdl208   LIKE pmdl_t.pmdl208  #電子採購單號
           END RECORD
DEFINE l_apgl  RECORD  #外購到貨主檔
       apglent   LIKE apgl_t.apglent, #企業編號
       apglcomp  LIKE apgl_t.apglcomp, #法人
       apgldocno LIKE apgl_t.apgldocno, #到貨單號
       apgldocdt LIKE apgl_t.apgldocdt, #到貨日期
       apgl001   LIKE apgl_t.apgl001, #報關日期
       apgl002   LIKE apgl_t.apgl002, #供應商編號
       apgl003   LIKE apgl_t.apgl003, #L/C NO
       apgl004   LIKE apgl_t.apgl004, #申請單號
       apgl005   LIKE apgl_t.apgl005, #業務人員
       apgl006   LIKE apgl_t.apgl006, #報關行
       apgl007   LIKE apgl_t.apgl007, #裝運通知單號
       apgl008   LIKE apgl_t.apgl008, #運送方式
       apgl009   LIKE apgl_t.apgl009, #大提單單號
       apgl010   LIKE apgl_t.apgl010, #小提單單號
       apgl011   LIKE apgl_t.apgl011, #提單日期
       apgl012   LIKE apgl_t.apgl012, #起運日期
       apgl013   LIKE apgl_t.apgl013, #預計抵達日期
       apgl014   LIKE apgl_t.apgl014, #裝運公司
       apgl015   LIKE apgl_t.apgl015, #船名/航次
       apgl016   LIKE apgl_t.apgl016, #海關手冊
       apgl017   LIKE apgl_t.apgl017, #領櫃地點
       apgl018   LIKE apgl_t.apgl018, #領櫃編號
       apgl019   LIKE apgl_t.apgl019, #交櫃地點
       apgl020   LIKE apgl_t.apgl020, #櫃量
       apgl021   LIKE apgl_t.apgl021, #免費倉租日期
       apgl022   LIKE apgl_t.apgl022, #報單號碼
       apgl023   LIKE apgl_t.apgl023, #到單單號
       apgl024   LIKE apgl_t.apgl024, #稅款繳納證號
       apgl025   LIKE apgl_t.apgl025, #營業稅率
       apgl026   LIKE apgl_t.apgl026, #扣抵編號
       apgl027   LIKE apgl_t.apgl027, #本幣營業稅稅基
       apgl028   LIKE apgl_t.apgl028, #本幣稅費合計
       apgl029   LIKE apgl_t.apgl029, #收貨/入庫單號
       apgl030   LIKE apgl_t.apgl030, #到貨費用應付憑單
       apgl100   LIKE apgl_t.apgl100, #幣別
       apgl101   LIKE apgl_t.apgl101, #報單匯率
       apgl103   LIKE apgl_t.apgl103, #到貨原幣金額
       apglownid LIKE apgl_t.apglownid, #資料所有者
       apglowndp LIKE apgl_t.apglowndp, #資料所屬部門
       apglcrtid LIKE apgl_t.apglcrtid, #資料建立者
       apglcrtdp LIKE apgl_t.apglcrtdp, #資料建立部門
       apglcrtdt LIKE apgl_t.apglcrtdt, #資料創建日
       apglmodid LIKE apgl_t.apglmodid, #資料修改者
       apglmoddt LIKE apgl_t.apglmoddt, #最近修改日
       apglcnfid LIKE apgl_t.apglcnfid, #資料確認者
       apglcnfdt LIKE apgl_t.apglcnfdt, #資料確認日
       apglstus  LIKE apgl_t.apglstus, #狀態碼
       apglud001 LIKE apgl_t.apglud001, #自定義欄位(文字)001
       apglud002 LIKE apgl_t.apglud002, #自定義欄位(文字)002
       apglud003 LIKE apgl_t.apglud003, #自定義欄位(文字)003
       apglud004 LIKE apgl_t.apglud004, #自定義欄位(文字)004
       apglud005 LIKE apgl_t.apglud005, #自定義欄位(文字)005
       apglud006 LIKE apgl_t.apglud006, #自定義欄位(文字)006
       apglud007 LIKE apgl_t.apglud007, #自定義欄位(文字)007
       apglud008 LIKE apgl_t.apglud008, #自定義欄位(文字)008
       apglud009 LIKE apgl_t.apglud009, #自定義欄位(文字)009
       apglud010 LIKE apgl_t.apglud010, #自定義欄位(文字)010
       apglud011 LIKE apgl_t.apglud011, #自定義欄位(數字)011
       apglud012 LIKE apgl_t.apglud012, #自定義欄位(數字)012
       apglud013 LIKE apgl_t.apglud013, #自定義欄位(數字)013
       apglud014 LIKE apgl_t.apglud014, #自定義欄位(數字)014
       apglud015 LIKE apgl_t.apglud015, #自定義欄位(數字)015
       apglud016 LIKE apgl_t.apglud016, #自定義欄位(數字)016
       apglud017 LIKE apgl_t.apglud017, #自定義欄位(數字)017
       apglud018 LIKE apgl_t.apglud018, #自定義欄位(數字)018
       apglud019 LIKE apgl_t.apglud019, #自定義欄位(數字)019
       apglud020 LIKE apgl_t.apglud020, #自定義欄位(數字)020
       apglud021 LIKE apgl_t.apglud021, #自定義欄位(日期時間)021
       apglud022 LIKE apgl_t.apglud022, #自定義欄位(日期時間)022
       apglud023 LIKE apgl_t.apglud023, #自定義欄位(日期時間)023
       apglud024 LIKE apgl_t.apglud024, #自定義欄位(日期時間)024
       apglud025 LIKE apgl_t.apglud025, #自定義欄位(日期時間)025
       apglud026 LIKE apgl_t.apglud026, #自定義欄位(日期時間)026
       apglud027 LIKE apgl_t.apglud027, #自定義欄位(日期時間)027
       apglud028 LIKE apgl_t.apglud028, #自定義欄位(日期時間)028
       apglud029 LIKE apgl_t.apglud029, #自定義欄位(日期時間)029
       apglud030 LIKE apgl_t.apglud030, #自定義欄位(日期時間)030
       apgl113   LIKE apgl_t.apgl113  #到貨本幣金額
           END RECORD
#161104-00024#4-add(e)
DEFINE r_success   LIKE type_t.num5
DEFINE r_docno     LIKE pmds_t.pmdsdocno
DEFINE l_apgm001   LIKE apgm_t.apgm001
DEFINE l_oodbl004  LIKE oodbl_t.oodbl004    #稅別名稱
DEFINE l_oodb005   LIKE oodb_t.oodb005      #含稅否
DEFINE l_oodb006   LIKE oodb_t.oodb006      #稅率 
DEFINE l_oodb011   LIKE oodb_t.oodb011      #取得稅別類型1:正常稅率2:依料件設定

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #SELECT * INTO l_apgl.* FROM apgl_t WHERE apglent = g_enterprise  #161208-00026#12 mark
   #161208-00026#12-add(s)
   SELECT apglent,apglcomp,apgldocno,apgldocdt,apgl001,
          apgl002,apgl003,apgl004,apgl005,apgl006,
          apgl007,apgl008,apgl009,apgl010,apgl011,
          apgl012,apgl013,apgl014,apgl015,apgl016,
          apgl017,apgl018,apgl019,apgl020,apgl021,
          apgl022,apgl023,apgl024,apgl025,apgl026,
          apgl027,apgl028,apgl029,apgl030,apgl100,
          apgl101,apgl103,apglownid,apglowndp,apglcrtid,
          apglcrtdp,apglcrtdt,apglmodid,apglmoddt,apglcnfid,
          apglcnfdt,apglstus,apglud001,apglud002,apglud003,
          apglud004,apglud005,apglud006,apglud007,apglud008,
          apglud009,apglud010,apglud011,apglud012,apglud013,
          apglud014,apglud015,apglud016,apglud017,apglud018,
          apglud019,apglud020,apglud021,apglud022,apglud023,
          apglud024,apglud025,apglud026,apglud027,apglud028,
          apglud029,apglud030,apgl113 
     INTO l_apgl.* 
     FROM apgl_t 
    WHERE apglent = g_enterprise
   #161208-00026#12-add(e)
      AND apgldocno = g_apgldocno AND apglcomp = g_apglcomp
  
  IF g_count > 0 THEN #有採購單號
     SELECT MAX(apgm001) INTO l_apgm001 
       FROM apgm_t WHERE apgment = g_enterprise
        AND apgmdocno = g_apgldocno AND apgmcomp = g_apglcomp   
     #SELECT * INTO l_pmdl.*   #161208-00026#12 mark
     #161208-00026#12-add(s)
     SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
            pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
            pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
            pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
            pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
            pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
            pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
            pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
            pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
            pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
            pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
            pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
            pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
            pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
            pmdlstus,pmdlud001,pmdlud002,pmdlud003,pmdlud004,
            pmdlud005,pmdlud006,pmdlud007,pmdlud008,pmdlud009,
            pmdlud010,pmdlud011,pmdlud012,pmdlud013,pmdlud014,
            pmdlud015,pmdlud016,pmdlud017,pmdlud018,pmdlud019,
            pmdlud020,pmdlud021,pmdlud022,pmdlud023,pmdlud024,
            pmdlud025,pmdlud026,pmdlud027,pmdlud028,pmdlud029,
            pmdlud030,pmdl205,pmdl206,pmdl207,pmdl208 
       INTO l_pmdl.* 
     #161208-00026#12-add(e)
       FROM pmdl_t WHERE pmdldocno = l_apgm001 AND pmdlent = g_enterprise
   END IF
   
   LET l_pmds.pmdsent = g_enterprise
   IF g_count > 0 THEN                       
      LET l_pmds.pmdssite = l_pmdl.pmdlsite
   ELSE
      LET l_pmds.pmdssite = g_apglcomp 
   END IF
   CALL s_aooi200_gen_docno(l_pmds.pmdssite,g_pmds_m.pmdsdocno,g_pmds_m.pmdsdocdt,g_program) 
      RETURNING g_sub_success,l_pmds.pmdsdocno
   LET l_pmds.pmdsownid = g_user
   LET l_pmds.pmdsowndp = g_dept
   LET l_pmds.pmdscrtid = g_user
   LET l_pmds.pmdscrtdp = g_dept
   LET l_pmds.pmdscrtdt = cl_get_current()
   LET l_pmds.pmdsmodid = ""
   LET l_pmds.pmdsmoddt = ""
   LET l_pmds.pmdscnfid = ""
   LET l_pmds.pmdscnfdt = ""
   LET l_pmds.pmdspstid = ""
   LET l_pmds.pmdspstdt = ""
   LET l_pmds.pmdsstus  = "N"
   #160705-00042#11 160714 by sakura mark(S)   
   #CASE g_program
   #   WHEN 'apmt520'
   #160705-00042#11 160714 by sakura mark(E)
   #160705-00042#11 160714 by sakura add(S)
   CASE 
      WHEN g_program MATCHES 'apmt520'
   #160705-00042#11 160714 by sakura add(E)      
         LET l_pmds.pmds000 = '1'  #1.採購收貨單    apmt520 
      #WHEN 'apmt530'                    #160705-00042#11 160714 by sakura mark
      WHEN g_program MATCHES 'apmt530'   #160705-00042#11 160714 by sakura add
         LET l_pmds.pmds000 = '3'  #3.採購收貨入庫單 apmt530
      #WHEN 'apmt522'                    #160705-00042#11 160714 by sakura mark
      WHEN g_program MATCHES 'apmt522'   #160705-00042#11 160714 by sakura add
         LET l_pmds.pmds000 = '2'  #2.無採購收貨單 apmt522 
      #WHEN 'apmt532'                    #160705-00042#11 160714 by sakura mark
      WHEN g_program MATCHES 'apmt532'   #160705-00042#11 160714 by sakura addf
         LET l_pmds.pmds000 = '4'  #4.無採購收貨入庫單 apmt532
    END CASE
    LET l_pmds.pmdsdocdt = g_pmds_m.pmdsdocdt
    LET l_pmds.pmds001   = g_today
    LET l_pmds.pmds002   = g_pmds_m.pmds002
    LET l_pmds.pmds003   = g_pmds_m.pmds003
    LET l_pmds.pmds006   = g_apgldocno
    LET l_pmds.pmds007   = l_apgl.apgl002
    LET l_pmds.pmds008   = l_apgl.apgl002
    LET l_pmds.pmds009   = l_apgl.apgl002
    LET l_pmds.pmds010   = ''
    LET l_pmds.pmds011   = '1'
    LET l_pmds.pmds012   = ''
    LET l_pmds.pmds013   = ''
    LET l_pmds.pmds014   = '1'
    LET l_pmds.pmds021   = 'Y'
    LET l_pmds.pmds022   = l_pmdl.pmdldocdt
    #LET l_pmds.pmds023   = l_pmdl.pmdl023   #160824-00049#3  mark
    LET l_pmds.pmds023   =  l_apgl.apgl022     #160824-00049#3
    LET l_pmds.pmds024   = g_apgldocno
    LET l_pmds.pmds028   = ''
    IF g_count > 0 THEN
       LET l_pmds.pmds031   = l_pmdl.pmdl009 #付款條件
       LET l_pmds.pmds032   = l_pmdl.pmdl010 #交易條件
       LET l_pmds.pmds033   = l_pmdl.pmdl011 #稅別
       LET l_pmds.pmds034   = l_pmdl.pmdl012 #稅率 
       LET l_pmds.pmds035   = l_pmdl.pmdl013 #單價含稅否     
       LET l_pmds.pmds039   = l_pmdl.pmdl017 
       LET l_pmds.pmds040   = l_pmdl.pmdl018
       LET l_pmds.pmds048   = l_pmdl.pmdl054
    ELSE
       SELECT pmab037,pmab053,pmab034,pmab054,
              pmab057,pmab038 
        INTO l_pmds.pmds031,l_pmds.pmds032,l_pmds.pmds033,l_pmds.pmds039,
             l_pmds.pmds048,l_pmds.pmds012 
        FROM pmab_t 
       WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = l_pmds.pmds007
       CALL s_tax_chk(l_pmds.pmdssite,l_pmds.pmds033)
              RETURNING g_sub_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011       
       IF g_sub_success THEN
          LET l_pmds.pmds034 = l_oodb006
          LET l_pmds.pmds035 = l_oodb005
       END IF     
    END IF
    LET l_pmds.pmds036   = '1'           #交易類型
    LET l_pmds.pmds037 = l_apgl.apgl100
    LET l_pmds.pmds038 = l_apgl.apgl101
    LET l_pmds.pmds041 = ''
    LET l_pmds.pmds042 = ''
    LET l_pmds.pmds043 = '0'
    LET l_pmds.pmds044 = '0'
    LET l_pmds.pmds045 = ''
    LET l_pmds.pmds046 = '0'
    LET l_pmds.pmds047 = ''
    LET l_pmds.pmds049 = '2'
    LET l_pmds.pmds050 = ''
    LET l_pmds.pmds051 = ''
    LET l_pmds.pmds052 = ''
    LET l_pmds.pmds053 = ''
    LET l_pmds.pmds054 = '1'
    LET l_pmds.pmds055 = '1'
    LET l_pmds.pmds201 = ''
    LET l_pmds.pmds202 = ''
    
   #INSERT INTO pmds_t VALUES (l_pmds.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO pmds_t (pmdsent,pmdssite,pmdsdocno,pmdsdocdt,pmds000,
                       pmds001,pmds002,pmds003,pmds006,pmds007,
                       pmds008,pmds009,pmds010,pmds011,pmds012,
                       pmds013,pmds014,pmds021,pmds022,pmds023,
                       pmds024,pmds028,pmds031,pmds032,pmds033,
                       pmds034,pmds035,pmds036,pmds037,pmds038,
                       pmds039,pmds040,pmds041,pmds042,pmds043,
                       pmds044,pmds045,pmds046,pmds047,pmds048,
                       pmds049,pmds050,pmds051,pmds052,pmds053,
                       pmds081,pmds100,pmds101,pmds102,
                       pmdsownid,pmdsowndp,pmdscrtid,pmdscrtdp,pmdscrtdt,
                       pmdsmodid,pmdsmoddt,pmdscnfid,pmdscnfdt,pmdspstid,
                       pmdspstdt,pmdsstus,
                       pmdsud001,pmdsud002,pmdsud003,pmdsud004,pmdsud005,
                       pmdsud006,pmdsud007,pmdsud008,pmdsud009,pmdsud010,
                       pmdsud011,pmdsud012,pmdsud013,pmdsud014,pmdsud015,
                       pmdsud016,pmdsud017,pmdsud018,pmdsud019,pmdsud020,
                       pmdsud021,pmdsud022,pmdsud023,pmdsud024,pmdsud025,
                       pmdsud026,pmdsud027,pmdsud028,pmdsud029,pmdsud030,
                       pmds200,pmds054,pmds055,pmds201,pmds202,
                       pmdsunit,pmds056,pmds057,pmds058,pmds103
                      )
   VALUES (l_pmds.pmdsent,l_pmds.pmdssite,l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds000,
           l_pmds.pmds001,l_pmds.pmds002,l_pmds.pmds003,l_pmds.pmds006,l_pmds.pmds007,
           l_pmds.pmds008,l_pmds.pmds009,l_pmds.pmds010,l_pmds.pmds011,l_pmds.pmds012,
           l_pmds.pmds013,l_pmds.pmds014,l_pmds.pmds021,l_pmds.pmds022,l_pmds.pmds023,
           l_pmds.pmds024,l_pmds.pmds028,l_pmds.pmds031,l_pmds.pmds032,l_pmds.pmds033,
           l_pmds.pmds034,l_pmds.pmds035,l_pmds.pmds036,l_pmds.pmds037,l_pmds.pmds038,
           l_pmds.pmds039,l_pmds.pmds040,l_pmds.pmds041,l_pmds.pmds042,l_pmds.pmds043,
           l_pmds.pmds044,l_pmds.pmds045,l_pmds.pmds046,l_pmds.pmds047,l_pmds.pmds048,
           l_pmds.pmds049,l_pmds.pmds050,l_pmds.pmds051,l_pmds.pmds052,l_pmds.pmds053,
           l_pmds.pmds081,l_pmds.pmds100,l_pmds.pmds101,l_pmds.pmds102,
           l_pmds.pmdsownid,l_pmds.pmdsowndp,l_pmds.pmdscrtid,l_pmds.pmdscrtdp,l_pmds.pmdscrtdt,
           l_pmds.pmdsmodid,l_pmds.pmdsmoddt,l_pmds.pmdscnfid,l_pmds.pmdscnfdt,l_pmds.pmdspstid,
           l_pmds.pmdspstdt,l_pmds.pmdsstus,
           l_pmds.pmdsud001,l_pmds.pmdsud002,l_pmds.pmdsud003,l_pmds.pmdsud004,l_pmds.pmdsud005,
           l_pmds.pmdsud006,l_pmds.pmdsud007,l_pmds.pmdsud008,l_pmds.pmdsud009,l_pmds.pmdsud010,
           l_pmds.pmdsud011,l_pmds.pmdsud012,l_pmds.pmdsud013,l_pmds.pmdsud014,l_pmds.pmdsud015,
           l_pmds.pmdsud016,l_pmds.pmdsud017,l_pmds.pmdsud018,l_pmds.pmdsud019,l_pmds.pmdsud020,
           l_pmds.pmdsud021,l_pmds.pmdsud022,l_pmds.pmdsud023,l_pmds.pmdsud024,l_pmds.pmdsud025,
           l_pmds.pmdsud026,l_pmds.pmdsud027,l_pmds.pmdsud028,l_pmds.pmdsud029,l_pmds.pmdsud030,
           l_pmds.pmds200,l_pmds.pmds054,l_pmds.pmds055,l_pmds.pmds201,l_pmds.pmds202,
           l_pmds.pmdsunit,l_pmds.pmds056,l_pmds.pmds057,l_pmds.pmds058,l_pmds.pmds103
          )
   #161108-00017#4 add end---
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = "pmds_t"
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success,r_docno
    END IF
    
    CALL aapt550_01_gen_pmdt(l_pmds.pmdsdocno) RETURNING r_success
    IF NOT r_success THEN
       LET l_pmds.pmdsdocno = ''
       RETURN r_success,l_pmds.pmdsdocno
    END IF        
    RETURN r_success,l_pmds.pmdsdocno
   



END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aapt550_01_gen_pmdt(p_docno)
# Date & Author..: 2016/03/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt550_01_gen_pmdt(p_pmdsdocno)
DEFINE p_pmdsdocno           LIKE pmds_t.pmdsdocno
#DEFINE l_apgm         RECORD LIKE apgm_t.* #161104-00024#4 mark
#DEFINE l_pmdn         RECORD LIKE pmdn_t.* #161104-00024#4 mark
#DEFINE l_pmdt         RECORD LIKE pmdt_t.* #161104-00024#4 mark
#DEFINE l_pmds         RECORD LIKE pmds_t.* #161104-00024#4 mark
#161104-00024#4-add(s)
DEFINE l_apgm  RECORD  #到貨明細檔
       apgment   LIKE apgm_t.apgment, #企業編號
       apgmcomp  LIKE apgm_t.apgmcomp, #法人
       apgmdocno LIKE apgm_t.apgmdocno, #到貨單號
       apgmseq   LIKE apgm_t.apgmseq, #項次
       apgmseq2  LIKE apgm_t.apgmseq2, #申請單項次
       apgmorga  LIKE apgm_t.apgmorga, #來源組織
       apgm001   LIKE apgm_t.apgm001, #採購單號
       apgm002   LIKE apgm_t.apgm002, #採購單號項次
       apgm003   LIKE apgm_t.apgm003, #產品編號
       apgm004   LIKE apgm_t.apgm004, #到貨數量
       apgm005   LIKE apgm_t.apgm005, #原幣含稅單價
       apgm006   LIKE apgm_t.apgm006, #稅別
       apgm105   LIKE apgm_t.apgm105, #原幣含稅金額
       apgmud001 LIKE apgm_t.apgmud001, #自定義欄位(文字)001
       apgmud002 LIKE apgm_t.apgmud002, #自定義欄位(文字)002
       apgmud003 LIKE apgm_t.apgmud003, #自定義欄位(文字)003
       apgmud004 LIKE apgm_t.apgmud004, #自定義欄位(文字)004
       apgmud005 LIKE apgm_t.apgmud005, #自定義欄位(文字)005
       apgmud006 LIKE apgm_t.apgmud006, #自定義欄位(文字)006
       apgmud007 LIKE apgm_t.apgmud007, #自定義欄位(文字)007
       apgmud008 LIKE apgm_t.apgmud008, #自定義欄位(文字)008
       apgmud009 LIKE apgm_t.apgmud009, #自定義欄位(文字)009
       apgmud010 LIKE apgm_t.apgmud010, #自定義欄位(文字)010
       apgmud011 LIKE apgm_t.apgmud011, #自定義欄位(數字)011
       apgmud012 LIKE apgm_t.apgmud012, #自定義欄位(數字)012
       apgmud013 LIKE apgm_t.apgmud013, #自定義欄位(數字)013
       apgmud014 LIKE apgm_t.apgmud014, #自定義欄位(數字)014
       apgmud015 LIKE apgm_t.apgmud015, #自定義欄位(數字)015
       apgmud016 LIKE apgm_t.apgmud016, #自定義欄位(數字)016
       apgmud017 LIKE apgm_t.apgmud017, #自定義欄位(數字)017
       apgmud018 LIKE apgm_t.apgmud018, #自定義欄位(數字)018
       apgmud019 LIKE apgm_t.apgmud019, #自定義欄位(數字)019
       apgmud020 LIKE apgm_t.apgmud020, #自定義欄位(數字)020
       apgmud021 LIKE apgm_t.apgmud021, #自定義欄位(日期時間)021
       apgmud022 LIKE apgm_t.apgmud022, #自定義欄位(日期時間)022
       apgmud023 LIKE apgm_t.apgmud023, #自定義欄位(日期時間)023
       apgmud024 LIKE apgm_t.apgmud024, #自定義欄位(日期時間)024
       apgmud025 LIKE apgm_t.apgmud025, #自定義欄位(日期時間)025
       apgmud026 LIKE apgm_t.apgmud026, #自定義欄位(日期時間)026
       apgmud027 LIKE apgm_t.apgmud027, #自定義欄位(日期時間)027
       apgmud028 LIKE apgm_t.apgmud028, #自定義欄位(日期時間)028
       apgmud029 LIKE apgm_t.apgmud029, #自定義欄位(日期時間)029
       apgmud030 LIKE apgm_t.apgmud030, #自定義欄位(日期時間)030
       apgm100   LIKE apgm_t.apgm100, #幣別
       apgm101   LIKE apgm_t.apgm101, #匯率
       apgm115   LIKE apgm_t.apgm115  #本幣含稅金額
           END RECORD
DEFINE l_pmdn  RECORD  #採購單身明細檔
       pmdnent   LIKE pmdn_t.pmdnent, #企業編號
       pmdnsite  LIKE pmdn_t.pmdnsite, #營運據點
       pmdnunit  LIKE pmdn_t.pmdnunit, #應用組織
       pmdndocno LIKE pmdn_t.pmdndocno, #採購單號
       pmdnseq   LIKE pmdn_t.pmdnseq, #項次
       pmdn001   LIKE pmdn_t.pmdn001, #料件編號
       pmdn002   LIKE pmdn_t.pmdn002, #產品特徵
       pmdn003   LIKE pmdn_t.pmdn003, #包裝容器
       pmdn004   LIKE pmdn_t.pmdn004, #作業編號
       pmdn005   LIKE pmdn_t.pmdn005, #作業序
       pmdn006   LIKE pmdn_t.pmdn006, #採購單位
       pmdn007   LIKE pmdn_t.pmdn007, #採購數量
       pmdn008   LIKE pmdn_t.pmdn008, #參考單位
       pmdn009   LIKE pmdn_t.pmdn009, #參考數量
       pmdn010   LIKE pmdn_t.pmdn010, #計價單位
       pmdn011   LIKE pmdn_t.pmdn011, #計價數量
       pmdn012   LIKE pmdn_t.pmdn012, #出貨日期
       pmdn013   LIKE pmdn_t.pmdn013, #到廠日期
       pmdn014   LIKE pmdn_t.pmdn014, #到庫日期
       pmdn015   LIKE pmdn_t.pmdn015, #單價
       pmdn016   LIKE pmdn_t.pmdn016, #稅別
       pmdn017   LIKE pmdn_t.pmdn017, #稅率
       pmdn019   LIKE pmdn_t.pmdn019, #子件特性
       pmdn020   LIKE pmdn_t.pmdn020, #緊急度
       pmdn021   LIKE pmdn_t.pmdn021, #保稅
       pmdn022   LIKE pmdn_t.pmdn022, #部分交貨
       pmdnorga  LIKE pmdn_t.pmdnorga, #付款據點
       pmdn023   LIKE pmdn_t.pmdn023, #送貨供應商
       pmdn024   LIKE pmdn_t.pmdn024, #多交期
       pmdn025   LIKE pmdn_t.pmdn025, #收貨地址編號
       pmdn026   LIKE pmdn_t.pmdn026, #帳款地址編號
       pmdn027   LIKE pmdn_t.pmdn027, #供應商料號
       pmdn028   LIKE pmdn_t.pmdn028, #收貨庫位
       pmdn029   LIKE pmdn_t.pmdn029, #收貨儲位
       pmdn030   LIKE pmdn_t.pmdn030, #收貨批號
       pmdn031   LIKE pmdn_t.pmdn031, #運輸方式
       pmdn032   LIKE pmdn_t.pmdn032, #取貨模式
       pmdn033   LIKE pmdn_t.pmdn033, #備品率
       pmdn034   LIKE pmdn_t.pmdn034, #no use
       pmdn035   LIKE pmdn_t.pmdn035, #價格核決
       pmdn036   LIKE pmdn_t.pmdn036, #專案編號
       pmdn037   LIKE pmdn_t.pmdn037, #WBS編號
       pmdn038   LIKE pmdn_t.pmdn038, #活動編號
       pmdn039   LIKE pmdn_t.pmdn039, #費用原因
       pmdn040   LIKE pmdn_t.pmdn040, #取價來源
       pmdn041   LIKE pmdn_t.pmdn041, #價格參考單號
       pmdn042   LIKE pmdn_t.pmdn042, #價格參考項次
       pmdn043   LIKE pmdn_t.pmdn043, #取出價格
       pmdn044   LIKE pmdn_t.pmdn044, #價差比
       pmdn045   LIKE pmdn_t.pmdn045, #行狀態
       pmdn046   LIKE pmdn_t.pmdn046, #未稅金額
       pmdn047   LIKE pmdn_t.pmdn047, #含稅金額
       pmdn048   LIKE pmdn_t.pmdn048, #稅額
       pmdn049   LIKE pmdn_t.pmdn049, #理由碼
       pmdn050   LIKE pmdn_t.pmdn050, #備註
       pmdn051   LIKE pmdn_t.pmdn051, #留置/結案理由碼
       pmdn052   LIKE pmdn_t.pmdn052, #檢驗否
       pmdn053   LIKE pmdn_t.pmdn053, #庫存管理特徵
       pmdn200   LIKE pmdn_t.pmdn200, #商品條碼
       pmdn201   LIKE pmdn_t.pmdn201, #包裝單位
       pmdn202   LIKE pmdn_t.pmdn202, #包裝數量
       pmdn203   LIKE pmdn_t.pmdn203, #收貨部門
       pmdn204   LIKE pmdn_t.pmdn204, #No Use
       pmdn205   LIKE pmdn_t.pmdn205, #要貨組織
       pmdn206   LIKE pmdn_t.pmdn206, #庫存量
       pmdn207   LIKE pmdn_t.pmdn207, #採購在途量
       pmdn208   LIKE pmdn_t.pmdn208, #前日銷售量
       pmdn209   LIKE pmdn_t.pmdn209, #上月銷量
       pmdn210   LIKE pmdn_t.pmdn210, #第一週銷量
       pmdn211   LIKE pmdn_t.pmdn211, #第二週銷量
       pmdn212   LIKE pmdn_t.pmdn212, #第三週銷量
       pmdn213   LIKE pmdn_t.pmdn213, #第四週銷量
       pmdn214   LIKE pmdn_t.pmdn214, #採購通路
       pmdn215   LIKE pmdn_t.pmdn215, #通路性質
       pmdn216   LIKE pmdn_t.pmdn216, #經營方式
       pmdn217   LIKE pmdn_t.pmdn217, #結算方式
       pmdn218   LIKE pmdn_t.pmdn218, #合約編號
       pmdn219   LIKE pmdn_t.pmdn219, #協議編號
       pmdn220   LIKE pmdn_t.pmdn220, #採購人員
       pmdn221   LIKE pmdn_t.pmdn221, #採購部門
       pmdn222   LIKE pmdn_t.pmdn222, #採購中心
       pmdn223   LIKE pmdn_t.pmdn223, #配送中心
       pmdn224   LIKE pmdn_t.pmdn224, #採購失效日
       pmdn900   LIKE pmdn_t.pmdn900, #保留欄位str
       pmdn999   LIKE pmdn_t.pmdn999, #保留欄位end
       pmdnud001 LIKE pmdn_t.pmdnud001, #自定義欄位(文字)001
       pmdnud002 LIKE pmdn_t.pmdnud002, #自定義欄位(文字)002
       pmdnud003 LIKE pmdn_t.pmdnud003, #自定義欄位(文字)003
       pmdnud004 LIKE pmdn_t.pmdnud004, #自定義欄位(文字)004
       pmdnud005 LIKE pmdn_t.pmdnud005, #自定義欄位(文字)005
       pmdnud006 LIKE pmdn_t.pmdnud006, #自定義欄位(文字)006
       pmdnud007 LIKE pmdn_t.pmdnud007, #自定義欄位(文字)007
       pmdnud008 LIKE pmdn_t.pmdnud008, #自定義欄位(文字)008
       pmdnud009 LIKE pmdn_t.pmdnud009, #自定義欄位(文字)009
       pmdnud010 LIKE pmdn_t.pmdnud010, #自定義欄位(文字)010
       pmdnud011 LIKE pmdn_t.pmdnud011, #自定義欄位(數字)011
       pmdnud012 LIKE pmdn_t.pmdnud012, #自定義欄位(數字)012
       pmdnud013 LIKE pmdn_t.pmdnud013, #自定義欄位(數字)013
       pmdnud014 LIKE pmdn_t.pmdnud014, #自定義欄位(數字)014
       pmdnud015 LIKE pmdn_t.pmdnud015, #自定義欄位(數字)015
       pmdnud016 LIKE pmdn_t.pmdnud016, #自定義欄位(數字)016
       pmdnud017 LIKE pmdn_t.pmdnud017, #自定義欄位(數字)017
       pmdnud018 LIKE pmdn_t.pmdnud018, #自定義欄位(數字)018
       pmdnud019 LIKE pmdn_t.pmdnud019, #自定義欄位(數字)019
       pmdnud020 LIKE pmdn_t.pmdnud020, #自定義欄位(數字)020
       pmdnud021 LIKE pmdn_t.pmdnud021, #自定義欄位(日期時間)021
       pmdnud022 LIKE pmdn_t.pmdnud022, #自定義欄位(日期時間)022
       pmdnud023 LIKE pmdn_t.pmdnud023, #自定義欄位(日期時間)023
       pmdnud024 LIKE pmdn_t.pmdnud024, #自定義欄位(日期時間)024
       pmdnud025 LIKE pmdn_t.pmdnud025, #自定義欄位(日期時間)025
       pmdnud026 LIKE pmdn_t.pmdnud026, #自定義欄位(日期時間)026
       pmdnud027 LIKE pmdn_t.pmdnud027, #自定義欄位(日期時間)027
       pmdnud028 LIKE pmdn_t.pmdnud028, #自定義欄位(日期時間)028
       pmdnud029 LIKE pmdn_t.pmdnud029, #自定義欄位(日期時間)029
       pmdnud030 LIKE pmdn_t.pmdnud030, #自定義欄位(日期時間)030
       pmdn225   LIKE pmdn_t.pmdn225, #最終收貨組織
       pmdn054   LIKE pmdn_t.pmdn054, #還料數量
       pmdn055   LIKE pmdn_t.pmdn055, #還量參考數量
       pmdn056   LIKE pmdn_t.pmdn056, #還價數量
       pmdn057   LIKE pmdn_t.pmdn057, #還價參考數量
       pmdn226   LIKE pmdn_t.pmdn226, #長效期每次送貨量
       pmdn227   LIKE pmdn_t.pmdn227, #補貨規格說明
       pmdn058   LIKE pmdn_t.pmdn058, #預算科目
       pmdn228   LIKE pmdn_t.pmdn228  #商品品類
           END RECORD
DEFINE l_pmdt  RECORD  #收貨/入庫單身明細檔
       pmdtent   LIKE pmdt_t.pmdtent, #企業編號
       pmdtsite  LIKE pmdt_t.pmdtsite, #營運據點
       pmdtdocno LIKE pmdt_t.pmdtdocno, #單據編號
       pmdtseq   LIKE pmdt_t.pmdtseq, #項次
       pmdt001   LIKE pmdt_t.pmdt001, #採購單號
       pmdt002   LIKE pmdt_t.pmdt002, #採購項次
       pmdt003   LIKE pmdt_t.pmdt003, #採購項序
       pmdt004   LIKE pmdt_t.pmdt004, #採購分批序
       pmdt005   LIKE pmdt_t.pmdt005, #子件特性
       pmdt006   LIKE pmdt_t.pmdt006, #料件編號
       pmdt007   LIKE pmdt_t.pmdt007, #產品特徵
       pmdt008   LIKE pmdt_t.pmdt008, #包裝容器
       pmdt009   LIKE pmdt_t.pmdt009, #作業編號
       pmdt010   LIKE pmdt_t.pmdt010, #作業序
       pmdt011   LIKE pmdt_t.pmdt011, #沖銷順序
       pmdt016   LIKE pmdt_t.pmdt016, #庫位
       pmdt017   LIKE pmdt_t.pmdt017, #儲位
       pmdt018   LIKE pmdt_t.pmdt018, #批號
       pmdt019   LIKE pmdt_t.pmdt019, #收貨/入庫單位
       pmdt020   LIKE pmdt_t.pmdt020, #收貨/入庫數量
       pmdt021   LIKE pmdt_t.pmdt021, #參考單位
       pmdt022   LIKE pmdt_t.pmdt022, #參考數量
       pmdt023   LIKE pmdt_t.pmdt023, #計價單位
       pmdt024   LIKE pmdt_t.pmdt024, #計價數量
       pmdt025   LIKE pmdt_t.pmdt025, #緊急度
       pmdt026   LIKE pmdt_t.pmdt026, #檢驗否
       pmdt027   LIKE pmdt_t.pmdt027, #收貨單號
       pmdt028   LIKE pmdt_t.pmdt028, #收貨項次
       pmdt036   LIKE pmdt_t.pmdt036, #單價
       pmdt037   LIKE pmdt_t.pmdt037, #稅率
       pmdt038   LIKE pmdt_t.pmdt038, #未稅金額
       pmdt039   LIKE pmdt_t.pmdt039, #含稅金額
       pmdt040   LIKE pmdt_t.pmdt040, #價格核決
       pmdt041   LIKE pmdt_t.pmdt041, #保稅否
       pmdt042   LIKE pmdt_t.pmdt042, #取價來源
       pmdt043   LIKE pmdt_t.pmdt043, #價格參考單號
       pmdt044   LIKE pmdt_t.pmdt044, #取出單價
       pmdt045   LIKE pmdt_t.pmdt045, #價差比
       pmdt046   LIKE pmdt_t.pmdt046, #稅別
       pmdt047   LIKE pmdt_t.pmdt047, #稅額
       pmdt051   LIKE pmdt_t.pmdt051, #理由碼
       pmdt052   LIKE pmdt_t.pmdt052, #狀態碼
       pmdt053   LIKE pmdt_t.pmdt053, #允收數量
       pmdt054   LIKE pmdt_t.pmdt054, #已入庫量
       pmdt055   LIKE pmdt_t.pmdt055, #驗退量
       pmdt056   LIKE pmdt_t.pmdt056, #主帳套已請款數量
       pmdt057   LIKE pmdt_t.pmdt057, #帳套二已請款數量
       pmdt058   LIKE pmdt_t.pmdt058, #帳套三已請款數量
       pmdt059   LIKE pmdt_t.pmdt059, #備註
       pmdt060   LIKE pmdt_t.pmdt060, #供應商批號
       pmdt061   LIKE pmdt_t.pmdt061, #供應商送貨數量
       pmdt062   LIKE pmdt_t.pmdt062, #多庫儲批收貨入庫
       pmdt063   LIKE pmdt_t.pmdt063, #庫存管理特徵
       pmdt064   LIKE pmdt_t.pmdt064, #出貨單號
       pmdt065   LIKE pmdt_t.pmdt065, #出貨單項次
       pmdt066   LIKE pmdt_t.pmdt066, #主帳套暫估數量
       pmdt067   LIKE pmdt_t.pmdt067, #帳套二暫估數量
       pmdt068   LIKE pmdt_t.pmdt068, #帳套三暫估數量
       pmdt069   LIKE pmdt_t.pmdt069, #已開發票數量
       pmdt081   LIKE pmdt_t.pmdt081, #QC單號
       pmdt082   LIKE pmdt_t.pmdt082, #QC判定項次
       pmdt083   LIKE pmdt_t.pmdt083, #判定結果
       pmdt084   LIKE pmdt_t.pmdt084, #須自立AP否
       pmdt085   LIKE pmdt_t.pmdt085, #多角流程編號
       pmdt086   LIKE pmdt_t.pmdt086, #採購多角性質
       pmdt087   LIKE pmdt_t.pmdt087, #採購單開立據點
       pmdt088   LIKE pmdt_t.pmdt088, #存貨備註
       pmdt089   LIKE pmdt_t.pmdt089, #有效日期
       pmdt900   LIKE pmdt_t.pmdt900, #保留欄位str
       pmdt999   LIKE pmdt_t.pmdt999, #保留欄位end
       pmdtud001 LIKE pmdt_t.pmdtud001, #自定義欄位(文字)001
       pmdtud002 LIKE pmdt_t.pmdtud002, #自定義欄位(文字)002
       pmdtud003 LIKE pmdt_t.pmdtud003, #自定義欄位(文字)003
       pmdtud004 LIKE pmdt_t.pmdtud004, #自定義欄位(文字)004
       pmdtud005 LIKE pmdt_t.pmdtud005, #自定義欄位(文字)005
       pmdtud006 LIKE pmdt_t.pmdtud006, #自定義欄位(文字)006
       pmdtud007 LIKE pmdt_t.pmdtud007, #自定義欄位(文字)007
       pmdtud008 LIKE pmdt_t.pmdtud008, #自定義欄位(文字)008
       pmdtud009 LIKE pmdt_t.pmdtud009, #自定義欄位(文字)009
       pmdtud010 LIKE pmdt_t.pmdtud010, #自定義欄位(文字)010
       pmdtud011 LIKE pmdt_t.pmdtud011, #自定義欄位(數字)011
       pmdtud012 LIKE pmdt_t.pmdtud012, #自定義欄位(數字)012
       pmdtud013 LIKE pmdt_t.pmdtud013, #自定義欄位(數字)013
       pmdtud014 LIKE pmdt_t.pmdtud014, #自定義欄位(數字)014
       pmdtud015 LIKE pmdt_t.pmdtud015, #自定義欄位(數字)015
       pmdtud016 LIKE pmdt_t.pmdtud016, #自定義欄位(數字)016
       pmdtud017 LIKE pmdt_t.pmdtud017, #自定義欄位(數字)017
       pmdtud018 LIKE pmdt_t.pmdtud018, #自定義欄位(數字)018
       pmdtud019 LIKE pmdt_t.pmdtud019, #自定義欄位(數字)019
       pmdtud020 LIKE pmdt_t.pmdtud020, #自定義欄位(數字)020
       pmdtud021 LIKE pmdt_t.pmdtud021, #自定義欄位(日期時間)021
       pmdtud022 LIKE pmdt_t.pmdtud022, #自定義欄位(日期時間)022
       pmdtud023 LIKE pmdt_t.pmdtud023, #自定義欄位(日期時間)023
       pmdtud024 LIKE pmdt_t.pmdtud024, #自定義欄位(日期時間)024
       pmdtud025 LIKE pmdt_t.pmdtud025, #自定義欄位(日期時間)025
       pmdtud026 LIKE pmdt_t.pmdtud026, #自定義欄位(日期時間)026
       pmdtud027 LIKE pmdt_t.pmdtud027, #自定義欄位(日期時間)027
       pmdtud028 LIKE pmdt_t.pmdtud028, #自定義欄位(日期時間)028
       pmdtud029 LIKE pmdt_t.pmdtud029, #自定義欄位(日期時間)029
       pmdtud030 LIKE pmdt_t.pmdtud030, #自定義欄位(日期時間)030
       pmdt200   LIKE pmdt_t.pmdt200, #商品條碼
       pmdt201   LIKE pmdt_t.pmdt201, #收貨包裝單位
       pmdt202   LIKE pmdt_t.pmdt202, #收貨包裝數量
       pmdt203   LIKE pmdt_t.pmdt203, #採購組織
       pmdt204   LIKE pmdt_t.pmdt204, #採購中心
       pmdt205   LIKE pmdt_t.pmdt205, #要貨組織
       pmdt206   LIKE pmdt_t.pmdt206, #預約收貨單號
       pmdt207   LIKE pmdt_t.pmdt207, #預約收貨項次
       pmdt208   LIKE pmdt_t.pmdt208, #採購通路
       pmdt209   LIKE pmdt_t.pmdt209, #通路性質
       pmdt210   LIKE pmdt_t.pmdt210, #經營方式
       pmdt211   LIKE pmdt_t.pmdt211, #結算方式
       pmdt212   LIKE pmdt_t.pmdt212, #合約編號
       pmdt213   LIKE pmdt_t.pmdt213, #協議編號
       pmdtorga  LIKE pmdt_t.pmdtorga, #帳務組織
       pmdt070   LIKE pmdt_t.pmdt070, #參考單號
       pmdt071   LIKE pmdt_t.pmdt071, #參考項次
       pmdt214   LIKE pmdt_t.pmdt214, #採購方式
       pmdt215   LIKE pmdt_t.pmdt215, #最終收貨組織
       pmdt048   LIKE pmdt_t.pmdt048, #價格參考項次
       pmdt216   LIKE pmdt_t.pmdt216, #退貨申請單號
       pmdt217   LIKE pmdt_t.pmdt217, #退貨申請項次
       pmdt090   LIKE pmdt_t.pmdt090, #借貨還價數量
       pmdt091   LIKE pmdt_t.pmdt091, #借貨還價參考數量
       pmdt092   LIKE pmdt_t.pmdt092, #還價未稅金額
       pmdt093   LIKE pmdt_t.pmdt093, #還價含稅金額
       pmdt218   LIKE pmdt_t.pmdt218, #採購價
       pmdt219   LIKE pmdt_t.pmdt219, #製造日期
       pmdt072   LIKE pmdt_t.pmdt072, #專案編號
       pmdt073   LIKE pmdt_t.pmdt073, #WBS
       pmdt074   LIKE pmdt_t.pmdt074, #活動編號
       pmdt227   LIKE pmdt_t.pmdt227, #補貨規格說明
       pmdt049   LIKE pmdt_t.pmdt049, #發票編號
       pmdt050   LIKE pmdt_t.pmdt050, #發票號碼
       pmdt075   LIKE pmdt_t.pmdt075, #預算細項
       pmdt220   LIKE pmdt_t.pmdt220, #商品品類
       pmdt221   LIKE pmdt_t.pmdt221  #來源單據商品品類
           END RECORD
DEFINE l_pmds  RECORD  #收貨/入庫單頭檔
       pmdsent   LIKE pmds_t.pmdsent, #企業編號
       pmdssite  LIKE pmds_t.pmdssite, #營運據點
       pmdsdocno LIKE pmds_t.pmdsdocno, #單據單號
       pmdsdocdt LIKE pmds_t.pmdsdocdt, #單據日期
       pmds000   LIKE pmds_t.pmds000, #單據性質
       pmds001   LIKE pmds_t.pmds001, #扣帳日期
       pmds002   LIKE pmds_t.pmds002, #申請人員
       pmds003   LIKE pmds_t.pmds003, #申請部門
       pmds006   LIKE pmds_t.pmds006, #來源單號
       pmds007   LIKE pmds_t.pmds007, #採購供應商
       pmds008   LIKE pmds_t.pmds008, #帳款供應商
       pmds009   LIKE pmds_t.pmds009, #送貨供應商
       pmds010   LIKE pmds_t.pmds010, #供應商送貨單號
       pmds011   LIKE pmds_t.pmds011, #採購性質
       pmds012   LIKE pmds_t.pmds012, #採購通路
       pmds013   LIKE pmds_t.pmds013, #採購分類
       pmds014   LIKE pmds_t.pmds014, #多角性質
       pmds021   LIKE pmds_t.pmds021, #LC進口
       pmds022   LIKE pmds_t.pmds022, #進口日期
       pmds023   LIKE pmds_t.pmds023, #進口報單
       pmds024   LIKE pmds_t.pmds024, #進口號碼
       pmds028   LIKE pmds_t.pmds028, #一次性交易對象識別碼
       pmds031   LIKE pmds_t.pmds031, #付款條件
       pmds032   LIKE pmds_t.pmds032, #交易條件
       pmds033   LIKE pmds_t.pmds033, #稅別
       pmds034   LIKE pmds_t.pmds034, #稅率
       pmds035   LIKE pmds_t.pmds035, #單價含稅否
       pmds036   LIKE pmds_t.pmds036, #交易類型
       pmds037   LIKE pmds_t.pmds037, #幣別
       pmds038   LIKE pmds_t.pmds038, #匯率
       pmds039   LIKE pmds_t.pmds039, #取價方式
       pmds040   LIKE pmds_t.pmds040, #付款優惠條件
       pmds041   LIKE pmds_t.pmds041, #多角序號
       pmds042   LIKE pmds_t.pmds042, #整合單號
       pmds043   LIKE pmds_t.pmds043, #採購總未稅金額
       pmds044   LIKE pmds_t.pmds044, #採購總含稅金額
       pmds045   LIKE pmds_t.pmds045, #備註
       pmds046   LIKE pmds_t.pmds046, #採購總稅額
       pmds047   LIKE pmds_t.pmds047, #多角貿易中斷點
       pmds048   LIKE pmds_t.pmds048, #內外購
       pmds049   LIKE pmds_t.pmds049, #匯率計算基準
       pmds050   LIKE pmds_t.pmds050, #多角貿易已拋轉
       pmds051   LIKE pmds_t.pmds051, #出貨單號
       pmds052   LIKE pmds_t.pmds052, #供應商出貨日
       pmds053   LIKE pmds_t.pmds053, #多角流程編號
       pmds081   LIKE pmds_t.pmds081, #取回日期
       pmds100   LIKE pmds_t.pmds100, #倉退方式
       pmds101   LIKE pmds_t.pmds101, #折讓日期
       pmds102   LIKE pmds_t.pmds102, #折讓原始發票
       pmdsownid LIKE pmds_t.pmdsownid, #資料所屬者
       pmdsowndp LIKE pmds_t.pmdsowndp, #資料所有部門
       pmdscrtid LIKE pmds_t.pmdscrtid, #資料建立者
       pmdscrtdp LIKE pmds_t.pmdscrtdp, #資料建立部門
       pmdscrtdt LIKE pmds_t.pmdscrtdt, #資料創建日
       pmdsmodid LIKE pmds_t.pmdsmodid, #資料修改者
       pmdsmoddt LIKE pmds_t.pmdsmoddt, #最近修改日
       pmdscnfid LIKE pmds_t.pmdscnfid, #資料確認者
       pmdscnfdt LIKE pmds_t.pmdscnfdt, #資料確認日
       pmdspstid LIKE pmds_t.pmdspstid, #資料過帳者
       pmdspstdt LIKE pmds_t.pmdspstdt, #資料過帳日
       pmdsstus  LIKE pmds_t.pmdsstus, #狀態碼
       pmdsud001 LIKE pmds_t.pmdsud001, #自定義欄位(文字)001
       pmdsud002 LIKE pmds_t.pmdsud002, #自定義欄位(文字)002
       pmdsud003 LIKE pmds_t.pmdsud003, #自定義欄位(文字)003
       pmdsud004 LIKE pmds_t.pmdsud004, #自定義欄位(文字)004
       pmdsud005 LIKE pmds_t.pmdsud005, #自定義欄位(文字)005
       pmdsud006 LIKE pmds_t.pmdsud006, #自定義欄位(文字)006
       pmdsud007 LIKE pmds_t.pmdsud007, #自定義欄位(文字)007
       pmdsud008 LIKE pmds_t.pmdsud008, #自定義欄位(文字)008
       pmdsud009 LIKE pmds_t.pmdsud009, #自定義欄位(文字)009
       pmdsud010 LIKE pmds_t.pmdsud010, #自定義欄位(文字)010
       pmdsud011 LIKE pmds_t.pmdsud011, #自定義欄位(數字)011
       pmdsud012 LIKE pmds_t.pmdsud012, #自定義欄位(數字)012
       pmdsud013 LIKE pmds_t.pmdsud013, #自定義欄位(數字)013
       pmdsud014 LIKE pmds_t.pmdsud014, #自定義欄位(數字)014
       pmdsud015 LIKE pmds_t.pmdsud015, #自定義欄位(數字)015
       pmdsud016 LIKE pmds_t.pmdsud016, #自定義欄位(數字)016
       pmdsud017 LIKE pmds_t.pmdsud017, #自定義欄位(數字)017
       pmdsud018 LIKE pmds_t.pmdsud018, #自定義欄位(數字)018
       pmdsud019 LIKE pmds_t.pmdsud019, #自定義欄位(數字)019
       pmdsud020 LIKE pmds_t.pmdsud020, #自定義欄位(數字)020
       pmdsud021 LIKE pmds_t.pmdsud021, #自定義欄位(日期時間)021
       pmdsud022 LIKE pmds_t.pmdsud022, #自定義欄位(日期時間)022
       pmdsud023 LIKE pmds_t.pmdsud023, #自定義欄位(日期時間)023
       pmdsud024 LIKE pmds_t.pmdsud024, #自定義欄位(日期時間)024
       pmdsud025 LIKE pmds_t.pmdsud025, #自定義欄位(日期時間)025
       pmdsud026 LIKE pmds_t.pmdsud026, #自定義欄位(日期時間)026
       pmdsud027 LIKE pmds_t.pmdsud027, #自定義欄位(日期時間)027
       pmdsud028 LIKE pmds_t.pmdsud028, #自定義欄位(日期時間)028
       pmdsud029 LIKE pmds_t.pmdsud029, #自定義欄位(日期時間)029
       pmdsud030 LIKE pmds_t.pmdsud030, #自定義欄位(日期時間)030
       pmds200   LIKE pmds_t.pmds200, #收貨預約單號
       pmds054   LIKE pmds_t.pmds054, #資料來源
       pmds055   LIKE pmds_t.pmds055, #來源單號
       pmds201   LIKE pmds_t.pmds201, #來源單號
       pmds202   LIKE pmds_t.pmds202, #來源類型
       pmdsunit  LIKE pmds_t.pmdsunit, #應用執行組織物件
       pmds056   LIKE pmds_t.pmds056, #No use
       pmds057   LIKE pmds_t.pmds057, #整合來源
       pmds058   LIKE pmds_t.pmds058, #倒扣領料單號
       pmds103   LIKE pmds_t.pmds103  #折讓證明單開立方式
           END RECORD
#161104-00024#4-add(e)
DEFINE l_pmdt019      LIKE type_t.chr10
DEFINE l_sql          STRING
DEFINE l_oodb004      LIKE oodb_t.oodb004
DEFINE l_apca013      LIKE apca_t.apca013
DEFINE l_oodb011      LIKE oodb_t.oodb011
DEFINE r_success      LIKE type_t.num5
DEFINE l_apgl004      LIKE apgl_t.apgl004

   WHENEVER ERROR CONTINUE

   #SELECT * INTO l_pmds.* FROM pmds_t WHERE pmdsdocno = p_pmdsdocno AND pmdsent = g_enterprise   #161208-00026#12 mark
   #161208-00026#12-add(s)
   SELECT pmdsent,pmdssite,pmdsdocno,pmdsdocdt,pmds000,
          pmds001,pmds002,pmds003,pmds006,pmds007,
          pmds008,pmds009,pmds010,pmds011,pmds012,
          pmds013,pmds014,pmds021,pmds022,pmds023,
          pmds024,pmds028,pmds031,pmds032,pmds033,
          pmds034,pmds035,pmds036,pmds037,pmds038,
          pmds039,pmds040,pmds041,pmds042,pmds043,
          pmds044,pmds045,pmds046,pmds047,pmds048,
          pmds049,pmds050,pmds051,pmds052,pmds053,
          pmds081,pmds100,pmds101,pmds102,pmdsownid,
          pmdsowndp,pmdscrtid,pmdscrtdp,pmdscrtdt,pmdsmodid,
          pmdsmoddt,pmdscnfid,pmdscnfdt,pmdspstid,pmdspstdt,
          pmdsstus,pmdsud001,pmdsud002,pmdsud003,pmdsud004,
          pmdsud005,pmdsud006,pmdsud007,pmdsud008,pmdsud009,
          pmdsud010,pmdsud011,pmdsud012,pmdsud013,pmdsud014,
          pmdsud015,pmdsud016,pmdsud017,pmdsud018,pmdsud019,
          pmdsud020,pmdsud021,pmdsud022,pmdsud023,pmdsud024,
          pmdsud025,pmdsud026,pmdsud027,pmdsud028,pmdsud029,
          pmdsud030,pmds200,pmds054,pmds055,pmds201,
          pmds202,pmdsunit,pmds056,pmds057,pmds058,
          pmds103 
     INTO l_pmds.* 
     FROM pmds_t 
    WHERE pmdsdocno = p_pmdsdocno 
      AND pmdsent = g_enterprise
   #161208-00026#12-add(e)
   SELECT apgl004 INTO l_apgl004 FROM apgl_t WHERE apglent = g_enterprise AND apgldocno = g_apgldocno
 
   LET r_success = TRUE   
   #LET l_sql = "  SELECT * FROM apgm_t WHERE apgment = '",g_enterprise,"'   ",   #161208-00026#12 mark
   #161208-00026#12-add(s)
   LET l_sql = "  SELECT apgment,apgmcomp,apgmdocno,apgmseq,apgmseq2,
                         apgmorga,apgm001,apgm002,apgm003,apgm004,
                         apgm005,apgm006,apgm105,apgmud001,apgmud002,
                         apgmud003,apgmud004,apgmud005,apgmud006,apgmud007,
                         apgmud008,apgmud009,apgmud010,apgmud011,apgmud012,
                         apgmud013,apgmud014,apgmud015,apgmud016,apgmud017,
                         apgmud018,apgmud019,apgmud020,apgmud021,apgmud022,
                         apgmud023,apgmud024,apgmud025,apgmud026,apgmud027,
                         apgmud028,apgmud029,apgmud030,apgm100,apgm101,
                         apgm115 
                    FROM apgm_t WHERE apgment = '",g_enterprise,"'   ",
   #161208-00026#12-add(e)
               "    AND apgmdocno = '",g_apgldocno,"' AND apgmcomp = '",g_apglcomp,"'  "
   PREPARE aapt550_01_prep01 FROM l_sql
   DECLARE aapt550_01_curs01 CURSOR FOR aapt550_01_prep01
   #FOREACH aapt550_01_curs01 INTO l_apgm.*    #161208-00026#12 mark
   #161208-00026#12-add(s)
   FOREACH aapt550_01_curs01 INTO l_apgm.apgment,l_apgm.apgmcomp,l_apgm.apgmdocno,l_apgm.apgmseq,l_apgm.apgmseq2,
                                  l_apgm.apgmorga,l_apgm.apgm001,l_apgm.apgm002,l_apgm.apgm003,l_apgm.apgm004,
                                  l_apgm.apgm005,l_apgm.apgm006,l_apgm.apgm105,l_apgm.apgmud001,l_apgm.apgmud002,
                                  l_apgm.apgmud003,l_apgm.apgmud004,l_apgm.apgmud005,l_apgm.apgmud006,l_apgm.apgmud007,
                                  l_apgm.apgmud008,l_apgm.apgmud009,l_apgm.apgmud010,l_apgm.apgmud011,l_apgm.apgmud012,
                                  l_apgm.apgmud013,l_apgm.apgmud014,l_apgm.apgmud015,l_apgm.apgmud016,l_apgm.apgmud017,
                                  l_apgm.apgmud018,l_apgm.apgmud019,l_apgm.apgmud020,l_apgm.apgmud021,l_apgm.apgmud022,
                                  l_apgm.apgmud023,l_apgm.apgmud024,l_apgm.apgmud025,l_apgm.apgmud026,l_apgm.apgmud027,
                                  l_apgm.apgmud028,l_apgm.apgmud029,l_apgm.apgmud030,l_apgm.apgm100,l_apgm.apgm101,
                                  l_apgm.apgm115 
   #161208-00026#12-add(e)
      INITIALIZE l_pmdt.* TO NULL
      INITIALIZE l_pmdn.* TO NULL
      IF g_count > 0 THEN
         #SELECT * INTO l_pmdn.* FROM pmdn_t   #161208-00026#12 mark
         #161208-00026#12-add(s)
         SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
                pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
                pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
                pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
                pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
                pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
                pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
                pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
                pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
                pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
                pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
                pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
                pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
                pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
                pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
                pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
                pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
                pmdnud001,pmdnud002,pmdnud003,pmdnud004,pmdnud005,
                pmdnud006,pmdnud007,pmdnud008,pmdnud009,pmdnud010,
                pmdnud011,pmdnud012,pmdnud013,pmdnud014,pmdnud015,
                pmdnud016,pmdnud017,pmdnud018,pmdnud019,pmdnud020,
                pmdnud021,pmdnud022,pmdnud023,pmdnud024,pmdnud025,
                pmdnud026,pmdnud027,pmdnud028,pmdnud029,pmdnud030,
                pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
                pmdn226,pmdn227,pmdn058,pmdn228 
           INTO l_pmdn.* 
           FROM pmdn_t
         #161208-00026#12-add(e)
          WHERE pmdndocno = l_apgm.apgm001 AND pmdnseq = l_apgm.apgm002
            AND pmdnent = g_enterprise
      END IF
      LET l_pmdt.pmdtent = g_enterprise
      LET l_pmdt.pmdtdocno = p_pmdsdocno
      LET l_pmdt.pmdtsite  = l_pmds.pmdssite
      LET l_pmdt.pmdtseq = l_apgm.apgmseq
      LET l_pmdt.pmdt001 = l_apgm.apgm001
      LET l_pmdt.pmdt002 = l_apgm.apgm002
      LET l_pmdt.pmdt003 = '1'
      #LET l_pmdt.pmdt004 = ''  #160824-00049#3 mark
      LET l_pmdt.pmdt004 = '1'  #160824-00049#3      
      LET l_pmdt.pmdt005 = '1'
      LET l_pmdt.pmdt006 = l_apgm.apgm003
      LET l_pmdt.pmdt007 = ''
      LET l_pmdt.pmdt008 = ''
      LET l_pmdt.pmdt009 = ''
      LET l_pmdt.pmdt010 = ''
      LET l_pmdt.pmdt011 = ''
      SELECT imaf091,imaf092 INTO l_pmdt.pmdt016,l_pmdt.pmdt017
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = l_pmdt.pmdtsite
         AND imaf001  = l_pmdt.pmdt006
       
      IF l_pmdt.pmdt017 IS NULL THEN
         SELECT imaf092 INTO l_pmdt.pmdt017
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = l_pmdt.pmdtsite
            AND imaf001  = l_pmdt.pmdt006
      END IF
      LET l_pmdt.pmdt020 = l_apgm.apgm004
      LET l_pmdt.pmdt024 = l_apgm.apgm004
      LET l_pmdt.pmdt046 = l_apgm.apgm006
      IF NOT cl_null(l_pmdn.pmdn015) THEN
         LET l_pmdt.pmdt036 = l_pmdn.pmdn015
      ELSE
         LET l_pmdt.pmdt036 = l_apgm.apgm005 
      END IF
      CALL s_tax_chk(g_apglcomp,l_pmdt.pmdt046) 
         RETURNING g_sub_success,l_oodb004,l_apca013,l_pmdt.pmdt037,l_oodb011
      
      #取得未稅金額、稅額、含稅金額
      CALL s_apmt520_get_amount(l_pmdt.pmdtdocno,l_pmdt.pmdtseq,l_pmdt.pmdt001,l_pmdt.pmdt024,l_pmdt.pmdt036,l_pmdt.pmdt046)
         RETURNING l_pmdt.pmdt038,l_pmdt.pmdt047,l_pmdt.pmdt039
      LET l_pmdt.pmdt053 = l_apgm.apgm004
      #IF g_program = 'apmt520' THEN        #160705-00042#11 160714 by sakura mark
      IF g_program MATCHES 'apmt520' THEN   #160705-00042#11 160714 by sakura add
         LET l_pmdt.pmdt052 = 0 
      ELSE
         LET l_pmdt.pmdt052 = l_apgm.apgm004
      END IF
      LET l_pmdt.pmdt055 = 0
      LET l_pmdt.pmdt056 = 0
      LET l_pmdt.pmdt057 = 0
      LET l_pmdt.pmdt058 = 0
      LET l_pmdt.pmdt059 = ''
    
      LET l_pmdt.pmdt066 = 0
      LET l_pmdt.pmdt067 = 0
      LET l_pmdt.pmdt068 = 0
      LET l_pmdt.pmdt069 = 0
      LET l_pmdt.pmdt084 = 'Y'
      SELECT apgb005 INTO l_pmdt019 
        FROM apgb_t WHERE apgbent = g_enterprise AND apgbdocno = l_apgl004 
         AND apgbseq = l_apgm.apgmseq2  AND apgbcomp = g_apglcomp                     
      LET l_pmdt.pmdt022 = l_apgm.apgm004
      LET l_pmdt.pmdt024 = l_apgm.apgm004
      LET l_pmdt.pmdt019 = l_pmdt019
      LET l_pmdt.pmdt021 = l_pmdt019
      LET l_pmdt.pmdt023 = l_pmdt019
      LET l_pmdt.pmdt025 = '1'
      LET l_pmdt.pmdt026 = 'N'
      LET l_pmdt.pmdt041 = 'N'
      LET l_pmdt.pmdt062 = 'N'
      LET l_pmdt.pmdt042 = 'X'
      LET l_pmdt.pmdt044 = 0
      LET l_pmdt.pmdt045 = 0
      LET l_pmdt.pmdt061 = 0
      LET l_pmdt.pmdt900 = 0
      LET l_pmdt.pmdt999 = 0
      LET l_pmdt.pmdt202 = 0
      LET l_pmdt.pmdt207 = 0
      LET l_pmdt.pmdt071 = 0
      LET l_pmdt.pmdt217 = 0
      LET l_pmdt.pmdt090 = 0
      LET l_pmdt.pmdt091 = 0
      LET l_pmdt.pmdt092 = 0
      LET l_pmdt.pmdt093 = 0
      #INSERT INTO pmdt_t VALUES (l_pmdt.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO pmdt_t (pmdtent,pmdtsite,pmdtdocno,pmdtseq,
                          pmdt001,pmdt002,pmdt003,pmdt004,pmdt005,
                          pmdt006,pmdt007,pmdt008,pmdt009,pmdt010,
                          pmdt011,pmdt016,pmdt017,pmdt018,pmdt019,
                          pmdt020,pmdt021,pmdt022,pmdt023,pmdt024,
                          pmdt025,pmdt026,pmdt027,pmdt028,pmdt036,
                          pmdt037,pmdt038,pmdt039,pmdt040,pmdt041,
                          pmdt042,pmdt043,pmdt044,pmdt045,pmdt046,
                          pmdt047,pmdt051,pmdt052,pmdt053,pmdt054,
                          pmdt055,pmdt056,pmdt057,pmdt058,pmdt059,
                          pmdt060,pmdt061,pmdt062,pmdt063,pmdt064,
                          pmdt065,pmdt066,pmdt067,pmdt068,pmdt069,
                          pmdt081,pmdt082,pmdt083,pmdt084,pmdt085,
                          pmdt086,pmdt087,pmdt088,pmdt089,pmdt900,
                          pmdt999,
                          pmdtud001,pmdtud002,pmdtud003,pmdtud004,pmdtud005,
                          pmdtud006,pmdtud007,pmdtud008,pmdtud009,pmdtud010,
                          pmdtud011,pmdtud012,pmdtud013,pmdtud014,pmdtud015,
                          pmdtud016,pmdtud017,pmdtud018,pmdtud019,pmdtud020,
                          pmdtud021,pmdtud022,pmdtud023,pmdtud024,pmdtud025,
                          pmdtud026,pmdtud027,pmdtud028,pmdtud029,pmdtud030,
                          pmdt200,pmdt201,pmdt202,pmdt203,pmdt204,
                          pmdt205,pmdt206,pmdt207,pmdt208,pmdt209,
                          pmdt210,pmdt211,pmdt212,pmdt213,pmdtorga,
                          pmdt070,pmdt071,pmdt214,pmdt215,pmdt048,
                          pmdt216,pmdt217,pmdt090,pmdt091,pmdt092,
                          pmdt093,pmdt218,pmdt219,pmdt072,pmdt073,
                          pmdt074,pmdt227,pmdt049,pmdt050,pmdt075,
                          pmdt220,pmdt221
                         )
      VALUES (l_pmdt.pmdtent,l_pmdt.pmdtsite,l_pmdt.pmdtdocno,l_pmdt.pmdtseq,
              l_pmdt.pmdt001,l_pmdt.pmdt002,l_pmdt.pmdt003,l_pmdt.pmdt004,l_pmdt.pmdt005,
              l_pmdt.pmdt006,l_pmdt.pmdt007,l_pmdt.pmdt008,l_pmdt.pmdt009,l_pmdt.pmdt010,
              l_pmdt.pmdt011,l_pmdt.pmdt016,l_pmdt.pmdt017,l_pmdt.pmdt018,l_pmdt.pmdt019,
              l_pmdt.pmdt020,l_pmdt.pmdt021,l_pmdt.pmdt022,l_pmdt.pmdt023,l_pmdt.pmdt024,
              l_pmdt.pmdt025,l_pmdt.pmdt026,l_pmdt.pmdt027,l_pmdt.pmdt028,l_pmdt.pmdt036,
              l_pmdt.pmdt037,l_pmdt.pmdt038,l_pmdt.pmdt039,l_pmdt.pmdt040,l_pmdt.pmdt041,
              l_pmdt.pmdt042,l_pmdt.pmdt043,l_pmdt.pmdt044,l_pmdt.pmdt045,l_pmdt.pmdt046,
              l_pmdt.pmdt047,l_pmdt.pmdt051,l_pmdt.pmdt052,l_pmdt.pmdt053,l_pmdt.pmdt054,
              l_pmdt.pmdt055,l_pmdt.pmdt056,l_pmdt.pmdt057,l_pmdt.pmdt058,l_pmdt.pmdt059,
              l_pmdt.pmdt060,l_pmdt.pmdt061,l_pmdt.pmdt062,l_pmdt.pmdt063,l_pmdt.pmdt064,
              l_pmdt.pmdt065,l_pmdt.pmdt066,l_pmdt.pmdt067,l_pmdt.pmdt068,l_pmdt.pmdt069,
              l_pmdt.pmdt081,l_pmdt.pmdt082,l_pmdt.pmdt083,l_pmdt.pmdt084,l_pmdt.pmdt085,
              l_pmdt.pmdt086,l_pmdt.pmdt087,l_pmdt.pmdt088,l_pmdt.pmdt089,l_pmdt.pmdt900,
              l_pmdt.pmdt999,
              l_pmdt.pmdtud001,l_pmdt.pmdtud002,l_pmdt.pmdtud003,l_pmdt.pmdtud004,l_pmdt.pmdtud005,
              l_pmdt.pmdtud006,l_pmdt.pmdtud007,l_pmdt.pmdtud008,l_pmdt.pmdtud009,l_pmdt.pmdtud010,
              l_pmdt.pmdtud011,l_pmdt.pmdtud012,l_pmdt.pmdtud013,l_pmdt.pmdtud014,l_pmdt.pmdtud015,
              l_pmdt.pmdtud016,l_pmdt.pmdtud017,l_pmdt.pmdtud018,l_pmdt.pmdtud019,l_pmdt.pmdtud020,
              l_pmdt.pmdtud021,l_pmdt.pmdtud022,l_pmdt.pmdtud023,l_pmdt.pmdtud024,l_pmdt.pmdtud025,
              l_pmdt.pmdtud026,l_pmdt.pmdtud027,l_pmdt.pmdtud028,l_pmdt.pmdtud029,l_pmdt.pmdtud030,
              l_pmdt.pmdt200,l_pmdt.pmdt201,l_pmdt.pmdt202,l_pmdt.pmdt203,l_pmdt.pmdt204,
              l_pmdt.pmdt205,l_pmdt.pmdt206,l_pmdt.pmdt207,l_pmdt.pmdt208,l_pmdt.pmdt209,
              l_pmdt.pmdt210,l_pmdt.pmdt211,l_pmdt.pmdt212,l_pmdt.pmdt213,l_pmdt.pmdtorga,
              l_pmdt.pmdt070,l_pmdt.pmdt071,l_pmdt.pmdt214,l_pmdt.pmdt215,l_pmdt.pmdt048,
              l_pmdt.pmdt216,l_pmdt.pmdt217,l_pmdt.pmdt090,l_pmdt.pmdt091,l_pmdt.pmdt092,
              l_pmdt.pmdt093,l_pmdt.pmdt218,l_pmdt.pmdt219,l_pmdt.pmdt072,l_pmdt.pmdt073,
              l_pmdt.pmdt074,l_pmdt.pmdt227,l_pmdt.pmdt049,l_pmdt.pmdt050,l_pmdt.pmdt075,
              l_pmdt.pmdt220,l_pmdt.pmdt221
             )
      #161108-00017#4 add end---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "l_pmdt"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
          
      #產生收貨原始需求分配明細資料
      IF NOT s_apmt520_gen_pmdv(l_pmdt.pmdtdocno,l_pmdt.pmdtseq) THEN
        LET r_success = FALSE
        RETURN r_success
        EXIT FOREACH
      END IF             
   END FOREACH
   #收貨/驗退/入庫/倉退單多庫儲批收貨明細檔
   IF NOT s_apmt520_gen_pmdu(l_pmdt.pmdtdocno) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success


END FUNCTION

################################################################################
# Descriptions...: 產生發票明細
# Memo...........:
# Usage..........: CALL aapt550_01_ins_pmdw(p_pmdsdocno)
# Date & Author..: 2016/06/08 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt550_01_ins_pmdw(p_pmdsdocno)
DEFINE l_pmdw RECORD  #進項發票檔
       pmdwent LIKE pmdw_t.pmdwent, #企業編號
       pmdwownid LIKE pmdw_t.pmdwownid, #資料所有者
       pmdwowndp LIKE pmdw_t.pmdwowndp, #資料所有部門
       pmdwcrtid LIKE pmdw_t.pmdwcrtid, #資料建立者
       pmdwcrtdp LIKE pmdw_t.pmdwcrtdp, #資料建立部門
       pmdwcrtdt LIKE pmdw_t.pmdwcrtdt, #資料創建日
       pmdwmodid LIKE pmdw_t.pmdwmodid, #資料修改者
       pmdwmoddt LIKE pmdw_t.pmdwmoddt, #最近修改日
       pmdwcnfid LIKE pmdw_t.pmdwcnfid, #資料確認者
       pmdwcnfdt LIKE pmdw_t.pmdwcnfdt, #資料確認日
       pmdwstus LIKE pmdw_t.pmdwstus,   #狀態碼
       pmdwcomp LIKE pmdw_t.pmdwcomp,   #法人
       pmdwdocno LIKE pmdw_t.pmdwdocno, #收貨單號
       pmdwseq LIKE pmdw_t.pmdwseq,     #項次
       pmdw001 LIKE pmdw_t.pmdw001,     #發票來源
       pmdw002 LIKE pmdw_t.pmdw002,     #開發票人
       pmdw004 LIKE pmdw_t.pmdw004,     #帳務中心(業務組織)
       pmdw008 LIKE pmdw_t.pmdw008,     #發票類型
       pmdw009 LIKE pmdw_t.pmdw009,     #銷方發票編號
       pmdw010 LIKE pmdw_t.pmdw010,     #發票號碼
       pmdw011 LIKE pmdw_t.pmdw011,     #發票日期
       pmdw012 LIKE pmdw_t.pmdw012,     #稅別
       pmdw0121 LIKE pmdw_t.pmdw0121,   #含稅否
       pmdw013 LIKE pmdw_t.pmdw013,    #稅率
       pmdw014 LIKE pmdw_t.pmdw014,    #幣別
       pmdw015 LIKE pmdw_t.pmdw015,    #匯率
       pmdw016 LIKE pmdw_t.pmdw016,    #購貨方名稱
       pmdw017 LIKE pmdw_t.pmdw017,    #購貨方稅務編號
       pmdw018 LIKE pmdw_t.pmdw018,    #購貨方地址
       pmdw019 LIKE pmdw_t.pmdw019,    #購貨方電話
       pmdw020 LIKE pmdw_t.pmdw020,    #購貨方開戶銀行
       pmdw021 LIKE pmdw_t.pmdw021,    #購貨方帳戶編碼
       pmdw023 LIKE pmdw_t.pmdw023,    #發票未稅金額
       pmdw024 LIKE pmdw_t.pmdw024,    #發票稅額
       pmdw025 LIKE pmdw_t.pmdw025,    #發票含稅金額
       pmdw026 LIKE pmdw_t.pmdw026,    #發票原幣未稅金額
       pmdw027 LIKE pmdw_t.pmdw027,    #發票原幣稅額
       pmdw028 LIKE pmdw_t.pmdw028,    #發票原幣含稅金額
       pmdw029 LIKE pmdw_t.pmdw029,    #銷貨方名稱
       pmdw030 LIKE pmdw_t.pmdw030,    #稅務編號
       pmdw031 LIKE pmdw_t.pmdw031,    #銷貨方地址
       pmdw032 LIKE pmdw_t.pmdw032,    #銷貨方電話
       pmdw033 LIKE pmdw_t.pmdw033,    #銷貨方開戶銀行
       pmdw034 LIKE pmdw_t.pmdw034,    #銷貨方帳號
       pmdw036 LIKE pmdw_t.pmdw036,    #異動狀態
       pmdw037 LIKE pmdw_t.pmdw037,    #可扣抵編號
       pmdw044 LIKE pmdw_t.pmdw044,
       pmdw107 LIKE pmdw_t.pmdw107,
       pmdw108 LIKE pmdw_t.pmdw108,
       pmdw117 LIKE pmdw_t.pmdw117,
       pmdw118 LIKE pmdw_t.pmdw118,
       pmdw200 LIKE pmdw_t.pmdw200
  
END RECORD
#DEFINE l_apgo        RECORD LIKE apgo_t.* #161104-00024#4 mark
#161104-00024#4-add(s)
DEFINE l_apgo  RECORD  #到貨發票明細檔
       apgoent   LIKE apgo_t.apgoent, #企業編號
       apgocomp  LIKE apgo_t.apgocomp, #法人
       apgodocno LIKE apgo_t.apgodocno, #單號
       apgoseq   LIKE apgo_t.apgoseq, #項次
       apgo001   LIKE apgo_t.apgo001, #開發票人
       apgo002   LIKE apgo_t.apgo002, #發票類型
       apgo003   LIKE apgo_t.apgo003, #電子發票否
       apgo004   LIKE apgo_t.apgo004, #發票編號
       apgo005   LIKE apgo_t.apgo005, #發票號碼
       apgo006   LIKE apgo_t.apgo006, #發票日期
       apgo007   LIKE apgo_t.apgo007, #稅別
       apgo008   LIKE apgo_t.apgo008, #含稅否
       apgo009   LIKE apgo_t.apgo009, #稅率
       apgo010   LIKE apgo_t.apgo010, #銷貨方名稱
       apgo011   LIKE apgo_t.apgo011, #開票人統編
       apgo012   LIKE apgo_t.apgo012, #可扣抵編號
       apgo100   LIKE apgo_t.apgo100, #幣別
       apgo101   LIKE apgo_t.apgo101, #匯率
       apgo103   LIKE apgo_t.apgo103, #發票原幣未稅金額
       apgo104   LIKE apgo_t.apgo104, #發票原幣稅額
       apgo105   LIKE apgo_t.apgo105, #發票原幣含稅金額
       apgo113   LIKE apgo_t.apgo113, #發票本幣未稅金額
       apgo114   LIKE apgo_t.apgo114, #發票本幣稅額
       apgo115   LIKE apgo_t.apgo115, #發票本幣含稅金額
       apgoud001 LIKE apgo_t.apgoud001, #自定義欄位(文字)001
       apgoud002 LIKE apgo_t.apgoud002, #自定義欄位(文字)002
       apgoud003 LIKE apgo_t.apgoud003, #自定義欄位(文字)003
       apgoud004 LIKE apgo_t.apgoud004, #自定義欄位(文字)004
       apgoud005 LIKE apgo_t.apgoud005, #自定義欄位(文字)005
       apgoud006 LIKE apgo_t.apgoud006, #自定義欄位(文字)006
       apgoud007 LIKE apgo_t.apgoud007, #自定義欄位(文字)007
       apgoud008 LIKE apgo_t.apgoud008, #自定義欄位(文字)008
       apgoud009 LIKE apgo_t.apgoud009, #自定義欄位(文字)009
       apgoud010 LIKE apgo_t.apgoud010, #自定義欄位(文字)010
       apgoud011 LIKE apgo_t.apgoud011, #自定義欄位(數字)011
       apgoud012 LIKE apgo_t.apgoud012, #自定義欄位(數字)012
       apgoud013 LIKE apgo_t.apgoud013, #自定義欄位(數字)013
       apgoud014 LIKE apgo_t.apgoud014, #自定義欄位(數字)014
       apgoud015 LIKE apgo_t.apgoud015, #自定義欄位(數字)015
       apgoud016 LIKE apgo_t.apgoud016, #自定義欄位(數字)016
       apgoud017 LIKE apgo_t.apgoud017, #自定義欄位(數字)017
       apgoud018 LIKE apgo_t.apgoud018, #自定義欄位(數字)018
       apgoud019 LIKE apgo_t.apgoud019, #自定義欄位(數字)019
       apgoud020 LIKE apgo_t.apgoud020, #自定義欄位(數字)020
       apgoud021 LIKE apgo_t.apgoud021, #自定義欄位(日期時間)021
       apgoud022 LIKE apgo_t.apgoud022, #自定義欄位(日期時間)022
       apgoud023 LIKE apgo_t.apgoud023, #自定義欄位(日期時間)023
       apgoud024 LIKE apgo_t.apgoud024, #自定義欄位(日期時間)024
       apgoud025 LIKE apgo_t.apgoud025, #自定義欄位(日期時間)025
       apgoud026 LIKE apgo_t.apgoud026, #自定義欄位(日期時間)026
       apgoud027 LIKE apgo_t.apgoud027, #自定義欄位(日期時間)027
       apgoud028 LIKE apgo_t.apgoud028, #自定義欄位(日期時間)028
       apgoud029 LIKE apgo_t.apgoud029, #自定義欄位(日期時間)029
       apgoud030 LIKE apgo_t.apgoud030  #自定義欄位(日期時間)030
           END RECORD
#161104-00024#4-add(e)
DEFINE l_sql         STRING
DEFINE p_pmdsdocno   LIKE pmds_t.pmdsdocno
DEFINE l_ooef019     LIKE ooef_t.ooef019
DEFINE l_ooef011     LIKE ooef_t.ooef011
DEFINE r_success      LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   SELECT ooef019,ooef011 INTO l_ooef019,l_ooef011   
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_site
 
   #LET l_sql = " SELECT * FROM apgo_t WHERE apgoent = '",g_enterprise,"' ",   #161208-00026#12 mark
   #161208-00026#12-add(s)
   LET l_sql = " SELECT apgoent,apgocomp,apgodocno,apgoseq,apgo001,
                        apgo002,apgo003,apgo004,apgo005,apgo006,
                        apgo007,apgo008,apgo009,apgo010,apgo011,
                        apgo012,apgo100,apgo101,apgo103,apgo104,
                        apgo105,apgo113,apgo114,apgo115,apgoud001,
                        apgoud002,apgoud003,apgoud004,apgoud005,apgoud006,
                        apgoud007,apgoud008,apgoud009,apgoud010,apgoud011,
                        apgoud012,apgoud013,apgoud014,apgoud015,apgoud016,
                        apgoud017,apgoud018,apgoud019,apgoud020,apgoud021,
                        apgoud022,apgoud023,apgoud024,apgoud025,apgoud026,
                        apgoud027,apgoud028,apgoud029,apgoud030 
                   FROM apgo_t 
                  WHERE apgoent = '",g_enterprise,"' ",
   #161208-00026#12-add(e)
               "    AND apgodocno = '",g_apgldocno,"' AND apgocomp = '",g_apglcomp,"'  "
   PREPARE aapt550_ins_pmdw_prep FROM l_sql 
   DECLARE aapt550_ins_pmdw_curs CURSOR FOR aapt550_ins_pmdw_prep
   #FOREACH aapt550_ins_pmdw_curs INTO l_apgo.*   #161208-00026#12 mark
   #161208-00026#12-add(s)
   FOREACH aapt550_ins_pmdw_curs INTO l_apgo.apgoent,l_apgo.apgocomp,l_apgo.apgodocno,l_apgo.apgoseq,l_apgo.apgo001,
                                      l_apgo.apgo002,l_apgo.apgo003,l_apgo.apgo004,l_apgo.apgo005,l_apgo.apgo006,
                                      l_apgo.apgo007,l_apgo.apgo008,l_apgo.apgo009,l_apgo.apgo010,l_apgo.apgo011,
                                      l_apgo.apgo012,l_apgo.apgo100,l_apgo.apgo101,l_apgo.apgo103,l_apgo.apgo104,
                                      l_apgo.apgo105,l_apgo.apgo113,l_apgo.apgo114,l_apgo.apgo115,l_apgo.apgoud001,
                                      l_apgo.apgoud002,l_apgo.apgoud003,l_apgo.apgoud004,l_apgo.apgoud005,l_apgo.apgoud006,
                                      l_apgo.apgoud007,l_apgo.apgoud008,l_apgo.apgoud009,l_apgo.apgoud010,l_apgo.apgoud011,
                                      l_apgo.apgoud012,l_apgo.apgoud013,l_apgo.apgoud014,l_apgo.apgoud015,l_apgo.apgoud016,
                                      l_apgo.apgoud017,l_apgo.apgoud018,l_apgo.apgoud019,l_apgo.apgoud020,l_apgo.apgoud021,
                                      l_apgo.apgoud022,l_apgo.apgoud023,l_apgo.apgoud024,l_apgo.apgoud025,l_apgo.apgoud026,
                                      l_apgo.apgoud027,l_apgo.apgoud028,l_apgo.apgoud029,l_apgo.apgoud030
   #161208-00026#12-add(e)
      INITIALIZE l_pmdw.* TO NULL
      LET l_pmdw.pmdwent   = g_enterprise       #企業編號
      LET l_pmdw.pmdwownid = g_user             #資料所有者
      LET l_pmdw.pmdwowndp = g_dept             #資料所有部門
      LET l_pmdw.pmdwcrtid = g_user             #資料建立者
      LET l_pmdw.pmdwcrtdp = g_dept             #資料建立部門
      LET l_pmdw.pmdwcrtdt = cl_get_current()   #資料創建日
      LET l_pmdw.pmdwmodid = g_user             #資料修改者
      LET l_pmdw.pmdwmoddt = cl_get_current()   #最近修改日
      LET l_pmdw.pmdwcnfid = g_user             #資料確認者
      LET l_pmdw.pmdwcnfdt = cl_get_current()   #資料確認日
      LET l_pmdw.pmdwstus  =  'Y'               #狀態碼
      LET l_pmdw.pmdwcomp  = l_apgo.apgocomp    #法人
      LET l_pmdw.pmdwdocno = p_pmdsdocno        #收貨單號
      LET l_pmdw.pmdwseq   = l_apgo.apgoseq     #項次END FOREACH   
      LET l_pmdw.pmdw001   = 'aapt550'          #發票來源
      LET l_pmdw.pmdw002   = l_apgo.apgo001     #開發票人
      LET l_pmdw.pmdw004   = g_dept             #帳務中心(業務組織)
      LET l_pmdw.pmdw008   = l_apgo.apgo002     #發票類型
      LET l_pmdw.pmdw009   = l_apgo.apgo004     #銷方發票編號
      LET l_pmdw.pmdw010   = l_apgo.apgo005     #發票號碼
      LET l_pmdw.pmdw011   = l_apgo.apgo006     #發票日期
      LET l_pmdw.pmdw012   = l_apgo.apgo007     #稅別
      LET l_pmdw.pmdw0121  = l_apgo.apgo008     #含稅否
      LET l_pmdw.pmdw013   = l_apgo.apgo009     #稅率
      LET l_pmdw.pmdw014   = l_apgo.apgo100     #幣別
      LET l_pmdw.pmdw015   = l_apgo.apgo101     #匯率
      SELECT ooefl004 INTO l_pmdw.pmdw016 FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = g_site
         AND ooefl002 = g_lang
      SELECT b.ooef002 INTO l_pmdw.pmdw017 #購貨方稅務編號
        FROM ooef_t a LEFT OUTER JOIN ooef_t b ON a.ooefent = b.ooefent AND b.ooef001 = a.ooef017
       WHERE a.ooefent = g_enterprise
         AND a.ooef001 = g_site
      SELECT isao002,isao003,isao004,isao005
       INTO l_pmdw.pmdw018,l_pmdw.pmdw019,  #購貨方地址/購貨方電話
            l_pmdw.pmdw020,l_pmdw.pmdw021   #購貨方開戶銀行/銷方銀行帳戶編碼
       FROM isao_t
      WHERE isaoent = g_enterprise
        AND isaosite= g_site
      
      LET l_pmdw.pmdw023  = l_apgo.apgo113    #發票未稅金額
      LET l_pmdw.pmdw024  = l_apgo.apgo114    #發票稅額
      LET l_pmdw.pmdw025  = l_apgo.apgo115    #發票含稅金額
      LET l_pmdw.pmdw026  = l_apgo.apgo103    #發票原幣未稅金額
      LET l_pmdw.pmdw027  = l_apgo.apgo104    #發票原幣稅額
      LET l_pmdw.pmdw028  = l_apgo.apgo105    #發票原幣含稅金額
      LET l_pmdw.pmdw029  = l_apgo.apgo010    #銷貨方名稱
      LET l_pmdw.pmdw030  = l_apgo.apgo011    #稅務編號
      SELECT isak009,isak010,isak011,isak012
       INTO l_pmdw.pmdw031,l_pmdw.pmdw032,     #地址/銷貨方電話
            l_pmdw.pmdw033,l_pmdw.pmdw034      #銷貨方開戶銀行/銷貨方帳號
       FROM isak_t
      WHERE isakent = g_enterprise
        AND isak001 = l_apgo.apgo001
        AND isak002 = l_ooef019    
      
      LET l_pmdw.pmdw037  = l_apgo.apgo012     #可扣抵編號
      LET l_pmdw.pmdw044  =  0                 #列印次數
      LET l_pmdw.pmdw107  =  0                 #發票原幣已折金額
      LET l_pmdw.pmdw108  =  0                 #發票原幣已折稅額
      LET l_pmdw.pmdw117  =  0                 #發票本幣已折金額
      LET l_pmdw.pmdw118  =  0                 #發票本幣已折稅額
      LET l_pmdw.pmdw200  =  l_apgo.apgo003    #電子發票否
     #INSERT INTO pmdw_t (pmdwent  ,pmdwownid,pmdwowndp,pmdwcrtid,pmdwcrtdp,
     #                    pmdwcrtdt,pmdwmodid,pmdwmoddt,pmdwcnfid,pmdwcnfdt,
     #                    pmdwstus ,pmdwcomp ,pmdwdocno,pmdwseq  ,
     #                    pmdw001  ,pmdw002  ,pmdw004  ,pmdw008  ,pmdw009,
     #                    pmdw010  ,pmdw011  ,pmdw012  ,pmdw0121 ,pmdw013,
     #                    pmdw014  ,pmdw015  ,pmdw016  ,pmdw017  ,pmdw018,
     #                    pmdw019  ,pmdw020  ,pmdw021  ,pmdw023  ,pmdw024,
     #                    pmdw025  ,pmdw026  ,pmdw027  ,pmdw027  ,pmdw029,
     #                    pmdw030  ,pmdw031  ,pmdw032  ,pmdw033  ,pmdw034,
     #                    pmdw037  ,pmdw044  ,pmdw107  ,pmdw108  ,pmdw117,
     #                    pmdw118  ,pmdw200)      
     #     VALUES( l_pmdw.pmdwent  ,l_pmdw.pmdwownid,l_pmdw.pmdwowndp,l_pmdw.pmdwcrtid,l_pmdw.pmdwcrtdp, 
     #             l_pmdw.pmdwcrtdt,l_pmdw.pmdwmodid,l_pmdw.pmdwmoddt,l_pmdw.pmdwcnfid,l_pmdw.pmdwcnfdt, 
     #             l_pmdw.pmdwstus ,l_pmdw.pmdwcomp ,l_pmdw.pmdwdocno,l_pmdw.pmdwseq  ,   
     #             l_pmdw.pmdw001  ,l_pmdw.pmdw002  ,l_pmdw.pmdw004  ,l_pmdw.pmdw008  ,l_pmdw.pmdw009,   
     #             l_pmdw.pmdw010  ,l_pmdw.pmdw011  ,l_pmdw.pmdw012  ,l_pmdw.pmdw0121 ,l_pmdw.pmdw013,   
     #             l_pmdw.pmdw014  ,l_pmdw.pmdw015  ,l_pmdw.pmdw016  ,l_pmdw.pmdw017  ,l_pmdw.pmdw018,
     #             l_pmdw.pmdw019  ,l_pmdw.pmdw020  ,l_pmdw.pmdw021  ,l_pmdw.pmdw023  ,l_pmdw.pmdw024, 
     #             l_pmdw.pmdw025  ,l_pmdw.pmdw026  ,l_pmdw.pmdw027  ,l_pmdw.pmdw027  ,l_pmdw.pmdw029,
     #             l_pmdw.pmdw030  ,l_pmdw.pmdw031  ,l_pmdw.pmdw032  ,l_pmdw.pmdw033  ,l_pmdw.pmdw034,
     #             l_pmdw.pmdw037  ,l_pmdw.pmdw044  ,l_pmdw.pmdw107  ,l_pmdw.pmdw108  ,l_pmdw.pmdw117,
     #             l_pmdw.pmdw118  ,l_pmdw.pmdw200)      
                   
                   
                   
       INSERT INTO pmdw_t (pmdwent,pmdwdocno,pmdwseq,pmdw001,pmdw008,
                                   pmdw037,pmdw011,pmdw010,pmdw030,pmdw009,
                                   pmdw012,pmdw0121,pmdw013,pmdw014,pmdw015,
                                   pmdw023,pmdw024,pmdw025,pmdw026,pmdw027,
                                   pmdw028,pmdwcomp,pmdwstus,pmdw002,
                                   pmdw004,pmdw016,pmdw017,pmdw018,pmdw019,
                                   pmdw020,pmdw021,pmdw029,pmdw031,
                                   pmdw032,pmdw033,pmdw034,pmdw200)
                  VALUES(g_enterprise,l_pmdw.pmdwdocno,l_pmdw.pmdwseq,l_pmdw.pmdw001,
                         l_pmdw.pmdw008,l_pmdw.pmdw037,l_pmdw.pmdw011,
                         l_pmdw.pmdw010,l_pmdw.pmdw030,l_pmdw.pmdw009,l_pmdw.pmdw012,
                         l_pmdw.pmdw0121,l_pmdw.pmdw013,l_pmdw.pmdw014,l_pmdw.pmdw015,
                         l_pmdw.pmdw023,l_pmdw.pmdw024,l_pmdw.pmdw025,
                         l_pmdw.pmdw026,l_pmdw.pmdw027,l_pmdw.pmdw028,
                         l_pmdw.pmdwcomp,l_pmdw.pmdwstus,
                         l_pmdw.pmdw002,l_pmdw.pmdw004,l_pmdw.pmdw016,l_pmdw.pmdw017,
                         l_pmdw.pmdw018,l_pmdw.pmdw019,l_pmdw.pmdw020,l_pmdw.pmdw021,
                         l_pmdw.pmdw029,l_pmdw.pmdw031,l_pmdw.pmdw032,
                         l_pmdw.pmdw033,l_pmdw.pmdw034,l_pmdw.pmdw200)                   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "insert pmdw '",l_pmdw.pmdw010,"' "
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE        
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
