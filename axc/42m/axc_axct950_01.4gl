#該程式已解開Section, 不再透過樣板產出!
{<section id="axct950_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-07-25 11:17:29), PR版次:0004(2017-01-05 18:41:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000018
#+ Filename...: axct950_01
#+ Description: 內部代工生產結算
#+ Creator....: 00768(2016-07-13 09:52:37)
#+ Modifier...: 00768 -SD/PR- 00768
 
{</section>}
 
{<section id="axct950_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#161103-00045#3   2016/11/04 By shiun    更改s_get_item_acc傳入參數
#161124-00048#19 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#170105-00002#1   2017/01/05 By 00768     修改161103-00045#3修改的取科目错误
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
IMPORT FGL lib_cl_schedule
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr  ui.Window
   DEFINE gfrm_curr  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
#end add-point
 
{</section>}
 
{<section id="axct950_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
PRIVATE TYPE type_master RECORD
        aa           LIKE type_t.chr1, 
        inaj022      LIKE inaj_t.inaj022,
        inaj020      LIKE inaj_t.inaj020,
        wc_aa        STRING,
        
        bb           LIKE type_t.chr1, 
        sffbdocdt    LIKE sffb_t.sffbdocdt,
        sffb005      LIKE sffb_t.sffb005,
        wc_bb        STRING
                     END RECORD
DEFINE g_master      type_master

DEFINE g_sql             STRING        #組 sql 用
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING


DEFINE g_xcjeld     LIKE xcje_t.xcjeld
DEFINE g_xcjedocno  LIKE xcje_t.xcjedocno
#DEFINE g_xcje       RECORD LIKE xcje_t.*    #161124-00048#19 mark
#DEFINE g_glaa       RECORD LIKE glaa_t.*    #161124-00048#19 mark
#DEFINE g_xcja       RECORD LIKE xcja_t.*    #161124-00048#19 mark
#161124-00048#19 add(s)
DEFINE g_xcje RECORD  #內部收入成本數據單頭檔
       xcjeent LIKE xcje_t.xcjeent, #企业编号
       xcjesite LIKE xcje_t.xcjesite, #账务中心
       xcjeld LIKE xcje_t.xcjeld, #账套
       xcjedocno LIKE xcje_t.xcjedocno, #单据编号
       xcjedocdt LIKE xcje_t.xcjedocdt, #单据日期
       xcje001 LIKE xcje_t.xcje001, #来源类型
       xcje002 LIKE xcje_t.xcje002, #年度
       xcje003 LIKE xcje_t.xcje003, #期别
       xcje004 LIKE xcje_t.xcje004, #凭证号码
       xcje005 LIKE xcje_t.xcje005, #凭证日期
       xcje006 LIKE xcje_t.xcje006, #计算类型(版本)
       xcje007 LIKE xcje_t.xcje007, #账务人员
       xcjeownid LIKE xcje_t.xcjeownid, #资料所有者
       xcjeowndp LIKE xcje_t.xcjeowndp, #资料所有部门
       xcjecrtid LIKE xcje_t.xcjecrtid, #资料录入者
       xcjecrtdp LIKE xcje_t.xcjecrtdp, #资料录入部门
       xcjecrtdt LIKE xcje_t.xcjecrtdt, #资料创建日
       xcjemodid LIKE xcje_t.xcjemodid, #资料更改者
       xcjemoddt LIKE xcje_t.xcjemoddt, #最近更改日
       xcjecnfid LIKE xcje_t.xcjecnfid, #资料审核者
       xcjecnfdt LIKE xcje_t.xcjecnfdt, #数据审核日
       xcjepstid LIKE xcje_t.xcjepstid, #资料过账者
       xcjepstdt LIKE xcje_t.xcjepstdt, #资料过账日
       xcjestus LIKE xcje_t.xcjestus  #状态码
END RECORD
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企业编号
       glaaownid LIKE glaa_t.glaaownid, #资料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
       glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
       glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
       glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
       glaamodid LIKE glaa_t.glaamodid, #资料更改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
       glaastus LIKE glaa_t.glaastus, #状态码
       glaald LIKE glaa_t.glaald, #账套编号
       glaacomp LIKE glaa_t.glaacomp, #归属法人
       glaa001 LIKE glaa_t.glaa001, #使用币种
       glaa002 LIKE glaa_t.glaa002, #汇率参照表号
       glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
       glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
       glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
       glaa006 LIKE glaa_t.glaa006, #月结方式
       glaa007 LIKE glaa_t.glaa007, #年结方式
       glaa008 LIKE glaa_t.glaa008, #平行记账否
       glaa009 LIKE glaa_t.glaa009, #凭证登录方式
       glaa010 LIKE glaa_t.glaa010, #现行年度
       glaa011 LIKE glaa_t.glaa011, #现行期别
       glaa012 LIKE glaa_t.glaa012, #最后过账日期
       glaa013 LIKE glaa_t.glaa013, #关账日期
       glaa014 LIKE glaa_t.glaa014, #主账套
       glaa015 LIKE glaa_t.glaa015, #启用本位币二
       glaa016 LIKE glaa_t.glaa016, #本位币二
       glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
       glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
       glaa019 LIKE glaa_t.glaa019, #启用本位币三
       glaa020 LIKE glaa_t.glaa020, #本位币三
       glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
       glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
       glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
       glaa024 LIKE glaa_t.glaa024, #单据别参照表号
       glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
       glaa026 LIKE glaa_t.glaa026, #币种参照表号
       glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
       glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
       glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
       glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
       glaa111 LIKE glaa_t.glaa111, #应计调整单别
       glaa112 LIKE glaa_t.glaa112, #期末结转单别
       glaa113 LIKE glaa_t.glaa113, #年底结转单别
       glaa120 LIKE glaa_t.glaa120, #成本计算类型
       glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
       glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
       glaa027 LIKE glaa_t.glaa027, #单据据点编号
       glaa130 LIKE glaa_t.glaa130, #合并账套否
       glaa131 LIKE glaa_t.glaa131, #分层合并
       glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
       glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
       glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
       glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
       glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
       glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
       glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
       glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
       glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
       glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
       glaa028 LIKE glaa_t.glaa028  #汇率来源
END RECORD
DEFINE g_xcja RECORD  #內部交易計算基礎設定
       xcjaent LIKE xcja_t.xcjaent, #企业编号
       xcja001 LIKE xcja_t.xcja001, #计算类型(版本)
       xcja002 LIKE xcja_t.xcja002, #主类型(版本)否
       xcja003 LIKE xcja_t.xcja003, #利润中心来源
       xcja004 LIKE xcja_t.xcja004, #类别
       xcja005 LIKE xcja_t.xcja005, #计算依据
       xcja006 LIKE xcja_t.xcja006, #核算币种
       xcja007 LIKE xcja_t.xcja007, #虚拟利润中心编号
       xcja008 LIKE xcja_t.xcja008, #计算方式
       xcja009 LIKE xcja_t.xcja009, #对比成本计算类型
       xcja010 LIKE xcja_t.xcja010, #结存是否计算内部成本
       xcjaownid LIKE xcja_t.xcjaownid, #资料所有者
       xcjaowndp LIKE xcja_t.xcjaowndp, #资料所有部门
       xcjacrtid LIKE xcja_t.xcjacrtid, #资料录入者
       xcjacrtdp LIKE xcja_t.xcjacrtdp, #资料录入部门
       xcjacrtdt LIKE xcja_t.xcjacrtdt, #资料创建日
       xcjamodid LIKE xcja_t.xcjamodid, #资料更改者
       xcjamoddt LIKE xcja_t.xcjamoddt, #最近更改日
       xcjastus LIKE xcja_t.xcjastus, #状态码
       xcja011 LIKE xcja_t.xcja011  #成本调整取价
END RECORD
#161124-00048#19 add(e)
DEFINE g_bdate      LIKE type_t.dat    #当期所属的起始日期
DEFINE g_edate      LIKE type_t.dat    #当期所属的截止日期
#end add-point
 
{</section>}
 
{<section id="axct950_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axct950_01.other_dialog" >}

 
{</section>}
 
{<section id="axct950_01.other_function" readonly="Y" >}

PUBLIC FUNCTION axct950_01(--)
   p_xcjeld,p_xcjedocno
   )

   DEFINE p_xcjeld     LIKE xcje_t.xcjeld
   DEFINE p_xcjedocno  LIKE xcje_t.xcjedocno

   IF cl_null(p_xcjeld) OR cl_null(p_xcjeld) THEN
      RETURN
   END IF

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_xcjeld    = p_xcjeld
   LET g_xcjedocno = p_xcjedocno
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct950_01 WITH FORM cl_ap_formpath("axc","axct950_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL axct950_01_init()

   #進入選單 Menu (="N")
   CALL axct950_01_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_axct950_01

END FUNCTION

PRIVATE FUNCTION axct950_01_init()
DEFINE ls_path        STRING

   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   #CALL cl_schedule_import_4fd()

   #LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   #LET ls_path = os.Path.join(ls_path,"toolbar_p.4tb")
   #CALL gfrm_curr.loadToolBar(ls_path)
   
   
#   SELECT * INTO g_xcje.* FROM xcje_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
    SELECT xcjeent,xcjesite,xcjeld,xcjedocno,xcjedocdt,xcje001,xcje002,
           xcje003,xcje004,xcje005,xcje006,xcje007,xcjeownid,xcjeowndp,
           xcjecrtid,xcjecrtdp,xcjecrtdt,xcjemodid,xcjemoddt,xcjecnfid,
           xcjecnfdt,xcjepstid,xcjepstdt,xcjestus 
      INTO g_xcje.* FROM xcje_t
   #161124-00048#19 add(e)
    WHERE xcjeent  = g_enterprise
      AND xcjeld   = g_xcjeld
      AND xcjedocno= g_xcjedocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = '-400'
      LET g_errparam.popup  = TRUE
      RETURN
   END IF
   
#   SELECT * INTO g_xcja.* FROM xcja_t  #内部交易计算基础设置  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjaent,xcja001,xcja002,xcja003,xcja004,xcja005,xcja006,xcja007,
          xcja008,xcja009,xcja010,xcjaownid,xcjaowndp,xcjacrtid,xcjacrtdp,
          xcjacrtdt,xcjamodid,xcjamoddt,xcjastus,xcja011 
     INTO g_xcja.* FROM xcja_t  #内部交易计算基础设置
   #161124-00048#19 add(e)
    WHERE xcjaent = g_enterprise
      AND xcja001 = g_xcje.xcje006  #计算类型(版本)
   
#   SELECT * INTO g_glaa.* FROM glaa_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,
          glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,
          glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,
          glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
          glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,
          glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
          glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,
          glaa124,glaa028 
     INTO g_glaa.* FROM glaa_t
   #161124-00048#19 add(e)
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcje.xcjeld
   #取当期的起始及截止日期
   CALL s_fin_date_get_period_range(g_glaa.glaa003,g_xcje.xcje002,g_xcje.xcje003)
        RETURNING g_bdate,g_edate


END FUNCTION

#
PRIVATE FUNCTION axct950_01_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_master
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_errno            LIKE gzze_t.gzze001
   DEFINE l_date             LIKE type_t.dat
   DEFINE l_master_t         type_master  
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT BY NAME g_master.aa,g_master.bb 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               IF cl_null(g_master.aa) THEN LET g_master.aa = 'Y' END IF
               IF cl_null(g_master.bb) THEN LET g_master.bb = 'Y' END IF
               IF g_master.aa = 'Y' THEN
                  LET g_master.inaj022 = GET_FLDBUF(inaj022)
                  IF cl_null(g_master.inaj022) THEN
                     DISPLAY g_xcje.xcjedocdt TO FORMONLY.inaj022
                  END IF       
               END IF
               IF g_master.bb = 'Y' THEN
                  LET g_master.sffbdocdt = GET_FLDBUF(sffbdocdt)
                  IF cl_null(g_master.sffbdocdt) THEN
                     DISPLAY g_xcje.xcjedocdt TO FORMONLY.sffbdocdt
                  END IF     
               END IF
          
            ON CHANGE aa
               IF g_master.aa = 'N' THEN
                  #CALL cl_set_comp_entry('inaj022,inaj020',FALSE)
                  #DISPLAY '' TO FORMONLY.inaj022
                  #DISPLAY '' TO FORMONLY.inaj020
                  LET g_master.wc_aa = " 1=1"
               ELSE
                  #CALL cl_set_comp_entry('inaj022,inaj020',TRUE)
               END IF
               
            ON CHANGE bb
               IF g_master.bb = 'N' THEN
                  #CALL cl_set_comp_entry('sffbdocdt,sffb005',FALSE)
                  #DISPLAY '' TO FORMONLY.sffbdocdt
                  #DISPLAY '' TO FORMONLY.sffb005
                  LET g_master.wc_bb = " 1=1"
               ELSE
                  #CALL cl_set_comp_entry('sffbdocdt,sffb005',TRUE)
               END IF
               
            AFTER INPUT
               IF cl_null(g_master.aa) THEN
                  LET g_master.aa = 'N'
               END IF
               
               IF cl_null(g_master.bb) THEN
                  LET g_master.bb = 'N'
               END IF
         END INPUT
      
         #螢幕上取條件
         CONSTRUCT BY NAME g_master.wc_aa ON inaj022,inaj020
            BEFORE CONSTRUCT
               LET g_master.inaj022 = GET_FLDBUF(inaj022)
               IF cl_null(g_master.inaj022) THEN
                  DISPLAY g_xcje.xcjedocdt TO FORMONLY.inaj022
               END IF            
      
            ON ACTION controlp INFIELD inaj020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM inaj_t ",  
                                      "          WHERE inajent = ",g_enterprise,
                                      "            AND inaj020 = sfaadocno ",  #工单
                                      "            AND inaj036 IN ('110','111','112','113','114') ",  #入库类型,不含"委外採購單"類型
                                      "            AND inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'", #取本月有工單入庫者
                                      "         ) "
               CALL q_sfaadocno_14()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inaj020  #顯示到畫面上
               NEXT FIELD inaj020                     #返回原欄位
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_master.wc_bb ON sffbdocdt,sffb005
            BEFORE CONSTRUCT
               LET g_master.sffbdocdt = GET_FLDBUF(sffbdocdt)
               IF cl_null(g_master.sffbdocdt) THEN
                  DISPLAY g_xcje.xcjedocdt TO FORMONLY.sffbdocdt
               END IF      
            
            ON ACTION controlp INFIELD sffb005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM sffb_t ",
                                      "          WHERE sffbent = ",g_enterprise,
                                      "            AND sffb005 = sfaadocno ",  #工单
                                      "            AND sffbdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'", #取本月有報工的工單資料開窗。
                                      "         ) "
               CALL q_sfaadocno_14()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sffb005  #顯示到畫面上
               NEXT FIELD sffb005                     #返回原欄位
         END CONSTRUCT
         
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            #CALL axcp500_get_buffer(l_dialog)

         ON ACTION close
            LET INT_FLAG = TRUE
            LET g_action_choice = "exit"
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            LET g_action_choice = "exit"
            EXIT DIALOG
 
        ON ACTION accept
           CALL axct950_01_process()
           LET g_action_choice = "exit"
           EXIT DIALOG
           
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "exit"  AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

 
END FUNCTION

##
PRIVATE FUNCTION axct950_01_process()
   DEFINE ls_js         STRING
   DEFINE lc_param      type_master
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_success_g   LIKE type_t.num5
   
   #CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   
   IF cl_null(g_master.wc_aa) THEN LET g_master.wc_aa = " 1=1" END IF
   IF cl_null(g_master.wc_bb) THEN LET g_master.wc_bb = " 1=1" END IF
   LET l_success_g = TRUE
   
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      CALL s_transaction_begin()
      
      IF g_master.aa = 'Y' THEN
         CALL axct950_01_aa() RETURNING l_success
         IF NOT l_success THEN
            LET l_success_g = l_success
         END IF
      END IF
      
      IF g_master.bb = 'Y' THEN
         CALL axct950_01_bb() RETURNING l_success
         IF NOT l_success THEN
            LET l_success_g = l_success
         END IF
      END IF
      
      IF l_success_g  THEN
         CALL s_transaction_end('Y','1')
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      
      CALL cl_ask_confirm3("std-00012","")  #批次作业已执行完成
   ELSE
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axct950_01_msgcentre_notify()
END FUNCTION

#內部代工生產結算
#同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门负责做，这样A与B之间需要内部结算加工收入和费用。
#产生2笔axct950的数据，一笔是工单生产部门的内部加工收入；另一笔工单所属site的内部加工成本。
PRIVATE FUNCTION axct950_01_aa()
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_sql      STRING
DEFINE l_inaj001  LIKE inaj_t.inaj001
DEFINE l_inaj002  LIKE inaj_t.inaj002
DEFINE l_inaj003  LIKE inaj_t.inaj003
DEFINE l_inaj020  LIKE inaj_t.inaj020
DEFINE l_inaj005  LIKE inaj_t.inaj005
DEFINE l_inaj006  LIKE inaj_t.inaj006
DEFINE l_inaj007  LIKE inaj_t.inaj007
DEFINE l_inaj008  LIKE inaj_t.inaj008
DEFINE l_inaj009  LIKE inaj_t.inaj009
DEFINE l_inaj010  LIKE inaj_t.inaj010
DEFINE l_inaj011  LIKE inaj_t.inaj011
DEFINE l_inaj012  LIKE inaj_t.inaj012
DEFINE l_sfaa017  LIKE sfaa_t.sfaa017
DEFINE l_ooeg004  LIKE ooeg_t.ooeg004
DEFINE l_sfaa068  LIKE sfaa_t.sfaa068
DEFINE l_sfaa012  LIKE sfaa_t.sfaa012
DEFINE l_sfaa013  LIKE sfaa_t.sfaa013

   LET r_success = TRUE
   
   #                           入库单                  工单    入库料号  库位    批号    交易数量 单位
   LET l_sql = " SELECT UNIQUE inaj001,inaj002,inaj003,inaj020,inaj005,inaj008,inaj010,inaj011,inaj012, ",
   #                   部门供应商，部门所属成本中心，成本中心
               "       sfaa017,ooeg004,sfaa068  ",
               "   FROM inaj_t,sfaa_t,ooeg_t ",
               "  WHERE inajent = ",g_enterprise,
               "    AND inajsite='",g_site,"' ",
               "    AND inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj036 IN ('110','111','112','113','114') ",
               "    AND inaj020 IS NOT NULL ",
               "    AND inajent = sfaaent   ",
               "    AND inaj020 = sfaadocno ",  #工单
               "    AND ooegent = sfaaent   ",
               "    AND ooeg001 = sfaa017   ",  #部门
               "    AND ooeg004 IS NOT NULL ",
               "    AND ooeg004!= sfaa068   ",
               "    AND ",g_master.wc_aa CLIPPED,
               "  ORDER BY inaj020 "
   PREPARE axct950_01_aa_p1 FROM l_sql
   DECLARE axct950_01_aa_c1 CURSOR FOR axct950_01_aa_p1
   FOREACH axct950_01_aa_c1 INTO l_inaj001,l_inaj002,l_inaj003,l_inaj020,l_inaj005,l_inaj008,l_inaj010,l_inaj011,l_inaj012,
                                 l_sfaa017,l_ooeg004,l_sfaa068
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach axct950_01_aa_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      CALL axct950_01_ins_xcjf_f_sfaa(g_xcjeld,g_xcjedocno,l_inaj001,l_inaj002,l_inaj003,l_inaj020,l_inaj005,l_inaj008,l_inaj010,l_inaj011,l_inaj012,l_ooeg004,l_sfaa068) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH

   RETURN r_success
END FUNCTION

#內部代加工費用結算
PRIVATE FUNCTION axct950_01_bb()
DEFINE r_success       LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_sql           STRING
DEFINE l_sffbdocno     LIKE sffb_t.sffbdocno #报工单号
DEFINE l_sffb005       LIKE sffb_t.sffb005 #报工工单
DEFINE l_sffb029       LIKE sffb_t.sffb029 #报工料号
DEFINE l_sfaa017       LIKE sfaa_t.sfaa017 #生产部门
DEFINE l_ooeg004_sfaa  LIKE ooeg_t.ooeg004
DEFINE l_sffb003       LIKE sffb_t.sffb003 #报工部门
DEFINE l_ooeg004_sffb  LIKE ooeg_t.ooeg004
DEFINE l_sffb017       LIKE sffb_t.sffb017 #报工数量
DEFINE l_sffb016       LIKE sffb_t.sffb016 #报工单位

   LET r_success = TRUE
   
   #                           报工单，   工单，  报工料号，生产部门，成本中心，报工部门，成本中心，报工数量，报工单位
   LET l_sql = " SELECT UNIQUE sffbdocno,sffb005,sffb029,sfaa017,a.ooeg004,sffb003,b.ooeg004,sffb017,sffb016  ",
               "   FROM sffb_t,sfaa_t,ooeg_t a,ooeg_t b ",
               "  WHERE sffbent = ",g_enterprise,
               "    AND sffbsite = '",g_site,"' ",
               "    AND sffbdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND sffbstus = 'Y' ",
               "    AND ",g_master.wc_bb CLIPPED,
               "    AND sffb005 = sfaadocno ",  #工单
               "    AND sffbent = sfaaent   ",
               "    AND a.ooegent = sfaaent  ",
               "    AND a.ooeg001 = sfaa017   ",  #生产部门
               "    AND a.ooeg004 IS NOT NULL ",
               "    AND b.ooegent = sffbent ",
               "    AND b.ooeg001 = sffb003   ",  #报工部门
               "    AND b.ooeg004 IS NOT NULL ",
               "    AND a.ooeg004!= b.ooeg004   ",
               "  ORDER BY sffbdocno "
   PREPARE axct950_01_bb_p1 FROM l_sql
   DECLARE axct950_01_bb_c1 CURSOR FOR axct950_01_bb_p1
   FOREACH axct950_01_bb_c1 INTO l_sffbdocno,l_sffb005,l_sffb029,l_sfaa017,l_ooeg004_sfaa,l_sffb003,l_ooeg004_sffb,l_sffb017,l_sffb016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach axct950_01_bb_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      CALL axct950_01_ins_xcjf_f_sffb(g_xcjeld,g_xcjedocno,l_sffbdocno,l_sffb005,l_sffb029,l_ooeg004_sfaa,l_ooeg004_sffb,l_sffb017,l_sffb016) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH

   RETURN r_success
END FUNCTION

#內部代工生產結算：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门负责做，这样A与B之间需要内部结算加工收入和费用。
PUBLIC FUNCTION axct950_01_ins_xcjf_f_sfaa(p_xcjeld,p_xcjedocno,p_inaj001,p_inaj002,p_inaj003,p_sfaadocno,p_inaj005,p_inaj008,p_inaj010,p_inaj011,p_inaj012,p_ooeg004,p_sfaa068)
   DEFINE p_xcjeld      LIKE xcje_t.xcjeld
   DEFINE p_xcjedocno   LIKE xcje_t.xcjedocno
   DEFINE p_inaj001     LIKE inaj_t.inaj001
   DEFINE p_inaj002     LIKE inaj_t.inaj002
   DEFINE p_inaj003     LIKE inaj_t.inaj003
   DEFINE p_sfaadocno   LIKE sfaa_t.sfaadocno
   DEFINE p_inaj005     LIKE inaj_t.inaj005  #入库料号
   #DEFINE p_inaj006     LIKE inaj_t.inaj006  #特性
   #DEFINE p_inaj007     LIKE inaj_t.inaj007  #库存管理特征
   DEFINE p_inaj008     LIKE inaj_t.inaj008  #库位编号
   #DEFINE p_inaj009     LIKE inaj_t.inaj009  #储位编号
   DEFINE p_inaj010     LIKE inaj_t.inaj010  #批号
   DEFINE p_inaj011     LIKE inaj_t.inaj011  #交易数量
   DEFINE p_inaj012     LIKE inaj_t.inaj012  #交易单位
   DEFINE p_ooeg004     LIKE ooeg_t.ooeg004  #生产部门归属成本中心
   DEFINE p_sfaa068     LIKE sfaa_t.sfaa068  #工单的成本中心
   #DEFINE p_sfaa012     LIKE sfaa_t.sfaa012  #生产数量
   #DEFINE p_sfaa013     LIKE sfaa_t.sfaa013  #生产单位
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
#   DEFINE l_glad        RECORD LIKE glad_t.*  #科目相关设置   #161124-00048#19 mark
#   DEFINE l_xcjf        RECORD LIKE xcjf_t.*  #161124-00048#19
   DEFINE l_imaa006     LIKE imaa_t.imaa006   #基础单位 
#   DEFINE l_xcjb        RECORD LIKE xcjb_t.* #161124-00048#19 mark
   DEFINE l_rate        LIKE xcjf_t.xcjf024   #计价单位与内部定价单位的换算率
   DEFINE l_cnt         LIKE type_t.num5
   #161124-00048#19 add(s)
   DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企业编号
       gladownid LIKE glad_t.gladownid, #资料所有者
       gladowndp LIKE glad_t.gladowndp, #资料所有部门
       gladcrtid LIKE glad_t.gladcrtid, #资料录入者
       gladcrtdp LIKE glad_t.gladcrtdp, #资料录入部门
       gladcrtdt LIKE glad_t.gladcrtdt, #资料创建日
       gladmodid LIKE glad_t.gladmodid, #资料更改者
       gladmoddt LIKE glad_t.gladmoddt, #最近更改日
       gladstus LIKE glad_t.gladstus, #状态码
       gladld LIKE glad_t.gladld, #账套
       glad001 LIKE glad_t.glad001, #会计科目编号
       glad002 LIKE glad_t.glad002, #是否按余额类型生成分录
       glad003 LIKE glad_t.glad003, #启用凭证项次细项立冲
       glad004 LIKE glad_t.glad004, #凭证项次异动别
       glad005 LIKE glad_t.glad005, #是否启用数量金额式
       glad006 LIKE glad_t.glad006, #借方现金变动码
       glad007 LIKE glad_t.glad007, #启用部门管理
       glad008 LIKE glad_t.glad008, #启用利润成本管理
       glad009 LIKE glad_t.glad009, #启用区域管理
       glad010 LIKE glad_t.glad010, #启用收付款客商管理
       glad011 LIKE glad_t.glad011, #启用客群管理
       glad012 LIKE glad_t.glad012, #启用产品类别管理
       glad013 LIKE glad_t.glad013, #启用人员管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #启用项目管理
       glad016 LIKE glad_t.glad016, #启用WBS管理
       glad017 LIKE glad_t.glad017, #启用自由核算项一
       glad0171 LIKE glad_t.glad0171, #自由核算项一类型编号
       glad0172 LIKE glad_t.glad0172, #自由核算项一控制方式
       glad018 LIKE glad_t.glad018, #启用自由核算项二
       glad0181 LIKE glad_t.glad0181, #自由核算项二类型编号
       glad0182 LIKE glad_t.glad0182, #自由核算项二控制方式
       glad019 LIKE glad_t.glad019, #启用自由核算项三
       glad0191 LIKE glad_t.glad0191, #自由核算项三类型编号
       glad0192 LIKE glad_t.glad0192, #自由核算项三控制方式
       glad020 LIKE glad_t.glad020, #启用自由核算项四
       glad0201 LIKE glad_t.glad0201, #自由核算项四类型编号
       glad0202 LIKE glad_t.glad0202, #自由核算项四控制方式
       glad021 LIKE glad_t.glad021, #启用自由核算项五
       glad0211 LIKE glad_t.glad0211, #自由核算项五类型编号
       glad0212 LIKE glad_t.glad0212, #自由核算项五控制方式
       glad022 LIKE glad_t.glad022, #启用自由核算项六
       glad0221 LIKE glad_t.glad0221, #自由核算项六类型编号
       glad0222 LIKE glad_t.glad0222, #自由核算项六控制方式
       glad023 LIKE glad_t.glad023, #启用自由核算项七
       glad0231 LIKE glad_t.glad0231, #自由核算项七类型编号
       glad0232 LIKE glad_t.glad0232, #自由核算项七控制方式
       glad024 LIKE glad_t.glad024, #启用自由核算项八
       glad0241 LIKE glad_t.glad0241, #自由核算项八类型编号
       glad0242 LIKE glad_t.glad0242, #自由核算项八控制方式
       glad025 LIKE glad_t.glad025, #启用自由核算项九
       glad0251 LIKE glad_t.glad0251, #自由核算项九类型编号
       glad0252 LIKE glad_t.glad0252, #自由核算项九控制方式
       glad026 LIKE glad_t.glad026, #启用自由核算项十
       glad0261 LIKE glad_t.glad0261, #自由核算项十类型编号
       glad0262 LIKE glad_t.glad0262, #自由核算项十控制方式
       glad027 LIKE glad_t.glad027, #启用账款客商管理
       glad030 LIKE glad_t.glad030, #是否进行预算管控
       glad031 LIKE glad_t.glad031, #启用经营方式管理
       glad032 LIKE glad_t.glad032, #启用渠道管理
       glad033 LIKE glad_t.glad033, #启用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多币种管理
       glad035 LIKE glad_t.glad035, #是否是子系统科目
       glad036 LIKE glad_t.glad036  #贷方现金变动码
END RECORD
DEFINE l_xcjf RECORD  #內部收入成本數據明細檔
       xcjfent LIKE xcjf_t.xcjfent, #企业编号
       xcjfsite LIKE xcjf_t.xcjfsite, #账务中心
       xcjfld LIKE xcjf_t.xcjfld, #账套
       xcjfdocno LIKE xcjf_t.xcjfdocno, #单据编号
       xcjfseq LIKE xcjf_t.xcjfseq, #项次
       xcjf001 LIKE xcjf_t.xcjf001, #业务单据
       xcjf002 LIKE xcjf_t.xcjf002, #项次
       xcjf003 LIKE xcjf_t.xcjf003, #项次
       xcjf010 LIKE xcjf_t.xcjf010, #类型(收入/成本)
       xcjf011 LIKE xcjf_t.xcjf011, #来源(存货/在制)
       xcjf012 LIKE xcjf_t.xcjf012, #计算类别(损益/资产)
       xcjf013 LIKE xcjf_t.xcjf013, #实体利润中心（组织)
       xcjf014 LIKE xcjf_t.xcjf014, #虚拟利润中心(组织)
       xcjf015 LIKE xcjf_t.xcjf015, #交易组织(site)
       xcjf016 LIKE xcjf_t.xcjf016, #料号
       xcjf017 LIKE xcjf_t.xcjf017, #仓库
       xcjf018 LIKE xcjf_t.xcjf018, #批号
       xcjf019 LIKE xcjf_t.xcjf019, #异动类型
       xcjf020 LIKE xcjf_t.xcjf020, #基础单位
       xcjf021 LIKE xcjf_t.xcjf021, #出入库码
       xcjf022 LIKE xcjf_t.xcjf022, #异动数量
       xcjf023 LIKE xcjf_t.xcjf023, #计价单位
       xcjf024 LIKE xcjf_t.xcjf024, #换算率
       xcjf028 LIKE xcjf_t.xcjf028, #收入/成本/存货科目
       xcjf029 LIKE xcjf_t.xcjf029, #对方科目
       xcjf030 LIKE xcjf_t.xcjf030, #摘要
       xcjf031 LIKE xcjf_t.xcjf031, #部门
       xcjf032 LIKE xcjf_t.xcjf032, #成本中心
       xcjf033 LIKE xcjf_t.xcjf033, #区域
       xcjf034 LIKE xcjf_t.xcjf034, #交易对象
       xcjf035 LIKE xcjf_t.xcjf035, #账款对象
       xcjf036 LIKE xcjf_t.xcjf036, #客群
       xcjf037 LIKE xcjf_t.xcjf037, #品类
       xcjf038 LIKE xcjf_t.xcjf038, #经营类别
       xcjf039 LIKE xcjf_t.xcjf039, #渠道
       xcjf040 LIKE xcjf_t.xcjf040, #品牌
       xcjf041 LIKE xcjf_t.xcjf041, #人员
       xcjf042 LIKE xcjf_t.xcjf042, #项目号
       xcjf043 LIKE xcjf_t.xcjf043, #WBS
       xcjf044 LIKE xcjf_t.xcjf044, #自由核算项1
       xcjf045 LIKE xcjf_t.xcjf045, #自由核算项2
       xcjf046 LIKE xcjf_t.xcjf046, #自由核算项3
       xcjf047 LIKE xcjf_t.xcjf047, #自由核算项4
       xcjf048 LIKE xcjf_t.xcjf048, #自由核算项5
       xcjf049 LIKE xcjf_t.xcjf049, #自由核算项6
       xcjf050 LIKE xcjf_t.xcjf050, #自由核算项7
       xcjf051 LIKE xcjf_t.xcjf051, #自由核算项8
       xcjf052 LIKE xcjf_t.xcjf052, #自由核算项9
       xcjf053 LIKE xcjf_t.xcjf053, #自由核算项10
       xcjf101 LIKE xcjf_t.xcjf101, #交易币种
       xcjf102 LIKE xcjf_t.xcjf102, #交易单价
       xcjf110 LIKE xcjf_t.xcjf110, #交易金额
       xcjf200 LIKE xcjf_t.xcjf200, #换算汇率
       xcjf201 LIKE xcjf_t.xcjf201, #本位币一金额
       xcjf210 LIKE xcjf_t.xcjf210, #换算汇率二
       xcjf211 LIKE xcjf_t.xcjf211, #本位币二金额
       xcjf220 LIKE xcjf_t.xcjf220, #换算汇率三
       xcjf221 LIKE xcjf_t.xcjf221, #本位币三金额
       xcjfud001 LIKE xcjf_t.xcjfud001, #自定义字段(文本)001
       xcjfud002 LIKE xcjf_t.xcjfud002, #自定义字段(文本)002
       xcjfud003 LIKE xcjf_t.xcjfud003, #自定义字段(文本)003
       xcjfud004 LIKE xcjf_t.xcjfud004, #自定义字段(文本)004
       xcjfud005 LIKE xcjf_t.xcjfud005, #自定义字段(文本)005
       xcjfud006 LIKE xcjf_t.xcjfud006, #自定义字段(文本)006
       xcjfud007 LIKE xcjf_t.xcjfud007, #自定义字段(文本)007
       xcjfud008 LIKE xcjf_t.xcjfud008, #自定义字段(文本)008
       xcjfud009 LIKE xcjf_t.xcjfud009, #自定义字段(文本)009
       xcjfud010 LIKE xcjf_t.xcjfud010, #自定义字段(文本)010
       xcjfud011 LIKE xcjf_t.xcjfud011, #自定义字段(数字)011
       xcjfud012 LIKE xcjf_t.xcjfud012, #自定义字段(数字)012
       xcjfud013 LIKE xcjf_t.xcjfud013, #自定义字段(数字)013
       xcjfud014 LIKE xcjf_t.xcjfud014, #自定义字段(数字)014
       xcjfud015 LIKE xcjf_t.xcjfud015, #自定义字段(数字)015
       xcjfud016 LIKE xcjf_t.xcjfud016, #自定义字段(数字)016
       xcjfud017 LIKE xcjf_t.xcjfud017, #自定义字段(数字)017
       xcjfud018 LIKE xcjf_t.xcjfud018, #自定义字段(数字)018
       xcjfud019 LIKE xcjf_t.xcjfud019, #自定义字段(数字)019
       xcjfud020 LIKE xcjf_t.xcjfud020, #自定义字段(数字)020
       xcjfud021 LIKE xcjf_t.xcjfud021, #自定义字段(日期时间)021
       xcjfud022 LIKE xcjf_t.xcjfud022, #自定义字段(日期时间)022
       xcjfud023 LIKE xcjf_t.xcjfud023, #自定义字段(日期时间)023
       xcjfud024 LIKE xcjf_t.xcjfud024, #自定义字段(日期时间)024
       xcjfud025 LIKE xcjf_t.xcjfud025, #自定义字段(日期时间)025
       xcjfud026 LIKE xcjf_t.xcjfud026, #自定义字段(日期时间)026
       xcjfud027 LIKE xcjf_t.xcjfud027, #自定义字段(日期时间)027
       xcjfud028 LIKE xcjf_t.xcjfud028, #自定义字段(日期时间)028
       xcjfud029 LIKE xcjf_t.xcjfud029, #自定义字段(日期时间)029
       xcjfud030 LIKE xcjf_t.xcjfud030  #自定义字段(日期时间)030
END RECORD
DEFINE l_xcjb RECORD  #內部交易定價主檔
       xcjbent LIKE xcjb_t.xcjbent, #企业编号
       xcjb001 LIKE xcjb_t.xcjb001, #计算类型(版本)
       xcjb002 LIKE xcjb_t.xcjb002, #年度
       xcjb003 LIKE xcjb_t.xcjb003, #期别
       xcjb004 LIKE xcjb_t.xcjb004, #料号
       xcjb005 LIKE xcjb_t.xcjb005, #销售组织
       xcjb006 LIKE xcjb_t.xcjb006, #采购组织
       xcjb007 LIKE xcjb_t.xcjb007, #计价单位
       xcjb008 LIKE xcjb_t.xcjb008, #币种
       xcjb009 LIKE xcjb_t.xcjb009, #内部定价
       xcjbownid LIKE xcjb_t.xcjbownid, #资料所有者
       xcjbowndp LIKE xcjb_t.xcjbowndp, #资料所有部门
       xcjbcrtid LIKE xcjb_t.xcjbcrtid, #资料录入者
       xcjbcrtdp LIKE xcjb_t.xcjbcrtdp, #资料录入部门
       xcjbcrtdt LIKE xcjb_t.xcjbcrtdt, #资料创建日
       xcjbmodid LIKE xcjb_t.xcjbmodid, #资料更改者
       xcjbmoddt LIKE xcjb_t.xcjbmoddt, #最近更改日
       xcjbstus LIKE xcjb_t.xcjbstus  #状态码
END RECORD
   #161124-00048#19 add(e)
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #已经产生过的不用再产生
   SELECT COUNT(*) INTO l_cnt FROM xcjf_t
    WHERE xcjfent   = g_enterprise
      AND xcjfld    = p_xcjeld
      AND xcjfdocno = p_xcjedocno
      AND xcjf001   = p_inaj001   #業務單據：入库单号
      AND xcjf002   = p_inaj002   #项次
      AND xcjf003   = p_inaj003   #项序
      AND xcjf010   = '5'   #内部代工生产类型中的一种
   IF l_cnt > 0 THEN
      RETURN r_success
   END IF
   
#   SELECT * INTO g_xcje.* FROM xcje_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
    SELECT xcjeent,xcjesite,xcjeld,xcjedocno,xcjedocdt,xcje001,xcje002,
           xcje003,xcje004,xcje005,xcje006,xcje007,xcjeownid,xcjeowndp,
           xcjecrtid,xcjecrtdp,xcjecrtdt,xcjemodid,xcjemoddt,xcjecnfid,
           xcjecnfdt,xcjepstid,xcjepstdt,xcjestus 
      INTO g_xcje.* FROM xcje_t
   #161124-00048#19 add(e)
    WHERE xcjeent  = g_enterprise
      AND xcjeld   = p_xcjeld
      AND xcjedocno= p_xcjedocno
   
#   SELECT * INTO g_glaa.* FROM glaa_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,
          glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,
          glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,
          glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
          glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,
          glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
          glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,
          glaa124,glaa028 
     INTO g_glaa.* FROM glaa_t
   #161124-00048#19 add(e)
    WHERE glaaent = g_enterprise 
      AND glaald  = g_xcje.xcjeld
   
   #取当期的起始及截止日期
   CALL s_fin_date_get_period_range(g_glaa.glaa003,g_xcje.xcje002,g_xcje.xcje003)
        RETURNING g_bdate,g_edate
   
#   SELECT * INTO g_xcja.* FROM xcja_t  #内部交易计算基础设置  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjaent,xcja001,xcja002,xcja003,xcja004,xcja005,xcja006,xcja007,
          xcja008,xcja009,xcja010,xcjaownid,xcjaowndp,xcjacrtid,xcjacrtdp,
          xcjacrtdt,xcjamodid,xcjamoddt,xcjastus,xcja011 
     INTO g_xcja.* FROM xcja_t  #内部交易计算基础设置
   #161124-00048#19 add(e)
    WHERE xcjaent = g_enterprise
      AND xcja001 = g_xcje.xcje006  #计算类型(版本)
   
   SELECT imaa006 INTO l_imaa006 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_inaj005
   

   #--工单生产部门的内部加工收入
   INITIALIZE l_xcjf.* TO NULL   #清空
   LET l_xcjf.xcjfent   = g_enterprise     #企業編號
   LET l_xcjf.xcjfsite  = g_xcje.xcjesite  #賬務中心
   LET l_xcjf.xcjfld    = g_xcje.xcjeld    #帳套
   LET l_xcjf.xcjfdocno = g_xcje.xcjedocno #單據編號
   #LET l_xcjf.xcjfseq             #項次
   SELECT MAX(xcjfseq)+1 INTO l_xcjf.xcjfseq FROM xcjf_t
    WHERE xcjfent  = l_xcjf.xcjfent
      AND xcjfld   = l_xcjf.xcjfld
      AND xcjfdocno=l_xcjf.xcjfdocno
   IF cl_null(l_xcjf.xcjfseq) OR l_xcjf.xcjfseq=0 THEN
      LET l_xcjf.xcjfseq = 1
   END IF
   LET l_xcjf.xcjf001   = p_inaj001   #業務單據：入库单号
   LET l_xcjf.xcjf002   = p_inaj002    #項次
   LET l_xcjf.xcjf003   = p_inaj003    #項次
   #库存结存 --仓库所属利润中心的内部成本 金额为正向
   LET l_xcjf.xcjf010   = '5'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本/5.內部加工收入/6.內部加工成本)
   LET l_xcjf.xcjf013   = p_ooeg004         #實體利潤中心（組織)
   LET l_xcjf.xcjf031   = ''    #申请部门
   LET l_xcjf.xcjf041   = ''    #申请人员
   
   #目前来源都是基于存货，计算类别都是损益;在制和资产等后面再思考如何做
   LET l_xcjf.xcjf011   = '1'              #來源(存貨/在制)
   LET l_xcjf.xcjf012   = '1'              #計算類別(損益/資產)
   LET l_xcjf.xcjf014   = g_xcja.xcja007   #虛擬利潤中心(組織)
   LET l_xcjf.xcjf015   = ''               #交易組織(site)
   LET l_xcjf.xcjf016   = p_inaj005        #料號
   LET l_xcjf.xcjf017   = p_inaj008        #倉庫
   LET l_xcjf.xcjf018   = p_inaj010   #批號
   LET l_xcjf.xcjf019   = ''   #異動類型
   LET l_xcjf.xcjf020   = l_imaa006   #基礎單位
   LET l_xcjf.xcjf021   = 0   #出入庫碼
   
   #LET l_xcjf.xcjf028   =    #收入成本存貨科目
   #mod--161103-00045#3 By shiun--(S)
   IF l_xcjf.xcjf010 MATCHES '[125]' THEN  #收入
#      CALL s_get_item_acc(g_xcje.xcjeld,'4',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'27',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'')  #170105-00002#1 mod 26->27
         RETURNING l_success,l_xcjf.xcjf028  #收入
   END IF
   IF l_xcjf.xcjf010 MATCHES '[346]' THEN  #成本
#      CALL s_get_item_acc(g_xcje.xcjeld,'5',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'28',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'')  #170105-00002#1 mod 27->28
         RETURNING l_success,l_xcjf.xcjf028 #成本
   END IF
   #mod--161103-00045#3 By shiun--(E)
   LET l_xcjf.xcjf029   = l_xcjf.xcjf028   #對方科目
   LET l_xcjf.xcjf030   = ''               #摘要
   
   LET l_xcjf.xcjf032   = l_xcjf.xcjf013        #成本中心=實體利潤中心（組織)
   
   #根据科目预设资料
   #获取科目相关设置预设资料
#   SELECT * INTO l_glad.* FROM glad_t #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,
          gladstus,gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,
          glad009,glad010,glad011,glad012,glad013,glad014,glad015,glad016,glad017,glad0171,
          glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,glad020,glad0201,
          glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,
          glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,
          glad0262,glad027,glad030,glad031,glad032,glad033,glad034,glad035,glad036 
     INTO l_glad.* FROM glad_t
   #161124-00048#19 add(e)
    WHERE gladent = g_enterprise
      AND gladld  = g_xcje.xcjeld
      AND glad001 = l_xcjf.xcjf028  #科目
   IF l_glad.glad009 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'4') RETURNING l_xcjf.xcjf033  #區域
   END IF
   IF l_glad.glad010 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'5') RETURNING l_xcjf.xcjf034  #交易對象
   END IF
   IF l_glad.glad027 = 'Y'THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'6') RETURNING l_xcjf.xcjf035  #帳款對象
   END IF
   IF l_glad.glad011 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'7') RETURNING l_xcjf.xcjf036  #客群
   END IF
   IF l_glad.glad012 ='Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'8') RETURNING l_xcjf.xcjf037  #品類
   END IF
   IF l_glad.glad031 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'9') RETURNING l_xcjf.xcjf038  #經營類別
   END IF
   IF l_glad.glad032 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'10') RETURNING l_xcjf.xcjf039  #渠道
   END IF
   IF l_glad.glad033 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'11') RETURNING l_xcjf.xcjf040  #品牌
   END IF
   IF l_glad.glad015 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'13') RETURNING l_xcjf.xcjf042  #項目號
   END IF
   IF l_glad.glad016 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'14') RETURNING l_xcjf.xcjf043  #WBS
   END IF
   IF l_glad.glad017 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'15') RETURNING l_xcjf.xcjf044  #自由核算項1
   END IF
   IF l_glad.glad018 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'16') RETURNING l_xcjf.xcjf045  #自由核算項2
   END IF
   IF l_glad.glad019 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'17') RETURNING l_xcjf.xcjf046  #自由核算項3
   END IF
   IF l_glad.glad020 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'18') RETURNING l_xcjf.xcjf047  #自由核算項4
   END IF
   IF l_glad.glad021 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'19') RETURNING l_xcjf.xcjf048  #自由核算項5
   END IF
   IF l_glad.glad022 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'20') RETURNING l_xcjf.xcjf049  #自由核算項6
   END IF
   IF l_glad.glad023 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'21') RETURNING l_xcjf.xcjf050  #自由核算項7
   END IF
   IF l_glad.glad024 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'22') RETURNING l_xcjf.xcjf051  #自由核算項8
   END IF
   IF l_glad.glad025 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'23') RETURNING l_xcjf.xcjf052  #自由核算項9
   END IF
   IF l_glad.glad026 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'24') RETURNING l_xcjf.xcjf053  #自由核算項10
   END IF
   
   LET l_xcjf.xcjf022 = p_inaj011       #異動數量
   LET l_xcjf.xcjf023 = p_inaj012       #計價單位
   #換算率xcjf024:计价单位与成本单位的换算率
   IF l_xcjf.xcjf020 = l_xcjf.xcjf023 THEN    #计价单位与成本单位的换算率
      LET l_xcjf.xcjf024 = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(l_xcjf.xcjf016,l_xcjf.xcjf023,l_xcjf.xcjf020,1)
           RETURNING l_success,l_xcjf.xcjf024
      IF cl_null(l_xcjf.xcjf024) OR l_xcjf.xcjf024 = 0 THEN
         LET l_xcjf.xcjf024 = 1          #換算率
      END IF
   END IF
   
   #LET l_xcjf.xcjf101 =    #交易幣別
   #LET l_xcjf.xcjf102 =    #交易單價(交易单位的)
   #LET l_xcjf.xcjf110 =    #交易金額
   #LET l_xcjf.xcjf200 =    #換算匯率
   #LET l_xcjf.xcjf210 =    #換算匯率二
   #LET l_xcjf.xcjf220 =    #換算匯率三
   #LET l_xcjf.xcjf201 =    #本位幣一金額
   #LET l_xcjf.xcjf211 =    #本位幣二金額
   #LET l_xcjf.xcjf221 =    #本位幣三金額
   #取axci951的xcjb009
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
    WHERE xcjbent = g_enterprise
      AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
      AND xcjb002 = g_xcje.xcje002  #年
      AND xcjb003 = g_xcje.xcje003  #期
      AND xcjb004 = l_xcjf.xcjf016  #料号
      AND xcjb005 = p_ooeg004  #销售组织
      AND xcjb006 = p_sfaa068  #采购组织
   IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
       WHERE xcjbent = g_enterprise
         AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
         AND xcjb002 = g_xcje.xcje002  #年
         AND xcjb003 = g_xcje.xcje003  #期
         AND xcjb004 = l_xcjf.xcjf016  #料号
         AND xcjb005 = p_ooeg004  #销售组织
         AND xcjb006 = 'ALL'      #采购组织
      IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
          WHERE xcjbent = g_enterprise
            AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
            AND xcjb002 = g_xcje.xcje002  #年
            AND xcjb003 = g_xcje.xcje003  #期
            AND xcjb004 = l_xcjf.xcjf016  #料号
            AND xcjb005='ALL'  #销售组织
            AND xcjb006='ALL'  #采购组织
      END IF
   END IF
   
   IF cl_null(l_xcjb.xcjb007) OR cl_null(l_xcjb.xcjb008) OR l_xcjb.xcjb009=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.replace[1] = p_ooeg004
      LET g_errparam.replace[2] = p_sfaa068
      LET g_errparam.code = 'axc-00784'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
   #计算交易单价xcjf102
   IF l_xcjf.xcjf023 = l_xcjb.xcjb007 THEN    #计价单位与内部定价单位的换算率
      LET l_rate = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(l_xcjf.xcjf016,l_xcjb.xcjb007,l_xcjf.xcjf023,1)
           RETURNING l_success,l_rate
      IF cl_null(l_rate) OR l_rate = 0 THEN
         LET l_rate = 1          #換算率
      END IF
   END IF
   LET l_xcjf.xcjf102 = l_xcjb.xcjb009 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
   
   LET l_xcjf.xcjf101 = l_xcjb.xcjb008        #交易幣別
   LET l_xcjf.xcjf110 = l_xcjf.xcjf102 * l_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
      
   #汇率一
   CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
         RETURNING l_xcjf.xcjf200
   IF cl_null(l_xcjf.xcjf200) OR l_xcjf.xcjf200=0 THEN LET l_xcjf.xcjf200 = 1 END IF
   LET l_xcjf.xcjf201 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
   #汇率二
   IF g_glaa.glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
         RETURNING l_xcjf.xcjf210
   ELSE
      LET l_xcjf.xcjf210 = 0
   END IF
   LET l_xcjf.xcjf211 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
   #汇率三
   IF g_glaa.glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
         RETURNING l_xcjf.xcjf220
   ELSE
      LET l_xcjf.xcjf220 = 0
   END IF
   LET l_xcjf.xcjf221 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三
           

   LET l_xcjf.xcjfud021 = ''   #自定義欄位(日期時間)021
   LET l_xcjf.xcjfud022 = ''   #自定義欄位(日期時間)022
   LET l_xcjf.xcjfud023 = ''   #自定義欄位(日期時間)023
   LET l_xcjf.xcjfud024 = ''   #自定義欄位(日期時間)024
   LET l_xcjf.xcjfud025 = ''   #自定義欄位(日期時間)025
   LET l_xcjf.xcjfud026 = ''   #自定義欄位(日期時間)026
   LET l_xcjf.xcjfud027 = ''   #自定義欄位(日期時間)027
   LET l_xcjf.xcjfud028 = ''   #自定義欄位(日期時間)028
   LET l_xcjf.xcjfud029 = ''   #自定義欄位(日期時間)029
   LET l_xcjf.xcjfud030 = ''   #自定義欄位(日期時間)030
   
