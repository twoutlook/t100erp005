#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi110_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-01-06 16:08:10), PR版次:0002(2016-12-14 14:45:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000125
#+ Filename...: aooi110_01
#+ Description: 組織資料準備
#+ Creator....: 01258(2013-08-16 10:41:44)
#+ Modifier...: 02482 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi110_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#161124-00048#7   2016/12/12  By 08734   星号整批调整
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
 
{<section id="aooi110_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_wcb                 STRING
DEFINE g_ooeb001             LIKE ooeb_t.ooeb001
#end add-point
 
{</section>}
 
{<section id="aooi110_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aooi110_01.other_dialog" >}

 
{</section>}
 
{<section id="aooi110_01.other_function" readonly="Y" >}

PUBLIC FUNCTION aooi110_01(p_ooeb001)
DEFINE p_ooeb001     LIKE ooeb_t.ooeb001
#DEFINE l_ooeb        RECORD LIKE ooeb_t.*  #161124-00048#7  2016/12/12 By 08734 mark
#161124-00048#7  2016/12/12 By 08734 add(S)
DEFINE l_ooeb RECORD  #組織計劃申請單頭檔
       ooebent LIKE ooeb_t.ooebent, #企业编号
       ooebstus LIKE ooeb_t.ooebstus, #状态码
       ooeb001 LIKE ooeb_t.ooeb001, #申请编号
       ooeb002 LIKE ooeb_t.ooeb002, #申请日期
       ooeb003 LIKE ooeb_t.ooeb003, #变更类型
       ooeb004 LIKE ooeb_t.ooeb004, #组织类型
       ooeb005 LIKE ooeb_t.ooeb005, #最上层组织
       ooeb006 LIKE ooeb_t.ooeb006, #版本
       ooeb007 LIKE ooeb_t.ooeb007, #生效日期
       ooeb008 LIKE ooeb_t.ooeb008, #失效日期
       ooebownid LIKE ooeb_t.ooebownid, #资料所有者
       ooebowndp LIKE ooeb_t.ooebowndp, #资料所有部门
       ooebcrtid LIKE ooeb_t.ooebcrtid, #资料录入者
       ooebcrtdp LIKE ooeb_t.ooebcrtdp, #资料录入部门
       ooebcrtdt LIKE ooeb_t.ooebcrtdt, #资料创建日
       ooebmodid LIKE ooeb_t.ooebmodid, #资料更改者
       ooebmoddt LIKE ooeb_t.ooebmoddt, #最近更改日
       ooebcnfid LIKE ooeb_t.ooebcnfid, #资料审核者
       ooebcnfdt LIKE ooeb_t.ooebcnfdt #数据审核日
END RECORD
#161124-00048#7  2016/12/12 By 08734 add(E)


   LET g_ooeb001 = p_ooeb001
   INITIALIZE l_ooeb.* TO NULL
   #SELECT * INTO l_ooeb.*  #161124-00048#7  2016/12/12 By 08734 mark
   SELECT ooebent,ooebstus,ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt,ooebmodid,ooebmoddt,ooebcnfid,ooebcnfdt INTO l_ooeb.*  #161124-00048#7  2016/12/12 By 08734 add
     FROM ooeb_t
    WHERE ooebent = g_enterprise
      AND ooeb001 = g_ooeb001
   OPEN WINDOW aooi110_01_w WITH FORM cl_ap_formpath("aoo","aooi110_01")
        ATTRIBUTE (STYLE="functionwin")

   CALL cl_set_act_visible("accept,cancel", TRUE)

      CONSTRUCT g_wcb ON ooef001 FROM ooef001
         BEFORE CONSTRUCT
             CALL cl_qbe_init()

         ON ACTION controlp INFIELD ooef001
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            IF cl_null(l_ooeb.ooeb008) THEN
               LET g_qryparam.where = " ooef001 <> '",l_ooeb.ooeb005,"' AND ooef001 NOT IN(SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed001 = '",l_ooeb.ooeb004,"' AND ooed002 <> '",l_ooeb.ooeb005,"'  AND (ooed007 >= to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') OR ooed007 IS NULL)) AND ooef001 IN(SELECT ooef001 FROM ooef_t,ooee_t WHERE ooefent = ooeeent AND ooefent = '",g_enterprise,"' AND ooef001 = ooee001 AND ooee002 = '1' AND ooee003 = '",l_ooeb.ooeb004,"' )"
            ELSE
               LET g_qryparam.where = " ooef001 <> '",l_ooeb.ooeb005,"' AND ooef001 NOT IN(SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed001 = '",l_ooeb.ooeb004,"' AND ooed002 <> '",l_ooeb.ooeb005,"'  AND (ooed006 BETWEEN to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') AND to_date('",l_ooeb.ooeb008,"','YYYY/MM/DD') OR ooed007 BETWEEN to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') AND to_date('",l_ooeb.ooeb008,"','YYYY/MM/DD') OR (ooed006 <= to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') AND (ooed007 IS NULL OR ooed007 >= to_date('",l_ooeb.ooeb008,"','YYYY/MM/DD'))))) AND ooef001 IN(SELECT ooef001 FROM ooef_t,ooee_t WHERE ooefent = ooeeent AND ooefent = '",g_enterprise,"' AND ooef001 = ooee001 AND ooee002 = '1' AND ooee003 = '",l_ooeb.ooeb004,"' )"
            END IF
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO ooef001
            LET g_qryparam.where = ""
            NEXT FIELD ooef001

         ON ACTION accept
            LET INT_FLAG = FALSE
            ACCEPT CONSTRUCT

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT CONSTRUCT

         ON ACTION about
            CALL cl_about()

         ON ACTION EXIT
            LET INT_FLAG = TRUE
            EXIT CONSTRUCT
      END CONSTRUCT

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CLOSE WINDOW aooi110_01_w
         RETURN ''
      ELSE
         CLOSE WINDOW aooi110_01_w
         IF cl_null(l_ooeb.ooeb008) THEN
            LET g_wcb = g_wcb ," AND ooef001 <> '",l_ooeb.ooeb005,"' AND ooef001 NOT IN(SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed001 = '",l_ooeb.ooeb004,"' AND ooed002 <> '",l_ooeb.ooeb005,"'  AND (ooed007 >= to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') OR ooed007 IS NULL)) AND ooef001 IN(SELECT ooef001 FROM ooef_t,ooee_t WHERE ooefent = ooeeent AND ooefent = '",g_enterprise,"' AND ooef001 = ooee001 AND ooee002 = '1' AND ooee003 = '",l_ooeb.ooeb004,"' )"
         ELSE
            LET g_wcb = g_wcb ," AND ooef001 <> '",l_ooeb.ooeb005,"' AND ooef001 NOT IN(SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed001 = '",l_ooeb.ooeb004,"' AND ooed002 <> '",l_ooeb.ooeb005,"'  AND (ooed006 BETWEEN to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') AND to_date('",l_ooeb.ooeb008,"','YYYY/MM/DD') OR ooed007 BETWEEN to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') AND to_date('",l_ooeb.ooeb008,"','YYYY/MM/DD') OR (ooed006 <= to_date('",l_ooeb.ooeb007,"','YYYY/MM/DD') AND (ooed007 IS NULL OR ooed007 >= to_date('",l_ooeb.ooeb008,"','YYYY/MM/DD'))))) AND ooef001 IN(SELECT ooef001 FROM ooef_t,ooee_t WHERE ooefent = ooeeent AND ooefent = '",g_enterprise,"' AND ooef001 = ooee001 AND ooee002 = '1' AND ooee003 = '",l_ooeb.ooeb004,"' )"
         END IF
         RETURN g_wcb
      END IF
      LET INT_FLAG = FALSE
END FUNCTION

 
{</section>}
 
