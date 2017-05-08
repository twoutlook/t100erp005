#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp360_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-08-31 22:29:36), PR版次:0008(2017-01-24 09:38:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000094
#+ Filename...: asfp360_04
#+ Description: 產生單據
#+ Creator....: 00768(2014-05-16 14:37:57)
#+ Modifier...: 00768 -SD/PR- 08992
 
{</section>}
 
{<section id="asfp360_04.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#21   2016/04/19  BY 07900    校验代码重复错误讯息的修改
#160408-00035#7 16/04/21 By xianghui  插入sfdd时增加备置量和在拣量的计算
#160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01,asfp360_03_temp3 ——> asfp360_tmp02,asfp360_05_temp3 ——> asfp360_tmp04
#161109-00085#42 2016/11/16 By lienjunqi    整批調整系統星號寫法
#170104-00066#1  2017/01/04  By Rainy     筆數相關變數由num5放大至num10
#170123-00011#1  2016/01/24 By 08992 補上SQL遺漏ent條件
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../asf/4gl/asfp360.inc"
#end add-point
 
{</section>}
 
{<section id="asfp360_04.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 
#end add-point
 
{</section>}
 
{<section id="asfp360_04.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE l_ac                  LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
#end add-point
 
{</section>}
 
{<section id="asfp360_04.other_dialog" >}

DIALOG asfp360_04_input()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_where      STRING
   DEFINE l_inaa007     LIKE inaa_t.inaa007   #儲位控管
   
   INPUT g_asfp360_04_m.user,g_asfp360_04_m.slips,g_asfp360_04_m.slipr,g_asfp360_04_m.ware,g_asfp360_04_m.loca,g_asfp360_04_m.lot
      FROM user_04a,slips_04a,slipr_04a,ware_04a,loca_04a,lot_04a
      
      ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT

      AFTER FIELD user_04a
         CALL asfp360_04_chk_column('user_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         CALL s_desc_get_person_desc(g_asfp360_04_m.user) RETURNING g_asfp360_04_m.user_desc
         DISPLAY g_asfp360_04_m.user_desc TO user_04a_desc

      AFTER FIELD slips_04a
         CALL asfp360_04_chk_column('slips_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         
         CALL s_aooi200_get_slip_desc(g_asfp360_04_m.slips) RETURNING g_asfp360_04_m.slips_desc
         DISPLAY g_asfp360_04_m.slips_desc TO slips_04a_desc

      AFTER FIELD slipr_04a
         CALL asfp360_04_chk_column('slipr_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         
         CALL s_aooi200_get_slip_desc(g_asfp360_04_m.slipr) RETURNING g_asfp360_04_m.slipr_desc
         DISPLAY g_asfp360_04_m.slipr_desc TO slipr_04a_desc

      AFTER FIELD ware_04a
         CALL asfp360_04_chk_column('ware_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         
         CALL s_desc_get_stock_desc(g_site,g_asfp360_04_m.ware) RETURNING g_asfp360_04_m.ware_desc
         DISPLAY g_asfp360_04_m.ware_desc TO ware_04a_desc
         IF NOT cl_null(g_asfp360_04_m.ware) AND NOT cl_null(g_asfp360_04_m.loca) THEN
            CALL s_desc_get_locator_desc(g_site,g_asfp360_04_m.ware,g_asfp360_04_m.loca) RETURNING g_asfp360_04_m.loca_desc
            DISPLAY g_asfp360_04_m.loca_desc TO loca_04a_desc
         END IF

      BEFORE FIELD loca_04a
         IF cl_null(g_asfp360_04_m.ware) THEN
            #请先维护库位
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00419'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD ware_04a
         END IF
         
      AFTER FIELD loca_04a
         CALL asfp360_04_chk_column('loca_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         
         IF NOT cl_null(g_asfp360_04_m.ware) AND NOT cl_null(g_asfp360_04_m.loca) THEN
            CALL s_desc_get_locator_desc(g_site,g_asfp360_04_m.ware,g_asfp360_04_m.loca) RETURNING g_asfp360_04_m.loca_desc
            DISPLAY g_asfp360_04_m.loca_desc TO loca_04a_desc
         END IF

      AFTER FIELD lot_04a
         CALL asfp360_04_chk_column('lot_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         
         IF NOT cl_null(g_asfp360_04_m.lot) THEN
            CALL s_aooi200_get_slip_desc(g_asfp360_04_m.lot) RETURNING g_asfp360_04_m.lot_desc
            DISPLAY g_asfp360_04_m.lot_desc TO lot_04a
         END IF

      ON ACTION controlp INFIELD user_04a
         #開窗i段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_asfp360_04_m.user           #給予default值
         LET g_qryparam.default2 = "" #g_sfda_m.oofa011 #全名
         #給予arg
         CALL q_ooag001_8()                                #呼叫開窗
         LET g_asfp360_04_m.user = g_qryparam.return1              #將開窗取得的值回傳到變數
         DISPLAY g_asfp360_04_m.user TO user_04a              #顯示到畫面上
         CALL s_desc_get_person_desc(g_asfp360_04_m.user) RETURNING g_asfp360_04_m.user_desc
         DISPLAY g_asfp360_04_m.user_desc TO user_04a_desc
         NEXT FIELD user_04a                          #返回原欄位

      ON ACTION controlp INFIELD slips_04a
         #開窗i段
         SELECT ooef004 INTO l_ooef004 FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
            
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_asfp360_04_m.slips           #給予default值
         #給予arg
         LET g_qryparam.arg1 = l_ooef004 #參照表編號
         IF g_asfp360_02_m.type = '1' THEN
            #1.成套挪料
            LET g_qryparam.arg2 = "asft311" #作业代号 成套发料
         ELSE
            #2.单颗挪料
            LET g_qryparam.arg2 = "asft313" #作业代号 欠料补料
         END IF
         CALL q_ooba002_8()                                #呼叫開窗
         LET g_asfp360_04_m.slips = g_qryparam.return1              #將開窗取得的值回傳到變數
         DISPLAY g_asfp360_04_m.slips TO slips_04a              #顯示到畫面上
         CALL s_aooi200_get_slip_desc(g_asfp360_04_m.slips) RETURNING g_asfp360_04_m.slips_desc
         DISPLAY g_asfp360_04_m.slips_desc TO slips_04a_desc
         NEXT FIELD slips_04a                          #返回原欄位
   
      ON ACTION controlp INFIELD slipr_04a
         #開窗i段
         SELECT ooef004 INTO l_ooef004 FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
            
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_asfp360_04_m.slipr           #給予default值
         #給予arg
         LET g_qryparam.arg1 = l_ooef004 #參照表編號
         IF g_asfp360_02_m.type = '1' THEN
            #1.成套挪料
            LET g_qryparam.arg2 = "asft321" #作业代号 成套退料
         ELSE
            #2.单颗挪料
            LET g_qryparam.arg2 = "asft323" #作业代号 一般退料
         END IF
         CALL q_ooba002_8()                                #呼叫開窗
         LET g_asfp360_04_m.slipr = g_qryparam.return1              #將開窗取得的值回傳到變數
         DISPLAY g_asfp360_04_m.slipr TO slipr_04a              #顯示到畫面上
         CALL s_aooi200_get_slip_desc(g_asfp360_04_m.slipr) RETURNING g_asfp360_04_m.slipr_desc
         DISPLAY g_asfp360_04_m.slipr_desc TO slipr_04a_desc
         NEXT FIELD slipr_04a                          #返回原欄位

      ON ACTION controlp INFIELD ware_04a
         #仓库
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_asfp360_04_m.ware
         LET g_qryparam.where = " 1=1"

         #关于控制组
         IF NOT cl_null(g_asfp360_04_m.slips) THEN
            CALL s_control_get_doc_sql("inaa001",g_asfp360_04_m.slips,'6')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
         END IF
         IF NOT cl_null(g_asfp360_04_m.slipr) THEN
            CALL s_control_get_doc_sql("inaa001",g_asfp360_04_m.slipr,'7')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
         END IF
         #关于控制组--end

         CALL q_inaa001_12()  #库位
         LET g_asfp360_04_m.ware = g_qryparam.return1
         DISPLAY g_asfp360_04_m.ware TO ware_04a
         CALL s_desc_get_stock_desc(g_site,g_asfp360_04_m.ware) RETURNING g_asfp360_04_m.ware_desc
         IF NOT cl_null(g_asfp360_04_m.loca) THEN
            CALL s_desc_get_locator_desc(g_site,g_asfp360_04_m.ware,g_asfp360_04_m.loca) RETURNING g_asfp360_04_m.loca_desc
         END IF
         DISPLAY g_asfp360_04_m.ware_desc TO ware_04a_desc
         DISPLAY g_asfp360_04_m.loca_desc TO loca_04a_desc
         NEXT FIELD ware_04a

      ON ACTION controlp INFIELD loca_04a
         IF cl_null(g_asfp360_04_m.ware) THEN
            #请先维护库位
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00419'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD ware_04a
         END IF
         #储位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = g_asfp360_04_m.ware
         LET g_qryparam.default1 = g_asfp360_04_m.loca
         CALL q_inab002_5()  #储位
         LET g_asfp360_04_m.loca = g_qryparam.return1
         DISPLAY g_asfp360_04_m.loca TO loca_04a
         #栏位说明
         CALL s_desc_get_locator_desc(g_site,g_asfp360_04_m.ware,g_asfp360_04_m.loca) RETURNING g_asfp360_04_m.loca_desc
         DISPLAY g_asfp360_04_m.loca_desc TO loca_04a_desc
         NEXT FIELD loca_04a

      ON ACTION gen_asft310  #产生发退料单
         CALL asfp360_04_chk_column('user_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD user_04a
         END IF
         CALL asfp360_04_chk_column('slips_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD slips_04a
         END IF
         CALL asfp360_04_chk_column('slipr_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD slipr_04a
         END IF
         CALL asfp360_04_chk_column('ware_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD ware_04a
         END IF
         CALL asfp360_04_chk_column('loca_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD loca_04a
         END IF
         CALL asfp360_04_chk_column('lot_04a') RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD lot_04a
         END IF
         
         SELECT inaa007 INTO l_inaa007  #儲位控管
           FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite= g_site
            AND inaa001 = g_asfp360_04_m.ware
         IF l_inaa007 != '5' THEN
            IF cl_null(g_asfp360_04_m.loca) THEN  #储位
               #当前库位限定使用储位管理，储位不可为空！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00271'
               LET g_errparam.extend = g_asfp360_04_m.ware
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD loca_04a
            END IF
         END IF
         
         IF NOT cl_null(g_asfp360_04_m2.send_no) THEN
            #单据已产生，不可重复产生
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00408'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            CALL asfp360_04_gen_asft310() RETURNING l_success
            IF l_success THEN
               CALL asfp360_04_show()
            ELSE
               #清空显示的资料变量
               LET g_asfp360_04_m2.sfladocno = ''  #挪料序号
               LET g_asfp360_04_m2.send_no =''
               LET g_asfp360_04_m2.return_no =''
            END IF
         END IF

   END INPUT
END DIALOG

DIALOG asfp360_04_display1()
   DISPLAY ARRAY g_asfp360_04_d1 TO s_asfp360_04_detail1.* ATTRIBUTE(COUNT = g_rec_b04_1)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_asfp360_04_detail1")

   END DISPLAY
END DIALOG

DIALOG asfp360_04_display2()
   DISPLAY ARRAY g_asfp360_04_d2 TO s_asfp360_04_detail2.* ATTRIBUTE(COUNT = g_rec_b04_2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_asfp360_04_detail2")

   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="asfp360_04.other_function" readonly="Y" >}

PUBLIC FUNCTION asfp360_04_init()

   WHENEVER ERROR CONTINUE

   #當整體參數有使用參考單位時才顯示
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_visible("sfdc009_04b1,sfdc009_04b1_desc,sfdc011_04b1",FALSE) #參考單位
      CALL cl_set_comp_visible("sfdc009_04b2,sfdc009_04b2_desc,sfdc011_04b2",FALSE) #參考單位
   END IF

END FUNCTION

#检查栏位
PUBLIC FUNCTION asfp360_04_chk_column(p_column)
   DEFINE p_column      LIKE type_t.chr20
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_prog        LIKE type_t.chr20
   DEFINE l_flag        LIKE type_t.num5  #s_control使用
   DEFINE l_inaa015     LIKE inaa_t.inaa015  #保税否
   DEFINE l_inaa010     LIKE inaa_t.inaa010  #成本库否
   DEFINE l_cnt         LIKE type_t.num10       #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_inaa007     LIKE inaa_t.inaa007   #儲位控管
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'user_04a'  #申请人
           IF cl_null(g_asfp360_04_m.user) THEN
              #此字段不可空白, 请输入数据!输入数据
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           IF NOT s_employee_chk(g_asfp360_04_m.user) THEN
              LET r_success = FALSE
              RETURN r_success
           END IF

      WHEN 'slips_04a' #发料单别
           IF cl_null(g_asfp360_04_m.slips) THEN
              #此字段不可空白, 请输入数据!输入数据
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           IF g_asfp360_02_m.type = '1' THEN
              #1.成套挪料
              LET l_prog = "asft311" #作业代号 成套发料
           ELSE
              #2.单颗挪料
              LET l_prog = "asft313" #作业代号 欠料补料
           END IF
           IF NOT s_aooi200_chk_slip(g_site,'',g_asfp360_04_m.slips,l_prog) THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #檢核輸入的單據別是否可以被key人員對應的控制組使用,'6' 為生管控制組類型
           CALL s_control_chk_doc('1',g_asfp360_04_m.slips,'6',g_user,g_dept,'','')
                RETURNING l_success,l_flag
           IF l_success THEN
              IF NOT l_flag THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           ELSE
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'slipr_04a' #退料单别
           IF cl_null(g_asfp360_04_m.slipr) THEN
              #此字段不可空白, 请输入数据!输入数据
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           IF g_asfp360_02_m.type = '1' THEN
              #1.成套挪料
              LET l_prog = "asft321" #作业代号 成套退料
           ELSE
              #2.单颗挪料
              LET l_prog = "asft323" #作业代号 一般退料
           END IF
           IF NOT s_aooi200_chk_slip(g_site,'',g_asfp360_04_m.slipr,l_prog) THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #檢核輸入的單據別是否可以被key人員對應的控制組使用,'6' 為生管控制組類型
           CALL s_control_chk_doc('1',g_asfp360_04_m.slipr,'6',g_user,g_dept,'','')
                RETURNING l_success,l_flag
           IF l_success THEN
              IF NOT l_flag THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           ELSE
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'ware_04a'  #库位
           IF cl_null(g_asfp360_04_m.ware) THEN
              #此字段不可空白, 请输入数据!输入数据
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           #是否存在库位资料
           INITIALIZE g_chkparam.* TO NULL
           LET g_chkparam.arg1 = g_asfp360_04_m.ware
           #160318-00025#21  by 07900 --add-str
           LET g_errshow = TRUE #是否開窗                   
           LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
           #160318-00025#21  by 07900 --add-end 
           IF NOT cl_chk_exist("v_inaa001_2") THEN
              LET r_success = FALSE
              RETURN r_success
           END IF

           #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位--发料单
           CALL s_control_chk_doc('6',g_asfp360_04_m.slips,g_asfp360_04_m.ware,'','','','')
              RETURNING l_success,l_flag
           IF NOT l_success OR NOT l_flag THEN
              #控制组检查错误,请检查单别设定的相关内容
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00122'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位--退料单
           CALL s_control_chk_doc('7',g_asfp360_04_m.slipr,g_asfp360_04_m.ware,'','','','')
              RETURNING l_success,l_flag
           IF NOT l_success OR NOT l_flag THEN
              #控制组检查错误,请检查单别设定的相关内容
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00122'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #如果储位已有，检查储位
           IF NOT cl_null(g_asfp360_04_m.loca) THEN
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_site
              LET g_chkparam.arg2 = g_asfp360_04_m.ware
              LET g_chkparam.arg3 = g_asfp360_04_m.loca
              #160318-00025#21  by 07900 --add-str
              LET g_errshow = TRUE #是否開窗                   
              LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
              #160318-00025#21  by 07900 --add-end 
              IF NOT cl_chk_exist("v_inab002") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF

           SELECT inaa010,inaa015,inaa007
             INTO l_inaa010,l_inaa015,l_inaa007  #成本库否，保税仓否,儲位控管
             FROM inaa_t
            WHERE inaaent = g_enterprise
              AND inaasite= g_site
              AND inaa001 = g_asfp360_04_m.ware
           IF cl_null(l_inaa015) THEN LET l_inaa015='N' END IF
           IF cl_null(l_inaa010) THEN LET l_inaa010='N' END IF

           #IF l_inaa007 != '5' THEN
           #   IF cl_null(g_asfp360_04_m.loca) THEN  #储位
           #      #当前库位限定使用储位管理，储位不可为空！
           #      INITIALIZE g_errparam TO NULL
           #      LET g_errparam.code = 'ain-00271'
           #      LET g_errparam.extend = g_asfp360_04_m.ware
           #      LET g_errparam.popup = TRUE
           #      CALL cl_err()
           #      LET r_success = FALSE
           #      RETURN r_success
           #   END IF
           #END IF

           #参数：生產非保稅料號，可由保稅倉發料
           CALL cl_get_doc_para(g_enterprise,g_site,g_asfp360_04_m.slips,'D-MFG-0031') RETURNING g_para
           IF l_inaa015='Y' AND (g_para = '1' OR g_para = '2') THEN #拒绝或警告
              #欲拋转的资料中有生产料号为非保税的资料吗
              SELECT COUNT(*) INTO l_cnt FROM imaf_t,asfp360_tmp01   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               WHERE imaf_t.imafent  = g_enterprise
                 AND imaf_t.imafsite = g_site
                 AND imaf_t.imaf001  = asfp360_tmp01.sfaa010   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                 AND asfp360_tmp01.sel = 'Y'  #欲拋转的资料    #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                 AND imaf034  = 'N'   #非保税料
              #當工單的生產料號=非保稅料，不可由保稅倉發料。
              IF l_cnt > 0  AND (g_para = '1' OR g_para = '2') THEN  #拒绝或警告
                 CASE
                    WHEN g_para = '1'
                         #当工单的生产料号为非保税料时，不可由保税仓发料！
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'asr-00008'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET r_success = FALSE
                         RETURN r_success
                    WHEN g_para = '2'
                         #拨出工单中，有非保税的生产料号将通过保税仓发料
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'asf-00421'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                 END CASE
              END IF
           END IF
           
           #參數：客供料可由成本倉料領料
           CALL cl_get_doc_para(g_enterprise,g_site,g_asfp360_04_m.slips,'D-MFG-0052') RETURNING g_para
           #1.拒絕時，只可輸入非成本倉。(2為警告)
           IF l_inaa010='Y' AND (g_para = '1' OR g_para = '2') THEN
              #检查发退料中是否存在客供料的资料
              #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
              SELECT COUNT(*) INTO l_cnt FROM asfp360_tmp01,asfp360_tmp02,sfba_t   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               WHERE asfp360_tmp01.sfaadocno = asfp360_tmp02.sfaadocno    #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                 AND asfp360_tmp02.sfaadocno = sfba_t.sfbadocno
                 AND asfp360_tmp02.sfbaseq   = sfba_t.sfbaseq
                 AND asfp360_tmp02.sfbaseq1  = sfba_t.sfbaseq1
                 AND sfba_t.sfbaent = g_enterprise
                 AND asfp360_tmp01.sel = 'Y'  #欲拋转的资料   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                 AND sfba028 = 'Y'  #客供料
              IF l_cnt > 0  AND (g_para = '1' OR g_para = '2') THEN  #拒绝或警告
                 CASE
                    WHEN g_para = '1' #拒绝
                         #客供料不可由成本仓领料
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'asf-00048'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET r_success = FALSE
                         RETURN r_success
                    WHEN g_para = '2' #警告
                         #挪料明细中，有客供料将通过成本仓领料
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'asf-00422'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                 END CASE
              END IF
           END IF

      WHEN 'loca_04a'  #储位
           IF NOT cl_null(g_asfp360_04_m.loca) THEN
              #检查库位+储位
              IF NOT cl_null(g_asfp360_04_m.ware) THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_site
                 LET g_chkparam.arg2 = g_asfp360_04_m.ware
                 LET g_chkparam.arg3 = g_asfp360_04_m.loca
                 #160318-00025#21  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                 #160318-00025#21  by 07900 --add-end 
                 IF NOT cl_chk_exist("v_inab002") THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF
              END IF
              
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_asfp360_04_m.slips,g_asfp360_04_m.ware,g_asfp360_04_m.loca,'','','')
                 RETURNING l_success,l_flag
              IF NOT l_success OR NOT l_flag THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
              CALL s_control_chk_doc('7',g_asfp360_04_m.slipr,g_asfp360_04_m.ware,g_asfp360_04_m.loca,'','','')
                 RETURNING l_success,l_flag
              IF NOT l_success OR NOT l_flag THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'lot_04a'   #批号
           IF NOT cl_null(g_asfp360_04_m.lot) THEN
           END IF
   END CASE
   RETURN r_success
END FUNCTION

#产生发退单
PUBLIC FUNCTION asfp360_04_gen_asft310()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CALL s_transaction_begin()
   
   #产生挪料记录--单头sfla
   CALL asfp360_04_gen_sfla() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #产生退料单
   CALL asfp360_04_gen_return_no() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #产生发料单
   CALL asfp360_04_gen_send_no() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF

   UPDATE sfla_t SET sfla003 = g_asfp360_04_m2.send_no,    #發料單號
                     sfla004 = g_asfp360_04_m2.return_no   #退料單號
    WHERE sflaent  = g_enterprise
      AND sflasite = g_site
      AND sfladocno= g_asfp360_04_m2.sfladocno
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd sfla_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF

   #产生挪料记录--明细sflb\sflc\sfld\sfle
   CALL asfp360_04_gen_sflb() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF

   CALL s_transaction_end('Y','0')
   RETURN r_success
   
END FUNCTION

#产生退料单
PUBLIC FUNCTION asfp360_04_gen_return_no()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_prog        LIKE type_t.chr20
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #退料单头
   CALL asfp360_04_gen_sfda('r') RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF g_asfp360_02_m.type = '1' THEN
      #成套挪--从asfp360_03中获取来源资料 21
      #成套退料套数单身
      CALL asfp360_04_gen_sfdb_21() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   
      #退料明细
      CALL asfp360_04_gen_sfdc_21() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      #单颗挪--从asfp360_05中获取来源资料 23
      #一般退料，无套数单身 
   
      #退料明细
      CALL asfp360_04_gen_sfdc_23() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

#产生发料单
PUBLIC FUNCTION asfp360_04_gen_send_no()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_prog        LIKE type_t.chr20
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #发料单头
   CALL asfp360_04_gen_sfda('s') RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF g_asfp360_02_m.type = '1' THEN
      #成套挪--从asfp360_03中获取来源资料 11
      #发料套数单身
      CALL asfp360_04_gen_sfdb_11() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   
      #发料明细
      CALL asfp360_04_gen_sfdc_11() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      #单颗挪--从asfp360_05中获取来源资料 13
      #发料套数单身
      CALL asfp360_04_gen_sfdb_13() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   
      #发料明细
      CALL asfp360_04_gen_sfdc_13() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

#发/退料单单头
PUBLIC FUNCTION asfp360_04_gen_sfda(p_type)
   DEFINE p_type        LIKE type_t.chr1  #s:发料单  r:退料单
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #161109-00085#42-s
   #DEFINE l_sfda        RECORD LIKE sfda_t.*
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
   END RECORD
   #161109-00085#42-e
   DEFINE l_prog        LIKE type_t.chr20
   DEFINE l_slip        LIKE sfda_t.sfdadocno  #发退料单单别
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #退料单单头
   INITIALIZE l_sfda.* TO NULL
   
   LET l_sfda.sfdaent   = g_enterprise #企業編號
   LET l_sfda.sfdasite  = g_site       #營運據點
   
   #单别取画面输入的值
   IF p_type = 's' THEN
      LET l_slip = g_asfp360_04_m.slips  #发料单
   ELSE
      LET l_slip = g_asfp360_04_m.slipr  #退料单
   END IF
   #取aooi200中BY单据别设定的栏位预设值
   LET l_sfda.sfdadocdt  = s_aooi200_get_doc_default(g_site,'1',l_slip,'sfdadocdt',l_sfda.sfdadocdt)     #單據日期
   LET l_sfda.sfda001    = s_aooi200_get_doc_default(g_site,'1',l_slip,'sfda001'  ,l_sfda.sfda001  )     #過帳日期
   LET l_sfda.sfda002    = s_aooi200_get_doc_default(g_site,'1',l_slip,'sfda002'  ,l_sfda.sfda002  )     #发退料类别
   LET l_sfda.sfda003    = s_aooi200_get_doc_default(g_site,'1',l_slip,'sfda003'  ,l_sfda.sfda003  )     #部門
   LET l_sfda.sfda004    = s_aooi200_get_doc_default(g_site,'1',l_slip,'sfda004'  ,l_sfda.sfda004  )     #申請人
   LET l_sfda.sfda005    = s_aooi200_get_doc_default(g_site,'1',l_slip,'sfda005'  ,l_sfda.sfda005  )     #PBI編號
   
   IF cl_null(l_sfda.sfdadocdt) THEN
      LET l_sfda.sfdadocdt = cl_get_today()   #單據日期
   END IF
   IF cl_null(l_sfda.sfda001) THEN
      LET l_sfda.sfda001   = cl_get_today()   #過帳日期
   END IF
   
   #發退料類別
   IF p_type = 's' THEN
      #发料单
      IF g_asfp360_02_m.type = '1' THEN
         #1.成套挪料
         LET l_prog = "asft311" #作业代号 成套发料
         #发退料单别应该严格控管单别与类型的关系 防止成本计算异常
         IF NOT cl_null(l_sfda.sfda002) AND l_sfda.sfda002!='11' THEN
            #发料单别设置的退料类型%1与此次需求类型%2不符，请查看[单据别维护作业aooi200]或修改单别
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00424'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_sfda.sfda002
            LET g_errparam.replace[2] = '11'
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_sfda.sfda002 = '11'
      ELSE
         #2.单颗挪料
         LET l_prog = "asft313" #作业代号 欠料补料
         #发退料单别应该严格控管单别与类型的关系 防止成本计算异常
         IF NOT cl_null(l_sfda.sfda002) AND l_sfda.sfda002!='13' THEN
            #发料单别设置的退料类型%1与此次需求类型%2不符，请查看[单据别维护作业aooi200]或修改单别
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00424'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_sfda.sfda002
            LET g_errparam.replace[2] = '13'
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_sfda.sfda002 = '13'
      END IF
   ELSE
      #退料单
      IF g_asfp360_02_m.type = '1' THEN
         #1.成套挪料
         LET l_prog = "asft321" #作业代号 成套退料
         #发退料单别应该严格控管单别与类型的关系 防止成本计算异常
         IF NOT cl_null(l_sfda.sfda002) AND l_sfda.sfda002!='21' THEN
            #退料单别设置的退料类型%1与此次需求类型%2不符，请查看[单据别维护作业aooi200]或修改单别
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00423'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_sfda.sfda002
            LET g_errparam.replace[2] = '21'
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_sfda.sfda002 = '21'
      ELSE
         #2.单颗挪料
         LET l_prog = "asft323" #作业代号 一般退料
         #发退料单别应该严格控管单别与类型的关系 防止成本计算异常
         IF NOT cl_null(l_sfda.sfda002) AND l_sfda.sfda002!='23' THEN
            #退料单别设置的退料类型%1与此次需求类型%2不符，请查看[单据别维护作业aooi200]或修改单别
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00423'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_sfda.sfda002
            LET g_errparam.replace[2] = '23'
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_sfda.sfda002 = '23'
      END IF
   END IF
   
   IF cl_null(l_sfda.sfda003) THEN
      LET l_sfda.sfda003   = g_dept  #生產部門
   END IF
   LET l_sfda.sfda004   = g_asfp360_04_m.user  #申請人 按照画面输入的给值
   IF cl_null(l_sfda.sfda005) THEN
      LET l_sfda.sfda005   = ''  #PBI編號
   END IF
   
   LET l_sfda.sfda006   = ''   #生產料號
   LET l_sfda.sfda007   = ''   #BOM特性
   LET l_sfda.sfda008   = ''   #產品特徵
   LET l_sfda.sfda009   = ''   #生產控制組
   LET l_sfda.sfda010   = ''   #作業編號
   LET l_sfda.sfda011   = ''   #作業序
   LET l_sfda.sfda012   = ''   #庫位
   LET l_sfda.sfda013   = 0    #套數
   LET l_sfda.sfda014   = g_asfp360_04_m2.sfladocno   #來源單號-挪料序号
   LET l_sfda.sfda015   = '05'   #來源類型--工单挪料作业
   LET l_sfda.sfdaownid = g_user  #資料所有者
   LET l_sfda.sfdaowndp = g_dept  #資料所屬部門
   LET l_sfda.sfdacrtid = g_user  #資料建立者
   LET l_sfda.sfdacrtdp = g_dept  #資料建立部門
   LET l_sfda.sfdacrtdt = cl_get_current()  #資料創建日
   LET l_sfda.sfdamodid = ''  #資料修改者
   LET l_sfda.sfdamoddt = ''  #最近修改日
   LET l_sfda.sfdacnfid = ''  #資料確認者
   LET l_sfda.sfdacnfdt = ''  #資料確認日
   LET l_sfda.sfdapstid = ''  #資料過帳者
   LET l_sfda.sfdapstdt = ''  #資料過帳日
   LET l_sfda.sfdastus  = 'N' #狀態碼
#161109-00085#42-s   
#   LET l_sfda.sfdaud001 = ''  #自定義欄位(文字)001
#   LET l_sfda.sfdaud002 = ''  #自定義欄位(文字)002
#   LET l_sfda.sfdaud003 = ''  #自定義欄位(文字)003
#   LET l_sfda.sfdaud004 = ''  #自定義欄位(文字)004
#   LET l_sfda.sfdaud005 = ''  #自定義欄位(文字)005
#   LET l_sfda.sfdaud006 = ''  #自定義欄位(文字)006
#   LET l_sfda.sfdaud007 = ''  #自定義欄位(文字)007
#   LET l_sfda.sfdaud008 = ''  #自定義欄位(文字)008
#   LET l_sfda.sfdaud009 = ''  #自定義欄位(文字)009
#   LET l_sfda.sfdaud010 = ''  #自定義欄位(文字)010
#   LET l_sfda.sfdaud011 = ''  #自定義欄位(數字)011
#   LET l_sfda.sfdaud012 = ''  #自定義欄位(數字)012
#   LET l_sfda.sfdaud013 = ''  #自定義欄位(數字)013
#   LET l_sfda.sfdaud014 = ''  #自定義欄位(數字)014
#   LET l_sfda.sfdaud015 = ''  #自定義欄位(數字)015
#   LET l_sfda.sfdaud016 = ''  #自定義欄位(數字)016
#   LET l_sfda.sfdaud017 = ''  #自定義欄位(數字)017
#   LET l_sfda.sfdaud018 = ''  #自定義欄位(數字)018
#   LET l_sfda.sfdaud019 = ''  #自定義欄位(數字)019
#   LET l_sfda.sfdaud020 = ''  #自定義欄位(數字)020
#   LET l_sfda.sfdaud021 = ''  #自定義欄位(日期時間)021
#   LET l_sfda.sfdaud022 = ''  #自定義欄位(日期時間)022
#   LET l_sfda.sfdaud023 = ''  #自定義欄位(日期時間)023
#   LET l_sfda.sfdaud024 = ''  #自定義欄位(日期時間)024
#   LET l_sfda.sfdaud025 = ''  #自定義欄位(日期時間)025
#   LET l_sfda.sfdaud026 = ''  #自定義欄位(日期時間)026
#   LET l_sfda.sfdaud027 = ''  #自定義欄位(日期時間)027
#   LET l_sfda.sfdaud028 = ''  #自定義欄位(日期時間)028
#   LET l_sfda.sfdaud029 = ''  #自定義欄位(日期時間)029
#   LET l_sfda.sfdaud030 = ''  #自定義欄位(日期時間)030
#161109-00085#42-s
   #發退料單號
   CALL s_aooi200_gen_docno(l_sfda.sfdasite,l_slip,l_sfda.sfdadocdt,l_prog)
      RETURNING l_success,l_sfda.sfdadocno
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #161109-00085#42-s
   #INSERT INTO sfda_t VALUES(l_sfda.*)
   INSERT INTO sfda_t( sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,
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
                       sfdaud030 )
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
   #161109-00085#42-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfda_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_type = 's' THEN
      LET g_asfp360_04_m2.send_no  = l_sfda.sfdadocno  #发料单
      LET g_asfp360_04_m2.send_type= l_sfda.sfda002    #发料类型
   ELSE
      LET g_asfp360_04_m2.return_no  = l_sfda.sfdadocno  #退料单
      LET g_asfp360_04_m2.return_type= l_sfda.sfda002    #退料类型
   END IF
   
   RETURN r_success

END FUNCTION

#成套发料
PUBLIC FUNCTION asfp360_04_gen_sfdb_11()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #161109-00085#42-s
   #DEFINE l_sfdb        RECORD LIKE sfdb_t.*
   DEFINE l_sfdb RECORD  #發退料套數檔
          sfdbent LIKE sfdb_t.sfdbent, #企業編號
          sfdbsite LIKE sfdb_t.sfdbsite, #營運據點
          sfdbdocno LIKE sfdb_t.sfdbdocno, #發退料單號
          sfdb001 LIKE sfdb_t.sfdb001, #工單單號
          sfdb002 LIKE sfdb_t.sfdb002, #Run Card
          sfdb003 LIKE sfdb_t.sfdb003, #部位
          sfdb004 LIKE sfdb_t.sfdb004, #作業
          sfdb005 LIKE sfdb_t.sfdb005, #作業序
          sfdb006 LIKE sfdb_t.sfdb006, #預計套數
          sfdb007 LIKE sfdb_t.sfdb007, #實際套數
          sfdb008 LIKE sfdb_t.sfdb008, #正負
          sfdbud001 LIKE sfdb_t.sfdbud001, #自定義欄位(文字)001
          sfdbud002 LIKE sfdb_t.sfdbud002, #自定義欄位(文字)002
          sfdbud003 LIKE sfdb_t.sfdbud003, #自定義欄位(文字)003
          sfdbud004 LIKE sfdb_t.sfdbud004, #自定義欄位(文字)004
          sfdbud005 LIKE sfdb_t.sfdbud005, #自定義欄位(文字)005
          sfdbud006 LIKE sfdb_t.sfdbud006, #自定義欄位(文字)006
          sfdbud007 LIKE sfdb_t.sfdbud007, #自定義欄位(文字)007
          sfdbud008 LIKE sfdb_t.sfdbud008, #自定義欄位(文字)008
          sfdbud009 LIKE sfdb_t.sfdbud009, #自定義欄位(文字)009
          sfdbud010 LIKE sfdb_t.sfdbud010, #自定義欄位(文字)010
          sfdbud011 LIKE sfdb_t.sfdbud011, #自定義欄位(數字)011
          sfdbud012 LIKE sfdb_t.sfdbud012, #自定義欄位(數字)012
          sfdbud013 LIKE sfdb_t.sfdbud013, #自定義欄位(數字)013
          sfdbud014 LIKE sfdb_t.sfdbud014, #自定義欄位(數字)014
          sfdbud015 LIKE sfdb_t.sfdbud015, #自定義欄位(數字)015
          sfdbud016 LIKE sfdb_t.sfdbud016, #自定義欄位(數字)016
          sfdbud017 LIKE sfdb_t.sfdbud017, #自定義欄位(數字)017
          sfdbud018 LIKE sfdb_t.sfdbud018, #自定義欄位(數字)018
          sfdbud019 LIKE sfdb_t.sfdbud019, #自定義欄位(數字)019
          sfdbud020 LIKE sfdb_t.sfdbud020, #自定義欄位(數字)020
          sfdbud021 LIKE sfdb_t.sfdbud021, #自定義欄位(日期時間)021
          sfdbud022 LIKE sfdb_t.sfdbud022, #自定義欄位(日期時間)022
          sfdbud023 LIKE sfdb_t.sfdbud023, #自定義欄位(日期時間)023
          sfdbud024 LIKE sfdb_t.sfdbud024, #自定義欄位(日期時間)024
          sfdbud025 LIKE sfdb_t.sfdbud025, #自定義欄位(日期時間)025
          sfdbud026 LIKE sfdb_t.sfdbud026, #自定義欄位(日期時間)026
          sfdbud027 LIKE sfdb_t.sfdbud027, #自定義欄位(日期時間)027
          sfdbud028 LIKE sfdb_t.sfdbud028, #自定義欄位(日期時間)028
          sfdbud029 LIKE sfdb_t.sfdbud029, #自定義欄位(日期時間)029
          sfdbud030 LIKE sfdb_t.sfdbud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   INITIALIZE l_sfdb.* TO NULL
   LET l_sfdb.sfdbent   = g_enterprise   #企業編號
   LET l_sfdb.sfdbsite  = g_site         #營運據點

   LET l_sfdb.sfdbdocno = g_asfp360_04_m2.send_no   #發退料單號
   LET l_sfdb.sfdb001   = g_sfaadocno_01            #工單單號
   LET l_sfdb.sfdb008   = -1   #正負
   
   LET l_sfdb.sfdb002   = ''     #Run Card

   SELECT sfca001 INTO l_sfdb.sfdb002 FROM sfca_t
    WHERE sfcaent = g_enterprise
      AND sfcasite= g_site
      AND sfcadocno=l_sfdb.sfdb001   #工单单号
   
   LET l_sfdb.sfdb003   = ' '   #部位
   LET l_sfdb.sfdb004   = ' '   #作業
   LET l_sfdb.sfdb005   = ' '   #作業序
   LET l_sfdb.sfdb006   = g_asfp360_02_m.insets   #預計套數
   LET l_sfdb.sfdb007   = l_sfdb.sfdb006         #實際套數
   

   LET l_sfdb.sfdbud001 = ''      #自定義欄位(文字)001
   LET l_sfdb.sfdbud002 = ''      #自定義欄位(文字)002
   LET l_sfdb.sfdbud003 = ''      #自定義欄位(文字)003
   LET l_sfdb.sfdbud004 = ''      #自定義欄位(文字)004
   LET l_sfdb.sfdbud005 = ''      #自定義欄位(文字)005
   LET l_sfdb.sfdbud006 = ''      #自定義欄位(文字)006
   LET l_sfdb.sfdbud007 = ''      #自定義欄位(文字)007
   LET l_sfdb.sfdbud008 = ''      #自定義欄位(文字)008
   LET l_sfdb.sfdbud009 = ''      #自定義欄位(文字)009
   LET l_sfdb.sfdbud010 = ''      #自定義欄位(文字)010
   LET l_sfdb.sfdbud011 = ''      #自定義欄位(數字)011
   LET l_sfdb.sfdbud012 = ''      #自定義欄位(數字)012
   LET l_sfdb.sfdbud013 = ''      #自定義欄位(數字)013
   LET l_sfdb.sfdbud014 = ''      #自定義欄位(數字)014
   LET l_sfdb.sfdbud015 = ''      #自定義欄位(數字)015
   LET l_sfdb.sfdbud016 = ''      #自定義欄位(數字)016
   LET l_sfdb.sfdbud017 = ''      #自定義欄位(數字)017
   LET l_sfdb.sfdbud018 = ''      #自定義欄位(數字)018
   LET l_sfdb.sfdbud019 = ''      #自定義欄位(數字)019
   LET l_sfdb.sfdbud020 = ''      #自定義欄位(數字)020
   LET l_sfdb.sfdbud021 = ''      #自定義欄位(日期時間)021
   LET l_sfdb.sfdbud022 = ''      #自定義欄位(日期時間)022
   LET l_sfdb.sfdbud023 = ''      #自定義欄位(日期時間)023
   LET l_sfdb.sfdbud024 = ''      #自定義欄位(日期時間)024
   LET l_sfdb.sfdbud025 = ''      #自定義欄位(日期時間)025
   LET l_sfdb.sfdbud026 = ''      #自定義欄位(日期時間)026
   LET l_sfdb.sfdbud027 = ''      #自定義欄位(日期時間)027
   LET l_sfdb.sfdbud028 = ''      #自定義欄位(日期時間)028
   LET l_sfdb.sfdbud029 = ''      #自定義欄位(日期時間)029
   LET l_sfdb.sfdbud030 = ''      #自定義欄位(日期時間)030

   #161109-00085#42-s
   #INSERT INTO sfdb_t VALUES(l_sfdb.*)
   INSERT INTO sfdb_t(sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,
                      sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,
                      sfdb008,sfdbud001,sfdbud002,sfdbud003,sfdbud004,
                      sfdbud005,sfdbud006,sfdbud007,sfdbud008,sfdbud009,
                      sfdbud010,sfdbud011,sfdbud012,sfdbud013,sfdbud014,
                      sfdbud015,sfdbud016,sfdbud017,sfdbud018,sfdbud019,
                      sfdbud020,sfdbud021,sfdbud022,sfdbud023,sfdbud024,
                      sfdbud025,sfdbud026,sfdbud027,sfdbud028,sfdbud029,
                      sfdbud030 )
      VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,
              l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,
              l_sfdb.sfdb008,l_sfdb.sfdbud001,l_sfdb.sfdbud002,l_sfdb.sfdbud003,l_sfdb.sfdbud004,
              l_sfdb.sfdbud005,l_sfdb.sfdbud006,l_sfdb.sfdbud007,l_sfdb.sfdbud008,l_sfdb.sfdbud009,
              l_sfdb.sfdbud010,l_sfdb.sfdbud011,l_sfdb.sfdbud012,l_sfdb.sfdbud013,l_sfdb.sfdbud014,
              l_sfdb.sfdbud015,l_sfdb.sfdbud016,l_sfdb.sfdbud017,l_sfdb.sfdbud018,l_sfdb.sfdbud019,
              l_sfdb.sfdbud020,l_sfdb.sfdbud021,l_sfdb.sfdbud022,l_sfdb.sfdbud023,l_sfdb.sfdbud024,
              l_sfdb.sfdbud025,l_sfdb.sfdbud026,l_sfdb.sfdbud027,l_sfdb.sfdbud028,l_sfdb.sfdbud029,
              l_sfdb.sfdbud030)   
   #161109-00085#42-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfdb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

#成套发料
PUBLIC FUNCTION asfp360_04_gen_sfdc_11()
   DEFINE p_sfaadocno   LIKE sfaa_t.sfaadocno  #工单
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
#161109-00085#42-s
#DEFINE l_sfdc        RECORD LIKE sfdc_t.*
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
END RECORD
#161109-00085#42-e
#161109-00085#42-s
#DEFINE l_sfdd        RECORD LIKE sfdd_t.*
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
       sfdd014 LIKE sfdd_t.sfdd014, #備置量
       sfdd015 LIKE sfdd_t.sfdd015  #在揀量
END RECORD
#161109-00085#42-e   
   DEFINE l_sql         STRING
   DEFINE l_temp        RECORD
                        sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                        sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                        sfba005        LIKE sfba_t.sfba005,  #BOM料号 需要和asfp360_02_temp匹配
                        sfba006        LIKE sfba_t.sfba006,  #发料料号
                        sfba021        LIKE sfba_t.sfba021,  #特征
                        sfba014        LIKE sfba_t.sfba014,  #单位
                        unitr          LIKE sfba_t.sfba014,  #参考单位
                        inqty_sum      LIKE sfba_t.sfba016,  #来源拨出数量合计
                        inqtyr_sum     LIKE sfba_t.sfba016   #参考单位来源拨出数量合计
                        END RECORD
   DEFINE l_sfdcseq     LIKE sfdc_t.sfdcseq
   DEFINE l_qty            LIKE sfdd_t.sfdd014    #160408-00035#7
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_sql = " SELECT sfbaseq,sfbaseq1,sfba005,sfba006,sfba021,sfba014,unitr,",
               "        SUM(inqty_sum),SUM(inqtyr_sum) ",
               "   FROM asfp360_02_temp ",
               "  WHERE inqty_sum > 0 ",
               "    AND sel = 'Y' ",
               "  GROUP BY sfbaseq,sfbaseq1,sfba005,sfba006,sfba021,sfba014,unitr ",
               "  ORDER BY sfbaseq,sfbaseq1 "
   PREPARE asfp360_04_gen_sfdc_11_p FROM l_sql
   DECLARE asfp360_04_gen_sfdc_11_c CURSOR FOR asfp360_04_gen_sfdc_11_p
   LET l_sfdcseq = 0
   FOREACH asfp360_04_gen_sfdc_11_c INTO l_temp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_04_gen_sfdc_11_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   
      IF cl_null(l_temp.inqty_sum) THEN LET l_temp.inqty_sum = 0 END IF
      IF cl_null(l_temp.inqtyr_sum) THEN LET l_temp.inqtyr_sum = 0 END IF
      
      INITIALIZE l_sfdc.* TO NULL
      LET l_sfdc.sfdcent   = g_enterprise   #企業編號
      LET l_sfdc.sfdcsite  = g_site         #營運據點

      #发料单
      LET l_sfdc.sfdcdocno = g_asfp360_04_m2.send_no   #發退料單號
      LET l_sfdc.sfdc017   = -1   #正負
      
      LET l_sfdcseq = l_sfdcseq + 1
      LET l_sfdc.sfdcseq   = l_sfdcseq   #項次
      
      LET l_sfdc.sfdc001   = g_sfaadocno_01     #工單單號
      LET l_sfdc.sfdc002   = l_temp.sfbaseq     #工單項次
      LET l_sfdc.sfdc003   = l_temp.sfbaseq1    #工單項序
      LET l_sfdc.sfdc004   = l_temp.sfba006     #需求料號
      LET l_sfdc.sfdc005   = l_temp.sfba021     #產品特徵
      IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF  #产品特征
      LET l_sfdc.sfdc006   = l_temp.sfba014     #單位
      LET l_sfdc.sfdc007   = l_temp.inqty_sum      #申請數量  跟实际数量一起更新
      LET l_sfdc.sfdc008   = 0  #l_temp.inqty_sum      #實際數量
      LET l_sfdc.sfdc009   = l_temp.unitr       #參考單位
      LET l_sfdc.sfdc010   = l_temp.inqtyr_sum     #參考單位需求數量
      LET l_sfdc.sfdc011   = 0  #l_temp.inqtyr_sum     #參考單位實際數量
      LET l_sfdc.sfdc012   = g_asfp360_04_m.ware #指定庫位
      IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
      LET l_sfdc.sfdc013   = g_asfp360_04_m.loca #指定儲位
      IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
      LET l_sfdc.sfdc014   = g_asfp360_04_m.lot  #指定批號
      IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
      LET l_sfdc.sfdc015   = ''   #理由碼
      LET l_sfdc.sfdc016   = ' '   #庫存管理特徴

      LET l_sfdc.sfdcud001 = ''   #自定義欄位(文字)001
      LET l_sfdc.sfdcud002 = ''   #自定義欄位(文字)002
      LET l_sfdc.sfdcud003 = ''   #自定義欄位(文字)003
      LET l_sfdc.sfdcud004 = ''   #自定義欄位(文字)004
      LET l_sfdc.sfdcud005 = ''   #自定義欄位(文字)005
      LET l_sfdc.sfdcud006 = ''   #自定義欄位(文字)006
      LET l_sfdc.sfdcud007 = ''   #自定義欄位(文字)007
      LET l_sfdc.sfdcud008 = ''   #自定義欄位(文字)008
      LET l_sfdc.sfdcud009 = ''   #自定義欄位(文字)009
      LET l_sfdc.sfdcud010 = ''   #自定義欄位(文字)010
      LET l_sfdc.sfdcud011 = ''   #自定義欄位(數字)011
      LET l_sfdc.sfdcud012 = ''   #自定義欄位(數字)012
      LET l_sfdc.sfdcud013 = ''   #自定義欄位(數字)013
      LET l_sfdc.sfdcud014 = ''   #自定義欄位(數字)014
      LET l_sfdc.sfdcud015 = ''   #自定義欄位(數字)015
      LET l_sfdc.sfdcud016 = ''   #自定義欄位(數字)016
      LET l_sfdc.sfdcud017 = ''   #自定義欄位(數字)017
      LET l_sfdc.sfdcud018 = ''   #自定義欄位(數字)018
      LET l_sfdc.sfdcud019 = ''   #自定義欄位(數字)019
      LET l_sfdc.sfdcud020 = ''   #自定義欄位(數字)020
      LET l_sfdc.sfdcud021 = ''   #自定義欄位(日期時間)021
      LET l_sfdc.sfdcud022 = ''   #自定義欄位(日期時間)022
      LET l_sfdc.sfdcud023 = ''   #自定義欄位(日期時間)023
      LET l_sfdc.sfdcud024 = ''   #自定義欄位(日期時間)024
      LET l_sfdc.sfdcud025 = ''   #自定義欄位(日期時間)025
      LET l_sfdc.sfdcud026 = ''   #自定義欄位(日期時間)026
      LET l_sfdc.sfdcud027 = ''   #自定義欄位(日期時間)027
      LET l_sfdc.sfdcud028 = ''   #自定義欄位(日期時間)028
      LET l_sfdc.sfdcud029 = ''   #自定義欄位(日期時間)029
      LET l_sfdc.sfdcud030 = ''   #自定義欄位(日期時間)030

      #161109-00085#42-s
      #INSERT INTO sfdc_t VALUES(l_sfdc.*)
      INSERT INTO sfdc_t( sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
                          sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
                          sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
                          sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
                          sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
                          sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
                          sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
                          sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
                          sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
                          sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
                          sfdcud030 )
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
      #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #新增或更新sfde(包含新增或更新sfdf)   'N'代表不自动增加sfdf
      CALL s_asft310_chg_sfde_f_sfdc_ins(l_sfdc.sfdcdocno,l_sfdc.sfdcseq,'N') RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      INITIALIZE l_sfdd.* TO NULL
      LET l_sfdd.sfddent   = g_enterprise           #企業代碼
      LET l_sfdd.sfddsite  = g_site                 #營運據

      #发料单
      LET l_sfdd.sfdddocno = g_asfp360_04_m2.send_no   #發退料單號
      LET l_sfdd.sfdd012   = -1   #正負

      LET l_sfdd.sfddseq   = l_sfdc.sfdcseq         #項次
      LET l_sfdd.sfddseq1  = 1                      #項序
      LET l_sfdd.sfdd001   = l_sfdc.sfdc004         #發退料料號
      LET l_sfdd.sfdd013   = l_sfdc.sfdc005         #产品特征
      IF cl_null(l_sfdd.sfdd013) THEN LET l_sfdd.sfdd013 = ' ' END IF
      LET l_sfdd.sfdd002   = 1                      #替代率
      LET l_sfdd.sfdd003   = l_sfdc.sfdc012         #庫位
      LET l_sfdd.sfdd004   = l_sfdc.sfdc013         #儲位
      LET l_sfdd.sfdd005   = l_sfdc.sfdc014         #批號
      LET l_sfdd.sfdd006   = l_sfdc.sfdc006         #單位
      LET l_sfdd.sfdd007   = l_sfdc.sfdc007         #數量
      LET l_sfdd.sfdd008   = l_sfdc.sfdc009         #参考单位
      LET l_sfdd.sfdd009   = l_sfdc.sfdc010         #参考单位数量
      LET l_sfdd.sfdd010   = l_sfdc.sfdc016         #庫存管理特徵
      LET l_sfdd.sfdd011   = ''   #包裝容器

      LET l_sfdd.sfddud001 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud002 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud003 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud004 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud005 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud006 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud007 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud008 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud009 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud010 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud011 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud012 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud013 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud014 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud015 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud016 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud017 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud018 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud019 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud020 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud021 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud022 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud023 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud024 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud025 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud026 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud027 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud028 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud029 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud030 = ''    #自定義欄位(日期時間)

      #160408-00035#7---add---begin
      CALL s_asft310_get_sfbb008_sfbb009(l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc016,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc006)
         RETURNING l_qty
      IF l_sfdd.sfdd007 >= l_qty THEN 
         LET l_sfdd.sfdd014 = l_qty
      ELSE   
         LET l_sfdd.sfdd014 = l_sfdd.sfdd007 
      END IF
      LET l_sfdd.sfdd015 = l_sfdd.sfdd007 - l_sfdd.sfdd014
      ##160408-00035#7---add---end										
      #161109-00085#42-s
      #INSERT INTO sfdd_t VALUES(l_sfdd.*)  
      INSERT INTO sfdd_t( sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,
                          sfdd001,sfdd002,sfdd003,sfdd004,sfdd005,
                          sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,
                          sfdd011,sfdd012,sfdd013,sfddud001,sfddud002,
                          sfddud003,sfddud004,sfddud005,sfddud006,sfddud007,
                          sfddud008,sfddud009,sfddud010,sfddud011,sfddud012,
                          sfddud013,sfddud014,sfddud015,sfddud016,sfddud017,
                          sfddud018,sfddud019,sfddud020,sfddud021,sfddud022,
                          sfddud023,sfddud024,sfddud025,sfddud026,sfddud027,
                          sfddud028,sfddud029,sfddud030,sfdd014,sfdd015) 
         VALUES (l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,
                 l_sfdd.sfdd001,l_sfdd.sfdd002,l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,
                 l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
                 l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfddud001,l_sfdd.sfddud002,
                 l_sfdd.sfddud003,l_sfdd.sfddud004,l_sfdd.sfddud005,l_sfdd.sfddud006,l_sfdd.sfddud007,
                 l_sfdd.sfddud008,l_sfdd.sfddud009,l_sfdd.sfddud010,l_sfdd.sfddud011,l_sfdd.sfddud012,
                 l_sfdd.sfddud013,l_sfdd.sfddud014,l_sfdd.sfddud015,l_sfdd.sfddud016,l_sfdd.sfddud017,
                 l_sfdd.sfddud018,l_sfdd.sfddud019,l_sfdd.sfddud020,l_sfdd.sfddud021,l_sfdd.sfddud022,
                 l_sfdd.sfddud023,l_sfdd.sfddud024,l_sfdd.sfddud025,l_sfdd.sfddud026,l_sfdd.sfddud027,
                 l_sfdd.sfddud028,l_sfdd.sfddud029,l_sfdd.sfddud030,l_sfdd.sfdd014,l_sfdd.sfdd015)      
      #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      #更新sfdc
      CALL s_asft310_chg_sfdc_f_sfdd_ins(l_sfdd.sfdddocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #处理sfdf,sfde：sfdd与sfdf总数应该平的
      CALL s_asft310_chg_sfdf_f_sfdd_ins(l_sfdd.sfdddocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      ##更新申请数量=实际数量
      #UPDATE sfdc_t SET sfdc007 = sfdc008,  #申請數量
      #                  sfdc010 = sfdc011   #参考单位申請數量
      # WHERE sfdcent  = g_enterprise
      #   AND sfdcdocno =l_sfdadocno
      #UPDATE sfde_t SET sfde004 = sfde005,  #申請數量
      #                  sfde007 = sfde008   #参考单位申請數量
      # WHERE sfdeent  = g_enterprise
      #   AND sfdedocno =l_sfdadocno
   END FOREACH
   CLOSE asfp360_04_gen_sfdc_11_c
   FREE asfp360_04_gen_sfdc_11_p

   RETURN r_success
END FUNCTION

#发退料套数单身(成套挪)--从asfp360_03中获取来源资料
#成套退料单21
PUBLIC FUNCTION asfp360_04_gen_sfdb_21()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #161109-00085#42-s
   #DEFINE l_sfdb        RECORD LIKE sfdb_t.*
   DEFINE l_sfdb RECORD  #發退料套數檔
          sfdbent LIKE sfdb_t.sfdbent, #企業編號
          sfdbsite LIKE sfdb_t.sfdbsite, #營運據點
          sfdbdocno LIKE sfdb_t.sfdbdocno, #發退料單號
          sfdb001 LIKE sfdb_t.sfdb001, #工單單號
          sfdb002 LIKE sfdb_t.sfdb002, #Run Card
          sfdb003 LIKE sfdb_t.sfdb003, #部位
          sfdb004 LIKE sfdb_t.sfdb004, #作業
          sfdb005 LIKE sfdb_t.sfdb005, #作業序
          sfdb006 LIKE sfdb_t.sfdb006, #預計套數
          sfdb007 LIKE sfdb_t.sfdb007, #實際套數
          sfdb008 LIKE sfdb_t.sfdb008, #正負
          sfdbud001 LIKE sfdb_t.sfdbud001, #自定義欄位(文字)001
          sfdbud002 LIKE sfdb_t.sfdbud002, #自定義欄位(文字)002
          sfdbud003 LIKE sfdb_t.sfdbud003, #自定義欄位(文字)003
          sfdbud004 LIKE sfdb_t.sfdbud004, #自定義欄位(文字)004
          sfdbud005 LIKE sfdb_t.sfdbud005, #自定義欄位(文字)005
          sfdbud006 LIKE sfdb_t.sfdbud006, #自定義欄位(文字)006
          sfdbud007 LIKE sfdb_t.sfdbud007, #自定義欄位(文字)007
          sfdbud008 LIKE sfdb_t.sfdbud008, #自定義欄位(文字)008
          sfdbud009 LIKE sfdb_t.sfdbud009, #自定義欄位(文字)009
          sfdbud010 LIKE sfdb_t.sfdbud010, #自定義欄位(文字)010
          sfdbud011 LIKE sfdb_t.sfdbud011, #自定義欄位(數字)011
          sfdbud012 LIKE sfdb_t.sfdbud012, #自定義欄位(數字)012
          sfdbud013 LIKE sfdb_t.sfdbud013, #自定義欄位(數字)013
          sfdbud014 LIKE sfdb_t.sfdbud014, #自定義欄位(數字)014
          sfdbud015 LIKE sfdb_t.sfdbud015, #自定義欄位(數字)015
          sfdbud016 LIKE sfdb_t.sfdbud016, #自定義欄位(數字)016
          sfdbud017 LIKE sfdb_t.sfdbud017, #自定義欄位(數字)017
          sfdbud018 LIKE sfdb_t.sfdbud018, #自定義欄位(數字)018
          sfdbud019 LIKE sfdb_t.sfdbud019, #自定義欄位(數字)019
          sfdbud020 LIKE sfdb_t.sfdbud020, #自定義欄位(數字)020
          sfdbud021 LIKE sfdb_t.sfdbud021, #自定義欄位(日期時間)021
          sfdbud022 LIKE sfdb_t.sfdbud022, #自定義欄位(日期時間)022
          sfdbud023 LIKE sfdb_t.sfdbud023, #自定義欄位(日期時間)023
          sfdbud024 LIKE sfdb_t.sfdbud024, #自定義欄位(日期時間)024
          sfdbud025 LIKE sfdb_t.sfdbud025, #自定義欄位(日期時間)025
          sfdbud026 LIKE sfdb_t.sfdbud026, #自定義欄位(日期時間)026
          sfdbud027 LIKE sfdb_t.sfdbud027, #自定義欄位(日期時間)027
          sfdbud028 LIKE sfdb_t.sfdbud028, #自定義欄位(日期時間)028
          sfdbud029 LIKE sfdb_t.sfdbud029, #自定義欄位(日期時間)029
          sfdbud030 LIKE sfdb_t.sfdbud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   DEFINE l_sql         STRING
   DEFINE l_temp1       RECORD
                        sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                        plan_outsets   LIKE sfaa_t.sfaa049    #拟拨出套数
                        END RECORD
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET l_sql = " SELECT sfaadocno,plan_outsets ",
               "   FROM asfp360_tmp01",   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               "  WHERE sel = 'Y' ",
               "    AND plan_outsets > 0 ",
               "  ORDER BY sfaadocno "
   PREPARE asfp360_04_gen_sfdb_1_p FROM l_sql
   DECLARE asfp360_04_gen_sfdb_1_c CURSOR FOR asfp360_04_gen_sfdb_1_p
   FOREACH asfp360_04_gen_sfdb_1_c INTO l_temp1.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_04_gen_sfdb_1_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   
      INITIALIZE l_sfdb.* TO NULL
      LET l_sfdb.sfdbent   = g_enterprise   #企業編號
      LET l_sfdb.sfdbsite  = g_site         #營運據點
      
      #退料单
      LET l_sfdb.sfdbdocno = g_asfp360_04_m2.return_no #發退料單號
      LET l_sfdb.sfdb001   = l_temp1.sfaadocno   #工單單號
      LET l_sfdb.sfdb008   = 1    #正負
      
      LET l_sfdb.sfdb002   = ''     #Run Card

      SELECT sfca001 INTO l_sfdb.sfdb002 FROM sfca_t
       WHERE sfcaent = g_enterprise
         AND sfcasite= g_site
         AND sfcadocno=l_sfdb.sfdb001   #工单单号
      
      LET l_sfdb.sfdb003   = ' '   #部位
      LET l_sfdb.sfdb004   = ' '   #作業
      LET l_sfdb.sfdb005   = ' '   #作業序
      LET l_sfdb.sfdb006   = l_temp1.plan_outsets   #預計套數
      LET l_sfdb.sfdb007   = l_sfdb.sfdb006         #實際套數
      

      LET l_sfdb.sfdbud001 = ''      #自定義欄位(文字)001
      LET l_sfdb.sfdbud002 = ''      #自定義欄位(文字)002
      LET l_sfdb.sfdbud003 = ''      #自定義欄位(文字)003
      LET l_sfdb.sfdbud004 = ''      #自定義欄位(文字)004
      LET l_sfdb.sfdbud005 = ''      #自定義欄位(文字)005
      LET l_sfdb.sfdbud006 = ''      #自定義欄位(文字)006
      LET l_sfdb.sfdbud007 = ''      #自定義欄位(文字)007
      LET l_sfdb.sfdbud008 = ''      #自定義欄位(文字)008
      LET l_sfdb.sfdbud009 = ''      #自定義欄位(文字)009
      LET l_sfdb.sfdbud010 = ''      #自定義欄位(文字)010
      LET l_sfdb.sfdbud011 = ''      #自定義欄位(數字)011
      LET l_sfdb.sfdbud012 = ''      #自定義欄位(數字)012
      LET l_sfdb.sfdbud013 = ''      #自定義欄位(數字)013
      LET l_sfdb.sfdbud014 = ''      #自定義欄位(數字)014
      LET l_sfdb.sfdbud015 = ''      #自定義欄位(數字)015
      LET l_sfdb.sfdbud016 = ''      #自定義欄位(數字)016
      LET l_sfdb.sfdbud017 = ''      #自定義欄位(數字)017
      LET l_sfdb.sfdbud018 = ''      #自定義欄位(數字)018
      LET l_sfdb.sfdbud019 = ''      #自定義欄位(數字)019
      LET l_sfdb.sfdbud020 = ''      #自定義欄位(數字)020
      LET l_sfdb.sfdbud021 = ''      #自定義欄位(日期時間)021
      LET l_sfdb.sfdbud022 = ''      #自定義欄位(日期時間)022
      LET l_sfdb.sfdbud023 = ''      #自定義欄位(日期時間)023
      LET l_sfdb.sfdbud024 = ''      #自定義欄位(日期時間)024
      LET l_sfdb.sfdbud025 = ''      #自定義欄位(日期時間)025
      LET l_sfdb.sfdbud026 = ''      #自定義欄位(日期時間)026
      LET l_sfdb.sfdbud027 = ''      #自定義欄位(日期時間)027
      LET l_sfdb.sfdbud028 = ''      #自定義欄位(日期時間)028
      LET l_sfdb.sfdbud029 = ''      #自定義欄位(日期時間)029
      LET l_sfdb.sfdbud030 = ''      #自定義欄位(日期時間)030

   #161109-00085#42-s
   #INSERT INTO sfdb_t VALUES(l_sfdb.*)
   INSERT INTO sfdb_t(sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,
                      sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,
                      sfdb008,sfdbud001,sfdbud002,sfdbud003,sfdbud004,
                      sfdbud005,sfdbud006,sfdbud007,sfdbud008,sfdbud009,
                      sfdbud010,sfdbud011,sfdbud012,sfdbud013,sfdbud014,
                      sfdbud015,sfdbud016,sfdbud017,sfdbud018,sfdbud019,
                      sfdbud020,sfdbud021,sfdbud022,sfdbud023,sfdbud024,
                      sfdbud025,sfdbud026,sfdbud027,sfdbud028,sfdbud029,
                      sfdbud030 )
      VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,
              l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,
              l_sfdb.sfdb008,l_sfdb.sfdbud001,l_sfdb.sfdbud002,l_sfdb.sfdbud003,l_sfdb.sfdbud004,
              l_sfdb.sfdbud005,l_sfdb.sfdbud006,l_sfdb.sfdbud007,l_sfdb.sfdbud008,l_sfdb.sfdbud009,
              l_sfdb.sfdbud010,l_sfdb.sfdbud011,l_sfdb.sfdbud012,l_sfdb.sfdbud013,l_sfdb.sfdbud014,
              l_sfdb.sfdbud015,l_sfdb.sfdbud016,l_sfdb.sfdbud017,l_sfdb.sfdbud018,l_sfdb.sfdbud019,
              l_sfdb.sfdbud020,l_sfdb.sfdbud021,l_sfdb.sfdbud022,l_sfdb.sfdbud023,l_sfdb.sfdbud024,
              l_sfdb.sfdbud025,l_sfdb.sfdbud026,l_sfdb.sfdbud027,l_sfdb.sfdbud028,l_sfdb.sfdbud029,
              l_sfdb.sfdbud030)   
   #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH
   CLOSE asfp360_04_gen_sfdb_1_c
   FREE asfp360_04_gen_sfdb_1_p

   RETURN r_success
END FUNCTION

#发退料需求档（成套挪）
#成套退料单21
PUBLIC FUNCTION asfp360_04_gen_sfdc_21()
   DEFINE p_sfaadocno   LIKE sfaa_t.sfaadocno  #工单
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
#161109-00085#42-s
#DEFINE l_sfdc        RECORD LIKE sfdc_t.*
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
END RECORD  
#161109-00085#42-e
#161109-00085#42-s
#DEFINE l_sfdd        RECORD LIKE sfdd_t.*
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
       sfdd014 LIKE sfdd_t.sfdd014, #備置量
       sfdd015 LIKE sfdd_t.sfdd015  #在揀量
END RECORD
#161109-00085#42-e  
   DEFINE l_sql         STRING
   DEFINE l_temp3       RECORD
                        sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                        sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                        sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                        sfba005        LIKE sfba_t.sfba005,  #BOM料号 需要和asfp360_02_temp匹配
                        sfba006        LIKE sfba_t.sfba006,  #发料料号
                        sfba021        LIKE sfba_t.sfba021,  #特征
                        sfba014        LIKE sfba_t.sfba014,  #单位
                        unitr          LIKE sfba_t.sfba014,  #参考单位
                        outqty         LIKE sfba_t.sfba016,  #拟拨出数量
                        outqtyr        LIKE sfba_t.sfba016   #参考单位拨出数量
                        END RECORD
   DEFINE l_sfdcseq     LIKE sfdc_t.sfdcseq
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
   LET l_sql = " SELECT asfp360_tmp02.sfaadocno,asfp360_tmp02.sfbaseq,asfp360_tmp02.sfbaseq1, ",
               "        asfp360_tmp02.sfba005,asfp360_tmp02.sfba006,asfp360_tmp02.sfba021, ",
               "        asfp360_tmp02.sfba014,asfp360_tmp02.unitr,",
               "        SUM(asfp360_tmp02.outqty),SUM(asfp360_tmp02.outqtyr) ",
               "   FROM asfp360_tmp02,asfp360_tmp01",   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               "  WHERE asfp360_tmp02.sfaadocno = asfp360_tmp01.sfaadocno ",   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               "    AND asfp360_tmp02.outqty > 0 ",
               "  GROUP BY asfp360_tmp02.sfaadocno,asfp360_tmp02.sfbaseq,asfp360_tmp02.sfbaseq1, ",
               "           asfp360_tmp02.sfba005,asfp360_tmp02.sfba006,asfp360_tmp02.sfba021, ",
               "           asfp360_tmp02.sfba014,asfp360_tmp02.unitr ",
               "  ORDER BY asfp360_tmp02.sfaadocno,asfp360_tmp02.sfbaseq,asfp360_tmp02.sfbaseq1 "
   PREPARE asfp360_04_gen_sfdc_21_p FROM l_sql
   DECLARE asfp360_04_gen_sfdc_21_c CURSOR FOR asfp360_04_gen_sfdc_21_p
   LET l_sfdcseq = 0
   FOREACH asfp360_04_gen_sfdc_21_c INTO l_temp3.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_04_gen_sfdc_21_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
         
      END IF
   
      IF cl_null(l_temp3.outqty) THEN LET l_temp3.outqty = 0 END IF
      IF cl_null(l_temp3.outqtyr) THEN LET l_temp3.outqtyr = 0 END IF
      
      INITIALIZE l_sfdc.* TO NULL
      LET l_sfdc.sfdcent   = g_enterprise   #企業編號
      LET l_sfdc.sfdcsite  = g_site         #營運據點

      #退料单
      LET l_sfdc.sfdcdocno = g_asfp360_04_m2.return_no #發退料單號
      LET l_sfdc.sfdc017   = 1    #正負
      
      LET l_sfdcseq = l_sfdcseq + 1
      LET l_sfdc.sfdcseq   = l_sfdcseq   #項次
      
      LET l_sfdc.sfdc001   = l_temp3.sfaadocno   #工單單號
      LET l_sfdc.sfdc002   = l_temp3.sfbaseq     #工單項次
      LET l_sfdc.sfdc003   = l_temp3.sfbaseq1    #工單項序
      LET l_sfdc.sfdc004   = l_temp3.sfba006     #需求料號
      LET l_sfdc.sfdc005   = l_temp3.sfba021     #產品特徵
      IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF  #产品特征
      LET l_sfdc.sfdc006   = l_temp3.sfba014     #單位
      LET l_sfdc.sfdc007   = l_temp3.outqty      #申請數量  跟实际数量一起更新
      LET l_sfdc.sfdc008   = 0  #l_temp3.outqty      #實際數量
      LET l_sfdc.sfdc009   = l_temp3.unitr       #參考單位
      LET l_sfdc.sfdc010   = l_temp3.outqtyr     #參考單位需求數量
      LET l_sfdc.sfdc011   = 0  #l_temp3.outqtyr     #參考單位實際數量
      LET l_sfdc.sfdc012   = g_asfp360_04_m.ware #指定庫位
      IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
      LET l_sfdc.sfdc013   = g_asfp360_04_m.loca #指定儲位
      IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
      LET l_sfdc.sfdc014   = g_asfp360_04_m.lot  #指定批號
      IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
      LET l_sfdc.sfdc015   = ''   #理由碼
      LET l_sfdc.sfdc016   = ' '   #庫存管理特徴

      LET l_sfdc.sfdcud001 = ''   #自定義欄位(文字)001
      LET l_sfdc.sfdcud002 = ''   #自定義欄位(文字)002
      LET l_sfdc.sfdcud003 = ''   #自定義欄位(文字)003
      LET l_sfdc.sfdcud004 = ''   #自定義欄位(文字)004
      LET l_sfdc.sfdcud005 = ''   #自定義欄位(文字)005
      LET l_sfdc.sfdcud006 = ''   #自定義欄位(文字)006
      LET l_sfdc.sfdcud007 = ''   #自定義欄位(文字)007
      LET l_sfdc.sfdcud008 = ''   #自定義欄位(文字)008
      LET l_sfdc.sfdcud009 = ''   #自定義欄位(文字)009
      LET l_sfdc.sfdcud010 = ''   #自定義欄位(文字)010
      LET l_sfdc.sfdcud011 = ''   #自定義欄位(數字)011
      LET l_sfdc.sfdcud012 = ''   #自定義欄位(數字)012
      LET l_sfdc.sfdcud013 = ''   #自定義欄位(數字)013
      LET l_sfdc.sfdcud014 = ''   #自定義欄位(數字)014
      LET l_sfdc.sfdcud015 = ''   #自定義欄位(數字)015
      LET l_sfdc.sfdcud016 = ''   #自定義欄位(數字)016
      LET l_sfdc.sfdcud017 = ''   #自定義欄位(數字)017
      LET l_sfdc.sfdcud018 = ''   #自定義欄位(數字)018
      LET l_sfdc.sfdcud019 = ''   #自定義欄位(數字)019
      LET l_sfdc.sfdcud020 = ''   #自定義欄位(數字)020
      LET l_sfdc.sfdcud021 = ''   #自定義欄位(日期時間)021
      LET l_sfdc.sfdcud022 = ''   #自定義欄位(日期時間)022
      LET l_sfdc.sfdcud023 = ''   #自定義欄位(日期時間)023
      LET l_sfdc.sfdcud024 = ''   #自定義欄位(日期時間)024
      LET l_sfdc.sfdcud025 = ''   #自定義欄位(日期時間)025
      LET l_sfdc.sfdcud026 = ''   #自定義欄位(日期時間)026
      LET l_sfdc.sfdcud027 = ''   #自定義欄位(日期時間)027
      LET l_sfdc.sfdcud028 = ''   #自定義欄位(日期時間)028
      LET l_sfdc.sfdcud029 = ''   #自定義欄位(日期時間)029
      LET l_sfdc.sfdcud030 = ''   #自定義欄位(日期時間)030

      #161109-00085#42-s
      #INSERT INTO sfdc_t VALUES(l_sfdc.*)
      INSERT INTO sfdc_t( sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
                          sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
                          sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
                          sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
                          sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
                          sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
                          sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
                          sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
                          sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
                          sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
                          sfdcud030 )
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
      #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #新增或更新sfde(包含新增或更新sfdf)   'N'代表不自动增加sfdf
      CALL s_asft310_chg_sfde_f_sfdc_ins(l_sfdc.sfdcdocno,l_sfdc.sfdcseq,'N') RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      INITIALIZE l_sfdd.* TO NULL
      LET l_sfdd.sfddent   = g_enterprise           #企業代碼
      LET l_sfdd.sfddsite  = g_site                 #營運據

      #退料单
      LET l_sfdd.sfdddocno = g_asfp360_04_m2.return_no #發退料單號
      LET l_sfdd.sfdd012   = 1    #正負

      LET l_sfdd.sfddseq   = l_sfdc.sfdcseq         #項次
      LET l_sfdd.sfddseq1  = 1                      #項序
      LET l_sfdd.sfdd001   = l_temp3.sfba006        #發退料料號
      LET l_sfdd.sfdd013   = l_temp3.sfba021        #产品特征
      IF cl_null(l_sfdd.sfdd013) THEN LET l_sfdd.sfdd013 = ' ' END IF
      LET l_sfdd.sfdd002   = 1                      #替代率
      LET l_sfdd.sfdd003   = l_sfdc.sfdc012         #庫位
      LET l_sfdd.sfdd004   = l_sfdc.sfdc013         #儲位
      LET l_sfdd.sfdd005   = l_sfdc.sfdc014         #批號
      LET l_sfdd.sfdd006   = l_sfdc.sfdc006         #單位
      LET l_sfdd.sfdd007   = l_temp3.outqty         #數量
      LET l_sfdd.sfdd008   = l_sfdc.sfdc009         #参考单位
      LET l_sfdd.sfdd009   = l_temp3.outqtyr        #参考单位数量
      LET l_sfdd.sfdd010   = l_sfdc.sfdc016         #庫存管理特徵
      LET l_sfdd.sfdd011   = ''   #包裝容器

      LET l_sfdd.sfddud001 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud002 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud003 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud004 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud005 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud006 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud007 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud008 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud009 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud010 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud011 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud012 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud013 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud014 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud015 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud016 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud017 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud018 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud019 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud020 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud021 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud022 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud023 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud024 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud025 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud026 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud027 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud028 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud029 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud030 = ''    #自定義欄位(日期時間)

      #161109-00085#42-s
      #INSERT INTO sfdd_t VALUES(l_sfdd.*)  
      INSERT INTO sfdd_t( sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,
                          sfdd001,sfdd002,sfdd003,sfdd004,sfdd005,
                          sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,
                          sfdd011,sfdd012,sfdd013,sfddud001,sfddud002,
                          sfddud003,sfddud004,sfddud005,sfddud006,sfddud007,
                          sfddud008,sfddud009,sfddud010,sfddud011,sfddud012,
                          sfddud013,sfddud014,sfddud015,sfddud016,sfddud017,
                          sfddud018,sfddud019,sfddud020,sfddud021,sfddud022,
                          sfddud023,sfddud024,sfddud025,sfddud026,sfddud027,
                          sfddud028,sfddud029,sfddud030,sfdd014,sfdd015) 
         VALUES (l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,
                 l_sfdd.sfdd001,l_sfdd.sfdd002,l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,
                 l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
                 l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfddud001,l_sfdd.sfddud002,
                 l_sfdd.sfddud003,l_sfdd.sfddud004,l_sfdd.sfddud005,l_sfdd.sfddud006,l_sfdd.sfddud007,
                 l_sfdd.sfddud008,l_sfdd.sfddud009,l_sfdd.sfddud010,l_sfdd.sfddud011,l_sfdd.sfddud012,
                 l_sfdd.sfddud013,l_sfdd.sfddud014,l_sfdd.sfddud015,l_sfdd.sfddud016,l_sfdd.sfddud017,
                 l_sfdd.sfddud018,l_sfdd.sfddud019,l_sfdd.sfddud020,l_sfdd.sfddud021,l_sfdd.sfddud022,
                 l_sfdd.sfddud023,l_sfdd.sfddud024,l_sfdd.sfddud025,l_sfdd.sfddud026,l_sfdd.sfddud027,
                 l_sfdd.sfddud028,l_sfdd.sfddud029,l_sfdd.sfddud030,l_sfdd.sfdd014,l_sfdd.sfdd015)      
      #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      #更新sfdc
      CALL s_asft310_chg_sfdc_f_sfdd_ins(l_sfdd.sfdddocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #处理sfdf,sfde：sfdd与sfdf总数应该平的
      CALL s_asft310_chg_sfdf_f_sfdd_ins(l_sfdd.sfdddocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      ##更新申请数量=实际数量
      #UPDATE sfdc_t SET sfdc007 = sfdc008,  #申請數量
      #                  sfdc010 = sfdc011   #参考单位申請數量
      # WHERE sfdcent  = g_enterprise
      #   AND sfdcdocno =l_sfdadocno
      #UPDATE sfde_t SET sfde004 = sfde005,  #申請數量
      #                  sfde007 = sfde008   #参考单位申請數量
      # WHERE sfdeent  = g_enterprise
      #   AND sfdedocno =l_sfdadocno
   END FOREACH
   CLOSE asfp360_04_gen_sfdc_21_c
   FREE asfp360_04_gen_sfdc_21_p

   RETURN r_success
END FUNCTION

#欠料补料
PUBLIC FUNCTION asfp360_04_gen_sfdb_13()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #161109-00085#42-s
   #DEFINE l_sfdb        RECORD LIKE sfdb_t.*
   DEFINE l_sfdb RECORD  #發退料套數檔
          sfdbent LIKE sfdb_t.sfdbent, #企業編號
          sfdbsite LIKE sfdb_t.sfdbsite, #營運據點
          sfdbdocno LIKE sfdb_t.sfdbdocno, #發退料單號
          sfdb001 LIKE sfdb_t.sfdb001, #工單單號
          sfdb002 LIKE sfdb_t.sfdb002, #Run Card
          sfdb003 LIKE sfdb_t.sfdb003, #部位
          sfdb004 LIKE sfdb_t.sfdb004, #作業
          sfdb005 LIKE sfdb_t.sfdb005, #作業序
          sfdb006 LIKE sfdb_t.sfdb006, #預計套數
          sfdb007 LIKE sfdb_t.sfdb007, #實際套數
          sfdb008 LIKE sfdb_t.sfdb008, #正負
          sfdbud001 LIKE sfdb_t.sfdbud001, #自定義欄位(文字)001
          sfdbud002 LIKE sfdb_t.sfdbud002, #自定義欄位(文字)002
          sfdbud003 LIKE sfdb_t.sfdbud003, #自定義欄位(文字)003
          sfdbud004 LIKE sfdb_t.sfdbud004, #自定義欄位(文字)004
          sfdbud005 LIKE sfdb_t.sfdbud005, #自定義欄位(文字)005
          sfdbud006 LIKE sfdb_t.sfdbud006, #自定義欄位(文字)006
          sfdbud007 LIKE sfdb_t.sfdbud007, #自定義欄位(文字)007
          sfdbud008 LIKE sfdb_t.sfdbud008, #自定義欄位(文字)008
          sfdbud009 LIKE sfdb_t.sfdbud009, #自定義欄位(文字)009
          sfdbud010 LIKE sfdb_t.sfdbud010, #自定義欄位(文字)010
          sfdbud011 LIKE sfdb_t.sfdbud011, #自定義欄位(數字)011
          sfdbud012 LIKE sfdb_t.sfdbud012, #自定義欄位(數字)012
          sfdbud013 LIKE sfdb_t.sfdbud013, #自定義欄位(數字)013
          sfdbud014 LIKE sfdb_t.sfdbud014, #自定義欄位(數字)014
          sfdbud015 LIKE sfdb_t.sfdbud015, #自定義欄位(數字)015
          sfdbud016 LIKE sfdb_t.sfdbud016, #自定義欄位(數字)016
          sfdbud017 LIKE sfdb_t.sfdbud017, #自定義欄位(數字)017
          sfdbud018 LIKE sfdb_t.sfdbud018, #自定義欄位(數字)018
          sfdbud019 LIKE sfdb_t.sfdbud019, #自定義欄位(數字)019
          sfdbud020 LIKE sfdb_t.sfdbud020, #自定義欄位(數字)020
          sfdbud021 LIKE sfdb_t.sfdbud021, #自定義欄位(日期時間)021
          sfdbud022 LIKE sfdb_t.sfdbud022, #自定義欄位(日期時間)022
          sfdbud023 LIKE sfdb_t.sfdbud023, #自定義欄位(日期時間)023
          sfdbud024 LIKE sfdb_t.sfdbud024, #自定義欄位(日期時間)024
          sfdbud025 LIKE sfdb_t.sfdbud025, #自定義欄位(日期時間)025
          sfdbud026 LIKE sfdb_t.sfdbud026, #自定義欄位(日期時間)026
          sfdbud027 LIKE sfdb_t.sfdbud027, #自定義欄位(日期時間)027
          sfdbud028 LIKE sfdb_t.sfdbud028, #自定義欄位(日期時間)028
          sfdbud029 LIKE sfdb_t.sfdbud029, #自定義欄位(日期時間)029
          sfdbud030 LIKE sfdb_t.sfdbud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   INITIALIZE l_sfdb.* TO NULL
   LET l_sfdb.sfdbent   = g_enterprise   #企業編號
   LET l_sfdb.sfdbsite  = g_site         #營運據點

   #发料单
   LET l_sfdb.sfdbdocno = g_asfp360_04_m2.send_no   #發退料單號
   LET l_sfdb.sfdb008   = -1   #正負
   LET l_sfdb.sfdb001   = g_sfaadocno_01     #工單單號
   
   LET l_sfdb.sfdb002   = ''     #Run Card
   SELECT sfca001 INTO l_sfdb.sfdb002 FROM sfca_t
    WHERE sfcaent = g_enterprise
      AND sfcasite= g_site
      AND sfcadocno=l_sfdb.sfdb001   #工单单号
   
   LET l_sfdb.sfdb003   = ' '   #部位
   LET l_sfdb.sfdb004   = ' '   #作業
   LET l_sfdb.sfdb005   = ' '   #作業序
   LET l_sfdb.sfdb006   = 0     #預計套數
   LET l_sfdb.sfdb007   = l_sfdb.sfdb006         #實際套數
   

   LET l_sfdb.sfdbud001 = ''      #自定義欄位(文字)001
   LET l_sfdb.sfdbud002 = ''      #自定義欄位(文字)002
   LET l_sfdb.sfdbud003 = ''      #自定義欄位(文字)003
   LET l_sfdb.sfdbud004 = ''      #自定義欄位(文字)004
   LET l_sfdb.sfdbud005 = ''      #自定義欄位(文字)005
   LET l_sfdb.sfdbud006 = ''      #自定義欄位(文字)006
   LET l_sfdb.sfdbud007 = ''      #自定義欄位(文字)007
   LET l_sfdb.sfdbud008 = ''      #自定義欄位(文字)008
   LET l_sfdb.sfdbud009 = ''      #自定義欄位(文字)009
   LET l_sfdb.sfdbud010 = ''      #自定義欄位(文字)010
   LET l_sfdb.sfdbud011 = ''      #自定義欄位(數字)011
   LET l_sfdb.sfdbud012 = ''      #自定義欄位(數字)012
   LET l_sfdb.sfdbud013 = ''      #自定義欄位(數字)013
   LET l_sfdb.sfdbud014 = ''      #自定義欄位(數字)014
   LET l_sfdb.sfdbud015 = ''      #自定義欄位(數字)015
   LET l_sfdb.sfdbud016 = ''      #自定義欄位(數字)016
   LET l_sfdb.sfdbud017 = ''      #自定義欄位(數字)017
   LET l_sfdb.sfdbud018 = ''      #自定義欄位(數字)018
   LET l_sfdb.sfdbud019 = ''      #自定義欄位(數字)019
   LET l_sfdb.sfdbud020 = ''      #自定義欄位(數字)020
   LET l_sfdb.sfdbud021 = ''      #自定義欄位(日期時間)021
   LET l_sfdb.sfdbud022 = ''      #自定義欄位(日期時間)022
   LET l_sfdb.sfdbud023 = ''      #自定義欄位(日期時間)023
   LET l_sfdb.sfdbud024 = ''      #自定義欄位(日期時間)024
   LET l_sfdb.sfdbud025 = ''      #自定義欄位(日期時間)025
   LET l_sfdb.sfdbud026 = ''      #自定義欄位(日期時間)026
   LET l_sfdb.sfdbud027 = ''      #自定義欄位(日期時間)027
   LET l_sfdb.sfdbud028 = ''      #自定義欄位(日期時間)028
   LET l_sfdb.sfdbud029 = ''      #自定義欄位(日期時間)029
   LET l_sfdb.sfdbud030 = ''      #自定義欄位(日期時間)030

   #161109-00085#42-s
   #INSERT INTO sfdb_t VALUES(l_sfdb.*)
   INSERT INTO sfdb_t(sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,
                      sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,
                      sfdb008,sfdbud001,sfdbud002,sfdbud003,sfdbud004,
                      sfdbud005,sfdbud006,sfdbud007,sfdbud008,sfdbud009,
                      sfdbud010,sfdbud011,sfdbud012,sfdbud013,sfdbud014,
                      sfdbud015,sfdbud016,sfdbud017,sfdbud018,sfdbud019,
                      sfdbud020,sfdbud021,sfdbud022,sfdbud023,sfdbud024,
                      sfdbud025,sfdbud026,sfdbud027,sfdbud028,sfdbud029,
                      sfdbud030 )
      VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,
              l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,
              l_sfdb.sfdb008,l_sfdb.sfdbud001,l_sfdb.sfdbud002,l_sfdb.sfdbud003,l_sfdb.sfdbud004,
              l_sfdb.sfdbud005,l_sfdb.sfdbud006,l_sfdb.sfdbud007,l_sfdb.sfdbud008,l_sfdb.sfdbud009,
              l_sfdb.sfdbud010,l_sfdb.sfdbud011,l_sfdb.sfdbud012,l_sfdb.sfdbud013,l_sfdb.sfdbud014,
              l_sfdb.sfdbud015,l_sfdb.sfdbud016,l_sfdb.sfdbud017,l_sfdb.sfdbud018,l_sfdb.sfdbud019,
              l_sfdb.sfdbud020,l_sfdb.sfdbud021,l_sfdb.sfdbud022,l_sfdb.sfdbud023,l_sfdb.sfdbud024,
              l_sfdb.sfdbud025,l_sfdb.sfdbud026,l_sfdb.sfdbud027,l_sfdb.sfdbud028,l_sfdb.sfdbud029,
              l_sfdb.sfdbud030)   
   #161109-00085#42-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfdb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

#欠料补料
PUBLIC FUNCTION asfp360_04_gen_sfdc_13()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
#161109-00085#42-s
#DEFINE l_sfdc        RECORD LIKE sfdc_t.*
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
END RECORD  
#161109-00085#42-e
#161109-00085#42-s
#DEFINE l_sfdd        RECORD LIKE sfdd_t.*
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
       sfdd014 LIKE sfdd_t.sfdd014, #備置量
       sfdd015 LIKE sfdd_t.sfdd015  #在揀量
END RECORD
#161109-00085#42-e  
   DEFINE l_sql         STRING
   DEFINE l_temp        RECORD
                        sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                        sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                        sfba005        LIKE sfba_t.sfba005,  #BOM料号 需要和asfp360_02_temp匹配
                        sfba006        LIKE sfba_t.sfba006,  #发料料号
                        sfba021        LIKE sfba_t.sfba021,  #特征
                        sfba014        LIKE sfba_t.sfba014,  #单位
                        unitr          LIKE sfba_t.sfba014,  #参考单位
                        inqty_sum      LIKE sfba_t.sfba016,  #来源拨出数量合计
                        inqtyr_sum     LIKE sfba_t.sfba016   #参考单位来源拨出数量合计
                        END RECORD
   DEFINE l_sfdcseq     LIKE sfdc_t.sfdcseq
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #同成套发料处理方式
   CALL asfp360_04_gen_sfdc_11() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

#发退料需求档（单颗挪）
#一般退料23
PUBLIC FUNCTION asfp360_04_gen_sfdc_23()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
#161109-00085#42-s
#DEFINE l_sfdc        RECORD LIKE sfdc_t.*
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
END RECORD  
#161109-00085#42-e
#161109-00085#42-s
#DEFINE l_sfdd        RECORD LIKE sfdd_t.*
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
       sfdd014 LIKE sfdd_t.sfdd014, #備置量
       sfdd015 LIKE sfdd_t.sfdd015  #在揀量
END RECORD
#161109-00085#42-e  
   DEFINE l_sql         STRING
   DEFINE l_temp3       RECORD
                        sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                        sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                        sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                        sfba005        LIKE sfba_t.sfba005,  #BOM料号 需要和asfp360_02_temp匹配
                        sfba006        LIKE sfba_t.sfba006,  #发料料号
                        sfba021        LIKE sfba_t.sfba021,  #特征
                        sfba014        LIKE sfba_t.sfba014,  #单位
                        unitr          LIKE sfba_t.sfba014,  #参考单位
                        outqty         LIKE sfba_t.sfba016,  #拟拨出数量
                        outqtyr        LIKE sfba_t.sfba016   #参考单位拨出数量
                        END RECORD
   DEFINE l_sfdcseq     LIKE sfdc_t.sfdcseq
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET l_sql = " SELECT sfaadocno,sfbaseq,sfbaseq1, ",
               "        sfba005,sfba006,sfba021, ",
               "        sfba014,unitr,",
               "        SUM(outqty),SUM(outqtyr) ",
               "   FROM asfp360_tmp04",   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_05_temp3 ——> asfp360_tmp04
               "  WHERE sel = 'Y' ",
               "    AND outqty > 0 ",
               "  GROUP BY sfaadocno,sfbaseq,sfbaseq1, ",
               "           sfba005,sfba006,sfba021, ",
               "           sfba014,unitr ",
               "  ORDER BY sfaadocno,sfbaseq,sfbaseq1 "
   PREPARE asfp360_04_gen_sfdc_23_p FROM l_sql
   DECLARE asfp360_04_gen_sfdc_23_c CURSOR FOR asfp360_04_gen_sfdc_23_p
   LET l_sfdcseq = 0
   FOREACH asfp360_04_gen_sfdc_23_c INTO l_temp3.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_04_gen_sfdc_23_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   
   
      IF cl_null(l_temp3.outqty) THEN LET l_temp3.outqty = 0 END IF
      IF cl_null(l_temp3.outqtyr) THEN LET l_temp3.outqtyr = 0 END IF
      
      INITIALIZE l_sfdc.* TO NULL
      LET l_sfdc.sfdcent   = g_enterprise   #企業編號
      LET l_sfdc.sfdcsite  = g_site         #營運據點

      #退料单
      LET l_sfdc.sfdcdocno = g_asfp360_04_m2.return_no #發退料單號
      LET l_sfdc.sfdc017   = 1    #正負
      
      LET l_sfdcseq = l_sfdcseq + 1
      LET l_sfdc.sfdcseq   = l_sfdcseq   #項次
      
      LET l_sfdc.sfdc001   = l_temp3.sfaadocno   #工單單號
      LET l_sfdc.sfdc002   = l_temp3.sfbaseq     #工單項次
      LET l_sfdc.sfdc003   = l_temp3.sfbaseq1    #工單項序
      LET l_sfdc.sfdc004   = l_temp3.sfba006     #需求料號
      LET l_sfdc.sfdc005   = l_temp3.sfba021     #產品特徵
      IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF  #产品特征
      LET l_sfdc.sfdc006   = l_temp3.sfba014     #單位
      LET l_sfdc.sfdc007   = l_temp3.outqty      #申請數量  跟实际数量一起更新
      LET l_sfdc.sfdc008   = 0  #l_temp3.outqty      #實際數量
      LET l_sfdc.sfdc009   = l_temp3.unitr       #參考單位
      LET l_sfdc.sfdc010   = l_temp3.outqtyr     #參考單位需求數量
      LET l_sfdc.sfdc011   = 0  #l_temp3.outqtyr     #參考單位實際數量
      LET l_sfdc.sfdc012   = g_asfp360_04_m.ware #指定庫位
      IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
      LET l_sfdc.sfdc013   = g_asfp360_04_m.loca #指定儲位
      IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
      LET l_sfdc.sfdc014   = g_asfp360_04_m.lot  #指定批號
      IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
      LET l_sfdc.sfdc015   = ''   #理由碼
      LET l_sfdc.sfdc016   = ' '   #庫存管理特徴

      LET l_sfdc.sfdcud001 = ''   #自定義欄位(文字)001
      LET l_sfdc.sfdcud002 = ''   #自定義欄位(文字)002
      LET l_sfdc.sfdcud003 = ''   #自定義欄位(文字)003
      LET l_sfdc.sfdcud004 = ''   #自定義欄位(文字)004
      LET l_sfdc.sfdcud005 = ''   #自定義欄位(文字)005
      LET l_sfdc.sfdcud006 = ''   #自定義欄位(文字)006
      LET l_sfdc.sfdcud007 = ''   #自定義欄位(文字)007
      LET l_sfdc.sfdcud008 = ''   #自定義欄位(文字)008
      LET l_sfdc.sfdcud009 = ''   #自定義欄位(文字)009
      LET l_sfdc.sfdcud010 = ''   #自定義欄位(文字)010
      LET l_sfdc.sfdcud011 = ''   #自定義欄位(數字)011
      LET l_sfdc.sfdcud012 = ''   #自定義欄位(數字)012
      LET l_sfdc.sfdcud013 = ''   #自定義欄位(數字)013
      LET l_sfdc.sfdcud014 = ''   #自定義欄位(數字)014
      LET l_sfdc.sfdcud015 = ''   #自定義欄位(數字)015
      LET l_sfdc.sfdcud016 = ''   #自定義欄位(數字)016
      LET l_sfdc.sfdcud017 = ''   #自定義欄位(數字)017
      LET l_sfdc.sfdcud018 = ''   #自定義欄位(數字)018
      LET l_sfdc.sfdcud019 = ''   #自定義欄位(數字)019
      LET l_sfdc.sfdcud020 = ''   #自定義欄位(數字)020
      LET l_sfdc.sfdcud021 = ''   #自定義欄位(日期時間)021
      LET l_sfdc.sfdcud022 = ''   #自定義欄位(日期時間)022
      LET l_sfdc.sfdcud023 = ''   #自定義欄位(日期時間)023
      LET l_sfdc.sfdcud024 = ''   #自定義欄位(日期時間)024
      LET l_sfdc.sfdcud025 = ''   #自定義欄位(日期時間)025
      LET l_sfdc.sfdcud026 = ''   #自定義欄位(日期時間)026
      LET l_sfdc.sfdcud027 = ''   #自定義欄位(日期時間)027
      LET l_sfdc.sfdcud028 = ''   #自定義欄位(日期時間)028
      LET l_sfdc.sfdcud029 = ''   #自定義欄位(日期時間)029
      LET l_sfdc.sfdcud030 = ''   #自定義欄位(日期時間)030

      #161109-00085#42-s
      #INSERT INTO sfdc_t VALUES(l_sfdc.*)
      INSERT INTO sfdc_t( sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
                          sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
                          sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
                          sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
                          sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
                          sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
                          sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
                          sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
                          sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
                          sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
                          sfdcud030 )
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
      #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #新增或更新sfde(包含新增或更新sfdf)   'N'代表不自动增加sfdf
      CALL s_asft310_chg_sfde_f_sfdc_ins(l_sfdc.sfdcdocno,l_sfdc.sfdcseq,'N') RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      INITIALIZE l_sfdd.* TO NULL
      LET l_sfdd.sfddent   = g_enterprise           #企業代碼
      LET l_sfdd.sfddsite  = g_site                 #營運據

      #退料单
      LET l_sfdd.sfdddocno = g_asfp360_04_m2.return_no #發退料單號
      LET l_sfdd.sfdd012   = 1    #正負

      LET l_sfdd.sfddseq   = l_sfdc.sfdcseq         #項次
      LET l_sfdd.sfddseq1  = 1                      #項序
      LET l_sfdd.sfdd001   = l_temp3.sfba006        #發退料料號
      LET l_sfdd.sfdd013   = l_temp3.sfba021        #产品特征
      IF cl_null(l_sfdd.sfdd013) THEN LET l_sfdd.sfdd013 = ' ' END IF
      LET l_sfdd.sfdd002   = 1                      #替代率
      LET l_sfdd.sfdd003   = l_sfdc.sfdc012         #庫位
      LET l_sfdd.sfdd004   = l_sfdc.sfdc013         #儲位
      LET l_sfdd.sfdd005   = l_sfdc.sfdc014         #批號
      LET l_sfdd.sfdd006   = l_sfdc.sfdc006         #單位
      LET l_sfdd.sfdd007   = l_temp3.outqty         #數量
      LET l_sfdd.sfdd008   = l_sfdc.sfdc009         #参考单位
      LET l_sfdd.sfdd009   = l_temp3.outqtyr        #参考单位数量
      LET l_sfdd.sfdd010   = l_sfdc.sfdc016         #庫存管理特徵
      LET l_sfdd.sfdd011   = ''   #包裝容器

      LET l_sfdd.sfddud001 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud002 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud003 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud004 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud005 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud006 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud007 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud008 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud009 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud010 = ''    #自定義欄位(文字)
      LET l_sfdd.sfddud011 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud012 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud013 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud014 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud015 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud016 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud017 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud018 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud019 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud020 = ''    #自定義欄位(數字)
      LET l_sfdd.sfddud021 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud022 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud023 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud024 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud025 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud026 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud027 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud028 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud029 = ''    #自定義欄位(日期時間)
      LET l_sfdd.sfddud030 = ''    #自定義欄位(日期時間) 
      
      #161109-00085#42-s
      #INSERT INTO sfdd_t VALUES(l_sfdd.*)  
      INSERT INTO sfdd_t( sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,
                          sfdd001,sfdd002,sfdd003,sfdd004,sfdd005,
                          sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,
                          sfdd011,sfdd012,sfdd013,sfddud001,sfddud002,
                          sfddud003,sfddud004,sfddud005,sfddud006,sfddud007,
                          sfddud008,sfddud009,sfddud010,sfddud011,sfddud012,
                          sfddud013,sfddud014,sfddud015,sfddud016,sfddud017,
                          sfddud018,sfddud019,sfddud020,sfddud021,sfddud022,
                          sfddud023,sfddud024,sfddud025,sfddud026,sfddud027,
                          sfddud028,sfddud029,sfddud030,sfdd014,sfdd015) 
         VALUES (l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,
                 l_sfdd.sfdd001,l_sfdd.sfdd002,l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,
                 l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
                 l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfddud001,l_sfdd.sfddud002,
                 l_sfdd.sfddud003,l_sfdd.sfddud004,l_sfdd.sfddud005,l_sfdd.sfddud006,l_sfdd.sfddud007,
                 l_sfdd.sfddud008,l_sfdd.sfddud009,l_sfdd.sfddud010,l_sfdd.sfddud011,l_sfdd.sfddud012,
                 l_sfdd.sfddud013,l_sfdd.sfddud014,l_sfdd.sfddud015,l_sfdd.sfddud016,l_sfdd.sfddud017,
                 l_sfdd.sfddud018,l_sfdd.sfddud019,l_sfdd.sfddud020,l_sfdd.sfddud021,l_sfdd.sfddud022,
                 l_sfdd.sfddud023,l_sfdd.sfddud024,l_sfdd.sfddud025,l_sfdd.sfddud026,l_sfdd.sfddud027,
                 l_sfdd.sfddud028,l_sfdd.sfddud029,l_sfdd.sfddud030,l_sfdd.sfdd014,l_sfdd.sfdd015)      
      #161109-00085#42-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      #更新sfdc
      CALL s_asft310_chg_sfdc_f_sfdd_ins(l_sfdd.sfdddocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #处理sfdf,sfde：sfdd与sfdf总数应该平的
      CALL s_asft310_chg_sfdf_f_sfdd_ins(l_sfdd.sfdddocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      ##更新申请数量=实际数量
      #UPDATE sfdc_t SET sfdc007 = sfdc008,  #申請數量
      #                  sfdc010 = sfdc011   #参考单位申請數量
      # WHERE sfdcent  = g_enterprise
      #   AND sfdcdocno =l_sfdadocno
      #UPDATE sfde_t SET sfde004 = sfde005,  #申請數量
      #                  sfde007 = sfde008   #参考单位申請數量
      # WHERE sfdeent  = g_enterprise
      #   AND sfdedocno =l_sfdadocno
   END FOREACH
   CLOSE asfp360_04_gen_sfdc_23_c
   FREE asfp360_04_gen_sfdc_23_p
   
   RETURN r_success
END FUNCTION

#显示产生的资料
PUBLIC FUNCTION asfp360_04_show()

   WHENEVER ERROR CONTINUE

   DISPLAY g_asfp360_04_m2.send_no TO send_no_04a1
   DISPLAY g_asfp360_04_m2.return_no TO return_no_04a2
                   
   CALL asfp360_04_b_fill1()
   CALL asfp360_04_b_fill2()
END FUNCTION

#发料单
PUBLIC FUNCTION asfp360_04_b_fill1()
   DEFINE l_sql        STRING
   DEFINE l_ac_l       LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   WHENEVER ERROR CONTINUE
   CALL g_asfp360_04_d1.clear()

   LET l_sql = "SELECT sfdcseq,sfdc001,sfdc002,sfdc003,sfba002,a.oocql004, ",
               "       sfba003,b.oocql004,sfba004,sfdc004,imaal003,imaal004, ",
               "       sfdc005,sfdc006,c.oocal003,sfba013,sfba016,sfdc008, ",
               "       sfdc009,d.oocal003,sfdc011 ",
               "  FROM sfdc_t LEFT OUTER JOIN sfba_t    ON sfbaent = sfdcent AND sfbadocno=sfdc001 AND sfbaseq=sfdc002 AND sfbaseq1=sfdc003 ",
               "              LEFT OUTER JOIN imaal_t   ON imaalent = sfdcent AND imaal001=sfdc004 AND imaal002= '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocql_t a ON a.oocql001= '215' AND sfba002 = a.oocql002 AND sfbaent = a.oocqlent AND a.oocql003 = '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocql_t b ON b.oocql001= '221' AND sfba003 = b.oocql002 AND sfbaent = b.oocqlent AND b.oocql003 = '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocal_t c ON c.oocalent = sfdcent AND c.oocal001 = sfdc006 AND c.oocal002 = '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocal_t d ON d.oocalent = sfdcent AND d.oocal001 = sfdc009 AND d.oocal002 = '"||g_dlang||"' ",
               " WHERE sfdcdocno = '",g_asfp360_04_m2.send_no,"' ",
               "   AND sfdcent = ",g_enterprise," ", #170123-00011#1 add
               " ORDER BY sfdcseq"
   PREPARE asfp360_04_b_fill1_sel FROM l_sql
   DECLARE asfp360_04_b_fill1_curs CURSOR FOR asfp360_04_b_fill1_sel
   LET l_ac_l = 1
   ERROR "Searching!"
   FOREACH asfp360_04_b_fill1_curs INTO g_asfp360_04_d1[l_ac_l].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_04_b_fill1_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF


      LET l_ac_l = l_ac_l + 1
      IF l_ac_l > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_asfp360_04_d1.deleteElement(l_ac_l)
   CLOSE asfp360_04_b_fill1_curs
   FREE asfp360_04_b_fill1_sel

END FUNCTION

#退料单
PUBLIC FUNCTION asfp360_04_b_fill2()
   DEFINE l_sql        STRING
   DEFINE l_ac_l       LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   WHENEVER ERROR CONTINUE
   CALL g_asfp360_04_d2.clear()

   LET l_sql = "SELECT sfdcseq,sfdc001,sfdc002,sfdc003,sfba002,a.oocql004, ",
               "       sfba003,b.oocql004,sfba004,sfdc004,imaal003,imaal004, ",
               "       sfdc005,sfdc006,c.oocal003,sfba013,sfba016,sfdc008, ",
               "       sfdc009,d.oocal003,sfdc011 ",
               "  FROM sfdc_t LEFT OUTER JOIN sfba_t    ON sfbaent = sfdcent AND sfbadocno=sfdc001 AND sfbaseq=sfdc002 AND sfbaseq1=sfdc003 ",
               "              LEFT OUTER JOIN imaal_t   ON imaalent = sfdcent AND imaal001=sfdc004 AND imaal002= '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocql_t a ON a.oocql001= '215' AND sfba002 = a.oocql002 AND sfbaent = a.oocqlent AND a.oocql003 = '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocql_t b ON b.oocql001= '221' AND sfba003 = b.oocql002 AND sfbaent = b.oocqlent AND b.oocql003 = '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocal_t c ON c.oocalent = sfdcent AND c.oocal001 = sfdc006 AND c.oocal002 = '"||g_dlang||"' ",
               "              LEFT OUTER JOIN oocal_t d ON d.oocalent = sfdcent AND d.oocal001 = sfdc009 AND d.oocal002 = '"||g_dlang||"' ",
               " WHERE sfdcdocno = '",g_asfp360_04_m2.return_no,"' ",
               "   AND sfdcent = ",g_enterprise," ", #170123-00011#1 add
               " ORDER BY sfdcseq"
   PREPARE asfp360_04_b_fill2_sel FROM l_sql
   DECLARE asfp360_04_b_fill2_curs CURSOR FOR asfp360_04_b_fill2_sel
   LET l_ac_l = 1
   ERROR "Searching!"
   FOREACH asfp360_04_b_fill2_curs INTO g_asfp360_04_d2[l_ac_l].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_04_b_fill2_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF


      LET l_ac_l = l_ac_l + 1
      IF l_ac_l > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_asfp360_04_d2.deleteElement(l_ac_l)
   CLOSE asfp360_04_b_fill2_curs
   FREE asfp360_04_b_fill2_sel

END FUNCTION

#产生挪料记录单头档
PUBLIC FUNCTION asfp360_04_gen_sfla()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #161109-00085#42-s
   #DEFINE l_sfla        RECORD LIKE sfla_t.*
   DEFINE l_sfla RECORD  #工單挪料記錄單頭檔
          sflaent LIKE sfla_t.sflaent, #企業編號
          sflasite LIKE sfla_t.sflasite, #營運據點
          sfladocno LIKE sfla_t.sfladocno, #挪料序號
          sfladocdt LIKE sfla_t.sfladocdt, #挪料日期
          sfla001 LIKE sfla_t.sfla001, #挪料類型
          sfla002 LIKE sfla_t.sfla002, #申請人
          sfla003 LIKE sfla_t.sfla003, #發料單號
          sfla004 LIKE sfla_t.sfla004, #退料單號
          sflaud001 LIKE sfla_t.sflaud001, #自定義欄位(文字)001
          sflaud002 LIKE sfla_t.sflaud002, #自定義欄位(文字)002
          sflaud003 LIKE sfla_t.sflaud003, #自定義欄位(文字)003
          sflaud004 LIKE sfla_t.sflaud004, #自定義欄位(文字)004
          sflaud005 LIKE sfla_t.sflaud005, #自定義欄位(文字)005
          sflaud006 LIKE sfla_t.sflaud006, #自定義欄位(文字)006
          sflaud007 LIKE sfla_t.sflaud007, #自定義欄位(文字)007
          sflaud008 LIKE sfla_t.sflaud008, #自定義欄位(文字)008
          sflaud009 LIKE sfla_t.sflaud009, #自定義欄位(文字)009
          sflaud010 LIKE sfla_t.sflaud010, #自定義欄位(文字)010
          sflaud011 LIKE sfla_t.sflaud011, #自定義欄位(數字)011
          sflaud012 LIKE sfla_t.sflaud012, #自定義欄位(數字)012
          sflaud013 LIKE sfla_t.sflaud013, #自定義欄位(數字)013
          sflaud014 LIKE sfla_t.sflaud014, #自定義欄位(數字)014
          sflaud015 LIKE sfla_t.sflaud015, #自定義欄位(數字)015
          sflaud016 LIKE sfla_t.sflaud016, #自定義欄位(數字)016
          sflaud017 LIKE sfla_t.sflaud017, #自定義欄位(數字)017
          sflaud018 LIKE sfla_t.sflaud018, #自定義欄位(數字)018
          sflaud019 LIKE sfla_t.sflaud019, #自定義欄位(數字)019
          sflaud020 LIKE sfla_t.sflaud020, #自定義欄位(數字)020
          sflaud021 LIKE sfla_t.sflaud021, #自定義欄位(日期時間)021
          sflaud022 LIKE sfla_t.sflaud022, #自定義欄位(日期時間)022
          sflaud023 LIKE sfla_t.sflaud023, #自定義欄位(日期時間)023
          sflaud024 LIKE sfla_t.sflaud024, #自定義欄位(日期時間)024
          sflaud025 LIKE sfla_t.sflaud025, #自定義欄位(日期時間)025
          sflaud026 LIKE sfla_t.sflaud026, #自定義欄位(日期時間)026
          sflaud027 LIKE sfla_t.sflaud027, #自定義欄位(日期時間)027
          sflaud028 LIKE sfla_t.sflaud028, #自定義欄位(日期時間)028
          sflaud029 LIKE sfla_t.sflaud029, #自定義欄位(日期時間)029
          sflaud030 LIKE sfla_t.sflaud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_sfla.sflaent   = g_enterprise  #企業編號
   LET l_sfla.sflasite  = g_site        #營運據點
   #LET l_sfla.sfladocno =    #挪料序號
   LET l_sfla.sfladocdt = cl_get_today()  #挪料日期
   LET l_sfla.sfla001   = g_asfp360_02_m.type #挪料類型 1 成套 2单颗
   LET l_sfla.sfla002   = g_asfp360_04_m.user #申請人
   LET l_sfla.sfla003   = ''   #發料單號
   LET l_sfla.sfla004   = ''   #退料單號
   #161109-00085#42-s
#   LET l_sfla.sflaud001 = ''   #自定義欄位(文字)001
#   LET l_sfla.sflaud002 = ''   #自定義欄位(文字)002
#   LET l_sfla.sflaud003 = ''   #自定義欄位(文字)003
#   LET l_sfla.sflaud004 = ''   #自定義欄位(文字)004
#   LET l_sfla.sflaud005 = ''   #自定義欄位(文字)005
#   LET l_sfla.sflaud006 = ''   #自定義欄位(文字)006
#   LET l_sfla.sflaud007 = ''   #自定義欄位(文字)007
#   LET l_sfla.sflaud008 = ''   #自定義欄位(文字)008
#   LET l_sfla.sflaud009 = ''   #自定義欄位(文字)009
#   LET l_sfla.sflaud010 = ''   #自定義欄位(文字)010
#   LET l_sfla.sflaud011 = ''   #自定義欄位(數字)011
#   LET l_sfla.sflaud012 = ''   #自定義欄位(數字)012
#   LET l_sfla.sflaud013 = ''   #自定義欄位(數字)013
#   LET l_sfla.sflaud014 = ''   #自定義欄位(數字)014
#   LET l_sfla.sflaud015 = ''   #自定義欄位(數字)015
#   LET l_sfla.sflaud016 = ''   #自定義欄位(數字)016
#   LET l_sfla.sflaud017 = ''   #自定義欄位(數字)017
#   LET l_sfla.sflaud018 = ''   #自定義欄位(數字)018
#   LET l_sfla.sflaud019 = ''   #自定義欄位(數字)019
#   LET l_sfla.sflaud020 = ''   #自定義欄位(數字)020
#   LET l_sfla.sflaud021 = ''   #自定義欄位(日期時間)021
#   LET l_sfla.sflaud022 = ''   #自定義欄位(日期時間)022
#   LET l_sfla.sflaud023 = ''   #自定義欄位(日期時間)023
#   LET l_sfla.sflaud024 = ''   #自定義欄位(日期時間)024
#   LET l_sfla.sflaud025 = ''   #自定義欄位(日期時間)025
#   LET l_sfla.sflaud026 = ''   #自定義欄位(日期時間)026
#   LET l_sfla.sflaud027 = ''   #自定義欄位(日期時間)027
#   LET l_sfla.sflaud028 = ''   #自定義欄位(日期時間)028
#   LET l_sfla.sflaud029 = ''   #自定義欄位(日期時間)029
#   LET l_sfla.sflaud030 = ''   #自定義欄位(日期時間)030
   #161109-00085#42-e   
   CALL asfp360_04_get_sfladocno(l_sfla.sfladocdt) RETURNING l_success,l_sfla.sfladocno #计算挪料序号
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #161109-00085#42-s
   #INSERT INTO sfla_t VALUES(l_sfla.*)
   INSERT INTO sfla_t( sflaent,sflasite,sfladocno,sfladocdt,sfla001,
                       sfla002,sfla003,sfla004,sflaud001,sflaud002,
                       sflaud003,sflaud004,sflaud005,sflaud006,sflaud007,
                       sflaud008,sflaud009,sflaud010,sflaud011,sflaud012,
                       sflaud013,sflaud014,sflaud015,sflaud016,sflaud017,
                       sflaud018,sflaud019,sflaud020,sflaud021,sflaud022,
                       sflaud023,sflaud024,sflaud025,sflaud026,sflaud027,
                       sflaud028,sflaud029,sflaud030 )
      VALUES(l_sfla.sflaent,l_sfla.sflasite,l_sfla.sfladocno,l_sfla.sfladocdt,l_sfla.sfla001,
             l_sfla.sfla002,l_sfla.sfla003,l_sfla.sfla004,l_sfla.sflaud001,l_sfla.sflaud002,
             l_sfla.sflaud003,l_sfla.sflaud004,l_sfla.sflaud005,l_sfla.sflaud006,l_sfla.sflaud007,
             l_sfla.sflaud008,l_sfla.sflaud009,l_sfla.sflaud010,l_sfla.sflaud011,l_sfla.sflaud012,
             l_sfla.sflaud013,l_sfla.sflaud014,l_sfla.sflaud015,l_sfla.sflaud016,l_sfla.sflaud017,
             l_sfla.sflaud018,l_sfla.sflaud019,l_sfla.sflaud020,l_sfla.sflaud021,l_sfla.sflaud022,
             l_sfla.sflaud023,l_sfla.sflaud024,l_sfla.sflaud025,l_sfla.sflaud026,l_sfla.sflaud027,
             l_sfla.sflaud028,l_sfla.sflaud029,l_sfla.sflaud030)
   #161109-00085#42-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfla_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET g_asfp360_04_m2.sfladocno = l_sfla.sfladocno  #挪料序號

   RETURN r_success
END FUNCTION

#产生挪料记录
#当非成套挪料时，不需要回写sflb_t和sflc_t
#不放在产生发料单重处理，为了程序的可读性，效能差距可以忽略
PUBLIC FUNCTION asfp360_04_gen_sflb()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #161109-00085#42-s
   #DEFINE l_sflb        RECORD LIKE sflb_t.*   #工單挪料記錄套數單身檔（目的）
   DEFINE l_sflb RECORD  #工單挪料記錄套數單身檔（目的）
          sflbent LIKE sflb_t.sflbent, #企業編號
          sflbsite LIKE sflb_t.sflbsite, #營運據點
          sflbdocno LIKE sflb_t.sflbdocno, #挪料序號
          sflbseq LIKE sflb_t.sflbseq, #項次
          sflb001 LIKE sflb_t.sflb001, #工單單號
          sflb002 LIKE sflb_t.sflb002, #生產數量
          sflb003 LIKE sflb_t.sflb003, #已發套數
          sflb004 LIKE sflb_t.sflb004, #已入庫量
          sflb005 LIKE sflb_t.sflb005, #撥入套數
          sflbud001 LIKE sflb_t.sflbud001, #自定義欄位(文字)001
          sflbud002 LIKE sflb_t.sflbud002, #自定義欄位(文字)002
          sflbud003 LIKE sflb_t.sflbud003, #自定義欄位(文字)003
          sflbud004 LIKE sflb_t.sflbud004, #自定義欄位(文字)004
          sflbud005 LIKE sflb_t.sflbud005, #自定義欄位(文字)005
          sflbud006 LIKE sflb_t.sflbud006, #自定義欄位(文字)006
          sflbud007 LIKE sflb_t.sflbud007, #自定義欄位(文字)007
          sflbud008 LIKE sflb_t.sflbud008, #自定義欄位(文字)008
          sflbud009 LIKE sflb_t.sflbud009, #自定義欄位(文字)009
          sflbud010 LIKE sflb_t.sflbud010, #自定義欄位(文字)010
          sflbud011 LIKE sflb_t.sflbud011, #自定義欄位(數字)011
          sflbud012 LIKE sflb_t.sflbud012, #自定義欄位(數字)012
          sflbud013 LIKE sflb_t.sflbud013, #自定義欄位(數字)013
          sflbud014 LIKE sflb_t.sflbud014, #自定義欄位(數字)014
          sflbud015 LIKE sflb_t.sflbud015, #自定義欄位(數字)015
          sflbud016 LIKE sflb_t.sflbud016, #自定義欄位(數字)016
          sflbud017 LIKE sflb_t.sflbud017, #自定義欄位(數字)017
          sflbud018 LIKE sflb_t.sflbud018, #自定義欄位(數字)018
          sflbud019 LIKE sflb_t.sflbud019, #自定義欄位(數字)019
          sflbud020 LIKE sflb_t.sflbud020, #自定義欄位(數字)020
          sflbud021 LIKE sflb_t.sflbud021, #自定義欄位(日期時間)021
          sflbud022 LIKE sflb_t.sflbud022, #自定義欄位(日期時間)022
          sflbud023 LIKE sflb_t.sflbud023, #自定義欄位(日期時間)023
          sflbud024 LIKE sflb_t.sflbud024, #自定義欄位(日期時間)024
          sflbud025 LIKE sflb_t.sflbud025, #自定義欄位(日期時間)025
          sflbud026 LIKE sflb_t.sflbud026, #自定義欄位(日期時間)026
          sflbud027 LIKE sflb_t.sflbud027, #自定義欄位(日期時間)027
          sflbud028 LIKE sflb_t.sflbud028, #自定義欄位(日期時間)028
          sflbud029 LIKE sflb_t.sflbud029, #自定義欄位(日期時間)029
          sflbud030 LIKE sflb_t.sflbud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   #161109-00085#42-s
   #DEFINE l_sflc        RECORD LIKE sflc_t.*   #工單挪料記錄套數單身檔（來源）
   DEFINE l_sflc RECORD  #工單挪料記錄套數單身檔（來源）
          sflcent LIKE sflc_t.sflcent, #企業編號
          sflcsite LIKE sflc_t.sflcsite, #營運據點
          sflcdocno LIKE sflc_t.sflcdocno, #挪料序號
          sflcseq LIKE sflc_t.sflcseq, #項次
          sflc001 LIKE sflc_t.sflc001, #工單單號
          sflc002 LIKE sflc_t.sflc002, #生產數量
          sflc003 LIKE sflc_t.sflc003, #已發套數
          sflc004 LIKE sflc_t.sflc004, #已入庫量
          sflc005 LIKE sflc_t.sflc005, #撥出套數
          sflcud001 LIKE sflc_t.sflcud001, #自定義欄位(文字)001
          sflcud002 LIKE sflc_t.sflcud002, #自定義欄位(文字)002
          sflcud003 LIKE sflc_t.sflcud003, #自定義欄位(文字)003
          sflcud004 LIKE sflc_t.sflcud004, #自定義欄位(文字)004
          sflcud005 LIKE sflc_t.sflcud005, #自定義欄位(文字)005
          sflcud006 LIKE sflc_t.sflcud006, #自定義欄位(文字)006
          sflcud007 LIKE sflc_t.sflcud007, #自定義欄位(文字)007
          sflcud008 LIKE sflc_t.sflcud008, #自定義欄位(文字)008
          sflcud009 LIKE sflc_t.sflcud009, #自定義欄位(文字)009
          sflcud010 LIKE sflc_t.sflcud010, #自定義欄位(文字)010
          sflcud011 LIKE sflc_t.sflcud011, #自定義欄位(數字)011
          sflcud012 LIKE sflc_t.sflcud012, #自定義欄位(數字)012
          sflcud013 LIKE sflc_t.sflcud013, #自定義欄位(數字)013
          sflcud014 LIKE sflc_t.sflcud014, #自定義欄位(數字)014
          sflcud015 LIKE sflc_t.sflcud015, #自定義欄位(數字)015
          sflcud016 LIKE sflc_t.sflcud016, #自定義欄位(數字)016
          sflcud017 LIKE sflc_t.sflcud017, #自定義欄位(數字)017
          sflcud018 LIKE sflc_t.sflcud018, #自定義欄位(數字)018
          sflcud019 LIKE sflc_t.sflcud019, #自定義欄位(數字)019
          sflcud020 LIKE sflc_t.sflcud020, #自定義欄位(數字)020
          sflcud021 LIKE sflc_t.sflcud021, #自定義欄位(日期時間)021
          sflcud022 LIKE sflc_t.sflcud022, #自定義欄位(日期時間)022
          sflcud023 LIKE sflc_t.sflcud023, #自定義欄位(日期時間)023
          sflcud024 LIKE sflc_t.sflcud024, #自定義欄位(日期時間)024
          sflcud025 LIKE sflc_t.sflcud025, #自定義欄位(日期時間)025
          sflcud026 LIKE sflc_t.sflcud026, #自定義欄位(日期時間)026
          sflcud027 LIKE sflc_t.sflcud027, #自定義欄位(日期時間)027
          sflcud028 LIKE sflc_t.sflcud028, #自定義欄位(日期時間)028
          sflcud029 LIKE sflc_t.sflcud029, #自定義欄位(日期時間)029
          sflcud030 LIKE sflc_t.sflcud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   #161109-00085#42-s
   #DEFINE l_sfld        RECORD LIKE sfld_t.*   #工單挪料記錄明細單身檔（目的）
   DEFINE l_sfld RECORD  #工單挪料記錄明細單身檔（目的）
          sfldent LIKE sfld_t.sfldent, #企業編號
          sfldsite LIKE sfld_t.sfldsite, #營運據點
          sflddocno LIKE sfld_t.sflddocno, #挪料序號
          sfldseq LIKE sfld_t.sfldseq, #項次
          sfldseq1 LIKE sfld_t.sfldseq1, #項序
          sfld001 LIKE sfld_t.sfld001, #工單單號
          sfld002 LIKE sfld_t.sfld002, #工單項次
          sfld003 LIKE sfld_t.sfld003, #工單項序
          sfld004 LIKE sfld_t.sfld004, #發料料號
          sfld005 LIKE sfld_t.sfld005, #標準QPA分子
          sfld006 LIKE sfld_t.sfld006, #標準QPA分母
          sfld007 LIKE sfld_t.sfld007, #應發數量
          sfld008 LIKE sfld_t.sfld008, #已發數量
          sfld009 LIKE sfld_t.sfld009, #撥入數量
          sfldud001 LIKE sfld_t.sfldud001, #自定義欄位(文字)001
          sfldud002 LIKE sfld_t.sfldud002, #自定義欄位(文字)002
          sfldud003 LIKE sfld_t.sfldud003, #自定義欄位(文字)003
          sfldud004 LIKE sfld_t.sfldud004, #自定義欄位(文字)004
          sfldud005 LIKE sfld_t.sfldud005, #自定義欄位(文字)005
          sfldud006 LIKE sfld_t.sfldud006, #自定義欄位(文字)006
          sfldud007 LIKE sfld_t.sfldud007, #自定義欄位(文字)007
          sfldud008 LIKE sfld_t.sfldud008, #自定義欄位(文字)008
          sfldud009 LIKE sfld_t.sfldud009, #自定義欄位(文字)009
          sfldud010 LIKE sfld_t.sfldud010, #自定義欄位(文字)010
          sfldud011 LIKE sfld_t.sfldud011, #自定義欄位(數字)011
          sfldud012 LIKE sfld_t.sfldud012, #自定義欄位(數字)012
          sfldud013 LIKE sfld_t.sfldud013, #自定義欄位(數字)013
          sfldud014 LIKE sfld_t.sfldud014, #自定義欄位(數字)014
          sfldud015 LIKE sfld_t.sfldud015, #自定義欄位(數字)015
          sfldud016 LIKE sfld_t.sfldud016, #自定義欄位(數字)016
          sfldud017 LIKE sfld_t.sfldud017, #自定義欄位(數字)017
          sfldud018 LIKE sfld_t.sfldud018, #自定義欄位(數字)018
          sfldud019 LIKE sfld_t.sfldud019, #自定義欄位(數字)019
          sfldud020 LIKE sfld_t.sfldud020, #自定義欄位(數字)020
          sfldud021 LIKE sfld_t.sfldud021, #自定義欄位(日期時間)021
          sfldud022 LIKE sfld_t.sfldud022, #自定義欄位(日期時間)022
          sfldud023 LIKE sfld_t.sfldud023, #自定義欄位(日期時間)023
          sfldud024 LIKE sfld_t.sfldud024, #自定義欄位(日期時間)024
          sfldud025 LIKE sfld_t.sfldud025, #自定義欄位(日期時間)025
          sfldud026 LIKE sfld_t.sfldud026, #自定義欄位(日期時間)026
          sfldud027 LIKE sfld_t.sfldud027, #自定義欄位(日期時間)027
          sfldud028 LIKE sfld_t.sfldud028, #自定義欄位(日期時間)028
          sfldud029 LIKE sfld_t.sfldud029, #自定義欄位(日期時間)029
          sfldud030 LIKE sfld_t.sfldud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   #161109-00085#42-s
   #DEFINE l_sfle        RECORD LIKE sfle_t.*   #工單挪料記錄明細單身檔（來源）
   DEFINE l_sfle RECORD  #工單挪料記錄明細單身檔（來源）
          sfleent LIKE sfle_t.sfleent, #企業編號
          sflesite LIKE sfle_t.sflesite, #營運據點
          sfledocno LIKE sfle_t.sfledocno, #挪料序號
          sfleseq LIKE sfle_t.sfleseq, #項次
          sfleseq1 LIKE sfle_t.sfleseq1, #項序
          sfle001 LIKE sfle_t.sfle001, #工單單號
          sfle002 LIKE sfle_t.sfle002, #工單項次
          sfle003 LIKE sfle_t.sfle003, #工單項序
          sfle004 LIKE sfle_t.sfle004, #發料料號
          sfle005 LIKE sfle_t.sfle005, #標準QPA分子
          sfle006 LIKE sfle_t.sfle006, #標準QPA分母
          sfle007 LIKE sfle_t.sfle007, #應發數量
          sfle008 LIKE sfle_t.sfle008, #已發數量
          sfle009 LIKE sfle_t.sfle009, #撥出數量
          sfleud001 LIKE sfle_t.sfleud001, #自定義欄位(文字)001
          sfleud002 LIKE sfle_t.sfleud002, #自定義欄位(文字)002
          sfleud003 LIKE sfle_t.sfleud003, #自定義欄位(文字)003
          sfleud004 LIKE sfle_t.sfleud004, #自定義欄位(文字)004
          sfleud005 LIKE sfle_t.sfleud005, #自定義欄位(文字)005
          sfleud006 LIKE sfle_t.sfleud006, #自定義欄位(文字)006
          sfleud007 LIKE sfle_t.sfleud007, #自定義欄位(文字)007
          sfleud008 LIKE sfle_t.sfleud008, #自定義欄位(文字)008
          sfleud009 LIKE sfle_t.sfleud009, #自定義欄位(文字)009
          sfleud010 LIKE sfle_t.sfleud010, #自定義欄位(文字)010
          sfleud011 LIKE sfle_t.sfleud011, #自定義欄位(數字)011
          sfleud012 LIKE sfle_t.sfleud012, #自定義欄位(數字)012
          sfleud013 LIKE sfle_t.sfleud013, #自定義欄位(數字)013
          sfleud014 LIKE sfle_t.sfleud014, #自定義欄位(數字)014
          sfleud015 LIKE sfle_t.sfleud015, #自定義欄位(數字)015
          sfleud016 LIKE sfle_t.sfleud016, #自定義欄位(數字)016
          sfleud017 LIKE sfle_t.sfleud017, #自定義欄位(數字)017
          sfleud018 LIKE sfle_t.sfleud018, #自定義欄位(數字)018
          sfleud019 LIKE sfle_t.sfleud019, #自定義欄位(數字)019
          sfleud020 LIKE sfle_t.sfleud020, #自定義欄位(數字)020
          sfleud021 LIKE sfle_t.sfleud021, #自定義欄位(日期時間)021
          sfleud022 LIKE sfle_t.sfleud022, #自定義欄位(日期時間)022
          sfleud023 LIKE sfle_t.sfleud023, #自定義欄位(日期時間)023
          sfleud024 LIKE sfle_t.sfleud024, #自定義欄位(日期時間)024
          sfleud025 LIKE sfle_t.sfleud025, #自定義欄位(日期時間)025
          sfleud026 LIKE sfle_t.sfleud026, #自定義欄位(日期時間)026
          sfleud027 LIKE sfle_t.sfleud027, #自定義欄位(日期時間)027
          sfleud028 LIKE sfle_t.sfleud028, #自定義欄位(日期時間)028
          sfleud029 LIKE sfle_t.sfleud029, #自定義欄位(日期時間)029
          sfleud030 LIKE sfle_t.sfleud030  #自定義欄位(日期時間)030
   END RECORD 
   #161109-00085#42-e
   DEFINE l_sflbseq     LIKE sflb_t.sflbseq
   DEFINE l_sflcseq     LIKE sflc_t.sflcseq
   DEFINE l_sfldseq1    LIKE sfld_t.sfldseq1
   DEFINE l_sfleseq1    LIKE sfle_t.sfleseq1
   DEFINE l_sql         STRING
   #161109-00085#42-s
   #DEFINE l_sfdb        RECORD LIKE sfdb_t.*
   DEFINE l_sfdb RECORD  #發退料套數檔
          sfdbent LIKE sfdb_t.sfdbent, #企業編號
          sfdbsite LIKE sfdb_t.sfdbsite, #營運據點
          sfdbdocno LIKE sfdb_t.sfdbdocno, #發退料單號
          sfdb001 LIKE sfdb_t.sfdb001, #工單單號
          sfdb002 LIKE sfdb_t.sfdb002, #Run Card
          sfdb003 LIKE sfdb_t.sfdb003, #部位
          sfdb004 LIKE sfdb_t.sfdb004, #作業
          sfdb005 LIKE sfdb_t.sfdb005, #作業序
          sfdb006 LIKE sfdb_t.sfdb006, #預計套數
          sfdb007 LIKE sfdb_t.sfdb007, #實際套數
          sfdb008 LIKE sfdb_t.sfdb008, #正負
          sfdbud001 LIKE sfdb_t.sfdbud001, #自定義欄位(文字)001
          sfdbud002 LIKE sfdb_t.sfdbud002, #自定義欄位(文字)002
          sfdbud003 LIKE sfdb_t.sfdbud003, #自定義欄位(文字)003
          sfdbud004 LIKE sfdb_t.sfdbud004, #自定義欄位(文字)004
          sfdbud005 LIKE sfdb_t.sfdbud005, #自定義欄位(文字)005
          sfdbud006 LIKE sfdb_t.sfdbud006, #自定義欄位(文字)006
          sfdbud007 LIKE sfdb_t.sfdbud007, #自定義欄位(文字)007
          sfdbud008 LIKE sfdb_t.sfdbud008, #自定義欄位(文字)008
          sfdbud009 LIKE sfdb_t.sfdbud009, #自定義欄位(文字)009
          sfdbud010 LIKE sfdb_t.sfdbud010, #自定義欄位(文字)010
          sfdbud011 LIKE sfdb_t.sfdbud011, #自定義欄位(數字)011
          sfdbud012 LIKE sfdb_t.sfdbud012, #自定義欄位(數字)012
          sfdbud013 LIKE sfdb_t.sfdbud013, #自定義欄位(數字)013
          sfdbud014 LIKE sfdb_t.sfdbud014, #自定義欄位(數字)014
          sfdbud015 LIKE sfdb_t.sfdbud015, #自定義欄位(數字)015
          sfdbud016 LIKE sfdb_t.sfdbud016, #自定義欄位(數字)016
          sfdbud017 LIKE sfdb_t.sfdbud017, #自定義欄位(數字)017
          sfdbud018 LIKE sfdb_t.sfdbud018, #自定義欄位(數字)018
          sfdbud019 LIKE sfdb_t.sfdbud019, #自定義欄位(數字)019
          sfdbud020 LIKE sfdb_t.sfdbud020, #自定義欄位(數字)020
          sfdbud021 LIKE sfdb_t.sfdbud021, #自定義欄位(日期時間)021
          sfdbud022 LIKE sfdb_t.sfdbud022, #自定義欄位(日期時間)022
          sfdbud023 LIKE sfdb_t.sfdbud023, #自定義欄位(日期時間)023
          sfdbud024 LIKE sfdb_t.sfdbud024, #自定義欄位(日期時間)024
          sfdbud025 LIKE sfdb_t.sfdbud025, #自定義欄位(日期時間)025
          sfdbud026 LIKE sfdb_t.sfdbud026, #自定義欄位(日期時間)026
          sfdbud027 LIKE sfdb_t.sfdbud027, #自定義欄位(日期時間)027
          sfdbud028 LIKE sfdb_t.sfdbud028, #自定義欄位(日期時間)028
          sfdbud029 LIKE sfdb_t.sfdbud029, #自定義欄位(日期時間)029
          sfdbud030 LIKE sfdb_t.sfdbud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#42-e
   DEFINE l_sfdb001     LIKE sfdb_t.sfdb001  #工单
   DEFINE l_sfdb007     LIKE sfdb_t.sfdb007  #套数
   DEFINE l_sfaa012     LIKE sfaa_t.sfaa012  #生產數量
   DEFINE l_sfaa049     LIKE sfaa_t.sfaa049  #已發料套數
   DEFINE l_sfaa050     LIKE sfaa_t.sfaa050  #已入庫合格量
   DEFINE l_sfdc001     LIKE sfdc_t.sfdc001
   DEFINE l_sfdc002     LIKE sfdc_t.sfdc002
   DEFINE l_sfdc003     LIKE sfdc_t.sfdc003
   DEFINE l_sfdc004     LIKE sfdc_t.sfdc004
   DEFINE l_sfba010     LIKE sfba_t.sfba010
   DEFINE l_sfba011     LIKE sfba_t.sfba011
   DEFINE l_sfba013     LIKE sfba_t.sfba013
   DEFINE l_sfba016     LIKE sfba_t.sfba016
   DEFINE l_sfdc008     LIKE sfdc_t.sfdc008

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #sflb工單挪料記錄套數單身檔
   LET l_sql = " SELECT sfdb001,sfdb007,sfaa012,sfaa049,sfaa050 ",
               "   FROM sfdb_t,sfaa_t ",
               "  WHERE sfdb001 = sfaadocno AND sfdbsite = sfaasite AND sfdbent = sfaaent ",
               "    AND sfdbent = ",g_enterprise," AND sfdbdocno=?"
   PREPARE asfp360_04_gen_sflb_p1 FROM l_sql
   DECLARE asfp360_04_gen_sflb_c1 CURSOR FOR asfp360_04_gen_sflb_p1

   #sfle工單挪料記錄明細單身檔（有套数单身）
   LET l_sql = " SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfba010,sfba011,sfba013,sfba016,sfdc008 ",
               "   FROM sfdc_t,sfba_t ",
               "  WHERE sfdc001 = sfbadocno AND sfdc002 = sfbaseq AND sfdc003 = sfbaseq1 ",
               "    AND sfdcsite = sfbasite AND sfdcent = sfbaent ",
               "    AND sfdcent = ",g_enterprise," AND sfdcdocno=? ",
               "    AND sfdc001 = ? "  #工单
   PREPARE asfp360_04_gen_sflb_p2 FROM l_sql
   DECLARE asfp360_04_gen_sflb_c2 CURSOR FOR asfp360_04_gen_sflb_p2

   #sfle工單挪料記錄明細單身檔（无套数单身）
   LET l_sql = " SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfba010,sfba011,sfba013,sfba016,sfdc008 ",
               "   FROM sfdc_t,sfba_t ",
               "  WHERE sfdc001 = sfbadocno AND sfdc002 = sfbaseq AND sfdc003 = sfbaseq1 ",
               "    AND sfdcsite = sfbasite AND sfdcent = sfbaent ",
               "    AND sfdcent = ",g_enterprise," AND sfdcdocno=? "
   PREPARE asfp360_04_gen_sflb_p3 FROM l_sql
   DECLARE asfp360_04_gen_sflb_c3 CURSOR FOR asfp360_04_gen_sflb_p3
   
   #工單挪料記錄套數單身檔
   IF g_asfp360_02_m.type = '1' THEN
      #sflc工單挪料記錄套數單身檔（來源）
      LET l_sflcseq = 0
      FOREACH asfp360_04_gen_sflb_c1 USING g_asfp360_04_m2.return_no
                                     INTO l_sfdb001,l_sfdb007,l_sfaa012,l_sfaa049,l_sfaa050
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp360_04_gen_sflb_c1"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         LET l_sflcseq = l_sflcseq + 1
         INITIALIZE l_sflc.* TO NULL
         LET l_sflc.sflcent   = g_enterprise  #企業編號
         LET l_sflc.sflcsite  = g_site        #營運據點
         LET l_sflc.sflcdocno = g_asfp360_04_m2.sfladocno #挪料序號
         LET l_sflc.sflcseq   = l_sflcseq #項次
         LET l_sflc.sflc001   = l_sfdb001 #工單單號
         LET l_sflc.sflc002   = l_sfaa012 #生產數量
         LET l_sflc.sflc003   = l_sfaa049 #已發套數
         LET l_sflc.sflc004   = l_sfaa050 #已入庫量
         LET l_sflc.sflc005   = l_sfdb007 #撥出套數
         #161109-00085#42-s
#         LET l_sflc.sflcud001 = ''  #自定義欄位(文字)001
#         LET l_sflc.sflcud002 = ''  #自定義欄位(文字)002
#         LET l_sflc.sflcud003 = ''  #自定義欄位(文字)003
#         LET l_sflc.sflcud004 = ''  #自定義欄位(文字)004
#         LET l_sflc.sflcud005 = ''  #自定義欄位(文字)005
#         LET l_sflc.sflcud006 = ''  #自定義欄位(文字)006
#         LET l_sflc.sflcud007 = ''  #自定義欄位(文字)007
#         LET l_sflc.sflcud008 = ''  #自定義欄位(文字)008
#         LET l_sflc.sflcud009 = ''  #自定義欄位(文字)009
#         LET l_sflc.sflcud010 = ''  #自定義欄位(文字)010
#         LET l_sflc.sflcud011 = ''  #自定義欄位(數字)011
#         LET l_sflc.sflcud012 = ''  #自定義欄位(數字)012
#         LET l_sflc.sflcud013 = ''  #自定義欄位(數字)013
#         LET l_sflc.sflcud014 = ''  #自定義欄位(數字)014
#         LET l_sflc.sflcud015 = ''  #自定義欄位(數字)015
#         LET l_sflc.sflcud016 = ''  #自定義欄位(數字)016
#         LET l_sflc.sflcud017 = ''  #自定義欄位(數字)017
#         LET l_sflc.sflcud018 = ''  #自定義欄位(數字)018
#         LET l_sflc.sflcud019 = ''  #自定義欄位(數字)019
#         LET l_sflc.sflcud020 = ''  #自定義欄位(數字)020
#         LET l_sflc.sflcud021 = ''  #自定義欄位(日期時間)021
#         LET l_sflc.sflcud022 = ''  #自定義欄位(日期時間)022
#         LET l_sflc.sflcud023 = ''  #自定義欄位(日期時間)023
#         LET l_sflc.sflcud024 = ''  #自定義欄位(日期時間)024
#         LET l_sflc.sflcud025 = ''  #自定義欄位(日期時間)025
#         LET l_sflc.sflcud026 = ''  #自定義欄位(日期時間)026
#         LET l_sflc.sflcud027 = ''  #自定義欄位(日期時間)027
#         LET l_sflc.sflcud028 = ''  #自定義欄位(日期時間)028
#         LET l_sflc.sflcud029 = ''  #自定義欄位(日期時間)029
#         LET l_sflc.sflcud030 = ''  #自定義欄位(日期時間)030
         #161109-00085#42-e
         #161109-00085#42-s
         #INSERT INTO sflc_t VALUES(l_sflc.*)         
         INSERT INTO sflc_t( sflcent,sflcsite,sflcdocno,sflcseq,sflc001,
                             sflc002,sflc003,sflc004,sflc005,sflcud001,
                             sflcud002,sflcud003,sflcud004,sflcud005,sflcud006,
                             sflcud007,sflcud008,sflcud009,sflcud010,sflcud011,
                             sflcud012,sflcud013,sflcud014,sflcud015,sflcud016,
                             sflcud017,sflcud018,sflcud019,sflcud020,sflcud021,
                             sflcud022,sflcud023,sflcud024,sflcud025,sflcud026,
                             sflcud027,sflcud028,sflcud029,sflcud030 )
            VALUES(l_sflc.sflcent,l_sflc.sflcsite,l_sflc.sflcdocno,l_sflc.sflcseq,l_sflc.sflc001,
                   l_sflc.sflc002,l_sflc.sflc003,l_sflc.sflc004,l_sflc.sflc005,l_sflc.sflcud001,
                   l_sflc.sflcud002,l_sflc.sflcud003,l_sflc.sflcud004,l_sflc.sflcud005,l_sflc.sflcud006,
                   l_sflc.sflcud007,l_sflc.sflcud008,l_sflc.sflcud009,l_sflc.sflcud010,l_sflc.sflcud011,
                   l_sflc.sflcud012,l_sflc.sflcud013,l_sflc.sflcud014,l_sflc.sflcud015,l_sflc.sflcud016,
                   l_sflc.sflcud017,l_sflc.sflcud018,l_sflc.sflcud019,l_sflc.sflcud020,l_sflc.sflcud021,
                   l_sflc.sflcud022,l_sflc.sflcud023,l_sflc.sflcud024,l_sflc.sflcud025,l_sflc.sflcud026,
                   l_sflc.sflcud027,l_sflc.sflcud028,l_sflc.sflcud029,l_sflc.sflcud030)
         #161109-00085#42-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins sflc_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF

         #sfle工單挪料記錄明細單身檔（來源）
         LET l_sfleseq1 = 0
         FOREACH asfp360_04_gen_sflb_c2 USING g_asfp360_04_m2.return_no,l_sflc.sflc001
                                        INTO l_sfdc001,l_sfdc002,l_sfdc003,l_sfdc004,
                                             l_sfba010,l_sfba011,l_sfba013,l_sfba016,
                                             l_sfdc008
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:asfp360_04_gen_sflb_c2"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            
            LET l_sfleseq1 = l_sfleseq1 + 1
            INITIALIZE l_sfle.* TO NULL
            LET l_sfle.sfleent   = g_enterprise  #企業編號
            LET l_sfle.sflesite  = g_site        #營運據點
            LET l_sfle.sfledocno = g_asfp360_04_m2.sfladocno #挪料序號
            LET l_sfle.sfleseq   = l_sflcseq  #項次
            LET l_sfle.sfleseq1  = l_sfleseq1 #項序
            LET l_sfle.sfle001   = l_sfdc001  #工單單號
            LET l_sfle.sfle002   = l_sfdc002  #工單項次
            LET l_sfle.sfle003   = l_sfdc003  #工單項序
            LET l_sfle.sfle004   = l_sfdc004  #發料料號
            LET l_sfle.sfle005   = l_sfba010  #標準QPA分子
            LET l_sfle.sfle006   = l_sfba011  #標準QPA分母
            LET l_sfle.sfle007   = l_sfba013  #應發數量
            LET l_sfle.sfle008   = l_sfba016  #已發數量
            LET l_sfle.sfle009   = l_sfdc008  #撥出數量
       
            LET l_sfle.sfleud001 = '' #自定義欄位(文字)001
            LET l_sfle.sfleud002 = '' #自定義欄位(文字)002
            LET l_sfle.sfleud003 = '' #自定義欄位(文字)003
            LET l_sfle.sfleud004 = '' #自定義欄位(文字)004
            LET l_sfle.sfleud005 = '' #自定義欄位(文字)005
            LET l_sfle.sfleud006 = '' #自定義欄位(文字)006
            LET l_sfle.sfleud007 = '' #自定義欄位(文字)007
            LET l_sfle.sfleud008 = '' #自定義欄位(文字)008
            LET l_sfle.sfleud009 = '' #自定義欄位(文字)009
            LET l_sfle.sfleud010 = '' #自定義欄位(文字)010
            LET l_sfle.sfleud011 = '' #自定義欄位(數字)011
            LET l_sfle.sfleud012 = '' #自定義欄位(數字)012
            LET l_sfle.sfleud013 = '' #自定義欄位(數字)013
            LET l_sfle.sfleud014 = '' #自定義欄位(數字)014
            LET l_sfle.sfleud015 = '' #自定義欄位(數字)015
            LET l_sfle.sfleud016 = '' #自定義欄位(數字)016
            LET l_sfle.sfleud017 = '' #自定義欄位(數字)017
            LET l_sfle.sfleud018 = '' #自定義欄位(數字)018
            LET l_sfle.sfleud019 = '' #自定義欄位(數字)019
            LET l_sfle.sfleud020 = '' #自定義欄位(數字)020
            LET l_sfle.sfleud021 = '' #自定義欄位(日期時間)021
            LET l_sfle.sfleud022 = '' #自定義欄位(日期時間)022
            LET l_sfle.sfleud023 = '' #自定義欄位(日期時間)023
            LET l_sfle.sfleud024 = '' #自定義欄位(日期時間)024
            LET l_sfle.sfleud025 = '' #自定義欄位(日期時間)025
            LET l_sfle.sfleud026 = '' #自定義欄位(日期時間)026
            LET l_sfle.sfleud027 = '' #自定義欄位(日期時間)027
            LET l_sfle.sfleud028 = '' #自定義欄位(日期時間)028
            LET l_sfle.sfleud029 = '' #自定義欄位(日期時間)029
            LET l_sfle.sfleud030 = '' #自定義欄位(日期時間)030

            #161109-00085#42-s
            #INSERT INTO sfle_t VALUES(l_sfle.*)
            INSERT INTO sfle_t( sfleent,sflesite,sfledocno,sfleseq,sfleseq1,
                                sfle001,sfle002,sfle003,sfle004,sfle005,
                                sfle006,sfle007,sfle008,sfle009,sfleud001,
                                sfleud002,sfleud003,sfleud004,sfleud005,sfleud006,
                                sfleud007,sfleud008,sfleud009,sfleud010,sfleud011,
                                sfleud012,sfleud013,sfleud014,sfleud015,sfleud016,
                                sfleud017,sfleud018,sfleud019,sfleud020,sfleud021,
                                sfleud022,sfleud023,sfleud024,sfleud025,sfleud026,
                                sfleud027,sfleud028,sfleud029,sfleud030 ) 
               VALUES (l_sfle.sfleent,l_sfle.sflesite,l_sfle.sfledocno,l_sfle.sfleseq,l_sfle.sfleseq1,
                       l_sfle.sfle001,l_sfle.sfle002,l_sfle.sfle003,l_sfle.sfle004,l_sfle.sfle005,
                       l_sfle.sfle006,l_sfle.sfle007,l_sfle.sfle008,l_sfle.sfle009,l_sfle.sfleud001,
                       l_sfle.sfleud002,l_sfle.sfleud003,l_sfle.sfleud004,l_sfle.sfleud005,l_sfle.sfleud006,
                       l_sfle.sfleud007,l_sfle.sfleud008,l_sfle.sfleud009,l_sfle.sfleud010,l_sfle.sfleud011,
                       l_sfle.sfleud012,l_sfle.sfleud013,l_sfle.sfleud014,l_sfle.sfleud015,l_sfle.sfleud016,
                       l_sfle.sfleud017,l_sfle.sfleud018,l_sfle.sfleud019,l_sfle.sfleud020,l_sfle.sfleud021,
                       l_sfle.sfleud022,l_sfle.sfleud023,l_sfle.sfleud024,l_sfle.sfleud025,l_sfle.sfleud026,
                       l_sfle.sfleud027,l_sfle.sfleud028,l_sfle.sfleud029,l_sfle.sfleud030)
            #161109-00085#42-e
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins sfle_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END FOREACH
         CLOSE asfp360_04_gen_sflb_c2
         FREE asfp360_04_gen_sflb_p2

      END FOREACH
      CLOSE asfp360_04_gen_sflb_c1
      FREE asfp360_04_gen_sflb_p1
      
      #sflb工單挪料記錄套數單身檔（目的）
      LET l_sflbseq = 0
      FOREACH asfp360_04_gen_sflb_c1 USING g_asfp360_04_m2.send_no
                                     INTO l_sfdb001,l_sfdb007,l_sfaa012,l_sfaa049,l_sfaa050
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp360_04_gen_sflb_c1"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF

         LET l_sflbseq = l_sflbseq + 1
         INITIALIZE l_sflb.* TO NULL
         LET l_sflb.sflbent   = g_enterprise #企業編號
         LET l_sflb.sflbsite  = g_site       #營運據點
         LET l_sflb.sflbdocno = g_asfp360_04_m2.sfladocno #挪料序號
         LET l_sflb.sflbseq   = l_sflbseq #項次
         LET l_sflb.sflb001   = l_sfdb001 #工單單號
         LET l_sflb.sflb002   = l_sfaa012 #生產數量
         LET l_sflb.sflb003   = l_sfaa049 #已發套數
         LET l_sflb.sflb004   = l_sfaa050 #已入庫量
         LET l_sflb.sflb005   = l_sfdb007 #撥入套數
         LET l_sflb.sflbud001 = '' #自定義欄位(文字)001
         LET l_sflb.sflbud002 = '' #自定義欄位(文字)002
         LET l_sflb.sflbud003 = '' #自定義欄位(文字)003
         LET l_sflb.sflbud004 = '' #自定義欄位(文字)004
         LET l_sflb.sflbud005 = '' #自定義欄位(文字)005
         LET l_sflb.sflbud006 = '' #自定義欄位(文字)006
         LET l_sflb.sflbud007 = '' #自定義欄位(文字)007
         LET l_sflb.sflbud008 = '' #自定義欄位(文字)008
         LET l_sflb.sflbud009 = '' #自定義欄位(文字)009
         LET l_sflb.sflbud010 = '' #自定義欄位(文字)010
         LET l_sflb.sflbud011 = '' #自定義欄位(數字)011
         LET l_sflb.sflbud012 = '' #自定義欄位(數字)012
         LET l_sflb.sflbud013 = '' #自定義欄位(數字)013
         LET l_sflb.sflbud014 = '' #自定義欄位(數字)014
         LET l_sflb.sflbud015 = '' #自定義欄位(數字)015
         LET l_sflb.sflbud016 = '' #自定義欄位(數字)016
         LET l_sflb.sflbud017 = '' #自定義欄位(數字)017
         LET l_sflb.sflbud018 = '' #自定義欄位(數字)018
         LET l_sflb.sflbud019 = '' #自定義欄位(數字)019
         LET l_sflb.sflbud020 = '' #自定義欄位(數字)020
         LET l_sflb.sflbud021 = '' #自定義欄位(日期時間)021
         LET l_sflb.sflbud022 = '' #自定義欄位(日期時間)022
         LET l_sflb.sflbud023 = '' #自定義欄位(日期時間)023
         LET l_sflb.sflbud024 = '' #自定義欄位(日期時間)024
         LET l_sflb.sflbud025 = '' #自定義欄位(日期時間)025
         LET l_sflb.sflbud026 = '' #自定義欄位(日期時間)026
         LET l_sflb.sflbud027 = '' #自定義欄位(日期時間)027
         LET l_sflb.sflbud028 = '' #自定義欄位(日期時間)028
         LET l_sflb.sflbud029 = '' #自定義欄位(日期時間)029
         LET l_sflb.sflbud030 = '' #自定義欄位(日期時間)030

         #161109-00085#42-s
         #INSERT INTO sflb_t VALUES(l_sflb.*)
         INSERT INTO sflb_t( sflbent,sflbsite,sflbdocno,sflbseq,sflb001,
                             sflb002,sflb003,sflb004,sflb005,sflbud001,
                             sflbud002,sflbud003,sflbud004,sflbud005,sflbud006,
                             sflbud007,sflbud008,sflbud009,sflbud010,sflbud011,
                             sflbud012,sflbud013,sflbud014,sflbud015,sflbud016,
                             sflbud017,sflbud018,sflbud019,sflbud020,sflbud021,
                             sflbud022,sflbud023,sflbud024,sflbud025,sflbud026,
                             sflbud027,sflbud028,sflbud029,sflbud030 ) 
            VALUES(l_sflb.sflbent,l_sflb.sflbsite,l_sflb.sflbdocno,l_sflb.sflbseq,l_sflb.sflb001,
                   l_sflb.sflb002,l_sflb.sflb003,l_sflb.sflb004,l_sflb.sflb005,l_sflb.sflbud001,
                   l_sflb.sflbud002,l_sflb.sflbud003,l_sflb.sflbud004,l_sflb.sflbud005,l_sflb.sflbud006,
                   l_sflb.sflbud007,l_sflb.sflbud008,l_sflb.sflbud009,l_sflb.sflbud010,l_sflb.sflbud011,
                   l_sflb.sflbud012,l_sflb.sflbud013,l_sflb.sflbud014,l_sflb.sflbud015,l_sflb.sflbud016,
                   l_sflb.sflbud017,l_sflb.sflbud018,l_sflb.sflbud019,l_sflb.sflbud020,l_sflb.sflbud021,
                   l_sflb.sflbud022,l_sflb.sflbud023,l_sflb.sflbud024,l_sflb.sflbud025,l_sflb.sflbud026,
                   l_sflb.sflbud027,l_sflb.sflbud028,l_sflb.sflbud029,l_sflb.sflbud030 )         
         #161109-00085#42-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins sflb_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF

         #sfld工單挪料記錄明細單身檔（目的）
         LET l_sfldseq1 = 0
         FOREACH asfp360_04_gen_sflb_c2 USING g_asfp360_04_m2.send_no,l_sflb.sflb001
                                        INTO l_sfdc001,l_sfdc002,l_sfdc003,l_sfdc004,
                                             l_sfba010,l_sfba011,l_sfba013,l_sfba016,
                                             l_sfdc008
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:asfp360_04_gen_sflb_c2"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF

            LET l_sfldseq1 = l_sfldseq1 + 1
            INITIALIZE l_sfld.* TO NULL
            LET l_sfld.sfldent   = g_enterprise #企業編號
            LET l_sfld.sfldsite  = g_site       #營運據點
            LET l_sfld.sflddocno = g_asfp360_04_m2.sfladocno #挪料序號
            LET l_sfld.sfldseq   = l_sflbseq #項次
            LET l_sfld.sfldseq1  = l_sfldseq1 #項序
            LET l_sfld.sfld001   = l_sfdc001  #工單單號
            LET l_sfld.sfld002   = l_sfdc002  #工單項次
            LET l_sfld.sfld003   = l_sfdc003  #工單項序
            LET l_sfld.sfld004   = l_sfdc004  #發料料號
            LET l_sfld.sfld005   = l_sfba010  #標準QPA分子
            LET l_sfld.sfld006   = l_sfba011  #標準QPA分母
            LET l_sfld.sfld007   = l_sfba013  #應發數量
            LET l_sfld.sfld008   = l_sfba016  #已發數量
            LET l_sfld.sfld009   = l_sfdc008  #撥入數量

            LET l_sfld.sfldud001 = ''  #自定義欄位(文字)001
            LET l_sfld.sfldud002 = ''  #自定義欄位(文字)002
            LET l_sfld.sfldud003 = ''  #自定義欄位(文字)003
            LET l_sfld.sfldud004 = ''  #自定義欄位(文字)004
            LET l_sfld.sfldud005 = ''  #自定義欄位(文字)005
            LET l_sfld.sfldud006 = ''  #自定義欄位(文字)006
            LET l_sfld.sfldud007 = ''  #自定義欄位(文字)007
            LET l_sfld.sfldud008 = ''  #自定義欄位(文字)008
            LET l_sfld.sfldud009 = ''  #自定義欄位(文字)009
            LET l_sfld.sfldud010 = ''  #自定義欄位(文字)010
            LET l_sfld.sfldud011 = ''  #自定義欄位(數字)011
            LET l_sfld.sfldud012 = ''  #自定義欄位(數字)012
            LET l_sfld.sfldud013 = ''  #自定義欄位(數字)013
            LET l_sfld.sfldud014 = ''  #自定義欄位(數字)014
            LET l_sfld.sfldud015 = ''  #自定義欄位(數字)015
            LET l_sfld.sfldud016 = ''  #自定義欄位(數字)016
            LET l_sfld.sfldud017 = ''  #自定義欄位(數字)017
            LET l_sfld.sfldud018 = ''  #自定義欄位(數字)018
            LET l_sfld.sfldud019 = ''  #自定義欄位(數字)019
            LET l_sfld.sfldud020 = ''  #自定義欄位(數字)020
            LET l_sfld.sfldud021 = ''  #自定義欄位(日期時間)021
            LET l_sfld.sfldud022 = ''  #自定義欄位(日期時間)022
            LET l_sfld.sfldud023 = ''  #自定義欄位(日期時間)023
            LET l_sfld.sfldud024 = ''  #自定義欄位(日期時間)024
            LET l_sfld.sfldud025 = ''  #自定義欄位(日期時間)025
            LET l_sfld.sfldud026 = ''  #自定義欄位(日期時間)026
            LET l_sfld.sfldud027 = ''  #自定義欄位(日期時間)027
            LET l_sfld.sfldud028 = ''  #自定義欄位(日期時間)028
            LET l_sfld.sfldud029 = ''  #自定義欄位(日期時間)029
            LET l_sfld.sfldud030 = ''  #自定義欄位(日期時間)030

            #161109-00085#42-s
            #INSERT INTO sfld_t VALUES(l_sfld.*)
            INSERT INTO sfld_t ( sfldent,sfldsite,sflddocno,sfldseq,sfldseq1,
                                 sfld001,sfld002,sfld003,sfld004,sfld005,
                                 sfld006,sfld007,sfld008,sfld009,sfldud001,
                                 sfldud002,sfldud003,sfldud004,sfldud005,sfldud006,
                                 sfldud007,sfldud008,sfldud009,sfldud010,sfldud011,
                                 sfldud012,sfldud013,sfldud014,sfldud015,sfldud016,
                                 sfldud017,sfldud018,sfldud019,sfldud020,sfldud021,
                                 sfldud022,sfldud023,sfldud024,sfldud025,sfldud026,
                                 sfldud027,sfldud028,sfldud029,sfldud030 )
               VALUES(l_sfld.sfldent,l_sfld.sfldsite,l_sfld.sflddocno,l_sfld.sfldseq,l_sfld.sfldseq1,
                      l_sfld.sfld001,l_sfld.sfld002,l_sfld.sfld003,l_sfld.sfld004,l_sfld.sfld005,
                      l_sfld.sfld006,l_sfld.sfld007,l_sfld.sfld008,l_sfld.sfld009,l_sfld.sfldud001,
                      l_sfld.sfldud002,l_sfld.sfldud003,l_sfld.sfldud004,l_sfld.sfldud005,l_sfld.sfldud006,
                      l_sfld.sfldud007,l_sfld.sfldud008,l_sfld.sfldud009,l_sfld.sfldud010,l_sfld.sfldud011,
                      l_sfld.sfldud012,l_sfld.sfldud013,l_sfld.sfldud014,l_sfld.sfldud015,l_sfld.sfldud016,
                      l_sfld.sfldud017,l_sfld.sfldud018,l_sfld.sfldud019,l_sfld.sfldud020,l_sfld.sfldud021,
                      l_sfld.sfldud022,l_sfld.sfldud023,l_sfld.sfldud024,l_sfld.sfldud025,l_sfld.sfldud026,
                      l_sfld.sfldud027,l_sfld.sfldud028,l_sfld.sfldud029,l_sfld.sfldud030)
            #161109-00085#42-e
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins sfld_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END FOREACH
         CLOSE asfp360_04_gen_sflb_c2
         FREE asfp360_04_gen_sflb_p2
      END FOREACH
      CLOSE asfp360_04_gen_sflb_c1
      FREE asfp360_04_gen_sflb_p1
   ELSE  #单颗挪料
      #sfle工單挪料記錄明細單身檔（來源）
      LET l_sfleseq1 = 0
      FOREACH asfp360_04_gen_sflb_c3 USING g_asfp360_04_m2.return_no
                                     INTO l_sfdc001,l_sfdc002,l_sfdc003,l_sfdc004,
                                          l_sfba010,l_sfba011,l_sfba013,l_sfba016,
                                          l_sfdc008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp360_04_gen_sflb_c3"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF

         LET l_sfleseq1 = l_sfleseq1 + 1
         INITIALIZE l_sfle.* TO NULL
         LET l_sfle.sfleent   = g_enterprise  #企業編號
         LET l_sfle.sflesite  = g_site        #營運據點
         LET l_sfle.sfledocno = g_asfp360_04_m2.sfladocno #挪料序號
         LET l_sfle.sfleseq   = 0 #項次
         LET l_sfle.sfleseq1  = l_sfleseq1 #項序
         LET l_sfle.sfle001   = l_sfdc001  #工單單號
         LET l_sfle.sfle002   = l_sfdc002  #工單項次
         LET l_sfle.sfle003   = l_sfdc003  #工單項序
         LET l_sfle.sfle004   = l_sfdc004  #發料料號
         LET l_sfle.sfle005   = l_sfba010  #標準QPA分子
         LET l_sfle.sfle006   = l_sfba011  #標準QPA分母
         LET l_sfle.sfle007   = l_sfba013  #應發數量
         LET l_sfle.sfle008   = l_sfba016  #已發數量
         LET l_sfle.sfle009   = l_sfdc008  #撥出數量
         LET l_sfle.sfleud001 = '' #自定義欄位(文字)001
         LET l_sfle.sfleud002 = '' #自定義欄位(文字)002
         LET l_sfle.sfleud003 = '' #自定義欄位(文字)003
         LET l_sfle.sfleud004 = '' #自定義欄位(文字)004
         LET l_sfle.sfleud005 = '' #自定義欄位(文字)005
         LET l_sfle.sfleud006 = '' #自定義欄位(文字)006
         LET l_sfle.sfleud007 = '' #自定義欄位(文字)007
         LET l_sfle.sfleud008 = '' #自定義欄位(文字)008
         LET l_sfle.sfleud009 = '' #自定義欄位(文字)009
         LET l_sfle.sfleud010 = '' #自定義欄位(文字)010
         LET l_sfle.sfleud011 = '' #自定義欄位(數字)011
         LET l_sfle.sfleud012 = '' #自定義欄位(數字)012
         LET l_sfle.sfleud013 = '' #自定義欄位(數字)013
         LET l_sfle.sfleud014 = '' #自定義欄位(數字)014
         LET l_sfle.sfleud015 = '' #自定義欄位(數字)015
         LET l_sfle.sfleud016 = '' #自定義欄位(數字)016
         LET l_sfle.sfleud017 = '' #自定義欄位(數字)017
         LET l_sfle.sfleud018 = '' #自定義欄位(數字)018
         LET l_sfle.sfleud019 = '' #自定義欄位(數字)019
         LET l_sfle.sfleud020 = '' #自定義欄位(數字)020
         LET l_sfle.sfleud021 = '' #自定義欄位(日期時間)021
         LET l_sfle.sfleud022 = '' #自定義欄位(日期時間)022
         LET l_sfle.sfleud023 = '' #自定義欄位(日期時間)023
         LET l_sfle.sfleud024 = '' #自定義欄位(日期時間)024
         LET l_sfle.sfleud025 = '' #自定義欄位(日期時間)025
         LET l_sfle.sfleud026 = '' #自定義欄位(日期時間)026
         LET l_sfle.sfleud027 = '' #自定義欄位(日期時間)027
         LET l_sfle.sfleud028 = '' #自定義欄位(日期時間)028
         LET l_sfle.sfleud029 = '' #自定義欄位(日期時間)029
         LET l_sfle.sfleud030 = '' #自定義欄位(日期時間)030

         #161109-00085#42-s
         #INSERT INTO sfle_t VALUES(l_sfle.*)
         INSERT INTO sfle_t( sfleent,sflesite,sfledocno,sfleseq,sfleseq1,
                             sfle001,sfle002,sfle003,sfle004,sfle005,
                             sfle006,sfle007,sfle008,sfle009,sfleud001,
                             sfleud002,sfleud003,sfleud004,sfleud005,sfleud006,
                             sfleud007,sfleud008,sfleud009,sfleud010,sfleud011,
                             sfleud012,sfleud013,sfleud014,sfleud015,sfleud016,
                             sfleud017,sfleud018,sfleud019,sfleud020,sfleud021,
                             sfleud022,sfleud023,sfleud024,sfleud025,sfleud026,
                             sfleud027,sfleud028,sfleud029,sfleud030 ) 
            VALUES (l_sfle.sfleent,l_sfle.sflesite,l_sfle.sfledocno,l_sfle.sfleseq,l_sfle.sfleseq1,
                    l_sfle.sfle001,l_sfle.sfle002,l_sfle.sfle003,l_sfle.sfle004,l_sfle.sfle005,
                    l_sfle.sfle006,l_sfle.sfle007,l_sfle.sfle008,l_sfle.sfle009,l_sfle.sfleud001,
                    l_sfle.sfleud002,l_sfle.sfleud003,l_sfle.sfleud004,l_sfle.sfleud005,l_sfle.sfleud006,
                    l_sfle.sfleud007,l_sfle.sfleud008,l_sfle.sfleud009,l_sfle.sfleud010,l_sfle.sfleud011,
                    l_sfle.sfleud012,l_sfle.sfleud013,l_sfle.sfleud014,l_sfle.sfleud015,l_sfle.sfleud016,
                    l_sfle.sfleud017,l_sfle.sfleud018,l_sfle.sfleud019,l_sfle.sfleud020,l_sfle.sfleud021,
                    l_sfle.sfleud022,l_sfle.sfleud023,l_sfle.sfleud024,l_sfle.sfleud025,l_sfle.sfleud026,
                    l_sfle.sfleud027,l_sfle.sfleud028,l_sfle.sfleud029,l_sfle.sfleud030)
         #161109-00085#42-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins sfle_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END FOREACH
      CLOSE asfp360_04_gen_sflb_c3
      FREE asfp360_04_gen_sflb_p3

      #sfld工單挪料記錄明細單身檔（目的）
      LET l_sfldseq1 = 0
      FOREACH asfp360_04_gen_sflb_c3 USING g_asfp360_04_m2.send_no
                                     INTO l_sfdc001,l_sfdc002,l_sfdc003,l_sfdc004,
                                          l_sfba010,l_sfba011,l_sfba013,l_sfba016,
                                          l_sfdc008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp360_04_gen_sflb_c3"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF

         LET l_sfldseq1 = l_sfldseq1 + 1
         INITIALIZE l_sfld.* TO NULL
         LET l_sfld.sfldent   = g_enterprise #企業編號
         LET l_sfld.sfldsite  = g_site       #營運據點
         LET l_sfld.sflddocno = g_asfp360_04_m2.sfladocno #挪料序號
         LET l_sfld.sfldseq   = 0 #項次
         LET l_sfld.sfldseq1  = l_sfldseq1 #項序
         LET l_sfld.sfld001   = l_sfdc001  #工單單號
         LET l_sfld.sfld002   = l_sfdc002  #工單項次
         LET l_sfld.sfld003   = l_sfdc003  #工單項序
         LET l_sfld.sfld004   = l_sfdc004  #發料料號
         LET l_sfld.sfld005   = l_sfba010  #標準QPA分子
         LET l_sfld.sfld006   = l_sfba011  #標準QPA分母
         LET l_sfld.sfld007   = l_sfba013  #應發數量
         LET l_sfld.sfld008   = l_sfba016  #已發數量
         LET l_sfld.sfld009   = l_sfdc008  #撥入數量

         LET l_sfld.sfldud001 = ''  #自定義欄位(文字)001
         LET l_sfld.sfldud002 = ''  #自定義欄位(文字)002
         LET l_sfld.sfldud003 = ''  #自定義欄位(文字)003
         LET l_sfld.sfldud004 = ''  #自定義欄位(文字)004
         LET l_sfld.sfldud005 = ''  #自定義欄位(文字)005
         LET l_sfld.sfldud006 = ''  #自定義欄位(文字)006
         LET l_sfld.sfldud007 = ''  #自定義欄位(文字)007
         LET l_sfld.sfldud008 = ''  #自定義欄位(文字)008
         LET l_sfld.sfldud009 = ''  #自定義欄位(文字)009
         LET l_sfld.sfldud010 = ''  #自定義欄位(文字)010
         LET l_sfld.sfldud011 = ''  #自定義欄位(數字)011
         LET l_sfld.sfldud012 = ''  #自定義欄位(數字)012
         LET l_sfld.sfldud013 = ''  #自定義欄位(數字)013
         LET l_sfld.sfldud014 = ''  #自定義欄位(數字)014
         LET l_sfld.sfldud015 = ''  #自定義欄位(數字)015
         LET l_sfld.sfldud016 = ''  #自定義欄位(數字)016
         LET l_sfld.sfldud017 = ''  #自定義欄位(數字)017
         LET l_sfld.sfldud018 = ''  #自定義欄位(數字)018
         LET l_sfld.sfldud019 = ''  #自定義欄位(數字)019
         LET l_sfld.sfldud020 = ''  #自定義欄位(數字)020
         LET l_sfld.sfldud021 = ''  #自定義欄位(日期時間)021
         LET l_sfld.sfldud022 = ''  #自定義欄位(日期時間)022
         LET l_sfld.sfldud023 = ''  #自定義欄位(日期時間)023
         LET l_sfld.sfldud024 = ''  #自定義欄位(日期時間)024
         LET l_sfld.sfldud025 = ''  #自定義欄位(日期時間)025
         LET l_sfld.sfldud026 = ''  #自定義欄位(日期時間)026
         LET l_sfld.sfldud027 = ''  #自定義欄位(日期時間)027
         LET l_sfld.sfldud028 = ''  #自定義欄位(日期時間)028
         LET l_sfld.sfldud029 = ''  #自定義欄位(日期時間)029
         LET l_sfld.sfldud030 = ''  #自定義欄位(日期時間)030

         #161109-00085#42-s
         #INSERT INTO sfld_t VALUES(l_sfld.*)
         INSERT INTO sfld_t ( sfldent,sfldsite,sflddocno,sfldseq,sfldseq1,
                              sfld001,sfld002,sfld003,sfld004,sfld005,
                              sfld006,sfld007,sfld008,sfld009,sfldud001,
                              sfldud002,sfldud003,sfldud004,sfldud005,sfldud006,
                              sfldud007,sfldud008,sfldud009,sfldud010,sfldud011,
                              sfldud012,sfldud013,sfldud014,sfldud015,sfldud016,
                              sfldud017,sfldud018,sfldud019,sfldud020,sfldud021,
                              sfldud022,sfldud023,sfldud024,sfldud025,sfldud026,
                              sfldud027,sfldud028,sfldud029,sfldud030 )
            VALUES(l_sfld.sfldent,l_sfld.sfldsite,l_sfld.sflddocno,l_sfld.sfldseq,l_sfld.sfldseq1,
                   l_sfld.sfld001,l_sfld.sfld002,l_sfld.sfld003,l_sfld.sfld004,l_sfld.sfld005,
                   l_sfld.sfld006,l_sfld.sfld007,l_sfld.sfld008,l_sfld.sfld009,l_sfld.sfldud001,
                   l_sfld.sfldud002,l_sfld.sfldud003,l_sfld.sfldud004,l_sfld.sfldud005,l_sfld.sfldud006,
                   l_sfld.sfldud007,l_sfld.sfldud008,l_sfld.sfldud009,l_sfld.sfldud010,l_sfld.sfldud011,
                   l_sfld.sfldud012,l_sfld.sfldud013,l_sfld.sfldud014,l_sfld.sfldud015,l_sfld.sfldud016,
                   l_sfld.sfldud017,l_sfld.sfldud018,l_sfld.sfldud019,l_sfld.sfldud020,l_sfld.sfldud021,
                   l_sfld.sfldud022,l_sfld.sfldud023,l_sfld.sfldud024,l_sfld.sfldud025,l_sfld.sfldud026,
                   l_sfld.sfldud027,l_sfld.sfldud028,l_sfld.sfldud029,l_sfld.sfldud030)
         #161109-00085#42-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins sfld_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END FOREACH
      CLOSE asfp360_04_gen_sflb_c3
      FREE asfp360_04_gen_sflb_p3
   END IF
   
   RETURN r_success
END FUNCTION

#自动编码-挪料序号
#4位年+2位月+4位流水
PUBLIC FUNCTION asfp360_04_get_sfladocno(p_sfladocdt)
DEFINE p_sfladocdt   LIKE sfla_t.sfladocdt  #挪料日期
DEFINE r_success     LIKE type_t.num5
DEFINE r_sfladocno   LIKE sfla_t.sfladocno
#DEFINE l_yy          LIKE type_t.chr4  #年
#DEFINE l_mm          LIKE type_t.chr2  #月
DEFINE l_ym          LIKE type_t.chr6  #年月
#DEFINE l_no          LIKE type_t.chr4  #流水码
DEFINE l_num         LIKE type_t.num5  #流水码

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #LET l_yy = YEAR(p_sfladocdt)
   #LET l_mm = MONTH(p_sfladocdt)
   LET l_ym = YEAR(p_sfladocdt) USING "####",MONTH(p_sfladocdt) USING "&&"

   SELECT MAX(sfladocno) INTO r_sfladocno FROM sfla_t
    WHERE sflaent  = g_enterprise
      AND sflasite = g_site
      AND substr(sfladocno,1,6)= l_ym
   IF cl_null(r_sfladocno)THEN
      LET l_num = 0
   ELSE
      LET l_num = r_sfladocno[7,10]
   END IF
   IF l_num = 9999 THEN
      #流水码不可超过9999,请联系信管人员放宽流水码长度
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00437'
      LET g_errparam.extend = 'ins sfla_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      LET r_sfladocno = ''
      RETURN r_success,r_sfladocno
   END IF

   LET l_num = l_num + 1
   LET r_sfladocno = l_ym,l_num USING "&&&&"

   RETURN r_success,r_sfladocno
END FUNCTION

 
{</section>}
 
