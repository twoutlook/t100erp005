#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt510_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-08-06 10:17:28), PR版次:0004(2016-11-11 16:30:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000155
#+ Filename...: axmt510_04
#+ Description: 維護訂單變更單其他資訊作業
#+ Creator....: 02040(2014-04-08 14:02:35)
#+ Modifier...: 02040 -SD/PR- 08992
 
{</section>}
 
{<section id="axmt510_04.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#17   2016/04/11   By 07900    校验代码的重复错误讯息修改
#161026-00025#2   2016/11/10  By lienjunqi 在呼叫v_pmao004前,增加一行轉換錯誤訊息apm-00260改為使用axm-00053
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
PRIVATE type type_g_xmeg_m        RECORD
       xmegdocno LIKE xmeg_t.xmegdocno, 
   xmegseq LIKE xmeg_t.xmegseq, 
   xmeg027 LIKE xmeg_t.xmeg027, 
   xmeg028 LIKE xmeg_t.xmeg028, 
   xmeg028_desc LIKE type_t.chr80, 
   xmeg029 LIKE xmeg_t.xmeg029, 
   xmeg029_desc LIKE type_t.chr80, 
   xmeg030 LIKE xmeg_t.xmeg030, 
   xmeg031 LIKE xmeg_t.xmeg031, 
   xmeg031_desc LIKE type_t.chr80, 
   xmeg032 LIKE xmeg_t.xmeg032, 
   xmeg003 LIKE xmeg_t.xmeg003, 
   xmeg003_desc LIKE type_t.chr80, 
   xmeg033 LIKE xmeg_t.xmeg033, 
   xmeg034 LIKE xmeg_t.xmeg034, 
   xmeg036 LIKE xmeg_t.xmeg036, 
   xmeg037 LIKE xmeg_t.xmeg037, 
   xmeg038 LIKE xmeg_t.xmeg038, 
   xmeg039 LIKE xmeg_t.xmeg039
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmegdocno     LIKE xmeg_t.xmegdocno
DEFINE g_xmegseq       LIKE xmeg_t.xmegseq
DEFINE g_xmeg900       LIKE xmeg_t.xmeg900
DEFINE g_xmeg027       LIKE xmeg_t.xmeg027
DEFINE g_xmeg_m_t      type_g_xmeg_m
DEFINE g_bgjob         LIKE type_t.chr1
DEFINE g_oofa001       LIKE oofa_t.oofa001
#end add-point
 
DEFINE g_xmeg_m        type_g_xmeg_m
 
   DEFINE g_xmegdocno_t LIKE xmeg_t.xmegdocno
DEFINE g_xmegseq_t LIKE xmeg_t.xmegseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmt510_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt510_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmegdocno,p_xmegseq,p_xmeg027,p_xmeg900
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
   DEFINE p_xmegdocno     LIKE xmeg_t.xmegdocno
   DEFINE p_xmegseq       LIKE xmeg_t.xmegseq
   DEFINE p_xmeg900       LIKE xmeg_t.xmeg900
   DEFINE p_xmeg027       LIKE xmeg_t.xmeg027   
   DEFINE l_forupd_sql    STRING
   DEFINE l_xmee004       LIKE xmee_t.xmee004
   DEFINE l_xmeg001       LIKE xmeg_t.xmeg001
   DEFINE l_xmeg002       LIKE xmeg_t.xmeg002
   DEFINE l_xmegorga      LIKE xmeg_t.xmegorga 
   DEFINE l_xmegunit      LIKE xmeg_t.xmegunit
   DEFINE l_ooef012       LIKE ooef_t.ooef012
   DEFINE l_imaf062       LIKE imaf_t.imaf062
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt510_04 WITH FORM cl_ap_formpath("axm","axmt510_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('xmeg032','2056')
   LET g_xmegdocno = p_xmegdocno
   LET g_xmegseq = p_xmegseq
   LET g_xmeg027 = p_xmeg027
   LET g_xmeg900 = p_xmeg900
   
   INITIALIZE g_xmeg_m.* LIKE xmeg_t.*
   
   CALL axmt510_04_xmegdocno_ref()  #帶值
   
   INITIALIZE g_xmeg_m_t.* TO NULL
   LET g_xmeg_m_t.* = g_xmeg_m.*
   
   LET p_cmd = 'u'
   LET l_forupd_sql = "SELECT xmegdocno,xmegseq,xmeg027,xmeg028,'',xmeg029,'',xmeg030,xmeg031,'',xmeg032,xmeg003,'',xmeg033,xmeg034,xmeg036,xmeg037,xmeg038,xmeg039 FROM xmeg_t WHERE xmegent= ? AND xmegdocno=? AND xmegseq = ? AND xmeg900=? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   DECLARE axmt510_04_cl CURSOR FROM l_forupd_sql
  
   DISPLAY BY NAME g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg027,g_xmeg_m.xmeg028,g_xmeg_m.xmeg028_desc,
                   g_xmeg_m.xmeg029,g_xmeg_m.xmeg029_desc,g_xmeg_m.xmeg030,g_xmeg_m.xmeg031,
                   g_xmeg_m.xmeg031_desc,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg003_desc,g_xmeg_m.xmeg033,
                   g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039
    
   #獲取當前營運據點的聯絡對象識別碼
   LET g_oofa001 = ''
   SELECT oofa001 INTO g_oofa001 FROM oofa_t 
    WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
   
   LET l_xmee004 = ''
   LET l_xmeg001 = ''
   LET l_xmeg002 = ''
   #獲得供應商編號、料件編號、產品特徵
   SELECT xmee004 INTO l_xmee004 FROM xmee_t 
    WHERE xmeeent = g_enterprise 
      AND xmeedocno = g_xmegdocno
      AND xmee900 = g_xmeg900
   
   SELECT xmeg001,xmeg002 INTO l_xmeg001,l_xmeg002 FROM xmeg_t 
    WHERE xmegent = g_enterprise 
      AND xmegdocno = g_xmegdocno 
      AND xmegseq = g_xmegseq
      AND xmeg900 = g_xmeg900
               
   
   LET l_xmegunit = ''
   #獲得收貨據點
   SELECT xmegunit,xmegorga INTO l_xmegunit,l_xmegorga FROM xmeg_t 
    WHERE xmegent = g_enterprise 
      AND xmegdocno = g_xmegdocno 
      AND xmegseq = g_xmegseq
      AND xmeg900 = g_xmeg900
   IF cl_null(l_xmegunit) THEN
      LET l_xmegunit = g_site
   END IF
   
   CALL axmt510_04_set_entry()
   CALL axmt510_04_set_no_entry()        
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg027,g_xmeg_m.xmeg028,g_xmeg_m.xmeg029, 
          g_xmeg_m.xmeg030,g_xmeg_m.xmeg031,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg033,g_xmeg_m.xmeg034, 
          g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039 ATTRIBUTE(WITHOUT DEFAULTS) 
 
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF p_cmd ='u' THEN
               
               CALL s_transaction_begin()
               
               OPEN axmt510_04_cl USING g_enterprise,g_xmegdocno,g_xmegseq,g_xmeg900
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axmt510_04_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axmt510_04_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
    
               #鎖住將被更改或取消的資料
               FETCH axmt510_04_cl INTO g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg027,g_xmeg_m.xmeg028,g_xmeg_m.xmeg028_desc,
                                        g_xmeg_m.xmeg029,g_xmeg_m.xmeg029_desc,g_xmeg_m.xmeg030,g_xmeg_m.xmeg031,
                                        g_xmeg_m.xmeg031_desc,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg003_desc,g_xmeg_m.xmeg033,
                                        g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039
            
               #資料被他人LOCK, 或是sql執行時出現錯誤
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmeg_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CLOSE axmt510_04_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmegdocno
            #add-point:BEFORE FIELD xmegdocno name="input.b.xmegdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmegdocno
            
            #add-point:AFTER FIELD xmegdocno name="input.a.xmegdocno"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmegdocno
            #add-point:ON CHANGE xmegdocno name="input.g.xmegdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmegseq
            #add-point:BEFORE FIELD xmegseq name="input.b.xmegseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmegseq
            
            #add-point:AFTER FIELD xmegseq name="input.a.xmegseq"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmegseq
            #add-point:ON CHANGE xmegseq name="input.g.xmegseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg027
            
            #add-point:AFTER FIELD xmeg027 name="input.a.xmeg027"
            IF NOT cl_null(g_xmeg_m.xmeg027) THEN 
               
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_xmee004
               LET g_chkparam.arg2 = l_xmeg001
               LET g_chkparam.arg3 = l_xmeg002
               LET g_chkparam.arg4 = g_xmeg_m.xmeg027  
               #160318-00025#17 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00261:sub-01302|apmi120|",cl_get_progname("apmi120",g_lang,"2"),"|:EXEPROGapmi120"
               #160318-00025#17 by 07900 --add-end 
               #161026-00025#2-s
               LET g_chkparam.err_str[2] ="apm-00260:axm-00053|axmi120|",cl_get_progname("axmi120",g_lang,"2"),"|:EXEPROGaxmi120"
               #161026-00025#2-e               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmao004") THEN
                  LET g_xmeg_m.xmeg027 = g_xmeg_m_t.xmeg027
                  DISPLAY BY NAME g_xmeg_m.xmeg027
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg027
            #add-point:BEFORE FIELD xmeg027 name="input.b.xmeg027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg027
            #add-point:ON CHANGE xmeg027 name="input.g.xmeg027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg028
            
            #add-point:AFTER FIELD xmeg028 name="input.a.xmeg028"
            CALL axmt510_04_xmeg028_ref()
            IF NOT cl_null(g_xmeg_m.xmeg028) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_xmegunit
               LET g_chkparam.arg2 = g_xmeg_m.xmeg028                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001_1") THEN
                  LET g_xmeg_m.xmeg028 = g_xmeg_m_t.xmeg028
                  DISPLAY BY NAME g_xmeg_m.xmeg028
                  CALL axmt510_04_xmeg028_ref()
                  NEXT FIELD CURRENT
               ELSE
                  IF NOT axmt510_04_xmeg029_chk() THEN
                     LET g_xmeg_m.xmeg028 = g_xmeg_m_t.xmeg028
                     DISPLAY BY NAME g_xmeg_m.xmeg028
                     CALL axmt510_04_xmeg028_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg028
            #add-point:BEFORE FIELD xmeg028 name="input.b.xmeg028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg028
            #add-point:ON CHANGE xmeg028 name="input.g.xmeg028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg029
            
            #add-point:AFTER FIELD xmeg029 name="input.a.xmeg029"
            CALL axmt510_04_xmeg028_ref()
            IF NOT cl_null(g_xmeg_m.xmeg029) THEN 
               IF NOT axmt510_04_xmeg029_chk() THEN
                  LET g_xmeg_m.xmeg029 = g_xmeg_m_t.xmeg029
                  DISPLAY BY NAME g_xmeg_m.xmeg028
                  CALL axmt510_04_xmeg029_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg029
            #add-point:BEFORE FIELD xmeg029 name="input.b.xmeg029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg029
            #add-point:ON CHANGE xmeg029 name="input.g.xmeg029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg030
            #add-point:BEFORE FIELD xmeg030 name="input.b.xmeg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg030
            
            #add-point:AFTER FIELD xmeg030 name="input.a.xmeg030"
            LET l_imaf062 = ''
            SELECT imaf062 INTO l_imaf062 FROM imaf_t 
             WHERE imafent = g_enterprise 
               AND imafsite = g_site 
               AND imaf001 = l_xmeg001
            
            #判斷[T:料件據點進銷存檔].[C:批號自動編碼]是否有勾選，若勾選自動編碼時需,呼叫命名規則產生的應用元件產生批號
            IF l_imaf062 = 'Y' THEN
            END IF
            #若輸入的料件+批號不存在[T:料件批號資料檔]時，則呼叫應用元件新增料件批號基本資料
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg030
            #add-point:ON CHANGE xmeg030 name="input.g.xmeg030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg031
            
            #add-point:AFTER FIELD xmeg031 name="input.a.xmeg031"
            CALL axmt510_04_xmeg031_ref()
            IF NOT cl_null(g_xmeg_m.xmeg031) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmeg_m.xmeg031

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oocq002_263") THEN
                  LET g_xmeg_m.xmeg031 = g_xmeg_m_t.xmeg031
                  CALL axmt510_04_xmeg031_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg031
            #add-point:BEFORE FIELD xmeg031 name="input.b.xmeg031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg031
            #add-point:ON CHANGE xmeg031 name="input.g.xmeg031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg032
            #add-point:BEFORE FIELD xmeg032 name="input.b.xmeg032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg032
            
            #add-point:AFTER FIELD xmeg032 name="input.a.xmeg032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg032
            #add-point:ON CHANGE xmeg032 name="input.g.xmeg032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg003
            
            #add-point:AFTER FIELD xmeg003 name="input.a.xmeg003"
            CALL axmt510_04_xmeg003_ref()
            IF NOT cl_null(g_xmeg_m.xmeg003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmeg_m.xmeg003
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_2") THEN
                  LET g_xmeg_m.xmeg003 = g_xmeg_m_t.xmeg003
                  CALL axmt510_04_xmeg003_ref()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg003
            #add-point:BEFORE FIELD xmeg003 name="input.b.xmeg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg003
            #add-point:ON CHANGE xmeg003 name="input.g.xmeg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmeg_m.xmeg033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD xmeg033
            END IF 
 
 
 
            #add-point:AFTER FIELD xmeg033 name="input.a.xmeg033"
            IF NOT cl_null(g_xmeg_m.xmeg033) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg033
            #add-point:BEFORE FIELD xmeg033 name="input.b.xmeg033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg033
            #add-point:ON CHANGE xmeg033 name="input.g.xmeg033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg034
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmeg_m.xmeg034,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD xmeg034
            END IF 
 
 
 
            #add-point:AFTER FIELD xmeg034 name="input.a.xmeg034"
            IF NOT cl_null(g_xmeg_m.xmeg034) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg034
            #add-point:BEFORE FIELD xmeg034 name="input.b.xmeg034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg034
            #add-point:ON CHANGE xmeg034 name="input.g.xmeg034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg036
            #add-point:BEFORE FIELD xmeg036 name="input.b.xmeg036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg036
            
            #add-point:AFTER FIELD xmeg036 name="input.a.xmeg036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg036
            #add-point:ON CHANGE xmeg036 name="input.g.xmeg036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg037
            #add-point:BEFORE FIELD xmeg037 name="input.b.xmeg037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg037
            
            #add-point:AFTER FIELD xmeg037 name="input.a.xmeg037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg037
            #add-point:ON CHANGE xmeg037 name="input.g.xmeg037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg038
            #add-point:BEFORE FIELD xmeg038 name="input.b.xmeg038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg038
            
            #add-point:AFTER FIELD xmeg038 name="input.a.xmeg038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg038
            #add-point:ON CHANGE xmeg038 name="input.g.xmeg038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg039
            #add-point:BEFORE FIELD xmeg039 name="input.b.xmeg039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg039
            
            #add-point:AFTER FIELD xmeg039 name="input.a.xmeg039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg039
            #add-point:ON CHANGE xmeg039 name="input.g.xmeg039"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmegdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmegdocno
            #add-point:ON ACTION controlp INFIELD xmegdocno name="input.c.xmegdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmegseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmegseq
            #add-point:ON ACTION controlp INFIELD xmegseq name="input.c.xmegseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg027
            #add-point:ON ACTION controlp INFIELD xmeg027 name="input.c.xmeg027"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmeg_m.xmeg027             #給予default值

            #給予arg

            IF cl_null(l_xmeg001) OR cl_null(l_xmeg002) THEN
               #給予arg
               LET g_qryparam.arg1 = l_xmee004 
               CALL q_pmao004_2()                                #呼叫開窗
            ELSE            
               #給予arg
               LET g_qryparam.arg1 = l_xmee004
               LET g_qryparam.arg2 = l_xmeg001
               LET g_qryparam.arg3 = l_xmeg002
               CALL q_pmao004_1()                                #呼叫開窗
            END IF

            LET g_xmeg_m.xmeg027 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmeg_m.xmeg027 TO xmeg027              #顯示到畫面上

            NEXT FIELD xmeg027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmeg028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg028
            #add-point:ON ACTION controlp INFIELD xmeg028 name="input.c.xmeg028"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmeg_m.xmeg028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #

            CALL q_inaa001_6()                                #呼叫開窗

            LET g_xmeg_m.xmeg028 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmeg_m.xmeg028 TO xmeg028              #顯示到畫面上

            NEXT FIELD xmeg028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmeg029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg029
            #add-point:ON ACTION controlp INFIELD xmeg029 name="input.c.xmeg029"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmeg_m.xmeg029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #
            LET g_qryparam.arg2 = g_xmeg_m.xmeg028 #

            CALL q_inab002_6()                                #呼叫開窗

            LET g_xmeg_m.xmeg029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmeg_m.xmeg029 TO xmeg029              #顯示到畫面上

            NEXT FIELD xmeg029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmeg030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg030
            #add-point:ON ACTION controlp INFIELD xmeg030 name="input.c.xmeg030"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg031
            #add-point:ON ACTION controlp INFIELD xmeg031 name="input.c.xmeg031"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmeg_m.xmeg031             #給予default值
          
            #給予arg
            LET g_qryparam.arg1 = "263" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_xmeg_m.xmeg031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmeg_m.xmeg031 TO xmeg031              #顯示到畫面上
            CALL axmt510_04_xmeg031_ref()

            NEXT FIELD xmeg031                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.xmeg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg032
            #add-point:ON ACTION controlp INFIELD xmeg032 name="input.c.xmeg032"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg003
            #add-point:ON ACTION controlp INFIELD xmeg003 name="input.c.xmeg003"
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            #給予arg

            CALL q_imaf001_3()                                #呼叫開窗

            LET g_xmeg_m.xmeg003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmeg_m.xmeg003 TO xmeg003              #顯示到畫面上
            CALL axmt510_04_xmeg003_ref()

            NEXT FIELD xmeg003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmeg033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg033
            #add-point:ON ACTION controlp INFIELD xmeg033 name="input.c.xmeg033"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg034
            #add-point:ON ACTION controlp INFIELD xmeg034 name="input.c.xmeg034"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg036
            #add-point:ON ACTION controlp INFIELD xmeg036 name="input.c.xmeg036"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg037
            #add-point:ON ACTION controlp INFIELD xmeg037 name="input.c.xmeg037"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg038
            #add-point:ON ACTION controlp INFIELD xmeg038 name="input.c.xmeg038"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg039
            #add-point:ON ACTION controlp INFIELD xmeg039 name="input.c.xmeg039"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            #單頭修改
            UPDATE xmeg_t 
               SET (xmeg027,xmeg028,xmeg029,xmeg030,xmeg031,xmeg032,xmeg003,xmeg033,xmeg034,xmeg036,xmeg037,xmeg038,xmeg039) = 
                   (g_xmeg_m.xmeg027,g_xmeg_m.xmeg028,g_xmeg_m.xmeg029,g_xmeg_m.xmeg030,g_xmeg_m.xmeg031,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg033,g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039)
             WHERE xmegent = g_enterprise AND xmegdocno = g_xmegdocno AND xmegseq = g_xmegseq AND xmeg900 = g_xmeg900
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmeg_t"
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
   CLOSE WINDOW w_axmt510_04 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt510_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt510_04.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt510_04_xmeg028_ref()
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_xmeg_m.xmeg028
       CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
       LET g_xmeg_m.xmeg028_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_xmeg_m.xmeg028_desc
END FUNCTION

PRIVATE FUNCTION axmt510_04_xmeg029_ref()
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_xmeg_m.xmeg029
       CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001='"||g_xmeg_m.xmeg028||"' AND inab002=?  ","") RETURNING g_rtn_fields
       LET g_xmeg_m.xmeg029_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_xmeg_m.xmeg029_desc
END FUNCTION

PRIVATE FUNCTION axmt510_04_set_entry()
       CALL cl_set_comp_entry("xmeg030",TRUE)
END FUNCTION

PRIVATE FUNCTION axmt510_04_set_no_entry()
DEFINE l_xmeg001   LIKE xmeg_t.xmeg001
DEFINE l_imaf061   LIKE imaf_t.imaf061

       LET l_xmeg001 = ''
       SELECT xmeg001 INTO l_xmeg001 FROM xmeg_t 
        WHERE xmegent = g_enterprise AND xmegdocno = g_xmegdocno 
          AND xmegseq = g_xmegseq AND xmeg900 = g_xmeg900

       IF NOT cl_null(l_xmeg001) THEN
          LET l_imaf061 = ''
          SELECT imaf061 INTO l_imaf061 FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_xmeg001
          IF l_imaf061 NOT MATCHES '[12]' THEN
             CALL cl_set_comp_entry("xmeg030",FALSE)
          END IF
       END IF
END FUNCTION
#帶值
PRIVATE FUNCTION axmt510_04_xmegdocno_ref()
      SELECT xmegdocno,xmegseq,xmeg027,xmeg028,xmeg029,
             xmeg030,xmeg031,xmeg032,
             xmeg003,xmeg033,xmeg034,xmeg036,xmeg037,
             xmeg038,xmeg039 
         INTO g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg027,g_xmeg_m.xmeg028,g_xmeg_m.xmeg029,
              g_xmeg_m.xmeg030,g_xmeg_m.xmeg031,g_xmeg_m.xmeg032,
              g_xmeg_m.xmeg003,g_xmeg_m.xmeg033,g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,
              g_xmeg_m.xmeg038,g_xmeg_m.xmeg039
         FROM xmeg_t 
         WHERE xmegent = g_enterprise AND xmegdocno = g_xmegdocno 
           AND xmegseq = g_xmegseq AND xmeg900 = g_xmeg900
       
       CALL axmt510_04_xmeg028_ref()
       CALL axmt510_04_xmeg029_ref()
       CALL axmt510_04_xmeg031_ref()
       CALL axmt510_04_xmeg003_ref()
       
       DISPLAY BY NAME g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg027,g_xmeg_m.xmeg028,g_xmeg_m.xmeg028_desc,
                       g_xmeg_m.xmeg029,g_xmeg_m.xmeg029_desc,g_xmeg_m.xmeg030,g_xmeg_m.xmeg031,
                       g_xmeg_m.xmeg031_desc,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg003_desc,g_xmeg_m.xmeg033,
                       g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039
END FUNCTION

PRIVATE FUNCTION axmt510_04_xmeg031_ref()
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_xmeg_m.xmeg031
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_xmeg_m.xmeg031_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_xmeg_m.xmeg031_desc
END FUNCTION

PRIVATE FUNCTION axmt510_04_xmeg003_ref()
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_xmeg_m.xmeg003
        CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xmeg_m.xmeg003_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_xmeg_m.xmeg003_desc
END FUNCTION
#儲位檢查
PRIVATE FUNCTION axmt510_04_xmeg029_chk()
DEFINE r_success  LIKE type_t.num5

        LET r_success = TRUE
        IF NOT cl_null(g_xmeg_m.xmeg029) THEN 

           #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
           INITIALIZE g_chkparam.* TO NULL
           
           #設定g_chkparam.*的參數
           LET g_chkparam.arg1 = g_site
           LET g_chkparam.arg2 = g_xmeg_m.xmeg028
           LET g_chkparam.arg3 = g_xmeg_m.xmeg029

              
           #呼叫檢查存在並帶值的library
           IF NOT cl_chk_exist("v_inab002_1") THEN
              LET r_success = FALSE
              RETURN r_success              
           END IF
        END IF
        RETURN r_success        
END FUNCTION

 
{</section>}
 
