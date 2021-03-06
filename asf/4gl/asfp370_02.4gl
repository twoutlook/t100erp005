#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp370_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-06-20 17:01:00), PR版次:0008(2017-01-06 15:24:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000114
#+ Filename...: asfp370_02
#+ Description: 發料前調撥作業—庫存分配
#+ Creator....: 00768(2014-07-01 15:49:41)
#+ Modifier...: 04441 -SD/PR- 00700
 
{</section>}
 
{<section id="asfp370_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#150101 单位转换率改写
#160512-00004#1   16/06/20  By Whitney inai012製造日期改抓inae010
#160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02,asfp370_02_temp3 ——> asfp370_tmp03,asfp370_02_temp5 ——> asfp370_tmp04
#161109-00085#41 2016/11/17 By lienjunqi    整批調整系統星號寫法
#170104-00066#2  2017/01/06  By Rainy     筆數相關變數由num5放大至num10
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
#GLOBALS "../4gl/asfp370_02.inc"
GLOBALS "../../asf/4gl/asfp370.inc"
#end add-point
 
{</section>}
 
{<section id="asfp370_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="asfp370_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_rec_b2          LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_rec_b3          LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_rec_b5          LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 

DEFINE l_ac                  LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_master_idx2         LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_master_idx3         LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_master_idx5         LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
#end add-point
 
{</section>}
 
{<section id="asfp370_02.other_dialog" >}

DIALOG asfp370_02_construct()
   CONSTRUCT BY NAME g_wc_02 ON inag004,inag005

      BEFORE CONSTRUCT

      AFTER CONSTRUCT
      
      ON ACTION controlp INFIELD inag004  #撥出庫位
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " inaastus ='Y' "
         CALL q_inaa001_2()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO inag004  #顯示到畫面上
         NEXT FIELD inag004                    #返回原欄位
         
      ON ACTION controlp INFIELD inag005  #撥出儲位
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " inabstus ='Y' "
         CALL q_inab002_1()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO inag005  #顯示到畫面上
         NEXT FIELD inag005                    #返回原欄位
         
      ON ACTION sel_ware  #产生库存资料
         CALL asfp370_02_sel_ware()
         CALL asfp370_02_b_fill('Y')
      
   END CONSTRUCT
END DIALOG

DIALOG asfp370_02_input()

   INPUT BY NAME g_asfp370_02_m.chief_default ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT

      AFTER INPUT
         
      AFTER FIELD chief_default
         IF cl_null(g_asfp370_02_m.chief_default) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aqc-00006'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            NEXT FIELD CURRENT
         END IF
         IF g_asfp370_02_m.chief_default NOT MATCHES '[NY]' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00144'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            NEXT FIELD CURRENT
         END IF

      ON ACTION sel_ware  #产生库存资料
         CALL asfp370_02_sel_ware()
         CALL asfp370_02_b_fill('Y')
      
   END INPUT
END DIALOG

DIALOG asfp370_02_display2()
   DISPLAY ARRAY g_sfdc02_d TO s_detail2_asfp370_02.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail2_asfp370_02")
        LET g_master_idx2 = l_ac
        CALL asfp370_02_b_fill3()
        IF g_rec_b3 = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code =  'ain-00308'
           LET g_errparam.extend =  ''
           LET g_errparam.popup = FALSE
           CALL cl_err()
        END IF
         
   END DISPLAY
END DIALOG

DIALOG asfp370_02_display3()
   DISPLAY ARRAY g_inag_d TO s_detail3_asfp370_02.* ATTRIBUTE(COUNT = g_rec_b3)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail3_asfp370_02")
        LET g_master_idx3 = l_ac
        CALL asfp370_02_b_fill5()

   END DISPLAY

END DIALOG

DIALOG asfp370_02_display5()
   DISPLAY ARRAY g_inai_d TO s_detail5_asfp370_02.* ATTRIBUTE(COUNT = g_rec_b5)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail5_asfp370_02")
        LET g_master_idx5 = l_ac

   END DISPLAY

END DIALOG
#库存资料页签
DIALOG asfp370_02_input3()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_isdiff  LIKE type_t.num5     #是否有差异 true/false 计算调拨最小量 批量用
   DEFINE l_qty     LIKE inag_t.inag008  #既满足调拨批量 又满足最小调拨数量 的最小数量
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_imaf102 LIKE imaf_t.imaf102  #最小调拨数量
   DEFINE l_string  STRING
   
   INPUT ARRAY g_inag_d FROM s_detail3_asfp370_02.*
       ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
               
       BEFORE INPUT
          IF g_master_idx2 = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00355'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             
             EXIT DIALOG
          END IF
          
       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_master_idx3 = l_ac
          LET g_inag_d_t.* = g_inag_d[l_ac].*
          LET g_inag_d_o.* = g_inag_d[l_ac].*
          CALL asfp370_02_b_fill5()
          CALL cl_set_comp_entry("qtyr_02_3",TRUE)
          IF cl_null(g_inag_d[l_ac].inag024) THEN
             CALL cl_set_comp_entry("qtyr_02_3",FALSE)
          END IF
       
       ON CHANGE sel_02_3
          #IF g_inag_d[l_ac].sel = 'N' THEN
          #   LET g_inag_d[l_ac].qty = 0
          #   LET g_inag_d[l_ac].qtyr= 0
          #ELSE
          #   IF g_inag_d[l_ac].qty = 0 THEN
          #      NEXT FIELD qty_02_3
          #   END IF
          #END IF
          
          #不可为空
          IF cl_null(g_inag_d[l_ac].sel) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00006'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inag_d[l_ac].sel = g_inag_d_o.sel
             NEXT FIELD sel_02_3
          END IF
          IF g_inag_d[l_ac].sel NOT MATCHES '[NY]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00144'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inag_d[l_ac].sel = g_inag_d_o.sel
             NEXT FIELD sel_02_3
          END IF
          
          #更新临时表
          CALL asfp370_02_upd_temp3(l_ac,'Y') RETURNING l_success
          IF NOT l_success THEN
             LET g_inag_d[l_ac].sel = g_inag_d_o.sel
             NEXT FIELD sel_02_3
          END IF
          #刷新单身显示
          CALL asfp370_02_b_fill('Y')
          
          LET g_inag_d_o.sel = g_inag_d[l_ac].sel

       ON CHANGE qty_02_3
       #AFTER FIELD qty_02_3
          #不可为空
          IF cl_null(g_inag_d[l_ac].qty) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00006'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inag_d[l_ac].qty = g_inag_d_o.qty
             NEXT FIELD qty_02_3
          END IF
          #不可小于0
          IF g_inag_d[l_ac].qty < 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00041'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inag_d[l_ac].qty = g_inag_d_o.qty
             NEXT FIELD qty_02_3
          END IF
          #不可大于库存数量
          IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00369'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             
             LET g_inag_d[l_ac].qty = g_inag_d_o.qty
             NEXT FIELD qty_02_3
          END IF
          
         #检查调拨最小数量和批量
          CALL asfp370_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
          IF l_isdiff THEN
             SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
              WHERE imafent = g_enterprise
                AND imafsite = g_site
                AND imaf001 = g_sfdc02_d[g_master_idx2].sfdc004
             IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
             IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
             #当前数量不符合调拨批量%1和最小调拨量2%，是否继续？
             LET l_string = l_imaf101,"|",l_imaf102
             IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
          END IF
          
          #总数不可大于拟调拨的差异数量 在asfp370_02_upd_temp()中判断，提高操作灵活性
          
          IF g_inag_d[l_ac].qty > 0 THEN
             LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
          END IF
          
          #计算参考单位数量
          IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
             #mark 150101
             #CALL s_aimi190_get_convert(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag024) RETURNING l_success,l_rate
             #IF NOT l_success THEN
             #   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
             #   NEXT FIELD qty_02_3
             #END IF
             #LET g_inag_d[l_ac].qtyr = g_inag_d[l_ac].qty * l_rate
             #mark 150101 end
             
             #add 150101
             CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag024,g_inag_d[l_ac].qty)
                RETURNING l_success,g_inag_d[l_ac].qtyr
             IF NOT l_success THEN
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qty_02_3
             END IF
             #add 150101 end
             
             IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00369'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                
                LET g_inag_d_o.qty = g_inag_d[l_ac].qty
                NEXT FIELD qtyr_02_3
             END IF
          END IF
          
          #更新临时表
          CALL asfp370_02_upd_temp3(l_ac,'Y') RETURNING l_success
          IF NOT l_success THEN
             LET g_inag_d[l_ac].qty = g_inag_d_o.qty
             NEXT FIELD qty_02_3
          END IF
          #刷新单身显示
          CALL asfp370_02_b_fill('Y')
          
          LET g_inag_d_o.qty = g_inag_d[l_ac].qty
          LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr  #add 150101
       
       ON CHANGE qtyr_02_3
       #AFTER FIELD qtyr_02_3
          #不可为空
          IF cl_null(g_inag_d[l_ac].qtyr) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00006'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
             NEXT FIELD qtyr_02_3
          END IF
          #不可小于0
          IF g_inag_d[l_ac].qtyr < 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00041'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
             NEXT FIELD qtyr_02_3
          END IF
          IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
             #不可大于库存数量
             IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00369'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF
             IF g_inag_d[l_ac].qtyr >0 AND g_inag_d[l_ac].qty=0 THEN #计算单位数量
                #mark 150101
                #CALL s_aimi190_get_convert(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007) RETURNING l_success,l_rate
                #IF NOT l_success THEN
                #   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                #   NEXT FIELD qtyr_02_3
                #END IF
                #LET g_inag_d[l_ac].qty = g_inag_d[l_ac].qtyr * l_rate
                #mark 150101 end
                #add 150101
                CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007,g_inag_d[l_ac].qtyr)
                   RETURNING l_success,g_inag_d[l_ac].qty
                IF NOT l_success THEN
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   LET g_inag_d[l_ac].qty  = g_inag_d_o.qty
                   NEXT FIELD qtyr_02_3
                END IF
                #add 150101 end
                IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'asf-00369'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   
                   LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
                   NEXT FIELD qty_02_3
                END IF
                
               #检查调拨最小数量和批量
               CALL asfp370_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
               IF l_isdiff THEN
                  SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = p_item
                  IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                  IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                   #当前数量不符合调拨批量10和最小调拨量10，是否继续？
                   LET l_string = l_imaf101,"|",l_imaf102
                   IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                      LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                      NEXT FIELD qty_02_3
                   END IF
               END IF

                IF g_inag_d[l_ac].qty > 0 THEN
                   LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
                END IF
             END IF
          END IF
          
          #更新临时表
          CALL asfp370_02_upd_temp3(l_ac,'Y') RETURNING l_success
          IF NOT l_success THEN
             LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
             NEXT FIELD qtyr_02_3
          END IF
          #刷新单身显示
          CALL asfp370_02_b_fill('Y')
          
          LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
          LET g_inag_d_o.qty  = g_inag_d[l_ac].qty  #add 150101

       ON CHANGE pack_02_3
          #輸入值須存在[T:料件包裝資料檔].[C:包裝容器編號]，錯誤訊息「此料沒有
          IF NOT cl_null(g_inag_d[l_ac].pack) THEN
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inag_d[l_ac].pack
             IF NOT cl_chk_exist("v_imaa001_3") THEN
                LET g_inag_d[l_ac].pack = g_inag_d_o.pack
                NEXT FIELD pack_02_3
             END IF
          END IF
          #更新临时表
          CALL asfp370_02_upd_temp3(l_ac,'N') RETURNING l_success
          IF NOT l_success THEN
             LET g_inag_d[l_ac].pack = g_inag_d_o.pack
             NEXT FIELD pack_02_3
          END IF
          #刷新单身显示
          CALL asfp370_02_b_fill('Y')
          
          LET g_inag_d_o.pack = g_inag_d[l_ac].pack
          
       ON ACTION controlp INFIELD pack_02_3
       #包装容器
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.default1 = g_inag_d[l_ac].pack
          CALL q_imaa001_11()
          LET g_inag_d[l_ac].pack = g_qryparam.return1     #將開窗取得的值>
          NEXT FIELD pack_02_3

       ON ROW CHANGE

       AFTER INPUT
          #这里不能检查，因为上一步也会走到这里
          #若不检查，也不能做更新的动作，否则数据就可能会不对
          
       #此处不好用，还需输入数量，并对数量做管控
       #ON ACTION selall
       #   CALL asfp370_02_sel_all("Y","inag")
       #
       #ON ACTION selnone
       #   CALL asfp370_02_sel_all("N","inag")
       
   END INPUT

END DIALOG

