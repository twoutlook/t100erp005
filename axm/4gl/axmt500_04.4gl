#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt500_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-07-02 11:50:36), PR版次:0004(2016-11-11 16:30:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000237
#+ Filename...: axmt500_04
#+ Description: 維護訂單其它資訊作業
#+ Creator....: 02040(2014-02-11 10:43:57)
#+ Modifier...: 02040 -SD/PR- 08992
 
{</section>}
 
{<section id="axmt500_04.global" >}
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
PRIVATE type type_g_xmdc_m        RECORD
       xmdcdocno LIKE xmdc_t.xmdcdocno, 
   xmdcseq LIKE xmdc_t.xmdcseq, 
   xmdc027 LIKE xmdc_t.xmdc027, 
   xmdc028 LIKE xmdc_t.xmdc028, 
   xmdc028_desc LIKE type_t.chr80, 
   xmdc029 LIKE xmdc_t.xmdc029, 
   xmdc029_desc LIKE type_t.chr80, 
   xmdc030 LIKE xmdc_t.xmdc030, 
   xmdc031 LIKE xmdc_t.xmdc031, 
   xmdc031_desc LIKE type_t.chr80, 
   xmdc032 LIKE xmdc_t.xmdc032, 
   xmdc003 LIKE xmdc_t.xmdc003, 
   xmdc003_desc LIKE type_t.chr80, 
   xmdc033 LIKE xmdc_t.xmdc033, 
   xmdc036 LIKE xmdc_t.xmdc036, 
   xmdc037 LIKE xmdc_t.xmdc037, 
   xmdc038 LIKE xmdc_t.xmdc038, 
   xmdc039 LIKE xmdc_t.xmdc039
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdcdocno     LIKE xmdc_t.xmdcdocno
DEFINE g_xmdcseq       LIKE xmdc_t.xmdcseq
DEFINE g_xmdc_m_t      type_g_xmdc_m
#end add-point
 
DEFINE g_xmdc_m        type_g_xmdc_m
 
   DEFINE g_xmdcdocno_t LIKE xmdc_t.xmdcdocno
