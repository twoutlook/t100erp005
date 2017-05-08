#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt450_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2016-10-11 09:23:46), PR版次:0018(2017-02-09 17:21:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000091
#+ Filename...: anmt450_01
#+ Description: 自動產生單身
#+ Creator....: 03080(2015-06-24 14:45:12)
#+ Modifier...: 01531 -SD/PR- 02114
 
{</section>}
 
{<section id="anmt450_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150714-00024#1  2015/07/15 By Reanna   bug修正
#150807-00007#1  2015/08/12 By Reanna   增加為兌現產生來源單據時，需把來源單據現金變動碼產過來
#151013-00016#6  2015/10/28 By RayHuang glbc_t新增狀態碼
#151203-00013#4  2015/12/07 By Jessy    anmt450整單操作->產生單身時, 要依開票單號排序寫入單身
#151222-00010#6  2016/01/06 By yangtt   增加异动类别为8:應收票據兌現时，glbc档有相应的资料（glbcld+glbcdocno+glbcseq)
#160107          2016/01/07 By Reanna   寫入glbc_t要依單據日期轉換期別
#160524-00055#2  2016/06/17 By 01531    规格调整，新增nmci009,预收为N
#160524-00055#4  2016/07/26 By 01531    自动产生单身时，nmcr008赋值调整
#160822-00018#1  2016/08/22 By Reanna   調整匯率取位問題，應用原幣幣別取位
#160830-00004#1  2016/09/01 By 01531    票据带入时，来源组织应给对应的票据anmt510上的来源组织nmbborga。
#160913-00032#1  2016/09/18 By 02599    開窗或自動產生單時,符合條件之收票資料,来源为anmt510的票据應取狀態Y 或V 
#161104-00047#1  2016/11/14 By 01531    anmt450中有利息支出，anmt470分录中需增加利息分录
#161111-00041#1  2016/11/21 By 01531    应收票据票贴 处理后“整单操作”  设置“现金变动码”未将贴现的拨金额写入
#161128-00061#2  2016/11/30 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161220-00013#1  2016/12/21 By 01531    自動產生單身的「開票單號」欄位,開窗增加anmt540的部分
#161026-00010#1  2016/12/22 By 01531    開窗或自動產生單時,符合條件之收票資料,来源为anmt510的票据應取狀態V
#170207-00022#1  2017/02/09 By 02114    托收、兌現时,产生glbc的金额都应该给nmcr106、nmcr116的值
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
PRIVATE type type_g_nmck_m        RECORD
       nmckcomp LIKE nmck_t.nmckcomp, 
   nmckcomp_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_nmck  STRING
DEFINE g_wc_nmbb  STRING
DEFINE g_display_docdt STRING
DEFINE g_display_docdt1 STRING #160929-00056#1
DEFINE g_display_docno STRING  #160929-00056#1
DEFINE g_anmt450_01 RECORD
                    prog      LIKE type_t.chr80,
                    nmchcomp  LIKE nmch_t.nmchcomp,
                    nmchdocno LIKE nmch_t.nmchdocno,
                    nmch003   LIKE nmch_t.nmch003,    #交易帳戶
                    nmch100   LIKE nmch_t.nmch100,    #票據幣別
                    nmch001   LIKE nmch_t.nmch001    #異動類型
                    END RECORD
#end add-point
 
DEFINE g_nmck_m        type_g_nmck_m
 
   DEFINE g_nmckcomp_t LIKE nmck_t.nmckcomp
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt450_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt450_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_array
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
   DEFINE p_array DYNAMIC ARRAY OF RECORD
                  chr    LIKE type_t.chr1000,
                  dat    LIKE type_t.dat
                  END RECORD
   DEFINE r_success LIKE type_t.num5
   DEFINE l_gzze003 LIKE gzze_t.gzze003  
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt450_01 WITH FORM cl_ap_formpath("anm","anmt450_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #傳入值的處理
   #p_array[1].chr     'anmt450' / 'anmt520'
   #p_array[2].chr     nmchcomp  / nmcqcomp 
   #p_array[3].chr     nmchdocno / nmcqdocno
   #p_array[4].chr     nmch003   / nmcq003    #交易帳戶
   #p_array[5].chr     nmch100   / nmcq100    #票據幣別
   #p_array[6].chr     nmch001   / nmcq001    #異動類型
   LET g_anmt450_01.prog = p_array[1].chr
   LET g_anmt450_01.nmchcomp = p_array[2].chr
   LET g_anmt450_01.nmchdocno = p_array[3].chr
   LET g_anmt450_01.nmch003   = p_array[4].chr
   LET g_anmt450_01.nmch100   = p_array[5].chr
   LET g_anmt450_01.nmch001   = p_array[6].chr
   #160929-00056#1 add s---
   IF g_prog = 'anmt520' THEN 
      LET l_gzze003 = NULL
      LET l_gzze003 = cl_getmsg('anm-03027',g_dlang)
      CALL cl_set_comp_att_text('nmckdocno',l_gzze003)
      LET l_gzze003 = NULL
      LET l_gzze003 = cl_getmsg('anm-03028',g_dlang)
      CALL cl_set_comp_att_text('nmckdocdt',l_gzze003)       
   END IF
   #160929-00056#1 add e---
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmck_m.nmckcomp ATTRIBUTE(WITHOUT DEFAULTS)
         
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
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcomp
            #add-point:ON ACTION controlp INFIELD nmckcomp name="input.c.nmckcomp"
            

            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      #CONSTRUCT g_wc_nmck ON nmck011 FROM nmck011                                        #160929-00056#1 mark
      CONSTRUCT g_wc_nmck ON nmck011,nmckdocno,nmckdocdt FROM nmck011,nmckdocno,nmckdocdt #160929-00056 add 
      
         #160929-00056#1 add s---      
         ON ACTION controlp INFIELD nmckdocno    
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_prog = 'anmt450' THEN
               LET g_qryparam.where = " nmck002 IN (SELECT ooia001 FROM ooia_t  WHERE ooia002 = '30' AND ooiaent = ",g_enterprise," )"
               #160913-00032#1 add s---
               CASE
                  WHEN g_anmt450_01.nmch001 = '3'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmck026 IN ('1','2','6') "
                  WHEN g_anmt450_01.nmch001 = '4'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmck026 IN ('1','2') "
                  WHEN g_anmt450_01.nmch001 = '5'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmck026 IN ('0','1','2') "
                  WHEN g_anmt450_01.nmch001 = '6'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmck026 IN ('0','1','2') "
               END CASE   
               #160913-00032#1 add s---               
               CALL q_nmckdocno_6()
            ELSE
               #LET g_qryparam.where = " nmba003 = 'anmt510' "                         #161220-00013#1 mark
               LET g_qryparam.where = " nmba003 IN('anmt510','anmt540','anmt541') "    #161220-00013#1 add
               #160913-00032#1 add s---
               CASE
                  WHEN g_anmt450_01.nmch001 = '2'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '1' "
                  WHEN g_anmt450_01.nmch001 = '4'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '1' "
                  WHEN g_anmt450_01.nmch001 = '5'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '1' "
                  WHEN g_anmt450_01.nmch001 = '6'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '2' "
                  WHEN g_anmt450_01.nmch001 = '7'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '2' "
                  WHEN g_anmt450_01.nmch001 = '8'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '2' "      
                  WHEN g_anmt450_01.nmch001 = '9'
                     LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmbb042 = '5' "         
               END CASE  
               #160913-00032#1 add e---               
               CALL q_nmbadocno_6()
            END IF
            DISPLAY g_qryparam.return1 TO nmckdocno   #顯示到畫面上
            NEXT FIELD nmckdocno                     #返回原欄位
         #160929-00056#1 add e--- 
         
         AFTER CONSTRUCT 
            LET g_display_docdt  = DIALOG.getFieldBuffer("nmck011")  
            LET g_display_docno  = DIALOG.getFieldBuffer("nmckdocno") #160929-00056#1 add
            LET g_display_docdt1 = DIALOG.getFieldBuffer("nmckdocdt") #160929-00056#1 add
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
#160929-00056#1 mark s---
#   CONSTRUCT g_wc_nmbb ON nmbb031                     
#     FROM nmck011
   CONSTRUCT g_wc_nmbb ON nmbb031,nmbadocno,nmbadocdt
     FROM nmck011,nmckdocno,nmckdocdt
#160929-00056#1 mark e---        
      BEFORE CONSTRUCT
         DISPLAY g_display_docdt  TO nmck011
         DISPLAY g_display_docdt1 TO nmckdocdt  #160929-00056#1 add
         DISPLAY g_display_docno  TO nmckdocno  #160929-00056#1 add 
         EXIT CONSTRUCT
   END CONSTRUCT
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_anmt450_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
       CASE 
          WHEN g_anmt450_01.prog = 'anmt450'
             CALL cl_err_collect_init()
             CALL anmt450_01_ins_nmci()RETURNING g_sub_success
             IF NOT g_sub_success THEN
                LET r_success = FALSE
             END IF
             CALL cl_err_collect_show()
          WHEN g_anmt450_01.prog = 'anmt520'
             CALL cl_err_collect_init()
             CALL anmt450_01_ins_nmcr()RETURNING g_sub_success
             IF NOT g_sub_success THEN
                LET r_success = FALSE
                
             END IF
             CALL cl_err_collect_show()
       END CASE
   ELSE
      LET INT_FLAG = FALSE
   END IF
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt450_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt450_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: anmt450 自動產生單身
# Memo...........:
# Date & Author..: 150624 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt450_01_ins_nmci()
   DEFINE l_nmci RECORD
                 nmcient   LIKE nmci_t.nmcient,
                 nmcicomp  LIKE nmci_t.nmcicomp,
                 nmcidocno LIKE nmci_t.nmcidocno,
                 nmciseq   LIKE nmci_t.nmciseq,
                 nmciorga  LIKE nmci_t.nmciorga,  #150714-00024#1
                 nmci001   LIKE nmci_t.nmci001,
                 nmci002   LIKE nmci_t.nmci002,
                 nmci003   LIKE nmci_t.nmci003,
                 nmci008   LIKE nmci_t.nmci008,
                 nmci100   LIKE nmci_t.nmci100,
                 nmci101   LIKE nmci_t.nmci101,
                 nmci103   LIKE nmci_t.nmci103,
                 nmci105   LIKE nmci_t.nmci105,
                 nmci113   LIKE nmci_t.nmci113,
                 nmci115   LIKE nmci_t.nmci115,
                 nmci118   LIKE nmci_t.nmci118,
                 nmci121   LIKE nmci_t.nmci121,
                 nmci131   LIKE nmci_t.nmci131,
                 nmci009   LIKE nmci_t.nmci009 #160524-00055#2
                 END RECORD
   DEFINE l_sql  STRING
   DEFINE l_nmck025  LIKE nmck_t.nmck025
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmch RECORD LIKE nmch_t.*
   DEFINE l_nmch RECORD  #應付票據異動主檔
       nmchent LIKE nmch_t.nmchent, #企業編碼
       nmchcomp LIKE nmch_t.nmchcomp, #法人
       nmchsite LIKE nmch_t.nmchsite, #資金中心
       nmchdocno LIKE nmch_t.nmchdocno, #單據號碼
       nmchdocdt LIKE nmch_t.nmchdocdt, #異動日期
       nmch001 LIKE nmch_t.nmch001, #異動類別
       nmch002 LIKE nmch_t.nmch002, #帳務人員
       nmch003 LIKE nmch_t.nmch003, #交易帳戶編碼
       nmch004 LIKE nmch_t.nmch004, #重立帳否
       nmch006 LIKE nmch_t.nmch006, #備註
       nmch007 LIKE nmch_t.nmch007, #主帳套帳務單號
       nmch008 LIKE nmch_t.nmch008, #次帳一帳套帳務單號
       nmch009 LIKE nmch_t.nmch009, #次帳二帳套帳務單號
       nmch100 LIKE nmch_t.nmch100, #幣別
       nmch101 LIKE nmch_t.nmch101, #匯率
       nmchstus LIKE nmch_t.nmchstus, #狀態碼
       nmchownid LIKE nmch_t.nmchownid, #資料所有者
       nmchowndp LIKE nmch_t.nmchowndp, #資料所屬部門
       nmchcrtid LIKE nmch_t.nmchcrtid, #資料建立者
       nmchcrtdp LIKE nmch_t.nmchcrtdp, #資料建立部門
       nmchcrtdt LIKE nmch_t.nmchcrtdt, #資料創建日
       nmchmodid LIKE nmch_t.nmchmodid, #資料修改者
       nmchmoddt LIKE nmch_t.nmchmoddt, #最近修改日
       nmchcnfid LIKE nmch_t.nmchcnfid, #資料確認者
       nmchcnfdt LIKE nmch_t.nmchcnfdt, #資料確認日
       nmch010 LIKE nmch_t.nmch010  #作業類別
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_date LIKE type_t.num10
   DEFINE l_nmckdocdt LIKE nmck_t.nmckdocdt
   DEFINE l_nmck011   LIKE nmck_t.nmck011
   DEFINE l_nmck113   LIKE nmck_t.nmck113
   DEFINE l_nmck031   LIKE nmck_t.nmck031
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_glaald    LIKE glaa_t.glaald
   DEFINE l_glaa      RECORD
                      glaa001  LIKE glaa_t.glaa001,
                      glaa015  LIKE glaa_t.glaa015,
                      glaa016  LIKE glaa_t.glaa016,
                      glaa017  LIKE glaa_t.glaa017,
                      glaa018  LIKE glaa_t.glaa018,
                      glaa019  LIKE glaa_t.glaa019,
                      glaa020  LIKE glaa_t.glaa020,
                      glaa021  LIKE glaa_t.glaa021,
                      glaa022  LIKE glaa_t.glaa022,
                      glaa023  LIKE glaa_t.glaa023
                      END RECORD
   DEFINE l_ooam003   LIKE ooam_t.ooam003
   DEFINE r_success   LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   INITIALIZE l_nmch.* TO NULL
   #161128-00061#2---modify----begin----------
   #SELECT * INTO l_nmch.*
   SELECT nmchent,nmchcomp,nmchsite,nmchdocno,nmchdocdt,nmch001,nmch002,nmch003,nmch004,
          nmch006,nmch007,nmch008,nmch009,nmch100,nmch101,nmchstus,nmchownid,nmchowndp,
          nmchcrtid,nmchcrtdp,nmchcrtdt,nmchmodid,nmchmoddt,nmchcnfid,nmchcnfdt,nmch010 INTO l_nmch.*
   #161128-00061#2---modify----end----------
     FROM nmch_t
    WHERE nmchent = g_enterprise
      AND nmchcomp = g_anmt450_01.nmchcomp
      AND nmchdocno = g_anmt450_01.nmchdocno

   LET l_glaald = NULL
   SELECT glaald INTO l_glaald FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_nmch.nmchcomp
      AND glaa014 = 'Y'
       
   INITIALIZE l_glaa.* TO NULL
   SELECT glaa001,glaa015,glaa016,glaa017,glaa018,
          glaa019,glaa020,glaa021,glaa022,glaa023
     INTO l_glaa.*
     FROM glaa_t
    WHERE glaald = l_glaald
      AND glaaent = g_enterprise
 
   LET r_success = TRUE
 
   LET l_sql  = "SELECT nmck025 FROM nmck_t ",
                " WHERE nmckent = ",g_enterprise," ",
                "   AND nmckcomp = '",g_anmt450_01.nmchcomp,"' ",
                "   AND nmck004  = '",g_anmt450_01.nmch003,"' ",
                "   AND nmckstus = 'Y' ",
                "   AND nmck025 IS NOT NULL ",   
                "   AND nmck002 NOT IN(SELECT ooia001 FROM ooia_t WHERE ooiaent = ",g_enterprise," AND ooia011 = 'Y') "
   CASE
      WHEN g_anmt450_01.nmch001 = '3'
         LET l_sql = l_sql CLIPPED, " AND nmck026 IN ('1','2','6') "
      WHEN g_anmt450_01.nmch001 = '4'
         LET l_sql = l_sql CLIPPED, " AND nmck026 IN ('1','2') "
      WHEN g_anmt450_01.nmch001 = '5'
         LET l_sql = l_sql CLIPPED, " AND nmck026 IN ('0','1','2') "
      WHEN g_anmt450_01.nmch001 = '6'
         LET l_sql = l_sql CLIPPED, " AND nmck026 IN ('0','1','2') "
   END CASE
   
   LET l_sql = l_sql CLIPPED ," AND ",g_wc_nmck CLIPPED
   LET l_sql = l_sql CLIPPED ," ORDER BY nmckdocno "       #151203-00013#4
   PREPARE anmt450_01p1 FROM l_sql
   DECLARE anmt450_01c1 CURSOR FOR anmt450_01p1
   
   FOREACH anmt450_01c1 INTO l_nmck025
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH :anmt450_01p1'
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      #檢查此票號是否已經存在任一單身
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM nmci_t
       WHERE nmcient = g_enterprise
         AND nmci001 = l_nmck025
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count > 0 THEN CONTINUE FOREACH END IF
   
      INITIALIZE l_nmci.* TO NULL
      LET l_nmci.nmcient  = g_enterprise
      LET l_nmci.nmcicomp = l_nmch.nmchcomp
      LET l_nmci.nmcidocno =l_nmch.nmchdocno
      LET l_nmci.nmciseq   = NULL
      
      SELECT MAX(nmciseq) + 1 INTO l_nmci.nmciseq FROM nmci_t
       WHERE nmcient = g_enterprise
         AND nmcicomp = l_nmci.nmcicomp
         AND nmcidocno  = l_nmci.nmcidocno
      IF cl_null(l_nmci.nmciseq)THEN LET l_nmci.nmciseq = 1 END IF
      
      LET l_nmci.nmci001  = l_nmck025
      SELECT nmck026,nmckdocno,nmck100,nmck103,
             nmckdocdt,nmck011,nmck031,nmck113
        INTO l_nmci.nmci002,l_nmci.nmci003,
             l_nmci.nmci100,l_nmci.nmci103,
             l_nmckdocdt,l_nmck011,l_nmck031,l_nmck113
        FROM nmck_t
       WHERE nmckent = g_enterprise
         AND nmckcomp = l_nmci.nmcicomp
         AND nmck025 = l_nmci.nmci001 
      IF cl_null(l_nmci.nmci103)THEN   LET l_nmci.nmci103=0 END IF
      IF cl_null(l_nmck113)THEN   LET l_nmck113=0 END IF      
      CALL s_curr_round_ld('1',l_glaald,l_nmci.nmci100,l_nmci.nmci103,2) RETURNING g_sub_success,g_errno,l_nmci.nmci103
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmck113,2) RETURNING g_sub_success,g_errno,l_nmck113
      
      LET l_nmci.nmci101 = l_nmch.nmch101 
     #CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmch.nmch101,3) RETURNING g_sub_success,g_errno,l_nmch.nmch101 #160822-00018#1 mark
      CALL s_curr_round_ld('1',l_glaald,l_nmch.nmch100,l_nmch.nmch101,3) RETURNING g_sub_success,g_errno,l_nmch.nmch101 #160822-00018#1
      
      LET l_nmci.nmci113 = l_nmci.nmci103 * l_nmci.nmci101 
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmci.nmci113,2) RETURNING g_sub_success,g_errno,l_nmci.nmci113
      
      IF l_nmch.nmch001 = '5' THEN 
         #流通期間= nmck011 到期日 -nmckdocdt 開票日期 
         #nmck103 * nmck031 利率/100  * 流通期間/360 
         LET l_date = l_nmck011 - l_nmckdocdt + 1  #利息+1
         LET l_nmci.nmci105 = l_nmci.nmci103 * l_nmck031 / 100 * l_date / 360
      ELSE
         LET l_nmci.nmci105 = 0 
      END IF
      CALL s_curr_round_ld('1',l_glaald,l_nmci.nmci100,l_nmci.nmci105,2) RETURNING g_sub_success,g_errno,l_nmci.nmci105
      
      LET l_nmci.nmci115 = l_nmci.nmci105 * l_nmci.nmci101
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmci.nmci115,2) RETURNING g_sub_success,g_errno,l_nmci.nmci115
      
      LET l_nmci.nmci118 = l_nmci.nmci113 - l_nmck113  

      IF l_glaa.glaa015 = 'Y' THEN          
         #來源幣別
         IF l_glaa.glaa017 = '1' THEN
            LET l_ooam003 = l_nmch.nmch100   
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = l_glaa.glaa001            #帳套使用幣別
         END IF
         #主帳套本位幣二匯率
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',l_glaald,l_nmch.nmchdocdt,l_ooam003,
                                   #目的幣別;          交易金額; 匯類類型
                                   l_glaa.glaa016,0,l_glaa.glaa018)
              RETURNING l_nmci.nmci121      
        #CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa016,l_nmci.nmci121,3) RETURNING g_sub_success,g_errno,l_nmci.nmci121 #160822-00018#1 mark
         CALL s_curr_round_ld('1',l_glaald,l_ooam003,l_nmci.nmci121,3) RETURNING g_sub_success,g_errno,l_nmci.nmci121      #160822-00018#1
      END IF
        
      IF l_glaa.glaa019 = 'Y' THEN 
         #來源幣別
         IF l_glaa.glaa021 = '1' THEN 
            LET l_ooam003 = l_nmch.nmch100    
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = l_glaa.glaa001   #帳套使用幣別
         END IF
         #主帳套本位幣三匯率
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',l_glaald,l_nmch.nmchdocdt,l_ooam003,
                                   #目的幣別; 交易金額; 匯類類型
                                   l_glaa.glaa020,0,l_glaa.glaa022)
              RETURNING l_nmci.nmci131
        #CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa020,l_nmci.nmci131,3) RETURNING g_sub_success,g_errno,l_nmci.nmci131 #160822-00018#1 mark
         CALL s_curr_round_ld('1',l_glaald,l_ooam003,l_nmci.nmci131,3) RETURNING g_sub_success,g_errno,l_nmci.nmci131      #160822-00018#1
      END IF

      #給0
      IF cl_null(l_nmci.nmci101)THEN   LET l_nmci.nmci101=0 END IF
      IF cl_null(l_nmci.nmci103)THEN   LET l_nmci.nmci103=0 END IF
      IF cl_null(l_nmci.nmci105)THEN   LET l_nmci.nmci105=0 END IF
      IF cl_null(l_nmci.nmci113)THEN   LET l_nmci.nmci113=0 END IF
      IF cl_null(l_nmci.nmci115)THEN   LET l_nmci.nmci115=0 END IF
      IF cl_null(l_nmci.nmci118)THEN   LET l_nmci.nmci118=0 END IF
      IF cl_null(l_nmci.nmci121)THEN   LET l_nmci.nmci121=0 END IF
      IF cl_null(l_nmci.nmci131)THEN   LET l_nmci.nmci131=0 END IF
      
      #150714-00024#1 add ------
      #撈取anmt440的來源組織(因為有限定同張單據只能同一個來源組織，所以撈第一項次即可)
      SELECT nmclorga INTO l_nmci.nmciorga
        FROM nmcl_t
       WHERE nmclent = g_enterprise
         AND nmclcomp = l_nmci.nmcicomp
         AND nmcldocno = l_nmci.nmci003
         AND nmclseq = 1
      #150714-00024#1 add end---
  
      LET l_nmci.nmci009 = 'N' #160524-00055#2
      #150714-00024#1 add nmciorga
      INSERT INTO nmci_t (nmcient,nmcicomp,nmcidocno,nmciseq,nmci001,
                          nmci002,nmci003,nmci008,nmci100,nmci101,
                          nmci103,nmci105,nmci113,nmci115,nmci118,
                          nmci121,nmci131,nmciorga,nmci009) #160524-00055#2 add nmci009
                  VALUES (l_nmci.nmcient,l_nmci.nmcicomp,l_nmci.nmcidocno,l_nmci.nmciseq,l_nmci.nmci001,
                          l_nmci.nmci002,l_nmci.nmci003,l_nmci.nmci008,l_nmci.nmci100,l_nmci.nmci101,
                          l_nmci.nmci103,l_nmci.nmci105,l_nmci.nmci113,l_nmci.nmci115,l_nmci.nmci118,
                          l_nmci.nmci121,l_nmci.nmci131,l_nmci.nmciorga,l_nmci.nmci009) #160524-00055#2 add nmci009
      IF SQLCA.SQLERRD[3] = 0 THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'ins_nmci'
         CALL cl_err()
         LET r_success = FALSE
      #150807-00007#1 add ------
      ELSE
         IF l_nmch.nmch001 = '5' THEN
            #如果是兌現，需寫入一筆anmt450的現金變動碼檔
            #150818 日期改抓anmt450的日期才對
            CALL anmt450_01_ins_glbc_450(l_nmci.nmcicomp,l_nmci.nmcidocno,l_nmci.nmciseq,l_nmch.nmchdocdt) RETURNING g_sub_success
         END IF
      #150807-00007#1 add end---
      END IF
      
   
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 應收票據異動單自動產生單身
# Memo...........:
# Usage..........:
# Date & Author..: 150624 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt450_01_ins_nmcr()
   DEFINE l_sql    STRING
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmcq   RECORD LIKE nmcq_t.*
   DEFINE l_nmcq RECORD  #應收票據異動主檔
       nmcqent LIKE nmcq_t.nmcqent, #企業編碼
       nmcqcomp LIKE nmcq_t.nmcqcomp, #法人
       nmcqsite LIKE nmcq_t.nmcqsite, #資金中心
       nmcqdocno LIKE nmcq_t.nmcqdocno, #單據號碼
       nmcqdocdt LIKE nmcq_t.nmcqdocdt, #異動日期
       nmcq001 LIKE nmcq_t.nmcq001, #異動類別
       nmcq002 LIKE nmcq_t.nmcq002, #帳務人員
       nmcq003 LIKE nmcq_t.nmcq003, #交易帳戶
       nmcq004 LIKE nmcq_t.nmcq004, #重立帳否
       nmcq005 LIKE nmcq_t.nmcq005, #轉付對象
       nmcq006 LIKE nmcq_t.nmcq006, #備註
       nmcq007 LIKE nmcq_t.nmcq007, #帳務單號
       nmcq008 LIKE nmcq_t.nmcq008, #帳套二帳務單號
       nmcq009 LIKE nmcq_t.nmcq009, #帳套三帳務單號
       nmcq100 LIKE nmcq_t.nmcq100, #幣別
       nmcq101 LIKE nmcq_t.nmcq101, #匯率
       nmcqstus LIKE nmcq_t.nmcqstus, #狀態碼
       nmcqownid LIKE nmcq_t.nmcqownid, #資料所有者
       nmcqowndp LIKE nmcq_t.nmcqowndp, #資料所屬部門
       nmcqcrtid LIKE nmcq_t.nmcqcrtid, #資料建立者
       nmcqcrtdp LIKE nmcq_t.nmcqcrtdp, #資料建立部門
       nmcqcrtdt LIKE nmcq_t.nmcqcrtdt, #資料創建日
       nmcqmodid LIKE nmcq_t.nmcqmodid, #資料修改者
       nmcqmoddt LIKE nmcq_t.nmcqmoddt, #最近修改日
       nmcqcnfid LIKE nmcq_t.nmcqcnfid, #資料確認者
       nmcqcnfdt LIKE nmcq_t.nmcqcnfdt  #資料確認日
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_nmcr   RECORD 
                   nmcrent   LIKE nmcr_t.nmcrent,
                   nmcrcomp  LIKE nmcr_t.nmcrcomp,
                   nmcrdocno LIKE nmcr_t.nmcrdocno,
                   nmcrseq   LIKE nmcr_t.nmcrseq,
                   nmcrorga  LIKE nmcr_t.nmcrorga,
                   nmcr001   LIKE nmcr_t.nmcr001,
                   nmcr002   LIKE nmcr_t.nmcr002,
                   nmcr003   LIKE nmcr_t.nmcr003,
                   nmcr004   LIKE nmcr_t.nmcr004,
                   nmcr005   LIKE nmcr_t.nmcr005,
                   nmcr006   LIKE nmcr_t.nmcr006,
                   nmcr007   LIKE nmcr_t.nmcr007,
                   nmcr008   LIKE nmcr_t.nmcr008,
                   nmcr100   LIKE nmcr_t.nmcr100,
                   nmcr101   LIKE nmcr_t.nmcr101,
                   nmcr103   LIKE nmcr_t.nmcr103,
                   nmcr104   LIKE nmcr_t.nmcr104,
                   nmcr105   LIKE nmcr_t.nmcr105,
                   nmcr106   LIKE nmcr_t.nmcr106,
                   nmcr107   LIKE nmcr_t.nmcr107,
                   nmcr113   LIKE nmcr_t.nmcr113,
                   nmcr114   LIKE nmcr_t.nmcr114,
                   nmcr115   LIKE nmcr_t.nmcr115,
                   nmcr116   LIKE nmcr_t.nmcr116,
                   nmcr117   LIKE nmcr_t.nmcr117,
                   nmcr118   LIKE nmcr_t.nmcr118,
                   nmcr121   LIKE nmcr_t.nmcr121,
                   nmcr122   LIKE nmcr_t.nmcr122,
                   nmcr131   LIKE nmcr_t.nmcr131,
                   nmcr132   LIKE nmcr_t.nmcr132
                   END RECORD
   DEFINE l_nmbb030   LIKE nmbb_t.nmbb030
   DEFINE l_nmbb026   LIKE nmbb_t.nmbb026
   DEFINE l_nmbb031   LIKE nmbb_t.nmbb031
   DEFINE l_nmbb065   LIKE nmbb_t.nmbb065
   DEFINE l_nmbb045   LIKE nmbb_t.nmbb045
   DEFINE l_glaald    LIKE glaa_t.glaald
   DEFINE l_glaa      RECORD
                      glaa001  LIKE glaa_t.glaa001,
                      glaa015  LIKE glaa_t.glaa015,
                      glaa016  LIKE glaa_t.glaa016,
                      glaa017  LIKE glaa_t.glaa017,
                      glaa018  LIKE glaa_t.glaa018,
                      glaa019  LIKE glaa_t.glaa019,
                      glaa020  LIKE glaa_t.glaa020,
                      glaa021  LIKE glaa_t.glaa021,
                      glaa022  LIKE glaa_t.glaa022,
                      glaa023  LIKE glaa_t.glaa023
                      END RECORD
   DEFINE l_ooam003   LIKE ooam_t.ooam003
   DEFINE l_nmbb066   LIKE nmbb_t.nmbb066
   DEFINE l_nmbb067   LIKE nmbb_t.nmbb067
   DEFINE l_nmbb068   LIKE nmbb_t.nmbb068
   DEFINE r_success   LIKE type_t.num5
 

   WHENEVER ERROR CONTINUE
   INITIALIZE l_nmcq.* TO NULL
   #161128-00061#2---modify----begin----------
   #SELECT * INTO l_nmcq.* FROM nmcq_t
   SELECT nmcqent,nmcqcomp,nmcqsite,nmcqdocno,nmcqdocdt,nmcq001,nmcq002,nmcq003,
          nmcq004,nmcq005,nmcq006,nmcq007,nmcq008,nmcq009,nmcq100,nmcq101,nmcqstus,
          nmcqownid,nmcqowndp,nmcqcrtid,nmcqcrtdp,nmcqcrtdt,nmcqmodid,nmcqmoddt,
          nmcqcnfid,nmcqcnfdt INTO l_nmcq.* FROM nmcq_t
   #161128-00061#2---modify----end----------
    WHERE nmcqent = g_enterprise
      AND nmcqcomp = g_anmt450_01.nmchcomp
      AND nmcqdocno = g_anmt450_01.nmchdocno
      
   LET l_glaald = NULL
   SELECT glaald INTO l_glaald FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_nmcq.nmcqcomp
      AND glaa014 = 'Y'
       
   INITIALIZE l_glaa.* TO NULL
   SELECT glaa001,glaa015,glaa016,
          glaa017,glaa018,glaa019,
          glaa020,glaa021,glaa022,
          glaa023
     INTO l_glaa.*
     FROM glaa_t
    WHERE glaald = l_glaald
      AND glaaent = g_enterprise
      
   LET r_success = TRUE
      
   LET l_sql = "SELECT nmbb030 ",   
               "  FROM nmba_t,nmbb_t ",
               " WHERE nmbaent=nmbbent AND nmbacomp=nmbbcomp AND nmbadocno=nmbbdocno  ",
               "   AND nmbbent= ",g_enterprise," AND nmbacomp='",g_anmt450_01.nmchcomp,"' ",
               "   AND nmbb029='30' ",
               "   AND (nmbb069 = 'N' OR nmbb069 IS NULL)",
              #"   AND nmbbseq = 1 ",   #150805apo mark
              #"   AND nmbastus IN ('Y','V') ", #150922-00021#4 mark
              #"   AND ((nmbastus='Y' AND nmba003<>'anmt540') OR (nmbastus='V' and nmba003='anmt540'))",#151021 by 03538 mark #150922-00021#4
