#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt510_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-09-01 17:55:30), PR版次:0004(2016-04-11 16:27:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000139
#+ Filename...: apmt510_02
#+ Description: 維護採購其他資訊作業
#+ Creator....: 02750(2014-03-28 15:37:11)
#+ Modifier...: 01588 -SD/PR- 07900
 
{</section>}
 
{<section id="apmt510_02.global" >}
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
PRIVATE type type_g_pmeg_m        RECORD
       pmeg900 LIKE pmeg_t.pmeg900, 
   pmegdocno LIKE pmeg_t.pmegdocno, 
   pmegseq LIKE pmeg_t.pmegseq, 
   pmeg027 LIKE pmeg_t.pmeg027, 
   pmeg028 LIKE pmeg_t.pmeg028, 
   pmeg028_desc LIKE type_t.chr80, 
   pmeg029 LIKE pmeg_t.pmeg029, 
   pmeg029_desc LIKE type_t.chr80, 
   pmeg030 LIKE pmeg_t.pmeg030, 
   pmeg053 LIKE pmeg_t.pmeg053, 
   pmeg025 LIKE pmeg_t.pmeg025, 
   pmeg025_desc LIKE type_t.chr80, 
   oofb017 LIKE type_t.chr500, 
   pmeg026 LIKE pmeg_t.pmeg026, 
   pmeg026_desc LIKE type_t.chr80, 
   oofb017_1 LIKE type_t.chr500, 
   pmeg031 LIKE pmeg_t.pmeg031, 
   pmeg031_desc LIKE type_t.chr80, 
   pmeg032 LIKE pmeg_t.pmeg032, 
   pmeg003 LIKE pmeg_t.pmeg003, 
   pmeg003_desc LIKE type_t.chr80, 
   pmeg033 LIKE pmeg_t.pmeg033, 
   pmeg036 LIKE pmeg_t.pmeg036, 
   pmeg037 LIKE pmeg_t.pmeg037, 
   pmeg038 LIKE pmeg_t.pmeg038, 
   pmeg039 LIKE pmeg_t.pmeg039
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_pmegdocno    LIKE pmeg_t.pmegdocno
DEFINE g_pmegseq      LIKE pmeg_t.pmegseq
DEFINE g_pmeg900      LIKE pmeg_t.pmeg900

DEFINE g_pmeg_m_t     type_g_pmeg_m
DEFINE g_bgjob        LIKE type_t.chr1
DEFINE g_oofa001      LIKE oofa_t.oofa001
#end add-point
 
DEFINE g_pmeg_m        type_g_pmeg_m
 
   DEFINE g_pmeg900_t LIKE pmeg_t.pmeg900
