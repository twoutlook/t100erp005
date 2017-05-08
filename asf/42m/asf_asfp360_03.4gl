#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp360_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2014-10-09 14:10:21), PR版次:0011(2017-01-06 14:52:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000102
#+ Filename...: asfp360_03
#+ Description: 來源工單挑選1-成套挑選
#+ Creator....: 00768(2014-05-16 14:36:22)
#+ Modifier...: 00768 -SD/PR- 00700
 
{</section>}
 
{<section id="asfp360_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#150101 单位转换率改写
#150119 对数量做单位取位
#160425-00019    2016/05/20 By Whitney      齊料套數不及時計算改抓sfaa071
#160727-00019#17 2016/08/04 By 08734        临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01,asfp360_03_temp3 ——> asfp360_tmp02,asfp360_03_temp4 ——> asfp360_tmp03
#161013-00051#1  2016/10/18 By shiun        整批調整據點組織開窗
#170104-00066#1  2017/01/04  By Rainy       筆數相關變數由num5放大至num10
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
 
{<section id="asfp360_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="asfp360_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE g_error_show          LIKE type_t.num5

DEFINE l_ac                  LIKE type_t.num10                                   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_detail_idx1         LIKE type_t.num10              #單身1目前所在筆數    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_detail_idx3         LIKE type_t.num10              #單身3目前所在筆數    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_detail_idx4         LIKE type_t.num10              #單身4目前所在筆數    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_detail_idx5         LIKE type_t.num10              #單身5目前所在筆數    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE g_current_page        LIKE type_t.num10               #170104-00066#1 num5->num10  17/01/05 mod by rainy 
#end add-point
 
{</section>}
 
{<section id="asfp360_03.other_dialog" >}

DIALOG asfp360_03_construct()
   DEFINE l_success    LIKE type_t.num5
   
   CONSTRUCT BY NAME g_wc_03 ON sfaadocno,sfaa010,sfaa002,sfaa017,sfaa018

      BEFORE CONSTRUCT

      AFTER CONSTRUCT

      ON ACTION controlp INFIELD sfaadocno  #工單單號
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " sfaasite = '",g_site,"' AND sfaastus='F' AND sfaa047 IS NULL"
         CALL q_sfaadocno_1()                     #呼叫開窗
         DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
         NEXT FIELD sfaadocno                     #返回原欄位

      ON ACTION controlp INFIELD sfaa010  #生產料號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaa001_9()                     #呼叫開窗
         DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
         NEXT FIELD sfaa010                     #返回原欄位
      
      ON ACTION controlp INFIELD sfaa002  #生管員
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                      #呼叫開窗
         DISPLAY g_qryparam.return1 TO sfaa002  #顯示到畫面上
         NEXT FIELD sfaa002                     #返回原欄位
      
      ON ACTION controlp INFIELD sfaa017  #部門廠商
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooeg001_1()                     #呼叫開窗
         DISPLAY g_qryparam.return1 TO sfaa017  #顯示到畫面上
         NEXT FIELD sfaa017                     #返回原欄位
      
      ON ACTION controlp INFIELD sfaa018  #協作據點
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         #mod--161013-00051#1 By shiun--(S)
#         CALL q_ooef001()                           #呼叫開窗
         CALL q_ooef001_1()
         #mod--161013-00051#1 By shiun--(E)
         DISPLAY g_qryparam.return1 TO sfaa018  #顯示到畫面上
         NEXT FIELD sfaa018                     #返回原欄位
      
      ON ACTION sel_from  #匹配來源工單
         CALL asfp360_03_gen_b() RETURNING l_success
         CALL asfp360_03_show()

   END CONSTRUCT
END DIALOG

DIALOG asfp360_03_display1()
   DISPLAY ARRAY g_asfp360_03_d1 TO s_asfp360_03_detail1.* ATTRIBUTE(COUNT = g_rec_b03_1)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx1)
         LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail1")
         LET g_current_page = 1
         CALL asfp360_03_idx_chk()

      BEFORE ROW
         CALL asfp360_03_idx_chk()
         LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail1")
         LET g_detail_idx1 = l_ac
         
         CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
         IF g_rec_b03_3 = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  'ain-00308'
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF

   END DISPLAY
END DIALOG

DIALOG asfp360_03_display2()
   #制程单身预留
   DISPLAY ARRAY g_asfp360_03_d2 TO s_asfp360_03_detail2.* ATTRIBUTE(COUNT = g_rec_b03_2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx2)
         LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail2")
         LET g_current_page = 2
         CALL asfp360_03_idx_chk()
   
      BEFORE ROW
        CALL asfp360_03_idx_chk()
        LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail2")
        LET g_detail_idx2 = l_ac
   
   END DISPLAY

END DIALOG

DIALOG asfp360_03_display3()
   DISPLAY ARRAY g_asfp360_03_d3 TO s_asfp360_03_detail3.* ATTRIBUTE(COUNT = g_rec_b03_3)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx3)
         LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail3")
         LET g_current_page = 3
         CALL asfp360_03_idx_chk()

      BEFORE ROW
        CALL asfp360_03_idx_chk()
        LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail3")
        LET g_detail_idx3 = l_ac
        
        CALL asfp360_03_b_fill4(g_asfp360_03_d1[g_detail_idx1].sfaadocno,g_asfp360_03_d3[g_detail_idx3].sfbaseq,g_asfp360_03_d3[g_detail_idx3].sfbaseq1)
        CALL asfp360_03_b_fill5(g_asfp360_03_d3[g_detail_idx3].sfba002,g_asfp360_03_d3[g_detail_idx3].sfba003,
                                g_asfp360_03_d3[g_detail_idx3].sfba004,g_asfp360_03_d3[g_detail_idx3].sfba005,
                                g_asfp360_03_d3[g_detail_idx3].sfba006,g_asfp360_03_d3[g_detail_idx3].sfba021,
                                g_asfp360_03_d3[g_detail_idx3].sfba014,g_asfp360_03_d3[g_detail_idx3].unitr)

   END DISPLAY
END DIALOG

DIALOG asfp360_03_display4()
   DISPLAY ARRAY g_asfp360_03_d4 TO s_asfp360_03_detail4.* ATTRIBUTE(COUNT = g_rec_b03_4)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx4)
         LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail4")
         LET g_current_page = 4
         CALL asfp360_03_idx_chk()

      BEFORE ROW
        CALL asfp360_03_idx_chk()
        LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail4")
        LET g_detail_idx4 = l_ac

   END DISPLAY

END DIALOG

DIALOG asfp360_03_display5()
   DISPLAY ARRAY g_asfp360_03_d5 TO s_asfp360_03_detail5.* ATTRIBUTE(COUNT = g_rec_b03_5)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx5)
         LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail5")
         LET g_current_page = 3
         CALL asfp360_03_idx_chk()

      BEFORE ROW
        CALL asfp360_03_idx_chk()
        LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail5")
        LET g_detail_idx5 = l_ac

   END DISPLAY
END DIALOG

DIALOG asfp360_03_input1()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_cnt       LIKE type_t.num5

   INPUT ARRAY g_asfp360_03_d1 FROM s_asfp360_03_detail1.*
       ATTRIBUTE(COUNT = g_rec_b03_1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)

       BEFORE INPUT
          CALL asfp360_03_b_fill1()
          LET g_rec_b03_1 = g_asfp360_03_d1.getLength()

       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_detail_idx1 = l_ac
          LET g_asfp360_03_d1_t.* = g_asfp360_03_d1[l_ac].*  #BACKUP
          LET g_asfp360_03_d1_o.* = g_asfp360_03_d1[l_ac].*  #BACKUP*
          CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
          CALL cl_set_comp_entry("plan_outsets_03b1",TRUE)
          IF g_asfp360_03_d1[l_ac].sel = 'N' THEN
             CALL cl_set_comp_entry("plan_outsets_03b1",FALSE)
          END IF
          
       ON CHANGE sel_03b1
          #检查
          CALL asfp360_03_chk_column_b1(l_ac,'sel_03b1') RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d1[l_ac].sel = g_asfp360_03_d1_o.sel
             NEXT FIELD CURRENT
          END IF
          
          IF g_asfp360_03_d1[l_ac].sel = 'N' THEN
             LET g_asfp360_03_d1[l_ac].plan_outsets = 0
          END IF
          
          CALL s_transaction_begin()
          #更新临时表
          CALL asfp360_03_upd_temp1(l_ac) RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d1[l_ac].sel = g_asfp360_03_d1_o.sel
             CALL s_transaction_end('N','0')
             NEXT FIELD CURRENT
          END IF
          #刷新单身显示
          CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
          IF cl_null(g_detail_idx3) OR g_detail_idx3 = 0 THEN
             LET g_detail_idx3 = 1
          END IF
          CALL asfp360_03_b_fill5(g_asfp360_03_d3[g_detail_idx3].sfba002,g_asfp360_03_d3[g_detail_idx3].sfba003,
                                  g_asfp360_03_d3[g_detail_idx3].sfba004,g_asfp360_03_d3[g_detail_idx3].sfba005,
                                  g_asfp360_03_d3[g_detail_idx3].sfba006,g_asfp360_03_d3[g_detail_idx3].sfba021,
                                  g_asfp360_03_d3[g_detail_idx3].sfba014,g_asfp360_03_d3[g_detail_idx3].unitr)
          #旧值备份
          LET g_asfp360_03_d1_o.sel =g_asfp360_03_d1[l_ac].sel
          CALL s_transaction_end('Y','0')

          CALL cl_set_comp_entry("plan_outsets_03b1",TRUE)
          IF g_asfp360_03_d1[l_ac].sel = 'N' THEN
             CALL cl_set_comp_entry("plan_outsets_03b1",FALSE)
          END IF
          
       ON CHANGE plan_outsets_03b1
          #检查
          CALL asfp360_03_chk_column_b1(l_ac,'plan_outsets_03b1') RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d1[l_ac].plan_outsets = g_asfp360_03_d1_o.plan_outsets
             NEXT FIELD CURRENT
          END IF
          CALL s_transaction_begin()
          #更新临时表
          CALL asfp360_03_upd_temp1(l_ac) RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d1[l_ac].plan_outsets = g_asfp360_03_d1_o.plan_outsets
             CALL s_transaction_end('N','0')
             NEXT FIELD CURRENT
          END IF
          #刷新单身显示
          CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
          IF cl_null(g_detail_idx3) OR g_detail_idx3 = 0 THEN
             LET g_detail_idx3 = 1
          END IF
          CALL asfp360_03_b_fill5(g_asfp360_03_d3[g_detail_idx3].sfba002,g_asfp360_03_d3[g_detail_idx3].sfba003,
                                  g_asfp360_03_d3[g_detail_idx3].sfba004,g_asfp360_03_d3[g_detail_idx3].sfba005,
                                  g_asfp360_03_d3[g_detail_idx3].sfba006,g_asfp360_03_d3[g_detail_idx3].sfba021,
                                  g_asfp360_03_d3[g_detail_idx3].sfba014,g_asfp360_03_d3[g_detail_idx3].unitr)
          #旧值备份
          LET g_asfp360_03_d1_o.plan_outsets =g_asfp360_03_d1[l_ac].plan_outsets
          CALL s_transaction_end('Y','0')

       ON ROW CHANGE
       
       AFTER ROW

       AFTER INPUT
          #这里不能检查，因为上一步也会走到这里
          #若不检查，也不能做更新的动作，否则数据就可能会不对

       #此处不好用，还需输入数量，并对数量做管控
       #ON ACTION selall
       #   CALL asfp360_03_sel_all("Y")
       #
       #ON ACTION selnone
       #   CALL asfp360_03_sel_all("N")

   END INPUT

END DIALOG

