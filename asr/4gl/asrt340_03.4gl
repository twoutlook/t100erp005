#該程式未解開Section, 採用最新樣板產出!
{<section id="asrt340_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-03-28 16:37:56), PR版次:0005(2016-12-19 11:12:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000124
#+ Filename...: asrt340_03
#+ Description: 重複性完工入庫單 - 倒扣料產生作業
#+ Creator....: 00378(2014-03-14 15:41:44)
#+ Modifier...: 00378 -SD/PR- 01996
 
{</section>}
 
{<section id="asrt340_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160512-00016#14     2016/05/27 By ming s_asft300_02_bom增加參數 
#160512-00016#26 2016/05/31 By 02295 保税否栏位給值N
#161124-00048#12 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
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
 
{<section id="asrt340_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
type type_g_sfda_m         RECORD
                           sfdadocno LIKE sfda_t.sfdadocno,
                           sfdadocdt LIKE sfda_t.sfdadocdt
                           END RECORD
DEFINE g_sfda_m            type_g_sfda_m
DEFINE g_sfdadocno_t       LIKE sfda_t.sfdadocno
DEFINE g_ref_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
TYPE type_bmba             RECORD #回传数组
                           bmba001    LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
                           bmba002    LIKE bmba_t.bmba002,
                           bmba003    LIKE bmba_t.bmba003,
                           bmba004    LIKE bmba_t.bmba004,
                           bmba005    DATETIME YEAR TO SECOND,
                           bmba007    LIKE bmba_t.bmba007,
                           bmba008    LIKE bmba_t.bmba008,
                           bmba035    LIKE bmba_t.bmba035,     #保稅否   #160512-00016#26
                           l_bmba011  LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
                           l_bmba012  LIKE bmba_t.bmba012      #QPA 分母，对应于原始的主件料号
                           END RECORD

{</Module define>}
#end add-point
 
{</section>}
 
{<section id="asrt340_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="asrt340_03.other_dialog" >}

 
{</section>}
 
{<section id="asrt340_03.other_function" readonly="Y" >}

PUBLIC FUNCTION asrt340_03(--)
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
   
   CALL asrt340_03_chk(p_sfeadocno)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   SELECT sfeasite INTO l_site FROM sfea_t WHERE sfeaent = g_enterprise AND sfeadocno = p_sfeadocno   

   #畫面開啟 (identifier)
   OPEN WINDOW w_asrt340_03 WITH FORM cl_ap_formpath("asr","asrt340_03")

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
            CALL s_aooi200_chk_slip(l_site,'',g_sfda_m.sfdadocno,'asrt310')
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
            LET g_qryparam.arg2 = "asrt310"
            CALL q_ooba002_6()                                #呼叫開窗
            LET g_sfda_m.sfdadocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_sfda_m.sfdadocno TO sfdadocno           #顯示到畫面上
            NEXT FIELD sfdadocno  

         AFTER INPUT
            IF cl_ask_promp('asf-00182') THEN
               CALL s_asrt310_gen('17',p_sfeadocno,0,g_sfda_m.sfdadocno,g_sfda_m.sfdadocdt)
                    RETURNING l_success,l_start_no,l_end_no
               IF l_success THEN
                  #成功产生单据，单据范围：%1 ~ %2
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00251'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_start_no 
                  LET g_errparam.replace[2] =  l_end_no
                  CALL cl_err()

               END IF
               LET r_success = l_success
               EXIT DIALOG
            END IF

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
   CLOSE WINDOW w_asrt340_03
   RETURN r_success

   #add-point:input段after input
   {<point name="input.post_input"/>}
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 入库单状态检查
# Memo...........:
# Usage..........: CALL asrt340_03_chk(p_sfeadocno)
#                  RETURNING r_success
# Input parameter: p_sfeadocno    完工入库单
# Return code....: r_success      需倒扣料发料否标识符
# Date & Author..: 2014-01-26 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_03_chk(p_sfeadocno)
   DEFINE p_sfeadocno       LIKE sfea_t.sfeadocno
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
#   DEFINE l_sfea            RECORD LIKE sfea_t.* #161124-00048#12 mark
   #161124-00048#12 add-s
   DEFINE l_sfea RECORD  #完工入庫單頭檔
       sfeaent LIKE sfea_t.sfeaent, #企业编号
       sfeasite LIKE sfea_t.sfeasite, #营运据点
       sfeadocno LIKE sfea_t.sfeadocno, #单号
       sfeadocdt LIKE sfea_t.sfeadocdt, #单据日期
       sfea001 LIKE sfea_t.sfea001, #过账日期
       sfea002 LIKE sfea_t.sfea002, #申请人
       sfea003 LIKE sfea_t.sfea003, #部门
       sfea004 LIKE sfea_t.sfea004, #PBI编号
       sfea005 LIKE sfea_t.sfea005, #倒扣领料单号
       sfeaownid LIKE sfea_t.sfeaownid, #资料所有者
       sfeaowndp LIKE sfea_t.sfeaowndp, #资料所有部门
       sfeacrtid LIKE sfea_t.sfeacrtid, #资料录入者
       sfeacrtdp LIKE sfea_t.sfeacrtdp, #资料录入部门
       sfeacrtdt LIKE sfea_t.sfeacrtdt, #资料创建日
       sfeamodid LIKE sfea_t.sfeamodid, #资料更改者
       sfeamoddt LIKE sfea_t.sfeamoddt, #最近更改日
       sfeacnfid LIKE sfea_t.sfeacnfid, #资料审核者
       sfeacnfdt LIKE sfea_t.sfeacnfdt, #数据审核日
       sfeapstid LIKE sfea_t.sfeapstid, #资料过账者
       sfeapstdt LIKE sfea_t.sfeapstdt, #资料过账日
       sfeastus LIKE sfea_t.sfeastus, #状态码
       sfea006 LIKE sfea_t.sfea006  #生产计划
   END RECORD
   #161124-00048#12 add-e
   DEFINE l_bmba            DYNAMIC ARRAY OF type_bmba  
#   DEFINE l_sfeb            RECORD LIKE sfeb_t.*   #161124-00048#12 mark
   #161124-00048#12 add-s
   DEFINE l_sfeb RECORD  #完工入庫申請檔
       sfebent LIKE sfeb_t.sfebent, #企业编号
       sfebsite LIKE sfeb_t.sfebsite, #营运据点
       sfebdocno LIKE sfeb_t.sfebdocno, #完工入库单号
       sfebseq LIKE sfeb_t.sfebseq, #项次
       sfeb001 LIKE sfeb_t.sfeb001, #工单单号
       sfeb002 LIKE sfeb_t.sfeb002, #FQC
       sfeb003 LIKE sfeb_t.sfeb003, #入库类型
       sfeb004 LIKE sfeb_t.sfeb004, #料件编号
       sfeb005 LIKE sfeb_t.sfeb005, #特征
       sfeb006 LIKE sfeb_t.sfeb006, #包装容器
       sfeb007 LIKE sfeb_t.sfeb007, #单位
       sfeb008 LIKE sfeb_t.sfeb008, #申请数量
       sfeb009 LIKE sfeb_t.sfeb009, #实际数量
       sfeb010 LIKE sfeb_t.sfeb010, #参考单位
       sfeb011 LIKE sfeb_t.sfeb011, #申请参考数量
       sfeb012 LIKE sfeb_t.sfeb012, #实际参考数量
       sfeb013 LIKE sfeb_t.sfeb013, #指定库位
       sfeb014 LIKE sfeb_t.sfeb014, #指定储位
       sfeb015 LIKE sfeb_t.sfeb015, #指定批号
       sfeb016 LIKE sfeb_t.sfeb016, #库存管理特征
       sfeb017 LIKE sfeb_t.sfeb017, #项目编号
       sfeb018 LIKE sfeb_t.sfeb018, #WBS
       sfeb019 LIKE sfeb_t.sfeb019, #活动编号
       sfeb020 LIKE sfeb_t.sfeb020, #理由码
       sfeb021 LIKE sfeb_t.sfeb021, #库存有效日期
       sfeb022 LIKE sfeb_t.sfeb022, #库存备注
       sfeb023 LIKE sfeb_t.sfeb023, #生产料号
       sfeb024 LIKE sfeb_t.sfeb024, #生产料号BOM特性
       sfeb025 LIKE sfeb_t.sfeb025, #生产料号特征
       sfeb026 LIKE sfeb_t.sfeb026, #RUN CARD
       sfeb027 LIKE sfeb_t.sfeb027, #检验合格量
       sfeb028 LIKE sfeb_t.sfeb028  #制造日期
END RECORD
   #161124-00048#12 add-e
   DEFINE l_bmad004         LIKE bmad_t.bmad004
   DEFINE l_qty             LIKE sfeb_t.sfeb009
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_imae016         LIKE imae_t.imae016
   DEFINE l_bmad005         LIKE bmad_t.bmad005
   DEFINE l_rate            LIKE inaj_t.inaj014
   DEFINE l_imae091         LIKE imae_t.imae091
   DEFINE l_success         LIKE type_t.num5 
   DEFINE l_bmba010         LIKE bmba_t.bmba010
   DEFINE l_bmba005_1       LIKE ooff_t.ooff007
   DEFINE l_qty1            LIKE sfec_t.sfec009

   LET r_success = FALSE
   
   #1.检查完工入库单存在否   
#   SELECT * INTO l_sfea.* FROM sfea_t  #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT sfeaent,sfeasite,sfeadocno,sfeadocdt,sfea001,sfea002,sfea003,
          sfea004,sfea005,sfeaownid,sfeaowndp,sfeacrtid,sfeacrtdp,sfeacrtdt,
          sfeamodid,sfeamoddt,sfeacnfid,sfeacnfdt,sfeapstid,sfeapstdt,
          sfeastus,sfea006 
     INTO l_sfea.* FROM sfea_t
   #161124-00048#12 add(e)
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
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM sfed_t
    WHERE sfedent   = g_enterprise
      AND sfeddocno = l_sfea.sfeadocno
   IF l_cnt >0 THEN
      #已经产生过倒扣料发料单了,不可重复产生
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00091'
      LET g_errparam.extend = l_sfea.sfea005
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #4.根据入库料件展备料
   DECLARE asrt340_03_cs1 CURSOR FOR
#    SELECT * FROM sfeb_t   #161124-00048#12 mark
    #161124-00048#12 add(s)
    SELECT sfebent,sfebsite,sfebdocno,sfebseq,sfeb001,sfeb002,sfeb003,
           sfeb004,sfeb005,sfeb006,sfeb007,sfeb008,sfeb009,sfeb010,sfeb011,
           sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb017,sfeb018,sfeb019,
           sfeb020,sfeb021,sfeb022,sfeb023,sfeb024,sfeb025,sfeb026,sfeb027,
           sfeb028 FROM sfeb_t
    #161124-00048#12 add(e)
     WHERE sfebent   = g_enterprise
       AND sfebdocno = p_sfeadocno
       AND sfeb003   IN ('1','2','3','5')
   FOREACH asrt340_03_cs1 INTO l_sfeb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asrt340_03_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      LET l_bmad004 = 1
      
      #取主件的生产单位
      SELECT imae016 INTO l_imae016 FROM imae_t
       WHERE imaeent  = g_enterprise
         AND imaesite = l_sfeb.sfebsite
         AND imae001  = l_sfeb.sfeb023
      IF l_sfeb.sfeb003 MATCHES '[12]' THEN    #主件/联产品
         LET l_bmad005 = l_imae016
      END IF
      
      #入库类型非1/2时,要做转换成主件数量
      IF l_sfeb.sfeb003 = '3' THEN   #多产出主件
         SELECT bmad005,bmad004 INTO l_bmad005,l_bmad004 FROM bmad_t
          WHERE bmadent  = g_enterprise
            AND bmadsite = l_sfeb.sfebsite
            AND bmad001  = l_sfeb.sfeb023
            AND bmad002  = l_sfeb.sfeb024
            AND bmad003  = l_sfeb.sfeb004
          IF cl_null(l_bmad004) OR l_bmad004 = 0 THEN
             LET l_bmad004 = 1
          END IF
      END IF
      
      IF l_sfeb.sfeb003 = '5' THEN   #副产品
         SELECT bmac004,bmac005 / bmac006 INTO l_bmad005,l_bmad004 FROM bmac_t
          WHERE bmacent  = g_enterprise
            AND bmacsite = l_sfeb.sfebsite
            AND bmac001  = l_sfeb.sfeb023
            AND bmac002  = l_sfeb.sfeb024
            AND bmac003  = l_sfeb.sfeb004
          IF cl_null(l_bmad004) OR l_bmad004 = 0 THEN
             LET l_bmad004 = 1
          END IF
      END IF

      LET l_rate = 1 
      LET l_qty = l_sfeb.sfeb009 / l_bmad004
      
      LET l_qty1 = l_qty
      IF l_bmad005 <> l_sfeb.sfeb007 THEN
#         CALL s_aimi190_get_convert(l_sfeb.sfeb004,l_sfeb.sfeb007,l_bmad005)
#              RETURNING l_success,l_rate
#         IF NOT l_success THEN
#            LET l_rate = 1
#         END IF
         CALL s_aooi250_convert_qty(l_sfeb.sfeb004,l_sfeb.sfeb007,l_bmad005,l_qty)
              RETURNING l_success,l_qty1
         IF NOT l_success THEN
            LET l_qty1 = l_qty
         END IF
      END IF
#      LET l_qty = l_qty * l_rate
      LET l_qty = l_qty1

      #160512-00016#14 20160527 modify by ming -----(S) 
      #目前不確定此程式是否走保稅，所以不指定Y/N 
      #CALL s_asft300_02_bom(0,l_sfeb.sfeb023,l_sfeb.sfeb024,l_imae016,1,1,l_sfea.sfeadocdt,'N','',l_sfeb.sfeb025,'N')
      #     RETURNING l_bmba
      CALL s_asft300_02_bom(0,l_sfeb.sfeb023,l_sfeb.sfeb024,l_imae016,1,1,l_sfea.sfeadocdt,'N','',l_sfeb.sfeb025,'N','N')   #160512-00016#26 保税否栏位給值N
           RETURNING l_bmba     
      #160512-00016#14 20160527 modify by ming -----(E) 
      FOR l_i = 1 TO l_bmba.getLength()
          SELECT imae091 INTO l_imae091 FROM imae_t
           WHERE imaeent  = g_enterprise
             AND imaesite = l_sfeb.sfebsite
             AND imae001  = l_sfeb.sfeb023
          IF l_imae091 = 'Y' THEN    #倒扣料
             SELECT COUNT(*) INTO l_cnt FROM asrt310_tmp_t
              WHERE bmba001 = l_sfeb.sfeb023          #主件
                AND bmba002 = l_sfeb.sfeb024          #主件特性
                AND eigen   = l_sfeb.sfeb025          #主件特征
                AND bmba003 = l_bmba[l_i].bmba003     #下阶料
                AND bmba007 = l_bmba[l_i].bmba007     #作业编号
                AND bmba008 = l_bmba[l_i].bmba008     #作业序
                AND bmba011 = l_bmba[l_i].l_bmba011   #组成用量
                AND bmba012 = l_bmba[l_i].l_bmba012   #底数
             IF l_cnt = 0 THEN
                #取发料单位
                SELECT bmba010 INTO l_bmba010 FROM bmba_t
                 WHERE bmbaent  = g_enterprise
                   AND bmbasite = l_sfea.sfeasite
                   AND bmba001  = l_sfeb.sfeb023
                   AND bmba002  = l_sfeb.sfeb024
                   AND bmba003  = l_bmba[l_i].bmba003
                   AND bmba004  = l_bmba[l_i].bmba004
                   AND bmba005  = l_bmba[l_i].bmba005
                   AND bmba007  = l_bmba[l_i].bmba007
                   AND bmba008  = l_bmba[l_i].bmba008             
             
                INSERT INTO asrt310_tmp_t 
                       VALUES(l_sfeb.sfeb023     ,l_sfeb.sfeb024       ,l_sfeb.sfeb025     ,
                              l_qty              ,l_bmba[l_i].bmba003  ,l_bmba[l_i].bmba004,
                              ''                 ,l_bmba[l_i].bmba007  ,l_bmba[l_i].bmba008,
                              l_bmba010          ,l_bmba[l_i].l_bmba011,l_bmba[l_i].l_bmba012)
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'insert asrt310_tmp_t'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   RETURN r_success
                END IF
             ELSE
                UPDATE asrt310_tmp_t SET sets = sets + l_qty
                 WHERE bmba001 = l_sfeb.sfeb023          #主件
                   AND bmba002 = l_sfeb.sfeb024          #主件特性
                   AND eigen   = l_sfeb.sfeb025          #主件特征
                   AND bmba003 = l_bmba[l_i].bmba003     #下阶料
                   AND bmba007 = l_bmba[l_i].bmba007     #作业编号
                   AND bmba008 = l_bmba[l_i].bmba008     #作业序
                   AND bmba011 = l_bmba[l_i].l_bmba011   #组成用量
                   AND bmba012 = l_bmba[l_i].l_bmba012   #底数 
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = 'update asrt310_tmp_t'
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   RETURN r_success
                END IF                  
             END IF
          END IF
      END FOR
   END FOREACH
   
   
   #5.检查工单是否有倒扣料的项次,若没有则不可以产生倒扣料领料单
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM asrt310_tmp_t
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
 