#   INSERT INTO xcjf_t VALUES l_xcjf.*  #161124-00048#19 mark
   #161124-00048#19 add(s)
   INSERT INTO xcjf_t(xcjfent,xcjfsite,xcjfld,xcjfdocno,xcjfseq,xcjf001,xcjf002,xcjf003,
                      xcjf010,xcjf011,xcjf012,xcjf013,xcjf014,xcjf015,xcjf016,xcjf017,xcjf018,
                      xcjf019,xcjf020,xcjf021,xcjf022,xcjf023,xcjf024,xcjf028,xcjf029,xcjf030,
                      xcjf031,xcjf032,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf038,xcjf039,
                      xcjf040,xcjf041,xcjf042,xcjf043,xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,
                      xcjf049,xcjf050,xcjf051,xcjf052,xcjf053,xcjf101,xcjf102,xcjf110,xcjf200,
                      xcjf201,xcjf210,xcjf211,xcjf220,xcjf221,
                      xcjfud001,xcjfud002,xcjfud003,xcjfud004,xcjfud005,xcjfud006,xcjfud007,xcjfud008,
                      xcjfud009,xcjfud010,xcjfud011,xcjfud012,xcjfud013,xcjfud014,xcjfud015,xcjfud016,
                      xcjfud017,xcjfud018,xcjfud019,xcjfud020,xcjfud021,xcjfud022,xcjfud023,xcjfud024,
                      xcjfud025,xcjfud026,xcjfud027,xcjfud028,xcjfud029,xcjfud030) 
               VALUES(l_xcjf.xcjfent,l_xcjf.xcjfsite,l_xcjf.xcjfld,l_xcjf.xcjfdocno,l_xcjf.xcjfseq,l_xcjf.xcjf001,l_xcjf.xcjf002,l_xcjf.xcjf003,
                      l_xcjf.xcjf010,l_xcjf.xcjf011,l_xcjf.xcjf012,l_xcjf.xcjf013,l_xcjf.xcjf014,l_xcjf.xcjf015,l_xcjf.xcjf016,l_xcjf.xcjf017,l_xcjf.xcjf018,
                      l_xcjf.xcjf019,l_xcjf.xcjf020,l_xcjf.xcjf021,l_xcjf.xcjf022,l_xcjf.xcjf023,l_xcjf.xcjf024,l_xcjf.xcjf028,l_xcjf.xcjf029,l_xcjf.xcjf030,
                      l_xcjf.xcjf031,l_xcjf.xcjf032,l_xcjf.xcjf033,l_xcjf.xcjf034,l_xcjf.xcjf035,l_xcjf.xcjf036,l_xcjf.xcjf037,l_xcjf.xcjf038,l_xcjf.xcjf039,
                      l_xcjf.xcjf040,l_xcjf.xcjf041,l_xcjf.xcjf042,l_xcjf.xcjf043,l_xcjf.xcjf044,l_xcjf.xcjf045,l_xcjf.xcjf046,l_xcjf.xcjf047,l_xcjf.xcjf048,
                      l_xcjf.xcjf049,l_xcjf.xcjf050,l_xcjf.xcjf051,l_xcjf.xcjf052,l_xcjf.xcjf053,l_xcjf.xcjf101,l_xcjf.xcjf102,l_xcjf.xcjf110,l_xcjf.xcjf200,
                      l_xcjf.xcjf201,l_xcjf.xcjf210,l_xcjf.xcjf211,l_xcjf.xcjf220,l_xcjf.xcjf221,
                      l_xcjf.xcjfud001,l_xcjf.xcjfud002,l_xcjf.xcjfud003,l_xcjf.xcjfud004,l_xcjf.xcjfud005,l_xcjf.xcjfud006,l_xcjf.xcjfud007,l_xcjf.xcjfud008,
                      l_xcjf.xcjfud009,l_xcjf.xcjfud010,l_xcjf.xcjfud011,l_xcjf.xcjfud012,l_xcjf.xcjfud013,l_xcjf.xcjfud014,l_xcjf.xcjfud015,l_xcjf.xcjfud016,
                      l_xcjf.xcjfud017,l_xcjf.xcjfud018,l_xcjf.xcjfud019,l_xcjf.xcjfud020,l_xcjf.xcjfud021,l_xcjf.xcjfud022,l_xcjf.xcjfud023,l_xcjf.xcjfud024,
                      l_xcjf.xcjfud025,l_xcjf.xcjfud026,l_xcjf.xcjfud027,l_xcjf.xcjfud028,l_xcjf.xcjfud029,l_xcjf.xcjfud030) 
   #161124-00048#19 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcjf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #--工单所属site的内部加工成本
   #LET l_xcjf.xcjfseq             #項次
   SELECT MAX(xcjfseq)+1 INTO l_xcjf.xcjfseq FROM xcjf_t
    WHERE xcjfent  = l_xcjf.xcjfent
      AND xcjfld   = l_xcjf.xcjfld
      AND xcjfdocno=l_xcjf.xcjfdocno
   IF cl_null(l_xcjf.xcjfseq) OR l_xcjf.xcjfseq=0 THEN
      LET l_xcjf.xcjfseq = 1
   END IF
   LET l_xcjf.xcjf010   = '6'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本/5.內部加工收入/6.內部加工成本)
   LET l_xcjf.xcjf013   = p_sfaa068         #實體利潤中心（組織)
   
   #LET l_xcjf.xcjf101 =    #交易幣別
   #LET l_xcjf.xcjf102 =    #交易單價(交易单位的)
   #LET l_xcjf.xcjf110 =    #交易金額
   #LET l_xcjf.xcjf200 =    #換算匯率
   #LET l_xcjf.xcjf210 =    #換算匯率二
   #LET l_xcjf.xcjf220 =    #換算匯率三
   #LET l_xcjf.xcjf201 =    #本位幣一金額
   #LET l_xcjf.xcjf211 =    #本位幣二金額
   #LET l_xcjf.xcjf221 =    #本位幣三金額
   #取axci951的xcjb009
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
    WHERE xcjbent = g_enterprise
      AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
      AND xcjb002 = g_xcje.xcje002  #年
      AND xcjb003 = g_xcje.xcje003  #期
      AND xcjb004 = l_xcjf.xcjf016  #料号
      AND xcjb005 = p_ooeg004  #销售组织
      AND xcjb006 = p_sfaa068  #采购组织
   IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
       WHERE xcjbent = g_enterprise
         AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
         AND xcjb002 = g_xcje.xcje002  #年
         AND xcjb003 = g_xcje.xcje003  #期
         AND xcjb004 = l_xcjf.xcjf016  #料号
         AND xcjb005 = 'ALL'      #销售组织
         AND xcjb006 = p_sfaa068  #采购组织
      IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
          WHERE xcjbent = g_enterprise
            AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
            AND xcjb002 = g_xcje.xcje002  #年
            AND xcjb003 = g_xcje.xcje003  #期
            AND xcjb004 = l_xcjf.xcjf016  #料号
            AND xcjb005='ALL'  #销售组织
            AND xcjb006='ALL'  #采购组织
      END IF
   END IF
   IF cl_null(l_xcjb.xcjb007) OR cl_null(l_xcjb.xcjb008) OR l_xcjb.xcjb009=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.replace[1] = p_ooeg004
      LET g_errparam.replace[2] = p_sfaa068
      LET g_errparam.code = 'axc-00784'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
   #计算交易单价xcjf102
   IF l_xcjf.xcjf023 = l_xcjb.xcjb007 THEN    #计价单位与内部定价单位的换算率
      LET l_rate = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(l_xcjf.xcjf016,l_xcjb.xcjb007,l_xcjf.xcjf023,1)
           RETURNING l_success,l_rate
      IF cl_null(l_rate) OR l_rate = 0 THEN
         LET l_rate = 1          #換算率
      END IF
   END IF
   LET l_xcjf.xcjf102 = l_xcjb.xcjb009 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
   
   LET l_xcjf.xcjf101 = l_xcjb.xcjb008        #交易幣別
   LET l_xcjf.xcjf110 = l_xcjf.xcjf102 * l_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
      
   #汇率一
   CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
         RETURNING l_xcjf.xcjf200
   IF cl_null(l_xcjf.xcjf200) OR l_xcjf.xcjf200=0 THEN LET l_xcjf.xcjf200 = 1 END IF
   LET l_xcjf.xcjf201 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
   #汇率二
   IF g_glaa.glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
         RETURNING l_xcjf.xcjf210
   ELSE
      LET l_xcjf.xcjf210 = 0
   END IF
   LET l_xcjf.xcjf211 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
   #汇率三
   IF g_glaa.glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
         RETURNING l_xcjf.xcjf220
   ELSE
      LET l_xcjf.xcjf220 = 0
   END IF
   LET l_xcjf.xcjf221 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三

