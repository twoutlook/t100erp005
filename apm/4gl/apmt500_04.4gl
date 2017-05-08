#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt500_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-08-29 11:19:27), PR版次:0003(2016-04-11 16:16:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000136
#+ Filename...: apmt500_04
#+ Description: 維護採購其他資訊作業
#+ Creator....: 02294(2013-12-23 11:26:59)
#+ Modifier...: 02294 -SD/PR- 07900
 
{</section>}
 
{<section id="apmt500_04.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#17     16/04/11   By 07900    校验代码的重复错误讯息修改
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
PRIVATE type type_g_pmdn_m        RECORD
       pmdndocno LIKE pmdn_t.pmdndocno, 
   pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdn027 LIKE pmdn_t.pmdn027, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn028_desc LIKE type_t.chr80, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn029_desc LIKE type_t.chr80, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn025_desc LIKE type_t.chr80, 
   oofb017 LIKE type_t.chr500, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn026_desc LIKE type_t.chr80, 
   oofb017_1 LIKE type_t.chr500, 
   pmdn031 LIKE pmdn_t.pmdn031, 
   pmdn031_desc LIKE type_t.chr80, 
   pmdn032 LIKE pmdn_t.pmdn032, 
   pmdn003 LIKE pmdn_t.pmdn003, 
   pmdn003_desc LIKE type_t.chr80, 
   pmdn033 LIKE pmdn_t.pmdn033, 
   pmdn036 LIKE pmdn_t.pmdn036, 
   pmdn037 LIKE pmdn_t.pmdn037, 
   pmdn038 LIKE pmdn_t.pmdn038, 
   pmdn039 LIKE pmdn_t.pmdn039
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_pmdndocno     LIKE pmdn_t.pmdndocno
DEFINE g_pmdnseq       LIKE pmdn_t.pmdnseq
DEFINE g_pmdn_m_t      type_g_pmdn_m
DEFINE g_bgjob         LIKE type_t.chr1
DEFINE g_oofa001      LIKE oofa_t.oofa001
#end add-point
 
DEFINE g_pmdn_m        type_g_pmdn_m
 
   DEFINE g_pmdndocno_t LIKE pmdn_t.pmdndocno
DEFINE g_pmdnseq_t LIKE pmdn_t.pmdnseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmt500_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt500_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmdndocno,p_pmdnseq
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
   DEFINE p_pmdndocno     LIKE pmdn_t.pmdndocno
   DEFINE p_pmdnseq       LIKE pmdn_t.pmdnseq
   DEFINE l_forupd_sql    STRING
   DEFINE l_pmdl004       LIKE pmdl_t.pmdl004
   DEFINE l_pmdn001       LIKE pmdn_t.pmdn001
   DEFINE l_pmdn002       LIKE pmdn_t.pmdn002
   DEFINE l_imaf062       LIKE imaf_t.imaf062
   DEFINE l_pmdnunit      LIKE pmdn_t.pmdnunit
   DEFINE l_ooef012       LIKE ooef_t.ooef012
   DEFINE l_pmdnorga      LIKE pmdn_t.pmdnorga
   DEFINE l_oofb002       LIKE oofb_t.oofb002
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt500_04 WITH FORM cl_ap_formpath("apm","apmt500_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('pmdn032','2056') 
   
   LET g_pmdndocno = p_pmdndocno
   LET g_pmdnseq = p_pmdnseq
   
   INITIALIZE g_pmdn_m.* LIKE pmdn_t.*
   
   CALL apmt500_04_pmdndocno_ref()  #帶值
   
   INITIALIZE g_pmdn_m_t.* TO NULL
   LET g_pmdn_m_t.* = g_pmdn_m.*
   
   LET p_cmd = 'u'
   LET l_forupd_sql = "SELECT pmdndocno,pmdnseq,pmdn027,pmdn028,'',pmdn029,'',pmdn030,pmdn025,'','',pmdn026,'','',pmdn031,'',pmdn032,pmdn003,'',pmdn033,pmdn036,pmdn037,pmdn038,pmdn039 FROM pmdn_t WHERE pmdnent= ? AND pmdndocno=? AND pmdnseq = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   DECLARE apmt500_04_cl CURSOR FROM l_forupd_sql
  
   DISPLAY BY NAME g_pmdn_m.pmdndocno,g_pmdn_m.pmdnseq,g_pmdn_m.pmdn027,g_pmdn_m.pmdn028,g_pmdn_m.pmdn028_desc,g_pmdn_m.pmdn029,g_pmdn_m.pmdn029_desc,g_pmdn_m.pmdn030,g_pmdn_m.pmdn025,g_pmdn_m.pmdn025_desc,g_pmdn_m.oofb017,g_pmdn_m.pmdn026,g_pmdn_m.pmdn026_desc,g_pmdn_m.oofb017_1,g_pmdn_m.pmdn031,g_pmdn_m.pmdn031_desc,g_pmdn_m.pmdn032,g_pmdn_m.pmdn003,g_pmdn_m.pmdn003_desc,g_pmdn_m.pmdn033,g_pmdn_m.pmdn036,g_pmdn_m.pmdn037,g_pmdn_m.pmdn038,g_pmdn_m.pmdn039
    
   #獲取當前營運據點的聯絡對象識別碼
   LET g_oofa001 = ''
   SELECT oofa001 INTO g_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
   
   
   LET l_pmdl004 = ''
   LET l_pmdn001 = ''
   LET l_pmdn002 = ''
   #獲得供應商編號、料件編號、產品特徵
   SELECT pmdl004 INTO l_pmdl004 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdndocno
   
   SELECT pmdn001,pmdn002 INTO l_pmdn001,l_pmdn002 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdndocno AND pmdnseq = g_pmdnseq
               
   
   LET l_pmdnunit = ''
   #獲得收貨據點
   SELECT pmdnunit,pmdnorga INTO l_pmdnunit,l_pmdnorga FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdndocno AND pmdnseq = g_pmdnseq
   IF cl_null(l_pmdnunit) THEN
      LET l_pmdnunit = g_site
   END IF
   
   CALL apmt500_04_set_entry()
   CALL apmt500_04_set_no_entry()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pmdn_m.pmdndocno,g_pmdn_m.pmdnseq,g_pmdn_m.pmdn027,g_pmdn_m.pmdn028,g_pmdn_m.pmdn029, 
          g_pmdn_m.pmdn030,g_pmdn_m.pmdn025,g_pmdn_m.oofb017,g_pmdn_m.pmdn026,g_pmdn_m.oofb017_1,g_pmdn_m.pmdn031, 
          g_pmdn_m.pmdn032,g_pmdn_m.pmdn003,g_pmdn_m.pmdn033,g_pmdn_m.pmdn036,g_pmdn_m.pmdn037,g_pmdn_m.pmdn038, 
          g_pmdn_m.pmdn039 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF p_cmd ='u' THEN
               
               CALL s_transaction_begin()
               
               OPEN apmt500_04_cl USING g_enterprise,g_pmdndocno,g_pmdnseq
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN apmt500_04_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE apmt500_04_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
    
               #鎖住將被更改或取消的資料
               FETCH apmt500_04_cl INTO g_pmdn_m.pmdndocno,g_pmdn_m.pmdnseq,g_pmdn_m.pmdn027,g_pmdn_m.pmdn028,g_pmdn_m.pmdn028_desc,g_pmdn_m.pmdn029,g_pmdn_m.pmdn029_desc,g_pmdn_m.pmdn030,g_pmdn_m.pmdn025,g_pmdn_m.pmdn025_desc,g_pmdn_m.oofb017,g_pmdn_m.pmdn026,g_pmdn_m.pmdn026_desc,g_pmdn_m.oofb017_1,g_pmdn_m.pmdn031,g_pmdn_m.pmdn031_desc,g_pmdn_m.pmdn032,g_pmdn_m.pmdn003,g_pmdn_m.pmdn003_desc,g_pmdn_m.pmdn033,g_pmdn_m.pmdn036,g_pmdn_m.pmdn037,g_pmdn_m.pmdn038,g_pmdn_m.pmdn039
            
               #資料被他人LOCK, 或是sql執行時出現錯誤
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmdn_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CLOSE apmt500_04_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdndocno
            #add-point:BEFORE FIELD pmdndocno name="input.b.pmdndocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdndocno
            
            #add-point:AFTER FIELD pmdndocno name="input.a.pmdndocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdndocno
            #add-point:ON CHANGE pmdndocno name="input.g.pmdndocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnseq
            #add-point:BEFORE FIELD pmdnseq name="input.b.pmdnseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnseq
            
            #add-point:AFTER FIELD pmdnseq name="input.a.pmdnseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdnseq
            #add-point:ON CHANGE pmdnseq name="input.g.pmdnseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn027
            
            #add-point:AFTER FIELD pmdn027 name="input.a.pmdn027"
            IF NOT cl_null(g_pmdn_m.pmdn027) THEN 
               
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_pmdl004
               LET g_chkparam.arg2 = l_pmdn001
               LET g_chkparam.arg3 = l_pmdn002
               LET g_chkparam.arg4 = g_pmdn_m.pmdn027

               #160318-00025#17 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00261:sub-01302|apmi120|",cl_get_progname("apmi120",g_lang,"2"),"|:EXEPROGapmi120"
               #160318-00025#17 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmao004") THEN
                  LET g_pmdn_m.pmdn027 = g_pmdn_m_t.pmdn027
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn027
            #add-point:BEFORE FIELD pmdn027 name="input.b.pmdn027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn027
            #add-point:ON CHANGE pmdn027 name="input.g.pmdn027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn028
            
            #add-point:AFTER FIELD pmdn028 name="input.a.pmdn028"
            CALL apmt500_04_pmdn028_ref()
            IF NOT cl_null(g_pmdn_m.pmdn028) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_pmdnunit
               LET g_chkparam.arg2 = g_pmdn_m.pmdn028

                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001_1") THEN
                  LET g_pmdn_m.pmdn028 = g_pmdn_m_t.pmdn028
                  CALL apmt500_04_pmdn028_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn028
            #add-point:BEFORE FIELD pmdn028 name="input.b.pmdn028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn028
            #add-point:ON CHANGE pmdn028 name="input.g.pmdn028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn029
            
            #add-point:AFTER FIELD pmdn029 name="input.a.pmdn029"
            CALL apmt500_04_pmdn029_ref()
            
            IF NOT cl_null(g_pmdn_m.pmdn029) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_pmdnunit
               LET g_chkparam.arg2 = g_pmdn_m.pmdn028
               LET g_chkparam.arg3 = g_pmdn_m.pmdn029

                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inab002_1") THEN
                  LET g_pmdn_m.pmdn029 = g_pmdn_m_t.pmdn029
                  CALL apmt500_04_pmdn029_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn029
            #add-point:BEFORE FIELD pmdn029 name="input.b.pmdn029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn029
            #add-point:ON CHANGE pmdn029 name="input.g.pmdn029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn030
            #add-point:BEFORE FIELD pmdn030 name="input.b.pmdn030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn030
            
            #add-point:AFTER FIELD pmdn030 name="input.a.pmdn030"
            LET l_imaf062 = ''
            SELECT imaf062 INTO l_imaf062 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn001
            
            #判斷[T:料件據點進銷存檔].[C:批號自動編碼]是否有勾選，若勾選自動編碼時需,呼叫命名規則產生的應用元件產生批號
            IF l_imaf062 = 'Y' THEN
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn030
            #add-point:ON CHANGE pmdn030 name="input.g.pmdn030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn025
            
            #add-point:AFTER FIELD pmdn025 name="input.a.pmdn025"
            CALL apmt500_04_pmdn025_ref() 
            
            IF NOT cl_null(g_pmdn_m.pmdn025) THEN
               IF NOT apmt500_04_pmdn025_chk(l_pmdnunit,g_pmdn_m.pmdn025) THEN
                  LET g_pmdn_m.pmdn025 = g_pmdn_m_t.pmdn025
                  CALL apmt500_04_pmdn025_ref() 
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn025
            #add-point:BEFORE FIELD pmdn025 name="input.b.pmdn025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn025
            #add-point:ON CHANGE pmdn025 name="input.g.pmdn025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb017
            #add-point:BEFORE FIELD oofb017 name="input.b.oofb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb017
            
            #add-point:AFTER FIELD oofb017 name="input.a.oofb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb017
            #add-point:ON CHANGE oofb017 name="input.g.oofb017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn026
            
            #add-point:AFTER FIELD pmdn026 name="input.a.pmdn026"
            CALL apmt500_04_pmdn026_ref() 
            
            IF NOT cl_null(g_pmdn_m.pmdn026) THEN
               LET l_oofb002 = ''
               SELECT ooef012 INTO l_oofb002 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_pmdnorga
               
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_oofb002
               LET g_chkparam.arg2 = g_pmdn_m.pmdn026
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofb019_2") THEN
                  LET g_pmdn_m.pmdn026 = g_pmdn_m_t.pmdn026
                  CALL apmt500_04_pmdn026_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn026
            #add-point:BEFORE FIELD pmdn026 name="input.b.pmdn026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn026
            #add-point:ON CHANGE pmdn026 name="input.g.pmdn026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb017_1
            #add-point:BEFORE FIELD oofb017_1 name="input.b.oofb017_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb017_1
            
            #add-point:AFTER FIELD oofb017_1 name="input.a.oofb017_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb017_1
            #add-point:ON CHANGE oofb017_1 name="input.g.oofb017_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn031
            
            #add-point:AFTER FIELD pmdn031 name="input.a.pmdn031"
            CALL apmt500_04_pmdn031_ref()
            IF NOT cl_null(g_pmdn_m.pmdn031) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdn_m.pmdn031

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oocq002_263") THEN
                  LET g_pmdn_m.pmdn031 = g_pmdn_m_t.pmdn031
                  CALL apmt500_04_pmdn031_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn031
            #add-point:BEFORE FIELD pmdn031 name="input.b.pmdn031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn031
            #add-point:ON CHANGE pmdn031 name="input.g.pmdn031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn032
            #add-point:BEFORE FIELD pmdn032 name="input.b.pmdn032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn032
            
            #add-point:AFTER FIELD pmdn032 name="input.a.pmdn032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn032
            #add-point:ON CHANGE pmdn032 name="input.g.pmdn032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn003
            
            #add-point:AFTER FIELD pmdn003 name="input.a.pmdn003"
            CALL apmt500_04_pmdn003_ref()
            IF NOT cl_null(g_pmdn_m.pmdn003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdn_m.pmdn003
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_2") THEN
                  LET g_pmdn_m.pmdn003 = g_pmdn_m_t.pmdn003
                  CALL apmt500_04_pmdn003_ref()
                  NEXT FIELD CURRENT
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn003
            #add-point:BEFORE FIELD pmdn003 name="input.b.pmdn003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn003
            #add-point:ON CHANGE pmdn003 name="input.g.pmdn003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_m.pmdn033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmdn033
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdn033 name="input.a.pmdn033"
            IF NOT cl_null(g_pmdn_m.pmdn033) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn033
            #add-point:BEFORE FIELD pmdn033 name="input.b.pmdn033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn033
            #add-point:ON CHANGE pmdn033 name="input.g.pmdn033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn036
            #add-point:BEFORE FIELD pmdn036 name="input.b.pmdn036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn036
            
            #add-point:AFTER FIELD pmdn036 name="input.a.pmdn036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn036
            #add-point:ON CHANGE pmdn036 name="input.g.pmdn036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn037
            #add-point:BEFORE FIELD pmdn037 name="input.b.pmdn037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn037
            
            #add-point:AFTER FIELD pmdn037 name="input.a.pmdn037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn037
            #add-point:ON CHANGE pmdn037 name="input.g.pmdn037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn038
            #add-point:BEFORE FIELD pmdn038 name="input.b.pmdn038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn038
            
            #add-point:AFTER FIELD pmdn038 name="input.a.pmdn038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn038
            #add-point:ON CHANGE pmdn038 name="input.g.pmdn038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn039
            #add-point:BEFORE FIELD pmdn039 name="input.b.pmdn039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn039
            
            #add-point:AFTER FIELD pmdn039 name="input.a.pmdn039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn039
            #add-point:ON CHANGE pmdn039 name="input.g.pmdn039"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdndocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdndocno
            #add-point:ON ACTION controlp INFIELD pmdndocno name="input.c.pmdndocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnseq
            #add-point:ON ACTION controlp INFIELD pmdnseq name="input.c.pmdnseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn027
            #add-point:ON ACTION controlp INFIELD pmdn027 name="input.c.pmdn027"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_pmdl004
            LET g_qryparam.arg2 = l_pmdn001 #
            LET g_qryparam.arg3 = l_pmdn002 #

            CALL q_pmao004_1()                                #呼叫開窗

            LET g_pmdn_m.pmdn027 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn027 TO pmdn027              #顯示到畫面上

            NEXT FIELD pmdn027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdn028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn028
            #add-point:ON ACTION controlp INFIELD pmdn028 name="input.c.pmdn028"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_pmdnunit #

            CALL q_inaa001_6()                                #呼叫開窗

            LET g_pmdn_m.pmdn028 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn028 TO pmdn028              #顯示到畫面上
            CALL apmt500_04_pmdn028_ref()

            NEXT FIELD pmdn028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdn029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn029
            #add-point:ON ACTION controlp INFIELD pmdn029 name="input.c.pmdn029"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_pmdnunit #
            LET g_qryparam.arg2 = g_pmdn_m.pmdn028 #

            CALL q_inab002_6()                                #呼叫開窗

            LET g_pmdn_m.pmdn029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn029 TO pmdn029              #顯示到畫面上
            CALL apmt500_04_pmdn029_ref()

            NEXT FIELD pmdn029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdn030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn030
            #add-point:ON ACTION controlp INFIELD pmdn030 name="input.c.pmdn030"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn025
            #add-point:ON ACTION controlp INFIELD pmdn025 name="input.c.pmdn025"
            MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
               ON ACTION open_ooef   #營運據點
                  LET g_bgjob = '1'
                  EXIT MENU

               ON ACTION open_inaa   #庫位
                  LET g_bgjob = '2'
                  EXIT MENU
            END MENU

            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn025             #給予default值

            #給予arg
            LET l_ooef012 = ''
            IF g_bgjob = '1' THEN
               SELECT ooef012 INTO l_ooef012 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_pmdnunit
            ELSE
               SELECT inaa004 INTO l_ooef012 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = l_pmdnunit AND inaa001 = g_pmdn_m.pmdn028
            END IF
            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '3' "

            CALL q_oofb019_1()                                #呼叫開窗

            LET g_pmdn_m.pmdn025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn025 TO pmdn025              #顯示到畫面上
            CALL apmt500_04_pmdn025_ref()

            NEXT FIELD pmdn025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oofb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb017
            #add-point:ON ACTION controlp INFIELD oofb017 name="input.c.oofb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn026
            #add-point:ON ACTION controlp INFIELD pmdn026 name="input.c.pmdn026"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn026             #給予default值

            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '5' "

            CALL q_oofb019_1()

            LET g_pmdn_m.pmdn026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn026 TO pmdn026              #顯示到畫面上
            CALL apmt500_04_pmdn026_ref()

            NEXT FIELD pmdn026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oofb017_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb017_1
            #add-point:ON ACTION controlp INFIELD oofb017_1 name="input.c.oofb017_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn031
            #add-point:ON ACTION controlp INFIELD pmdn031 name="input.c.pmdn031"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn031             #給予default值
            LET g_qryparam.default2 = "" #g_pmdn_m.oocq010 #參考欄位七

            #給予arg
            LET g_qryparam.arg1 = "263" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmdn_m.pmdn031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn031 TO pmdn031              #顯示到畫面上
            CALL apmt500_04_pmdn031_ref()

            NEXT FIELD pmdn031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn032
            #add-point:ON ACTION controlp INFIELD pmdn032 name="input.c.pmdn032"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn003
            #add-point:ON ACTION controlp INFIELD pmdn003 name="input.c.pmdn003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_m.pmdn003             #給予default值
            LET g_qryparam.default2 = "" #g_pmdn_m.imaal003 #品名

            #給予arg

            CALL q_imaa001_3()                                #呼叫開窗

            LET g_pmdn_m.pmdn003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_m.pmdn003 TO pmdn003              #顯示到畫面上
            CALL apmt500_04_pmdn003_ref()

            NEXT FIELD pmdn003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn033
            #add-point:ON ACTION controlp INFIELD pmdn033 name="input.c.pmdn033"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn036
            #add-point:ON ACTION controlp INFIELD pmdn036 name="input.c.pmdn036"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn037
            #add-point:ON ACTION controlp INFIELD pmdn037 name="input.c.pmdn037"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn038
            #add-point:ON ACTION controlp INFIELD pmdn038 name="input.c.pmdn038"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdn039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn039
            #add-point:ON ACTION controlp INFIELD pmdn039 name="input.c.pmdn039"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            #單頭修改
            UPDATE pmdn_t SET (pmdn027,pmdn028,pmdn029,pmdn030,pmdn025,pmdn026,pmdn031,pmdn032,pmdn003,pmdn033,pmdn036,pmdn037,pmdn038,pmdn039) = 
              (g_pmdn_m.pmdn027,g_pmdn_m.pmdn028,g_pmdn_m.pmdn029,g_pmdn_m.pmdn030,g_pmdn_m.pmdn025,g_pmdn_m.pmdn026,g_pmdn_m.pmdn031,g_pmdn_m.pmdn032,g_pmdn_m.pmdn003,g_pmdn_m.pmdn033,g_pmdn_m.pmdn036,g_pmdn_m.pmdn037,g_pmdn_m.pmdn038,g_pmdn_m.pmdn039)
             WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdndocno AND pmdnseq = g_pmdnseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmdn_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
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
   CLOSE WINDOW w_apmt500_04 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = FALSE
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt500_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt500_04.other_function" readonly="Y" >}
#帶值
PRIVATE FUNCTION apmt500_04_pmdndocno_ref()
       SELECT pmdndocno,pmdnseq,pmdn027,pmdn028,pmdn029,pmdn030,pmdn025,pmdn026,pmdn031,pmdn032,pmdn003,pmdn033,pmdn036,pmdn037,pmdn038,pmdn039 
         INTO g_pmdn_m.pmdndocno,g_pmdn_m.pmdnseq,g_pmdn_m.pmdn027,g_pmdn_m.pmdn028,g_pmdn_m.pmdn029,g_pmdn_m.pmdn030,g_pmdn_m.pmdn025,g_pmdn_m.pmdn026,g_pmdn_m.pmdn031,g_pmdn_m.pmdn032,g_pmdn_m.pmdn003,g_pmdn_m.pmdn033,g_pmdn_m.pmdn036,g_pmdn_m.pmdn037,g_pmdn_m.pmdn038,g_pmdn_m.pmdn039
         FROM pmdn_t 
         WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdndocno AND pmdnseq = g_pmdnseq
       
       CALL apmt500_04_pmdn028_ref()
       CALL apmt500_04_pmdn029_ref()
       CALL apmt500_04_pmdn025_ref()
       CALL apmt500_04_pmdn026_ref()
       CALL apmt500_04_pmdn031_ref()
       CALL apmt500_04_pmdn003_ref()
       
       DISPLAY BY NAME g_pmdn_m.pmdndocno,g_pmdn_m.pmdnseq,g_pmdn_m.pmdn027,g_pmdn_m.pmdn028,g_pmdn_m.pmdn028_desc,g_pmdn_m.pmdn029,g_pmdn_m.pmdn029_desc,g_pmdn_m.pmdn030,g_pmdn_m.pmdn025,g_pmdn_m.pmdn025_desc,g_pmdn_m.oofb017,g_pmdn_m.pmdn026,g_pmdn_m.pmdn026_desc,g_pmdn_m.oofb017_1,g_pmdn_m.pmdn031,g_pmdn_m.pmdn031_desc,g_pmdn_m.pmdn032,g_pmdn_m.pmdn003,g_pmdn_m.pmdn003_desc,g_pmdn_m.pmdn033,g_pmdn_m.pmdn036,g_pmdn_m.pmdn037,g_pmdn_m.pmdn038,g_pmdn_m.pmdn039
           
END FUNCTION

PRIVATE FUNCTION apmt500_04_set_entry()
       
       CALL cl_set_comp_entry("pmdn030",TRUE)
       
END FUNCTION

PRIVATE FUNCTION apmt500_04_set_no_entry()
DEFINE l_pmdn001   LIKE pmdn_t.pmdn001
DEFINE l_imaf061   LIKE imaf_t.imaf061

       LET l_pmdn001 = ''
       SELECT pmdn001 INTO l_pmdn001 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdndocno AND pmdnseq = g_pmdnseq

       #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
       IF NOT cl_null(l_pmdn001) THEN
          LET l_imaf061 = ''
          SELECT imaf061 INTO l_imaf061 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn001
          IF l_imaf061 = '2' THEN
             LET g_pmdn_m.pmdn030 = ''
             CALL cl_set_comp_entry("pmdn030",FALSE)
          END IF
       END IF
       
END FUNCTION
#
PRIVATE FUNCTION apmt500_04_pmdn025_chk(p_site,p_pmdn025)
DEFINE p_site      LIKE ooef_t.ooef001
DEFINE p_pmdn025   LIKE pmdn_t.pmdn025
DEFINE l_ooef012   LIKE ooef_t.ooef012
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdn025) THEN 
          #先判斷是否存在與對應庫位的聯絡地址檔中
          LET l_n = 0
          LET l_ooef012 = ''
          IF (NOT cl_null(p_site)) AND (NOT cl_null(g_pmdn_m.pmdn028)) THEN
             SELECT inaa004 INTO l_ooef012 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = p_site AND inaa001 = g_pmdn_m.pmdn028
           
             SELECT COUNT(*) INTO l_n FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_ooef012 AND oofb019 = p_pmdn025 AND oofbstus = 'Y' AND oofb008 = '3'
          END IF
          IF l_n = 0 THEN
             #若不存在與對應庫位的聯絡地址檔中，在判斷是否存在與對應營運據點聯絡地址檔中，若都不存在，則報錯
             LET l_ooef012 = ''
             IF NOT cl_null(p_site) THEN
                SELECT ooef012 INTO l_ooef012 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site
                SELECT COUNT(*) INTO l_n FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_ooef012 AND oofb019 = p_pmdn025 AND oofbstus = 'Y' AND oofb008 = '3'
                IF l_n = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00216'
                   LET g_errparam.extend = p_pmdn025
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET r_success = FALSE
                   RETURN r_success
                END IF
             END IF
          END IF
       END IF 
       RETURN r_success
       
END FUNCTION

PRIVATE FUNCTION apmt500_04_pmdn025_ref()
       SELECT oofb011 INTO g_pmdn_m.pmdn025_desc FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = g_oofa001 AND oofb002 = '3' AND oofb019 = g_pmdn_m.pmdn025
       DISPLAY BY NAME g_pmdn_m.pmdn025_desc
       
END FUNCTION

PRIVATE FUNCTION apmt500_04_pmdn026_ref()
       SELECT oofb011 INTO g_pmdn_m.pmdn026_desc FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = g_oofa001 AND oofb002 = '5' AND oofb019 = g_pmdn_m.pmdn026
       DISPLAY BY NAME g_pmdn_m.pmdn026_desc
       
END FUNCTION

PRIVATE FUNCTION apmt500_04_pmdn028_ref()
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_pmdn_m.pmdn028
       CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
       LET g_pmdn_m.pmdn028_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_pmdn_m.pmdn028_desc

END FUNCTION

PRIVATE FUNCTION apmt500_04_pmdn029_ref()
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_pmdn_m.pmdn029
       CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001='"||g_pmdn_m.pmdn028||"' AND inab002=?  ","") RETURNING g_rtn_fields
       LET g_pmdn_m.pmdn029_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_pmdn_m.pmdn029_desc
       
END FUNCTION

PRIVATE FUNCTION apmt500_04_pmdn003_ref()
 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_pmdn_m.pmdn003
        CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_pmdn_m.pmdn003_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_pmdn_m.pmdn003_desc
         
END FUNCTION

PRIVATE FUNCTION apmt500_04_pmdn031_ref()
 
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_pmdn_m.pmdn031
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_pmdn_m.pmdn031_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_pmdn_m.pmdn031_desc

END FUNCTION

 
{</section>}
 
