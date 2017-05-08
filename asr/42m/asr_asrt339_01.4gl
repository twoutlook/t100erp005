#該程式已解開Section, 不再透過樣板產出!
{<section id="asrt339_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000019
#+ 
#+ Filename...: asrt339_01
#+ Description: ...
#+ Creator....: 00537(2014/07/09)
#+ Modifier...: 00537(2014/07/09)
#+ Buildtype..: 應用 c01b 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="asrt339_01.global" >}

 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160905-00007#15 2016/09/06 by 08172 库存管理特征 
#161124-00048#12 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
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
DEFINE g_flag          LIKE type_t.num5     #0:杂收单，退料单都是全新产生的 1:已有杂收单，不用重新产生 2：已有退料单，不用重新产生
DEFINE g_sfjadocno     LIKE sfja_t.sfjadocno
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="asrt339_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION asrt339_01(--)
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
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asrt339_01 WITH FORM cl_ap_formpath("asr","asrt339_01")
 
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
      CLOSE WINDOW w_asrt339_01 
      RETURN
   END IF

#产生过的，提示下不产生了，记得要set no entry，都产生过了，提示下就return吧
   IF l_sfja004 IS NULL AND l_sfja005 IS NULL THEN
      LET g_flag = 0
#不能两种单身资料都没有
#      LET l_cnt = 0 
#      SELECT COUNT(*) INTO l_cnt 
#        FROM sfjb_t
#       WHERE sfjbent   = g_enterprise
#         AND sfjbsite  = g_site
#         AND sfjbdocno = p_sfjadocno
#         AND (sfjb010   = '2' OR sfjb010   = '3') 
#      
#      IF l_cnt = 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00404'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CLOSE WINDOW w_asrt339_01 
#         RETURN
#      END IF

      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
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
         CLOSE WINDOW w_asrt339_01 
         RETURN
      END IF

#检查单身是否有杂收资料，若没有，不用产生
#      LET l_cnt = 0 
#      SELECT COUNT(*) INTO l_cnt 
#        FROM sfjb_t
#       WHERE sfjbent   = g_enterprise
#         AND sfjbsite  = g_site
#         AND sfjbdocno = p_sfjadocno
#         AND sfjb010   = '2' 
#      
#      IF l_cnt = 0 THEN
#         LET g_flag = 1
#         CALL cl_set_comp_entry("inbadocno",FALSE)
#      END IF
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '2' 
      
      IF l_cnt = 0 THEN
         LET g_flag = 1
         CALL cl_set_comp_entry("inbadocno",FALSE)
      END IF
#检查单身是否有退料资料，若没有，不用产生
#      LET l_cnt = 0 
#      SELECT COUNT(*) INTO l_cnt 
#        FROM sfjb_t
#       WHERE sfjbent   = g_enterprise
#         AND sfjbsite  = g_site
#         AND sfjbdocno = p_sfjadocno
#         AND sfjb010   = '3' 
#      
#      IF l_cnt = 0 THEN
#         LET g_flag = 2
#         CALL cl_set_comp_entry("sfdadocno",FALSE)
#      END IF
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '3' 
      
      IF l_cnt = 0 THEN
         LET g_flag = 2
         CALL cl_set_comp_entry("sfdadocno",FALSE)
      END IF
       
   END IF
   IF l_sfja004 IS NOT NULL AND l_sfja005 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00362'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL cl_set_comp_entry("inbadocno",FALSE)
      LET g_inba_m.inbadocno = l_sfja004
      LET g_flag = 1
#检查单身是否有退料资料，若没有，不用产生
#      LET l_cnt = 0 
#      SELECT COUNT(*) INTO l_cnt 
#        FROM sfjb_t
#       WHERE sfjbent   = g_enterprise
#         AND sfjbsite  = g_site
#         AND sfjbdocno = p_sfjadocno
#         AND sfjb010   = '3' 
#      
#      IF l_cnt = 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00401'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CLOSE WINDOW w_asrt339_01 
#         RETURN
#      END IF
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '3' 
      
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00402'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE WINDOW w_asrt339_01 
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
      LET g_flag = 2
#检查单身是否有杂收资料，若没有，不用产生
#      LET l_cnt = 0 
#      SELECT COUNT(*) INTO l_cnt 
#        FROM sfjb_t
#       WHERE sfjbent   = g_enterprise
#         AND sfjbsite  = g_site
#         AND sfjbdocno = p_sfjadocno
#         AND sfjb010   = '2' 
#      
#      IF l_cnt = 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00399'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CLOSE WINDOW w_asrt339_01 
#         RETURN
#      END IF
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
        FROM sfjc_t
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = p_sfjadocno
         AND sfjc010   = '2' 
      
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE WINDOW w_asrt339_01 
         RETURN
      END IF
   END IF
   IF l_sfja005 IS NOT NULL AND l_sfja004 IS NOT NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00364'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE WINDOW w_asrt339_01
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
            CALL asrt339_01_gen_inba_sfda()
            #end add-point
            
      END INPUT
    
      #add-point:自定義input

      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
#这里居然没有addpoint
         CALL asrt339_01_gen_inba_sfda()
        
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
   CLOSE WINDOW w_asrt339_01 
   
   #add-point:input段after input 

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrt339_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asrt339_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION asrt339_01_gen_inba_sfda()
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
   IF g_flag = '0' THEN  #两个都产生
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
      IF NOT asrt339_01_ins_inba() THEN
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
      IF NOT asrt339_01_ins_sfda() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET l_sfdadocno = g_inba_m.sfdadocno
   END IF
   IF g_flag = '1' THEN  #已有杂收单，只要产生退料单
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
      IF NOT asrt339_01_ins_sfda() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET l_sfdadocno = g_inba_m.sfdadocno
   END IF
   IF g_flag = '2' THEN  #已有退料单，只要产生杂收单
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
      IF NOT asrt339_01_ins_inba() THEN
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
PRIVATE FUNCTION asrt339_01_ins_inba()
#161124-00048#12 mark-s
#   DEFINE l_sfja      RECORD LIKE sfja_t.*
#   DEFINE l_sfjb      RECORD LIKE sfjb_t.*
#   DEFINE l_sfjc      RECORD LIKE sfjc_t.*
#   DEFINE l_inba      RECORD LIKE inba_t.*
#   DEFINE l_inbb      RECORD LIKE inbb_t.*
#   DEFINE l_inbc      RECORD LIKE inbc_t.*
#   DEFINE l_inao      RECORD LIKE inao_t.*
#161124-00048#12 mark-e
#161124-00048#12 add-s
DEFINE l_sfja RECORD  #工單下階料報廢單頭檔
       sfjaent LIKE sfja_t.sfjaent, #企业编号
       sfjasite LIKE sfja_t.sfjasite, #营运据点
       sfjadocno LIKE sfja_t.sfjadocno, #报废单号
       sfjadocdt LIKE sfja_t.sfjadocdt, #单据日期
       sfja001 LIKE sfja_t.sfja001, #申请人员
       sfja002 LIKE sfja_t.sfja002, #申请部门
       sfja003 LIKE sfja_t.sfja003, #过账日期
       sfja004 LIKE sfja_t.sfja004, #杂收单号
       sfja005 LIKE sfja_t.sfja005, #退料单号
       sfjaownid LIKE sfja_t.sfjaownid, #资料所有者
       sfjaowndp LIKE sfja_t.sfjaowndp, #资料所有部门
       sfjacrtid LIKE sfja_t.sfjacrtid, #资料录入者
       sfjacrtdp LIKE sfja_t.sfjacrtdp, #资料录入部门
       sfjacrtdt LIKE sfja_t.sfjacrtdt, #资料创建日
       sfjamodid LIKE sfja_t.sfjamodid, #资料更改者
       sfjamoddt LIKE sfja_t.sfjamoddt, #最近更改日
       sfjacnfid LIKE sfja_t.sfjacnfid, #资料审核者
       sfjacnfdt LIKE sfja_t.sfjacnfdt, #数据审核日
       sfjapstid LIKE sfja_t.sfjapstid, #资料过账者
       sfjapstdt LIKE sfja_t.sfjapstdt, #资料过账日
       sfjastus LIKE sfja_t.sfjastus  #状态码
END RECORD
DEFINE l_sfjb RECORD  #工單下階料報廢單身檔
       sfjbent LIKE sfjb_t.sfjbent, #企业编号
       sfjbsite LIKE sfjb_t.sfjbsite, #营运据点
       sfjbdocno LIKE sfjb_t.sfjbdocno, #报废单号
       sfjbseq LIKE sfjb_t.sfjbseq, #项次
       sfjb001 LIKE sfjb_t.sfjb001, #工单单号
       sfjb002 LIKE sfjb_t.sfjb002, #工单项次
       sfjb003 LIKE sfjb_t.sfjb003, #料件编号
       sfjb004 LIKE sfjb_t.sfjb004, #产品特征
       sfjb005 LIKE sfjb_t.sfjb005, #单位
       sfjb006 LIKE sfjb_t.sfjb006, #报废数量
       sfjb007 LIKE sfjb_t.sfjb007, #参考单位
       sfjb008 LIKE sfjb_t.sfjb008, #参考数量
       sfjb009 LIKE sfjb_t.sfjb009, #理由码
       sfjb010 LIKE sfjb_t.sfjb010, #预计处理方式
       sfjb011 LIKE sfjb_t.sfjb011, #库位
       sfjb012 LIKE sfjb_t.sfjb012, #储位
       sfjb013 LIKE sfjb_t.sfjb013, #批号
       sfjb014 LIKE sfjb_t.sfjb014, #库存管理特征
       sfjb015 LIKE sfjb_t.sfjb015, #工单项序
       sfjb016 LIKE sfjb_t.sfjb016, #生产料号
       sfjb017 LIKE sfjb_t.sfjb017, #BOM特性
       sfjb018 LIKE sfjb_t.sfjb018, #产品特征
       sfjb019 LIKE sfjb_t.sfjb019  #生产计划
END RECORD
DEFINE l_sfjc RECORD  #工單下階料報廢明細檔
       sfjcent LIKE sfjc_t.sfjcent, #企业编号
       sfjcsite LIKE sfjc_t.sfjcsite, #营运据点
       sfjcdocno LIKE sfjc_t.sfjcdocno, #报废单号
       sfjcseq LIKE sfjc_t.sfjcseq, #项次
       sfjcseq1 LIKE sfjc_t.sfjcseq1, #项序
       sfjc001 LIKE sfjc_t.sfjc001, #工单单号
       sfjc002 LIKE sfjc_t.sfjc002, #工单项次
       sfjc003 LIKE sfjc_t.sfjc003, #料件编号
       sfjc004 LIKE sfjc_t.sfjc004, #产品特征
       sfjc005 LIKE sfjc_t.sfjc005, #单位
       sfjc006 LIKE sfjc_t.sfjc006, #报废数量
       sfjc007 LIKE sfjc_t.sfjc007, #参考单位
       sfjc008 LIKE sfjc_t.sfjc008, #参考数量
       sfjc009 LIKE sfjc_t.sfjc009, #理由码
       sfjc010 LIKE sfjc_t.sfjc010, #预计处理方式
       sfjc011 LIKE sfjc_t.sfjc011, #库位
       sfjc012 LIKE sfjc_t.sfjc012, #储位
       sfjc013 LIKE sfjc_t.sfjc013, #批号
       sfjc014 LIKE sfjc_t.sfjc014, #库存管理特征
       sfjc015 LIKE sfjc_t.sfjc015, #工单项序
       sfjc016 LIKE sfjc_t.sfjc016, #生产料号
       sfjc017 LIKE sfjc_t.sfjc017, #BOM特性
       sfjc018 LIKE sfjc_t.sfjc018, #产品特征
       sfjc019 LIKE sfjc_t.sfjc019  #生产计划
END RECORD
DEFINE l_inba RECORD  #雜項庫存異動單頭檔
       inbaent LIKE inba_t.inbaent, #企业编号
       inbasite LIKE inba_t.inbasite, #营运据点
       inbadocno LIKE inba_t.inbadocno, #单据编号
       inbadocdt LIKE inba_t.inbadocdt, #录入日期
       inba001 LIKE inba_t.inba001, #单据类别
       inba002 LIKE inba_t.inba002, #扣账日期
       inba003 LIKE inba_t.inba003, #申请人员
       inba004 LIKE inba_t.inba004, #申请部门
       inba005 LIKE inba_t.inba005, #来源数据类型
       inba006 LIKE inba_t.inba006, #来源单号
       inba007 LIKE inba_t.inba007, #理由码
       inba008 LIKE inba_t.inba008, #备注
       inba009 LIKE inba_t.inba009, #保税异动原因
       inba010 LIKE inba_t.inba010, #保税进口报单
       inba011 LIKE inba_t.inba011, #保税进口报单日期
       inbaownid LIKE inba_t.inbaownid, #资料所有者
       inbaowndp LIKE inba_t.inbaowndp, #资料所有部门
       inbacrtid LIKE inba_t.inbacrtid, #资料录入者
       inbacrtdp LIKE inba_t.inbacrtdp, #资料录入部门
       inbacrtdt LIKE inba_t.inbacrtdt, #资料创建日
       inbamodid LIKE inba_t.inbamodid, #资料更改者
       inbamoddt LIKE inba_t.inbamoddt, #最近更改日
       inbacnfid LIKE inba_t.inbacnfid, #资料审核者
       inbacnfdt LIKE inba_t.inbacnfdt, #数据审核日
       inbapstid LIKE inba_t.inbapstid, #资料过账者
       inbapstdt LIKE inba_t.inbapstdt, #资料过账日
       inbastus LIKE inba_t.inbastus, #状态码
       inbaunit LIKE inba_t.inbaunit, #应用组织
       inba012 LIKE inba_t.inba012, #领用类型
       inba013 LIKE inba_t.inba013, #费用对象
       inba014 LIKE inba_t.inba014, #直接交款否
       inba015 LIKE inba_t.inba015, #库位
       inba200 LIKE inba_t.inba200, #冲减方式
       inba201 LIKE inba_t.inba201, #管理品类
       inba202 LIKE inba_t.inba202, #来源作业
       inba203 LIKE inba_t.inba203, #管理品类
       inba204 LIKE inba_t.inba204, #供应商编号
       inba205 LIKE inba_t.inba205, #领用部门
       inba206 LIKE inba_t.inba206, #转入库位
       inba207 LIKE inba_t.inba207, #转入管理品类
       inba208 LIKE inba_t.inba208  #返回
END RECORD
DEFINE l_inbb RECORD  #雜項庫存異動申請明細檔
       inbbent LIKE inbb_t.inbbent, #企业编号
       inbbsite LIKE inbb_t.inbbsite, #营运据点
       inbbdocno LIKE inbb_t.inbbdocno, #单据编号
       inbbseq LIKE inbb_t.inbbseq, #项次
       inbb001 LIKE inbb_t.inbb001, #料件编号
       inbb002 LIKE inbb_t.inbb002, #产品特征
       inbb003 LIKE inbb_t.inbb003, #库存管理特征
       inbb004 LIKE inbb_t.inbb004, #包装容器编号
       inbb007 LIKE inbb_t.inbb007, #库位
       inbb008 LIKE inbb_t.inbb008, #限定储位
       inbb009 LIKE inbb_t.inbb009, #限定批号
       inbb010 LIKE inbb_t.inbb010, #交易单位
       inbb011 LIKE inbb_t.inbb011, #申请数量
       inbb012 LIKE inbb_t.inbb012, #实际异动数量
       inbb013 LIKE inbb_t.inbb013, #参考单位
       inbb014 LIKE inbb_t.inbb014, #参考单位申请数量
       inbb015 LIKE inbb_t.inbb015, #参考单位实际数量
       inbb016 LIKE inbb_t.inbb016, #理由码
       inbb017 LIKE inbb_t.inbb017, #来源单号
       inbb018 LIKE inbb_t.inbb018, #检验否
       inbb019 LIKE inbb_t.inbb019, #检验合格量
       inbb020 LIKE inbb_t.inbb020, #单据备注
       inbb021 LIKE inbb_t.inbb021, #存货备注
       inbb022 LIKE inbb_t.inbb022, #有效日期
       inbb200 LIKE inbb_t.inbb200, #商品条码
       inbb201 LIKE inbb_t.inbb201, #包装单位
       inbb202 LIKE inbb_t.inbb202, #申请包装数量
       inbb203 LIKE inbb_t.inbb203, #实际包装数量
       inbbunit LIKE inbb_t.inbbunit, #应用组织
       inbb204 LIKE inbb_t.inbb204, #制造日期
       inbb023 LIKE inbb_t.inbb023, #项目编号
       inbb024 LIKE inbb_t.inbb024, #WBS
       inbb025 LIKE inbb_t.inbb025, #活动编号
       inbb205 LIKE inbb_t.inbb205, #领用/退回单价
       inbb206 LIKE inbb_t.inbb206, #领用/退回金额
       inbb207 LIKE inbb_t.inbb207, #成本单价
       inbb208 LIKE inbb_t.inbb208, #成本金额
       inbb209 LIKE inbb_t.inbb209, #费用编号
       inbb210 LIKE inbb_t.inbb210, #进价
       inbb211 LIKE inbb_t.inbb211, #来源单据项次
       inbb212 LIKE inbb_t.inbb212, #来源单据项序
       inbb213 LIKE inbb_t.inbb213, #转入商品条码
       inbb214 LIKE inbb_t.inbb214, #转入商品编号
       inbb215 LIKE inbb_t.inbb215, #转入产品特征
       inbb216 LIKE inbb_t.inbb216, #转入单位
       inbb217 LIKE inbb_t.inbb217, #转入数量
       inbb218 LIKE inbb_t.inbb218, #转入包装单位
       inbb219 LIKE inbb_t.inbb219, #转入包装数量
       inbb220 LIKE inbb_t.inbb220, #转入库位
       inbb221 LIKE inbb_t.inbb221, #转入储位
       inbb222 LIKE inbb_t.inbb222, #转入批号
       inbb223 LIKE inbb_t.inbb223, #转入进价
       inbb224 LIKE inbb_t.inbb224, #计价单位
       inbb225 LIKE inbb_t.inbb225  #计价数量
END RECORD
DEFINE l_inbc RECORD  #雜項庫存異動庫儲批明細檔
       inbcent LIKE inbc_t.inbcent, #企业编号
       inbcsite LIKE inbc_t.inbcsite, #营运据点
       inbcdocno LIKE inbc_t.inbcdocno, #单据编号
       inbcseq LIKE inbc_t.inbcseq, #项次
       inbcseq1 LIKE inbc_t.inbcseq1, #项序
       inbc001 LIKE inbc_t.inbc001, #料件编号
       inbc002 LIKE inbc_t.inbc002, #产品特征
       inbc003 LIKE inbc_t.inbc003, #库存管理特征
       inbc004 LIKE inbc_t.inbc004, #包装容器编号
       inbc005 LIKE inbc_t.inbc005, #库位
       inbc006 LIKE inbc_t.inbc006, #储位
       inbc007 LIKE inbc_t.inbc007, #批号
       inbc009 LIKE inbc_t.inbc009, #交易单位
       inbc010 LIKE inbc_t.inbc010, #数量
       inbc011 LIKE inbc_t.inbc011, #参考单位
       inbc015 LIKE inbc_t.inbc015, #参考数量
       inbc016 LIKE inbc_t.inbc016, #有效日期
       inbc017 LIKE inbc_t.inbc017, #存货备注
       inbc018 LIKE inbc_t.inbc018, #QC单号
       inbc019 LIKE inbc_t.inbc019, #QC判定项次
       inbc020 LIKE inbc_t.inbc020, #判定结果
       inbc200 LIKE inbc_t.inbc200, #商品条码
       inbc201 LIKE inbc_t.inbc201, #包装单位
       inbc202 LIKE inbc_t.inbc202, #包装数量
       inbcunit LIKE inbc_t.inbcunit, #应用组织
       inbc203 LIKE inbc_t.inbc203, #制造日期
       inbc021 LIKE inbc_t.inbc021, #项目编号
       inbc022 LIKE inbc_t.inbc022, #WBS
       inbc023 LIKE inbc_t.inbc023, #活动编号
       inbc204 LIKE inbc_t.inbc204, #领用/退回单价
       inbc205 LIKE inbc_t.inbc205, #领用/退回金额
       inbc206 LIKE inbc_t.inbc206, #成本单价
       inbc207 LIKE inbc_t.inbc207, #成本金额
       inbc208 LIKE inbc_t.inbc208, #费用编号
       inbc209 LIKE inbc_t.inbc209, #来源单据项次
       inbc210 LIKE inbc_t.inbc210, #来源单据项序
       inbc211 LIKE inbc_t.inbc211, #计价单位
       inbc212 LIKE inbc_t.inbc212  #计价数量
END RECORD
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025  #已退品量
END RECORD
#161124-00048#12 add-e
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
   
   INITIALIZE l_sfja.* TO NULL
   INITIALIZE l_sfjb.* TO NULL
   INITIALIZE l_sfjc.* TO NULL
   INITIALIZE l_inba.* TO NULL
   INITIALIZE l_inbb.* TO NULL
   INITIALIZE l_inbc.* TO NULL
   INITIALIZE l_inao.* TO NULL
   
#先插单头
#   SELECT * INTO l_sfja.*  #161124-00048#12 mark
   #161124-00048#12 add-s
   SELECT sfjaent,sfjasite,sfjadocno,sfjadocdt,sfja001,sfja002,sfja003,sfja004,
          sfja005,sfjaownid,sfjaowndp,sfjacrtid,sfjacrtdp,sfjacrtdt,sfjamodid,
          sfjamoddt,sfjacnfid,sfjacnfdt,sfjapstid,sfjapstdt,sfjastus 
     INTO l_sfja.*
   #161124-00048#12 add-e
     FROM sfja_t
    WHERE sfjaent   = g_enterprise
      AND sfjasite  = g_site
      AND sfjadocno = g_sfjadocno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel sfja_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_inba.inbaent   = l_sfja.sfjaent                                                  #企業編號        
   LET l_inba.inbasite  = l_sfja.sfjasite                                                 #營運據點        
   LET l_inba.inbadocno = g_inba_m.inbadocno                                              #單據編號        
   LET l_inba.inbadocdt = g_today                                                         #輸入日期        
   LET l_inba.inba001   = '2'                                                             #單據類別        
   LET l_inba.inba002   = ''                                                              #扣帳日期        
   LET l_inba.inba003   = g_user                                                          #申請人員        
   LET l_inba.inba004   = g_dept                                                          #申請部門        
   LET l_inba.inba005   = '8'                                                             #來源資料類型    
   LET l_inba.inba006   = l_sfja.sfjadocno                                                #來源單號        
   LET l_inba.inba007   = ''                                                              #理由碼  
   CALL s_aooi360_sel('6',l_sfja.sfjadocno,'','','','','','','','','','4')              #備註 
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

#   INSERT INTO inba_t VALUES(l_inba.*) #161124-00048#12 mark
   #161124-00048#12 add-s
   INSERT INTO inba_t(inbaent,inbasite,inbadocno,inbadocdt,inba001,inba002,inba003,
                      inba004,inba005,inba006,inba007,inba008,inba009,inba010,inba011,
                      inbaownid,inbaowndp,inbacrtid,inbacrtdp,inbacrtdt,inbamodid,inbamoddt,
                      inbacnfid,inbacnfdt,inbapstid,inbapstdt,inbastus,inbaunit,inba012,
                      inba013,inba014,inba015,inba200,inba201,inba202,inba203,inba204,
                      inba205,inba206,inba207,inba208) 
               VALUES(l_inba.inbaent,l_inba.inbasite,l_inba.inbadocno,l_inba.inbadocdt,l_inba.inba001,l_inba.inba002,l_inba.inba003,
                      l_inba.inba004,l_inba.inba005,l_inba.inba006,l_inba.inba007,l_inba.inba008,l_inba.inba009,l_inba.inba010,l_inba.inba011,
                      l_inba.inbaownid,l_inba.inbaowndp,l_inba.inbacrtid,l_inba.inbacrtdp,l_inba.inbacrtdt,l_inba.inbamodid,l_inba.inbamoddt,
                      l_inba.inbacnfid,l_inba.inbacnfdt,l_inba.inbapstid,l_inba.inbapstdt,l_inba.inbastus,l_inba.inbaunit,l_inba.inba012,
                      l_inba.inba013,l_inba.inba014,l_inba.inba015,l_inba.inba200,l_inba.inba201,l_inba.inba202,l_inba.inba203,l_inba.inba204,
                      l_inba.inba205,l_inba.inba206,l_inba.inba207,l_inba.inba208)
   #161124-00048#12 add-e
   
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
   DECLARE asrt339_01_sel_sfjc_cs CURSOR FOR
#      SELECT * FROM sfjc_t #161124-00048#12 mark
      #161124-00048#12 add-s
      SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,
             sfjc004,sfjc005,sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,
             sfjc013,sfjc014,sfjc015,sfjc016,sfjc017,sfjc018,sfjc019
        FROM sfjc_t
      #161124-00048#12 add-e
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = g_sfjadocno
         AND sfjc010   = '2'
         
   FOREACH asrt339_01_sel_sfjc_cs INTO l_sfjc.*
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
      LET l_inbb.inbb017   = l_sfja.sfjadocno                                #來源單號        
      LET l_inbb.inbb018   = 'N'                                             #檢驗否          
      LET l_inbb.inbb020   = ''                                              #單據備註        
      LET l_inbb.inbb021   = ''                                              #存貨備註        
      LET l_inbb.inbb022   = ''                                              #有效日期  

#      INSERT INTO inbb_t VALUES(l_inbb.*)  #161124-00048#12 mark
     #161124-00048#12 add-s
     INSERT INTO inbb_t(inbbent,inbbsite,inbbdocno,inbbseq,inbb001,inbb002,inbb003,inbb004,
                        inbb007,inbb008,inbb009,inbb010,inbb011,inbb012,inbb013,inbb014,inbb015,
                        inbb016,inbb017,inbb018,inbb019,inbb020,inbb021,inbb022,inbb200,inbb201,
                        inbb202,inbb203,inbbunit,inbb204,inbb023,inbb024,inbb025,inbb205,inbb206,
                        inbb207,inbb208,inbb209,inbb210,inbb211,inbb212,inbb213,inbb214,inbb215,
                        inbb216,inbb217,inbb218,inbb219,inbb220,inbb221,inbb222,inbb223,inbb224,inbb225) 
                 VALUES(l_inbb.inbbent,l_inbb.inbbsite,l_inbb.inbbdocno,l_inbb.inbbseq,l_inbb.inbb001,l_inbb.inbb002,l_inbb.inbb003,l_inbb.inbb004,
                        l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb009,l_inbb.inbb010,l_inbb.inbb011,l_inbb.inbb012,l_inbb.inbb013,l_inbb.inbb014,l_inbb.inbb015,
                        l_inbb.inbb016,l_inbb.inbb017,l_inbb.inbb018,l_inbb.inbb019,l_inbb.inbb020,l_inbb.inbb021,l_inbb.inbb022,l_inbb.inbb200,l_inbb.inbb201,
                        l_inbb.inbb202,l_inbb.inbb203,l_inbb.inbbunit,l_inbb.inbb204,l_inbb.inbb023,l_inbb.inbb024,l_inbb.inbb025,l_inbb.inbb205,l_inbb.inbb206,
                        l_inbb.inbb207,l_inbb.inbb208,l_inbb.inbb209,l_inbb.inbb210,l_inbb.inbb211,l_inbb.inbb212,l_inbb.inbb213,l_inbb.inbb214,l_inbb.inbb215,
                        l_inbb.inbb216,l_inbb.inbb217,l_inbb.inbb218,l_inbb.inbb219,l_inbb.inbb220,l_inbb.inbb221,l_inbb.inbb222,l_inbb.inbb223,l_inbb.inbb224,l_inbb.inbb225)
     #161124-00048#12 add-e
      
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
      LET l_success = '' 
      LET l_imaf071 = ''
      LET l_imaf081 = '' 
      SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = l_inbb.inbb001
         
      IF l_imaf071 = '1' OR l_imaf081 = '1' THEN   #参考aimm212，制造批序号管理            
         CALL s_lot_ins(g_site,l_inba.inbadocno,l_inbb.inbbseq,'0',l_inbb.inbb001,l_inbb.inbb002,l_inbb.inbb010,l_inbb.inbb011,'1',l_inba.inba003,'2',g_site,l_inba.inba007,l_inba.inba008,l_inba.inba009,l_inbb.inbb003) #160905-00007#15 by 08172 库存管理特征 
              RETURNING l_success,l_amount
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END FOREACH
   CLOSE asrt339_01_sel_sfjc_cs
   FREE asrt339_01_sel_sfjc_cs

 
   DECLARE asrt339_01_sel_sfjc_cs1 CURSOR FOR
#      SELECT * FROM sfjc_t  #161124-00048#12 mark
      #161124-00048#12 add-s
      SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,
             sfjc004,sfjc005,sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,
             sfjc013,sfjc014,sfjc015,sfjc016,sfjc017,sfjc018,sfjc019
        FROM sfjc_t
      #161124-00048#12 add-e
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = g_sfjadocno
         AND sfjc010   = '2'
         
   FOREACH asrt339_01_sel_sfjc_cs1 INTO l_sfjc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
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

#      INSERT INTO inbc_t VALUES(l_inbc.*) #161124-00048#12 mark
      #161124-00048#12 add-s
      INSERT INTO inbc_t(inbcent,inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002,
                         inbc003,inbc004,inbc005,inbc006,inbc007,inbc009,inbc010,inbc011,
                         inbc015,inbc016,inbc017,inbc018,inbc019,inbc020,inbc200,inbc201,
                         inbc202,inbcunit,inbc203,inbc021,inbc022,inbc023,inbc204,inbc205,
                         inbc206,inbc207,inbc208,inbc209,inbc210,inbc211,inbc212) 
                  VALUES(l_inbc.inbcent,l_inbc.inbcsite,l_inbc.inbcdocno,l_inbc.inbcseq,l_inbc.inbcseq1,l_inbc.inbc001,l_inbc.inbc002,
                         l_inbc.inbc003,l_inbc.inbc004,l_inbc.inbc005,l_inbc.inbc006,l_inbc.inbc007,l_inbc.inbc009,l_inbc.inbc010,l_inbc.inbc011,
                         l_inbc.inbc015,l_inbc.inbc016,l_inbc.inbc017,l_inbc.inbc018,l_inbc.inbc019,l_inbc.inbc020,l_inbc.inbc200,l_inbc.inbc201,
                         l_inbc.inbc202,l_inbc.inbcunit,l_inbc.inbc203,l_inbc.inbc021,l_inbc.inbc022,l_inbc.inbc023,l_inbc.inbc204,l_inbc.inbc205,
                         l_inbc.inbc206,l_inbc.inbc207,l_inbc.inbc208,l_inbc.inbc209,l_inbc.inbc210,l_inbc.inbc211,l_inbc.inbc212)
      #161124-00048#12 add-e
      
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
   CLOSE asrt339_01_sel_sfjc_cs1
   FREE asrt339_01_sel_sfjc_cs1 
   
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
PRIVATE FUNCTION asrt339_01_ins_sfda()
#161124-00048#12 mark-s
#   DEFINE l_sfda      RECORD LIKE sfda_t.*
#   DEFINE l_sfdc      RECORD LIKE sfdc_t.*
#   DEFINE l_sfdd      RECORD LIKE sfdd_t.*
#   DEFINE l_sfde      RECORD LIKE sfde_t.*
#   DEFINE l_sfdf      RECORD LIKE sfdf_t.*
#   DEFINE l_sfja      RECORD LIKE sfja_t.*
#   DEFINE l_sfjb      RECORD LIKE sfjb_t.*
#   DEFINE l_sfjc      RECORD LIKE sfjc_t.*
#161124-00048#12 mark-e
#161124-00048#12 add-s
DEFINE l_sfda RECORD  #發退料單頭檔
       sfdaent LIKE sfda_t.sfdaent, #企业编号
       sfdasite LIKE sfda_t.sfdasite, #营运据点
       sfdadocno LIKE sfda_t.sfdadocno, #发退料单号
       sfdadocdt LIKE sfda_t.sfdadocdt, #单据日期
       sfda001 LIKE sfda_t.sfda001, #过账日期
       sfda002 LIKE sfda_t.sfda002, #发退料类别
       sfda003 LIKE sfda_t.sfda003, #生产部门
       sfda004 LIKE sfda_t.sfda004, #申请人
       sfda005 LIKE sfda_t.sfda005, #PBI编号
       sfda006 LIKE sfda_t.sfda006, #生产料号
       sfda007 LIKE sfda_t.sfda007, #BOM特性
       sfda008 LIKE sfda_t.sfda008, #产品特征
       sfda009 LIKE sfda_t.sfda009, #生产控制组
       sfda010 LIKE sfda_t.sfda010, #作业编号
       sfda011 LIKE sfda_t.sfda011, #作业序
       sfda012 LIKE sfda_t.sfda012, #库位
       sfda013 LIKE sfda_t.sfda013, #套数
       sfda014 LIKE sfda_t.sfda014, #来源单号
       sfda015 LIKE sfda_t.sfda015, #来源类型
       sfdaownid LIKE sfda_t.sfdaownid, #资料所有者
       sfdaowndp LIKE sfda_t.sfdaowndp, #资料所有部门
       sfdacrtid LIKE sfda_t.sfdacrtid, #资料录入者
       sfdacrtdp LIKE sfda_t.sfdacrtdp, #资料录入部门
       sfdacrtdt LIKE sfda_t.sfdacrtdt, #资料创建日
       sfdamodid LIKE sfda_t.sfdamodid, #资料更改者
       sfdamoddt LIKE sfda_t.sfdamoddt, #最近更改日
       sfdacnfid LIKE sfda_t.sfdacnfid, #资料审核者
       sfdacnfdt LIKE sfda_t.sfdacnfdt, #数据审核日
       sfdapstid LIKE sfda_t.sfdapstid, #资料过账者
       sfdapstdt LIKE sfda_t.sfdapstdt, #资料过账日
       sfdastus LIKE sfda_t.sfdastus  #状态码
END RECORD
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企业编号
       sfdcsite LIKE sfdc_t.sfdcsite, #营运据点
       sfdcdocno LIKE sfdc_t.sfdcdocno, #发退料单号
       sfdcseq LIKE sfdc_t.sfdcseq, #项次
       sfdc001 LIKE sfdc_t.sfdc001, #工单单号
       sfdc002 LIKE sfdc_t.sfdc002, #工单项次
       sfdc003 LIKE sfdc_t.sfdc003, #工单项序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料号
       sfdc005 LIKE sfdc_t.sfdc005, #产品特征
       sfdc006 LIKE sfdc_t.sfdc006, #单位
       sfdc007 LIKE sfdc_t.sfdc007, #申请数量
       sfdc008 LIKE sfdc_t.sfdc008, #实际数量
       sfdc009 LIKE sfdc_t.sfdc009, #参考单位
       sfdc010 LIKE sfdc_t.sfdc010, #参考单位需求数量
       sfdc011 LIKE sfdc_t.sfdc011, #参考单位实际数量
       sfdc012 LIKE sfdc_t.sfdc012, #指定库位
       sfdc013 LIKE sfdc_t.sfdc013, #指定储位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批号
       sfdc015 LIKE sfdc_t.sfdc015, #理由码
       sfdc016 LIKE sfdc_t.sfdc016, #库存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017  #正负
END RECORD
DEFINE l_sfdd RECORD  #發退料明細檔
       sfddent LIKE sfdd_t.sfddent, #企业编号
       sfddsite LIKE sfdd_t.sfddsite, #营运据点
       sfdddocno LIKE sfdd_t.sfdddocno, #发退料单号
       sfddseq LIKE sfdd_t.sfddseq, #项次
       sfddseq1 LIKE sfdd_t.sfddseq1, #项序
       sfdd001 LIKE sfdd_t.sfdd001, #发退料料号
       sfdd002 LIKE sfdd_t.sfdd002, #替代率
       sfdd003 LIKE sfdd_t.sfdd003, #库位
       sfdd004 LIKE sfdd_t.sfdd004, #储位
       sfdd005 LIKE sfdd_t.sfdd005, #批号
       sfdd006 LIKE sfdd_t.sfdd006, #单位
       sfdd007 LIKE sfdd_t.sfdd007, #数量
       sfdd008 LIKE sfdd_t.sfdd008, #参考单位
       sfdd009 LIKE sfdd_t.sfdd009, #参考单位数量
       sfdd010 LIKE sfdd_t.sfdd010, #库存管理特征
       sfdd011 LIKE sfdd_t.sfdd011, #包装容器
       sfdd012 LIKE sfdd_t.sfdd012, #正负
       sfdd013 LIKE sfdd_t.sfdd013, #产品特征
       sfdd014 LIKE sfdd_t.sfdd014, #备置量
       sfdd015 LIKE sfdd_t.sfdd015  #在拣量
END RECORD
DEFINE l_sfde RECORD  #發退料需求匯總檔
       sfdeent LIKE sfde_t.sfdeent, #企业编号
       sfdesite LIKE sfde_t.sfdesite, #营运据点
       sfdedocno LIKE sfde_t.sfdedocno, #发退料单号
       sfdeseq LIKE sfde_t.sfdeseq, #项次
       sfde001 LIKE sfde_t.sfde001, #需求料号
       sfde002 LIKE sfde_t.sfde002, #产品特征
       sfde003 LIKE sfde_t.sfde003, #单位
       sfde004 LIKE sfde_t.sfde004, #申请数量
       sfde005 LIKE sfde_t.sfde005, #实际数量
       sfde006 LIKE sfde_t.sfde006, #参考单位
       sfde007 LIKE sfde_t.sfde007, #参考单位申请数量
       sfde008 LIKE sfde_t.sfde008, #参考单位实际数量
       sfde009 LIKE sfde_t.sfde009, #客供料
       sfde010 LIKE sfde_t.sfde010  #正负
END RECORD
DEFINE l_sfdf RECORD  #發退料倉儲批匯總檔
       sfdfent LIKE sfdf_t.sfdfent, #企业编号
       sfdfsite LIKE sfdf_t.sfdfsite, #营运据点
       sfdfdocno LIKE sfdf_t.sfdfdocno, #发退料单号
       sfdfseq LIKE sfdf_t.sfdfseq, #项次
       sfdfseq1 LIKE sfdf_t.sfdfseq1, #项序
       sfdf001 LIKE sfdf_t.sfdf001, #发退料料号
       sfdf002 LIKE sfdf_t.sfdf002, #替代率
       sfdf003 LIKE sfdf_t.sfdf003, #库位
       sfdf004 LIKE sfdf_t.sfdf004, #储位
       sfdf005 LIKE sfdf_t.sfdf005, #批号
       sfdf006 LIKE sfdf_t.sfdf006, #单位
       sfdf007 LIKE sfdf_t.sfdf007, #数量
       sfdf008 LIKE sfdf_t.sfdf008, #参考单位
       sfdf009 LIKE sfdf_t.sfdf009, #参考单位数量
       sfdf010 LIKE sfdf_t.sfdf010, #库存管理特征
       sfdf011 LIKE sfdf_t.sfdf011, #包装容器
       sfdf012 LIKE sfdf_t.sfdf012, #正负
       sfdf013 LIKE sfdf_t.sfdf013  #产品特征
END RECORD
DEFINE l_sfja RECORD  #工單下階料報廢單頭檔
       sfjaent LIKE sfja_t.sfjaent, #企业编号
       sfjasite LIKE sfja_t.sfjasite, #营运据点
       sfjadocno LIKE sfja_t.sfjadocno, #报废单号
       sfjadocdt LIKE sfja_t.sfjadocdt, #单据日期
       sfja001 LIKE sfja_t.sfja001, #申请人员
       sfja002 LIKE sfja_t.sfja002, #申请部门
       sfja003 LIKE sfja_t.sfja003, #过账日期
       sfja004 LIKE sfja_t.sfja004, #杂收单号
       sfja005 LIKE sfja_t.sfja005, #退料单号
       sfjaownid LIKE sfja_t.sfjaownid, #资料所有者
       sfjaowndp LIKE sfja_t.sfjaowndp, #资料所有部门
       sfjacrtid LIKE sfja_t.sfjacrtid, #资料录入者
       sfjacrtdp LIKE sfja_t.sfjacrtdp, #资料录入部门
       sfjacrtdt LIKE sfja_t.sfjacrtdt, #资料创建日
       sfjamodid LIKE sfja_t.sfjamodid, #资料更改者
       sfjamoddt LIKE sfja_t.sfjamoddt, #最近更改日
       sfjacnfid LIKE sfja_t.sfjacnfid, #资料审核者
       sfjacnfdt LIKE sfja_t.sfjacnfdt, #数据审核日
       sfjapstid LIKE sfja_t.sfjapstid, #资料过账者
       sfjapstdt LIKE sfja_t.sfjapstdt, #资料过账日
       sfjastus LIKE sfja_t.sfjastus  #状态码
END RECORD
DEFINE l_sfjb RECORD  #工單下階料報廢單身檔
       sfjbent LIKE sfjb_t.sfjbent, #企业编号
       sfjbsite LIKE sfjb_t.sfjbsite, #营运据点
       sfjbdocno LIKE sfjb_t.sfjbdocno, #报废单号
       sfjbseq LIKE sfjb_t.sfjbseq, #项次
       sfjb001 LIKE sfjb_t.sfjb001, #工单单号
       sfjb002 LIKE sfjb_t.sfjb002, #工单项次
       sfjb003 LIKE sfjb_t.sfjb003, #料件编号
       sfjb004 LIKE sfjb_t.sfjb004, #产品特征
       sfjb005 LIKE sfjb_t.sfjb005, #单位
       sfjb006 LIKE sfjb_t.sfjb006, #报废数量
       sfjb007 LIKE sfjb_t.sfjb007, #参考单位
       sfjb008 LIKE sfjb_t.sfjb008, #参考数量
       sfjb009 LIKE sfjb_t.sfjb009, #理由码
       sfjb010 LIKE sfjb_t.sfjb010, #预计处理方式
       sfjb011 LIKE sfjb_t.sfjb011, #库位
       sfjb012 LIKE sfjb_t.sfjb012, #储位
       sfjb013 LIKE sfjb_t.sfjb013, #批号
       sfjb014 LIKE sfjb_t.sfjb014, #库存管理特征
       sfjb015 LIKE sfjb_t.sfjb015, #工单项序
       sfjb016 LIKE sfjb_t.sfjb016, #生产料号
       sfjb017 LIKE sfjb_t.sfjb017, #BOM特性
       sfjb018 LIKE sfjb_t.sfjb018, #产品特征
       sfjb019 LIKE sfjb_t.sfjb019  #生产计划
END RECORD
DEFINE l_sfjc RECORD  #工單下階料報廢明細檔
       sfjcent LIKE sfjc_t.sfjcent, #企业编号
       sfjcsite LIKE sfjc_t.sfjcsite, #营运据点
       sfjcdocno LIKE sfjc_t.sfjcdocno, #报废单号
       sfjcseq LIKE sfjc_t.sfjcseq, #项次
       sfjcseq1 LIKE sfjc_t.sfjcseq1, #项序
       sfjc001 LIKE sfjc_t.sfjc001, #工单单号
       sfjc002 LIKE sfjc_t.sfjc002, #工单项次
       sfjc003 LIKE sfjc_t.sfjc003, #料件编号
       sfjc004 LIKE sfjc_t.sfjc004, #产品特征
       sfjc005 LIKE sfjc_t.sfjc005, #单位
       sfjc006 LIKE sfjc_t.sfjc006, #报废数量
       sfjc007 LIKE sfjc_t.sfjc007, #参考单位
       sfjc008 LIKE sfjc_t.sfjc008, #参考数量
       sfjc009 LIKE sfjc_t.sfjc009, #理由码
       sfjc010 LIKE sfjc_t.sfjc010, #预计处理方式
       sfjc011 LIKE sfjc_t.sfjc011, #库位
       sfjc012 LIKE sfjc_t.sfjc012, #储位
       sfjc013 LIKE sfjc_t.sfjc013, #批号
       sfjc014 LIKE sfjc_t.sfjc014, #库存管理特征
       sfjc015 LIKE sfjc_t.sfjc015, #工单项序
       sfjc016 LIKE sfjc_t.sfjc016, #生产料号
       sfjc017 LIKE sfjc_t.sfjc017, #BOM特性
       sfjc018 LIKE sfjc_t.sfjc018, #产品特征
       sfjc019 LIKE sfjc_t.sfjc019  #生产计划
END RECORD
#161124-00048#12 add-e
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   #检查事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   INITIALIZE l_sfja.* TO NULL
   INITIALIZE l_sfjb.* TO NULL
   INITIALIZE l_sfjc.* TO NULL
   INITIALIZE l_sfda.* TO NULL
   INITIALIZE l_sfdc.* TO NULL
   INITIALIZE l_sfdd.* TO NULL
   INITIALIZE l_sfde.* TO NULL
   INITIALIZE l_sfdf.* TO NULL
   

#先插单头
#   SELECT * INTO l_sfja.*  #161124-00048#12 mark
   #161124-00048#12 add-s
   SELECT sfjaent,sfjasite,sfjadocno,sfjadocdt,sfja001,sfja002,sfja003,
          sfja004,sfja005,sfjaownid,sfjaowndp,sfjacrtid,sfjacrtdp,sfjacrtdt,
          sfjamodid,sfjamoddt,sfjacnfid,sfjacnfdt,sfjapstid,sfjapstdt,sfjastus 
     INTO l_sfja.*
   #161124-00048#12 add-e
     FROM sfja_t
    WHERE sfjaent   = g_enterprise
      AND sfjasite  = g_site
      AND sfjadocno = g_sfjadocno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel sfja_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sfda.sfdaent   = l_sfja.sfjaent             #企業編號    
   LET l_sfda.sfdasite  = l_sfja.sfjasite            #營運據點    
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
   LET l_sfda.sfda014   = l_sfja.sfjadocno           #來源單號    
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

#   INSERT INTO sfda_t VALUES(l_sfda.*) #161124-00048#12 mark
   #161124-00048#12 add-s
   INSERT INTO sfda_t(sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,
                      sfda004,sfda005,sfda006,sfda007,sfda008,sfda009,sfda010,sfda011,
                      sfda012,sfda013,sfda014,sfda015,sfdaownid,sfdaowndp,sfdacrtid,
                      sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdacnfid,sfdacnfdt,
                      sfdapstid,sfdapstdt,sfdastus) 
               VALUES(l_sfda.sfdaent,l_sfda.sfdasite,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
                      l_sfda.sfda004,l_sfda.sfda005,l_sfda.sfda006,l_sfda.sfda007,l_sfda.sfda008,l_sfda.sfda009,l_sfda.sfda010,l_sfda.sfda011,
                      l_sfda.sfda012,l_sfda.sfda013,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
                      l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdacnfid,l_sfda.sfdacnfdt,
                      l_sfda.sfdapstid,l_sfda.sfdapstdt,l_sfda.sfdastus)
   #161124-00048#12 add-e
   
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
   DECLARE asrt339_01_sel_sfjc_cs2 CURSOR FOR
#      SELECT * FROM sfjc_t  #161124-00048#12 mark
      #161124-00048#12 add-s
      SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,
             sfjc004,sfjc005,sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,
             sfjc013,sfjc014,sfjc015,sfjc016,sfjc017,sfjc018,sfjc019 
        FROM sfjc_t
      #161124-00048#12 add-e
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = g_sfjadocno
         AND sfjc010   = '3'
         

   FOREACH asrt339_01_sel_sfjc_cs2 INTO l_sfjc.*
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
      
#      INSERT INTO sfdc_t VALUES(l_sfdc.*) #161124-00048#12 mark
      #161124-00048#12 add-s
      INSERT INTO sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,
                         sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
                         sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017)
                  VALUES(l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,
                         l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
                         l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,l_sfdc.sfdc017)
      #161124-00048#12 add-e
      
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'ins sfdc'
        LET g_errparam.popup = TRUE
        CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asrt339_01_sel_sfjc_cs2
   FREE asrt339_01_sel_sfjc_cs2
   