#               "   AND ( (nmbastus='Y' AND nmba003 NOT IN ('anmt540','anmt541')) ",     #151021 by 03538 #160913-00032#1 mark
               #"   AND ( (nmbastus IN ('Y','V') AND nmba003 NOT IN ('anmt540','anmt541')) ", #160913-00032#1 add #161026-00010#1 mark
               "   AND ( (nmbastus = 'V' AND nmba003 NOT IN ('anmt540','anmt541')) ",  #161026-00010#1 add
               "    OR   (nmbastus='V' AND nmba003 IN ('anmt540','anmt541')) )",        #151021 by 03538                
               "   AND nmbb030 IS NOT NULL ",
               "   AND nmbb004 = '",g_anmt450_01.nmch100,"' "
   CASE
      WHEN g_anmt450_01.nmch001 = '2'
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '1' "
      WHEN g_anmt450_01.nmch001 = '4'
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '1' "
      WHEN g_anmt450_01.nmch001 = '5'
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '1' "
      WHEN g_anmt450_01.nmch001 = '6'
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '2' "
      WHEN g_anmt450_01.nmch001 = '7'
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '2' "
      WHEN g_anmt450_01.nmch001 = '8'
         #兌現類型2且帳戶要相同且兌現日未到應不可兌現(手動輸入時詢問)
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '2' ",
                                    " AND nmbb003 = '",g_anmt450_01.nmch003,"' ",
                                    " AND nmbb031 <= '",l_nmcq.nmcqdocdt,"' "         
      WHEN g_anmt450_01.nmch001 = '9'
         LET l_sql = l_sql CLIPPED, " AND nmbb042 = '5' "         
   END CASE      
   LET l_sql = l_sql CLIPPED ," AND ",g_wc_nmbb CLIPPED
   PREPARE anmt450_01p2 FROM l_sql
   DECLARE anmt450_01c2 CURSOR FOR anmt450_01p2
   
   FOREACH anmt450_01c2 INTO l_nmbb030 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "FOREACH anmt450_01c2"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      INITIALIZE l_nmcr.* TO NULL
      LET l_nmcr.nmcrent   = g_enterprise
      LET l_nmcr.nmcrcomp  = l_nmcq.nmcqcomp
      LET l_nmcr.nmcrdocno = l_nmcq.nmcqdocno
      #LET l_nmcr.nmcrorga  = l_nmcq.nmcqcomp #160830-00004#1
      LET l_nmcr.nmcrseq   = NULL
      SELECT MAX(nmcrseq)+1 INTO l_nmcr.nmcrseq FROM nmcr_t
       WHERE nmcrent = g_enterprise
         AND nmcrcomp = l_nmcq.nmcqcomp
         AND nmcrdocno  = l_nmcq.nmcqdocno
      IF cl_null(l_nmcr.nmcrseq)THEN LET l_nmcr.nmcrseq = 1 END IF
         
      LET l_nmcr.nmcr001 = l_nmbb030
      
      SELECT DISTINCT nmbb042,nmbb026,nmbb031,nmbb006,nmbb065,
                      nmbb045,nmbadocno,nmbb066,nmbb067,nmbb068,nmbborga  #160830-00004#1 add nmbborga
        INTO l_nmcr.nmcr002,l_nmbb026,l_nmbb031,l_nmcr.nmcr103,l_nmbb065,
             l_nmbb045,l_nmcr.nmcr003,l_nmbb066,l_nmbb067,l_nmbb068,l_nmcr.nmcrorga  #160830-00004#1 add nmbborga
        FROM nmba_t,nmbb_t
       WHERE nmbaent=nmbbent AND nmbacomp=nmbbcomp AND nmbadocno=nmbbdocno
         AND nmbbent=g_enterprise
         AND nmbacomp=l_nmcq.nmcqcomp
         AND nmbb029='30'
         AND nmbb030 = l_nmcr.nmcr001
         AND (nmbb069 = 'N' OR nmbb069 IS NULL)
        #AND nmbbseq = 1   #150805apo mark
      IF cl_null(l_nmbb068) THEN LET l_nmbb068 = 0 END IF
      IF cl_null(l_nmbb067) THEN LET l_nmbb067 = 0 END IF
      IF cl_null(l_nmbb066) THEN LET l_nmbb066 = 0 END IF
      IF cl_null(l_nmbb045) THEN LET l_nmbb045 = 0 END IF #161111-00041#1 add 
      IF cl_null(l_nmcr.nmcr103)THEN LET l_nmcr.nmcr103 = 0 END IF
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa020,l_nmbb068,2) RETURNING g_sub_success,g_errno,l_nmbb068
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa016,l_nmbb067,2) RETURNING g_sub_success,g_errno,l_nmbb067
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmbb066,2) RETURNING g_sub_success,g_errno,l_nmbb066
      CALL s_curr_round_ld('1',l_glaald,l_nmcq.nmcq100,l_nmcr.nmcr103,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr103
      
      LET l_nmcr.nmcr100 = l_nmcq.nmcq100
      LET l_nmcr.nmcr101 = l_nmcq.nmcq101
      CALL s_curr_round_ld('1',l_glaald,l_nmcq.nmcq100,l_nmcr.nmcr101,3) RETURNING g_sub_success,g_errno,l_nmcr.nmcr101
      
      LET l_nmcr.nmcr113 = l_nmcr.nmcr103 * l_nmcr.nmcr101
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmcr.nmcr113,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr113
      
      IF l_nmcq.nmcq001 MATCHES '[48]' THEN
         LET l_nmcr.nmcr004=l_nmbb031-l_nmbb065+1
         LET l_nmcr.nmcr104=l_nmcr.nmcr103*l_nmbb045/100*l_nmcr.nmcr004/360
         CALL s_curr_round_ld('1',l_glaald,l_nmcq.nmcq100,l_nmcr.nmcr104,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr104
         LET l_nmcr.nmcr114=l_nmcr.nmcr104*l_nmcr.nmcr101
         CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmcr.nmcr114,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr114
      ELSE
         LET l_nmcr.nmcr004 = 0 
         LET l_nmcr.nmcr104 = 0 
         LET l_nmcr.nmcr114 = 0 
      END IF
      
#     LET l_nmcr.nmcr005
      LET l_nmcr.nmcr006 = 0
      LET l_nmcr.nmcr007 = 0
#      LET l_nmcr.nmcr008 = 0 #160524-00055#4
      
      LET l_nmcr.nmcr107 =0
      LET l_nmcr.nmcr117 =0
      LET l_nmcr.nmcr118 =0
      IF cl_null(l_nmbb066)THEN LET l_nmbb066 = 0 END IF
      LET l_nmcr.nmcr118= l_nmcr.nmcr113-l_nmbb066
      
      LET l_nmcr.nmcr105=(l_nmcr.nmcr103+l_nmcr.nmcr104) * l_nmcr.nmcr006/100 * l_nmcr.nmcr007/360
      CALL s_curr_round_ld('1',l_glaald,l_nmcq.nmcq100,l_nmcr.nmcr105,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr105
      LET l_nmcr.nmcr115= l_nmcr.nmcr105 * l_nmcr.nmcr101
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmcr.nmcr115,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr115
      LET l_nmcr.nmcr106= l_nmcr.nmcr103+l_nmcr.nmcr104-l_nmcr.nmcr105 - l_nmcr.nmcr107
      LET l_nmcr.nmcr116= l_nmcr.nmcr106 * l_nmcr.nmcr101
      CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa001,l_nmcr.nmcr116,2) RETURNING g_sub_success,g_errno,l_nmcr.nmcr116
      IF l_glaa.glaa015 = 'Y' THEN
         #來源幣別
         IF l_glaa.glaa017 = '1' THEN
            LET l_ooam003 = l_nmcq.nmcq100
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = l_glaa.glaa001            #帳套使用幣別
         END IF
         #主帳套本位幣二匯率
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',l_glaald,l_nmcq.nmcqdocdt,l_ooam003,
                                   #目的幣別;          交易金額; 匯類類型
                                   l_glaa.glaa016,0,l_glaa.glaa018)
              RETURNING l_nmcr.nmcr121
        #CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa016,l_nmcr.nmcr121,3) #160822-00018#1 mark
         CALL s_curr_round_ld('1',l_glaald,l_ooam003,l_nmcr.nmcr121,3)      #160822-00018#1
              RETURNING g_sub_success,g_errno,l_nmcr.nmcr121
         IF l_glaa.glaa017 = '1' THEN #原幣
            LET l_nmcr.nmcr122 = l_nmcr.nmcr103 * l_nmcr.nmcr121-l_nmbb067
            CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa016,l_nmcr.nmcr122,2)
                 RETURNING g_sub_success,g_errno,l_nmcr.nmcr122
         ELSE #本幣
            LET l_nmcr.nmcr122 = l_nmcr.nmcr113 * l_nmcr.nmcr121-l_nmbb067
            CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa016,l_nmcr.nmcr122,2)
                 RETURNING g_sub_success,g_errno,l_nmcr.nmcr122
         END IF
      END IF
      
      IF l_glaa.glaa019 = 'Y' THEN
         #來源幣別
         IF l_glaa.glaa021 = '1' THEN 
            LET l_ooam003 = l_nmcq.nmcq100
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = l_glaa.glaa001               #帳套使用幣別
         END IF
         #主帳套本位幣三匯率
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',l_glaald,l_nmcq.nmcqdocdt,l_ooam003,
                                   #目的幣別; 交易金額; 匯類類型
                                   l_glaa.glaa020,0,l_glaa.glaa022)
              RETURNING l_nmcr.nmcr131
        #CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa020,l_nmcr.nmcr131,3) #160822-00018#1 mark
         CALL s_curr_round_ld('1',l_glaald,l_ooam003,l_nmcr.nmcr131,3)      #160822-00018#1
              RETURNING g_sub_success,g_errno,l_nmcr.nmcr131
         IF l_glaa.glaa021 = '1' THEN #原幣
            LET l_nmcr.nmcr132 = l_nmcr.nmcr103 * l_nmcr.nmcr131-l_nmbb068
            CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa020,l_nmcr.nmcr132,2)
                 RETURNING g_sub_success,g_errno,l_nmcr.nmcr132
         ELSE #本幣
            LET l_nmcr.nmcr132 = l_nmcr.nmcr113 * l_nmcr.nmcr131-l_nmbb068
            CALL s_curr_round_ld('1',l_glaald,l_glaa.glaa020,l_nmcr.nmcr132,2)
                 RETURNING g_sub_success,g_errno,l_nmcr.nmcr132
         END IF
      END IF

      #給0
      IF cl_null(l_nmcr.nmcr103)THEN LET l_nmcr.nmcr103=0 END IF
      IF cl_null(l_nmcr.nmcr104)THEN LET l_nmcr.nmcr104=0 END IF
      IF cl_null(l_nmcr.nmcr105)THEN LET l_nmcr.nmcr105=0 END IF
      IF cl_null(l_nmcr.nmcr106)THEN LET l_nmcr.nmcr106=0 END IF
      IF cl_null(l_nmcr.nmcr107)THEN LET l_nmcr.nmcr107=0 END IF
      IF cl_null(l_nmcr.nmcr113)THEN LET l_nmcr.nmcr113=0 END IF
      IF cl_null(l_nmcr.nmcr114)THEN LET l_nmcr.nmcr114=0 END IF
      IF cl_null(l_nmcr.nmcr115)THEN LET l_nmcr.nmcr115=0 END IF
      IF cl_null(l_nmcr.nmcr116)THEN LET l_nmcr.nmcr116=0 END IF
      IF cl_null(l_nmcr.nmcr117)THEN LET l_nmcr.nmcr117=0 END IF
      IF cl_null(l_nmcr.nmcr118)THEN LET l_nmcr.nmcr118=0 END IF
      IF cl_null(l_nmcr.nmcr121)THEN LET l_nmcr.nmcr121=0 END IF
      IF cl_null(l_nmcr.nmcr122)THEN LET l_nmcr.nmcr122=0 END IF
      IF cl_null(l_nmcr.nmcr131)THEN LET l_nmcr.nmcr131=0 END IF
      IF cl_null(l_nmcr.nmcr132)THEN LET l_nmcr.nmcr132=0 END IF
      
      INSERT INTO nmcr_t(nmcrent,nmcrcomp,nmcrdocno,nmcrseq,nmcrorga,
                         nmcr001,nmcr002,nmcr003,nmcr004,nmcr005,
                         nmcr006,nmcr007,nmcr008,nmcr100,nmcr101,
                         nmcr103,nmcr104,nmcr105,nmcr106,nmcr107,
                         nmcr113,nmcr114,nmcr115,nmcr116,nmcr117,
                         nmcr118,nmcr121,nmcr122,nmcr131,nmcr132)
             VALUES(l_nmcr.nmcrent,l_nmcr.nmcrcomp,l_nmcr.nmcrdocno,l_nmcr.nmcrseq,l_nmcr.nmcrorga,
                    l_nmcr.nmcr001,l_nmcr.nmcr002,l_nmcr.nmcr003,l_nmcr.nmcr004,l_nmcr.nmcr005,
                    l_nmcr.nmcr006,l_nmcr.nmcr007,l_nmcr.nmcr008,l_nmcr.nmcr100,l_nmcr.nmcr101,
                    l_nmcr.nmcr103,l_nmcr.nmcr104,l_nmcr.nmcr105,l_nmcr.nmcr106,l_nmcr.nmcr107,
                    l_nmcr.nmcr113,l_nmcr.nmcr114,l_nmcr.nmcr115,l_nmcr.nmcr116,l_nmcr.nmcr117,
                    l_nmcr.nmcr118,l_nmcr.nmcr121,l_nmcr.nmcr122,l_nmcr.nmcr131,l_nmcr.nmcr132)
      IF SQLCA.SQLERRD[3] = 0 THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'ins_nmci'
         CALL cl_err()
         LET r_success = FALSE
      #150807-00007#1 add ------
      ELSE
         IF l_nmcq.nmcq001 ='8' THEN
            #如果是兌現，需寫入一筆anmt540的現金變動碼檔
            CALL anmt450_01_ins_glbc_520(l_nmcr.nmcrcomp,l_nmcr.nmcrdocno,l_nmcr.nmcrseq,l_nmcq.nmcqdocdt)
                 RETURNING g_sub_success
         END IF
      #150807-00007#1 add end---
      END IF
   END FOREACH
        
   RETURN r_success        
