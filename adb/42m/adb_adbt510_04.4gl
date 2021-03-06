#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt510_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-08-11 15:18:53), PR版次:0001(2014-08-11 15:19:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000093
#+ Filename...: adbt510_04
#+ Description: 分銷訂單變更其他資訊維護作業
#+ Creator....: 02748(2014-07-01 17:07:50)
#+ Modifier...: 02748 -SD/PR- 02748
 
{</section>}
 
{<section id="adbt510_04.global" >}
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
PRIVATE type type_g_xmeg_m        RECORD
       xmeg900 LIKE xmeg_t.xmeg900, 
   xmegdocno LIKE xmeg_t.xmegdocno, 
   xmegseq LIKE xmeg_t.xmegseq, 
   xmeg901 LIKE xmeg_t.xmeg901, 
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
DEFINE g_xmeg_m_t      type_g_xmeg_m
#end add-point
 
DEFINE g_xmeg_m        type_g_xmeg_m
 
   DEFINE g_xmeg900_t LIKE xmeg_t.xmeg900
DEFINE g_xmegdocno_t LIKE xmeg_t.xmegdocno
DEFINE g_xmegseq_t LIKE xmeg_t.xmegseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adbt510_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION adbt510_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmegdocno,p_xmeg900,p_xmegseq
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
   DEFINE p_xmeg900       LIKE xmeg_t.xmeg900
   DEFINE p_xmegseq       LIKE xmeg_t.xmegseq
   DEFINE l_forupd_sql    STRING
   DEFINE l_xmee004       LIKE xmee_t.xmee004
   DEFINE l_xmeg001       LIKE xmeg_t.xmeg001
   DEFINE l_xmeg002       LIKE xmeg_t.xmeg002
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_adbt510_04 WITH FORM cl_ap_formpath("adb","adbt510_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc_part('xmeg032','2056','1,2,3,4')
   LET g_xmegdocno = p_xmegdocno
   LET g_xmegseq = p_xmegseq
   LET g_xmeg900 = p_xmeg900
   INITIALIZE g_xmeg_m.* LIKE xmeg_t.*
   
   CALL adbt510_04_xmegdocno_ref()  #帶值
   
   INITIALIZE g_xmeg_m_t.* TO NULL
   LET g_xmeg_m_t.* = g_xmeg_m.*
   
   LET p_cmd = 'u'
   LET l_forupd_sql = "SELECT xmegdocno,xmegseq,xmeg031,'',xmeg032,xmeg003,'',xmeg033,xmeg034,xmeg036,xmeg037,xmeg038,xmeg039,xmeg901 FROM xmeg_t WHERE xmegent= ? AND xmegdocno=? AND xmegseq = ? AND xmeg900 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   DECLARE adbt510_04_cl CURSOR FROM l_forupd_sql
   
   LET l_xmee004 = ''
   LET l_xmeg001 = ''
   LET l_xmeg002 = ''
   #獲得供應商編號、料件編號、產品特徵
   SELECT xmee004 INTO l_xmee004 FROM xmee_t 
    WHERE xmeeent = g_enterprise AND xmeedocno = g_xmegdocno AND xmee900 = g_xmeg900
   
   SELECT xmeg001,xmeg002 INTO l_xmeg001,l_xmeg002 FROM xmeg_t 
    WHERE xmegent = g_enterprise AND xmegdocno = g_xmegdocno AND xmegseq = g_xmegseq AND xmeg900 = g_xmeg900

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xmeg_m.xmeg900,g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg901,g_xmeg_m.xmeg031, 
          g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg033,g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037, 
          g_xmeg_m.xmeg038,g_xmeg_m.xmeg039 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF p_cmd ='u' THEN
               
               CALL s_transaction_begin()
               
               OPEN adbt510_04_cl USING g_enterprise,g_xmegdocno,g_xmegseq,g_xmeg900
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN adbt510_04_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE adbt510_04_cl
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               END IF
    
               #鎖住將被更改或取消的資料
               FETCH adbt510_04_cl INTO g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg031,
                                        g_xmeg_m.xmeg031_desc,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg003_desc,
                                        g_xmeg_m.xmeg033,g_xmeg_m.xmeg034,
                                        g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039,g_xmeg_m.xmeg901
            
               #資料被他人LOCK, 或是sql執行時出現錯誤
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmeg_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CLOSE adbt510_04_cl
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               END IF
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg900
            #add-point:BEFORE FIELD xmeg900 name="input.b.xmeg900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg900
            
            #add-point:AFTER FIELD xmeg900 name="input.a.xmeg900"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmeg_m.xmegdocno) AND NOT cl_null(g_xmeg_m.xmegseq) AND NOT cl_null(g_xmeg_m.xmeg900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmeg_m.xmegdocno != g_xmegdocno_t  OR g_xmeg_m.xmegseq != g_xmegseq_t  OR g_xmeg_m.xmeg900 != g_xmeg900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmeg_t WHERE "||"xmegent = '" ||g_enterprise|| "' AND "||"xmegdocno = '"||g_xmeg_m.xmegdocno ||"' AND "|| "xmegseq = '"||g_xmeg_m.xmegseq ||"' AND "|| "xmeg900 = '"||g_xmeg_m.xmeg900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg900
            #add-point:ON CHANGE xmeg900 name="input.g.xmeg900"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmegdocno
            #add-point:BEFORE FIELD xmegdocno name="input.b.xmegdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmegdocno
            
            #add-point:AFTER FIELD xmegdocno name="input.a.xmegdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmeg_m.xmegdocno) AND NOT cl_null(g_xmeg_m.xmegseq) AND NOT cl_null(g_xmeg_m.xmeg900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmeg_m.xmegdocno != g_xmegdocno_t  OR g_xmeg_m.xmegseq != g_xmegseq_t  OR g_xmeg_m.xmeg900 != g_xmeg900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmeg_t WHERE "||"xmegent = '" ||g_enterprise|| "' AND "||"xmegdocno = '"||g_xmeg_m.xmegdocno ||"' AND "|| "xmegseq = '"||g_xmeg_m.xmegseq ||"' AND "|| "xmeg900 = '"||g_xmeg_m.xmeg900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



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
            IF  NOT cl_null(g_xmeg_m.xmegdocno) AND NOT cl_null(g_xmeg_m.xmegseq) AND NOT cl_null(g_xmeg_m.xmeg900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmeg_m.xmegdocno != g_xmegdocno_t  OR g_xmeg_m.xmegseq != g_xmegseq_t  OR g_xmeg_m.xmeg900 != g_xmeg900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmeg_t WHERE "||"xmegent = '" ||g_enterprise|| "' AND "||"xmegdocno = '"||g_xmeg_m.xmegdocno ||"' AND "|| "xmegseq = '"||g_xmeg_m.xmegseq ||"' AND "|| "xmeg900 = '"||g_xmeg_m.xmeg900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmegseq
            #add-point:ON CHANGE xmegseq name="input.g.xmegseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmeg901
            #add-point:BEFORE FIELD xmeg901 name="input.b.xmeg901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg901
            
            #add-point:AFTER FIELD xmeg901 name="input.a.xmeg901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmeg901
            #add-point:ON CHANGE xmeg901 name="input.g.xmeg901"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmeg031
            
            #add-point:AFTER FIELD xmeg031 name="input.a.xmeg031"
            IF NOT cl_null(g_xmeg_m.xmeg031) THEN
               IF NOT s_azzi650_chk_exist('263',g_xmeg_m.xmeg031) THEN
                  LET g_xmeg_m.xmeg031 = g_xmeg_m_t.xmeg031
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_acc_desc('263',g_xmeg_m.xmeg031) RETURNING g_xmeg_m.xmeg031_desc
            DISPLAY BY NAME g_xmeg_m.xmeg031_desc
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
            IF NOT cl_null(g_xmeg_m.xmeg003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmeg_m.xmeg003
 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaa001_3") THEN
                  LET g_xmeg_m.xmeg003 = g_xmeg_m_t.xmeg003
                  CALL adbt510_04_xmeg003_ref()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            CALL adbt510_04_xmeg003_ref()

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
                  #Ctrlp:input.c.xmeg900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg900
            #add-point:ON ACTION controlp INFIELD xmeg900 name="input.c.xmeg900"
            
            #END add-point
 
 
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
 
 
         #Ctrlp:input.c.xmeg901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg901
            #add-point:ON ACTION controlp INFIELD xmeg901 name="input.c.xmeg901"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmeg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmeg031
            #add-point:ON ACTION controlp INFIELD xmeg031 name="input.c.xmeg031"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmeg_m.xmeg031             #給予default值
            LET g_qryparam.default2 = "" 
            LET g_qryparam.arg1 = "263"  #
            CALL q_oocq002()                                #呼叫開窗
            LET g_xmeg_m.xmeg031 = g_qryparam.return1              
            DISPLAY g_xmeg_m.xmeg031 TO xmeg031              #
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
            LET g_qryparam.default1 = g_xmeg_m.xmeg003             #給予default值
            LET g_qryparam.default2 = "" #g_xmeg_m.imaal003 #品名
            CALL q_imaa001_3()                                #呼叫開窗
            LET g_xmeg_m.xmeg003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmeg_m.xmeg003 TO xmeg003              #顯示到畫面上
            CALL adbt510_04_xmeg003_ref()
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
            IF g_xmeg_m.xmeg901 = '1' THEN
               LET g_xmeg_m.xmeg901 = '2'
            END IF
            #單頭修改
            UPDATE xmeg_t SET (xmeg031,xmeg032,xmeg003,xmeg033,xmeg036,xmeg037,xmeg038,xmeg039,xmeg901) = 
              (g_xmeg_m.xmeg031,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg033,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039,g_xmeg_m.xmeg901)
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
   CLOSE WINDOW w_adbt510_04 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adbt510_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="adbt510_04.other_function" readonly="Y" >}

PRIVATE FUNCTION adbt510_04_xmeg003_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmeg_m.xmeg003
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmeg_m.xmeg003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmeg_m.xmeg003_desc
END FUNCTION

PRIVATE FUNCTION adbt510_04_xmegdocno_ref()
      SELECT xmegdocno,xmegseq,xmeg031,xmeg032,
             xmeg003,xmeg033,xmeg034,xmeg036,xmeg037,
             xmeg038,xmeg039,xmeg901 
         INTO g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg031,g_xmeg_m.xmeg032,
              g_xmeg_m.xmeg003,g_xmeg_m.xmeg033,g_xmeg_m.xmeg034,g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,
              g_xmeg_m.xmeg038,g_xmeg_m.xmeg039,g_xmeg_m.xmeg901
         FROM xmeg_t 
         WHERE xmegent = g_enterprise AND xmegdocno = g_xmegdocno AND xmegseq = g_xmegseq AND xmeg900 = g_xmeg900
       
       CALL s_desc_get_acc_desc('263',g_xmeg_m.xmeg031) RETURNING g_xmeg_m.xmeg031_desc
          DISPLAY BY NAME g_xmeg_m.xmeg031_desc
       CALL adbt510_04_xmeg003_ref()
       
       DISPLAY BY NAME g_xmeg_m.xmegdocno,g_xmeg_m.xmegseq,g_xmeg_m.xmeg031,
                       g_xmeg_m.xmeg031_desc,g_xmeg_m.xmeg032,g_xmeg_m.xmeg003,g_xmeg_m.xmeg003_desc,g_xmeg_m.xmeg033,g_xmeg_m.xmeg034,
                       g_xmeg_m.xmeg036,g_xmeg_m.xmeg037,g_xmeg_m.xmeg038,g_xmeg_m.xmeg039
END FUNCTION

 
{</section>}
 
