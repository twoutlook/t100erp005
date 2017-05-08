#該程式已解開Section, 不再透過樣板產出!
{<section id="asft339_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000019
#+ 
#+ Filename...: asft339_01
#+ Description: ...
#+ Creator....: 00537(2014/07/09)
#+ Modifier...: 00537(2014/07/09)
#+ Buildtype..: 應用 c01b 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="asft339_01.global" >}
#161109-00085#32 2016/11/14 By lienjunqi 整批調整系統星號寫法
#161109-00085#62 2016/11/30 By 08171     整批調整系統星號寫法
#170102-00008#1  2017/1/3   By liqma     加入語句WHENEVER ERROR CONTINUE，防止出現sql等錯誤時程序down掉
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_inba_m        RECORD
       inbadocno LIKE inba_t.inbadocno, 
   inbadocno_desc LIKE type_t.chr80, 
   sfdadocno LIKE type_t.chr20, 
   sfdadocno_desc LIKE type_t.chr80
       END RECORD
DEFINE g_inba_m        type_g_inba_m
 
   DEFINE g_inbadocno_t LIKE inba_t.inbadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_flag          LIKE type_t.num5     #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
DEFINE g_sfjadocno     LIKE sfja_t.sfjadocno
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="asft339_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION asft339_01(--)
   #add-point:input段變數傳入
   p_sfjadocno
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define
   DEFINE p_sfjadocno     LIKE sfja_t.sfjadocno
   DEFINE l_sfjastus      LIKE sfja_t.sfjastus
   DEFINE l_sfja004       LIKE sfja_t.sfja004
   DEFINE l_sfja005       LIKE sfja_t.sfja005
   DEFINE l_inbastus      LIKE inba_t.inbastus
   DEFINE l_sfdastus      LIKE sfda_t.sfdastus
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CONTINUE             #170102-00008#1   add
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft339_01 WITH FORM cl_ap_formpath("asf","asft339_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理
   LET g_today = cl_get_today()
   LET g_argv[1] = p_sfjadocno 
   LET g_sfjadocno = p_sfjadocno
   SELECT sfja004,sfja005,sfjastus INTO l_sfja004,l_sfja005,l_sfjastus
     FROM sfja_t
    WHERE sfjaent   = g_enterprise
      AND sfjasite  = g_site
      AND sfjadocno = p_sfjadocno
   IF l_sfjastus NOT MATCHES '[S]' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00398'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE WINDOW w_asft339_01 
      RETURN
   END IF

   #产生过的，提示下不产生了，记得要set no entry，都产生过了，提示下就return吧
   IF l_sfja004 IS NULL AND l_sfja005 IS NULL THEN
      LET g_flag = 0 #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
      #不能两种单身资料都没有
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND (sfjc010   = '2' OR sfjc010   = '3')
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00405'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE WINDOW w_asft339_01 
         RETURN
      END IF

      #检查单身是否有杂收资料，若没有，不用产生
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '2'  #2.报废转杂收
      IF l_cnt = 0 THEN
         LET g_flag = 1 #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
         CALL cl_set_comp_entry("inbadocno",FALSE)
      END IF
      #检查单身是否有退料资料，若没有，不用产生
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '3'  #3.不良品退料
      IF l_cnt = 0 THEN
         LET g_flag = 2 #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
         CALL cl_set_comp_entry("sfdadocno",FALSE)
      END IF
   END IF
   
   IF l_sfja004 IS NOT NULL AND l_sfja005 IS NULL THEN
      #已有杂收单，此类单据不可重复产生！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00362'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL cl_set_comp_entry("inbadocno",FALSE)
      LET g_inba_m.inbadocno = l_sfja004
      LET g_flag = 1 #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
      #检查单身是否有退料资料，若没有，不用产生
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '3'   #3.不良品退料
      
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00402'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE WINDOW w_asft339_01 
         RETURN
      END IF
   END IF
   IF l_sfja005 IS NOT NULL AND l_sfja004 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00363'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL cl_set_comp_entry("sfdadocno",FALSE)
      LET g_inba_m.sfdadocno = l_sfja005
      LET g_flag = 2 #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
      #检查单身是否有杂收资料，若没有，不用产生
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '2'   #2.报废转杂收
      
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE WINDOW w_asft339_01 
         RETURN
      END IF
   END IF
   IF l_sfja005 IS NOT NULL AND l_sfja004 IS NOT NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00364'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE WINDOW w_asft339_01
      RETURN
   END IF
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_inba_m.inbadocno,g_inba_m.sfdadocno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理

         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理
            SELECT ooef004 INTO l_ooef004 
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               
            IF g_inba_m.inbadocno IS NULL AND l_ooef004 IS NOT NULL THEN
               SELECT COUNT(ooba002) INTO l_cnt
                 FROM ooba_t
                 WHERE oobaent = g_enterprise 
                   AND ooba002  IN (SELECT oobl001 FROM oobl_t WHERE  ooblent = g_enterprise  AND oobl002 = 'aint302' ) 
                   AND oobastus = 'Y' 
                   AND ooba001  = l_ooef004
               IF l_cnt = 1 THEN
                  SELECT ooba002 INTO g_inba_m.inbadocno
                    FROM ooba_t
                    WHERE oobaent = g_enterprise 
                      AND ooba002  IN (SELECT oobl001 FROM oobl_t WHERE  ooblent = g_enterprise  AND oobl002 = 'aint302' ) 
                      AND oobastus = 'Y' 
                      AND ooba001  = l_ooef004               
               END IF
            END IF
            IF g_inba_m.sfdadocno IS NULL AND l_ooef004 IS NOT NULL THEN
               SELECT COUNT(ooba002) INTO l_cnt
                 FROM ooba_t
                 WHERE oobaent = g_enterprise 
                   AND ooba002  IN (SELECT oobl001 FROM oobl_t WHERE  ooblent = g_enterprise  AND oobl002 = 'asft323' ) 
                   AND oobastus = 'Y' 
                   AND ooba001  = l_ooef004
               IF l_cnt = 1 THEN
                  SELECT ooba002 INTO g_inba_m.sfdadocno
                    FROM ooba_t
                    WHERE oobaent = g_enterprise 
                      AND ooba002  IN (SELECT oobl001 FROM oobl_t WHERE  ooblent = g_enterprise  AND oobl002 = 'aint302' ) 
                      AND oobastus = 'Y' 
                      AND ooba001  = l_ooef004               
               END IF
            END IF
            #现在写成默认带主画面的，如果有就带出来
            #还要写如果没有就检查2个单别是不是唯一的单别，是的话就带出来
            #end add-point
          
                  #此段落由子樣板a02產生
         AFTER FIELD inbadocno
            
            #add-point:AFTER FIELD inbadocno

            #此段落由子樣板a05產生
            IF NOT cl_null(g_inba_m.inbadocno) THEN
#有单别检查单别，是完整单号检查完整单号，传入完整单号的话，会截取单别做单别合法性检查               
               IF NOT s_aooi200_chk_docno(g_site,g_inba_m.inbadocno,g_today,'aint302') THEN
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_inba_m.inbadocno_desc = s_aooi200_get_slip_desc(g_inba_m.inbadocno)
            DISPLAY BY NAME g_inba_m.inbadocno_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD inbadocno
            #add-point:BEFORE FIELD inbadocno

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE inbadocno
            #add-point:ON CHANGE inbadocno

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfdadocno
            
            #add-point:AFTER FIELD sfdadocno
            IF NOT cl_null(g_inba_m.sfdadocno) THEN
#有单别检查单别，是完整单号检查完整单号，传入完整单号的话，会截取单别做单别合法性检查               
               IF NOT s_aooi200_chk_docno(g_site,g_inba_m.sfdadocno,g_today,'asft323') THEN
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_inba_m.sfdadocno_desc = s_aooi200_get_slip_desc(g_inba_m.sfdadocno)
            DISPLAY BY NAME g_inba_m.sfdadocno_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfdadocno
            #add-point:BEFORE FIELD sfdadocno

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfdadocno
            #add-point:ON CHANGE sfdadocno

            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.inbadocno
         ON ACTION controlp INFIELD inbadocno
            #add-point:ON ACTION controlp INFIELD inbadocno
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inba_m.inbadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               
            LET g_qryparam.arg1 = l_ooef004          #
            LET g_qryparam.arg2 = 'aint302'      #
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_inba_m.inbadocno = g_qryparam.return1              

            DISPLAY g_inba_m.inbadocno TO inbadocno              #

            NEXT FIELD inbadocno                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.sfdadocno
         ON ACTION controlp INFIELD sfdadocno
            #add-point:ON ACTION controlp INFIELD sfdadocno
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inba_m.sfdadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               
            LET g_qryparam.arg1 = l_ooef004          #
            LET g_qryparam.arg2 = 'asft323'      #
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_inba_m.sfdadocno = g_qryparam.return1              

            DISPLAY g_inba_m.sfdadocno TO sfdadocno              #

            NEXT FIELD sfdadocno                          #返回原欄位


            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理
#都ok了，开始吧！
            CALL asft339_01_gen_inba_sfda()
            #end add-point
            
      END INPUT
    
      #add-point:自定義input

      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
#这里居然没有addpoint
         CALL asft339_01_gen_inba_sfda()
        
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
 
   #add-point:畫面關閉前

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asft339_01 
   
   #add-point:input段after input 

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asft339_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft339_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asft339_01_gen_inba_sfda()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_inbadocno   LIKE inba_t.inbadocno
   DEFINE l_sfdadocno   LIKE sfda_t.sfdadocno   
#检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN 
   END IF   

   CALL s_lot_ins_create_tmp()  
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/19 By shiun
   CALL s_transaction_begin()
   LET l_inbadocno = NULL
   LET l_sfdadocno = NULL
   IF g_flag = '0' THEN   #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
      CALL s_aooi200_gen_docno(g_site,g_inba_m.inbadocno,g_today,'aint302') RETURNING l_success,g_inba_m.inbadocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_inba_m.inbadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT asft339_01_ins_inba() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET l_inbadocno = g_inba_m.inbadocno
      CALL s_aooi200_gen_docno(g_site,g_inba_m.sfdadocno,g_today,'asft323') RETURNING l_success,g_inba_m.sfdadocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_inba_m.sfdadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT asft339_01_ins_sfda() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET l_sfdadocno = g_inba_m.sfdadocno
   END IF
   IF g_flag = '1' THEN  #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
      CALL s_aooi200_gen_docno(g_site,g_inba_m.sfdadocno,g_today,'asft323') RETURNING l_success,g_inba_m.sfdadocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_inba_m.sfdadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT asft339_01_ins_sfda() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET l_sfdadocno = g_inba_m.sfdadocno
   END IF
   IF g_flag = '2' THEN  #0:杂收单，退料单都是全新产生的 1:只产生退料 2：只产生杂收
      CALL s_aooi200_gen_docno(g_site,g_inba_m.inbadocno,g_today,'aint302') RETURNING l_success,g_inba_m.inbadocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_inba_m.inbadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT asft339_01_ins_inba() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET l_inbadocno = g_inba_m.inbadocno
   END IF
   CALL s_lot_ins_drop_tmp()
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   UPDATE sfja_t SET sfja004 = l_inbadocno,
                     sfja005 = l_sfdadocno
    WHERE sfjaent   = g_enterprise
      AND sfjasite  = g_site
      AND sfjadocno = g_sfjadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd sfja_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL s_transaction_end('Y','0')
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asft339_01_ins_inba()
   #161109-00085#32-s
   #DEFINE l_sfja      RECORD LIKE sfja_t.*
   #DEFINE l_sfjb      RECORD LIKE sfjb_t.*
   #DEFINE l_sfjc      RECORD LIKE sfjc_t.*
   DEFINE l_sfjc RECORD  #工單下階料報廢明細檔
          sfjcent LIKE sfjc_t.sfjcent, #企業編號
          sfjcsite LIKE sfjc_t.sfjcsite, #營運據點
          sfjcdocno LIKE sfjc_t.sfjcdocno, #報廢單號
          sfjcseq LIKE sfjc_t.sfjcseq, #項次
          sfjcseq1 LIKE sfjc_t.sfjcseq1, #項序
          sfjc001 LIKE sfjc_t.sfjc001, #工單單號
          sfjc002 LIKE sfjc_t.sfjc002, #工單項次
          sfjc003 LIKE sfjc_t.sfjc003, #料件編號
          sfjc004 LIKE sfjc_t.sfjc004, #產品特徵
          sfjc005 LIKE sfjc_t.sfjc005, #單位
          sfjc006 LIKE sfjc_t.sfjc006, #報廢數量
          sfjc007 LIKE sfjc_t.sfjc007, #參考單位
          sfjc008 LIKE sfjc_t.sfjc008, #參考數量
          sfjc009 LIKE sfjc_t.sfjc009, #理由碼
          sfjc010 LIKE sfjc_t.sfjc010, #預計處理方式
          sfjc011 LIKE sfjc_t.sfjc011, #庫位
          sfjc012 LIKE sfjc_t.sfjc012, #儲位
          sfjc013 LIKE sfjc_t.sfjc013, #批號
          sfjc014 LIKE sfjc_t.sfjc014, #庫存管理特徵
          sfjc015 LIKE sfjc_t.sfjc015, #工單項序
          #161109-00085#62 --s add
          sfjcud001 LIKE sfjc_t.sfjcud001, #自定義欄位(文字)001
          sfjcud002 LIKE sfjc_t.sfjcud002, #自定義欄位(文字)002
          sfjcud003 LIKE sfjc_t.sfjcud003, #自定義欄位(文字)003
          sfjcud004 LIKE sfjc_t.sfjcud004, #自定義欄位(文字)004
          sfjcud005 LIKE sfjc_t.sfjcud005, #自定義欄位(文字)005
          sfjcud006 LIKE sfjc_t.sfjcud006, #自定義欄位(文字)006
          sfjcud007 LIKE sfjc_t.sfjcud007, #自定義欄位(文字)007
          sfjcud008 LIKE sfjc_t.sfjcud008, #自定義欄位(文字)008
          sfjcud009 LIKE sfjc_t.sfjcud009, #自定義欄位(文字)009
          sfjcud010 LIKE sfjc_t.sfjcud010, #自定義欄位(文字)010
          sfjcud011 LIKE sfjc_t.sfjcud011, #自定義欄位(數字)011
          sfjcud012 LIKE sfjc_t.sfjcud012, #自定義欄位(數字)012
          sfjcud013 LIKE sfjc_t.sfjcud013, #自定義欄位(數字)013
          sfjcud014 LIKE sfjc_t.sfjcud014, #自定義欄位(數字)014
          sfjcud015 LIKE sfjc_t.sfjcud015, #自定義欄位(數字)015
          sfjcud016 LIKE sfjc_t.sfjcud016, #自定義欄位(數字)016
          sfjcud017 LIKE sfjc_t.sfjcud017, #自定義欄位(數字)017
          sfjcud018 LIKE sfjc_t.sfjcud018, #自定義欄位(數字)018
          sfjcud019 LIKE sfjc_t.sfjcud019, #自定義欄位(數字)019
          sfjcud020 LIKE sfjc_t.sfjcud020, #自定義欄位(數字)020
          sfjcud021 LIKE sfjc_t.sfjcud021, #自定義欄位(日期時間)021
          sfjcud022 LIKE sfjc_t.sfjcud022, #自定義欄位(日期時間)022
          sfjcud023 LIKE sfjc_t.sfjcud023, #自定義欄位(日期時間)023
          sfjcud024 LIKE sfjc_t.sfjcud024, #自定義欄位(日期時間)024
          sfjcud025 LIKE sfjc_t.sfjcud025, #自定義欄位(日期時間)025
          sfjcud026 LIKE sfjc_t.sfjcud026, #自定義欄位(日期時間)026
          sfjcud027 LIKE sfjc_t.sfjcud027, #自定義欄位(日期時間)027
          sfjcud028 LIKE sfjc_t.sfjcud028, #自定義欄位(日期時間)028
          sfjcud029 LIKE sfjc_t.sfjcud029, #自定義欄位(日期時間)029
          sfjcud030 LIKE sfjc_t.sfjcud030, #自定義欄位(日期時間)030
          #161109-00085#62 --e add
          sfjc016 LIKE sfjc_t.sfjc016, #生產料號
          sfjc017 LIKE sfjc_t.sfjc017, #BOM特性
          sfjc018 LIKE sfjc_t.sfjc018, #產品特徵
          sfjc019 LIKE sfjc_t.sfjc019  #生產計劃
   END RECORD
   #DEFINE l_inba      RECORD LIKE inba_t.*
   DEFINE l_inba RECORD  #雜項庫存異動單頭檔
          inbaent LIKE inba_t.inbaent, #企業編號
          inbasite LIKE inba_t.inbasite, #營運據點
          inbadocno LIKE inba_t.inbadocno, #單據編號
          inbadocdt LIKE inba_t.inbadocdt, #輸入日期
          inba001 LIKE inba_t.inba001, #單據類別
          inba002 LIKE inba_t.inba002, #扣帳日期
          inba003 LIKE inba_t.inba003, #申請人員
          inba004 LIKE inba_t.inba004, #申請部門
          inba005 LIKE inba_t.inba005, #來源資料類型
          inba006 LIKE inba_t.inba006, #來源單號
          inba007 LIKE inba_t.inba007, #理由碼
          inba008 LIKE inba_t.inba008, #備註
          inba009 LIKE inba_t.inba009, #保稅異動原因
          inba010 LIKE inba_t.inba010, #保稅進口報單
          inba011 LIKE inba_t.inba011, #保稅進口報單日期
          inbaownid LIKE inba_t.inbaownid, #資料所有者
          inbaowndp LIKE inba_t.inbaowndp, #資料所屬部門
          inbacrtid LIKE inba_t.inbacrtid, #資料建立者
          inbacrtdp LIKE inba_t.inbacrtdp, #資料建立部門
          inbacrtdt LIKE inba_t.inbacrtdt, #資料創建日
          inbamodid LIKE inba_t.inbamodid, #資料修改者
          inbamoddt LIKE inba_t.inbamoddt, #最近修改日
          inbacnfid LIKE inba_t.inbacnfid, #資料確認者
          inbacnfdt LIKE inba_t.inbacnfdt, #資料確認日
          inbapstid LIKE inba_t.inbapstid, #資料過帳者
          inbapstdt LIKE inba_t.inbapstdt, #資料過帳日
          inbastus LIKE inba_t.inbastus, #狀態碼
          #161109-00085#62 --s add
          inbaud001 LIKE inba_t.inbaud001, #自定義欄位(文字)001
          inbaud002 LIKE inba_t.inbaud002, #自定義欄位(文字)002
          inbaud003 LIKE inba_t.inbaud003, #自定義欄位(文字)003
          inbaud004 LIKE inba_t.inbaud004, #自定義欄位(文字)004
          inbaud005 LIKE inba_t.inbaud005, #自定義欄位(文字)005
          inbaud006 LIKE inba_t.inbaud006, #自定義欄位(文字)006
          inbaud007 LIKE inba_t.inbaud007, #自定義欄位(文字)007
          inbaud008 LIKE inba_t.inbaud008, #自定義欄位(文字)008
          inbaud009 LIKE inba_t.inbaud009, #自定義欄位(文字)009
          inbaud010 LIKE inba_t.inbaud010, #自定義欄位(文字)010
          inbaud011 LIKE inba_t.inbaud011, #自定義欄位(數字)011
          inbaud012 LIKE inba_t.inbaud012, #自定義欄位(數字)012
          inbaud013 LIKE inba_t.inbaud013, #自定義欄位(數字)013
          inbaud014 LIKE inba_t.inbaud014, #自定義欄位(數字)014
          inbaud015 LIKE inba_t.inbaud015, #自定義欄位(數字)015
          inbaud016 LIKE inba_t.inbaud016, #自定義欄位(數字)016
          inbaud017 LIKE inba_t.inbaud017, #自定義欄位(數字)017
          inbaud018 LIKE inba_t.inbaud018, #自定義欄位(數字)018
          inbaud019 LIKE inba_t.inbaud019, #自定義欄位(數字)019
          inbaud020 LIKE inba_t.inbaud020, #自定義欄位(數字)020
          inbaud021 LIKE inba_t.inbaud021, #自定義欄位(日期時間)021
          inbaud022 LIKE inba_t.inbaud022, #自定義欄位(日期時間)022
          inbaud023 LIKE inba_t.inbaud023, #自定義欄位(日期時間)023
          inbaud024 LIKE inba_t.inbaud024, #自定義欄位(日期時間)024
          inbaud025 LIKE inba_t.inbaud025, #自定義欄位(日期時間)025
          inbaud026 LIKE inba_t.inbaud026, #自定義欄位(日期時間)026
          inbaud027 LIKE inba_t.inbaud027, #自定義欄位(日期時間)027
          inbaud028 LIKE inba_t.inbaud028, #自定義欄位(日期時間)028
          inbaud029 LIKE inba_t.inbaud029, #自定義欄位(日期時間)029
          inbaud030 LIKE inba_t.inbaud030, #自定義欄位(日期時間)030
          #161109-00085#62 --e add
          inbaunit LIKE inba_t.inbaunit, #應用組織
          inba012 LIKE inba_t.inba012, #領用類型
          inba013 LIKE inba_t.inba013, #費用對象
          inba014 LIKE inba_t.inba014, #直接交款否
          inba015 LIKE inba_t.inba015, #庫位
          inba200 LIKE inba_t.inba200, #沖減方式
          inba201 LIKE inba_t.inba201, #管理品類
          inba202 LIKE inba_t.inba202, #來源作業
          inba203 LIKE inba_t.inba203, #管理品類
          inba204 LIKE inba_t.inba204, #供應商編號
          inba205 LIKE inba_t.inba205, #領用部門
          inba206 LIKE inba_t.inba206, #轉入庫位
          inba207 LIKE inba_t.inba207, #轉入管理品類
          inba208 LIKE inba_t.inba208  #返回
   END RECORD   
   #DEFINE l_inbb      RECORD LIKE inbb_t.*
   DEFINE l_inbb RECORD  #雜項庫存異動申請明細檔
          inbbent LIKE inbb_t.inbbent, #企業編號
          inbbsite LIKE inbb_t.inbbsite, #營運據點
          inbbdocno LIKE inbb_t.inbbdocno, #單據編號
          inbbseq LIKE inbb_t.inbbseq, #項次
          inbb001 LIKE inbb_t.inbb001, #料件編號
          inbb002 LIKE inbb_t.inbb002, #產品特徵
          inbb003 LIKE inbb_t.inbb003, #庫存管理特徵
          inbb004 LIKE inbb_t.inbb004, #包裝容器編號
          inbb007 LIKE inbb_t.inbb007, #庫位
          inbb008 LIKE inbb_t.inbb008, #限定儲位
          inbb009 LIKE inbb_t.inbb009, #限定批號
          inbb010 LIKE inbb_t.inbb010, #交易單位
          inbb011 LIKE inbb_t.inbb011, #申請數量
          inbb012 LIKE inbb_t.inbb012, #實際異動數量
          inbb013 LIKE inbb_t.inbb013, #參考單位
          inbb014 LIKE inbb_t.inbb014, #參考單位申請數量
          inbb015 LIKE inbb_t.inbb015, #參考單位實際數量
          inbb016 LIKE inbb_t.inbb016, #理由碼
          inbb017 LIKE inbb_t.inbb017, #來源單號
          inbb018 LIKE inbb_t.inbb018, #檢驗否
          inbb019 LIKE inbb_t.inbb019, #檢驗合格量
          inbb020 LIKE inbb_t.inbb020, #單據備註
          inbb021 LIKE inbb_t.inbb021, #存貨備註
          inbb022 LIKE inbb_t.inbb022, #有效日期
          #161109-00085#62 --s add
          inbbud001 LIKE inbb_t.inbbud001, #自定義欄位(文字)001
          inbbud002 LIKE inbb_t.inbbud002, #自定義欄位(文字)002
          inbbud003 LIKE inbb_t.inbbud003, #自定義欄位(文字)003
          inbbud004 LIKE inbb_t.inbbud004, #自定義欄位(文字)004
          inbbud005 LIKE inbb_t.inbbud005, #自定義欄位(文字)005
          inbbud006 LIKE inbb_t.inbbud006, #自定義欄位(文字)006
          inbbud007 LIKE inbb_t.inbbud007, #自定義欄位(文字)007
          inbbud008 LIKE inbb_t.inbbud008, #自定義欄位(文字)008
          inbbud009 LIKE inbb_t.inbbud009, #自定義欄位(文字)009
          inbbud010 LIKE inbb_t.inbbud010, #自定義欄位(文字)010
          inbbud011 LIKE inbb_t.inbbud011, #自定義欄位(數字)011
          inbbud012 LIKE inbb_t.inbbud012, #自定義欄位(數字)012
          inbbud013 LIKE inbb_t.inbbud013, #自定義欄位(數字)013
          inbbud014 LIKE inbb_t.inbbud014, #自定義欄位(數字)014
          inbbud015 LIKE inbb_t.inbbud015, #自定義欄位(數字)015
          inbbud016 LIKE inbb_t.inbbud016, #自定義欄位(數字)016
          inbbud017 LIKE inbb_t.inbbud017, #自定義欄位(數字)017
          inbbud018 LIKE inbb_t.inbbud018, #自定義欄位(數字)018
          inbbud019 LIKE inbb_t.inbbud019, #自定義欄位(數字)019
          inbbud020 LIKE inbb_t.inbbud020, #自定義欄位(數字)020
          inbbud021 LIKE inbb_t.inbbud021, #自定義欄位(日期時間)021
          inbbud022 LIKE inbb_t.inbbud022, #自定義欄位(日期時間)022
          inbbud023 LIKE inbb_t.inbbud023, #自定義欄位(日期時間)023
          inbbud024 LIKE inbb_t.inbbud024, #自定義欄位(日期時間)024
          inbbud025 LIKE inbb_t.inbbud025, #自定義欄位(日期時間)025
          inbbud026 LIKE inbb_t.inbbud026, #自定義欄位(日期時間)026
          inbbud027 LIKE inbb_t.inbbud027, #自定義欄位(日期時間)027
          inbbud028 LIKE inbb_t.inbbud028, #自定義欄位(日期時間)028
          inbbud029 LIKE inbb_t.inbbud029, #自定義欄位(日期時間)029
          inbbud030 LIKE inbb_t.inbbud030, #自定義欄位(日期時間)030
          #161109-00085#62 --e add
          inbb200 LIKE inbb_t.inbb200, #商品條碼
          inbb201 LIKE inbb_t.inbb201, #包裝單位
          inbb202 LIKE inbb_t.inbb202, #申請包裝數量
          inbb203 LIKE inbb_t.inbb203, #實際包裝數量
          inbbunit LIKE inbb_t.inbbunit, #應用組織
          inbb204 LIKE inbb_t.inbb204, #製造日期
          inbb023 LIKE inbb_t.inbb023, #專案編號
          inbb024 LIKE inbb_t.inbb024, #WBS
          inbb025 LIKE inbb_t.inbb025, #活動編號
          inbb205 LIKE inbb_t.inbb205, #領用/退回單價
          inbb206 LIKE inbb_t.inbb206, #領用/退回金額
          inbb207 LIKE inbb_t.inbb207, #成本單價
          inbb208 LIKE inbb_t.inbb208, #成本金額
          inbb209 LIKE inbb_t.inbb209, #費用編號
          inbb210 LIKE inbb_t.inbb210, #進價
          inbb211 LIKE inbb_t.inbb211, #來源單據項次
          inbb212 LIKE inbb_t.inbb212, #來源單據項序
          inbb213 LIKE inbb_t.inbb213, #轉入商品條碼
          inbb214 LIKE inbb_t.inbb214, #轉入商品編號
          inbb215 LIKE inbb_t.inbb215, #轉入產品特徵
          inbb216 LIKE inbb_t.inbb216, #轉入單位
          inbb217 LIKE inbb_t.inbb217, #轉入數量
          inbb218 LIKE inbb_t.inbb218, #轉入包裝單位
          inbb219 LIKE inbb_t.inbb219, #轉入包裝數量
          inbb220 LIKE inbb_t.inbb220, #轉入庫位
          inbb221 LIKE inbb_t.inbb221, #轉入儲位
          inbb222 LIKE inbb_t.inbb222, #轉入批號
          inbb223 LIKE inbb_t.inbb223, #轉入進價
          inbb224 LIKE inbb_t.inbb224, #計價單位
          inbb225 LIKE inbb_t.inbb225  #計價數量
   END RECORD
   #DEFINE l_inbc      RECORD LIKE inbc_t.*
   DEFINE l_inbc RECORD  #雜項庫存異動庫儲批明細檔
          inbcent LIKE inbc_t.inbcent, #企業編號
          inbcsite LIKE inbc_t.inbcsite, #營運據點
          inbcdocno LIKE inbc_t.inbcdocno, #單據編號
          inbcseq LIKE inbc_t.inbcseq, #項次
          inbcseq1 LIKE inbc_t.inbcseq1, #項序
          inbc001 LIKE inbc_t.inbc001, #料件編號
          inbc002 LIKE inbc_t.inbc002, #產品特徵
          inbc003 LIKE inbc_t.inbc003, #庫存管理特徵
          inbc004 LIKE inbc_t.inbc004, #包裝容器編號
          inbc005 LIKE inbc_t.inbc005, #庫位
          inbc006 LIKE inbc_t.inbc006, #儲位
          inbc007 LIKE inbc_t.inbc007, #批號
          inbc009 LIKE inbc_t.inbc009, #交易單位
          inbc010 LIKE inbc_t.inbc010, #數量
          inbc011 LIKE inbc_t.inbc011, #參考單位
          inbc015 LIKE inbc_t.inbc015, #參考數量
          inbc016 LIKE inbc_t.inbc016, #有效日期
          inbc017 LIKE inbc_t.inbc017, #存貨備註
          inbc018 LIKE inbc_t.inbc018, #QC單號
          inbc019 LIKE inbc_t.inbc019, #QC判定項次
          inbc020 LIKE inbc_t.inbc020, #判定結果
          #161109-00085#62 --s add
          inbcud001 LIKE inbc_t.inbcud001, #自定義欄位(文字)001
          inbcud002 LIKE inbc_t.inbcud002, #自定義欄位(文字)002
          inbcud003 LIKE inbc_t.inbcud003, #自定義欄位(文字)003
          inbcud004 LIKE inbc_t.inbcud004, #自定義欄位(文字)004
          inbcud005 LIKE inbc_t.inbcud005, #自定義欄位(文字)005
          inbcud006 LIKE inbc_t.inbcud006, #自定義欄位(文字)006
          inbcud007 LIKE inbc_t.inbcud007, #自定義欄位(文字)007
          inbcud008 LIKE inbc_t.inbcud008, #自定義欄位(文字)008
          inbcud009 LIKE inbc_t.inbcud009, #自定義欄位(文字)009
          inbcud010 LIKE inbc_t.inbcud010, #自定義欄位(文字)010
          inbcud011 LIKE inbc_t.inbcud011, #自定義欄位(數字)011
          inbcud012 LIKE inbc_t.inbcud012, #自定義欄位(數字)012
          inbcud013 LIKE inbc_t.inbcud013, #自定義欄位(數字)013
          inbcud014 LIKE inbc_t.inbcud014, #自定義欄位(數字)014
          inbcud015 LIKE inbc_t.inbcud015, #自定義欄位(數字)015
          inbcud016 LIKE inbc_t.inbcud016, #自定義欄位(數字)016
          inbcud017 LIKE inbc_t.inbcud017, #自定義欄位(數字)017
          inbcud018 LIKE inbc_t.inbcud018, #自定義欄位(數字)018
          inbcud019 LIKE inbc_t.inbcud019, #自定義欄位(數字)019
          inbcud020 LIKE inbc_t.inbcud020, #自定義欄位(數字)020
          inbcud021 LIKE inbc_t.inbcud021, #自定義欄位(日期時間)021
          inbcud022 LIKE inbc_t.inbcud022, #自定義欄位(日期時間)022
          inbcud023 LIKE inbc_t.inbcud023, #自定義欄位(日期時間)023
          inbcud024 LIKE inbc_t.inbcud024, #自定義欄位(日期時間)024
          inbcud025 LIKE inbc_t.inbcud025, #自定義欄位(日期時間)025
          inbcud026 LIKE inbc_t.inbcud026, #自定義欄位(日期時間)026
          inbcud027 LIKE inbc_t.inbcud027, #自定義欄位(日期時間)027
          inbcud028 LIKE inbc_t.inbcud028, #自定義欄位(日期時間)028
          inbcud029 LIKE inbc_t.inbcud029, #自定義欄位(日期時間)029
          inbcud030 LIKE inbc_t.inbcud030, #自定義欄位(日期時間)030
          #161109-00085#62 --e add
          inbc200 LIKE inbc_t.inbc200, #商品條碼
          inbc201 LIKE inbc_t.inbc201, #包裝單位
          inbc202 LIKE inbc_t.inbc202, #包裝數量
          inbcunit LIKE inbc_t.inbcunit, #應用組織
          inbc203 LIKE inbc_t.inbc203, #製造日期
          inbc021 LIKE inbc_t.inbc021, #專案編號
          inbc022 LIKE inbc_t.inbc022, #WBS
          inbc023 LIKE inbc_t.inbc023, #活動編號
          inbc204 LIKE inbc_t.inbc204, #領用/退回單價
          inbc205 LIKE inbc_t.inbc205, #領用/退回金額
          inbc206 LIKE inbc_t.inbc206, #成本單價
          inbc207 LIKE inbc_t.inbc207, #成本金額
          inbc208 LIKE inbc_t.inbc208, #費用編號
          inbc209 LIKE inbc_t.inbc209, #來源單據項次
          inbc210 LIKE inbc_t.inbc210, #來源單據項序
          inbc211 LIKE inbc_t.inbc211, #計價單位
          inbc212 LIKE inbc_t.inbc212  #計價數量
   END RECORD   
   #DEFINE l_inao      RECORD LIKE inao_t.*
   #161109-00085#32-e   
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_amount    LIKE inbb_t.inbb011
   DEFINE l_imaf071   LIKE imaf_t.imaf071
   DEFINE l_imaf081   LIKE imaf_t.imaf081
   
   LET r_success = TRUE
   #检查事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #161109-00085#32-s
   #INITIALIZE l_sfja.* TO NULL
   #INITIALIZE l_sfjb.* TO NULL
   #INITIALIZE l_inao.* TO NULL
   #161109-00085#32-e   
   INITIALIZE l_sfjc.* TO NULL
   INITIALIZE l_inba.* TO NULL
   INITIALIZE l_inbb.* TO NULL
   INITIALIZE l_inbc.* TO NULL
   
#先插单头
   #161109-00085#32-s
   #SELECT * INTO l_sfja.*
   # WHERE sfjaent   = g_enterprise
   #   AND sfjasite  = g_site
   #   AND sfjadocno = g_sfjadocno
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'sel sfja_t'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #161109-00085#32-e   

   LET l_inba.inbaent   = g_enterprise                                                    #企業編號    #161109-00085#32
   LET l_inba.inbasite  = g_site                                                          #營運據點    #161109-00085#32
   LET l_inba.inbadocno = g_inba_m.inbadocno                                              #單據編號        
   LET l_inba.inbadocdt = g_today                                                         #輸入日期        
   LET l_inba.inba001   = '2'                                                             #單據類別        
   LET l_inba.inba002   = ''                                                              #扣帳日期        
   LET l_inba.inba003   = g_user                                                          #申請人員        
   LET l_inba.inba004   = g_dept                                                          #申請部門        
   LET l_inba.inba005   = '8'                                                             #來源資料類型    
   LET l_inba.inba006   = g_sfjadocno                                                     #來源單號    #161109-00085#32
   LET l_inba.inba007   = ''                                                              #理由碼  
   CALL s_aooi360_sel('6',g_sfjadocno,'','','','','','','','','','4')                     #備註        #161109-00085#32
        RETURNING l_success,l_inba.inba008                                                #                          
   LET l_inba.inba009   = ''                                                              #保稅異動原因      
   LET l_inba.inba010   = ''                                                              #保稅進口報單    
   LET l_inba.inba011   = ''                                                              #保稅進口報單日期
   LET l_inba.inbaownid = g_user                                                          #資料所有者      
   LET l_inba.inbaowndp = g_dept                                                          #資料所屬部門    
   LET l_inba.inbacrtid = g_user                                                          #資料建立者      
   LET l_inba.inbacrtdp = g_dept                                                          #資料建立部門    
   LET l_inba.inbacrtdt = g_today                                                         #資料創建日      
   LET l_inba.inbamodid = ''                                                              #資料修改者      
   LET l_inba.inbamoddt = ''                                                              #最近修改日      
   LET l_inba.inbacnfid = ''                                                              #資料確認者      
   LET l_inba.inbacnfdt = ''                                                              #資料確認日      
   LET l_inba.inbapstid = ''                                                              #資料過帳者
   LET l_inba.inbapstdt = ''                                                              #資料過帳日
   LET l_inba.inbastus  = 'N'                                                             #狀態碼
   #161109-00085#62 --s add
   LET l_inba.inbaud001 = ''
   LET l_inba.inbaud002 = ''
   LET l_inba.inbaud003 = ''
   LET l_inba.inbaud004 = ''
   LET l_inba.inbaud005 = ''
   LET l_inba.inbaud006 = ''
   LET l_inba.inbaud007 = ''
   LET l_inba.inbaud008 = ''
   LET l_inba.inbaud009 = ''
   LET l_inba.inbaud010 = ''
   LET l_inba.inbaud011 = ''
   LET l_inba.inbaud012 = ''
   LET l_inba.inbaud013 = ''
   LET l_inba.inbaud014 = ''
   LET l_inba.inbaud015 = ''
   LET l_inba.inbaud016 = ''
   LET l_inba.inbaud017 = ''
   LET l_inba.inbaud018 = ''
   LET l_inba.inbaud019 = ''
   LET l_inba.inbaud020 = ''
   LET l_inba.inbaud021 = ''
   LET l_inba.inbaud022 = ''
   LET l_inba.inbaud023 = ''
   LET l_inba.inbaud024 = ''
   LET l_inba.inbaud025 = ''
   LET l_inba.inbaud026 = ''
   LET l_inba.inbaud027 = ''
   LET l_inba.inbaud028 = ''
   LET l_inba.inbaud029 = ''
   LET l_inba.inbaud030 = ''
   #161109-00085#62 --e add
   #161109-00085#32-s #161109-00085#62 mark
   #INSERT INTO inba_t VALUES(l_inba.*)
   #INSERT INTO inba_t(inbaent,inbasite,inbadocno,inbadocdt,inba001,inba002,inba003,inba004,inba005,inba006,
   #                   inba007,inba008,inba009,inba010,inba011,inbaownid,inbaowndp,inbacrtid,inbacrtdp,inbacrtdt,
   #                   inbamodid,inbamoddt,inbacnfid,inbacnfdt,inbapstid,inbapstdt,inbastus,inbaunit,inba012,inba013,inba014,
   #                   inba015,inba200,inba201,inba202,inba203,inba204,inba205,inba206,inba207,inba208) 
   #VALUES (l_inba.inbaent,l_inba.inbasite,l_inba.inbadocno,l_inba.inbadocdt,l_inba.inba001,
   #        l_inba.inba002,l_inba.inba003,l_inba.inba004,l_inba.inba005,l_inba.inba006,
   #        l_inba.inba007,l_inba.inba008,l_inba.inba009,l_inba.inba010,l_inba.inba011,
   #        l_inba.inbaownid,l_inba.inbaowndp,l_inba.inbacrtid,l_inba.inbacrtdp,l_inba.inbacrtdt,
   #        l_inba.inbamodid,l_inba.inbamoddt,l_inba.inbacnfid,l_inba.inbacnfdt,l_inba.inbapstid,
   #        l_inba.inbapstdt,l_inba.inbastus,l_inba.inbaunit,l_inba.inba012,l_inba.inba013,l_inba.inba014,
   #        l_inba.inba015,l_inba.inba200,l_inba.inba201,l_inba.inba202,l_inba.inba203,
   #        l_inba.inba204,l_inba.inba205,l_inba.inba206,l_inba.inba207,l_inba.inba208)
   #161109-00085#32-e #161109-00085#62 mark
   #161109-00085#62 --s add
   INSERT INTO inba_t(inbaent,inbasite,inbadocno,inbadocdt,inba001,
                      inba002,inba003,inba004,inba005,inba006,
                      inba007,inba008,inba009,inba010,inba011,
                      inbaownid,inbaowndp,inbacrtid,inbacrtdp,
                      inbacrtdt,inbamodid,inbamoddt,inbacnfid,inbacnfdt,
                      inbapstid,inbapstdt,inbastus,inbaud001,inbaud002,
                      inbaud003,inbaud004,inbaud005,inbaud006,inbaud007,
                      inbaud008,inbaud009,inbaud010,inbaud011,inbaud012,
                      inbaud013,inbaud014,inbaud015,inbaud016,inbaud017,
                      inbaud018,inbaud019,inbaud020,inbaud021,inbaud022,
                      inbaud023,inbaud024,inbaud025,inbaud026,inbaud027,
                      inbaud028,inbaud029,inbaud030,inbaunit,inba012,
                      inba013,inba014,inba015,inba200,inba201,
                      inba202,inba203,inba204,inba205,inba206,
                      inba207,inba208)
   VALUES(l_inba.inbaent,l_inba.inbasite,l_inba.inbadocno,l_inba.inbadocdt,l_inba.inba001,
          l_inba.inba002,l_inba.inba003,l_inba.inba004,l_inba.inba005,l_inba.inba006,
          l_inba.inba007,l_inba.inba008,l_inba.inba009,l_inba.inba010,l_inba.inba011,
          l_inba.inbaownid,l_inba.inbaowndp,l_inba.inbacrtid,l_inba.inbacrtdp,
          l_inba.inbacrtdt,l_inba.inbamodid,l_inba.inbamoddt,l_inba.inbacnfid,l_inba.inbacnfdt,
          l_inba.inbapstid,l_inba.inbapstdt,l_inba.inbastus,l_inba.inbaud001,l_inba.inbaud002,
          l_inba.inbaud003,l_inba.inbaud004,l_inba.inbaud005,l_inba.inbaud006,l_inba.inbaud007,
          l_inba.inbaud008,l_inba.inbaud009,l_inba.inbaud010,l_inba.inbaud011,l_inba.inbaud012,
          l_inba.inbaud013,l_inba.inbaud014,l_inba.inbaud015,l_inba.inbaud016,l_inba.inbaud017,
          l_inba.inbaud018,l_inba.inbaud019,l_inba.inbaud020,l_inba.inbaud021,l_inba.inbaud022,
          l_inba.inbaud023,l_inba.inbaud024,l_inba.inbaud025,l_inba.inbaud026,l_inba.inbaud027,
          l_inba.inbaud028,l_inba.inbaud029,l_inba.inbaud030,l_inba.inbaunit,l_inba.inba012,
          l_inba.inba013,l_inba.inba014,l_inba.inba015,l_inba.inba200,l_inba.inba201,
          l_inba.inba202,l_inba.inba203,l_inba.inba204,l_inba.inba205,l_inba.inba206,
          l_inba.inba207,l_inba.inba208)
   #161109-00085#62 --e add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins inba'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

#再插各个单身  #取sfjc没错，是SA要求的
   #161109-00085#32-s
   #效能優化－刪除內容一樣的asft339_01_sel_sfjc_cs1
   DECLARE asft339_01_sel_sfjc_cs CURSOR FOR
     #SELECT * FROM sfjc_t
     #161109-00085#62 --s mark
     #SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,sfjc004,sfjc005,
     #       sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,sfjc013,sfjc014,sfjc015,
     #       sfjc016,sfjc017,sfjc018,sfjc019 
     #161109-00085#62 --e mark
     #161109-00085#62 --s add
     SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,
            sfjc001,sfjc002,sfjc003,sfjc004,sfjc005,
            sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,
            sfjc011,sfjc012,sfjc013,sfjc014,sfjc015,
            sfjcud001,sfjcud002,sfjcud003,sfjcud004,sfjcud005,
            sfjcud006,sfjcud007,sfjcud008,sfjcud009,sfjcud010,
            sfjcud011,sfjcud012,sfjcud013,sfjcud014,sfjcud015,
            sfjcud016,sfjcud017,sfjcud018,sfjcud019,sfjcud020,
            sfjcud021,sfjcud022,sfjcud023,sfjcud024,sfjcud025,
            sfjcud026,sfjcud027,sfjcud028,sfjcud029,sfjcud030,
            sfjc016,sfjc017,sfjc018,sfjc019
     #161109-00085#62 --e add
       FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = g_sfjadocno
         AND sfjc010   = '2'
   #FOREACH asft339_01_sel_sfjc_cs INTO l_sfjc.*
   FOREACH asft339_01_sel_sfjc_cs 
      INTO l_sfjc.sfjcent,l_sfjc.sfjcsite,l_sfjc.sfjcdocno,l_sfjc.sfjcseq,l_sfjc.sfjcseq1,
           l_sfjc.sfjc001,l_sfjc.sfjc002,l_sfjc.sfjc003,l_sfjc.sfjc004,l_sfjc.sfjc005,
           l_sfjc.sfjc006,l_sfjc.sfjc007,l_sfjc.sfjc008,l_sfjc.sfjc009,l_sfjc.sfjc010,
           l_sfjc.sfjc011,l_sfjc.sfjc012,l_sfjc.sfjc013,l_sfjc.sfjc014,l_sfjc.sfjc015,
           #161109-00085#62 --s add
           l_sfjc.sfjcud001,l_sfjc.sfjcud002,l_sfjc.sfjcud003,l_sfjc.sfjcud004,l_sfjc.sfjcud005,
           l_sfjc.sfjcud006,l_sfjc.sfjcud007,l_sfjc.sfjcud008,l_sfjc.sfjcud009,l_sfjc.sfjcud010,
           l_sfjc.sfjcud011,l_sfjc.sfjcud012,l_sfjc.sfjcud013,l_sfjc.sfjcud014,l_sfjc.sfjcud015,
           l_sfjc.sfjcud016,l_sfjc.sfjcud017,l_sfjc.sfjcud018,l_sfjc.sfjcud019,l_sfjc.sfjcud020,
           l_sfjc.sfjcud021,l_sfjc.sfjcud022,l_sfjc.sfjcud023,l_sfjc.sfjcud024,l_sfjc.sfjcud025,
           l_sfjc.sfjcud026,l_sfjc.sfjcud027,l_sfjc.sfjcud028,l_sfjc.sfjcud029,l_sfjc.sfjcud030,
           #161109-00085#62 --e add
           l_sfjc.sfjc016,l_sfjc.sfjc017,l_sfjc.sfjc018,l_sfjc.sfjc019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_inbb.inbbent   = l_sfjc.sfjcent                                  #企業編號        
      LET l_inbb.inbbsite  = l_sfjc.sfjcsite                                 #營運據點        
      LET l_inbb.inbbdocno = g_inba_m.inbadocno                              #單據編號        
      LET l_inbb.inbbseq   = l_sfjc.sfjcseq                                  #項次            
      LET l_inbb.inbb001   = l_sfjc.sfjc003                                  #料件編號        
      LET l_inbb.inbb002   = l_sfjc.sfjc004                                  #產品特徵        
      LET l_inbb.inbb003   = l_sfjc.sfjc014                                  #庫存管理特徵    
      LET l_inbb.inbb004   = ''                                              #包裝容器編號    
      LET l_inbb.inbb007   = l_sfjc.sfjc011                                  #庫位            
      LET l_inbb.inbb008   = l_sfjc.sfjc012                                  #限定儲位        
      LET l_inbb.inbb009   = l_sfjc.sfjc013                                  #限定批號        
      LET l_inbb.inbb010   = l_sfjc.sfjc005                                  #交易單位        
      LET l_inbb.inbb011   = l_sfjc.sfjc006                                  #申請數量        
      LET l_inbb.inbb012   = l_sfjc.sfjc006                                  #實際異動數量    
      LET l_inbb.inbb013   = l_sfjc.sfjc007                                  #參考單位        
      LET l_inbb.inbb014   = l_sfjc.sfjc008                                  #參考單位申請數量
      LET l_inbb.inbb015   = l_sfjc.sfjc008                                  #參考單位實際數量
      LET l_inbb.inbb016   = l_sfjc.sfjc009                                  #理由碼          
      LET l_inbb.inbb017   = g_sfjadocno                                     #來源單號    #161109-00085#32
      LET l_inbb.inbb018   = 'N'                                             #檢驗否          
      LET l_inbb.inbb020   = ''                                              #單據備註        
      LET l_inbb.inbb021   = ''                                              #存貨備註        
      LET l_inbb.inbb022   = ''                                              #有效日期        
      #161109-00085#62 --s add
      LET l_inbb.inbbud001 = ''
      LET l_inbb.inbbud002 = ''
      LET l_inbb.inbbud003 = ''
      LET l_inbb.inbbud004 = ''
      LET l_inbb.inbbud005 = ''
      LET l_inbb.inbbud006 = ''
      LET l_inbb.inbbud007 = ''
      LET l_inbb.inbbud008 = ''
      LET l_inbb.inbbud009 = ''
      LET l_inbb.inbbud010 = ''
      LET l_inbb.inbbud011 = ''
      LET l_inbb.inbbud012 = ''
      LET l_inbb.inbbud013 = ''
      LET l_inbb.inbbud014 = ''
      LET l_inbb.inbbud015 = ''
      LET l_inbb.inbbud016 = ''
      LET l_inbb.inbbud017 = ''
      LET l_inbb.inbbud018 = ''
      LET l_inbb.inbbud019 = ''
      LET l_inbb.inbbud020 = ''
      LET l_inbb.inbbud021 = ''
      LET l_inbb.inbbud022 = ''
      LET l_inbb.inbbud023 = ''
      LET l_inbb.inbbud024 = ''
      LET l_inbb.inbbud025 = ''
      LET l_inbb.inbbud026 = ''
      LET l_inbb.inbbud027 = ''
      LET l_inbb.inbbud028 = ''
      LET l_inbb.inbbud029 = ''
      LET l_inbb.inbbud030 = ''
      #161109-00085#62 --e add
      #INSERT INTO inbb_t VALUES(l_inbb.*)
      #161109-00085#62 --s mark
      #INSERT INTO inbb_t(inbbent,inbbsite,inbbdocno,inbbseq,inbb001,inbb002,inbb003,inbb004,inbb007,inbb008,
      #                   inbb009,inbb010,inbb011,inbb012,inbb013,inbb014,inbb015,inbb016,inbb017,inbb018,
      #                   inbb019,inbb020,inbb021,inbb022,inbb200,inbb201,inbb202,inbb203,inbbunit,inbb204,inbb023,
      #                   inbb024,inbb025,inbb205,inbb206,inbb207,inbb208,inbb209,inbb210,inbb211,inbb212,inbb213,inbb214,
      #                   inbb215,inbb216,inbb217,inbb218,inbb219,inbb220,inbb221,inbb222,inbb223,inbb224,inbb225) 
      #VALUES(l_inbb.inbbent,l_inbb.inbbsite,l_inbb.inbbdocno,l_inbb.inbbseq,l_inbb.inbb001,
      #       l_inbb.inbb002,l_inbb.inbb003,l_inbb.inbb004,l_inbb.inbb007,l_inbb.inbb008,
      #       l_inbb.inbb009,l_inbb.inbb010,l_inbb.inbb011,l_inbb.inbb012,l_inbb.inbb013,
      #       l_inbb.inbb014,l_inbb.inbb015,l_inbb.inbb016,l_inbb.inbb017,l_inbb.inbb018,
      #       l_inbb.inbb019,l_inbb.inbb020,l_inbb.inbb021,l_inbb.inbb022,l_inbb.inbb200,
      #       l_inbb.inbb201,l_inbb.inbb202,l_inbb.inbb203,l_inbb.inbbunit,l_inbb.inbb204,l_inbb.inbb023,
      #       l_inbb.inbb024,l_inbb.inbb025,l_inbb.inbb205,l_inbb.inbb206,l_inbb.inbb207,l_inbb.inbb208,
      #       l_inbb.inbb209,l_inbb.inbb210,l_inbb.inbb211,l_inbb.inbb212,l_inbb.inbb213,l_inbb.inbb214,
      #       l_inbb.inbb215,l_inbb.inbb216,l_inbb.inbb217,l_inbb.inbb218,l_inbb.inbb219,l_inbb.inbb220,
      #       l_inbb.inbb221,l_inbb.inbb222,l_inbb.inbb223,l_inbb.inbb224,l_inbb.inbb225)
      #161109-00085#62 --e mark
      #161109-00085#62 --s add
      INSERT INTO inbb_t(inbbent,inbbsite,inbbdocno,inbbseq,inbb001,
                         inbb002,inbb003,inbb004,inbb007,inbb008,
                         inbb009,inbb010,inbb011,inbb012,inbb013,
                         inbb014,inbb015,inbb016,inbb017,inbb018,
                         inbb019,inbb020,inbb021,inbb022,inbbud001,
                         inbbud002,inbbud003,inbbud004,inbbud005,inbbud006,
                         inbbud007,inbbud008,inbbud009,inbbud010,inbbud011,
                         inbbud012,inbbud013,inbbud014,inbbud015,inbbud016,
                         inbbud017,inbbud018,inbbud019,inbbud020,inbbud021,
                         inbbud022,inbbud023,inbbud024,inbbud025,inbbud026,
                         inbbud027,inbbud028,inbbud029,inbbud030,inbb200,
                         inbb201,inbb202,inbb203,inbbunit,inbb204,
                         inbb023,inbb024,inbb025,inbb205,inbb206,
                         inbb207,inbb208,inbb209,inbb210,inbb211,
                         inbb212,inbb213,inbb214,inbb215,inbb216,
                         inbb217,inbb218,inbb219,inbb220,inbb221,
                         inbb222,inbb223,inbb224,inbb225)
      VALUES(l_inbb.inbbent,l_inbb.inbbsite,l_inbb.inbbdocno,l_inbb.inbbseq,l_inbb.inbb001,
             l_inbb.inbb002,l_inbb.inbb003,l_inbb.inbb004,l_inbb.inbb007,l_inbb.inbb008,
             l_inbb.inbb009,l_inbb.inbb010,l_inbb.inbb011,l_inbb.inbb012,l_inbb.inbb013,
             l_inbb.inbb014,l_inbb.inbb015,l_inbb.inbb016,l_inbb.inbb017,l_inbb.inbb018,
             l_inbb.inbb019,l_inbb.inbb020,l_inbb.inbb021,l_inbb.inbb022,l_inbb.inbbud001,
             l_inbb.inbbud002,l_inbb.inbbud003,l_inbb.inbbud004,l_inbb.inbbud005,l_inbb.inbbud006,
             l_inbb.inbbud007,l_inbb.inbbud008,l_inbb.inbbud009,l_inbb.inbbud010,l_inbb.inbbud011,
             l_inbb.inbbud012,l_inbb.inbbud013,l_inbb.inbbud014,l_inbb.inbbud015,l_inbb.inbbud016,
             l_inbb.inbbud017,l_inbb.inbbud018,l_inbb.inbbud019,l_inbb.inbbud020,l_inbb.inbbud021,
             l_inbb.inbbud022,l_inbb.inbbud023,l_inbb.inbbud024,l_inbb.inbbud025,l_inbb.inbbud026,
             l_inbb.inbbud027,l_inbb.inbbud028,l_inbb.inbbud029,l_inbb.inbbud030,l_inbb.inbb200,
             l_inbb.inbb201,l_inbb.inbb202,l_inbb.inbb203,l_inbb.inbbunit,l_inbb.inbb204,
             l_inbb.inbb023,l_inbb.inbb024,l_inbb.inbb025,l_inbb.inbb205,l_inbb.inbb206,
             l_inbb.inbb207,l_inbb.inbb208,l_inbb.inbb209,l_inbb.inbb210,l_inbb.inbb211,
             l_inbb.inbb212,l_inbb.inbb213,l_inbb.inbb214,l_inbb.inbb215,l_inbb.inbb216,
             l_inbb.inbb217,l_inbb.inbb218,l_inbb.inbb219,l_inbb.inbb220,l_inbb.inbb221,
             l_inbb.inbb222,l_inbb.inbb223,l_inbb.inbb224,l_inbb.inbb225)
      #161109-00085#62 --e add
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'ins inbb'
        LET g_errparam.popup = TRUE
        CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
#再插单身对应的批序号
      #mod 150921 不开窗，直接产生了
      #LET l_success = '' 
      #LET l_imaf071 = ''
      #LET l_imaf081 = '' 
      #SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
      # WHERE imafent  = g_enterprise
      #   AND imafsite = g_site
      #   AND imaf001  = l_inbb.inbb001
      #   
      #IF l_imaf071 = '1' OR l_imaf081 = '1' THEN   #参考aimm212，制造批序号管理  
      #   CALL s_lot_ins(g_site,l_inba.inbadocno,l_inbb.inbbseq,'0',l_inbb.inbb001,l_inbb.inbb002,l_inbb.inbb010,l_inbb.inbb011,'1',l_inba.inba003,'2',g_site)
      #        RETURNING l_success,l_amount
      #   IF NOT l_success THEN
      #      LET r_success = FALSE
      #      RETURN r_success
      #   END IF
      #END IF
      CALL asft339_01_ins_lot(l_sfjc.sfjcdocno,l_sfjc.sfjcseq,l_sfjc.sfjcseq1,g_inba_m.inbadocno,l_inbb.inbbseq,1,'1')  #aint302中申请的没项序给的是1的
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #mod 150921 end
      
      LET l_inbc.inbcent   = l_sfjc.sfjcent                                  #企業編號        
      LET l_inbc.inbcsite  = l_sfjc.sfjcsite                                 #營運據點        
      LET l_inbc.inbcdocno = g_inba_m.inbadocno                              #單據編號        
      LET l_inbc.inbcseq   = l_sfjc.sfjcseq                                  #項次 
      LET l_inbc.inbcseq1  = l_sfjc.sfjcseq1                                 #項序       
      LET l_inbc.inbc001   = l_sfjc.sfjc003                                  #料件編號        
      LET l_inbc.inbc002   = l_sfjc.sfjc004                                  #產品特徵        
      LET l_inbc.inbc003   = l_sfjc.sfjc014                                  #庫存管理特徵    
      LET l_inbc.inbc004   = ''                                              #包裝容器編號    
      LET l_inbc.inbc005   = l_sfjc.sfjc011                                  #庫位            
      LET l_inbc.inbc006   = l_sfjc.sfjc012                                  #儲位        
      LET l_inbc.inbc007   = l_sfjc.sfjc013                                  #批號        
      LET l_inbc.inbc009   = l_sfjc.sfjc005                                  #交易單位        
      LET l_inbc.inbc010   = l_sfjc.sfjc006                                  #數量           
      LET l_inbc.inbc011   = l_sfjc.sfjc007                                  #參考單位        
      LET l_inbc.inbc015   = l_sfjc.sfjc008                                  #參考數量
      LET l_inbc.inbc016   = ''                                              #有效日期
      LET l_inbc.inbc017   = ''                                              #存貨備註        
      #INSERT INTO inbc_t VALUES(l_inbc.*)
      #161109-00085#62 --s mark
      #INSERT INTO inbc_t(inbcent,inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002,inbc003,inbc004,inbc005,
      #                   inbc006,inbc007,inbc009,inbc010,inbc011,inbc015,inbc016,inbc017,inbc018,inbc019,
      #                   inbc020,inbc200,inbc201,inbc202,inbcunit,inbc203,inbc021,inbc022,inbc023,inbc204,
      #                   inbc205,inbc206,inbc207,inbc208,inbc209,inbc210,inbc211,inbc212) 
      #VALUES(l_inbc.inbcent,l_inbc.inbcsite,l_inbc.inbcdocno,l_inbc.inbcseq,l_inbc.inbcseq1,
      #       l_inbc.inbc001,l_inbc.inbc002,l_inbc.inbc003,l_inbc.inbc004,l_inbc.inbc005,
      #       l_inbc.inbc006,l_inbc.inbc007,l_inbc.inbc009,l_inbc.inbc010,l_inbc.inbc011,
      #       l_inbc.inbc015,l_inbc.inbc016,l_inbc.inbc017,l_inbc.inbc018,l_inbc.inbc019,
      #       l_inbc.inbc020,l_inbc.inbc200,l_inbc.inbc201,l_inbc.inbc202,l_inbc.inbcunit,
      #       l_inbc.inbc203,l_inbc.inbc021,l_inbc.inbc022,l_inbc.inbc023,l_inbc.inbc204,
      #       l_inbc.inbc205,l_inbc.inbc206,l_inbc.inbc207,l_inbc.inbc208,l_inbc.inbc209,
      #       l_inbc.inbc210,l_inbc.inbc211,l_inbc.inbc212)
      #161109-00085#62 --e mark
      #161109-00085#62 --s add
      INSERT INTO inbc_t(inbcent,inbcsite,inbcdocno,inbcseq,inbcseq1,
                         inbc001,inbc002,inbc003,inbc004,inbc005,
                         inbc006,inbc007,inbc009,inbc010,inbc011,
                         inbc015,inbc016,inbc017,inbc018,inbc019,
                         inbc020,inbcud001,inbcud002,inbcud003,inbcud004,
                         inbcud005,inbcud006,inbcud007,inbcud008,inbcud009,
                         inbcud010,inbcud011,inbcud012,inbcud013,inbcud014,
                         inbcud015,inbcud016,inbcud017,inbcud018,inbcud019,
                         inbcud020,inbcud021,inbcud022,inbcud023,inbcud024,
                         inbcud025,inbcud026,inbcud027,inbcud028,inbcud029,
                         inbcud030,inbc200,inbc201,inbc202,inbcunit,
                         inbc203,inbc021,inbc022,inbc023,inbc204,
                         inbc205,inbc206,inbc207,inbc208,inbc209,
                         inbc210,inbc211,inbc212)
      VALUES(l_inbc.inbcent,l_inbc.inbcsite,l_inbc.inbcdocno,l_inbc.inbcseq,l_inbc.inbcseq1,
             l_inbc.inbc001,l_inbc.inbc002,l_inbc.inbc003,l_inbc.inbc004,l_inbc.inbc005,
             l_inbc.inbc006,l_inbc.inbc007,l_inbc.inbc009,l_inbc.inbc010,l_inbc.inbc011,
             l_inbc.inbc015,l_inbc.inbc016,l_inbc.inbc017,l_inbc.inbc018,l_inbc.inbc019,
             l_inbc.inbc020,l_inbc.inbcud001,l_inbc.inbcud002,l_inbc.inbcud003,l_inbc.inbcud004,
             l_inbc.inbcud005,l_inbc.inbcud006,l_inbc.inbcud007,l_inbc.inbcud008,l_inbc.inbcud009,
             l_inbc.inbcud010,l_inbc.inbcud011,l_inbc.inbcud012,l_inbc.inbcud013,l_inbc.inbcud014,
             l_inbc.inbcud015,l_inbc.inbcud016,l_inbc.inbcud017,l_inbc.inbcud018,l_inbc.inbcud019,
             l_inbc.inbcud020,l_inbc.inbcud021,l_inbc.inbcud022,l_inbc.inbcud023,l_inbc.inbcud024,
             l_inbc.inbcud025,l_inbc.inbcud026,l_inbc.inbcud027,l_inbc.inbcud028,l_inbc.inbcud029,
             l_inbc.inbcud030,l_inbc.inbc200,l_inbc.inbc201,l_inbc.inbc202,l_inbc.inbcunit,
             l_inbc.inbc203,l_inbc.inbc021,l_inbc.inbc022,l_inbc.inbc023,l_inbc.inbc204,
             l_inbc.inbc205,l_inbc.inbc206,l_inbc.inbc207,l_inbc.inbc208,l_inbc.inbc209,
             l_inbc.inbc210,l_inbc.inbc211,l_inbc.inbc212)
      #161109-00085#62 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins inbc'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH
   CLOSE asft339_01_sel_sfjc_cs
   FREE asft339_01_sel_sfjc_cs
   #161109-00085#32-e
   
   RETURN r_success
#inao的批序号资料进aint302去维护产生
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asft339_01_ins_sfda()
   #161109-00085#32-s   
   #DEFINE l_sfda      RECORD LIKE sfda_t.*
   #161109-00085#62 --s mark
   DEFINE l_sfda RECORD  #發退料單頭檔
       sfdaent LIKE sfda_t.sfdaent, #企業編號
       sfdasite LIKE sfda_t.sfdasite, #營運據點
       sfdadocno LIKE sfda_t.sfdadocno, #發退料單號
       sfdadocdt LIKE sfda_t.sfdadocdt, #單據日期
       sfda001 LIKE sfda_t.sfda001, #過帳日期
       sfda002 LIKE sfda_t.sfda002, #發退料類別
       sfda003 LIKE sfda_t.sfda003, #生產部門
       sfda004 LIKE sfda_t.sfda004, #申請人
       sfda005 LIKE sfda_t.sfda005, #PBI編號
       sfda006 LIKE sfda_t.sfda006, #生產料號
       sfda007 LIKE sfda_t.sfda007, #BOM特性
       sfda008 LIKE sfda_t.sfda008, #產品特徵
       sfda009 LIKE sfda_t.sfda009, #生產控制組
       sfda010 LIKE sfda_t.sfda010, #作業編號
       sfda011 LIKE sfda_t.sfda011, #作業序
       sfda012 LIKE sfda_t.sfda012, #庫位
       sfda013 LIKE sfda_t.sfda013, #套數
       sfda014 LIKE sfda_t.sfda014, #來源單號
       sfda015 LIKE sfda_t.sfda015, #來源類型
       sfdaownid LIKE sfda_t.sfdaownid, #資料所有者
       sfdaowndp LIKE sfda_t.sfdaowndp, #資料所屬部門
       sfdacrtid LIKE sfda_t.sfdacrtid, #資料建立者
       sfdacrtdp LIKE sfda_t.sfdacrtdp, #資料建立部門
       sfdacrtdt LIKE sfda_t.sfdacrtdt, #資料創建日
       sfdamodid LIKE sfda_t.sfdamodid, #資料修改者
       sfdamoddt LIKE sfda_t.sfdamoddt, #最近修改日
       sfdacnfid LIKE sfda_t.sfdacnfid, #資料確認者
       sfdacnfdt LIKE sfda_t.sfdacnfdt, #資料確認日
       sfdapstid LIKE sfda_t.sfdapstid, #資料過帳者
       sfdapstdt LIKE sfda_t.sfdapstdt, #資料過帳日
      #sfdastus LIKE sfda_t.sfdastus    #狀態碼   #161109-00085#62 mark
       #161109-00085#62 --s add
       sfdastus LIKE sfda_t.sfdastus, #狀態碼
       sfdaud001 LIKE sfda_t.sfdaud001, #自定義欄位(文字)001
       sfdaud002 LIKE sfda_t.sfdaud002, #自定義欄位(文字)002
       sfdaud003 LIKE sfda_t.sfdaud003, #自定義欄位(文字)003
       sfdaud004 LIKE sfda_t.sfdaud004, #自定義欄位(文字)004
       sfdaud005 LIKE sfda_t.sfdaud005, #自定義欄位(文字)005
       sfdaud006 LIKE sfda_t.sfdaud006, #自定義欄位(文字)006
       sfdaud007 LIKE sfda_t.sfdaud007, #自定義欄位(文字)007
       sfdaud008 LIKE sfda_t.sfdaud008, #自定義欄位(文字)008
       sfdaud009 LIKE sfda_t.sfdaud009, #自定義欄位(文字)009
       sfdaud010 LIKE sfda_t.sfdaud010, #自定義欄位(文字)010
       sfdaud011 LIKE sfda_t.sfdaud011, #自定義欄位(數字)011
       sfdaud012 LIKE sfda_t.sfdaud012, #自定義欄位(數字)012
       sfdaud013 LIKE sfda_t.sfdaud013, #自定義欄位(數字)013
       sfdaud014 LIKE sfda_t.sfdaud014, #自定義欄位(數字)014
       sfdaud015 LIKE sfda_t.sfdaud015, #自定義欄位(數字)015
       sfdaud016 LIKE sfda_t.sfdaud016, #自定義欄位(數字)016
       sfdaud017 LIKE sfda_t.sfdaud017, #自定義欄位(數字)017
       sfdaud018 LIKE sfda_t.sfdaud018, #自定義欄位(數字)018
       sfdaud019 LIKE sfda_t.sfdaud019, #自定義欄位(數字)019
       sfdaud020 LIKE sfda_t.sfdaud020, #自定義欄位(數字)020
       sfdaud021 LIKE sfda_t.sfdaud021, #自定義欄位(日期時間)021
       sfdaud022 LIKE sfda_t.sfdaud022, #自定義欄位(日期時間)022
       sfdaud023 LIKE sfda_t.sfdaud023, #自定義欄位(日期時間)023
       sfdaud024 LIKE sfda_t.sfdaud024, #自定義欄位(日期時間)024
       sfdaud025 LIKE sfda_t.sfdaud025, #自定義欄位(日期時間)025
       sfdaud026 LIKE sfda_t.sfdaud026, #自定義欄位(日期時間)026
       sfdaud027 LIKE sfda_t.sfdaud027, #自定義欄位(日期時間)027
       sfdaud028 LIKE sfda_t.sfdaud028, #自定義欄位(日期時間)028
       sfdaud029 LIKE sfda_t.sfdaud029, #自定義欄位(日期時間)029
       sfdaud030 LIKE sfda_t.sfdaud030  #自定義欄位(日期時間)030
       #161109-00085#62 --e add
   END RECORD

   #DEFINE l_sfdc      RECORD LIKE sfdc_t.*
   DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企業編號
       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
       sfdcseq LIKE sfdc_t.sfdcseq, #項次
       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
       sfdc006 LIKE sfdc_t.sfdc006, #單位
       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
       #sfdc017 LIKE sfdc_t.sfdc017  #正負 #161109-00085#62 mark
       #161109-00085#62 --s add
       sfdc017 LIKE sfdc_t.sfdc017, #正負
       sfdcud001 LIKE sfdc_t.sfdcud001, #自定義欄位(文字)001
       sfdcud002 LIKE sfdc_t.sfdcud002, #自定義欄位(文字)002
       sfdcud003 LIKE sfdc_t.sfdcud003, #自定義欄位(文字)003
       sfdcud004 LIKE sfdc_t.sfdcud004, #自定義欄位(文字)004
       sfdcud005 LIKE sfdc_t.sfdcud005, #自定義欄位(文字)005
       sfdcud006 LIKE sfdc_t.sfdcud006, #自定義欄位(文字)006
       sfdcud007 LIKE sfdc_t.sfdcud007, #自定義欄位(文字)007
       sfdcud008 LIKE sfdc_t.sfdcud008, #自定義欄位(文字)008
       sfdcud009 LIKE sfdc_t.sfdcud009, #自定義欄位(文字)009
       sfdcud010 LIKE sfdc_t.sfdcud010, #自定義欄位(文字)010
       sfdcud011 LIKE sfdc_t.sfdcud011, #自定義欄位(數字)011
       sfdcud012 LIKE sfdc_t.sfdcud012, #自定義欄位(數字)012
       sfdcud013 LIKE sfdc_t.sfdcud013, #自定義欄位(數字)013
       sfdcud014 LIKE sfdc_t.sfdcud014, #自定義欄位(數字)014
       sfdcud015 LIKE sfdc_t.sfdcud015, #自定義欄位(數字)015
       sfdcud016 LIKE sfdc_t.sfdcud016, #自定義欄位(數字)016
       sfdcud017 LIKE sfdc_t.sfdcud017, #自定義欄位(數字)017
       sfdcud018 LIKE sfdc_t.sfdcud018, #自定義欄位(數字)018
       sfdcud019 LIKE sfdc_t.sfdcud019, #自定義欄位(數字)019
       sfdcud020 LIKE sfdc_t.sfdcud020, #自定義欄位(數字)020
       sfdcud021 LIKE sfdc_t.sfdcud021, #自定義欄位(日期時間)021
       sfdcud022 LIKE sfdc_t.sfdcud022, #自定義欄位(日期時間)022
       sfdcud023 LIKE sfdc_t.sfdcud023, #自定義欄位(日期時間)023
       sfdcud024 LIKE sfdc_t.sfdcud024, #自定義欄位(日期時間)024
       sfdcud025 LIKE sfdc_t.sfdcud025, #自定義欄位(日期時間)025
       sfdcud026 LIKE sfdc_t.sfdcud026, #自定義欄位(日期時間)026
       sfdcud027 LIKE sfdc_t.sfdcud027, #自定義欄位(日期時間)027
       sfdcud028 LIKE sfdc_t.sfdcud028, #自定義欄位(日期時間)028
       sfdcud029 LIKE sfdc_t.sfdcud029, #自定義欄位(日期時間)029
       sfdcud030 LIKE sfdc_t.sfdcud030  #自定義欄位(日期時間)030
       #161109-00085#62 --e add
   END RECORD   
   
   #DEFINE l_sfdd      RECORD LIKE sfdd_t.*
   DEFINE l_sfdd RECORD  #發退料明細檔
       sfddent LIKE sfdd_t.sfddent, #企業編號
       sfddsite LIKE sfdd_t.sfddsite, #營運據點
       sfdddocno LIKE sfdd_t.sfdddocno, #發退料單號
       sfddseq LIKE sfdd_t.sfddseq, #項次
       sfddseq1 LIKE sfdd_t.sfddseq1, #項序
       sfdd001 LIKE sfdd_t.sfdd001, #發退料料號
       sfdd002 LIKE sfdd_t.sfdd002, #替代率
       sfdd003 LIKE sfdd_t.sfdd003, #庫位
       sfdd004 LIKE sfdd_t.sfdd004, #儲位
       sfdd005 LIKE sfdd_t.sfdd005, #批號
       sfdd006 LIKE sfdd_t.sfdd006, #單位
       sfdd007 LIKE sfdd_t.sfdd007, #數量
       sfdd008 LIKE sfdd_t.sfdd008, #參考單位
       sfdd009 LIKE sfdd_t.sfdd009, #參考單位數量
       sfdd010 LIKE sfdd_t.sfdd010, #庫存管理特徵
       sfdd011 LIKE sfdd_t.sfdd011, #包裝容器
       sfdd012 LIKE sfdd_t.sfdd012, #正負
       sfdd013 LIKE sfdd_t.sfdd013, #產品特徵
       #161109-00085#62 --s add
       sfddud001 LIKE sfdd_t.sfddud001, #自定義欄位(文字)001
       sfddud002 LIKE sfdd_t.sfddud002, #自定義欄位(文字)002
       sfddud003 LIKE sfdd_t.sfddud003, #自定義欄位(文字)003
       sfddud004 LIKE sfdd_t.sfddud004, #自定義欄位(文字)004
       sfddud005 LIKE sfdd_t.sfddud005, #自定義欄位(文字)005
       sfddud006 LIKE sfdd_t.sfddud006, #自定義欄位(文字)006
       sfddud007 LIKE sfdd_t.sfddud007, #自定義欄位(文字)007
       sfddud008 LIKE sfdd_t.sfddud008, #自定義欄位(文字)008
       sfddud009 LIKE sfdd_t.sfddud009, #自定義欄位(文字)009
       sfddud010 LIKE sfdd_t.sfddud010, #自定義欄位(文字)010
       sfddud011 LIKE sfdd_t.sfddud011, #自定義欄位(數字)011
       sfddud012 LIKE sfdd_t.sfddud012, #自定義欄位(數字)012
       sfddud013 LIKE sfdd_t.sfddud013, #自定義欄位(數字)013
       sfddud014 LIKE sfdd_t.sfddud014, #自定義欄位(數字)014
       sfddud015 LIKE sfdd_t.sfddud015, #自定義欄位(數字)015
       sfddud016 LIKE sfdd_t.sfddud016, #自定義欄位(數字)016
       sfddud017 LIKE sfdd_t.sfddud017, #自定義欄位(數字)017
       sfddud018 LIKE sfdd_t.sfddud018, #自定義欄位(數字)018
       sfddud019 LIKE sfdd_t.sfddud019, #自定義欄位(數字)019
       sfddud020 LIKE sfdd_t.sfddud020, #自定義欄位(數字)020
       sfddud021 LIKE sfdd_t.sfddud021, #自定義欄位(日期時間)021
       sfddud022 LIKE sfdd_t.sfddud022, #自定義欄位(日期時間)022
       sfddud023 LIKE sfdd_t.sfddud023, #自定義欄位(日期時間)023
       sfddud024 LIKE sfdd_t.sfddud024, #自定義欄位(日期時間)024
       sfddud025 LIKE sfdd_t.sfddud025, #自定義欄位(日期時間)025
       sfddud026 LIKE sfdd_t.sfddud026, #自定義欄位(日期時間)026
       sfddud027 LIKE sfdd_t.sfddud027, #自定義欄位(日期時間)027
       sfddud028 LIKE sfdd_t.sfddud028, #自定義欄位(日期時間)028
       sfddud029 LIKE sfdd_t.sfddud029, #自定義欄位(日期時間)029
       sfddud030 LIKE sfdd_t.sfddud030, #自定義欄位(日期時間)030
       #161109-00085#62 --e add
       sfdd014 LIKE sfdd_t.sfdd014, #備置量
       sfdd015 LIKE sfdd_t.sfdd015  #在揀量
   END RECORD

   #DEFINE l_sfde      RECORD LIKE sfde_t.*
   
   DEFINE l_sfde RECORD  #發退料需求匯總檔
       sfdeent LIKE sfde_t.sfdeent, #企業編號
       sfdesite LIKE sfde_t.sfdesite, #營運據點
       sfdedocno LIKE sfde_t.sfdedocno, #發退料單號
       sfdeseq LIKE sfde_t.sfdeseq, #項次
       sfde001 LIKE sfde_t.sfde001, #需求料號
       sfde002 LIKE sfde_t.sfde002, #產品特徵
       sfde003 LIKE sfde_t.sfde003, #單位
       sfde004 LIKE sfde_t.sfde004, #申請數量
       sfde005 LIKE sfde_t.sfde005, #實際數量
       sfde006 LIKE sfde_t.sfde006, #參考單位
       sfde007 LIKE sfde_t.sfde007, #參考單位申請數量
       sfde008 LIKE sfde_t.sfde008, #參考單位實際數量
       sfde009 LIKE sfde_t.sfde009, #客供料
      #sfde010 LIKE sfde_t.sfde010  #正負 #161109-00085#62 mark
       #161109-00085#62 --s add
       sfde010 LIKE sfde_t.sfde010, #正負
       sfdeud001 LIKE sfde_t.sfdeud001, #自定義欄位(文字)001
       sfdeud002 LIKE sfde_t.sfdeud002, #自定義欄位(文字)002
       sfdeud003 LIKE sfde_t.sfdeud003, #自定義欄位(文字)003
       sfdeud004 LIKE sfde_t.sfdeud004, #自定義欄位(文字)004
       sfdeud005 LIKE sfde_t.sfdeud005, #自定義欄位(文字)005
       sfdeud006 LIKE sfde_t.sfdeud006, #自定義欄位(文字)006
       sfdeud007 LIKE sfde_t.sfdeud007, #自定義欄位(文字)007
       sfdeud008 LIKE sfde_t.sfdeud008, #自定義欄位(文字)008
       sfdeud009 LIKE sfde_t.sfdeud009, #自定義欄位(文字)009
       sfdeud010 LIKE sfde_t.sfdeud010, #自定義欄位(文字)010
       sfdeud011 LIKE sfde_t.sfdeud011, #自定義欄位(數字)011
       sfdeud012 LIKE sfde_t.sfdeud012, #自定義欄位(數字)012
       sfdeud013 LIKE sfde_t.sfdeud013, #自定義欄位(數字)013
       sfdeud014 LIKE sfde_t.sfdeud014, #自定義欄位(數字)014
       sfdeud015 LIKE sfde_t.sfdeud015, #自定義欄位(數字)015
       sfdeud016 LIKE sfde_t.sfdeud016, #自定義欄位(數字)016
       sfdeud017 LIKE sfde_t.sfdeud017, #自定義欄位(數字)017
       sfdeud018 LIKE sfde_t.sfdeud018, #自定義欄位(數字)018
       sfdeud019 LIKE sfde_t.sfdeud019, #自定義欄位(數字)019
       sfdeud020 LIKE sfde_t.sfdeud020, #自定義欄位(數字)020
       sfdeud021 LIKE sfde_t.sfdeud021, #自定義欄位(日期時間)021
       sfdeud022 LIKE sfde_t.sfdeud022, #自定義欄位(日期時間)022
       sfdeud023 LIKE sfde_t.sfdeud023, #自定義欄位(日期時間)023
       sfdeud024 LIKE sfde_t.sfdeud024, #自定義欄位(日期時間)024
       sfdeud025 LIKE sfde_t.sfdeud025, #自定義欄位(日期時間)025
       sfdeud026 LIKE sfde_t.sfdeud026, #自定義欄位(日期時間)026
       sfdeud027 LIKE sfde_t.sfdeud027, #自定義欄位(日期時間)027
       sfdeud028 LIKE sfde_t.sfdeud028, #自定義欄位(日期時間)028
       sfdeud029 LIKE sfde_t.sfdeud029, #自定義欄位(日期時間)029
       sfdeud030 LIKE sfde_t.sfdeud030  #自定義欄位(日期時間)030
       #161109-00085#62 --e add
   END RECORD
   
   #DEFINE l_sfdf      RECORD LIKE sfdf_t.*
   DEFINE l_sfdf RECORD  #發退料倉儲批匯總檔
       sfdfent LIKE sfdf_t.sfdfent, #企業編號
       sfdfsite LIKE sfdf_t.sfdfsite, #營運據點
       sfdfdocno LIKE sfdf_t.sfdfdocno, #發退料單號
       sfdfseq LIKE sfdf_t.sfdfseq, #項次
       sfdfseq1 LIKE sfdf_t.sfdfseq1, #項序
       sfdf001 LIKE sfdf_t.sfdf001, #發退料料號
       sfdf002 LIKE sfdf_t.sfdf002, #替代率
       sfdf003 LIKE sfdf_t.sfdf003, #庫位
       sfdf004 LIKE sfdf_t.sfdf004, #儲位
       sfdf005 LIKE sfdf_t.sfdf005, #批號
       sfdf006 LIKE sfdf_t.sfdf006, #單位
       sfdf007 LIKE sfdf_t.sfdf007, #數量
       sfdf008 LIKE sfdf_t.sfdf008, #參考單位
       sfdf009 LIKE sfdf_t.sfdf009, #參考單位數量
       sfdf010 LIKE sfdf_t.sfdf010, #庫存管理特徵
       sfdf011 LIKE sfdf_t.sfdf011, #包裝容器
       sfdf012 LIKE sfdf_t.sfdf012, #正負
      #sfdf013 LIKE sfdf_t.sfdf013  #產品特徵 #161109-00085#62 mark
       #161109-00085#62 --s add
       sfdf013 LIKE sfdf_t.sfdf013, #產品特徵
       sfdfud001 LIKE sfdf_t.sfdfud001, #自定義欄位(文字)001
       sfdfud002 LIKE sfdf_t.sfdfud002, #自定義欄位(文字)002
       sfdfud003 LIKE sfdf_t.sfdfud003, #自定義欄位(文字)003
       sfdfud004 LIKE sfdf_t.sfdfud004, #自定義欄位(文字)004
       sfdfud005 LIKE sfdf_t.sfdfud005, #自定義欄位(文字)005
       sfdfud006 LIKE sfdf_t.sfdfud006, #自定義欄位(文字)006
       sfdfud007 LIKE sfdf_t.sfdfud007, #自定義欄位(文字)007
       sfdfud008 LIKE sfdf_t.sfdfud008, #自定義欄位(文字)008
       sfdfud009 LIKE sfdf_t.sfdfud009, #自定義欄位(文字)009
       sfdfud010 LIKE sfdf_t.sfdfud010, #自定義欄位(文字)010
       sfdfud011 LIKE sfdf_t.sfdfud011, #自定義欄位(數字)011
       sfdfud012 LIKE sfdf_t.sfdfud012, #自定義欄位(數字)012
       sfdfud013 LIKE sfdf_t.sfdfud013, #自定義欄位(數字)013
       sfdfud014 LIKE sfdf_t.sfdfud014, #自定義欄位(數字)014
       sfdfud015 LIKE sfdf_t.sfdfud015, #自定義欄位(數字)015
       sfdfud016 LIKE sfdf_t.sfdfud016, #自定義欄位(數字)016
       sfdfud017 LIKE sfdf_t.sfdfud017, #自定義欄位(數字)017
       sfdfud018 LIKE sfdf_t.sfdfud018, #自定義欄位(數字)018
       sfdfud019 LIKE sfdf_t.sfdfud019, #自定義欄位(數字)019
       sfdfud020 LIKE sfdf_t.sfdfud020, #自定義欄位(數字)020
       sfdfud021 LIKE sfdf_t.sfdfud021, #自定義欄位(日期時間)021
       sfdfud022 LIKE sfdf_t.sfdfud022, #自定義欄位(日期時間)022
       sfdfud023 LIKE sfdf_t.sfdfud023, #自定義欄位(日期時間)023
       sfdfud024 LIKE sfdf_t.sfdfud024, #自定義欄位(日期時間)024
       sfdfud025 LIKE sfdf_t.sfdfud025, #自定義欄位(日期時間)025
       sfdfud026 LIKE sfdf_t.sfdfud026, #自定義欄位(日期時間)026
       sfdfud027 LIKE sfdf_t.sfdfud027, #自定義欄位(日期時間)027
       sfdfud028 LIKE sfdf_t.sfdfud028, #自定義欄位(日期時間)028
       sfdfud029 LIKE sfdf_t.sfdfud029, #自定義欄位(日期時間)029
       sfdfud030 LIKE sfdf_t.sfdfud030  #自定義欄位(日期時間)030
       #161109-00085#62 --e add
   END RECORD   
   
   #DEFINE l_sfja      RECORD LIKE sfja_t.*
   #DEFINE l_sfjb      RECORD LIKE sfjb_t.*
   #DEFINE l_sfjc      RECORD LIKE sfjc_t.*
   DEFINE l_sfjc RECORD  #工單下階料報廢明細檔
       sfjcent LIKE sfjc_t.sfjcent, #企業編號      
       sfjcsite LIKE sfjc_t.sfjcsite, #營運據點
       sfjcdocno LIKE sfjc_t.sfjcdocno, #報廢單號
       sfjcseq LIKE sfjc_t.sfjcseq, #項次
       sfjcseq1 LIKE sfjc_t.sfjcseq1, #項序
       sfjc001 LIKE sfjc_t.sfjc001, #工單單號
       sfjc002 LIKE sfjc_t.sfjc002, #工單項次
       sfjc003 LIKE sfjc_t.sfjc003, #料件編號
       sfjc004 LIKE sfjc_t.sfjc004, #產品特徵
       sfjc005 LIKE sfjc_t.sfjc005, #單位
       sfjc006 LIKE sfjc_t.sfjc006, #報廢數量
       sfjc007 LIKE sfjc_t.sfjc007, #參考單位
       sfjc008 LIKE sfjc_t.sfjc008, #參考數量
       sfjc009 LIKE sfjc_t.sfjc009, #理由碼
       sfjc010 LIKE sfjc_t.sfjc010, #預計處理方式
       sfjc011 LIKE sfjc_t.sfjc011, #庫位
       sfjc012 LIKE sfjc_t.sfjc012, #儲位
       sfjc013 LIKE sfjc_t.sfjc013, #批號
       sfjc014 LIKE sfjc_t.sfjc014, #庫存管理特徵
       sfjc015 LIKE sfjc_t.sfjc015, #工單項序
       #161109-00085#62 --s add         
       sfjcud001 LIKE sfjc_t.sfjcud001, #自定義欄位(文字)001
       sfjcud002 LIKE sfjc_t.sfjcud002, #自定義欄位(文字)002
       sfjcud003 LIKE sfjc_t.sfjcud003, #自定義欄位(文字)003
       sfjcud004 LIKE sfjc_t.sfjcud004, #自定義欄位(文字)004
       sfjcud005 LIKE sfjc_t.sfjcud005, #自定義欄位(文字)005
       sfjcud006 LIKE sfjc_t.sfjcud006, #自定義欄位(文字)006
       sfjcud007 LIKE sfjc_t.sfjcud007, #自定義欄位(文字)007
       sfjcud008 LIKE sfjc_t.sfjcud008, #自定義欄位(文字)008
       sfjcud009 LIKE sfjc_t.sfjcud009, #自定義欄位(文字)009
       sfjcud010 LIKE sfjc_t.sfjcud010, #自定義欄位(文字)010
       sfjcud011 LIKE sfjc_t.sfjcud011, #自定義欄位(數字)011
       sfjcud012 LIKE sfjc_t.sfjcud012, #自定義欄位(數字)012
       sfjcud013 LIKE sfjc_t.sfjcud013, #自定義欄位(數字)013
       sfjcud014 LIKE sfjc_t.sfjcud014, #自定義欄位(數字)014
       sfjcud015 LIKE sfjc_t.sfjcud015, #自定義欄位(數字)015
       sfjcud016 LIKE sfjc_t.sfjcud016, #自定義欄位(數字)016
       sfjcud017 LIKE sfjc_t.sfjcud017, #自定義欄位(數字)017
       sfjcud018 LIKE sfjc_t.sfjcud018, #自定義欄位(數字)018
       sfjcud019 LIKE sfjc_t.sfjcud019, #自定義欄位(數字)019
       sfjcud020 LIKE sfjc_t.sfjcud020, #自定義欄位(數字)020
       sfjcud021 LIKE sfjc_t.sfjcud021, #自定義欄位(日期時間)021
       sfjcud022 LIKE sfjc_t.sfjcud022, #自定義欄位(日期時間)022
       sfjcud023 LIKE sfjc_t.sfjcud023, #自定義欄位(日期時間)023
       sfjcud024 LIKE sfjc_t.sfjcud024, #自定義欄位(日期時間)024
       sfjcud025 LIKE sfjc_t.sfjcud025, #自定義欄位(日期時間)025
       sfjcud026 LIKE sfjc_t.sfjcud026, #自定義欄位(日期時間)026
       sfjcud027 LIKE sfjc_t.sfjcud027, #自定義欄位(日期時間)027
       sfjcud028 LIKE sfjc_t.sfjcud028, #自定義欄位(日期時間)028
       sfjcud029 LIKE sfjc_t.sfjcud029, #自定義欄位(日期時間)029
       sfjcud030 LIKE sfjc_t.sfjcud030, #自定義欄位(日期時間)030
       #161109-00085#62 --e add
       sfjc016 LIKE sfjc_t.sfjc016, #生產料號
       sfjc017 LIKE sfjc_t.sfjc017, #BOM特性
       sfjc018 LIKE sfjc_t.sfjc018, #產品特徵
       sfjc019 LIKE sfjc_t.sfjc019  #生產計劃
   END RECORD
   #161109-00085#32-e  
   
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5

   LET r_success = TRUE
   #检查事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #161109-00085#32-s
   #INITIALIZE l_sfja.* TO NULL
   #INITIALIZE l_sfjb.* TO NULL
   #161109-00085#32-e   
   INITIALIZE l_sfjc.* TO NULL
   INITIALIZE l_sfda.* TO NULL
   INITIALIZE l_sfdc.* TO NULL
   INITIALIZE l_sfdd.* TO NULL
   INITIALIZE l_sfde.* TO NULL
   INITIALIZE l_sfdf.* TO NULL
   

#先插单头
   #161109-00085#32-s
   #SELECT * INTO l_sfja.*
   #  FROM sfja_t
   # WHERE sfjaent   = g_enterprise
   #   AND sfjasite  = g_site
   #   AND sfjadocno = g_sfjadocno
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'sel sfja_t'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #161109-00085#32-e   
   
   LET l_sfda.sfdaent   = g_enterprise               #企業編號    #161109-00085#32
   LET l_sfda.sfdasite  = g_site                     #營運據點    #161109-00085#32
   LET l_sfda.sfdadocno = g_inba_m.sfdadocno         #發退料單號  
   LET l_sfda.sfdadocdt = g_today                    #單據日期    
   LET l_sfda.sfda001   = ''                         #過帳日期    
   LET l_sfda.sfda002   = '23'                       #發退料類別  
   LET l_sfda.sfda003   = g_dept                     #生產部門    
   LET l_sfda.sfda004   = g_user                     #申請人      
   LET l_sfda.sfda005   = ''                         #PBI編號     
   LET l_sfda.sfda006   = ''                         #生產料號    
   LET l_sfda.sfda007   = ''                         #BOM特性     
   LET l_sfda.sfda008   = ''                         #產品特徵    
   LET l_sfda.sfda009   = ''                         #生產控制組  
   LET l_sfda.sfda010   = ''                         #作業編號    
   LET l_sfda.sfda011   = ''                         #作業序      
   LET l_sfda.sfda012   = ''                         #庫位        
   LET l_sfda.sfda013   = ''                         #套數        
   LET l_sfda.sfda014   = g_sfjadocno                #來源單號    #161109-00085#32
   LET l_sfda.sfda015   = '04'                       #來源類型    
   LET l_sfda.sfdaownid = g_user                     #資料所有者  
   LET l_sfda.sfdaowndp = g_dept                     #資料所屬部門
   LET l_sfda.sfdacrtid = g_user                     #資料建立者  
   LET l_sfda.sfdacrtdp = g_dept                     #資料建立部門
   LET l_sfda.sfdacrtdt = g_today                    #資料創建日  
   LET l_sfda.sfdamodid = ''                         #資料修改者
   LET l_sfda.sfdamoddt = ''                         #最近修改日
   LET l_sfda.sfdacnfid = ''                         #資料確認者
   LET l_sfda.sfdacnfdt = ''                         #資料確認日
   LET l_sfda.sfdapstid = ''                         #資料過帳者
   LET l_sfda.sfdapstdt = ''                         #資料過帳日
   LET l_sfda.sfdastus  = 'N'                        #狀態碼      
   #161109-00085#62 --s add
   LET l_sfda.sfdaud001 = ''
   LET l_sfda.sfdaud002 = ''
   LET l_sfda.sfdaud003 = ''
   LET l_sfda.sfdaud004 = ''
   LET l_sfda.sfdaud005 = ''
   LET l_sfda.sfdaud006 = ''
   LET l_sfda.sfdaud007 = ''
   LET l_sfda.sfdaud008 = ''
   LET l_sfda.sfdaud009 = ''
   LET l_sfda.sfdaud010 = ''
   LET l_sfda.sfdaud011 = ''
   LET l_sfda.sfdaud012 = ''
   LET l_sfda.sfdaud013 = ''
   LET l_sfda.sfdaud014 = ''
   LET l_sfda.sfdaud015 = ''
   LET l_sfda.sfdaud016 = ''
   LET l_sfda.sfdaud017 = ''
   LET l_sfda.sfdaud018 = ''
   LET l_sfda.sfdaud019 = ''
   LET l_sfda.sfdaud020 = ''
   LET l_sfda.sfdaud021 = ''
   LET l_sfda.sfdaud022 = ''
   LET l_sfda.sfdaud023 = ''
   LET l_sfda.sfdaud024 = ''
   LET l_sfda.sfdaud025 = ''
   LET l_sfda.sfdaud026 = ''
   LET l_sfda.sfdaud027 = ''
   LET l_sfda.sfdaud028 = ''
   LET l_sfda.sfdaud029 = ''
   LET l_sfda.sfdaud030 = ''
   #161109-00085#62 --e add
   #161109-00085#32-s
   #INSERT INTO sfda_t VALUES(l_sfda.*)
   #161109-00085#62 --s mark
   #INSERT INTO sfda_t(sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda005,sfda006,
   #                   sfda007,sfda008,sfda009,sfda010,sfda011,sfda012,sfda013,sfda014,sfda015,sfdaownid,
   #                   sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdacnfid,sfdacnfdt,sfdapstid,sfdapstdt,
   #                   sfdastus) 
   #VALUES(l_sfda.sfdaent,l_sfda.sfdasite,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,
   #       l_sfda.sfda002,l_sfda.sfda003,l_sfda.sfda004,l_sfda.sfda005,l_sfda.sfda006,
   #       l_sfda.sfda007,l_sfda.sfda008,l_sfda.sfda009,l_sfda.sfda010,l_sfda.sfda011,
   #       l_sfda.sfda012,l_sfda.sfda013,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,
   #       l_sfda.sfdaowndp,l_sfda.sfdacrtid,l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,
   #       l_sfda.sfdamoddt,l_sfda.sfdacnfid,l_sfda.sfdacnfdt,l_sfda.sfdapstid,l_sfda.sfdapstdt,
   #       l_sfda.sfdastus)
   #161109-00085#62 --e mark
   #161109-00085#62 --s add
   INSERT INTO sfda_t(sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,
                      sfda002,sfda003,sfda004,sfda005,sfda006,
                      sfda007,sfda008,sfda009,sfda010,sfda011,
                      sfda012,sfda013,sfda014,sfda015,sfdaownid,
                      sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,
                      sfdamoddt,sfdacnfid,sfdacnfdt,sfdapstid,sfdapstdt,
                      sfdastus,sfdaud001,sfdaud002,sfdaud003,sfdaud004,
                      sfdaud005,sfdaud006,sfdaud007,sfdaud008,sfdaud009,
                      sfdaud010,sfdaud011,sfdaud012,sfdaud013,sfdaud014,
                      sfdaud015,sfdaud016,sfdaud017,sfdaud018,sfdaud019,
                      sfdaud020,sfdaud021,sfdaud022,sfdaud023,sfdaud024,
                      sfdaud025,sfdaud026,sfdaud027,sfdaud028,sfdaud029,
                      sfdaud030)
   VALUES(l_sfda.sfdaent,l_sfda.sfdasite,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,
          l_sfda.sfda002,l_sfda.sfda003,l_sfda.sfda004,l_sfda.sfda005,l_sfda.sfda006,
          l_sfda.sfda007,l_sfda.sfda008,l_sfda.sfda009,l_sfda.sfda010,l_sfda.sfda011,
          l_sfda.sfda012,l_sfda.sfda013,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,
          l_sfda.sfdaowndp,l_sfda.sfdacrtid,l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,
          l_sfda.sfdamoddt,l_sfda.sfdacnfid,l_sfda.sfdacnfdt,l_sfda.sfdapstid,l_sfda.sfdapstdt,
          l_sfda.sfdastus,l_sfda.sfdaud001,l_sfda.sfdaud002,l_sfda.sfdaud003,l_sfda.sfdaud004,
          l_sfda.sfdaud005,l_sfda.sfdaud006,l_sfda.sfdaud007,l_sfda.sfdaud008,l_sfda.sfdaud009,
          l_sfda.sfdaud010,l_sfda.sfdaud011,l_sfda.sfdaud012,l_sfda.sfdaud013,l_sfda.sfdaud014,
          l_sfda.sfdaud015,l_sfda.sfdaud016,l_sfda.sfdaud017,l_sfda.sfdaud018,l_sfda.sfdaud019,
          l_sfda.sfdaud020,l_sfda.sfdaud021,l_sfda.sfdaud022,l_sfda.sfdaud023,l_sfda.sfdaud024,
          l_sfda.sfdaud025,l_sfda.sfdaud026,l_sfda.sfdaud027,l_sfda.sfdaud028,l_sfda.sfdaud029,
          l_sfda.sfdaud030)
   #161109-00085#62 --e add
   #161109-00085#32-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfda'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

#再插各个单身
#取sfjc没错，是SA要求的
   #161109-00085#32-s
   #效能優化－刪除內容一樣的asft339_01_sel_sfjc_cs3
   DECLARE asft339_01_sel_sfjc_cs2 CURSOR FOR
      #SELECT * FROM sfjc_t
      #161109-00085#62 --s mark
      #SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,sfjc004,sfjc005,
      #       sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,sfjc013,sfjc014,sfjc015,
      #       sfjc016,sfjc017,sfjc018,sfjc019 
      #161109-00085#62 --e mark
      #161109-00085#62 --s add
      SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,
             sfjc001,sfjc002,sfjc003,sfjc004,sfjc005,
             sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,
             sfjc011,sfjc012,sfjc013,sfjc014,sfjc015,
             sfjcud001,sfjcud002,sfjcud003,sfjcud004,sfjcud005,
             sfjcud006,sfjcud007,sfjcud008,sfjcud009,sfjcud010,
             sfjcud011,sfjcud012,sfjcud013,sfjcud014,sfjcud015,
             sfjcud016,sfjcud017,sfjcud018,sfjcud019,sfjcud020,
             sfjcud021,sfjcud022,sfjcud023,sfjcud024,sfjcud025,
             sfjcud026,sfjcud027,sfjcud028,sfjcud029,sfjcud030,
             sfjc016,sfjc017,sfjc018,sfjc019
      #161109-00085#62 --e add
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = g_sfjadocno
         AND sfjc010   = '3'
   #FOREACH asft339_01_sel_sfjc_cs2 INTO l_sfjc.*
   FOREACH asft339_01_sel_sfjc_cs2 
      INTO l_sfjc.sfjcent,l_sfjc.sfjcsite,l_sfjc.sfjcdocno,l_sfjc.sfjcseq,l_sfjc.sfjcseq1,
           l_sfjc.sfjc001,l_sfjc.sfjc002,l_sfjc.sfjc003,l_sfjc.sfjc004,l_sfjc.sfjc005,
           l_sfjc.sfjc006,l_sfjc.sfjc007,l_sfjc.sfjc008,l_sfjc.sfjc009,l_sfjc.sfjc010,
           l_sfjc.sfjc011,l_sfjc.sfjc012,l_sfjc.sfjc013,l_sfjc.sfjc014,l_sfjc.sfjc015,
           #161109-00085#62 --s add
           l_sfjc.sfjcud001,l_sfjc.sfjcud002,l_sfjc.sfjcud003,l_sfjc.sfjcud004,l_sfjc.sfjcud005,
           l_sfjc.sfjcud006,l_sfjc.sfjcud007,l_sfjc.sfjcud008,l_sfjc.sfjcud009,l_sfjc.sfjcud010,
           l_sfjc.sfjcud011,l_sfjc.sfjcud012,l_sfjc.sfjcud013,l_sfjc.sfjcud014,l_sfjc.sfjcud015,
           l_sfjc.sfjcud016,l_sfjc.sfjcud017,l_sfjc.sfjcud018,l_sfjc.sfjcud019,l_sfjc.sfjcud020,
           l_sfjc.sfjcud021,l_sfjc.sfjcud022,l_sfjc.sfjcud023,l_sfjc.sfjcud024,l_sfjc.sfjcud025,
           l_sfjc.sfjcud026,l_sfjc.sfjcud027,l_sfjc.sfjcud028,l_sfjc.sfjcud029,l_sfjc.sfjcud030,
           #161109-00085#62 --e add
           l_sfjc.sfjc016,l_sfjc.sfjc017,l_sfjc.sfjc018,l_sfjc.sfjc019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_sfdc.sfdcent   = l_sfjc.sfjcent           #企業編號        
      LET l_sfdc.sfdcsite  = l_sfjc.sfjcsite          #營運據點        
      LET l_sfdc.sfdcdocno = g_inba_m.sfdadocno       #發退料單號      
      LET l_sfdc.sfdcseq   = l_sfjc.sfjcseq           #項次            
      LET l_sfdc.sfdc001   = l_sfjc.sfjc001           #工單單號        
      LET l_sfdc.sfdc002   = l_sfjc.sfjc002           #工單項次        
      LET l_sfdc.sfdc003   = l_sfjc.sfjc015           #工單項序        
      LET l_sfdc.sfdc004   = l_sfjc.sfjc003           #需求料號        
      LET l_sfdc.sfdc005   = l_sfjc.sfjc004           #特徵            
      LET l_sfdc.sfdc006   = l_sfjc.sfjc005           #單位            
      LET l_sfdc.sfdc007   = l_sfjc.sfjc006           #申請數量        
      LET l_sfdc.sfdc008   = l_sfjc.sfjc006           #實際數量        
      LET l_sfdc.sfdc009   = l_sfjc.sfjc007           #參考單位        
      LET l_sfdc.sfdc010   = l_sfjc.sfjc008           #參考單位需求數量
      LET l_sfdc.sfdc011   = l_sfjc.sfjc008           #參考單位實際數量
      LET l_sfdc.sfdc012   = l_sfjc.sfjc011           #指定庫位        
      LET l_sfdc.sfdc013   = l_sfjc.sfjc012           #指定儲位        
      LET l_sfdc.sfdc014   = l_sfjc.sfjc013           #指定批號        
      LET l_sfdc.sfdc015   = l_sfjc.sfjc009           #理由碼          
      LET l_sfdc.sfdc016   = l_sfjc.sfjc014           #庫存管理特徴    
      LET l_sfdc.sfdc017   = '1'                      #正負            
      #INSERT INTO sfdc_t VALUES(l_sfdc.*)
      #161109-00085#62 --s mark
      #INSERT INTO sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
      #                   sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
      #                   sfdc017) 
      #VALUES(l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
      #       l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
      #       l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
      #       l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
      #       l_sfdc.sfdc017)
      #161109-00085#62 --e mark  
      #161109-00085#62 --s add
      INSERT INTO sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
                         sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
                         sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
                         sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
                         sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
                         sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
                         sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
                         sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
                         sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
                         sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
                         sfdcud030)
      VALUES(l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
             l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
             l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
             l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
             l_sfdc.sfdc017,l_sfdc.sfdcud001,l_sfdc.sfdcud002,l_sfdc.sfdcud003,l_sfdc.sfdcud004,
             l_sfdc.sfdcud005,l_sfdc.sfdcud006,l_sfdc.sfdcud007,l_sfdc.sfdcud008,l_sfdc.sfdcud009,
             l_sfdc.sfdcud010,l_sfdc.sfdcud011,l_sfdc.sfdcud012,l_sfdc.sfdcud013,l_sfdc.sfdcud014,
             l_sfdc.sfdcud015,l_sfdc.sfdcud016,l_sfdc.sfdcud017,l_sfdc.sfdcud018,l_sfdc.sfdcud019,
             l_sfdc.sfdcud020,l_sfdc.sfdcud021,l_sfdc.sfdcud022,l_sfdc.sfdcud023,l_sfdc.sfdcud024,
             l_sfdc.sfdcud025,l_sfdc.sfdcud026,l_sfdc.sfdcud027,l_sfdc.sfdcud028,l_sfdc.sfdcud029,
             l_sfdc.sfdcud030)
      #161109-00085#62 --e add      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdc'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #add 150921 begin
      CALL asft339_01_ins_lot(l_sfjc.sfjcdocno,l_sfjc.sfjcseq,l_sfjc.sfjcseq1,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,0,'1')
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #add 150921 end
      
      #sfdd对应sfjc
      LET l_sfdd.sfddent   = l_sfjc.sfjcent             #企業編號    
      LET l_sfdd.sfddsite  = l_sfjc.sfjcsite            #營運據點    
      LET l_sfdd.sfdddocno = g_inba_m.sfdadocno         #發退料單號  
      LET l_sfdd.sfddseq   = l_sfjc.sfjcseq             #項次        
      LET l_sfdd.sfddseq1  = l_sfjc.sfjcseq1            #項序        
      LET l_sfdd.sfdd001   = l_sfjc.sfjc003             #發退料料號  
      LET l_sfdd.sfdd002   = '1'                        #替代率      
      LET l_sfdd.sfdd003   = l_sfjc.sfjc011             #庫位        
      LET l_sfdd.sfdd004   = l_sfjc.sfjc012             #儲位        
      LET l_sfdd.sfdd005   = l_sfjc.sfjc013             #批號        
      LET l_sfdd.sfdd006   = l_sfjc.sfjc005             #單位        
      LET l_sfdd.sfdd007   = l_sfjc.sfjc006             #數量        
      LET l_sfdd.sfdd008   = l_sfjc.sfjc007             #參考單位    
      LET l_sfdd.sfdd009   = l_sfjc.sfjc008             #參考單位數量
      LET l_sfdd.sfdd010   = l_sfjc.sfjc014             #庫存管理特徵
      LET l_sfdd.sfdd011   = ''                         #包裝容器    
      LET l_sfdd.sfdd012   = '1'                        #正負 
      LET l_sfdd.sfdd013   = l_sfjc.sfjc004             #产品特征             
      #INSERT INTO sfdd_t VALUES(l_sfdd.*)
      #161109-00085#62 --s mark
      #INSERT INTO sfdd_t(sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,sfdd001,sfdd002,sfdd003,sfdd004,sfdd005,
      #                   sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,sfdd011,sfdd012,sfdd013,sfdd014,sfdd015) 
      #VALUES(l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,
      #       l_sfdd.sfdd001,l_sfdd.sfdd002,l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,
      #       l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
      #       l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfdd014,l_sfdd.sfdd015)
      #161109-00085#62 --e mark
      #161109-00085#62 --s add
      INSERT INTO sfdd_t(sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,
                         sfdd001,sfdd002,sfdd003,sfdd004,sfdd005,
                         sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,
                         sfdd011,sfdd012,sfdd013,sfddud001,sfddud002,
                         sfddud003,sfddud004,sfddud005,sfddud006,sfddud007,
                         sfddud008,sfddud009,sfddud010,sfddud011,sfddud012,
                         sfddud013,sfddud014,sfddud015,sfddud016,sfddud017,
                         sfddud018,sfddud019,sfddud020,sfddud021,sfddud022,
                         sfddud023,sfddud024,sfddud025,sfddud026,sfddud027,
                         sfddud028,sfddud029,sfddud030,sfdd014,sfdd015)
      VALUES(l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,
             l_sfdd.sfdd001,l_sfdd.sfdd002,l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,
             l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
             l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfddud001,l_sfdd.sfddud002,
             l_sfdd.sfddud003,l_sfdd.sfddud004,l_sfdd.sfddud005,l_sfdd.sfddud006,l_sfdd.sfddud007,
             l_sfdd.sfddud008,l_sfdd.sfddud009,l_sfdd.sfddud010,l_sfdd.sfddud011,l_sfdd.sfddud012,
             l_sfdd.sfddud013,l_sfdd.sfddud014,l_sfdd.sfddud015,l_sfdd.sfddud016,l_sfdd.sfddud017,
             l_sfdd.sfddud018,l_sfdd.sfddud019,l_sfdd.sfddud020,l_sfdd.sfddud021,l_sfdd.sfddud022,
             l_sfdd.sfddud023,l_sfdd.sfddud024,l_sfdd.sfddud025,l_sfdd.sfddud026,l_sfdd.sfddud027,
             l_sfdd.sfddud028,l_sfdd.sfddud029,l_sfdd.sfddud030,l_sfdd.sfdd014,l_sfdd.sfdd015)
      #161109-00085#62 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdd'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #add 150921 begin
      CALL asft339_01_ins_lot(l_sfjc.sfjcdocno,l_sfjc.sfjcseq,l_sfjc.sfjcseq1,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,'2')
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #add 150921 end
      
   END FOREACH
   CLOSE asft339_01_sel_sfjc_cs2
   FREE asft339_01_sel_sfjc_cs2
   #161109-00085#32-e

#sfde是需求汇总档，根据sfdc汇总 group by 料号，特征，单位，参考单位
   DECLARE asft339_01_sel_sfdc_cs CURSOR FOR
      SELECT DISTINCT sfdcent,sfdcsite,sfdcdocno,'0',sfdc004,sfdc005,sfdc006,SUM(sfdc007),SUM(sfdc008),sfdc009,SUM(sfdc010),SUM(sfdc011),'',sfdc017 
        FROM sfdc_t,sfda_t
       WHERE sfdaent   = g_enterprise
         AND sfdasite  = g_site
         AND sfdadocno = g_inba_m.sfdadocno
         AND sfdcent   = sfdaent
         AND sfdcsite  = sfdasite
         AND sfdcdocno = sfdadocno
         GROUP BY sfdcent,sfdcsite,sfdcdocno,sfdc004,sfdc005,sfdc006,sfdc009,sfdc017
   #161109-00085#32-s
   #FOREACH asft339_01_sel_sfdc_cs INTO l_sfde.*
   FOREACH asft339_01_sel_sfdc_cs
      INTO l_sfde.sfdeent,l_sfde.sfdesite,l_sfde.sfdedocno,l_sfde.sfdeseq,l_sfde.sfde001,
           l_sfde.sfde002,l_sfde.sfde003,l_sfde.sfde004,l_sfde.sfde005,l_sfde.sfde006,l_sfde.sfde007,
           l_sfde.sfde008,l_sfde.sfde009,l_sfde.sfde010
   #161109-00085#32-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      SELECT MAX(sfdeseq)+1 
        INTO l_sfde.sfdeseq
        FROM sfde_t
       WHERE sfdeent   = g_enterprise
         AND sfdesite  = g_site
         AND sfdedocno = g_inba_m.sfdadocno 
         
      IF l_sfde.sfdeseq IS NULL OR l_sfde.sfdeseq = 0 THEN
         LET l_sfde.sfdeseq = 1
      END IF      
          
      #161109-00085#32-s
      #INSERT INTO sfde_t VALUES(l_sfde.*)
      #161109-00085#62 --s mark
      #INSERT INTO sfde_t(sfdeent,sfdesite,sfdedocno,sfdeseq,sfde001,sfde002,sfde003,sfde004,sfde005,sfde006,sfde007,
      #                   sfde008,sfde009,sfde010)
      #VALUES(l_sfde.sfdeent,l_sfde.sfdesite,l_sfde.sfdedocno,l_sfde.sfdeseq,l_sfde.sfde001,
      #       l_sfde.sfde002,l_sfde.sfde003,l_sfde.sfde004,l_sfde.sfde005,l_sfde.sfde006,l_sfde.sfde007,
      #       l_sfde.sfde008,l_sfde.sfde009,l_sfde.sfde010)
      #161109-00085#62 --e mark
      #161109-00085#32-e
      #161109-00085#62 --s add
      INSERT INTO sfde_t(sfdeent,sfdesite,sfdedocno,sfdeseq,sfde001,
                         sfde002,sfde003,sfde004,sfde005,sfde006,
                         sfde007,sfde008,sfde009,sfde010,sfdeud001,
                         sfdeud002,sfdeud003,sfdeud004,sfdeud005,sfdeud006,
                         sfdeud007,sfdeud008,sfdeud009,sfdeud010,sfdeud011,
                         sfdeud012,sfdeud013,sfdeud014,sfdeud015,sfdeud016,
                         sfdeud017,sfdeud018,sfdeud019,sfdeud020,sfdeud021,
                         sfdeud022,sfdeud023,sfdeud024,sfdeud025,sfdeud026,
                         sfdeud027,sfdeud028,sfdeud029,sfdeud030)
      VALUES(l_sfde.sfdeent,l_sfde.sfdesite,l_sfde.sfdedocno,l_sfde.sfdeseq,l_sfde.sfde001,
             l_sfde.sfde002,l_sfde.sfde003,l_sfde.sfde004,l_sfde.sfde005,l_sfde.sfde006,
             l_sfde.sfde007,l_sfde.sfde008,l_sfde.sfde009,l_sfde.sfde010,l_sfde.sfdeud001,
             l_sfde.sfdeud002,l_sfde.sfdeud003,l_sfde.sfdeud004,l_sfde.sfdeud005,l_sfde.sfdeud006,
             l_sfde.sfdeud007,l_sfde.sfdeud008,l_sfde.sfdeud009,l_sfde.sfdeud010,l_sfde.sfdeud011,
             l_sfde.sfdeud012,l_sfde.sfdeud013,l_sfde.sfdeud014,l_sfde.sfdeud015,l_sfde.sfdeud016,
             l_sfde.sfdeud017,l_sfde.sfdeud018,l_sfde.sfdeud019,l_sfde.sfdeud020,l_sfde.sfdeud021,
             l_sfde.sfdeud022,l_sfde.sfdeud023,l_sfde.sfdeud024,l_sfde.sfdeud025,l_sfde.sfdeud026,
             l_sfde.sfdeud027,l_sfde.sfdeud028,l_sfde.sfdeud029,l_sfde.sfdeud030)
      #161109-00085#62 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfde'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asft339_01_sel_sfdc_cs
   FREE asft339_01_sel_sfdc_cs       
      
#sfdf是明细汇总档，根据sfdd汇总 group by 料号，特征，单位，参考单位，仓储批
   DECLARE asft339_01_sel_sfdd_cs CURSOR FOR
      SELECT DISTINCT sfddent,sfddsite,sfdddocno,sfddseq,'0',sfdd001,sfdd002,
                      sfdd003,sfdd004,sfdd005,sfdd006,SUM(sfdd007),sfdd008,SUM(sfdd009),sfdd010,sfdd011,sfdd012,sfdd013 
        FROM sfdd_t,sfda_t
       WHERE sfdaent   = g_enterprise
         AND sfdasite  = g_site
         AND sfdadocno = g_inba_m.sfdadocno
         AND sfddent   = sfdaent
         AND sfddsite  = sfdasite
         AND sfdddocno = sfdadocno
         GROUP BY sfddent,sfddsite,sfdddocno,sfddseq,sfdd001,sfdd002,sfdd003,
                      sfdd004,sfdd005,sfdd006,sfdd008,sfdd010,sfdd011,sfdd012,sfdd013        
   #161109-00085#32-s
   #FOREACH asft339_01_sel_sfdd_cs INTO l_sfdf.*
   FOREACH asft339_01_sel_sfdd_cs
      INTO l_sfdf.sfdfent,l_sfdf.sfdfsite,l_sfdf.sfdfdocno,l_sfdf.sfdfseq,l_sfdf.sfdfseq1,
           l_sfdf.sfdf001,l_sfdf.sfdf002,l_sfdf.sfdf003,l_sfdf.sfdf004,l_sfdf.sfdf005,
           l_sfdf.sfdf006,l_sfdf.sfdf007,l_sfdf.sfdf008,l_sfdf.sfdf009,l_sfdf.sfdf010,
           l_sfdf.sfdf011,l_sfdf.sfdf012,l_sfdf.sfdf013
   #161109-00085#32-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      SELECT MAX(sfdfseq1)+1 
        INTO l_sfdf.sfdfseq1
        FROM sfdf_t
       WHERE sfdfent   = g_enterprise
         AND sfdfsite  = g_site
         AND sfdfdocno = g_inba_m.sfdadocno
         AND sfdfseq   = l_sfdf.sfdfseq         
         
      IF l_sfdf.sfdfseq1 IS NULL OR l_sfdf.sfdfseq1 = 0 THEN
         LET l_sfdf.sfdfseq1 = 1
      END IF  
            
      #161109-00085#32-s
      #INSERT INTO sfdf_t VALUES(l_sfdf.*)
      #161109-00085#62 --s mark
      #INSERT INTO sfdf_t(sfdfent,sfdfsite,sfdfdocno,sfdfseq,sfdfseq1,sfdf001,sfdf002,sfdf003,sfdf004,sfdf005,
      #                   sfdf006,sfdf007,sfdf008,sfdf009,sfdf010,sfdf011,sfdf012,sfdf013) 
      #VALUES (l_sfdf.sfdfent,l_sfdf.sfdfsite,l_sfdf.sfdfdocno,l_sfdf.sfdfseq,l_sfdf.sfdfseq1,
      #        l_sfdf.sfdf001,l_sfdf.sfdf002,l_sfdf.sfdf003,l_sfdf.sfdf004,l_sfdf.sfdf005,
      #        l_sfdf.sfdf006,l_sfdf.sfdf007,l_sfdf.sfdf008,l_sfdf.sfdf009,l_sfdf.sfdf010,
      #        l_sfdf.sfdf011,l_sfdf.sfdf012,l_sfdf.sfdf013)
      #161109-00085#62 --e mark
      #161109-00085#32-e
      #161109-00085#62 --s add
      INSERT INTO sfdf_t(sfdfent,sfdfsite,sfdfdocno,sfdfseq,sfdfseq1,
                         sfdf001,sfdf002,sfdf003,sfdf004,sfdf005,
                         sfdf006,sfdf007,sfdf008,sfdf009,sfdf010,
                         sfdf011,sfdf012,sfdf013,sfdfud001,sfdfud002,
                         sfdfud003,sfdfud004,sfdfud005,sfdfud006,sfdfud007,
                         sfdfud008,sfdfud009,sfdfud010,sfdfud011,sfdfud012,
                         sfdfud013,sfdfud014,sfdfud015,sfdfud016,sfdfud017,
                         sfdfud018,sfdfud019,sfdfud020,sfdfud021,sfdfud022,
                         sfdfud023,sfdfud024,sfdfud025,sfdfud026,sfdfud027,
                         sfdfud028,sfdfud029,sfdfud030)
      VALUES(l_sfdf.sfdfent,l_sfdf.sfdfsite,l_sfdf.sfdfdocno,l_sfdf.sfdfseq,l_sfdf.sfdfseq1,
             l_sfdf.sfdf001,l_sfdf.sfdf002,l_sfdf.sfdf003,l_sfdf.sfdf004,l_sfdf.sfdf005,
             l_sfdf.sfdf006,l_sfdf.sfdf007,l_sfdf.sfdf008,l_sfdf.sfdf009,l_sfdf.sfdf010,
             l_sfdf.sfdf011,l_sfdf.sfdf012,l_sfdf.sfdf013,l_sfdf.sfdfud001,l_sfdf.sfdfud002,
             l_sfdf.sfdfud003,l_sfdf.sfdfud004,l_sfdf.sfdfud005,l_sfdf.sfdfud006,l_sfdf.sfdfud007,
             l_sfdf.sfdfud008,l_sfdf.sfdfud009,l_sfdf.sfdfud010,l_sfdf.sfdfud011,l_sfdf.sfdfud012,
             l_sfdf.sfdfud013,l_sfdf.sfdfud014,l_sfdf.sfdfud015,l_sfdf.sfdfud016,l_sfdf.sfdfud017,
             l_sfdf.sfdfud018,l_sfdf.sfdfud019,l_sfdf.sfdfud020,l_sfdf.sfdfud021,l_sfdf.sfdfud022,
             l_sfdf.sfdfud023,l_sfdf.sfdfud024,l_sfdf.sfdfud025,l_sfdf.sfdfud026,l_sfdf.sfdfud027,
             l_sfdf.sfdfud028,l_sfdf.sfdfud029,l_sfdf.sfdfud030)
      #161109-00085#62 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdf'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asft339_01_sel_sfdd_cs
   FREE asft339_01_sel_sfdd_cs 

   RETURN r_success
END FUNCTION

#add 150921
#产生制造批序号资料
PRIVATE FUNCTION asft339_01_ins_lot(p_sfjcdocno,p_sfjcseq,p_sfjcseq1,p_inaodocno,p_inaoseq,p_inaoseq1,p_inao000)
   DEFINE p_sfjcdocno  LIKE sfjc_t.sfjcdocno
   DEFINE p_sfjcseq    LIKE sfjc_t.sfjcseq
   DEFINE p_sfjcseq1   LIKE sfjc_t.sfjcseq1
   DEFINE p_inaodocno  LIKE inao_t.inaodocno
   DEFINE p_inaoseq    LIKE inao_t.inaoseq
   DEFINE p_inaoseq1   LIKE inao_t.inaoseq1
   DEFINE p_inao000    LIKE inao_t.inao000
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   #161109-00085#32-s
   #DEFINE l_inao      RECORD LIKE inao_t.*
   DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
          inaoent LIKE inao_t.inaoent, #企業編號
          inaosite LIKE inao_t.inaosite, #營運據點
          inaodocno LIKE inao_t.inaodocno, #單號
          inaoseq LIKE inao_t.inaoseq, #項次
          inaoseq1 LIKE inao_t.inaoseq1, #項序
          inaoseq2 LIKE inao_t.inaoseq2, #序號
          inao000 LIKE inao_t.inao000, #資料類型
          inao001 LIKE inao_t.inao001, #料件編號
          inao002 LIKE inao_t.inao002, #產品特徵
          inao003 LIKE inao_t.inao003, #庫存管理特徵
          inao004 LIKE inao_t.inao004, #包裝容器編號
          inao005 LIKE inao_t.inao005, #庫位
          inao006 LIKE inao_t.inao006, #儲位
          inao007 LIKE inao_t.inao007, #批號
          inao008 LIKE inao_t.inao008, #製造批號
          inao009 LIKE inao_t.inao009, #製造序號
          inao010 LIKE inao_t.inao010, #製造日期
          inao011 LIKE inao_t.inao011, #有效日期
          inao012 LIKE inao_t.inao012, #數量
          inao013 LIKE inao_t.inao013, #出入庫碼
          #161109-00085#62 --s add
          inaoud001 LIKE inao_t.inaoud001, #自定義欄位(文字)001
          inaoud002 LIKE inao_t.inaoud002, #自定義欄位(文字)002
          inaoud003 LIKE inao_t.inaoud003, #自定義欄位(文字)003
          inaoud004 LIKE inao_t.inaoud004, #自定義欄位(文字)004
          inaoud005 LIKE inao_t.inaoud005, #自定義欄位(文字)005
          inaoud006 LIKE inao_t.inaoud006, #自定義欄位(文字)006
          inaoud007 LIKE inao_t.inaoud007, #自定義欄位(文字)007
          inaoud008 LIKE inao_t.inaoud008, #自定義欄位(文字)008
          inaoud009 LIKE inao_t.inaoud009, #自定義欄位(文字)009
          inaoud010 LIKE inao_t.inaoud010, #自定義欄位(文字)010
          inaoud011 LIKE inao_t.inaoud011, #自定義欄位(數字)011
          inaoud012 LIKE inao_t.inaoud012, #自定義欄位(數字)012
          inaoud013 LIKE inao_t.inaoud013, #自定義欄位(數字)013
          inaoud014 LIKE inao_t.inaoud014, #自定義欄位(數字)014
          inaoud015 LIKE inao_t.inaoud015, #自定義欄位(數字)015
          inaoud016 LIKE inao_t.inaoud016, #自定義欄位(數字)016
          inaoud017 LIKE inao_t.inaoud017, #自定義欄位(數字)017
          inaoud018 LIKE inao_t.inaoud018, #自定義欄位(數字)018
          inaoud019 LIKE inao_t.inaoud019, #自定義欄位(數字)019
          inaoud020 LIKE inao_t.inaoud020, #自定義欄位(數字)020
          inaoud021 LIKE inao_t.inaoud021, #自定義欄位(日期時間)021
          inaoud022 LIKE inao_t.inaoud022, #自定義欄位(日期時間)022
          inaoud023 LIKE inao_t.inaoud023, #自定義欄位(日期時間)023
          inaoud024 LIKE inao_t.inaoud024, #自定義欄位(日期時間)024
          inaoud025 LIKE inao_t.inaoud025, #自定義欄位(日期時間)025
          inaoud026 LIKE inao_t.inaoud026, #自定義欄位(日期時間)026
          inaoud027 LIKE inao_t.inaoud027, #自定義欄位(日期時間)027
          inaoud028 LIKE inao_t.inaoud028, #自定義欄位(日期時間)028
          inaoud029 LIKE inao_t.inaoud029, #自定義欄位(日期時間)029
          inaoud030 LIKE inao_t.inaoud030, #自定義欄位(日期時間)030
          #161109-00085#62 --e add
          inao014 LIKE inao_t.inao014, #庫存單位
          inao020 LIKE inao_t.inao020, #檢驗合格量
          inao021 LIKE inao_t.inao021, #已入庫/出貨/簽收量
          inao022 LIKE inao_t.inao022, #已驗退/簽退量
          inao023 LIKE inao_t.inao023, #已倉退/銷退量
          inao024 LIKE inao_t.inao024, #已轉QC量
          inao025 LIKE inao_t.inao025  #已退品量
   END RECORD
   #161109-00085#32-e     
   LET r_success = TRUE
   
   #161109-00085#32-s
   #LET l_sql ="SELECT * FROM inao_t ",
   #161109-00085#62 --s mark
   #LET l_sql ="SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003, ",
   #           "       inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013, ",
   #           "       inao014,inao020,inao021,inao022,inao023,inao024,inao025 ",
   #161109-00085#62 --e mark
   #161109-00085#62 --s add
   LET l_sql ="SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1, ",
              "       inaoseq2,inao000,inao001,inao002,inao003, ",
              "       inao004,inao005,inao006,inao007,inao008, ",
              "       inao009,inao010,inao011,inao012,inao013, ",
              "       inaoud001,inaoud002,inaoud003,inaoud004,inaoud005, ",
              "       inaoud006,inaoud007,inaoud008,inaoud009,inaoud010, ",
              "       inaoud011,inaoud012,inaoud013,inaoud014,inaoud015, ",
              "       inaoud016,inaoud017,inaoud018,inaoud019,inaoud020, ",
              "       inaoud021,inaoud022,inaoud023,inaoud024,inaoud025, ",
              "       inaoud026,inaoud027,inaoud028,inaoud029,inaoud030, ",
              "       inao014,inao020,inao021,inao022,inao023, ",
              "       inao024,inao025 ",
   #161109-00085#62 --e add
              "  FROM inao_t ",
   #161109-00085#32-e
               " WHERE inaoent  = ",g_enterprise,
               "   AND inaodocno='",p_sfjcdocno,"'",
               "   AND inaoseq  = ",p_sfjcseq,
               "   AND inaoseq1 = ",p_sfjcseq1,
               "   AND inao000  ='2' ",  #实际
               "   AND inao013  = 1  "   #入库
   DECLARE asft339_01_ins_lot_p CURSOR FROM l_sql
   #161109-00085#32-s
   #FOREACH asft339_01_ins_lot_p INTO l_inao.*
   FOREACH asft339_01_ins_lot_p 
      INTO l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
           l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
           l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
           l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
           #161109-00085#62 --s add
           l_inao.inaoud001,l_inao.inaoud002,l_inao.inaoud003,l_inao.inaoud004,l_inao.inaoud005,
           l_inao.inaoud006,l_inao.inaoud007,l_inao.inaoud008,l_inao.inaoud009,l_inao.inaoud010,
           l_inao.inaoud011,l_inao.inaoud012,l_inao.inaoud013,l_inao.inaoud014,l_inao.inaoud015,
           l_inao.inaoud016,l_inao.inaoud017,l_inao.inaoud018,l_inao.inaoud019,l_inao.inaoud020,
           l_inao.inaoud021,l_inao.inaoud022,l_inao.inaoud023,l_inao.inaoud024,l_inao.inaoud025,
           l_inao.inaoud026,l_inao.inaoud027,l_inao.inaoud028,l_inao.inaoud029,l_inao.inaoud030,
           #161109-00085#62 --e add
           l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
           l_inao.inao024,l_inao.inao025
   #161109-00085#32-e
      LET l_inao.inaodocno= p_inaodocno
      LET l_inao.inaoseq  = p_inaoseq
      LET l_inao.inaoseq1 = p_inaoseq1
      LET l_inao.inao000  = p_inao000
      #161109-00085#32-s
      #INSERT INTO inao_t VALUES (l_inao.*)
      #161109-00085#62 --s mark
      #INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,
      #                   inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,      
      #                   inao014,inao020,inao021,inao022,inao023,inao024,inao025) 
      #VALUES (l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
      #        l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
      #        l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
      #        l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,      
      #        l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
      #        l_inao.inao024,l_inao.inao025) 
      #161109-00085#62 --e mark   
      #161109-00085#62 --s add
      INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,
                         inaoseq2,inao000,inao001,inao002,inao003,
                         inao004,inao005,inao006,inao007,inao008,
                         inao009,inao010,inao011,inao012,inao013,
                         inaoud001,inaoud002,inaoud003,inaoud004,inaoud005,
                         inaoud006,inaoud007,inaoud008,inaoud009,inaoud010,
                         inaoud011,inaoud012,inaoud013,inaoud014,inaoud015,
                         inaoud016,inaoud017,inaoud018,inaoud019,inaoud020,
                         inaoud021,inaoud022,inaoud023,inaoud024,inaoud025,
                         inaoud026,inaoud027,inaoud028,inaoud029,inaoud030,
                         inao014,inao020,inao021,inao022,inao023,
                         inao024,inao025)
      VALUES (l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
              l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
              l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
              l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
              l_inao.inaoud001,l_inao.inaoud002,l_inao.inaoud003,l_inao.inaoud004,l_inao.inaoud005,
              l_inao.inaoud006,l_inao.inaoud007,l_inao.inaoud008,l_inao.inaoud009,l_inao.inaoud010,
              l_inao.inaoud011,l_inao.inaoud012,l_inao.inaoud013,l_inao.inaoud014,l_inao.inaoud015,
              l_inao.inaoud016,l_inao.inaoud017,l_inao.inaoud018,l_inao.inaoud019,l_inao.inaoud020,
              l_inao.inaoud021,l_inao.inaoud022,l_inao.inaoud023,l_inao.inaoud024,l_inao.inaoud025,
              l_inao.inaoud026,l_inao.inaoud027,l_inao.inaoud028,l_inao.inaoud029,l_inao.inaoud030,
              l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
              l_inao.inao024,l_inao.inao025)
      #161109-00085#62 --e add      
      #161109-00085#32-e      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH     
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