#批序号页签
DIALOG asfp370_02_input5()
   DEFINE l_qty_sum    LIKE sfdc_t.sfdc007
   DEFINE l_imaf071    LIKE imaf_t.imaf071
   DEFINE l_imaf081    LIKE imaf_t.imaf081
   DEFINE l_success    LIKE type_t.num5
   
   INPUT ARRAY g_inai_d FROM s_detail5_asfp370_02.*
       ATTRIBUTE(COUNT = g_rec_b5,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
       BEFORE INPUT
          IF g_master_idx3 = 0 OR cl_null(g_inag_d[g_master_idx3].seq) THEN
             EXIT DIALOG
          END IF
       
       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_master_idx5 = l_ac
          LET g_inai_d_t.* = g_inai_d[l_ac].*
          LET g_inai_d_o.* = g_inai_d[l_ac].*
          
       ON CHANGE sel_02_5
          #IF g_inai_d[l_ac].sel = 'N' THEN
          #   LET g_inai_d[l_ac].qty = 0
          #ELSE
          #   IF g_inai_d[l_ac].qty = 0 THEN
          #      LET g_inai_d[l_ac].sel = g_inai_d_o.sel
          #      NEXT FIELD qty_02_5
          #   END IF
          #END IF
          
       #AFTER FIELD sel_02_5
          IF cl_null(g_inai_d[l_ac].sel) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00006'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inai_d[l_ac].sel = g_inai_d_o.sel
             NEXT FIELD sel_02_5
          END IF
          IF g_inai_d[l_ac].sel NOT MATCHES '[NY]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00144'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inai_d[l_ac].sel = g_inai_d_o.sel
             NEXT FIELD sel_02_5
          END IF
          IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
             UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                         qty = g_inai_d[l_ac].qty
              WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                AND sfdc009 IS NULL  #参考单位
                AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                AND seq     = g_inag_d[g_master_idx3].seq      #项次
                AND seq1    = g_inai_d[l_ac].seq1              #项序
          ELSE
             UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                         qty = g_inai_d[l_ac].qty
              WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
                AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                AND seq     = g_inag_d[g_master_idx3].seq      #项次
                AND seq1    = g_inai_d[l_ac].seq1              #项序
          END IF
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inai_d[l_ac].sel = g_inai_d_o.sel
             NEXT FIELD sel_02_5
          END IF
       
          LET g_inai_d_o.sel = g_inai_d[l_ac].sel
       
       ON CHANGE qty_02_5
       #AFTER FIELD qty_02_5
          #不可为空
          IF cl_null(g_inai_d[l_ac].qty) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00006'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inai_d[l_ac].qty = g_inai_d_o.qty
             NEXT FIELD qty_02_5
          END IF
          #不可小于0
          IF g_inai_d[l_ac].qty < 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00041'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inai_d[l_ac].qty = g_inai_d_o.qty
             NEXT FIELD qty_02_5
          END IF
          #不可大于库存数量
          IF g_inai_d[l_ac].qty > g_inai_d[l_ac].inai010 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'asf-00369'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             
             LET g_inai_d[l_ac].qty = g_inai_d_o.qty
             NEXT FIELD qty_02_5
          END IF
          IF g_inai_d[l_ac].qty > 0 THEN
             LET g_inai_d[l_ac].sel = 'Y'  #不用自己再去勾选
          END IF
          
          IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
             UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                         qty = g_inai_d[l_ac].qty
              WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                AND sfdc009 IS NULL  #参考单位
                AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                AND seq     = g_inag_d[g_master_idx3].seq      #项次
                AND seq1    = g_inai_d[l_ac].seq1              #项序
          ELSE
             UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                         qty = g_inai_d[l_ac].qty
              WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
                AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                AND seq     = g_inag_d[g_master_idx3].seq      #项次
                AND seq1    = g_inai_d[l_ac].seq1              #项序
          END IF
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_inai_d[l_ac].qty = g_inai_d_o.qty
             NEXT FIELD qty_02_5
          END IF

          LET g_inai_d_o.qty = g_inai_d[l_ac].qty
          
       ON ROW CHANGE
      

       AFTER INPUT
          #能否进入到下一步的判断不能写在这，因为上一步也会走到这段
          CALL asfp370_02_upd_temp('0') RETURNING l_success #更新temp3 temp2
          IF NOT l_success THEN
             NEXT FIELD sel_02_5
          END IF

       #此处不好用，还需输入数量，并对数量做管控
       #ON ACTION selall
       #   CALL asfp370_02_sel_all("Y","inai")
       #
       #ON ACTION selnone
       #   CALL asfp370_02_sel_all("N","inai")
       
   END INPUT
END DIALOG

 
{</section>}
 
{<section id="asfp370_02.other_function" readonly="Y" >}

#畫面資料初始化
PUBLIC FUNCTION asfp370_02_init()
   
   WHENEVER ERROR CONTINUE
   
   CALL cl_set_comp_visible("pack_02_3",FALSE) #add 141118 包装容器隐藏
   
   #當整體參數有使用參考單位時才顯示
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_visible("sfdc009_02,sfdc010_02,inag025_02,diffr_02,sum_qtyr_02",FALSE) #參考單位
      CALL cl_set_comp_visible("inag024_02_3,inag025_02_3,qtyr_02_3",FALSE) #參考單位
   END IF


END FUNCTION

PUBLIC FUNCTION asfp370_02_b_fill(p_flag)
   DEFINE p_flag       LIKE type_t.chr1   #Y展开 N不展开
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   CALL g_sfdc02_d.clear()
   
   LET l_sql = "SELECT UNIQUE sfdc004,imaal003,imaal004,sfdc005, ",
               "       sfdc006,sfdc007,inag008,0, ",
               "       sfdc009,sfdc010,inag025,0, ",
               "       sfdc012,sfdc013,sum_qty,sum_qtyr ",
               "  FROM asfp370_tmp02 LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=sfdc004 AND imaal002='"||g_dlang||"' ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
               " ORDER BY sfdc004"
   PREPARE asfp370_02_b_fill_sel FROM l_sql
   DECLARE asfp370_02_b_fill_curs CURSOR FOR asfp370_02_b_fill_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"
   FOREACH asfp370_02_b_fill_curs INTO g_sfdc02_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      #计算差异量
      LET g_sfdc02_d[l_ac].diff  = g_sfdc02_d[l_ac].sfdc007 - g_sfdc02_d[l_ac].inag008     #差异数量
      IF g_sfdc02_d[l_ac].diff < 0 THEN
         LET g_sfdc02_d[l_ac].diff = 0
      END IF
      
      #计算参考单位差异量
      LET g_sfdc02_d[l_ac].diffr = g_sfdc02_d[l_ac].sfdc010 - g_sfdc02_d[l_ac].inag025     #参考单位差异数量
      IF g_sfdc02_d[l_ac].diffr < 0 THEN
         LET g_sfdc02_d[l_ac].diffr = 0
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b2 = l_ac - 1
   CALL g_sfdc02_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE asfp370_02_b_fill_curs
   FREE asfp370_02_b_fill_sel
   
   #LET g_master_idx2 = l_ac
   IF cl_null(g_master_idx2) OR g_master_idx2 = 0 THEN
      LET g_master_idx2 = 1
   END IF
   
   IF p_flag = 'Y' THEN
      CALL asfp370_02_b_fill3()
   END IF
END FUNCTION

PUBLIC FUNCTION asfp370_02_b_fill3()
   DEFINE l_ac_t      LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_sql       STRING

   WHENEVER ERROR CONTINUE
   CALL g_inag_d.clear()

   IF cl_null(g_master_idx2) OR g_master_idx2=0 THEN
      RETURN
   END IF
   
   IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
      LET l_sql = "SELECT sel    ,seq    ,inag004,inaa002,inag005,inab003, ",
                  "       inag006,inag003,inag007,inag008,inag024,inag025, ",
                  "       pack   ,qty    ,qtyr   ",
                  "  FROM asfp370_tmp03  LEFT JOIN inaa_t ON inaaent="||g_enterprise||" AND inaasite='"||g_site||"' AND inaa001=inag004  ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                  "                         LEFT JOIN inab_t ON inabent="||g_enterprise||" AND inabsite='"||g_site||"' AND inab001=inag004 AND inab002=inag005  ",
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 IS NULL ",  #参考单位
                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  " ORDER BY seq "
   ELSE
      LET l_sql = "SELECT sel    ,seq    ,inag004,inaa002,inag005,inab003, ",
                  "       inag006,inag003,inag007,inag008,inag024,inag025, ",
                  "       pack   ,qty    ,qtyr   ",
                  "  FROM asfp370_tmp03  LEFT JOIN inaa_t ON inaaent="||g_enterprise||" AND inaasite='"||g_site||"' AND inaa001=inag004  ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                  "                         LEFT JOIN inab_t ON inabent="||g_enterprise||" AND inabsite='"||g_site||"' AND inab001=inag004 AND inab002=inag005  ",
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 = '",g_sfdc02_d[g_master_idx2].sfdc009,"' ",  #参考单位
                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  " ORDER BY seq "
   END IF
   PREPARE asfp370_02_b_fill3_sel FROM l_sql
   DECLARE asfp370_02_b_fill3_curs CURSOR FOR asfp370_02_b_fill3_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   FOREACH asfp370_02_b_fill3_curs INTO g_inag_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_b_fill3_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b3 = l_ac - 1
   CALL g_inag_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE asfp370_02_b_fill3_curs
   FREE asfp370_02_b_fill3_sel
   
   #LET g_master_idx3 = l_ac
   IF cl_null(g_master_idx3) OR g_master_idx3 = 0 THEN
      LET g_master_idx3 = 1
   END IF
   IF g_rec_b3 > 0 THEN
      CALL asfp370_02_b_fill5()
   END IF

END FUNCTION

PUBLIC FUNCTION asfp370_02_b_fill5()
   DEFINE l_ac_t      LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_sql       STRING
   
   WHENEVER ERROR CONTINUE
   CALL g_inai_d.clear()
   
   IF cl_null(g_master_idx2) OR g_master_idx2=0
   OR cl_null(g_master_idx3) OR g_master_idx3=0 THEN
      RETURN
   END IF
   IF cl_null(g_inag_d[g_master_idx3].seq) THEN
      RETURN
   END IF
   #IF cl_null(g_master_idx2) OR g_master_idx2=0 THEN
   #   LET g_master_idx2 = 1
   #END IF
   #IF cl_null(g_master_idx3) OR g_master_idx3=0 THEN
   #   LET g_master_idx3 = 1
   #END IF
   
   IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
      LET l_sql = "SELECT sel    ,seq    ,seq1   , ",
                  "       inai007,inai008,inae010,inai010,qty ",  #160512-00004#1 by whitney modify inai012->inae010
                  "  FROM asfp370_tmp04",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 IS NULL ",  #参考单位
                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  "   AND seq     =  ",g_inag_d[g_master_idx3].seq,   #库存资料页签的项次
                  " ORDER BY seq,seq1 "
   ELSE
      LET l_sql = "SELECT sel    ,seq    ,seq1   , ",
                  "       inai007,inai008,inae010,inai010,qty ",  #160512-00004#1 by whitney modify inai012->inae010
                  "  FROM asfp370_tmp04",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                  " WHERE sfdc004 = '",g_sfdc02_d[g_master_idx2].sfdc004,"' ",  #料件编号
                  "   AND sfdc005 = '",g_sfdc02_d[g_master_idx2].sfdc005,"' ",  #产品特征
                  "   AND sfdc006 = '",g_sfdc02_d[g_master_idx2].sfdc006,"' ",  #单位
                  "   AND sfdc009 = '",g_sfdc02_d[g_master_idx2].sfdc009,"' ",  #参考单位
                  "   AND sfdc012 = '",g_sfdc02_d[g_master_idx2].sfdc012,"' ",  #拨入库位
                  "   AND sfdc013 = '",g_sfdc02_d[g_master_idx2].sfdc013,"' ",  #拨入储位
                  "   AND seq     =  ",g_inag_d[g_master_idx3].seq,   #库存资料页签的项次
                  " ORDER BY seq,seq1 "
   END IF
   PREPARE asfp370_02_b_fill5_sel FROM l_sql
   DECLARE asfp370_02_b_fill5_curs CURSOR FOR asfp370_02_b_fill5_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   FOREACH asfp370_02_b_fill5_curs INTO g_inai_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_b_fill5_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   LET g_rec_b5 = l_ac - 1
   CALL g_inai_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE asfp370_02_b_fill5_curs
   FREE asfp370_02_b_fill5_sel

   #LET g_master_idx5 = l_ac
   IF cl_null(g_master_idx5) OR g_master_idx5 = 0 THEN
      LET g_master_idx5 = 1
   END IF
END FUNCTION

PUBLIC FUNCTION asfp370_02_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT asfp370_02_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF


   CREATE TEMP TABLE asfp370_tmp02(  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号
      sfdc005              LIKE sfdc_t.sfdc005,     #特征
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
      sfdc007              LIKE sfdc_t.sfdc007,     #申请数量
      inag008              LIKE inag_t.inag008,     #库存数量
      sfdc010              LIKE sfdc_t.sfdc010,     #参考单位申请数量
      inag025              LIKE inag_t.inag025,     #参考单位库存数量
      sum_qty              LIKE sfdc_t.sfdc007,     #拟拨入数量合计
      sum_qtyr             LIKE sfdc_t.sfdc010      #拟拨入参考数量合计
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp370_tmp02'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp370_tmp02_01 on asfp370_tmp02 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013)  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp370_tmp02'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE asfp370_tmp03(  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号  inag001
      sfdc005              LIKE sfdc_t.sfdc005,     #特征      inag002
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
      sel                  LIKE type_t.chr1,        #选择
      seq                  LIKE type_t.num5,        #项次
      inag004              LIKE inag_t.inag004,     #拨出库位
      inag005              LIKE inag_t.inag005,     #拨出储位
      inag006              LIKE inag_t.inag006,     #拨出批号
      inag003              LIKE inag_t.inag003,     #库存管理特征
      inag007              LIKE inag_t.inag007,     #单位
      inag008              LIKE inag_t.inag008,     #库存数量
      inag024              LIKE inag_t.inag024,     #参考单位
      inag025              LIKE inag_t.inag025,     #参考单位库存数量
      pack                 LIKE imaa_t.imaa001,     #包装容器
      qty                  LIKE inag_t.inag008,     #拨出数量
      qtyr                 LIKE inag_t.inag025      #拨出参考数量
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp370_tmp03'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp370_tmp03_01 on asfp370_tmp03 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,seq)  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp370_tmp03'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE asfp370_tmp04(   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
      sfdc004              LIKE sfdc_t.sfdc004,     #需求料号  inai001
      sfdc005              LIKE sfdc_t.sfdc005,     #特征      inai002
      sfdc006              LIKE sfdc_t.sfdc006,     #单位
      sfdc009              LIKE sfdc_t.sfdc009,     #参考单位
      sfdc012              LIKE sfdc_t.sfdc012,     #拨入库位
      sfdc013              LIKE sfdc_t.sfdc013,     #拨入储位
      sel                  LIKE type_t.chr1,        #选择
      seq                  LIKE type_t.num5,        #项次
      seq1                 LIKE type_t.num5,        #项序
      inai007              LIKE inai_t.inai007,     #制造序号
      inai008              LIKE inai_t.inai008,     #制造批号
     #inai012              LIKE inai_t.inai012,     #制造日期  #160512-00004#1 by whitney mark
      inae010              LIKE inae_t.inae010,     #制造日期  #160512-00004#1 by whitney add
      inai010              LIKE inai_t.inai010,     #库存数量
      qty                  LIKE inai_t.inai010      #拨出数量
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asfp370_tmp04_01 on asfp370_tmp04 (sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,seq,seq1)  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asfp370_tmp04'   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success

END FUNCTION

PUBLIC FUNCTION asfp370_02_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE asfp370_tmp02  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp370_tmp02'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE asfp370_tmp03  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp370_tmp03'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE asfp370_tmp04  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success

END FUNCTION

#删除临时表中的资料
PUBLIC FUNCTION asfp370_02_delete_temp_table()
   WHENEVER ERROR CONTINUE
   
   DELETE FROM asfp370_tmp02  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
   DELETE FROM asfp370_tmp03  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
   DELETE FROM asfp370_tmp04  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
   
END FUNCTION

PUBLIC FUNCTION asfp370_02_sel_all(p_flag,p_table)
   DEFINE p_flag         LIKE type_t.chr1
   DEFINE p_table        LIKE type_t.chr10
#   DEFINE l_i            LIKE type_t.num5
#
#   CASE
#      WHEN 'inag'
#           FOR l_i = 1 TO g_rec_b3
#               LET g_inag_d[l_i].sel = p_flag
#               #更新临时表
#               UPDATE asfp370_02_temp3 SET sel = g_inag_d[l_i].sel
#                WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
#                  AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
#                  AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
#                  AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
#                  AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
#                  AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
#                  AND seq     = g_inag_d[l_i].seq              #项次
#               IF SQLCA.sqlcode THEN
#                  #CALL cl_err('upd asfp370_02_temp3',SQLCA.sqlcode,1)
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = 'upd asfp370_02_temp3'
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  EXIT FOR
#               END IF 
#               #自动处理inai
#           END FOR
#      WHEN 'inai'
#           FOR l_i = 1 TO g_rec_b5
#               LET g_inai_d[l_i].sel = p_flag
#               #更新临时表
#               UPDATE asfp370_02_temp5 SET sel = g_inai_d[l_i].sel
#                WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
#                  AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
#                  AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
#                  AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
#                  AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
#                  AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
#                  AND seq     = g_inag_d[g_master_idx3].seq      #项次
#                  AND seq1    = g_inai_d[l_i].seq1               #项序
#               IF SQLCA.sqlcode THEN
#                  #CALL cl_err('upd asfp370_02_temp5',SQLCA.sqlcode,1)
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = 'upd asfp370_02_temp5'
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  EXIT FOR
#               END IF
#               #检查inai汇总与inag一致          
#           END FOR
#   END CASE
END FUNCTION

#产生库存资料
PUBLIC FUNCTION asfp370_02_sel_ware()
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_sql2      STRING
   DEFINE l_sql3      STRING
   DEFINE l_sfdc004   LIKE sfdc_t.sfdc004 #需求料号
   DEFINE l_sfdc005   LIKE sfdc_t.sfdc005 #特征
   DEFINE l_sfdc006   LIKE sfdc_t.sfdc006 #单位
   DEFINE l_sfdc009   LIKE sfdc_t.sfdc009 #参考单位
   DEFINE l_sfdc012   LIKE sfdc_t.sfdc012 #拨入库位
   DEFINE l_sfdc013   LIKE sfdc_t.sfdc013 #拨入储位
   DEFINE l_diff      LIKE sfdc_t.sfdc007 #差异数量
   DEFINE l_diffr     LIKE sfdc_t.sfdc007 #参考单位差异数量
   DEFINE l_imaf053   LIKE imaf_t.imaf053 #库存单位
   DEFINE l_imaf054   LIKE imaf_t.imaf054 #多单位
   DEFINE l_imaf091   LIKE imaf_t.imaf091 #预设库位
   DEFINE l_imaf071   LIKE imaf_t.imaf071
   DEFINE l_imaf081   LIKE imaf_t.imaf081
   #161109-00085#41-s
   #DEFINE l_inag      RECORD LIKE inag_t.*
   DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企業編號
       inagsite LIKE inag_t.inagsite, #營運據點
       inag001 LIKE inag_t.inag001, #料件編號
       inag002 LIKE inag_t.inag002, #產品特徵
       inag003 LIKE inag_t.inag003, #庫存管理特徵
       inag004 LIKE inag_t.inag004, #庫位編號
       inag005 LIKE inag_t.inag005, #儲位編號
       inag006 LIKE inag_t.inag006, #批號
       inag007 LIKE inag_t.inag007, #庫存單位
       inag008 LIKE inag_t.inag008, #帳面庫存數量
       inag009 LIKE inag_t.inag009, #實際庫存數量
       inag010 LIKE inag_t.inag010, #庫存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本庫否
       inag013 LIKE inag_t.inag013, #揀貨優先序
       inag014 LIKE inag_t.inag014, #最近一次盤點日期
       inag015 LIKE inag_t.inag015, #最後異動日期
       inag016 LIKE inag_t.inag016, #呆滯日期
       inag017 LIKE inag_t.inag017, #第一次入庫日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #備置數量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二進位碼
       inag024 LIKE inag_t.inag024, #參考單位
       inag025 LIKE inag_t.inag025, #參考數量
       inag026 LIKE inag_t.inag026, #最近一次檢驗日期
       inag027 LIKE inag_t.inag027, #下次檢驗日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人員
       inag030 LIKE inag_t.inag030, #留置部門
       inag031 LIKE inag_t.inag031, #留置單號
       inag032 LIKE inag_t.inag032, #基礎單位
       inag033 LIKE inag_t.inag033 #基礎單位數量
   END RECORD   
   #161109-00085#41-e
   #161109-00085#41-s
   #DEFINE l_inai      RECORD LIKE inai_t.*
   DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企業編號
       inaisite LIKE inai_t.inaisite, #營運據點
       inai001 LIKE inai_t.inai001, #料件編號
       inai002 LIKE inai_t.inai002, #產品特徵
       inai003 LIKE inai_t.inai003, #庫存管理特徵
       inai004 LIKE inai_t.inai004, #庫位編號
       inai005 LIKE inai_t.inai005, #儲位編號
       inai006 LIKE inai_t.inai006, #批號
       inai007 LIKE inai_t.inai007, #製造批號
       inai008 LIKE inai_t.inai008, #製造序號
       inai009 LIKE inai_t.inai009, #庫存單位
       inai010 LIKE inai_t.inai010, #帳面基礎單位庫存數量
       inai011 LIKE inai_t.inai011, #實際基礎單位庫存數量
       inai012 LIKE inai_t.inai012, #NO USE
       inai013 LIKE inai_t.inai013, #Tag二進位碼
       inai014 LIKE inai_t.inai014  #基礎單位
   END RECORD
   #161109-00085#41-e
   DEFINE l_seq       LIKE type_t.num5
   DEFINE l_seq1      LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_inag007   LIKE inag_t.inag007  #单位
   DEFINE l_inag008   LIKE inag_t.inag008  #库存数量
   DEFINE l_inag024   LIKE inag_t.inag024  #参考单位
   DEFINE l_inag025   LIKE inag_t.inag025  #参考单位库存数量
   DEFINE l_inag004   LIKE inag_t.inag004  #拨出库位
   DEFINE l_qty       LIKE sfdc_t.sfdc007  #分配数量
   DEFINE l_qtyr      LIKE sfdc_t.sfdc007  #分配参考单位数量
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_rate2     LIKE inaj_t.inaj014  #参考单位换算率
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_min_qty   LIKE sfdc_t.sfdc007  #计算调拨最小量 批量用
   DEFINE l_max_qty   LIKE sfdc_t.sfdc007  #计算调拨最小量 批量用
   DEFINE l_rate3     LIKE inaj_t.inaj014  #计算调拨最小量 批量用
   DEFINE l_isdiff    LIKE type_t.num5      #是否有差异 true/false 计算调拨最小量 批量用
   DEFINE l_qty_t     LIKE inag_t.inag008  #数量 临时变量  #add 150101
   DEFINE l_inae010   LIKE inae_t.inae010  #160512-00004#1 by whitney add
   
   WHENEVER ERROR CONTINUE
   
   SELECT COUNT(*) INTO l_cnt FROM asfp370_tmp03  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
   IF l_cnt > 0 THEN
      #已存在庫存資料，是否重新產生？
      IF cl_ask_confirm('asf-00370') THEN
         DELETE FROM asfp370_tmp03  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
         DELETE FROM asfp370_tmp04  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
      ELSE
         RETURN
      END IF
   END IF
   
   IF cl_null(g_wc_02) THEN
      LET g_wc_02 = " 1=1"
   END IF
   
   ########################################################################
   #信息获取
   ########################################################################
   #160512-00004#1 by whitney modify start
   #LET l_sql3 = " SELECT * FROM inai_t ",
   #             "  WHERE inaient = ",g_enterprise,
   #             "    AND inaisite= '",g_site,"' ",
   #             "    AND inai001 = ? ", #料号
   #             "    AND inai002 = ? ", #特征
   #             "    AND inai003 = ? ", #庫存管理特徵
   #             "    AND inai004 = ? ", #庫位編號
   #             "    AND inai005 = ? ", #儲位編號
   #             "    AND inai006 = ? ", #批號
   #             "    AND inai009 = ? ", #庫存單位
   #             " ORDER BY inai012 "
   #LET l_sql3 = " SELECT inae010,inai_t.* FROM inai_t ",   #161109-00085#41  MARK
   #161109-00085#41-s
   LET l_sql3 = " SELECT inae010,inaient,inaisite,inai001,inai002,
                         inai003,inai004,inai005,inai006,inai007,
                         inai008,inai009,inai010,inai011,inai012,
                         inai013,inai014
                    FROM inai_t ",
   #161109-00085#41-e
                "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
                "  WHERE inaient = ",g_enterprise,
                "    AND inaisite= '",g_site,"' ",
                "    AND inai001 = ? ", #料号
                "    AND inai002 = ? ", #特征
                "    AND inai003 = ? ", #庫存管理特徵
                "    AND inai004 = ? ", #庫位編號
                "    AND inai005 = ? ", #儲位編號
                "    AND inai006 = ? ", #批號
                "    AND inai009 = ? ", #庫存單位
                " ORDER BY inae010 "
   #160512-00004#1 by whitney modify end
   PREPARE asfp370_02_sel_ware_sel3 FROM l_sql3
   DECLARE asfp370_02_sel_ware_curs3 CURSOR FOR asfp370_02_sel_ware_sel3

   #                    需求料号 特征    单位    参考单位 拨入库位 拨入储位 库存单位 多单位
   LET l_sql = " SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,imaf053,imaf054,imaf071,imaf081 ",
               "   FROM asfp370_tmp02 LEFT JOIN imaf_t ON imafent="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfdc004  "  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
   PREPARE asfp370_02_sel_ware_sel FROM l_sql
   DECLARE asfp370_02_sel_ware_curs CURSOR FOR asfp370_02_sel_ware_sel
   FOREACH asfp370_02_sel_ware_curs INTO l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_imaf053,l_imaf054,l_imaf071,l_imaf081
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_sel_ware_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF l_imaf054 = 'N' AND cl_null(l_imaf053) THEN  #库存多单位
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00476'
         LET g_errparam.extend = l_sfdc004
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      ##--begin inag--
      #LET l_sql2= " SELECT * FROM inag_t ",
      #161109-00085#41-s
      LET l_sql2= " SELECT inagent,inagsite,inag001,inag002,inag003,inag004,
                           inag005,inag006,inag007,inag008,inag009,inag010,
                           inag011,inag012,inag013,inag014,inag015,inag016,
                           inag017,inag018,inag019,inag020,inag021,inag022,
                           inag023,inag024,inag025,inag026,inag027,inag028,
                           inag029,inag030,inag031,inag032,inag033 
                      FROM inag_t ",
      #161109-00085#41-e
                  "  WHERE inagent = ",g_enterprise,
                  "    AND inagsite= '",g_site,"' ",
                  "    AND inag001 = '",l_sfdc004,"' ", #料号
                  "    AND inag002 = '",l_sfdc005,"' ", #特征
                  "    AND ",g_wc_02 CLIPPED
                  
      #N 只能从存储为库存单位的那笔库存资料中出库
      #Y 只能从存储为单据上指定单位的那笔库存资料中
      IF l_imaf054 = 'N' THEN  #库存多单位
         LET l_sql2 = l_sql2 CLIPPED," AND inag007 = '",l_imaf053,"' " #据点库存单位
      END IF
      PREPARE asfp370_02_sel_ware_sel2 FROM l_sql2
      DECLARE asfp370_02_sel_ware_curs2 CURSOR FOR asfp370_02_sel_ware_sel2
      LET l_seq = 0
      #FOREACH asfp370_02_sel_ware_curs2 INTO l_inag.* #161109-00085#41 MARK
      #161109-00085#41-s
      FOREACH asfp370_02_sel_ware_curs2 
         INTO l_inag.inagent,l_inag.inagsite,l_inag.inag001,l_inag.inag002,l_inag.inag003,l_inag.inag004,
              l_inag.inag005,l_inag.inag006,l_inag.inag007,l_inag.inag008,l_inag.inag009,l_inag.inag010,
              l_inag.inag011,l_inag.inag012,l_inag.inag013,l_inag.inag014,l_inag.inag015,l_inag.inag016,
              l_inag.inag017,l_inag.inag018,l_inag.inag019,l_inag.inag020,l_inag.inag021,l_inag.inag022,
              l_inag.inag023,l_inag.inag024,l_inag.inag025,l_inag.inag026,l_inag.inag027,l_inag.inag028,
              l_inag.inag029,l_inag.inag030,l_inag.inag031,l_inag.inag032,l_inag.inag033
      #161109-00085#41-e      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp370_02_sel_ware_curs2"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
         #库存不足的不需要产生
         IF l_inag.inag008 <= 0 THEN
            CONTINUE FOREACH
         END IF
         
         #与拨入库储一致的不需要产生
         IF l_inag.inag004 = l_sfdc012 AND l_inag.inag005 = l_sfdc013 THEN
            CONTINUE FOREACH
         END IF
         
         LET l_seq = l_seq + 1
         INSERT INTO asfp370_tmp03(sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                      sel    ,seq    ,inag004,inag005,inag006,inag003,
                                      inag007,inag008,inag024,inag025,pack   ,qty    ,qtyr   )
            VALUES(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,
                   'N'      ,l_seq    ,l_inag.inag004,l_inag.inag005,l_inag.inag006,l_inag.inag003,
                   l_inag.inag007,l_inag.inag008,l_inag.inag024,l_inag.inag025,'',0,0
                  )
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins asfp370_tmp03'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         ##--begin inai--
         IF l_imaf071='1' OR l_imaf081='1' THEN
            LET l_seq1 = 0
            FOREACH asfp370_02_sel_ware_curs3 USING l_inag.inag001,l_inag.inag002,l_inag.inag003,l_inag.inag004,l_inag.inag005,l_inag.inag006,l_inag.inag007                                               
               #161109-00085#41-s
               #INTO l_inae010,l_inai.*  #160512-00004#1 by whitney add l_inae010
               INTO l_inae010,l_inai.inaient,l_inai.inaisite,l_inai.inai001,l_inai.inai002,l_inai.inai003,l_inai.inai004,
                    l_inai.inai005,l_inai.inai006,l_inai.inai007,l_inai.inai008,l_inai.inai009,
                    l_inai.inai010,l_inai.inai011,l_inai.inai012,l_inai.inai013,l_inai.inai014
               #161109-00085#41-e                                
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:asfp370_02_sel_ware_curs3"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF
            
               IF l_inai.inai010 <= 0 THEN
                  CONTINUE FOREACH
               END IF
               
               LET l_seq1 = l_seq1 + 1
               #160512-00004#1 by whitney modify start
               #INSERT INTO asfp370_02_temp5(sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,
               #                             sel    ,seq    ,seq1   ,inai007,inai008,inai012,
               #                             inai010,qty    )
               #   VALUES(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,
               #          'N'      ,l_seq    ,l_seq1   ,l_inai.inai007,l_inai.inai008,l_inai.inai012,
               #          l_inai.inai010,0)
               INSERT INTO asfp370_tmp04(sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            sel    ,seq    ,seq1   ,inai007,inai008,inae010,
                                            inai010,qty    )
                  VALUES(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,
                         'N'      ,l_seq    ,l_seq1   ,l_inai.inai007,l_inai.inai008,l_inae010,
                         l_inai.inai010,0)
               #160512-00004#1 by whitney modify end
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'ins asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF
            END FOREACH
            CLOSE asfp370_02_sel_ware_curs3
            FREE asfp370_02_sel_ware_sel3
         END IF
         ##--end inai--
      
      END FOREACH
      CLOSE asfp370_02_sel_ware_curs2
      FREE asfp370_02_sel_ware_sel2
      ##--end inag--
      
   END FOREACH
   CLOSE asfp370_02_sel_ware_curs
   FREE asfp370_02_sel_ware_sel
   #--end asfp370_02_temp2
   
   ########################################################################
   #数量预设
   ########################################################################
   ##inag库存-第一轮
   #LET l_sql2= " SELECT seq,inag004,inag007,inag008,inag024,inag025 ",
   #            "   FROM asfp370_02_temp3 ",
   #            "  WHERE sfdc004 = ? ",
   #            "    AND sfdc005 = ? ",
   #            "    AND sfdc006 = ? ",
   #            "    AND sfdc009 = ? ",
   #            "    AND sfdc012 = ? ",
   #            "    AND sfdc013 = ? "
   #PREPARE asfp370_02_sel_ware_sel21 FROM l_sql2
   #DECLARE asfp370_02_sel_ware_curs21 CURSOR FOR asfp370_02_sel_ware_sel21
   #
   ###inag库存-第二轮 排除sel=Y的
   #LET l_sql2= " SELECT seq,inag007,inag008,inag024,inag025 ",
   #            "   FROM asfp370_02_temp3 ",
   #            "  WHERE sfdc004 = ? ",
   #            "    AND sfdc005 = ? ",
   #            "    AND sfdc006 = ? ",
   #            "    AND sfdc009 = ? ",
   #            "    AND sfdc012 = ? ",
   #            "    AND sfdc013 = ? ",
   #            "    AND sel     = 'N' "
   #PREPARE asfp370_02_sel_ware_sel22 FROM l_sql2
   #DECLARE asfp370_02_sel_ware_curs22 CURSOR FOR asfp370_02_sel_ware_sel22
   
   LET l_sql = " SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,(sfdc007-inag008),(sfdc010-inag025),imaf091 ",
               "   FROM asfp370_tmp02 LEFT JOIN imaf_t ON imafent="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfdc004  "  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
   PREPARE asfp370_02_sel_ware_sel20 FROM l_sql
   DECLARE asfp370_02_sel_ware_curs20 CURSOR FOR asfp370_02_sel_ware_sel20
   FOREACH asfp370_02_sel_ware_curs20 INTO l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_diff,l_diffr,l_imaf091
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_sel_ware_curs20"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF l_diff < 0 THEN LET l_diff = 0 END IF
      IF l_diffr< 0 THEN LET l_diffr= 0 END IF
      IF l_diff = 0 THEN  #不需要调拨
         CONTINUE FOREACH
      END IF

      CALL asfp370_02_inflate_qty('1',l_sfdc004,l_diff) RETURNING l_isdiff,l_diff  #计算满足调拨最小量和批量的数量
      
      #--数量预设，第一轮回，处理主要库存--
      #“從料件主要倉庫撥出”勾選:產生資料時主要倉庫對應資料自動勾選aimm212中的预设库位imaf091
      #“從料件主要倉庫撥出”勾選  & 主要仓库非空
      IF g_asfp370_02_m.chief_default = 'Y' AND NOT cl_null(l_imaf091) THEN
         #inag库存-第一轮
         IF l_sfdc009 IS NULL THEN
            LET l_sql2= " SELECT seq,inag004,inag007,inag008,inag024,inag025 ",
                        "   FROM asfp370_tmp03 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                        "  WHERE sfdc004 = '",l_sfdc004,"' ",
                        "    AND sfdc005 = '",l_sfdc005,"' ",
                        "    AND sfdc006 = '",l_sfdc006,"' ",
                        "    AND sfdc009 IS NULL ",
                        "    AND sfdc012 = '",l_sfdc012,"' ",
                        "    AND sfdc013 = '",l_sfdc013,"' "
         ELSE
            LET l_sql2= " SELECT seq,inag004,inag007,inag008,inag024,inag025 ",
                        "   FROM asfp370_tmp03 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                        "  WHERE sfdc004 = '",l_sfdc004,"' ",
                        "    AND sfdc005 = '",l_sfdc005,"' ",
                        "    AND sfdc006 = '",l_sfdc006,"' ",
                        "    AND sfdc009 = '",l_sfdc009,"' ",
                        "    AND sfdc012 = '",l_sfdc012,"' ",
                        "    AND sfdc013 = '",l_sfdc013,"' "
         END IF
         PREPARE asfp370_02_sel_ware_sel21 FROM l_sql2
         DECLARE asfp370_02_sel_ware_curs21 CURSOR FOR asfp370_02_sel_ware_sel21
         #FOREACH asfp370_02_sel_ware_curs21 USING l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013
         FOREACH asfp370_02_sel_ware_curs21
                                             INTO l_seq,l_inag004,l_inag007,l_inag008,l_inag024,l_inag025
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:asfp370_02_sel_ware_curs21"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            IF l_imaf091 = l_inag004 THEN  #仓库=主要仓库
               #mark 150101
               ##单位转换
               #CALL s_aimi190_get_convert(l_sfdc004,l_inag007,l_sfdc006) RETURNING l_success,l_rate
               #IF NOT l_success THEN
               #   CONTINUE FOREACH
               #END IF
               ##参考单位换算率
               #IF NOT cl_null(l_sfdc009) THEN
               #   CALL s_aimi190_get_convert(l_sfdc004,l_inag024,l_sfdc009) RETURNING l_success,l_rate2
               #   IF NOT l_success THEN
               #      CONTINUE FOREACH
               #   END IF
               #   CALL s_aimi190_get_convert(l_sfdc004,l_sfdc006,l_sfdc009) RETURNING l_success,l_rate3
               #   IF NOT l_success THEN
               #      CONTINUE FOREACH
               #   END IF
               #ELSE
               #   LET l_rate2 = 1
               #END IF
               #mark 150101 end
               #IF l_diff > l_inag008 * l_rate THEN #mark 150101
               #add 150101
               CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_inag008)
                  RETURNING l_success,l_qty_t
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
               IF l_diff > l_qty_t THEN
               #add 150101 end
                  #LET l_qty   = l_inag008
                  #LET l_qtyr  = l_inag025
                  #LET l_diff  = l_diff  - l_inag008 * l_rate
                  #LET l_diffr = l_diffr - l_inag025 * l_rate2
                  CALL asfp370_02_min_qty(l_sfdc004) RETURNING l_min_qty  #最小可发量
                  IF l_inag008 > l_min_qty THEN
                     CALL asfp370_02_max_qty(l_sfdc004,l_inag008) RETURNING l_max_qty  #最大可发量
                     LET l_qty   = l_max_qty
                     #mark 150101
                     #LET l_qtyr  = l_max_qty * l_rate3
                     #LET l_diff  = l_diff  - l_qty  * l_rate
                     #LET l_diffr = l_diffr - l_qtyr * l_rate2
                     #mark 150101 end
                     #add 150101
                     #l_qtyr
                     CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_sfdc009,l_max_qty) RETURNING l_success,l_qtyr
                     IF NOT l_success THEN
                        CONTINUE FOREACH
                     END IF
                     #l_diff
                     CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_qty) RETURNING l_success,l_qty_t
                     IF NOT l_success THEN
                        CONTINUE FOREACH
                     END IF
                     LET l_diff  = l_diff  - l_qty_t
                     #l_diffr
                     IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
                        LET l_diffr = l_diffr - l_qtyr
                     ELSE
                        CALL s_aooi250_convert_qty(l_sfdc004,l_inag024,l_sfdc009,l_qtyr) RETURNING l_success,l_qty_t
                        IF NOT l_success THEN
                           CONTINUE FOREACH
                        END IF
                        LET l_diffr = l_diffr - l_qty_t
                     END IF
                     #add 150101 end
                  ELSE
                     CONTINUE FOREACH
                  END IF
               ELSE
                  #mark 150101
                  #LET l_qty   = l_diff  / l_rate
                  #LET l_qtyr  = l_diffr / l_rate2
                  #mark 150101 end
                  #add 150101
                  #l_qty
                  CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_inag007,l_diff) RETURNING l_success,l_qty
                  IF NOT l_success THEN
                     CONTINUE FOREACH
                  END IF
                  #l_qtyr
                  IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
                     LET l_qtyr  = l_diffr
                  ELSE
                     CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc009,l_inag024,l_diffr) RETURNING l_success,l_qtyr
                     IF NOT l_success THEN
                        CONTINUE FOREACH
                     END IF
                  END IF
                  #add 150101 end
                  LET l_diff  = 0
                  LET l_diffr = 0
               END IF
               
               IF l_sfdc009 IS NULL THEN
                  UPDATE asfp370_tmp03 SET sel = 'Y',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                              qty = l_qty ,
                                              qtyr= l_qtyr
                   WHERE sfdc004 = l_sfdc004  #料件编号
                     AND sfdc005 = l_sfdc005  #产品特征
                     AND sfdc006 = l_sfdc006  #单位
                     AND sfdc009 IS NULL  #参考单位
                     AND sfdc012 = l_sfdc012  #拨入库位
                     AND sfdc013 = l_sfdc013  #拨入储位
                     AND seq     = l_seq      #项次
               ELSE
                  UPDATE asfp370_tmp03 SET sel = 'Y',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                              qty = l_qty ,
                                              qtyr= l_qtyr
                   WHERE sfdc004 = l_sfdc004  #料件编号
                     AND sfdc005 = l_sfdc005  #产品特征
                     AND sfdc006 = l_sfdc006  #单位
                     AND sfdc009 = l_sfdc009  #参考单位
                     AND sfdc012 = l_sfdc012  #拨入库位
                     AND sfdc013 = l_sfdc013  #拨入储位
                     AND seq     = l_seq      #项次
               END IF
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "UPDATE asfp370_tmp03"  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT FOREACH
               END IF  
               #处理批序号管理
               CALL asfp370_02_upd_temp5(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_seq,l_qty)
                  RETURNING l_success
               IF NOT l_success THEN
                  EXIT FOREACH
               END IF             
            END IF
            IF l_diff = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
         CLOSE asfp370_02_sel_ware_curs21
         FREE asfp370_02_sel_ware_sel21
      END IF
      
      #第一轮结束，已分配完，无需做第二轮分配
      IF l_diff = 0 THEN
         CONTINUE FOREACH
      END IF
      
      #--数量预设，第二轮回，处理其他库存--
      ###inag库存-第二轮 排除sel=Y的
      IF l_sfdc009 IS NULL THEN
         LET l_sql2= " SELECT seq,inag007,inag008,inag024,inag025 ",
                     "   FROM asfp370_tmp03 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                     "  WHERE sfdc004 = '",l_sfdc004,"' ",
                     "    AND sfdc005 = '",l_sfdc005,"' ",
                     "    AND sfdc006 = '",l_sfdc006,"' ",
                     "    AND sfdc009 IS NULL ",
                     "    AND sfdc012 = '",l_sfdc012,"' ",
                     "    AND sfdc013 = '",l_sfdc013,"' ",
                     "    AND sel     = 'N' "
      ELSE
         LET l_sql2= " SELECT seq,inag007,inag008,inag024,inag025 ",
                     "   FROM asfp370_tmp03 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                     "  WHERE sfdc004 = '",l_sfdc004,"' ",
                     "    AND sfdc005 = '",l_sfdc005,"' ",
                     "    AND sfdc006 = '",l_sfdc006,"' ",
                     "    AND sfdc009 = '",l_sfdc009,"' ",
                     "    AND sfdc012 = '",l_sfdc012,"' ",
                     "    AND sfdc013 = '",l_sfdc013,"' ",
                     "    AND sel     = 'N' "
      END IF
      PREPARE asfp370_02_sel_ware_sel22 FROM l_sql2
      DECLARE asfp370_02_sel_ware_curs22 CURSOR FOR asfp370_02_sel_ware_sel22
      #FOREACH asfp370_02_sel_ware_curs22 USING l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013
      FOREACH asfp370_02_sel_ware_curs22 
                                          INTO l_seq,l_inag007,l_inag008,l_inag024,l_inag025
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp370_02_sel_ware_curs22"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         #mark 150101
         ##单位转换
         #CALL s_aimi190_get_convert(l_sfdc004,l_inag007,l_sfdc006) RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   CONTINUE FOREACH
         #END IF
         ##参考单位换算率
         #IF NOT cl_null(l_sfdc009) THEN
         #   CALL s_aimi190_get_convert(l_sfdc004,l_inag024,l_sfdc009) RETURNING l_success,l_rate2
         #   IF NOT l_success THEN
         #      CONTINUE FOREACH
         #   END IF
         #   CALL s_aimi190_get_convert(l_sfdc004,l_sfdc006,l_sfdc009) RETURNING l_success,l_rate3
         #   IF NOT l_success THEN
         #      CONTINUE FOREACH
         #   END IF
         #ELSE
         #   LET l_rate2 = 1
         #END IF
         #mark 150101 end
         #IF l_diff > l_inag008 * l_rate THEN #mark 150101
         #add 150101
         CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_inag008)
            RETURNING l_success,l_qty_t
         IF NOT l_success THEN
            CONTINUE FOREACH
         END IF
         IF l_diff > l_qty_t THEN
         #add 150101 end
            #LET l_qty   = l_inag008
            #LET l_qtyr  = l_inag025
            #LET l_diff  = l_diff  - l_inag008 * l_rate
            #LET l_diffr = l_diffr - l_inag025 * l_rate2
            CALL asfp370_02_min_qty(l_sfdc004) RETURNING l_min_qty  #最小可发量
            IF l_inag008 > l_min_qty THEN
               CALL asfp370_02_max_qty(l_sfdc004,l_inag008) RETURNING l_max_qty  #最大可发量
               LET l_qty   = l_max_qty
               #mark 150101
               #LET l_qtyr  = l_max_qty * l_rate3
               #LET l_diff  = l_diff  - l_qty  * l_rate
               #LET l_diffr = l_diffr - l_qtyr * l_rate2
               #mark 150101 end
               #add 150101
               #l_qtyr
               CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_sfdc009,l_max_qty) RETURNING l_success,l_qtyr
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
               #l_diff
               CALL s_aooi250_convert_qty(l_sfdc004,l_inag007,l_sfdc006,l_qty) RETURNING l_success,l_qty_t
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
               LET l_diff  = l_diff  - l_qty_t
               #l_diffr
               IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
                  LET l_diffr = l_diffr - l_qtyr
               ELSE
                  CALL s_aooi250_convert_qty(l_sfdc004,l_inag024,l_sfdc009,l_qtyr) RETURNING l_success,l_qty_t
                  IF NOT l_success THEN
                     CONTINUE FOREACH
                  END IF
                  LET l_diffr = l_diffr - l_qty_t
               END IF
               #add 150101 end
            ELSE
               CONTINUE FOREACH
            END IF
         ELSE
            #mark 150101
            #LET l_qty   = l_diff  / l_rate
            #LET l_qtyr  = l_diffr / l_rate2
            #mark 150101 end
            #add 150101
            #l_qty
            CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_inag007,l_diff) RETURNING l_success,l_qty
            IF NOT l_success THEN
               CONTINUE FOREACH
            END IF
            #l_qtyr
            IF cl_null(l_sfdc009) OR cl_null(l_inag024) THEN
               LET l_qtyr  = l_diffr
            ELSE
               CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc009,l_inag024,l_diffr) RETURNING l_success,l_qtyr
               IF NOT l_success THEN
                  CONTINUE FOREACH
               END IF
            END IF
            #add 150101 end
            LET l_diff  = 0
            LET l_diffr = 0
         END IF
         
         IF l_sfdc009 IS NULL THEN
            UPDATE asfp370_tmp03 SET sel = 'Y',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                        qty = l_qty ,
                                        qtyr= l_qtyr
             WHERE sfdc004 = l_sfdc004  #料件编号
               AND sfdc005 = l_sfdc005  #产品特征
               AND sfdc006 = l_sfdc006  #单位
               AND sfdc009 IS NULL  #参考单位
               AND sfdc012 = l_sfdc012  #拨入库位
               AND sfdc013 = l_sfdc013  #拨入储位
               AND seq     = l_seq      #项次
         ELSE
            UPDATE asfp370_tmp03 SET sel = 'Y',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                        qty = l_qty ,
                                        qtyr= l_qtyr
             WHERE sfdc004 = l_sfdc004  #料件编号
               AND sfdc005 = l_sfdc005  #产品特征
               AND sfdc006 = l_sfdc006  #单位
               AND sfdc009 = l_sfdc009  #参考单位
               AND sfdc012 = l_sfdc012  #拨入库位
               AND sfdc013 = l_sfdc013  #拨入储位
               AND seq     = l_seq      #项次
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE asfp370_tmp03"  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF   
         #处理批序号管理
         CALL asfp370_02_upd_temp5(l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009,l_sfdc012,l_sfdc013,l_seq,l_qty)
            RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF   
         
         IF l_diff = 0 THEN
            EXIT FOREACH
         END IF

      END FOREACH
      CLOSE asfp370_02_sel_ware_curs22
      FREE asfp370_02_sel_ware_sel22

   END FOREACH
   CLOSE asfp370_02_sel_ware_curs20
   FREE asfp370_02_sel_ware_sel20
   
   #更新temp2
   CALL asfp370_02_upd_temp('2') RETURNING l_success