#   INSERT INTO xcjf_t VALUES l_xcjf.*  #161124-00048#19 mark
   #161124-00048#19 add(s)
   INSERT INTO xcjf_t(xcjfent,xcjfsite,xcjfld,xcjfdocno,xcjfseq,xcjf001,xcjf002,xcjf003,
                      xcjf010,xcjf011,xcjf012,xcjf013,xcjf014,xcjf015,xcjf016,xcjf017,xcjf018,
                      xcjf019,xcjf020,xcjf021,xcjf022,xcjf023,xcjf024,xcjf028,xcjf029,xcjf030,
                      xcjf031,xcjf032,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf038,xcjf039,
                      xcjf040,xcjf041,xcjf042,xcjf043,xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,
                      xcjf049,xcjf050,xcjf051,xcjf052,xcjf053,xcjf101,xcjf102,xcjf110,xcjf200,
                      xcjf201,xcjf210,xcjf211,xcjf220,xcjf221,
                      xcjfud001,xcjfud002,xcjfud003,xcjfud004,xcjfud005,xcjfud006,xcjfud007,xcjfud008,
                      xcjfud009,xcjfud010,xcjfud011,xcjfud012,xcjfud013,xcjfud014,xcjfud015,xcjfud016,
                      xcjfud017,xcjfud018,xcjfud019,xcjfud020,xcjfud021,xcjfud022,xcjfud023,xcjfud024,
                      xcjfud025,xcjfud026,xcjfud027,xcjfud028,xcjfud029,xcjfud030) 
               VALUES(l_xcjf.xcjfent,l_xcjf.xcjfsite,l_xcjf.xcjfld,l_xcjf.xcjfdocno,l_xcjf.xcjfseq,l_xcjf.xcjf001,l_xcjf.xcjf002,l_xcjf.xcjf003,
                      l_xcjf.xcjf010,l_xcjf.xcjf011,l_xcjf.xcjf012,l_xcjf.xcjf013,l_xcjf.xcjf014,l_xcjf.xcjf015,l_xcjf.xcjf016,l_xcjf.xcjf017,l_xcjf.xcjf018,
                      l_xcjf.xcjf019,l_xcjf.xcjf020,l_xcjf.xcjf021,l_xcjf.xcjf022,l_xcjf.xcjf023,l_xcjf.xcjf024,l_xcjf.xcjf028,l_xcjf.xcjf029,l_xcjf.xcjf030,
                      l_xcjf.xcjf031,l_xcjf.xcjf032,l_xcjf.xcjf033,l_xcjf.xcjf034,l_xcjf.xcjf035,l_xcjf.xcjf036,l_xcjf.xcjf037,l_xcjf.xcjf038,l_xcjf.xcjf039,
                      l_xcjf.xcjf040,l_xcjf.xcjf041,l_xcjf.xcjf042,l_xcjf.xcjf043,l_xcjf.xcjf044,l_xcjf.xcjf045,l_xcjf.xcjf046,l_xcjf.xcjf047,l_xcjf.xcjf048,
                      l_xcjf.xcjf049,l_xcjf.xcjf050,l_xcjf.xcjf051,l_xcjf.xcjf052,l_xcjf.xcjf053,l_xcjf.xcjf101,l_xcjf.xcjf102,l_xcjf.xcjf110,l_xcjf.xcjf200,
                      l_xcjf.xcjf201,l_xcjf.xcjf210,l_xcjf.xcjf211,l_xcjf.xcjf220,l_xcjf.xcjf221,
                      l_xcjf.xcjfud001,l_xcjf.xcjfud002,l_xcjf.xcjfud003,l_xcjf.xcjfud004,l_xcjf.xcjfud005,l_xcjf.xcjfud006,l_xcjf.xcjfud007,l_xcjf.xcjfud008,
                      l_xcjf.xcjfud009,l_xcjf.xcjfud010,l_xcjf.xcjfud011,l_xcjf.xcjfud012,l_xcjf.xcjfud013,l_xcjf.xcjfud014,l_xcjf.xcjfud015,l_xcjf.xcjfud016,
                      l_xcjf.xcjfud017,l_xcjf.xcjfud018,l_xcjf.xcjfud019,l_xcjf.xcjfud020,l_xcjf.xcjfud021,l_xcjf.xcjfud022,l_xcjf.xcjfud023,l_xcjf.xcjfud024,
                      l_xcjf.xcjfud025,l_xcjf.xcjfud026,l_xcjf.xcjfud027,l_xcjf.xcjfud028,l_xcjf.xcjfud029,l_xcjf.xcjfud030) 
   #161124-00048#19 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcjf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#根据生产工时报工单上的报工部门和生产工单上的生产部门，如果两者不归属一个成本中心，则根据两个不同部门之间该料的内部加工费用结算价。
