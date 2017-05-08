#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt520_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-01 16:14:37), PR版次:0002(2016-11-30 15:36:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: anmt520_01
#+ Description: 票據重新立帳
#+ Creator....: 01531(2016-07-01 09:58:02)
#+ Modifier...: 01531 -SD/PR- 02481
 
{</section>}
 
{<section id="anmt520_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161128-00061#2  2016/11/30 by 02481  标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_xrca_m        RECORD
       xrcadocno LIKE xrca_t.xrcadocno, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE type_t.chr80, 
   xrca007 LIKE xrca_t.xrca007, 
   xrca007_desc LIKE type_t.chr80, 
   xrca009 LIKE xrca_t.xrca009
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaa024       LIKE glaa_t.glaa024
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_sql           STRING 
DEFINE g_nmcqcomp      LIKE nmcq_t.nmcqcomp
DEFINE g_nmcqdocno     LIKE nmcq_t.nmcqdocno   
DEFINE g_nmcqsite      LIKE nmcq_t.nmcqsite 
DEFINE g_ooef019       LIKE ooef_t.ooef019
#end add-point
 
DEFINE g_xrca_m        type_g_xrca_m
 
   DEFINE g_xrcadocno_t LIKE xrca_t.xrcadocno
DEFINE g_xrcald_t LIKE xrca_t.xrcald
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="anmt520_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt520_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_nmcqcomp,p_nmcqdocno,p_nmcqsite
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
   DEFINE p_nmcqcomp      LIKE nmcq_t.nmcqcomp
   DEFINE p_nmcqdocno     LIKE nmcq_t.nmcqdocno   
   DEFINE p_nmcqsite      LIKE nmcq_t.nmcqsite
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_success1     LIKE type_t.num5
      
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt520_01 WITH FORM cl_ap_formpath("anm","anmt520_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_success1 = TRUE
   SELECT glaald,glaa024,glaa020,glaa016 INTO g_glaald,g_glaa024,g_glaa020,g_glaa016 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = p_nmcqcomp AND glaa014 = 'Y'
   LET g_xrca_m.xrcald = g_glaald  
   CALL cl_set_comp_visible("xrcald",FALSE)
   LET g_xrca_m.xrca009 = g_today
   LET g_nmcqcomp = p_nmcqcomp
   LET g_nmcqdocno = p_nmcqdocno
   LET g_nmcqsite = p_nmcqsite
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrca_m.xrcadocno,g_xrca_m.xrcald,g_xrca_m.xrca007,g_xrca_m.xrca009 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="input.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrca_m.xrcald) AND NOT cl_null(g_xrca_m.xrcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrca_m.xrcald != g_xrcald_t  OR g_xrca_m.xrcadocno != g_xrcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrca_t WHERE "||"xrcaent = '" ||g_enterprise|| "' AND "||"xrcald = '"||g_xrca_m.xrcald ||"' AND "|| "xrcadocno = '"||g_xrca_m.xrcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocno
            #add-point:ON CHANGE xrcadocno name="input.g.xrcadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="input.a.xrcald"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrca_m.xrcald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrca_m.xrcald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrca_m.xrcald_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrca_m.xrcald) AND NOT cl_null(g_xrca_m.xrcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrca_m.xrcald != g_xrcald_t  OR g_xrca_m.xrcadocno != g_xrcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrca_t WHERE "||"xrcaent = '" ||g_enterprise|| "' AND "||"xrcald = '"||g_xrca_m.xrcald ||"' AND "|| "xrcadocno = '"||g_xrca_m.xrcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="input.b.xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcald
            #add-point:ON CHANGE xrcald name="input.g.xrcald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca007
            
            #add-point:AFTER FIELD xrca007 name="input.a.xrca007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrca_m.xrca007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrca_m.xrca007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrca_m.xrca007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca007
            #add-point:BEFORE FIELD xrca007 name="input.b.xrca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca007
            #add-point:ON CHANGE xrca007 name="input.g.xrca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca009
            #add-point:BEFORE FIELD xrca009 name="input.b.xrca009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca009
            
            #add-point:AFTER FIELD xrca009 name="input.a.xrca009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca009
            #add-point:ON CHANGE xrca009 name="input.g.xrca009"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrca_m.xrcadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024 #s
            LET g_qryparam.arg2 = "axrt330" #s
            LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                    "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                    "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "  #只能選不產生分录的單別            
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_xrca_m.xrcadocno = g_qryparam.return1              

            DISPLAY g_xrca_m.xrcadocno TO xrcadocno              #

            NEXT FIELD xrcadocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="input.c.xrcald"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
 
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_xrca_m.xrcald = g_qryparam.return1              

            DISPLAY g_xrca_m.xrcald TO xrcald              #

            NEXT FIELD xrcald                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca007
            #add-point:ON ACTION controlp INFIELD xrca007 name="input.c.xrca007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrca_m.xrca007             #給予default值
            LET g_qryparam.default2 = "" #g_xrca_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3111" #s 3111

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_xrca_m.xrca007 = g_qryparam.return1              
            #LET g_xrca_m.oocq002 = g_qryparam.return2 
            DISPLAY g_xrca_m.xrca007 TO xrca007              #
            #DISPLAY g_xrca_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD xrca007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca009
            #add-point:ON ACTION controlp INFIELD xrca009 name="input.c.xrca009"
            
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
   CLOSE WINDOW w_anmt520_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL anmt520_01_get_data()
      CALL anmt520_01_ins_xrca() RETURNING r_success 
      IF r_success = FALSE THEN LET r_success1 = FALSE END IF 
   ELSE
      LET INT_FLAG = FALSE
      LET r_success1 = FALSE
      LET r_success = TRUE
   END IF   
   RETURN r_success,r_success1
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt520_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt520_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 临时表
# Memo...........:
# Usage..........: CALL anmt520_01_create_tmp()
# Input parameter:  
# Date & Author..: 2016/06/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt520_01_create_tmp()
DROP TABLE anmt520_01_tmp;
 CREATE TEMP TABLE anmt520_01_tmp(
     nmcq100   VARCHAR(10),        #票据币别 
     nmcr001   VARCHAR(20),        #票据号码 
     nmcr003   VARCHAR(20),        #开票单号 
     xrca004   VARCHAR(10),        #交易对象 
     xrca005   VARCHAR(10),        #付款对象 
     nmcr103   DECIMAL(20,6),        #原币金额
     nmcrseq   INTEGER     #单身项次     
 );
END FUNCTION

################################################################################
# Descriptions...: 获取资料
# Memo...........:
# Usage..........: CALL anmt520_01_get_data()
# Input parameter:  
# Date & Author..: 2016/06/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt520_01_get_data()
DEFINE l_tmp   RECORD
     nmcq100  LIKE nmcq_t.nmcq100,   #票据币别 
     nmcr001  LIKE nmcr_t.nmcr001,   #票据号码 
     nmcr003  LIKE nmcr_t.nmcr003,   #开票单号 
     xrca004  LIKE xrca_t.xrca004,   #交易对象 
     xrca005  LIKE xrca_t.xrca005,   #付款对象 
     nmcr103  LIKE nmcr_t.nmcr103,   #原币金额
     nmcrseq  LIKE nmcr_t.nmcrseq    #单身项次         
               END  RECORD
DEFINE l_cnt   LIKE type_t.num5               

   CALL anmt520_01_create_tmp()
   DELETE FROM anmt520_01_tmp
   
               #票据币别，票据号码，开票单号，交易对象，付款对象，原币金额， 
   LET g_sql = " SELECT nmcq100,nmcr001,nmcr003,'','',nmcr103,nmcrseq ",
               "   FROM nmcq_t,nmcr_t ",
               "  WHERE nmcqent = nmcrent AND nmcqcomp = nmcrcomp AND nmcrdocno = nmcqdocno ",
               "    AND nmcqent = '",g_enterprise,"' AND nmcqcomp = '",g_nmcqcomp,"'",
               "    AND nmcqdocno = '",g_nmcqdocno,"'"  

   PREPARE anmt520_01_sel_prep FROM g_sql
   DECLARE anmt520_01_sel_curs CURSOR FOR anmt520_01_sel_prep   
   
   #取交易對象及收款對象
   LET g_sql = " SELECT xrca004,xrca005 FROM xrca_t,xrde_t ",
               "  WHERE xrdeent = '",g_enterprise,"'",
               "    AND xrdeld = '",g_glaald,"'",
               "    AND xrdedocno = xrcadocno ", 
               "    AND xrde008 = ? ", #票据號碼 nmck025/nmcr001
               "    AND xrcastus ='Y' ",
               " UNION ",
               " SELECT xrda004,xrda005 FROM xrda_t,xrde_t",
               "  WHERE xrdadocno = xrdedocno ", 
               "    AND xrde003 = ? ",#开票单号 nmbbdocno/nmcr003 
               "    AND xrdastus = 'Y' "
   PREPARE anmt520_01_sel_prep2 FROM g_sql
   DECLARE anmt520_01_sel_curs2 CURSOR FOR anmt520_01_sel_prep2 

   LET g_sql = " SELECT nmbb026 FROM nmbb_t ",
               "  WHERE nmbbent = '",g_enterprise,"' AND nmbbdocno = ? ",
               "    AND nmbb030 = ? ",
               "    AND nmbbcomp = '",g_nmcqcomp,"'"
   PREPARE anmt520_01_sel_prep3 FROM g_sql
   DECLARE anmt520_01_sel_curs3 CURSOR FOR anmt520_01_sel_prep3                
   
   FOREACH anmt520_01_sel_curs INTO l_tmp.nmcq100,l_tmp.nmcr001,l_tmp.nmcr003,l_tmp.xrca004,l_tmp.xrca005,l_tmp.nmcr103,l_tmp.nmcrseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      
      EXECUTE anmt520_01_sel_curs2 USING l_tmp.nmcr001,l_tmp.nmcr003
           INTO l_tmp.xrca004,l_tmp.xrca005
           
      IF cl_null(l_tmp.xrca004) THEN
         EXECUTE anmt520_01_sel_curs3 USING l_tmp.nmcr003,l_tmp.nmcr001
            INTO l_tmp.xrca004       
      END IF 
      IF cl_null(l_tmp.xrca005) THEN
         EXECUTE anmt520_01_sel_curs3 USING l_tmp.nmcr003,l_tmp.nmcr001
            INTO l_tmp.xrca005       
      END IF       
      
      INSERT INTO anmt520_01_tmp VALUES (l_tmp.*)
       
   END FOREACH
   #备注
   SELECT COUNT(*) INTO l_cnt FROM anmt520_01_tmp;
END FUNCTION

################################################################################
# Descriptions...: anmt520_01_ins_xrca()
# Memo...........:
# Usage..........: CALL anmt520_01_ins_xrca()
# Input parameter: 
# Date & Author..: 2016/06/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt520_01_ins_xrca()
#161128-00061#2---modify----begin----------
#DEFINE g_xrca  RECORD LIKE xrca_t.*
#DEFINE g_xrcb  RECORD LIKE xrcb_t.*
#DEFINE g_xrcc  RECORD LIKE xrcc_t.*
DEFINE g_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票代碼
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138  #本位幣三應收金額
       END RECORD
DEFINE g_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
DEFINE g_xrcc RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企業編號
       xrccld LIKE xrcc_t.xrccld, #帳套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #應收帳款單號碼
       xrccseq LIKE xrcc_t.xrccseq, #項次
       xrcc001 LIKE xrcc_t.xrcc001, #期別
       xrcc002 LIKE xrcc_t.xrcc002, #應收收款類別
       xrcc003 LIKE xrcc_t.xrcc003, #應收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容許票據到期日
       xrcc005 LIKE xrcc_t.xrcc005, #帳款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正負值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算組織
       xrcc008 LIKE xrcc_t.xrcc008, #發票代碼
       xrcc009 LIKE xrcc_t.xrcc009, #發票號碼
       xrccsite LIKE xrcc_t.xrccsite, #帳務中心
       xrcc010 LIKE xrcc_t.xrcc010, #發票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出貨單據日期
       xrcc012 LIKE xrcc_t.xrcc012, #立帳日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易認定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入庫扣帳日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原幣別
       xrcc101 LIKE xrcc_t.xrcc101, #原幣匯率
       xrcc102 LIKE xrcc_t.xrcc102, #原幣重估後匯率
       xrcc103 LIKE xrcc_t.xrcc103, #重評價調整數
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原幣應收金額
       xrcc109 LIKE xrcc_t.xrcc109, #原幣收款沖帳金額
       xrcc113 LIKE xrcc_t.xrcc113, #本幣重評價調整數
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本幣應收金額
       xrcc119 LIKE xrcc_t.xrcc119, #本幣收款沖帳金額
       xrcc120 LIKE xrcc_t.xrcc120, #本位幣二幣別
       xrcc121 LIKE xrcc_t.xrcc121, #本位幣二匯率
       xrcc122 LIKE xrcc_t.xrcc122, #本位幣二重估後匯率
       xrcc123 LIKE xrcc_t.xrcc123, #本位幣二重評價調整數
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位幣二應收金額
       xrcc129 LIKE xrcc_t.xrcc129, #本位幣二收款沖帳金額
       xrcc130 LIKE xrcc_t.xrcc130, #本位幣三幣別
       xrcc131 LIKE xrcc_t.xrcc131, #本位幣三匯率
       xrcc132 LIKE xrcc_t.xrcc132, #本位幣三重估後匯率
       xrcc133 LIKE xrcc_t.xrcc133, #本位幣三重評價調整數
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位幣三應收金額
       xrcc139 LIKE xrcc_t.xrcc139, #本位幣三收款沖帳金額
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD

#161128-00061#2---modify----end----------
DEFINE ls_js         STRING
DEFINE lc_param      RECORD
         xrca004     LIKE xrca_t.xrca004      
                 END RECORD
DEFINE l_nmcr103     LIKE nmcr_t.nmcr103
DEFINE l_xrca100     LIKE xrca_t.xrca100
DEFINE l_oodb004     LIKE oodb_t.oodb004
DEFINE l_oodb011     LIKE oodb_t.oodb011
DEFINE l_xrca034_desc  LIKE type_t.chr80
DEFINE l_xrac007 LIKE xrac_t.xrac007
DEFINE l_xrac008 LIKE xrac_t.xrac008
DEFINE l_n       LIKE type_t.num5
DEFINE r_success LIKE type_t.num5
DEFINE l_nmcrseq LIKE nmcr_t.nmcrseq
DEFINE l_comp    LIKE xrca_t.xrcacomp
DEFINE l_xrca004_desc  LIKE type_t.chr80
DEFINE l_xrca008_desc  LIKE type_t.chr80
DEFINE l_xrca007_desc  LIKE type_t.chr80
DEFINE l_xrca014_desc  LIKE type_t.chr80
DEFINE l_xrca015_desc  LIKE type_t.chr80
DEFINE l_xrca100_2     LIKE xrca_t.xrca100
DEFINE l_xrca005_desc  LIKE type_t.chr80
DEFINE l_xrca058_desc  LIKE type_t.chr80
DEFINE l_xrca035_desc  LIKE type_t.chr80
DEFINE l_xrca036_desc  LIKE type_t.chr80
DEFINE l_xrca005       LIKE xrca_t.xrca005


   LET r_success = TRUE
   
   LET g_sql = " SELECT nmcq100,xrca004,xrca005,SUM(nmcr103) ",
               "   FROM anmt520_01_tmp ",
               "   GROUP BY nmcq100,xrca004,xrca005 "
   PREPARE anmt520_01_sel_prep4 FROM g_sql
   DECLARE anmt520_01_sel_curs4 CURSOR FOR anmt520_01_sel_prep4
   
   LET g_sql = " SELECT nmcr103,nmcrseq ",
               "   FROM anmt520_01_tmp ",
               "  WHERE xrca004 = ? AND xrca005 = ? "
   PREPARE anmt520_01_sel_prep5 FROM g_sql
   DECLARE anmt520_01_sel_curs5 CURSOR FOR anmt520_01_sel_prep5   

 
   INITIALIZE g_xrca TO NULL
   INITIALIZE g_xrcb TO NULL
   INITIALIZE g_xrcc TO NULL
   FOREACH anmt520_01_sel_curs4 INTO g_xrca.xrca100,g_xrca.xrca004,g_xrca.xrca005,g_xrca.xrca108
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
       
 
      LET g_xrca.xrcaownid = g_user
      LET g_xrca.xrcaowndp = g_dept
      LET g_xrca.xrcacrtid = g_user
      LET g_xrca.xrcacrtdp = g_dept
      LET g_xrca.xrcacrtdt = g_today      
      LET g_xrca.xrcaent = g_enterprise
      LET g_xrca.xrcald = g_glaald
      LET g_xrca.xrca009 = g_xrca_m.xrca009  #付款日期
      LET g_xrca.xrca010 = g_xrca_m.xrca009  #票据到期日 
      LET g_xrca.xrcadocdt = g_today
      LET g_xrca.xrcacomp = g_nmcqcomp
      LET g_xrca.xrcasite = g_nmcqsite
      LET g_xrca.xrca003 = g_user
      LET g_xrca.xrca001 = '19'
      LET g_xrca.xrcastus = 'Y' 
      LET g_xrca.xrcadocno = g_xrca_m.xrcadocno
      LET g_xrca.xrca106 = 0
      LET g_xrca.xrca116 = 0
      LET g_xrca.xrca107 = 0
      LET g_xrca.xrca117 = 0
      LET g_xrca.xrca126 = 0
      LET g_xrca.xrca127 = 0
      LET g_xrca.xrca136 = 0
      LET g_xrca.xrca137 = 0
      LET g_xrca.xrca017 = '1'
      CALL s_aooi200_fin_gen_docno(g_xrca.xrcald,'','',g_xrca.xrcadocno,g_xrca.xrcadocdt,'axrt330')
           RETURNING r_success,g_xrca.xrcadocno
      
             

      CALL s_axrt300_xrca004_ref(g_xrca.xrcasite,g_xrca.xrca003,g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,g_xrca.xrca004,g_xrca.xrcacomp)
         RETURNING r_success,l_xrca004_desc,g_xrca.xrca008,l_xrca008_desc,g_xrca.xrca009,g_xrca.xrca010,
                   g_xrca.xrca007,l_xrca007_desc,g_xrca.xrca014,l_xrca014_desc,g_xrca.xrca015,
                   l_xrca015_desc,g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013,l_xrca100,
                   l_xrca100_2,g_xrca.xrca101,g_xrca.xrca121,g_xrca.xrca131,g_xrca.xrca061,g_xrca.xrca028,  
                   l_xrca005,l_xrca005_desc,g_xrca.xrca046,g_xrca.xrca058,l_xrca058_desc,
                   g_xrca.xrca006,g_xrca.xrca034,l_xrca034_desc,g_xrca.xrca035,l_xrca035_desc,
                   g_xrca.xrca036,l_xrca036_desc
      IF NOT cl_null(g_xrca_m.xrca007) THEN
         LET g_xrca.xrca007 = g_xrca_m.xrca007 
      END IF   
     SELECT glab005 INTO g_xrca.xrca035 FROM glab_t 
      WHERE glabld  = g_xrca.xrcald
        AND glabent = g_enterprise
        AND glab002 = g_xrca.xrca007        # 帳款類別
        AND glab001 = '13'             # 應收帳務類型科目設定
 　     AND glab003 = '8304_01'

     SELECT glab005 INTO g_xrca.xrca036 FROM glab_t 
      WHERE glabld  = g_xrca.xrcald
        AND glabent = g_enterprise
        AND glab002 = g_xrca.xrca007       # 帳款類別
        AND glab001 = '13'             # 應收帳務類型科目設定
 　     AND glab003 = '8304_21'

      #取得該法人的稅區
      CALL s_tax_get_ooef019(g_nmcqcomp) RETURNING r_success,g_ooef019
    
      SELECT oodb002,oodb006,oodb005 
        INTO g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013
        FROM oodb_t 
       WHERE oodb001 = g_ooef019 AND oodbent = g_enterprise AND oodb008 = '2'
       
             
      #汇率
      IF NOT cl_null(g_xrca.xrca100) AND NOT cl_null(g_xrca.xrcadocdt) AND NOT cl_null(g_xrca.xrca004) THEN
         LET lc_param.xrca004 = g_xrca.xrca004
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_fin_get_curr_rate(g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocdt,g_xrca.xrca100,ls_js)
              RETURNING g_xrca.xrca101,g_xrca.xrca121,g_xrca.xrca131  
      END IF  
      
      LET g_xrca.xrca054 = ''
      LET g_xrca.xrca055 = ''

      
      #稅別
      LET g_xrca.xrca060 = '2'
      LET g_xrca.xrca014 = g_user
      LET g_xrca.xrca015 = g_dept 
      
      #161128-00061#2---modify----begin----------
      #INSERT INTO xrca_t VALUES(g_xrca.*)
      INSERT INTO xrca_t (xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
                          xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,
                          xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,
                          xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,
                          xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,
                          xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,
                          xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,
                          xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,
                          xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,
                          xrca133,xrca134,xrca136,xrca137,xrca138)
       VALUES(g_xrca.xrcaent,g_xrca.xrcaownid,g_xrca.xrcaowndp,g_xrca.xrcacrtid,g_xrca.xrcacrtdp,g_xrca.xrcacrtdt,g_xrca.xrcamodid,g_xrca.xrcamoddt,g_xrca.xrcacnfid,
              g_xrca.xrcacnfdt,g_xrca.xrcapstid,g_xrca.xrcapstdt,g_xrca.xrcastus,g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,g_xrca.xrca001,g_xrca.xrcasite,
              g_xrca.xrca003,g_xrca.xrca004,g_xrca.xrca005,g_xrca.xrca006,g_xrca.xrca007,g_xrca.xrca008,g_xrca.xrca009,g_xrca.xrca010,g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013,g_xrca.xrca014,
              g_xrca.xrca015,g_xrca.xrca016,g_xrca.xrca017,g_xrca.xrca018,g_xrca.xrca019,g_xrca.xrca020,g_xrca.xrca021,g_xrca.xrca022,g_xrca.xrca023,g_xrca.xrca024,g_xrca.xrca025,g_xrca.xrca026,
              g_xrca.xrca028,g_xrca.xrca029,g_xrca.xrca030,g_xrca.xrca031,g_xrca.xrca032,g_xrca.xrca033,g_xrca.xrca034,g_xrca.xrca035,g_xrca.xrca036,g_xrca.xrca037,g_xrca.xrca038,g_xrca.xrca039,
              g_xrca.xrca040,g_xrca.xrca041,g_xrca.xrca042,g_xrca.xrca043,g_xrca.xrca044,g_xrca.xrca045,g_xrca.xrca046,g_xrca.xrca047,g_xrca.xrca048,g_xrca.xrca049,g_xrca.xrca050,g_xrca.xrca051,
              g_xrca.xrca052,g_xrca.xrca053,g_xrca.xrca054,g_xrca.xrca055,g_xrca.xrca056,g_xrca.xrca057,g_xrca.xrca058,g_xrca.xrca059,g_xrca.xrca060,g_xrca.xrca061,g_xrca.xrca062,g_xrca.xrca063,
              g_xrca.xrca064,g_xrca.xrca065,g_xrca.xrca066,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca106,g_xrca.xrca107,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,
              g_xrca.xrca116,g_xrca.xrca117,g_xrca.xrca118,g_xrca.xrca120,g_xrca.xrca121,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca126,g_xrca.xrca127,g_xrca.xrca128,g_xrca.xrca130,g_xrca.xrca131,
              g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca136,g_xrca.xrca137,g_xrca.xrca138)
      #161128-00061#2---modify----begin----------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_xrca",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF  

      FOREACH anmt520_01_sel_curs5 USING g_xrca.xrca004,g_xrca.xrca005 INTO l_nmcr103,l_nmcrseq 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF 
         LET g_xrcb.xrcbent = g_enterprise
         LET g_xrcb.xrcbld = g_xrca.xrcald
         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbsite = g_xrca.xrcasite
         LET g_xrcb.xrcb101 = l_nmcr103
         LET g_xrcb.xrcb031 = g_xrca.xrca008 #收款条件
         
         SELECT MAX(xrcbseq) INTO l_n FROM xrcb_t
          WHERE xrcbent = g_enterprise AND xrcbld = g_xrcb.xrcbld AND xrcbdocno = g_xrcb.xrcbdocno 
         IF cl_null(l_n) THEN LET l_n = 1 ELSE LET l_n = l_n + 1 END IF 
         LET g_xrcb.xrcbseq = l_n
         LET g_xrcb.xrcb001 = '19' 
         
         
         LET g_xrcb.xrcb007 = 1
         LET g_xrcb.xrcb020 = g_xrca.xrca011
         LET g_xrcb.xrcb100 = g_xrca.xrca100
        
         CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,g_nmcqcomp,
                        g_xrcb.xrcb101 * g_xrcb.xrcb007,g_xrcb.xrcb020,
                        g_xrcb.xrcb007,g_xrcb.xrcb100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
            RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                      g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                      g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                      g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
                      
         IF g_xrca.xrca013 = 'Y' THEN
            LET g_xrcb.xrcb113 = g_xrcb.xrcb115 - g_xrcb.xrcb114
            LET g_xrcb.xrcb123 = g_xrcb.xrcb125 - g_xrcb.xrcb124
            LET g_xrcb.xrcb133 = g_xrcb.xrcb135 - g_xrcb.xrcb134
         ELSE
            LET g_xrcb.xrcb115 = g_xrcb.xrcb113 + g_xrcb.xrcb114
            LET g_xrcb.xrcb125 = g_xrcb.xrcb123 + g_xrcb.xrcb124
            LET g_xrcb.xrcb135 = g_xrcb.xrcb133 + g_xrcb.xrcb134
         END IF                      
         LET g_xrcb.xrcb106 = 0
         LET g_xrcb.xrcb116 = 0
         LET g_xrcb.xrcb117 = 0
         LET g_xrcb.xrcb118 = g_xrcb.xrcb113
         LET g_xrcb.xrcb119 = g_xrcb.xrcb115
         LET g_xrcb.xrcb126 = 0
         LET g_xrcb.xrcb136 = 0
         LET g_xrcb.xrcb023 = 'N'
         LET g_xrcb.xrcb022 = 1 
         LET g_xrcb.xrcb003 = ''
         
         LET g_xrcb.xrcb111 = g_xrcb.xrcb113
         LET g_xrcb.xrcb021 = g_xrca.xrca036
         LET g_xrcb.xrcb029 = g_xrca.xrca035         
         
         #161128-00061#2---modify----begin----------
         #INSERT INTO xrcb_t VALUES(g_xrcb.*)
          INSERT INTO xrcb_t (xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
                              xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
                              xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
                              xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
                              xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
                              xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
                              xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
                              xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
                              xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,
                              xrcb059,xrcb060,xrcb107)
           VALUES(g_xrcb.xrcbent,g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrcb.xrcbsite,g_xrcb.xrcborga,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003,g_xrcb.xrcb004,
                  g_xrcb.xrcb005,g_xrcb.xrcb006,g_xrcb.xrcb007,g_xrcb.xrcb008,g_xrcb.xrcb009,g_xrcb.xrcblegl,g_xrcb.xrcb010,g_xrcb.xrcb011,g_xrcb.xrcb012,g_xrcb.xrcb013,
                  g_xrcb.xrcb014,g_xrcb.xrcb015,g_xrcb.xrcb016,g_xrcb.xrcb017,g_xrcb.xrcb018,g_xrcb.xrcb019,g_xrcb.xrcb020,g_xrcb.xrcb021,g_xrcb.xrcb022,g_xrcb.xrcb023,
                  g_xrcb.xrcb024,g_xrcb.xrcb025,g_xrcb.xrcb026,g_xrcb.xrcb027,g_xrcb.xrcb028,g_xrcb.xrcb029,g_xrcb.xrcb030,g_xrcb.xrcb031,g_xrcb.xrcb032,g_xrcb.xrcb033,
                  g_xrcb.xrcb034,g_xrcb.xrcb035,g_xrcb.xrcb036,g_xrcb.xrcb037,g_xrcb.xrcb038,g_xrcb.xrcb039,g_xrcb.xrcb040,g_xrcb.xrcb041,g_xrcb.xrcb042,g_xrcb.xrcb043,
                  g_xrcb.xrcb044,g_xrcb.xrcb045,g_xrcb.xrcb046,g_xrcb.xrcb047,g_xrcb.xrcb048,g_xrcb.xrcb049,g_xrcb.xrcb050,g_xrcb.xrcb051,g_xrcb.xrcb100,g_xrcb.xrcb101,
                  g_xrcb.xrcb102,g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,g_xrcb.xrcb106,g_xrcb.xrcb111,g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,g_xrcb.xrcb116,
                  g_xrcb.xrcb117,g_xrcb.xrcb118,g_xrcb.xrcb119,g_xrcb.xrcb121,g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,g_xrcb.xrcb126,g_xrcb.xrcb131,g_xrcb.xrcb133,
                  g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136,g_xrcb.xrcb052,g_xrcb.xrcb053,g_xrcb.xrcb054,g_xrcb.xrcb055,g_xrcb.xrcb056,g_xrcb.xrcb057,g_xrcb.xrcb058,
                  g_xrcb.xrcb059,g_xrcb.xrcb060,g_xrcb.xrcb107)
         #161128-00061#2---modify----end----------
                    
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins_xrcb",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF 
            
         UPDATE nmcr_t SET nmcr008 = g_xrca.xrcadocno
                 WHERE nmcrent = g_enterprise
                   AND nmcrcomp = g_nmcqcomp
                   AND nmcrdocno = g_nmcqdocno
                   AND nmcrseq = l_nmcrseq
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmcr_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmcr_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE               
         END CASE 



      END FOREACH   
      
      #计算单头金额
      SELECT SUM(xrcb103*xrcb022),SUM(xrcb104*xrcb022),SUM(xrcb105*xrcb022),
             SUM(xrcb113*xrcb022),SUM(xrcb114*xrcb022),SUM(xrcb115*xrcb022),
             SUM(xrcb123*xrcb022),SUM(xrcb124*xrcb022),SUM(xrcb125*xrcb022),
             SUM(xrcb133*xrcb022),SUM(xrcb134*xrcb022),SUM(xrcb135*xrcb022)
        INTO g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca108,
             g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca118,
             g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca128,
             g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca138
        FROM xrcb_t
       WHERE xrcbent  = g_enterprise AND xrcbld = g_glaald
         AND xrcbdocno = g_xrca.xrcadocno
         
      IF cl_null(g_xrca.xrca103) THEN LET g_xrca.xrca103 = 0 END IF
      IF cl_null(g_xrca.xrca104) THEN LET g_xrca.xrca104 = 0 END IF
      IF cl_null(g_xrca.xrca108) THEN LET g_xrca.xrca108 = 0 END IF
      IF cl_null(g_xrca.xrca113) THEN LET g_xrca.xrca113 = 0 END IF
      IF cl_null(g_xrca.xrca114) THEN LET g_xrca.xrca114 = 0 END IF
      IF cl_null(g_xrca.xrca118) THEN LET g_xrca.xrca118 = 0 END IF 
      IF cl_null(g_xrca.xrca123) THEN LET g_xrca.xrca123 = 0 END IF
      IF cl_null(g_xrca.xrca124) THEN LET g_xrca.xrca124 = 0 END IF
      IF cl_null(g_xrca.xrca128) THEN LET g_xrca.xrca128 = 0 END IF 
      IF cl_null(g_xrca.xrca133) THEN LET g_xrca.xrca133 = 0 END IF
      IF cl_null(g_xrca.xrca134) THEN LET g_xrca.xrca134 = 0 END IF
      IF cl_null(g_xrca.xrca138) THEN LET g_xrca.xrca138 = 0 END IF       
      
      UPDATE xrca_t SET (xrca103,xrca104,xrca108,
                         xrca113,xrca114,xrca118,
                         xrca123,xrca124,xrca128,
                         xrca133,xrca134,xrca138
                         ) =
                        (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca108,
                         g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca118,
                         g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca128,
                         g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca138)
        WHERE xrcaent = g_enterprise AND xrcald = g_glaald
          AND xrcadocno = g_xrca.xrcadocno
       
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "upd xrca_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF         
      
      CALL s_axrt300_create_tmp()   
      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING r_success

                
   END FOREACH
   RETURN r_success
END FUNCTION

 
{</section>}
 