END FUNCTION

################################################################################
# Descriptions...: 產生現金變動碼檔(from anmt450)
# Memo...........: #150807-00007#1
# Usage..........: CALL anmt450_01_ins_glbc_450()
# Date & Author..: 2015/08/12 By Reanna
# Modify.........:
################################################################################
PUBLIC FUNCTION anmt450_01_ins_glbc_450(p_comp,p_docno,p_seq,p_docdt)
DEFINE p_comp        LIKE nmch_t.nmchcomp
DEFINE p_docno       LIKE nmch_t.nmchdocno
DEFINE p_seq         LIKE nmci_t.nmciseq
DEFINE p_docdt       LIKE nmch_t.nmchdocdt
DEFINE l_nmchstus    LIKE nmch_t.nmchstus    #151013-00016#6
DEFINE l_sql         STRING
#161128-00061#2---modify----begin----------
#DEFINE l_glbc        RECORD LIKE glbc_t.*
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企業編號
       glbcld LIKE glbc_t.glbcld, #帳套
       glbccomp LIKE glbc_t.glbccomp, #營運據點
       glbcdocno LIKE glbc_t.glbcdocno, #傳票編號
       glbcseq LIKE glbc_t.glbcseq, #項次
       glbcseq1 LIKE glbc_t.glbcseq1, #序號
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期別
       glbc003 LIKE glbc_t.glbc003, #借貸別
       glbc004 LIKE glbc_t.glbc004, #現金變動碼
       glbc005 LIKE glbc_t.glbc005, #關係人
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbc015 LIKE glbc_t.glbc015  #狀態碼
       END RECORD