END FUNCTION

##更新拟调拨料号汇总页签asfp370_02_temp2
##按单位换算计算汇总数量，只汇总sel='Y'的
PUBLIC FUNCTION asfp370_02_upd_temp2(p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc009,p_sfdc012,p_sfdc013)
   DEFINE p_sfdc004    LIKE sfdc_t.sfdc004  #料件编号
   DEFINE p_sfdc005    LIKE sfdc_t.sfdc005  #产品特征
   DEFINE p_sfdc006    LIKE sfdc_t.sfdc006  #单位
   DEFINE p_sfdc009    LIKE sfdc_t.sfdc009  #参考单位
   DEFINE p_sfdc012    LIKE sfdc_t.sfdc012  #拨入库位
   DEFINE p_sfdc013    LIKE sfdc_t.sfdc013  #拨入储位
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_inag007    LIKE inag_t.inag007
   DEFINE l_qty        LIKE sfdc_t.sfdc007      #拨入数量
   DEFINE l_inag024    LIKE inag_t.inag024
   DEFINE l_qtyr       LIKE sfdc_t.sfdc010      #拨入参考数量
   DEFINE l_rate       LIKE inaj_t.inaj014      #单位换算率
   DEFINE l_rate2      LIKE inaj_t.inaj014      #参考单位换算率
   DEFINE l_sum_qty    LIKE sfdc_t.sfdc007      #拟拨入数量合计
   DEFINE l_sum_qtyr   LIKE sfdc_t.sfdc010      #拟拨入参考数量合计
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_qty_t      LIKE sfdc_t.sfdc007   #数量 临时周转用 add 150101

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF p_sfdc009 IS NULL THEN
      LET l_sql = " SELECT inag007,qty,inag024,qtyr ",
                  "   FROM asfp370_tmp03  ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 IS NULL ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND sel = 'Y' "
   ELSE
      LET l_sql = " SELECT inag007,qty,inag024,qtyr ",
                  "   FROM asfp370_tmp03  ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 = '",p_sfdc009,"' ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND sel = 'Y' "
   END IF
   PREPARE asfp370_02_upd_temp2_sel FROM l_sql
   DECLARE asfp370_02_upd_temp2_curs CURSOR FOR asfp370_02_upd_temp2_sel
   LET l_sum_qty = 0
   LET l_sum_qtyr= 0
   FOREACH asfp370_02_upd_temp2_curs INTO l_inag007,l_qty,l_inag024,l_qtyr
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_upd_temp2_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE asfp370_02_upd_temp2_curs
         FREE asfp370_02_upd_temp2_sel
         EXIT FOREACH
      END IF
      
      #mark 150101
      #CALL s_aimi190_get_convert(p_sfdc004,l_inag007,p_sfdc006) RETURNING l_success,l_rate
      #IF NOT l_success THEN
      #   CLOSE asfp370_02_upd_temp2_curs
      #   FREE asfp370_02_upd_temp2_sel
      #   LET r_success = FALSE
      #   RETURN r_success
      #END IF
      #LET l_sum_qty = l_sum_qty + l_qty * l_rate
      #mark 150101 end
      #add 150101
      CALL s_aooi250_convert_qty(p_sfdc004,l_inag007,p_sfdc006,l_qty) RETURNING l_success,l_qty_t
      IF NOT l_success THEN
         CLOSE asfp370_02_upd_temp2_curs
         FREE asfp370_02_upd_temp2_sel
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_sum_qty = l_sum_qty + l_qty_t
      #add 150101 end
      
      IF NOT cl_null(p_sfdc009) AND NOT cl_null(l_inag024) THEN
         #mark 150101
         #CALL s_aimi190_get_convert(p_sfdc004,l_inag024,p_sfdc009) RETURNING l_success,l_rate2
         #IF NOT l_success THEN
         #   CLOSE asfp370_02_upd_temp2_curs
         #   FREE asfp370_02_upd_temp2_sel
         #   LET r_success = FALSE
         #   RETURN r_success
         #END IF
         #LET l_sum_qtyr = l_sum_qtyr + l_qtyr * l_rate2
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(p_sfdc004,l_inag024,p_sfdc009,l_qtyr) RETURNING l_success,l_qty_t
         IF NOT l_success THEN
            CLOSE asfp370_02_upd_temp2_curs
            FREE asfp370_02_upd_temp2_sel
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_sum_qtyr = l_sum_qtyr + l_qty_t
         #add 150101 end
      END IF
   END FOREACH
   CLOSE asfp370_02_upd_temp2_curs
   FREE asfp370_02_upd_temp2_sel
   
   IF p_sfdc009 IS NULL THEN
      UPDATE asfp370_tmp02  SET sum_qty = l_sum_qty,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
                                   sum_qtyr= l_sum_qtyr
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 IS NULL  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
   ELSE
      UPDATE asfp370_tmp02  SET sum_qty = l_sum_qty,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
                                   sum_qtyr= l_sum_qtyr
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 = p_sfdc009  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd asfp370_tmp02'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

