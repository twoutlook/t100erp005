#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt450_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-06-22 15:31:18), PR版次:0002(2016-11-30 14:27:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: anmt450_02
#+ Description: 票據重新立帳
#+ Creator....: 01531(2016-06-22 15:21:31)
#+ Modifier...: 01531 -SD/PR- 02481
 
{</section>}
 
{<section id="anmt450_02.global" >}
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
PRIVATE type type_g_apca_m        RECORD
       apcadocno LIKE apca_t.apcadocno, 
   apcald LIKE apca_t.apcald, 
   apcald_desc LIKE type_t.chr80, 
   apca007 LIKE apca_t.apca007, 
   apca007_desc LIKE type_t.chr80, 
   apca009 LIKE apca_t.apca009
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaa024       LIKE glaa_t.glaa024
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_sql           STRING 
DEFINE g_nmchcomp      LIKE nmch_t.nmchcomp
DEFINE g_nmchdocno     LIKE nmch_t.nmchdocno   
DEFINE g_nmchsite      LIKE nmch_t.nmchsite 
DEFINE g_ooef019       LIKE ooef_t.ooef019
#end add-point
 
DEFINE g_apca_m        type_g_apca_m
 
   DEFINE g_apcadocno_t LIKE apca_t.apcadocno
DEFINE g_apcald_t LIKE apca_t.apcald
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="anmt450_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt450_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_nmchcomp,p_nmchdocno,p_nmchsite
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
   DEFINE p_nmchcomp      LIKE nmch_t.nmchcomp
   DEFINE p_nmchdocno     LIKE nmch_t.nmchdocno   
   DEFINE p_nmchsite      LIKE nmch_t.nmchsite
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_success1     LIKE type_t.num5
      
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt450_02 WITH FORM cl_ap_formpath("anm","anmt450_02")
 
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
    WHERE glaaent = g_enterprise AND glaacomp = p_nmchcomp AND glaa014 = 'Y'
   LET g_apca_m.apcald = g_glaald  
   CALL cl_set_comp_visible("apcald",FALSE)
   LET g_apca_m.apca009 = g_today
   LET g_nmchcomp = p_nmchcomp
   LET g_nmchdocno = p_nmchdocno
   LET g_nmchsite = p_nmchsite
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apca_m.apcadocno,g_apca_m.apcald,g_apca_m.apca007,g_apca_m.apca009 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="input.b.apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="input.a.apcadocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_apca_m.apcald) AND NOT cl_null(g_apca_m.apcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apca_m.apcald != g_apcald_t  OR g_apca_m.apcadocno != g_apcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apca_t WHERE "||"apcaent = '" ||g_enterprise|| "' AND "||"apcald = '"||g_apca_m.apcald ||"' AND "|| "apcadocno = '"||g_apca_m.apcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocno
            #add-point:ON CHANGE apcadocno name="input.g.apcadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcald
            
            #add-point:AFTER FIELD apcald name="input.a.apcald"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apcald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apcald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apcald_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_apca_m.apcald) AND NOT cl_null(g_apca_m.apcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apca_m.apcald != g_apcald_t  OR g_apca_m.apcadocno != g_apcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apca_t WHERE "||"apcaent = '" ||g_enterprise|| "' AND "||"apcald = '"||g_apca_m.apcald ||"' AND "|| "apcadocno = '"||g_apca_m.apcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="input.b.apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcald
            #add-point:ON CHANGE apcald name="input.g.apcald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="input.a.apca007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3211' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca007
            #add-point:BEFORE FIELD apca007 name="input.b.apca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca007
            #add-point:ON CHANGE apca007 name="input.g.apca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca009
            #add-point:BEFORE FIELD apca009 name="input.b.apca009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca009
            
            #add-point:AFTER FIELD apca009 name="input.a.apca009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca009
            #add-point:ON CHANGE apca009 name="input.g.apca009"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="input.c.apcadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_apca_m.apcadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024 #s
            LET g_qryparam.arg2 = "aapt301" #s
            LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                    "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                    "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "  #只能選不產生分录的單別            
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_apca_m.apcadocno = g_qryparam.return1              

            DISPLAY g_apca_m.apcadocno TO apcadocno              #

            NEXT FIELD apcadocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_apca_m.apcald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
 
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_apca_m.apcald = g_qryparam.return1              

            DISPLAY g_apca_m.apcald TO apcald              #

            NEXT FIELD apcald                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="input.c.apca007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_apca_m.apca007             #給予default值
            LET g_qryparam.default2 = "" #g_apca_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3211" #s 3111

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_apca_m.apca007 = g_qryparam.return1              
            #LET g_apca_m.oocq002 = g_qryparam.return2 
            DISPLAY g_apca_m.apca007 TO apca007              #
            #DISPLAY g_apca_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD apca007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.apca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca009
            #add-point:ON ACTION controlp INFIELD apca009 name="input.c.apca009"
            
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
   CLOSE WINDOW w_anmt450_02 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL anmt450_02_get_data()
      CALL anmt450_02_ins_apca() RETURNING r_success 
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
 
{<section id="anmt450_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt450_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 临时表
# Memo...........:
# Usage..........: CALL anmt450_02_create_tmp()
# Input parameter:  
# Date & Author..: 2016/06/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt450_02_create_tmp()
DROP TABLE anmt450_02_tmp;
 CREATE TEMP TABLE anmt450_02_tmp(
     nmch100  LIKE nmch_t.nmch100,   #票据币别 
     nmci001  LIKE nmci_t.nmci001,   #票据号码 
     nmci003  LIKE nmci_t.nmci003,   #开票单号 
     apca004  LIKE apca_t.apca004,   #交易对象 
     apca005  LIKE apca_t.apca005,   #付款对象 
     nmci103  LIKE nmci_t.nmci103,   #原币金额
     nmciseq  LIKE nmci_t.nmciseq    #单身项次     
 );
END FUNCTION

################################################################################
# Descriptions...: 获取资料
# Memo...........:
# Usage..........: CALL anmt450_02_get_data()
# Input parameter:  
# Date & Author..: 2016/06/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt450_02_get_data()
DEFINE l_tmp   RECORD
     nmch100  LIKE nmch_t.nmch100,   #票据币别 
     nmci001  LIKE nmci_t.nmci001,   #票据号码 
     nmci003  LIKE nmci_t.nmci003,   #开票单号 
     apca004  LIKE apca_t.apca004,   #交易对象 
     apca005  LIKE apca_t.apca005,   #付款对象 
     nmci103  LIKE nmci_t.nmci103,   #原币金额
     nmciseq  LIKE nmci_t.nmciseq    #单身项次         
               END  RECORD
DEFINE l_cnt   LIKE type_t.num5               

   CALL anmt450_02_create_tmp()
   DELETE FROM anmt450_02_tmp
   
               #票据币别，票据号码，开票单号，交易对象，付款对象，原币金额， 
   LET g_sql = " SELECT nmch100,nmci001,nmci003,'','',nmci103,nmciseq ",
               "   FROM nmch_t,nmci_t ",
               "  WHERE nmchent = nmcient AND nmchcomp = nmcicomp AND nmcidocno = nmchdocno ",
               "    AND nmchent = '",g_enterprise,"' AND nmchcomp = '",g_nmchcomp,"'",
               "    AND nmchdocno = '",g_nmchdocno,"'"  

   PREPARE anmt420_02_sel_prep FROM g_sql
   DECLARE anmt420_02_sel_curs CURSOR FOR anmt420_02_sel_prep   
   
   #取交易對象及收款對象
   LET g_sql = " SELECT apca004,apca005 FROM apca_t,apde_t ",
               "  WHERE apdeent = '",g_enterprise,"'",
               "    AND apdeld = '",g_glaald,"'",
               "    AND apdedocno = apcadocno ", 
               "    AND apde024 = ? ", #票据號碼 nmck025/nmci001
               "    AND apcastus ='Y' ",
               " UNION ",
               " SELECT apda004,apda005 FROM apda_t,apde_t",
               "  WHERE apdadocno = apdedocno ", 
               "    AND apde003 = ? ",#开票单号 nmckdocno/nmci003 
               "    AND apdastus = 'Y' "
   PREPARE anmt420_02_sel_prep2 FROM g_sql
   DECLARE anmt420_02_sel_curs2 CURSOR FOR anmt420_02_sel_prep2 

   LET g_sql = " SELECT nmck005 FROM nmck_t ",
               "  WHERE nmckent = '",g_enterprise,"' AND nmckdocno = ? ",
               "    AND nmck025 = ? ",
               "    AND nmckcomp = '",g_nmchcomp,"'"
   PREPARE anmt420_02_sel_prep3 FROM g_sql
   DECLARE anmt420_02_sel_curs3 CURSOR FOR anmt420_02_sel_prep3                
   
   FOREACH anmt420_02_sel_curs INTO l_tmp.nmch100,l_tmp.nmci001,l_tmp.nmci003,l_tmp.apca004,l_tmp.apca005,l_tmp.nmci103,l_tmp.nmciseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      
      EXECUTE anmt420_02_sel_curs2 USING l_tmp.nmci001,l_tmp.nmci003
           INTO l_tmp.apca004,l_tmp.apca005
           
      IF cl_null(l_tmp.apca004) THEN
         EXECUTE anmt420_02_sel_curs3 USING l_tmp.nmci003,l_tmp.nmci001
            INTO l_tmp.apca004       
      END IF 
      IF cl_null(l_tmp.apca005) THEN
         EXECUTE anmt420_02_sel_curs3 USING l_tmp.nmci003,l_tmp.nmci001
            INTO l_tmp.apca005       
      END IF       
      
      INSERT INTO anmt450_02_tmp VALUES (l_tmp.*)
       
   END FOREACH
   #备注
   SELECT COUNT(*) INTO l_cnt FROM anmt450_02_tmp;
END FUNCTION

################################################################################
# Descriptions...: anmt450_02_ins_apca()
# Memo...........:
# Usage..........: CALL anmt450_02_ins_apca()
# Input parameter: 
# Date & Author..: 2016/06/28 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt450_02_ins_apca()
#161128-00061#2---modify----begin----------
#DEFINE g_apca  RECORD LIKE apca_t.*
#DEFINE g_apcb  RECORD LIKE apcb_t.*
#DEFINE g_apcc  RECORD LIKE apcc_t.*
DEFINE g_apca RECORD  #應付憑單單頭
       apcaent LIKE apca_t.apcaent, #企業編號
       apcaownid LIKE apca_t.apcaownid, #資料所有者
       apcaowndp LIKE apca_t.apcaowndp, #資料所有部門
       apcacrtid LIKE apca_t.apcacrtid, #資料建立者
       apcacrtdp LIKE apca_t.apcacrtdp, #資料建立部門
       apcacrtdt LIKE apca_t.apcacrtdt, #資料創建日
       apcamodid LIKE apca_t.apcamodid, #資料修改者
       apcamoddt LIKE apca_t.apcamoddt, #最近修改日
       apcacnfid LIKE apca_t.apcacnfid, #資料確認者
       apcacnfdt LIKE apca_t.apcacnfdt, #資料確認日
       apcapstid LIKE apca_t.apcapstid, #資料過帳者
       apcapstdt LIKE apca_t.apcapstdt, #資料過帳日
       apcastus LIKE apca_t.apcastus, #狀態碼
       apcald LIKE apca_t.apcald, #帳套
       apcacomp LIKE apca_t.apcacomp, #法人
       apcadocno LIKE apca_t.apcadocno, #應付帳款單號碼
       apcadocdt LIKE apca_t.apcadocdt, #帳款日期
       apcasite LIKE apca_t.apcasite, #帳務中心
       apca001 LIKE apca_t.apca001, #帳款單性質
       apca003 LIKE apca_t.apca003, #帳務人員
       apca004 LIKE apca_t.apca004, #帳款對象編號
       apca005 LIKE apca_t.apca005, #付款對象
       apca006 LIKE apca_t.apca006, #供應商分類
       apca007 LIKE apca_t.apca007, #帳款類別
       apca008 LIKE apca_t.apca008, #付款條件編號
       apca009 LIKE apca_t.apca009, #應付款日/應扣抵日
       apca010 LIKE apca_t.apca010, #容許票據到期日
       apca011 LIKE apca_t.apca011, #稅別
       apca012 LIKE apca_t.apca012, #稅率
       apca013 LIKE apca_t.apca013, #含稅否
       apca014 LIKE apca_t.apca014, #人員編號
       apca015 LIKE apca_t.apca015, #部門編號
       apca016 LIKE apca_t.apca016, #來源作業類型
       apca017 LIKE apca_t.apca017, #產生方式
       apca018 LIKE apca_t.apca018, #來源參考單號
       apca019 LIKE apca_t.apca019, #系統產生對應單號(待抵帳款-預付)
       apca020 LIKE apca_t.apca020, #信用狀付款否
       apca021 LIKE apca_t.apca021, #商業發票號碼(IV no.)
       apca022 LIKE apca_t.apca022, #進口報單號碼
       apca025 LIKE apca_t.apca025, #差異處理(發票與帳款差異)
       apca026 LIKE apca_t.apca026, #原幣未稅差異
       apca027 LIKE apca_t.apca027, #原幣稅額差異
       apca028 LIKE apca_t.apca028, #本幣未稅差異
       apca029 LIKE apca_t.apca029, #本幣幣稅額差異
       apca030 LIKE apca_t.apca030, #差異科目
       apca031 LIKE apca_t.apca031, #產生之差異折讓單號
       apca032 LIKE apca_t.apca032, #發票類型
       apca033 LIKE apca_t.apca033, #專案編號
       apca034 LIKE apca_t.apca034, #責任中心
       apca035 LIKE apca_t.apca035, #應付(貸方)科目編號
       apca036 LIKE apca_t.apca036, #費用(借方)科目編號
       apca037 LIKE apca_t.apca037, #產生傳票否
       apca038 LIKE apca_t.apca038, #拋轉傳票號碼
       apca039 LIKE apca_t.apca039, #會計檢核附件份數
       apca040 LIKE apca_t.apca040, #留置否
       apca041 LIKE apca_t.apca041, #留置理由碼
       apca042 LIKE apca_t.apca042, #留置設定日期
       apca043 LIKE apca_t.apca043, #留置解除日期
       apca044 LIKE apca_t.apca044, #留置原幣金額
       apca045 LIKE apca_t.apca045, #留置說明
       apca046 LIKE apca_t.apca046, #關係人否
       apca047 LIKE apca_t.apca047, #多角序號
       apca048 LIKE apca_t.apca048, #集團代付/代付單號
       apca049 LIKE apca_t.apca049, #來源營運中心編號
       apca050 LIKE apca_t.apca050, #交易原始單據份數
       apca051 LIKE apca_t.apca051, #作廢理由碼
       apca052 LIKE apca_t.apca052, #列印次數
       apca053 LIKE apca_t.apca053, #備註
       apca054 LIKE apca_t.apca054, #多帳期設定
       apca055 LIKE apca_t.apca055, #繳款優惠條件
       apca056 LIKE apca_t.apca056, #會計檢核附件狀態
       apca057 LIKE apca_t.apca057, #交易對象識別碼
       apca058 LIKE apca_t.apca058, #稅別交易類型
       apca059 LIKE apca_t.apca059, #預算編號
       apca060 LIKE apca_t.apca060, #發票開立方式
       apca061 LIKE apca_t.apca061, #預開發票基準日
       apca062 LIKE apca_t.apca062, #多角性質
       apca063 LIKE apca_t.apca063, #整帳批序號
       apca064 LIKE apca_t.apca064, #訂金序次
       apca065 LIKE apca_t.apca065, #發票編號
       apca066 LIKE apca_t.apca066, #發票號碼
       apca100 LIKE apca_t.apca100, #交易原幣別
       apca101 LIKE apca_t.apca101, #原幣匯率
       apca103 LIKE apca_t.apca103, #原幣未稅金額
       apca104 LIKE apca_t.apca104, #原幣稅額
       apca106 LIKE apca_t.apca106, #原幣應稅折抵合計金額
       apca107 LIKE apca_t.apca107, #NO USE
       apca108 LIKE apca_t.apca108, #原幣應付金額
       apca113 LIKE apca_t.apca113, #本幣未稅金額
       apca114 LIKE apca_t.apca114, #本幣稅額
       apca116 LIKE apca_t.apca116, #本幣應稅折抵合計金額
       apca117 LIKE apca_t.apca117, #NO USE
       apca118 LIKE apca_t.apca118, #本幣應付金額
       apca120 LIKE apca_t.apca120, #本位幣二幣別
       apca121 LIKE apca_t.apca121, #本位幣二匯率
       apca123 LIKE apca_t.apca123, #本位幣二未稅金額
       apca124 LIKE apca_t.apca124, #本位幣二稅額
       apca126 LIKE apca_t.apca126, #本位幣二應稅折抵合計金額
       apca127 LIKE apca_t.apca127, #NO USE
       apca128 LIKE apca_t.apca128, #本位幣二應付金額
       apca130 LIKE apca_t.apca130, #本位幣三幣別
       apca131 LIKE apca_t.apca131, #本位幣三匯率
       apca133 LIKE apca_t.apca133, #本位幣三未稅金額
       apca134 LIKE apca_t.apca134, #本位幣三稅額
       apca136 LIKE apca_t.apca136, #本位幣三應稅折抵合計金額
       apca137 LIKE apca_t.apca137, #NO USE
       apca138 LIKE apca_t.apca138, #本位幣三應付金額
       apca067 LIKE apca_t.apca067, #管理品類
       apca068 LIKE apca_t.apca068, #經營方式
       apca069 LIKE apca_t.apca069, #no use
       apca070 LIKE apca_t.apca070, #no use
       apca071 LIKE apca_t.apca071, #no use
       apca072 LIKE apca_t.apca072, #no use
       apca073 LIKE apca_t.apca073  #信用狀申請單號
       END RECORD
DEFINE g_apcb RECORD  #應付憑單單身
       apcbent LIKE apcb_t.apcbent, #企業編號
       apcbld LIKE apcb_t.apcbld, #帳套
       apcblegl LIKE apcb_t.apcblegl, #核算組織
       apcborga LIKE apcb_t.apcborga, #帳務歸屬組織(來源組織)
       apcbsite LIKE apcb_t.apcbsite, #應付帳務組織
       apcbdocno LIKE apcb_t.apcbdocno, #單號
       apcbseq LIKE apcb_t.apcbseq, #項次
       apcb001 LIKE apcb_t.apcb001, #來源類型
       apcb002 LIKE apcb_t.apcb002, #來源業務單據號碼
       apcb003 LIKE apcb_t.apcb003, #來源業務單據項次
       apcb004 LIKE apcb_t.apcb004, #產品編號
       apcb005 LIKE apcb_t.apcb005, #品名規格
       apcb006 LIKE apcb_t.apcb006, #單位
       apcb007 LIKE apcb_t.apcb007, #計價數量
       apcb008 LIKE apcb_t.apcb008, #參考單據號碼
       apcb009 LIKE apcb_t.apcb009, #參考單據項次
       apcb010 LIKE apcb_t.apcb010, #業務部門
       apcb011 LIKE apcb_t.apcb011, #責任中心
       apcb012 LIKE apcb_t.apcb012, #產品類別
       apcb013 LIKE apcb_t.apcb013, #搭贈
       apcb014 LIKE apcb_t.apcb014, #理由碼
       apcb015 LIKE apcb_t.apcb015, #專案編號
       apcb016 LIKE apcb_t.apcb016, #WBS編號
       apcb017 LIKE apcb_t.apcb017, #預算細項
       apcb018 LIKE apcb_t.apcb018, #专柜编号
       apcb019 LIKE apcb_t.apcb019, #開票性質
       apcb020 LIKE apcb_t.apcb020, #稅別
       apcb021 LIKE apcb_t.apcb021, #費用會計科目
       apcb022 LIKE apcb_t.apcb022, #正負值
       apcb023 LIKE apcb_t.apcb023, #沖暫估單否
       apcb024 LIKE apcb_t.apcb024, #區域
       apcb025 LIKE apcb_t.apcb025, #傳票號碼
       apcb026 LIKE apcb_t.apcb026, #傳票項次
       apcb027 LIKE apcb_t.apcb027, #發票代碼
       apcb028 LIKE apcb_t.apcb028, #發票號碼
       apcb029 LIKE apcb_t.apcb029, #應付帳款科目
       apcb030 LIKE apcb_t.apcb030, #付款條件
       apcb032 LIKE apcb_t.apcb032, #訂金序次
       apcb033 LIKE apcb_t.apcb033, #經營方式
       apcb034 LIKE apcb_t.apcb034, #通路
       apcb035 LIKE apcb_t.apcb035, #品牌
       apcb036 LIKE apcb_t.apcb036, #客群
       apcb037 LIKE apcb_t.apcb037, #自由核算項一
       apcb038 LIKE apcb_t.apcb038, #自由核算項二
       apcb039 LIKE apcb_t.apcb039, #自由核算項三
       apcb040 LIKE apcb_t.apcb040, #自由核算項四
       apcb041 LIKE apcb_t.apcb041, #自由核算項五
       apcb042 LIKE apcb_t.apcb042, #自由核算項六
       apcb043 LIKE apcb_t.apcb043, #自由核算項七
       apcb044 LIKE apcb_t.apcb044, #自由核算項八
       apcb045 LIKE apcb_t.apcb045, #自由核算項九
       apcb046 LIKE apcb_t.apcb046, #自由核算項十
       apcb047 LIKE apcb_t.apcb047, #摘要
       apcb048 LIKE apcb_t.apcb048, #來源訂購單號
       apcb049 LIKE apcb_t.apcb049, #開票單號
       apcb050 LIKE apcb_t.apcb050, #開票項次
       apcb051 LIKE apcb_t.apcb051, #業務人員
       apcb100 LIKE apcb_t.apcb100, #交易原幣
       apcb101 LIKE apcb_t.apcb101, #交易原幣單價
       apcb102 LIKE apcb_t.apcb102, #原幣匯率
       apcb103 LIKE apcb_t.apcb103, #交易原幣未稅金額
       apcb104 LIKE apcb_t.apcb104, #交易原幣稅額
       apcb105 LIKE apcb_t.apcb105, #交易原幣含稅金額
       apcb106 LIKE apcb_t.apcb106, #交易幣標準成本金額
       apcb107 LIKE apcb_t.apcb107, #NO USE
       apcb108 LIKE apcb_t.apcb108, #交易原幣成本認列金額
       apcb111 LIKE apcb_t.apcb111, #本幣單價
       apcb113 LIKE apcb_t.apcb113, #本幣未稅金額
       apcb114 LIKE apcb_t.apcb114, #本幣稅額
       apcb115 LIKE apcb_t.apcb115, #本幣含稅金額
       apcb116 LIKE apcb_t.apcb116, #本幣標準成本金額
       apcb117 LIKE apcb_t.apcb117, #NO USE
       apcb118 LIKE apcb_t.apcb118, #本幣成本認列金額
       apcb119 LIKE apcb_t.apcb119, #應開發票含稅金額
       apcb121 LIKE apcb_t.apcb121, #本位幣二匯率
       apcb123 LIKE apcb_t.apcb123, #本位幣二未稅金額
       apcb124 LIKE apcb_t.apcb124, #本位幣二稅額
       apcb125 LIKE apcb_t.apcb125, #本位幣二含稅金額
       apcb126 LIKE apcb_t.apcb126, #本幣二標準成本金額
       apcb127 LIKE apcb_t.apcb127, #NO USE
       apcb128 LIKE apcb_t.apcb128, #本位幣二成本認列金額
       apcb131 LIKE apcb_t.apcb131, #本位幣三匯率
       apcb133 LIKE apcb_t.apcb133, #本位幣三未稅金額
       apcb134 LIKE apcb_t.apcb134, #本位幣三稅額
       apcb135 LIKE apcb_t.apcb135, #本位幣三含稅金額
       apcb136 LIKE apcb_t.apcb136, #本幣三標準成本金額
       apcb137 LIKE apcb_t.apcb137, #NO USE
       apcb138 LIKE apcb_t.apcb138, #本位幣三成本認列金額
       apcb052 LIKE apcb_t.apcb052, #稅額
       apcb053 LIKE apcb_t.apcb053, #含稅金額
       apcb054 LIKE apcb_t.apcb054, #帳款對象
       apcb055 LIKE apcb_t.apcb055  #付款對象
       END RECORD

DEFINE g_apcc RECORD  #應付多帳期檔
       apccent LIKE apcc_t.apccent, #企業編號
       apccld LIKE apcc_t.apccld, #帳套
       apcccomp LIKE apcc_t.apcccomp, #法人
       apcclegl LIKE apcc_t.apcclegl, #核算組織
       apccsite LIKE apcc_t.apccsite, #帳務中心
       apccdocno LIKE apcc_t.apccdocno, #應付帳款單號碼
       apccseq LIKE apcc_t.apccseq, #項次
       apcc001 LIKE apcc_t.apcc001, #分期帳款序
       apcc002 LIKE apcc_t.apcc002, #應付款別性質
       apcc003 LIKE apcc_t.apcc003, #應付款日
       apcc004 LIKE apcc_t.apcc004, #容許票據到期日
       apcc005 LIKE apcc_t.apcc005, #帳款起算日
       apcc006 LIKE apcc_t.apcc006, #正負值
       apcc007 LIKE apcc_t.apcc007, #原幣已請款金額
       apcc008 LIKE apcc_t.apcc008, #發票代碼
       apcc009 LIKE apcc_t.apcc009, #發票號碼
       apcc010 LIKE apcc_t.apcc010, #發票日期
       apcc011 LIKE apcc_t.apcc011, #交易單據日期
       apcc012 LIKE apcc_t.apcc012, #立帳日期
       apcc013 LIKE apcc_t.apcc013, #交易認定日期
       apcc014 LIKE apcc_t.apcc014, #出入庫扣帳日期
       apcc100 LIKE apcc_t.apcc100, #交易原幣別
       apcc101 LIKE apcc_t.apcc101, #原幣匯率
       apcc102 LIKE apcc_t.apcc102, #原幣重估後匯率
       apcc103 LIKE apcc_t.apcc103, #NO USE
       apcc104 LIKE apcc_t.apcc104, #NO USE
       apcc105 LIKE apcc_t.apcc105, #NO USE
       apcc106 LIKE apcc_t.apcc106, #NO USE
       apcc107 LIKE apcc_t.apcc107, #NO USE
       apcc108 LIKE apcc_t.apcc108, #原幣應付金額
       apcc109 LIKE apcc_t.apcc109, #原幣付款沖帳金額
       apcc113 LIKE apcc_t.apcc113, #重評價調整數
       apcc114 LIKE apcc_t.apcc114, #NO USE
       apcc115 LIKE apcc_t.apcc115, #NO USE
       apcc116 LIKE apcc_t.apcc116, #NO USE
       apcc117 LIKE apcc_t.apcc117, #NO USE
       apcc118 LIKE apcc_t.apcc118, #本幣應付金額
       apcc119 LIKE apcc_t.apcc119, #本幣付款沖帳金額
       apcc120 LIKE apcc_t.apcc120, #本位幣二幣別
       apcc121 LIKE apcc_t.apcc121, #本位幣二匯率
       apcc122 LIKE apcc_t.apcc122, #本位幣二重估後匯率
       apcc123 LIKE apcc_t.apcc123, #重評價調整數
       apcc124 LIKE apcc_t.apcc124, #NO USE
       apcc125 LIKE apcc_t.apcc125, #NO USE
       apcc126 LIKE apcc_t.apcc126, #NO USE
       apcc127 LIKE apcc_t.apcc127, #NO USE
       apcc128 LIKE apcc_t.apcc128, #本位幣二應付金額
       apcc129 LIKE apcc_t.apcc129, #本位幣二付款沖帳金額
       apcc130 LIKE apcc_t.apcc130, #本位幣三幣別
       apcc131 LIKE apcc_t.apcc131, #本位幣三匯率
       apcc132 LIKE apcc_t.apcc132, #本位幣三重估後匯率
       apcc133 LIKE apcc_t.apcc133, #重評價調整數
       apcc134 LIKE apcc_t.apcc134, #NO USE
       apcc135 LIKE apcc_t.apcc135, #NO USE
       apcc136 LIKE apcc_t.apcc136, #NO USE
       apcc137 LIKE apcc_t.apcc137, #NO USE
       apcc138 LIKE apcc_t.apcc138, #本位幣三應付金額
       apcc139 LIKE apcc_t.apcc139, #本位幣三付款沖帳金額
       apcc015 LIKE apcc_t.apcc015, #付款條件
       apcc016 LIKE apcc_t.apcc016, #帳款類型
       apcc017 LIKE apcc_t.apcc017  #採購單號
       END RECORD

#161128-00061#2---modify----end----------
DEFINE ls_js         STRING
DEFINE lc_param      RECORD
         apca004     LIKE apca_t.apca004      
                 END RECORD
DEFINE l_nmci103     LIKE nmci_t.nmci103
DEFINE l_apca100     LIKE apca_t.apca100
DEFINE l_oodb004     LIKE oodb_t.oodb004
DEFINE l_oodb011     LIKE oodb_t.oodb011
DEFINE l_apca034_desc  LIKE type_t.chr80
DEFINE l_xrac007 LIKE xrac_t.xrac007
DEFINE l_xrac008 LIKE xrac_t.xrac008
DEFINE l_n       LIKE type_t.num5
DEFINE r_success LIKE type_t.num5
DEFINE l_nmciseq LIKE nmci_t.nmciseq
DEFINE l_comp    LIKE apca_t.apcacomp


   LET r_success = TRUE
   
   LET g_sql = " SELECT nmch100,apca004,apca005,SUM(nmci103) ",
               "   FROM anmt450_02_tmp ",
               "   GROUP BY nmch100,apca004,apca005 "
   PREPARE anmt420_02_sel_prep4 FROM g_sql
   DECLARE anmt420_02_sel_curs4 CURSOR FOR anmt420_02_sel_prep4
   
   LET g_sql = " SELECT nmci103,nmciseq ",
               "   FROM anmt450_02_tmp ",
               "  WHERE apca004 = ? AND apca005 = ? "
   PREPARE anmt420_02_sel_prep5 FROM g_sql
   DECLARE anmt420_02_sel_curs5 CURSOR FOR anmt420_02_sel_prep5   
 
 
   INITIALIZE g_apca TO NULL
   INITIALIZE g_apcb TO NULL
   INITIALIZE g_apcc TO NULL
   FOREACH anmt420_02_sel_curs4 INTO g_apca.apca100,g_apca.apca004,g_apca.apca005,g_apca.apca108
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
       
 
      LET g_apca.apcaownid = g_user
      LET g_apca.apcaowndp = g_dept
      LET g_apca.apcacrtid = g_user
      LET g_apca.apcacrtdp = g_dept
      LET g_apca.apcacrtdt = g_today      
      LET g_apca.apcaent = g_enterprise
      LET g_apca.apcald = g_glaald
      LET g_apca.apca009 = g_apca_m.apca009  #付款日期
      LET g_apca.apca010 = g_apca_m.apca009  #票据到期日 
      LET g_apca.apcadocdt = g_today
      LET g_apca.apcacomp = g_nmchcomp
      LET g_apca.apcasite = g_nmchsite
      LET g_apca.apca003 = g_user
      LET g_apca.apca001 = '19'
      LET g_apca.apcastus = 'Y' 
      LET g_apca.apcadocno = g_apca_m.apcadocno
      LET g_apca.apca106 = 0
      LET g_apca.apca107 = 0
      LET g_apca.apca117 = 0
      LET g_apca.apca127 = 0
      LET g_apca.apca137 = 0      
      LET g_apca.apca116 = 0
      LET g_apca.apca126 = 0
      LET g_apca.apca136 = 0
      LET g_apca.apca017 = '1'
      CALL s_aooi200_fin_gen_docno(g_apca.apcald,'','',g_apca.apcadocno,g_apca.apcadocdt,'aapt301')
           RETURNING r_success,g_apca.apcadocno
      
      #汇率
      IF NOT cl_null(g_apca.apca100) AND NOT cl_null(g_apca.apcadocdt) AND NOT cl_null(g_apca.apca004) THEN
         LET lc_param.apca004 = g_apca.apca004
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_fin_get_curr_rate(g_apca.apcacomp,g_apca.apcald,g_apca.apcadocdt,g_apca.apca100,ls_js)
              RETURNING g_apca.apca101,g_apca.apca121,g_apca.apca131  
      END IF              

      #帳款資訊
      CALL s_aap_get_payment_term(g_apca.apcald,g_apca.apcacomp,g_apca.apca004,g_apca.apca001)
           RETURNING g_sub_success,g_apca.apca015,g_apca.apca007,g_apca.apca008,g_apca.apca035,
                     g_apca.apca036,g_apca.apca058,l_apca100,g_apca.apca011,g_apca.apca014
      IF NOT cl_null(g_apca_m.apca007) THEN 
         LET g_apca.apca007 = g_apca_m.apca007  
      END IF
      CALL s_aap_get_apca007_default_acct(g_apca.apcald,g_apca.apca007,g_apca.apca001) RETURNING g_apca.apca036,g_apca.apca035
      
      IF cl_null(g_apca.apca008) THEN
         LET l_n = 0
         LET l_comp = g_nmchcomp 
         SELECT COUNT(*) INTO l_n FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_nmchcomp AND pmab001 = g_apca.apca004
         IF l_n = 0 THEN LET l_comp = "ALL" END IF    
         SELECT pmab037 INTO g_apca.apca008 FROM pmab_t
          WHERE pmabent = g_enterprise AND pmabsite = l_comp AND pmab001 = g_apca.apca004         
      END IF
      
      LET g_apca.apca054 = ''
      LET g_apca.apca055 = '' 

            
      
      #稅別
      LET g_apca.apca060 = '2'
      #取得該法人的稅區
      CALL s_tax_get_ooef019(g_nmchcomp) RETURNING r_success,g_ooef019
    
      SELECT oodb002,oodb006,oodb005 
        INTO g_apca.apca011,g_apca.apca012,g_apca.apca013
        FROM oodb_t 
       WHERE oodb001 = g_ooef019 AND oodbent = g_enterprise AND oodb008 = '2'

      IF NOT cl_null(g_apca.apca015) THEN
         CALL s_department_get_respon_center(g_apca.apca015,g_apca.apcadocdt)
              RETURNING g_sub_success,g_errno,g_apca.apca034,l_apca034_desc
      END IF
 
      LET g_apca.apca014 = g_user
      LET g_apca.apca015 = g_dept
 
      #161128-00061#2---modify----begin----------
      #INSERT INTO apca_t VALUES(g_apca.*)
      INSERT INTO apca_t (apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,
                          apcacnfdt,apcapstid,apcapstdt,apcastus,apcald,apcacomp,apcadocno,apcadocdt,apcasite,
                          apca001,apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,
                          apca013,apca014,apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,
                          apca026,apca027,apca028,apca029,apca030,apca031,apca032,apca033,apca034,apca035,apca036,
                          apca037,apca038,apca039,apca040,apca041,apca042,apca043,apca044,apca045,apca046,apca047,
                          apca048,apca049,apca050,apca051,apca052,apca053,apca054,apca055,apca056,apca057,apca058,
                          apca059,apca060,apca061,apca062,apca063,apca064,apca065,apca066,apca100,apca101,apca103,
                          apca104,apca106,apca107,apca108,apca113,apca114,apca116,apca117,apca118,apca120,apca121,
                          apca123,apca124,apca126,apca127,apca128,apca130,apca131,apca133,apca134,apca136,apca137,
                          apca138,apca067,apca068,apca069,apca070,apca071,apca072,apca073)
       VALUES(g_apca.apcaent,g_apca.apcaownid,g_apca.apcaowndp,g_apca.apcacrtid,g_apca.apcacrtdp,g_apca.apcacrtdt,g_apca.apcamodid,g_apca.apcamoddt,g_apca.apcacnfid,
              g_apca.apcacnfdt,g_apca.apcapstid,g_apca.apcapstdt,g_apca.apcastus,g_apca.apcald,g_apca.apcacomp,g_apca.apcadocno,g_apca.apcadocdt,g_apca.apcasite,
              g_apca.apca001,g_apca.apca003,g_apca.apca004,g_apca.apca005,g_apca.apca006,g_apca.apca007,g_apca.apca008,g_apca.apca009,g_apca.apca010,g_apca.apca011,g_apca.apca012,
              g_apca.apca013,g_apca.apca014,g_apca.apca015,g_apca.apca016,g_apca.apca017,g_apca.apca018,g_apca.apca019,g_apca.apca020,g_apca.apca021,g_apca.apca022,g_apca.apca025,
              g_apca.apca026,g_apca.apca027,g_apca.apca028,g_apca.apca029,g_apca.apca030,g_apca.apca031,g_apca.apca032,g_apca.apca033,g_apca.apca034,g_apca.apca035,g_apca.apca036,
              g_apca.apca037,g_apca.apca038,g_apca.apca039,g_apca.apca040,g_apca.apca041,g_apca.apca042,g_apca.apca043,g_apca.apca044,g_apca.apca045,g_apca.apca046,g_apca.apca047,
              g_apca.apca048,g_apca.apca049,g_apca.apca050,g_apca.apca051,g_apca.apca052,g_apca.apca053,g_apca.apca054,g_apca.apca055,g_apca.apca056,g_apca.apca057,g_apca.apca058,
              g_apca.apca059,g_apca.apca060,g_apca.apca061,g_apca.apca062,g_apca.apca063,g_apca.apca064,g_apca.apca065,g_apca.apca066,g_apca.apca100,g_apca.apca101,g_apca.apca103,
              g_apca.apca104,g_apca.apca106,g_apca.apca107,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca116,g_apca.apca117,g_apca.apca118,g_apca.apca120,g_apca.apca121,
              g_apca.apca123,g_apca.apca124,g_apca.apca126,g_apca.apca127,g_apca.apca128,g_apca.apca130,g_apca.apca131,g_apca.apca133,g_apca.apca134,g_apca.apca136,g_apca.apca137,
              g_apca.apca138,g_apca.apca067,g_apca.apca068,g_apca.apca069,g_apca.apca070,g_apca.apca071,g_apca.apca072,g_apca.apca073)
      #161128-00061#2---modify----end----------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_apca",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF  

      FOREACH anmt420_02_sel_curs5 USING g_apca.apca004,g_apca.apca005 INTO l_nmci103,l_nmciseq 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF 
         LET g_apcb.apcbent = g_enterprise
         LET g_apcb.apcbld = g_apca.apcald
         LET g_apcb.apcbdocno = g_apca.apcadocno
         LET g_apcb.apcbsite = g_apca.apcasite
         LET g_apcb.apcb101 = l_nmci103
         
         SELECT MAX(apcbseq) INTO l_n FROM apcb_t
          WHERE apcbent = g_enterprise AND apcbld = g_apcb.apcbld AND apcbdocno = g_apcb.apcbdocno 
         IF cl_null(l_n) THEN LET l_n = 1 ELSE LET l_n = l_n + 1 END IF 
         LET g_apcb.apcbseq = l_n
         LET g_apcb.apcb001 = '19' 
         
          
         LET g_apcb.apcb007 = 1
         LET g_apcb.apcb020 = g_apca.apca011
         LET g_apcb.apcb100 = g_apca.apca100
         LET g_apcb.apcb021 = g_apca.apca036
         LET g_apcb.apcb029 = g_apca.apca035
        
         CALL s_tax_ins(g_apca.apcadocno,g_apcb.apcbseq,0,g_nmchcomp,
                        g_apcb.apcb101 * g_apcb.apcb007,g_apcb.apcb020,
                        g_apcb.apcb007,g_apcb.apcb100,g_apca.apca101,g_apca.apcald,g_apca.apca121,g_apca.apca131)
            RETURNING g_apcb.apcb103,g_apcb.apcb104,g_apcb.apcb105,
                      g_apcb.apcb113,g_apcb.apcb114,g_apcb.apcb115,
                      g_apcb.apcb123,g_apcb.apcb124,g_apcb.apcb125,
                      g_apcb.apcb133,g_apcb.apcb134,g_apcb.apcb135
                      
         IF g_apca.apca013 = 'Y' THEN
            LET g_apcb.apcb113 = g_apcb.apcb115 - g_apcb.apcb114
            LET g_apcb.apcb123 = g_apcb.apcb125 - g_apcb.apcb124
            LET g_apcb.apcb133 = g_apcb.apcb135 - g_apcb.apcb134
         ELSE
            LET g_apcb.apcb115 = g_apcb.apcb113 + g_apcb.apcb114
            LET g_apcb.apcb125 = g_apcb.apcb123 + g_apcb.apcb124
            LET g_apcb.apcb135 = g_apcb.apcb133 + g_apcb.apcb134
         END IF                      
         LET g_apcb.apcb106 = 0
         LET g_apcb.apcb116 = 0
         LET g_apcb.apcb117 = 0
         LET g_apcb.apcb118 = g_apcb.apcb113
         LET g_apcb.apcb119 = g_apcb.apcb115
         LET g_apcb.apcb126 = 0
         LET g_apcb.apcb136 = 0
         LET g_apcb.apcb023 = 'N'
         LET g_apcb.apcb022 = 1 
         LET g_apcb.apcb003 = ''
         LET g_apcb.apcb111 = g_apcb.apcb113 
         LET g_apcb.apcb030 = g_apca.apca008
        
         #161128-00061#2---modify----begin----------        
         #INSERT INTO apcb_t VALUES(g_apcb.*) 
         INSERT INTO apcb_t (apcbent,apcbld,apcblegl,apcborga,apcbsite,apcbdocno,apcbseq,apcb001,apcb002,apcb003,
                             apcb004,apcb005,apcb006,apcb007,apcb008,apcb009,apcb010,apcb011,apcb012,apcb013,apcb014,
                             apcb015,apcb016,apcb017,apcb018,apcb019,apcb020,apcb021,apcb022,apcb023,apcb024,apcb025,
                             apcb026,apcb027,apcb028,apcb029,apcb030,apcb032,apcb033,apcb034,apcb035,apcb036,apcb037,
                             apcb038,apcb039,apcb040,apcb041,apcb042,apcb043,apcb044,apcb045,apcb046,apcb047,apcb048,
                             apcb049,apcb050,apcb051,apcb100,apcb101,apcb102,apcb103,apcb104,apcb105,apcb106,apcb107,
                             apcb108,apcb111,apcb113,apcb114,apcb115,apcb116,apcb117,apcb118,apcb119,apcb121,apcb123,
                             apcb124,apcb125,apcb126,apcb127,apcb128,apcb131,apcb133,apcb134,apcb135,apcb136,apcb137,
                             apcb138,apcb052,apcb053,apcb054,apcb055)
          VALUES(g_apcb.apcbent,g_apcb.apcbld,g_apcb.apcblegl,g_apcb.apcborga,g_apcb.apcbsite,g_apcb.apcbdocno,g_apcb.apcbseq,g_apcb.apcb001,g_apcb.apcb002,g_apcb.apcb003,
                 g_apcb.apcb004,g_apcb.apcb005,g_apcb.apcb006,g_apcb.apcb007,g_apcb.apcb008,g_apcb.apcb009,g_apcb.apcb010,g_apcb.apcb011,g_apcb.apcb012,g_apcb.apcb013,g_apcb.apcb014,
                 g_apcb.apcb015,g_apcb.apcb016,g_apcb.apcb017,g_apcb.apcb018,g_apcb.apcb019,g_apcb.apcb020,g_apcb.apcb021,g_apcb.apcb022,g_apcb.apcb023,g_apcb.apcb024,g_apcb.apcb025,
                 g_apcb.apcb026,g_apcb.apcb027,g_apcb.apcb028,g_apcb.apcb029,g_apcb.apcb030,g_apcb.apcb032,g_apcb.apcb033,g_apcb.apcb034,g_apcb.apcb035,g_apcb.apcb036,g_apcb.apcb037,
                 g_apcb.apcb038,g_apcb.apcb039,g_apcb.apcb040,g_apcb.apcb041,g_apcb.apcb042,g_apcb.apcb043,g_apcb.apcb044,g_apcb.apcb045,g_apcb.apcb046,g_apcb.apcb047,g_apcb.apcb048,
                 g_apcb.apcb049,g_apcb.apcb050,g_apcb.apcb051,g_apcb.apcb100,g_apcb.apcb101,g_apcb.apcb102,g_apcb.apcb103,g_apcb.apcb104,g_apcb.apcb105,g_apcb.apcb106,g_apcb.apcb107,
                 g_apcb.apcb108,g_apcb.apcb111,g_apcb.apcb113,g_apcb.apcb114,g_apcb.apcb115,g_apcb.apcb116,g_apcb.apcb117,g_apcb.apcb118,g_apcb.apcb119,g_apcb.apcb121,g_apcb.apcb123,
                 g_apcb.apcb124,g_apcb.apcb125,g_apcb.apcb126,g_apcb.apcb127,g_apcb.apcb128,g_apcb.apcb131,g_apcb.apcb133,g_apcb.apcb134,g_apcb.apcb135,g_apcb.apcb136,g_apcb.apcb137,
                 g_apcb.apcb138,g_apcb.apcb052,g_apcb.apcb053,g_apcb.apcb054,g_apcb.apcb055) 
         #161128-00061#2---modify----end----------
                    
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins_apcb",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF 
            
         UPDATE nmci_t SET nmci008 = g_apca.apcadocno
                 WHERE nmcient = g_enterprise
                   AND nmcicomp = g_nmchcomp
                   AND nmcidocno = g_nmchdocno
                   AND nmciseq = l_nmciseq
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmci_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmci_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE               
         END CASE 



      END FOREACH   
      
      #计算单头金额
      SELECT SUM(apcb103*apcb022),SUM(apcb104*apcb022),SUM(apcb105*apcb022),
             SUM(apcb113*apcb022),SUM(apcb114*apcb022),SUM(apcb115*apcb022),
             SUM(apcb123*apcb022),SUM(apcb124*apcb022),SUM(apcb125*apcb022),
             SUM(apcb133*apcb022),SUM(apcb134*apcb022),SUM(apcb135*apcb022)
        INTO g_apca.apca103,g_apca.apca104,g_apca.apca108,
             g_apca.apca113,g_apca.apca114,g_apca.apca118,
             g_apca.apca123,g_apca.apca124,g_apca.apca128,
             g_apca.apca133,g_apca.apca134,g_apca.apca138
        FROM apcb_t
       WHERE apcbent  = g_enterprise AND apcbld = g_glaald
         AND apcbdocno = g_apca.apcadocno
         
      IF cl_null(g_apca.apca103) THEN LET g_apca.apca103 = 0 END IF
      IF cl_null(g_apca.apca104) THEN LET g_apca.apca104 = 0 END IF
      IF cl_null(g_apca.apca108) THEN LET g_apca.apca108 = 0 END IF
      IF cl_null(g_apca.apca113) THEN LET g_apca.apca113 = 0 END IF
      IF cl_null(g_apca.apca114) THEN LET g_apca.apca114 = 0 END IF
      IF cl_null(g_apca.apca118) THEN LET g_apca.apca118 = 0 END IF 
      IF cl_null(g_apca.apca123) THEN LET g_apca.apca123 = 0 END IF
      IF cl_null(g_apca.apca124) THEN LET g_apca.apca124 = 0 END IF
      IF cl_null(g_apca.apca128) THEN LET g_apca.apca128 = 0 END IF  
      IF cl_null(g_apca.apca133) THEN LET g_apca.apca133 = 0 END IF
      IF cl_null(g_apca.apca134) THEN LET g_apca.apca134 = 0 END IF
      IF cl_null(g_apca.apca138) THEN LET g_apca.apca138 = 0 END IF       
      
      UPDATE apca_t SET (apca103,apca104,apca108,
                         apca113,apca114,apca118,
                         apca123,apca124,apca128,
                         apca133,apca134,apca138
                         ) =
                        (g_apca.apca103,g_apca.apca104,g_apca.apca108,
                         g_apca.apca113,g_apca.apca114,g_apca.apca118,
                         g_apca.apca123,g_apca.apca124,g_apca.apca128,
                         g_apca.apca133,g_apca.apca134,g_apca.apca138)
        WHERE apcaent = g_enterprise AND apcald = g_glaald
          AND apcadocno = g_apca.apcadocno
       
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "upd apca_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF         
      
      CALL s_aap_create_multi_bill_perod_tmp()
      CALL s_aap_multi_bill_period(g_apca.apcald,g_apca.apcadocno) RETURNING r_success,g_errno
     
   END FOREACH
   RETURN r_success
END FUNCTION

 
{</section>}
 