#sfdd对应sfjc
   DECLARE asrt339_01_sel_sfjc_cs3 CURSOR FOR
#      SELECT * FROM sfjc_t  #161124-00048#12 mark
      #161124-00048#12 add-s 
      SELECT sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,
             sfjc004,sfjc005,sfjc006,sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,
             sfjc013,sfjc014,sfjc015,sfjc016,sfjc017,sfjc018,sfjc019
        FROM sfjc_t
      #161124-00048#12 add-e
       WHERE sfjcent   = g_enterprise
         AND sfjcsite  = g_site
         AND sfjcdocno = g_sfjadocno
         AND sfjc010   = '3'
         
   FOREACH asrt339_01_sel_sfjc_cs3 INTO l_sfjc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
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

#      INSERT INTO sfdd_t VALUES(l_sfdd.*)  #161124-00048#12 mark
      #161124-00048#12 add-s
      INSERT INTO sfdd_t(sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,sfdd001,sfdd002,
                         sfdd003,sfdd004,sfdd005,sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,
                         sfdd011,sfdd012,sfdd013,sfdd014,sfdd015)
                  VALUES(l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,l_sfdd.sfdd001,l_sfdd.sfdd002,
                         l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
                         l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfdd014,l_sfdd.sfdd015)
      #161124-00048#12 add-e
      
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'ins sfdd'
        LET g_errparam.popup = TRUE
        CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asrt339_01_sel_sfjc_cs3
   FREE asrt339_01_sel_sfjc_cs3  