PUBLIC FUNCTION axct950_01_ins_xcjf_f_sffb(p_xcjeld,p_xcjedocno,p_sffbdocno,p_sffb005,p_sffb029,p_ooeg004_sfaa,p_ooeg004_sffb,p_sffb017,p_sffb016)
   DEFINE p_xcjeld      LIKE xcje_t.xcjeld
   DEFINE p_xcjedocno   LIKE xcje_t.xcjedocno
   DEFINE p_sffbdocno     LIKE sffb_t.sffbdocno  #报工单
   DEFINE p_sffb005       LIKE sffb_t.sffb005    #工单
   DEFINE p_sffb029       LIKE sffb_t.sffb029    #报工料号
   DEFINE p_ooeg004_sfaa  LIKE ooeg_t.ooeg004    #生产部门成本中心
   DEFINE p_ooeg004_sffb  LIKE ooeg_t.ooeg004    #报工部门成本中心
   DEFINE p_sffb017       LIKE sffb_t.sffb017    #报工数量
   DEFINE p_sffb016       LIKE sffb_t.sffb016    #报工单位
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
#   DEFINE l_glad          RECORD LIKE glad_t.*  #科目相关设置  #161124-00048#19 mark
#   DEFINE l_xcjf          RECORD LIKE xcjf_t.*  #161124-00048#19 mark
   DEFINE l_imaa006       LIKE imaa_t.imaa006   #基础单位
