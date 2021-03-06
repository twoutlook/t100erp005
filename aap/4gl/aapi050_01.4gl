#該程式未解開Section, 採用最新樣板產出!
{<section id="aapi050_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-12-10 11:54:59), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: aapi050_01
#+ Description: 批次產生資料
#+ Creator....: 02159(2015-12-08 14:23:56)
#+ Modifier...: 02159 -SD/PR- 00000
 
{</section>}
 
{<section id="aapi050_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
 
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
PRIVATE type type_g_apaa_m        RECORD
       apaa004 LIKE apaa_t.apaa004, 
   apaa005 LIKE apaa_t.apaa005, 
   apaa006 LIKE apaa_t.apaa006, 
   apaa007 LIKE apaa_t.apaa007, 
   apaa008 LIKE apaa_t.apaa008, 
   apaa009 LIKE apaa_t.apaa009, 
   apaa001 LIKE apaa_t.apaa001
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_parameter RECORD
     apaasite  LIKE apaa_t.apaasite,   #營運據點
     apaa002   LIKE apaa_t.apaa002     #付款/收款
                    END RECORD
DEFINE g_wc         STRING                    
#end add-point
 
DEFINE g_apaa_m        type_g_apaa_m
 
   DEFINE g_apaa001_t LIKE apaa_t.apaa001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapi050_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapi050_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   ls_js
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
   DEFINE ls_js     STRING
   DEFINE lc_param  type_parameter
   DEFINE r_success LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapi050_01 WITH FORM cl_ap_formpath("aap","aapi050_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   CALL util.JSON.parse(ls_js,lc_param)
   CALL cl_set_combo_scc('apaa004','8712')
   CALL cl_set_combo_scc('apaa006','8508')
   CALL cl_set_combo_scc('apaa008','8508')
   CALL cl_set_combo_scc('apaa009','6')   
   LET g_apaa_m.apaa004 = '1' 
   LET g_apaa_m.apaa005 = 0
   LET g_apaa_m.apaa006 = '0'
   LET g_apaa_m.apaa007 = 0
   LET g_apaa_m.apaa008 = '0'
   LET g_apaa_m.apaa009 = '1'
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apaa_m.apaa004,g_apaa_m.apaa005,g_apaa_m.apaa006,g_apaa_m.apaa007,g_apaa_m.apaa008, 
          g_apaa_m.apaa009 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaa004
            #add-point:BEFORE FIELD apaa004 name="input.b.apaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaa004
            
            #add-point:AFTER FIELD apaa004 name="input.a.apaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaa004
            #add-point:ON CHANGE apaa004 name="input.g.apaa004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaa005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apaa_m.apaa005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD apaa005
            END IF 
 
 
 
            #add-point:AFTER FIELD apaa005 name="input.a.apaa005"
            IF NOT cl_null(g_apaa_m.apaa005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaa005
            #add-point:BEFORE FIELD apaa005 name="input.b.apaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaa005
            #add-point:ON CHANGE apaa005 name="input.g.apaa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaa006
            #add-point:BEFORE FIELD apaa006 name="input.b.apaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaa006
            
            #add-point:AFTER FIELD apaa006 name="input.a.apaa006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaa006
            #add-point:ON CHANGE apaa006 name="input.g.apaa006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaa007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apaa_m.apaa007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD apaa007
            END IF 
 
 
 
            #add-point:AFTER FIELD apaa007 name="input.a.apaa007"
            IF NOT cl_null(g_apaa_m.apaa007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaa007
            #add-point:BEFORE FIELD apaa007 name="input.b.apaa007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaa007
            #add-point:ON CHANGE apaa007 name="input.g.apaa007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaa008
            #add-point:BEFORE FIELD apaa008 name="input.b.apaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaa008
            
            #add-point:AFTER FIELD apaa008 name="input.a.apaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaa008
            #add-point:ON CHANGE apaa008 name="input.g.apaa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaa009
            #add-point:BEFORE FIELD apaa009 name="input.b.apaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaa009
            
            #add-point:AFTER FIELD apaa009 name="input.a.apaa009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaa009
            #add-point:ON CHANGE apaa009 name="input.g.apaa009"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaa004
            #add-point:ON ACTION controlp INFIELD apaa004 name="input.c.apaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.apaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaa005
            #add-point:ON ACTION controlp INFIELD apaa005 name="input.c.apaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.apaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaa006
            #add-point:ON ACTION controlp INFIELD apaa006 name="input.c.apaa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.apaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaa007
            #add-point:ON ACTION controlp INFIELD apaa007 name="input.c.apaa007"
            
            #END add-point
 
 
         #Ctrlp:input.c.apaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaa008
            #add-point:ON ACTION controlp INFIELD apaa008 name="input.c.apaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaa009
            #add-point:ON ACTION controlp INFIELD apaa009 name="input.c.apaa009"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON apaa001
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD apaa001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   CASE lc_param.apaa002
			      WHEN '1'
			         LET g_qryparam.arg1 = "('1','3')"
			      WHEN '2'
	               LET g_qryparam.arg1 = "('2','3')"
	            OTHERWISE
	               LET g_qryparam.arg1 = "('1','3')"
	         END CASE
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO apaa001
            NEXT FIELD apaa001
      END CONSTRUCT
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
   CLOSE WINDOW w_aapi050_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      CALL aapi050_01_ins_apaa(ls_js) RETURNING g_sub_success
      IF g_sub_success THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      CALL cl_err_collect_show()
   ELSE
      LET INT_FLAG = FALSE
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapi050_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapi050_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 自動產生單身
# Memo...........:
# Usage..........: CALL aapi050_01_ins_apaa(ls_js)
#                  RETURNING r_success
# Input parameter: ls_js
# Return code....: r_success    True/False
# Date & Author..: 2015/12/08 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aapi050_01_ins_apaa(ls_js)
DEFINE ls_js            STRING
DEFINE r_success        LIKE type_t.num5
DEFINE lc_param         type_parameter
DEFINE l_sql            STRING
DEFINE l_apaa001        LIKE apaa_t.apaa001
DEFINE ld_date          DATETIME YEAR TO SECOND
DEFINE l_cnt            LIKE type_t.num5
   
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   CALL util.JSON.parse(ls_js,lc_param)
   
   LET ld_date = cl_get_current()  
   LET g_wc  = cl_replace_str(g_wc,'apaa001','pmaa001')
   #先撈出適合的交易對象資料
   LET l_sql = " SELECT DISTINCT pmaa001 ",
               "   FROM pmaa_t ",
               "  WHERE pmaaent = ",g_enterprise,
               "    AND ",g_wc,               
               "  ORDER BY pmaa001 "
   PREPARE aapi050_01_p FROM l_sql
   DECLARE aapi050_01_c CURSOR FOR aapi050_01_p
   FOREACH aapi050_01_c INTO l_apaa001
            
      #檢查是否重覆輸入
      SELECT COUNT(*) INTO l_cnt
        FROM apaa_t
       WHERE apaaent = g_enterprise
	     AND apaasite = lc_param.apaasite
         AND apaa001 = l_apaa001
		 AND apaa002 = lc_param.apaa002
		 
      IF l_cnt > 0 THEN   
         CONTINUE FOREACH
      ELSE
         INSERT INTO apaa_t
                     (apaaent  , apaasite , apaa001   , apaa002  , apaastus ,
                      apaa003  , apaa004  , apaa005   , apaa006  , apaa007  ,
                      apaa008  , apaa009  , apaaownid , apaaowndp, apaacrtid,
                      apaacrtdp, apaacrtdt, apaamodid , apaamoddt) 
               VALUES(g_enterprise,lc_param.apaasite,l_apaa001,lc_param.apaa002,'Y',
                      'Y',g_apaa_m.apaa004,g_apaa_m.apaa005,g_apaa_m.apaa006,g_apaa_m.apaa007,
                      g_apaa_m.apaa008,g_apaa_m.apaa009,g_user,g_dept,g_user,
                      g_dept,ld_date,g_user,ld_date)
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins_apaa wrong!!"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