DEFINE g_xmdcseq_t LIKE xmdc_t.xmdcseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmt500_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt500_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmdcdocno,p_xmdcseq
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
   DEFINE p_xmdcdocno     LIKE xmdc_t.xmdcdocno
   DEFINE p_xmdcseq       LIKE xmdc_t.xmdcseq
   DEFINE l_forupd_sql    STRING
   DEFINE l_xmda004       LIKE xmda_t.xmda004
   DEFINE l_xmdc001       LIKE xmdc_t.xmdc001     #料件
   DEFINE l_xmdc002       LIKE xmdc_t.xmdc002     #產品特微
   DEFINE l_xmdc010       LIKE xmdc_t.xmdc010     #計價單位
   DEFINE l_xmdc011       LIKE xmdc_t.xmdc011     #計價數量
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt500_04 WITH FORM cl_ap_formpath("axm","axmt500_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('xmdc032','2056')
   LET g_xmdcdocno = p_xmdcdocno
   LET g_xmdcseq = p_xmdcseq
   
   INITIALIZE g_xmdc_m.* TO NULL
   
   CALL axmt500_04_xmdcdocno_ref()  #帶值
   
   INITIALIZE g_xmdc_m_t.* TO NULL
   LET g_xmdc_m_t.* = g_xmdc_m.*
   
   LET p_cmd = 'u'
   LET l_forupd_sql = "SELECT xmdcdocno,xmdcseq,xmdc027,xmdc028,'',xmdc029,'',xmdc030,xmdc031,'',xmdc032,xmdc003,'',xmdc033,xmdc036,xmdc037,xmdc038,xmdc039 FROM xmdc_t WHERE xmdcent= ? AND xmdcdocno=? AND xmdcseq = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   DECLARE axmt500_04_cl CURSOR FROM l_forupd_sql
     
   LET l_xmda004 = ''
   LET l_xmdc001 = ''
   LET l_xmdc002 = ''
   LET l_xmdc010 = ''
   LET l_xmdc011 = ''
   #獲得供應商編號、料件編號、產品特徵
   SELECT xmda004 INTO l_xmda004 FROM xmda_t 
    WHERE xmdaent = g_enterprise AND xmdadocno = g_xmdcdocno
   
   SELECT xmdc001,xmdc002,xmdc010,xmdc011
     INTO l_xmdc001,l_xmdc002,l_xmdc010,l_xmdc011 
     FROM xmdc_t 
    WHERE xmdcent = g_enterprise 
      AND xmdcdocno = g_xmdcdocno 
      AND xmdcseq = g_xmdcseq
   
   CALL axmt500_04_set_entry()
   CALL axmt500_04_set_no_entry()        
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xmdc_m.xmdcdocno,g_xmdc_m.xmdcseq,g_xmdc_m.xmdc027,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029, 
          g_xmdc_m.xmdc030,g_xmdc_m.xmdc031,g_xmdc_m.xmdc032,g_xmdc_m.xmdc003,g_xmdc_m.xmdc033,g_xmdc_m.xmdc036, 
          g_xmdc_m.xmdc037,g_xmdc_m.xmdc038,g_xmdc_m.xmdc039 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF p_cmd ='u' THEN               
               CALL s_transaction_begin()               
               OPEN axmt500_04_cl USING g_enterprise,g_xmdcdocno,g_xmdcseq
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axmt500_04_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axmt500_04_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
    
               #鎖住將被更改或取消的資料
               FETCH axmt500_04_cl INTO g_xmdc_m.xmdcdocno,g_xmdc_m.xmdcseq,g_xmdc_m.xmdc027,g_xmdc_m.xmdc028,g_xmdc_m.xmdc028_desc,
                                        g_xmdc_m.xmdc029,g_xmdc_m.xmdc029_desc,g_xmdc_m.xmdc030,g_xmdc_m.xmdc031,
                                        g_xmdc_m.xmdc031_desc,g_xmdc_m.xmdc032,g_xmdc_m.xmdc003,g_xmdc_m.xmdc003_desc,g_xmdc_m.xmdc033,
                                        g_xmdc_m.xmdc036,g_xmdc_m.xmdc037,g_xmdc_m.xmdc038,g_xmdc_m.xmdc039
            
               #資料被他人LOCK, 或是sql執行時出現錯誤
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmdc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CLOSE axmt500_04_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdcdocno
            #add-point:BEFORE FIELD xmdcdocno name="input.b.xmdcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdcdocno
            
            #add-point:AFTER FIELD xmdcdocno name="input.a.xmdcdocno"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdcdocno
            #add-point:ON CHANGE xmdcdocno name="input.g.xmdcdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdcseq
            #add-point:BEFORE FIELD xmdcseq name="input.b.xmdcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdcseq
            
            #add-point:AFTER FIELD xmdcseq name="input.a.xmdcseq"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdcseq
            #add-point:ON CHANGE xmdcseq name="input.g.xmdcseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc027
            
            #add-point:AFTER FIELD xmdc027 name="input.a.xmdc027"
            IF NOT cl_null(g_xmdc_m.xmdc027) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_xmda004
               LET g_chkparam.arg2 = l_xmdc001
               LET g_chkparam.arg3 = l_xmdc002
               LET g_chkparam.arg4 = g_xmdc_m.xmdc027
               #160318-00025#17 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00261:sub-01302|apmi120|",cl_get_progname("apmi120",g_lang,"2"),"|:EXEPROGapmi120"
               #160318-00025#17 by 07900 --add-end
               #161026-00025#2-s
               LET g_chkparam.err_str[2] ="apm-00260:axm-00053|axmi120|",cl_get_progname("axmi120",g_lang,"2"),"|:EXEPROGaxmi120"
               #161026-00025#2-e
               IF NOT cl_chk_exist("v_pmao004") THEN
                  LET g_xmdc_m.xmdc027 = g_xmdc_m_t.xmdc027
                  DISPLAY BY NAME g_xmdc_m.xmdc027
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc027
            #add-point:BEFORE FIELD xmdc027 name="input.b.xmdc027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc027
            #add-point:ON CHANGE xmdc027 name="input.g.xmdc027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc028
            
            #add-point:AFTER FIELD xmdc028 name="input.a.xmdc028"
            LET g_xmdc_m.xmdc028_desc = ''
            IF NOT cl_null(g_xmdc_m.xmdc028) THEN
               IF NOT s_axmt500_xmdc028_chk(l_xmdc001,l_xmdc002,g_xmdc_m.xmdc028) THEN
                  LET g_xmdc_m.xmdc028 = g_xmdc_m_t.xmdc028
                  CALL s_desc_get_stock_desc(g_site,g_xmdc_m.xmdc028) RETURNING g_xmdc_m.xmdc028_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_axmt500_inan_chk(g_xmdcdocno,l_xmdc001,l_xmdc002,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029,g_xmdc_m.xmdc030,
                                         l_xmdc010,l_xmdc011) THEN
                  LET g_xmdc_m.xmdc028 = g_xmdc_m_t.xmdc028
                  CALL s_desc_get_stock_desc(g_site,g_xmdc_m.xmdc028) RETURNING g_xmdc_m.xmdc028_desc
                  NEXT FIELD CURRENT
               END IF                     
            END IF
            CALL s_desc_get_stock_desc(g_site,g_xmdc_m.xmdc028) RETURNING g_xmdc_m.xmdc028_desc
            DISPLAY BY NAME g_xmdc_m.xmdc028_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc028
            #add-point:BEFORE FIELD xmdc028 name="input.b.xmdc028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc028
            #add-point:ON CHANGE xmdc028 name="input.g.xmdc028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc029
            
            #add-point:AFTER FIELD xmdc029 name="input.a.xmdc029"
            LET g_xmdc_m.xmdc029_desc = ''
            IF NOT cl_null(g_xmdc_m.xmdc029) THEN
               IF NOT s_axmt500_xmdc029_chk(l_xmdc001,l_xmdc002,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029) THEN
                  LET g_xmdc_m.xmdc029 = g_xmdc_m_t.xmdc029
                  CALL s_desc_get_locator_desc(g_site,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029)
                    RETURNING g_xmdc_m.xmdc029_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_axmt500_inan_chk(g_xmdcdocno,l_xmdc001,l_xmdc002,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029,g_xmdc_m.xmdc030,
                                         l_xmdc010,l_xmdc011) THEN
                  LET g_xmdc_m.xmdc029 = g_xmdc_m_t.xmdc029
                  CALL s_desc_get_locator_desc(g_site,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029)
                    RETURNING g_xmdc_m.xmdc029_desc
                  NEXT FIELD CURRENT 
               END IF               
            END IF
            CALL s_desc_get_locator_desc(g_site,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029)
              RETURNING g_xmdc_m.xmdc029_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc029
            #add-point:BEFORE FIELD xmdc029 name="input.b.xmdc029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc029
            #add-point:ON CHANGE xmdc029 name="input.g.xmdc029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc030
            #add-point:BEFORE FIELD xmdc030 name="input.b.xmdc030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc030
            
            #add-point:AFTER FIELD xmdc030 name="input.a.xmdc030"
            IF NOT cl_null(g_xmdc_m.xmdc030) THEN
               IF NOT  s_axmt500_xmdc030_chk(l_xmdc001,l_xmdc002,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029,g_xmdc_m.xmdc030) THEN
                  LET g_xmdc_m.xmdc030 = g_xmdc_m_t.xmdc030
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_axmt500_inan_chk(g_xmdcdocno,l_xmdc001,l_xmdc002,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029,g_xmdc_m.xmdc030,
                                         l_xmdc010,l_xmdc011) THEN
                  LET g_xmdc_m.xmdc030 = g_xmdc_m_t.xmdc030
                  NEXT FIELD CURRENT
               END IF              
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc030
            #add-point:ON CHANGE xmdc030 name="input.g.xmdc030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc031
            
            #add-point:AFTER FIELD xmdc031 name="input.a.xmdc031"
            LET g_xmdc_m.xmdc031_desc = ''
            IF NOT cl_null(g_xmdc_m.xmdc031) THEN
               IF NOT s_azzi650_chk_exist('263',g_xmdc_m.xmdc031) THEN
                  LET g_xmdc_m.xmdc031 = g_xmdc_m_t.xmdc031
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_acc_desc('263',g_xmdc_m.xmdc031) RETURNING g_xmdc_m.xmdc031_desc
            DISPLAY BY NAME g_xmdc_m.xmdc031_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc031
            #add-point:BEFORE FIELD xmdc031 name="input.b.xmdc031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc031
            #add-point:ON CHANGE xmdc031 name="input.g.xmdc031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc032
            #add-point:BEFORE FIELD xmdc032 name="input.b.xmdc032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc032
            
            #add-point:AFTER FIELD xmdc032 name="input.a.xmdc032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc032
            #add-point:ON CHANGE xmdc032 name="input.g.xmdc032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc003
            
            #add-point:AFTER FIELD xmdc003 name="input.a.xmdc003"
            CALL axmt500_04_xmdc003_ref()
            IF NOT cl_null(g_xmdc_m.xmdc003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdc_m.xmdc003
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#17  by 07900 --add-end
                #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_2") THEN
                  LET g_xmdc_m.xmdc003 = g_xmdc_m_t.xmdc003
                  CALL axmt500_04_xmdc003_ref()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc003
            #add-point:BEFORE FIELD xmdc003 name="input.b.xmdc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc003
            #add-point:ON CHANGE xmdc003 name="input.g.xmdc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdc_m.xmdc033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD xmdc033
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdc033 name="input.a.xmdc033"
            IF NOT cl_null(g_xmdc_m.xmdc033) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc033
            #add-point:BEFORE FIELD xmdc033 name="input.b.xmdc033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc033
            #add-point:ON CHANGE xmdc033 name="input.g.xmdc033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc036
            #add-point:BEFORE FIELD xmdc036 name="input.b.xmdc036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc036
            
            #add-point:AFTER FIELD xmdc036 name="input.a.xmdc036"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc036
            #add-point:ON CHANGE xmdc036 name="input.g.xmdc036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc037
            #add-point:BEFORE FIELD xmdc037 name="input.b.xmdc037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc037
            
            #add-point:AFTER FIELD xmdc037 name="input.a.xmdc037"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc037
            #add-point:ON CHANGE xmdc037 name="input.g.xmdc037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc038
            #add-point:BEFORE FIELD xmdc038 name="input.b.xmdc038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc038
            
            #add-point:AFTER FIELD xmdc038 name="input.a.xmdc038"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc038
            #add-point:ON CHANGE xmdc038 name="input.g.xmdc038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc039
            #add-point:BEFORE FIELD xmdc039 name="input.b.xmdc039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc039
            
            #add-point:AFTER FIELD xmdc039 name="input.a.xmdc039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdc039
            #add-point:ON CHANGE xmdc039 name="input.g.xmdc039"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmdcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdcdocno
            #add-point:ON ACTION controlp INFIELD xmdcdocno name="input.c.xmdcdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdcseq
            #add-point:ON ACTION controlp INFIELD xmdcseq name="input.c.xmdcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc027
            #add-point:ON ACTION controlp INFIELD xmdc027 name="input.c.xmdc027"
             #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdc_m.xmdc027       #給予default值
            LET g_qryparam.arg1 = l_xmda004
            LET g_qryparam.arg2 = l_xmdc001
            LET g_qryparam.arg3 = l_xmdc002
            CALL q_pmao004_1()                               #呼叫開窗
            LET g_xmdc_m.xmdc027 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_xmdc_m.xmdc027 TO xmdc027              #顯示到畫面上
            NEXT FIELD xmdc027                               #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdc028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc028
            #add-point:ON ACTION controlp INFIELD xmdc028 name="input.c.xmdc028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdc_m.xmdc028    #給予default值
            LET g_qryparam.arg1 = l_xmdc001
            LET g_qryparam.arg2 = l_xmdc002
            CALL q_inag004_1()                                   #呼叫開窗
            LET g_xmdc_m.xmdc028 = g_qryparam.return1     #將開窗取得的值回傳到變數
            LET g_xmdc_m.xmdc029 = g_qryparam.return2
            LET g_xmdc_m.xmdc030 = g_qryparam.return3
            DISPLAY g_xmdc_m.xmdc028 TO xmdc028           #顯示到畫面上
            DISPLAY g_xmdc_m.xmdc029 TO xmdc029
            DISPLAY g_xmdc_m.xmdc030 TO xmdc030
            CALL s_desc_get_stock_desc(g_site,g_xmdc_m.xmdc028) RETURNING g_xmdc_m.xmdc028_desc
            CALL s_desc_get_locator_desc(g_site,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029) RETURNING g_xmdc_m.xmdc029_desc
            NEXT FIELD xmdc028
            #END add-point
 
 
         #Ctrlp:input.c.xmdc029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc029
            #add-point:ON ACTION controlp INFIELD xmdc029 name="input.c.xmdc029"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdc_m.xmdc029     #給予default值
            LET g_qryparam.arg1 = l_xmdc001
            LET g_qryparam.arg2 = l_xmdc002
            LET g_qryparam.arg3 = g_xmdc_m.xmdc028
            CALL q_inag005_5()                                      #呼叫開窗
            LET g_xmdc_m.xmdc029 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_xmdc_m.xmdc029 TO xmdc029         #顯示到畫面上
            CALL s_desc_get_locator_desc(g_site,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029) RETURNING g_xmdc_m.xmdc029_desc 
            #END add-point
 
 
         #Ctrlp:input.c.xmdc030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc030
            #add-point:ON ACTION controlp INFIELD xmdc030 name="input.c.xmdc030"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc031
            #add-point:ON ACTION controlp INFIELD xmdc031 name="input.c.xmdc031"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdc_m.xmdc031             #給予default值           
            LET g_qryparam.arg1 = "263" 
            CALL q_oocq002()                 
            LET g_xmdc_m.xmdc031 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdc_m.xmdc031 TO xmdc031                    #顯示到畫面上
            CALL s_desc_get_acc_desc('263',g_xmdc_m.xmdc031) RETURNING g_xmdc_m.xmdc031_desc
            DISPLAY BY NAME g_xmdc_m.xmdc031_desc
            NEXT FIELD xmdc031                                     #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.xmdc032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc032
            #add-point:ON ACTION controlp INFIELD xmdc032 name="input.c.xmdc032"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc003
            #add-point:ON ACTION controlp INFIELD xmdc003 name="input.c.xmdc003"
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdc_m.xmdc003        #給予default值
            CALL q_imaa001_3()                                #呼叫開窗
            LET g_xmdc_m.xmdc003 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_xmdc_m.xmdc003 TO xmdc003               #顯示到畫面上
            CALL axmt500_04_xmdc003_ref()
            NEXT FIELD xmdc003                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdc033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc033
            #add-point:ON ACTION controlp INFIELD xmdc033 name="input.c.xmdc033"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc036
            #add-point:ON ACTION controlp INFIELD xmdc036 name="input.c.xmdc036"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc037
            #add-point:ON ACTION controlp INFIELD xmdc037 name="input.c.xmdc037"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc038
            #add-point:ON ACTION controlp INFIELD xmdc038 name="input.c.xmdc038"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdc039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc039
            #add-point:ON ACTION controlp INFIELD xmdc039 name="input.c.xmdc039"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            #單頭修改
            UPDATE xmdc_t SET (xmdc027,xmdc028,xmdc029,xmdc030,xmdc031,xmdc032,xmdc003,xmdc033,xmdc036,xmdc037,xmdc038,xmdc039) = 
              (g_xmdc_m.xmdc027,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029,g_xmdc_m.xmdc030,g_xmdc_m.xmdc031,g_xmdc_m.xmdc032,g_xmdc_m.xmdc003,g_xmdc_m.xmdc033,g_xmdc_m.xmdc036,g_xmdc_m.xmdc037,g_xmdc_m.xmdc038,g_xmdc_m.xmdc039)
             WHERE xmdcent = g_enterprise AND xmdcdocno = g_xmdcdocno AND xmdcseq = g_xmdcseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdc_t"
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
   CLOSE WINDOW w_axmt500_04 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt500_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt500_04.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt500_04_set_entry()
       CALL cl_set_comp_entry("xmdc030",TRUE)
END FUNCTION

PRIVATE FUNCTION axmt500_04_set_no_entry()
DEFINE l_xmdc001   LIKE xmdc_t.xmdc001
DEFINE l_imaf061   LIKE imaf_t.imaf061

       LET l_xmdc001 = ''
       SELECT xmdc001 INTO l_xmdc001 FROM xmdc_t 
        WHERE xmdcent = g_enterprise AND xmdcdocno = g_xmdcdocno AND xmdcseq = g_xmdcseq

       IF NOT cl_null(l_xmdc001) THEN
          #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
          LET l_imaf061 = ''
          SELECT imaf061 INTO l_imaf061 FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_xmdc001
          IF l_imaf061 NOT MATCHES '[13]' THEN
             CALL cl_set_comp_entry("xmdc030",FALSE)
          END IF
       END IF
             
END FUNCTION
#帶值
PRIVATE FUNCTION axmt500_04_xmdcdocno_ref()
      SELECT xmdcdocno,xmdcseq,xmdc027,xmdc028,xmdc029,
             xmdc030,xmdc031,xmdc032,
             xmdc003,xmdc033,xmdc036,xmdc037,
             xmdc038,xmdc039 
         INTO g_xmdc_m.xmdcdocno,g_xmdc_m.xmdcseq,g_xmdc_m.xmdc027,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029,
              g_xmdc_m.xmdc030,g_xmdc_m.xmdc031,g_xmdc_m.xmdc032,
              g_xmdc_m.xmdc003,g_xmdc_m.xmdc033,g_xmdc_m.xmdc036,g_xmdc_m.xmdc037,
              g_xmdc_m.xmdc038,g_xmdc_m.xmdc039
         FROM xmdc_t 
         WHERE xmdcent = g_enterprise AND xmdcdocno = g_xmdcdocno AND xmdcseq = g_xmdcseq
       
       CALL s_desc_get_stock_desc(g_site,g_xmdc_m.xmdc028) RETURNING g_xmdc_m.xmdc028_desc
       CALL s_desc_get_locator_desc(g_site,g_xmdc_m.xmdc028,g_xmdc_m.xmdc029) RETURNING g_xmdc_m.xmdc029_desc
       CALL s_desc_get_acc_desc('263',g_xmdc_m.xmdc031) RETURNING g_xmdc_m.xmdc031_desc
       CALL axmt500_04_xmdc003_ref()
       
       DISPLAY BY NAME g_xmdc_m.xmdc027,g_xmdc_m.xmdc028,g_xmdc_m.xmdc028_desc,
                       g_xmdc_m.xmdc029,g_xmdc_m.xmdc029_desc,g_xmdc_m.xmdc030,g_xmdc_m.xmdc031,
                       g_xmdc_m.xmdc031_desc,g_xmdc_m.xmdc032,g_xmdc_m.xmdc003,g_xmdc_m.xmdc003_desc,g_xmdc_m.xmdc033,
                       g_xmdc_m.xmdc036,g_xmdc_m.xmdc037,g_xmdc_m.xmdc038,g_xmdc_m.xmdc039
END FUNCTION

PRIVATE FUNCTION axmt500_04_xmdc003_ref()
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_xmdc_m.xmdc003
        CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xmdc_m.xmdc003_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_xmdc_m.xmdc003_desc
END FUNCTION

 
{</section>}
 