#sfde是需求汇总档，根据sfdc汇总 group by 料号，特征，单位，参考单位
   DECLARE asrt339_01_sel_sfdc_cs CURSOR FOR
      SELECT DISTINCT sfdcent,sfdcsite,sfdcdocno,'0',sfdc004,sfdc005,sfdc006,SUM(sfdc007),SUM(sfdc008),sfdc009,SUM(sfdc010),SUM(sfdc011),'',sfdc017 
        FROM sfdc_t,sfda_t
       WHERE sfdaent   = g_enterprise
         AND sfdasite  = g_site
         AND sfdadocno = g_inba_m.sfdadocno
         AND sfdcent   = sfdaent
         AND sfdcsite  = sfdasite
         AND sfdcdocno = sfdadocno
         GROUP BY sfdcent,sfdcsite,sfdcdocno,sfdc004,sfdc005,sfdc006,sfdc009,sfdc017         

   FOREACH asrt339_01_sel_sfdc_cs INTO l_sfde.*
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
          
#      INSERT INTO sfde_t VALUES(l_sfde.*) #161124-00048#12 mark
      #161124-00048#12 add-s
      INSERT INTO sfde_t(sfdeent,sfdesite,sfdedocno,sfdeseq,sfde001,sfde002,sfde003,
                         sfde004,sfde005,sfde006,sfde007,sfde008,sfde009,sfde010)
                  VALUES(l_sfde.sfdeent,l_sfde.sfdesite,l_sfde.sfdedocno,l_sfde.sfdeseq,l_sfde.sfde001,l_sfde.sfde002,l_sfde.sfde003,
                         l_sfde.sfde004,l_sfde.sfde005,l_sfde.sfde006,l_sfde.sfde007,l_sfde.sfde008,l_sfde.sfde009,l_sfde.sfde010)
      #161124-00048#12 add-e
      
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
   CLOSE asrt339_01_sel_sfdc_cs
   FREE asrt339_01_sel_sfdc_cs       
      
