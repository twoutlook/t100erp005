#該程式未解開Section, 採用最新樣板產出!
{<section id="afat470_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-10-19 12:43:30), PR版次:0007(2016-11-23 11:13:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000095
#+ Filename...: afat470_01
#+ Description: 合併原則
#+ Creator....: 01531(2014-10-19 12:33:02)
#+ Modifier...: 01531 -SD/PR- 02481
 
{</section>}
 
{<section id="afat470_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161009-00007#1     2016/10/10 By 07900    1）单身一多了一个‘规格’栏位，测试和‘规格型号’是一样的。
#                                          2）单身二增加名称栏位（实体字段，表结构要加字段），产生到afai100时，faah013=单身二的名称。
#161009-00006#7     2016/10/13 By 02114    卡编自动编码时，抓取max（卡编）要按归属法人来抓
#161111-00028#7     2016/11/23 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_ooia_m        RECORD
       sel LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fabadocno   LIKE faba_t.fabadocno
#end add-point
 
DEFINE g_ooia_m        type_g_ooia_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afat470_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat470_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_fabadocno
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
   DEFINE p_fabadocno     LIKE faba_t.fabadocno
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat470_01 WITH FORM cl_ap_formpath("afa","afat470_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_ooia_m.sel = '1'
   DISPLAY BY NAME  g_ooia_m.sel
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooia_m.sel ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.sel"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.sel"
            
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
   CLOSE WINDOW w_afat470_01 
   
   #add-point:input段after input name="input.post_input"
   LET g_fabadocno = p_fabadocno   
   CALL afat470_01_fabm_ins()
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat470_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat470_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 新增合并资料
# Memo...........:
# Usage..........: CALL afat470_01_fabm_ins()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/10/19 By yangxf
# Modify.........:
################################################################################
PUBLIC FUNCTION afat470_01_fabm_ins()
   #161111-00028#7---modify--begin-----------
  # DEFINE l_fabm      RECORD LIKE fabm_t.*
  # DEFINE l_fabl      RECORD LIKE fabl_t.*
  # DEFINE l_faba      RECORD LIKE faba_t.*
   DEFINE l_fabm RECORD  #資產合併/分割單身二明細檔
       fabment LIKE fabm_t.fabment, #企業編碼
       fabmcomp LIKE fabm_t.fabmcomp, #法人
       fabmdocno LIKE fabm_t.fabmdocno, #工作量單號
       fabmseq LIKE fabm_t.fabmseq, #項次
       fabm001 LIKE fabm_t.fabm001, #財產編號
       fabm002 LIKE fabm_t.fabm002, #附號
       fabm003 LIKE fabm_t.fabm003, #卡片編號
       fabm004 LIKE fabm_t.fabm004, #主要類型
       fabm005 LIKE fabm_t.fabm005, #類型
       fabm006 LIKE fabm_t.fabm006, #規格
       fabm007 LIKE fabm_t.fabm007, #數量
       fabm008 LIKE fabm_t.fabm008, #資產性質
       fabm009 LIKE fabm_t.fabm009, #資產屬性
       fabm010 LIKE fabm_t.fabm010, #幣別
       fabm011 LIKE fabm_t.fabm011, #匯率
       fabm012 LIKE fabm_t.fabm012, #成本
       fabm013 LIKE fabm_t.fabm013, #累折
       fabm014 LIKE fabm_t.fabm014, #管理組織
       fabm015 LIKE fabm_t.fabm015, #所有組織
       fabm016 LIKE fabm_t.fabm016, #核算組織
       fabm017 LIKE fabm_t.fabm017, #未折減額
       fabm018 LIKE fabm_t.fabm018, #減值準備
       fabm101 LIKE fabm_t.fabm101, #本位幣二幣別
       fabm102 LIKE fabm_t.fabm102, #本位幣二匯率
       fabm103 LIKE fabm_t.fabm103, #本位幣二成本
       fabm104 LIKE fabm_t.fabm104, #本位幣二累折
       fabm105 LIKE fabm_t.fabm105, #本位幣二未折減額
       fabm106 LIKE fabm_t.fabm106, #本位幣二減值準備
       fabm201 LIKE fabm_t.fabm201, #本位幣三幣別
       fabm202 LIKE fabm_t.fabm202, #本位幣三匯率
       fabm203 LIKE fabm_t.fabm203, #本位幣三成本
       fabm204 LIKE fabm_t.fabm204, #本位幣三累折
       fabm205 LIKE fabm_t.fabm205, #本位幣三未折減額
       fabm206 LIKE fabm_t.fabm206, #本位幣三減值準備
       fabm019 LIKE fabm_t.fabm019, #使用年限
       fabm020 LIKE fabm_t.fabm020  #名稱
        END RECORD
   DEFINE l_fabl RECORD  #資產合併/分割單身一明細檔
       fablent LIKE fabl_t.fablent, #企業編碼
       fablcomp LIKE fabl_t.fablcomp, #法人
       fabldocno LIKE fabl_t.fabldocno, #工作量單號
       fablseq LIKE fabl_t.fablseq, #項次
       fabl001 LIKE fabl_t.fabl001, #財產編號
       fabl002 LIKE fabl_t.fabl002, #附號
       fabl003 LIKE fabl_t.fabl003, #卡片編號
       fabl004 LIKE fabl_t.fabl004, #主要類型
       fabl005 LIKE fabl_t.fabl005, #規格
       fabl006 LIKE fabl_t.fabl006, #數量
       fabl007 LIKE fabl_t.fabl007, #資產性質
       fabl008 LIKE fabl_t.fabl008, #資產屬性
       fabl009 LIKE fabl_t.fabl009, #幣別
       fabl010 LIKE fabl_t.fabl010, #匯率
       fabl011 LIKE fabl_t.fabl011, #成本
       fabl012 LIKE fabl_t.fabl012, #累折
       fabl013 LIKE fabl_t.fabl013, #管理組織
       fabl014 LIKE fabl_t.fabl014, #所有組織
       fabl015 LIKE fabl_t.fabl015, #核算組織
       fabl016 LIKE fabl_t.fabl016, #未折減額
       fabl017 LIKE fabl_t.fabl017, #類型
       fabl018 LIKE fabl_t.fabl018, #使用年限
       fabl101 LIKE fabl_t.fabl101, #本位幣二幣別
       fabl102 LIKE fabl_t.fabl102, #本位幣二匯率
       fabl103 LIKE fabl_t.fabl103, #本位幣二成本
       fabl104 LIKE fabl_t.fabl104, #本位幣二累折
       fabl105 LIKE fabl_t.fabl105, #本位幣二未折減額
       fabl106 LIKE fabl_t.fabl106, #本位幣二減值準備
       fabl201 LIKE fabl_t.fabl201, #本位幣三幣別
       fabl202 LIKE fabl_t.fabl202, #本位幣三匯率
       fabl203 LIKE fabl_t.fabl203, #本位幣三成本
       fabl204 LIKE fabl_t.fabl204, #本位幣三累折
       fabl205 LIKE fabl_t.fabl205, #本位幣三耒折減額
       fabl206 LIKE fabl_t.fabl206, #本位幣三減值準備
       fabl019 LIKE fabl_t.fabl019  #減值準備
       END RECORD
   DEFINE l_faba RECORD  #資產異動單頭檔
       fabaent LIKE faba_t.fabaent, #企業編號
       fabadocno LIKE faba_t.fabadocno, #單據編號
       fabadocdt LIKE faba_t.fabadocdt, #單據日期
       fabasite LIKE faba_t.fabasite, #資產中心
       fabacomp LIKE faba_t.fabacomp, #法人
       faba001 LIKE faba_t.faba001, #帳務人員
       faba002 LIKE faba_t.faba002, #No Use
       faba003 LIKE faba_t.faba003, #單據性質
       fabastus LIKE faba_t.fabastus, #確認碼
       fabaownid LIKE faba_t.fabaownid, #資料所有者
       fabaowndp LIKE faba_t.fabaowndp, #資料所屬部門
       fabacrtid LIKE faba_t.fabacrtid, #資料建立者
       fabacrtdp LIKE faba_t.fabacrtdp, #資料建立部門
       fabacrtdt LIKE faba_t.fabacrtdt, #資料創建日
       fabamodid LIKE faba_t.fabamodid, #資料修改者
       fabamoddt LIKE faba_t.fabamoddt, #最近修改日
       fabacnfid LIKE faba_t.fabacnfid, #資料確認者
       fabacnfdt LIKE faba_t.fabacnfdt, #資料確認日
       faba004 LIKE faba_t.faba004, #申請人員
       faba005 LIKE faba_t.faba005, #申請部門
       faba006 LIKE faba_t.faba006, #申請日期
       faba007 LIKE faba_t.faba007, #解除文號
       faba008 LIKE faba_t.faba008, #解除日期
       faba009 LIKE faba_t.faba009, #帳務單號
       faba010 LIKE faba_t.faba010, #帳務日期
       faba011 LIKE faba_t.faba011, #調撥流水號
       faba012 LIKE faba_t.faba012, #在途否
       faba013 LIKE faba_t.faba013, #撥出過帳
       faba014 LIKE faba_t.faba014, #撥入過帳
       faba015 LIKE faba_t.faba015, #保險公司
       faba016 LIKE faba_t.faba016, #付款對象
       faba017 LIKE faba_t.faba017, #帳務單據
       faba018 LIKE faba_t.faba018, #投資抵減/免稅狀態
       faba019 LIKE faba_t.faba019, #投資抵減/免税年度
       faba020 LIKE faba_t.faba020, #管理局/開工核准日期
       faba021 LIKE faba_t.faba021, #管理局/開工核准文號
       faba022 LIKE faba_t.faba022, #國稅局/免稅核准日期
       faba023 LIKE faba_t.faba023, #國稅局/免稅核准文號
       faba024 LIKE faba_t.faba024  #免稅金額
       END RECORD

   #161111-00028#7---modify--end-----------
   DEFINE l_sql       STRING 
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_faah002   LIKE faah_t.faah002
   DEFINE l_faah001   LIKE faah_t.faah001
   DEFINE l_para_data LIKE type_t.chr80
   DEFINE l_faaj003   LIKE faaj_t.faaj003
   DEFINE l_faaj005   LIKE faaj_t.faaj005
   DEFINE l_fabl009   LIKE fabl_t.fabl009
   DEFINE l_fabl010   LIKE fabl_t.fabl010
   DEFINE l_fabl006   LIKE fabl_t.fabl006
   DEFINE l_fabl011   LIKE fabl_t.fabl011
   DEFINE l_fabl012   LIKE fabl_t.fabl012
   DEFINE l_fabl016   LIKE fabl_t.fabl016
   DEFINE l_fabl019   LIKE fabl_t.fabl019
   DEFINE l_fabl101   LIKE fabl_t.fabl101
   DEFINE l_fabl102   LIKE fabl_t.fabl102
   DEFINE l_fabl103   LIKE fabl_t.fabl103
   DEFINE l_fabl104   LIKE fabl_t.fabl104
   DEFINE l_fabl105   LIKE fabl_t.fabl105
   DEFINE l_fabl106   LIKE fabl_t.fabl106
   DEFINE l_fabl201   LIKE fabl_t.fabl201
   DEFINE l_fabl202   LIKE fabl_t.fabl202
   DEFINE l_fabl203   LIKE fabl_t.fabl203
   DEFINE l_fabl204   LIKE fabl_t.fabl204
   DEFINE l_fabl205   LIKE fabl_t.fabl205
   DEFINE l_fabl206   LIKE fabl_t.fabl206
   DEFINE l_fabl013   LIKE fabl_t.fabl013
   DEFINE l_fabl014   LIKE fabl_t.fabl014
   DEFINE l_fabl015   LIKE fabl_t.fabl015
   #######################################add by huangtao
   DEFINE l_str       STRING
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_ooab002_1 LIKE ooab_t.ooab002
   DEFINE l_ooab002_2 LIKE ooab_t.ooab002
   DEFINE l_glaald    LIKE glaa_t.glaald
   #######################################add by huangtao
   
   
   WHENEVER ERROR CONTINUE
   INITIALIZE l_fabm.* TO NULL
   INITIALIZE l_fabl.* TO NULL
   LET l_fabl013 = ''
   LET l_fabl014 = ''
   LET l_fabl015 = ''   
   ##########################################
   #161111-00028#7---modify--begin-----------
   #SELECT * INTO l_faba.* 
   SELECT fabaent,fabadocno,fabadocdt,fabasite,fabacomp,faba001,faba002,faba003,fabastus,fabaownid,
          fabaowndp,fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt,fabacnfid,fabacnfdt,faba004,
          faba005,faba006,faba007,faba008,faba009,faba010,faba011,faba012,faba013,faba014,faba015,
          faba016,faba017,faba018,faba019,faba020,faba021,faba022,faba023,faba024 INTO l_faba.* 
   #161111-00028#7---modify--begin-----------
    FROM faba_t WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno  
   SELECT  glaald INTO l_glaald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_faba.fabacomp AND glaa014 = 'Y'
     
   CALL cl_get_para(g_enterprise,l_faba.fabacomp,'S-FIN-9010') RETURNING l_ooab002_1    #财编自动编号
   CALL cl_get_para(g_enterprise,l_faba.fabacomp,'S-FIN-9005') RETURNING l_ooab002_2    #卡号自动编号
   ##########################################
   
   CALL s_transaction_begin()
  #######################mark by huangtao
  # SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_faah001
  #   FROM faah_t
  #  WHERE faahent = g_enterprise
  #######################mark by huangtao
   #以附件形式显示
   IF g_ooia_m.sel = '1' THEN
     #161111-00028#7---modify--begin-----------   
     #DECLARE sel_fabl  CURSOR FOR SELECT * FROM fabl_t 
      DECLARE sel_fabl  CURSOR FOR SELECT fablent,fablcomp,fabldocno,fablseq,fabl001,fabl002,fabl003,fabl004,fabl005,
                                          fabl006,fabl007,fabl008,fabl009,fabl010,fabl011,fabl012,fabl013,fabl014,
                                          fabl015,fabl016,fabl017,fabl018,fabl101,fabl102,fabl103,fabl104,fabl105,
                                          fabl106,fabl201,fabl202,fabl203,fabl204,fabl205,fabl206,fabl019 FROM fabl_t 
     #161111-00028#7---modify--end-----------   
                                    WHERE fabldocno = g_fabadocno 
                                      AND fablent = g_enterprise
                                    ORDER BY fabl017
      LET l_n = 1
      FOREACH sel_fabl INTO l_fabl.*
         LET l_fabm.fabment = l_fabl.fablent
         LET l_fabm.fabmcomp = l_fabl.fablcomp
         LET l_fabm.fabmdocno = l_fabl.fabldocno
         LET l_fabm.fabmseq = l_n
         ################################mark by huangtao
         #LET l_fabm.fabm001 = ''
         #IF l_n = 1 THEN 
         #   LET l_fabm.fabm002 = ' '
         #ELSE
         #   LET l_fabm.fabm002 = ''
         #END IF 
         #LET l_fabm.fabm003 = l_faah001
         #################################mark by huangtao
         #################################add by huangtao
         LET l_str = l_fabl.fabl001
         LET l_cnt = l_str.getLength()
         
         LET l_fabm.fabm001 = l_fabl.fabl001
        # IF l_ooab002_1 = 'N' OR cl_null(l_ooab002_1) THEN
        #    LET l_fabm.fabm001 = l_fabl.fabl001
        # ELSE
        #    CALL s_aooi390('3') RETURNING l_success,l_fabm.fabm001     
        # END IF

         IF l_n = 1 THEN
            LET l_fabm.fabm002 = ' '
         ELSE
            IF l_cnt > 4 THEN
               LET l_fabm.fabm002 = l_fabl.fabl001[l_cnt-3,l_cnt]
            ELSE
               LET l_fabm.fabm002 = l_fabl.fabl001
            END IF
         END IF
         
         IF l_ooab002_2 = 'Y' THEN       
            #LET l_sql = " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0)) + 1),10,'0') FROM faah_t ",   #161009-00006#7 mark lujh
            LET l_sql = " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0))) + 1),10,'0') FROM faah_t ",   #161009-00006#7 add lujh 
                        " WHERE faahent ='",g_enterprise,"'",
                        "    AND regexp_substr(faah001,'[0-9]+') IS NOT NULL",
                        "    AND faah032 = '",l_faba.fabacomp,"'"       #161009-00006#7 add lujh                     
            PREPARE sel_faah001 FROM l_sql
            EXECUTE sel_faah001 INTO l_fabm.fabm003 
            IF cl_null(l_fabm.fabm003) THEN LET l_fabm.fabm003 = '0000000001' END IF 
         ELSE
            LET l_fabm.fabm003 = ''
         END IF 
         #################################add by huangtao
         LET l_fabm.fabm004 = l_fabl.fabl004
         IF l_n = 1 THEN
            LET l_fabm.fabm005 = '1'
         ELSE
            IF l_fabl.fabl017 = '1' THEN 
               LET l_fabm.fabm005 = '2'
            ELSE
               LET l_fabm.fabm005 = l_fabl.fabl017
            END IF 
         END IF 
         #161009-00007#1--add--s--
         #獲取單身預設值-名称
         IF cl_null(l_fabl.fabl002) THEN
            LET l_fabl.fabl002 = ' '
         END IF
         SELECT faah012 INTO l_fabm.fabm020
           FROM faah_t
          WHERE faahent = g_enterprise
            AND faah003 = l_fabl.fabl001
            AND faah004 = l_fabl.fabl002 
            AND faah001 = l_fabl.fabl003                   
         #161009-00007#1--add--e--
         LET l_fabm.fabm006 = l_fabl.fabl005
         LET l_fabm.fabm007 = l_fabl.fabl006
         LET l_fabm.fabm008 = l_fabl.fabl007
         LET l_fabm.fabm009 = l_fabl.fabl008
         LET l_fabm.fabm010 = l_fabl.fabl009
         LET l_fabm.fabm011 = l_fabl.fabl010
         LET l_fabm.fabm012 = l_fabl.fabl011
         LET l_fabm.fabm013 = l_fabl.fabl012
         LET l_fabm.fabm014 = l_fabl.fabl013
         LET l_fabm.fabm015 = l_fabl.fabl014
         LET l_fabm.fabm016 = l_fabl.fabl015
         LET l_fabm.fabm017 = l_fabl.fabl016 
         LET l_fabm.fabm018 = l_fabl.fabl019
         LET l_fabm.fabm101 = l_fabl.fabl101
         LET l_fabm.fabm102 = l_fabl.fabl102
         LET l_fabm.fabm103 = l_fabl.fabl103
         LET l_fabm.fabm104 = l_fabl.fabl104
         LET l_fabm.fabm105 = l_fabl.fabl105
         LET l_fabm.fabm106 = l_fabl.fabl106
         LET l_fabm.fabm201 = l_fabl.fabl201
         LET l_fabm.fabm202 = l_fabl.fabl202
         LET l_fabm.fabm203 = l_fabl.fabl203
         LET l_fabm.fabm204 = l_fabl.fabl204
         LET l_fabm.fabm205 = l_fabl.fabl205
         LET l_fabm.fabm206 = l_fabl.fabl206
         #161111-00028#7---modify--begin-----------
        #INSERT INTO fabm_t VALUES(l_fabm.*)
         INSERT INTO fabm_t (fabment,fabmcomp,fabmdocno,fabmseq,fabm001,fabm002,fabm003,fabm004,fabm005,fabm006,
                             fabm007,fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm014,fabm015,fabm016,fabm017,
                             fabm018,fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,
                             fabm205,fabm206,fabm019,fabm020)
           VALUES(l_fabm.fabment,l_fabm.fabmcomp,l_fabm.fabmdocno,l_fabm.fabmseq,l_fabm.fabm001,l_fabm.fabm002,l_fabm.fabm003,l_fabm.fabm004,l_fabm.fabm005,l_fabm.fabm006,
                  l_fabm.fabm007,l_fabm.fabm008,l_fabm.fabm009,l_fabm.fabm010,l_fabm.fabm011,l_fabm.fabm012,l_fabm.fabm013,l_fabm.fabm014,l_fabm.fabm015,l_fabm.fabm016,l_fabm.fabm017,
                  l_fabm.fabm018,l_fabm.fabm101,l_fabm.fabm102,l_fabm.fabm103,l_fabm.fabm104,l_fabm.fabm105,l_fabm.fabm106,l_fabm.fabm201,l_fabm.fabm202,l_fabm.fabm203,l_fabm.fabm204,
                  l_fabm.fabm205,l_fabm.fabm206,l_fabm.fabm019,l_fabm.fabm020)
         #161111-00028#7---modify--begin-----------
         IF SQLCA.sqlcode THEN 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'INS fabm_t ' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN 
         END IF 
         LET l_n = l_n + 1
        # SELECT lpad((MAX(faah001) + l_n),10,'0') INTO l_faah001
        #   FROM faah_t
        #  WHERE faahent = g_enterprise
      END FOREACH 
   END IF 
   #相同年限，折旧方法合并
   IF g_ooia_m.sel = '2' THEN 
      LET l_n = 1
      DECLARE sel_fabl2 CURSOR FOR SELECT faaj003,faaj005,fabl009,fabl010,SUM(fabl006),SUM(fabl011),SUM(fabl012),
                                          SUM(fabl016),SUM(fabl019),fabl101,fabl102,SUM(fabl103),SUM(fabl104),SUM(fabl105),
                                          SUM(fabl106),fabl201,fabl202,SUM(fabl203),SUM(fabl204),SUM(fabl205),SUM(fabl206)
                                     FROM fabl_t,faaj_t
                                    WHERE fablent = faajent
                                      AND fabl001 = faaj001
                                      AND fabl002 = faaj002
                                      AND fabl003 = faaj037
                                      AND faajld = l_glaald
                                      AND fabldocno = g_fabadocno
                                      AND fablent = g_enterprise
                                    GROUP BY faaj003,faaj005,fabl009,fabl010,fabl101,fabl102,fabl201,fabl202#,fabl013,fabl014,fabl015
      FOREACH sel_fabl2 INTO l_faaj003,l_faaj005,l_fabl009,l_fabl010,l_fabl006,l_fabl011,l_fabl012,
                             l_fabl016,l_fabl019,l_fabl101,l_fabl102,l_fabl103,l_fabl104,l_fabl105,l_fabl106,
                             l_fabl201,l_fabl202,l_fabl203,l_fabl204,l_fabl205,l_fabl206
                             
                             
         #################################add by huangtao
       
         SELECT DISTINCT fabl001 INTO l_fabl.fabl001 FROM fabl_t,faaj_t
          WHERE fablent = faajent AND fabl001 = faaj001 AND fabl002 = faaj002
            AND fabl003 = faaj037 AND faajld = l_glaald AND fablent = g_enterprise AND fabldocno = g_fabadocno 
            AND faaj003 = l_faaj003 AND faaj005 = l_faaj005
            
         LET l_str = l_fabl.fabl001
         LET l_cnt = l_str.getLength()
         
         LET l_fabm.fabm001 = l_fabl.fabl001
        # IF l_ooab002_1 = 'N' OR cl_null(l_ooab002_1) THEN
        #    LET l_fabm.fabm001 = l_fabl.fabl001
        # ELSE
        #        
        # END IF

         IF l_n = 1 THEN
            LET l_fabm.fabm002 = ' '
         ELSE
            IF l_cnt > 4 THEN
               LET l_fabm.fabm002 = l_fabl.fabl001[l_cnt-3,l_cnt]
            ELSE
               LET l_fabm.fabm002 = l_fabl.fabl001
            END IF
         END IF
         
         IF l_ooab002_2 = 'Y' THEN
            #LET l_sql = " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0)) + 1),10,'0') FROM faah_t ",   #161009-00006#7 mark lujh
            LET l_sql = " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0))) + 1),10,'0') FROM faah_t ",   #161009-00006#7 add lujh
                        "  WHERE faahent ='",g_enterprise,"'",
                        "    AND regexp_substr(faah001,'[0-9]+') IS NOT NULL",
                        "    AND faah032 = '",l_faba.fabacomp,"'"    #161009-00006#7 add lujh                         
            PREPARE sel_faah001_1 FROM l_sql
            EXECUTE sel_faah001_1 INTO l_fabm.fabm003 
            IF cl_null(l_fabm.fabm003) THEN LET l_fabm.fabm003 = '0000000001' END IF
         ELSE
            LET l_fabm.fabm003 = ''
         END IF 
         #################################add by huangtao                    
                             
         IF l_n = 1 THEN
            LET l_fabm.fabm005 = '1'
         ELSE
            LET l_fabm.fabm005 = '2'        
         END IF
         SELECT fabl013,fabl014,fabl015 INTO l_fabl013,l_fabl014,l_fabl015
           FROM fabl_t
          WHERE fabl017 = '1' 
            AND fabldocno = g_fabadocno
            AND fablent = g_enterprise 
            
         LET l_fabm.fabment = g_enterprise
         LET l_fabm.fabmdocno = g_fabadocno
         LET l_fabm.fabmseq = l_n
         ############################mark by huangtao
         #LET l_fabm.fabm001 = ''
         #LET l_fabm.fabm003 = l_faah001
         ############################mark by huangtao
         #161009-00007#1--add--s--
         #獲取單身預設值-名称、规格
         IF cl_null(l_fabm.fabm002) THEN
            LET l_fabm.fabm002 = ' '
         END IF
         SELECT faah012,faah013 INTO l_fabm.fabm020,l_fabm.fabm006
           FROM faah_t
          WHERE faahent = g_enterprise
            AND faah003 = l_fabm.fabm001
            AND faah004 = l_fabm.fabm002 
            AND faah001 = l_fabm.fabm003   
         #161009-00007#1--add--e--
         LET l_fabm.fabm007 = l_fabl006
         LET l_fabm.fabm010 = l_fabl009
         LET l_fabm.fabm011 = l_fabl010
         LET l_fabm.fabm012 = l_fabl011
         LET l_fabm.fabm013 = l_fabl012
         LET l_fabm.fabm014 = l_fabl013
         LET l_fabm.fabm015 = l_fabl014
         LET l_fabm.fabm016 = l_fabl015
         LET l_fabm.fabm017 = l_fabl016 
         LET l_fabm.fabm018 = l_fabl019
         LET l_fabm.fabm101 = l_fabl101
         LET l_fabm.fabm102 = l_fabl102
         LET l_fabm.fabm103 = l_fabl103
         LET l_fabm.fabm104 = l_fabl104
         LET l_fabm.fabm105 = l_fabl105
         LET l_fabm.fabm106 = l_fabl106
         LET l_fabm.fabm201 = l_fabl201
         LET l_fabm.fabm202 = l_fabl202
         LET l_fabm.fabm203 = l_fabl203
         LET l_fabm.fabm204 = l_fabl204
         LET l_fabm.fabm205 = l_fabl205
         LET l_fabm.fabm206 = l_fabl206
        #161111-00028#7---modify--begin-----------
        #INSERT INTO fabm_t VALUES(l_fabm.*)
         INSERT INTO fabm_t (fabment,fabmcomp,fabmdocno,fabmseq,fabm001,fabm002,fabm003,fabm004,fabm005,fabm006,
                             fabm007,fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm014,fabm015,fabm016,fabm017,
                             fabm018,fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,
                             fabm205,fabm206,fabm019,fabm020)
           VALUES(l_fabm.fabment,l_fabm.fabmcomp,l_fabm.fabmdocno,l_fabm.fabmseq,l_fabm.fabm001,l_fabm.fabm002,l_fabm.fabm003,l_fabm.fabm004,l_fabm.fabm005,l_fabm.fabm006,
                  l_fabm.fabm007,l_fabm.fabm008,l_fabm.fabm009,l_fabm.fabm010,l_fabm.fabm011,l_fabm.fabm012,l_fabm.fabm013,l_fabm.fabm014,l_fabm.fabm015,l_fabm.fabm016,l_fabm.fabm017,
                  l_fabm.fabm018,l_fabm.fabm101,l_fabm.fabm102,l_fabm.fabm103,l_fabm.fabm104,l_fabm.fabm105,l_fabm.fabm106,l_fabm.fabm201,l_fabm.fabm202,l_fabm.fabm203,l_fabm.fabm204,
                  l_fabm.fabm205,l_fabm.fabm206,l_fabm.fabm019,l_fabm.fabm020)
        #161111-00028#7---modify--begin-----------
         IF SQLCA.sqlcode THEN 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'INS fabm_t ' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN 
         END IF 
         LET l_n = l_n + 1
        ##############################mark by huangtao
        # SELECT lpad((MAX(faah001) + l_n),10,'0') INTO l_faah001
        #   FROM faah_t
        #  WHERE faahent = g_enterprise
        #############################mark by huangtao
      END FOREACH 
   END IF 
   CALL s_transaction_end('Y','0')
END FUNCTION

 
{</section>}
 