#161128-00061#2---modify----end----------
DEFINE l_nmci        RECORD
                        nmci003   LIKE nmci_t.nmci003,
                        nmci100   LIKE nmci_t.nmci100,
                        nmci101   LIKE nmci_t.nmci101,
                        nmci103   LIKE nmci_t.nmci103,
                        nmci113   LIKE nmci_t.nmci113,
                        nmci121   LIKE nmci_t.nmci121,
                        nmci131   LIKE nmci_t.nmci131,
                        nmci009   LIKE nmci_t.nmci009,  #160524-00055#2
                        nmci105   LIKE nmci_t.nmci105,  #161104-00047#1 add
                        nmci115   LIKE nmci_t.nmci115   #161104-00047#1 add
                     END RECORD
DEFINE l_glaa        RECORD
                        glaald    LIKE glaa_t.glaald,
                        glaa015   LIKE glaa_t.glaa015,
                        glaa016   LIKE glaa_t.glaa016,
                        glaa017   LIKE glaa_t.glaa017,
                        glaa019   LIKE glaa_t.glaa019,
                        glaa020   LIKE glaa_t.glaa020,
                        glaa021   LIKE glaa_t.glaa021,  #160107 add ,
                        glaa003   LIKE glaa_t.glaa003   #160107
                     END RECORD
