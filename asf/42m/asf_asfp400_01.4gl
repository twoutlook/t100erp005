#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp400_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-07-17 09:42:18), PR版次:0005(2016-11-17 17:34:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000118
#+ Filename...: asfp400_01
#+ Description: 工單轉委外採購單-條件輸入
#+ Creator....: 00378(2014-04-15 15:11:55)
#+ Modifier...: 00378 -SD/PR- 08992
 
{</section>}
 
{<section id="asfp400_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#161109-00085#41 2016/11/17 By lienjunqi    整批調整系統星號寫法
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
 
{<section id="asfp400_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
TYPE type_g_pmdl_m        RECORD
                          pmdldocno LIKE pmdl_t.pmdldocno,
                          pmdldocdt LIKE pmdl_t.pmdldocdt,
                          combine   LIKE type_t.chr1
                          END RECORD
DEFINE g_pmdl_m           type_g_pmdl_m

DEFINE g_pmdldocno_t      LIKE pmdl_t.pmdldocno    #Key值備份

TYPE type_g_sfcb_d        RECORD
                          sel              LIKE type_t.chr1,
                          b_sfcbdocno      LIKE sfcb_t.sfcbdocno,
                          b_sfcb001        LIKE sfcb_t.sfcb001, 
                          b_sfcb002        LIKE sfcb_t.sfcb002, 
                          b_sfaa003        LIKE sfaa_t.sfaa003,
                          b_sfaa002        LIKE sfaa_t.sfaa002,
                          b_sfaa002_desc   LIKE type_t.chr500,
                          b_sfaa010        LIKE sfaa_t.sfaa010,   
                          b_sfaa010_desc1  LIKE imaal_t.imaal003,
                          b_sfaa010_desc2  LIKE imaal_t.imaal004,                                                                  
                          b_sfcb003        LIKE sfcb_t.sfcb003, 
                          b_sfcb003_desc   LIKE type_t.chr500,
                          b_sfcb004        LIKE sfcb_t.sfcb004, 
                          b_sfcb020        LIKE sfcb_t.sfcb020, 
                          b_sfcb020_desc   LIKE type_t.chr500,
                          b_tot_qty        LIKE sfaa_t.sfaa012,
                          b_carry_qty      LIKE sfaa_t.sfaa012,
                          b_sfcb013        LIKE sfcb_t.sfcb013, 
                          b_sfcb013_desc   LIKE type_t.chr500,
                          b_sfcb044        LIKE sfcb_t.sfcb044, 
                          b_sfcb045        LIKE sfcb_t.sfcb045, 
                          b_pmdl017        LIKE pmdl_t.pmdl017,
                          b_pmdl017_desc   LIKE type_t.chr500,
                          b_pmdl015        LIKE pmdl_t.pmdl015,
                          b_pmdl015_desc   LIKE type_t.chr500,
                          b_exrate         LIKE ooan_t.ooan005,
                          b_pmdl011        LIKE pmdl_t.pmdl011,
                          b_pmdl011_desc   LIKE type_t.chr500,
                          b_price          LIKE pmdn_t.pmdn015
                          END RECORD
                          
DEFINE g_sfcb_d           DYNAMIC ARRAY OF type_g_sfcb_d    
DEFINE g_rec_b1           LIKE type_t.num10

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="asfp400_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asfp400_01.other_dialog" >}

 
{</section>}
 
{<section id="asfp400_01.other_function" readonly="Y" >}

PUBLIC FUNCTION asfp400_01(--)
   #add-point:input段變數傳入
   {<point name="input.get_var"/>}
   p_sfcb_d   
   #end add-point
   )

   DEFINE p_sfcb_d        DYNAMIC ARRAY OF type_g_sfcb_d
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_site          LIKE ooef_t.ooef001
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_start_no      LIKE sfea_t.sfeadocno
   DEFINE l_end_no        LIKE sfea_t.sfeadocno
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_i             LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   LET g_sfcb_d.* = p_sfcb_d.*
   LET g_rec_b1 = g_sfcb_d.getLength()
   LET l_date = cl_get_today()
   FOR l_i = 1 TO g_rec_b1
       IF g_sfcb_d[l_i].sel = 'N' THEN
          CONTINUE FOR
       END IF
