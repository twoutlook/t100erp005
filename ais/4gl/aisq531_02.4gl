#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq531_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-03-02 14:27:11), PR版次:0002(2016-11-09 19:40:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aisq531_02
#+ Description: 清除發票列印碼
#+ Creator....: 05016(2016-03-02 14:22:55)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aisq531_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161104-00024#10  161108 By 08171  程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
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
PRIVATE type type_g_isax_m        RECORD
       isax006 LIKE isax_t.isax006, 
   isax005 LIKE isax_t.isax005, 
   isax007 LIKE isax_t.isax007
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_isax_m        type_g_isax_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisq531_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aisq531_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_isaw001,p_isaw002,p_isaw003,p_isawcomp
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
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
  #DEFINE l_isax    RECORD LIKE isax_t.*   #161104-00024#10 mark
   #161104-00024#10 --s add
   DEFINE l_isax RECORD  #電子發票列印異動紀錄檔
          isaxent LIKE isax_t.isaxent, #企業編號
          isaxseq LIKE isax_t.isaxseq, #項次
          isax001 LIKE isax_t.isax001, #總公司統一編號
          isax002 LIKE isax_t.isax002, #發票所屬年度
          isax003 LIKE isax_t.isax003, #發票所屬月份
          isax004 LIKE isax_t.isax004, #發票編號
          isax005 LIKE isax_t.isax005, #發票號碼
          isax006 LIKE isax_t.isax006, #載具顯碼ID
          isax007 LIKE isax_t.isax007, #異動原因
          isax008 LIKE isax_t.isax008, #異動類型
          isax009 LIKE isax_t.isax009, #異動日期
          isax010 LIKE isax_t.isax010, #異動人員
          isax011 LIKE isax_t.isax011, #異動時間
          isaxcomp LIKE isax_t.isaxcomp, #法人
          isaxsite LIKE isax_t.isaxsite, #營運據點
          isaxud001 LIKE isax_t.isaxud001, #自定義欄位(文字)001
          isaxud002 LIKE isax_t.isaxud002, #自定義欄位(文字)002
          isaxud003 LIKE isax_t.isaxud003, #自定義欄位(文字)003
          isaxud004 LIKE isax_t.isaxud004, #自定義欄位(文字)004
          isaxud005 LIKE isax_t.isaxud005, #自定義欄位(文字)005
          isaxud006 LIKE isax_t.isaxud006, #自定義欄位(文字)006
          isaxud007 LIKE isax_t.isaxud007, #自定義欄位(文字)007
          isaxud008 LIKE isax_t.isaxud008, #自定義欄位(文字)008
          isaxud009 LIKE isax_t.isaxud009, #自定義欄位(文字)009
          isaxud010 LIKE isax_t.isaxud010, #自定義欄位(文字)010
          isaxud011 LIKE isax_t.isaxud011, #自定義欄位(數字)011
          isaxud012 LIKE isax_t.isaxud012, #自定義欄位(數字)012
          isaxud013 LIKE isax_t.isaxud013, #自定義欄位(數字)013
          isaxud014 LIKE isax_t.isaxud014, #自定義欄位(數字)014
          isaxud015 LIKE isax_t.isaxud015, #自定義欄位(數字)015
          isaxud016 LIKE isax_t.isaxud016, #自定義欄位(數字)016
          isaxud017 LIKE isax_t.isaxud017, #自定義欄位(數字)017
          isaxud018 LIKE isax_t.isaxud018, #自定義欄位(數字)018
          isaxud019 LIKE isax_t.isaxud019, #自定義欄位(數字)019
          isaxud020 LIKE isax_t.isaxud020, #自定義欄位(數字)020
          isaxud021 LIKE isax_t.isaxud021, #自定義欄位(日期時間)021
          isaxud022 LIKE isax_t.isaxud022, #自定義欄位(日期時間)022
          isaxud023 LIKE isax_t.isaxud023, #自定義欄位(日期時間)023
          isaxud024 LIKE isax_t.isaxud024, #自定義欄位(日期時間)024
          isaxud025 LIKE isax_t.isaxud025, #自定義欄位(日期時間)025
          isaxud026 LIKE isax_t.isaxud026, #自定義欄位(日期時間)026
          isaxud027 LIKE isax_t.isaxud027, #自定義欄位(日期時間)027
          isaxud028 LIKE isax_t.isaxud028, #自定義欄位(日期時間)028
          isaxud029 LIKE isax_t.isaxud029, #自定義欄位(日期時間)029
          isaxud030 LIKE isax_t.isaxud030  #自定義欄位(日期時間)030
   END RECORD
   #161104-00024#10 --e add
   DEFINE p_isawcomp LIKE isaw_t.isawcomp
   DEFINE p_isaw001  LIKE isaw_t.isaw001
   DEFINE p_isaw002  LIKE isaw_t.isaw002
   DEFINE p_isaw003  LIKE isaw_t.isaw003
   DEFINE l_sql  STRING   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aisq531_02 WITH FORM cl_ap_formpath("ais","aisq531_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('isax007','9758')    
   LET g_isax_m.isax006 = ''
   LET g_isax_m.isax005 = ''
   LET g_isax_m.isax007 = ''    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_isax_m.isax006,g_isax_m.isax005,g_isax_m.isax007 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isax006
            #add-point:BEFORE FIELD isax006 name="input.b.isax006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isax006
            
            #add-point:AFTER FIELD isax006 name="input.a.isax006"
            IF NOT cl_null(g_isax_m.isax006) THEN
               CALL aisq531_02_isax_chk(g_isax_m.isax006,g_isax_m.isax005) 
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isax_m.isax005 = ''
                  LET g_isax_m.isax006 = ''
                  DISPLAY BY NAME g_isax_m.isax005,g_isax_m.isax006               
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isax006
            #add-point:ON CHANGE isax006 name="input.g.isax006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isax005
            #add-point:BEFORE FIELD isax005 name="input.b.isax005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isax005
            
            #add-point:AFTER FIELD isax005 name="input.a.isax005"
            IF NOT cl_null(g_isax_m.isax005) THEN
               CALL aisq531_02_isax_chk(g_isax_m.isax006,g_isax_m.isax005) 
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isax_m.isax005 = ''
                  LET g_isax_m.isax006 = ''
                  DISPLAY BY NAME g_isax_m.isax005,g_isax_m.isax006               
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isax005
            #add-point:ON CHANGE isax005 name="input.g.isax005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isax007
            #add-point:BEFORE FIELD isax007 name="input.b.isax007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isax007
            
            #add-point:AFTER FIELD isax007 name="input.a.isax007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isax007
            #add-point:ON CHANGE isax007 name="input.g.isax007"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isax006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isax006
            #add-point:ON ACTION controlp INFIELD isax006 name="input.c.isax006"
            
            #END add-point
 
 
         #Ctrlp:input.c.isax005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isax005
            #add-point:ON ACTION controlp INFIELD isax005 name="input.c.isax005"
            
            #END add-point
 
 
         #Ctrlp:input.c.isax007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isax007
            #add-point:ON ACTION controlp INFIELD isax007 name="input.c.isax007"
            
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
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_aisq531_02
      RETURN
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aisq531_02 
   
   #add-point:input段after input name="input.post_input"
   #調整發票列印次數
   CALL s_transaction_begin()
   LET l_sql = "UPDATE isat_t SET isat021 = 0",
               " WHERE isat014 = '11'",
                 " AND isat004 = '",g_isax_m.isax005,"'",
                 " AND isat002 = 'Y' ",
                 " AND isat206 = '",g_isax_m.isax006,"'",
                 " AND isatent = '",g_enterprise,"' "
                 
   PREPARE aisq531_upd_isat021 FROM l_sql
   EXECUTE aisq531_upd_isat021
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN   
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd isat021 " 
      LET g_errparam.code   = 'ais-00301' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   # 調整發票列印碼
   LET l_sql = "UPDATE isaw_t SET isaw029 = 'N'",
               " WHERE isawent = '",g_enterprise,"' ",
               " AND isawcomp  = '",p_isawcomp,"' ",
               " AND isaw002   = '",p_isaw002,"'  ",
               " AND isaw003   = '",p_isaw003,"'",
               " AND isaw005   = '",g_isax_m.isax005,"'"
   PREPARE aisq531_upd_isaw029 FROM l_sql
   EXECUTE aisq531_upd_isaw029
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN   
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd isaw029 " 
      LET g_errparam.code   = 'ais-00301' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   # 寫入列印異動清單中
   LET l_n = 0
   SELECT MAX(isaxseq)+1 INTO l_n FROM isax_t
    WHERE isaxcomp = p_isawcomp
      AND isax002  = p_isaw002
      AND isax003  = p_isaw003
      AND isaxent = g_enterprise
   IF cl_null(l_n) THEN
      LET l_n = 1
   END IF
   LET l_isax.isax001 = p_isaw001
   LET l_isax.isax002 = p_isaw002
   LET l_isax.isax003 = p_isaw003
   LET l_isax.isax004 = ' '
   LET l_isax.isax005 = g_isax_m.isax005
   LET l_isax.isax006 = g_isax_m.isax006
   LET l_isax.isax007 = g_isax_m.isax007
   LET l_isax.isax008 = '1'
   LET l_isax.isax009 = g_today
   LET l_isax.isax010 = g_user
   LET l_isax.isax011 = cl_get_current()
   LET l_isax.isaxseq = l_n
   LET l_isax.isaxent = g_enterprise
   LET l_isax.isaxcomp = p_isawcomp
   LET l_isax.isaxsite = p_isawcomp
          
   INSERT INTO isax_t
   VALUES (l_isax.*)
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN   
     INITIALIZE g_errparam TO NULL 
     LET g_errparam.extend = "ISERT INTO isat_t " 
     LET g_errparam.code   = SQLCA.sqlcode 
     LET g_errparam.popup  = TRUE 
     CALL cl_err()
     CALL s_transaction_end('N','0')
     RETURN
   END IF
   CALL s_transaction_end('Y','0')
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq531_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aisq531_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 載具顯碼檢核
# Memo...........:
# Usage..........: CALL aisq531_02_isax006_chk(p_isax006)
# Date & Author..: 2016/03/03 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq531_02_isax_chk(p_isax006,p_isax005)
DEFINE p_isax006   LIKE isax_t.isax006　#載具顯碼
DEFINE p_isax005   LIKE isax_t.isax005 #發票號碼
DEFINE r_success   LIKE type_t.num5
DEFINE r_errno     LIKE gzze_t.gzze001
DEFINE l_count     LIKE type_t.num5

   LET r_success = TRUE
   
   IF NOT cl_null(p_isax006) THEN
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM isaw_t WHERE isawent = g_enterprise
         AND isaw014 = p_isax006
      IF cl_null(l_count) THEN LET l_count = 0 END If
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00303'
         RETURN r_success,r_errno
      END IF
   END IF
   
   IF NOT cl_null(p_isax005) THEN
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM isaw_t WHERE isawent = g_enterprise
         AND isaw005 = p_isax005 
      IF cl_null(l_count) THEN LET l_count = 0 END If
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00304'
         RETURN r_success,r_errno
      END IF
   END IF

   IF NOT cl_null(p_isax005) AND NOT cl_null(p_isax006) THEN
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM isaw_t WHERE isawent = g_enterprise
         AND isaw005 = p_isax005 AND isaw014 = p_isax006
      IF cl_null(l_count) THEN LET l_count = 0 END If
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00305'
         RETURN r_success,r_errno
      END IF
   END IF

   RETURN r_success,r_errno

END FUNCTION

 
{</section>}
 