##全部清空，数量清为0，重新勾选，默认数量
PUBLIC FUNCTION asfp370_02_upd_temp5(p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc009,p_sfdc012,p_sfdc013,p_seq,p_qty)
   DEFINE p_sfdc004    LIKE sfdc_t.sfdc004  #料件编号
   DEFINE p_sfdc005    LIKE sfdc_t.sfdc005  #产品特征
   DEFINE p_sfdc006    LIKE sfdc_t.sfdc006  #单位
   DEFINE p_sfdc009    LIKE sfdc_t.sfdc009  #参考单位
   DEFINE p_sfdc012    LIKE sfdc_t.sfdc012  #拨入库位
   DEFINE p_sfdc013    LIKE sfdc_t.sfdc013  #拨入储位
   DEFINE p_seq        LIKE type_t.num5     #项次
   DEFINE p_qty        LIKE sfdc_t.sfdc007  #待分配数量
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_qty        LIKE sfdc_t.sfdc007  #分配数量
   DEFINE l_seq1       LIKE type_t.num5     #项序
   DEFINE l_inai010    LIKE inai_t.inai010  #库存数量
   DEFINE l_imaf071    LIKE imaf_t.imaf071
   DEFINE l_imaf081    LIKE imaf_t.imaf081

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   SELECT imaf071,imaf081
     INTO l_imaf071,l_imaf081
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = p_sfdc004
   IF l_imaf071 != '1' AND l_imaf081 != '1' THEN
      RETURN r_success
   END IF
   
   #先清
   IF p_sfdc009 IS NULL THEN
      UPDATE asfp370_tmp04 SET sel = 'N',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                  qty = 0
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 IS NULL  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
         AND seq     = p_seq      #项次
   ELSE
      UPDATE asfp370_tmp04 SET sel = 'N',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                  qty = 0
       WHERE sfdc004 = p_sfdc004  #料件编号
         AND sfdc005 = p_sfdc005  #产品特征
         AND sfdc006 = p_sfdc006  #单位
         AND sfdc009 = p_sfdc009  #参考单位
         AND sfdc012 = p_sfdc012  #拨入库位
         AND sfdc013 = p_sfdc013  #拨入储位
         AND seq     = p_seq      #项次
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #后分配:依据拨出数量及制造日期（seq已按此顺序）从前往后顺序自动勾选
   #无数量，无需分配
   IF p_qty = 0 THEN
      RETURN r_success
   END IF
   
   IF p_sfdc009 IS NULL THEN
      LET l_sql = " SELECT seq1,inai010 ",  #项序，库存数量
                  "   FROM asfp370_tmp04  ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 IS NULL ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND seq     = ",p_seq,
                  " ORDER BY seq1  "
   ELSE
      LET l_sql = " SELECT seq1,inai010 ",  #项序，库存数量
                  "   FROM asfp370_tmp04  ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                  "  WHERE sfdc004 = '",p_sfdc004,"' ", #料件编号
                  "    AND sfdc005 = '",p_sfdc005,"' ", #产品特征
                  "    AND sfdc006 = '",p_sfdc006,"' ", #单位
                  "    AND sfdc009 = '",p_sfdc009,"' ", #参考单位
                  "    AND sfdc012 = '",p_sfdc012,"' ", #拨入库位
                  "    AND sfdc013 = '",p_sfdc013,"' ", #拨入储位
                  "    AND seq     = ",p_seq,
                  " ORDER BY seq1  "
   END IF
   PREPARE asfp370_02_upd_temp5_sel FROM l_sql
   DECLARE asfp370_02_upd_temp5_curs CURSOR FOR asfp370_02_upd_temp5_sel
   FOREACH asfp370_02_upd_temp5_curs INTO l_seq1,l_inai010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asfp370_02_upd_temp5_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE asfp370_02_upd_temp5_curs
         FREE asfp370_02_upd_temp5_sel
         EXIT FOREACH
      END IF
      
      #异动数量
      IF p_qty > l_inai010 THEN
         LET l_qty = l_inai010
      ELSE
         LET l_qty = p_qty
      END IF
      #剩余待分配数量
      LET p_qty = p_qty - l_qty
      
      IF p_sfdc009 IS NULL THEN
         UPDATE asfp370_tmp04 SET sel = 'Y',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                     qty = l_qty
          WHERE sfdc004 = p_sfdc004  #料件编号
            AND sfdc005 = p_sfdc005  #产品特征
            AND sfdc006 = p_sfdc006  #单位
            AND sfdc009 IS NULL  #参考单位
            AND sfdc012 = p_sfdc012  #拨入库位
            AND sfdc013 = p_sfdc013  #拨入储位
            AND seq     = p_seq      #项次                             
            AND seq1    = l_seq1     #项序
      ELSE
         UPDATE asfp370_tmp04 SET sel = 'Y',  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                     qty = l_qty
          WHERE sfdc004 = p_sfdc004  #料件编号
            AND sfdc005 = p_sfdc005  #产品特征
            AND sfdc006 = p_sfdc006  #单位
            AND sfdc009 = p_sfdc009  #参考单位
            AND sfdc012 = p_sfdc012  #拨入库位
            AND sfdc013 = p_sfdc013  #拨入储位
            AND seq     = p_seq      #项次                             
            AND seq1    = l_seq1     #项序
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE asfp370_02_upd_temp5_curs
         FREE asfp370_02_upd_temp5_sel
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF p_qty <= 0 THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CLOSE asfp370_02_upd_temp5_curs
   FREE asfp370_02_upd_temp5_sel
   
   RETURN r_success
