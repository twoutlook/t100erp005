#該程式未解開Section, 採用最新樣板產出!
{<section id="afat720_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-04-22 10:52:24), PR版次:0002(2016-11-28 15:19:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: afat720_01
#+ Description: 投資抵減單號
#+ Creator....: 02114(2016-04-22 10:50:59)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="afat720_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161111-00028#8   2016/11/28  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_faba_m        RECORD
       fabadocno LIKE faba_t.fabadocno
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_docno         LIKE faba_t.fabadocno
DEFINE g_faba019       LIKE faba_t.faba019
#end add-point
 
DEFINE g_faba_m        type_g_faba_m
 
   DEFINE g_fabadocno_t LIKE faba_t.fabadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"
  
#end add-point
 
{</section>}
 
{<section id="afat720_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat720_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_docno
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
   DEFINE p_docno         LIKE faba_t.fabadocno
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat720_01 WITH FORM cl_ap_formpath("afa","afat720_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_faba_m.fabadocno = ''
   LET g_docno = p_docno
   SELECT faba019 INTO g_faba019 
     FROM faba_t
    WHERE fabaent = g_enterprise
      AND fabadocno = g_docno
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_faba_m.fabadocno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocno
            #add-point:BEFORE FIELD fabadocno name="input.b.fabadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocno
            
            #add-point:AFTER FIELD fabadocno name="input.a.fabadocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF NOT cl_null(g_faba_m.fabadocno) THEN  
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faba_m.fabadocno
               
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fabadocno_36") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL afat720_01_fabadocno_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_faba_m.fabadocno
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faba_m.fabadocno = ''
                  NEXT FIELD CURRENT
               END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabadocno
            #add-point:ON CHANGE fabadocno name="input.g.fabadocno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocno
            #add-point:ON ACTION controlp INFIELD fabadocno name="input.c.fabadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faba_m.fabadocno             #給予default值

            LET g_qryparam.where = "     faba003 = '36' AND fabastus = 'Y' AND faba018 = '4' ",
                                   " AND fabadocno NOT IN (SELECT DISTINCT fabq021 FROM faba_t,fabq_t ",
                                   "                        WHERE fabaent = ",g_enterprise,
                                   "                          AND fabaent = fabqent ",
                                   "                          AND fabadocno = fabqdocno ",
                                   "                          AND faba003 = '37' ",
                                   "                          AND faba019 = ",g_faba019,
                                   "                      )"
 
            CALL q_fabadocno()                                #呼叫開窗
 
            LET g_faba_m.fabadocno = g_qryparam.return1              

            DISPLAY g_faba_m.fabadocno TO fabadocno              #

            NEXT FIELD fabadocno                          #返回原欄位



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
   CLOSE WINDOW w_afat720_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   CALL afat720_01_fabq_ins()
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat720_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat720_01.other_function" readonly="Y" >}
# 抵減單號檢查
PRIVATE FUNCTION afat720_01_fabadocno_chk()
   DEFINE l_faba018           LIKE faba_t.faba018
   DEFINE l_n                 LIKE type_t.num5
   
   LET g_errno = ''
   SELECT faba018 INTO l_faba018
     FROM faba_t
    WHERE fabaent = g_enterprise
      AND fabadocno = g_faba_m.fabadocno
      
   IF l_faba018 <> '4' THEN 
      LET g_errno = 'afa-01061'
      RETURN
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM faba_t,fabq_t
    WHERE fabaent = g_enterprise
      AND fabaent = fabqent
      AND fabadocno = fabqdocno
      AND faba003 = '37'
      AND faba019 = g_faba019
      AND fabq021 = g_faba_m.fabadocno
      
   IF l_n > 0 THEN 
      LET g_errno = 'afa-01063'
      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_n
     FROM faba_t,fabq_t
    WHERE fabaent = g_enterprise
      AND fabaent = fabqent
      AND fabadocno = fabqdocno
      AND faba003 = '37'
      AND fabq021 = g_faba_m.fabadocno 
      AND fabastus = 'N'
      
   IF l_n > 0 THEN 
      LET g_errno = 'afa-01064'
      RETURN
   END IF
END FUNCTION
# 整批產生單身資料
PRIVATE FUNCTION afat720_01_fabq_ins()
   DEFINE l_sql               STRING
   #161111-00028#8----modify----begin---------
   #DEFINE l_fabq         RECORD LIKE fabq_t.*
   DEFINE l_fabq RECORD  #資產抵押/解除單身檔
       fabqent LIKE fabq_t.fabqent, #企業編碼
       fabqsite LIKE fabq_t.fabqsite, #營運據點
       fabqdocno LIKE fabq_t.fabqdocno, #異動單號
       fabqseq LIKE fabq_t.fabqseq, #項次
       fabq001 LIKE fabq_t.fabq001, #抵押銀行
       fabq002 LIKE fabq_t.fabq002, #抵押文號
       fabq003 LIKE fabq_t.fabq003, #抵押日期
       fabq004 LIKE fabq_t.fabq004, #償還日期
       fabq005 LIKE fabq_t.fabq005, #財產編號
       fabq006 LIKE fabq_t.fabq006, #附號
       fabq007 LIKE fabq_t.fabq007, #卡片編號
       fabq008 LIKE fabq_t.fabq008, #規格
       fabq009 LIKE fabq_t.fabq009, #數量
       fabq010 LIKE fabq_t.fabq010, #成本
       fabq011 LIKE fabq_t.fabq011, #帳面金額
       fabq012 LIKE fabq_t.fabq012, #抵押幣別
       fabq013 LIKE fabq_t.fabq013, #匯率
       fabq014 LIKE fabq_t.fabq014, #抵押原幣金額/解除金額
       fabq015 LIKE fabq_t.fabq015, #抵押本幣抵押/解除金額
       fabq016 LIKE fabq_t.fabq016, #鑑價
       fabq017 LIKE fabq_t.fabq017, #異動原因
       fabq018 LIKE fabq_t.fabq018, #狀態
       fabq019 LIKE fabq_t.fabq019, #清償日期
       fabq020 LIKE fabq_t.fabq020, #鑑價日期
       fabq021 LIKE fabq_t.fabq021, #抵押單號
       fabq022 LIKE fabq_t.fabq022, #抵押項次
       fabq101 LIKE fabq_t.fabq101, #本幣位二幣別
       fabq102 LIKE fabq_t.fabq102, #本位幣二匯率
       fabq103 LIKE fabq_t.fabq103, #本位幣二成本
       fabq104 LIKE fabq_t.fabq104, #本位幣二帳面金額
       fabq105 LIKE fabq_t.fabq105, #本位幣二抵押金額/解除
       fabq111 LIKE fabq_t.fabq111, #本位幣三幣別
       fabq112 LIKE fabq_t.fabq112, #本位幣三匯率
       fabq113 LIKE fabq_t.fabq113, #本位幣三成本
       fabq114 LIKE fabq_t.fabq114, #本位幣三帳面金額
       fabq115 LIKE fabq_t.fabq115, #本位幣三抵押金額/解除
       fabq023 LIKE fabq_t.fabq023, #合併
       fabq024 LIKE fabq_t.fabq024, #抵減率
       fabq025 LIKE fabq_t.fabq025  #用途
       END RECORD

   #161111-00028#8----modify----end---------
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_faba020           LIKE faba_t.faba020
   DEFINE l_faba021           LIKE faba_t.faba021
   DEFINE l_faba022           LIKE faba_t.faba022
   DEFINE l_faba023           LIKE faba_t.faba023
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_flag = 'N'
   
   #161111-00028#8----modify----begin---------
   #LET l_sql = "SELECT fabq_t.* ",
   LET l_sql = "SELECT fabqent,fabqsite,fabqdocno,fabqseq,fabq001,fabq002,fabq003,fabq004,fabq005,fabq006,fabq007,",
               "fabq008,fabq009,fabq010,fabq011,fabq012,fabq013,fabq014,fabq015,fabq016,fabq017,fabq018,fabq019,",
               "fabq020,fabq021,fabq022,fabq101,fabq102,fabq103,fabq104,fabq105,fabq111,fabq112,fabq113,fabq114,",
               "fabq115,fabq023,fabq024,fabq025",
   #161111-00028#8----modify----end---------
               "  FROM faba_t,fabq_t ",
               " WHERE fabaent = ",g_enterprise,
               "   AND fabaent = fabqent ",
               "   AND fabadocno = fabqdocno ",
               "   AND faba003 = '36' ",
               "   AND fabadocno = '",g_faba_m.fabadocno,"'",
               " ORDER BY fabqseq "
   PREPARE afat720_01_fabq_ins_pre FROM l_sql
   DECLARE afat720_01_fabq_ins_cs CURSOR FOR afat720_01_fabq_ins_pre
   
   FOREACH afat720_01_fabq_ins_cs INTO l_fabq.*   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      LET l_fabq.fabqdocno = g_docno
      LET l_fabq.fabq021 = g_faba_m.fabadocno
      LET l_fabq.fabq022 = l_fabq.fabqseq
      #161111-00028#8----modify----begin---------
      #INSERT INTO fabq_t VALUES(l_fabq.*)
      INSERT INTO fabq_t (fabqent,fabqsite,fabqdocno,fabqseq,fabq001,fabq002,fabq003,fabq004,fabq005,fabq006,
                          fabq007,fabq008,fabq009,fabq010,fabq011,fabq012,fabq013,fabq014,fabq015,fabq016,fabq017,
                          fabq018,fabq019,fabq020,fabq021,fabq022,fabq101,fabq102,fabq103,fabq104,fabq105,fabq111,
                          fabq112,fabq113,fabq114,fabq115,fabq023,fabq024,fabq025)
       VALUES(l_fabq.fabqent,l_fabq.fabqsite,l_fabq.fabqdocno,l_fabq.fabqseq,l_fabq.fabq001,l_fabq.fabq002,l_fabq.fabq003,l_fabq.fabq004,l_fabq.fabq005,l_fabq.fabq006,
              l_fabq.fabq007,l_fabq.fabq008,l_fabq.fabq009,l_fabq.fabq010,l_fabq.fabq011,l_fabq.fabq012,l_fabq.fabq013,l_fabq.fabq014,l_fabq.fabq015,l_fabq.fabq016,l_fabq.fabq017,
              l_fabq.fabq018,l_fabq.fabq019,l_fabq.fabq020,l_fabq.fabq021,l_fabq.fabq022,l_fabq.fabq101,l_fabq.fabq102,l_fabq.fabq103,l_fabq.fabq104,l_fabq.fabq105,l_fabq.fabq111,
              l_fabq.fabq112,l_fabq.fabq113,l_fabq.fabq114,l_fabq.fabq115,l_fabq.fabq023,l_fabq.fabq024,l_fabq.fabq025)
      #161111-00028#8----modify----end---------
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "fabq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET l_success = FALSE                        
      END IF 
      LET l_flag = 'Y'      
   END FOREACH
   
   SELECT faba020,faba021,faba022,faba023
     INTO l_faba020,l_faba021,l_faba022,l_faba023
     FROM faba_t
    WHERE fabaent = g_enterprise
      AND fabadocno = g_faba_m.fabadocno
   
   UPDATE faba_t SET faba020 = l_faba020,
                     faba021 = l_faba021,
                     faba022 = l_faba022,
                     faba023 = l_faba023
    WHERE fabaent = g_enterprise
      AND fabadocno = g_docno
      
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "faba_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET l_success = FALSE                        
   END IF 
   
   
   CALL cl_err_collect_show()
   IF l_success = TRUE THEN 
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')  
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
   ELSE
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION

 
{</section>}
 