#   DEFINE l_xcjb          RECORD LIKE xcjb_t.* #161124-00048#19 mark
   DEFINE l_rate          LIKE xcjf_t.xcjf024   #计价单位与内部定价单位的换算率
   DEFINE l_cnt           LIKE type_t.num5
   #161124-00048#19 add(s)
   DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企业编号
       gladownid LIKE glad_t.gladownid, #资料所有者
       gladowndp LIKE glad_t.gladowndp, #资料所有部门
       gladcrtid LIKE glad_t.gladcrtid, #资料录入者
       gladcrtdp LIKE glad_t.gladcrtdp, #资料录入部门
       gladcrtdt LIKE glad_t.gladcrtdt, #资料创建日
       gladmodid LIKE glad_t.gladmodid, #资料更改者
       gladmoddt LIKE glad_t.gladmoddt, #最近更改日
       gladstus LIKE glad_t.gladstus, #状态码
       gladld LIKE glad_t.gladld, #账套
       glad001 LIKE glad_t.glad001, #会计科目编号
       glad002 LIKE glad_t.glad002, #是否按余额类型生成分录
       glad003 LIKE glad_t.glad003, #启用凭证项次细项立冲
       glad004 LIKE glad_t.glad004, #凭证项次异动别
       glad005 LIKE glad_t.glad005, #是否启用数量金额式
       glad006 LIKE glad_t.glad006, #借方现金变动码
       glad007 LIKE glad_t.glad007, #启用部门管理
       glad008 LIKE glad_t.glad008, #启用利润成本管理
       glad009 LIKE glad_t.glad009, #启用区域管理
       glad010 LIKE glad_t.glad010, #启用收付款客商管理
       glad011 LIKE glad_t.glad011, #启用客群管理
       glad012 LIKE glad_t.glad012, #启用产品类别管理
       glad013 LIKE glad_t.glad013, #启用人员管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #启用项目管理
       glad016 LIKE glad_t.glad016, #启用WBS管理
       glad017 LIKE glad_t.glad017, #启用自由核算项一
       glad0171 LIKE glad_t.glad0171, #自由核算项一类型编号
       glad0172 LIKE glad_t.glad0172, #自由核算项一控制方式
       glad018 LIKE glad_t.glad018, #启用自由核算项二
       glad0181 LIKE glad_t.glad0181, #自由核算项二类型编号
       glad0182 LIKE glad_t.glad0182, #自由核算项二控制方式
       glad019 LIKE glad_t.glad019, #启用自由核算项三
       glad0191 LIKE glad_t.glad0191, #自由核算项三类型编号
       glad0192 LIKE glad_t.glad0192, #自由核算项三控制方式
       glad020 LIKE glad_t.glad020, #启用自由核算项四
       glad0201 LIKE glad_t.glad0201, #自由核算项四类型编号
       glad0202 LIKE glad_t.glad0202, #自由核算项四控制方式
       glad021 LIKE glad_t.glad021, #启用自由核算项五
       glad0211 LIKE glad_t.glad0211, #自由核算项五类型编号
       glad0212 LIKE glad_t.glad0212, #自由核算项五控制方式
       glad022 LIKE glad_t.glad022, #启用自由核算项六
       glad0221 LIKE glad_t.glad0221, #自由核算项六类型编号
       glad0222 LIKE glad_t.glad0222, #自由核算项六控制方式
       glad023 LIKE glad_t.glad023, #启用自由核算项七
       glad0231 LIKE glad_t.glad0231, #自由核算项七类型编号
       glad0232 LIKE glad_t.glad0232, #自由核算项七控制方式
       glad024 LIKE glad_t.glad024, #启用自由核算项八
       glad0241 LIKE glad_t.glad0241, #自由核算项八类型编号
       glad0242 LIKE glad_t.glad0242, #自由核算项八控制方式
       glad025 LIKE glad_t.glad025, #启用自由核算项九
       glad0251 LIKE glad_t.glad0251, #自由核算项九类型编号
       glad0252 LIKE glad_t.glad0252, #自由核算项九控制方式
       glad026 LIKE glad_t.glad026, #启用自由核算项十
       glad0261 LIKE glad_t.glad0261, #自由核算项十类型编号
       glad0262 LIKE glad_t.glad0262, #自由核算项十控制方式
       glad027 LIKE glad_t.glad027, #启用账款客商管理
       glad030 LIKE glad_t.glad030, #是否进行预算管控
       glad031 LIKE glad_t.glad031, #启用经营方式管理
       glad032 LIKE glad_t.glad032, #启用渠道管理
       glad033 LIKE glad_t.glad033, #启用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多币种管理
       glad035 LIKE glad_t.glad035, #是否是子系统科目
       glad036 LIKE glad_t.glad036  #贷方现金变动码