#sfdf是明细汇总档，根据sfdd汇总 group by 料号，特征，单位，参考单位，仓储批
   DECLARE asrt339_01_sel_sfdd_cs CURSOR FOR
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

   FOREACH asrt339_01_sel_sfdd_cs INTO l_sfdf.*
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
      
#      INSERT INTO sfdf_t VALUES(l_sfdf.*) #161124-00048#12 mark
      #161124-00048#12 add-s
      INSERT INTO sfdf_t(sfdfent,sfdfsite,sfdfdocno,sfdfseq,sfdfseq1,sfdf001,sfdf002,sfdf003,sfdf004,
                         sfdf005,sfdf006,sfdf007,sfdf008,sfdf009,sfdf010,sfdf011,sfdf012,sfdf013) 
                  VALUES(l_sfdf.sfdfent,l_sfdf.sfdfsite,l_sfdf.sfdfdocno,l_sfdf.sfdfseq,l_sfdf.sfdfseq1,l_sfdf.sfdf001,l_sfdf.sfdf002,l_sfdf.sfdf003,l_sfdf.sfdf004,
                         l_sfdf.sfdf005,l_sfdf.sfdf006,l_sfdf.sfdf007,l_sfdf.sfdf008,l_sfdf.sfdf009,l_sfdf.sfdf010,l_sfdf.sfdf011,l_sfdf.sfdf012,l_sfdf.sfdf013)
      #161124-00048#12 add-e
      
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
   CLOSE asrt339_01_sel_sfdd_cs
   FREE asrt339_01_sel_sfdd_cs 

   RETURN r_success
END FUNCTION

 
{</section>}
 
