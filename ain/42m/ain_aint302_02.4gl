#該程式未解開Section, 採用最新樣板產出!
{<section id="aint302_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-12-29 16:32:09), PR版次:0006(2017-02-20 14:06:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000079
#+ Filename...: aint302_02
#+ Description: 產生QC單
#+ Creator....: 01534(2014-12-29 16:25:32)
#+ Modifier...: 01534 -SD/PR- 01996
 
{</section>}
 
{<section id="aint302_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#22   16/04/23  BY 07900   校验代码重复错误讯息的修改
#161124-00048#13   16/12/29  By 08734   星号整批调整
#160711-00040#15   17/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_qcba_m        RECORD
       qcbadocno LIKE qcba_t.qcbadocno, 
   qcbadocdt LIKE qcba_t.qcbadocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_qcba_m        type_g_qcba_m
 
   DEFINE g_qcbadocno_t LIKE qcba_t.qcbadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aint302_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aint302_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_inbadocno
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_inbadocno         LIKE inba_t.inbadocno
   DEFINE l_site              LIKE inba_t.inbasite
   DEFINE l_success           LIKE type_t.num5
   DEFINE r_success           LIKE type_t.num5   
   DEFINE l_ooef004           LIKE ooef_t.ooef004
   DEFINE l_start_no          LIKE inba_t.inbadocno
   DEFINE l_end_no            LIKE inba_t.inbadocno   
   DEFINE  l_sql1                STRING     #160711-00040#15 add
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   LET g_errshow = 1
   IF cl_null(p_inbadocno) THEN
      RETURN 
   END IF
   
   CALL aint302_02_chk(p_inbadocno)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF     
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint302_02 WITH FORM cl_ap_formpath("ain","aint302_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   SELECT inbasite INTO l_site FROM inba_t WHERE inbaent = g_enterprise AND inbadocno = p_inbadocno
   LET g_qcba_m.qcbadocdt = cl_get_today()
   DISPLAY BY NAME g_qcba_m.qcbadocdt   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_qcba_m.qcbadocno,g_qcba_m.qcbadocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcbadocno
            #add-point:BEFORE FIELD qcbadocno name="input.b.qcbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcbadocno
            
            #add-point:AFTER FIELD qcbadocno name="input.a.qcbadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  NOT cl_null(g_qcba_m.qcbadocno) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcba_m.qcbadocno != g_qcbadocno_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcba_t WHERE "||"qcbaent = '" ||g_enterprise|| "' AND "||"qcbadocno = '"||g_qcba_m.qcbadocno ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF

            IF cl_null(g_qcba_m.qcbadocno) THEN
               NEXT FIELD qcbadocno
            END IF
            CALL s_aooi200_chk_slip(l_site,'',g_qcba_m.qcbadocno,'aqct300')
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD qcbadocno
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcbadocno
            #add-point:ON CHANGE qcbadocno name="input.g.qcbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcbadocdt
            #add-point:BEFORE FIELD qcbadocdt name="input.b.qcbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcbadocdt
            
            #add-point:AFTER FIELD qcbadocdt name="input.a.qcbadocdt"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcbadocdt
            #add-point:ON CHANGE qcbadocdt name="input.g.qcbadocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.qcbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcbadocno
            #add-point:ON ACTION controlp INFIELD qcbadocno name="input.c.qcbadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcba_m.qcbadocno             #給予default值
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_site

            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = "aqct300"
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_6()                                #呼叫開窗

            LET g_qcba_m.qcbadocno = g_qryparam.return1              

            DISPLAY g_qcba_m.qcbadocno TO qcbadocno              #

            NEXT FIELD qcbadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.qcbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcbadocdt
            #add-point:ON ACTION controlp INFIELD qcbadocdt name="input.c.qcbadocdt"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            CALL s_aqct300_gen('5',p_inbadocno,0,g_qcba_m.qcbadocno,g_qcba_m.qcbadocdt)
                 RETURNING l_success,l_start_no,l_end_no
            IF l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00399'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()   
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()               
            END IF                    
            DISPLAY "Start No:",l_start_no,"    End No:",l_end_no
#            LET r_success = l_success
            EXIT DIALOG
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
   CLOSE WINDOW w_aint302_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint302_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查
# Memo...........:
# Usage..........: CALL aint302_02_chk(p_inbadocno)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint302_02_chk(p_inbadocno)
DEFINE  p_inbadocno      LIKE inba_t.inbadocno
DEFINE  r_success         LIKE type_t.num5
DEFINE  l_cnt             LIKE type_t.num5
#DEFINE  l_inbb            RECORD LIKE inbb_t.*  #161124-00048#13  16/12/29 By 08734 mark
#161124-00048#13  16/12/29 By 08734 add(S)
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
       inbb225 LIKE inbb_t.inbb225 #计价数量
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
DEFINE  l_qc_qty          LIKE inbb_t.inbb011
DEFINE  l_flag            LIKE type_t.chr1

   LET r_success = FALSE
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_inbadocno
   #160318-00025#23  by 07900 --add-str
   LET g_errshow = TRUE #是否開窗                   
   LET g_chkparam.err_str[1] ="aqc-00045:sub-01318|aint302|",cl_get_progname("aint302",g_lang,"2"),"|:EXEPROGaint302"
   #160318-00025#23  by 07900 --add-end
   IF NOT cl_chk_exist("v_inbadocno_7") THEN
      RETURN r_success
   END IF 
   
   #2.雜發单中是否有需QC的单身
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM inbb_t
    WHERE inbbent   = g_enterprise
      AND inbbdocno = p_inbadocno
      AND inbb018 = 'Y'
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00375'
      LET g_errparam.extend = p_inbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   
   #3.工单有FQC的单身,检查是否全数FQC了
   DECLARE aint302_02_chk CURSOR FOR
    #SELECT * FROM inbb_t  #161124-00048#13  16/12/29 By 08734 mark
    SELECT inbbent,inbbsite,inbbdocno,inbbseq,inbb001,inbb002,inbb003,inbb004,inbb007,inbb008,inbb009,
           inbb010,inbb011,inbb012,inbb013,inbb014,inbb015,inbb016,inbb017,inbb018,inbb019,inbb020,
           inbb021,inbb022,inbb200,inbb201,inbb202,inbb203,inbbunit,inbb204,inbb023,inbb024,inbb025,
           inbb205,inbb206,inbb207,inbb208,inbb209,inbb210,inbb211,inbb212,inbb213,inbb214,inbb215,
           inbb216,inbb217,inbb218,inbb219,inbb220,inbb221,inbb222,inbb223,inbb224,inbb225 FROM inbb_t  #161124-00048#13  16/12/29 By 08734 add
    WHERE inbbent   = g_enterprise
      AND inbbdocno = p_inbadocno
      AND inbb018 = 'Y'
   LET l_flag = 'N'      
   FOREACH aint302_02_chk INTO l_inbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach aint302_02_chk'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success         
      END IF
      
      LET l_qc_qty = 0
      
      SELECT SUM(qcba017) INTO l_qc_qty FROM qcba_t
       WHERE qcbaent  = g_enterprise
         AND qcbasite = l_inbb.inbbsite
         AND qcba001  = p_inbadocno
         AND qcba002  = l_inbb.inbbseq
         AND qcbastus <> 'X'         
      IF cl_null(l_qc_qty) THEN LET l_qc_qty = 0 END IF
      #检查是否还有剩余可FQC的量
      IF l_qc_qty < l_inbb.inbb011 THEN
         LET l_flag = 'Y'
         EXIT FOREACH
      END IF
   END FOREACH
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00376'
      LET g_errparam.extend = p_inbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
      
   LET r_success = TRUE
   RETURN r_success  
END FUNCTION

 
{</section>}
 