END RECORD
DEFINE l_xcjf RECORD  #內部收入成本數據明細檔
       xcjfent LIKE xcjf_t.xcjfent, #企业编号
       xcjfsite LIKE xcjf_t.xcjfsite, #账务中心
       xcjfld LIKE xcjf_t.xcjfld, #账套
       xcjfdocno LIKE xcjf_t.xcjfdocno, #单据编号
       xcjfseq LIKE xcjf_t.xcjfseq, #项次
       xcjf001 LIKE xcjf_t.xcjf001, #业务单据
       xcjf002 LIKE xcjf_t.xcjf002, #项次
       xcjf003 LIKE xcjf_t.xcjf003, #项次
       xcjf010 LIKE xcjf_t.xcjf010, #类型(收入/成本)
       xcjf011 LIKE xcjf_t.xcjf011, #来源(存货/在制)
       xcjf012 LIKE xcjf_t.xcjf012, #计算类别(损益/资产)
       xcjf013 LIKE xcjf_t.xcjf013, #实体利润中心（组织)
       xcjf014 LIKE xcjf_t.xcjf014, #虚拟利润中心(组织)
       xcjf015 LIKE xcjf_t.xcjf015, #交易组织(site)
       xcjf016 LIKE xcjf_t.xcjf016, #料号
       xcjf017 LIKE xcjf_t.xcjf017, #仓库
       xcjf018 LIKE xcjf_t.xcjf018, #批号
       xcjf019 LIKE xcjf_t.xcjf019, #异动类型
       xcjf020 LIKE xcjf_t.xcjf020, #基础单位
       xcjf021 LIKE xcjf_t.xcjf021, #出入库码
       xcjf022 LIKE xcjf_t.xcjf022, #异动数量
       xcjf023 LIKE xcjf_t.xcjf023, #计价单位
       xcjf024 LIKE xcjf_t.xcjf024, #换算率
       xcjf028 LIKE xcjf_t.xcjf028, #收入/成本/存货科目
       xcjf029 LIKE xcjf_t.xcjf029, #对方科目
       xcjf030 LIKE xcjf_t.xcjf030, #摘要
       xcjf031 LIKE xcjf_t.xcjf031, #部门
       xcjf032 LIKE xcjf_t.xcjf032, #成本中心
       xcjf033 LIKE xcjf_t.xcjf033, #区域
       xcjf034 LIKE xcjf_t.xcjf034, #交易对象
       xcjf035 LIKE xcjf_t.xcjf035, #账款对象
       xcjf036 LIKE xcjf_t.xcjf036, #客群
       xcjf037 LIKE xcjf_t.xcjf037, #品类
       xcjf038 LIKE xcjf_t.xcjf038, #经营类别
       xcjf039 LIKE xcjf_t.xcjf039, #渠道
       xcjf040 LIKE xcjf_t.xcjf040, #品牌
       xcjf041 LIKE xcjf_t.xcjf041, #人员
       xcjf042 LIKE xcjf_t.xcjf042, #项目号
       xcjf043 LIKE xcjf_t.xcjf043, #WBS
       xcjf044 LIKE xcjf_t.xcjf044, #自由核算项1
       xcjf045 LIKE xcjf_t.xcjf045, #自由核算项2
       xcjf046 LIKE xcjf_t.xcjf046, #自由核算项3
       xcjf047 LIKE xcjf_t.xcjf047, #自由核算项4
       xcjf048 LIKE xcjf_t.xcjf048, #自由核算项5
       xcjf049 LIKE xcjf_t.xcjf049, #自由核算项6
       xcjf050 LIKE xcjf_t.xcjf050, #自由核算项7
       xcjf051 LIKE xcjf_t.xcjf051, #自由核算项8
       xcjf052 LIKE xcjf_t.xcjf052, #自由核算项9
       xcjf053 LIKE xcjf_t.xcjf053, #自由核算项10
       xcjf101 LIKE xcjf_t.xcjf101, #交易币种
       xcjf102 LIKE xcjf_t.xcjf102, #交易单价
       xcjf110 LIKE xcjf_t.xcjf110, #交易金额
       xcjf200 LIKE xcjf_t.xcjf200, #换算汇率
       xcjf201 LIKE xcjf_t.xcjf201, #本位币一金额
       xcjf210 LIKE xcjf_t.xcjf210, #换算汇率二
       xcjf211 LIKE xcjf_t.xcjf211, #本位币二金额
       xcjf220 LIKE xcjf_t.xcjf220, #换算汇率三
       xcjf221 LIKE xcjf_t.xcjf221, #本位币三金额
       xcjfud001 LIKE xcjf_t.xcjfud001, #自定义字段(文本)001
       xcjfud002 LIKE xcjf_t.xcjfud002, #自定义字段(文本)002
       xcjfud003 LIKE xcjf_t.xcjfud003, #自定义字段(文本)003
       xcjfud004 LIKE xcjf_t.xcjfud004, #自定义字段(文本)004
       xcjfud005 LIKE xcjf_t.xcjfud005, #自定义字段(文本)005
       xcjfud006 LIKE xcjf_t.xcjfud006, #自定义字段(文本)006
       xcjfud007 LIKE xcjf_t.xcjfud007, #自定义字段(文本)007
       xcjfud008 LIKE xcjf_t.xcjfud008, #自定义字段(文本)008
       xcjfud009 LIKE xcjf_t.xcjfud009, #自定义字段(文本)009
       xcjfud010 LIKE xcjf_t.xcjfud010, #自定义字段(文本)010
       xcjfud011 LIKE xcjf_t.xcjfud011, #自定义字段(数字)011
       xcjfud012 LIKE xcjf_t.xcjfud012, #自定义字段(数字)012
       xcjfud013 LIKE xcjf_t.xcjfud013, #自定义字段(数字)013
       xcjfud014 LIKE xcjf_t.xcjfud014, #自定义字段(数字)014
       xcjfud015 LIKE xcjf_t.xcjfud015, #自定义字段(数字)015
       xcjfud016 LIKE xcjf_t.xcjfud016, #自定义字段(数字)016
       xcjfud017 LIKE xcjf_t.xcjfud017, #自定义字段(数字)017
       xcjfud018 LIKE xcjf_t.xcjfud018, #自定义字段(数字)018
       xcjfud019 LIKE xcjf_t.xcjfud019, #自定义字段(数字)019
       xcjfud020 LIKE xcjf_t.xcjfud020, #自定义字段(数字)020
       xcjfud021 LIKE xcjf_t.xcjfud021, #自定义字段(日期时间)021
       xcjfud022 LIKE xcjf_t.xcjfud022, #自定义字段(日期时间)022
       xcjfud023 LIKE xcjf_t.xcjfud023, #自定义字段(日期时间)023
       xcjfud024 LIKE xcjf_t.xcjfud024, #自定义字段(日期时间)024
       xcjfud025 LIKE xcjf_t.xcjfud025, #自定义字段(日期时间)025
       xcjfud026 LIKE xcjf_t.xcjfud026, #自定义字段(日期时间)026
       xcjfud027 LIKE xcjf_t.xcjfud027, #自定义字段(日期时间)027
       xcjfud028 LIKE xcjf_t.xcjfud028, #自定义字段(日期时间)028
       xcjfud029 LIKE xcjf_t.xcjfud029, #自定义字段(日期时间)029
       xcjfud030 LIKE xcjf_t.xcjfud030  #自定义字段(日期时间)030
END RECORD
DEFINE l_xcjb RECORD  #內部交易定價主檔
       xcjbent LIKE xcjb_t.xcjbent, #企业编号
       xcjb001 LIKE xcjb_t.xcjb001, #计算类型(版本)
       xcjb002 LIKE xcjb_t.xcjb002, #年度
       xcjb003 LIKE xcjb_t.xcjb003, #期别
       xcjb004 LIKE xcjb_t.xcjb004, #料号
       xcjb005 LIKE xcjb_t.xcjb005, #销售组织
       xcjb006 LIKE xcjb_t.xcjb006, #采购组织
       xcjb007 LIKE xcjb_t.xcjb007, #计价单位
       xcjb008 LIKE xcjb_t.xcjb008, #币种
       xcjb009 LIKE xcjb_t.xcjb009, #内部定价
       xcjbownid LIKE xcjb_t.xcjbownid, #资料所有者
       xcjbowndp LIKE xcjb_t.xcjbowndp, #资料所有部门
       xcjbcrtid LIKE xcjb_t.xcjbcrtid, #资料录入者
       xcjbcrtdp LIKE xcjb_t.xcjbcrtdp, #资料录入部门
       xcjbcrtdt LIKE xcjb_t.xcjbcrtdt, #资料创建日
       xcjbmodid LIKE xcjb_t.xcjbmodid, #资料更改者
       xcjbmoddt LIKE xcjb_t.xcjbmoddt, #最近更改日
       xcjbstus LIKE xcjb_t.xcjbstus  #状态码
END RECORD
   #161124-00048#19 add(e)
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #已经产生过的不用再产生
   SELECT COUNT(*) INTO l_cnt FROM xcjf_t
    WHERE xcjfent   = g_enterprise
      AND xcjfld    = p_xcjeld
      AND xcjfdocno = p_xcjedocno
      AND xcjf001   = p_sffbdocno   #業務單據：报工单号
      AND xcjf010   = '5'   #内部代工生产类型中的一种
   IF l_cnt > 0 THEN
      RETURN r_success
   END IF
   
#   SELECT * INTO g_xcje.* FROM xcje_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
    SELECT xcjeent,xcjesite,xcjeld,xcjedocno,xcjedocdt,xcje001,xcje002,
           xcje003,xcje004,xcje005,xcje006,xcje007,xcjeownid,xcjeowndp,
           xcjecrtid,xcjecrtdp,xcjecrtdt,xcjemodid,xcjemoddt,xcjecnfid,
           xcjecnfdt,xcjepstid,xcjepstdt,xcjestus 
      INTO g_xcje.* FROM xcje_t
   #161124-00048#19 add(e)
    WHERE xcjeent  = g_enterprise
      AND xcjeld   = p_xcjeld
      AND xcjedocno= p_xcjedocno
   
