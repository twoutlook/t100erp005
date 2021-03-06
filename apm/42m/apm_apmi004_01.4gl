#該程式未解開Section, 採用最新樣板產出!
{<section id="apmi004_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-10-01 10:07:52), PR版次:0005(2016-03-27 17:28:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000161
#+ Filename...: apmi004_01
#+ Description: 一次性交易對象基本資料
#+ Creator....: 02294(2013-09-10 16:07:06)
#+ Modifier...: 03555 -SD/PR- 07900
 
{</section>}
 
{<section id="apmi004_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#33  2016/03/27   By 07900    重复错误信息修改
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
#150824-00010#1   15/10/01   By Alberti   新增欄位(pmak010)銀行別 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmak_m        RECORD
       pmak001 LIKE pmak_t.pmak001, 
   pmak003 LIKE pmak_t.pmak003, 
   pmak004 LIKE pmak_t.pmak004, 
   pmak010 LIKE pmak_t.pmak010, 
   pmak009 LIKE pmak_t.pmak009, 
   pmak005 LIKE pmak_t.pmak005, 
   pmak007 LIKE pmak_t.pmak007, 
   pmak008 LIKE pmak_t.pmak008
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_pmak_m        type_g_pmak_m
 
   DEFINE g_pmak001_t LIKE pmak_t.pmak001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmi004_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmi004_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type,p_pmak001,p_pmak002,p_pmak006
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
   DEFINE p_type          LIKE type_t.chr1      #'1' 識別碼   '2' 內部員工
   DEFINE p_pmak001       LIKE pmak_t.pmak001
   DEFINE p_pmak002       LIKE pmak_t.pmak002
   DEFINE p_pmak006       LIKE pmak_t.pmak006
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_oofa001       LIKE oofa_t.oofa001
   DEFINE l_pmaa002       LIKE pmaa_t.pmaa002
   DEFINE l_forupd_sql    STRING
   DEFINE r_pmak001       LIKE pmak_t.pmak001
   DEFINE l_gzze003  LIKE gzze_t.gzze003
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmi004_01 WITH FORM cl_ap_formpath("apm","apmi004_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   IF cl_null(p_type) THEN
      #参数为空,请检查传入参数！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00110'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_pmak001 =  ''
      RETURN r_pmak001
      CLOSE WINDOW w_apmi004_01
   END IF
   IF p_type = '1' THEN
      IF cl_null(p_pmak002) OR cl_null(p_pmak006) THEN
         #参数为空,请检查传入参数！
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00110'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET r_pmak001 =  ''
         RETURN r_pmak001
         CLOSE WINDOW w_apmi004_01
      END IF
   END IF
   IF p_type = '2' THEN
      IF cl_null(p_pmak002) THEN
         #参数为空,请检查传入参数！
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00110'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET r_pmak001 =  ''
         RETURN r_pmak001
         CLOSE WINDOW w_apmi004_01
      END IF
   END IF
   
   IF p_type = '1' THEN
      CALL cl_set_comp_visible("lbl_pmak001,pmak001",FALSE)
   END IF
   
   IF p_type = '2' THEN
      LET l_gzze003 = ' '
       SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00188' AND gzze002 = g_dlang
       CALL cl_set_comp_att_text('lbl_pmak001',l_gzze003)
   END IF
   
   INITIALIZE g_pmak_m.* LIKE pmak_t.*             #DEFAULT 設定  
   LET g_pmak001_t = NULL     
      
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmak_t WHERE pmak001 = p_pmak001 AND pmakent = g_enterprise 
   IF l_n > 0 THEN
      CALL apmi004_01_pmak001_ref(p_pmak001)  #帶值
      LET p_cmd = 'u'
      LET l_forupd_sql = "SELECT pmak001,pmak003,pmak004,pmak005,pmak007,pmak008,pmak009 FROM pmak_t WHERE pmakent= ? AND pmak001=? FOR UPDATE"
      LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
      DECLARE apmi004_01_cl CURSOR FROM l_forupd_sql
      
      SELECT pmak001,pmak003,pmak004,pmak005,pmak007,pmak008,pmak009 INTO g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009
         FROM pmak_t WHERE pmakent= g_enterprise AND pmak001=p_pmak001
   ELSE     
      LET g_pmak_m.pmak001 = p_pmak001
      LET g_pmak_m.pmak008 = g_today   #預設值
      LET p_cmd = 'a'
   END IF
   DISPLAY BY NAME g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak010,g_pmak_m.pmak009, 
          g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF p_cmd ='u' THEN
               LET g_pmak001_t = g_pmak_m.pmak001
               
               CALL s_transaction_begin()
               
               OPEN apmi004_01_cl USING g_enterprise,g_pmak_m.pmak001
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN apmi004_01_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE apmi004_01_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
 
               #鎖住將被更改或取消的資料
               FETCH apmi004_01_cl INTO g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009
       
               #資料被他人LOCK, 或是sql執行時出現錯誤
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmak_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CLOSE apmi004_01_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak001
            #add-point:BEFORE FIELD pmak001 name="input.b.pmak001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak001
            
            #add-point:AFTER FIELD pmak001 name="input.a.pmak001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_pmak_m.pmak001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmak_m.pmak001 != g_pmak001_t )) THEN
                 #150824-00010#1-Start-Mark               
                 #CALL apmi004_01_pmak001_desc() 
                 #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmak_t WHERE "||"pmakent = '" ||g_enterprise|| "' AND "||"pmak001 = '"||g_pmak_m.pmak001 ||"'",'std-00004',0) THEN 
                 #   LET g_pmak_m.pmak001 = g_pmak001_t
                 #   CALL apmi004_01_pmak001_desc() 
                 #   NEXT FIELD CURRENT
                 #END IF
                 #150824-00010#1-End-Mark
                 #150824-00010#1-Start-Add
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmak_t WHERE pmak001 = p_pmak001 AND pmakent = g_enterprise 
                  IF l_n > 0 THEN
                     CALL apmi004_01_pmak001_ref(p_pmak001)  #帶值
                     LET p_cmd = 'u'
                  ELSE    
                 #150824-00010#1-End-Add                 
                     IF NOT apmi004_01_pmak001_chk() THEN
                        LET g_pmak_m.pmak001 = g_pmak001_t
                        CALL apmi004_01_pmak001_desc() 
                        NEXT FIELD CURRENT
                     END IF
                  END IF      #150824-00010#1 add
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak001
            #add-point:ON CHANGE pmak001 name="input.g.pmak001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak003
            #add-point:BEFORE FIELD pmak003 name="input.b.pmak003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak003
            
            #add-point:AFTER FIELD pmak003 name="input.a.pmak003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak003
            #add-point:ON CHANGE pmak003 name="input.g.pmak003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak004
            #add-point:BEFORE FIELD pmak004 name="input.b.pmak004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak004
            
            #add-point:AFTER FIELD pmak004 name="input.a.pmak004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak004
            #add-point:ON CHANGE pmak004 name="input.g.pmak004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak010
            #add-point:BEFORE FIELD pmak010 name="input.b.pmak010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak010
            
            #add-point:AFTER FIELD pmak010 name="input.a.pmak010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak010
            #add-point:ON CHANGE pmak010 name="input.g.pmak010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak009
            #add-point:BEFORE FIELD pmak009 name="input.b.pmak009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak009
            
            #add-point:AFTER FIELD pmak009 name="input.a.pmak009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak009
            #add-point:ON CHANGE pmak009 name="input.g.pmak009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak005
            #add-point:BEFORE FIELD pmak005 name="input.b.pmak005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak005
            
            #add-point:AFTER FIELD pmak005 name="input.a.pmak005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak005
            #add-point:ON CHANGE pmak005 name="input.g.pmak005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak007
            #add-point:BEFORE FIELD pmak007 name="input.b.pmak007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak007
            
            #add-point:AFTER FIELD pmak007 name="input.a.pmak007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak007
            #add-point:ON CHANGE pmak007 name="input.g.pmak007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmak008
            #add-point:BEFORE FIELD pmak008 name="input.b.pmak008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmak008
            
            #add-point:AFTER FIELD pmak008 name="input.a.pmak008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmak008
            #add-point:ON CHANGE pmak008 name="input.g.pmak008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak001
            #add-point:ON ACTION controlp INFIELD pmak001 name="input.c.pmak001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmak_m.pmak001             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pmak_m.pmak001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmak_m.pmak001 TO pmak001              #顯示到畫面上
            CALL apmi004_01_pmak001_desc() 
            NEXT FIELD pmak001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmak003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak003
            #add-point:ON ACTION controlp INFIELD pmak003 name="input.c.pmak003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmak004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak004
            #add-point:ON ACTION controlp INFIELD pmak004 name="input.c.pmak004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmak010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak010
            #add-point:ON ACTION controlp INFIELD pmak010 name="input.c.pmak010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmak009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak009
            #add-point:ON ACTION controlp INFIELD pmak009 name="input.c.pmak009"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak005
            #add-point:ON ACTION controlp INFIELD pmak005 name="input.c.pmak005"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmak007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak007
            #add-point:ON ACTION controlp INFIELD pmak007 name="input.c.pmak007"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmak008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmak008
            #add-point:ON ACTION controlp INFIELD pmak008 name="input.c.pmak008"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            IF p_cmd <> "u" THEN
               
               CALL s_transaction_begin()
               
               LET l_count = 1  
               
               IF p_type = '1' THEN
                  #新增到oofa_t 聯絡信息
                  LET l_success = ''
                  LET l_oofa001 = ''
                  SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 =  p_pmak002
                  IF cl_null(l_pmaa002) THEN
                     LET l_pmaa002 = '3'
                  END IF
                  CALL s_aooi350_ins_oofa('3',p_pmak002,l_pmaa002) RETURNING l_success,g_pmak_m.pmak001
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG 
                  END IF
               END IF
               
               SELECT COUNT(*) INTO l_count FROM pmak_t
                WHERE pmakent = g_enterprise AND pmak001 = g_pmak_m.pmak001

               IF l_count = 0 THEN
               
                 #INSERT INTO pmak_t (pmakent,pmak001,pmak002,pmak003,pmak004,pmak005,pmak006,pmak007,pmak008,pmak009)                                                                           #150824-00010#1 mark       
                 #VALUES (g_enterprise,g_pmak_m.pmak001,p_pmak002,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,p_pmak006,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009) # DISK WRITE  #150824-00010#1 mark
                 
                  INSERT INTO pmak_t (pmakent,pmak001,pmak002,pmak003,pmak004,pmak005,pmak006,pmak007,pmak008,pmak009,pmak010)                                                                           #150824-00010#1 add  
                  VALUES (g_enterprise,g_pmak_m.pmak001,p_pmak002,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,p_pmak006,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009,g_pmak_m.pmak010)      #150824-00010#1 add
                  
                 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF

                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "p_pmak001"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               
               CALL s_transaction_begin()
               
               #單頭修改
              #UPDATE pmak_t SET (pmak001,pmak003,pmak004,pmak005,pmak007,pmak008,pmak009) = (g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009)                          #150824-00010#1 mark
               UPDATE pmak_t SET (pmak001,pmak003,pmak004,pmak005,pmak007,pmak008,pmak009,pmak010) = (g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009,g_pmak_m.pmak010) #150824-00010#1 add
                WHERE pmak001 = p_pmak001 AND pmakent = g_enterprise
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
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
   CLOSE WINDOW w_apmi004_01 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = FALSE
   LET r_pmak001 =  g_pmak_m.pmak001
   RETURN r_pmak001
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmi004_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apmi004_01.other_function" readonly="Y" >}
#依據傳入的參數p_pmak001(識別碼)的值，從[T:一次性交易對象資料檔]抓取出對應的資料顯示在畫面上
PRIVATE FUNCTION apmi004_01_pmak001_ref(p_pmak001)
DEFINE p_pmak001   LIKE pmak_t.pmak001

    SELECT pmak001,pmak003,pmak004,pmak005,pmak007,pmak008,pmak009 
          ,pmak010             #150824-00010#1 add
       INTO g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009
           ,g_pmak_m.pmak010   #150824-00010#1 add
       FROM pmak_t 
       WHERE pmak001 = p_pmak001 AND pmakent = g_enterprise
       
       #150824-00010#1-Start-Add 
       DISPLAY BY NAME g_pmak_m.pmak001,g_pmak_m.pmak003,g_pmak_m.pmak004,g_pmak_m.pmak005,g_pmak_m.pmak007,g_pmak_m.pmak008,g_pmak_m.pmak009
                      ,g_pmak_m.pmak010
       #150824-00010#1-End-Add                
       
       
END FUNCTION
#+
PRIVATE FUNCTION apmi004_01_pmak001_chk()
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT ap_chk_isExist(g_pmak_m.pmak001,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? ","aoo-00074",1 ) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       IF NOT ap_chk_isExist(g_pmak_m.pmak001,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","sub-01302","aooi130" ) THEN  #aoo-00071 #160318-00005#33 by 07900 --mod
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmi004_01_pmak001_desc()
       #150824-00010#1-Start-Mark
       #SELECT oofa011 INTO g_pmak_m.pmak003 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '2' AND oofa003 = g_pmak_m.pmak001
       # 
       #SELECT oofb010 INTO g_pmak_m.pmak005 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = '2' AND oofb003 = g_pmak_m.pmak001
       #
       #SELECT ooag006 INTO g_pmak_m.pmak009 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_pmak_m.pmak001
       #150824-00010#1-End-Mark 
       
       #150824-00010#1-Start-Add
        SELECT ooag011,ooag006,ooag007,oofb017 INTO g_pmak_m.pmak003,g_pmak_m.pmak010,g_pmak_m.pmak009,g_pmak_m.pmak005
          FROM ooag_t LEFT OUTER JOIN oofb_t ON ooagent = oofbent AND ooag002 = oofb002 and oofb010 = 'Y'
         WHERE ooagent = g_enterprise
           AND ooag001 = g_pmak_m.pmak001
        DISPLAY BY NAME g_pmak_m.pmak003,g_pmak_m.pmak010,g_pmak_m.pmak005,g_pmak_m.pmak009
        
        
       #150824-00010#1-End-Add 
END FUNCTION

 
{</section>}
 