DEFINE g_pmegdocno_t LIKE pmeg_t.pmegdocno
DEFINE g_pmegseq_t LIKE pmeg_t.pmegseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmt510_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt510_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmegdocno,p_pmegseq,p_pmeg900
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
   DEFINE p_pmegdocno     LIKE pmeg_t.pmegdocno
   DEFINE p_pmegseq       LIKE pmeg_t.pmegseq
   DEFINE p_pmeg900       LIKE pmeg_t.pmeg900

   DEFINE l_forupd_sql    STRING
   DEFINE l_pmee004       LIKE pmee_t.pmee004
   DEFINE l_pmeg001       LIKE pmeg_t.pmeg001
   DEFINE l_pmeg002       LIKE pmeg_t.pmeg002
   DEFINE l_imaf062       LIKE imaf_t.imaf062
   DEFINE l_pmegunit      LIKE pmeg_t.pmegunit
   DEFINE l_pmegorga      LIKE pmeg_t.pmegorga
   DEFINE l_ooef012       LIKE ooef_t.ooef012   
   DEFINE l_oofb002       LIKE oofb_t.oofb002
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt510_02 WITH FORM cl_ap_formpath("apm","apmt510_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('pmeg032','2056')

   LET g_pmegdocno = p_pmegdocno
   LET g_pmegseq = p_pmegseq
   LET g_pmeg900 = p_pmeg900

   INITIALIZE g_pmeg_m.* LIKE pmeg_t.*

   CALL apmt510_02_pmeg_ref()  #帶值

   INITIALIZE g_pmeg_m_t.* TO NULL
   LET g_pmeg_m_t.* = g_pmeg_m.*
   
   LET p_cmd = 'u'
   LET l_forupd_sql = "SELECT pmeg900,pmegdocno,pmegseq,pmeg027,pmeg028,'',pmeg029,'', ", 
                      "       pmeg030,pmeg025,'','',pmeg026,'','',pmeg031,'',pmeg032,   ",
                      "       pmeg003,'',pmeg033,pmeg036,pmeg037,pmeg038,pmeg039 ",   
                      "  FROM pmeg_t ",
                      " WHERE pmegent=? ",
                      "   AND pmegdocno=? AND pmeg900=? AND pmegseq=? FOR UPDATE "
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   DECLARE apmt510_02_cl CURSOR FROM l_forupd_sql   
   
   DISPLAY BY NAME g_pmeg_m.pmeg900,g_pmeg_m.pmegdocno,g_pmeg_m.pmegseq,g_pmeg_m.pmeg027,g_pmeg_m.pmeg028,
                   g_pmeg_m.pmeg028_desc,g_pmeg_m.pmeg029,g_pmeg_m.pmeg029_desc,g_pmeg_m.pmeg030, 
                   g_pmeg_m.pmeg025,g_pmeg_m.pmeg025_desc,g_pmeg_m.oofb017,g_pmeg_m.pmeg026,g_pmeg_m.pmeg026_desc, 
                   g_pmeg_m.oofb017_1,g_pmeg_m.pmeg031,g_pmeg_m.pmeg031_desc,g_pmeg_m.pmeg032,g_pmeg_m.pmeg003,
                   g_pmeg_m.pmeg003_desc,g_pmeg_m.pmeg033,g_pmeg_m.pmeg036,g_pmeg_m.pmeg037,
                   g_pmeg_m.pmeg038,g_pmeg_m.pmeg039 

   #獲取當前營運據點的聯絡對象識別碼
   LET g_oofa001 = ''
   #2015/05/18 by stellar modify ----- (S)
#   SELECT oofa001 INTO g_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
   SELECT ooef012 INTO g_oofa001 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #2015/05/18 by stellar modify ----- (E)
   
   LET l_pmee004 = ''
   LET l_pmeg001 = ''
   LET l_pmeg002 = ''
   #獲得供應商編號、料件編號、產品特徵
   SELECT pmee004 INTO l_pmee004 FROM pmee_t     
    WHERE pmeeent = g_enterprise 
      AND pmeedocno = p_pmegdocno AND pmee900 = p_pmeg900

   SELECT pmeg001,pmeg002 INTO l_pmeg001,l_pmeg002     
     FROM pmeg_t 
    WHERE pmegent = g_enterprise 
      AND pmegdocno = g_pmegdocno AND pmegseq = g_pmegseq AND pmeg900 = p_pmeg900
      
      
   LET l_pmegunit = ''
   #獲得收貨據點
   SELECT pmegunit,pmegorga INTO l_pmegunit,l_pmegorga 
     FROM pmeg_t 
    WHERE pmegent = g_enterprise 
      AND pmegdocno = g_pmegdocno AND pmegseq = g_pmegseq AND pmeg900 = p_pmeg900
   IF cl_null(l_pmegunit) THEN
      LET l_pmegunit = g_site
   END IF

   CALL apmt510_02_set_entry()
   CALL apmt510_02_set_no_required()
   CALL apmt510_02_set_required()
   CALL apmt510_02_set_no_entry()      
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pmeg_m.pmeg900,g_pmeg_m.pmegdocno,g_pmeg_m.pmegseq,g_pmeg_m.pmeg027,g_pmeg_m.pmeg028, 
          g_pmeg_m.pmeg029,g_pmeg_m.pmeg030,g_pmeg_m.pmeg053,g_pmeg_m.pmeg025,g_pmeg_m.oofb017,g_pmeg_m.pmeg026, 
          g_pmeg_m.oofb017_1,g_pmeg_m.pmeg031,g_pmeg_m.pmeg032,g_pmeg_m.pmeg003,g_pmeg_m.pmeg033,g_pmeg_m.pmeg036, 
          g_pmeg_m.pmeg037,g_pmeg_m.pmeg038,g_pmeg_m.pmeg039 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"

            IF p_cmd ='u' THEN

               CALL s_transaction_begin()

               OPEN apmt510_02_cl USING g_enterprise,g_pmegdocno,g_pmeg900,g_pmegseq
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN apmt510_02_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE apmt510_02_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
               
               #鎖住將被更改或取消的資料               
               FETCH apmt510_02_cl INTO g_pmeg_m.pmeg900,g_pmeg_m.pmegdocno,g_pmeg_m.pmegseq,g_pmeg_m.pmeg027,
                                        g_pmeg_m.pmeg028,g_pmeg_m.pmeg028_desc,g_pmeg_m.pmeg029,g_pmeg_m.pmeg029_desc,
                                        g_pmeg_m.pmeg030,g_pmeg_m.pmeg025,g_pmeg_m.pmeg025_desc,g_pmeg_m.oofb017,
                                        g_pmeg_m.pmeg026,g_pmeg_m.pmeg026_desc,g_pmeg_m.oofb017_1,g_pmeg_m.pmeg031,
                                        g_pmeg_m.pmeg031_desc,g_pmeg_m.pmeg032,g_pmeg_m.pmeg003,g_pmeg_m.pmeg003_desc,
                                        g_pmeg_m.pmeg033,g_pmeg_m.pmeg036,g_pmeg_m.pmeg037,
                                        g_pmeg_m.pmeg038,g_pmeg_m.pmeg039    
               #資料被他人LOCK, 或是sql執行時出現錯誤
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmeg_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CLOSE apmt510_02_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF                                        

            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg900
            #add-point:BEFORE FIELD pmeg900 name="input.b.pmeg900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg900
            
            #add-point:AFTER FIELD pmeg900 name="input.a.pmeg900"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmeg_m.pmegdocno) AND NOT cl_null(g_pmeg_m.pmegseq) AND NOT cl_null(g_pmeg_m.pmeg900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmeg_m.pmegdocno != g_pmegdocno_t  OR g_pmeg_m.pmegseq != g_pmegseq_t  OR g_pmeg_m.pmeg900 != g_pmeg900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmeg_t WHERE "||"pmegent = '" ||g_enterprise|| "' AND "||"pmegdocno = '"||g_pmeg_m.pmegdocno ||"' AND "|| "pmegseq = '"||g_pmeg_m.pmegseq ||"' AND "|| "pmeg900 = '"||g_pmeg_m.pmeg900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg900
            #add-point:ON CHANGE pmeg900 name="input.g.pmeg900"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmegdocno
            #add-point:BEFORE FIELD pmegdocno name="input.b.pmegdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmegdocno
            
            #add-point:AFTER FIELD pmegdocno name="input.a.pmegdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmeg_m.pmegdocno) AND NOT cl_null(g_pmeg_m.pmegseq) AND NOT cl_null(g_pmeg_m.pmeg900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmeg_m.pmegdocno != g_pmegdocno_t  OR g_pmeg_m.pmegseq != g_pmegseq_t  OR g_pmeg_m.pmeg900 != g_pmeg900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmeg_t WHERE "||"pmegent = '" ||g_enterprise|| "' AND "||"pmegdocno = '"||g_pmeg_m.pmegdocno ||"' AND "|| "pmegseq = '"||g_pmeg_m.pmegseq ||"' AND "|| "pmeg900 = '"||g_pmeg_m.pmeg900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmegdocno
            #add-point:ON CHANGE pmegdocno name="input.g.pmegdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmegseq
            #add-point:BEFORE FIELD pmegseq name="input.b.pmegseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmegseq
            
            #add-point:AFTER FIELD pmegseq name="input.a.pmegseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmeg_m.pmegdocno) AND NOT cl_null(g_pmeg_m.pmegseq) AND NOT cl_null(g_pmeg_m.pmeg900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmeg_m.pmegdocno != g_pmegdocno_t  OR g_pmeg_m.pmegseq != g_pmegseq_t  OR g_pmeg_m.pmeg900 != g_pmeg900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmeg_t WHERE "||"pmegent = '" ||g_enterprise|| "' AND "||"pmegdocno = '"||g_pmeg_m.pmegdocno ||"' AND "|| "pmegseq = '"||g_pmeg_m.pmegseq ||"' AND "|| "pmeg900 = '"||g_pmeg_m.pmeg900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmegseq
            #add-point:ON CHANGE pmegseq name="input.g.pmegseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg027
            
            #add-point:AFTER FIELD pmeg027 name="input.a.pmeg027"
            IF NOT cl_null(g_pmeg_m.pmeg027) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_pmee004
               LET g_chkparam.arg2 = l_pmeg001
               LET g_chkparam.arg3 = l_pmeg002
               LET g_chkparam.arg4 = g_pmeg_m.pmeg027
               #160318-00025#17 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00261:sub-01302|apmi120|",cl_get_progname("apmi120",g_lang,"2"),"|:EXEPROGapmi120"
               #160318-00025#17 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmao004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmeg_m.pmeg027 = g_pmeg_m_t.pmeg027                  
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg027
            #add-point:BEFORE FIELD pmeg027 name="input.b.pmeg027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg027
            #add-point:ON CHANGE pmeg027 name="input.g.pmeg027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg028
            
            #add-point:AFTER FIELD pmeg028 name="input.a.pmeg028"
            CALL apmt510_01_pmeg028_ref()
            IF NOT cl_null(g_pmeg_m.pmeg028) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_pmegunit
               LET g_chkparam.arg2 = g_pmeg_m.pmeg028
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmeg_m.pmeg028 = g_pmeg_m_t.pmeg028                  
                  CALL apmt510_01_pmeg028_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg028
            #add-point:BEFORE FIELD pmeg028 name="input.b.pmeg028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg028
            #add-point:ON CHANGE pmeg028 name="input.g.pmeg028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg029
            
            #add-point:AFTER FIELD pmeg029 name="input.a.pmeg029"
            IF NOT cl_null(g_pmeg_m.pmeg029) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_pmegunit
               LET g_chkparam.arg2 = g_pmeg_m.pmeg028
               LET g_chkparam.arg3 = g_pmeg_m.pmeg029
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inab002_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmeg_m.pmeg029 = g_pmeg_m_t.pmeg029                  
                  CALL apmt510_01_pmeg029_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg029
            #add-point:BEFORE FIELD pmeg029 name="input.b.pmeg029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg029
            #add-point:ON CHANGE pmeg029 name="input.g.pmeg029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg030
            #add-point:BEFORE FIELD pmeg030 name="input.b.pmeg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg030
            
            #add-point:AFTER FIELD pmeg030 name="input.a.pmeg030"

            LET l_imaf062 = ''
            SELECT imaf062 INTO l_imaf062 FROM imaf_t 
             WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmeg001

            #判斷[T:料件據點進銷存檔].[C:批號自動編碼]是否有勾選，若勾選自動編碼時需,呼叫命名規則產生的應用元件產生批號
            IF l_imaf062 = 'Y' THEN
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg030
            #add-point:ON CHANGE pmeg030 name="input.g.pmeg030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg053
            #add-point:BEFORE FIELD pmeg053 name="input.b.pmeg053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg053
            
            #add-point:AFTER FIELD pmeg053 name="input.a.pmeg053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg053
            #add-point:ON CHANGE pmeg053 name="input.g.pmeg053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg025
            
            #add-point:AFTER FIELD pmeg025 name="input.a.pmeg025"
            CALL apmt510_01_pmeg025_ref()
            
            IF NOT cl_null(g_pmeg_m.pmeg025) THEN
               IF NOT apmt510_02_pmeg025_chk(l_pmegunit,g_pmeg_m.pmeg025) THEN
                  LET g_pmeg_m.pmeg025 = g_pmeg_m_t.pmeg025
                  CALL apmt510_01_pmeg025_ref()
                  NEXT FIELD CURRENT
               END IF            
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg025
            #add-point:BEFORE FIELD pmeg025 name="input.b.pmeg025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg025
            #add-point:ON CHANGE pmeg025 name="input.g.pmeg025"
            
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
         AFTER FIELD pmeg026
            
            #add-point:AFTER FIELD pmeg026 name="input.a.pmeg026"
            CALL apmt510_01_pmeg026_ref()
            
            IF NOT cl_null(g_pmeg_m.pmeg026) THEN 
               LET l_oofb002 = ''
               SELECT ooef012 INTO l_oofb002 FROM ooef_t 
                WHERE ooefent = g_enterprise AND ooef001 = l_pmegorga
               
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_oofb002
               LET g_chkparam.arg2 = g_pmeg_m.pmeg026
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
               #160318-00025#17  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oofb019_2") THEN               
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmeg_m.pmeg026 = g_pmeg_m_t.pmeg026   
                  CALL apmt510_01_pmeg026_ref()                  
                  NEXT FIELD CURRENT
               END IF
            

            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg026
            #add-point:BEFORE FIELD pmeg026 name="input.b.pmeg026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg026
            #add-point:ON CHANGE pmeg026 name="input.g.pmeg026"
            
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
         AFTER FIELD pmeg031
            
            #add-point:AFTER FIELD pmeg031 name="input.a.pmeg031"
            CALL apmt510_01_pmeg031_ref()
            
            IF NOT cl_null(g_pmeg_m.pmeg031) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmeg_m.pmeg031
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_263") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmeg_m.pmeg031 = g_pmeg_m_t.pmeg031                  
                  CALL apmt510_01_pmeg031_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg031
            #add-point:BEFORE FIELD pmeg031 name="input.b.pmeg031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg031
            #add-point:ON CHANGE pmeg031 name="input.g.pmeg031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg032
            #add-point:BEFORE FIELD pmeg032 name="input.b.pmeg032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg032
            
            #add-point:AFTER FIELD pmeg032 name="input.a.pmeg032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg032
            #add-point:ON CHANGE pmeg032 name="input.g.pmeg032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg003
            
            #add-point:AFTER FIELD pmeg003 name="input.a.pmeg003"
            CALL apmt510_01_pmeg003_ref()
            
            IF NOT cl_null(g_pmeg_m.pmeg003) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmeg_m.pmeg003
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#17  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmeg_m.pmeg003 = g_pmeg_m_t.pmeg003                  
                  CALL apmt510_01_pmeg003_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg003
            #add-point:BEFORE FIELD pmeg003 name="input.b.pmeg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg003
            #add-point:ON CHANGE pmeg003 name="input.g.pmeg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmeg_m.pmeg033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmeg033
            END IF 
 
 
 
            #add-point:AFTER FIELD pmeg033 name="input.a.pmeg033"
            IF NOT cl_null(g_pmeg_m.pmeg033) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg033
            #add-point:BEFORE FIELD pmeg033 name="input.b.pmeg033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg033
            #add-point:ON CHANGE pmeg033 name="input.g.pmeg033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg036
            #add-point:BEFORE FIELD pmeg036 name="input.b.pmeg036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg036
            
            #add-point:AFTER FIELD pmeg036 name="input.a.pmeg036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg036
            #add-point:ON CHANGE pmeg036 name="input.g.pmeg036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg037
            #add-point:BEFORE FIELD pmeg037 name="input.b.pmeg037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg037
            
            #add-point:AFTER FIELD pmeg037 name="input.a.pmeg037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg037
            #add-point:ON CHANGE pmeg037 name="input.g.pmeg037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg038
            #add-point:BEFORE FIELD pmeg038 name="input.b.pmeg038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg038
            
            #add-point:AFTER FIELD pmeg038 name="input.a.pmeg038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg038
            #add-point:ON CHANGE pmeg038 name="input.g.pmeg038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeg039
            #add-point:BEFORE FIELD pmeg039 name="input.b.pmeg039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeg039
            
            #add-point:AFTER FIELD pmeg039 name="input.a.pmeg039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeg039
            #add-point:ON CHANGE pmeg039 name="input.g.pmeg039"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmeg900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg900
            #add-point:ON ACTION controlp INFIELD pmeg900 name="input.c.pmeg900"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmegdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmegdocno
            #add-point:ON ACTION controlp INFIELD pmegdocno name="input.c.pmegdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmegseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmegseq
            #add-point:ON ACTION controlp INFIELD pmegseq name="input.c.pmegseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg027
            #add-point:ON ACTION controlp INFIELD pmeg027 name="input.c.pmeg027"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_pmee004
            LET g_qryparam.arg2 = l_pmeg001
            LET g_qryparam.arg3 = l_pmeg002
            
            CALL q_pmao004_1()                                #呼叫開窗

            LET g_pmeg_m.pmeg027 = g_qryparam.return1              

            DISPLAY g_pmeg_m.pmeg027 TO pmeg027              #

            NEXT FIELD pmeg027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmeg028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg028
            #add-point:ON ACTION controlp INFIELD pmeg028 name="input.c.pmeg028"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_pmegunit

            
            CALL q_inaa001_6()                                #呼叫開窗

            LET g_pmeg_m.pmeg028 = g_qryparam.return1              

            DISPLAY g_pmeg_m.pmeg028 TO pmeg028              #

	        CALL apmt510_01_pmeg028_ref()
            NEXT FIELD pmeg028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmeg029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg029
            #add-point:ON ACTION controlp INFIELD pmeg029 name="input.c.pmeg029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_pmegunit
            LET g_qryparam.arg2 = g_pmeg_m.pmeg028
            
            CALL q_inab002_6()                                #呼叫開窗

            LET g_pmeg_m.pmeg029 = g_qryparam.return1              

            DISPLAY g_pmeg_m.pmeg029 TO pmeg029              #

            CALL apmt510_01_pmeg029_ref()
            NEXT FIELD pmeg029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmeg030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg030
            #add-point:ON ACTION controlp INFIELD pmeg030 name="input.c.pmeg030"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg053
            #add-point:ON ACTION controlp INFIELD pmeg053 name="input.c.pmeg053"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg025
            #add-point:ON ACTION controlp INFIELD pmeg025 name="input.c.pmeg025"
            MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
               ON ACTION open_ooef   #營運據點
                  LET g_bgjob = '1'
                  EXIT MENU

               ON ACTION open_inaa   #庫位
                  LET g_bgjob = '2'
                  EXIT MENU
            END MENU
            
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg025             #給予default值

            #給予arg
            LET l_ooef012 = ''
            IF g_bgjob = '1' THEN
               SELECT ooef012 INTO l_ooef012 FROM ooef_t 
                WHERE ooefent = g_enterprise AND ooef001 = l_pmegunit
            ELSE
               SELECT inaa004 INTO l_ooef012 FROM inaa_t 
                WHERE inaaent = g_enterprise AND inaasite = l_pmegunit AND inaa001 = g_pmeg_m.pmeg028
            END IF
            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '3' "
            
            CALL q_oofb019_1()                                #呼叫開窗

            LET g_pmeg_m.pmeg025 = g_qryparam.return1              

            DISPLAY g_pmeg_m.pmeg025 TO pmeg025              #

            CALL apmt510_01_pmeg025_ref()
            NEXT FIELD pmeg025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oofb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb017
            #add-point:ON ACTION controlp INFIELD oofb017 name="input.c.oofb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg026
            #add-point:ON ACTION controlp INFIELD pmeg026 name="input.c.pmeg026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '5' "
            
            CALL q_oofb019_1()                                #呼叫開窗

            LET g_pmeg_m.pmeg026 = g_qryparam.return1              

            DISPLAY g_pmeg_m.pmeg026 TO pmeg026              #

            CALL apmt510_01_pmeg026_ref()
            NEXT FIELD pmeg026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oofb017_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb017_1
            #add-point:ON ACTION controlp INFIELD oofb017_1 name="input.c.oofb017_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg031
            #add-point:ON ACTION controlp INFIELD pmeg031 name="input.c.pmeg031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "263"
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_pmeg_m.pmeg031 = g_qryparam.return1              

            DISPLAY g_pmeg_m.pmeg031 TO pmeg031              #

            CALL apmt510_01_pmeg031_ref()
            NEXT FIELD pmeg031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmeg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg032
            #add-point:ON ACTION controlp INFIELD pmeg032 name="input.c.pmeg032"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg003
            #add-point:ON ACTION controlp INFIELD pmeg003 name="input.c.pmeg003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmeg_m.pmeg003             #給予default值
            LET g_qryparam.default2 = "" #g_pmeg_m.imaal003 #品名
            #給予arg
            
           #CALL q_imaa001_3()                                #呼叫開窗
            CALL q_imaf001_5()
            
            LET g_pmeg_m.pmeg003 = g_qryparam.return1              
            #LET g_pmeg_m.imaal003 = g_qryparam.return2 
            DISPLAY g_pmeg_m.pmeg003 TO pmeg003              #
            #DISPLAY g_pmeg_m.imaal003 TO imaal003 #品名
            
            CALL apmt510_01_pmeg003_ref()
            NEXT FIELD pmeg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmeg033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg033
            #add-point:ON ACTION controlp INFIELD pmeg033 name="input.c.pmeg033"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg036
            #add-point:ON ACTION controlp INFIELD pmeg036 name="input.c.pmeg036"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg037
            #add-point:ON ACTION controlp INFIELD pmeg037 name="input.c.pmeg037"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg038
            #add-point:ON ACTION controlp INFIELD pmeg038 name="input.c.pmeg038"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeg039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeg039
            #add-point:ON ACTION controlp INFIELD pmeg039 name="input.c.pmeg039"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"

            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()   #錯誤訊息統整顯示

            UPDATE pmeg_t SET (pmeg027,pmeg028,pmeg029,pmeg030,pmeg025,pmeg026,pmeg031,pmeg032,pmeg003,pmeg033,
                               pmeg036,pmeg037,pmeg038,pmeg039)                              
                            = (g_pmeg_m.pmeg027,g_pmeg_m.pmeg028,g_pmeg_m.pmeg029,g_pmeg_m.pmeg030,
                               g_pmeg_m.pmeg025,g_pmeg_m.pmeg026,g_pmeg_m.pmeg031,g_pmeg_m.pmeg032,
                               g_pmeg_m.pmeg003,g_pmeg_m.pmeg033,g_pmeg_m.pmeg036,
                               g_pmeg_m.pmeg037,g_pmeg_m.pmeg038,g_pmeg_m.pmeg039)                               
             WHERE pmegent = g_enterprise 
               AND pmegdocno = g_pmegdocno
               AND pmegseq = g_pmegseq
               AND pmeg900 = g_pmeg900
              
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmeg_t"
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
   LET INT_FLAG = FALSE
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apmt510_02 
   
   #add-point:input段after input name="input.post_input"
  
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt510_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmt510_02.other_function" readonly="Y" >}

PRIVATE FUNCTION apmt510_02_pmeg_ref()
   
   SELECT pmeg900,pmegdocno,pmegseq,pmeg027,
          pmeg028,pmeg029,pmeg030,pmeg025,
          pmeg026,pmeg031,pmeg032,pmeg003,
          pmeg033,pmeg036,pmeg037,pmeg038,
          pmeg039
     INTO g_pmeg_m.pmeg900,g_pmeg_m.pmegdocno,g_pmeg_m.pmegseq,g_pmeg_m.pmeg027,
          g_pmeg_m.pmeg028,g_pmeg_m.pmeg029,g_pmeg_m.pmeg030,g_pmeg_m.pmeg025,
          g_pmeg_m.pmeg026,g_pmeg_m.pmeg031,g_pmeg_m.pmeg032,g_pmeg_m.pmeg003,
          g_pmeg_m.pmeg033,g_pmeg_m.pmeg036,g_pmeg_m.pmeg037,g_pmeg_m.pmeg038,
          g_pmeg_m.pmeg039
     FROM pmeg_t
    WHERE pmegent = g_enterprise 
      AND pmegdocno = g_pmegdocno      
      AND pmegseq = g_pmegseq
      AND pmeg900 = g_pmeg900
   
   CALL apmt510_01_pmeg028_ref()
   CALL apmt510_01_pmeg029_ref()  
   CALL apmt510_01_pmeg025_ref()  
   CALL apmt510_01_pmeg026_ref()
   CALL apmt510_01_pmeg031_ref()
   CALL apmt510_01_pmeg003_ref()
   
   DISPLAY BY NAME g_pmeg_m.pmeg900,g_pmeg_m.pmegdocno,g_pmeg_m.pmegseq,g_pmeg_m.pmeg027,g_pmeg_m.pmeg028,
                   g_pmeg_m.pmeg028_desc,g_pmeg_m.pmeg029,g_pmeg_m.pmeg029_desc,g_pmeg_m.pmeg030, 
                   g_pmeg_m.pmeg025,g_pmeg_m.pmeg025_desc,g_pmeg_m.oofb017,g_pmeg_m.pmeg026,g_pmeg_m.pmeg026_desc, 
                   g_pmeg_m.oofb017_1,g_pmeg_m.pmeg031,g_pmeg_m.pmeg031_desc,g_pmeg_m.pmeg032,g_pmeg_m.pmeg003,
                   g_pmeg_m.pmeg003_desc,g_pmeg_m.pmeg033,g_pmeg_m.pmeg036,g_pmeg_m.pmeg037,
                   g_pmeg_m.pmeg038,g_pmeg_m.pmeg039    

END FUNCTION

PRIVATE FUNCTION apmt510_02_set_entry()
       CALL cl_set_comp_entry("pmeg030",TRUE)
       CALL cl_set_comp_entry("pmeg053",TRUE)

END FUNCTION

PRIVATE FUNCTION apmt510_02_set_no_entry()
DEFINE l_pmeg001   LIKE pmeg_t.pmeg001
DEFINE l_imaf061   LIKE imaf_t.imaf061
DEFINE l_imaf055   LIKE imaf_t.imaf055

       LET l_pmeg001 = ''
       SELECT pmeg001 INTO l_pmeg001 
         FROM pmeg_t 
        WHERE pmegent = g_enterprise 
          AND pmegdocno = g_pmegdocno AND pmegseq = g_pmegseq AND pmeg900 = g_pmeg900

       IF NOT cl_null(l_pmeg001) THEN
          LET l_imaf061 = ''
          LET l_imaf055 = ''
          SELECT imaf061,imaf055 INTO l_imaf061,l_imaf055
            FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmeg001
          IF l_imaf061 NOT MATCHES '[12]' THEN
             CALL cl_set_comp_entry("pmeg030",FALSE)
          END IF
          
          IF l_imaf055 = '2' THEN
             CALL cl_set_comp_entry("pmeg053",FALSE)
          END IF
       END IF
       
END FUNCTION

PRIVATE FUNCTION apmt510_01_pmeg028_ref()
     
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_pmeg_m.pmeg028
     CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_pmeg_m.pmeg028_desc = '', g_rtn_fields[1] , ''
     
     DISPLAY BY NAME g_pmeg_m.pmeg028_desc
     
END FUNCTION

PRIVATE FUNCTION apmt510_01_pmeg029_ref()
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_pmeg_m.pmeg028
     LET g_ref_fields[2] = g_pmeg_m.pmeg029
     CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite = '"||g_site||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
     LET g_pmeg_m.pmeg029_desc = '', g_rtn_fields[1] , ''
     
     DISPLAY BY NAME g_pmeg_m.pmeg029_desc
            
END FUNCTION

PRIVATE FUNCTION apmt510_01_pmeg025_ref()
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_pmeg_m.pmeg025
     CALL ap_ref_array2(g_ref_fields,"SELECT oofb011 FROM oofb_t WHERE oofbent='"||g_enterprise||"' AND oofb019=? ","") RETURNING g_rtn_fields
     LET g_pmeg_m.pmeg025_desc = '', g_rtn_fields[1] , ''
     
     DISPLAY BY NAME g_pmeg_m.pmeg025_desc
            
END FUNCTION

PRIVATE FUNCTION apmt510_01_pmeg026_ref()
            
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_pmeg_m.pmeg026
     CALL ap_ref_array2(g_ref_fields,"SELECT oofb011 FROM oofb_t WHERE oofbent='"||g_enterprise||"' AND oofb019=? ","") RETURNING g_rtn_fields
     LET g_pmeg_m.pmeg026_desc = '', g_rtn_fields[1] , ''
     
     DISPLAY BY NAME g_pmeg_m.pmeg026_desc
            
END FUNCTION

PRIVATE FUNCTION apmt510_01_pmeg031_ref()
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_pmeg_m.pmeg031
     CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_pmeg_m.pmeg031_desc = '', g_rtn_fields[1] , ''
     
     DISPLAY BY NAME g_pmeg_m.pmeg031_desc
            
END FUNCTION

PRIVATE FUNCTION apmt510_01_pmeg003_ref()
            
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_pmeg_m.pmeg003
     CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_pmeg_m.pmeg003_desc = '', g_rtn_fields[1] , ''
     
     DISPLAY BY NAME g_pmeg_m.pmeg003_desc
            
END FUNCTION

PRIVATE FUNCTION apmt510_02_pmeg025_chk(p_pmegunit,p_pmeg025)
DEFINE p_pmegunit  LIKE pmeg_t.pmegunit
DEFINE p_pmeg025   LIKE pmeg_t.pmeg025
DEFINE l_ooef012   LIKE ooef_t.ooef012
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5

       LET r_success = TRUE

       IF NOT cl_null(p_pmeg025) THEN
          #先判斷是否存在與對應庫位的聯絡地址檔中
          LET l_n = 0
          LET l_ooef012 = ''
          IF (NOT cl_null(p_pmegunit)) AND (NOT cl_null(g_pmeg_m.pmeg028)) THEN
             SELECT inaa004 INTO l_ooef012 FROM inaa_t 
              WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_pmeg_m.pmeg028

             SELECT COUNT(*) INTO l_n FROM oofb_t 
              WHERE oofbent = g_enterprise 
                AND oofb002 = l_ooef012 
                AND oofb019 = p_pmeg025 AND oofbstus = 'Y' AND oofb008 = '3'
          END IF
          IF l_n = 0 THEN       
             #若不存在與對應庫位的聯絡地址檔中，在判斷是否存在與對應營運據點聯絡地址檔中，若都不存在，則報錯
             LET l_ooef012 = ''
             IF NOT cl_null(p_pmegunit) THEN
                SELECT ooef012 INTO l_ooef012 FROM ooef_t 
                 WHERE ooefent = g_enterprise AND ooef001 = p_pmegunit
                SELECT COUNT(*) INTO l_n FROM oofb_t 
                 WHERE oofbent = g_enterprise 
                   AND oofb002 = l_ooef012 AND oofb019 = p_pmeg025 AND oofbstus = 'Y' AND oofb008 = '3'
                IF l_n = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00216'
                   LET g_errparam.extend = p_pmeg025
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

PRIVATE FUNCTION apmt510_02_set_required()
DEFINE l_pmeg001   LIKE pmeg_t.pmeg001
DEFINE l_imaf055   LIKE imaf_t.imaf055

       LET l_pmeg001 = ''
       SELECT pmeg001 INTO l_pmeg001 
         FROM pmeg_t 
        WHERE pmegent = g_enterprise 
          AND pmegdocno = g_pmegdocno AND pmegseq = g_pmegseq AND pmeg900 = g_pmeg900

       IF NOT cl_null(l_pmeg001) THEN
          LET l_imaf055 = ''
          SELECT imaf055 INTO l_imaf055
            FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmeg001
          
          IF l_imaf055 = '1' THEN
             CALL cl_set_comp_required("pmeg053",TRUE)
          END IF
       END IF
END FUNCTION

PRIVATE FUNCTION apmt510_02_set_no_required()

   CALL cl_set_comp_required("pmeg053",FALSE)
END FUNCTION

 
{</section>}
 