#   SELECT * INTO g_glaa.* FROM glaa_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,
          glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,
          glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,
          glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
          glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,
          glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
          glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,
          glaa124,glaa028 
     INTO g_glaa.* FROM glaa_t
   #161124-00048#19 add(e)
    WHERE glaaent = g_enterprise 
      AND glaald  = g_xcje.xcjeld
   
   #取当期的起始及截止日期
   CALL s_fin_date_get_period_range(g_glaa.glaa003,g_xcje.xcje002,g_xcje.xcje003)
        RETURNING g_bdate,g_edate
   
#   SELECT * INTO g_xcja.* FROM xcja_t  #内部交易计算基础设置  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjaent,xcja001,xcja002,xcja003,xcja004,xcja005,xcja006,xcja007,
          xcja008,xcja009,xcja010,xcjaownid,xcjaowndp,xcjacrtid,xcjacrtdp,
          xcjacrtdt,xcjamodid,xcjamoddt,xcjastus,xcja011 
     INTO g_xcja.* FROM xcja_t  #内部交易计算基础设置
   #161124-00048#19 add(e)
    WHERE xcjaent = g_enterprise
      AND xcja001 = g_xcje.xcje006  #计算类型(版本)
   
   SELECT imaa006 INTO l_imaa006 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_sffb029
   
   #--报工部门的内部加工收入
   INITIALIZE l_xcjf.* TO NULL   #清空
   LET l_xcjf.xcjfent   = g_enterprise     #企業編號
   LET l_xcjf.xcjfsite  = g_xcje.xcjesite  #賬務中心
   LET l_xcjf.xcjfld    = g_xcje.xcjeld    #帳套
   LET l_xcjf.xcjfdocno = g_xcje.xcjedocno #單據編號
   #LET l_xcjf.xcjfseq             #項次
   SELECT MAX(xcjfseq)+1 INTO l_xcjf.xcjfseq FROM xcjf_t
    WHERE xcjfent  = l_xcjf.xcjfent
      AND xcjfld   = l_xcjf.xcjfld
      AND xcjfdocno= l_xcjf.xcjfdocno
   IF cl_null(l_xcjf.xcjfseq) OR l_xcjf.xcjfseq=0 THEN
      LET l_xcjf.xcjfseq = 1
   END IF
   LET l_xcjf.xcjf001   = p_sffbdocno   #業務單據：报工单号
   LET l_xcjf.xcjf002   = 0    #項次
   LET l_xcjf.xcjf003   = 0    #項次
   #库存结存 --仓库所属利润中心的内部成本 金额为正向
   LET l_xcjf.xcjf010   = '5'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本/5.內部加工收入/6.內部加工成本)
   LET l_xcjf.xcjf013   = p_ooeg004_sffb         #實體利潤中心（組織)  ：报工部门
   LET l_xcjf.xcjf031   = ''    #申请部门
   LET l_xcjf.xcjf041   = ''    #申请人员
   
   #目前来源都是基于存货，计算类别都是损益;在制和资产等后面再思考如何做
   LET l_xcjf.xcjf011   = '1'              #來源(存貨/在制)
   LET l_xcjf.xcjf012   = '1'              #計算類別(損益/資產)
   LET l_xcjf.xcjf014   = g_xcja.xcja007   #虛擬利潤中心(組織)
   LET l_xcjf.xcjf015   = ''               #交易組織(site)
   LET l_xcjf.xcjf016   = p_sffb029        #料號
   LET l_xcjf.xcjf017   = ' '        #倉庫
   LET l_xcjf.xcjf018   = ' '   #批號
   LET l_xcjf.xcjf019   = ''   #異動類型
   LET l_xcjf.xcjf020   = l_imaa006   #基礎單位
   LET l_xcjf.xcjf021   = 0   #出入庫碼
   
   #LET l_xcjf.xcjf028   =    #收入成本存貨科目
   #mod--161103-00045#3 By shiun--(S)
   IF l_xcjf.xcjf010 MATCHES '[125]' THEN  #收入
#      CALL s_get_item_acc(g_xcje.xcjeld,'4',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'27',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'') #170105-00002#1 mod 26->27
         RETURNING l_success,l_xcjf.xcjf028  #收入
   END IF
   IF l_xcjf.xcjf010 MATCHES '[346]' THEN  #成本
#      CALL s_get_item_acc(g_xcje.xcjeld,'5',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'28',l_xcjf.xcjf016,'','',g_glaa.glaacomp,'') #170105-00002#1 mod 27->28
         RETURNING l_success,l_xcjf.xcjf028 #成本
   END IF
   #mod--161103-00045#3 By shiun--(E)
   LET l_xcjf.xcjf029   = l_xcjf.xcjf028   #對方科目
   LET l_xcjf.xcjf030   = ''               #摘要
   
   LET l_xcjf.xcjf032   = l_xcjf.xcjf013        #成本中心=實體利潤中心（組織)
   
   #根据科目预设资料
   #获取科目相关设置预设资料
#   SELECT * INTO l_glad.* FROM glad_t #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,
          gladstus,gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,
          glad009,glad010,glad011,glad012,glad013,glad014,glad015,glad016,glad017,glad0171,
          glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,glad020,glad0201,
          glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,
          glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,
          glad0262,glad027,glad030,glad031,glad032,glad033,glad034,glad035,glad036 
     INTO l_glad.* FROM glad_t
   #161124-00048#19 add(e)
    WHERE gladent = g_enterprise
      AND gladld  = g_xcje.xcjeld
      AND glad001 = l_xcjf.xcjf028  #科目
   IF l_glad.glad009 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'4') RETURNING l_xcjf.xcjf033  #區域
   END IF
   IF l_glad.glad010 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'5') RETURNING l_xcjf.xcjf034  #交易對象
   END IF
   IF l_glad.glad027 = 'Y'THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'6') RETURNING l_xcjf.xcjf035  #帳款對象
   END IF
   IF l_glad.glad011 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'7') RETURNING l_xcjf.xcjf036  #客群
   END IF
   IF l_glad.glad012 ='Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'8') RETURNING l_xcjf.xcjf037  #品類
   END IF
   IF l_glad.glad031 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'9') RETURNING l_xcjf.xcjf038  #經營類別
   END IF
   IF l_glad.glad032 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'10') RETURNING l_xcjf.xcjf039  #渠道
   END IF
   IF l_glad.glad033 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'11') RETURNING l_xcjf.xcjf040  #品牌
   END IF
   IF l_glad.glad015 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'13') RETURNING l_xcjf.xcjf042  #項目號
   END IF
   IF l_glad.glad016 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'14') RETURNING l_xcjf.xcjf043  #WBS
   END IF
   IF l_glad.glad017 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'15') RETURNING l_xcjf.xcjf044  #自由核算項1
   END IF
   IF l_glad.glad018 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'16') RETURNING l_xcjf.xcjf045  #自由核算項2
   END IF
   IF l_glad.glad019 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'17') RETURNING l_xcjf.xcjf046  #自由核算項3
   END IF
   IF l_glad.glad020 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'18') RETURNING l_xcjf.xcjf047  #自由核算項4
   END IF
   IF l_glad.glad021 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'19') RETURNING l_xcjf.xcjf048  #自由核算項5
   END IF
   IF l_glad.glad022 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'20') RETURNING l_xcjf.xcjf049  #自由核算項6
   END IF
   IF l_glad.glad023 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'21') RETURNING l_xcjf.xcjf050  #自由核算項7
   END IF
   IF l_glad.glad024 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'22') RETURNING l_xcjf.xcjf051  #自由核算項8
   END IF
   IF l_glad.glad025 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'23') RETURNING l_xcjf.xcjf052  #自由核算項9
   END IF
   IF l_glad.glad026 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,l_xcjf.xcjf028,'24') RETURNING l_xcjf.xcjf053  #自由核算項10
   END IF
   
   LET l_xcjf.xcjf022 = p_sffb017       #異動數量
   LET l_xcjf.xcjf023 = p_sffb016       #計價單位
   #換算率xcjf024:计价单位与成本单位的换算率
   IF l_xcjf.xcjf020 = l_xcjf.xcjf023 THEN    #计价单位与成本单位的换算率
      LET l_xcjf.xcjf024 = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(l_xcjf.xcjf016,l_xcjf.xcjf023,l_xcjf.xcjf020,1)
           RETURNING l_success,l_xcjf.xcjf024
      IF cl_null(l_xcjf.xcjf024) OR l_xcjf.xcjf024 = 0 THEN
         LET l_xcjf.xcjf024 = 1          #換算率
      END IF
   END IF
   
   #LET l_xcjf.xcjf101 =    #交易幣別
   #LET l_xcjf.xcjf102 =    #交易單價(交易单位的)
   #LET l_xcjf.xcjf110 =    #交易金額
   #LET l_xcjf.xcjf200 =    #換算匯率
   #LET l_xcjf.xcjf210 =    #換算匯率二
   #LET l_xcjf.xcjf220 =    #換算匯率三
   #LET l_xcjf.xcjf201 =    #本位幣一金額
   #LET l_xcjf.xcjf211 =    #本位幣二金額
   #LET l_xcjf.xcjf221 =    #本位幣三金額
   #取axci951的xcjb009
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
    WHERE xcjbent = g_enterprise
      AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
      AND xcjb002 = g_xcje.xcje002  #年
      AND xcjb003 = g_xcje.xcje003  #期
      AND xcjb004 = l_xcjf.xcjf016  #料号
      AND xcjb005 = p_ooeg004_sffb  #销售组织：报工部门
      AND xcjb006 = p_ooeg004_sfaa  #采购组织：生产部门
   IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
       WHERE xcjbent = g_enterprise
         AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
         AND xcjb002 = g_xcje.xcje002  #年
         AND xcjb003 = g_xcje.xcje003  #期
         AND xcjb004 = l_xcjf.xcjf016  #料号
         AND xcjb005 = p_ooeg004_sffb #销售组织：报工部门
         AND xcjb006 = 'ALL'      #采购组织
      IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
          WHERE xcjbent = g_enterprise
            AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
            AND xcjb002 = g_xcje.xcje002  #年
            AND xcjb003 = g_xcje.xcje003  #期
            AND xcjb004 = l_xcjf.xcjf016  #料号
            AND xcjb005='ALL'  #销售组织
            AND xcjb006='ALL'  #采购组织
      END IF
   END IF
   
   IF cl_null(l_xcjb.xcjb007) OR cl_null(l_xcjb.xcjb008) OR l_xcjb.xcjb009=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.replace[1] = p_ooeg004_sffb
      LET g_errparam.replace[2] = p_ooeg004_sfaa
      LET g_errparam.code = 'axc-00784'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
   #计算交易单价xcjf102
   IF l_xcjf.xcjf023 = l_xcjb.xcjb007 THEN    #计价单位与内部定价单位的换算率
      LET l_rate = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(l_xcjf.xcjf016,l_xcjb.xcjb007,l_xcjf.xcjf023,1)
           RETURNING l_success,l_rate
      IF cl_null(l_rate) OR l_rate = 0 THEN
         LET l_rate = 1          #換算率
      END IF
   END IF
   LET l_xcjf.xcjf102 = l_xcjb.xcjb009 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
   
   LET l_xcjf.xcjf101 = l_xcjb.xcjb008        #交易幣別
   LET l_xcjf.xcjf110 = l_xcjf.xcjf102 * l_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
      
   #汇率一
   CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
         RETURNING l_xcjf.xcjf200
   IF cl_null(l_xcjf.xcjf200) OR l_xcjf.xcjf200=0 THEN LET l_xcjf.xcjf200 = 1 END IF
   LET l_xcjf.xcjf201 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
   #汇率二
   IF g_glaa.glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
         RETURNING l_xcjf.xcjf210
   ELSE
      LET l_xcjf.xcjf210 = 0
   END IF
   LET l_xcjf.xcjf211 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
   #汇率三
   IF g_glaa.glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
         RETURNING l_xcjf.xcjf220
   ELSE
      LET l_xcjf.xcjf220 = 0
   END IF
   LET l_xcjf.xcjf221 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三
           

   LET l_xcjf.xcjfud021 = ''   #自定義欄位(日期時間)021
   LET l_xcjf.xcjfud022 = ''   #自定義欄位(日期時間)022
   LET l_xcjf.xcjfud023 = ''   #自定義欄位(日期時間)023
   LET l_xcjf.xcjfud024 = ''   #自定義欄位(日期時間)024
   LET l_xcjf.xcjfud025 = ''   #自定義欄位(日期時間)025
   LET l_xcjf.xcjfud026 = ''   #自定義欄位(日期時間)026
   LET l_xcjf.xcjfud027 = ''   #自定義欄位(日期時間)027
   LET l_xcjf.xcjfud028 = ''   #自定義欄位(日期時間)028
   LET l_xcjf.xcjfud029 = ''   #自定義欄位(日期時間)029
   LET l_xcjf.xcjfud030 = ''   #自定義欄位(日期時間)030
   
