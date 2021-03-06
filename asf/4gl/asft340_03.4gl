#該程式未解開Section, 採用最新樣板產出!
{<section id="asft340_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-01-24 00:00:00), PR版次:0002(2016-11-20 09:12:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000094
#+ Filename...: asft340_03
#+ Description: 
#+ Creator....: 00378(2014-01-24 01:08:02)
#+ Modifier...: 00378 -SD/PR- 08992
 
{</section>}
 
{<section id="asft340_03.global" >}
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
 
{<section id="asft340_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
 type type_g_sfda_m        RECORD
       sfdadocno LIKE sfda_t.sfdadocno,
       sfdadocdt LIKE sfda_t.sfdadocdt
       END RECORD
DEFINE g_sfda_m        type_g_sfda_m

   DEFINE g_sfdadocno_t LIKE sfda_t.sfdadocno


DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="asft340_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asft340_03.other_dialog" >}

 
{</section>}
 
{<section id="asft340_03.other_function" readonly="Y" >}

PUBLIC FUNCTION asft340_03(--)
   #add-point:input段變數傳入
   {<point name="input.get_var"/>}
   p_sfeadocno
   )
   {<Local define>}
   DEFINE p_sfeadocno     LIKE sfea_t.sfeadocno
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_site          LIKE ooef_t.ooef001
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_start_no      LIKE sfea_t.sfeadocno
   DEFINE l_end_no        LIKE sfea_t.sfeadocno
   DEFINE p_cmd           LIKE type_t.chr5
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   IF cl_null(p_sfeadocno) THEN
      RETURN r_success
   END IF
   
   CALL asft340_03_chk(p_sfeadocno)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   SELECT sfeasite INTO l_site FROM sfea_t WHERE sfeaent = g_enterprise AND sfeadocno = p_sfeadocno   

   #畫面開啟 (identifier)
   OPEN WINDOW w_asft340_03 WITH FORM cl_ap_formpath("asf","asft340_03")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   LET g_sfda_m.sfdadocdt = cl_get_today()
   DISPLAY BY NAME g_sfda_m.sfdadocdt

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_sfda_m.sfdadocno,g_sfda_m.sfdadocdt ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD sfdadocno
            IF cl_null(g_sfda_m.sfdadocno) THEN
               NEXT FIELD sfdadocno
            END IF
            CALL s_aooi200_chk_slip(l_site,'',g_sfda_m.sfdadocno,'asft314')
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD sfdadocno
            END IF


         #此段落由子樣板a02產生
         AFTER FIELD sfdadocdt

            #add-point:AFTER FIELD sfdadocdt
            {<point name="input.a.sfdadocdt" />}
            #END add-point

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<sfdadocno>>----
         #Ctrlp:input.c.sfdadocno
         ON ACTION controlp INFIELD sfdadocno
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfda_m.sfdadocno             #給予default值
            #給予arg
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_site
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = "asft314"
            CALL q_ooba002_6()                                #呼叫開窗
            LET g_sfda_m.sfdadocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_sfda_m.sfdadocno TO sfdadocno           #顯示到畫面上
            NEXT FIELD sfdadocno  

         AFTER INPUT
#            IF cl_ask_sure() THEN
               CALL s_asft310_gen('14',p_sfeadocno,0,g_sfda_m.sfdadocno,g_sfda_m.sfdadocdt)
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
   CLOSE WINDOW w_asft340_03
   RETURN r_success

   #add-point:input段after input
   {<point name="input.post_input"/>}
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 入库单状态检查
# Memo...........:
# Usage..........: CALL asft340_03_chk(p_sfeadocno)
#                  RETURNING r_success
# Input parameter: p_sfeadocno    完工入库单
# Return code....: r_success      需倒扣料发料否标识符
# Date & Author..: 2014-01-26 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_03_chk(p_sfeadocno)
   DEFINE p_sfeadocno       LIKE sfea_t.sfeadocno
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
   #161109-00085#34-s
   #DEFINE l_sfea            RECORD LIKE sfea_t.*
   DEFINE l_sfea RECORD  #完工入庫單頭檔
       sfea005    LIKE sfea_t.sfea005,    #倒扣領料單號
       sfeastus   LIKE sfea_t.sfeastus    #狀態碼
   END RECORD
   #161109-00085#34-e
   LET r_success = FALSE
   
   #1.检查完工入库单存在否   
   #161109-00085#34-s
   #SELECT * INTO l_sfea.* FROM sfea_t
   SELECT sfea005,sfeastus
     INTO l_sfea.sfea005,l_sfea.sfeastus
     FROM sfea_t
   #161109-00085#34-e
    WHERE sfeaent  = g_enterprise
      AND sfeadocno = p_sfeadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = p_sfeadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   #2.检查单据是否已过帐
   IF l_sfea.sfeastus <> 'S' THEN
      #完工入库单的状态不是S.已过帐,请检查
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00090'
      LET g_errparam.extend = l_sfea.sfeastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #3.已产生过倒扣料发料单否
   IF NOT cl_null(l_sfea.sfea005) THEN
      #已经产生过倒扣料发料单了,不可重复产生
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00091'
      LET g_errparam.extend = l_sfea.sfea005
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #4.检查工单是否有倒扣料的项次,若没有则不可以产生倒扣料领料单
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM sfeb_t,sfba_t
    WHERE sfebent = sfbaent AND sfebent = g_enterprise
      AND sfebdocno = p_sfeadocno #完工入库单
      AND sfeb001 = sfbadocno     #工单
      AND sfba009 = 'Y'           #倒扣料
      AND sfba013 > 0             #应发数量
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt = 0 THEN
      #此完工入库单没有倒扣料项次
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00092'
      LET g_errparam.extend = p_sfeadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
      

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

 
{</section>}
 