DEFINE l_nmck005     LIKE nmck_t.nmck005
DEFINE l_nmck010     LIKE nmck_t.nmck010
DEFINE r_success     LIKE type_t.num5
DEFINE l_nmck004     LIKE nmck_t.nmck004  #160524-00055#2
DEFINE l_nmck044     LIKE nmck_t.nmck044  #160524-00055#2
DEFINE l_nmck049     LIKE nmck_t.nmck049  #160524-00055#2
DEFINE l_nmck029     LIKE nmck_t.nmck029  #160524-00055#2
DEFINE l_nmck029_t   LIKE nmck_t.nmck029  #160524-00055#2
#160107 add ------
DEFINE l_flag        LIKE type_t.chr1
DEFINE l_errno       LIKE type_t.chr100
DEFINE l_glav002     LIKE glav_t.glav002
DEFINE l_glav005     LIKE glav_t.glav005
DEFINE l_sdate_s     LIKE glav_t.glav004
DEFINE l_sdate_e     LIKE glav_t.glav004
DEFINE l_glav006     LIKE glav_t.glav006
DEFINE l_pdate_s     LIKE glav_t.glav004
DEFINE l_pdate_e     LIKE glav_t.glav004
DEFINE l_glav007     LIKE glav_t.glav007
DEFINE l_wdate_s     LIKE glav_t.glav004
DEFINE l_wdate_e     LIKE glav_t.glav004
#160107 add end---

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #151013-00016#6---s
   SELECT nmchstus INTO l_nmchstus
     FROM nmch_t
    WHERE nmchent = g_enterprise
      AND nmchcomp = p_comp
      AND nmchdocno = p_docno
   #151013-00016#6---e
   
   #160107 add glaa003(會計週期參照表)
   SELECT glaald,glaa015,glaa016,glaa017,glaa019,
          glaa020,glaa021,glaa003
     INTO l_glaa.glaald,l_glaa.glaa015,l_glaa.glaa016,l_glaa.glaa017,l_glaa.glaa019,
          l_glaa.glaa020,l_glaa.glaa021,l_glaa.glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_comp
      AND glaa014 = 'Y'
   
   LET l_sql = " SELECT nmci003,nmci100,nmci101,nmci103,nmci113,",
               "        nmci121,nmci131,nmci009, ",  #160524-00055#2 add nmci009
               "        nmci105,nmci115 ",           #161104-00047#1 add               
               "   FROM nmci_t ",
               "  WHERE nmcient = ",g_enterprise,
               "    AND nmcicomp = '",p_comp,"'",
               "    AND nmcidocno = '",p_docno,"'",
               "    AND nmciseq = '",p_seq,"'"
   PREPARE anmt450_01_glbc_pb FROM l_sql
   EXECUTE anmt450_01_glbc_pb INTO l_nmci.nmci003,l_nmci.nmci100,l_nmci.nmci101,l_nmci.nmci103,l_nmci.nmci113,
                                   l_nmci.nmci121,l_nmci.nmci131,l_nmci.nmci009, #160524-00055#2 add nmci009
                                   l_nmci.nmci105,l_nmci.nmci115 #161104-00047#1 add 
   
   LET l_glbc.glbcent   = g_enterprise
   LET l_glbc.glbcld    = l_glaa.glaald
   LET l_glbc.glbccomp  = p_comp
   LET l_glbc.glbcdocno = p_docno
   LET l_glbc.glbcseq   = p_seq
   LET l_glbc.glbcseq1  = 1
   #LET l_glbc.glbc001   = YEAR(p_docdt)   #160107 mark
   #LET l_glbc.glbc002   = MONTH(p_docdt)  #160107 mark
   #160107 add ------
   #依單據日期取得會計年度&期別
   CALL s_get_accdate(l_glaa.glaa003,p_docdt,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   LET l_glbc.glbc001   = l_glav002
   LET l_glbc.glbc002   = l_glav006
   #160107 add end---
   LET l_glbc.glbc003   = '2'

   SELECT nmck005,nmck010,
          nmck044,nmck004,nmck049,nmck029    #160524-00055#2
     INTO l_nmck005,l_nmck010,
          l_nmck044,l_nmck004,l_nmck049,l_nmck029 #160524-00055#2
     FROM nmck_t
    WHERE nmckent = g_enterprise
      AND nmckcomp = p_comp
      AND nmckdocno = l_nmci.nmci003
   #現金變動碼
   LET l_glbc.glbc004   = l_nmck010
   #付款對象
   LET l_glbc.glbc005   = l_nmck005
   LET l_glbc.glbc006   = l_nmci.nmci100
   LET l_glbc.glbc007   = l_nmci.nmci101
   #160524-00055#1 add s---
   LET l_nmck029_t = 0   
   IF l_nmci.nmci009 = 'Y' AND l_nmck004 != l_nmck044 THEN
      LET l_nmck029_t = l_nmck029  
   END IF   
   #160524-00055#1 add e--- 
#161104-00047#1 mod s---   
#   LET l_glbc.glbc008   = l_nmci.nmci103 -  l_nmck029_t    #160524-00055#1 l_nmck029_t
#   LET l_glbc.glbc009   = l_nmci.nmci113 -  l_nmck029_t    #160524-00055#1 l_nmck029_t
   LET l_glbc.glbc008   = l_nmci.nmci103 -  l_nmck029_t + l_nmci.nmci105   #160524-00055#1 l_nmck029_t
   LET l_glbc.glbc009   = l_nmci.nmci113 -  l_nmck029_t + l_nmci.nmci105   #160524-00055#1 l_nmck029_t
#161104-00047#1 mod e---   
   LET l_glbc.glbc010   ='2' 
  
   #以下視主帳套有無啟用本位幣
   IF l_glaa.glaa015 = 'Y' THEN 
      LET l_glbc.glbc011 = l_nmci.nmci121
      IF l_glaa.glaa017 = '1' THEN #原幣
         LET l_glbc.glbc012 = l_glbc.glbc008 * l_nmci.nmci121
      ELSE #本幣
         LET l_glbc.glbc012 = l_glbc.glbc009 * l_nmci.nmci121
      END IF
      CALL s_curr_round_ld('1',l_glaa.glaald,l_glaa.glaa016,l_glbc.glbc012,2)
           RETURNING g_sub_success,g_errno,l_glbc.glbc012
   END IF
   IF l_glaa.glaa019 = 'Y' THEN 
      LET l_glbc.glbc013 = l_nmci.nmci131
      IF l_glaa.glaa021='1' THEN
         LET l_glbc.glbc014 = l_glbc.glbc008 * l_nmci.nmci131
      ELSE
         LET l_glbc.glbc014 = l_glbc.glbc009 * l_nmci.nmci131
      END IF
      CALL s_curr_round_ld('1',l_glaa.glaald,l_glaa.glaa020,l_glbc.glbc014,2)
           RETURNING g_sub_success,g_errno,l_glbc.glbc014
   END IF
   
   LET l_glbc.glbc015   = l_nmchstus      #151013-00016#6
   

   #161128-00061#2---modify----begin----------
   #INSERT INTO glbc_t VALUES(l_glbc.*)
   INSERT INTO glbc_t (glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc003,glbc004,
                       glbc005,glbc006,glbc007,glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014,glbc015)
    VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
           l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,l_glbc.glbc015)
   #161128-00061#2---modify----end----------
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
   END IF
   
   #160524-00055#1 add s----
   IF l_nmci.nmci009 = 'Y' AND l_nmck004 != l_nmck044 THEN  
      LET l_glbc.glbc004 = l_nmck010  #取保证金账户的变动码
      LET l_glbc.glbcseq1  = 2
      LET l_glbc.glbc008   = l_nmck029    
      LET l_glbc.glbc009   = l_nmck029  
    #以下視主帳套有無啟用本位幣
    IF l_glaa.glaa015 = 'Y' THEN 
       LET l_glbc.glbc011 = l_nmci.nmci121
       IF l_glaa.glaa017 = '1' THEN #原幣
          LET l_glbc.glbc012 = l_glbc.glbc008 * l_nmci.nmci121
       ELSE #本幣
          LET l_glbc.glbc012 = l_glbc.glbc009 * l_nmci.nmci121
       END IF
       CALL s_curr_round_ld('1',l_glaa.glaald,l_glaa.glaa016,l_glbc.glbc012,2)
            RETURNING g_sub_success,g_errno,l_glbc.glbc012
    END IF
    IF l_glaa.glaa019 = 'Y' THEN 
       LET l_glbc.glbc013 = l_nmci.nmci131
       IF l_glaa.glaa021='1' THEN
          LET l_glbc.glbc014 = l_glbc.glbc008 * l_nmci.nmci131
       ELSE
          LET l_glbc.glbc014 = l_glbc.glbc009 * l_nmci.nmci131
       END IF
       CALL s_curr_round_ld('1',l_glaa.glaald,l_glaa.glaa020,l_glbc.glbc014,2)
            RETURNING g_sub_success,g_errno,l_glbc.glbc014
    END IF      
       #161128-00061#2---modify----begin----------
       #INSERT INTO glbc_t VALUES(l_glbc.*)
       INSERT INTO glbc_t (glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc003,glbc004,
                           glbc005,glbc006,glbc007,glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014,glbc015)
        VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
               l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,l_glbc.glbc015)
       #161128-00061#2---modify----end----------
       IF SQLCA.sqlcode THEN
          LET r_success = FALSE
       END IF   
    END IF
    #160524-00055#1 add e----
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生現金變動碼檔(from anmt510/anmt540)
# Memo...........: #150807-00007#1
# Usage..........: CALL anmt450_01_ins_glbc_520()
# Date & Author..: 2015/08/15 By Reanna
# Modify.........:
################################################################################
PUBLIC FUNCTION anmt450_01_ins_glbc_520(p_comp,p_docno,p_seq,p_docdt)
DEFINE p_comp        LIKE nmcq_t.nmcqcomp
DEFINE p_docno       LIKE nmcq_t.nmcqdocno
DEFINE p_seq         LIKE nmcr_t.nmcrseq
DEFINE p_docdt       LIKE nmcq_t.nmcqdocdt
DEFINE l_nmcqstus    LIKE nmcq_t.nmcqstus    #151013-00016#6
DEFINE l_sql         STRING
#161128-00061#2---modify----begin----------
#DEFINE l_glbc        RECORD LIKE glbc_t.*
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企業編號
       glbcld LIKE glbc_t.glbcld, #帳套
       glbccomp LIKE glbc_t.glbccomp, #營運據點
       glbcdocno LIKE glbc_t.glbcdocno, #傳票編號
       glbcseq LIKE glbc_t.glbcseq, #項次
       glbcseq1 LIKE glbc_t.glbcseq1, #序號
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期別
       glbc003 LIKE glbc_t.glbc003, #借貸別
       glbc004 LIKE glbc_t.glbc004, #現金變動碼
       glbc005 LIKE glbc_t.glbc005, #關係人
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbc015 LIKE glbc_t.glbc015  #狀態碼
       END RECORD