#   INSERT INTO xcjf_t VALUES l_xcjf.*  #161124-00048#19 mark
    #161124-00048#19 add(s)
   INSERT INTO xcjf_t(xcjfent,xcjfsite,xcjfld,xcjfdocno,xcjfseq,xcjf001,xcjf002,xcjf003,
                      xcjf010,xcjf011,xcjf012,xcjf013,xcjf014,xcjf015,xcjf016,xcjf017,xcjf018,
                      xcjf019,xcjf020,xcjf021,xcjf022,xcjf023,xcjf024,xcjf028,xcjf029,xcjf030,
                      xcjf031,xcjf032,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf038,xcjf039,
                      xcjf040,xcjf041,xcjf042,xcjf043,xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,
                      xcjf049,xcjf050,xcjf051,xcjf052,xcjf053,xcjf101,xcjf102,xcjf110,xcjf200,
                      xcjf201,xcjf210,xcjf211,xcjf220,xcjf221,
                      xcjfud001,xcjfud002,xcjfud003,xcjfud004,xcjfud005,xcjfud006,xcjfud007,xcjfud008,
                      xcjfud009,xcjfud010,xcjfud011,xcjfud012,xcjfud013,xcjfud014,xcjfud015,xcjfud016,
                      xcjfud017,xcjfud018,xcjfud019,xcjfud020,xcjfud021,xcjfud022,xcjfud023,xcjfud024,
                      xcjfud025,xcjfud026,xcjfud027,xcjfud028,xcjfud029,xcjfud030) 
               VALUES(l_xcjf.xcjfent,l_xcjf.xcjfsite,l_xcjf.xcjfld,l_xcjf.xcjfdocno,l_xcjf.xcjfseq,l_xcjf.xcjf001,l_xcjf.xcjf002,l_xcjf.xcjf003,
                      l_xcjf.xcjf010,l_xcjf.xcjf011,l_xcjf.xcjf012,l_xcjf.xcjf013,l_xcjf.xcjf014,l_xcjf.xcjf015,l_xcjf.xcjf016,l_xcjf.xcjf017,l_xcjf.xcjf018,
                      l_xcjf.xcjf019,l_xcjf.xcjf020,l_xcjf.xcjf021,l_xcjf.xcjf022,l_xcjf.xcjf023,l_xcjf.xcjf024,l_xcjf.xcjf028,l_xcjf.xcjf029,l_xcjf.xcjf030,
                      l_xcjf.xcjf031,l_xcjf.xcjf032,l_xcjf.xcjf033,l_xcjf.xcjf034,l_xcjf.xcjf035,l_xcjf.xcjf036,l_xcjf.xcjf037,l_xcjf.xcjf038,l_xcjf.xcjf039,
                      l_xcjf.xcjf040,l_xcjf.xcjf041,l_xcjf.xcjf042,l_xcjf.xcjf043,l_xcjf.xcjf044,l_xcjf.xcjf045,l_xcjf.xcjf046,l_xcjf.xcjf047,l_xcjf.xcjf048,
                      l_xcjf.xcjf049,l_xcjf.xcjf050,l_xcjf.xcjf051,l_xcjf.xcjf052,l_xcjf.xcjf053,l_xcjf.xcjf101,l_xcjf.xcjf102,l_xcjf.xcjf110,l_xcjf.xcjf200,
                      l_xcjf.xcjf201,l_xcjf.xcjf210,l_xcjf.xcjf211,l_xcjf.xcjf220,l_xcjf.xcjf221,
                      l_xcjf.xcjfud001,l_xcjf.xcjfud002,l_xcjf.xcjfud003,l_xcjf.xcjfud004,l_xcjf.xcjfud005,l_xcjf.xcjfud006,l_xcjf.xcjfud007,l_xcjf.xcjfud008,
                      l_xcjf.xcjfud009,l_xcjf.xcjfud010,l_xcjf.xcjfud011,l_xcjf.xcjfud012,l_xcjf.xcjfud013,l_xcjf.xcjfud014,l_xcjf.xcjfud015,l_xcjf.xcjfud016,
                      l_xcjf.xcjfud017,l_xcjf.xcjfud018,l_xcjf.xcjfud019,l_xcjf.xcjfud020,l_xcjf.xcjfud021,l_xcjf.xcjfud022,l_xcjf.xcjfud023,l_xcjf.xcjfud024,
                      l_xcjf.xcjfud025,l_xcjf.xcjfud026,l_xcjf.xcjfud027,l_xcjf.xcjfud028,l_xcjf.xcjfud029,l_xcjf.xcjfud030) 
   #161124-00048#19 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcjf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #--生产部门的内部加工成本
   #LET l_xcjf.xcjfseq             #項次
   SELECT MAX(xcjfseq)+1 INTO l_xcjf.xcjfseq FROM xcjf_t
    WHERE xcjfent  = l_xcjf.xcjfent
      AND xcjfld   = l_xcjf.xcjfld
      AND xcjfdocno= l_xcjf.xcjfdocno
   IF cl_null(l_xcjf.xcjfseq) OR l_xcjf.xcjfseq=0 THEN
      LET l_xcjf.xcjfseq = 1
   END IF
   LET l_xcjf.xcjf010   = '6'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本/5.內部加工收入/6.內部加工成本)
   LET l_xcjf.xcjf013   = p_ooeg004_sfaa         #實體利潤中心（組織)  ：生产部门
   
   #LET l_xcjf.xcjf101 =    #交易幣別
   #LET l_xcjf.xcjf102 =    #交易單價(交易单位的)
   #LET l_xcjf.xcjf110 =    #交易金額
   #LET l_xcjf.xcjf200 =    #換算匯率
   #LET l_xcjf.xcjf210 =    #換算匯率二
   #LET l_xcjf.xcjf220 =    #換算匯率三
   #LET l_xcjf.xcjf201 =    #本位幣一金額
   #LET l_xcjf.xcjf211 =    #本位幣二金額
   #LET l_xcjf.xcjf221 =    #本位幣三金額
   #取axci951的xcjb009
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
    WHERE xcjbent = g_enterprise
      AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
      AND xcjb002 = g_xcje.xcje002  #年
      AND xcjb003 = g_xcje.xcje003  #期
      AND xcjb004 = l_xcjf.xcjf016  #料号
      AND xcjb005 = p_ooeg004_sffb  #销售组织
      AND xcjb006 = p_ooeg004_sfaa  #采购组织
   IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
       WHERE xcjbent = g_enterprise
         AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
         AND xcjb002 = g_xcje.xcje002  #年
         AND xcjb003 = g_xcje.xcje003  #期
         AND xcjb004 = l_xcjf.xcjf016  #料号
         AND xcjb005 = 'ALL'      #销售组织
         AND xcjb006 = p_ooeg004_sfaa  #采购组织
      IF SQLCA.sqlcode THEN
#   SELECT * INTO l_xcjb.* FROM xcjb_t  #161124-00048#19 mark
   #161124-00048#19 add(s)
   SELECT xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006,xcjb007,
          xcjb008,xcjb009,xcjbownid,xcjbowndp,xcjbcrtid,xcjbcrtdp,xcjbcrtdt,
          xcjbmodid,xcjbmoddt,xcjbstus 
     INTO l_xcjb.* FROM xcjb_t
   #161124-00048#19 add(e)
          WHERE xcjbent = g_enterprise
            AND xcjb001 = g_xcje.xcje006  #计算类型(版本)
            AND xcjb002 = g_xcje.xcje002  #年
            AND xcjb003 = g_xcje.xcje003  #期
            AND xcjb004 = l_xcjf.xcjf016  #料号
            AND xcjb005='ALL'  #销售组织
            AND xcjb006='ALL'  #采购组织
      END IF
   END IF
   IF cl_null(l_xcjb.xcjb007) OR cl_null(l_xcjb.xcjb008) OR l_xcjb.xcjb009=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.replace[1] = p_ooeg004_sffb
      LET g_errparam.replace[2] = p_ooeg004_sfaa
      LET g_errparam.code = 'axc-00784'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
   #计算交易单价xcjf102
   IF l_xcjf.xcjf023 = l_xcjb.xcjb007 THEN    #计价单位与内部定价单位的换算率
      LET l_rate = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(l_xcjf.xcjf016,l_xcjb.xcjb007,l_xcjf.xcjf023,1)
           RETURNING l_success,l_rate
      IF cl_null(l_rate) OR l_rate = 0 THEN
         LET l_rate = 1          #換算率
      END IF
   END IF
   LET l_xcjf.xcjf102 = l_xcjb.xcjb009 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
   
   LET l_xcjf.xcjf101 = l_xcjb.xcjb008        #交易幣別
   LET l_xcjf.xcjf110 = l_xcjf.xcjf102 * l_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
      
   #汇率一
   CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
         RETURNING l_xcjf.xcjf200
   IF cl_null(l_xcjf.xcjf200) OR l_xcjf.xcjf200=0 THEN LET l_xcjf.xcjf200 = 1 END IF
   LET l_xcjf.xcjf201 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
   #汇率二
   IF g_glaa.glaa015 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
         RETURNING l_xcjf.xcjf210
   ELSE
      LET l_xcjf.xcjf210 = 0
   END IF
   LET l_xcjf.xcjf211 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
   #汇率三
   IF g_glaa.glaa019 = 'Y' THEN
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,l_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
         RETURNING l_xcjf.xcjf220
   ELSE
      LET l_xcjf.xcjf220 = 0
   END IF
   LET l_xcjf.xcjf221 = (l_xcjf.xcjf110*l_xcjf.xcjf024) * l_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三

#   INSERT INTO xcjf_t VALUES l_xcjf.*  #161124-00048#19 mark
    #161124-00048#19 add(s)
   INSERT INTO xcjf_t(xcjfent,xcjfsite,xcjfld,xcjfdocno,xcjfseq,xcjf001,xcjf002,xcjf003,
                      xcjf010,xcjf011,xcjf012,xcjf013,xcjf014,xcjf015,xcjf016,xcjf017,xcjf018,
                      xcjf019,xcjf020,xcjf021,xcjf022,xcjf023,xcjf024,xcjf028,xcjf029,xcjf030,
                      xcjf031,xcjf032,xcjf033,xcjf034,xcjf035,xcjf036,xcjf037,xcjf038,xcjf039,
                      xcjf040,xcjf041,xcjf042,xcjf043,xcjf044,xcjf045,xcjf046,xcjf047,xcjf048,
                      xcjf049,xcjf050,xcjf051,xcjf052,xcjf053,xcjf101,xcjf102,xcjf110,xcjf200,
                      xcjf201,xcjf210,xcjf211,xcjf220,xcjf221,
                      xcjfud001,xcjfud002,xcjfud003,xcjfud004,xcjfud005,xcjfud006,xcjfud007,xcjfud008,
                      xcjfud009,xcjfud010,xcjfud011,xcjfud012,xcjfud013,xcjfud014,xcjfud015,xcjfud016,
                      xcjfud017,xcjfud018,xcjfud019,xcjfud020,xcjfud021,xcjfud022,xcjfud023,xcjfud024,
                      xcjfud025,xcjfud026,xcjfud027,xcjfud028,xcjfud029,xcjfud030) 
               VALUES(l_xcjf.xcjfent,l_xcjf.xcjfsite,l_xcjf.xcjfld,l_xcjf.xcjfdocno,l_xcjf.xcjfseq,l_xcjf.xcjf001,l_xcjf.xcjf002,l_xcjf.xcjf003,
                      l_xcjf.xcjf010,l_xcjf.xcjf011,l_xcjf.xcjf012,l_xcjf.xcjf013,l_xcjf.xcjf014,l_xcjf.xcjf015,l_xcjf.xcjf016,l_xcjf.xcjf017,l_xcjf.xcjf018,
                      l_xcjf.xcjf019,l_xcjf.xcjf020,l_xcjf.xcjf021,l_xcjf.xcjf022,l_xcjf.xcjf023,l_xcjf.xcjf024,l_xcjf.xcjf028,l_xcjf.xcjf029,l_xcjf.xcjf030,
                      l_xcjf.xcjf031,l_xcjf.xcjf032,l_xcjf.xcjf033,l_xcjf.xcjf034,l_xcjf.xcjf035,l_xcjf.xcjf036,l_xcjf.xcjf037,l_xcjf.xcjf038,l_xcjf.xcjf039,
                      l_xcjf.xcjf040,l_xcjf.xcjf041,l_xcjf.xcjf042,l_xcjf.xcjf043,l_xcjf.xcjf044,l_xcjf.xcjf045,l_xcjf.xcjf046,l_xcjf.xcjf047,l_xcjf.xcjf048,
                      l_xcjf.xcjf049,l_xcjf.xcjf050,l_xcjf.xcjf051,l_xcjf.xcjf052,l_xcjf.xcjf053,l_xcjf.xcjf101,l_xcjf.xcjf102,l_xcjf.xcjf110,l_xcjf.xcjf200,
                      l_xcjf.xcjf201,l_xcjf.xcjf210,l_xcjf.xcjf211,l_xcjf.xcjf220,l_xcjf.xcjf221,
                      l_xcjf.xcjfud001,l_xcjf.xcjfud002,l_xcjf.xcjfud003,l_xcjf.xcjfud004,l_xcjf.xcjfud005,l_xcjf.xcjfud006,l_xcjf.xcjfud007,l_xcjf.xcjfud008,
                      l_xcjf.xcjfud009,l_xcjf.xcjfud010,l_xcjf.xcjfud011,l_xcjf.xcjfud012,l_xcjf.xcjfud013,l_xcjf.xcjfud014,l_xcjf.xcjfud015,l_xcjf.xcjfud016,
                      l_xcjf.xcjfud017,l_xcjf.xcjfud018,l_xcjf.xcjfud019,l_xcjf.xcjfud020,l_xcjf.xcjfud021,l_xcjf.xcjfud022,l_xcjf.xcjfud023,l_xcjf.xcjfud024,
                      l_xcjf.xcjfud025,l_xcjf.xcjfud026,l_xcjf.xcjfud027,l_xcjf.xcjfud028,l_xcjf.xcjfud029,l_xcjf.xcjfud030) 
   #161124-00048#19 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcjf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#
PRIVATE FUNCTION axct950_01_msgcentre_notify()
   DEFINE lc_state LIKE type_t.chr5
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 

 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
END FUNCTION

 
{</section>}
 
{<section id="axct950_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct950_01_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
{<point name="modify.define_customerization" edit="c" mark="Y"/>}
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
{<point name="modify.define"/>}
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
 
 
{<point name="modify.before_input"/>}
 
 
 
END FUNCTION   
 
{</section>}
 
