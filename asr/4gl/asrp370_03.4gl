#該程式未解開Section, 採用最新樣板產出!
{<section id="asrp370_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-11-24 14:38:30), PR版次:0004(2016-12-15 14:16:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000065
#+ Filename...: asrp370_03
#+ Description: 重複性生產調撥產生作業——生成調撥單
#+ Creator....: 00768(2014-11-11 17:01:59)
#+ Modifier...: 00768 -SD/PR- 01996
 
{</section>}
 
{<section id="asrp370_03.global" >}
#應用 c03b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150105 单位转换率改写
#160512-00004#1   16/06/20  By Whitney inai012製造日期改抓inae010
#160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_02_temp1 ——> asrp370_tmp04,asrp370_02_temp2 ——> asrp370_tmp05,asrp370_02_temp3 ——> asrp370_tmp06
#161124-00048#10  2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../asr/4gl/asrp370.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_indc_m        RECORD
       indcdocno LIKE indc_t.indcdocno, 
   indcdocno_desc LIKE type_t.chr80, 
   indcdocdt LIKE indc_t.indcdocdt, 
   post LIKE type_t.chr500, 
   indcdocno_03 LIKE type_t.chr20, 
   indcdocdt_03 LIKE type_t.dat
       END RECORD
DEFINE g_indc_m        type_g_indc_m
 
   DEFINE g_indcdocno_t LIKE indc_t.indcdocno
 
 
#單身 type 宣告
PRIVATE TYPE type_g_indd_d        RECORD
       inddseq LIKE indd_t.inddseq, 
   indd002 LIKE indd_t.indd002, 
   indd002_desc LIKE type_t.chr500, 
   indd002_desc_desc LIKE type_t.chr500, 
   indd004 LIKE indd_t.indd004, 
   indd102 LIKE indd_t.indd102, 
   indd022 LIKE indd_t.indd022, 
   indd022_desc LIKE type_t.chr500, 
   indd023 LIKE indd_t.indd023, 
   indd023_desc LIKE type_t.chr500, 
   indd024 LIKE indd_t.indd024, 
   indd006 LIKE indd_t.indd006, 
   indd006_desc LIKE type_t.chr500, 
   indd103 LIKE indd_t.indd103, 
   indd021 LIKE indd_t.indd021, 
   indd104 LIKE indd_t.indd104, 
   indd104_desc LIKE type_t.chr500, 
   indd105 LIKE indd_t.indd105, 
   indd106 LIKE indd_t.indd106, 
   indd151 LIKE indd_t.indd151, 
   indd151_desc LIKE type_t.chr500, 
   indd032 LIKE indd_t.indd032, 
   indd032_desc LIKE type_t.chr500, 
   indd033 LIKE indd_t.indd033, 
   indd033_desc LIKE type_t.chr500, 
   indd031 LIKE indd_t.indd031, 
   indd109 LIKE indd_t.indd109, 
   indd040 LIKE indd_t.indd040, 
   indd152 LIKE indd_t.indd152
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_indd_d          DYNAMIC ARRAY OF type_g_indd_d
DEFINE g_indd_d_t        type_g_indd_d
 
 
DEFINE g_inddseq_t   LIKE indd_t.inddseq    #Key值備份
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
     
#add-point:傳入參數說明(global.argv) name="global.argv"

DEFINE g_master_idx          LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="asrp370_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION asrp370_03(--)
   #add-point:input段變數傳入 name="input.get_var"
   
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asrp370_03 WITH FORM cl_ap_formpath("asr","asrp370_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.post ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.head.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.head.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocno
            
            #add-point:AFTER FIELD indcdocno name="input.a.indcdocno"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indc_m.indcdocno
            CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indc_m.indcdocno_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indc_m.indcdocno_desc

            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  NOT cl_null(g_indc_m.indcdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_indc_m.indcdocno != g_indcdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indc_t WHERE "||"indcent = '" ||g_enterprise|| "' AND "||"indcdocno = '"||g_indc_m.indcdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocno
            #add-point:BEFORE FIELD indcdocno name="input.b.indcdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcdocno
            #add-point:ON CHANGE indcdocno name="input.g.indcdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocdt
            #add-point:BEFORE FIELD indcdocdt name="input.b.indcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocdt
            
            #add-point:AFTER FIELD indcdocdt name="input.a.indcdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcdocdt
            #add-point:ON CHANGE indcdocdt name="input.g.indcdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD post
            #add-point:BEFORE FIELD post name="input.b.post"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD post
            
            #add-point:AFTER FIELD post name="input.a.post"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE post
            #add-point:ON CHANGE post name="input.g.post"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.indcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocno
            #add-point:ON ACTION controlp INFIELD indcdocno name="input.c.indcdocno"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indcdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            
            CALL q_ooba002_8()                                #呼叫開窗

            LET g_indc_m.indcdocno = g_qryparam.return1              

            DISPLAY g_indc_m.indcdocno TO indcdocno              #

            NEXT FIELD indcdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocdt
            #add-point:ON ACTION controlp INFIELD indcdocdt name="input.c.indcdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.post
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD post
            #add-point:ON ACTION controlp INFIELD post name="input.c.post"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.head.after_input"
            
            #end add-point
            
      END INPUT
   
      INPUT ARRAY g_indd_d FROM s_detail1_asrp370_03.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.body.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.body.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].inddseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inddseq
            END IF 
 
 
 
            #add-point:AFTER FIELD inddseq name="input.a.page1_asrp370_03.inddseq"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddseq
            #add-point:BEFORE FIELD inddseq name="input.b.page1_asrp370_03.inddseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inddseq
            #add-point:ON CHANGE inddseq name="input.g.page1_asrp370_03.inddseq"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_asrp370_03.inddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddseq
            #add-point:ON ACTION controlp INFIELD inddseq name="input.c.page1_asrp370_03.inddseq"
            
            #END add-point
 
 
 
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.body.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asrp370_03 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrp370_03.other_dialog" readonly="Y" >}

DIALOG asrp370_03_display1()
    DISPLAY ARRAY g_indd03_d TO s_detail1_asrp370_03.* ATTRIBUTE(COUNT = g_rec_b)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail1_asrp370_03")

   END DISPLAY
END DIALOG

DIALOG asrp370_03_input()
   DEFINE l_ooef004    LIKE ooef_t.ooef004  #单据别参照表号
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success_tot    LIKE type_t.num5
   DEFINE l_date       LIKE indc_t.indc022  #成本关账日期
   DEFINE l_indc022    LIKE indc_t.indc022  #扣帐日期
   
   INPUT BY NAME g_asrp370_03_m.indcdocno,g_asrp370_03_m.indcdocdt,g_asrp370_03_m.post
      ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT

      AFTER FIELD indcdocno
         IF NOT cl_null(g_asrp370_03_m.indcdocno) THEN
            IF NOT s_aooi200_chk_slip(g_site,'',g_asrp370_03_m.indcdocno,'aint330') THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_aooi200_get_slip_desc(g_asrp370_03_m.indcdocno) RETURNING g_asrp370_03_m.indcdocno_desc
            DISPLAY BY NAME g_asrp370_03_m.indcdocno_desc
         END IF

      ON ACTION controlp INFIELD indcdocno
         #開窗i段
         SELECT ooef004 INTO l_ooef004 FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site

         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_asrp370_03_m.indcdocno             #給予default值
         #給予arg
         LET g_qryparam.arg1 = l_ooef004  #单据别参照标号
         LET g_qryparam.arg2 = "aint330"  #
         CALL q_ooba002_8()                                #呼叫開窗
         LET g_asrp370_03_m.indcdocno = g_qryparam.return1
         DISPLAY g_asrp370_03_m.indcdocno TO indcdocno              #
         CALL s_aooi200_get_slip_desc(g_asrp370_03_m.indcdocno) RETURNING g_asrp370_03_m.indcdocno_desc
         DISPLAY BY NAME g_asrp370_03_m.indcdocno_desc
         NEXT FIELD indcdocno                          #返回原欄位

      ON ACTION gen_aint330  #产生发料前调拨单据
         IF cl_null(g_asrp370_03_m.indcdocno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'acr-00015'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD indcdocno
         END IF
         IF cl_null(g_asrp370_03_m.indcdocdt) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'acr-00015'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD indcdocdt
         END IF
         IF cl_null(g_asrp370_03_m.post) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'acr-00015'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD post
         END IF
         IF NOT s_aooi200_chk_slip(g_site,'',g_asrp370_03_m.indcdocno,'aint330') THEN
            NEXT FIELD indcdocno
         END IF
         IF NOT cl_null(g_asrp370_03_m.indcdocno_03) THEN
            #单据已产生，不可重复产生
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00408'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            CALL asrp370_03_gen_aint330() RETURNING l_success
            IF l_success THEN
               CALL asrp370_03_show()
               IF g_asrp370_03_m.post = 'Y' THEN
                  #执行确认过账
                  LET l_success_tot = TRUE
                  CALL s_transaction_begin()
                  #确认
                  IF l_success_tot THEN
                     CALL s_aint330_conf_chk(g_asrp370_03_m.indcdocno_03) RETURNING l_success
                     IF NOT l_success THEN
                        #调拨单执行确认失败！请至【一阶段调拨作业aint330】中执行！
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00409'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success_tot = l_success
                     END IF
                  END IF
                  IF l_success_tot THEN
                     CALL s_aint330_conf_upd(g_asrp370_03_m.indcdocno_03) RETURNING l_success
                     IF NOT l_success THEN
                        #调拨单执行确认失败！请至【一阶段调拨作业aint330】中执行！
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00409'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success_tot = l_success
                     END IF
                  END IF
                  #过账
                  IF l_success_tot THEN
                     CALL s_aint330_post_chk(g_asrp370_03_m.indcdocno_03) RETURNING l_success
                     IF NOT l_success THEN
                        #调拨单执行过账失败！请至【一阶段调拨作业aint330】中执行！
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00410'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success_tot = l_success
                     END IF
                  END IF
                  IF l_success_tot THEN
                     LET l_indc022 = cl_get_today()
                     #檢查不小於等于库存關賬日期
                     CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_date  #
                     IF l_indc022 <= l_date THEN
                        LET l_indc022 = l_date + 1
                     END IF
                     CALL s_aint330_post_upd(g_asrp370_03_m.indcdocno_03,l_indc022,'aint330') RETURNING l_success
                     IF NOT l_success THEN
                        #调拨单执行过账失败！请至【一阶段调拨作业aint330】中执行！
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00410'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success_tot = l_success
                     END IF
                  END IF
                  IF l_success_tot THEN
                     UPDATE indc_t SET indc022 = l_indc022
                      WHERE indcent = g_enterprise
                        AND indcdocno = g_asrp370_03_m.indcdocno_03
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET l_success_tot = FALSE
                     END IF
                  END IF
                  IF l_success_tot THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
            ELSE
               LET g_asrp370_03_m.indcent_03   = ''
               LET g_asrp370_03_m.indcdocno_03 = ''
               LET g_asrp370_03_m.indcdocdt_03 = ''
            END IF
         END IF
         
   END INPUT
END DIALOG

 
{</section>}
 
{<section id="asrp370_03.other_function" readonly="Y" >}

PUBLIC FUNCTION asrp370_03_init()
   WHENEVER ERROR CONTINUE

   #當整體參數有使用參考單位時才顯示
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",FALSE) #參考單位
   END IF

END FUNCTION

#产生发料前调拨单据
PUBLIC FUNCTION asrp370_03_gen_aint330()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #初始化
   LET g_asrp370_03_m.indcdocno_03 = ''
   LET g_asrp370_03_m.indcdocdt_03 = ''
   
   CALL s_transaction_begin()
   
   #产生单头indc
   CALL asrp370_03_gen_aint330_indc() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF

   #产生单身indd
   CALL asrp370_03_gen_aint330_indd() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      CALL s_transaction_end('N','0')
      RETURN r_success
   END IF
   
   CALL s_transaction_end('Y','0')
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asrp370_03_show()
   WHENEVER ERROR CONTINUE
   
   DISPLAY g_asrp370_03_m.indcdocno_03 TO indcdocno_03
   DISPLAY g_asrp370_03_m.indcdocdt_03 TO indcdocdt_03
   
   CALL asrp370_03_b_fill()
END FUNCTION

PUBLIC FUNCTION asrp370_03_b_fill()
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   CALL g_indd03_d.clear()
   
   LET l_sql = "SELECT UNIQUE inddseq,indd002,t1.imaal003,t1.imaal004,indd004,indd102, ",
               "       indd022,t2.inaa002,indd023,t3.inab003,indd024,indd006,t6.oocal003,indd103, ",
               "       indd021,indd104,t7.oocal003,indd105,indd106,indd151,t8.oocql004, ",
               "       indd032,t4.inaa002,indd033,t5.inab003,indd031,indd109,indd040,indd152 ",
               "  FROM indd_t LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=indd002 AND t1.imaal002='"||g_dlang||"' ",
               "              LEFT JOIN inaa_t t2 ON t2.inaaent='"||g_enterprise||"' AND t2.inaasite=inddsite AND t2.inaa001=indd022  ",
               "              LEFT JOIN inab_t t3 ON t3.inabent='"||g_enterprise||"' AND t3.inabsite=inddsite AND t3.inab001=indd022 AND t3.inab002=indd023  ",
               "              LEFT JOIN inaa_t t4 ON t4.inaaent='"||g_enterprise||"' AND t4.inaasite=inddsite AND t4.inaa001=indd032  ",
               "              LEFT JOIN inab_t t5 ON t5.inabent='"||g_enterprise||"' AND t5.inabsite=inddsite AND t5.inab001=indd032 AND t5.inab002=indd033  ",
               "              LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=indd006 AND t6.oocal002='"||g_dlang||"' ",
               "              LEFT JOIN oocal_t t7 ON t7.oocalent='"||g_enterprise||"' AND t7.oocal001=indd104 AND t7.oocal002='"||g_dlang||"' ",
               "              LEFT JOIN oocql_t t8 ON t8.oocqlent='"||g_enterprise||"' AND t8.oocql001='303' AND t8.oocql002=indd151 AND t8.oocql003='"||g_dlang||"' ",
               " WHERE inddent=",g_enterprise,
               "   AND indddocno='",g_asrp370_03_m.indcdocno_03,"'",
               " ORDER BY indd_t.inddseq"
   PREPARE asrp370_03_b_fill_sel FROM l_sql
   DECLARE asrp370_03_b_fill_curs CURSOR FOR asrp370_03_b_fill_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"
   FOREACH asrp370_03_b_fill_curs INTO g_indd03_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asrp370_03_b_fill_curs"
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
   LET g_rec_b = l_ac - 1
   CALL g_indd03_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE asrp370_03_b_fill_curs
   FREE asrp370_03_b_fill_sel
   
   LET g_master_idx = l_ac

END FUNCTION

################################################################################
# Descriptions...:插入调拨单aint330单头
# Memo...........:
# Usage..........: CALL asrp370_03_gen_aint330_indc()
#                  RETURNING r_success
# Input parameter: 无
# Return code....: r_success      处理状态
# Date & Author..: 2014/11/20 By zhangllc
# Modify.........:
################################################################################
PUBLIC FUNCTION asrp370_03_gen_aint330_indc()
   DEFINE r_success   LIKE type_t.num5
#   DEFINE l_indc      RECORD LIKE indc_t.* #161124-00048#10 mark
   #161124-00048#10 add(s)
   DEFINE l_indc RECORD  #調撥單單頭檔
       indcent LIKE indc_t.indcent, #企业编号
       indcsite LIKE indc_t.indcsite, #营运据点
       indcunit LIKE indc_t.indcunit, #应用组织
       indcdocno LIKE indc_t.indcdocno, #调拨单号
       indcdocdt LIKE indc_t.indcdocdt, #调拨日期
       indc000 LIKE indc_t.indc000, #单据性质
       indc001 LIKE indc_t.indc001, #对应调拨单号
       indc002 LIKE indc_t.indc002, #来源类别
       indc003 LIKE indc_t.indc003, #来源单号
       indc004 LIKE indc_t.indc004, #调拨人员
       indc005 LIKE indc_t.indc005, #拨出营运据点
       indc006 LIKE indc_t.indc006, #拨入营运据点
       indc007 LIKE indc_t.indc007, #在途仓
       indc008 LIKE indc_t.indc008, #备注
       indc021 LIKE indc_t.indc021, #拨出审核人员
       indc022 LIKE indc_t.indc022, #拨出审核日期
       indc023 LIKE indc_t.indc023, #拨入审核人员
       indc024 LIKE indc_t.indc024, #拨入审核日期
       indcstus LIKE indc_t.indcstus, #状态码
       indcownid LIKE indc_t.indcownid, #资料所有者
       indcowndp LIKE indc_t.indcowndp, #资料所有部门
       indccrtid LIKE indc_t.indccrtid, #资料录入者
       indccrtdp LIKE indc_t.indccrtdp, #资料录入部门
       indccrtdt LIKE indc_t.indccrtdt, #资料创建日
       indcmodid LIKE indc_t.indcmodid, #资料更改者
       indcmoddt LIKE indc_t.indcmoddt, #最近更改日
       indccnfid LIKE indc_t.indccnfid, #资料审核者
       indccnfdt LIKE indc_t.indccnfdt, #数据审核日
       indcpstid LIKE indc_t.indcpstid, #资料过账者
       indcpstdt LIKE indc_t.indcpstdt, #资料过账日
       indc101 LIKE indc_t.indc101, #调拨部门
       indc102 LIKE indc_t.indc102, #检验方式
       indc103 LIKE indc_t.indc103, #包装单制作
       indc104 LIKE indc_t.indc104, #Invoice制作
       indc105 LIKE indc_t.indc105, #送货地址
       indc106 LIKE indc_t.indc106, #运输方式
       indc107 LIKE indc_t.indc107, #起运地点
       indc108 LIKE indc_t.indc108, #到达地点
       indc109 LIKE indc_t.indc109, #在途非成本库位
       indc151 LIKE indc_t.indc151, #调拨理由
       indc199 LIKE indc_t.indc199, #调拨性质
       indc009 LIKE indc_t.indc009, #单一单位库存单位变更
       indc200 LIKE indc_t.indc200, #拨出仓库
       indc201 LIKE indc_t.indc201, #拨入仓库
       indc010 LIKE indc_t.indc010, #调整单号
       indc202 LIKE indc_t.indc202, #操作类型
       indc025 LIKE indc_t.indc025, #前端单号
       indc026 LIKE indc_t.indc026  #前端类型
   END RECORD
   #161124-00048#10 add(e)
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_date      DATETIME YEAR TO SECOND
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   IF cl_null(g_asrp370_03_m.indcdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00532'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_indc.indcent   = g_enterprise     #企業編號
   LET l_indc.indcsite  = g_site           #營運據點
   LET l_indc.indcunit  = ''               #應用組織
   LET l_indc.indcdocno = ''               #調撥單號	 最后产生
   LET l_indc.indcdocdt = g_asrp370_03_m.indcdocdt  #cl_get_today()   #調撥日期
   LET l_indc.indc000   = '1'              #單據性質:一阶段调拨
   LET l_indc.indc001   = ''               #對應調撥單號
   LET l_indc.indc002   = '1'              #來源類別:手工输入
   LET l_indc.indc003   = ''               #來源單號
   LET l_indc.indc004   = g_user           #調撥人員
   LET l_indc.indc005   = g_site           #撥出營運據點
   LET l_indc.indc006   = g_site           #撥入營運據點
   LET l_indc.indc007   = ''               #在途倉
   LET l_indc.indc008   = ''               #備註
   LET l_indc.indc021   = ''               #撥出確認人員
   LET l_indc.indc022   = ''               #撥出確認日期
   LET l_indc.indc023   = ''               #撥入確認人員
   LET l_indc.indc024   = ''               #撥入確認日期
   LET l_indc.indcstus  = 'N'              #狀態碼
   LET l_indc.indcownid = g_user           #資料所有者
   LET l_indc.indcowndp = g_dept           #資料所屬部門
   LET l_indc.indccrtid = g_user           #資料建立者
   LET l_indc.indccrtdp = g_dept           #資料建立部門
   LET l_indc.indccrtdt = cl_get_current() #資料創建日
   LET l_indc.indcmodid = ''               #資料修改者
   LET l_indc.indcmoddt = ''               #最近修改日
   LET l_indc.indccnfid = ''               #資料確認者
   LET l_indc.indccnfdt = ''               #資料確認日
   LET l_indc.indcpstid = ''               #資料過帳者
   LET l_indc.indcpstdt = ''               #資料過帳日
   LET l_indc.indc101   = g_dept           #調撥部門
   LET l_indc.indc102   = '1'              #檢驗方式:不需检验
   LET l_indc.indc103   = 'N'              #包裝單製作
   LET l_indc.indc104   = 'N'              #Invoice製作
   LET l_indc.indc105   = ''               #送貨地址
   LET l_indc.indc106   = ''               #運輸方式
   LET l_indc.indc107   = ''               #起運地點
   LET l_indc.indc108   = ''               #到達地點
   LET l_indc.indc109   = ''               #在途非成本庫位
   LET l_indc.indc151   = ''               #調撥理由

   CALL s_aooi200_gen_docno(g_site,g_asrp370_03_m.indcdocno,g_today,'aint330')
        RETURNING l_success,l_indc.indcdocno
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
							
#   INSERT INTO indc_t VALUES(l_indc.*) #161124-00048#10 mark
   #161124-00048#10 add-s
   INSERT INTO indc_t(indcent,indcsite,indcunit,indcdocno,indcdocdt,indc000,
                      indc001,indc002,indc003,indc004,indc005,indc006,
                      indc007,indc008,indc021,indc022,indc023,indc024,
                      indcstus,indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt,
                      indcmodid,indcmoddt,indccnfid,indccnfdt,indcpstid,indcpstdt,
                      indc101,indc102,indc103,indc104,indc105,indc106,
                      indc107,indc108,indc109,indc151,indc199,indc009,
                      indc200,indc201,indc010,indc202,indc025,indc026) 
               VALUES(l_indc.indcent,l_indc.indcsite,l_indc.indcunit,l_indc.indcdocno,l_indc.indcdocdt,l_indc.indc000,
                      l_indc.indc001,l_indc.indc002,l_indc.indc003,l_indc.indc004,l_indc.indc005,l_indc.indc006,
                      l_indc.indc007,l_indc.indc008,l_indc.indc021,l_indc.indc022,l_indc.indc023,l_indc.indc024,
                      l_indc.indcstus,l_indc.indcownid,l_indc.indcowndp,l_indc.indccrtid,l_indc.indccrtdp,l_indc.indccrtdt,
                      l_indc.indcmodid,l_indc.indcmoddt,l_indc.indccnfid,l_indc.indccnfdt,l_indc.indcpstid,l_indc.indcpstdt,
                      l_indc.indc101,l_indc.indc102,l_indc.indc103,l_indc.indc104,l_indc.indc105,l_indc.indc106,
                      l_indc.indc107,l_indc.indc108,l_indc.indc109,l_indc.indc151,l_indc.indc199,l_indc.indc009,
                      l_indc.indc200,l_indc.indc201,l_indc.indc010,l_indc.indc202,l_indc.indc025,l_indc.indc026)
   #161124-00048#10 add-e
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
      #数据更新失败
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_date = cl_get_current()
   UPDATE indc_t SET indccrtdt = l_date
    WHERE indcent   = l_indc.indcent
      AND indcdocno = l_indc.indcdocno
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
      #数据更新失败
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET g_asrp370_03_m.indcent_03   = l_indc.indcent
   LET g_asrp370_03_m.indcdocno_03 = l_indc.indcdocno
   LET g_asrp370_03_m.indcdocdt_03 = l_indc.indcdocdt
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...:插入调拨单aint330单身
# Memo...........:
# Usage..........: CALL asrp370_03_gen_aint330_indd()
#                  RETURNING r_success
# Input parameter: 无
# Return code....: r_success      处理状态
# Date & Author..: 2014/07/29 By zhangllc
# Modify.........:
################################################################################
PUBLIC FUNCTION asrp370_03_gen_aint330_indd()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   #161124-00048#10 mark-s
#   DEFINE l_indc      RECORD LIKE indc_t.*
#   DEFINE l_indd      RECORD LIKE indd_t.*
#   DEFINE l_inao      RECORD LIKE inao_t.*
   #161124-00048#10 mark-d
   #161124-00048#10 add-s
   DEFINE l_indc RECORD  #調撥單單頭檔
       indcent LIKE indc_t.indcent, #企业编号
       indcsite LIKE indc_t.indcsite, #营运据点
       indcunit LIKE indc_t.indcunit, #应用组织
       indcdocno LIKE indc_t.indcdocno, #调拨单号
       indcdocdt LIKE indc_t.indcdocdt, #调拨日期
       indc000 LIKE indc_t.indc000, #单据性质
       indc001 LIKE indc_t.indc001, #对应调拨单号
       indc002 LIKE indc_t.indc002, #来源类别
       indc003 LIKE indc_t.indc003, #来源单号
       indc004 LIKE indc_t.indc004, #调拨人员
       indc005 LIKE indc_t.indc005, #拨出营运据点
       indc006 LIKE indc_t.indc006, #拨入营运据点
       indc007 LIKE indc_t.indc007, #在途仓
       indc008 LIKE indc_t.indc008, #备注
       indc021 LIKE indc_t.indc021, #拨出审核人员
       indc022 LIKE indc_t.indc022, #拨出审核日期
       indc023 LIKE indc_t.indc023, #拨入审核人员
       indc024 LIKE indc_t.indc024, #拨入审核日期
       indcstus LIKE indc_t.indcstus, #状态码
       indcownid LIKE indc_t.indcownid, #资料所有者
       indcowndp LIKE indc_t.indcowndp, #资料所有部门
       indccrtid LIKE indc_t.indccrtid, #资料录入者
       indccrtdp LIKE indc_t.indccrtdp, #资料录入部门
       indccrtdt LIKE indc_t.indccrtdt, #资料创建日
       indcmodid LIKE indc_t.indcmodid, #资料更改者
       indcmoddt LIKE indc_t.indcmoddt, #最近更改日
       indccnfid LIKE indc_t.indccnfid, #资料审核者
       indccnfdt LIKE indc_t.indccnfdt, #数据审核日
       indcpstid LIKE indc_t.indcpstid, #资料过账者
       indcpstdt LIKE indc_t.indcpstdt, #资料过账日
       indc101 LIKE indc_t.indc101, #调拨部门
       indc102 LIKE indc_t.indc102, #检验方式
       indc103 LIKE indc_t.indc103, #包装单制作
       indc104 LIKE indc_t.indc104, #Invoice制作
       indc105 LIKE indc_t.indc105, #送货地址
       indc106 LIKE indc_t.indc106, #运输方式
       indc107 LIKE indc_t.indc107, #起运地点
       indc108 LIKE indc_t.indc108, #到达地点
       indc109 LIKE indc_t.indc109, #在途非成本库位
       indc151 LIKE indc_t.indc151, #调拨理由
       indc199 LIKE indc_t.indc199, #调拨性质
       indc009 LIKE indc_t.indc009, #单一单位库存单位变更
       indc200 LIKE indc_t.indc200, #拨出仓库
       indc201 LIKE indc_t.indc201, #拨入仓库
       indc010 LIKE indc_t.indc010, #调整单号
       indc202 LIKE indc_t.indc202, #操作类型
       indc025 LIKE indc_t.indc025, #前端单号
       indc026 LIKE indc_t.indc026  #前端类型
   END RECORD
   DEFINE l_indd RECORD  #調撥單單身明細檔
       inddent LIKE indd_t.inddent, #企业编号
       inddsite LIKE indd_t.inddsite, #营运据点
       inddunit LIKE indd_t.inddunit, #应用组织
       indddocno LIKE indd_t.indddocno, #调拨单号
       inddseq LIKE indd_t.inddseq, #项次
       indd001 LIKE indd_t.indd001, #来源项次
       indd002 LIKE indd_t.indd002, #商品编号
       indd003 LIKE indd_t.indd003, #商品条码
       indd004 LIKE indd_t.indd004, #产品特征
       indd005 LIKE indd_t.indd005, #经营方式
       indd006 LIKE indd_t.indd006, #库存单位
       indd007 LIKE indd_t.indd007, #包装单位
       indd008 LIKE indd_t.indd008, #件装数
       indd009 LIKE indd_t.indd009, #预调拨量
       indd020 LIKE indd_t.indd020, #拨出件数
       indd021 LIKE indd_t.indd021, #拨出数量
       indd022 LIKE indd_t.indd022, #拨出库位
       indd023 LIKE indd_t.indd023, #拨出储位
       indd024 LIKE indd_t.indd024, #拨出批号
       indd030 LIKE indd_t.indd030, #拨入件数
       indd031 LIKE indd_t.indd031, #拨入数量
       indd032 LIKE indd_t.indd032, #拨入库位
       indd033 LIKE indd_t.indd033, #拨入储位
       indd034 LIKE indd_t.indd034, #拨入批号
       indd040 LIKE indd_t.indd040, #结案否
       indd101 LIKE indd_t.indd101, #来源单号
       indd102 LIKE indd_t.indd102, #库存管理特征
       indd103 LIKE indd_t.indd103, #拨出申请量
       indd104 LIKE indd_t.indd104, #参考单位
       indd105 LIKE indd_t.indd105, #拨出申请参考数量
       indd106 LIKE indd_t.indd106, #拨出合格参考数量
       indd107 LIKE indd_t.indd107, #拨入申请数量
       indd108 LIKE indd_t.indd108, #拨入申请参考数量
       indd109 LIKE indd_t.indd109, #拨入合格参考数量
       indd110 LIKE indd_t.indd110, #差异量
       indd111 LIKE indd_t.indd111, #差异原因
       indd112 LIKE indd_t.indd112, #差异已调整量
       indd151 LIKE indd_t.indd151, #调拨理由
       indd152 LIKE indd_t.indd152, #备注
       indd041 LIKE indd_t.indd041, #拨入单位
       indd042 LIKE indd_t.indd042, #项目编号
       indd043 LIKE indd_t.indd043, #WBS
       indd044 LIKE indd_t.indd044, #活动编号
       indd010 LIKE indd_t.indd010, #多库储否
       indd025 LIKE indd_t.indd025, #拨出组织库存数量
       indd035 LIKE indd_t.indd035, #拨入组织库存数量
       indd045 LIKE indd_t.indd045, #预估单价
       indd046 LIKE indd_t.indd046, #预估金额
       indd047 LIKE indd_t.indd047, #来源需求单号
       indd048 LIKE indd_t.indd048  #来源需求项次
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
   #161124-00048#10 add-d
   DEFINE l_sql       STRING
   DEFINE l_temp      RECORD
                      sfdc004   LIKE sfdc_t.sfdc004,  #料号
                      sfdc005   LIKE sfdc_t.sfdc005,  #特征
                      sfdc006   LIKE sfdc_t.sfdc006,  #单位
                      sfdc009   LIKE sfdc_t.sfdc009,  #参考单位
                      sfdc007   LIKE sfdc_t.sfdc007,  #申请数量
                      sfdc010   LIKE sfdc_t.sfdc010,  #参考单位申请数量
                      planware       LIKE sfdc_t.sfdc012,     #拨入库位
                      planloca       LIKE sfdc_t.sfdc013,     #拨入储位
                      sfdc012        LIKE sfdc_t.sfdc012,     #指定库位
                      sfdc013        LIKE sfdc_t.sfdc013,     #指定储位
                      sfdc014        LIKE sfdc_t.sfdc014,     #指定批号
                      sfdc016        LIKE sfdc_t.sfdc016,     #库存管理特征
                      seq       LIKE type_t.num5,     #项次
                      inag004   LIKE inag_t.inag004,  #拨出库位
                      inag005   LIKE inag_t.inag005,  #拨出储位
                      inag006   LIKE inag_t.inag006,  #拨出批号
                      inag003   LIKE inag_t.inag003,  #库存管理特征
                      inag007   LIKE inag_t.inag007,  #单位
                      inag024   LIKE inag_t.inag024,  #参考单位
                      inag008   LIKE inag_t.inag008,  #库存数量
                      inag025   LIKE inag_t.inag025,  #参考单位库存数量
                      pack      LIKE imaa_t.imaa001,  #包装容器
                      qty       LIKE inag_t.inag008,  #拨出数量
                      qtyr      LIKE inag_t.inag025   #拨出参考数量
                      END RECORD
   DEFINE l_temp2     RECORD
                      seq1      LIKE type_t.num5,     #项序
                      inai007   LIKE inai_t.inai007,  #制造批号
                      inai008   LIKE inai_t.inai008,  #制造序号
                     #inai012   LIKE inai_t.inai012,  #制造日期  #160512-00004#1 by whitney mark
                      inae010   LIKE inae_t.inae010,  #制造日期  #160512-00004#1 by whitney add
                      inai010   LIKE inai_t.inai010,  #库存数量
                      qty       LIKE inai_t.inai010   #拨出数量
                      END RECORD
   DEFINE l_inddseq   LIKE indd_t.inddseq  #项次
   DEFINE l_inaoseq2  LIKE inao_t.inaoseq2 #序号
   DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率  不能被覆写
   DEFINE l_rate2     LIKE inaj_t.inaj014  #参考单位换算率
   DEFINE l_imaf053   LIKE imaf_t.imaf053  #據點庫存單位
   DEFINE l_imaf054   LIKE imaf_t.imaf054  #庫存多單位
   DEFINE l_imaf031   LIKE imaf_t.imaf031  #有效期月數
   DEFINE l_imaf032   LIKE imaf_t.imaf032  #有效期加天數
   DEFINE l_ooca002   LIKE ooca_t.ooca002  #单位-小数位数 不能被覆写
   DEFINE l_ooca004   LIKE ooca_t.ooca004  #单位-舍入类型 不能被覆写
   DEFINE l_ooca002_2 LIKE ooca_t.ooca002  #参考单位-小数位数
   DEFINE l_ooca004_2 LIKE ooca_t.ooca004  #参考单位-舍入类型
   DEFINE l_qty       LIKE inag_t.inag008
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
#   SELECT * INTO l_indc.* FROM indc_t #161124-00048#10 mark
   #161124-00048#10 add-s
   SELECT indcent,indcsite,indcunit,indcdocno,indcdocdt,indc000,
          indc001,indc002,indc003,indc004,indc005,indc006,indc007,
          indc008,indc021,indc022,indc023,indc024,indcstus,indcownid,
          indcowndp,indccrtid,indccrtdp,indccrtdt,indcmodid,indcmoddt,
          indccnfid,indccnfdt,indcpstid,indcpstdt,indc101,indc102,
          indc103,indc104,indc105,indc106,indc107,indc108,indc109,
          indc151,indc199,indc009,indc200,indc201,indc010,indc202,
          indc025,indc026 
     INTO l_indc.* FROM indc_t
   #161124-00048#10 add-e
    WHERE indcent   = g_asrp370_03_m.indcent_03
      AND indcdocno = g_asrp370_03_m.indcdocno_03
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel indc'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #LET l_sql = " SELECT asrp370_02_temp3.seq1   , ", #项序
   #            "        asrp370_02_temp3.inai007,asrp370_02_temp3.inai008, ", #制造序号 制造批号
   #            "        asrp370_02_temp3.inai012,asrp370_02_temp3.inai010, ", #制造日期 库存数量
   #            "        asrp370_02_temp3.qty ",  #拨出数量
   #            "  FROM asrp370_02_temp3",
   #            " WHERE sfdc004 = ? ",  #料件编号
   #            "   AND sfdc005 = ? ",  #产品特征
   #            "   AND sfdc006 = ? ",  #单位
   #            "   AND sfdc009 = ? ",  #参考单位
   #            "   AND planware= ? ",  #拨入库位
   #            "   AND planloca= ? ",  #拨入储位
   #            "   AND sfdc012 = ? ",  #指定库位
   #            "   AND sfdc013 = ? ",  #指定储位
   #            "   AND sfdc014 = ? ",  #指定批号
   #            "   AND sfdc016 = ? ",  #库存管理特征
   #            "   AND seq     = ? ",  #库存资料页签的项次
   #            "   AND asrp370_02_temp3.sel = 'Y' ",
   #            "   AND asrp370_02_temp3.qty > 0 ",
   #            " ORDER BY seq,seq1 "
   #PREPARE asrp370_03_gen_aint330_indd_p2 FROM l_sql
   #DECLARE asrp370_03_gen_aint330_indd_c2 CURSOR FOR asrp370_03_gen_aint330_indd_p2
   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_02_temp1 ——> asrp370_tmp04
   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_02_temp2 ——> asrp370_tmp05
   LET l_sql = " SELECT UNIQUE asrp370_tmp04.sfdc004,asrp370_tmp04.sfdc005, ",  #料号，特征
               "        asrp370_tmp04.sfdc006,asrp370_tmp04.sfdc009, ", #单位，参考单位
               "        asrp370_tmp04.sfdc007,asrp370_tmp04.sfdc010, ", #申请数量,参考单位申请数量
               "        asrp370_tmp04.planware,asrp370_tmp04.planloca, ", #拨入库位，拨入储位
               "        asrp370_tmp04.sfdc012,asrp370_tmp04.sfdc013, ", #指定库位，指定储位
               "        asrp370_tmp04.sfdc014,asrp370_tmp04.sfdc016, ", #指定批号，库存管理特征
               #"       asrp370_02_temp1.sumqty,asrp370_02_temp1.sumqtyr,", #拟拨入数量合计
               "        asrp370_tmp05.seq    ,                          ",  #项次
               "        asrp370_tmp05.inag004,asrp370_tmp05.inag005, ",  #拨出库位，拨出储位
               "        asrp370_tmp05.inag006,asrp370_tmp05.inag003, ",  #拨出批号，库存管理特征
               "        asrp370_tmp05.inag007,asrp370_tmp05.inag024, ",  #单位 参考单位
               "        asrp370_tmp05.inag008,asrp370_tmp05.inag025, ",  #库存数量 参考单位库存数量
               "        asrp370_tmp05.pack   ,asrp370_tmp05.qty    , ",  #包装容器 拨出数量
               "        asrp370_tmp05.qtyr   ", #拨出参考数量
               "   FROM asrp370_tmp04,asrp370_tmp05  ",
               "  WHERE asrp370_tmp04.sfdc004 = asrp370_tmp05.sfdc004 ",  #料件编号
               "    AND asrp370_tmp04.sfdc005 = asrp370_tmp05.sfdc005 ",  #产品特征
               "    AND asrp370_tmp04.sfdc006 = asrp370_tmp05.sfdc006 ",  #单位
               "    AND asrp370_tmp04.sfdc009 = asrp370_tmp05.sfdc009 ",  #参考单位
               "    AND asrp370_tmp04.planware= asrp370_tmp05.planware ",  #拨入库位
               "    AND asrp370_tmp04.planloca= asrp370_tmp05.planloca ",  #拨入储位
               "    AND asrp370_tmp04.sfdc012 = asrp370_tmp05.sfdc012 ",  #指定库位
               "    AND asrp370_tmp04.sfdc013 = asrp370_tmp05.sfdc013 ",  #指定储位
               "    AND asrp370_tmp04.sfdc014 = asrp370_tmp05.sfdc014 ",  #指定批号
               "    AND asrp370_tmp04.sfdc016 = asrp370_tmp05.sfdc016 ",  #库存管理特征
               "    AND asrp370_tmp04.sumqty > 0 ",  #拟拨入数量合计
               "    AND asrp370_tmp05.sel = 'Y' ",    #已选择的来源库存
               "    AND asrp370_tmp05.qty > 0 ",      #有拨出量色
               "    AND asrp370_tmp04.sfdc009 IS NOT NULL ",
               " UNION ",
               " SELECT UNIQUE asrp370_tmp04.sfdc004,asrp370_tmp04.sfdc005, ",  #料号，特征
               "        asrp370_tmp04.sfdc006,asrp370_tmp04.sfdc009, ", #单位，参考单位
               "        asrp370_tmp04.sfdc007,asrp370_tmp04.sfdc010, ", #申请数量,参考单位申请数量
               "        asrp370_tmp04.planware,asrp370_tmp04.planloca, ", #拨入库位，拨入储位
               "        asrp370_tmp04.sfdc012,asrp370_tmp04.sfdc013, ", #指定库位，指定储位
               "        asrp370_tmp04.sfdc014,asrp370_tmp04.sfdc016, ", #指定批号，库存管理特征
               #"       asrp370_02_temp1.sumqty,asrp370_02_temp1.sumqtyr,", #拟拨入数量合计
               "        asrp370_tmp05.seq    ,                          ",  #项次
               "        asrp370_tmp05.inag004,asrp370_tmp05.inag005, ",  #拨出库位，拨出储位
               "        asrp370_tmp05.inag006,asrp370_tmp05.inag003, ",  #拨出批号，库存管理特征
               "        asrp370_tmp05.inag007,asrp370_tmp05.inag024, ",  #单位 参考单位
               "        asrp370_tmp05.inag008,asrp370_tmp05.inag025, ",  #库存数量 参考单位库存数量
               "        asrp370_tmp05.pack   ,asrp370_tmp05.qty    , ",  #包装容器 拨出数量
               "        asrp370_tmp05.qtyr   ", #拨出参考数量
               "   FROM asrp370_tmp04,asrp370_tmp05  ",
               "  WHERE asrp370_tmp04.sfdc004 = asrp370_tmp05.sfdc004 ",  #料件编号
               "    AND asrp370_tmp04.sfdc005 = asrp370_tmp05.sfdc005 ",  #产品特征
               "    AND asrp370_tmp04.sfdc006 = asrp370_tmp05.sfdc006 ",  #单位
               #"    AND asrp370_02_temp1.sfdc009 = asrp370_02_temp2.sfdc009 ",  #参考单位
               "    AND asrp370_tmp04.planware= asrp370_tmp05.planware ",  #拨入库位
               "    AND asrp370_tmp04.planloca= asrp370_tmp05.planloca ",  #拨入储位
               "    AND asrp370_tmp04.sfdc012 = asrp370_tmp05.sfdc012 ",  #指定库位
               "    AND asrp370_tmp04.sfdc013 = asrp370_tmp05.sfdc013 ",  #指定储位
               "    AND asrp370_tmp04.sfdc014 = asrp370_tmp05.sfdc014 ",  #指定批号
               "    AND asrp370_tmp04.sfdc016 = asrp370_tmp05.sfdc016 ",  #库存管理特征
               "    AND asrp370_tmp04.sumqty > 0 ",  #拟拨入数量合计
               "    AND asrp370_tmp05.sel = 'Y' ",    #已选择的来源库存
               "    AND asrp370_tmp05.qty > 0 ",      #有拨出量色
               "    AND asrp370_tmp04.sfdc009 IS NULL AND asrp370_tmp05.sfdc009 IS NULL "
   PREPARE asrp370_03_gen_aint330_indd_p FROM l_sql
   DECLARE asrp370_03_gen_aint330_indd_c CURSOR FOR asrp370_03_gen_aint330_indd_p
   LET l_inddseq = 0
   FOREACH asrp370_03_gen_aint330_indd_c INTO l_temp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asrp370_03_gen_aint330_indd_c'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #據點庫存單位 庫存多單位 有效期月數 有效期加天數
      SELECT imaf053,imaf054,imaf031,imaf032
        INTO l_imaf053,l_imaf054,l_imaf031,l_imaf032
        FROM imaf_t
       WHERE imafent = l_indc.indcent
         AND imafsite= l_indc.indcsite
         AND imaf001 = l_temp.sfdc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel imaf'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF cl_null(l_imaf054) THEN
         #输入的料件没有使用多单位!  不能为空的意思
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00178'
         LET g_errparam.extend = l_temp.sfdc004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_imaf054='N' AND cl_null(l_imaf053) THEN
         #此料件不存在对应的据点库存单位！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00476'
         LET g_errparam.extend = l_temp.sfdc004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      INITIALIZE l_indd.* TO NULL
      LET l_indd.inddent   = l_indc.indcent    #企業編號
      LET l_indd.inddsite  = l_indc.indcsite   #營運據點
      LET l_indd.inddunit  = l_indc.indcunit   #應用組織
      LET l_indd.indddocno = l_indc.indcdocno  #調撥單號
      LET l_inddseq = l_inddseq + 1
      LET l_indd.inddseq   = l_inddseq         #項次
      LET l_indd.indd001   = ''                #來源項次
      LET l_indd.indd002   = l_temp.sfdc004    #商品編號
      LET l_indd.indd003   = ''                #商品條碼
      LET l_indd.indd004   = l_temp.sfdc005    #產品特徵
      LET l_indd.indd005   = ''                #經營方式
      LET l_indd.indd007   = ''                #包裝單位
      LET l_indd.indd008   = ''                #件裝數
      LET l_indd.indd009   = ''                #預調撥量
      LET l_indd.indd020   = ''                #撥出件數
      LET l_indd.indd022   = l_temp.inag004    #撥出庫位
      LET l_indd.indd023   = l_temp.inag005    #撥出儲位
      LET l_indd.indd024   = l_temp.inag006    #撥出批號
      LET l_indd.indd030   = ''                #撥入件數
      LET l_indd.indd032   = l_temp.planware    #撥入庫位
      LET l_indd.indd033   = l_temp.planloca    #撥入儲位
      LET l_indd.indd034   = ''                #撥入批號
      LET l_indd.indd040   = 'N'               #結案否
      LET l_indd.indd101   = ''                #來源單號
      LET l_indd.indd102   = l_temp.inag003    #庫存管理特徵
      LET l_indd.indd151   = ''                #調撥理由
      LET l_indd.indd152   = 'asrp370'         #備註
      
      ##-----单位-----
      IF l_imaf054='N' THEN  #库存单一单位
         LET l_indd.indd006   = l_imaf053    #庫存單位
         LET l_indd.indd041   = l_imaf053    #拨入单位add 150108
      ELSE
	      LET l_indd.indd006   = l_temp.inag007    #拨出單位
         LET l_indd.indd041   = l_temp.sfdc006    #拨入单位add 150108
      END IF
      #--拨出
      #单位换算率 库存单位->拨出单位
      CALL s_aooi250_convert_qty(l_indd.indd002,l_temp.inag007,l_indd.indd006,l_temp.qty)
         RETURNING l_success,l_qty
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #單位取位
      LET l_ooca002 = ''
      LET l_ooca004 = ''
      CALL s_aooi250_get_msg(l_indd.indd006) RETURNING l_success,l_ooca002,l_ooca004 #抓取单位档中的小数位数和舍入类型
      IF l_success THEN
         CALL s_num_round(l_ooca004,l_qty,l_ooca002) RETURNING l_qty
      END IF
	   LET l_indd.indd103   = l_qty   #撥出申請量
	   LET l_indd.indd021   = l_qty   #撥出合格數量
      
      #--拨入
      #单位换算率 库存单位->拨入单位
      CALL s_aooi250_convert_qty(l_indd.indd002,l_temp.inag007,l_indd.indd041,l_temp.qty)
         RETURNING l_success,l_qty
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #單位取位
      LET l_ooca002 = '' #小數位數
      LET l_ooca004 = '' #捨入類型
      CALL s_aooi250_get_msg(l_indd.indd041) RETURNING l_success,l_ooca002,l_ooca004 #抓取单位档中的小数位数和舍入类型
      IF l_success THEN
         CALL s_num_round(l_ooca004,l_qty,l_ooca002) RETURNING l_qty
      END IF
	   LET l_indd.indd107   = l_qty   #撥入申請數量
	   LET l_indd.indd031   = l_qty   #撥入數量
      
      
      ##-----参考单位-----
      LET l_indd.indd104   = l_temp.sfdc009    #參考單位
      IF cl_null(l_indd.indd104) THEN
         LET l_indd.indd105   = 0
         LET l_indd.indd106   = 0   #撥出合格參考數量
         LET l_indd.indd108   = 0   #撥入申請參考數量
         LET l_indd.indd109   = 0   #撥入合格參考數量
      ELSE
         #参考單位取位
         LET l_ooca002_2 = ''
         LET l_ooca004_2 = ''
         CALL s_aooi250_get_msg(l_indd.indd104) RETURNING l_success,l_ooca002_2,l_ooca004_2 #抓取单位档中的小数位数和舍入类型
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         #--拨出
         #参考单位换算率
         CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd104,l_indd.indd103)
            RETURNING r_success,l_qty
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         CALL s_num_round(l_ooca004_2,l_qty,l_ooca002_2) RETURNING l_qty
	      LET l_indd.indd105   = l_qty #撥出申請參考數量
	      LET l_indd.indd106   = l_qty #撥出合格參考數量
	      
	      #--拨入
         #参考单位换算率
	      CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd041,l_indd.indd104,l_indd.indd107)
            RETURNING l_success,l_qty
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         CALL s_num_round(l_ooca004_2,l_qty,l_ooca002_2) RETURNING l_qty #参考單位取位
	      LET l_indd.indd108   = l_qty   #撥入申請參考數量
	      LET l_indd.indd109   = l_qty   #撥入合格參考數量
      END IF
      LET l_indd.indd110   = 0                 #差異量
      LET l_indd.indd111   = ''                #差異原因
      LET l_indd.indd112   = 0                 #差異已調整量

#      INSERT INTO indd_t VALUES(l_indd.*) #161124-00048#10 mark
      #161124-00048#10 add-s
      INSERT INTO indd_t(inddent,inddsite,inddunit,indddocno,inddseq,indd001,
                         indd002,indd003,indd004,indd005,indd006,indd007,indd008,
                         indd009,indd020,indd021,indd022,indd023,indd024,indd030,
                         indd031,indd032,indd033,indd034,indd040,indd101,indd102,
                         indd103,indd104,indd105,indd106,indd107,indd108,indd109,
                         indd110,indd111,indd112,indd151,indd152,indd041,indd042,
                         indd043,indd044,indd010,indd025,indd035,indd045,indd046,
                         indd047,indd048) 
                  VALUES(l_indd.inddent,l_indd.inddsite,l_indd.inddunit,l_indd.indddocno,l_indd.inddseq,l_indd.indd001,
                         l_indd.indd002,l_indd.indd003,l_indd.indd004,l_indd.indd005,l_indd.indd006,l_indd.indd007,l_indd.indd008,
                         l_indd.indd009,l_indd.indd020,l_indd.indd021,l_indd.indd022,l_indd.indd023,l_indd.indd024,l_indd.indd030,
                         l_indd.indd031,l_indd.indd032,l_indd.indd033,l_indd.indd034,l_indd.indd040,l_indd.indd101,l_indd.indd102,
                         l_indd.indd103,l_indd.indd104,l_indd.indd105,l_indd.indd106,l_indd.indd107,l_indd.indd108,l_indd.indd109,
                         l_indd.indd110,l_indd.indd111,l_indd.indd112,l_indd.indd151,l_indd.indd152,l_indd.indd041,l_indd.indd042,
                         l_indd.indd043,l_indd.indd044,l_indd.indd010,l_indd.indd025,l_indd.indd035,l_indd.indd045,l_indd.indd046,
                         l_indd.indd047,l_indd.indd048)
      #161124-00048#10 add-e
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = 'ins indd'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #批序号处理
      #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_02_temp3 ——> asrp370_tmp06
      LET l_inaoseq2 = 0
      IF l_temp.sfdc009 IS NULL THEN
         LET l_sql = " SELECT asrp370_tmp06.seq1   , ", #项序
                     "        asrp370_tmp06.inai007,asrp370_tmp06.inai008, ", #制造序号 制造批号
                     "        asrp370_tmp06.inae010,asrp370_tmp06.inai010, ", #制造日期 库存数量  #160512-00004#1 by whitney modify inai012->inae010
                     "        asrp370_tmp06.qty ",  #拨出数量
                     "  FROM asrp370_tmp06",
                     " WHERE sfdc004 = '",l_temp.sfdc004,"' ",  #料件编号
                     "   AND sfdc005 = '",l_temp.sfdc005,"' ",  #产品特征
                     "   AND sfdc006 = '",l_temp.sfdc006,"' ",  #单位
                     "   AND sfdc009 IS NULL ",  #参考单位
                     "   AND planware= '",l_temp.planware,"' ",  #拨入库位
                     "   AND planloca= '",l_temp.planloca,"' ",  #拨入储位
                     "   AND sfdc012 = '",l_temp.sfdc012,"' ",  #指定库位
                     "   AND sfdc013 = '",l_temp.sfdc013,"' ",  #指定储位
                     "   AND sfdc014 = '",l_temp.sfdc014,"' ",  #指定批号
                     "   AND sfdc016 = '",l_temp.sfdc016,"' ",  #库存管理特征
                     "   AND seq     = ",l_temp.seq,  #库存资料页签的项次
                     "   AND sel = 'Y' ",
                     "   AND qty > 0 ",
                     " ORDER BY seq,seq1 "
      ELSE
         LET l_sql = " SELECT asrp370_tmp06.seq1   , ", #项序
                     "        asrp370_tmp06.inai007,asrp370_tmp06.inai008, ", #制造序号 制造批号
                     "        asrp370_tmp06.inae010,asrp370_tmp06.inai010, ", #制造日期 库存数量  #160512-00004#1 by whitney modify inai012->inae010
                     "        asrp370_tmp06.qty ",  #拨出数量
                     "  FROM asrp370_tmp06",
                     " WHERE sfdc004 = '",l_temp.sfdc004,"' ",  #料件编号
                     "   AND sfdc005 = '",l_temp.sfdc005,"' ",  #产品特征
                     "   AND sfdc006 = '",l_temp.sfdc006,"' ",  #单位
                     "   AND sfdc009 = '",l_temp.sfdc009,"' ",  #参考单位
                     "   AND planware= '",l_temp.planware,"' ",  #拨入库位
                     "   AND planloca= '",l_temp.planloca,"' ",  #拨入储位
                     "   AND sfdc012 = '",l_temp.sfdc012,"' ",  #指定库位
                     "   AND sfdc013 = '",l_temp.sfdc013,"' ",  #指定储位
                     "   AND sfdc014 = '",l_temp.sfdc014,"' ",  #指定批号
                     "   AND sfdc016 = '",l_temp.sfdc016,"' ",  #库存管理特征
                     "   AND seq     = ",l_temp.seq,  #库存资料页签的项次
                     "   AND sel = 'Y' ",
                     "   AND qty > 0 ",
                     " ORDER BY seq,seq1 "
      END IF
      PREPARE asrp370_03_gen_aint330_indd_p2 FROM l_sql
      DECLARE asrp370_03_gen_aint330_indd_c2 CURSOR FOR asrp370_03_gen_aint330_indd_p2
      #FOREACH asrp370_03_gen_aint330_indd_c2 USING l_temp.sfdc004,l_temp.sfdc005,l_temp.sfdc006,l_temp.sfdc009,
      #                                             l_temp.planware,l_temp.planloca,
      #                                             l_temp.sfdc012,l_temp.sfdc013,l_temp.sfdc014,l_temp.sfdc016,
      #                                             l_temp.seq
      FOREACH asrp370_03_gen_aint330_indd_c2
         INTO l_temp2.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asrp370_03_gen_aint330_indd_c2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         INITIALIZE l_inao.* TO NULL
         LET l_inao.inaoent  = l_indd.inddent   #企業編號
         LET l_inao.inaosite = l_indd.inddsite  #營運據點
         LET l_inao.inaodocno= l_indd.indddocno #單號
         LET l_inao.inaoseq  = l_indd.inddseq   #項次
         LET l_inao.inaoseq1 = 0                #項序
         LET l_inaoseq2 = l_inaoseq2 + 1
         LET l_inao.inaoseq2 = l_inaoseq2       #序號
         LET l_inao.inao000  = '1'              #資料類型:申请 还是应该实际呢？ aint330此功能尚未实现
         LET l_inao.inao001  = l_indd.indd002   #料件編號
         LET l_inao.inao002  = l_indd.indd004   #產品特徵
         LET l_inao.inao003  = l_indd.indd102   #庫存管理特徵
         LET l_inao.inao004  = l_temp.pack      #包裝容器編號
         LET l_inao.inao005  = l_indd.indd022   #庫位
         LET l_inao.inao006  = l_indd.indd023   #儲位
         LET l_inao.inao007  = l_indd.indd024   #批號
         LET l_inao.inao008  = l_temp2.inai007  #製造批號
         LET l_inao.inao009  = l_temp2.inai008  #製造序號
         LET l_inao.inao010  = l_temp2.inae010  #製造日期  #160512-00004#1 by whitney modify inai012->inae010
         #製造日期後自動推算有效日期，推算公式=製造日期+料件設定的有效期限
         CALL s_date_get_date(l_inao.inao010,l_imaf031,l_imaf032)
            RETURNING l_inao.inao011
         #mod 150105
         #LET l_inao.inao012  = l_temp2.qty * l_rate      #數量
         CALL s_aooi250_convert_qty(l_indd.indd002,l_temp.inag007,l_indd.indd006,l_temp2.qty)
            RETURNING l_success,l_inao.inao012
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         #mod 150105 end
         #單位取位
         CALL s_num_round(l_ooca004,l_inao.inao012,l_ooca002) RETURNING l_inao.inao012 
      
         LET l_inao.inao013  = -1               #出入庫碼

#         INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#10 mark
         #161124-00048#10 add-s
         INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,
                            inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,
                            inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,
                            inao022,inao023,inao024,inao025)
                     VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,
                            l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
                            l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,
                            l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
         #161124-00048#10 add-e
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00034'
            LET g_errparam.extend = 'ins inao'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF						

      END FOREACH
   END FOREACH
   CLOSE asrp370_03_gen_aint330_indd_c
   FREE asrp370_03_gen_aint330_indd_p

   RETURN r_success
END FUNCTION

 
{</section>}
 