END FUNCTION

#更新库存资料页签，连带更新其他页签
PUBLIC FUNCTION asfp370_02_upd_temp3(p_ac,p_flag)
   DEFINE p_ac         LIKE type_t.num10  #更新哪笔    10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE p_flag       LIKE type_t.chr1  #是否更新关联表
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_qty        LIKE sfdc_t.sfdc007  #待分配数量

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
      UPDATE asfp370_tmp03 SET sel = g_inag_d[p_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                  pack= g_inag_d[p_ac].pack,
                                  qty = g_inag_d[p_ac].qty,
                                  qtyr= g_inag_d[p_ac].qtyr
       WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
         AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
         AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
         AND sfdc009 IS NULL  #参考单位
         AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
         AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
         AND seq     = g_inag_d[p_ac].seq               #项次
   ELSE
      UPDATE asfp370_tmp03 SET sel = g_inag_d[p_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
                                  pack= g_inag_d[p_ac].pack,
                                  qty = g_inag_d[p_ac].qty,
                                  qtyr= g_inag_d[p_ac].qtyr
       WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
         AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
         AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
         AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
         AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
         AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
         AND seq     = g_inag_d[p_ac].seq               #项次
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd asfp370_tmp03'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   IF p_flag='Y' THEN
      #更新拟调拨料号汇总页签asfp370_02_temp2
      CALL asfp370_02_upd_temp2(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc005,
                                g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,
                                g_sfdc02_d[g_master_idx2].sfdc012,g_sfdc02_d[g_master_idx2].sfdc013)
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #有作批序号管理的情况，更新批序号资料asfp370_02_temp5 
      IF g_inag_d_t.qty != g_inag_d[p_ac].qty OR g_inag_d_t.sel != g_inag_d[p_ac].sel THEN
         IF g_inag_d[p_ac].sel = 'Y' THEN
            LET l_qty = g_inag_d[p_ac].qty
         ELSE
            LET l_qty = 0
         END IF
         CALL asfp370_02_upd_temp5(g_sfdc02_d[g_master_idx2].sfdc004,g_sfdc02_d[g_master_idx2].sfdc005,
                                   g_sfdc02_d[g_master_idx2].sfdc006,g_sfdc02_d[g_master_idx2].sfdc009,
                                   g_sfdc02_d[g_master_idx2].sfdc012,g_sfdc02_d[g_master_idx2].sfdc013,
                                   g_inag_d[p_ac].seq               ,l_qty              )
            RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
#根据明细数量，更新各临时表总数量，顺带检查总数不可大于拟调拨的差异数量
#temp3数量与temp数量匹配，有作批序号管理的条件下，temp3与temp5数量匹配（sel='Y'的资料）
PUBLIC FUNCTION asfp370_02_upd_temp(p_flag)
   DEFINE p_flag       LIKE type_t.chr1   #2:更新temp2  3:更新temp3 0:全更新
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_temp5      RECORD
                       sfdc004        LIKE sfdc_t.sfdc004,     #需求料号  inai001
                       sfdc005        LIKE sfdc_t.sfdc005,     #特征      inai002
                       sfdc006        LIKE sfdc_t.sfdc006,     #单位
                       sfdc009        LIKE sfdc_t.sfdc009,     #参考单位
                       sfdc012        LIKE sfdc_t.sfdc012,     #拨入库位
                       sfdc013        LIKE sfdc_t.sfdc013,     #拨入储位
                       seq            LIKE type_t.num5,        #项次
                       inag007_03     LIKE inag_t.inag007,     #单位
                       inag008_03     LIKE inag_t.inag025,     #库存数量
                       qty_03         LIKE inag_t.inag008,     #已存拨出总数量
                       inag024_03     LIKE inag_t.inag024,     #参考单位
                       inag025_03     LIKE inag_t.inag025,     #参考单位库存数量
                       qtyr_03        LIKE inag_t.inag025,     #拨出参考数量
                       qty            LIKE inai_t.inai010      #拨出数量
                       END RECORD
   DEFINE l_rate       LIKE inaj_t.inaj013
   DEFINE l_temp3      RECORD
                       sfdc004        LIKE sfdc_t.sfdc004,     #需求料号  inai001
                       sfdc005        LIKE sfdc_t.sfdc005,     #特征      inai002
                       sfdc006        LIKE sfdc_t.sfdc006,     #单位
                       sfdc009        LIKE sfdc_t.sfdc009,     #参考单位
                       sfdc012        LIKE sfdc_t.sfdc012,     #拨入库位
                       sfdc013        LIKE sfdc_t.sfdc013,     #拨入储位
                       inag007        LIKE inag_t.inag007,     #单位
                       inag024        LIKE inag_t.inag024,     #参考单位
                       qty            LIKE inag_t.inag008,     #拨出数量
                       qtyr           LIKE inag_t.inag025      #拨出参考数量
                       END RECORD
   DEFINE l_sum_qty    LIKE inag_t.inag008      #拨出数量
   DEFINE l_sum_qtyr   LIKE inag_t.inag025      #拨出参考数量
   DEFINE l_temp2      RECORD
                       sfdc004        LIKE sfdc_t.sfdc004,     #需求料号  inai001
                       sfdc005        LIKE sfdc_t.sfdc005,     #特征      inai002
                       sfdc006        LIKE sfdc_t.sfdc006,     #单位
                       sfdc009        LIKE sfdc_t.sfdc009,     #参考单位
                       sfdc012        LIKE sfdc_t.sfdc012,     #拨入库位
                       sfdc013        LIKE sfdc_t.sfdc013      #拨入储位
                       END RECORD
   DEFINE l_cnt        LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #temp3与temp5数量的匹配情况
   #更新temp3
   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
   IF p_flag = '3' OR p_flag = '0' THEN
      SELECT asfp370_tmp04.sfdc004,asfp370_tmp04.sfdc005,asfp370_tmp04.sfdc006,asfp370_tmp04.sfdc009, #key
             asfp370_tmp04.sfdc012,asfp370_tmp04.sfdc013,asfp370_tmp04.seq    , #key
             asfp370_tmp03.inag007,asfp370_tmp03.inag008,asfp370_tmp03.qty    , #temp3表
             asfp370_tmp03.inag024,asfp370_tmp03.inag025,asfp370_tmp03.qtyr   , #temp3表
             SUM(asfp370_tmp04.qty) 
        INTO l_temp5.*
        FROM asfp370_tmp04,asfp370_tmp03 
       WHERE asfp370_tmp03.sfdc004 = asfp370_tmp04.sfdc004   #料件编号
         AND asfp370_tmp03.sfdc005 = asfp370_tmp04.sfdc005   #产品特征
         AND asfp370_tmp03.sfdc006 = asfp370_tmp04.sfdc006   #单位
         AND asfp370_tmp03.sfdc009 = asfp370_tmp04.sfdc009   #参考单位
         AND asfp370_tmp03.sfdc012 = asfp370_tmp04.sfdc012   #拨入库位
         AND asfp370_tmp03.sfdc013 = asfp370_tmp04.sfdc013   #拨入储位
         AND asfp370_tmp03.seq     = asfp370_tmp04.seq       #库存资料页签的项次
         AND asfp370_tmp04.sel = 'Y' 
         AND asfp370_tmp04.qty > 0 
       GROUP BY asfp370_tmp04.sfdc004,asfp370_tmp04.sfdc005,asfp370_tmp04.sfdc006,asfp370_tmp04.sfdc009,   #key
                asfp370_tmp04.sfdc012,asfp370_tmp04.sfdc013,asfp370_tmp04.seq    , #key
                asfp370_tmp03.inag007,asfp370_tmp03.inag008,asfp370_tmp03.qty    , #temp3表
                asfp370_tmp03.inag024,asfp370_tmp03.inag025,asfp370_tmp03.qtyr     #temp3表
      IF SQLCA.sqlcode AND SQLCA.sqlcode!=100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sel asfp370_tmp04:qty"  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success
      END IF
      #temp5有都未选的情况，也有不存在temp5数据的情况
      IF cl_null(l_temp5.qty) THEN LET l_temp5.qty=0 END IF
      #不可大于库存量
      IF l_temp5.qty > l_temp5.inag008_03 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00369'
         LET g_errparam.extend = l_temp5.inag008_03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_temp5.qty != l_temp5.qty_03 THEN
         #计算参考单位
         IF NOT cl_null(l_temp5.inag024_03) THEN
            #mark 150101
            #CALL s_aimi190_get_convert(l_temp5.sfdc004,l_temp5.inag007_03,l_temp5.inag024_03) RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET r_success = FALSE
            #   RETURN r_success
            #END IF
            #LET l_temp5.qtyr_03 = l_temp5.qty * l_rate
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_temp5.sfdc004,l_temp5.inag007_03,l_temp5.inag024_03,l_temp5.qty) RETURNING l_success,l_temp5.qtyr_03
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            #add 150101 end
            IF l_temp5.qtyr_03 > l_temp5.inag025_03 THEN
               LET l_temp5.qtyr_03 = l_temp5.inag025_03
            END IF
         ELSE
            LET l_temp5.qtyr_03 = 0
         END IF
         #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
         IF l_temp5.sfdc009 IS NULL THEN
            UPDATE asfp370_tmp03 SET qty = l_temp5.qty,
                                        qtyr= l_temp5.qtyr_03
             WHERE asfp370_tmp03.sfdc004 = l_temp5.sfdc004   #料件编号
               AND asfp370_tmp03.sfdc005 = l_temp5.sfdc005   #产品特征
               AND asfp370_tmp03.sfdc006 = l_temp5.sfdc006   #单位
               AND asfp370_tmp03.sfdc009 IS NULL   #参考单位
               AND asfp370_tmp03.sfdc012 = l_temp5.sfdc012   #拨入库位
               AND asfp370_tmp03.sfdc013 = l_temp5.sfdc013   #拨入储位
               AND asfp370_tmp03.seq     = l_temp5.seq       #库存资料页签的项次
         ELSE
            UPDATE asfp370_tmp03 SET qty = l_temp5.qty,
                                        qtyr= l_temp5.qtyr_03
             WHERE asfp370_tmp03.sfdc004 = l_temp5.sfdc004   #料件编号
               AND asfp370_tmp03.sfdc005 = l_temp5.sfdc005   #产品特征
               AND asfp370_tmp03.sfdc006 = l_temp5.sfdc006   #单位
               AND asfp370_tmp03.sfdc009 = l_temp5.sfdc009   #参考单位
               AND asfp370_tmp03.sfdc012 = l_temp5.sfdc012   #拨入库位
               AND asfp370_tmp03.sfdc013 = l_temp5.sfdc013   #拨入储位
               AND asfp370_tmp03.seq     = l_temp5.seq       #库存资料页签的项次
         END IF
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd asfp370_tmp03:qty"  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
   
   
   #temp2与temp3数量的匹配情况
   #更新temp2
   IF p_flag = '2' OR p_flag = '0' THEN
      LET l_sql = " SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013 ",
                  "   FROM asfp370_tmp02  "  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      PREPARE asfp370_02_upd_temp_sel2 FROM l_sql
      DECLARE asfp370_02_upd_temp_curs2 CURSOR FOR asfp370_02_upd_temp_sel2
      FOREACH asfp370_02_upd_temp_curs2 INTO l_temp2.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:asfp370_02_upd_temp_curs2"
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            CLOSE asfp370_02_upd_temp_curs2
            FREE asfp370_02_upd_temp_sel2
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         CALL asfp370_02_upd_temp2(l_temp2.sfdc004,l_temp2.sfdc005,
                                   l_temp2.sfdc006,l_temp2.sfdc009,
                                   l_temp2.sfdc012,l_temp2.sfdc013)
            RETURNING l_success
         IF NOT l_success THEN
            CLOSE asfp370_02_upd_temp_curs2
            FREE asfp370_02_upd_temp_sel2
            LET r_success = FALSE
            RETURN r_success
         END IF
      
      END FOREACH
      CLOSE asfp370_02_upd_temp_curs2
      FREE asfp370_02_upd_temp_sel2
   END IF
   
   CALL asfp370_02_b_fill('Y')
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asfp370_02_insert_asfp370_02_temp2()
   DEFINE r_success    LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #memo:参考单位不应该存在不同的情况，都是imaf015，所以库存数量、参考单位库存数量都是有唯一性，不能sum，sum都成倍了
   INSERT INTO asfp370_tmp02   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      SELECT sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,SUM(sfdc007),inag008,SUM(sfdc010),inag025,0,0
        FROM asfp370_01_temp
       WHERE sel = 'Y'
       GROUP BY sfdc004,sfdc005,sfdc006,sfdc009,sfdc012,sfdc013,inag008,inag025
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins asfp370_tmp02'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp2 ——> asfp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#根据数量计算既满足调拨批量 又满足最小调拨数量 的数量（大于传入数量的最小数量）
PUBLIC FUNCTION asfp370_02_inflate_qty(p_type,p_item,p_qty)
   DEFINE p_type    LIKE type_t.chr1     #1.计算调拨批量
   DEFINE p_item    LIKE imaf_t.imaf001
   DEFINE p_qty     LIKE inag_t.inag008
   DEFINE r_isdiff  LIKE type_t.num5     #是否有差异 true/false
   DEFINE r_qty     LIKE inag_t.inag008
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_imaf102 LIKE imaf_t.imaf102  #最小调拨数量
   DEFINE l_double  LIKE type_t.num10
   
   LET r_qty = p_qty
   LET r_isdiff = FALSE
   IF cl_null(p_item) OR cl_null(p_qty) THEN
      RETURN r_isdiff,r_qty
   END IF
   IF p_qty = 0 THEN
      RETURN r_isdiff,r_qty
   END IF

   CASE p_type
      WHEN '1'  #计算调拨批量
           SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
            WHERE imafent = g_enterprise
              AND imafsite = g_site
              AND imaf001 = p_item
           IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
           IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF

           #考虑最小调拨数量
           IF l_imaf102 != 0 AND r_qty < l_imaf102 THEN
              LET r_qty=l_imaf102
           END IF
           #考虑调拨批量
           IF l_imaf101!=0 THEN
              LET l_double=(r_qty/l_imaf101)+ 0.999999
              LET r_qty=l_double*l_imaf101
           END IF
      OTHERWISE
           RETURN r_isdiff,r_qty
   END CASE

   IF p_qty! = r_qty THEN
      LET r_isdiff = TRUE
   END IF
   RETURN r_isdiff,r_qty
END FUNCTION

#计算既满足调拨批量 又满足最小调拨数量 的最小数量
PUBLIC FUNCTION asfp370_02_min_qty(p_item)
   DEFINE p_item   LIKE imaf_t.imaf001
   DEFINE r_qty    LIKE inag_t.inag008
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_imaf102 LIKE imaf_t.imaf102  #最小调拨数量
   DEFINE l_double LIKE type_t.num10

   LET r_qty = 0
   IF cl_null(p_item) THEN
      RETURN r_qty
   END IF

   SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_item
   IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
   IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF

   #先取最小调拨数量
   LET r_qty=l_imaf102
   #考虑调拨批量
   IF l_imaf101!=0 THEN
      LET l_double=(r_qty/l_imaf101)+ 0.999999
      LET r_qty=l_double*l_imaf101
   END IF

   RETURN r_qty
END FUNCTION

#计算在数量p_qty中 既满足调拨批量 又满足最小调拨数量 的最大数量（小于传入数量的最大数量）
PUBLIC FUNCTION asfp370_02_max_qty(p_item,p_qty)
   DEFINE p_item   LIKE imaf_t.imaf001
   DEFINE p_qty    LIKE inag_t.inag008
  #DEFINE p_min_qty    LIKE inag_t.inag008
   DEFINE r_qty    LIKE inag_t.inag008
   DEFINE l_qty    LIKE inag_t.inag008   #既满足调拨批量 又满足最小调拨数量 的最小数量
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #调拨批量
   DEFINE l_double LIKE type_t.num10

   LET r_qty = p_qty
   IF cl_null(p_item) OR cl_null(p_qty) THEN
      RETURN r_qty
   END IF
   IF p_qty = 0 THEN
      RETURN r_qty
   END IF

   CALL asfp370_02_min_qty(p_item) RETURNING l_qty  #既满足调拨批量 又满足最小调拨数量 的最小数量
   IF l_qty != 0 AND p_qty < l_qty THEN
      LET r_qty=0
      RETURN r_qty
   END IF

   SELECT imaf101 INTO l_imaf101 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_item
   IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF

   #考虑调拨批量
   IF l_imaf101!=0 THEN
      LET l_double=p_qty/l_imaf101
      LET r_qty=l_double*l_imaf101
   END IF

   RETURN r_qty
END FUNCTION
################################################################################
# Descriptions...: 庫儲頁籤的輸入段
# Memo...........:
# Usage..........: CALL asfp370_02_b3()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/03/31 By polly (151118-00029#10)
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp370_02_b3()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_rate      LIKE inaj_t.inaj014  #?位?算率
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_isdiff  LIKE type_t.num5     #是否有差异 true/false ?算??最小量 批量用
   DEFINE l_qty     LIKE inag_t.inag008  #既?足??批量 又?足最小???量 的最小?量
   DEFINE l_imaf101 LIKE imaf_t.imaf101  #??批量
   DEFINE l_imaf102 LIKE imaf_t.imaf102  #最小???量
   DEFINE l_string  STRING

   WHENEVER ERROR CONTINUE

   DIALOG ATTRIBUTES(UNBUFFERED)

      INPUT ARRAY g_inag_d FROM s_detail3_asfp370_02.*
          ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
                  
          BEFORE INPUT
             IF g_master_idx2 = 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00355'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                
                EXIT DIALOG
             END IF
             
          BEFORE ROW
             LET l_ac = ARR_CURR()
             LET g_master_idx3 = l_ac
             LET g_inag_d_t.* = g_inag_d[l_ac].*
             LET g_inag_d_o.* = g_inag_d[l_ac].*
             CALL asfp370_02_b_fill5()
             CALL cl_set_comp_entry("qtyr_02_3",TRUE)
             IF cl_null(g_inag_d[l_ac].inag024) THEN
                CALL cl_set_comp_entry("qtyr_02_3",FALSE)
             END IF
          
          ON CHANGE sel_02_3
             #IF g_inag_d[l_ac].sel = 'N' THEN
             #   LET g_inag_d[l_ac].qty = 0
             #   LET g_inag_d[l_ac].qtyr= 0
             #ELSE
             #   IF g_inag_d[l_ac].qty = 0 THEN
             #      NEXT FIELD qty_02_3
             #   END IF
             #END IF
             
             #不可为空
             IF cl_null(g_inag_d[l_ac].sel) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             IF g_inag_d[l_ac].sel NOT MATCHES '[NY]' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00144'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             
             #更新临时表
             CALL asfp370_02_upd_temp3(l_ac,'Y') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             #刷新单身显示
             CALL asfp370_02_b_fill('Y')
             
             LET g_inag_d_o.sel = g_inag_d[l_ac].sel
      
          ON CHANGE qty_02_3
          #AFTER FIELD qty_02_3
             #不可为空
             IF cl_null(g_inag_d[l_ac].qty) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             #不可小于0
             IF g_inag_d[l_ac].qty < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00041'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             #不可大于库存数量
             IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00369'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()                
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             
            #检查调拨最小数量和批量
             CALL asfp370_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
             IF l_isdiff THEN
                SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                 WHERE imafent = g_enterprise
                   AND imafsite = g_site
                   AND imaf001 = g_sfdc02_d[g_master_idx2].sfdc004
                IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                #当前数量不符合调拨批量%1和最小调拨量2%，是否继续？
                LET l_string = l_imaf101,"|",l_imaf102
                IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   NEXT FIELD qty_02_3
                END IF
             END IF
             
             #总数不可大于拟调拨的差异数量 在asfp370_02_upd_temp()中判断，提高操作灵活性
             
             IF g_inag_d[l_ac].qty > 0 THEN
                LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
             END IF
             
             #计算参考单位数量
             IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
                #mark 150101
                #CALL s_aimi190_get_convert(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag024) RETURNING l_success,l_rate
                #IF NOT l_success THEN
                #   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                #   NEXT FIELD qty_02_3
                #END IF
                #LET g_inag_d[l_ac].qtyr = g_inag_d[l_ac].qty * l_rate
                #mark 150101 end
                
                #add 150101
                CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag024,g_inag_d[l_ac].qty)
                   RETURNING l_success,g_inag_d[l_ac].qtyr
                IF NOT l_success THEN
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   NEXT FIELD qty_02_3
                END IF
                #add 150101 end
                
                IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'asf-00369'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   
                   LET g_inag_d_o.qty = g_inag_d[l_ac].qty
                   NEXT FIELD qtyr_02_3
                END IF
             END IF
             
             #更新临时表
             CALL asfp370_02_upd_temp3(l_ac,'Y') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                NEXT FIELD qty_02_3
             END IF
             #刷新单身显示
             CALL asfp370_02_b_fill('Y')
             
             LET g_inag_d_o.qty = g_inag_d[l_ac].qty
             LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr  #add 150101
          
          ON CHANGE qtyr_02_3
          #AFTER FIELD qtyr_02_3
             #不可为空
             IF cl_null(g_inag_d[l_ac].qtyr) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF
             #不可小于0
             IF g_inag_d[l_ac].qtyr < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00041'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF
             IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
                #不可大于库存数量
                IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'asf-00369'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   NEXT FIELD qtyr_02_3
                END IF
                IF g_inag_d[l_ac].qtyr >0 AND g_inag_d[l_ac].qty=0 THEN #计算单位数量
                   #mark 150101
                   #CALL s_aimi190_get_convert(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007) RETURNING l_success,l_rate
                   #IF NOT l_success THEN
                   #   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   #   NEXT FIELD qtyr_02_3
                   #END IF
                   #LET g_inag_d[l_ac].qty = g_inag_d[l_ac].qtyr * l_rate
                   #mark 150101 end
                   #add 150101
                   CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007,g_inag_d[l_ac].qtyr)
                      RETURNING l_success,g_inag_d[l_ac].qty
                   IF NOT l_success THEN
                      LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                      LET g_inag_d[l_ac].qty  = g_inag_d_o.qty
                      NEXT FIELD qtyr_02_3
                   END IF
                   #add 150101 end
                   IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'asf-00369'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      
                      LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
                      NEXT FIELD qty_02_3
                   END IF
                   
                  #检查调拨最小数量和批量
                  CALL asfp370_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
                  IF l_isdiff THEN
                     SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                      WHERE imafent = g_enterprise
                        AND imafsite = g_site
                        AND imaf001 = p_item
                     IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                     IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                      #当前数量不符合调拨批量10和最小调拨量10，是否继续？
                      LET l_string = l_imaf101,"|",l_imaf102
                      IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                         LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                         NEXT FIELD qty_02_3
                      END IF
                  END IF
      
                   IF g_inag_d[l_ac].qty > 0 THEN
                      LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
                   END IF
                END IF
             END IF
             
             #更新临时表
             CALL asfp370_02_upd_temp3(l_ac,'Y') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                NEXT FIELD qtyr_02_3
             END IF
             #刷新单身显示
             CALL asfp370_02_b_fill('Y')
             
             LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
             LET g_inag_d_o.qty  = g_inag_d[l_ac].qty  #add 150101
      
          ON CHANGE pack_02_3
             #輸入值須存在[T:料件包裝資料檔].[C:包裝容器編號]，錯誤訊息「此料沒有
             IF NOT cl_null(g_inag_d[l_ac].pack) THEN
                INITIALIZE g_chkparam.* TO NULL
                LET g_chkparam.arg1 = g_inag_d[l_ac].pack
                IF NOT cl_chk_exist("v_imaa001_3") THEN
                   LET g_inag_d[l_ac].pack = g_inag_d_o.pack
                   NEXT FIELD pack_02_3
                END IF
             END IF
             #更新临时表
             CALL asfp370_02_upd_temp3(l_ac,'N') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].pack = g_inag_d_o.pack
                NEXT FIELD pack_02_3
             END IF
             #刷新单身显示
             CALL asfp370_02_b_fill('Y')
             
             LET g_inag_d_o.pack = g_inag_d[l_ac].pack
             
          ON ACTION controlp INFIELD pack_02_3
          #包装容器
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_inag_d[l_ac].pack
             CALL q_imaa001_11()
             LET g_inag_d[l_ac].pack = g_qryparam.return1     #將開窗取得的值>
             NEXT FIELD pack_02_3
      
          ON ROW CHANGE
          
          ON ACTION accept          
             #==選擇==檢查
             IF cl_null(g_inag_d[l_ac].sel) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             IF g_inag_d[l_ac].sel NOT MATCHES '[NY]' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00144'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inag_d[l_ac].sel = g_inag_d_o.sel
                NEXT FIELD sel_02_3
             END IF
             #==撥出數量==檢查
             IF g_inag_d[l_ac].qty <> g_inag_d_o.qty THEN
                IF cl_null(g_inag_d[l_ac].qty) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aqc-00006'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()      
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   NEXT FIELD qty_02_3
                END IF
                IF g_inag_d[l_ac].qty < 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00041'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()      
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   NEXT FIELD qty_02_3
                END IF
                #不可大于库存数量
                IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'asf-00369'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()                
                   LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                   NEXT FIELD qty_02_3
                END IF
                
                #检查调拨最小数量和批量
                CALL asfp370_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
                IF l_isdiff THEN
                   SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                    WHERE imafent = g_enterprise
                      AND imafsite = g_site
                      AND imaf001 = g_sfdc02_d[g_master_idx2].sfdc004
                   IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                   IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                   #当前数量不符合调拨批量%1和最小调拨量2%，是否继续？
                   LET l_string = l_imaf101,"|",l_imaf102
                   IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                      LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                      NEXT FIELD qty_02_3
                   END IF
                END IF             
                #总数不可大于拟调拨的差异数量 在asfp370_02_upd_temp()中判断，提高操作灵活性
                IF g_inag_d[l_ac].qty > 0 THEN
                   LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
                END IF             
                #计算参考单位数量
                IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
                   CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag024,g_inag_d[l_ac].qty)
                      RETURNING l_success,g_inag_d[l_ac].qtyr
                   IF NOT l_success THEN
                      LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                      LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                      NEXT FIELD qty_02_3
                   END IF
                  
                   IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'asf-00369'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()                   
                      LET g_inag_d_o.qty = g_inag_d[l_ac].qty
                      NEXT FIELD qtyr_02_3
                   END IF
                END IF
             END IF                
             #==撥出參考數==檢查

                IF cl_null(g_inag_d[l_ac].qtyr) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aqc-00006'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()      
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   NEXT FIELD qtyr_02_3
                END IF
                #不可小于0
                IF g_inag_d[l_ac].qtyr < 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00041'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()      
                   LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                   NEXT FIELD qtyr_02_3
                END IF
                IF NOT cl_null(g_inag_d[l_ac].inag024) THEN
                   #不可大于库存数量
                   IF g_inag_d[l_ac].qtyr> g_inag_d[l_ac].inag025 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'asf-00369'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()                   
                      LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                      NEXT FIELD qtyr_02_3
                   END IF
                   IF g_inag_d[l_ac].qtyr >0 AND g_inag_d[l_ac].qty=0 THEN #计算单位数量
                      CALL s_aooi250_convert_qty(g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag007,g_inag_d[l_ac].qtyr)
                         RETURNING l_success,g_inag_d[l_ac].qty
                      IF NOT l_success THEN
                         LET g_inag_d[l_ac].qtyr = g_inag_d_o.qtyr
                         LET g_inag_d[l_ac].qty  = g_inag_d_o.qty
                         NEXT FIELD qtyr_02_3
                      END IF
                      IF g_inag_d[l_ac].qty > g_inag_d[l_ac].inag008 THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'asf-00369'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         
                         LET g_inag_d_o.qtyr = g_inag_d[l_ac].qtyr
                         NEXT FIELD qty_02_3
                      END IF
                      
                     #检查调拨最小数量和批量
                     CALL asfp370_02_inflate_qty('1',g_sfdc02_d[g_master_idx2].sfdc004,g_inag_d[l_ac].qty) RETURNING l_isdiff,l_qty
                     IF l_isdiff THEN
                        SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                         WHERE imafent = g_enterprise
                           AND imafsite = g_site
                           AND imaf001 = p_item
                        IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
                        IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF
                         #当前数量不符合调拨批量10和最小调拨量10，是否继续？
                         LET l_string = l_imaf101,"|",l_imaf102
                         IF NOT cl_ask_confirm_parm("asf-00420",l_string) THEN
                            LET g_inag_d[l_ac].qty = g_inag_d_o.qty
                            NEXT FIELD qty_02_3
                         END IF
                     END IF
                
                      IF g_inag_d[l_ac].qty > 0 THEN
                         LET g_inag_d[l_ac].sel = 'Y'  #不用自己再去勾选
                      END IF
                   END IF
                END IF  
               
             #更新临时表
             CALL asfp370_02_upd_temp3(l_ac,'N') RETURNING l_success
             IF NOT l_success THEN
                LET g_inag_d[l_ac].pack = g_inag_d_o.pack
                NEXT FIELD qty_02_3
             END IF
             CALL asfp370_02_b_fill('Y')
             EXIT DIALOG      
            
         ON ACTION cancel 
            LET g_inag_d[l_ac].*  = g_inag_d_o.* 
            EXIT DIALOG          
      
          AFTER INPUT
             #这里不能检查，因为上一步也会走到这里
             #若不检查，也不能做更新的动作，否则数据就可能会不对
             
          #此处不好用，还需输入数量，并对数量做管控
          #ON ACTION selall
          #   CALL asfp370_02_sel_all("Y","inag")
          #
          #ON ACTION selnone
          #   CALL asfp370_02_sel_all("N","inag")
          
      END INPUT

   END DIALOG      
