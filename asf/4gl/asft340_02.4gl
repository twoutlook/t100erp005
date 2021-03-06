#該程式未解開Section, 採用最新樣板產出!
{<section id="asft340_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-02-18 09:45:14), PR版次:0002(2016-11-20 09:11:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000130
#+ Filename...: asft340_02
#+ Description: 
#+ Creator....: 00378(2014-01-08 14:49:10)
#+ Modifier...: 00378 -SD/PR- 08992
 
{</section>}
 
{<section id="asft340_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#161109-00085#34 2016/11/15 By lienjunqi    整批調整系統星號寫法
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="asft340_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
 type type_g_qcba_m        RECORD
       qcbadocno LIKE qcba_t.qcbadocno,
       qcbadocdt LIKE qcba_t.qcbadocdt
       END RECORD
DEFINE g_qcba_m        type_g_qcba_m

DEFINE g_qcbadocno_t   LIKE qcba_t.qcbadocno    #Key值備份


DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="asft340_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asft340_02.other_dialog" >}

 
{</section>}
 
{<section id="asft340_02.other_function" readonly="Y" >}

PUBLIC FUNCTION asft340_02(--)
   #add-point:input段變數傳入
   {<point name="input.get_var"/>}
   p_sfeadocno   
   #end add-point
   )

   DEFINE p_sfeadocno     LIKE sfea_t.sfeadocno
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_site          LIKE ooef_t.ooef001
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_start_no      LIKE sfea_t.sfeadocno
   DEFINE l_end_no        LIKE sfea_t.sfeadocno

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   IF cl_null(p_sfeadocno) THEN
      RETURN r_success
   END IF
   
   CALL asft340_02_chk(p_sfeadocno)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   SELECT sfeasite INTO l_site FROM sfea_t WHERE sfeaent = g_enterprise AND sfeadocno = p_sfeadocno

   #畫面開啟 (identifier)
   OPEN WINDOW w_asft340_02 WITH FORM cl_ap_formpath("asf","asft340_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qcba_m.qcbadocdt = cl_get_today()
   DISPLAY BY NAME g_qcba_m.qcbadocdt

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_qcba_m.qcbadocno,g_qcba_m.qcbadocdt ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD qcbadocno
            IF cl_null(g_qcba_m.qcbadocno) THEN
               NEXT FIELD qcbadocno
            END IF
            CALL s_aooi200_chk_slip(l_site,'',g_qcba_m.qcbadocno,'aqct300')
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD qcbadocno
            END IF
 
         #此段落由子樣板a02產生
         AFTER FIELD qcbadocdt

            #add-point:AFTER FIELD qcbadocdt
            {<point name="input.a.qcbadocdt" />}
            #END add-point

         ON ACTION controlp INFIELD qcbadocno
            #add-point:ON ACTION controlp INFIELD qcbadocno
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_qcba_m.qcbadocno             #給予default值
            #給予arg
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_site
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = "aqct300"
            CALL q_ooba002_6()                                #呼叫開窗
            LET g_qcba_m.qcbadocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_qcba_m.qcbadocno TO qcbadocno           #顯示到畫面上
            NEXT FIELD qcbadocno                          

         AFTER INPUT
#            IF cl_ask_sure() THEN
               CALL s_aqct300_gen('2',p_sfeadocno,0,g_qcba_m.qcbadocno,g_qcba_m.qcbadocdt)
                    RETURNING l_success,l_start_no,l_end_no
               DISPLAY "Start No:",l_start_no,"    End No:",l_end_no
               LET r_success = l_success
               EXIT DIALOG
 #           END IF

      END INPUT

      #add-point:自定義input
      {<point name="input.more_input"/>}
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

   #add-point:畫面關閉前
   {<point name="input.before_close"/>}
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_asft340_02
   RETURN r_success

   #add-point:input段after input
   {<point name="input.post_input"/>}
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 入库单状态检查
# Memo...........:
# Usage..........: CALL asft340_02_chk(p_sfeadocno)
#                  RETURNING r_success
# Input parameter: p_sfeadocno    完工入库单
# Return code....: r_success      可以转FQC否
# Date & Author..: 2014-01-16 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_02_chk(p_sfeadocno)
   DEFINE p_sfeadocno       LIKE sfea_t.sfeadocno
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
   #161109-00085#34-s
   #DEFINE l_sfeb            RECORD LIKE sfeb_t.*
   DEFINE l_sfeb RECORD  #完工入庫申請檔
       sfebsite   LIKE sfeb_t.sfebsite,   #營運據點
       sfebdocno  LIKE sfeb_t.sfebdocno,  #完工入庫單號
       sfebseq    LIKE sfeb_t.sfebseq,    #項次
       sfeb008    LIKE sfeb_t.sfeb008     #申請數量
END RECORD   
   #161109-00085#34-e
   DEFINE l_qc_qty          LIKE sfec_t.sfec009
   DEFINE l_flag            LIKE type_t.chr1
   
   LET r_success = FALSE
   
   #1.检查完工入库单存在否 + 状态是 审核 否
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_sfeadocno
   IF NOT cl_chk_exist("v_sfeadocno") THEN
      RETURN r_success
   END IF
   
   #2.工单中是否有需FQC的单身
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM sfeb_t
    WHERE sfebent   = g_enterprise
      AND sfebdocno = p_sfeadocno
      AND sfeb002 = 'Y'
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00081'
      LET g_errparam.extend = p_sfeadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #3.工单有FQC的单身,检查是否全数FQC了
   DECLARE asft340_02_cs1 CURSOR FOR
      #161109-00085#34-s
      #SELECT * FROM sfeb_t
      SELECT sfebsite,sfebdocno,sfebseq,sfeb008
        FROM sfeb_t
      #161109-00085#34-e
       WHERE sfebent   = g_enterprise
         AND sfebdocno = p_sfeadocno
         AND sfeb002   = 'Y'
       
   LET l_flag = 'N'

   #161109-00085#34-s
   #FOREACH asft340_02_cs1 INTO l_sfeb.*
   FOREACH asft340_02_cs1 INTO l_sfeb.sfebsite,l_sfeb.sfebdocno,l_sfeb.sfebseq,l_sfeb.sfeb008
   #161109-00085#34-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft340_02_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success         
      END IF
      
      LET l_qc_qty = 0
      SELECT SUM(qcba017) INTO l_qc_qty FROM qcba_t
       WHERE qcbaent  = g_enterprise
         AND qcbasite = l_sfeb.sfebsite
         AND qcba001  = l_sfeb.sfebdocno
         AND qcba002  = l_sfeb.sfebseq
         AND qcbastus <> 'X'
      IF cl_null(l_qc_qty) THEN LET l_qc_qty = 0 END IF
      #检查是否还有剩余可FQC的量
      IF l_qc_qty < l_sfeb.sfeb008 THEN
         LET l_flag = 'Y'
         EXIT FOREACH
      END IF
   END FOREACH
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00082'
      LET g_errparam.extend = p_sfeadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
      
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

 
{</section>}
 