#制程单身预留
DIALOG asfp360_03_input2()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_cnt       LIKE type_t.num5

   INPUT ARRAY g_asfp360_03_d2 FROM s_asfp360_03_detail2.*
       ATTRIBUTE(COUNT = g_rec_b03_2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
   
       BEFORE INPUT
          CALL asfp360_03_b_fill2()
          LET g_rec_b03_2 = g_asfp360_03_d2.getLength()
   
       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_detail_idx2 = l_ac
          LET g_asfp360_03_d2_t.* = g_asfp360_03_d2[l_ac].*  #BACKUP
          LET g_asfp360_03_d2_o.* = g_asfp360_03_d2[l_ac].*  #BACKUP*
          #CALL cl_set_comp_entry("plan_outqty_03b2",TRUE)
          #IF g_asfp360_03_d2[l_ac].sel = 'N' THEN
          #   CALL cl_set_comp_entry("plan_outqty_03b2",FALSE)
          #END IF

       #ON CHANGE sel_03b2
       #   #检查
       #   CALL asfp360_03_chk_column_b2(l_ac,'sel_03b2') RETURNING l_success
       #   IF NOT l_success THEN
       #      LET g_asfp360_03_d2[l_ac].sel = g_asfp360_03_d2_o.sel
       #      NEXT FIELD CURRENT
       #   END IF
       #   
       #   IF g_asfp360_03_d2[l_ac].sel = 'N' THEN
       #      LET g_asfp360_03_d2[l_ac].plan_outqty = 0
       #   END IF
       #
       #   #更新临时表
       #   CALL asfp360_03_upd_temp2(l_ac) RETURNING l_success
       #   IF NOT l_success THEN
       #      LET g_asfp360_03_d2[l_ac].sel = g_asfp360_03_d2_o.sel
       #      NEXT FIELD sel_03b2
       #   END IF
       #   #刷新单身显示
       #   CALL asfp360_03_b_fill2()
       #   #旧值备份
       #   LET g_asfp360_03_d2_o.sel = g_asfp360_03_d2[l_ac].sel
       #
       #   CALL cl_set_comp_entry("plan_outqty_03b2",TRUE)
       #   IF g_asfp360_03_d2[l_ac].sel = 'N' THEN
       #      CALL cl_set_comp_entry("plan_outqty_03b2",FALSE)
       #   END IF
       #   
       #ON CHANGE plan_outqty_03b2
       #   #检查
       #   CALL asfp360_03_chk_column_b2(l_ac,'plan_outqty_03b2') RETURNING l_success
       #   IF NOT l_success THEN
       #      LET g_asfp360_03_d2[l_ac].plan_outqty = g_asfp360_03_d2_o.plan_outqty
       #      NEXT FIELD CURRENT
       #   END IF
       #   #更新临时表
       #   CALL asfp360_03_upd_temp2(l_ac) RETURNING l_success
       #   IF NOT l_success THEN
       #      LET g_asfp360_03_d2[l_ac].plan_outqty = g_asfp360_03_d2_o.plan_outqty
       #      NEXT FIELD CURRENT
       #   END IF
       #   #刷新单身显示
       #   CALL asfp360_03_b_fill2()
       #   #旧值备份
       #   LET g_asfp360_03_d2_o.plan_outqty =g_asfp360_03_d2[l_ac].plan_outqty
   
       ON ROW CHANGE
   
       AFTER ROW

       AFTER INPUT
          #这里不能检查，因为上一步也会走到这里
          #若不检查，也不能做更新的动作，否则数据就可能会不对
   
   
   END INPUT
END DIALOG

DIALOG asfp360_03_input3()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_count      LIKE type_t.num5
   
   INPUT ARRAY g_asfp360_03_d3 FROM s_asfp360_03_detail3.*
       ATTRIBUTE(COUNT = g_rec_b03_3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)

       BEFORE INPUT
          CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
          LET g_rec_b03_3 = g_asfp360_03_d3.getLength()
          IF g_asfp360_03_d1[g_detail_idx1].sel = 'N' THEN
             #请先选择工单资料
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00391'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             NEXT FIELD sel_03b1
          END IF

       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_detail_idx3 = l_ac
          LET g_asfp360_03_d3_t.* = g_asfp360_03_d3[l_ac].*  #BACKUP
          LET g_asfp360_03_d3_o.* = g_asfp360_03_d3[l_ac].*  #BACKUP*
          CALL asfp360_03_b_fill4(g_asfp360_03_d1[g_detail_idx1].sfaadocno,g_asfp360_03_d3[g_detail_idx3].sfbaseq,g_asfp360_03_d3[g_detail_idx3].sfbaseq1)
          CALL asfp360_03_b_fill5(g_asfp360_03_d3[g_detail_idx3].sfba002,g_asfp360_03_d3[g_detail_idx3].sfba003,
                                  g_asfp360_03_d3[g_detail_idx3].sfba004,g_asfp360_03_d3[g_detail_idx3].sfba005,
                                  g_asfp360_03_d3[g_detail_idx3].sfba006,g_asfp360_03_d3[g_detail_idx3].sfba021,
                                  g_asfp360_03_d3[g_detail_idx3].sfba014,g_asfp360_03_d3[g_detail_idx3].unitr)
                                  
       ON CHANGE outqty_03b3
          #add 150119 单位取位
          IF NOT cl_null(g_asfp360_03_d3[l_ac].outqty) THEN
             CALL s_aooi250_get_msg(g_asfp360_03_d3[l_ac].sfba014) RETURNING l_success,g_ooca002,g_ooca004
             IF l_success THEN
                CALL s_num_round(g_ooca004,g_asfp360_03_d3[l_ac].outqty,g_ooca002) RETURNING g_asfp360_03_d3[l_ac].outqty
                #DISPLAY BY NAME g_asfp360_03_d3[l_ac].outqty
             END IF
          END IF
          #add 150119 end
          #检查
          CALL asfp360_03_chk_column_b3(l_ac,'outqty_03b3') RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d3[l_ac].outqty = g_asfp360_03_d3_o.outqty
             NEXT FIELD CURRENT
          END IF
          #计算参考单位数量
          #计算换算率
          IF cl_null(g_asfp360_03_d3[l_ac].unitr) THEN
             LET g_asfp360_03_d3[l_ac].outqtyr = 0
          ELSE
             #mod 150101
             #CALL s_aimi190_get_convert(g_asfp360_03_d3[l_ac].sfba006,g_asfp360_03_d3[l_ac].sfba014,g_asfp360_03_d3[l_ac].unitr)
             #   RETURNING l_success,l_rate
             #IF NOT l_success THEN
             #   LET l_rate = 1
             #END IF
             #LET g_asfp360_03_d3[l_ac].outqtyr = g_asfp360_03_d3[l_ac].outqty * l_rate
             CALL s_aooi250_convert_qty(g_asfp360_03_d3[l_ac].sfba006,g_asfp360_03_d3[l_ac].sfba014,g_asfp360_03_d3[l_ac].unitr,g_asfp360_03_d3[l_ac].outqty)
                RETURNING l_success,g_asfp360_03_d3[l_ac].outqtyr
             IF NOT l_success THEN
                LET g_asfp360_03_d3[l_ac].outqtyr = g_asfp360_03_d3[l_ac].outqty
             END IF
             #mod 150101 end
          END IF
          
          CALL s_transaction_begin()
          #更新临时表
          CALL asfp360_03_upd_temp3(l_ac) RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d3[l_ac].outqty = g_asfp360_03_d3_o.outqty
             LET g_asfp360_03_d3[l_ac].outqtyr= g_asfp360_03_d3_o.outqtyr
             CALL s_transaction_end('N','0')
             NEXT FIELD CURRENT
          END IF
          #刷新单身显示
          #CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
          CALL asfp360_03_b_fill5(g_asfp360_03_d3[l_ac].sfba002,g_asfp360_03_d3[l_ac].sfba003,
                                  g_asfp360_03_d3[l_ac].sfba004,g_asfp360_03_d3[l_ac].sfba005,
                                  g_asfp360_03_d3[l_ac].sfba006,g_asfp360_03_d3[l_ac].sfba021,
                                  g_asfp360_03_d3[l_ac].sfba014,g_asfp360_03_d3[l_ac].unitr)
          #旧值备份
          LET g_asfp360_03_d3_o.outqty = g_asfp360_03_d3[l_ac].outqty
          CALL s_transaction_end('Y','0')

       ON ROW CHANGE

       AFTER ROW

       AFTER INPUT
          #这里不能检查，因为上一步也会走到这里
          #若不检查，也不能做更新的动作，否则数据就可能会不对

       #此处不好用，还需输入数量，并对数量做管控
       #ON ACTION selall
       #   CALL asfp360_03_sel_all("Y")
       #
       #ON ACTION selnone
       #   CALL asfp360_03_sel_all("N")

   END INPUT

END DIALOG

DIALOG asfp360_03_input4()
   DEFINE l_qty_sum    LIKE sfdc_t.sfdc007
   DEFINE l_imaf071    LIKE imaf_t.imaf071
   DEFINE l_imaf081    LIKE imaf_t.imaf081
   DEFINE l_success    LIKE type_t.num5

   INPUT ARRAY g_asfp360_03_d4 FROM s_asfp360_03_detail4.*
       ATTRIBUTE(COUNT = g_rec_b03_4,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
       BEFORE INPUT
          CALL asfp360_03_b_fill4(g_asfp360_03_d1[g_detail_idx1].sfaadocno,g_asfp360_03_d3[g_detail_idx3].sfbaseq,g_asfp360_03_d3[g_detail_idx3].sfbaseq1)
          LET g_rec_b03_4 = g_asfp360_03_d4.getLength()
          IF g_asfp360_03_d1[g_detail_idx1].sel = 'N' THEN
             #请先选择工单资料
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00391'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             NEXT FIELD sel_03b1
          END IF

       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_detail_idx4 = l_ac
          LET g_asfp360_03_d4_t.* = g_asfp360_03_d4[l_ac].*  #BACKUP
          LET g_asfp360_03_d4_o.* = g_asfp360_03_d4[l_ac].*  #BACKUP*
          CALL cl_set_comp_entry("outqty_03b4",TRUE)
          IF g_asfp360_03_d4[l_ac].sel = 'N' THEN
             CALL cl_set_comp_entry("outqty_03b4",FALSE)
          END IF

       ON CHANGE sel_03b4
          #检查
          CALL asfp360_03_chk_column_b4(l_ac,'sel_03b4') RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d4[l_ac].sel = g_asfp360_03_d4_o.sel
             NEXT FIELD CURRENT
          END IF
          
          IF g_asfp360_03_d4[l_ac].sel = 'N' THEN
             LET g_asfp360_03_d4[l_ac].outqty = 0
          END IF
          
          CALL s_transaction_begin()
          #更新临时表
          CALL asfp360_03_upd_temp4(l_ac) RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d4[l_ac].sel = g_asfp360_03_d4_o.sel
             CALL s_transaction_end('N','0')
             NEXT FIELD CURRENT
          END IF
          #刷新单身显示
          #CALL asfp360_03_b_fill4(g_asfp360_03_d1[g_detail_idx1].sfaadocno,g_asfp360_03_d3[g_detail_idx3].sfbaseq,g_asfp360_03_d3[g_detail_idx3].sfbaseq1)
          #旧值备份
          LET g_asfp360_03_d4_o.sel =g_asfp360_03_d4[l_ac].sel
          CALL s_transaction_end('Y','0')

          CALL cl_set_comp_entry("outqty_03b4",TRUE)
          IF g_asfp360_03_d4[l_ac].sel = 'N' THEN
             CALL cl_set_comp_entry("outqty_03b4",FALSE)
          END IF

       ON CHANGE outqty_03b4
          #add 150119 单位取位
          IF NOT cl_null(g_asfp360_03_d4[l_ac].outqty) THEN
             CALL s_aooi250_get_msg(g_asfp360_03_d3[g_detail_idx3].sfba014) RETURNING l_success,g_ooca002,g_ooca004
             IF l_success THEN
                CALL s_num_round(g_ooca004,g_asfp360_03_d4[l_ac].outqty,g_ooca002) RETURNING g_asfp360_03_d4[l_ac].outqty
                #DISPLAY BY NAME g_asfp360_03_d4[l_ac].outqty
             END IF
          END IF
          #add 150119 end
          #检查
          CALL asfp360_03_chk_column_b4(l_ac,'outqty_03b4') RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d4[l_ac].outqty = g_asfp360_03_d4_o.outqty
             NEXT FIELD CURRENT
          END IF
          CALL s_transaction_begin()
          #更新临时表
          CALL asfp360_03_upd_temp4(l_ac) RETURNING l_success
          IF NOT l_success THEN
             LET g_asfp360_03_d4[l_ac].outqty = g_asfp360_03_d4_o.outqty
             CALL s_transaction_end('N','0')
             NEXT FIELD CURRENT
          END IF
          #刷新单身显示
          #CALL asfp360_03_b_fill4(g_asfp360_03_d1[g_detail_idx1].sfaadocno,g_asfp360_03_d3[g_detail_idx3].sfbaseq,g_asfp360_03_d3[g_detail_idx3].sfbaseq1)
          #旧值备份
          LET g_asfp360_03_d4_o.outqty = g_asfp360_03_d4[l_ac].outqty
          CALL s_transaction_end('Y','0')

       ON ROW CHANGE

       AFTER ROW


       AFTER INPUT
          #能否进入到下一步的判断不能写在这，因为上一步也会走到这段
          #CALL asfp360_02_upd_temp('0') RETURNING l_success #更新temp3 temp2
          #IF NOT l_success THEN
          #   NEXT FIELD sel_02_5
          #END IF

       #此处不好用，还需输入数量，并对数量做管控
       #ON ACTION selall
       #   CALL asfp360_02_sel_all("Y")
       #
       #ON ACTION selnone
       #   CALL asfp360_02_sel_all("N")

   END INPUT

END DIALOG

 
{</section>}
 
{<section id="asfp360_03.other_function" readonly="Y" >}

PUBLIC FUNCTION asfp360_03_init()
   WHENEVER ERROR CONTINUE

   CALL cl_set_comp_required("sfaadocno",FALSE)
   
   #制程尚未规划好，先隐藏
   CALL cl_set_comp_visible("page03_2",FALSE)
   
   CALL cl_set_comp_visible("sfba005_03b3",FALSE) #bom料号放画面方便计算用，不显示于画面中
   
   #當整體參數有使用參考單位時才顯示
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_visible("unitr_03b3,outqtyr_03b3",FALSE) #參考單位
      CALL cl_set_comp_visible("inqtyr_sum",FALSE) #參考單位
   END IF
END FUNCTION

PUBLIC FUNCTION asfp360_03_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF NOT asfp360_03_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF


   CREATE TEMP TABLE asfp360_tmp01(    #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
      sel             VARCHAR(1),           #选择
      sfaadocno       VARCHAR(20),      #工单单号
      sfaa010         VARCHAR(40),        #生产料号
      sfaa012         DECIMAL(20,6),        #生产数量
      sfaa049         DECIMAL(20,6),        #已发套数
      sfaa050         DECIMAL(20,6),        #已入库量
      can_outsets     DECIMAL(20,6),        #可拨出套数
      plan_outsets    DECIMAL(20,6),        #拟拨出套数
      sfaa019         DATE,        #预计开工日
      sfaa020         DATE     #预计完工日
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp360_tmp01'   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp360_tmp01_01 on asfp360_tmp01 (sfaadocno)   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp360_tmp01'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #制程单身--预留
   #CREATE TEMP TABLE asfp360_03_temp2(
   #   sel            LIKE type_t.chr1,     #选择
   #   sfcb001        LIKE sfcb_t.sfcb001,  #RUN CARD
   #   sfcb002        LIKE sfcb_t.sfcb002,  #项次
   #   sfcb003        LIKE sfcb_t.sfcb003,  #作业
   #   sfcb004        LIKE sfcb_t.sfcb004,  #作业序
   #   sfcb050        LIKE sfcb_t.sfcb050,  #在制数量
   #   sfcb028        LIKE sfcb_t.sfcb028,  #良品转入
   #   sfcb033        LIKE sfcb_t.sfcb033,  #良品转出
   #   sfcb036        LIKE sfcb_t.sfcb036,  #当站报废
   #   sfcb037        LIKE sfcb_t.sfcb037,  #当站下线
   #   sfcb046        LIKE sfcb_t.sfcb046,  #待Move in數
   #   sfcb047        LIKE sfcb_t.sfcb047,  #待Check in數
   #   sfcb048        LIKE sfcb_t.sfcb048,  #待Check out數
   #   sfcb049        LIKE sfcb_t.sfcb049,  #待Move out數
   #   outqty         LIKE sfcb_t.sfcb049,  #擬撥出數量
   #   manh           LIKE sfcb_t.sfcb023,  #應轉出工時
   #   mach           LIKE sfcb_t.sfcb025   #應轉出機時
   #   )
   #IF SQLCA.sqlcode != 0 THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'create asfp360_03_temp2'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #CREATE UNIQUE INDEX asfp360_03_temp2_01 on asfp360_03_temp2 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013)
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'create index asfp360_03_temp2'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF

   CREATE TEMP TABLE asfp360_tmp02(   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      sfaadocno       VARCHAR(20),      #工单单号
      sfbaseq         INTEGER,       #项次
      sfbaseq1        INTEGER,      #项序
      sfba002         VARCHAR(10),       #部位
      sfba003         VARCHAR(10),       #作业
      sfba004         VARCHAR(10),       #作业序
      sfba005         VARCHAR(40),       #BOM料号 需要和asfp360_02_temp匹配
      sfba006         VARCHAR(40),       #发料料号
      sfba021         VARCHAR(256),       #特征
      sfba014         VARCHAR(10),       #单位
      sfba013         DECIMAL(20,6),       #应发
      sfba016         DECIMAL(20,6),       #已发
      outqty          DECIMAL(20,6),       #拟拨出数量
      unitr           VARCHAR(10),       #参考单位
      outqtyr         DECIMAL(20,6)     #参考单位拨出数量
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp360_tmp02'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp360_tmp02_01 on asfp360_tmp02 (sfaadocno,sfbaseq,sfbaseq1)  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp360_tmp02'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE asfp360_tmp03(   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      sel             VARCHAR(1),
      sfaadocno       VARCHAR(20),      #工单单号
      sfbaseq         INTEGER,        #工单项次
      sfbaseq1        INTEGER,       #工单项序
      inaodocno       VARCHAR(20),     #发料单号
      inaoseq         INTEGER,       #项次
      inaoseq1        INTEGER,      #项序
      inaoseq2        INTEGER,      #序号
      inao001         VARCHAR(40),       #料件编号
      inao008         VARCHAR(30),       #制造批号
      inao009         VARCHAR(30),       #制造序号
      inao010         DATE,       #制造日期
      can_outqty      DECIMAL(20,6),       #可拨出数量
      outqty          DECIMAL(20,6)     #数量
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp360_tmp03'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp360_tmp03_01 on asfp360_tmp03 (sfaadocno,sfbaseq,sfbaseq1,inaodocno,inaoseq,inaoseq1,inaoseq2)  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp360_tmp03'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PUBLIC FUNCTION asfp360_03_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE asfp360_tmp01   #160727-00019#17   16/08/049 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp360_tmp01'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #制程单身--预留
   #DROP TABLE asfp360_03_temp2
   #IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'drop asfp360_03_temp2'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   DROP TABLE asfp360_tmp02  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp360_tmp02'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DROP TABLE asfp360_tmp03  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp360_tmp03'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PUBLIC FUNCTION asfp360_03_delete_temp_table()
   WHENEVER ERROR CONTINUE

   DELETE FROM asfp360_tmp01   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
   #DELETE FROM asfp360_03_temp2  #制程单身--预留
   DELETE FROM asfp360_tmp02  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
   DELETE FROM asfp360_tmp03  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
END FUNCTION

PUBLIC FUNCTION asfp360_03_b_fill1()
   DEFINE p_flag       LIKE type_t.chr1   #Y展开 N不展开
   DEFINE l_sql        STRING
   DEFINE l_ac_l       LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   CALL g_asfp360_03_d1.clear()

   LET l_sql = "SELECT sel,sfaadocno,sfaa010,imaal003,imaal004, ",
               "       sfaa012,sfaa049,sfaa050,can_outsets,plan_outsets, ",
               "       sfaa019,sfaa020 ",
               "  FROM asfp360_tmp01 LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"' ",  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               " WHERE can_outsets > 0 ",
               " ORDER BY can_outsets,sfaa020"
   PREPARE asfp360_03_b_fill1_p FROM l_sql
   DECLARE asfp360_03_b_fill1_c CURSOR FOR asfp360_03_b_fill1_p
   LET l_ac_l = 1
   ERROR "Searching!"
   FOREACH asfp360_03_b_fill1_c INTO g_asfp360_03_d1[l_ac_l].sel,g_asfp360_03_d1[l_ac_l].sfaadocno,g_asfp360_03_d1[l_ac_l].sfaa010,
          g_asfp360_03_d1[l_ac_l].sfaa010_desc,g_asfp360_03_d1[l_ac_l].sfaa010_desc2,g_asfp360_03_d1[l_ac_l].sfaa012,
          g_asfp360_03_d1[l_ac_l].sfaa049,g_asfp360_03_d1[l_ac_l].sfaa050,g_asfp360_03_d1[l_ac_l].can_outsets,g_asfp360_03_d1[l_ac_l].plan_outsets,
          g_asfp360_03_d1[l_ac_l].sfaa019,g_asfp360_03_d1[l_ac_l].sfaa020
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_b_fill1_c"
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
   LET g_rec_b03_1 = l_ac_l - 1
   CALL g_asfp360_03_d1.deleteElement(g_asfp360_03_d1.getLength())

   CLOSE asfp360_03_b_fill1_c
   FREE asfp360_03_b_fill1_p
   
   #DISPLAY ARRAY g_asfp360_03_d1 TO s_asfp360_03_detail1.* ATTRIBUTE(COUNT = g_rec_b03_1)
   #   BEFORE DISPLAY
   #      CALL FGL_SET_ARR_CURR(g_detail_idx1)
   #      LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail1")
   #      LET g_current_page = 1
   #      CALL asfp360_03_idx_chk()
   #
   #   BEFORE ROW
   #      CALL asfp360_03_idx_chk()
   #      LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail1")
   #      LET g_detail_idx1 = l_ac
   #      CALL asfp360_03_b_fill3(g_asfp360_03_d1[l_ac].sfaadocno)
   #      EXIT DISPLAY
   #
   #END DISPLAY
END FUNCTION

PUBLIC FUNCTION asfp360_03_b_fill2()
   DEFINE l_ac_l       LIKE type_t.num5
   
#mark 制程单身预留
#   WHENEVER ERROR CONTINUE
#   CALL g_asfp360_03_d2.clear()
#
#   LET g_sql = "SELECT UNIQUE sel,sfcb001,sfcb002,sfcb003,sfcb004,sfcb050,sfcb028,sfcb033,sfcb036, ",
#               "       sfcb037,sfcb046,sfcb047,sfcb048,sfcb049,0,0,0 ",
#               "  FROM asfp360_03_temp2",
#               " INNER JOIN sfaa_t ON sfaadocno = sfcbdocno ",
#               " ORDER BY sfcb_t.sfcb001,sfcb_t.sfcb002"
#   PREPARE asfp360_03_b_fill2_p FROM g_sql
#   DECLARE asfp360_03_b_fill2_c CURSOR FOR asfp360_03_b_fill2_p
#   LET l_ac_l = 1
#   FOREACH asfp360_03_b_fill2_c INTO g_asfp360_03_d2[l_ac_l].sel,g_asfp360_03_d2[l_ac_l].sfcb001,g_asfp360_03_d2[l_ac_l].sfcb002,
#       g_asfp360_03_d2[l_ac_l].sfcb003,g_asfp360_03_d2[l_ac_l].sfcb004,g_asfp360_03_d2[l_ac_l].sfcb050,g_asfp360_03_d2[l_ac_l].sfcb028,
#       g_asfp360_03_d2[l_ac_l].sfcb033,g_asfp360_03_d2[l_ac_l].sfcb036,g_asfp360_03_d2[l_ac_l].sfcb037,g_asfp360_03_d2[l_ac_l].sfcb046,
#       g_asfp360_03_d2[l_ac_l].sfcb047,g_asfp360_03_d2[l_ac_l].sfcb048,g_asfp360_03_d2[l_ac_l].sfcb049,g_asfp360_03_d2[l_ac_l].move,
#       g_asfp360_03_d2[l_ac_l].manh,g_asfp360_03_d2[l_ac_l].mach
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:asfp360_03_b_fill2_c"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#
#      LET l_ac_l = l_ac_l + 1
#      IF l_ac_l > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code =  9035
#         LET g_errparam.extend =  ""
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#   END FOREACH
#      
#   CALL g_asfp360_03_d2.deleteElement(g_asfp360_03_d2.getLength())
#   FREE asfp360_03_b_fill2_p
END FUNCTION

PUBLIC FUNCTION asfp360_03_b_fill3(p_sfaadocno)
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE l_ac_l          LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   WHENEVER ERROR CONTINUE
   CALL g_asfp360_03_d3.clear()
   
   LET g_sql = "SELECT sfbaseq,sfbaseq1,sfba002,a.oocql004,sfba003,b.oocql004, ",
               "       sfba004,sfba005,sfba006,imaal003,imaal004,sfba021,sfba014,oocal003, ",
               "       sfba013,sfba016,outqty,unitr,outqtyr ",
               "  FROM asfp360_tmp02 LEFT OUTER JOIN imaal_t   ON imaalent = "||g_enterprise||" AND imaal001=sfba006 AND imaal002= '"||g_dlang||"' ",  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
               "                        LEFT OUTER JOIN oocql_t a ON a.oocql001= '215' AND a.oocql002 = sfba002 AND a.oocqlent = "||g_enterprise||" AND a.oocql003 = '"||g_dlang||"' ",
               "                        LEFT OUTER JOIN oocql_t b ON b.oocql001= '221' AND b.oocql002 = sfba003 AND b.oocqlent = "||g_enterprise||" AND b.oocql003 = '"||g_dlang||"' ",
               "                        LEFT OUTER JOIN oocal_t   ON oocalent = "||g_enterprise||" AND oocal001 = sfba014 AND oocal002 = '"||g_dlang||"' ",
               " WHERE sfaadocno = '",p_sfaadocno,"' ",
               " ORDER BY sfbaseq,sfbaseq1"
            
   PREPARE asfp360_03_b_fill3_p FROM g_sql
   DECLARE asfp360_03_b_fill3_c CURSOR FOR asfp360_03_b_fill3_p
   LET l_ac_l = 1
   FOREACH asfp360_03_b_fill3_c INTO g_asfp360_03_d3[l_ac_l].sfbaseq,g_asfp360_03_d3[l_ac_l].sfbaseq1,g_asfp360_03_d3[l_ac_l].sfba002,
       g_asfp360_03_d3[l_ac_l].sfba002_desc,g_asfp360_03_d3[l_ac_l].sfba003,g_asfp360_03_d3[l_ac_l].sfba003_desc,g_asfp360_03_d3[l_ac_l].sfba004,
       g_asfp360_03_d3[l_ac_l].sfba005,g_asfp360_03_d3[l_ac_l].sfba006,g_asfp360_03_d3[l_ac_l].sfba006_desc,g_asfp360_03_d3[l_ac_l].sfba006_desc2,
       g_asfp360_03_d3[l_ac_l].sfba021,g_asfp360_03_d3[l_ac_l].sfba014,g_asfp360_03_d3[l_ac_l].sfba014_desc,g_asfp360_03_d3[l_ac_l].sfba013,
       g_asfp360_03_d3[l_ac_l].sfba016,g_asfp360_03_d3[l_ac_l].outqty,g_asfp360_03_d3[l_ac_l].unitr,g_asfp360_03_d3[l_ac_l].outqtyr
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_b_fill3_c"
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
   CALL g_asfp360_03_d3.deleteElement(g_asfp360_03_d3.getLength())

   FREE asfp360_03_b_fill3_p

   #DISPLAY ARRAY g_asfp360_03_d3 TO s_asfp360_03_detail3.* ATTRIBUTE(COUNT = g_rec_b03_3)
   #   BEFORE DISPLAY
   #      CALL FGL_SET_ARR_CURR(g_detail_idx3)
   #      LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail3")
   #      LET g_current_page = 3
   #      CALL asfp360_03_idx_chk()
   #
   #   BEFORE ROW
   #     CALL asfp360_03_idx_chk()
   #     LET l_ac = DIALOG.getCurrentRow("s_asfp360_03_detail3")
   #     LET g_detail_idx3 = l_ac
   #     
   #     CALL asfp360_03_b_fill5(g_asfp360_03_d3[l_ac].sfba002,g_asfp360_03_d3[l_ac].sfba003,
   #                             g_asfp360_03_d3[l_ac].sfba004,g_asfp360_03_d3[l_ac].sfba005,
   #                             g_asfp360_03_d3[l_ac].sfba006,g_asfp360_03_d3[l_ac].sfba021,
   #                             g_asfp360_03_d3[l_ac].sfba014,g_asfp360_03_d3[l_ac].unitr)
   #     EXIT DISPLAY
   #
   #END DISPLAY
END FUNCTION

PUBLIC FUNCTION asfp360_03_b_fill4(p_sfaadocno,p_sfbaseq,p_sfbaseq1)
   DEFINE p_sfaadocno      LIKE sfaa_t.sfaadocno #工单单号
   DEFINE p_sfbaseq        LIKE sfba_t.sfbaseq   #工单项次
   DEFINE p_sfbaseq1       LIKE sfba_t.sfbaseq1  #工单项序
   DEFINE l_inaodocno      LIKE inao_t.inaodocno #发料单号
   DEFINE l_ac_l           LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   
   WHENEVER ERROR CONTINUE
   CALL g_asfp360_03_d4.clear()

   LET g_sql = "SELECT sel,inaodocno,inaoseq,inaoseq1,inaoseq2,inao001,imaal003,imaal004, ",
               "       inao008,inao009,inao010,can_outqty,outqty ",
               "  FROM asfp360_tmp03 LEFT OUTER JOIN imaal_t ON imaalent = "||g_enterprise||" AND imaal001=sfba006 AND imaal002= '"||g_dlang||"' ",  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
               " WHERE sfaadocno = '",p_sfaadocno,"' ",
               "   AND sfbaseq = ",p_sfbaseq,
               "   AND sfbaseq1= ",p_sfbaseq1,
               " ORDER BY inaodocno,inaoseq,inaoseq1,inaoseq2"
            
   PREPARE asfp360_03_b_fill4_p FROM g_sql
   DECLARE asfp360_03_b_fill4_c CURSOR FOR asfp360_03_b_fill4_p
   LET l_ac_l = 1
   FOREACH asfp360_03_b_fill4_c INTO g_asfp360_03_d4[l_ac_l].sel,g_asfp360_03_d4[l_ac_l].inaodocno,
       g_asfp360_03_d4[l_ac_l].inaoseq,g_asfp360_03_d4[l_ac_l].inaoseq1,g_asfp360_03_d4[l_ac_l].inaoseq2,
       g_asfp360_03_d4[l_ac_l].inao001,g_asfp360_03_d4[l_ac_l].inao001_desc,g_asfp360_03_d4[l_ac_l].inao001_desc2,
       g_asfp360_03_d4[l_ac_l].inao008,g_asfp360_03_d4[l_ac_l].inao009,g_asfp360_03_d4[l_ac_l].inao010,
       g_asfp360_03_d4[l_ac_l].can_outqty,g_asfp360_03_d4[l_ac_l].outqty

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_b_fill4_c"
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
   CALL g_asfp360_03_d4.deleteElement(g_asfp360_03_d4.getLength())

   FREE asfp360_03_b_fill4_p
END FUNCTION

PUBLIC FUNCTION asfp360_03_b_fill5(p_sfba002,p_sfba003,p_sfba004,p_sfba005,p_sfba006,p_sfba021,p_sfba014,p_unitr)
   #DEFINE p_sfbaseq        LIKE sfba_t.sfbaseq   #项次
   #DEFINE p_sfbaseq1       LIKE sfba_t.sfbaseq1  #项序
   DEFINE p_sfba002        LIKE sfba_t.sfba002     #部位
   DEFINE p_sfba003        LIKE sfba_t.sfba003     #作业
   DEFINE p_sfba004        LIKE sfba_t.sfba004     #作业序
   DEFINE p_sfba005        LIKE sfba_t.sfba005     #BOM料号
   DEFINE p_sfba006        LIKE sfba_t.sfba006     #需求料号
   DEFINE p_sfba021        LIKE sfba_t.sfba021     #特征
   DEFINE p_sfba014        LIKE sfba_t.sfba014     #单位
   DEFINE p_unitr          LIKE sfba_t.sfba014     #参考单位
   DEFINE l_ac_l           LIKE type_t.num10        #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   
   WHENEVER ERROR CONTINUE
   CALL g_asfp360_03_d5.clear()

   IF NOT cl_null(p_unitr) THEN
      LET g_sql = "SELECT inqty_sum,inqtyr_sum ",
                  "  FROM asfp360_02_temp ",
                  #" WHERE sfbaseq = ",p_sfbaseq,
                  #"   AND sfbaseq1= ",p_sfbaseq1,
                  " WHERE sfba002 = '",p_sfba002,"' ",
                  "   AND sfba003 = '",p_sfba003,"' ",
                  "   AND sfba004 = '",p_sfba004,"' ",
                  "   AND sfba005 = '",p_sfba005,"' ",
                  "   AND sfba006 = '",p_sfba006,"' ",
                  "   AND sfba021 = '",p_sfba021,"' ",
                  "   AND sfba014 = '",p_sfba014,"' ",
                  "   AND unitr   = '",p_unitr,"' ", 
                  " ORDER BY inqty_sum,inqtyr_sum"
   ELSE
      LET g_sql = "SELECT inqty_sum,inqtyr_sum ",
                  "  FROM asfp360_02_temp ",
                  #" WHERE sfbaseq = ",p_sfbaseq,
                  #"   AND sfbaseq1= ",p_sfbaseq1,
                  " WHERE sfba002 = '",p_sfba002,"' ",
                  "   AND sfba003 = '",p_sfba003,"' ",
                  "   AND sfba004 = '",p_sfba004,"' ",
                  "   AND sfba005 = '",p_sfba005,"' ",
                  "   AND sfba006 = '",p_sfba006,"' ",
                  "   AND sfba021 = '",p_sfba021,"' ",
                  "   AND sfba014 = '",p_sfba014,"' ",
                  "   AND unitr IS NULL ", 
                  " ORDER BY inqty_sum,inqtyr_sum"
   END IF
            
   PREPARE asfp360_03_b_fill5_p FROM g_sql
   DECLARE asfp360_03_b_fill5_c CURSOR FOR asfp360_03_b_fill5_p
   LET l_ac_l = 1
   FOREACH asfp360_03_b_fill5_c INTO g_asfp360_03_d5[l_ac_l].inqty_sum,g_asfp360_03_d5[l_ac_l].inqtyr_sum
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_b_fill5_c"
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
   CALL g_asfp360_03_d5.deleteElement(g_asfp360_03_d5.getLength())

   FREE asfp360_03_b_fill5_p
END FUNCTION

#匹配來源工單
PUBLIC FUNCTION asfp360_03_gen_b()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sfaa010    LIKE sfaa_t.sfaa010  #需求工单生产料号
   DEFINE l_sfaa011    LIKE sfaa_t.sfaa011  #需求工单特性
   DEFINE l_temp1      RECORD
                       sel            LIKE type_t.chr1,      #选择
                       sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                       sfaa010        LIKE sfaa_t.sfaa010,   #生产料号
                       sfaa012        LIKE sfaa_t.sfaa012,   #生产数量
                       sfaa049        LIKE sfaa_t.sfaa049,   #已发套数
                       sfaa050        LIKE sfaa_t.sfaa050,   #已入库量
                       can_outsets    LIKE sfaa_t.sfaa049,   #可拨出套数=齐料套数-已入库数量
                       plan_outsets   LIKE sfaa_t.sfaa049,   #拟拨出套数
                       sfaa019        LIKE sfaa_t.sfaa019,   #预计开工日
                       sfaa020        LIKE sfaa_t.sfaa020    #预计完工日
                       END RECORD
   DEFINE l_full_sets  LIKE sfaa_t.sfaa049  #工单齐料套数
   DEFINE l_cnt        LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #目的工单生产料号 特性
   SELECT sfaa010,sfaa011 INTO l_sfaa010,l_sfaa011
     FROM sfaa_t 
    WHERE sfaaent   = g_enterprise
      AND sfaadocno = g_sfaadocno_01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfaadocno_01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM asfp360_tmp01  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
   IF l_cnt > 0 THEN
      #是否重新產生？
      IF NOT cl_ask_confirm('anm-00164') THEN
         RETURN r_success
      END IF
   END IF
   
   #获取来源工单asfp360_03_temp1
   CALL asfp360_03_delete_temp_table()
   
   LET l_sql = "SELECT 'N',sfaadocno,sfaa010,sfaa012,sfaa049,sfaa050, ",
              #160425-00019 by whitney modift start
              #"       0,0,sfaa019,sfaa020 ",
               "       (sfaa071-sfaa050),0,sfaa019,sfaa020 ",
              #160425-00019 by whitney modift end
               "  FROM sfaa_t  ",
               " WHERE sfaaent =",g_enterprise,
               "   AND sfaasite='",g_site,"'",
               "   AND sfaa010 = '",l_sfaa010,"' ",
               "   AND sfaa011 = '",l_sfaa011,"' ",
               "   AND ",g_wc_03 CLIPPED,
               "   AND sfaadocno !='",g_sfaadocno_01,"' ",  #非需求工单
               "   AND sfaastus = 'F' AND sfaa047 IS NULL "  #已发放，尚未结案
   PREPARE asfp360_03_sel_from_p FROM l_sql
   DECLARE asfp360_03_sel_from_c CURSOR FOR asfp360_03_sel_from_p
   FOREACH asfp360_03_sel_from_c INTO l_temp1.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_sel_from_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      #检查来源单身跟需求单身是否匹配，且有已发量，若来源单身没有一笔匹配的，则此工单不显示
      CALL asfp360_03_chk_sfaadocno(l_temp1.sfaadocno) RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
      
      #计算工单齐料套数
#160425-00019 by whitney mark start
#      CALL s_asft340_full_sets(l_temp1.sfaadocno,'','','') RETURNING l_success,l_full_sets
#      LET l_temp1.can_outsets = l_full_sets - l_temp1.sfaa050  #可拨出套数=齐料套数-已入库套数
#160425-00019 by whitney mark end
      IF l_temp1.can_outsets < 0 THEN  #可拨出套数为0的先产生到临时表，显示的时候不显示出来就好了
         LET l_temp1.can_outsets = 0
      END IF
      
      INSERT INTO asfp360_tmp01(sel         ,sfaadocno   ,sfaa010     ,   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                                   sfaa012     ,sfaa049     ,sfaa050     ,
                                   can_outsets ,plan_outsets,sfaa019     ,
                                   sfaa020     )
         VALUES (l_temp1.sel         ,l_temp1.sfaadocno   ,l_temp1.sfaa010     ,
                 l_temp1.sfaa012     ,l_temp1.sfaa049     ,l_temp1.sfaa050     ,
                 l_temp1.can_outsets ,l_temp1.plan_outsets,l_temp1.sfaa019     ,
                 l_temp1.sfaa020 )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT asfp360_tmp01"   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asfp360_03_sel_from_c
   FREE asfp360_03_sel_from_p

   #必须重foreach计算，因为要根据can_outsets排序，主sql无法一次抓出
   CALL asfp360_03_def_qty() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#分配数量
PUBLIC FUNCTION asfp360_03_def_qty()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_temp1      RECORD
                       sel            LIKE type_t.chr1,      #选择
                       sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                       sfaa010        LIKE sfaa_t.sfaa010,   #生产料号
                       sfaa012        LIKE sfaa_t.sfaa012,   #生产数量
                       sfaa049        LIKE sfaa_t.sfaa049,   #已发套数
                       sfaa050        LIKE sfaa_t.sfaa050,   #已入库量
                       can_outsets    LIKE sfaa_t.sfaa049,   #可拨出套数
                       plan_outsets   LIKE sfaa_t.sfaa049,   #拟拨出套数
                       sfaa019        LIKE sfaa_t.sfaa019,   #预计开工日
                       sfaa020        LIKE sfaa_t.sfaa020    #预计完工日
                       END RECORD
   DEFINE l_sets       LIKE sfaa_t.sfaa049   #待分配套数
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_count      LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_sets = g_asfp360_02_m.insets    #待分配套数=需求套数
   
   LET l_sql = "SELECT sel,sfaadocno,sfaa010,sfaa012,sfaa049,sfaa050,can_outsets,plan_outsets, ",
               "       sfaa019,sfaa020 ",
               "  FROM asfp360_tmp01 ",   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               " ORDER BY can_outsets,sfaa020"
   PREPARE asfp360_03_def_qty_p FROM l_sql
   DECLARE asfp360_03_def_qty_c CURSOR FOR asfp360_03_def_qty_p
   FOREACH asfp360_03_def_qty_c INTO l_temp1.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_def_qty_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF l_sets > 0 THEN
         IF l_temp1.can_outsets >= l_sets THEN
            LET l_temp1.plan_outsets = l_sets
            IF l_temp1.plan_outsets > 0 THEN
               LET l_temp1.sel = 'Y'
            ELSE
               LET l_temp1.sel = 'N'
            END IF
            UPDATE asfp360_tmp01 SET sel          = l_temp1.sel,  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                                        plan_outsets = l_temp1.plan_outsets
             WHERE sfaadocno = l_temp1.sfaadocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPDATE asfp360_tmp01"   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            LET l_sets = 0
         ELSE
            LET l_temp1.plan_outsets = l_temp1.can_outsets
            IF l_temp1.plan_outsets > 0 THEN
               LET l_temp1.sel = 'Y'
            ELSE
               LET l_temp1.sel = 'N'
            END IF
            UPDATE asfp360_tmp01 SET sel          = 'Y',  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                                        plan_outsets = l_temp1.plan_outsets
             WHERE sfaadocno = l_temp1.sfaadocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPDATE asfp360_tmp01"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            LET l_sets = l_sets - l_temp1.can_outsets
         END IF
      END IF
      
      #获取来源工单备料asfp360_03_temp3
      CALL asfp360_03_get_temp3('a',l_temp1.sfaadocno,l_temp1.plan_outsets) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asfp360_03_def_qty_c
   FREE asfp360_03_def_qty_p

   RETURN r_success
END FUNCTION

#获取来源工单备料asfp360_03_temp3
PUBLIC FUNCTION asfp360_03_get_temp3(p_flag,p_sfaadocno,p_sets)
   DEFINE p_flag       LIKE type_t.chr1   #a新增  u更新
   DEFINE p_sfaadocno  LIKE sfaa_t.sfaadocno
   DEFINE p_sets       LIKE sfaa_t.sfaa049    #拟拨出套数
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_temp3      RECORD
                       sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                       sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                       sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                       sfba002        LIKE sfba_t.sfba002,  #部位
                       sfba003        LIKE sfba_t.sfba003,  #作业
                       sfba004        LIKE sfba_t.sfba004,  #作业序
                       sfba005        LIKE sfba_t.sfba005,  #BOM料号
                       sfba006        LIKE sfba_t.sfba006,  #发料料号
                       sfba021        LIKE sfba_t.sfba021,  #特征
                       sfba014        LIKE sfba_t.sfba014,  #单位
                       sfba013        LIKE sfba_t.sfba013,  #应发
                       sfba016        LIKE sfba_t.sfba016,  #已发
                       outqty         LIKE sfba_t.sfba016,  #拟拨出数量
                       unitr          LIKE sfba_t.sfba014,  #参考单位
                       outqtyr        LIKE sfba_t.sfba016,  #参考单位拨出数量
                       sfba010        LIKE sfba_t.sfba010,     #QPA分子
                       sfba011        LIKE sfba_t.sfba011,     #QPA分母
                       sfba022        LIKE sfba_t.sfba022      #替代率
                       END RECORD
   DEFINE l_qty        LIKE sfba_t.sfba013  #套数计算剩余数量 用于预设
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num10     #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_imaf071    LIKE imaf_t.imaf071
   DEFINE l_imaf081    LIKE imaf_t.imaf081
   DEFINE l_sql        STRING


   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF p_flag = 'u' THEN
      #删除后重新产生
      DELETE FROM asfp360_tmp02 WHERE sfaadocno = p_sfaadocno   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del asfp360_tmp02"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      DELETE FROM asfp360_tmp03 WHERE sfaadocno = p_sfaadocno   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del asfp360_tmp03"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   LET l_sql = "SELECT sfbadocno,sfbaseq,sfbaseq1,sfba002,sfba003,",
               "       sfba004,sfba005,sfba006,sfba021,sfba014, ",
               "       sfba013,sfba016,0,imaf015,0,  ",
               "       sfba010,sfba011,sfba022, ",
               "       imaf071,imaf081 ",
               "  FROM sfba_t LEFT JOIN imaf_t ON imafent="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfba006 ",
               " WHERE sfbadocno = '",p_sfaadocno,"' ",
               " ORDER BY sfbaseq,sfbaseq1"
   PREPARE asfp360_03_get_temp3_p FROM l_sql
   DECLARE asfp360_03_get_temp3_c CURSOR FOR asfp360_03_get_temp3_p
   FOREACH asfp360_03_get_temp3_c INTO l_temp3.*,l_imaf071,l_imaf081
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_get_temp3_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      IF cl_null(l_temp3.sfba005) THEN LET l_temp3.sfba005 = ' ' END IF
      
      IF l_temp3.sfba016 <= 0 THEN #已发数量小于等于0
         CONTINUE FOREACH
      END IF
      
      #memo:工单中不应该出现只有替代料，没有原料的情况
      IF NOT cl_null(l_temp3.unitr) THEN
         SELECT COUNT(*) INTO l_cnt FROM asfp360_02_temp
          WHERE sfba002 = l_temp3.sfba002
            AND sfba003 = l_temp3.sfba003
            AND sfba004 = l_temp3.sfba004
            AND sfba005 = l_temp3.sfba005
            AND sfba006 = l_temp3.sfba006
            AND sfba021 = l_temp3.sfba021
            AND sfba014 = l_temp3.sfba014
            AND unitr   = l_temp3.unitr
            AND sel     = 'Y'
      ELSE
         SELECT COUNT(*) INTO l_cnt FROM asfp360_02_temp
          WHERE sfba002 = l_temp3.sfba002
            AND sfba003 = l_temp3.sfba003
            AND sfba004 = l_temp3.sfba004
            AND sfba005 = l_temp3.sfba005
            AND sfba006 = l_temp3.sfba006
            AND sfba021 = l_temp3.sfba021
            AND sfba014 = l_temp3.sfba014
            AND unitr IS NULL
            AND sel     = 'Y'
      END IF
      IF l_cnt = 0 THEN
         #需求料件中不存在的料，拟拨出数量设定为0
         LET l_temp3.outqty = 0
         CONTINUE FOREACH   #部位、作业、作业序等不同，无法一一对应到需求单上去
      ELSE
         #outqty默认值=拨出套数*标准QPA分子/标准QPA分母 需考虑未发量
         IF l_temp3.sfbaseq1 = 0 THEN
            #未被取替代
            LET l_temp3.outqty = p_sets * l_temp3.sfba010/l_temp3.sfba011
            #add 150119 单位取位
            CALL s_aooi250_get_msg(l_temp3.sfba014) RETURNING l_success,g_ooca002,g_ooca004
            IF l_success THEN
               CALL s_num_round(g_ooca004,l_temp3.outqty,g_ooca002) RETURNING l_temp3.outqty
            END IF
            #add 150119 end
            IF l_temp3.outqty > l_temp3.sfba016 THEN
               LET l_qty = l_temp3.outqty - l_temp3.sfba016   #套数剩余数量
               LET l_temp3.outqty = l_temp3.sfba016
            ELSE
               LET l_qty = 0
            END IF
         ELSE
            LET l_temp3.outqty = l_qty * l_temp3.sfba022  #备料量转换成替代料的量
            IF l_temp3.outqty > l_temp3.sfba016 THEN
               LET l_qty = (l_temp3.outqty - l_temp3.sfba016)/l_temp3.sfba022   #套数剩余数量 转换回替代料的量
               LET l_temp3.outqty = l_temp3.sfba016
            END IF
         END IF
      END IF
      
      #计算参考单位换算率
      IF cl_null(l_temp3.unitr) THEN
         LET l_temp3.outqtyr = 0
      ELSE
         #mod 150101
         #CALL s_aimi190_get_convert(l_temp3.sfba006,l_temp3.sfba014,l_temp3.unitr) RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_temp3.outqtyr = l_temp3.outqty * l_rate
         CALL s_aooi250_convert_qty(l_temp3.sfba006,l_temp3.sfba014,l_temp3.unitr,l_temp3.outqty)
            RETURNING l_success,l_temp3.outqtyr
         IF NOT l_success THEN
            LET l_temp3.outqtyr = l_temp3.outqty
         END IF
         #mod 150101 end
      END IF
      
      INSERT INTO asfp360_tmp02(sfaadocno   ,sfbaseq     ,sfbaseq1    ,   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
                                   sfba002     ,sfba003     ,sfba004     ,
                                   sfba005     ,
                                   sfba006     ,sfba021     ,sfba014     ,
                                   sfba013     ,sfba016     ,
                                   outqty      ,unitr       ,outqtyr    
                                   )
         VALUES(l_temp3.sfaadocno   ,l_temp3.sfbaseq     ,l_temp3.sfbaseq1    ,
                l_temp3.sfba002     ,l_temp3.sfba003     ,l_temp3.sfba004     ,
                l_temp3.sfba005     ,
                l_temp3.sfba006     ,l_temp3.sfba021     ,l_temp3.sfba014     ,
                l_temp3.sfba013     ,l_temp3.sfba016     ,
                l_temp3.outqty      ,l_temp3.unitr       ,l_temp3.outqtyr    
               )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT asfp360_tmp02"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #更新需求工单，备料中已拨入数量
      IF NOT cl_null(l_temp3.unitr) THEN
         UPDATE asfp360_02_temp SET inqty_sum = inqty_sum + l_temp3.outqty,
                                    inqtyr_sum= inqtyr_sum + l_temp3.outqtyr
          WHERE sfba002 = l_temp3.sfba002
            AND sfba003 = l_temp3.sfba003
            AND sfba004 = l_temp3.sfba004
            AND sfba005 = l_temp3.sfba005
            AND sfba006 = l_temp3.sfba006
            AND sfba021 = l_temp3.sfba021
            AND sfba014 = l_temp3.sfba014
            AND unitr   = l_temp3.unitr
      ELSE
         UPDATE asfp360_02_temp SET inqty_sum = inqty_sum + l_temp3.outqty,
                                    inqtyr_sum= inqtyr_sum + l_temp3.outqtyr
          WHERE sfba002 = l_temp3.sfba002
            AND sfba003 = l_temp3.sfba003
            AND sfba004 = l_temp3.sfba004
            AND sfba005 = l_temp3.sfba005
            AND sfba006 = l_temp3.sfba006
            AND sfba021 = l_temp3.sfba021
            AND sfba014 = l_temp3.sfba014
            AND unitr IS NULL
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE asfp360_02_temp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #获取来源工单备料asfp360_03_temp3
      IF l_imaf071='1' OR l_imaf081='1' THEN
         CALL asfp360_03_get_temp4(l_temp3.sfaadocno,l_temp3.sfbaseq,l_temp3.sfbaseq1,l_temp3.outqty) RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

#获取来源工单备料批序号asfp360_03_temp4
PUBLIC FUNCTION asfp360_03_get_temp4(p_sfaadocno,p_sfbaseq,p_sfbaseq1,p_outqty)
   DEFINE p_sfaadocno  LIKE sfaa_t.sfaadocno #工单
   DEFINE p_sfbaseq    LIKE sfba_t.sfbaseq   #工单项次
   DEFINE p_sfbaseq1   LIKE sfba_t.sfbaseq1  #工单项序
   DEFINE p_outqty     LIKE sfba_t.sfba016   #拟拨出数量
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_temp4      RECORD
                       sel            LIKE type_t.chr1,     #选择
                       sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                       sfbaseq        LIKE sfba_t.sfbaseq,   #工单项次
                       sfbaseq1       LIKE sfba_t.sfbaseq1,  #工单项序
                       inaodocno      LIKE inao_t.inaodocno,#发料单号
                       inaoseq        LIKE inao_t.inaoseq,  #项次
                       inaoseq1       LIKE inao_t.inaoseq1, #项序
                       inaoseq2       LIKE inao_t.inaoseq2, #序号
                       inao001        LIKE inao_t.inao001,  #料件编号
                       inao008        LIKE inao_t.inao008,  #制造批号
                       inao009        LIKE inao_t.inao009,  #制造序号
                       inao010        LIKE inao_t.inao010,  #制造日期
                       can_outqty     LIKE inao_t.inao012,  #可拨出数量
                       outqty         LIKE inao_t.inao012   #数量
                       END RECORD
   DEFINE l_qty        LIKE inao_t.inao012  #待分配数量
   DEFINE l_back_qty   LIKE inao_t.inao012  #已退数量
   DEFINE l_str1       STRING    #发料单号
   DEFINE l_sfdadocno  LIKE sfda_t.sfdadocno
   DEFINE l_sql        STRING

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_qty = p_outqty   #待分配数量=拟拨出数量
   LET l_sql = "SELECT 'N','',0,0, ",
               "       inaodocno,inaoseq,inaoseq1,inaoseq2, ",
               "       inao001,inao008,inao009,inao010, ",
               "       inao012,0  ",
               "  FROM inao_t  ",
               " WHERE inaoent = ",g_enterprise,
               "   AND inao012 > 0 ",
               "   AND EXISTS ",  #工单所在的发料单号,此处需要已过账的
               "             (SELECT 1 FROM sfda_t,sfdc_t,sfdd_t ",
               "               WHERE sfdaent = sfdcent AND sfdadocno = sfdcdocno ",
               "                 AND sfdcent = sfddent AND sfdcdocno = sfdddocno AND sfdcseq = sfddseq ",
               "                 AND inaoent = sfdcent AND inaodocno = sfdcdocno AND inaoseq = sfdcseq AND inaoseq1 = sfddseq1  ",
               "                 AND sfdcent = ",g_enterprise,
               "                 AND sfdc001 = '",p_sfaadocno,"' ",
               "                 AND sfdc002 = ",p_sfbaseq,
               "                 AND sfdc003 = ",p_sfbaseq1,
               "                 AND sfdc017 = -1 ",  #发料
               "                 AND sfdastus= 'S' ",
               "                 AND inao012 > 0 ",
               "             )",
               " ORDER BY inaodocno,inaoseq,inaoseq1,inaoseq2"
   PREPARE asfp360_03_get_temp4_p FROM l_sql
   DECLARE asfp360_03_get_temp4_c CURSOR FOR asfp360_03_get_temp4_p
   FOREACH asfp360_03_get_temp4_c INTO l_temp4.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_get_temp4_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      LET l_temp4.sfaadocno = p_sfaadocno
      LET l_temp4.sfbaseq   = p_sfbaseq
      LET l_temp4.sfbaseq1  = p_sfbaseq1
      
      #可拨出数量需减去退料数量,没数量的不用产生出来供拨出用
      CALL asfp360_03_get_back_qty(l_temp4.sfaadocno,l_temp4.sfbaseq,l_temp4.sfbaseq1,l_temp4.inao008,l_temp4.inao009) RETURNING l_back_qty
      LET l_temp4.can_outqty = l_temp4.can_outqty - l_back_qty
      IF l_temp4.can_outqty <= 0 THEN
         CONTINUE FOREACH
      END IF
      
      IF l_qty <= l_temp4.can_outqty THEN
         IF l_qty = 0 THEN
            LET l_temp4.sel = 'N'
         ELSE
            LET l_temp4.sel = 'Y'
         END IF
         LET l_temp4.outqty = l_qty
         LET l_qty = 0
      ELSE
         LET l_temp4.sel = 'Y'
         LET l_temp4.outqty = l_temp4.can_outqty
         LET l_qty = l_qty - l_temp4.can_outqty
      END IF
      
      INSERT INTO asfp360_tmp03(sel       ,sfaadocno ,sfbaseq   ,sfbaseq1  ,  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
                                   inaodocno ,inaoseq   ,inaoseq1  ,inaoseq2  ,
                                   inao001   ,inao008   ,inao009   ,inao010   ,
                                   can_outqty,outqty    )
         VALUES(l_temp4.sel       ,l_temp4.sfaadocno ,l_temp4.sfbaseq   ,l_temp4.sfbaseq1  ,
                l_temp4.inaodocno ,l_temp4.inaoseq   ,l_temp4.inaoseq1  ,l_temp4.inaoseq2  ,
                l_temp4.inao001   ,l_temp4.inao008   ,l_temp4.inao009   ,l_temp4.inao010   ,
                l_temp4.can_outqty,l_temp4.outqty    )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT asfp360_tmp03"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH
   
   RETURN r_success
END FUNCTION

#可拨出数量需减去退料数量,没数量的不用产生出来供拨出用
PUBLIC FUNCTION asfp360_03_get_back_qty(p_sfaadocno,p_sfbaseq,p_sfbaseq1,p_inao008,p_inao009)
   DEFINE p_sfaadocno  LIKE sfaa_t.sfaadocno #工单
   DEFINE p_sfbaseq    LIKE sfba_t.sfbaseq   #工单项次
   DEFINE p_sfbaseq1   LIKE sfba_t.sfbaseq1  #工单项序
   DEFINE p_inao008    LIKE inao_t.inao008   #制造批号
   DEFINE p_inao009    LIKE inao_t.inao009   #制造序号
   DEFINE r_back_qty     LIKE inao_t.inao012
   DEFINE l_temp4      RECORD
                       inaodocno      LIKE inao_t.inaodocno,#退料单号
                       inaoseq        LIKE inao_t.inaoseq,  #项次
                       inaoseq1       LIKE inao_t.inaoseq1, #项序
                       inaoseq2       LIKE inao_t.inaoseq2, #序号
                       inao001        LIKE inao_t.inao001,  #料件编号
                       inao008        LIKE inao_t.inao008,  #制造批号
                       inao009        LIKE inao_t.inao009,  #制造序号
                       inao010        LIKE inao_t.inao010,  #制造日期
                       inao012        LIKE inao_t.inao012   #退料量
                       END RECORD
   
   LET r_back_qty = 0
   
   #LET l_sql = "SELECT inaodocno,inaoseq,inaoseq1,inaoseq2, ",
   #            "       inao001,inao008,inao009,inao010,inao012  ",
   #            "  FROM inao_t  ",
   #            " WHERE inaoent = ",g_enterprise,
   #            "   AND inao012 > 0 ",
   #            "   AND inao008 = '",p_inao008,"' AND inao009 = '",p_inao009,"' ",
   #            "   AND EXISTS ",  #工单所在的发料单号,此处只要未作废的均可,面产生的单据跟已有的重复
   #            "             (SELECT 1 FROM sfda_t,sfdc_t,sfdd_t ",
   #            "               WHERE sfdaent = sfdcent AND sfdadocno = sfdcdocno ",
   #            "                 AND sfdcent = sfddent AND sfdcdocno = sfdddocno AND sfdcseq = sfddseq ",
   #            "                 AND inaoent = sfdcent AND inaodocno = sfdcdocno AND inaoseq = sfdcseq AND inaoseq1 = sfddseq1  ",
   #            "                 AND sfdcent = ",g_enterprise,
   #            "                 AND sfdc001 = '",p_sfaadocno,"' ",
   #            "                 AND sfdc002 = ",p_sfbaseq,
   #            "                 AND sfdc003 = ",p_sfbaseq1,
   #            "                 AND sfdc017 = 1 ",  #退料
   #            "                 AND sfdastus!= 'X' ",
   #            "                 AND inao012 > 0 ",
   #            "                 AND inao008 = '",p_inao008,"' AND inao009 = '",p_inao009,"' ",
   #            "             )",
   #            " ORDER BY inaodocno,inaoseq,inaoseq1,inaoseq2"
   #PREPARE asfp360_03_get_back_qty_p FROM l_sql
   #DECLARE asfp360_03_get_back_qty_c CURSOR FOR asfp360_03_get_back_qty_p
   #FOREACH asfp360_03_get_back_qty_c INTO l_temp4.*
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "FOREACH:asfp360_03_get_back_qty_c"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF
   #
   #   LET r_back_qty = r_back_qty + l_temp4.inao012
   #END FOREACH
   #上面foreach sql抄下来的,上面那个先保留，可能要考虑单位
   SELECT SUM(inao012) INTO r_back_qty FROM inao_t
    WHERE inaoent = g_enterprise
      AND inao012 > 0
      AND inao008 = p_inao008 AND inao009 = p_inao009
      AND EXISTS (SELECT 1 FROM sfda_t,sfdc_t,sfdd_t #工单所在的发料单号,此处只要未作废的均可,面产生的单据跟已有的重复
                   WHERE sfdaent = sfdcent AND sfdadocno = sfdcdocno
                     AND sfdcent = sfddent AND sfdcdocno = sfdddocno AND sfdcseq = sfddseq
                     AND inaoent = sfdcent AND inaodocno = sfdcdocno AND inaoseq = sfdcseq AND inaoseq1 = sfddseq1
                     AND sfdcent = g_enterprise AND sfdc001 = p_sfaadocno
                     AND sfdc002 = p_sfbaseq AND sfdc003 = p_sfbaseq1
                     AND sfdc017 = 1   #退料
                     AND sfdastus!= 'X'
                     AND inao012 > 0
                     AND inao008 = p_inao008 AND inao009 = p_inao009)
   IF cl_null(r_back_qty) THEN LET r_back_qty = 0 END IF
   
   RETURN r_back_qty
END FUNCTION

PUBLIC FUNCTION asfp360_03_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx1 = g_curr_diag.getCurrentRow("s_asfp360_03_detail1")
      IF g_detail_idx1 > g_asfp360_03_d1.getLength() THEN
         LET g_detail_idx1 = g_asfp360_03_d1.getLength()
      END IF
      IF g_detail_idx1 = 0 AND g_asfp360_03_d1.getLength() <> 0 THEN
         LET g_detail_idx1 = 1
      END IF
   END IF

   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_asfp360_03_detail2")
      IF g_detail_idx2 > g_asfp360_03_d2.getLength() THEN
         LET g_detail_idx2 = g_asfp360_03_d2.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_asfp360_03_d2.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx3 = g_curr_diag.getCurrentRow("s_asfp360_03_detail3")
      IF g_detail_idx3 > g_asfp360_03_d3.getLength() THEN
         LET g_detail_idx3 = g_asfp360_03_d3.getLength()
      END IF
      IF g_detail_idx3 = 0 AND g_asfp360_03_d3.getLength() <> 0 THEN
         LET g_detail_idx3 = 1
      END IF
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx4 = g_curr_diag.getCurrentRow("s_asfp360_03_detail4")
      IF g_detail_idx4 > g_asfp360_03_d4.getLength() THEN
         LET g_detail_idx4 = g_asfp360_03_d4.getLength()
      END IF
      IF g_detail_idx4 = 0 AND g_asfp360_03_d4.getLength() <> 0 THEN
         LET g_detail_idx4 = 1
      END IF
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx5 = g_curr_diag.getCurrentRow("s_asfp360_03_detail5")
      IF g_detail_idx5 > g_asfp360_03_d5.getLength() THEN
         LET g_detail_idx5 = g_asfp360_03_d5.getLength()
      END IF
      IF g_detail_idx5 = 0 AND g_asfp360_03_d5.getLength() <> 0 THEN
         LET g_detail_idx5 = 1
      END IF
   END IF

END FUNCTION

PUBLIC FUNCTION asfp360_03_upd_temp1(p_ac)
   DEFINE p_ac         LIKE type_t.num10  #更新哪笔     #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_sfba002        LIKE sfba_t.sfba002     #部位
   DEFINE l_sfba003        LIKE sfba_t.sfba003     #作业
   DEFINE l_sfba004        LIKE sfba_t.sfba004     #作业序
   DEFINE l_sfba005        LIKE sfba_t.sfba005     #BOM料号
   DEFINE l_sfba006        LIKE sfba_t.sfba006     #需求料号
   DEFINE l_sfba021        LIKE sfba_t.sfba021     #特征
   DEFINE l_sfba014        LIKE sfba_t.sfba014     #单位
   DEFINE l_unitr          LIKE sfba_t.sfba014     #参考单位

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   UPDATE asfp360_tmp01 SET sel          = g_asfp360_03_d1[p_ac].sel,  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
                               plan_outsets = g_asfp360_03_d1[p_ac].plan_outsets   #拟拨出套数
       WHERE sfaadocno = g_asfp360_03_d1[p_ac].sfaadocno  #工单号
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd asfp360_tmp01'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #更新asfp360_03_temp3
   CALL asfp360_03_upd_temp3_f_temp1(p_ac) RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
          
   #检查并更新asfp360_02_temp需求拨入总数量
   LET l_sql = " SELECT UNIQUE sfba002,sfba003,sfba004,sfba005,sfba006,sfba021,sfba014,unitr ",
               "   FROM asfp360_tmp02 ",   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
               "  WHERE sfaadocno = '",g_asfp360_03_d1[p_ac].sfaadocno,"' "
   PREPARE asfp360_03_upd_temp1_p FROM l_sql
   DECLARE asfp360_03_upd_temp1_c CURSOR FOR asfp360_03_upd_temp1_p
   FOREACH asfp360_03_upd_temp1_c INTO l_sfba002,l_sfba003,l_sfba004,l_sfba005,l_sfba006,l_sfba021,l_sfba014,l_unitr
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_upd_temp1_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      CALL asfp360_03_upd_02_temp(l_sfba002,l_sfba003,
                                  l_sfba004,l_sfba005,
                                  l_sfba006,l_sfba021,
                                  l_sfba014,l_unitr)
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   
   END FOREACH
   CLOSE asfp360_03_upd_temp1_c
   FREE asfp360_03_upd_temp1_p

   RETURN r_success

END FUNCTION

#制程预留
PUBLIC FUNCTION asfp360_03_upd_temp2(p_ac)
   DEFINE p_ac         LIKE type_t.num5  #更新哪笔
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #UPDATE asfp360_03_temp2 SET sel          = g_asfp360_03_d1[p_ac].sel,
   #                            plan_outsets = g_asfp360_03_d1[p_ac].plan_outsets  #拟拨出套数
   #    WHERE sfaadocno = g_asfp360_03_d1[p_ac].sfaadocno  #工单号
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'upd asfp360_03_temp2'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp360_03_upd_temp3(p_ac)
   DEFINE p_ac         LIKE type_t.num10  #更新哪笔    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   #DEFINE l_plan_inqty LIKE sfba_t.sfba013    #拟拨入数量
   #DEFINE l_inqty_sum  LIKE sfba_t.sfba013    #来源拨出数量合计
   #DEFINE l_inqty_sum_o LIKE sfba_t.sfba013    #来源拨出数量合计

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   ##更新需求工单，备料中已拨入数量(此处用旧值_o而非_t因为，栏位没变动一次就直接更新数据库)
   ##先检查拨出数量合计不可大于需求数量
   #SELECT plan_inqty,inqty_sum INTO l_plan_inqty,l_inqty_sum
   #  FROM asfp360_02_temp
   # WHERE sfba002 = g_asfp360_03_d3[p_ac].sfba002
   #   AND sfba003 = g_asfp360_03_d3[p_ac].sfba003
   #   AND sfba004 = g_asfp360_03_d3[p_ac].sfba004
   #   AND sfba005 = g_asfp360_03_d3[p_ac].sfba005
   #   AND sfba006 = g_asfp360_03_d3[p_ac].sfba006
   #   AND sfba021 = g_asfp360_03_d3[p_ac].sfba021
   #   AND sfba014 = g_asfp360_03_d3[p_ac].sfba014
   #   AND unitr   = g_asfp360_03_d3[p_ac].unitr
   #LET l_inqty_sum_o = l_inqty_sum
   #LET l_inqty_sum = l_inqty_sum + g_asfp360_03_d3[p_ac].outqty   - g_asfp360_03_d3_o.outqty
   #IF l_inqty_sum > l_plan_inqty THEN
   #    #拨出数量合计%1不可大于需求数量%2,此处最多可拨出%3
   #    INITIALIZE g_errparam TO NULL
   #    LET g_errparam.code = 'asf-00433'
   #    LET g_errparam.extend = ''
   #    LET g_errparam.popup = TRUE
   #    LET g_errparam.replace[1] = l_inqty_sum
   #    LET g_errparam.replace[2] = l_plan_inqty
   #    LET g_errparam.replace[3] = l_plan_inqty - l_inqty_sum_o + g_asfp360_03_d3_o.outqty
   #    CALL cl_err()
   #    LET r_success=FALSE
   #    RETURN r_success
   #END IF
   #
   #UPDATE asfp360_02_temp SET inqty_sum = inqty_sum + g_asfp360_03_d3[p_ac].outqty   - g_asfp360_03_d3_o.outqty,
   #                           inqtyr_sum= inqtyr_sum + g_asfp360_03_d3[p_ac].outqtyr - g_asfp360_03_d3_o.outqtyr
   # WHERE sfba002 = g_asfp360_03_d3[p_ac].sfba002
   #   AND sfba003 = g_asfp360_03_d3[p_ac].sfba003
   #   AND sfba004 = g_asfp360_03_d3[p_ac].sfba004
   #   AND sfba005 = g_asfp360_03_d3[p_ac].sfba005
   #   AND sfba006 = g_asfp360_03_d3[p_ac].sfba006
   #   AND sfba021 = g_asfp360_03_d3[p_ac].sfba021
   #   AND sfba014 = g_asfp360_03_d3[p_ac].sfba014
   #   AND unitr   = g_asfp360_03_d3[p_ac].unitr
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = "UPDATE asfp360_02_temp"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   
   #检查通过再进行更新
   UPDATE asfp360_tmp02 SET outqty = g_asfp360_03_d3[p_ac].outqty,  #拟拨出数量   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
                               outqtyr= g_asfp360_03_d3[p_ac].outqtyr  #参考单位拨出数量
    WHERE sfaadocno = g_asfp360_03_d1[g_detail_idx1].sfaadocno  #工单号
      AND sfbaseq   = g_asfp360_03_d3[p_ac].sfbaseq    #项次
      AND sfbaseq1  = g_asfp360_03_d3[p_ac].sfbaseq1   #项序
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd asfp360_tmp02'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #检查并更新asfp360_02_temp需求拨入总数量
   CALL asfp360_03_upd_02_temp(g_asfp360_03_d3[p_ac].sfba002,g_asfp360_03_d3[p_ac].sfba003,
                               g_asfp360_03_d3[p_ac].sfba004,g_asfp360_03_d3[p_ac].sfba005,
                               g_asfp360_03_d3[p_ac].sfba006,g_asfp360_03_d3[p_ac].sfba021,
                               g_asfp360_03_d3[p_ac].sfba014,g_asfp360_03_d3[p_ac].unitr)
      RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp360_03_upd_temp4(p_ac)
   DEFINE p_ac         LIKE type_t.num10  #更新哪笔    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   UPDATE asfp360_tmp03 SET sel    = g_asfp360_03_d4[p_ac].sel,  #拟拨出数量  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
                               outqty = g_asfp360_03_d4[p_ac].outqty #参考单位拨出数量
    WHERE sfaadocno = g_asfp360_03_d1[g_detail_idx1].sfaadocno  #工单号
      AND sfbaseq   = g_asfp360_03_d3[g_detail_idx3].sfbaseq    #项次
      AND sfbaseq1  = g_asfp360_03_d3[g_detail_idx3].sfbaseq1   #项序
      AND inaodocno = g_asfp360_03_d4[p_ac].inaodocno
      AND inaoseq   = g_asfp360_03_d4[p_ac].inaoseq  
      AND inaoseq1  = g_asfp360_03_d4[p_ac].inaoseq1 
      AND inaoseq2  = g_asfp360_03_d4[p_ac].inaoseq2 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd asfp360_tmp03'  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp360_03_chk_column_b1(p_ac,p_column)
DEFINE p_ac       LIKE type_t.num10  #传参为null或0 代表全体检查    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE p_column   LIKE type_t.chr20
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_idx      LIKE type_t.num5
DEFINE l_sets       LIKE sfaa_t.sfaa049   #已分配套数

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'sel_03b1'  #选择否
           IF cl_null(g_asfp360_03_d1[p_ac].sel) THEN
              #此字段不可为空
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aqc-00006'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
           IF g_asfp360_03_d1[p_ac].sel NOT MATCHES '[NY]' THEN
              #请输入Y/N
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'agl-00144'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
      WHEN 'plan_outsets_03b1'  #拟拨出套数
           IF cl_null(g_asfp360_03_d1[p_ac].plan_outsets) THEN
              #此字段不可为空
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aqc-00006'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
           IF g_asfp360_03_d1[p_ac].plan_outsets > g_asfp360_03_d1[p_ac].can_outsets THEN
              #不可大于可拨出套数%1
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00431'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = g_asfp360_03_d1[p_ac].can_outsets
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
           #不可大于总需求套数
           SELECT SUM(plan_outsets) INTO l_sets  #其他笔已分配套数
             FROM asfp360_tmp01   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
            WHERE sel = 'Y'
              AND sfaadocno != g_asfp360_03_d1[p_ac].sfaadocno
           IF cl_null(l_sets) THEN LET l_sets = 0 END IF
           IF l_sets + g_asfp360_03_d1[p_ac].plan_outsets > g_asfp360_02_m.insets THEN #分配套数>需求套数
              #总拨出套数%1不可大于需求套数%2，此处最多可拨出%3
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00438'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = l_sets + g_asfp360_03_d1[p_ac].plan_outsets
              LET g_errparam.replace[2] = g_asfp360_02_m.insets
              LET g_errparam.replace[3] = g_asfp360_02_m.insets - g_asfp360_03_d1[p_ac].plan_outsets
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
      OTHERWISE
   END CASE
   
   RETURN r_success
END FUNCTION

#制程预留
PUBLIC FUNCTION asfp360_03_chk_column_b2(p_ac,p_column)
DEFINE p_ac       LIKE type_t.num5  #传参为null或0 代表全体检查
DEFINE p_column   LIKE type_t.chr20
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_idx      LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
  # CASE p_column
  #    WHEN 'sel_03b2'
  #         IF cl_null(g_asfp360_03_d2[p_ac].sel) THEN
  #            #此字段不可为空
  #            INITIALIZE g_errparam TO NULL
  #            LET g_errparam.code = 'aqc-00006'
  #            LET g_errparam.extend = ''
  #            LET g_errparam.popup = TRUE
  #            CALL cl_err()
  #            LET r_success=FALSE
  #            RETURN r_success
  #         END IF
  #         IF g_asfp360_03_d2[p_ac].sel NOT MATCHES '[NY]' THEN
  #            #请输入Y/N
  #            INITIALIZE g_errparam TO NULL
  #            LET g_errparam.code = 'agl-00144'
  #            LET g_errparam.extend = ''
  #            LET g_errparam.popup = TRUE
  #            CALL cl_err()
  #            LET r_success=FALSE
  #            RETURN r_success
  #         END IF
  #    
  #    WHEN 'plan_outqty_03b2'  #拟拨出数量
  #         IF cl_null(g_asfp360_03_d2[p_ac].plan_outqty) THEN
  #            #此字段不可为空
  #            INITIALIZE g_errparam TO NULL
  #            LET g_errparam.code = 'aqc-00006'
  #            LET g_errparam.extend = ''
  #            LET g_errparam.popup = TRUE
  #            CALL cl_err()
  #            LET r_success=FALSE
  #            RETURN r_success
  #         END IF
  #    OTHERWISE
  # END CASE
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp360_03_chk_column_b3(p_ac,p_column)
   DEFINE p_ac          LIKE type_t.num10  #传参为null或0 代表全体检查    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE p_column      LIKE type_t.chr20
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_idx         LIKE type_t.num5
   DEFINE l_plan_inqty LIKE sfba_t.sfba013    #拟拨入数量
   DEFINE l_inqty_sum  LIKE sfba_t.sfba013    #来源拨出数量合计
   DEFINE l_inqty_sum_o LIKE sfba_t.sfba013    #来源拨出数量合计

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'outqty_03b3'  #拟拨出数量
           IF cl_null(g_asfp360_03_d3[p_ac].outqty) THEN
              #此字段不可为空
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aqc-00006'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
           IF g_asfp360_03_d3[p_ac].outqty > g_asfp360_03_d3[p_ac].sfba016 THEN
              #不可大于已发数量%1
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00434'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = g_asfp360_03_d3[p_ac].sfba016
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
           
           #检查拨出数量合计不可大于需求数量
           IF NOT cl_null(g_asfp360_03_d3[p_ac].unitr) THEN
              SELECT plan_inqty,inqty_sum INTO l_plan_inqty,l_inqty_sum
                FROM asfp360_02_temp
               WHERE sfba002 = g_asfp360_03_d3[p_ac].sfba002
                 AND sfba003 = g_asfp360_03_d3[p_ac].sfba003
                 AND sfba004 = g_asfp360_03_d3[p_ac].sfba004
                 AND sfba005 = g_asfp360_03_d3[p_ac].sfba005
                 AND sfba006 = g_asfp360_03_d3[p_ac].sfba006
                 AND sfba021 = g_asfp360_03_d3[p_ac].sfba021
                 AND sfba014 = g_asfp360_03_d3[p_ac].sfba014
                 AND unitr   = g_asfp360_03_d3[p_ac].unitr
           ELSE
              SELECT plan_inqty,inqty_sum INTO l_plan_inqty,l_inqty_sum
                FROM asfp360_02_temp
               WHERE sfba002 = g_asfp360_03_d3[p_ac].sfba002
                 AND sfba003 = g_asfp360_03_d3[p_ac].sfba003
                 AND sfba004 = g_asfp360_03_d3[p_ac].sfba004
                 AND sfba005 = g_asfp360_03_d3[p_ac].sfba005
                 AND sfba006 = g_asfp360_03_d3[p_ac].sfba006
                 AND sfba021 = g_asfp360_03_d3[p_ac].sfba021
                 AND sfba014 = g_asfp360_03_d3[p_ac].sfba014
                 AND unitr IS NULL
           END IF
           LET l_inqty_sum_o = l_inqty_sum
           LET l_inqty_sum = l_inqty_sum + g_asfp360_03_d3[p_ac].outqty - g_asfp360_03_d3_o.outqty
           IF l_inqty_sum > l_plan_inqty THEN
               #拨出数量合计%1不可大于需求数量%2,此处最多可拨出%3
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00433'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_inqty_sum
               LET g_errparam.replace[2] = l_plan_inqty
               LET g_errparam.replace[3] = l_plan_inqty - l_inqty_sum_o + g_asfp360_03_d3_o.outqty
               CALL cl_err()
               LET r_success=FALSE
               RETURN r_success
           END IF
      OTHERWISE
   END CASE
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp360_03_chk_column_b4(p_ac,p_column)
DEFINE p_ac       LIKE type_t.num10  #传参为null或0 代表全体检查   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
DEFINE p_column   LIKE type_t.chr20
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_idx      LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'sel_03b4'  #选择
           #不可为空
           IF cl_null(g_asfp360_03_d4[p_ac].sel) THEN
              #此字段不可为空
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aqc-00006'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
           IF g_asfp360_03_d4[p_ac].sel NOT MATCHES '[NY]' THEN
              #请输入Y/N
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'agl-00144'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
      WHEN 'outqty_03b4'  #数量
           #不可为空
           IF cl_null(g_asfp360_03_d4[p_ac].outqty) THEN
              #此字段不可为空
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aqc-00006'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
           END IF
           IF g_asfp360_03_d4[p_ac].outqty > g_asfp360_03_d4[p_ac].can_outqty THEN
              #不可大于可拨出数量%1
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00432'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = g_asfp360_03_d4[p_ac].can_outqty
              CALL cl_err()
              LET r_success=FALSE
              RETURN r_success
           END IF
      OTHERWISE
   END CASE
   
   RETURN r_success
END FUNCTION

#产生来源工单时，检查来源单身跟需求单身是否匹配，若来源单身没有一笔匹配的，则此工单不显示
PUBLIC FUNCTION asfp360_03_chk_sfaadocno(p_sfaadocno)
   DEFINE p_sfaadocno  LIKE sfaa_t.sfaadocno  #来源工单
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_count      LIKE type_t.num10   #产生单身笔数     #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_temp3      RECORD
                       sfaadocno      LIKE sfaa_t.sfaadocno, #工单单号
                       sfbaseq        LIKE sfba_t.sfbaseq,  #项次
                       sfbaseq1       LIKE sfba_t.sfbaseq1, #项序
                       sfba002        LIKE sfba_t.sfba002,  #部位
                       sfba003        LIKE sfba_t.sfba003,  #作业
                       sfba004        LIKE sfba_t.sfba004,  #作业序
                       sfba005        LIKE sfba_t.sfba005,  #BOM料号
                       sfba006        LIKE sfba_t.sfba006,  #发料料号
                       sfba021        LIKE sfba_t.sfba021,  #特征
                       sfba014        LIKE sfba_t.sfba014,  #单位
                       sfba013        LIKE sfba_t.sfba013,  #应发
                       sfba016        LIKE sfba_t.sfba016,  #已发
                       outqty         LIKE sfba_t.sfba016,  #拟拨出数量
                       unitr          LIKE sfba_t.sfba014,  #参考单位
                       outqtyr        LIKE sfba_t.sfba016,  #参考单位拨出数量
                       sfba010        LIKE sfba_t.sfba010,     #QPA分子
                       sfba011        LIKE sfba_t.sfba011,     #QPA分母
                       sfba022        LIKE sfba_t.sfba022      #替代率
                       END RECORD
   DEFINE l_sql        STRING
   DEFINE l_cnt        LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   WHENEVER ERROR CONTINUE
   LET l_count = 0

   LET l_sql = "SELECT sfbadocno,sfbaseq,sfbaseq1,sfba002,sfba003,",
               "       sfba004,sfba005,sfba006,sfba021,sfba014, ",
               "       sfba013,sfba016,0,imaf015,0,  ",
               "       sfba010,sfba011,sfba022 ",
               "  FROM sfba_t LEFT JOIN imaf_t ON imafent="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfba006 ",
               " WHERE sfbadocno = '",p_sfaadocno,"' ",
               " ORDER BY sfbaseq,sfbaseq1"
   PREPARE asfp360_03_chk_sfaadocno_p FROM l_sql
   DECLARE asfp360_03_chk_sfaadocno_c CURSOR FOR asfp360_03_chk_sfaadocno_p
   FOREACH asfp360_03_chk_sfaadocno_c INTO l_temp3.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp360_03_chk_sfaadocno_c"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      IF cl_null(l_temp3.sfba005) THEN LET l_temp3.sfba005 = ' ' END IF
      
      IF l_temp3.sfba016 <= 0 THEN #已发数量小于等于0
         CONTINUE FOREACH
      END IF
      
      #memo:工单中不应该出现只有替代料，没有原料的情况
      IF NOT cl_null(l_temp3.unitr) THEN
         SELECT COUNT(*) INTO l_cnt FROM asfp360_02_temp
          WHERE sfba002 = l_temp3.sfba002
            AND sfba003 = l_temp3.sfba003
            AND sfba004 = l_temp3.sfba004
            AND sfba005 = l_temp3.sfba005
            AND sfba006 = l_temp3.sfba006
            AND sfba021 = l_temp3.sfba021
            AND sfba014 = l_temp3.sfba014
            AND unitr   = l_temp3.unitr
            AND sel     = 'Y'
      ELSE
         SELECT COUNT(*) INTO l_cnt FROM asfp360_02_temp
          WHERE sfba002 = l_temp3.sfba002
            AND sfba003 = l_temp3.sfba003
            AND sfba004 = l_temp3.sfba004
            AND sfba005 = l_temp3.sfba005
            AND sfba006 = l_temp3.sfba006
            AND sfba021 = l_temp3.sfba021
            AND sfba014 = l_temp3.sfba014
            AND unitr IS NULL
            AND sel     = 'Y'
      END IF
      IF l_cnt > 0 THEN
         LET l_count = l_count + 1
         EXIT FOREACH  #知道有资料了，可以不用再检查下去了，提高效能
      END IF
   
   END FOREACH
   
   IF l_count > 0 THEN
      LET r_success = TRUE
   ELSE
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp360_03_show()
   WHENEVER ERROR CONTINUE
   
   CALL asfp360_03_b_fill1()

   IF cl_null(g_detail_idx1) OR g_detail_idx1=0 THEN
      LET g_detail_idx1 = 1
   END IF
   CALL asfp360_03_b_fill3(g_asfp360_03_d1[g_detail_idx1].sfaadocno)
   
   IF cl_null(g_detail_idx3) OR g_detail_idx3=0 THEN
      LET g_detail_idx3 = 1
   END IF
   CALL asfp360_03_b_fill4(g_asfp360_03_d1[g_detail_idx1].sfaadocno,g_asfp360_03_d3[g_detail_idx3].sfbaseq,g_asfp360_03_d3[g_detail_idx3].sfbaseq1)
   CALL asfp360_03_b_fill5(g_asfp360_03_d3[g_detail_idx3].sfba002,g_asfp360_03_d3[g_detail_idx3].sfba003,
                           g_asfp360_03_d3[g_detail_idx3].sfba004,g_asfp360_03_d3[g_detail_idx3].sfba005,
                           g_asfp360_03_d3[g_detail_idx3].sfba006,g_asfp360_03_d3[g_detail_idx3].sfba021,
                           g_asfp360_03_d3[g_detail_idx3].sfba014,g_asfp360_03_d3[g_detail_idx3].unitr)
END FUNCTION

#更新需求数量
PUBLIC FUNCTION asfp360_03_upd_02_temp(p_sfba002,p_sfba003,p_sfba004,p_sfba005,p_sfba006,p_sfba021,p_sfba014,p_unitr)
   DEFINE p_ac         LIKE type_t.num5  #更新哪笔
   DEFINE p_sfba002        LIKE sfba_t.sfba002     #部位
   DEFINE p_sfba003        LIKE sfba_t.sfba003     #作业
   DEFINE p_sfba004        LIKE sfba_t.sfba004     #作业序
   DEFINE p_sfba005        LIKE sfba_t.sfba005     #BOM料号
   DEFINE p_sfba006        LIKE sfba_t.sfba006     #需求料号
   DEFINE p_sfba021        LIKE sfba_t.sfba021     #特征
   DEFINE p_sfba014        LIKE sfba_t.sfba014     #单位
   DEFINE p_unitr          LIKE sfba_t.sfba014     #参考单位
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_plan_inqty LIKE sfba_t.sfba013    #拟拨入数量
   DEFINE l_inqty_sum  LIKE sfba_t.sfba013    #来源拨出数量合计
   DEFINE l_inqtyr_sum  LIKE sfba_t.sfba013    #来源拨出数量合计

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #先检查拨出数量合计不可大于需求数量
   
   #计算拟拨入数量:l_plan_inqty
   IF NOT cl_null(p_unitr) THEN
      SELECT plan_inqty INTO l_plan_inqty
        FROM asfp360_02_temp
       WHERE sfba002 = p_sfba002
         AND sfba003 = p_sfba003
         AND sfba004 = p_sfba004
         AND sfba005 = p_sfba005
         AND sfba006 = p_sfba006
         AND sfba021 = p_sfba021
         AND sfba014 = p_sfba014
         AND unitr   = p_unitr
   ELSE
      SELECT plan_inqty INTO l_plan_inqty
        FROM asfp360_02_temp
       WHERE sfba002 = p_sfba002
         AND sfba003 = p_sfba003
         AND sfba004 = p_sfba004
         AND sfba005 = p_sfba005
         AND sfba006 = p_sfba006
         AND sfba021 = p_sfba021
         AND sfba014 = p_sfba014
         AND unitr IS NULL
   END IF
   #计算来源拨出数量合计:l_inqty_sum
   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
   IF NOT cl_null(p_unitr) THEN
      SELECT SUM(asfp360_tmp02.outqty),SUM(asfp360_tmp02.outqtyr) INTO l_inqty_sum,l_inqtyr_sum
        FROM asfp360_tmp02,asfp360_tmp01   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
       WHERE asfp360_tmp02.sfaadocno = asfp360_tmp01.sfaadocno  #工单号  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
         AND asfp360_tmp01.sel     = 'Y'   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
         AND asfp360_tmp02.sfba002 = p_sfba002
         AND asfp360_tmp02.sfba003 = p_sfba003
         AND asfp360_tmp02.sfba004 = p_sfba004
         AND asfp360_tmp02.sfba005 = p_sfba005
         AND asfp360_tmp02.sfba006 = p_sfba006
         AND asfp360_tmp02.sfba021 = p_sfba021
         AND asfp360_tmp02.sfba014 = p_sfba014
         AND asfp360_tmp02.unitr   = p_unitr
   ELSE
      SELECT SUM(asfp360_tmp02.outqty),SUM(asfp360_tmp02.outqtyr) INTO l_inqty_sum,l_inqtyr_sum
        FROM asfp360_tmp02,asfp360_tmp01  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
       WHERE asfp360_tmp02.sfaadocno = asfp360_tmp01.sfaadocno  #工单号  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
         AND asfp360_tmp01.sel     = 'Y'     #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp1 ——> asfp360_tmp01
         AND asfp360_tmp02.sfba002 = p_sfba002
         AND asfp360_tmp02.sfba003 = p_sfba003
         AND asfp360_tmp02.sfba004 = p_sfba004
         AND asfp360_tmp02.sfba005 = p_sfba005
         AND asfp360_tmp02.sfba006 = p_sfba006
         AND asfp360_tmp02.sfba021 = p_sfba021
         AND asfp360_tmp02.sfba014 = p_sfba014
         AND asfp360_tmp02.unitr IS NULL
   END IF
   IF cl_null(l_inqty_sum) THEN LET l_inqty_sum = 0 END IF
   IF cl_null(l_inqtyr_sum) THEN LET l_inqtyr_sum = 0 END IF
   
   IF l_inqty_sum > l_plan_inqty THEN
       #拨出数量合计%1不可大于需求数量%2
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'asf-00436'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = l_inqty_sum
       LET g_errparam.replace[2] = l_plan_inqty
       CALL cl_err()
       LET r_success=FALSE
       RETURN r_success
   END IF
   
   IF NOT cl_null(p_unitr) THEN
      UPDATE asfp360_02_temp SET inqty_sum = l_inqty_sum,  #inqty_sum + g_asfp360_03_d3[p_ac].outqty   - g_asfp360_03_d3_o.outqty,
                                 inqtyr_sum= l_inqtyr_sum  #inqtyr_sum + g_asfp360_03_d3[p_ac].outqtyr - g_asfp360_03_d3_o.outqtyr
       WHERE sfba002 = p_sfba002
         AND sfba003 = p_sfba003
         AND sfba004 = p_sfba004
         AND sfba005 = p_sfba005
         AND sfba006 = p_sfba006
         AND sfba021 = p_sfba021
         AND sfba014 = p_sfba014
         AND unitr   = p_unitr
   ELSE
      UPDATE asfp360_02_temp SET inqty_sum = l_inqty_sum,  #inqty_sum + g_asfp360_03_d3[p_ac].outqty   - g_asfp360_03_d3_o.outqty,
                                 inqtyr_sum= l_inqtyr_sum  #inqtyr_sum + g_asfp360_03_d3[p_ac].outqtyr - g_asfp360_03_d3_o.outqtyr
       WHERE sfba002 = p_sfba002
         AND sfba003 = p_sfba003
         AND sfba004 = p_sfba004
         AND sfba005 = p_sfba005
         AND sfba006 = p_sfba006
         AND sfba021 = p_sfba021
         AND sfba014 = p_sfba014
         AND unitr IS NULL
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE asfp360_02_temp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

#因更新temp1，联动更新temp3
PUBLIC FUNCTION asfp360_03_upd_temp3_f_temp1(p_ac)
   DEFINE p_ac         LIKE type_t.num10  #更新哪笔     #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_outqty     LIKE sfba_t.sfba016
   DEFINE l_outqtyr    LIKE sfba_t.sfba016

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #对应的单身重新default
   #asfp360_02_temp 在upd_temp1中会去调用更新的
   #先清空
   UPDATE asfp360_tmp02 SET outqty = 0,   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
                               outqtyr= 0
    WHERE sfaadocno = g_asfp360_03_d1[p_ac].sfaadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd asfp360_tmp02"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp3 ——> asfp360_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   UPDATE asfp360_tmp03 SET sel    = 'N',   #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
                               outqty = 0
    WHERE sfaadocno = g_asfp360_03_d1[p_ac].sfaadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd asfp360_tmp03"  #160727-00019#17   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp360_03_temp4 ——> asfp360_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #重新分配
   IF g_asfp360_03_d1[p_ac].sel = 'Y' THEN
      #刷新来源工单备料asfp360_03_temp3
      CALL asfp360_03_get_temp3('u',g_asfp360_03_d1[p_ac].sfaadocno,g_asfp360_03_d1[p_ac].plan_outsets) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success

END FUNCTION

 
{</section>}
 