#160419-00037 by whitney mark start
#       IF l_date > g_sfcb_d[l_i].b_sfcb045 THEN
#          LET l_date = g_sfcb_d[l_i].b_sfcb045
#       END IF
#160419-00037 by whitney mark end
   END FOR
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asfp400_01 WITH FORM cl_ap_formpath("asf","asfp400_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_pmdl_m.pmdldocdt = l_date
   LET g_pmdl_m.combine = 'Y'
   DISPLAY BY NAME g_pmdl_m.pmdldocdt,g_pmdl_m.combine

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_pmdl_m.pmdldocno,g_pmdl_m.pmdldocdt,g_pmdl_m.combine ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD pmdldocno
            IF cl_null(g_pmdl_m.pmdldocno) THEN
               NEXT FIELD pmdldocno
            END IF
#            CALL asfp400_01_chk_doc_type(g_pmdl_m.pmdldocno)
#                 RETURNING l_success
#            IF NOT l_success THEN
#               NEXT FIELD pmdldocno
#            END IF
 
         #此段落由子樣板a02產生
         AFTER FIELD pmdldocdt
            IF cl_null(g_pmdl_m.pmdldocdt) THEN
               NEXT FIELD pmdldocdt
            END IF
#            CALL asfp400_01_chk_date(g_pmdl_m.pmdldocdt)
#                 RETURNING l_success
#            IF NOT l_success THEN
#               NEXT FIELD pmdldocdt
#            END IF         

         AFTER FIELD combine
            IF cl_null(g_pmdl_m.combine) THEN
               NEXT FIELD combine
            END IF
            IF g_pmdl_m.combine NOT MATCHES '[YN]' THEN
               NEXT FIELD combine
            END IF

            #add-point:AFTER FIELD pmdldocdt
            {<point name="input.a.pmdldocdt" />}
            #END add-point

         ON ACTION controlp INFIELD pmdldocno
            #add-point:ON ACTION controlp INFIELD pmdldocno
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdldocno             #給予default值
            #給予arg
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = "apmt501"
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_pmdl_m.pmdldocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_m.pmdldocno TO pmdldocno           #顯示到畫面上
            NEXT FIELD pmdldocno                          

         AFTER INPUT
            #委外厂商
            CALL asfp400_01_chk_doc_type(g_pmdl_m.pmdldocno)
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD pmdldocno
            END IF  
            #单据日期
            CALL asfp400_01_chk_date(g_pmdl_m.pmdldocdt)
                 RETURNING l_success
            IF NOT l_success THEN
               CALL cl_err_collect_show()   
               NEXT FIELD pmdldocdt
            END IF 

            LET r_success = TRUE
            EXIT DIALOG

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
   CLOSE WINDOW w_asfp400_01
   RETURN r_success,g_pmdl_m.pmdldocno,g_pmdl_m.pmdldocdt,g_pmdl_m.combine

   #add-point:input段after input
   {<point name="input.post_input"/>}
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 入库单状态检查
# Memo...........:
# Usage..........: CALL asfp400_01_chk(p_sfeadocno)
#                  RETURNING r_success
# Input parameter: p_sfeadocno    完工入库单
# Return code....: r_success      可以转FQC否
# Date & Author..: 2014-01-16 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_01_chk(p_sfeadocno)
   DEFINE p_sfeadocno       LIKE sfea_t.sfeadocno
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
  #161109-00085#41-s
  #DEFINE l_sfeb    RECORD LIKE sfeb_t.*
  DEFINE l_sfeb RECORD  #完工入庫申請檔
       sfebent LIKE sfeb_t.sfebent, #企業編號
       sfebsite LIKE sfeb_t.sfebsite, #營運據點
       sfebdocno LIKE sfeb_t.sfebdocno, #完工入庫單號
       sfebseq LIKE sfeb_t.sfebseq, #項次
       sfeb001 LIKE sfeb_t.sfeb001, #工單單號
       sfeb002 LIKE sfeb_t.sfeb002, #FQC
       sfeb003 LIKE sfeb_t.sfeb003, #入庫類型
       sfeb004 LIKE sfeb_t.sfeb004, #料件編號
       sfeb005 LIKE sfeb_t.sfeb005, #特徵
       sfeb006 LIKE sfeb_t.sfeb006, #包裝容器
       sfeb007 LIKE sfeb_t.sfeb007, #單位
       sfeb008 LIKE sfeb_t.sfeb008, #申請數量
       sfeb009 LIKE sfeb_t.sfeb009, #實際數量
       sfeb010 LIKE sfeb_t.sfeb010, #參考單位
       sfeb011 LIKE sfeb_t.sfeb011, #申請參考數量
       sfeb012 LIKE sfeb_t.sfeb012, #實際參考數量
       sfeb013 LIKE sfeb_t.sfeb013, #指定庫位
       sfeb014 LIKE sfeb_t.sfeb014, #指定儲位
       sfeb015 LIKE sfeb_t.sfeb015, #指定批號
       sfeb016 LIKE sfeb_t.sfeb016, #庫存管理特徵
       sfeb017 LIKE sfeb_t.sfeb017, #專案編號
       sfeb018 LIKE sfeb_t.sfeb018, #WBS
       sfeb019 LIKE sfeb_t.sfeb019, #活動編號
       sfeb020 LIKE sfeb_t.sfeb020, #理由碼
       sfeb021 LIKE sfeb_t.sfeb021, #庫存有效日期
       sfeb022 LIKE sfeb_t.sfeb022, #庫存備註
       sfeb023 LIKE sfeb_t.sfeb023, #生產料號
       sfeb024 LIKE sfeb_t.sfeb024, #生產料號BOM特性
       sfeb025 LIKE sfeb_t.sfeb025, #生產料號特徵
       sfeb026 LIKE sfeb_t.sfeb026, #RUN CARD
       sfeb027 LIKE sfeb_t.sfeb027, #檢驗合格量
       sfeb028 LIKE sfeb_t.sfeb028  #製造日期
  END RECORD
  #161109-00085#41-e
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
   SELECT COUNT(*) INTO l_cnt FROM sfeb_t
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
   DECLARE asfp400_01_cs1 CURSOR FOR
   #161109-00085#41-s
   #SELECT * FROM sfeb_t
   SELECT sfebent,sfebsite,sfebdocno,sfebseq,sfeb001,
          sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,
          sfeb007,sfeb008,sfeb009,sfeb010,sfeb011,
          sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,
          sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,
          sfeb022,sfeb023,sfeb024,sfeb025,sfeb026,
          sfeb027,sfeb028
        FROM sfeb_t
   #161109-00085#41-e
     WHERE sfebent   = g_enterprise
       AND sfebdocno = p_sfeadocno
       AND sfeb002   = 'Y'
       
   LET l_flag = 'N'
   #161109-00085#41-s
   #FOREACH asfp400_01_cs1 INTO l_sfeb.*
   FOREACH asfp400_01_cs1 
   INTO l_sfeb.sfebent,l_sfeb.sfebsite,l_sfeb.sfebdocno,l_sfeb.sfebseq,l_sfeb.sfeb001,
        l_sfeb.sfeb002,l_sfeb.sfeb003,l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb006,
        l_sfeb.sfeb007,l_sfeb.sfeb008,l_sfeb.sfeb009,l_sfeb.sfeb010,l_sfeb.sfeb011,
        l_sfeb.sfeb012,l_sfeb.sfeb013,l_sfeb.sfeb014,l_sfeb.sfeb015,l_sfeb.sfeb016,
        l_sfeb.sfeb017,l_sfeb.sfeb018,l_sfeb.sfeb019,l_sfeb.sfeb020,l_sfeb.sfeb021,
        l_sfeb.sfeb022,l_sfeb.sfeb023,l_sfeb.sfeb024,l_sfeb.sfeb025,l_sfeb.sfeb026,
        l_sfeb.sfeb027,l_sfeb.sfeb028
   #161109-00085#41-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asfp400_01_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success         
      END IF
      
      LET l_qc_qty = 0
      SELECT SUM(pmdl017) INTO l_qc_qty FROM pmdl_t
       WHERE pmdlent  = g_enterprise
         AND pmdlsite = l_sfeb.sfebsite
         AND pmdl001  = l_sfeb.sfebdocno
         AND pmdl002  = l_sfeb.sfebseq
         AND pmdlstus <> 'X'
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

################################################################################
# Descriptions...: 检查日期
# Memo...........:
# Usage..........: CALL asfp400_01_chk_date(p_date)
#                  RETURNING r_success
# Input parameter: p_date      单据日期
# Return code....: r_success   检查通过否
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_01_chk_date(p_date)
   DEFINE p_date         LIKE type_t.dat
   DEFINE l_i            LIKE type_t.num10
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   
   LET r_success = FALSE
   
   FOR l_i = 1 TO g_rec_b1
       IF g_sfcb_d[l_i].sel = 'N' THEN
          CONTINUE FOR
       END IF
       
       #预计交期
       CALL s_asfp400_chk_sfcb045(g_sfcb_d[l_i].b_sfcbdocno,g_sfcb_d[l_i].b_sfcb044,g_sfcb_d[l_i].b_sfcb045,p_date)
            RETURNING l_success
       IF NOT l_success THEN
          RETURN r_success
       END IF       

   END FOR
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查单别
# Memo...........:
# Usage..........: CALL asfp400_01_chk_doc_type(p_doc_type)
#                  RETURNING r_success
# Input parameter: p_doc_type  采购单别
# Return code....: r_success   检查通过否
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_01_chk_doc_type(p_doc_type)
   DEFINE p_doc_type     LIKE ooba_t.ooba002
   DEFINE l_i            LIKE type_t.num10
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   
   LET r_success = FALSE
   
   CALL s_aooi200_chk_slip(g_site,'',g_pmdl_m.pmdldocno,'apmt501')
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   FOR l_i = 1 TO g_rec_b1
       IF g_sfcb_d[l_i].sel = 'N' THEN
          CONTINUE FOR
       END IF

       #委外厂商
       CALL s_asfp400_chk_sfcb013(g_sfcb_d[l_i].b_sfcbdocno,g_sfcb_d[l_i].b_sfcb013,p_doc_type)
            RETURNING l_success
       IF NOT l_success THEN
          RETURN r_success
       END IF    

   END FOR
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

 
{</section>}
 