#161128-00061#2---modify----end----------
DEFINE l_nmcr        RECORD
                        nmcr001   LIKE nmcr_t.nmcr001,
                        nmcr003   LIKE nmcr_t.nmcr003,
                        nmcr100   LIKE nmcr_t.nmcr100,
                        nmcr101   LIKE nmcr_t.nmcr101,
                        nmcr103   LIKE nmcr_t.nmcr103,
                        nmcr113   LIKE nmcr_t.nmcr113,
                        nmcr121   LIKE nmcr_t.nmcr121,
                        nmcr131   LIKE nmcr_t.nmcr131,
                        nmcr106   LIKE nmcr_t.nmcr106,  #151222-00010#6
                        nmcr116   LIKE nmcr_t.nmcr116   #151222-00010#6 
                     END RECORD
DEFINE l_glaa        RECORD
                        glaald    LIKE glaa_t.glaald,
                        glaa015   LIKE glaa_t.glaa015,
                        glaa016   LIKE glaa_t.glaa016,
                        glaa017   LIKE glaa_t.glaa017,
                        glaa019   LIKE glaa_t.glaa019,
                        glaa020   LIKE glaa_t.glaa020,
                        glaa021   LIKE glaa_t.glaa021,  #160107 add ,
                        glaa003   LIKE glaa_t.glaa003   #160107
                     END RECORD