END FUNCTION
################################################################################
# Descriptions...: 批序號資料頁籤的輸入段
# Memo...........:
# Usage..........: CALL asfp370_02_b5()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/03/31 By polly (151118-00029#10)
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp370_02_b5()
   DEFINE l_qty_sum    LIKE sfdc_t.sfdc007
   DEFINE l_imaf071    LIKE imaf_t.imaf071
   DEFINE l_imaf081    LIKE imaf_t.imaf081
   DEFINE l_success    LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   DIALOG ATTRIBUTES(UNBUFFERED)

      INPUT ARRAY g_inai_d FROM s_detail5_asfp370_02.*
          ATTRIBUTE(COUNT = g_rec_b5,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
          BEFORE INPUT
             IF g_master_idx3 = 0 OR cl_null(g_inag_d[g_master_idx3].seq) THEN
                EXIT DIALOG
             END IF
          
          BEFORE ROW
             LET l_ac = ARR_CURR()
             LET g_master_idx5 = l_ac
             LET g_inai_d_t.* = g_inai_d[l_ac].*
             LET g_inai_d_o.* = g_inai_d[l_ac].*
             
          ON CHANGE sel_02_5
             #IF g_inai_d[l_ac].sel = 'N' THEN
             #   LET g_inai_d[l_ac].qty = 0
             #ELSE
             #   IF g_inai_d[l_ac].qty = 0 THEN
             #      LET g_inai_d[l_ac].sel = g_inai_d_o.sel
             #      NEXT FIELD qty_02_5
             #   END IF
             #END IF
             
          #AFTER FIELD sel_02_5
             IF cl_null(g_inai_d[l_ac].sel) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inai_d[l_ac].sel = g_inai_d_o.sel
                NEXT FIELD sel_02_5
             END IF
             IF g_inai_d[l_ac].sel NOT MATCHES '[NY]' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00144'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inai_d[l_ac].sel = g_inai_d_o.sel
                NEXT FIELD sel_02_5
             END IF
             IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 IS NULL  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             ELSE
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             END IF
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inai_d[l_ac].sel = g_inai_d_o.sel
                NEXT FIELD sel_02_5
             END IF
          
             LET g_inai_d_o.sel = g_inai_d[l_ac].sel
          
          ON CHANGE qty_02_5
          #AFTER FIELD qty_02_5
             #不可为空
             IF cl_null(g_inai_d[l_ac].qty) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
             #不可小于0
             IF g_inai_d[l_ac].qty < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00041'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
             #不可大于库存数量
             IF g_inai_d[l_ac].qty > g_inai_d[l_ac].inai010 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00369'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
             IF g_inai_d[l_ac].qty > 0 THEN
                LET g_inai_d[l_ac].sel = 'Y'  #不用自己再去勾选
             END IF
             
             IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 IS NULL  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             ELSE
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             END IF
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                LET g_errparam.popup = TRUE
                CALL cl_err()
      
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
      
             LET g_inai_d_o.qty = g_inai_d[l_ac].qty
             
          ON ROW CHANGE

          ON ACTION accept          
             #==選擇==檢查
             IF cl_null(g_inai_d[l_ac].sel) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inai_d[l_ac].sel = g_inai_d_o.sel
                NEXT FIELD sel_02_5
             END IF
             IF g_inai_d[l_ac].sel NOT MATCHES '[NY]' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00144'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inai_d[l_ac].sel = g_inai_d_o.sel
                NEXT FIELD sel_02_5
             END IF
             IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 IS NULL  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             ELSE
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             END IF
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inai_d[l_ac].sel = g_inai_d_o.sel
                NEXT FIELD sel_02_5
             END IF          
             #==擬撥出數量==檢查
             IF cl_null(g_inai_d[l_ac].qty) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aqc-00006'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
             #不可小于0
             IF g_inai_d[l_ac].qty < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00041'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
             #不可大于库存数量
             IF g_inai_d[l_ac].qty > g_inai_d[l_ac].inai010 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'asf-00369'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()                
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF
             IF g_inai_d[l_ac].qty > 0 THEN
                LET g_inai_d[l_ac].sel = 'Y'  #不用自己再去勾选
             END IF
             
             IF g_sfdc02_d[g_master_idx2].sfdc009 IS NULL THEN
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 IS NULL  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             ELSE
                UPDATE asfp370_tmp04 SET sel = g_inai_d[l_ac].sel,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                                            qty = g_inai_d[l_ac].qty
                 WHERE sfdc004 = g_sfdc02_d[g_master_idx2].sfdc004  #料件编号
                   AND sfdc005 = g_sfdc02_d[g_master_idx2].sfdc005  #产品特征
                   AND sfdc006 = g_sfdc02_d[g_master_idx2].sfdc006  #单位
                   AND sfdc009 = g_sfdc02_d[g_master_idx2].sfdc009  #参考单位
                   AND sfdc012 = g_sfdc02_d[g_master_idx2].sfdc012  #拨入库位
                   AND sfdc013 = g_sfdc02_d[g_master_idx2].sfdc013  #拨入储位
                   AND seq     = g_inag_d[g_master_idx3].seq      #项次
                   AND seq1    = g_inai_d[l_ac].seq1              #项序
             END IF
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'upd asfp370_tmp04'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp5 ——> asfp370_tmp04
                LET g_errparam.popup = TRUE
                CALL cl_err()      
                LET g_inai_d[l_ac].qty = g_inai_d_o.qty
                NEXT FIELD qty_02_5
             END IF                  
             EXIT DIALOG      
             
             
          ON ACTION cancel 
             LET g_inai_d[l_ac].*  = g_inai_d_o.* 
             EXIT DIALOG  
      
          AFTER INPUT
             #能否进入到下一步的判断不能写在这，因为上一步也会走到这段
             CALL asfp370_02_upd_temp('0') RETURNING l_success #更新temp3 temp2
             IF NOT l_success THEN
                NEXT FIELD sel_02_5
             END IF
      
          #此处不好用，还需输入数量，并对数量做管控
          #ON ACTION selall
          #   CALL asfp370_02_sel_all("Y","inai")
          #
          #ON ACTION selnone
          #   CALL asfp370_02_sel_all("N","inai")
          
      END INPUT
   END DIALOG 
END FUNCTION

 
{</section>}
 
