#該程式未解開Section, 採用最新樣板產出!
{<section id="aisi010_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-07-05 11:04:39), PR版次:0001(2016-07-05 16:24:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: aisi010_01
#+ Description: 批次產生申報單位
#+ Creator....: 06821(2016-07-05 11:02:08)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aisi010_01.global" >}
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
PRIVATE type type_g_isaa_m        RECORD
       isaa001 LIKE isaa_t.isaa001, 
   isaa001_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_isaa_m        type_g_isaa_m
 
   DEFINE g_isaa001_t LIKE isaa_t.isaa001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisi010_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aisi010_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE l_cnt1          LIKE type_t.num10
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_isaa001       LIKE isaa_t.isaa001
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aisi010_01 WITH FORM cl_ap_formpath("ais","aisi010_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   
   INITIALIZE g_isaa_m.* TO NULL
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_isaa_m.isaa001 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa001
            
            #add-point:AFTER FIELD isaa001 name="input.a.isaa001"
            LET g_isaa_m.isaa001_desc = ''
            DISPLAY BY NAME g_isaa_m.isaa001_desc
            IF NOT cl_null(g_isaa_m.isaa001) THEN 
               CALL aisi010_01_isaa001_chk() RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isaa_m.isaa001 = ''
                  LET g_isaa_m.isaa001_desc = s_desc_get_ooefl006_desc(g_isaa_m.isaa001)
                  DISPLAY BY NAME g_isaa_m.isaa001,g_isaa_m.isaa001_desc
                  NEXT FIELD isaa001
               END IF
               #檢查該組織是否已存在aisi010
               LET l_cnt1 = 0
               SELECT COUNT(*) INTO l_cnt1 FROM isaa_t
                WHERE isaaent = g_enterprise AND isaa001 = g_isaa_m.isaa001
               IF l_cnt1 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'std-00006'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isaa_m.isaa001 = ''
                  LET g_isaa_m.isaa001_desc = s_desc_get_ooefl006_desc(g_isaa_m.isaa001)
                  DISPLAY BY NAME g_isaa_m.isaa001,g_isaa_m.isaa001_desc
                  NEXT FIELD isaa001
               END IF
            END IF 
            LET g_isaa_m.isaa001_desc = s_desc_get_ooefl006_desc(g_isaa_m.isaa001)
            DISPLAY BY NAME g_isaa_m.isaa001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa001
            #add-point:BEFORE FIELD isaa001 name="input.b.isaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa001
            #add-point:ON CHANGE isaa001 name="input.g.isaa001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa001
            #add-point:ON ACTION controlp INFIELD isaa001 name="input.c.isaa001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isaa_m.isaa001     #給予default值
            LET g_qryparam.where = " isaostus = 'Y' AND isaosite NOT IN (SELECT isaa001 FROM isaa_t WHERE isaaent = ",g_enterprise,") "            
            CALL q_isaosite()                              #呼叫開窗
            LET g_isaa_m.isaa001 = g_qryparam.return1              
            LET g_isaa_m.isaa001_desc = s_desc_get_ooefl006_desc(g_isaa_m.isaa001)
            DISPLAY BY NAME g_isaa_m.isaa001,g_isaa_m.isaa001_desc
            NEXT FIELD isaa001                             #返回原欄位
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
   CLOSE WINDOW w_aisi010_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   LET r_isaa001 = ''
   
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      CALL aisi010_01_ins_isaa() RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success= FALSE
      ELSE
         LET r_isaa001 = g_isaa_m.isaa001
      END IF
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success,r_isaa001 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisi010_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aisi010_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 組織檢核是否存在aisi090
# Memo...........:
# Usage..........: CALL aisi010_01_isaa001_chk()
# Date & Author..: 160705 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi010_01_isaa001_chk()
DEFINE r_success  LIKE type_t.num5
DEFINE r_errno    LIKE gzze_t.gzze001 
DEFINE l_isaostus LIKE isao_t.isaostus

   LET r_success = TRUE
   LET r_errno = ''
   LET l_isaostus = ''
   
   IF cl_null(g_isaa_m.isaa001) THEN RETURN END IF
   
   #檢查是否存在且參照表類型為0
   SELECT isaostus INTO l_isaostus FROM isao_t 
    WHERE isaoent = g_enterprise AND isaosite = g_isaa_m.isaa001
   
   CASE
      WHEN SQLCA.sqlcode = 100   
         LET r_errno = 'ais-00332'
         LET r_success = FALSE
      WHEN l_isaostus = 'N'
         LET r_errno = 'ais-00333'
         LET r_success = FALSE
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 將aisi090寫入aisi010
# Memo...........:
# Usage..........: CALL aisi010_01_ins_isaa()
# Date & Author..: 160705 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi010_01_ins_isaa()
DEFINE ld_date       DATETIME YEAR TO SECOND
DEFINE l_sql         STRING
DEFINE l_isao        RECORD                  #來源TABLE
         isao001     LIKE isao_t.isao001,   
         isao013     LIKE isao_t.isao013,   
         isao003     LIKE isao_t.isao003,   
         isao010     LIKE isao_t.isao010,   
         isao009     LIKE isao_t.isao009,   
         isao011     LIKE isao_t.isao011,   
         isao012     LIKE isao_t.isao012,   
         isao002     LIKE isao_t.isao002   
                     END RECORD                             
DEFINE l_isab        RECORD                   #單身
         isabent	   LIKE isab_t.isabent,     #企業編號
         isab001	   LIKE isab_t.isab001,     #申報單位編號
         isab002	   LIKE isab_t.isab002,     #稅別編號
         isab003	   LIKE isab_t.isab003,     #併增值稅申報否
         isab004	   LIKE isab_t.isab004,     #申報週期
         isab005	   LIKE isab_t.isab005,     #申報年度
         isab006	   LIKE isab_t.isab006      #申報月份
                     END RECORD                                                
DEFINE l_ooef012     LIKE ooef_t.ooef012
DEFINE l_isaa006     LIKE isaa_t.isaa006
DEFINE l_isaa009     LIKE isaa_t.isaa009
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   LET ld_date = cl_get_current()  
   
   LET l_ooef012 = ''
   SELECT DISTINCT ooef012 INTO l_ooef012 FROM ooef_t 
    WHERE ooefent = g_enterprise AND ooef001 = g_isaa_m.isaa001
   
   #來源資料aisi090
   INITIALIZE l_isao.* TO NULL
   LET l_sql = " SELECT isao001,isao013,isao003,isao010,isao009,isao011,isao012,isao002 ",
               "   FROM isao_t ",
               "  WHERE isaoent = ",g_enterprise,
               "    AND isaosite = '",g_isaa_m.isaa001,"' ",        
               "  ORDER BY isao001 "
               
   PREPARE aisi010_01_p FROM l_sql
   DECLARE aisi010_01_c CURSOR FOR aisi010_01_p
   FOREACH aisi010_01_c INTO l_isao.*
      
      
      #同aisi010欄位處理方法-------
      IF cl_null(l_isao.isao013) THEN
         SELECT oofc012 INTO l_isao.isao013
           FROM oofc_t 
          WHERE oofcent = g_enterprise
            AND oofc008 = '4'   #電子郵件 
            AND oofc010 = 'Y' 
            AND oofc002 = l_ooef012
      END IF
      IF cl_null(l_isao.isao003) THEN
      SELECT oofc012 INTO l_isao.isao003
        FROM oofc_t 
       WHERE oofcent = g_enterprise
         AND oofc008 = '1'   #電話
         AND oofc010 = 'Y' 
         AND oofc002 = l_ooef012
      END IF

      LET l_isaa006 = ''
      SELECT oofc012 INTO l_isaa006
        FROM oofc_t 
       WHERE oofcent = g_enterprise
         AND oofc008 = '3'   #傳真
         AND oofc010 = 'Y' 
         AND oofc002 = l_ooef012
      
      LET l_isaa009 = ''
      SELECT ooef017 INTO l_isaa009
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_isaa_m.isaa001      
      #-------------
      
      #新增單頭isaa_t
      INSERT INTO isaa_t(isaaent,isaa001,isaa002,isaa003,isaa004,isaa005,
                         isaa006,isaa007,isaa008,isaa009,isaa010,isaa011,
                         isaa012,isaa013,isaa014,isaa015,isaa016,isaa017,
                         isaa018,isaa019,isaa020,isaa021,isaastus,isaaownid,
                         isaaowndp,isaacrtid,isaacrtdp,isaacrtdt,isaamodid,isaamoddt,
                         isaa022,isaa023,isaa024,isaa025,isaa026,isaa027,
                         isaa028,isaa029,isaa030,isaa031,isaa032)                                                
                  VALUES(g_enterprise,g_isaa_m.isaa001,l_isao.isao001,'',l_isao.isao013,l_isao.isao003,
                         l_isaa006,'1','2',l_isaa009,'1',l_isao.isao010,
                         '','','','','','',
                         '','','','','Y',g_user,
                         g_dept,g_user,g_dept,ld_date,g_user,ld_date,
                         'Y','N',l_isao.isao009,l_isao.isao011,l_isao.isao012,'',
                         '','','',l_isao.isao002,'')                                                     
                         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_isaa_t_wrong"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