DEFINE l_nmbb010     LIKE nmbb_t.nmbb010
DEFINE l_nmbb026     LIKE nmbb_t.nmbb026
DEFINE r_success     LIKE type_t.num5
DEFINE l_nmcq001     LIKE nmcq_t.nmcq001  #151222-00010#6
#160107 add ------
DEFINE l_flag        LIKE type_t.chr1
DEFINE l_errno       LIKE type_t.chr100
DEFINE l_glav002     LIKE glav_t.glav002
DEFINE l_glav005     LIKE glav_t.glav005
DEFINE l_sdate_s     LIKE glav_t.glav004
DEFINE l_sdate_e     LIKE glav_t.glav004
DEFINE l_glav006     LIKE glav_t.glav006
DEFINE l_pdate_s     LIKE glav_t.glav004
DEFINE l_pdate_e     LIKE glav_t.glav004
DEFINE l_glav007     LIKE glav_t.glav007
DEFINE l_wdate_s     LIKE glav_t.glav004
DEFINE l_wdate_e     LIKE glav_t.glav004
#160107 add end---

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #151013-00016#6---s
   SELECT nmcqstus,nmcq001 INTO l_nmcqstus,l_nmcq001    #151222-00010#6 add nmcq001
     FROM nmcq_t
    WHERE nmcqent = g_enterprise
      AND nmcqcomp = p_comp
      AND nmcqdocno = p_docno
   #151013-00016#6---e
   
   #160107 add glaa003(會計週期參照表)
   SELECT glaald,glaa015,glaa016,glaa017,glaa019,
          glaa020,glaa021,glaa003
     INTO l_glaa.glaald,l_glaa.glaa015,l_glaa.glaa016,l_glaa.glaa017,l_glaa.glaa019,
          l_glaa.glaa020,l_glaa.glaa021,l_glaa.glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_comp
      AND glaa014 = 'Y'
   
   LET l_sql = " SELECT nmcr001,nmcr003,nmcr100,nmcr101,nmcr103,",
               "        nmcr113,nmcr121,nmcr131,nmcr106,nmcr116 ",  #151222-00010#6 add nmcr106,nmcr116 
               "   FROM nmcr_t ",
               "  WHERE nmcrent = ",g_enterprise,
               "    AND nmcrcomp = '",p_comp,"'",
               "    AND nmcrdocno = '",p_docno,"'",
               "    AND nmcrseq = '",p_seq,"'"
   PREPARE anmt520_01_glbc_pb FROM l_sql
   EXECUTE anmt520_01_glbc_pb INTO l_nmcr.nmcr001,l_nmcr.nmcr003,l_nmcr.nmcr100,l_nmcr.nmcr101,l_nmcr.nmcr103,
                                   l_nmcr.nmcr113,l_nmcr.nmcr121,l_nmcr.nmcr131,l_nmcr.nmcr106,l_nmcr.nmcr116 #151222-00010#6 add nmcr106,nmcr116 
   
   LET l_glbc.glbcent   = g_enterprise
   LET l_glbc.glbcld    = l_glaa.glaald
   LET l_glbc.glbccomp  = p_comp
   LET l_glbc.glbcdocno = p_docno
   LET l_glbc.glbcseq   = p_seq
   #LET l_glbc.glbc001   = YEAR(p_docdt)  #160107 mark
   #LET l_glbc.glbc002   = MONTH(p_docdt) #160107 mark
   #160107 add ------
   #依單據日期取得會計年度&期別
   CALL s_get_accdate(l_glaa.glaa003,p_docdt,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   LET l_glbc.glbc001   = l_glav002
   LET l_glbc.glbc002   = l_glav006
   #160107 add end---
   LET l_glbc.glbcseq1  = 1
   LET l_glbc.glbc003   = '1'
   #支票資料
   SELECT nmbb010,nmbb026 INTO l_nmbb010,l_nmbb026
     FROM nmba_t
     LEFT JOIN nmbb_t ON nmbaent=nmbbent AND nmbacomp=nmbbcomp AND nmbadocno=nmbbdocno
    WHERE nmbbent=g_enterprise
      AND nmbb029 = '30'
      AND nmbacomp = p_comp
      AND nmbadocno = l_nmcr.nmcr003
      AND nmbb030 = l_nmcr.nmcr001
      AND (nmbb069 = 'N' OR nmbb069 IS NULL)
   #現金變動碼
   LET l_glbc.glbc004   = l_nmbb010
   #付款對象
   LET l_glbc.glbc005   = l_nmbb026
   LET l_glbc.glbc006   = l_nmcr.nmcr100
   LET l_glbc.glbc007   = l_nmcr.nmcr101
   
   #151222-00010#6---add--str
#   #兌現
#   LET l_glbc.glbc008   = l_nmcr.nmcr103
#   LET l_glbc.glbc009   = l_nmcr.nmcr113
   #IF l_nmcq001='4' THEN #托收     #170207-00022#1 mark lujh
      LET l_glbc.glbc008   = l_nmcr.nmcr106
      LET l_glbc.glbc009   = l_nmcr.nmcr116
   #170207-00022#1--mark--str--lujh
   #ELSE #兌現
   #   LET l_glbc.glbc008   = l_nmcr.nmcr103
   #   LET l_glbc.glbc009   = l_nmcr.nmcr113
   #END IF
   #170207-00022#1--mark--end--lujh
   #151222-00010#6---add--end
   
   
   LET l_glbc.glbc010   ='2'
   #--以下視主帳套有無啟用本位幣
   IF l_glaa.glaa015 = 'Y' THEN
      LET l_glbc.glbc011 = l_nmcr.nmcr121
      IF l_glaa.glaa017 = '1' THEN #原幣
         LET l_glbc.glbc012 = l_glbc.glbc008 * l_nmcr.nmcr121
      ELSE #本幣
         LET l_glbc.glbc012 = l_glbc.glbc009 * l_nmcr.nmcr121
      END IF
      CALL s_curr_round_ld('1',l_glaa.glaald,l_glaa.glaa016,l_glbc.glbc012,2)
           RETURNING g_sub_success,g_errno,l_glbc.glbc012
   END IF
   IF l_glaa.glaa019 = 'Y' THEN
      LET l_glbc.glbc013 = l_nmcr.nmcr131
      IF l_glaa.glaa021='1' THEN
         LET l_glbc.glbc014 = l_glbc.glbc008 * l_nmcr.nmcr131
      ELSE
         LET l_glbc.glbc014 = l_glbc.glbc009 * l_nmcr.nmcr131
      END IF
      CALL s_curr_round_ld('1',l_glaa.glaald,l_glaa.glaa020,l_glbc.glbc014,2)
           RETURNING g_sub_success,g_errno,l_glbc.glbc014
   END IF
   
   LET l_glbc.glbc015   = l_nmcqstus      #151013-00016#6
   #161128-00061#2---modify----begin----------
   #INSERT INTO glbc_t VALUES(l_glbc.*)
   INSERT INTO glbc_t (glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc003,glbc004,
                       glbc005,glbc006,glbc007,glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014,glbc015)
    VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
           l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,l_glbc.glbc015)
   #161128-00061#2---modify----end----------
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
