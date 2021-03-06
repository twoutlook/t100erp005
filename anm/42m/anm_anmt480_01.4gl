#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt480_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-19 16:02:10), PR版次:0001(2015-11-20 09:56:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: anmt480_01
#+ Description: 自動產生單身
#+ Creator....: 02159(2015-11-19 15:35:52)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="anmt480_01.global" >}
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
PRIVATE type type_g_nmck_m        RECORD
       nmckcomp LIKE nmck_t.nmckcomp, 
   nmckcomp_desc LIKE type_t.chr80, 
   nmckdocno LIKE nmck_t.nmckdocno
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_nmck  STRING
DEFINE g_display_docdt STRING
 TYPE type_parameter RECORD
             nmchsite  LIKE nmch_t.nmchsite,   #資金中心
             nmchcomp  LIKE nmch_t.nmchcomp,   #法人
             nmchdocno LIKE nmch_t.nmchdocno,  #單據號碼
             nmchdocdt LIKE nmch_t.nmchdocdt,  #異動日期
             nmch003   LIKE nmch_t.nmch003     #交易帳戶
                            END RECORD                    
#end add-point
 
DEFINE g_nmck_m        type_g_nmck_m
 
   DEFINE g_nmckcomp_t LIKE nmck_t.nmckcomp
DEFINE g_nmckdocno_t LIKE nmck_t.nmckdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt480_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt480_01(--)
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
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter
   DEFINE r_success LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt480_01 WITH FORM cl_ap_formpath("anm","anmt480_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   CALL util.JSON.parse(ls_js,lc_param)
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmck_m.nmckcomp,g_nmck_m.nmckdocno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcomp
            
            #add-point:AFTER FIELD nmckcomp name="input.a.nmckcomp"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcomp
            #add-point:BEFORE FIELD nmckcomp name="input.b.nmckcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckcomp
            #add-point:ON CHANGE nmckcomp name="input.g.nmckcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocno
            #add-point:BEFORE FIELD nmckdocno name="input.b.nmckdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocno
            
            #add-point:AFTER FIELD nmckdocno name="input.a.nmckdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckdocno
            #add-point:ON CHANGE nmckdocno name="input.g.nmckdocno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcomp
            #add-point:ON ACTION controlp INFIELD nmckcomp name="input.c.nmckcomp"
            

            #END add-point
 
 
         #Ctrlp:input.c.nmckdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocno
            #add-point:ON ACTION controlp INFIELD nmckdocno name="input.c.nmckdocno"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT g_wc_nmck ON nmck011 FROM nmck011
         AFTER CONSTRUCT 
            LET g_display_docdt  = DIALOG.getFieldBuffer("nmck011")
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
   CLOSE WINDOW w_anmt480_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL cl_err_collect_init()
      CALL anmt480_01_ins_nmci(ls_js) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
      CALL cl_err_collect_show()
   ELSE
      LET INT_FLAG = FALSE
   END IF
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt480_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt480_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 自動產生單身
# Memo...........:
# Usage..........: CALL anmt480_01_ins_nmci(ls_js)
#                  RETURNING r_success
# Input parameter: ls_js
# Return code....: r_success    True/False
# Date & Author..: 2015/11/19 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt480_01_ins_nmci(ls_js)
DEFINE ls_js            STRING
DEFINE lc_param         type_parameter
DEFINE l_sql            STRING
DEFINE l_nmckdocno      LIKE nmck_t.nmckdocno
DEFINE l_date           DATETIME YEAR TO SECOND
DEFINE r_success        LIKE type_t.num5
   
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   CALL util.JSON.parse(ls_js,lc_param)
   
   #先撈出適合的匯款單據
   LET l_sql = "SELECT nmckdocno",
               "  FROM nmck_t",
               " WHERE nmckent = ",g_enterprise,
               "   AND nmcksite = '",lc_param.nmchsite,"'",
               "   AND nmckcomp = '",lc_param.nmchcomp,"'",
               "   AND nmck004 = '",lc_param.nmch003,"'",
               "   AND nmck026 ='10' ",
               "   AND nmck012 IS NULL ",
               "   AND nmckstus='Y' ",
               "   AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 IN ('10','20') AND ooiaent = ",g_enterprise,") ",
               "   AND nmckdocno NOT IN (",
               "       SELECT nmci003 FROM nmci_t ",
               "         LEFT JOIN nmch_t ON nmchent = nmcient AND nmchcomp = nmcicomp AND nmchdocno = nmcidocno ",
               "         WHERE nmchent = ",g_enterprise,
               "           AND nmchcomp = '",lc_param.nmchcomp,"'",
               "           AND nmchstus <> 'X'",
               "           AND nmch001 = '11'",
               "       )",
               "   AND ",g_wc_nmck CLIPPED,
               " ORDER BY nmckdocno"
   PREPARE anmt480_01_p FROM l_sql
   DECLARE anmt480_01_c CURSOR FOR anmt480_01_p
   FOREACH anmt480_01_c INTO l_nmckdocno
      CALL s_anmt480_ins_nmci(lc_param.nmchdocno,lc_param.nmchdocdt,lc_param.nmchcomp,'11',l_nmckdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
