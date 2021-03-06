#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0030(2016-06-13 17:17:39), PR版次:0030(2017-04-20 14:32:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: axcp200
#+ Description: 發出商品整批生產作業
#+ Creator....: 00768(2015-09-16 17:22:19)
#+ Modifier...: 02295 -SD/PR- 02294
 
{</section>}
 
{<section id="axcp200.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160603-00008#1   2016/06/03  By 02295  发出商品应包含当月出货，当月开票的资料(埃美柯追回)
#160328-00022#5   2016/07/14  By 02040  增加progressbar顯示計算進度條
#160706-00021#2   2016/07/14  By 02097  轉出時(出貨)發出商品科目應取原轉入時的科目，無則取料件對應的會計科目。
#                                       當月出貨又當月開發票者(aist310)則不計入/檢核轉出時，是取銷貨單的多倉儲表
#160804-00042#1   2016/08/04  By 02097  xckb006 應給isag003 而非isagseq 
#160817-00005#1   2016/08/30  By 02097  倉儲預設給值
#160907-00003#4   2016/09/08  By 02097  axcp200: 銷退單時,應取原出貨月份的成本金額
#160907-00003#1   2016/09/22  By 02295  走簽收出貨型式的, 系統沒捉到
#161012-00038#1   2016/10/13  By 01258  发出商品科目调整，销退单资料应只需扣除4、销货折让（泰日升追回）
#161124-00048#12  2016/12/13  By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#161223-00020#1   2016/12/23  By 02295  效能优化
#161222-00034#1   2017/01/03  By charles4m 調整 axcp200.4gl；當非銷退時，增加取出貨月的年度期別的值。
#170103-00021#1   2017/01/05  By charles4m SQL 多寫了一個 FROM
#170103-00022#1   2017/01/05  By charles4m 取成本域類型時，要使用 g_sys_6002 才正確
#170105-00068#1   2017/01/10  By 06694    調整MERGE語法
#170104-00054#1   2017/01/22  By 02295    效能优化
#170213-00024#1   2017/02/13  By 02295    将insert into的写法改成列出具体的栏位出来
#170214-00060#1   2017/02/20  By charles4m 1. 下QBE 條件無法產生資料。2. 銷退單抓不到出貨單扣帳日。3. 各種 SQL 語法錯誤。4. 發票跟原本出貨/銷退單金額對不上。
#                                          5. 從客戶貨款對帳明細 isag_t 撈資料要多下條件isag001 in ('11','21')。6. 增加抓取開張單價邏輯。7. 處理 xckb037 NULL 問題。
#170220-00038#1   2017/02/20  By charles4m 1.要判斷關帳年月，如果要執行的年月已超過關帳年月，不可重跑資料
#                                          2.PREPARE xckb_pre1 FROM g_sql 少右括號。
#                                          3.PREPARE xckb2_pre3 FROM g_sql isag004*isag005 改為 isag004*isag015。
#170220-00032#1   2017/02/22  By 02295     1. xckc_t 要加上出貨單號、項次，key index要加上這二個欄位
#                                          2. 從xckb_t產生xckc_t資料，要多加出貨單號、項次，另外從上期轉入、計算本月出貨數、本月轉出數這些地方的計算都要多加上出貨單號、項次
#                                          3. 把計算xckc_t這段寫程副程序，讓axcp204可以呼叫統計多期的xckc資料(要本次來用全域變數的值都改用傳入的方式)
#170306-00053#1   2017/03/07  By wujiea    axcp200_xckb2_new（）中将多笔isag合并，isaf011处理空值 
#170217-00025#7   2017/03/07  By zhujing   整批调整未产生数据时，提示消息修正。
#170306-00022#1   2017/03/13  By fionchen  調整因為小數位數的差異，會造成期末金額差異問題
#170207-00034#1   2017/03/14  By fionchen  1.账套开窗过滤操作者权限 2.修改账套后，应带出账套所属法人当前的"现行成本结算年度"和"现行成本结算期别"
#170322-00109#1   2017/03/27  By 00768     若参数“按料件特性计算成本否”为N时，xckb037栏位给空格
#170323-00090#1   2017/03/28  By 02111     PREPARE xckb_pre6 條件不構導致無法 MERGE，增加批號當條件即可。(AND b.xccc008 = a.xckb017)。
#170405-00005#1   2017/04/05  By 08734     修复执行 execute xckb_pre6 报错。
#170417-00016#1   2017/04/18  By 02295     调整#170214-00060#1处理漏掉的地方
#170414-00057#1   2017/04/19  By lixiang   出货单有对应的销退单，抓成本单价时，应以出货单的扣账日期取单价
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pmaa001 LIKE type_t.chr500, 
   imaa001 LIKE type_t.chr500, 
   glaald LIKE type_t.chr500, 
   glaald_desc LIKE type_t.chr80, 
   yy LIKE type_t.num5, 
   pp LIKE type_t.num5, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_success     LIKE type_t.num5

DEFINE g_sys_6001           LIKE ooab_t.ooab002                #系统参数[S-FIN-6001]:採用成本域否
DEFINE g_sys_6002           LIKE ooab_t.ooab002                #系统参数[S-FIN-6002]:成本域類型
DEFINE g_sys_6013           LIKE ooab_t.ooab002                #系统参数[S-FIN-6013]:按料件特性计算成本否  #170322-00109#1 add
DEFINE g_sys_6005           LIKE ooab_t.ooab002                #170414-00057#1 add
DEFINE g_round_type         LIKE ooaa_t.ooaa002                #金额舍入类型

DEFINE g_comp        LIKE xccc_t.xccccomp #法人
DEFINE g_ld          LIKE xccc_t.xcccld   #账别
DEFINE g_yy          LIKE xccc_t.xccc004  #成本年
DEFINE g_pp          LIKE xccc_t.xccc005  #成本期
DEFINE g_last_yy     LIKE xccc_t.xccc004  #成本年-上期
DEFINE g_last_pp     LIKE xccc_t.xccc005  #成本期-上期
DEFINE g_calc_type   LIKE xccc_t.xccc003  #glaa120成本计算类型
DEFINE g_bdate       LIKE glav_t.glav004  #年度+期別對應的起始截止日期
DEFINE g_edate       LIKE glav_t.glav004

DEFINE g_xcat001     LIKE xcat_t.xcat001  #成本计算类型
DEFINE g_glaa003     LIKE glaa_t.glaa003  #会计周期参照表号
DEFINE g_glaa026     LIKE glaa_t.glaa026  #币种参照表号

DEFINE g_glaa001     LIKE glaa_t.glaa001  #使用幣別
DEFINE g_glaa025     LIKE glaa_t.glaa025  #本位幣一 匯率採用
DEFINE g_ooaj006_1   LIKE ooaj_t.ooaj006  #本位幣一 成本單價小數位數
DEFINE g_ooaj007_1   LIKE ooaj_t.ooaj006  #本位幣一 成本金額小數位數

DEFINE g_glaa015     LIKE glaa_t.glaa015  #啟用本位幣二
DEFINE g_glaa016     LIKE glaa_t.glaa016  #本位幣二
DEFINE g_glaa017     LIKE glaa_t.glaa017  #本位幣二 汇种换算基准
DEFINE g_glaa018     LIKE glaa_t.glaa018  #本位幣二 匯率採用
DEFINE g_ooaj006_2   LIKE ooaj_t.ooaj006  #本位幣二 成本單價小數位數
DEFINE g_ooaj007_2   LIKE ooaj_t.ooaj006  #本位幣二 成本金額小數位數

DEFINE g_glaa019     LIKE glaa_t.glaa019  #啟用本位幣三
DEFINE g_glaa020     LIKE glaa_t.glaa020  #本位幣三
DEFINE g_glaa021     LIKE glaa_t.glaa021  #本位幣三 汇种换算基准
DEFINE g_glaa022     LIKE glaa_t.glaa022  #本位幣三 匯率採用
DEFINE g_ooaj006_3   LIKE ooaj_t.ooaj006  #本位幣三 成本單價小數位數
DEFINE g_ooaj007_3   LIKE ooaj_t.ooaj006  #本位幣三 成本金額小數位數

DEFINE g_wc_axm      STRING  #销售单据
DEFINE g_wc_ais      STRING  #发票
DEFINE g_flag        LIKE type_t.num5  #170217-00025#7 add 
DEFINE g_wc_comp     STRING            #170207-00034#1 add 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp200.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_axc_set_site_default()
      RETURNING g_comp,g_ld,g_yy,g_pp,g_calc_type 
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp200_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp200 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp200_init()
 
      #進入選單 Menu (="N")
      CALL axcp200_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp200
   END IF
 
   #add-point:作業離開前 name="main.exit"
   #170104-00054#1---add---s
   DROP TABLE convert_tmp;
   DROP TABLE xckb_tmp;
   DROP TABLE xckb2_tmp;
   #170104-00054#1---add---e
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp200.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp200_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp200_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_errno    LIKE gzze_t.gzze001
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   IF cl_null(g_master.glaald) THEN
      LET g_master.glaald = g_ld
   END IF
   IF cl_null(g_master.yy) OR g_master.yy = 0 THEN
      LET g_master.yy = g_yy
   END IF
   IF cl_null(g_master.pp) OR g_master.pp = 0 THEN
      LET g_master.pp = g_pp
   END IF
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glaald,g_master.yy,g_master.pp 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="input.a.glaald"
            IF NOT cl_null(g_master.glaald)  THEN
               CALL s_fin_ld_chk(g_master.glaald,g_user,'N')
                    RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = l_errno
                  LET g_errparam.extend = g_master.glaald
                  #160321-00016#41 s983961--add(s)
                  LET g_errparam.replace[1] ='agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog ='agli010'
                  #160321-00016#41 s983961--add(e)
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            CALL s_desc_get_ld_desc(g_master.glaald) RETURNING g_master.glaald_desc
            DISPLAY BY NAME g_master.glaald_desc
            CALL axcp200_default()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="input.b.glaald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaald
            #add-point:ON CHANGE glaald name="input.g.glaald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD yy
            #add-point:BEFORE FIELD yy name="input.b.yy"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD yy
            
            #add-point:AFTER FIELD yy name="input.a.yy"
            IF g_master.yy < 0 THEN
               NEXT FIELD CURRENT
            END IF
            IF g_master.yy > 9999 THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE yy
            #add-point:ON CHANGE yy name="input.g.yy"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pp
            #add-point:BEFORE FIELD pp name="input.b.pp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pp
            
            #add-point:AFTER FIELD pp name="input.a.pp"
            IF g_master.pp < 0 THEN
               NEXT FIELD CURRENT
            END IF
            IF g_master.pp > 99 THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pp
            #add-point:ON CHANGE pp name="input.g.pp"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="input.c.glaald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glaald
           #CALL q_glaald()      #170207-00034#1 mark
            #170207-00034#1 add --(S)--
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            #增加帳套過濾條件
            IF cl_null(g_wc_comp) THEN
               CALL s_axrt300_get_site(g_user,'','3') RETURNING g_wc_comp
               LET g_wc_comp = cl_replace_str(g_wc_comp,"ooef017","glaacomp")
            END IF
            IF NOT cl_null(g_wc_comp) THEN
               LET g_qryparam.where = g_wc_comp
            END IF            
            CALL q_authorised_ld()                                #呼叫開窗              
            #170207-00034#1 add --(E)--
            LET g_master.glaald = g_qryparam.return1     #將開窗取得的值>
            DISPLAY BY NAME g_master.glaald
            #170207-00034#1 add --(S)--
            CALL axcp200_default()          
            #170207-00034#1 add --(E)--
            NEXT FIELD glaald
            #END add-point
 
 
         #Ctrlp:input.c.yy
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD yy
            #add-point:ON ACTION controlp INFIELD yy name="input.c.yy"
            
            #END add-point
 
 
         #Ctrlp:input.c.pp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pp
            #add-point:ON ACTION controlp INFIELD pp name="input.c.pp"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmaa001,imaa001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa001
            #add-point:BEFORE FIELD pmaa001 name="construct.b.pmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa001
            
            #add-point:AFTER FIELD pmaa001 name="construct.a.pmaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa001
            #add-point:ON ACTION controlp INFIELD pmaa001 name="construct.c.pmaa001"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa001  #顯示到畫面上
            NEXT FIELD pmaa001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaa001_10()                    #呼叫開窗
           #DISPLAY g_qryparam.return1 TO pmaa001  #顯示到畫面上  #160706-00021#2 mark
           #NEXT FIELD pmaa001                     #返回原欄位    #160706-00021#2 mark  
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上  #160706-00021#2
            NEXT FIELD imaa001                     #返回原欄位    #160706-00021#2 
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL axcp200_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axcp200_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axcp200_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp200_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcp200.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp200_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axcp200.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp200_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp200_process_cs CURSOR FROM ls_sql
#  FOREACH axcp200_process_cs INTO
   #add-point:process段process name="process.process"
   #170220-00038#1 ---addd (s)---
   CALL axcp200_date_chk()
   IF NOT cl_null(g_errno) THEN
      LET g_errparam.extend = g_master.yy
      LET g_errparam.code   = g_errno
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF      
   #170220-00038#1 ---addd (s)---
   CALL axcp200_create_tmp()    #170104-00054#1
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
        
      
      CALL s_transaction_begin()
      CALL cl_err_collect_init()  #汇总错误讯息初始化
      LET g_flag = FALSE   #170217-00025#7 add
      
      #執行，生成發出商品資料（xckb_t,xckc_t）
      CALL axcp200_execute() RETURNING l_success
      
      CALL cl_err_collect_show() #显示错误讯息汇总
      
      IF l_success THEN
         CALL s_transaction_end('Y','0')  
      ELSE
         CALL s_transaction_end('N','0') 
      END IF
      
      #170217-00025#7 add-S
      IF g_flag = FALSE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN  
      END IF      
      #170217-00025#7 add-E
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp200_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp200.get_buffer" >}
PRIVATE FUNCTION axcp200_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glaald = p_dialog.getFieldBuffer('glaald')
   LET g_master.yy = p_dialog.getFieldBuffer('yy')
   LET g_master.pp = p_dialog.getFieldBuffer('pp')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp200.msgcentre_notify" >}
PRIVATE FUNCTION axcp200_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#執行，生成發出商品資料（xckb_t,xckc_t）
PRIVATE FUNCTION axcp200_execute()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sql      STRING
   
   LET r_success = TRUE
   
   #取"會計週期參照表號glaa003"，用于取年度+期別對應的起始截止日期
   #取币别glaa001,glaa016,glaa020
   LET g_glaa003=''
   SELECT glaacomp,glaa120,glaa003,glaa026,
          glaa001,glaa025,
          glaa015,glaa016,glaa017,glaa018,
          glaa019,glaa020,glaa021,glaa022
     INTO g_comp,g_xcat001,g_glaa003,g_glaa026,
          g_glaa001,g_glaa025,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,
          g_glaa019,g_glaa020,g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.glaald
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Select glaa003'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #g_comp判断与处理
   #判断参数 ，若参数 “发出商品不纳入成本计算” 则启动作业，否则不予启动。
   IF cl_get_para(g_enterprise,g_comp,'S-FIN-1003')!='4' THEN
      #参数未设置：发出商品不纳入成本计算，此作业不启动！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00731'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_sys_6001 = cl_get_para(g_enterprise,g_comp,'S-FIN-6001')   #系统参数[S-FIN-6001]:採用成本域否
   LET g_sys_6002 = cl_get_para(g_enterprise,g_comp,'S-FIN-6002')   #系统参数[S-FIN-6002]:成本域類型
   LET g_sys_6005 = cl_get_para(g_enterprise,g_comp,'S-FIN-6005')   #170414-00057#1 add
   
   IF g_sys_6001 = 'N' THEN
      LET g_sys_6002 = ''
   END IF
   LET g_sys_6013 = cl_get_para(g_enterprise,g_comp,'S-FIN-6013')   #系统参数[S-FIN-6013]:按料件特性计算成本否  #170322-00109#1 add
   LET g_round_type = cl_get_para(g_enterprise,'','E-COM-0006')  #取企业参数设置-金额舍入类型
   IF g_round_type NOT MATCHES '[1234]' OR cl_null(g_round_type) THEN
      #进位方式不正确
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00293'
      LET g_errparam.extend = g_round_type
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #币别小数位数设置
   SELECT ooaj006,ooaj007 INTO g_ooaj006_1,g_ooaj007_1 FROM ooaj_t
    WHERE ooajent = g_enterprise                           
      AND ooaj001 = g_glaa026                              
      AND ooaj002 = g_glaa001 
   SELECT ooaj006,ooaj007 INTO g_ooaj006_2,g_ooaj007_2 FROM ooaj_t
    WHERE ooajent = g_enterprise                           
      AND ooaj001 = g_glaa026                              
      AND ooaj002 = g_glaa016 
   SELECT ooaj006,ooaj007 INTO g_ooaj006_3,g_ooaj007_3 FROM ooaj_t
    WHERE ooajent = g_enterprise                           
      AND ooaj001 = g_glaa026                              
      AND ooaj002 = g_glaa020 
      
      
   CALL s_fin_date_get_period_range(g_glaa003,g_master.yy,g_master.pp)
       RETURNING g_bdate,g_edate

   #取上期的年度/期别
   CALL s_fin_date_get_last_period('',g_master.glaald,g_master.yy,g_master.pp)
        RETURNING l_success,g_last_yy,g_last_pp
   IF NOT l_success THEN
      RETURN r_success
   END IF

   #CALL s_transaction_begin() #170214-00060#1 add  #170104-00054#1 mark

   #根据条件，判断发出商品档是否已经存在对应资料。若已存在，则删除资料后重新统计。
   LET g_wc = g_master.wc
   LET g_wc= cl_replace_str(g_wc,"pmaa001","xckb009") #客戶
   LET g_wc= cl_replace_str(g_wc,"imaa001","xckb012") #產品編號
   LET l_sql = "DELETE FROM xckb_t ",
               " WHERE xckbent = ",g_enterprise,
               "   AND xckbcomp='",g_comp,"' ",
               "   AND xckbld  ='",g_master.glaald,"' ",
               "   AND xckb007 = ",g_master.yy,
               "   AND xckb008 = ",g_master.pp,
               "   AND ",g_wc CLIPPED
   PREPARE axcp200_execute_p1 FROM l_sql
   EXECUTE axcp200_execute_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xckb'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #170217-00025#7 add-S
   IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
   END IF
   #170217-00025#7 add-E
   
   #170220-00032#1---mark---s
   #LET g_wc = g_master.wc
   #LET g_wc = cl_replace_str(g_wc,"pmaa001","xckc003") #客戶
   #LET g_wc = cl_replace_str(g_wc,"imaa001","xckc004") #產品編號
   #LET l_sql = "DELETE FROM xckc_t ",
   #            " WHERE xckcent = ",g_enterprise,
   #            "   AND xckccomp='",g_comp,"' ",
   #            "   AND xckcld  ='",g_master.glaald,"' ",
   #            "   AND xckc001 = ",g_master.yy,
   #            "   AND xckc002 = ",g_master.pp,
   #            "   AND ",g_wc CLIPPED
   #PREPARE axcp200_execute_p2 FROM l_sql
   #EXECUTE axcp200_execute_p2
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'delete xckc'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #170220-00032#1---mark---e
   
   #170104-00054#1---add---s
   CALL axcp200_ins_xckb_new() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL axcp200_ins_xckb2_new() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
  
  #CALL s_transaction_begin() #170214-00060#1 mark
   
   #INSERT INTO xckb_t SELECT * FROM xckb_tmp   #170213-00024#1 mark
   #170213-00024#1---add---s
   INSERT INTO xckb_t(xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb004,xckb005,xckb006,xckb007,
                      xckb008,xckb009,xckb010,xckb011,xckb012,xckb013,xckb014,xckb015,xckb016,xckb017,
                      xckb018,xckb019,xckb020,xckb021,xckb022,xckb023,xckb024,xckb025,xckb026,xckb027,
                      xckb028,xckb029,xckb030,xckb031,xckb032,xckb033,xckb034,xckb035,xckb036,xckb037,
                      xckb101,xckb101a,xckb101b,xckb101c,xckb101d,xckb101e,xckb101f,xckb101g,xckb101h,
                      xckb102,xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,xckb102f,xckb102g,xckb102h,
                      xckb111,xckb111a,xckb111b,xckb111c,xckb111d,xckb111e,xckb111f,xckb111g,xckb111h,
                      xckb112,xckb112a,xckb112b,xckb112c,xckb112d,xckb112e,xckb112f,xckb112g,xckb112h,
                      xckb121,xckb121a,xckb121b,xckb121c,xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,
                      xckb122,xckb122a,xckb122b,xckb122c,xckb122d,xckb122e,xckb122f,xckb122g,xckb122h,
                      xckb038)
   SELECT xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb004,xckb005,xckb006,xckb007,
          xckb008,xckb009,xckb010,xckb011,xckb012,xckb013,xckb014,xckb015,xckb016,xckb017,
          xckb018,xckb019,xckb020,xckb021,xckb022,xckb023,xckb024,xckb025,xckb026,xckb027,
          xckb028,xckb029,xckb030,xckb031,xckb032,xckb033,xckb034,xckb035,xckb036,xckb037,
          xckb101,xckb101a,xckb101b,xckb101c,xckb101d,xckb101e,xckb101f,xckb101g,xckb101h,
          xckb102,xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,xckb102f,xckb102g,xckb102h,
          xckb111,xckb111a,xckb111b,xckb111c,xckb111d,xckb111e,xckb111f,xckb111g,xckb111h,
          xckb112,xckb112a,xckb112b,xckb112c,xckb112d,xckb112e,xckb112f,xckb112g,xckb112h,
          xckb121,xckb121a,xckb121b,xckb121c,xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,
          xckb122,xckb122a,xckb122b,xckb122c,xckb122d,xckb122e,xckb122f,xckb122g,xckb122h,
          xckb038
   FROM xckb_tmp       
   #170213-00024#1---add---e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INS xckb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #CALL s_transaction_end('N','0')   #170104-00054#1 mark
      RETURN r_success
   END IF
   #170217-00025#7 add-S
   IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
   END IF
   #170217-00025#7 add-E
   #INSERT INTO xckb_t SELECT * FROM xckb2_tmp   #170213-00024#1 mark
   #170213-00024#1---add---s
   INSERT INTO xckb_t(xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb004,xckb005,xckb006,xckb007,
                      xckb008,xckb009,xckb010,xckb011,xckb012,xckb013,xckb014,xckb015,xckb016,xckb017,
                      xckb018,xckb019,xckb020,xckb021,xckb022,xckb023,xckb024,xckb025,xckb026,xckb027,
                      xckb028,xckb029,xckb030,xckb031,xckb032,xckb033,xckb034,xckb035,xckb036,xckb037,
                      xckb101,xckb101a,xckb101b,xckb101c,xckb101d,xckb101e,xckb101f,xckb101g,xckb101h,
                      xckb102,xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,xckb102f,xckb102g,xckb102h,
                      xckb111,xckb111a,xckb111b,xckb111c,xckb111d,xckb111e,xckb111f,xckb111g,xckb111h,
                      xckb112,xckb112a,xckb112b,xckb112c,xckb112d,xckb112e,xckb112f,xckb112g,xckb112h,
                      xckb121,xckb121a,xckb121b,xckb121c,xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,
                      xckb122,xckb122a,xckb122b,xckb122c,xckb122d,xckb122e,xckb122f,xckb122g,xckb122h,
                      xckb038)
   SELECT xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb004,xckb005,xckb006,xckb007,
          xckb008,xckb009,xckb010,xckb011,xckb012,xckb013,xckb014,xckb015,xckb016,xckb017,
          xckb018,xckb019,xckb020,xckb021,xckb022,xckb023,xckb024,xckb025,xckb026,xckb027,
          xckb028,xckb029,xckb030,xckb031,xckb032,xckb033,xckb034,xckb035,xckb036,xckb037,
          xckb101,xckb101a,xckb101b,xckb101c,xckb101d,xckb101e,xckb101f,xckb101g,xckb101h,
          xckb102,xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,xckb102f,xckb102g,xckb102h,
          xckb111,xckb111a,xckb111b,xckb111c,xckb111d,xckb111e,xckb111f,xckb111g,xckb111h,
          xckb112,xckb112a,xckb112b,xckb112c,xckb112d,xckb112e,xckb112f,xckb112g,xckb112h,
          xckb121,xckb121a,xckb121b,xckb121c,xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,
          xckb122,xckb122a,xckb122b,xckb122c,xckb122d,xckb122e,xckb122f,xckb122g,xckb122h,
          xckb038
   FROM xckb2_tmp    
   #170213-00024#1---add---e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INS xckb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #CALL s_transaction_end('N','0')  ##170104-00054#1 mark
      RETURN r_success
   END IF   
   #170104-00054#1---add---e
   
   #170217-00025#7 add-S
   IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
   END IF
   #170217-00025#7 add-E
   
   #170213-00024#1---mark---s
   ##170104-00054#1---mark---s
   ##发出商品统计档--用于做分录
   ##获取明细资料，统计出当月的xckb发出商品的月底统计资料
   #CALL axcp200_execute_ins_xckb()
   #   RETURNING l_success
   #IF NOT l_success THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   ##170104-00054#1---mark---e
   #170213-00024#1---mark---e

   #170306-00022#1 add --(S)--
   ## 小數尾差處理: 當一同出貨單項次拆成二筆項序出貨，出貨單上的總金額是二筆出貨各自數量*單價後的加總
   ## 但這樣在收款時的計算，是用總數量*單價，數量可能相同，但因為單據小數位關係，金額會有尾差
   ## 所以當該出貨單的數量已全數收款，但金額沖銷後有的尾差，要放到這次收款的總金額中
   CALL axcp200_upd_xckb() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #170306-00022#1 add --(E)--

   #发出商品汇总统计档——用于汇总查询发出商品金额
   #根据月度统计资料，汇总获得xckc发出商品当月的汇总统计档。
   #170220-00032#1---mod---s
   #CALL axcp200_execute_ins_xckc()
   #   RETURNING l_success
   CALL s_axcp200_ins_xckc(g_master.wc,g_comp,g_master.glaald,g_master.yy,g_master.pp)
      RETURNING l_success   
   #170220-00032#1---mod---s
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

#发出商品统计档--用于做分录
#获取明细资料，统计出当月的xckb发出商品的月底统计资料
PRIVATE FUNCTION axcp200_execute_ins_xckb()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sql      STRING
#   DEFINE l_xckb     RECORD LIKE xckb_t.*  #161124-00048#12 mark
  #161124-00048#12 add(s)
  DEFINE l_xckb RECORD  #發出商品統計檔
       xckbent LIKE xckb_t.xckbent, #企业编号
       xckbcomp LIKE xckb_t.xckbcomp, #法人
       xckbld LIKE xckb_t.xckbld, #账套
       xckb001 LIKE xckb_t.xckb001, #来源
       xckb002 LIKE xckb_t.xckb002, #方向
       xckb003 LIKE xckb_t.xckb003, #发票号码
       xckb004 LIKE xckb_t.xckb004, #据点site
       xckb005 LIKE xckb_t.xckb005, #出货单号
       xckb006 LIKE xckb_t.xckb006, #出货项次
       xckb007 LIKE xckb_t.xckb007, #年度
       xckb008 LIKE xckb_t.xckb008, #期别
       xckb009 LIKE xckb_t.xckb009, #客户编号
       xckb010 LIKE xckb_t.xckb010, #人员编号
       xckb011 LIKE xckb_t.xckb011, #部门编号
       xckb012 LIKE xckb_t.xckb012, #产品编号
       xckb013 LIKE xckb_t.xckb013, #销售单位
       xckb014 LIKE xckb_t.xckb014, #数量
       xckb015 LIKE xckb_t.xckb015, #仓库编号
       xckb016 LIKE xckb_t.xckb016, #库位编号
       xckb017 LIKE xckb_t.xckb017, #批号
       xckb018 LIKE xckb_t.xckb018, #no use
       xckb019 LIKE xckb_t.xckb019, #发票编号
       xckb020 LIKE xckb_t.xckb020, #库存单位
       xckb021 LIKE xckb_t.xckb021, #库存数量
       xckb022 LIKE xckb_t.xckb022, #科目编号
       xckb023 LIKE xckb_t.xckb023, #多角贸易否
       xckb024 LIKE xckb_t.xckb024, #开票年度
       xckb025 LIKE xckb_t.xckb025, #开票期别
       xckb026 LIKE xckb_t.xckb026, #币种一
       xckb027 LIKE xckb_t.xckb027, #金额
       xckb028 LIKE xckb_t.xckb028, #币种二
       xckb029 LIKE xckb_t.xckb029, #金额
       xckb030 LIKE xckb_t.xckb030, #币种三
       xckb031 LIKE xckb_t.xckb031, #金额
       xckb032 LIKE xckb_t.xckb032, #no use
       xckb033 LIKE xckb_t.xckb033, #no use
       xckb034 LIKE xckb_t.xckb034, #no use
       xckb035 LIKE xckb_t.xckb035, #no use
       xckb036 LIKE xckb_t.xckb036, #项序
       xckb037 LIKE xckb_t.xckb037, #特性
       xckb101 LIKE xckb_t.xckb101, #币种一成本单价
       xckb101a LIKE xckb_t.xckb101a, #币种一成本单价-材料
       xckb101b LIKE xckb_t.xckb101b, #币种一成本单价-人工
       xckb101c LIKE xckb_t.xckb101c, #币种一成本单价-加工
       xckb101d LIKE xckb_t.xckb101d, #币种一成本单价-制费一
       xckb101e LIKE xckb_t.xckb101e, #币种一成本单价-制费二
       xckb101f LIKE xckb_t.xckb101f, #币种一成本单价-制费三
       xckb101g LIKE xckb_t.xckb101g, #币种一成本单价-制费四
       xckb101h LIKE xckb_t.xckb101h, #币种一成本单价-制费五
       xckb102 LIKE xckb_t.xckb102, #币种一成本金额
       xckb102a LIKE xckb_t.xckb102a, #币种一成本金额-材料
       xckb102b LIKE xckb_t.xckb102b, #币种一成本金额-人工
       xckb102c LIKE xckb_t.xckb102c, #币种一成本金额-加工
       xckb102d LIKE xckb_t.xckb102d, #币种一成本金额-制费一
       xckb102e LIKE xckb_t.xckb102e, #币种一成本金额-制费二
       xckb102f LIKE xckb_t.xckb102f, #币种一成本金额-制费三
       xckb102g LIKE xckb_t.xckb102g, #币种一成本金额-制费四
       xckb102h LIKE xckb_t.xckb102h, #币种一成本金额-制费五
       xckb111 LIKE xckb_t.xckb111, #币种二成本单价
       xckb111a LIKE xckb_t.xckb111a, #币种二成本单价-材料
       xckb111b LIKE xckb_t.xckb111b, #币种二成本单价-人工
       xckb111c LIKE xckb_t.xckb111c, #币种二成本单价-加工
       xckb111d LIKE xckb_t.xckb111d, #币种二成本单价-制费一
       xckb111e LIKE xckb_t.xckb111e, #币种二成本单价-制费二
       xckb111f LIKE xckb_t.xckb111f, #币种二成本单价-制费三
       xckb111g LIKE xckb_t.xckb111g, #币种二成本单价-制费四
       xckb111h LIKE xckb_t.xckb111h, #币种二成本单价-制费五
       xckb112 LIKE xckb_t.xckb112, #币种二成本金额
       xckb112a LIKE xckb_t.xckb112a, #币种二成本金额-材料
       xckb112b LIKE xckb_t.xckb112b, #币种二成本金额-人工
       xckb112c LIKE xckb_t.xckb112c, #币种二成本金额-加工
       xckb112d LIKE xckb_t.xckb112d, #币种二成本金额-制费一
       xckb112e LIKE xckb_t.xckb112e, #币种二成本金额-制费二
       xckb112f LIKE xckb_t.xckb112f, #币种二成本金额-制费三
       xckb112g LIKE xckb_t.xckb112g, #币种二成本金额-制费四
       xckb112h LIKE xckb_t.xckb112h, #币种二成本金额-制费五
       xckb121 LIKE xckb_t.xckb121, #币种三成本单价
       xckb121a LIKE xckb_t.xckb121a, #币种三成本单价-材料
       xckb121b LIKE xckb_t.xckb121b, #币种三成本单价-人工
       xckb121c LIKE xckb_t.xckb121c, #币种三成本单价-加工
       xckb121d LIKE xckb_t.xckb121d, #币种三成本单价-制费一
       xckb121e LIKE xckb_t.xckb121e, #币种三成本单价-制费二
       xckb121f LIKE xckb_t.xckb121f, #币种三成本单价-制费三
       xckb121g LIKE xckb_t.xckb121g, #币种三成本单价-制费四
       xckb121h LIKE xckb_t.xckb121h, #币种三成本单价-制费五
       xckb122 LIKE xckb_t.xckb122, #币种三成本金额
       xckb122a LIKE xckb_t.xckb122a, #币种三成本金额-材料
       xckb122b LIKE xckb_t.xckb122b, #币种三成本金额-人工
       xckb122c LIKE xckb_t.xckb122c, #币种三成本金额-加工
       xckb122d LIKE xckb_t.xckb122d, #币种三成本金额-制费一
       xckb122e LIKE xckb_t.xckb122e, #种三成本金额-制费二
       xckb122f LIKE xckb_t.xckb122f, #币种三成本金额-制费三
       xckb122g LIKE xckb_t.xckb122g, #币种三成本金额-制费四
       xckb122h LIKE xckb_t.xckb122h, #币种三成本金额-制费五
       xckb038 LIKE xckb_t.xckb038  #成本域
END RECORD
  #161124-00048#12 add(e)
#   DEFINE l_xmdk     RECORD LIKE xmdk_t.*  #出货/签收/销退单单头档 #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_xmdk RECORD  #出貨/簽收/銷退單單頭檔
       xmdkent LIKE xmdk_t.xmdkent, #企业编号
       xmdksite LIKE xmdk_t.xmdksite, #营运据点
       xmdkunit LIKE xmdk_t.xmdkunit, #应用组织
       xmdkdocno LIKE xmdk_t.xmdkdocno, #单据单号
       xmdkdocdt LIKE xmdk_t.xmdkdocdt, #单据日期
       xmdk000 LIKE xmdk_t.xmdk000, #单据性质
       xmdk001 LIKE xmdk_t.xmdk001, #扣账日期
       xmdk002 LIKE xmdk_t.xmdk002, #出货性质
       xmdk003 LIKE xmdk_t.xmdk003, #业务人员
       xmdk004 LIKE xmdk_t.xmdk004, #业务部门
       xmdk005 LIKE xmdk_t.xmdk005, #出通/出货单号
       xmdk006 LIKE xmdk_t.xmdk006, #订单单号
       xmdk007 LIKE xmdk_t.xmdk007, #订单客户
       xmdk008 LIKE xmdk_t.xmdk008, #收款客户
       xmdk009 LIKE xmdk_t.xmdk009, #收货客户
       xmdk010 LIKE xmdk_t.xmdk010, #收款条件
       xmdk011 LIKE xmdk_t.xmdk011, #交易条件
       xmdk012 LIKE xmdk_t.xmdk012, #税种
       xmdk013 LIKE xmdk_t.xmdk013, #税率
       xmdk014 LIKE xmdk_t.xmdk014, #单价含税否
       xmdk015 LIKE xmdk_t.xmdk015, #发票类型
       xmdk016 LIKE xmdk_t.xmdk016, #币种
       xmdk017 LIKE xmdk_t.xmdk017, #汇率
       xmdk018 LIKE xmdk_t.xmdk018, #取价方式
       xmdk019 LIKE xmdk_t.xmdk019, #优惠条件
       xmdk020 LIKE xmdk_t.xmdk020, #送货供应商
       xmdk021 LIKE xmdk_t.xmdk021, #送货地址
       xmdk022 LIKE xmdk_t.xmdk022, #运输方式
       xmdk023 LIKE xmdk_t.xmdk023, #交运起点
       xmdk024 LIKE xmdk_t.xmdk024, #交运终点
       xmdk025 LIKE xmdk_t.xmdk025, #航次/航班/车号
       xmdk026 LIKE xmdk_t.xmdk026, #起运日期
       xmdk027 LIKE xmdk_t.xmdk027, #唛头编号
       xmdk028 LIKE xmdk_t.xmdk028, #包装单制作
       xmdk029 LIKE xmdk_t.xmdk029, #Invoice制作
       xmdk030 LIKE xmdk_t.xmdk030, #销售渠道
       xmdk031 LIKE xmdk_t.xmdk031, #销售分类
       xmdk032 LIKE xmdk_t.xmdk032, #结关日期
       xmdk033 LIKE xmdk_t.xmdk033, #额外品名规格
       xmdk034 LIKE xmdk_t.xmdk034, #留置原因
       xmdk035 LIKE xmdk_t.xmdk035, #多角序号
       xmdk036 LIKE xmdk_t.xmdk036, #集成单号
       xmdk037 LIKE xmdk_t.xmdk037, #发票号码
       xmdk038 LIKE xmdk_t.xmdk038, #运输状态
       xmdk039 LIKE xmdk_t.xmdk039, #在途成本库位
       xmdk040 LIKE xmdk_t.xmdk040, #在途非成本库位
       xmdk041 LIKE xmdk_t.xmdk041, #发票编号
       xmdk042 LIKE xmdk_t.xmdk042, #内外销
       xmdk043 LIKE xmdk_t.xmdk043, #汇率计算基准
       xmdk044 LIKE xmdk_t.xmdk044, #多角流程编号
       xmdk045 LIKE xmdk_t.xmdk045, #多角性质
       xmdk051 LIKE xmdk_t.xmdk051, #总税前金额
       xmdk052 LIKE xmdk_t.xmdk052, #总含税金额
       xmdk053 LIKE xmdk_t.xmdk053, #总税额
       xmdk054 LIKE xmdk_t.xmdk054, #备注
       xmdk055 LIKE xmdk_t.xmdk055, #客户收货日
       xmdk081 LIKE xmdk_t.xmdk081, #对应的签收单号
       xmdk082 LIKE xmdk_t.xmdk082, #销退方式
       xmdk083 LIKE xmdk_t.xmdk083, #多角贸易已抛转
       xmdk084 LIKE xmdk_t.xmdk084, #折让证明单开立否
       xmdk200 LIKE xmdk_t.xmdk200, #调货经销商编号
       xmdk201 LIKE xmdk_t.xmdk201, #代送商编号
       xmdk202 LIKE xmdk_t.xmdk202, #发票客户
       xmdk203 LIKE xmdk_t.xmdk203, #促销方案编号
       xmdk204 LIKE xmdk_t.xmdk204, #整单折扣
       xmdk205 LIKE xmdk_t.xmdk205, #送货站点编号
       xmdk206 LIKE xmdk_t.xmdk206, #运输路线编号
       xmdk207 LIKE xmdk_t.xmdk207, #销售组织
       xmdk208 LIKE xmdk_t.xmdk208, #调货出货单号
       xmdk209 LIKE xmdk_t.xmdk209, #No Use
       xmdk210 LIKE xmdk_t.xmdk210, #No Use
       xmdk211 LIKE xmdk_t.xmdk211, #No Use
       xmdk212 LIKE xmdk_t.xmdk212, #No Use
       xmdk213 LIKE xmdk_t.xmdk213, #本币含税总金额
       xmdk214 LIKE xmdk_t.xmdk214, #收款完成否
       xmdkownid LIKE xmdk_t.xmdkownid, #资料所有者
       xmdkowndp LIKE xmdk_t.xmdkowndp, #资料所有部门
       xmdkcrtid LIKE xmdk_t.xmdkcrtid, #资料录入者
       xmdkcrtdp LIKE xmdk_t.xmdkcrtdp, #资料录入部门
       xmdkcrtdt LIKE xmdk_t.xmdkcrtdt, #资料创建日
       xmdkmodid LIKE xmdk_t.xmdkmodid, #资料更改者
       xmdkmoddt LIKE xmdk_t.xmdkmoddt, #最近更改日
       xmdkcnfid LIKE xmdk_t.xmdkcnfid, #资料审核者
       xmdkcnfdt LIKE xmdk_t.xmdkcnfdt, #数据审核日
       xmdkpstid LIKE xmdk_t.xmdkpstid, #资料过账者
       xmdkpstdt LIKE xmdk_t.xmdkpstdt, #资料过账日
       xmdkstus LIKE xmdk_t.xmdkstus, #状态码
       xmdk085 LIKE xmdk_t.xmdk085, #数据源(销退)
       xmdk086 LIKE xmdk_t.xmdk086, #来源单号(销退)
       xmdk046 LIKE xmdk_t.xmdk046, #集成来源
       xmdk087 LIKE xmdk_t.xmdk087, #出货走发票仓调拨
       xmdk047 LIKE xmdk_t.xmdk047, #一次性交易对象识别码
       xmdk088 LIKE xmdk_t.xmdk088, #来源类型
       xmdk089 LIKE xmdk_t.xmdk089  #来源单号
#       xmdk048 LIKE xmdk_t.xmdk048, #进口报单
#       xmdk049 LIKE xmdk_t.xmdk049, #进口日期
#       xmdk050 LIKE xmdk_t.xmdk050  #保税异动原因编号
END RECORD
   #161124-00048#12 add(e)
#   DEFINE l_xmdl     RECORD LIKE xmdl_t.*  #出货/签收/销退单单身明细档  #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_xmdl RECORD  #出貨/簽收/銷退單單身明細檔
       xmdlent LIKE xmdl_t.xmdlent, #企业编号
       xmdlsite LIKE xmdl_t.xmdlsite, #营运据点
       xmdldocno LIKE xmdl_t.xmdldocno, #单据编号
       xmdlseq LIKE xmdl_t.xmdlseq, #项次
       xmdl001 LIKE xmdl_t.xmdl001, #出通单号
       xmdl002 LIKE xmdl_t.xmdl002, #出通项次
       xmdl003 LIKE xmdl_t.xmdl003, #订单单号
       xmdl004 LIKE xmdl_t.xmdl004, #订单项次
       xmdl005 LIKE xmdl_t.xmdl005, #订单项序
       xmdl006 LIKE xmdl_t.xmdl006, #订单分批序
       xmdl007 LIKE xmdl_t.xmdl007, #子件特性
       xmdl008 LIKE xmdl_t.xmdl008, #料件编号
       xmdl009 LIKE xmdl_t.xmdl009, #产品特征
       xmdl010 LIKE xmdl_t.xmdl010, #包装容器
       xmdl011 LIKE xmdl_t.xmdl011, #作业编号
       xmdl012 LIKE xmdl_t.xmdl012, #作业序
       xmdl013 LIKE xmdl_t.xmdl013, #多库储批出货
       xmdl014 LIKE xmdl_t.xmdl014, #库位
       xmdl015 LIKE xmdl_t.xmdl015, #储位
       xmdl016 LIKE xmdl_t.xmdl016, #批号
       xmdl017 LIKE xmdl_t.xmdl017, #出货单位
       xmdl018 LIKE xmdl_t.xmdl018, #数量
       xmdl019 LIKE xmdl_t.xmdl019, #参考单位
       xmdl020 LIKE xmdl_t.xmdl020, #参考数量
       xmdl021 LIKE xmdl_t.xmdl021, #计价单位
       xmdl022 LIKE xmdl_t.xmdl022, #计价数量
       xmdl023 LIKE xmdl_t.xmdl023, #检验否
       xmdl024 LIKE xmdl_t.xmdl024, #单价
       xmdl025 LIKE xmdl_t.xmdl025, #税种
       xmdl026 LIKE xmdl_t.xmdl026, #税率
       xmdl027 LIKE xmdl_t.xmdl027, #税前金额
       xmdl028 LIKE xmdl_t.xmdl028, #含税金额
       xmdl029 LIKE xmdl_t.xmdl029, #税额
       xmdl030 LIKE xmdl_t.xmdl030, #项目编号
       xmdl031 LIKE xmdl_t.xmdl031, #WBS编号
       xmdl032 LIKE xmdl_t.xmdl032, #活动编号
       xmdl033 LIKE xmdl_t.xmdl033, #客户料号
       xmdl034 LIKE xmdl_t.xmdl034, #QPA
       xmdl035 LIKE xmdl_t.xmdl035, #已签收量
       xmdl036 LIKE xmdl_t.xmdl036, #已签退量
       xmdl037 LIKE xmdl_t.xmdl037, #已销退量
       xmdl038 LIKE xmdl_t.xmdl038, #主账套已立账数量
       xmdl039 LIKE xmdl_t.xmdl039, #账套二已立账数量
       xmdl040 LIKE xmdl_t.xmdl040, #账套三已立账数量
       xmdl041 LIKE xmdl_t.xmdl041, #保税否
       xmdl042 LIKE xmdl_t.xmdl042, #取价来源
       xmdl043 LIKE xmdl_t.xmdl043, #价格来源参考单号
       xmdl044 LIKE xmdl_t.xmdl044, #价格来源参考项次
       xmdl045 LIKE xmdl_t.xmdl045, #取出价格
       xmdl046 LIKE xmdl_t.xmdl046, #价差比
       xmdl047 LIKE xmdl_t.xmdl047, #已开发票数量
       xmdl048 LIKE xmdl_t.xmdl048, #发票编号
       xmdl049 LIKE xmdl_t.xmdl049, #发票号码
       xmdl050 LIKE xmdl_t.xmdl050, #理由码
       xmdl051 LIKE xmdl_t.xmdl051, #备注
       xmdl052 LIKE xmdl_t.xmdl052, #库存管理特征
       xmdl053 LIKE xmdl_t.xmdl053, #主账套暂估数量
       xmdl054 LIKE xmdl_t.xmdl054, #账套二暂估数量
       xmdl055 LIKE xmdl_t.xmdl055, #账套三暂估数量
       xmdl081 LIKE xmdl_t.xmdl081, #签退数量(签收、签退单使用)
       xmdl082 LIKE xmdl_t.xmdl082, #签退参考数量(签收、签退单使用)
       xmdl083 LIKE xmdl_t.xmdl083, #签退计价数量(签收、签退单使用)
       xmdl084 LIKE xmdl_t.xmdl084, #签退理由码(签收、签退单使用)
       xmdl085 LIKE xmdl_t.xmdl085, #订单开立据点
       xmdl086 LIKE xmdl_t.xmdl086, #订单多角性质
       xmdl087 LIKE xmdl_t.xmdl087, #需自立应收否
       xmdl088 LIKE xmdl_t.xmdl088, #多角流程编号
       xmdl089 LIKE xmdl_t.xmdl089, #QC单号
       xmdl090 LIKE xmdl_t.xmdl090, #判定项次
       xmdl091 LIKE xmdl_t.xmdl091, #判定结果
       xmdl092 LIKE xmdl_t.xmdl092, #借货还量数量
       xmdl093 LIKE xmdl_t.xmdl093, #借货还量参考数量
       xmdl200 LIKE xmdl_t.xmdl200, #销售渠道
       xmdl201 LIKE xmdl_t.xmdl201, #产品组编码
       xmdl202 LIKE xmdl_t.xmdl202, #销售范围编码
       xmdl203 LIKE xmdl_t.xmdl203, #销售办公室
       xmdl204 LIKE xmdl_t.xmdl204, #出货包装单位
       xmdl205 LIKE xmdl_t.xmdl205, #出货包装数量
       xmdl206 LIKE xmdl_t.xmdl206, #签退包装数量
       xmdl207 LIKE xmdl_t.xmdl207, #库存锁定等级
       xmdl208 LIKE xmdl_t.xmdl208, #标准价
       xmdl209 LIKE xmdl_t.xmdl209, #促销价
       xmdl210 LIKE xmdl_t.xmdl210, #交易价
       xmdl211 LIKE xmdl_t.xmdl211, #折价金额
       xmdl212 LIKE xmdl_t.xmdl212, #销售组织
       xmdl213 LIKE xmdl_t.xmdl213, #销售人员
       xmdl214 LIKE xmdl_t.xmdl214, #销售部门
       xmdl215 LIKE xmdl_t.xmdl215, #合同编号
       xmdl216 LIKE xmdl_t.xmdl216, #经营方式
       xmdl217 LIKE xmdl_t.xmdl217, #结算类型
       xmdl218 LIKE xmdl_t.xmdl218, #结算方式
       xmdl219 LIKE xmdl_t.xmdl219, #交易类型
       xmdl220 LIKE xmdl_t.xmdl220, #寄销已核销数量
       xmdl222 LIKE xmdl_t.xmdl222, #地区编号
       xmdl223 LIKE xmdl_t.xmdl223, #县市编号
       xmdl224 LIKE xmdl_t.xmdl224, #省区编号
       xmdl225 LIKE xmdl_t.xmdl225, #区域编号
       xmdl226 LIKE xmdl_t.xmdl226, #商品条码
       xmdlunit LIKE xmdl_t.xmdlunit, #应用组织
       xmdlorga LIKE xmdl_t.xmdlorga, #账务组织
       xmdl056 LIKE xmdl_t.xmdl056, #检验合格量
       xmdl094 LIKE xmdl_t.xmdl094, #来源单号(销退)
       xmdl095 LIKE xmdl_t.xmdl095, #项次(销退)
       xmdl227 LIKE xmdl_t.xmdl227, #现金折扣单号
       xmdl228 LIKE xmdl_t.xmdl228, #现金折扣单项次
       xmdl057 LIKE xmdl_t.xmdl057, #有效日期
       xmdl058 LIKE xmdl_t.xmdl058, #制造日期
       xmdl096 LIKE xmdl_t.xmdl096, #来源项次
       xmdl059 LIKE xmdl_t.xmdl059, #客户退货量
       xmdl060 LIKE xmdl_t.xmdl060  #放行状态
END RECORD
   #161124-00048#12 add(e)
#   DEFINE l_xmdm     RECORD LIKE xmdm_t.*  #出货/签收/销退单多库储批出货明细档 #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_xmdm RECORD  #出貨/簽收/銷退單多庫儲批出貨明細檔
       xmdment LIKE xmdm_t.xmdment, #企业编号
       xmdmsite LIKE xmdm_t.xmdmsite, #营运据点
       xmdmdocno LIKE xmdm_t.xmdmdocno, #出货单号
       xmdmseq LIKE xmdm_t.xmdmseq, #项次
       xmdmseq1 LIKE xmdm_t.xmdmseq1, #项序
       xmdm001 LIKE xmdm_t.xmdm001, #料件编号
       xmdm002 LIKE xmdm_t.xmdm002, #产品特征
       xmdm003 LIKE xmdm_t.xmdm003, #作业编号
       xmdm004 LIKE xmdm_t.xmdm004, #作业序
       xmdm005 LIKE xmdm_t.xmdm005, #限定库位
       xmdm006 LIKE xmdm_t.xmdm006, #限定储位
       xmdm007 LIKE xmdm_t.xmdm007, #限定批号
       xmdm008 LIKE xmdm_t.xmdm008, #单位
       xmdm009 LIKE xmdm_t.xmdm009, #出货数量
       xmdm010 LIKE xmdm_t.xmdm010, #参考单位
       xmdm011 LIKE xmdm_t.xmdm011, #参考数量
       xmdm012 LIKE xmdm_t.xmdm012, #已签收数量
       xmdm013 LIKE xmdm_t.xmdm013, #已签退数量
       xmdm014 LIKE xmdm_t.xmdm014, #已销退数量
       xmdm031 LIKE xmdm_t.xmdm031, #签退数量
       xmdm032 LIKE xmdm_t.xmdm032, #签退参考数量
       xmdm033 LIKE xmdm_t.xmdm033, #库存管理特征
       xmdm034 LIKE xmdm_t.xmdm034, #备置量
       xmdm035 LIKE xmdm_t.xmdm035  #在拣量
END RECORD
   #161124-00048#12 add(e)
#   DEFINE l_isaf     RECORD LIKE isaf_t.* #161124-00048#12 mark
#   DEFINE l_isag     RECORD LIKE isag_t.* #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_isaf RECORD  #銷項發票主檔
       isafent LIKE isaf_t.isafent, #企业编码
       isafsite LIKE isaf_t.isafsite, #账务组织
       isafcomp LIKE isaf_t.isafcomp, #法人
       isafdocno LIKE isaf_t.isafdocno, #开票单号
       isafdocdt LIKE isaf_t.isafdocdt, #录入日期
       isaf001 LIKE isaf_t.isaf001, #发票来源
       isaf002 LIKE isaf_t.isaf002, #发票客户
       isaf003 LIKE isaf_t.isaf003, #账款客户
       isaf004 LIKE isaf_t.isaf004, #业务组织
       isaf005 LIKE isaf_t.isaf005, #开票人员
       isaf006 LIKE isaf_t.isaf006, #开票部门
       isaf007 LIKE isaf_t.isaf007, #扣账日期
       isaf008 LIKE isaf_t.isaf008, #发票类型
       isaf009 LIKE isaf_t.isaf009, #电子发票否
       isaf010 LIKE isaf_t.isaf010, #发票编号
       isaf011 LIKE isaf_t.isaf011, #发票号码
       isaf012 LIKE isaf_t.isaf012, #发票检查码
       isaf013 LIKE isaf_t.isaf013, #发票防伪随机码
       isaf014 LIKE isaf_t.isaf014, #发票日期
       isaf015 LIKE isaf_t.isaf015, #发票时间
       isaf016 LIKE isaf_t.isaf016, #税种
       isaf017 LIKE isaf_t.isaf017, #含税否
       isaf018 LIKE isaf_t.isaf018, #税率
       isaf019 LIKE isaf_t.isaf019, #申报格式
       isaf020 LIKE isaf_t.isaf020, #发票号码迄号
       isaf021 LIKE isaf_t.isaf021, #购货方名称
       isaf022 LIKE isaf_t.isaf022, #购货方税务编号
       isaf023 LIKE isaf_t.isaf023, #购货方地址
       isaf024 LIKE isaf_t.isaf024, #购货方电话
       isaf025 LIKE isaf_t.isaf025, #购货方开户银行
       isaf026 LIKE isaf_t.isaf026, #购货方账户编码
       isaf027 LIKE isaf_t.isaf027, #销货方名称
       isaf028 LIKE isaf_t.isaf028, #销方税务编号
       isaf029 LIKE isaf_t.isaf029, #销货方地址
       isaf030 LIKE isaf_t.isaf030, #销货方电话
       isaf031 LIKE isaf_t.isaf031, #销货方开户银行
       isaf032 LIKE isaf_t.isaf032, #销货方帐号
       isaf033 LIKE isaf_t.isaf033, #POS机号
       isaf034 LIKE isaf_t.isaf034, #POS单号
       isaf035 LIKE isaf_t.isaf035, #应收单号
       isaf036 LIKE isaf_t.isaf036, #发票异动状态
       isaf037 LIKE isaf_t.isaf037, #异动理由码
       isaf038 LIKE isaf_t.isaf038, #异动备注
       isaf039 LIKE isaf_t.isaf039, #异动日期
       isaf040 LIKE isaf_t.isaf040, #异动时间
       isaf041 LIKE isaf_t.isaf041, #异动人员
       isaf042 LIKE isaf_t.isaf042, #项目作废核准文号
       isaf043 LIKE isaf_t.isaf043, #通关方式注记
       isaf044 LIKE isaf_t.isaf044, #打印次数
       isaf045 LIKE isaf_t.isaf045, #支付工具卡号1
       isaf046 LIKE isaf_t.isaf046, #支付工具卡号2
       isaf047 LIKE isaf_t.isaf047, #支付工具卡号3
       isaf048 LIKE isaf_t.isaf048, #辅助账二应收单号
       isaf049 LIKE isaf_t.isaf049, #辅助账三应收单号
       isaf050 LIKE isaf_t.isaf050, #生成方式
       isaf051 LIKE isaf_t.isaf051, #发票簿号
       isaf052 LIKE isaf_t.isaf052, #发票簿号对应的营运据点
       isaf053 LIKE isaf_t.isaf053, #发票联数
       isaf054 LIKE isaf_t.isaf054, #课税种
       isaf055 LIKE isaf_t.isaf055, #收款客户
       isaf056 LIKE isaf_t.isaf056, #发票性质
       isaf057 LIKE isaf_t.isaf057, #业务人员
       isaf058 LIKE isaf_t.isaf058, #收款条件
       isaf100 LIKE isaf_t.isaf100, #币种
       isaf101 LIKE isaf_t.isaf101, #汇率
       isaf103 LIKE isaf_t.isaf103, #发票原币税前金额
       isaf104 LIKE isaf_t.isaf104, #发票原币税额
       isaf105 LIKE isaf_t.isaf105, #发票原币含税金额
       isaf106 LIKE isaf_t.isaf106, #发票原币留抵税额
       isaf107 LIKE isaf_t.isaf107, #发票原币已折金额
       isaf108 LIKE isaf_t.isaf108, #发票原币已折税额
       isaf113 LIKE isaf_t.isaf113, #发票本币税前金额
       isaf114 LIKE isaf_t.isaf114, #发票本币税额
       isaf115 LIKE isaf_t.isaf115, #发票本币含税金额
       isaf116 LIKE isaf_t.isaf116, #发票本币留抵税额
       isaf117 LIKE isaf_t.isaf117, #发票本币已折金额
       isaf118 LIKE isaf_t.isaf118, #发票本币已折税额
       isaf119 LIKE isaf_t.isaf119, #账款应税金额
       isaf120 LIKE isaf_t.isaf120, #账款零税金额
       isaf121 LIKE isaf_t.isaf121, #账款免税金额
       isaf122 LIKE isaf_t.isaf122, #礼券已开发票金额
       isaf123 LIKE isaf_t.isaf123, #礼券已开发票税额
       isaf124 LIKE isaf_t.isaf124, #已开发票留抵税额
       isaf201 LIKE isaf_t.isaf201, #爱心码
       isaf202 LIKE isaf_t.isaf202, #载具类别号码
       isaf203 LIKE isaf_t.isaf203, #载具显码 ID
       isaf204 LIKE isaf_t.isaf204, #载具隐码 ID
       isaf205 LIKE isaf_t.isaf205, #电子发票导出状态
       isaf206 LIKE isaf_t.isaf206, #电子发票导出序号
       isaf207 LIKE isaf_t.isaf207, #电子发票领取方式
       isaf208 LIKE isaf_t.isaf208, #申报年度
       isaf209 LIKE isaf_t.isaf209, #申报月份
       isaf210 LIKE isaf_t.isaf210, #申报据点
       isafstus LIKE isaf_t.isafstus, #状态码
       isafownid LIKE isaf_t.isafownid, #资料所有者
       isafowndp LIKE isaf_t.isafowndp, #资料所有部门
       isafcrtid LIKE isaf_t.isafcrtid, #资料录入者
       isafcrtdp LIKE isaf_t.isafcrtdp, #资料录入部门
       isafcrtdt LIKE isaf_t.isafcrtdt, #资料创建日
       isafmodid LIKE isaf_t.isafmodid, #资料更改者
       isafmoddt LIKE isaf_t.isafmoddt, #最近更改日
       isafcnfid LIKE isaf_t.isafcnfid, #资料审核者
       isafcnfdt LIKE isaf_t.isafcnfdt, #数据审核日
       isaf059 LIKE isaf_t.isaf059, #适用零税率规定
       isaf060 LIKE isaf_t.isaf060, #通关方式
       isaf061 LIKE isaf_t.isaf061, #非经海关证明文档名称
       isaf062 LIKE isaf_t.isaf062, #非经海关证明文档号码
       isaf063 LIKE isaf_t.isaf063, #经由海关出口报单类别
       isaf064 LIKE isaf_t.isaf064, #出口报单号码
       isaf065 LIKE isaf_t.isaf065, #输出或结汇日期
       isaf066 LIKE isaf_t.isaf066, #商业发票号码(IV no.)
       isaf067 LIKE isaf_t.isaf067  #一次性交易对象
END RECORD
DEFINE l_isag RECORD  #銷項發票來源明細檔
       isagent LIKE isag_t.isagent, #企业编号
       isagcomp LIKE isag_t.isagcomp, #法人
       isagdocno LIKE isag_t.isagdocno, #开票单号
       isagseq LIKE isag_t.isagseq, #项次
       isagorga LIKE isag_t.isagorga, #来源组织
       isag001 LIKE isag_t.isag001, #来源类型
       isag002 LIKE isag_t.isag002, #来源单号
       isag003 LIKE isag_t.isag003, #来源项次
       isag004 LIKE isag_t.isag004, #发票数量
       isag005 LIKE isag_t.isag005, #发票单位
       isag006 LIKE isag_t.isag006, #税种
       isag007 LIKE isag_t.isag007, #含税否
       isag008 LIKE isag_t.isag008, #税率
       isag009 LIKE isag_t.isag009, #料号
       isag010 LIKE isag_t.isag010, #品名
       isag011 LIKE isag_t.isag011, #期别
       isag012 LIKE isag_t.isag012, #收款条件
       isag013 LIKE isag_t.isag013, #原始发票编号
       isag014 LIKE isag_t.isag014, #原始发票号码
       isag015 LIKE isag_t.isag015, #正负值
       isag016 LIKE isag_t.isag016, #客户料号
       isag017 LIKE isag_t.isag017, #客户品名
       isag101 LIKE isag_t.isag101, #原币单价
       isag103 LIKE isag_t.isag103, #原币税前金额
       isag104 LIKE isag_t.isag104, #原币税额
       isag105 LIKE isag_t.isag105, #原币税后金额
       isag106 LIKE isag_t.isag106, #订金发票已被摊税前额
       isag113 LIKE isag_t.isag113, #本币税前金额
       isag114 LIKE isag_t.isag114, #本币税额
       isag115 LIKE isag_t.isag115, #本币税后金额
       isag116 LIKE isag_t.isag116, #原币已收金额
       isag117 LIKE isag_t.isag117, #本币已收金额
       isag126 LIKE isag_t.isag126, #辅助账二原币已收金额　
       isag127 LIKE isag_t.isag127, #辅助账二本币已收金额　
       isag128 LIKE isag_t.isag128, #辅助账二应收单号
       isag136 LIKE isag_t.isag136, #辅助账三原币已收金额　
       isag137 LIKE isag_t.isag137, #辅助账二本币已收金额　
       isag138 LIKE isag_t.isag138, #辅助账三应收单号
       isag018 LIKE isag_t.isag018  #订金已开发票
END RECORD
   #161124-00048#12 add(e)
   DEFINE l_count    LIKE type_t.num10
   DEFINE l_isaf014  LIKE isaf_t.isaf014   #发票日期
   DEFINE l_type     LIKE type_t.num5
   DEFINE l_imaa006  LIKE imaa_t.imaa006  #成本用基础单位
   DEFINE l_xcbf001  LIKE xcbf_t.xcbf001  #成本域
   DEFINE l_qty      LIKE xmdl_t.xmdl018  #发出商品数量
   DEFINE l_isag004  LIKE isag_t.isag004  #已开发票数量
   DEFINE l_msg      STRING #160328-00022#5
   DEFINE l_xmdmseq1	LIKE xmdm_t.xmdmseq1  #160706-00021#2
   DEFINE l_xmdm005	LIKE xmdm_t.xmdm005   #160706-00021#2
   DEFINE l_xmdm006	LIKE xmdm_t.xmdm006   #160706-00021#2
   DEFINE l_xmdm007	LIKE xmdm_t.xmdm007   #160706-00021#2
   DEFINE l_xmdm008	LIKE xmdm_t.xmdm008   #160706-00021#2
   DEFINE l_xmdm009	LIKE xmdm_t.xmdm009   #160706-00021#2
   DEFINE l_xcat005  LIKE xcat_t.xcat005   #160706-00021#2
   DEFINE l_glav001  LIKE glav_t.glav001   #160706-00021#2
   DEFINE l_ld       LIKE glaa_t.glaald    #160706-00021#2
   DEFINE l_xckb007  LIKE xckb_t.xckb007   #160706-00021#2
   DEFINE l_xckb008  LIKE xckb_t.xckb008   #160706-00021#2
   DEFINE l_xmdl001  LIKE xmdl_t.xmdl001   #160706-00021#2
   #170414-00057#1 add--s
   DEFINE l_xmdkdocdt LIKE xmdk_t.xmdkdocdt 
   DEFINE l_xmdk000   LIKE xmdk_t.xmdk000  
   DEFINE l_count5    LIKE type_t.num5
   #170414-00057#1 add---e
   
   LET r_success = TRUE
  #160328-00022#5-s-add
   IF g_bgjob <> "Y" THEN
      LET l_count = 3
      CALL cl_progress_bar_no_window(l_count)   
   END IF       
  #160328-00022#5-e-add   
   
   #160706-00021#2--s
   CALL s_fin_get_major_ld(g_comp) RETURNING l_ld
   SELECT glaa003 INTO l_glav001 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = l_ld
   #160706-00021#2--e
   LET l_count = 0

   #160328-00022#5-s-add
   IF g_bgjob <> "Y" THEN 
      LET l_msg = cl_getmsg_parm("axc-00781",g_lang,'')  #抓取出貨資料寫入發出商品統計檔！           
      CALL cl_progress_no_window_ing(l_msg)          
   END IF      
   #160328-00022#5-e-add 

   #取出货单(axmt540)
   #取签收单(axmt680):xmdk002 = ‘3’的不要抓，就类似于oga65客户出货签收否 = ‘Y’。表示这张出货单是需要签收的
   #取签退单(axmt690)
   #取销退单(axmt600)
   #开票资料(axrt310)
   #LET g_wc = g_master.wc
   LET g_wc_axm = g_master.wc
   LET g_wc_axm = cl_replace_str(g_wc_axm,"pmaa001","xmdk008") #客戶
   LET g_wc_axm = cl_replace_str(g_wc_axm,"imaa001","xmdl008") #產品編號
   
   #161223-00020#1---add---s
   SELECT xcat005 INTO l_xcat005
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xcat001  
                    
  #LET l_sql = " SELECT xcbf001 FROM FROM xcbf_t WHERE xcbfent =",g_enterprise," AND xcbfcomp = '",g_comp,"' AND xcbf002 =? " #170103-00021#1 mark
   LET l_sql = " SELECT xcbf001 FROM xcbf_t WHERE xcbfent =",g_enterprise," AND xcbfcomp = '",g_comp,"' AND xcbf002 =? " #170103-00021#1 add
   PREPARE p200_xckb_pre1 FROM l_sql
   
   
   LET l_sql = " SELECT glav002,glav006 ",
               "   FROM xmdl_t,xmdk_t,glav_t ",
               "  WHERE xmdlent = ",g_enterprise,
               "    AND xmdldocno = ? AND xmdlseq = ?  ",
               "    AND xmdlent = xmdkent AND xmdl001 = xmdkdocno ",
               "    AND glavent = xmdlent AND glav004 = xmdkdocdt ",
               "    AND glav001 = '",l_glav001,"'"            
   PREPARE p200_xckb_pre2 FROM l_sql
   
   #161222-00034#1 add start -----
   LET l_sql = "SELECT glav002,glav006 ",
               "  FROM xmdk_t,glav_t ",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkdocno = ? ",
               "   AND glavent = xmdkent AND glav004 = xmdkdocdt ",
               "   AND glav001 = '",l_glav001,"'"
   PREPARE p200_xckb_pre2_1 FROM l_sql
   #161222-00034#1 add end  -----
      
   IF l_xcat005 = '3' THEN   
      LET l_sql = " SELECT xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h ",
                  "   FROM xccc_t",
                  "  WHERE xcccent = ",g_enterprise,
                  "    AND xcccld  = '",g_master.glaald,"'", #帐套
                  "    AND xccc001 = '1'",           #帐套本位币顺序
                  "    AND xccc002 = ? ", #成本域
                  "    AND xccc003 = '",g_xcat001,"'",      #成本计算类型
                  "    AND xccc004 = ? ",                  #年度        
                  "    AND xccc005 = ? ",                  #期别        
                  "    AND xccc006 = ? ",                  #料号
                  "    AND xccc007 = ? ",                  #特性
                  "    AND xccc008 = ? "                   #批号         
      PREPARE p200_xckb_pre3 FROM l_sql
   ELSE
      LET l_sql = " SELECT xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h ",
                  "   FROM xccc_t",
                  "  WHERE xcccent = ",g_enterprise,
                  "    AND xcccld  = '",g_master.glaald,"'", #帐套
                  "    AND xccc001 = '1'",           #帐套本位币顺序
                  "    AND xccc002 = ? ", #成本域
                  "    AND xccc003 = '",g_xcat001,"'",      #成本计算类型
                  "    AND xccc004 = ? ",                  #年度        
                  "    AND xccc005 = ? ",                  #期别        
                  "    AND xccc006 = ? ",                  #料号
                  "    AND xccc007 = ? "                   #特性          
      PREPARE p200_xckb_pre4 FROM l_sql
   END IF                         
   #161223-00020#1---add---e
   
#   LET l_sql = " SELECT xmdk_t.*,xmdl_t.*,imaa006 ", #161124-00048#12 mark
   #161124-00048#12 add(s)
   LET l_sql = " SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,",
               "        xmdk003,xmdk004,xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,",
               "        xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,",
               "        xmdk021,xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,",
               "        xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,xmdk035,xmdk036,xmdk037,xmdk038,",
               "        xmdk039,xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,xmdk045,xmdk051,xmdk052,",
               "        xmdk053,xmdk054,xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,xmdk200,xmdk201,",
               "        xmdk202,xmdk203,xmdk204,xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,xmdk210,",
               "        xmdk211,xmdk212,xmdk213,xmdk214,xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,",
               "        xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,xmdkpstdt,  ",
               "        xmdkstus,xmdk085,xmdk086,xmdk046,xmdk087,xmdk047,xmdk088,xmdk089,",#xmdk048,  ",
              #"        xmdk049,xmdk050,
               "        xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003,",
               "        xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,   ",
               "        xmdl013,xmdl014,xmdl015,xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021,   ",
               "        xmdl022,xmdl023,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,   ",
               "        xmdl031,xmdl032,xmdl033,xmdl034,xmdl035,xmdl036,xmdl037,xmdl038,xmdl039,   ",
               "        xmdl040,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,xmdl046,xmdl047,xmdl048,   ",
               "        xmdl049,xmdl050,xmdl051,xmdl052,xmdl053,xmdl054,xmdl055,xmdl081,xmdl082,   ",
               "        xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,xmdl088,xmdl089,xmdl090,xmdl091,   ",
               "        xmdl092,xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,xmdl204,xmdl205,xmdl206,   ",
               "        xmdl207,xmdl208,xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,xmdl214,xmdl215,   ",
               "        xmdl216,xmdl217,xmdl218,xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,xmdl225,   ",
               "        xmdl226,xmdlunit,xmdlorga,xmdl056,xmdl094,xmdl095,xmdl227,xmdl228,xmdl057, ",
               "        xmdl058,xmdl096,xmdl059,xmdl060,imaa006 ", 
   #161124-00048#12 add(e)
                       ",xmdmseq1,xmdm005,xmdm006,xmdm007,xmdm008,xmdm009",      #160706-00021#2
               "   FROM xmdk_t,xmdl_t,inaa_t,imaa_t,xmdm_t ",                    #160706-00021#2
               "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
               "    AND inaaent = xmdlent AND inaasite  = xmdlsite  AND inaa001 = xmdl014 ",
               "    AND imaaent = xmdlent AND imaa001   = xmdl008 ",
               #160907-00003#1---mark---s
               #"    AND ((xmdk000 IN ('1','2','3','4','5') AND xmdk002 IN ('1','2')) ",
               #"        OR xmdk000 ='6') ",   #销退
               #160907-00003#1---mark---e
               "    AND xmdment = xmdkent AND xmdmdocno = xmdkdocno AND xmdmseq = xmdlseq ",    #160706-00021#2 add xmdm
               "    AND xmdkent = ",g_enterprise,
               "    AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooefstus ='Y' AND ooef017 ='",g_comp,"')",
               #"    AND xmdkstus='S' ",   #160907-00003#1---mark
               #160907-00003#1---add---s
               "    AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S') ",
               "         OR (xmdk000 IN ('4','5') AND xmdkstus = 'Y' AND xmdk002 = '3') ",
              #"         OR (xmdk000 = '6' AND xmdk082 = '1' AND xmdkstus = 'S' )) ",       #161012-00038#1 mark
               "         OR (xmdk000 = '6' AND xmdk082 != '4' AND xmdkstus = 'S' )) ",      #161012-00038#1 add        
               #160907-00003#1---add---e
               "    AND xmdk001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND inaa010 = 'Y' ",    #成本仓
               "    AND ",g_wc_axm CLIPPED,
               #160706-00021#2 add 
               " UNION ",
#               " SELECT xmdk_t.*,xmdl_t.*,imaa006,xmdmseq1,xmdm005,xmdm006,xmdm007,xmdm008,xmdm009  ",  #161124-00048#12 mark 
              #161124-00048#12 add(s)
               " SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,",
               "        xmdk003,xmdk004,xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,",
               "        xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,",
               "        xmdk021,xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,",
               "        xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,xmdk035,xmdk036,xmdk037,xmdk038,",
               "        xmdk039,xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,xmdk045,xmdk051,xmdk052,",
               "        xmdk053,xmdk054,xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,xmdk200,xmdk201,",
               "        xmdk202,xmdk203,xmdk204,xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,xmdk210,",
               "        xmdk211,xmdk212,xmdk213,xmdk214,xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,",
               "        xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,xmdkpstdt,  ",
               "        xmdkstus,xmdk085,xmdk086,xmdk046,xmdk087,xmdk047,xmdk088,xmdk089,",#xmdk048,  ",
               #"       xmdk049,xmdk050,",
               "        xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003,",
               "        xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,   ",
               "        xmdl013,xmdl014,xmdl015,xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021,   ",
               "        xmdl022,xmdl023,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,   ",
               "        xmdl031,xmdl032,xmdl033,xmdl034,xmdl035,xmdl036,xmdl037,xmdl038,xmdl039,   ",
               "        xmdl040,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,xmdl046,xmdl047,xmdl048,   ",
               "        xmdl049,xmdl050,xmdl051,xmdl052,xmdl053,xmdl054,xmdl055,xmdl081,xmdl082,   ",
               "        xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,xmdl088,xmdl089,xmdl090,xmdl091,   ",
               "        xmdl092,xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,xmdl204,xmdl205,xmdl206,   ",
               "        xmdl207,xmdl208,xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,xmdl214,xmdl215,   ",
               "        xmdl216,xmdl217,xmdl218,xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,xmdl225,   ",
               "        xmdl226,xmdlunit,xmdlorga,xmdl056,xmdl094,xmdl095,xmdl227,xmdl228,xmdl057, ",
               "        xmdl058,xmdl096,xmdl059,xmdl060,imaa006,xmdmseq1,xmdm005,xmdm006,xmdm007,xmdm008,xmdm009  ",
              #161124-00048#12 add(e)
               "   FROM xmdk_t,xmdl_t,imaa_t,xmdm_t  ",
               "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
               "    AND imaaent = xmdlent AND imaa001   = xmdl008 ",
               "   AND xmdl014 = ' '  ",
               #160907-00003#1---mark---s
               #"    AND ((xmdk000 IN ('1','2','3','4','5') AND xmdk002 IN ('1','2')) ",
               #"        OR xmdk000 ='6') ",   #销退
               #160907-00003#1---mark---e
               "   AND xmdment = xmdkent AND xmdmdocno = xmdkdocno AND xmdmseq = xmdlseq",
               "    AND xmdkent = ",g_enterprise,
               "    AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooefstus ='Y' AND ooef017 ='",g_comp,"')",
               #"    AND xmdkstus='S' ",   #160907-00003#1---mark
               #160907-00003#1---add---s
               "    AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S') ",
               "         OR (xmdk000 IN ('4','5') AND xmdkstus = 'Y' AND xmdk002 = '3') ",
              #"         OR (xmdk000 = '6' AND xmdk082 = '1' AND xmdkstus = 'S' )) ",           #161012-00038#1 mark
               "         OR (xmdk000 = '6' AND xmdk082 != '4' AND xmdkstus = 'S' )) ",           #161012-00038#1 add              
               #160907-00003#1---add---e               
               "    AND xmdk001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND ",g_wc_axm CLIPPED
               #160706-00021#2 add 
   PREPARE axcp200_execute_ins_xckb_p1 FROM l_sql
   DECLARE axcp200_execute_ins_xckb_c1 CURSOR FOR axcp200_execute_ins_xckb_p1
   FOREACH axcp200_execute_ins_xckb_c1 INTO l_xmdk.*,l_xmdl.*,l_imaa006,l_xmdmseq1,l_xmdm005,l_xmdm006,l_xmdm007,l_xmdm008,l_xmdm009  #160706-00021#2 add xmdm #,l_xmdm.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axcp200_execute_ins_xckb_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      #160706-00021#2--mark--s
      ##本月已出货/签收/销退未开票的--add 160107 begin
      #SELECT SUM(isag004) INTO l_isag004 FROM isag_t  #已开发票数
      # WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno
      #   AND isafent = g_enterprise
      #   AND isafcomp= g_comp
      #   AND isafstus IN ('S' ,'Y') 
      #   AND isaf014 BETWEEN g_bdate AND g_edate
      #   AND isag002 = l_xmdk.xmdkdocno  #来源单号
      #   AND isag003 = l_xmdl.xmdlseq    #来源项次
      #IF cl_null(l_isag004) THEN LET l_isag004 = 0 END IF
      #LET l_qty = l_xmdl.xmdl018 - l_isag004
      #IF l_qty <= 0 THEN
      #   CONTINUE FOREACH
      #END IF
      #--end
      #160706-00021#2--mark--e
      
      INITIALIZE l_xckb.* TO NULL
      LET l_xckb.xckbent = g_enterprise      #企業代碼
      LET l_xckb.xckbcomp= g_comp            #法人，跟据点走，不是跟账别走
      LET l_xckb.xckbld  = g_master.glaald   #帳別
      #xmdk000:1:出货单 2:无订单出货 3:直送订单出货 4:出货签收单 5:出货签退单 6:销退单
      CASE
         WHEN l_xmdk.xmdk000 = '1' OR l_xmdk.xmdk000 = '2' OR l_xmdk.xmdk000 = '3'
              LET l_xckb.xckb001 = '1'       #來源:1为出货单，2为签收单，3为销退单，4发票
         WHEN l_xmdk.xmdk000 = '4' OR l_xmdk.xmdk000 = '5'
              LET l_xckb.xckb001 = '2'       #來源:1为出货单，2为签收单，3为销退单，4发票
         WHEN l_xmdk.xmdk000 = '6'           
              LET l_xckb.xckb001 = '3'       #來源:1为出货单，2为签收单，3为销退单，4发票
      END CASE                               
      LET l_xckb.xckb002 = 1                 #方向:从出货/签收/销退取得的为1，表示转入发出商品档。
                                             #     从开票资料中取得的为-1，表示转出发出商品档
      LET l_xckb.xckb003 = 'UNINVOICE'       #發票號碼:出货/签收/销退单，赋值 “UNINVOICE”，表示未开票。
                                             #        开票资料，则将对应的发票号码写进去。
      LET l_xckb.xckb004 = l_xmdk.xmdksite   #據點site:为单据所在据点，而非当前操作据点
      LET l_xckb.xckb005 = l_xmdk.xmdkdocno  #出貨單號
      LET l_xckb.xckb006 = l_xmdl.xmdlseq    #l_xmdm.xmdmseq    #出貨項次
     #LET l_xckb.xckb036 = 0                 #l_xmdm.xmdmseq1   #出貨项序      #160706-00021#2
      LET l_xckb.xckb036 = l_xmdmseq1        #出貨项序           #160706-00021#2
      LET l_xckb.xckb007 = g_master.yy       #年度
      LET l_xckb.xckb008 = g_master.pp       #期別
      LET l_xckb.xckb009 = l_xmdk.xmdk008    #客戶編號
      LET l_xckb.xckb010 = l_xmdk.xmdk003    #人員編號
      LET l_xckb.xckb011 = l_xmdk.xmdk004    #部門編號
      LET l_xckb.xckb012 = l_xmdl.xmdl008    #l_xmdm.xmdm001    #產品編號
      LET l_xckb.xckb037 = l_xmdl.xmdl009    #特性
      IF cl_null(l_xckb.xckb037) THEN LET l_xckb.xckb037 = ' ' END IF
      
      #170322-00109#1 add --s
      #按料件特性计算成本否
      IF g_sys_6013 = 'N' THEN
         LET l_xckb.xckb037 = ' '
      END IF
      #170322-00109#1 add --e
      
      #LET l_xckb.xckb013 = l_xmdl.xmdl017    #l_xmdm.xmdm008    #銷售單位        #160706-00021#2 mark
      #LET l_xckb.xckb014 = l_qty  #l_xmdl.xmdl018    #l_xmdm.xmdm009    #數量    #160706-00021#2 mark
      #LET l_xckb.xckb015 = l_xmdl.xmdl014    #l_xmdm.xmdm005    #倉庫編號        #160706-00021#2 mark
      #LET l_xckb.xckb016 = l_xmdl.xmdl015    #l_xmdm.xmdm006    #庫位編號        #160706-00021#2 mark
      #LET l_xckb.xckb017 = l_xmdl.xmdl016    #l_xmdm.xmdm007    #批號            #160706-00021#2 mark
      #LET l_xckb.xckb018 =  #no use
      #160706-00021#2--s
      LET l_xckb.xckb013 = l_xmdm008    #銷售單位
      LET l_xckb.xckb014 = l_xmdm009    #數量      
      LET l_xckb.xckb015 = l_xmdm005    #倉庫編號
      LET l_xckb.xckb016 = l_xmdm006    #庫位編號
      LET l_xckb.xckb017 = l_xmdm007    #批號
      #160706-00021#2--e
      LET l_xckb.xckb019 = l_xmdk.xmdk041    #發票代碼
      
      LET l_xckb.xckb020 = l_imaa006    #庫存單位
      CALL s_aooi250_convert_qty(l_xckb.xckb012,l_xckb.xckb013,l_xckb.xckb020,l_xckb.xckb014)
         RETURNING l_success,l_xckb.xckb021  #庫存數量
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_xckb.xckb001 = '3' THEN    #销退单
         LET l_xckb.xckb021 = l_xckb.xckb021 * -1
         LET l_xckb.xckb014 = l_xckb.xckb014 * -1     #160817-00005#1
      END IF
      
      #IF l_xckb.xckb002 = '1' THEN
      #   #转入：抓取agli161，存货类科目中的 发出商品科目glcc006
      #   LET l_type = 17  #取得科目類型:发出商品
      #ELSE
      #   #转出：科目抓取对应的主营业务成本科目。根据出货单对应到agli161抓取科目。
      #   LET l_type =  #取得科目類型
      #END IF
      #CALL s_get_item_acc(g_master.glaald,l_type,l_xckb.xckb012,'','',g_comp,'') 
      CALL s_get_item_acc(g_master.glaald,17,l_xckb.xckb012,'','',g_comp,'') 
        RETURNING l_success,l_xckb.xckb022     #科目編號
      IF cl_null(l_xckb.xckb022) THEN LET l_xckb.xckb022 = ' ' END IF
        
      IF cl_null(l_xmdk.xmdk044) THEN
         LET l_xckb.xckb023 = 'N'              #多角貿易否
      ELSE
         LET l_xckb.xckb023 = 'Y'              #多角貿易否
      END IF
      
      #转入不给值
      #LET l_xckb.xckb024 =  #開票年度
      #LET l_xckb.xckb025 =  #開票期別
      LET l_xckb.xckb026 = g_glaa001 #幣種一
      LET l_xckb.xckb027 = l_xmdl.xmdl028 #金額  
      #LET l_xckb.xckb032 =  #no use
      #LET l_xckb.xckb033 =  #no use
      #LET l_xckb.xckb034 =  #no use
      #LET l_xckb.xckb035 =  #no use

      #成本域
      IF g_sys_6001 = 'N' THEN
         LET l_xcbf001 = ' '
      ELSE
        #CASE g_sys_6001 #170103-00022#1 mark
         CASE g_sys_6002 #170103-00022#1 add
              WHEN '1'  #组织
                 #161223-00020#1---mod---s
                 #  SELECT xcbf001 INTO l_xcbf001 FROM xcbf_t
                 #   WHERE xcbfent  = g_enterprise
                 #     AND xcbfcomp = g_comp
                 #     AND xcbf002  = l_xmdk.xmdksite
                 EXECUTE p200_xckb_pre1 USING l_xmdk.xmdksite INTO l_xcbf001
                 #161223-00020#1---mod---e
              WHEN '2'  #仓库
                 #161223-00020#1---mod---s
                 #  SELECT xcbf001 INTO l_xcbf001 FROM xcbf_t
                 #   WHERE xcbfent  = g_enterprise
                 #     AND xcbfcomp = g_comp
                 #     AND xcbf002  = l_xmdl.xmdl014 #倉庫編號
                 EXECUTE p200_xckb_pre1 USING l_xmdl.xmdl014 INTO l_xcbf001
                 #161223-00020#1---mod---e
              WHEN '3'  #库存管理特征
                   LET l_xcbf001 = l_xmdl.xmdl052
              OTHERWISE
                   LET l_xcbf001 = ' ' 
         END CASE
      END IF
      LET l_xckb.xckb038 = l_xcbf001   #成本域
      #161223-00020#1---mark---s
      ##160706-00021#2--(S)
      #SELECT xcat005 INTO l_xcat005
      #  FROM xcat_t
      # WHERE xcatent = g_enterprise
      #   AND xcat001 = g_xcat001
      ##160706-00021#2--(E)      
      #161223-00020#1---mark---s
      #170414-00057#1--s
      LET l_xckb007 = l_xckb.xckb007
      LET l_xckb008 = l_xckb.xckb008
      #170414-00057#1--e
      #160907-00003#4-s
      IF l_xmdk.xmdk000 = '6' THEN
         #從xckb的銷退單號, 串回原退貨單xmdl, 查到該銷退單對應的出貨單及月份
         #161223-00020#1---mod---e
         #SELECT glav002,glav006 INTO l_xckb007,l_xckb008
         #  FROM xmdl_t,xmdk_t,glav_t
         # WHERE xmdlent = g_enterprise
         #   AND xmdldocno = l_xckb.xckb005 AND xmdlseq = l_xckb.xckb006
         #   AND xmdlent = xmdkent AND xmdl001 = xmdkdocno
         #   AND glavent = xmdlent AND glav004 = xmdkdocdt
         #   AND glav001 = l_glav001 
         EXECUTE p200_xckb_pre2 USING l_xckb.xckb005,l_xckb.xckb006 INTO l_xckb007,l_xckb008
         #161223-00020#1---mod---e
         #170414-00057#1---s
         IF g_sys_6005='1' THEN
            SELECT  xmdk001 INTO l_xmdkdocdt 
               FROM xmdl_t,xmdk_t   
               WHERE xmdlent = g_enterprise
               AND xmdldocno = l_xckb.xckb005 AND xmdlseq = l_xckb.xckb006
               AND xmdlent = xmdkent AND xmdl001 = xmdkdocno 
            IF cl_null(l_xmdkdocdt) THEN
               SELECT xmdkdocdt INTO l_xmdkdocdt
               FROM xmdk_t WHERE xmdkdocno=l_xckb.xckb005
               AND xmdkent = g_enterprise
            END IF 
            LET l_xckb007=YEAR(l_xmdkdocdt)
            LET l_xckb008=month(l_xmdkdocdt) 
            
            IF STATUS=100 THEN 
               LET l_xckb007 = l_xckb.xckb007
               LET l_xckb008 = l_xckb.xckb008
            END IF 
         END IF 
         #170414-00057#1---e
      ELSE
         #161222-00034#1 add start -----
         EXECUTE p200_xckb_pre2_1 USING l_xckb.xckb005 INTO l_xckb007,l_xckb008
         IF SQLCA.sqlcode THEN
         #161222-00034#1 add end   -----
            LET l_xckb007 = l_xckb.xckb007
            LET l_xckb008 = l_xckb.xckb008
         END IF #161222-00034#1 add
      END IF
      #160907-00003#4-e
      IF l_xcat005 = '3' THEN    #160706-00021#2
         #161223-00020#1---mod---s
         #SELECT xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h
         #  INTO l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d, #幣種一成本單價
         #                      l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,l_xckb.xckb101h  #幣種一成本單價
         #  FROM xccc_t
         # WHERE xcccent = g_enterprise
         #   AND xcccld  = l_xckb.xckbld #帐套
         #   AND xccc001 = '1'           #帐套本位币顺序
         #   AND xccc002 = l_xckb.xckb038 #成本域
         #   AND xccc003 = g_xcat001      #成本计算类型
         #   AND xccc004 = l_xckb007      #年度          #160706-00021#2 modify
         #   AND xccc005 = l_xckb008      #期别          #160706-00021#2 modify
         #   AND xccc006 = l_xckb.xckb012 #料号
         #   AND xccc007 = l_xckb.xckb037 #特性
         #   AND xccc008 = l_xckb.xckb017 #批号
         EXECUTE p200_xckb_pre3 USING l_xckb.xckb038,l_xckb007,l_xckb008,l_xckb.xckb012,l_xckb.xckb037,l_xckb.xckb017
            INTO l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d, #幣種一成本單價
                                l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,l_xckb.xckb101h  #幣種一成本單價                                  
         #161223-00020#1---mod---e
      #160706-00021#2--(S)
      ELSE
         #161223-00020#1---mod---s
         #SELECT xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h
         #  INTO l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d, #幣種一成本單價
         #                      l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,l_xckb.xckb101h  #幣種一成本單價
         #  FROM xccc_t
         # WHERE xcccent = g_enterprise
         #   AND xcccld  = l_xckb.xckbld #帐套
         #   AND xccc001 = '1'           #帐套本位币顺序
         #   AND xccc002 = l_xckb.xckb038 #成本域
         #   AND xccc003 = g_xcat001      #成本计算类型
         #   AND xccc004 = l_xckb007      #年度       #160706-00021#2 modify
         #   AND xccc005 = l_xckb008      #期别       #160706-00021#2 modify
         #   AND xccc006 = l_xckb.xckb012 #料号
         #   AND xccc007 = l_xckb.xckb037 #特性  
         EXECUTE p200_xckb_pre4 USING l_xckb.xckb038,l_xckb007,l_xckb008,l_xckb.xckb012,l_xckb.xckb037
            INTO l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d, #幣種一成本單價
                                l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,l_xckb.xckb101h  #幣種一成本單價             
         #161223-00020#1---mod---e
      END IF      
      #160706-00021#2--(E)
      LET l_xckb.xckb102  = l_xckb.xckb101  * l_xckb.xckb021 #幣種一成本金額       
      LET l_xckb.xckb102a = l_xckb.xckb101a * l_xckb.xckb021 #幣種一成本金額-材料  
      LET l_xckb.xckb102b = l_xckb.xckb101b * l_xckb.xckb021 #幣種一成本金額-人工  
      LET l_xckb.xckb102c = l_xckb.xckb101c * l_xckb.xckb021 #幣種一成本金額-加工  
      LET l_xckb.xckb102d = l_xckb.xckb101d * l_xckb.xckb021 #幣種一成本金額-制費一
      LET l_xckb.xckb102e = l_xckb.xckb101e * l_xckb.xckb021 #幣種一成本金額-制費二
      LET l_xckb.xckb102f = l_xckb.xckb101f * l_xckb.xckb021 #幣種一成本金額-制費三
      LET l_xckb.xckb102g = l_xckb.xckb101g * l_xckb.xckb021 #幣種一成本金額-制費四
      LET l_xckb.xckb102h = l_xckb.xckb101h * l_xckb.xckb021 #幣種一成本金額-制費五
      CALL s_num_round(g_round_type,l_xckb.xckb102 ,g_ooaj007_1) RETURNING l_xckb.xckb102
      CALL s_num_round(g_round_type,l_xckb.xckb102a,g_ooaj007_1) RETURNING l_xckb.xckb102a
      CALL s_num_round(g_round_type,l_xckb.xckb102b,g_ooaj007_1) RETURNING l_xckb.xckb102b
      CALL s_num_round(g_round_type,l_xckb.xckb102c,g_ooaj007_1) RETURNING l_xckb.xckb102c
      CALL s_num_round(g_round_type,l_xckb.xckb102d,g_ooaj007_1) RETURNING l_xckb.xckb102d
      CALL s_num_round(g_round_type,l_xckb.xckb102e,g_ooaj007_1) RETURNING l_xckb.xckb102e
      CALL s_num_round(g_round_type,l_xckb.xckb102f,g_ooaj007_1) RETURNING l_xckb.xckb102f
      CALL s_num_round(g_round_type,l_xckb.xckb102g,g_ooaj007_1) RETURNING l_xckb.xckb102g
      CALL s_num_round(g_round_type,l_xckb.xckb102h,g_ooaj007_1) RETURNING l_xckb.xckb102h
      
      IF g_glaa015 = 'Y' THEN  #啟用本位幣二
         LET l_xckb.xckb028 = g_glaa016           #幣種二
         IF l_xckb.xckb027 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,l_isaf.isafdocdt,l_xckb.xckb026,l_xckb.xckb028,l_xckb.xckb027,g_glaa018)
                 RETURNING l_xckb.xckb029            #金額
         END IF
         #成本金额
         IF l_xckb.xckb101 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101 ,g_glaa018) RETURNING l_xckb.xckb111  #幣種二成本單價     
         END IF   
         IF l_xckb.xckb101a!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101a,g_glaa018) RETURNING l_xckb.xckb111a #幣種二成本單價-材料
         END IF  
         IF l_xckb.xckb101b!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101b,g_glaa018) RETURNING l_xckb.xckb111b #幣種二成本單價-人工  
         END IF
         IF l_xckb.xckb101c!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101c,g_glaa018) RETURNING l_xckb.xckb111c #幣種二成本單價-加工 
         END IF 
         IF l_xckb.xckb101d!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101d,g_glaa018) RETURNING l_xckb.xckb111d #幣種二成本單價-制費一
         END IF
         IF l_xckb.xckb101e!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101e,g_glaa018) RETURNING l_xckb.xckb111e #幣種二成本單價-制費二
         END IF
         IF l_xckb.xckb101f!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101f,g_glaa018) RETURNING l_xckb.xckb111f #幣種二成本單價-制費三
         END IF
         IF l_xckb.xckb101g!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101g,g_glaa018) RETURNING l_xckb.xckb111g #幣種二成本單價-制費四
         END IF
         IF l_xckb.xckb101h!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101h,g_glaa018) RETURNING l_xckb.xckb111h #幣種二成本單價-制費五
         END IF
         CALL s_num_round(g_round_type,l_xckb.xckb111 ,g_ooaj006_2) RETURNING l_xckb.xckb111 
         CALL s_num_round(g_round_type,l_xckb.xckb111a,g_ooaj006_2) RETURNING l_xckb.xckb111a
         CALL s_num_round(g_round_type,l_xckb.xckb111b,g_ooaj006_2) RETURNING l_xckb.xckb111b
         CALL s_num_round(g_round_type,l_xckb.xckb111c,g_ooaj006_2) RETURNING l_xckb.xckb111c
         CALL s_num_round(g_round_type,l_xckb.xckb111d,g_ooaj006_2) RETURNING l_xckb.xckb111d
         CALL s_num_round(g_round_type,l_xckb.xckb111e,g_ooaj006_2) RETURNING l_xckb.xckb111e
         CALL s_num_round(g_round_type,l_xckb.xckb111f,g_ooaj006_2) RETURNING l_xckb.xckb111f
         CALL s_num_round(g_round_type,l_xckb.xckb111g,g_ooaj006_2) RETURNING l_xckb.xckb111g
         CALL s_num_round(g_round_type,l_xckb.xckb111h,g_ooaj006_2) RETURNING l_xckb.xckb111h
         LET l_xckb.xckb112  = l_xckb.xckb111  * l_xckb.xckb021 #幣種二成本金額       
         LET l_xckb.xckb112a = l_xckb.xckb111a * l_xckb.xckb021 #幣種二成本金額-材料  
         LET l_xckb.xckb112b = l_xckb.xckb111b * l_xckb.xckb021 #幣種二成本金額-人工  
         LET l_xckb.xckb112c = l_xckb.xckb111c * l_xckb.xckb021 #幣種二成本金額-加工  
         LET l_xckb.xckb112d = l_xckb.xckb111d * l_xckb.xckb021 #幣種二成本金額-制費一
         LET l_xckb.xckb112e = l_xckb.xckb111e * l_xckb.xckb021 #幣種二成本金額-制費二
         LET l_xckb.xckb112f = l_xckb.xckb111f * l_xckb.xckb021 #幣種二成本金額-制費三
         LET l_xckb.xckb112g = l_xckb.xckb111g * l_xckb.xckb021 #幣種二成本金額-制費四
         LET l_xckb.xckb112h = l_xckb.xckb111h * l_xckb.xckb021 #幣種二成本金額-制費五   
         CALL s_num_round(g_round_type,l_xckb.xckb112 ,g_ooaj007_2) RETURNING l_xckb.xckb112 
         CALL s_num_round(g_round_type,l_xckb.xckb112a,g_ooaj007_2) RETURNING l_xckb.xckb112a
         CALL s_num_round(g_round_type,l_xckb.xckb112b,g_ooaj007_2) RETURNING l_xckb.xckb112b
         CALL s_num_round(g_round_type,l_xckb.xckb112c,g_ooaj007_2) RETURNING l_xckb.xckb112c
         CALL s_num_round(g_round_type,l_xckb.xckb112d,g_ooaj007_2) RETURNING l_xckb.xckb112d
         CALL s_num_round(g_round_type,l_xckb.xckb112e,g_ooaj007_2) RETURNING l_xckb.xckb112e
         CALL s_num_round(g_round_type,l_xckb.xckb112f,g_ooaj007_2) RETURNING l_xckb.xckb112f
         CALL s_num_round(g_round_type,l_xckb.xckb112g,g_ooaj007_2) RETURNING l_xckb.xckb112g
         CALL s_num_round(g_round_type,l_xckb.xckb112h,g_ooaj007_2) RETURNING l_xckb.xckb112h
      END IF
      IF g_glaa019 = 'Y' THEN  #啟用本位幣三
         LET l_xckb.xckb030 = g_glaa020           #幣種三
         IF l_xckb.xckb027 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,l_isaf.isafdocdt,l_xckb.xckb026,l_xckb.xckb030,l_xckb.xckb027,g_glaa022)
                 RETURNING l_xckb.xckb031
         END IF
         #成本金额
         IF l_xckb.xckb101 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101 ,g_glaa022) RETURNING l_xckb.xckb121  #幣種三成本單價  
         END IF      
         IF l_xckb.xckb101a!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101a,g_glaa022) RETURNING l_xckb.xckb121a #幣種三成本單價-材料
         END IF  
         IF l_xckb.xckb101b!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101b,g_glaa022) RETURNING l_xckb.xckb121b #幣種三成本單價-人工
         END IF  
         IF l_xckb.xckb101c!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101c,g_glaa022) RETURNING l_xckb.xckb121c #幣種三成本單價-加工 
         END IF 
         IF l_xckb.xckb101d!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101d,g_glaa022) RETURNING l_xckb.xckb121d #幣種三成本單價-制費一
         END IF
         IF l_xckb.xckb101e!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101e,g_glaa022) RETURNING l_xckb.xckb121e #幣種三成本單價-制費二
         END IF
         IF l_xckb.xckb101f!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101f,g_glaa022) RETURNING l_xckb.xckb121f #幣種三成本單價-制費三
         END IF
         IF l_xckb.xckb101g!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101g,g_glaa022) RETURNING l_xckb.xckb121g #幣種三成本單價-制費四
         END IF
         IF l_xckb.xckb101h!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101h,g_glaa022) RETURNING l_xckb.xckb121h #幣種三成本單價-制費五
         END IF
         CALL s_num_round(g_round_type,l_xckb.xckb121 ,g_ooaj006_3) RETURNING l_xckb.xckb121 
         CALL s_num_round(g_round_type,l_xckb.xckb121a,g_ooaj006_3) RETURNING l_xckb.xckb121a
         CALL s_num_round(g_round_type,l_xckb.xckb121b,g_ooaj006_3) RETURNING l_xckb.xckb121b
         CALL s_num_round(g_round_type,l_xckb.xckb121c,g_ooaj006_3) RETURNING l_xckb.xckb121c
         CALL s_num_round(g_round_type,l_xckb.xckb121d,g_ooaj006_3) RETURNING l_xckb.xckb121d
         CALL s_num_round(g_round_type,l_xckb.xckb121e,g_ooaj006_3) RETURNING l_xckb.xckb121e
         CALL s_num_round(g_round_type,l_xckb.xckb121f,g_ooaj006_3) RETURNING l_xckb.xckb121f
         CALL s_num_round(g_round_type,l_xckb.xckb121g,g_ooaj006_3) RETURNING l_xckb.xckb121g
         CALL s_num_round(g_round_type,l_xckb.xckb121h,g_ooaj006_3) RETURNING l_xckb.xckb121h
         LET l_xckb.xckb122  = l_xckb.xckb121  * l_xckb.xckb021 #幣種三成本金額
         LET l_xckb.xckb122a = l_xckb.xckb121a * l_xckb.xckb021 #幣種三成本金額-材料
         LET l_xckb.xckb122b = l_xckb.xckb121b * l_xckb.xckb021 #幣種三成本金額-人工
         LET l_xckb.xckb122c = l_xckb.xckb121c * l_xckb.xckb021 #幣種三成本金額-加工
         LET l_xckb.xckb122d = l_xckb.xckb121d * l_xckb.xckb021 #幣種三成本金額-制費一
         LET l_xckb.xckb122e = l_xckb.xckb121e * l_xckb.xckb021 #幣種三成本金額-制費二
         LET l_xckb.xckb122f = l_xckb.xckb121f * l_xckb.xckb021 #幣種三成本金額-制費三
         LET l_xckb.xckb122g = l_xckb.xckb121g * l_xckb.xckb021 #幣種三成本金額-制費四
         LET l_xckb.xckb122h = l_xckb.xckb121h * l_xckb.xckb021 #幣種三成本金額-制費五
         CALL s_num_round(g_round_type,l_xckb.xckb122 ,g_ooaj007_3) RETURNING l_xckb.xckb122 
         CALL s_num_round(g_round_type,l_xckb.xckb122a,g_ooaj007_3) RETURNING l_xckb.xckb122a
         CALL s_num_round(g_round_type,l_xckb.xckb122b,g_ooaj007_3) RETURNING l_xckb.xckb122b
         CALL s_num_round(g_round_type,l_xckb.xckb122c,g_ooaj007_3) RETURNING l_xckb.xckb122c
         CALL s_num_round(g_round_type,l_xckb.xckb122d,g_ooaj007_3) RETURNING l_xckb.xckb122d
         CALL s_num_round(g_round_type,l_xckb.xckb122e,g_ooaj007_3) RETURNING l_xckb.xckb122e
         CALL s_num_round(g_round_type,l_xckb.xckb122f,g_ooaj007_3) RETURNING l_xckb.xckb122f
         CALL s_num_round(g_round_type,l_xckb.xckb122g,g_ooaj007_3) RETURNING l_xckb.xckb122g
         CALL s_num_round(g_round_type,l_xckb.xckb122h,g_ooaj007_3) RETURNING l_xckb.xckb122h
      END IF

      CALL axcp200_execute_ins_xckb_null_zero(l_xckb.*)
         RETURNING l_xckb.*
      
#      INSERT INTO xckb_t VALUES (l_xckb.*)  #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO xckb_t(xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb004,xckb005,
                         xckb006,xckb007,xckb008,xckb009,xckb010,xckb011,xckb012,xckb013,
                         xckb014,xckb015,xckb016,xckb017,xckb018,xckb019,xckb020,xckb021,
                         xckb022,xckb023,xckb024,xckb025,xckb026,xckb027,xckb028,xckb029,
                         xckb030,xckb031,xckb032,xckb033,xckb034,xckb035,xckb036,xckb037,
                         xckb101,xckb101a,xckb101b,xckb101c,xckb101d,xckb101e,xckb101f,xckb101g,
                         xckb101h,xckb102,xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,xckb102f,
                         xckb102g,xckb102h,xckb111,xckb111a,xckb111b,xckb111c,xckb111d,xckb111e,
                         xckb111f,xckb111g,xckb111h,xckb112,xckb112a,xckb112b,xckb112c,xckb112d,
                         xckb112e,xckb112f,xckb112g,xckb112h,xckb121,xckb121a,xckb121b,xckb121c,
                         xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,xckb122,xckb122a,xckb122b,
                         xckb122c,xckb122d,xckb122e,xckb122f,xckb122g,xckb122h,xckb038) 
                 VALUES (l_xckb.xckbent,l_xckb.xckbcomp,l_xckb.xckbld,l_xckb.xckb001,l_xckb.xckb002,l_xckb.xckb003,l_xckb.xckb004,l_xckb.xckb005,
                         l_xckb.xckb006,l_xckb.xckb007,l_xckb.xckb008,l_xckb.xckb009,l_xckb.xckb010,l_xckb.xckb011,l_xckb.xckb012,l_xckb.xckb013,
                         l_xckb.xckb014,l_xckb.xckb015,l_xckb.xckb016,l_xckb.xckb017,l_xckb.xckb018,l_xckb.xckb019,l_xckb.xckb020,l_xckb.xckb021,
                         l_xckb.xckb022,l_xckb.xckb023,l_xckb.xckb024,l_xckb.xckb025,l_xckb.xckb026,l_xckb.xckb027,l_xckb.xckb028,l_xckb.xckb029,
                         l_xckb.xckb030,l_xckb.xckb031,l_xckb.xckb032,l_xckb.xckb033,l_xckb.xckb034,l_xckb.xckb035,l_xckb.xckb036,l_xckb.xckb037,
                         l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d,l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,
                         l_xckb.xckb101h,l_xckb.xckb102,l_xckb.xckb102a,l_xckb.xckb102b,l_xckb.xckb102c,l_xckb.xckb102d,l_xckb.xckb102e,l_xckb.xckb102f,
                         l_xckb.xckb102g,l_xckb.xckb102h,l_xckb.xckb111,l_xckb.xckb111a,l_xckb.xckb111b,l_xckb.xckb111c,l_xckb.xckb111d,l_xckb.xckb111e,
                         l_xckb.xckb111f,l_xckb.xckb111g,l_xckb.xckb111h,l_xckb.xckb112,l_xckb.xckb112a,l_xckb.xckb112b,l_xckb.xckb112c,l_xckb.xckb112d,
                         l_xckb.xckb112e,l_xckb.xckb112f,l_xckb.xckb112g,l_xckb.xckb112h,l_xckb.xckb121,l_xckb.xckb121a,l_xckb.xckb121b,l_xckb.xckb121c,
                         l_xckb.xckb121d,l_xckb.xckb121e,l_xckb.xckb121f,l_xckb.xckb121g,l_xckb.xckb121h,l_xckb.xckb122,l_xckb.xckb122a,l_xckb.xckb122b,
                         l_xckb.xckb122c,l_xckb.xckb122d,l_xckb.xckb122e,l_xckb.xckb122f,l_xckb.xckb122g,l_xckb.xckb122h,l_xckb.xckb038)
      #161124-00048#12 add(e)
      LET l_count = l_count + 1
   END FOREACH

   #160328-00022#5-s-add
   IF g_bgjob <> "Y" THEN 
      LET l_msg = cl_getmsg_parm("axc-00782",g_lang,'')  #抓取開票資料寫入發出商品統計檔！
      CALL cl_progress_no_window_ing(l_msg)          
   END IF      
   #160328-00022#5-e-add 


   #开票
   #LET g_wc = g_master.wc
   LET g_wc_ais = g_master.wc
   LET g_wc_ais = cl_replace_str(g_wc_ais,"pmaa001","isaf003") #客戶
   LET g_wc_ais = cl_replace_str(g_wc_ais,"imaa001","isag009") #產品編號
   
   #161223-00020#1---add---s
   LET l_sql = " SELECT xmdl009  ",
               "   FROM xmdl_t ",
               "  WHERE xmdlent   = ",g_enterprise,
               "    AND xmdldocno = ? ",
               "    AND xmdlseq   = ? "
   PREPARE p200_xckb_pre5 FROM l_sql            
   #161223-00020#1---add---e
         
   #LET l_sql = " SELECT isaf_t.*,isag_t.* ",
   #            "   FROM isaf_t,isag_t ",
   #            "  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno ",
   #            "    AND isafent = ",g_enterprise,
   #            "    AND isafcomp='",g_comp,"' ",
   #            "    AND isafstus IN ('S' ,'Y') ",
   #            "    AND isafdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
   #            "    AND isag009 IS NOT NULL ",
   #            "    AND ",g_wc_ais CLIPPED
   
   #本月已开票，但开的是前月的部分的 --160107 mod
#   LET l_sql = " SELECT isaf_t.*,isag_t.* ",  #161124-00048#12 mark
   #161124-00048#12 add(s)
   LET l_sql = " SELECT isafent,isafsite,isafcomp,isafdocno,isafdocdt,isaf001,isaf002,isaf003,           ",
               "        isaf004,isaf005,isaf006,isaf007,isaf008,isaf009,isaf010,isaf011,isaf012,         ",
               "        isaf013,isaf014,isaf015,isaf016,isaf017,isaf018,isaf019,isaf020,isaf021,         ",
               "        isaf022,isaf023,isaf024,isaf025,isaf026,isaf027,isaf028,isaf029,isaf030,         ",
               "        isaf031,isaf032,isaf033,isaf034,isaf035,isaf036,isaf037,isaf038,isaf039,         ",
               "        isaf040,isaf041,isaf042,isaf043,isaf044,isaf045,isaf046,isaf047,isaf048,         ",
               "        isaf049,isaf050,isaf051,isaf052,isaf053,isaf054,isaf055,isaf056,isaf057,         ",
               "        isaf058,isaf100,isaf101,isaf103,isaf104,isaf105,isaf106,isaf107,isaf108,         ",
               "        isaf113,isaf114,isaf115,isaf116,isaf117,isaf118,isaf119,isaf120,isaf121,         ",
               "        isaf122,isaf123,isaf124,isaf201,isaf202,isaf203,isaf204,isaf205,isaf206,         ",
               "        isaf207,isaf208,isaf209,isaf210,isafstus,isafownid,isafowndp,isafcrtid,          ",
               "        isafcrtdp,isafcrtdt,isafmodid,isafmoddt,isafcnfid,isafcnfdt,isaf059,isaf060,     ",
               "        isaf061,isaf062,isaf063,isaf064,isaf065,isaf066,isaf067,isagent,isagcomp,        ",
               "        isagdocno,isagseq,isagorga,isag001,isag002,isag003,isag004,isag005,isag006,      ",
               "        isag007,isag008,isag009,isag010,isag011,isag012,isag013,isag014,isag015,isag016, ",
               "        isag017,isag101,isag103,isag104,isag105,isag106,isag113,isag114,isag115,isag116, ",
               "        isag117,isag126,isag127,isag128,isag136,isag137,isag138,isag018, ",               
   #161124-00048#12 add(e)
               "        imaa006 ",  #161223-00020#1 add
               "   FROM isaf_t,isag_t ",
               "   LEFT JOIN imaa_t ON imaaent = isagent AND imaa001 = isag009 ",   #161223-00020#1 add
               "  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno ",
               "    AND isafent = ",g_enterprise,
               "    AND isafcomp='",g_comp,"' ",
               "    AND isafstus IN ('S' ,'Y') ",
               "    AND isaf014 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND isag009 IS NOT NULL ",
               "    AND ",g_wc_ais CLIPPED   #,    #160706-00021#2 mark
               #160706-00021#2 mark--s
               #"    AND EXISTS (SELECT 1 FROM xmdk_t,xmdl_t,inaa_t ",
               #"                 WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
               #"                   AND inaaent = xmdlent AND inaasite  = xmdlsite  AND inaa001 = xmdl014 ",
               #"                   AND ((xmdk000 IN ('1','2','3','4','5') AND xmdk002 IN ('1','2')) ",
               #"                       OR xmdk000 ='6') ",   #销退
               #"                   AND xmdkent = ",g_enterprise,
               #"                   AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               #"                   AND ooefstus ='Y' AND ooef017 ='",g_comp,"')",
               #"                   AND xmdkstus='S' ",
               ##"                   AND xmdk001 < '",g_bdate,"' ",   #160603-00008#1
               #"                   AND inaa010 = 'Y' ",    #成本仓
               #"                   AND ",g_wc_axm CLIPPED,
               #"                   AND xmdldocno = isag002 ",  #来源单号
               #"                   AND xmdlseq   = isag003 ",   #来源项次
               #"               ) "
               #160706-00021#2 mark--e
   PREPARE axcp200_execute_ins_xckb_p2 FROM l_sql
   DECLARE axcp200_execute_ins_xckb_c2 CURSOR FOR axcp200_execute_ins_xckb_p2
   FOREACH axcp200_execute_ins_xckb_c2 INTO l_isaf.*,l_isag.*,l_imaa006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axcp200_execute_ins_xckb_c2'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #161223-00020#1---add---s  
      IF cl_null(l_imaa006) THEN
         #此料未維護基礎單位！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aim-00194'
         LET g_errparam.extend = l_isag.isag009
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      #161223-00020#1---add---e    
      INITIALIZE l_xckb.* TO NULL
      LET l_xckb.xckbent = g_enterprise      #企業代碼
      LET l_xckb.xckbcomp= g_comp            #法人，跟据点走，不是跟账别走
      LET l_xckb.xckbld  = g_master.glaald   #帳別        
      LET l_xckb.xckb001 = '4'               #來源:1为出货单，2为签收单，3为销退单，4发票                             
      LET l_xckb.xckb002 = -1                #方向:从出货/签收/销退取得的为1，表示转入发出商品档。
                                             #     从开票资料中取得的为-1，表示转出发出商品档
      LET l_xckb.xckb003 = l_isaf.isaf011    #發票號碼:出货/签收/销退单，赋值 “UNINVOICE”，表示未开票。
                                             #        开票资料，则将对应的发票号码写进去。
      IF cl_null(l_xckb.xckb003) THEN LET l_xckb.xckb003 = ' ' END IF      #160706-00021#2
      LET l_xckb.xckb004 = g_site            #據點site:为单据所在据点，而非当前操作据点
      #LET l_xckb.xckb005 = l_isaf.isafdocno #出貨單號    #160706-00021#2 mark
      LET l_xckb.xckb005 = l_isag.isag002    #出貨單號    #160706-00021#2
     #LET l_xckb.xckb006 = l_isag.isagseq    #出貨項次    #160804-00042#1 mark
      LET l_xckb.xckb006 = l_isag.isag003    #出貨項次    #160804-00042#1
      LET l_xckb.xckb036 = 0                 #出貨项序
      LET l_xckb.xckb007 = g_master.yy       #年度
      LET l_xckb.xckb008 = g_master.pp       #期別
      LET l_xckb.xckb009 = l_isaf.isaf003    #客戶編號
      LET l_xckb.xckb010 = l_isaf.isaf005    #人員編號
      LET l_xckb.xckb011 = l_isaf.isaf006    #部門編號
      LET l_xckb.xckb012 = l_isag.isag009    #產品編號
      #161223-00020#1---mod---s
      #SELECT xmdl009 INTO l_xckb.xckb037     #特性
      #  FROM xmdl_t
      # WHERE xmdlent   = g_enterprise
      #   AND xmdldocno = l_isag.isag002
      #   AND xmdlseq   = l_isag.isag003
      EXECUTE p200_xckb_pre5 USING l_isag.isag002,l_isag.isag003 INTO  l_xckb.xckb037
      #161223-00020#1---mod---e
         
      IF cl_null(l_xckb.xckb037) THEN LET l_xckb.xckb037 = ' ' END IF
      

      #170322-00109#1 add--s
      #按料件特性计算成本否
      IF g_sys_6013 = 'N' THEN
         LET l_xckb.xckb037 = ' '
      END IF
      #170322-00109#1 add--e
      
      LET l_xckb.xckb013 = l_isag.isag005    #銷售單位
     #LET l_xckb.xckb014 = l_isag.isag004    #數量         #160817-00005#1 mark
      #160817-00005#1--s
      IF NOT cl_null(l_isag.isag015) THEN 
         LET l_xckb.xckb014 = l_isag.isag004 * l_isag.isag015 
      ELSE 
         LET l_xckb.xckb014 = l_isag.isag004 
      END IF
      #160817-00005#1--e
      LET l_xckb.xckb015 = ' '               #倉庫編號
      LET l_xckb.xckb016 = ' '               #庫位編號
      LET l_xckb.xckb017 = ' '               #批號
      #LET l_xckb.xckb018 =  #no use
      LET l_xckb.xckb019 = l_isaf.isaf010    #發票代碼
      
      #161223-00020#1---mark---s
      #SELECT imaa006 INTO l_xckb.xckb020     #庫存單位
      #  FROM imaa_t
      # WHERE imaaent = g_enterprise
      #   AND imaa001 = l_xckb.xckb012   
      #IF cl_null(l_xckb.xckb020) THEN
      #   #此料未維護基礎單位！
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = 'aim-00194'
      #   LET g_errparam.extend = l_xckb.xckb012
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #   LET r_success = FALSE
      #   CONTINUE FOREACH
      #END IF
      #161223-00020#1---mark---e
      LET l_xckb.xckb020 = l_imaa006   #161223-00020#1 add
      CALL s_aooi250_convert_qty(l_xckb.xckb012,l_xckb.xckb013,l_xckb.xckb020,l_xckb.xckb014)
         RETURNING l_success,l_xckb.xckb021  #庫存數量
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #IF l_xckb.xckb002 = '1' THEN
      #   #转入：抓取agli161，存货类科目中的 发出商品科目glcc006
      #   LET l_type = 17  #取得科目類型:发出商品
      #ELSE
      #   #转出：科目抓取对应的主营业务成本科目。根据出货单对应到agli161抓取科目。
      #   LET l_type = 5   #取得科目類型
      #END IF
      #CALL s_get_item_acc(g_master.glaald,l_type,l_xckb.xckb012,'','',g_comp,'') 
     #CALL s_get_item_acc(g_master.glaald,5,l_xckb.xckb012,'','',g_comp,'')      #161012-00038#1 mark
      CALL s_get_item_acc(g_master.glaald,17,l_xckb.xckb012,'','',g_comp,'')     #161012-00038#1 add
        RETURNING l_success,l_xckb.xckb022     #科目編號
      IF cl_null(l_xckb.xckb022) THEN LET l_xckb.xckb022 = ' ' END IF
        
      LET l_xckb.xckb023 = 'N'                 #多角貿易否
      
      #转入不给值
      #LET l_xckb.xckb024 =                     #開票年度
      #LET l_xckb.xckb025 =                     #開票期別
      
      LET l_xckb.xckb026 = g_glaa001           #幣種一
      LET l_xckb.xckb027 = l_isag.isag115      #金額
      #LET l_xckb.xckb032 =  #no use
      #LET l_xckb.xckb033 =  #no use
      #LET l_xckb.xckb034 =  #no use
      #LET l_xckb.xckb035 =  #no use
      
      #成本域
      IF g_sys_6001 = 'N' THEN
         LET l_xcbf001 = ' '
      ELSE
        #CASE g_sys_6001 #170103-00022#1 mark
         CASE g_sys_6002 #170103-00022#1 add
              WHEN '1'  #组织
                 #161223-00020#1---mod---s
                 #  SELECT xcbf001 INTO l_xcbf001 FROM xcbf_t
                 #   WHERE xcbfent  = g_enterprise
                 #     AND xcbfcomp = g_comp
                 #     AND xcbf002  = l_xckb.xckb004  #据点
                 EXECUTE p200_xckb_pre1 USING l_xckb.xckb004 INTO l_xcbf001
                 #161223-00020#1---mod---e
              WHEN '2'  #仓库
                 #161223-00020#1---mod---e                      
                 #  SELECT xcbf001 INTO l_xcbf001 FROM xcbf_t
                 #   WHERE xcbfent  = g_enterprise
                 #     AND xcbfcomp = g_comp
                 #     AND xcbf002  = l_xckb.xckb015 #仓库
                 EXECUTE p200_xckb_pre1 USING l_xckb.xckb015 INTO l_xcbf001
                 #161223-00020#1---mod---e                      
              WHEN '3'  #库存管理特征
                   LET l_xcbf001 = l_xmdl.xmdl052
              OTHERWISE
                   LET l_xcbf001 = ' ' 
         END CASE
      END IF
      LET l_xckb.xckb038 = l_xcbf001   #成本域
      
      #161223-00020#1---mod---s         
      #SELECT xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h
      #  INTO l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d, #幣種一成本單價
      #                      l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,l_xckb.xckb101h  #幣種一成本單價
      #  FROM xccc_t
      # WHERE xcccent = g_enterprise
      #   AND xcccld  = l_xckb.xckbld #帐套
      #   AND xccc001 = '1'           #帐套本位币顺序
      #   AND xccc002 = l_xckb.xckb038 #成本域
      #   AND xccc003 = g_xcat001      #成本计算类型
      #   AND xccc004 = l_xckb.xckb007 #年度
      #   AND xccc005 = l_xckb.xckb008 #期别
      #   AND xccc006 = l_xckb.xckb012 #料号
      #   AND xccc007 = l_xckb.xckb037 #特性
      #   AND xccc008 = l_xckb.xckb017 #批号
      
      #170414-00057#1---s
      LET l_xckb007 = l_xckb.xckb007
      LET l_xckb008 = l_xckb.xckb008         
   
      IF g_sys_6005='1' THEN
         #從xckb的銷退單號, 串回原退貨單xmdl, 查到該銷退單對應的出貨單及月份        
         LET l_xmdkdocdt=NULL 
         SELECT  xmdkdocdt INTO l_xmdkdocdt    #add renjj170301  按扣账日期算
           FROM xmdl_t,xmdk_t   
           WHERE xmdlent = g_enterprise
           AND xmdldocno = l_xckb.xckb005 AND xmdlseq = l_xckb.xckb006
           AND xmdlent = xmdkent AND xmdl001 = xmdkdocno AND xmdldocno IN (SELECT m.xmdkdocno FROM xmdk_t m WHERE xmdk000='6')
         IF cl_null(l_xmdkdocdt) THEN
            SELECT xmdkdocdt INTO l_xmdkdocdt
              FROM xmdk_t WHERE xmdkdocno=l_xckb.xckb005
               AND xmdkent = g_enterprise AND xmdk000='6'
         END IF
         IF NOT cl_null(l_xmdkdocdt) THEN
            LET l_xckb007=YEAR(l_xmdkdocdt)
            LET l_xckb008=month(l_xmdkdocdt) 
         END IF
      END IF     
      #170414-00057#1---e
      EXECUTE p200_xckb_pre3 USING l_xckb.xckb038,l_xckb.xckb007,l_xckb.xckb008,
                                   l_xckb.xckb012,l_xckb.xckb037,l_xckb.xckb017
         INTO l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d, #幣種一成本單價
                             l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,l_xckb.xckb101h  #幣種一成本單價                                  
      #161223-00020#1---mod---e     
      LET l_xckb.xckb102  = l_xckb.xckb101  * l_xckb.xckb021 #幣種一成本金額       
      LET l_xckb.xckb102a = l_xckb.xckb101a * l_xckb.xckb021 #幣種一成本金額-材料  
      LET l_xckb.xckb102b = l_xckb.xckb101b * l_xckb.xckb021 #幣種一成本金額-人工  
      LET l_xckb.xckb102c = l_xckb.xckb101c * l_xckb.xckb021 #幣種一成本金額-加工  
      LET l_xckb.xckb102d = l_xckb.xckb101d * l_xckb.xckb021 #幣種一成本金額-制費一
      LET l_xckb.xckb102e = l_xckb.xckb101e * l_xckb.xckb021 #幣種一成本金額-制費二
      LET l_xckb.xckb102f = l_xckb.xckb101f * l_xckb.xckb021 #幣種一成本金額-制費三
      LET l_xckb.xckb102g = l_xckb.xckb101g * l_xckb.xckb021 #幣種一成本金額-制費四
      LET l_xckb.xckb102h = l_xckb.xckb101h * l_xckb.xckb021 #幣種一成本金額-制費五
      CALL s_num_round(g_round_type,l_xckb.xckb102 ,g_ooaj007_1) RETURNING l_xckb.xckb102
      CALL s_num_round(g_round_type,l_xckb.xckb102a,g_ooaj007_1) RETURNING l_xckb.xckb102a
      CALL s_num_round(g_round_type,l_xckb.xckb102b,g_ooaj007_1) RETURNING l_xckb.xckb102b
      CALL s_num_round(g_round_type,l_xckb.xckb102c,g_ooaj007_1) RETURNING l_xckb.xckb102c
      CALL s_num_round(g_round_type,l_xckb.xckb102d,g_ooaj007_1) RETURNING l_xckb.xckb102d
      CALL s_num_round(g_round_type,l_xckb.xckb102e,g_ooaj007_1) RETURNING l_xckb.xckb102e
      CALL s_num_round(g_round_type,l_xckb.xckb102f,g_ooaj007_1) RETURNING l_xckb.xckb102f
      CALL s_num_round(g_round_type,l_xckb.xckb102g,g_ooaj007_1) RETURNING l_xckb.xckb102g
      CALL s_num_round(g_round_type,l_xckb.xckb102h,g_ooaj007_1) RETURNING l_xckb.xckb102h
      
      IF g_glaa015 = 'Y' THEN  #啟用本位幣二
         LET l_xckb.xckb028 = g_glaa016           #幣種二
         IF l_xckb.xckb027 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,l_isaf.isafdocdt,l_xckb.xckb026,l_xckb.xckb028,l_xckb.xckb027,g_glaa018)
                 RETURNING l_xckb.xckb029            #金額
         END IF
         #成本金额
         IF l_xckb.xckb101 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101 ,g_glaa018) RETURNING l_xckb.xckb111  #幣種二成本單價      
         END IF 
         IF l_xckb.xckb101a!= 0 THEN 
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101a,g_glaa018) RETURNING l_xckb.xckb111a #幣種二成本單價-材料  
         END IF
         IF l_xckb.xckb101b!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101b,g_glaa018) RETURNING l_xckb.xckb111b #幣種二成本單價-人工 
         END IF 
         IF l_xckb.xckb101c!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101c,g_glaa018) RETURNING l_xckb.xckb111c #幣種二成本單價-加工  
         END IF
         IF l_xckb.xckb101d!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101d,g_glaa018) RETURNING l_xckb.xckb111d #幣種二成本單價-制費一
         END IF
         IF l_xckb.xckb101e!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101e,g_glaa018) RETURNING l_xckb.xckb111e #幣種二成本單價-制費二
         END IF
         IF l_xckb.xckb101f!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101f,g_glaa018) RETURNING l_xckb.xckb111f #幣種二成本單價-制費三
         END IF
         IF l_xckb.xckb101g!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101g,g_glaa018) RETURNING l_xckb.xckb111g #幣種二成本單價-制費四
         END IF
         IF l_xckb.xckb101h!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa016,l_xckb.xckb101h,g_glaa018) RETURNING l_xckb.xckb111h #幣種二成本單價-制費五
         END IF
         CALL s_num_round(g_round_type,l_xckb.xckb111 ,g_ooaj006_2) RETURNING l_xckb.xckb111 
         CALL s_num_round(g_round_type,l_xckb.xckb111a,g_ooaj006_2) RETURNING l_xckb.xckb111a
         CALL s_num_round(g_round_type,l_xckb.xckb111b,g_ooaj006_2) RETURNING l_xckb.xckb111b
         CALL s_num_round(g_round_type,l_xckb.xckb111c,g_ooaj006_2) RETURNING l_xckb.xckb111c
         CALL s_num_round(g_round_type,l_xckb.xckb111d,g_ooaj006_2) RETURNING l_xckb.xckb111d
         CALL s_num_round(g_round_type,l_xckb.xckb111e,g_ooaj006_2) RETURNING l_xckb.xckb111e
         CALL s_num_round(g_round_type,l_xckb.xckb111f,g_ooaj006_2) RETURNING l_xckb.xckb111f
         CALL s_num_round(g_round_type,l_xckb.xckb111g,g_ooaj006_2) RETURNING l_xckb.xckb111g
         CALL s_num_round(g_round_type,l_xckb.xckb111h,g_ooaj006_2) RETURNING l_xckb.xckb111h
         LET l_xckb.xckb112  = l_xckb.xckb111  * l_xckb.xckb021 #幣種二成本金額       
         LET l_xckb.xckb112a = l_xckb.xckb111a * l_xckb.xckb021 #幣種二成本金額-材料  
         LET l_xckb.xckb112b = l_xckb.xckb111b * l_xckb.xckb021 #幣種二成本金額-人工  
         LET l_xckb.xckb112c = l_xckb.xckb111c * l_xckb.xckb021 #幣種二成本金額-加工  
         LET l_xckb.xckb112d = l_xckb.xckb111d * l_xckb.xckb021 #幣種二成本金額-制費一
         LET l_xckb.xckb112e = l_xckb.xckb111e * l_xckb.xckb021 #幣種二成本金額-制費二
         LET l_xckb.xckb112f = l_xckb.xckb111f * l_xckb.xckb021 #幣種二成本金額-制費三
         LET l_xckb.xckb112g = l_xckb.xckb111g * l_xckb.xckb021 #幣種二成本金額-制費四
         LET l_xckb.xckb112h = l_xckb.xckb111h * l_xckb.xckb021 #幣種二成本金額-制費五   
         CALL s_num_round(g_round_type,l_xckb.xckb112 ,g_ooaj007_2) RETURNING l_xckb.xckb112 
         CALL s_num_round(g_round_type,l_xckb.xckb112a,g_ooaj007_2) RETURNING l_xckb.xckb112a
         CALL s_num_round(g_round_type,l_xckb.xckb112b,g_ooaj007_2) RETURNING l_xckb.xckb112b
         CALL s_num_round(g_round_type,l_xckb.xckb112c,g_ooaj007_2) RETURNING l_xckb.xckb112c
         CALL s_num_round(g_round_type,l_xckb.xckb112d,g_ooaj007_2) RETURNING l_xckb.xckb112d
         CALL s_num_round(g_round_type,l_xckb.xckb112e,g_ooaj007_2) RETURNING l_xckb.xckb112e
         CALL s_num_round(g_round_type,l_xckb.xckb112f,g_ooaj007_2) RETURNING l_xckb.xckb112f
         CALL s_num_round(g_round_type,l_xckb.xckb112g,g_ooaj007_2) RETURNING l_xckb.xckb112g
         CALL s_num_round(g_round_type,l_xckb.xckb112h,g_ooaj007_2) RETURNING l_xckb.xckb112h
      END IF
      IF g_glaa019 = 'Y' THEN  #啟用本位幣三
         LET l_xckb.xckb030 = g_glaa020           #幣種三
         IF l_xckb.xckb027 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,l_isaf.isafdocdt,l_xckb.xckb026,l_xckb.xckb030,l_xckb.xckb027,g_glaa022)
                 RETURNING l_xckb.xckb031            #金額
         END IF
         #成本金额
         IF l_xckb.xckb101 != 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101 ,g_glaa022) RETURNING l_xckb.xckb121  #幣種三成本單價    
         END IF    
         IF l_xckb.xckb101a!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101a,g_glaa022) RETURNING l_xckb.xckb121a #幣種三成本單價-材料  
         END IF
         IF l_xckb.xckb101b!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101b,g_glaa022) RETURNING l_xckb.xckb121b #幣種三成本單價-人工  
         END IF
         IF l_xckb.xckb101c!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101c,g_glaa022) RETURNING l_xckb.xckb121c #幣種三成本單價-加工  
         END IF
         IF l_xckb.xckb101d!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101d,g_glaa022) RETURNING l_xckb.xckb121d #幣種三成本單價-制費一
         END IF
         IF l_xckb.xckb101e!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101e,g_glaa022) RETURNING l_xckb.xckb121e #幣種三成本單價-制費二
         END IF
         IF l_xckb.xckb101f!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101f,g_glaa022) RETURNING l_xckb.xckb121f #幣種三成本單價-制費三
         END IF
         IF l_xckb.xckb101g!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101g,g_glaa022) RETURNING l_xckb.xckb121g #幣種三成本單價-制費四
         END IF
         IF l_xckb.xckb101h!= 0 THEN
            CALL s_aooi160_get_exrate('2',l_xckb.xckbld,g_today,g_glaa001,g_glaa020,l_xckb.xckb101h,g_glaa022) RETURNING l_xckb.xckb121h #幣種三成本單價-制費五
         END IF
         CALL s_num_round(g_round_type,l_xckb.xckb121 ,g_ooaj006_3) RETURNING l_xckb.xckb121 
         CALL s_num_round(g_round_type,l_xckb.xckb121a,g_ooaj006_3) RETURNING l_xckb.xckb121a
         CALL s_num_round(g_round_type,l_xckb.xckb121b,g_ooaj006_3) RETURNING l_xckb.xckb121b
         CALL s_num_round(g_round_type,l_xckb.xckb121c,g_ooaj006_3) RETURNING l_xckb.xckb121c
         CALL s_num_round(g_round_type,l_xckb.xckb121d,g_ooaj006_3) RETURNING l_xckb.xckb121d
         CALL s_num_round(g_round_type,l_xckb.xckb121e,g_ooaj006_3) RETURNING l_xckb.xckb121e
         CALL s_num_round(g_round_type,l_xckb.xckb121f,g_ooaj006_3) RETURNING l_xckb.xckb121f
         CALL s_num_round(g_round_type,l_xckb.xckb121g,g_ooaj006_3) RETURNING l_xckb.xckb121g
         CALL s_num_round(g_round_type,l_xckb.xckb121h,g_ooaj006_3) RETURNING l_xckb.xckb121h
         LET l_xckb.xckb122  = l_xckb.xckb121  * l_xckb.xckb021 #幣種三成本金額
         LET l_xckb.xckb122a = l_xckb.xckb121a * l_xckb.xckb021 #幣種三成本金額-材料
         LET l_xckb.xckb122b = l_xckb.xckb121b * l_xckb.xckb021 #幣種三成本金額-人工
         LET l_xckb.xckb122c = l_xckb.xckb121c * l_xckb.xckb021 #幣種三成本金額-加工
         LET l_xckb.xckb122d = l_xckb.xckb121d * l_xckb.xckb021 #幣種三成本金額-制費一
         LET l_xckb.xckb122e = l_xckb.xckb121e * l_xckb.xckb021 #幣種三成本金額-制費二
         LET l_xckb.xckb122f = l_xckb.xckb121f * l_xckb.xckb021 #幣種三成本金額-制費三
         LET l_xckb.xckb122g = l_xckb.xckb121g * l_xckb.xckb021 #幣種三成本金額-制費四
         LET l_xckb.xckb122h = l_xckb.xckb121h * l_xckb.xckb021 #幣種三成本金額-制費五
         CALL s_num_round(g_round_type,l_xckb.xckb122 ,g_ooaj007_3) RETURNING l_xckb.xckb122 
         CALL s_num_round(g_round_type,l_xckb.xckb122a,g_ooaj007_3) RETURNING l_xckb.xckb122a
         CALL s_num_round(g_round_type,l_xckb.xckb122b,g_ooaj007_3) RETURNING l_xckb.xckb122b
         CALL s_num_round(g_round_type,l_xckb.xckb122c,g_ooaj007_3) RETURNING l_xckb.xckb122c
         CALL s_num_round(g_round_type,l_xckb.xckb122d,g_ooaj007_3) RETURNING l_xckb.xckb122d
         CALL s_num_round(g_round_type,l_xckb.xckb122e,g_ooaj007_3) RETURNING l_xckb.xckb122e
         CALL s_num_round(g_round_type,l_xckb.xckb122f,g_ooaj007_3) RETURNING l_xckb.xckb122f
         CALL s_num_round(g_round_type,l_xckb.xckb122g,g_ooaj007_3) RETURNING l_xckb.xckb122g
         CALL s_num_round(g_round_type,l_xckb.xckb122h,g_ooaj007_3) RETURNING l_xckb.xckb122h
      END IF

      CALL axcp200_execute_ins_xckb_null_zero(l_xckb.*)
         RETURNING l_xckb.*
      
#      INSERT INTO xckb_t VALUES (l_xckb.*)  #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO xckb_t(xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb004,xckb005,
                         xckb006,xckb007,xckb008,xckb009,xckb010,xckb011,xckb012,xckb013,
                         xckb014,xckb015,xckb016,xckb017,xckb018,xckb019,xckb020,xckb021,
                         xckb022,xckb023,xckb024,xckb025,xckb026,xckb027,xckb028,xckb029,
                         xckb030,xckb031,xckb032,xckb033,xckb034,xckb035,xckb036,xckb037,
                         xckb101,xckb101a,xckb101b,xckb101c,xckb101d,xckb101e,xckb101f,xckb101g,
                         xckb101h,xckb102,xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,xckb102f,
                         xckb102g,xckb102h,xckb111,xckb111a,xckb111b,xckb111c,xckb111d,xckb111e,
                         xckb111f,xckb111g,xckb111h,xckb112,xckb112a,xckb112b,xckb112c,xckb112d,
                         xckb112e,xckb112f,xckb112g,xckb112h,xckb121,xckb121a,xckb121b,xckb121c,
                         xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,xckb122,xckb122a,xckb122b,
                         xckb122c,xckb122d,xckb122e,xckb122f,xckb122g,xckb122h,xckb038) 
                 VALUES (l_xckb.xckbent,l_xckb.xckbcomp,l_xckb.xckbld,l_xckb.xckb001,l_xckb.xckb002,l_xckb.xckb003,l_xckb.xckb004,l_xckb.xckb005,
                         l_xckb.xckb006,l_xckb.xckb007,l_xckb.xckb008,l_xckb.xckb009,l_xckb.xckb010,l_xckb.xckb011,l_xckb.xckb012,l_xckb.xckb013,
                         l_xckb.xckb014,l_xckb.xckb015,l_xckb.xckb016,l_xckb.xckb017,l_xckb.xckb018,l_xckb.xckb019,l_xckb.xckb020,l_xckb.xckb021,
                         l_xckb.xckb022,l_xckb.xckb023,l_xckb.xckb024,l_xckb.xckb025,l_xckb.xckb026,l_xckb.xckb027,l_xckb.xckb028,l_xckb.xckb029,
                         l_xckb.xckb030,l_xckb.xckb031,l_xckb.xckb032,l_xckb.xckb033,l_xckb.xckb034,l_xckb.xckb035,l_xckb.xckb036,l_xckb.xckb037,
                         l_xckb.xckb101,l_xckb.xckb101a,l_xckb.xckb101b,l_xckb.xckb101c,l_xckb.xckb101d,l_xckb.xckb101e,l_xckb.xckb101f,l_xckb.xckb101g,
                         l_xckb.xckb101h,l_xckb.xckb102,l_xckb.xckb102a,l_xckb.xckb102b,l_xckb.xckb102c,l_xckb.xckb102d,l_xckb.xckb102e,l_xckb.xckb102f,
                         l_xckb.xckb102g,l_xckb.xckb102h,l_xckb.xckb111,l_xckb.xckb111a,l_xckb.xckb111b,l_xckb.xckb111c,l_xckb.xckb111d,l_xckb.xckb111e,
                         l_xckb.xckb111f,l_xckb.xckb111g,l_xckb.xckb111h,l_xckb.xckb112,l_xckb.xckb112a,l_xckb.xckb112b,l_xckb.xckb112c,l_xckb.xckb112d,
                         l_xckb.xckb112e,l_xckb.xckb112f,l_xckb.xckb112g,l_xckb.xckb112h,l_xckb.xckb121,l_xckb.xckb121a,l_xckb.xckb121b,l_xckb.xckb121c,
                         l_xckb.xckb121d,l_xckb.xckb121e,l_xckb.xckb121f,l_xckb.xckb121g,l_xckb.xckb121h,l_xckb.xckb122,l_xckb.xckb122a,l_xckb.xckb122b,
                         l_xckb.xckb122c,l_xckb.xckb122d,l_xckb.xckb122e,l_xckb.xckb122f,l_xckb.xckb122g,l_xckb.xckb122h,l_xckb.xckb038)
      #161124-00048#12 add(e)
      LET l_count = l_count + 1
   END FOREACH
   IF l_count = 0 THEN
      #所选条件范围内无资料!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00697'
      LET g_errparam.extend = 'Select glaa003'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
   
END FUNCTION

#发出商品汇总统计档——用于汇总查询发出商品金额
#根据月度统计资料，汇总获得xckc发出商品当月的汇总统计档。
PRIVATE FUNCTION axcp200_execute_ins_xckc()
#170220-00032#1---mark---s   
#   DEFINE r_success  LIKE type_t.num5
#   DEFINE l_success  LIKE type_t.num5
#   DEFINE l_sql    STRING
##   DEFINE l_xckc   RECORD LIKE xckc_t.* #161124-00048#12 mark
#   DEFINE l_xckc RECORD  #發出商品匯總統計檔
#       xckcent LIKE xckc_t.xckcent, #企业编号
#       xckccomp LIKE xckc_t.xckccomp, #法人
#       xckcld LIKE xckc_t.xckcld, #账套
#       xckc001 LIKE xckc_t.xckc001, #年度
#       xckc002 LIKE xckc_t.xckc002, #期别
#       xckc003 LIKE xckc_t.xckc003, #客户编号
#       xckc004 LIKE xckc_t.xckc004, #产品编号
#       xckc005 LIKE xckc_t.xckc005, #科目编号
#       xckc006 LIKE xckc_t.xckc006, #库存单位
#       xckc007 LIKE xckc_t.xckc007, #期初数量
#       xckc008 LIKE xckc_t.xckc008, #期初金额
#       xckc009 LIKE xckc_t.xckc009, #本月出货数量
#       xckc010 LIKE xckc_t.xckc010, #本月出货金额
#       xckc011 LIKE xckc_t.xckc011, #本月转出数量
#       xckc012 LIKE xckc_t.xckc012, #本月转出金额
#       xckc013 LIKE xckc_t.xckc013, #期末数量
#       xckc014 LIKE xckc_t.xckc014, #期末金额
#       xckc015 LIKE xckc_t.xckc015, #币种二期初金额
#       xckc016 LIKE xckc_t.xckc016, #币种二本月出货金额
#       xckc017 LIKE xckc_t.xckc017, #币种二本月转出金额
#       xckc018 LIKE xckc_t.xckc018, #币种二期末金额
#       xckc019 LIKE xckc_t.xckc019, #币种三期初金额
#       xckc020 LIKE xckc_t.xckc020, #币种三本月出货金额
#       xckc021 LIKE xckc_t.xckc021, #币种三本月转出金额
#       xckc022 LIKE xckc_t.xckc022, #币种三期末金额
#       xckc023 LIKE xckc_t.xckc023, #特性
#       xckc008a LIKE xckc_t.xckc008a, #期初金额-材料
#       xckc008b LIKE xckc_t.xckc008b, #期初金额-人工
#       xckc008c LIKE xckc_t.xckc008c, #期初金额-加工
#       xckc008d LIKE xckc_t.xckc008d, #期初金额-制费一
#       xckc008e LIKE xckc_t.xckc008e, #期初金额-制费二
#       xckc008f LIKE xckc_t.xckc008f, #期初金额-制费三
#       xckc008g LIKE xckc_t.xckc008g, #期初金额-制费四
#       xckc008h LIKE xckc_t.xckc008h, #期初金额-制费五
#       xckc010a LIKE xckc_t.xckc010a, #本月出货金额-材料
#       xckc010b LIKE xckc_t.xckc010b, #本月出货金额-人工
#       xckc010c LIKE xckc_t.xckc010c, #本月出货金额-加工
#       xckc010d LIKE xckc_t.xckc010d, #本月出货金额-制费一
#       xckc010e LIKE xckc_t.xckc010e, #本月出货金额-制费二
#       xckc010f LIKE xckc_t.xckc010f, #本月出货金额-制费三
#       xckc010g LIKE xckc_t.xckc010g, #本月出货金额-制费四
#       xckc010h LIKE xckc_t.xckc010h, #本月出货金额-制费五
#       xckc012a LIKE xckc_t.xckc012a, #本月转出金额-材料
#       xckc012b LIKE xckc_t.xckc012b, #本月转出金额-人工
#       xckc012c LIKE xckc_t.xckc012c, #本月转出金额-加工
#       xckc012d LIKE xckc_t.xckc012d, #本月转出金额-制费一
#       xckc012e LIKE xckc_t.xckc012e, #本月转出金额-制费二
#       xckc012f LIKE xckc_t.xckc012f, #本月转出金额-制费三
#       xckc012g LIKE xckc_t.xckc012g, #本月转出金额-制费四
#       xckc012h LIKE xckc_t.xckc012h, #本月转出金额-制费五
#       xckc014a LIKE xckc_t.xckc014a, #期末金额-材料
#       xckc014b LIKE xckc_t.xckc014b, #期末金额-人工
#       xckc014c LIKE xckc_t.xckc014c, #期末金额-加工
#       xckc014d LIKE xckc_t.xckc014d, #期末金额-制费一
#       xckc014e LIKE xckc_t.xckc014e, #期末金额-制费二
#       xckc014f LIKE xckc_t.xckc014f, #期末金额-制费三
#       xckc014g LIKE xckc_t.xckc014g, #期末金额-制费四
#       xckc014h LIKE xckc_t.xckc014h, #期末金额-制费五
#       xckc015a LIKE xckc_t.xckc015a, #币种二期初金额-材料
#       xckc015b LIKE xckc_t.xckc015b, #币种二期初金额-人工
#       xckc015c LIKE xckc_t.xckc015c, #币种二期初金额-加工
#       xckc015d LIKE xckc_t.xckc015d, #币种二期初金额-制费一
#       xckc015e LIKE xckc_t.xckc015e, #币种二期初金额-制费二
#       xckc015f LIKE xckc_t.xckc015f, #币种二期初金额-制费三
#       xckc015g LIKE xckc_t.xckc015g, #币种二期初金额-制费四
#       xckc015h LIKE xckc_t.xckc015h, #币种二期初金额-制费五
#       xckc016a LIKE xckc_t.xckc016a, #币种二本月出货金额-材料
#       xckc016b LIKE xckc_t.xckc016b, #币种二本月出货金额-人工
#       xckc016c LIKE xckc_t.xckc016c, #币种二本月出货金额-加工
#       xckc016d LIKE xckc_t.xckc016d, #币种二本月出货金额-制费一
#       xckc016e LIKE xckc_t.xckc016e, #币种二本月出货金额-制费二
#       xckc016f LIKE xckc_t.xckc016f, #币种二本月出货金额-制费三
#       xckc016g LIKE xckc_t.xckc016g, #币种二本月出货金额-制费四
#       xckc016h LIKE xckc_t.xckc016h, #币种二本月出货金额-制费五
#       xckc017a LIKE xckc_t.xckc017a, #币种二本月转出金额-材料
#       xckc017b LIKE xckc_t.xckc017b, #币种二本月转出金额-人工
#       xckc017c LIKE xckc_t.xckc017c, #币种二本月转出金额-加工
#       xckc017d LIKE xckc_t.xckc017d, #币种二本月转出金额-制费一
#       xckc017e LIKE xckc_t.xckc017e, #币种二本月转出金额-制费二
#       xckc017f LIKE xckc_t.xckc017f, #币种二本月转出金额-制费三
#       xckc017g LIKE xckc_t.xckc017g, #币种二本月转出金额-制费四
#       xckc017h LIKE xckc_t.xckc017h, #币种二本月转出金额-制费五
#       xckc018a LIKE xckc_t.xckc018a, #币种二期末金额-材料
#       xckc018b LIKE xckc_t.xckc018b, #币种二期末金额-人工
#       xckc018c LIKE xckc_t.xckc018c, #币种二期末金额-加工
#       xckc018d LIKE xckc_t.xckc018d, #币种二期末金额-制费一
#       xckc018e LIKE xckc_t.xckc018e, #币种二期末金额-制费二
#       xckc018f LIKE xckc_t.xckc018f, #币种二期末金额-制费三
#       xckc018g LIKE xckc_t.xckc018g, #币种二期末金额-制费四
#       xckc018h LIKE xckc_t.xckc018h, #币种二期末金额-制费五
#       xckc019a LIKE xckc_t.xckc019a, #币种三期初金额-材料
#       xckc019b LIKE xckc_t.xckc019b, #币种三期初金额-人工
#       xckc019c LIKE xckc_t.xckc019c, #币种三期初金额-加工
#       xckc019d LIKE xckc_t.xckc019d, #币种三期初金额-制费一
#       xckc019e LIKE xckc_t.xckc019e, #币种三期初金额-制费二
#       xckc019f LIKE xckc_t.xckc019f, #币种三期初金额-制费三
#       xckc019g LIKE xckc_t.xckc019g, #币种三期初金额-制费四
#       xckc019h LIKE xckc_t.xckc019h, #币种三期初金额-制费五
#       xckc020a LIKE xckc_t.xckc020a, #币种三本月出货金额-材料
#       xckc020b LIKE xckc_t.xckc020b, #币种三本月出货金额-人工
#       xckc020c LIKE xckc_t.xckc020c, #币种三本月出货金额-加工
#       xckc020d LIKE xckc_t.xckc020d, #币种三本月出货金额-制费一
#       xckc020e LIKE xckc_t.xckc020e, #币种三本月出货金额-制费二
#       xckc020f LIKE xckc_t.xckc020f, #币种三本月出货金额-制费三
#       xckc020g LIKE xckc_t.xckc020g, #币种三本月出货金额-制费四
#       xckc020h LIKE xckc_t.xckc020h, #币种三本月出货金额-制费五
#       xckc021a LIKE xckc_t.xckc021a, #币种三本月转出金额-材料
#       xckc021b LIKE xckc_t.xckc021b, #币种三本月转出金额-人工
#       xckc021c LIKE xckc_t.xckc021c, #币种三本月转出金额-加工
#       xckc021d LIKE xckc_t.xckc021d, #币种三本月转出金额-制费一
#       xckc021e LIKE xckc_t.xckc021e, #币种三本月转出金额-制费二
#       xckc021f LIKE xckc_t.xckc021f, #币种三本月转出金额-制费三
#       xckc021g LIKE xckc_t.xckc021g, #币种三本月转出金额-制费四
#       xckc021h LIKE xckc_t.xckc021h, #币种三本月转出金额-制费五
#       xckc022a LIKE xckc_t.xckc022a, #币种三期末金额-材料
#       xckc022b LIKE xckc_t.xckc022b, #币种三期末金额-人工
#       xckc022c LIKE xckc_t.xckc022c, #币种三期末金额-加工
#       xckc022d LIKE xckc_t.xckc022d, #币种三期末金额-制费一
#       xckc022e LIKE xckc_t.xckc022e, #币种三期末金额-制费二
#       xckc022f LIKE xckc_t.xckc022f, #币种三期末金额-制费三
#       xckc022g LIKE xckc_t.xckc022g, #币种三期末金额-制费四
#       xckc022h LIKE xckc_t.xckc022h  #币种三期末金额-制费五
#END RECORD
#   DEFINE l_msg    STRING #160328-00022#5
#
#
#   LET r_success = TRUE
#
#   #160328-00022#5-s-add
#   IF g_bgjob <> "Y" THEN 
#      LET l_msg = cl_getmsg_parm("axc-00783",g_lang,'')  #抓取開票資料寫入發出商品統計檔！
#      CALL cl_progress_no_window_ing(l_msg)          
#   END IF      
#   #160328-00022#5-e-add 
#
#   LET g_wc = g_master.wc
#   LET g_wc= cl_replace_str(g_wc,"pmaa001","xckb009") #客戶
#   LET g_wc= cl_replace_str(g_wc,"imaa001","xckb012") #產品編號
#   LET l_sql="INSERT INTO xckc_t(xckcent,xckccomp,xckcld,xckc001,xckc002,xckc003,xckc004,xckc023,xckc005,xckc006,",
#             #                   期初数  金额     本月出货数 金额  本月转出数 金额   期末数  金额
#             "                   xckc007,xckc008,xckc009,xckc010,xckc011,xckc012,xckc013,xckc014,",
#             #                币种2期初/本月出货/本月转出/期末金额  币种3期初/本月出货/本月转出/期末金额
#             "                   xckc015,xckc016,xckc017,xckc018,xckc019,xckc020,xckc021,xckc022, ",
#             "                   xckc008a,xckc008b,xckc008c,xckc008d,xckc008e,xckc008f,xckc008g,xckc008h, ",
#             "                   xckc010a,xckc010b,xckc010c,xckc010d,xckc010e,xckc010f,xckc010g,xckc010h, ",
#             "                   xckc012a,xckc012b,xckc012c,xckc012d,xckc012e,xckc012f,xckc012g,xckc012h, ",
#             "                   xckc014a,xckc014b,xckc014c,xckc014d,xckc014e,xckc014f,xckc014g,xckc014h, ",
#             "                   xckc015a,xckc015b,xckc015c,xckc015d,xckc015e,xckc015f,xckc015g,xckc015h, ",
#             "                   xckc016a,xckc016b,xckc016c,xckc016d,xckc016e,xckc016f,xckc016g,xckc016h, ",
#             "                   xckc017a,xckc017b,xckc017c,xckc017d,xckc017e,xckc017f,xckc017g,xckc017h, ",
#             "                   xckc018a,xckc018b,xckc018c,xckc018d,xckc018e,xckc018f,xckc018g,xckc018h, ",
#             "                   xckc019a,xckc019b,xckc019c,xckc019d,xckc019e,xckc019f,xckc019g,xckc019h, ",
#             "                   xckc020a,xckc020b,xckc020c,xckc020d,xckc020e,xckc020f,xckc020g,xckc020h, ",
#             "                   xckc021a,xckc021b,xckc021c,xckc021d,xckc021e,xckc021f,xckc021g,xckc021h, ",
#             "                   xckc022a,xckc022b,xckc022c,xckc022d,xckc022e,xckc022f,xckc022g,xckc022h) ",
#             "SELECT UNIQUE xckbent,xckbcomp,xckbld,xckb007,xckb008,xckb009,xckb012,xckb037,NVL(xckb022,' '),xckb020,",
#             "       0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0, ",
#             "       0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0, ",
#             "       0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0, ",
#             "       0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0  ",
#             "  FROM xckb_t ",
#             " WHERE xckbent = ",g_enterprise,     #企業代碼
#             "   AND xckbcomp='",g_comp,"' ",      #法人，跟据点走，不是跟账别走
#             "   AND xckbld  ='",g_master.glaald,"' ",  #帳別
#             "   AND xckb007 = ",g_master.yy,      #年度
#             "   AND xckb008 = ",g_master.pp,      #期別
#             "   AND ",g_wc
#   PREPARE axcp200_execute_ins_xckc_p FROM l_sql
#   EXECUTE axcp200_execute_ins_xckc_p
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'axcp200_execute_ins_xckc_p'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   
#   #期初 
#   #LET g_wc = g_master.wc
#   #LET g_wc = cl_replace_str(g_wc,"pmaa001","xckc003") #客戶
#   #LET g_wc = cl_replace_str(g_wc,"imaa001","xckc004") #產品編號
#   LET l_sql = " MERGE INTO xckc_t a ",
#               " USING ( SELECT xckc_t.* FROM xckc_t ",
#               "          WHERE xckcent = ",g_enterprise,
#               "            AND xckccomp='",g_comp,"' ",
#               "            AND xckcld  = '",g_master.glaald,"'",
#               "            AND xckc001 = ",g_last_yy,  #年度-上期
#               "            AND xckc002 = ",g_last_pp,  #期别-上期
#               "            AND (xckc013 <> 0 OR xckc014 <> 0 )", #170105-00068#1 add 
#               #"            AND ",g_wc,
#               "       ) b ",
#               "    ON ( a.xckcent = b.xckcent         ",
#               "     AND a.xckccomp= b.xckccomp        ",
#               "     AND a.xckcld  = b.xckcld          ",
#               "     AND a.xckc001 = ",g_master.yy, #年度-本期
#               "     AND a.xckc002 = ",g_master.pp, #期别-本期
#               "     AND a.xckc003 = b.xckc003         ", #客戶
#               "     AND a.xckc004 = b.xckc004         ", #產品
#               "     AND a.xckc023 = b.xckc023)         ", #特性   #170105-00068#1 add )
#               #"     AND a.xckc005 = b.xckc005 )       ", #科目  #170105-00068#1 mark 
#               "  WHEN MATCHED THEN                          ",
#               "       UPDATE SET a.xckc007  = nvl(b.xckc013,0) ,   ",  #期初数量
#               "                  a.xckc008  = nvl(b.xckc014,0) ,   ",  #期初金额
#               "                  a.xckc008a = nvl(b.xckc014a,0) ,   ",  #期初金额
#               "                  a.xckc008b = nvl(b.xckc014b,0) ,   ",  #期初金额
#               "                  a.xckc008c = nvl(b.xckc014c,0) ,   ",  #期初金额
#               "                  a.xckc008d = nvl(b.xckc014d,0) ,   ",  #期初金额
#               "                  a.xckc008e = nvl(b.xckc014e,0) ,   ",  #期初金额
#               "                  a.xckc008f = nvl(b.xckc014f,0) ,   ",  #期初金额
#               "                  a.xckc008g = nvl(b.xckc014g,0) ,   ",  #期初金额
#               "                  a.xckc008h = nvl(b.xckc014h,0) ,   ",  #期初金额
#               "                  a.xckc015  = nvl(b.xckc018,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015a = nvl(b.xckc018a,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015b = nvl(b.xckc018b,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015c = nvl(b.xckc018c,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015d = nvl(b.xckc018d,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015e = nvl(b.xckc018e,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015f = nvl(b.xckc018f,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015g = nvl(b.xckc018g,0) ,   ",  #币种2期初金额  
#               "                  a.xckc015h = nvl(b.xckc018h,0) ,   ",  #币种2期初金额
#               "                  a.xckc019  = nvl(b.xckc022,0) ,   ",  #币种3期初金额
#               "                  a.xckc019a = nvl(b.xckc022a,0) ,   ",  #币种3期初金额
#               "                  a.xckc019b = nvl(b.xckc022b,0) ,   ",  #币种3期初金额
#               "                  a.xckc019c = nvl(b.xckc022c,0) ,   ",  #币种3期初金额
#               "                  a.xckc019d = nvl(b.xckc022d,0) ,   ",  #币种3期初金额
#               "                  a.xckc019e = nvl(b.xckc022e,0) ,   ",  #币种3期初金额
#               "                  a.xckc019f = nvl(b.xckc022f,0) ,   ",  #币种3期初金额
#               "                  a.xckc019g = nvl(b.xckc022g,0) ,   ",  #币种3期初金额
#               "                  a.xckc019h = nvl(b.xckc022h,0)     ",  #币种3期初金额
#               "        WHERE a.xckc001 = ",g_master.yy,  #年度-本期
#               "          AND a.xckc002 = ",g_master.pp,  #期别-本期 #161012-00038#1 mark  ','    #170105-00068#1 remove #
#              #170105-00068#1 remove # start -----
#              #161012-00038#1 mark  --begin--
#              #上面insert已经塞入了，故mark              
#              "  WHEN NOT MATCHED THEN                      ",
#              "       INSERT VALUES(b.xckcent,b.xckccomp,b.xckcld,",g_master.yy,",",g_master.pp,", ",
#              "                     b.xckc003,b.xckc004,b.xckc005,b.xckc006,     ",
#              "                     b.xckc013,b.xckc014, 0,0, 0,0, 0,0,", #期初数量/金额,本月出货数/金,本月转出数/金，期末数/金
#              "                     b.xckc018,0,0,0, b.xckc022,0,0,0,", #币种二...  币种三...
#              "                     b.xckc023, ",        #特性
#              "                     b.xckc014a,b.xckc014b,b.xckc014c,b.xckc014d, ", #期初金额明细
#              "                     b.xckc014e,b.xckc014f,b.xckc014g,b.xckc014h, ", 
#              "                     0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0, ",   #本月出货/转出/期末金额
#              "                     b.xckc018a,b.xckc018b,b.xckc018c,b.xckc018d, ", #期初金额明细--币种二
#              "                     b.xckc018e,b.xckc018f,b.xckc018g,b.xckc018h, ",
#              "                     0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0, ",   #本月出货/转出/期末金额
#              "                     b.xckc022a,b.xckc022b,b.xckc022c,b.xckc022d, ", #期初金额明细--币种三
#              "                     b.xckc022e,b.xckc022f,b.xckc022g,b.xckc022h, ",
#              "                     0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0  ",   #本月出货/转出/期末金额
#              "                     )  "
#              #161012-00038#1 mark  --end--
#              #170105-00068#1 remove # end -----
#   PREPARE axcp200_execute_ins_xckc_p1 FROM l_sql
#   EXECUTE axcp200_execute_ins_xckc_p1
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'axcp200_execute_ins_xckc_p1'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   #本月出货数
#   LET g_wc = g_master.wc
#   LET g_wc= cl_replace_str(g_wc,"pmaa001","xckb009") #客戶
#   LET g_wc= cl_replace_str(g_wc,"imaa001","xckb012") #產品編號
#   LET l_sql = " MERGE INTO xckc_t a ",
#               #" USING xckb_t ",
#               " USING ( SELECT xckbent,xckbcomp,xckbld,xckb007,xckb008,xckb009,xckb012,xckb037,xckb022, ",
#               "                SUM(xckb021) xckb021,SUM(xckb102) xckb102,SUM(xckb112) xckb112,SUM(xckb122) xckb122, ",
#               "                SUM(xckb102a) xckb102a,SUM(xckb102b) xckb102b,SUM(xckb102c) xckb102c,SUM(xckb102d) xckb102d, ",
#               "                SUM(xckb102e) xckb102e,SUM(xckb102f) xckb102f,SUM(xckb102g) xckb102g,SUM(xckb102h) xckb102h, ",
#               "                SUM(xckb112a) xckb112a,SUM(xckb112b) xckb112b,SUM(xckb112c) xckb112c,SUM(xckb112d) xckb112d, ",
#               "                SUM(xckb112e) xckb112e,SUM(xckb112f) xckb112f,SUM(xckb112g) xckb112g,SUM(xckb112h) xckb112h, ",
#               "                SUM(xckb122a) xckb122a,SUM(xckb122b) xckb122b,SUM(xckb122c) xckb122c,SUM(xckb122d) xckb122d, ",
#               "                SUM(xckb122e) xckb122e,SUM(xckb122f) xckb122f,SUM(xckb122g) xckb122g,SUM(xckb122h) xckb122h  ",
#               "           FROM xckb_t ",
#               "          WHERE xckbent = ",g_enterprise,
#               "            AND xckbcomp='",g_comp,"' ",
#               "            AND xckbld  = '",g_master.glaald,"'",
#               "            AND xckb007 = ",g_master.yy,  #年度-本期
#               "            AND xckb008 = ",g_master.pp,  #期别-本期
#               "            AND xckb002 = 1 ",
#               "            AND ",g_wc,
#               "          GROUP BY xckbent,xckbcomp,xckbld,xckb007,xckb008,xckb009,xckb012,xckb037,xckb022 ",
#               "       ) b ",
#               "    ON ( a.xckcent = b.xckbent   ",
#               "    AND  a.xckccomp= b.xckbcomp  ",
#               "    AND  a.xckcld  = b.xckbld    ",
#               "    AND  a.xckc001 = b.xckb007   ", #年度-本期
#               "    AND  a.xckc002 = b.xckb008   ", #期别-本期
#               "    AND  a.xckc003 = b.xckb009   ", #客戶
#               "    AND  a.xckc004 = b.xckb012   ", #產品
#               "    AND  a.xckc023 = b.xckb037   ", #特性
#               "    AND  a.xckc005 = b.xckb022 ) ", #科目
#               "  WHEN MATCHED THEN  ",
#               "       UPDATE SET a.xckc009  = b.xckb021, ",  #本月出货数量
#               "                  a.xckc010  = b.xckb102, ",  #本月出货金额
#               "                  a.xckc010a = b.xckb102a, ",  #本月出货金额
#               "                  a.xckc010b = b.xckb102b, ",  #本月出货金额
#               "                  a.xckc010c = b.xckb102c, ",  #本月出货金额
#               "                  a.xckc010d = b.xckb102d, ",  #本月出货金额
#               "                  a.xckc010e = b.xckb102e, ",  #本月出货金额
#               "                  a.xckc010f = b.xckb102f, ",  #本月出货金额
#               "                  a.xckc010g = b.xckb102g, ",  #本月出货金额
#               "                  a.xckc010h = b.xckb102h, ",  #本月出货金额
#               "                  a.xckc016  = b.xckb112, ",  #币种2
#               "                  a.xckc016a = b.xckb112a, ",  #
#               "                  a.xckc016b = b.xckb112b, ",  #
#               "                  a.xckc016c = b.xckb112c, ",  #
#               "                  a.xckc016d = b.xckb112d, ",  #
#               "                  a.xckc016e = b.xckb112e, ",  #
#               "                  a.xckc016f = b.xckb112f, ",  #
#               "                  a.xckc016g = b.xckb112g, ",  #
#               "                  a.xckc016h = b.xckb112h, ",  #
#               "                  a.xckc020  = b.xckb122, ",  #币种3
#               "                  a.xckc020a = b.xckb122a, ",  #
#               "                  a.xckc020b = b.xckb122b, ",  #
#               "                  a.xckc020c = b.xckb122c, ",  #
#               "                  a.xckc020d = b.xckb122d, ",  #
#               "                  a.xckc020e = b.xckb122e, ",  #
#               "                  a.xckc020f = b.xckb122f, ",  #
#               "                  a.xckc020g = b.xckb122g, ",  #
#               "                  a.xckc020h = b.xckb122h  "   #
#   PREPARE axcp200_execute_ins_xckc_p2 FROM l_sql
#   EXECUTE axcp200_execute_ins_xckc_p2
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'axcp200_execute_ins_xckc_p2'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   #本月转出数
#   LET l_sql = " MERGE INTO xckc_t a ",
#               #" USING xckb_t ",
#               " USING ( SELECT xckbent,xckbcomp,xckbld,xckb007,xckb008,xckb009,xckb012,xckb037,xckb022, ",
#               "                SUM(xckb021) xckb021,SUM(xckb102) xckb102,SUM(xckb112) xckb112,SUM(xckb122) xckb122, ",
#               "                SUM(xckb102a) xckb102a,SUM(xckb102b) xckb102b,SUM(xckb102c) xckb102c,SUM(xckb102d) xckb102d, ",
#               "                SUM(xckb102e) xckb102e,SUM(xckb102f) xckb102f,SUM(xckb102g) xckb102g,SUM(xckb102h) xckb102h, ",
#               "                SUM(xckb112a) xckb112a,SUM(xckb112b) xckb112b,SUM(xckb112c) xckb112c,SUM(xckb112d) xckb112d, ",
#               "                SUM(xckb112e) xckb112e,SUM(xckb112f) xckb112f,SUM(xckb112g) xckb112g,SUM(xckb112h) xckb112h, ",
#               "                SUM(xckb122a) xckb122a,SUM(xckb122b) xckb122b,SUM(xckb122c) xckb122c,SUM(xckb122d) xckb122d, ",
#               "                SUM(xckb122e) xckb122e,SUM(xckb122f) xckb122f,SUM(xckb122g) xckb122g,SUM(xckb122h) xckb122h  ",
#               "           FROM xckb_t ",
#               "          WHERE xckbent = ",g_enterprise,
#               "            AND xckbcomp='",g_comp,"' ",
#               "            AND xckbld  = '",g_master.glaald,"'",
#               "            AND xckb007 = ",g_master.yy,  #年度-本期
#               "            AND xckb008 = ",g_master.pp,  #期别-本期
#               "            AND xckb002 = -1 ",  #转出
#               "            AND ",g_wc,
#               "          GROUP BY xckbent,xckbcomp,xckbld,xckb007,xckb008,xckb009,xckb012,xckb037,xckb022 ",
#               "       ) b ",
#               "    ON ( a.xckcent = b.xckbent   ",
#               "    AND  a.xckccomp= b.xckbcomp  ",
#               "    AND  a.xckcld  = b.xckbld    ",
#               "    AND  a.xckc001 = b.xckb007   ", #年度-本期
#               "    AND  a.xckc002 = b.xckb008   ", #期别-本期
#               "    AND  a.xckc003 = b.xckb009   ", #客戶
#               "    AND  a.xckc004 = b.xckb012   ", #產品
#               "    AND  a.xckc023 = b.xckb037   ", #特性
#               "    AND  a.xckc005 = b.xckb022 ) ", #科目
#               "  WHEN MATCHED THEN  ",  
#               "       UPDATE SET a.xckc011  = b.xckb021, ",  #本月转出数量
#               "                  a.xckc012  = b.xckb102, ",  #本月转出金额
#               "                  a.xckc012a = b.xckb102a, ",  #本月转出金额
#               "                  a.xckc012b = b.xckb102b, ",  #本月转出金额
#               "                  a.xckc012c = b.xckb102c, ",  #本月转出金额
#               "                  a.xckc012d = b.xckb102d, ",  #本月转出金额
#               "                  a.xckc012e = b.xckb102e, ",  #本月转出金额
#               "                  a.xckc012f = b.xckb102f, ",  #本月转出金额
#               "                  a.xckc012g = b.xckb102g, ",  #本月转出金额
#               "                  a.xckc012h = b.xckb102h, ",  #本月转出金额
#               "                  a.xckc017  = b.xckb112, ",  #币种2
#               "                  a.xckc017a = b.xckb112a, ",  #
#               "                  a.xckc017b = b.xckb112b, ",  #
#               "                  a.xckc017c = b.xckb112c, ",  #
#               "                  a.xckc017d = b.xckb112d, ",  #
#               "                  a.xckc017e = b.xckb112e, ",  #
#               "                  a.xckc017f = b.xckb112f, ",  #
#               "                  a.xckc017g = b.xckb112g, ",  #
#               "                  a.xckc017h = b.xckb112h, ",  #
#               "                  a.xckc021  = b.xckb122, ",  #币种3
#               "                  a.xckc021a = b.xckb122a, ",  #
#               "                  a.xckc021b = b.xckb122b, ",  #
#               "                  a.xckc021c = b.xckb122c, ",  #
#               "                  a.xckc021d = b.xckb122d, ",  #
#               "                  a.xckc021e = b.xckb122e, ",  #
#               "                  a.xckc021f = b.xckb122f, ",  #
#               "                  a.xckc021g = b.xckb122g, ",  #
#               "                  a.xckc021h = b.xckb122h  "   #
#   PREPARE axcp200_execute_ins_xckc_p3 FROM l_sql
#   EXECUTE axcp200_execute_ins_xckc_p3
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'axcp200_execute_ins_xckc_p3'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   #期末数
#   LET g_wc = g_master.wc
#   LET g_wc = cl_replace_str(g_wc,"pmaa001","xckc003") #客戶
#   LET g_wc = cl_replace_str(g_wc,"imaa001","xckc004") #產品編號
#   LET l_sql = " UPDATE xckc_t SET xckc013  = xckc007 + xckc009 - xckc011, ",  #期末数量
#               "                   xckc014  = xckc008 + xckc010 - xckc012, ",  #期末金额
#               "                   xckc014a = xckc008a+ xckc010a- xckc012a, ",  #期末金额
#               "                   xckc014b = xckc008b+ xckc010b- xckc012b, ",  #期末金额
#               "                   xckc014c = xckc008c+ xckc010c- xckc012c, ",  #期末金额
#               "                   xckc014d = xckc008d+ xckc010d- xckc012d, ",  #期末金额
#               "                   xckc014e = xckc008e+ xckc010e- xckc012e, ",  #期末金额
#               "                   xckc014f = xckc008f+ xckc010f- xckc012f, ",  #期末金额
#               "                   xckc014g = xckc008g+ xckc010g- xckc012g, ",  #期末金额
#               "                   xckc014h = xckc008h+ xckc010h- xckc012h, ",  #期末金额
#               "                   xckc018  = xckc015 + xckc016 - xckc017, ",  #币种2 
#               "                   xckc018a = xckc015a+ xckc016a- xckc017a, ",  #
#               "                   xckc018b = xckc015b+ xckc016b- xckc017b, ",  #
#               "                   xckc018c = xckc015c+ xckc016c- xckc017c, ",  #
#               "                   xckc018d = xckc015d+ xckc016d- xckc017d, ",  #
#               "                   xckc018e = xckc015e+ xckc016e- xckc017e, ",  #
#               "                   xckc018f = xckc015f+ xckc016f- xckc017f, ",  #
#               "                   xckc018g = xckc015g+ xckc016g- xckc017g, ",  #
#               "                   xckc018h = xckc015h+ xckc016h- xckc017h, ",  #
#               "                   xckc022  = xckc019 + xckc020 - xckc021, ",  #币种3
#               "                   xckc022a = xckc019a+ xckc020a- xckc021a, ",  #
#               "                   xckc022b = xckc019b+ xckc020b- xckc021b, ",  #
#               "                   xckc022c = xckc019c+ xckc020c- xckc021c, ",  #
#               "                   xckc022d = xckc019d+ xckc020d- xckc021d, ",  #
#               "                   xckc022e = xckc019e+ xckc020e- xckc021e, ",  #
#               "                   xckc022f = xckc019f+ xckc020f- xckc021f, ",  #
#               "                   xckc022g = xckc019g+ xckc020g- xckc021g, ",  #
#               "                   xckc022h = xckc019h+ xckc020h- xckc021h  ",  #
#               "  WHERE xckcent = ",g_enterprise,
#               "    AND xckccomp='",g_comp,"' ",
#               "    AND xckcld  = '",g_master.glaald,"'",
#               "    AND xckc001 = ",g_master.yy,  #年度-本期
#               "    AND xckc002 = ",g_master.pp,  #期别-本期
#               "    AND ",g_wc
#   PREPARE axcp200_execute_ins_xckc_p4 FROM l_sql
#   EXECUTE axcp200_execute_ins_xckc_p4
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'axcp200_execute_ins_xckc_p4'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
#   
#   RETURN r_success
#170220-00032#1---mark---e   
END FUNCTION

#xckb空赋值0
PRIVATE FUNCTION axcp200_execute_ins_xckb_null_zero(p_xckb)
#   DEFINE p_xckb     RECORD LIKE xckb_t.*  #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE p_xckb RECORD  #發出商品統計檔
       xckbent LIKE xckb_t.xckbent, #企业编号
       xckbcomp LIKE xckb_t.xckbcomp, #法人
       xckbld LIKE xckb_t.xckbld, #账套
       xckb001 LIKE xckb_t.xckb001, #来源
       xckb002 LIKE xckb_t.xckb002, #方向
       xckb003 LIKE xckb_t.xckb003, #发票号码
       xckb004 LIKE xckb_t.xckb004, #据点site
       xckb005 LIKE xckb_t.xckb005, #出货单号
       xckb006 LIKE xckb_t.xckb006, #出货项次
       xckb007 LIKE xckb_t.xckb007, #年度
       xckb008 LIKE xckb_t.xckb008, #期别
       xckb009 LIKE xckb_t.xckb009, #客户编号
       xckb010 LIKE xckb_t.xckb010, #人员编号
       xckb011 LIKE xckb_t.xckb011, #部门编号
       xckb012 LIKE xckb_t.xckb012, #产品编号
       xckb013 LIKE xckb_t.xckb013, #销售单位
       xckb014 LIKE xckb_t.xckb014, #数量
       xckb015 LIKE xckb_t.xckb015, #仓库编号
       xckb016 LIKE xckb_t.xckb016, #库位编号
       xckb017 LIKE xckb_t.xckb017, #批号
       xckb018 LIKE xckb_t.xckb018, #no use
       xckb019 LIKE xckb_t.xckb019, #发票编号
       xckb020 LIKE xckb_t.xckb020, #库存单位
       xckb021 LIKE xckb_t.xckb021, #库存数量
       xckb022 LIKE xckb_t.xckb022, #科目编号
       xckb023 LIKE xckb_t.xckb023, #多角贸易否
       xckb024 LIKE xckb_t.xckb024, #开票年度
       xckb025 LIKE xckb_t.xckb025, #开票期别
       xckb026 LIKE xckb_t.xckb026, #币种一
       xckb027 LIKE xckb_t.xckb027, #金额
       xckb028 LIKE xckb_t.xckb028, #币种二
       xckb029 LIKE xckb_t.xckb029, #金额
       xckb030 LIKE xckb_t.xckb030, #币种三
       xckb031 LIKE xckb_t.xckb031, #金额
       xckb032 LIKE xckb_t.xckb032, #no use
       xckb033 LIKE xckb_t.xckb033, #no use
       xckb034 LIKE xckb_t.xckb034, #no use
       xckb035 LIKE xckb_t.xckb035, #no use
       xckb036 LIKE xckb_t.xckb036, #项序
       xckb037 LIKE xckb_t.xckb037, #特性
       xckb101 LIKE xckb_t.xckb101, #币种一成本单价
       xckb101a LIKE xckb_t.xckb101a, #币种一成本单价-材料
       xckb101b LIKE xckb_t.xckb101b, #币种一成本单价-人工
       xckb101c LIKE xckb_t.xckb101c, #币种一成本单价-加工
       xckb101d LIKE xckb_t.xckb101d, #币种一成本单价-制费一
       xckb101e LIKE xckb_t.xckb101e, #币种一成本单价-制费二
       xckb101f LIKE xckb_t.xckb101f, #币种一成本单价-制费三
       xckb101g LIKE xckb_t.xckb101g, #币种一成本单价-制费四
       xckb101h LIKE xckb_t.xckb101h, #币种一成本单价-制费五
       xckb102 LIKE xckb_t.xckb102, #币种一成本金额
       xckb102a LIKE xckb_t.xckb102a, #币种一成本金额-材料
       xckb102b LIKE xckb_t.xckb102b, #币种一成本金额-人工
       xckb102c LIKE xckb_t.xckb102c, #币种一成本金额-加工
       xckb102d LIKE xckb_t.xckb102d, #币种一成本金额-制费一
       xckb102e LIKE xckb_t.xckb102e, #币种一成本金额-制费二
       xckb102f LIKE xckb_t.xckb102f, #币种一成本金额-制费三
       xckb102g LIKE xckb_t.xckb102g, #币种一成本金额-制费四
       xckb102h LIKE xckb_t.xckb102h, #币种一成本金额-制费五
       xckb111 LIKE xckb_t.xckb111, #币种二成本单价
       xckb111a LIKE xckb_t.xckb111a, #币种二成本单价-材料
       xckb111b LIKE xckb_t.xckb111b, #币种二成本单价-人工
       xckb111c LIKE xckb_t.xckb111c, #币种二成本单价-加工
       xckb111d LIKE xckb_t.xckb111d, #币种二成本单价-制费一
       xckb111e LIKE xckb_t.xckb111e, #币种二成本单价-制费二
       xckb111f LIKE xckb_t.xckb111f, #币种二成本单价-制费三
       xckb111g LIKE xckb_t.xckb111g, #币种二成本单价-制费四
       xckb111h LIKE xckb_t.xckb111h, #币种二成本单价-制费五
       xckb112 LIKE xckb_t.xckb112, #币种二成本金额
       xckb112a LIKE xckb_t.xckb112a, #币种二成本金额-材料
       xckb112b LIKE xckb_t.xckb112b, #币种二成本金额-人工
       xckb112c LIKE xckb_t.xckb112c, #币种二成本金额-加工
       xckb112d LIKE xckb_t.xckb112d, #币种二成本金额-制费一
       xckb112e LIKE xckb_t.xckb112e, #币种二成本金额-制费二
       xckb112f LIKE xckb_t.xckb112f, #币种二成本金额-制费三
       xckb112g LIKE xckb_t.xckb112g, #币种二成本金额-制费四
       xckb112h LIKE xckb_t.xckb112h, #币种二成本金额-制费五
       xckb121 LIKE xckb_t.xckb121, #币种三成本单价
       xckb121a LIKE xckb_t.xckb121a, #币种三成本单价-材料
       xckb121b LIKE xckb_t.xckb121b, #币种三成本单价-人工
       xckb121c LIKE xckb_t.xckb121c, #币种三成本单价-加工
       xckb121d LIKE xckb_t.xckb121d, #币种三成本单价-制费一
       xckb121e LIKE xckb_t.xckb121e, #币种三成本单价-制费二
       xckb121f LIKE xckb_t.xckb121f, #币种三成本单价-制费三
       xckb121g LIKE xckb_t.xckb121g, #币种三成本单价-制费四
       xckb121h LIKE xckb_t.xckb121h, #币种三成本单价-制费五
       xckb122 LIKE xckb_t.xckb122, #币种三成本金额
       xckb122a LIKE xckb_t.xckb122a, #币种三成本金额-材料
       xckb122b LIKE xckb_t.xckb122b, #币种三成本金额-人工
       xckb122c LIKE xckb_t.xckb122c, #币种三成本金额-加工
       xckb122d LIKE xckb_t.xckb122d, #币种三成本金额-制费一
       xckb122e LIKE xckb_t.xckb122e, #种三成本金额-制费二
       xckb122f LIKE xckb_t.xckb122f, #币种三成本金额-制费三
       xckb122g LIKE xckb_t.xckb122g, #币种三成本金额-制费四
       xckb122h LIKE xckb_t.xckb122h, #币种三成本金额-制费五
       xckb038 LIKE xckb_t.xckb038  #成本域
END RECORD
   #161124-00048#12 add(e)
   
   IF cl_null(p_xckb.xckb027 ) THEN LET p_xckb.xckb027  = 0 END IF #币种一金额
   IF cl_null(p_xckb.xckb029 ) THEN LET p_xckb.xckb029  = 0 END IF #币种二金额
   IF cl_null(p_xckb.xckb031 ) THEN LET p_xckb.xckb031  = 0 END IF #币种三金额
   
   #币种一成本单价，金额
   IF cl_null(p_xckb.xckb101 ) THEN LET p_xckb.xckb101  = 0 END IF
   IF cl_null(p_xckb.xckb101a) THEN LET p_xckb.xckb101a = 0 END IF
   IF cl_null(p_xckb.xckb101b) THEN LET p_xckb.xckb101b = 0 END IF
   IF cl_null(p_xckb.xckb101c) THEN LET p_xckb.xckb101c = 0 END IF
   IF cl_null(p_xckb.xckb101d) THEN LET p_xckb.xckb101d = 0 END IF
   IF cl_null(p_xckb.xckb101e) THEN LET p_xckb.xckb101e = 0 END IF
   IF cl_null(p_xckb.xckb101f) THEN LET p_xckb.xckb101f = 0 END IF
   IF cl_null(p_xckb.xckb101g) THEN LET p_xckb.xckb101g = 0 END IF
   IF cl_null(p_xckb.xckb101h) THEN LET p_xckb.xckb101h = 0 END IF
   IF cl_null(p_xckb.xckb102 ) THEN LET p_xckb.xckb102  = 0 END IF
   IF cl_null(p_xckb.xckb102a) THEN LET p_xckb.xckb102a = 0 END IF
   IF cl_null(p_xckb.xckb102b) THEN LET p_xckb.xckb102b = 0 END IF
   IF cl_null(p_xckb.xckb102c) THEN LET p_xckb.xckb102c = 0 END IF
   IF cl_null(p_xckb.xckb102d) THEN LET p_xckb.xckb102d = 0 END IF
   IF cl_null(p_xckb.xckb102e) THEN LET p_xckb.xckb102e = 0 END IF
   IF cl_null(p_xckb.xckb102f) THEN LET p_xckb.xckb102f = 0 END IF
   IF cl_null(p_xckb.xckb102g) THEN LET p_xckb.xckb102g = 0 END IF
   IF cl_null(p_xckb.xckb102h) THEN LET p_xckb.xckb102h = 0 END IF
   
   #币种二成本单价，金额
   IF cl_null(p_xckb.xckb111 ) THEN LET p_xckb.xckb111  = 0 END IF
   IF cl_null(p_xckb.xckb111a) THEN LET p_xckb.xckb111a = 0 END IF
   IF cl_null(p_xckb.xckb111b) THEN LET p_xckb.xckb111b = 0 END IF
   IF cl_null(p_xckb.xckb111c) THEN LET p_xckb.xckb111c = 0 END IF
   IF cl_null(p_xckb.xckb111d) THEN LET p_xckb.xckb111d = 0 END IF
   IF cl_null(p_xckb.xckb111e) THEN LET p_xckb.xckb111e = 0 END IF
   IF cl_null(p_xckb.xckb111f) THEN LET p_xckb.xckb111f = 0 END IF
   IF cl_null(p_xckb.xckb111g) THEN LET p_xckb.xckb111g = 0 END IF
   IF cl_null(p_xckb.xckb111h) THEN LET p_xckb.xckb111h = 0 END IF
   IF cl_null(p_xckb.xckb112 ) THEN LET p_xckb.xckb112  = 0 END IF
   IF cl_null(p_xckb.xckb112a) THEN LET p_xckb.xckb112a = 0 END IF
   IF cl_null(p_xckb.xckb112b) THEN LET p_xckb.xckb112b = 0 END IF
   IF cl_null(p_xckb.xckb112c) THEN LET p_xckb.xckb112c = 0 END IF
   IF cl_null(p_xckb.xckb112d) THEN LET p_xckb.xckb112d = 0 END IF
   IF cl_null(p_xckb.xckb112e) THEN LET p_xckb.xckb112e = 0 END IF
   IF cl_null(p_xckb.xckb112f) THEN LET p_xckb.xckb112f = 0 END IF
   IF cl_null(p_xckb.xckb112g) THEN LET p_xckb.xckb112g = 0 END IF
   IF cl_null(p_xckb.xckb112h) THEN LET p_xckb.xckb112h = 0 END IF

   #币种三成本单价，金额
   IF cl_null(p_xckb.xckb121 ) THEN LET p_xckb.xckb121  = 0 END IF
   IF cl_null(p_xckb.xckb121a) THEN LET p_xckb.xckb121a = 0 END IF
   IF cl_null(p_xckb.xckb121b) THEN LET p_xckb.xckb121b = 0 END IF
   IF cl_null(p_xckb.xckb121c) THEN LET p_xckb.xckb121c = 0 END IF
   IF cl_null(p_xckb.xckb121d) THEN LET p_xckb.xckb121d = 0 END IF
   IF cl_null(p_xckb.xckb121e) THEN LET p_xckb.xckb121e = 0 END IF
   IF cl_null(p_xckb.xckb121f) THEN LET p_xckb.xckb121f = 0 END IF
   IF cl_null(p_xckb.xckb121g) THEN LET p_xckb.xckb121g = 0 END IF
   IF cl_null(p_xckb.xckb121h) THEN LET p_xckb.xckb121h = 0 END IF
   IF cl_null(p_xckb.xckb122 ) THEN LET p_xckb.xckb122  = 0 END IF
   IF cl_null(p_xckb.xckb122a) THEN LET p_xckb.xckb122a = 0 END IF
   IF cl_null(p_xckb.xckb122b) THEN LET p_xckb.xckb122b = 0 END IF
   IF cl_null(p_xckb.xckb122c) THEN LET p_xckb.xckb122c = 0 END IF
   IF cl_null(p_xckb.xckb122d) THEN LET p_xckb.xckb122d = 0 END IF
   IF cl_null(p_xckb.xckb122e) THEN LET p_xckb.xckb122e = 0 END IF
   IF cl_null(p_xckb.xckb122f) THEN LET p_xckb.xckb122f = 0 END IF
   IF cl_null(p_xckb.xckb122g) THEN LET p_xckb.xckb122g = 0 END IF
   IF cl_null(p_xckb.xckb122h) THEN LET p_xckb.xckb122h = 0 END IF
   
   RETURN p_xckb.*
END FUNCTION

################################################################################
# Date & Author..: 2017/01/22 By xianghui
# Modify.........: #170104-00054#1
################################################################################
PRIVATE FUNCTION axcp200_create_tmp()
   
   WHENEVER ERROR CONTINUE
   
   #单位转换的临时表
   DROP TABLE convert_tmp;
   CREATE TEMP TABLE convert_tmp(
      imaa001    VARCHAR(40),
      from_unit  VARCHAR(10),
      to_unit    VARCHAR(10),
      qty        DECIMAL(20,6)
      )

   #發出商品統計檔
   DROP TABLE xckb_tmp;
   CREATE TEMP TABLE xckb_tmp(
       xckbent  SMALLINT,      #企业代码
       xckbcomp  VARCHAR(10),      #法人
       xckbld  VARCHAR(5),      #账别
       xckb001  VARCHAR(1),      #来源
       xckb002  SMALLINT,      #方向
       xckb003  VARCHAR(20),      #发票号码
       xckb004  VARCHAR(10),      #据点site
       xckb005  VARCHAR(20),      #出货单号
       xckb006  SMALLINT,      #出货项次
       xckb007  SMALLINT,      #年度
       xckb008  SMALLINT,      #期别
       xckb009  VARCHAR(10),      #客户编号
       xckb010  VARCHAR(20),      #人员编号
       xckb011  VARCHAR(10),      #部门编号
       xckb012  VARCHAR(40),      #产品编号
       xckb013  VARCHAR(10),      #销售单位
       xckb014  DECIMAL(20,6),      #数量
       xckb015  VARCHAR(10),      #仓库编号
       xckb016  VARCHAR(10),      #库位编号
       xckb017  VARCHAR(30),      #批号
       xckb018  VARCHAR(40),      #no use
       xckb019  VARCHAR(10),      #发票代码
       xckb020  VARCHAR(10),      #库存单位
       xckb021  DECIMAL(20,6),      #库存数量
       xckb022  VARCHAR(24),      #科目编号
       xckb023  VARCHAR(1),      #多角贸易否
       xckb024  SMALLINT,      #开票年度
       xckb025  SMALLINT,      #开票期别
       xckb026  VARCHAR(10),      #币种一
       xckb027  DECIMAL(20,6),      #金额
       xckb028  VARCHAR(10),      #币种二
       xckb029  DECIMAL(20,6),      #金额
       xckb030  VARCHAR(10),      #币种三
       xckb031  DECIMAL(20,6),      #金额
       xckb032  DECIMAL(20,6),      #no use
       xckb033  DECIMAL(20,6),      #no use
       xckb034  DECIMAL(20,6),      #no use
       xckb035  VARCHAR(40),      #no use
       xckb036  SMALLINT,      #项序
       xckb037  VARCHAR(256),      #特性
       xckb101  DECIMAL(20,6),      #币种一成本单价
       xckb101a  DECIMAL(20,6),      #币种一成本单价-材料
       xckb101b  DECIMAL(20,6),      #币种一成本单价-人工
       xckb101c  DECIMAL(20,6),      #币种一成本单价-加工
       xckb101d  DECIMAL(20,6),      #币种一成本单价-制费一
       xckb101e  DECIMAL(20,6),      #币种一成本单价-制费二
       xckb101f  DECIMAL(20,6),      #币种一成本单价-制费三
       xckb101g  DECIMAL(20,6),      #币种一成本单价-制费四
       xckb101h  DECIMAL(20,6),      #币种一成本单价-制费五
       xckb102  DECIMAL(20,6),      #币种一成本金额
       xckb102a  DECIMAL(20,6),      #币种一成本金额-材料
       xckb102b  DECIMAL(20,6),      #币种一成本金额-人工
       xckb102c  DECIMAL(20,6),      #币种一成本金额-加工
       xckb102d  DECIMAL(20,6),      #币种一成本金额-制费一
       xckb102e  DECIMAL(20,6),      #币种一成本金额-制费二
       xckb102f  DECIMAL(20,6),      #币种一成本金额-制费三
       xckb102g  DECIMAL(20,6),      #币种一成本金额-制费四
       xckb102h  DECIMAL(20,6),      #币种一成本金额-制费五
       xckb111  DECIMAL(20,6),      #币种二成本单价
       xckb111a  DECIMAL(20,6),      #币种二成本单价-材料
       xckb111b  DECIMAL(20,6),      #币种二成本单价-人工
       xckb111c  DECIMAL(20,6),      #币种二成本单价-加工
       xckb111d  DECIMAL(20,6),      #币种二成本单价-制费一
       xckb111e  DECIMAL(20,6),      #币种二成本单价-制费二
       xckb111f  DECIMAL(20,6),      #币种二成本单价-制费三
       xckb111g  DECIMAL(20,6),      #币种二成本单价-制费四
       xckb111h  DECIMAL(20,6),      #币种二成本单价-制费五
       xckb112  DECIMAL(20,6),      #币种二成本金额
       xckb112a  DECIMAL(20,6),      #币种二成本金额-材料
       xckb112b  DECIMAL(20,6),      #币种二成本金额-人工
       xckb112c  DECIMAL(20,6),      #币种二成本金额-加工
       xckb112d  DECIMAL(20,6),      #币种二成本金额-制费一
       xckb112e  DECIMAL(20,6),      #币种二成本金额-制费二
       xckb112f  DECIMAL(20,6),      #币种二成本金额-制费三
       xckb112g  DECIMAL(20,6),      #币种二成本金额-制费四
       xckb112h  DECIMAL(20,6),      #币种二成本金额-制费五
       xckb121  DECIMAL(20,6),      #币种三成本单价
       xckb121a  DECIMAL(20,6),      #币种三成本单价-材料
       xckb121b  DECIMAL(20,6),      #币种三成本单价-人工
       xckb121c  DECIMAL(20,6),      #币种三成本单价-加工
       xckb121d  DECIMAL(20,6),      #币种三成本单价-制费一
       xckb121e  DECIMAL(20,6),      #币种三成本单价-制费二
       xckb121f  DECIMAL(20,6),      #币种三成本单价-制费三
       xckb121g  DECIMAL(20,6),      #币种三成本单价-制费四
       xckb121h  DECIMAL(20,6),      #币种三成本单价-制费五
       xckb122  DECIMAL(20,6),      #币种三成本金额
       xckb122a  DECIMAL(20,6),      #币种三成本金额-材料
       xckb122b  DECIMAL(20,6),      #币种三成本金额-人工
       xckb122c  DECIMAL(20,6),      #币种三成本金额-加工
       xckb122d  DECIMAL(20,6),      #币种三成本金额-制费一
       xckb122e  DECIMAL(20,6),      #种三成本金额-制费二
       xckb122f  DECIMAL(20,6),      #币种三成本金额-制费三
       xckb122g  DECIMAL(20,6),      #币种三成本金额-制费四
       xckb122h  DECIMAL(20,6),      #币种三成本金额-制费五
       xckb038   VARCHAR(30),       #成本域
       docdt     DATE,
       yy        SMALLINT,          #年度
       mm        SMALLINT     #期别     
      )
      
   DROP TABLE xckb2_tmp;
   CREATE TEMP TABLE xckb2_tmp(
       xckbent  SMALLINT,      #企业代码
       xckbcomp  VARCHAR(10),      #法人
       xckbld  VARCHAR(5),      #账别
       xckb001  VARCHAR(1),      #来源
       xckb002  SMALLINT,      #方向
       xckb003  VARCHAR(20),      #发票号码
       xckb004  VARCHAR(10),      #据点site
       xckb005  VARCHAR(20),      #出货单号
       xckb006  SMALLINT,      #出货项次
       xckb007  SMALLINT,      #年度
       xckb008  SMALLINT,      #期别
       xckb009  VARCHAR(10),      #客户编号
       xckb010  VARCHAR(20),      #人员编号
       xckb011  VARCHAR(10),      #部门编号
       xckb012  VARCHAR(40),      #产品编号
       xckb013  VARCHAR(10),      #销售单位
       xckb014  DECIMAL(20,6),      #数量
       xckb015  VARCHAR(10),      #仓库编号
       xckb016  VARCHAR(10),      #库位编号
       xckb017  VARCHAR(30),      #批号
       xckb018  VARCHAR(40),      #no use
       xckb019  VARCHAR(10),      #发票代码
       xckb020  VARCHAR(10),      #库存单位
       xckb021  DECIMAL(20,6),      #库存数量
       xckb022  VARCHAR(24),      #科目编号
       xckb023  VARCHAR(1),      #多角贸易否
       xckb024  SMALLINT,      #开票年度
       xckb025  SMALLINT,      #开票期别
       xckb026  VARCHAR(10),      #币种一
       xckb027  DECIMAL(20,6),      #金额
       xckb028  VARCHAR(10),      #币种二
       xckb029  DECIMAL(20,6),      #金额
       xckb030  VARCHAR(10),      #币种三
       xckb031  DECIMAL(20,6),      #金额
       xckb032  DECIMAL(20,6),      #no use
       xckb033  DECIMAL(20,6),      #no use
       xckb034  DECIMAL(20,6),      #no use
       xckb035  VARCHAR(40),      #no use
       xckb036  SMALLINT,      #项序
       xckb037  VARCHAR(256),      #特性
       xckb101  DECIMAL(20,6),      #币种一成本单价
       xckb101a  DECIMAL(20,6),      #币种一成本单价-材料
       xckb101b  DECIMAL(20,6),      #币种一成本单价-人工
       xckb101c  DECIMAL(20,6),      #币种一成本单价-加工
       xckb101d  DECIMAL(20,6),      #币种一成本单价-制费一
       xckb101e  DECIMAL(20,6),      #币种一成本单价-制费二
       xckb101f  DECIMAL(20,6),      #币种一成本单价-制费三
       xckb101g  DECIMAL(20,6),      #币种一成本单价-制费四
       xckb101h  DECIMAL(20,6),      #币种一成本单价-制费五
       xckb102  DECIMAL(20,6),      #币种一成本金额
       xckb102a  DECIMAL(20,6),      #币种一成本金额-材料
       xckb102b  DECIMAL(20,6),      #币种一成本金额-人工
       xckb102c  DECIMAL(20,6),      #币种一成本金额-加工
       xckb102d  DECIMAL(20,6),      #币种一成本金额-制费一
       xckb102e  DECIMAL(20,6),      #币种一成本金额-制费二
       xckb102f  DECIMAL(20,6),      #币种一成本金额-制费三
       xckb102g  DECIMAL(20,6),      #币种一成本金额-制费四
       xckb102h  DECIMAL(20,6),      #币种一成本金额-制费五
       xckb111  DECIMAL(20,6),      #币种二成本单价
       xckb111a  DECIMAL(20,6),      #币种二成本单价-材料
       xckb111b  DECIMAL(20,6),      #币种二成本单价-人工
       xckb111c  DECIMAL(20,6),      #币种二成本单价-加工
       xckb111d  DECIMAL(20,6),      #币种二成本单价-制费一
       xckb111e  DECIMAL(20,6),      #币种二成本单价-制费二
       xckb111f  DECIMAL(20,6),      #币种二成本单价-制费三
       xckb111g  DECIMAL(20,6),      #币种二成本单价-制费四
       xckb111h  DECIMAL(20,6),      #币种二成本单价-制费五
       xckb112  DECIMAL(20,6),      #币种二成本金额
       xckb112a  DECIMAL(20,6),      #币种二成本金额-材料
       xckb112b  DECIMAL(20,6),      #币种二成本金额-人工
       xckb112c  DECIMAL(20,6),      #币种二成本金额-加工
       xckb112d  DECIMAL(20,6),      #币种二成本金额-制费一
       xckb112e  DECIMAL(20,6),      #币种二成本金额-制费二
       xckb112f  DECIMAL(20,6),      #币种二成本金额-制费三
       xckb112g  DECIMAL(20,6),      #币种二成本金额-制费四
       xckb112h  DECIMAL(20,6),      #币种二成本金额-制费五
       xckb121  DECIMAL(20,6),      #币种三成本单价
       xckb121a  DECIMAL(20,6),      #币种三成本单价-材料
       xckb121b  DECIMAL(20,6),      #币种三成本单价-人工
       xckb121c  DECIMAL(20,6),      #币种三成本单价-加工
       xckb121d  DECIMAL(20,6),      #币种三成本单价-制费一
       xckb121e  DECIMAL(20,6),      #币种三成本单价-制费二
       xckb121f  DECIMAL(20,6),      #币种三成本单价-制费三
       xckb121g  DECIMAL(20,6),      #币种三成本单价-制费四
       xckb121h  DECIMAL(20,6),      #币种三成本单价-制费五
       xckb122  DECIMAL(20,6),      #币种三成本金额
       xckb122a  DECIMAL(20,6),      #币种三成本金额-材料
       xckb122b  DECIMAL(20,6),      #币种三成本金额-人工
       xckb122c  DECIMAL(20,6),      #币种三成本金额-加工
       xckb122d  DECIMAL(20,6),      #币种三成本金额-制费一
       xckb122e  DECIMAL(20,6),      #种三成本金额-制费二
       xckb122f  DECIMAL(20,6),      #币种三成本金额-制费三
       xckb122g  DECIMAL(20,6),      #币种三成本金额-制费四
       xckb122h  DECIMAL(20,6),      #币种三成本金额-制费五
       xckb038  VARCHAR(30)     #成本域
      )
END FUNCTION

################################################################################
# Date & Author..: 2017/01/22 By xianghui
# Modify.........: #170104-00054#1
################################################################################
PRIVATE FUNCTION axcp200_ins_xckb_new()
DEFINE l_success    LIKE type_t.num5
DEFINE l_qty        LIKE inag_t.inag008 
DEFINE l_imaa001    LIKE imaa_t.imaa001
DEFINE l_from_unit  LIKE inag_t.inag007 
DEFINE l_to_unit    LIKE inag_t.inag007
DEFINE l_ext1       LIKE ooan_t.ooan005
DEFINE l_ext2       LIKE ooan_t.ooan005
DEFINE l_finarg     LIKE type_t.chr1    
DEFINE r_success    LIKE type_t.num5
DEFINE l_count      LIKE type_t.num10
DEFINE l_xcat005    LIKE xcat_t.xcat005
DEFINE l_glav001    LIKE glav_t.glav001
DEFINE l_ld         LIKE glaa_t.glaald

   LET r_success = TRUE

   LET l_finarg  = cl_get_para(g_enterprise,g_site,'S-FINC9020') #根据参数 S-FINC9020  出货当月全部转发出商品

   LET g_wc_axm = g_master.wc
   LET g_wc_axm = cl_replace_str(g_wc_axm,"pmaa001","xmdk008") #客戶
   LET g_wc_axm = cl_replace_str(g_wc_axm,"imaa001","xmdl008") #產品編號
   
   SELECT xcat005 INTO l_xcat005
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xcat001 
      
   CALL s_fin_get_major_ld(g_comp) RETURNING l_ld
   SELECT glaa003 INTO l_glav001 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = l_ld
      
   LET l_count = 0
   LET g_sql = "SELECT COUNT(1) ",
               "   FROM xmdk_t,xmdl_t,imaa_t,xmdm_t  ",
               "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
               "    AND imaaent = xmdlent AND imaa001   = xmdl008 ",
               "    AND xmdment = xmdkent AND xmdmdocno = xmdkdocno AND xmdmseq = xmdlseq",
               "    AND xmdkent = ",g_enterprise,
               "    AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooefstus ='Y' AND ooef017 ='",g_comp,"')",
               "    AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S') ",
               "         OR (xmdk000 IN ('4','5') AND xmdkstus = 'Y' AND xmdk002 = '3') ",
               "         OR (xmdk000 = '6' AND xmdk082 != '4' AND xmdkstus = 'S' )) ",                             
               "    AND xmdk001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND (xmdl014 = ' ' OR EXISTS(SELECT 1 FROM inaa_t WHERE inaaent = xmdlent AND inaasite  = xmdlsite  AND inaa001 = xmdl014 AND inaa010 = 'Y')) ", #170214-00060#1 add )
               "    AND ",g_wc_axm CLIPPED
   PREPARE xckb_count_pre FROM g_sql
   EXECUTE xckb_count_pre INTO l_count
   IF l_count = 0 THEN
      RETURN r_success
   END IF
   
   DELETE FROM convert_tmp;
   LET g_sql = " INSERT INTO convert_tmp ",
               " SELECT DISTINCT xmdl008,xmdl017,imaa006,1 ",
               "   FROM xmdk_t,xmdl_t,imaa_t,xmdm_t  ",
               "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
               "    AND imaaent = xmdlent AND imaa001   = xmdl008 ",
               "    AND xmdment = xmdkent AND xmdmdocno = xmdkdocno AND xmdmseq = xmdlseq",
               "    AND xmdkent = ",g_enterprise,
               "    AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooefstus ='Y' AND ooef017 ='",g_comp,"')",
               "    AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S') ",
               "         OR (xmdk000 IN ('4','5') AND xmdkstus = 'Y' AND xmdk002 = '3') ",
               "         OR (xmdk000 = '6' AND xmdk082 != '4' AND xmdkstus = 'S' )) ",                             
               "    AND xmdk001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND (xmdl014 = ' ' OR EXISTS(SELECT 1 FROM inaa_t WHERE inaaent = xmdlent AND inaasite  = xmdlsite  AND inaa001 = xmdl014 AND inaa010 = 'Y')) ", #170220-00038#1 add )
               "    AND ",g_wc_axm CLIPPED   
   PREPARE xckb_pre1 FROM g_sql
   EXECUTE xckb_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   UPDATE convert_tmp
      SET from_unit = 'PCS'
    WHERE imaa001 = 'MISC'
      AND from_unit IS NULL
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE convert_tmp"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   LET g_sql = " SELECT DISTINCT imaa001,from_unit,to_unit ",
               "   FROM convert_tmp "
   PREPARE xckb_pre2 FROM g_sql
   DECLARE xckb_cur2 CURSOR FOR xckb_pre2
   FOREACH xckb_cur2 INTO l_imaa001,l_from_unit,l_to_unit
      CALL s_aooi250_convert_qty(l_imaa001,l_from_unit,l_to_unit,1)
         RETURNING l_success,l_qty
      IF l_success THEN
　       UPDATE convert_tmp
            SET qty = l_qty
          WHERE imaa001 = l_imaa001
            AND from_unit = l_from_unit
            AND to_unit = l_to_unit
      END IF
   END FOREACH
   
               
   LET g_sql = " INSERT INTO xckb_tmp(xckbent,xckbcomp,xckbld,xckb001,xckb002,",
               "                 xckb003,xckb004,xckb005,xckb006,xckb007,",
               "                 xckb008,xckb009,xckb010,xckb011,xckb012,",
               "                 xckb013,xckb014,xckb015,xckb016,xckb017,",
               "                 xckb018,xckb019,xckb020,xckb021,xckb022,",
               "                 xckb023,xckb024,xckb025,xckb026,xckb027,",
               "                 xckb028,xckb029,xckb030,xckb031,xckb032,",
               "                 xckb033,xckb034,xckb035,xckb036,xckb037,",
               "                 xckb101,xckb101a,xckb101b,xckb101c,xckb101d,",
               "                 xckb101e,xckb101f,xckb101g,xckb101h,xckb102,",
               "                 xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,",
               "                 xckb102f,xckb102g,xckb102h,xckb111,xckb111a,",
               "                 xckb111b,xckb111c,xckb111d,xckb111e,xckb111f,",
               "                 xckb111g,xckb111h,xckb112,xckb112a,xckb112b,",
               "                 xckb112c,xckb112d,xckb112e,xckb112f,xckb112g,",
               "                 xckb112h,xckb121,xckb121a,xckb121b,xckb121c,",
               "                 xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,",
               "                 xckb122,xckb122a,xckb122b,xckb122c,xckb122d,",
               "                 xckb122e,xckb122f,xckb122g,xckb122h,xckb038 ) ",
               " SELECT ",g_enterprise,",'",g_comp,"','",g_master.glaald,"',(CASE WHEN xmdk000='1' OR xmdk000='2' OR xmdk000='3'  THEN '1' WHEN xmdk000='4' OR xmdk000='5' THEN '2' WHEN xmdk000='6' THEN '3' END) xckb001,'1',",
               "        'UNINVOICE',xmdksite,xmdkdocno,xmdlseq,",g_master.yy,",",
               "        ",g_master.pp,",xmdk008,xmdk003,xmdk004,xmdl008,",
               "        xmdm008,xmdm009,xmdm005,xmdm006,xmdm007,", 
               "        '',xmdk041,imaa006,0,'',",
               "        DECODE(xmdk044,NULL,'N','Y'),'','','",g_glaa001,"',xmdl028,"
      IF g_glaa015 = 'Y' THEN                        
         LET g_sql = g_sql,"'",g_glaa016,"',0,"
      ELSE
         LET g_sql = g_sql,"'',0,"
      END IF
      IF g_glaa019 = 'Y' THEN                        
         LET g_sql = g_sql,"'",g_glaa020,"',0,'',"
      ELSE
         LET g_sql = g_sql,"'',0,'',"
      END IF
      LET g_sql = g_sql,
                #"'','','',xmdmseq1,xmdl009,",          #170214-00060#1 mark
                 "'','','',xmdmseq1,NVL(xmdl009,' '),", #170214-00060#1 add
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,"
     IF g_sys_6001 = '3' THEN
        LET g_sql = g_sql,"xmdl052" #170214-00060#1 remove ,
     ELSE
        LET g_sql = g_sql,"' '" #170214-00060#1 remove ,
     END IF
    #LET g_sql = g_sql,"'','','',", #170214-00060#1 mark
     LET g_sql = g_sql, #170214-00060#1 add
                 "   FROM xmdk_t,xmdl_t,imaa_t,xmdm_t  ",
                 "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
                 "    AND imaaent = xmdlent AND imaa001   = xmdl008 ",
                 "    AND xmdment = xmdkent AND xmdmdocno = xmdkdocno AND xmdmseq = xmdlseq",
                 "    AND xmdkent = ",g_enterprise,
                 "    AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                 "    AND ooefstus ='Y' AND ooef017 ='",g_comp,"')",
                 "    AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S') ",
                 "         OR (xmdk000 IN ('4','5') AND xmdkstus = 'Y' AND xmdk002 = '3') ",
                 "         OR (xmdk000 = '6' AND xmdk082 != '4' AND xmdkstus = 'S' )) ",                             
                 "    AND xmdk001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
                 "    AND (xmdl014 = ' ' OR EXISTS(SELECT 1 FROM inaa_t WHERE inaaent = xmdlent AND inaasite  = xmdlsite  AND inaa001 = xmdl014 AND inaa010 = 'Y')) ", #170214-00060#1 add )
                 "    AND ",g_wc_axm CLIPPED    
   PREPARE xckb_pre3 FROM g_sql
   EXECUTE xckb_pre3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   

   #170322-00109#1 add--s
   #按料件特性计算成本否
   IF g_sys_6013 = 'N' THEN
      UPDATE xckb_tmp SET xckb037 = ' '
   END IF
   #170322-00109#1 add--e
   
   #更新库存数量栏位         
   LET g_sql = " MERGE INTO xckb_tmp a",
               " USING (SELECT imaa001,from_unit,to_unit,qty FROM convert_tmp ) b",
               "    ON (a.xckb012 = b.imaa001 AND a.xckb013 = b.from_unit AND a.xckb020 = b.to_unit) ",
               "  WHEN MATCHED THEN ",
               "        UPDATE SET a.xckb021 = a.xckb014*b.qty "
   PREPARE xckb_pre4 FROM g_sql
   EXECUTE xckb_pre4     
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #销退单   
   UPDATE xckb_tmp 
      SET xckb014 = xckb014 *-1,
          xckb021 = xckb021 *-1
    WHERE xckb001 = '3' 

   #科目
   LET g_sql =     " MERGE INTO xckb_tmp ",
                   " USING (SELECT glcc002,glcc016 FROM glcc_t",
                   "         WHERE glccent = ",g_enterprise," AND glcc001 = '1' ",
                   "           AND glccld  = '",g_master.glaald,"' ",
                   "           AND (glcc014='",g_comp,"' OR glcc014='*' ) AND ROWNUM = 1 ORDER BY glcc016 ) ",
                   "    ON ((glcc016 = xckb012 OR glcc016 = '*') ) ",
                   "    WHEN MATCHED THEN  ",
                   "    UPDATE SET xckb022 = glcc002"
   PREPARE xckb_pre12 FROM g_sql
   EXECUTE xckb_pre12 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre12"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #更新成本域    
   IF g_sys_6001 = 'N' THEN
      UPDATE xckb_tmp 
         SET xckb038 = ' ' 
   ELSE
      CASE g_sys_6002
           WHEN '1'  #组织
              UPDATE xckb_tmp 
                 SET xckb038 = (SELECT xcbf001 FROM xcbf_t
                                 WHERE xcbfent  = g_enterprise
                                   AND xcbfcomp = g_comp
                                   AND xcbf002  = xckb004)                    
           WHEN '2'  #仓库
              UPDATE xckb_tmp 
                 SET xckb038 = (SELECT xcbf001 FROM xcbf_t
                                 WHERE xcbfent  = g_enterprise
                                   AND xcbfcomp = g_comp
                                   AND xcbf002  = xckb015)            
      END CASE
   END IF  

   ## --> 170220-00038#1
   ##調整順序，先不論是出貨單還是銷退單，拿過帳日期先更新docdt
   ##銷退單有出貨來源的，再用原出貨單的過帳日期更新docdt
   ##這樣做才能避免銷退無出貨來源的資料，能抓的到過帳年月的單位成本

   UPDATE xckb_tmp 
      SET docdt = (SELECT xmdk001 FROM xmdk_t 
                    WHERE xmdkent = g_enterprise 
                      AND xmdkdocno = xckb005) 
                      
   UPDATE xckb_tmp 
     #170214-00060#1 ---add (s)---
      SET docdt = (SELECT a.xmdk001 FROM xmdk_t a,xmdk_t b,xmdl_t
                    WHERE b.xmdkent = g_enterprise AND b.xmdk000 = '6'
                      AND xmdldocno = xckb005 AND xmdlseq = xckb006
                      AND b.xmdkent = xmdlent AND b.xmdkdocno = xmdldocno
                      AND xmdl001 = a.xmdkdocno)
      WHERE xckb001 = '3'
      #170220-00038#1 add start -----
        AND EXISTS (SELECT * FROM xmdl_t
                     WHERE xmdlent = g_enterprise AND xmdldocno = xckb005
                       AND NVL(xmdl001,' ') <> ' ')     
      #170220-00038#1 add end   -----                       
     #170214-00060#1 ---add (e)---
     #170214-00060#1 ---mark (s)---
     #SET docdt = (SELECT xmdkdocdt FROM xmdl_t,xmdk_t 
     #              WHERE xmdlent = xmdkent 
     #                AND xmdl001 = xmdkdocno 
     #                AND xmdlent = g_enterprise 
     #                AND xmdldocno = xckb005 
     #                AND xmdlseq = xckb006) 
     #WHERE xmdk000 = '6'   
     #170214-00060#1 ---mark (e)---
#170220-00038#1 mark start -----
#   UPDATE xckb_tmp 
#      SET docdt = (SELECT xmdkdocdt FROM xmdk_t 
#                    WHERE xmdkent = g_enterprise 
#                     #AND xmdkdocno = xckb005)                      #170214-00060#1 mark
#                      AND xmdkdocno = xckb005 and xmdk000 <> '6' )  #170214-00060#1 add
#   #WHERE xmdk000 <> '6'  #170214-00060#1 mark
#    WHERE xckb001 <> '3' #170214-00060#1 add
#170220-00038#1 mark end   -----    
    
   UPDATE xckb_tmp 
      SET yy = (SELECT DISTINCT glav002 FROM glav_t 
                 WHERE glavent = g_enterprise 
                   #AND glav004 = xmdkdocdt  #170220-00038#1 mark
                   AND glav001 = l_glav001 
                   AND glav004 = docdt),
          mm = (SELECT DISTINCT glav006 FROM glav_t 
                 WHERE glavent = g_enterprise 
                   #AND glav004 = xmdkdocdt  #170220-00038#1 mark
                   AND glav001 = l_glav001 
                   AND glav004 = docdt)           

  ##170214-00060#1 ---add (s)---
   UPDATE xckb_tmp 
      SET yy = g_master.yy, mm = g_master.pp
    WHERE xckb001 = '3' AND docdt IS NULL

   IF l_xcat005 = '3' THEN
      LET g_sql = " MERGE INTO xckb_tmp a",
                  " USING (SELECT xccald,xcca001,xcca002,xcca004,xcca005,xcca006,xcca007,xcca008, ",
                  "                xcca110, xcca110a,xcca110b,  ",
                  "                xcca110c,xcca110d,xcca110e, ",
                  "                xcca110f,xcca110g,xcca110h  ",
                  "          FROM xcca_t ",
                  "         WHERE xccaent = ",g_enterprise,
                  "           AND xcca001 = '1'",                    #帐套本位币顺序
                  "           AND xcca003 = '",g_xcat001,"'",      #成本计算类型
                  "    ) b ",
                  "    ON (b.xccald  = a.xckbld AND b.xcca002 = a.xckb038 AND b.xcca004 = a.yy ",
                  "   AND b.xcca005 = a.mm AND b.xcca006 = a.xckb012 AND b.xcca007 = a.xckb037) ",
                  "  WHEN MATCHED THEN ",
                  "        UPDATE SET a.xckb101  = b.xcca110, ",
                  "                   a.xckb101a = b.xcca110a, ",
                  "                   a.xckb101b = b.xcca110b, ",
                  "                   a.xckb101c = b.xcca110c, ",
                  "                   a.xckb101d = b.xcca110d, ",
                  "                   a.xckb101e = b.xcca110e, ",
                  "                   a.xckb101f = b.xcca110f, ",
                  "                   a.xckb101g = b.xcca110g, ",
                  "                   a.xckb101h = b.xcca110h "
   ELSE
      LET g_sql = " MERGE INTO xckb_tmp a",
                  " USING (SELECT xccald,xcca001,xcca002,xcca004,xcca005,xcca006,xcca007, ",
                  "                xcca110, xcca110a,xcca110b,  ",
                  "                xcca110c,xcca110d,xcca110e, ",
                  "                xcca110f,xcca110g,xcca110h  ",
                  "          FROM xcca_t ",
                  "         WHERE xccaent = ",g_enterprise,
                  "           AND xcca001 = '1'",                    #帐套本位币顺序
                  "           AND xcca003 = '",g_xcat001,"'",      #成本计算类型
                  "    ) b ",
                  "    ON (b.xccald  = a.xckbld AND b.xcca002 = a.xckb038 AND b.xcca004 = a.yy ",
                  "   AND b.xcca005 = a.mm AND b.xcca006 = a.xckb012 AND b.xcca007 = a.xckb037) ",
                  "  WHEN MATCHED THEN ",
                  "        UPDATE SET a.xckb101  = b.xcca110, ",
                  "                   a.xckb101a = b.xcca110a, ",
                  "                   a.xckb101b = b.xcca110b, ",
                  "                   a.xckb101c = b.xcca110c, ",
                  "                   a.xckb101d = b.xcca110d, ",
                  "                   a.xckb101e = b.xcca110e, ",
                  "                   a.xckb101f = b.xcca110f, ",
                  "                   a.xckb101g = b.xcca110g, ",
                  "                   a.xckb101h = b.xcca110h "
   END IF
   PREPARE xckb_pre6_1 FROM g_sql
   EXECUTE xckb_pre6_1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre6_1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
  #170214-00060#1 ---add (e)---

   IF l_xcat005 = '3' THEN 
      LET g_sql = " MERGE INTO xckb_tmp a",
                  " USING (SELECT xcccld,xccc001,xccc002,xccc004,xccc005,xccc006,xccc007,xccc008, ",
                  "                xccc280, xccc280a,xccc280b,  ",
                  "                xccc280c,xccc280d,xccc280e, ",
                  "                xccc280f,xccc280g,xccc280h  ",
                  "          FROM xccc_t ",
                  "         WHERE xcccent = ",g_enterprise,
                  "           AND xccc001 = '1'",                    #帐套本位币顺序
                  "           AND xccc003 = '",g_xcat001,"'",      #成本计算类型
                  "    ) b ",
                  "    ON (b.xcccld  = a.xckbld AND b.xccc002 = a.xckb038 AND b.xccc004 = a.yy ",
                  "    AND b.xccc008 = a.xckb017 ", #170323-00090#1 add                  
                  "   AND b.xccc005 = a.mm AND b.xccc006 = a.xckb012 AND b.xccc007 = a.xckb037) ",
                  "  WHEN MATCHED THEN ",
                  "        UPDATE SET a.xckb101  = b.xccc280, ",
                  "                   a.xckb101a = b.xccc280a, ",               
                  "                   a.xckb101b = b.xccc280b, ",               
                  "                   a.xckb101c = b.xccc280c, ",               
                  "                   a.xckb101d = b.xccc280d, ",               
                  "                   a.xckb101e = b.xccc280e, ",               
                  "                   a.xckb101f = b.xccc280f, ",               
                  "                   a.xckb101g = b.xccc280g, ",               
                  "                   a.xckb101h = b.xccc280h "     
   ELSE
      LET g_sql = " MERGE INTO xckb_tmp a",
                  " USING (SELECT xcccld,xccc001,xccc002,xccc004,xccc005,xccc006,xccc007,xccc008, ",  #170405-00005#1 add 增加xccc008
                  "                xccc280, xccc280a,xccc280b,  ",
                  "                xccc280c,xccc280d,xccc280e, ",
                  "                xccc280f,xccc280g,xccc280h  ",
                  "          FROM xccc_t ",
                  "         WHERE xcccent = ",g_enterprise,
                  "           AND xccc001 = '1'",                    #帐套本位币顺序
                  "           AND xccc003 = '",g_xcat001,"'",      #成本计算类型
                  "    ) b ",
                  "    ON (b.xcccld  = a.xckbld AND b.xccc002 = a.xckb038 AND b.xccc004 = a.yy ",
                  "    AND b.xccc008 = a.xckb017 ", #170323-00090#1 add                  
                  "   AND b.xccc005 = a.mm AND b.xccc006 = a.xckb012 AND b.xccc007 = a.xckb037) ",
                  "  WHEN MATCHED THEN ",
                  "        UPDATE SET a.xckb101  = b.xccc280, ",
                  "                   a.xckb101a = b.xccc280a, ",               
                  "                   a.xckb101b = b.xccc280b, ",               
                  "                   a.xckb101c = b.xccc280c, ",               
                  "                   a.xckb101d = b.xccc280d, ",               
                  "                   a.xckb101e = b.xccc280e, ",               
                  "                   a.xckb101f = b.xccc280f, ",               
                  "                   a.xckb101g = b.xccc280g, ",               
                  "                   a.xckb101h = b.xccc280h "   
   END IF                  
   PREPARE xckb_pre6 FROM g_sql
   EXECUTE xckb_pre6
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre6"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
  #UPDATE xckb2_tmp #170214-00060#1 mark
   UPDATE xckb_tmp  #170214-00060#1 add
      SET xckb102 =  xckb101  * xckb021,
          xckb102a = xckb101a * xckb021,
          xckb102b = xckb101b * xckb021,
          xckb102c = xckb101c * xckb021,
          xckb102d = xckb101d * xckb021,
          xckb102e = xckb101e * xckb021,
          xckb102f = xckb101f * xckb021,
          xckb102g = xckb101g * xckb021,
          xckb102h = xckb101h * xckb021 
          
   #币种一进行取位
   CASE g_round_type
      WHEN '1'
         LET g_sql = " UPDATE xckb_tmp ",
                     "    SET xckb102  = round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102a = round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102b = round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102c = round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102d = round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102e = round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102f = round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102g = round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102h = round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,") "          
      WHEN '2'
         LET g_sql = " UPDATE xckb_tmp ",
                     "    SET xckb102  = (CASE WHEN MOD(round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                     "        xckb102a  = (CASE WHEN MOD(round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                     "        xckb102b  = (CASE WHEN MOD(round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102c  = (CASE WHEN MOD(round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102d  = (CASE WHEN MOD(round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102e  = (CASE WHEN MOD(round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102f  = (CASE WHEN MOD(round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102g  = (CASE WHEN MOD(round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102h  = (CASE WHEN MOD(round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
      WHEN '3'
         LET g_sql = " UPDATE xckb_tmp ",
                     "    SET xckb102  = trunc(round(COALESCE(xckb102,0),6),",g_ooaj007_1,"),  ",
                     "        xckb102a = trunc(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,"), ",
                     "        xckb102b = trunc(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,"), ",
                     "        xckb102c = trunc(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,"), ",
                     "        xckb102d = trunc(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,"), ",
                     "        xckb102e = trunc(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,"), ",
                     "        xckb102f = trunc(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,"), ",
                     "        xckb102g = trunc(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,"), ",
                     "        xckb102h = trunc(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,") "
      WHEN '4'
         LET g_sql = " UPDATE xckb_tmp ",
                     "    SET xckb102  = ceil(round(COALESCE(xckb102,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102a = ceil(round(COALESCE(xckb102a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102b = ceil(round(COALESCE(xckb102b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102c = ceil(round(COALESCE(xckb102c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102d = ceil(round(COALESCE(xckb102d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102e = ceil(round(COALESCE(xckb102e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102f = ceil(round(COALESCE(xckb102f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102g = ceil(round(COALESCE(xckb102g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102h = ceil(round(COALESCE(xckb102h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
   END CASE
   PREPARE xckb_pre7 FROM g_sql
   EXECUTE xckb_pre7   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb_pre7"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   IF g_glaa015 = 'Y' THEN  #啟用本位幣二
      CALL s_aooi160_get_exrate('2',g_master.glaald,g_today,g_glaa001,g_glaa016,1,g_glaa018) RETURNING l_ext1            #金額
      UPDATE xckb_tmp
         SET xckb028 = g_glaa016,
             xckb029 = xckb027 * l_ext1,
             xckb111 =  xckb101 * l_ext1,
             xckb111a = xckb101a * l_ext1,
             xckb111b = xckb101b * l_ext1,
             xckb111c = xckb101c * l_ext1,
             xckb111d = xckb101d * l_ext1,
             xckb111e = xckb101e * l_ext1,
             xckb111f = xckb101f * l_ext1,
             xckb111g = xckb101g * l_ext1,
             xckb111h = xckb101h * l_ext1
      #币种二单价进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb111  = round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111a = round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111b = round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111c = round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111d = round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111e = round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111f = round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111g = round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111h = round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb111  = (CASE WHEN MOD(round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb111a  = (CASE WHEN MOD(round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb111b  = (CASE WHEN MOD(round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111c  = (CASE WHEN MOD(round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111d  = (CASE WHEN MOD(round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111e  = (CASE WHEN MOD(round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111f  = (CASE WHEN MOD(round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111g  = (CASE WHEN MOD(round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111h  = (CASE WHEN MOD(round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb111  = trunc(round(COALESCE(xckb111,0),6),",g_ooaj007_1,"),  ",
                        "        xckb111a = trunc(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,"), ",
                        "        xckb111b = trunc(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,"), ",
                        "        xckb111c = trunc(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,"), ",
                        "        xckb111d = trunc(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,"), ",
                        "        xckb111e = trunc(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,"), ",
                        "        xckb111f = trunc(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,"), ",
                        "        xckb111g = trunc(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,"), ",
                        "        xckb111h = trunc(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb111  = ceil(round(COALESCE(xckb111,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb111a = ceil(round(COALESCE(xckb111a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111b = ceil(round(COALESCE(xckb111b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111c = ceil(round(COALESCE(xckb111c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111d = ceil(round(COALESCE(xckb111d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111e = ceil(round(COALESCE(xckb111e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111f = ceil(round(COALESCE(xckb111f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111g = ceil(round(COALESCE(xckb111g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111h = ceil(round(COALESCE(xckb111h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE   
      PREPARE xckb_pre8 FROM g_sql
      EXECUTE xckb_pre8 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb_pre8"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      UPDATE xckb_tmp
         SET xckb112 =  xckb111  * xckb021,
             xckb112a = xckb111a * xckb021,
             xckb112b = xckb111b * xckb021,
             xckb112c = xckb111c * xckb021,
             xckb112d = xckb111d * xckb021,
             xckb112e = xckb111e * xckb021,
             xckb112f = xckb111f * xckb021,
             xckb112g = xckb111g * xckb021,
             xckb112h = xckb111h * xckb021 
      #币种二金额进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb112  = round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112a = round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112b = round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112c = round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112d = round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112e = round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112f = round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112g = round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112h = round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb112  = (CASE WHEN MOD(round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb112a  = (CASE WHEN MOD(round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb112b  = (CASE WHEN MOD(round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112c  = (CASE WHEN MOD(round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112d  = (CASE WHEN MOD(round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112e  = (CASE WHEN MOD(round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112f  = (CASE WHEN MOD(round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112g  = (CASE WHEN MOD(round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112h  = (CASE WHEN MOD(round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb112  = trunc(round(COALESCE(xckb112,0),6),",g_ooaj007_1,"),  ",
                        "        xckb112a = trunc(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,"), ",
                        "        xckb112b = trunc(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,"), ",
                        "        xckb112c = trunc(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,"), ",
                        "        xckb112d = trunc(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,"), ",
                        "        xckb112e = trunc(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,"), ",
                        "        xckb112f = trunc(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,"), ",
                        "        xckb112g = trunc(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,"), ",
                        "        xckb112h = trunc(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb112  = ceil(round(COALESCE(xckb112,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb112a = ceil(round(COALESCE(xckb112a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112b = ceil(round(COALESCE(xckb112b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112c = ceil(round(COALESCE(xckb112c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112d = ceil(round(COALESCE(xckb112d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112e = ceil(round(COALESCE(xckb112e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112f = ceil(round(COALESCE(xckb112f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112g = ceil(round(COALESCE(xckb112g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112h = ceil(round(COALESCE(xckb112h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE  
      PREPARE xckb_pre9 FROM g_sql
      EXECUTE xckb_pre9 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb_pre9"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF
   
   IF g_glaa019 = 'Y' THEN  #啟用本位幣三
      CALL s_aooi160_get_exrate('2',g_master.glaald,g_today,g_glaa001,g_glaa020,1,g_glaa022) RETURNING l_ext2            #金額
      UPDATE xckb_tmp
         SET xckb030 = g_glaa020,
             xckb031 =  xckb027 * l_ext2,
             xckb121 =  xckb101 * l_ext2,
             xckb121a = xckb101a * l_ext2,
             xckb121b = xckb101b * l_ext2,
             xckb121c = xckb101c * l_ext2,
             xckb121d = xckb101d * l_ext2,
             xckb121e = xckb101e * l_ext2,
             xckb121f = xckb101f * l_ext2,
             xckb121g = xckb101g * l_ext2,
             xckb121h = xckb101h * l_ext2
      #币种三单价进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb121  = round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121a = round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121b = round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121c = round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121d = round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121e = round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121f = round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121g = round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121h = round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb121  = (CASE WHEN MOD(round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb121a  = (CASE WHEN MOD(round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb121b  = (CASE WHEN MOD(round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121c  = (CASE WHEN MOD(round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121d  = (CASE WHEN MOD(round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121e  = (CASE WHEN MOD(round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121f  = (CASE WHEN MOD(round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121g  = (CASE WHEN MOD(round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121h  = (CASE WHEN MOD(round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb121  = trunc(round(COALESCE(xckb121,0),6),",g_ooaj007_1,"),  ",
                        "        xckb121a = trunc(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,"), ",
                        "        xckb121b = trunc(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,"), ",
                        "        xckb121c = trunc(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,"), ",
                        "        xckb121d = trunc(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,"), ",
                        "        xckb121e = trunc(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,"), ",
                        "        xckb121f = trunc(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,"), ",
                        "        xckb121g = trunc(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,"), ",
                        "        xckb121h = trunc(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb121  = ceil(round(COALESCE(xckb121,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb121a = ceil(round(COALESCE(xckb121a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121b = ceil(round(COALESCE(xckb121b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121c = ceil(round(COALESCE(xckb121c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121d = ceil(round(COALESCE(xckb121d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121e = ceil(round(COALESCE(xckb121e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121f = ceil(round(COALESCE(xckb121f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121g = ceil(round(COALESCE(xckb121g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121h = ceil(round(COALESCE(xckb121h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE 
      PREPARE xckb_pre10 FROM g_sql
      EXECUTE xckb_pre10  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb_pre10"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      UPDATE xckb_tmp
         SET xckb122 =  xckb121  * xckb021,
             xckb122a = xckb121a * xckb021,
             xckb122b = xckb121b * xckb021,
             xckb122c = xckb121c * xckb021,
             xckb122d = xckb121d * xckb021,
             xckb122e = xckb121e * xckb021,
             xckb122f = xckb121f * xckb021,
             xckb122g = xckb121g * xckb021,
             xckb122h = xckb121h * xckb021 
      #币种三金额进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb122  = round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122a = round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122b = round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122c = round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122d = round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122e = round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122f = round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122g = round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122h = round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb122  = (CASE WHEN MOD(round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb122a  = (CASE WHEN MOD(round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb122b  = (CASE WHEN MOD(round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122c  = (CASE WHEN MOD(round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122d  = (CASE WHEN MOD(round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122e  = (CASE WHEN MOD(round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122f  = (CASE WHEN MOD(round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122g  = (CASE WHEN MOD(round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122h  = (CASE WHEN MOD(round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb122  = trunc(round(COALESCE(xckb122,0),6),",g_ooaj007_1,"),  ",
                        "        xckb122a = trunc(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,"), ",
                        "        xckb122b = trunc(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,"), ",
                        "        xckb122c = trunc(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,"), ",
                        "        xckb122d = trunc(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,"), ",
                        "        xckb122e = trunc(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,"), ",
                        "        xckb122f = trunc(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,"), ",
                        "        xckb122g = trunc(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,"), ",
                        "        xckb122h = trunc(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb_tmp ",
                        "    SET xckb122  = ceil(round(COALESCE(xckb122,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb122a = ceil(round(COALESCE(xckb122a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122b = ceil(round(COALESCE(xckb122b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122c = ceil(round(COALESCE(xckb122c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122d = ceil(round(COALESCE(xckb122d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122e = ceil(round(COALESCE(xckb122e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122f = ceil(round(COALESCE(xckb122f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122g = ceil(round(COALESCE(xckb122g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122h = ceil(round(COALESCE(xckb122h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE  
      PREPARE xckb_pre11 FROM g_sql
      EXECUTE xckb_pre11
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb_pre11"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  
   RETURN r_success
END FUNCTION

################################################################################
# Date & Author..: 2017/01/22 By xianghui
# Modify.........: #170104-00054#1
################################################################################
PRIVATE FUNCTION axcp200_ins_xckb2_new()
DEFINE l_success    LIKE type_t.num5
DEFINE l_qty        LIKE inag_t.inag008 
DEFINE l_imaa001    LIKE imaa_t.imaa001
DEFINE l_from_unit  LIKE inag_t.inag007 
DEFINE l_to_unit    LIKE inag_t.inag007
DEFINE l_ext1       LIKE ooan_t.ooan005
DEFINE l_ext2       LIKE ooan_t.ooan005
DEFINE r_success    LIKE type_t.num5
DEFINE l_count      LIKE type_t.num10


   LET r_success = TRUE
   LET g_wc_ais = g_master.wc
  #170214-00060#1 ---mark (s)---
  #LET g_wc_ais = cl_replace_str(g_wc_ais,"pmaa001","xrca005") #客戶
  #LET g_wc_ais = cl_replace_str(g_wc_ais,"imaa001","xrcb004") #產品編號  
  #170214-00060#1 ---mark (e)---
   LET g_wc_ais = cl_replace_str(g_wc_ais,"pmaa001","isaf003") #170214-00060#1 add
  
   LET l_count = 0
   LET g_sql = " SELECT COUNT(1) ",
               "   FROM isaf_t,isag_t ",
               "   LEFT JOIN imaa_t ON imaaent = isagent AND imaa001 = isag009 ",   #161223-00020#1 add
               "  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno ",
               "    AND isafent = ",g_enterprise,
               "    AND isafcomp='",g_comp,"' ",
               "    AND isafstus IN ('S' ,'Y') ",
               "    AND isaf014 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND isag009 IS NOT NULL ",
               "    AND isag001 in ('11','21') ",   #170417-00016#1
               "    AND ",g_wc_ais CLIPPED
   PREPARE xckb2_count_pre FROM g_sql
   EXECUTE xckb2_count_pre INTO l_count
   IF l_count = 0 THEN
      RETURN r_success
   END IF


   DELETE FROM convert_tmp;
   LET g_sql = " INSERT INTO convert_tmp ",
               " SELECT DISTINCT isag009,isag005,imaa006,1 ",
               "   FROM isaf_t,isag_t ",
               "   LEFT JOIN imaa_t ON imaaent = isagent AND imaa001 = isag009 ",   #161223-00020#1 add
               "  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno ",
               "    AND isafent = ",g_enterprise,
               "    AND isafcomp='",g_comp,"' ",
               "    AND isafstus IN ('S' ,'Y') ",
               "    AND isaf014 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND isag009 IS NOT NULL ",
               "    AND isag001 in ('11','21') ",   #170417-00016#1
               "    AND ",g_wc_ais CLIPPED
   PREPARE xckb2_pre1 FROM g_sql
   EXECUTE xckb2_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   UPDATE convert_tmp
      SET from_unit = 'PCS'
    WHERE imaa001 = 'MISC'
      AND from_unit IS NULL
      
   LET g_sql = " SELECT DISTINCT imaa001,from_unit,to_unit ",
               "   FROM convert_tmp "
   PREPARE xckb2_pre2 FROM g_sql
   DECLARE xckb2_cur2 CURSOR FOR xckb2_pre2
   FOREACH xckb2_cur2 INTO l_imaa001,l_from_unit,l_to_unit
      CALL s_aooi250_convert_qty(l_imaa001,l_from_unit,l_to_unit,1)
         RETURNING l_success,l_qty
      IF l_success THEN
　       UPDATE convert_tmp
            SET qty = l_qty
          WHERE imaa001 = l_imaa001
            AND from_unit = l_from_unit
            AND to_unit = l_to_unit
      END IF
   END FOREACH

   LET g_sql = " INSERT INTO xckb2_tmp(xckbent,xckbcomp,xckbld,xckb001,xckb002,",
               "                 xckb003,xckb004,xckb005,xckb006,xckb007,",
               "                 xckb008,xckb009,xckb010,xckb011,xckb012,",
               "                 xckb013,xckb014,xckb015,xckb016,xckb017,",
               "                 xckb018,xckb019,xckb020,xckb021,xckb022,",
               "                 xckb023,xckb024,xckb025,xckb026,xckb027,",
               "                 xckb028,xckb029,xckb030,xckb031,xckb032,",
               "                 xckb033,xckb034,xckb035,xckb036,xckb037,",
               "                 xckb101,xckb101a,xckb101b,xckb101c,xckb101d,",
               "                 xckb101e,xckb101f,xckb101g,xckb101h,xckb102,",
               "                 xckb102a,xckb102b,xckb102c,xckb102d,xckb102e,",
               "                 xckb102f,xckb102g,xckb102h,xckb111,xckb111a,",
               "                 xckb111b,xckb111c,xckb111d,xckb111e,xckb111f,",
               "                 xckb111g,xckb111h,xckb112,xckb112a,xckb112b,",
               "                 xckb112c,xckb112d,xckb112e,xckb112f,xckb112g,",
               "                 xckb112h,xckb121,xckb121a,xckb121b,xckb121c,",
               "                 xckb121d,xckb121e,xckb121f,xckb121g,xckb121h,",
               "                 xckb122,xckb122a,xckb122b,xckb122c,xckb122d,",
               "                 xckb122e,xckb122f,xckb122g,xckb122h,xckb038) ",        
               " SELECT ",g_enterprise,",'",g_comp,"','",g_master.glaald,"','4','-1',",
               #"        isaf011,'",g_site,"',isag002,isag003,",g_master.yy,",",                  #170306-00053 wujie mark
               "        NVL(isaf011,' ') isaf011,'",g_site,"',isag002,isag003,",g_master.yy,",",  #170306-00053 wujie add NVL
               "        ",g_master.pp,",isaf003,isaf005,isaf006,isag009,",
               #"        isag005,DECODE(isag005,NULL,isag004,isag004*isag005),' ',' ',' ',", #170220-00038#1 mark
               #"        isag005,DECODE(isag005,NULL,isag004,isag004*isag015),' ',' ',' ',",  #170220-00038#1 add               #170306-00053 wujie mark
               "        isag005,SUM(DECODE(isag005,NULL,isag004,isag004*isag015)) isag004,' ',' ',' ',",  #170220-00038#1 add   #170306-00053 wujie mod
               "        '',isaf010,imaa006,'','',",
               "        'N','','','",g_glaa001,"',SUM(isag115),"  #170306-00053#1 wujie add SUM()
      IF g_glaa015 = 'Y' THEN                        
         LET g_sql = g_sql,"'",g_glaa016,"',0,"
      ELSE
         LET g_sql = g_sql,"'',0,"
      END IF
      IF g_glaa019 = 'Y' THEN                        
         LET g_sql = g_sql,"'",g_glaa020,"',0,'',"
      ELSE
         LET g_sql = g_sql,"'',0,'',"
      END IF
      LET g_sql = g_sql,
                 "'','','',0,' ',",
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,", 
                 "0,0,0,0,0,0,0,0,0,",
                 "0,0,0,0,0,0,0,0,0,",
                 "0,0,0,0,0,0,0,0,0,",
                 "' '", #170214-00060#1 remove ,
                 "   FROM isaf_t,isag_t ",
                 "   LEFT JOIN imaa_t ON imaaent = isagent AND imaa001 = isag009 ",  
                 "  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno ",
                 "    AND isafent = ",g_enterprise,
                 "    AND isafcomp='",g_comp,"' ",
                 "    AND isafstus IN ('S' ,'Y') ",
                 "    AND isaf014 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
                 "    AND isag009 IS NOT NULL ",
                 "    AND isag001 in ('11','21') ",  #170214-00060#1 add
                 "    AND ",g_wc_ais CLIPPED,
                 " GROUP BY isaf011,isag002,isag003,isaf003,isaf005,isaf006,isag009,isag005,isaf010,imaa006"    #170306-00053 wujie add                    
   PREPARE xckb2_pre3 FROM g_sql
   EXECUTE xckb2_pre3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   
   #更新库存数量栏位         
   LET g_sql = " MERGE INTO xckb2_tmp a",
               " USING (SELECT imaa001,from_unit,to_unit,qty FROM convert_tmp ) b",
               "    ON (a.xckb012 = b.imaa001 AND a.xckb013 = b.from_unit AND a.xckb020 = b.to_unit) ",
               "  WHEN MATCHED THEN ",
               "        UPDATE SET a.xckb021 = a.xckb014*b.qty "
   PREPARE xckb2_pre4 FROM g_sql
   EXECUTE xckb2_pre4    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   #科目
   LET g_sql =     " MERGE INTO xckb2_tmp ",
                   " USING (SELECT glcc002,glcc016 FROM glcc_t",
                   "         WHERE glccent = ",g_enterprise," AND glcc001 = '1' ",
                   "           AND glccld  = '",g_master.glaald,"' ",
                   "           AND (glcc014='",g_comp,"' OR glcc014='*' ) AND ROWNUM = 1 ORDER BY glcc016 ) ",
                   "    ON ((glcc016 = xckb012 OR glcc016 = '*') ) ",
                   "    WHEN MATCHED THEN  ",
                   "    UPDATE SET xckb022 = glcc002"
   PREPARE xckb2_pre5 FROM g_sql
   EXECUTE xckb2_pre5
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre5"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   #更新成本域    
   IF g_sys_6001 = 'N' THEN
      UPDATE xckb2_tmp 
         SET xckb038 = ' ' 
   ELSE
      CASE g_sys_6002
         WHEN '1'  #组织
            UPDATE xckb2_tmp 
               SET xckb038 = (SELECT xcbf001 FROM xcbf_t
                               WHERE xcbfent  = g_enterprise
                                 AND xcbfcomp = g_comp
                                 AND xcbf002  = xckb004)                    
         WHEN '2'  #仓库
            UPDATE xckb2_tmp 
               SET xckb038 = (SELECT xcbf001 FROM xcbf_t
                               WHERE xcbfent  = g_enterprise
                                 AND xcbfcomp = g_comp
                                 AND xcbf002  = xckb015) 
         WHEN '3' #库存管理特征
            UPDATE xckb2_tmp 
               SET xckb038 = (SELECT xmdl052 FROM xmdl_t
                               WHERE xmdlent  = g_enterprise
                                 AND xmdldocno = xckb005
                                 AND xmdlseq  = xckb006)                      
      END CASE
   END IF    
   #特性
   UPDATE xckb2_tmp 
      SET xckb037 = (SELECT NVL(xmdl009,' ') FROM xmdl_t
                      WHERE xmdlent  = g_enterprise
                        AND xmdldocno = xckb005
                        AND xmdlseq  = xckb006)  

   #170322-00109#1 add--s
   #按料件特性计算成本否
   IF g_sys_6013 = 'N' THEN
      UPDATE xckb2_tmp SET xckb037 = ' '
   END IF
   #170322-00109#1 add--e

  #170214-00060#1 ---mark (s)---                        
  #LET g_sql = " MERGE INTO xckb2_tmp a",
  #            " USING (SELECT xcccld,xccc001,xccc002,xccc004,xccc005,xccc006,xccc007,xccc008, ",
  #            "                xccc280, xccc280a,xccc280b,  ",
  #            "                xccc280c,xccc280d,xccc280e, ",
  #            "                xccc280f,xccc280g,xccc280h  ",
  #            "          FROM xccc_t ",
  #            "         WHERE xcccent = ",g_enterprise,
  #            "           AND xccc001 = '1'",                    #帐套本位币顺序
  #            "           AND xccc003 = '",g_xcat001,"'",      #成本计算类型
  #            "       ) b ",
  #            "    ON (b.xcccld  = a.xckbld AND b.xccc002 = a.xckb038 AND b.xccc004 = xckb007",
  #            "   AND b.xccc005 = xckb008 AND b.xccc006 = a.xckb012 AND b.xccc007 = a.xckb037 AND b.xccc008 = a.xckb017) ",
  #            "  WHEN MATCHED THEN ",
  #            "        UPDATE SET a.xckb101  = b.xccc280, ",
  #            "                   a.xckb101a = b.xccc280a, ",               
  #            "                   a.xckb101b = b.xccc280b, ",               
  #            "                   a.xckb101c = b.xccc280c, ",               
  #            "                   a.xckb101d = b.xccc280d, ",               
  #            "                   a.xckb101e = b.xccc280e, ",               
  #            "                   a.xckb101f = b.xccc280f, ",               
  #            "                   a.xckb101g = b.xccc280g, ",               
  #            "                   a.xckb101h = b.xccc280h "               
  #PREPARE xckb2_pre8 FROM g_sql
  #EXECUTE xckb2_pre8
  #IF SQLCA.sqlcode THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code   = SQLCA.sqlcode
  #   LET g_errparam.extend = "EXECUTE xckb2_pre8"
  #   LET g_errparam.popup  = TRUE
  #   CALL cl_err()
  #   LET r_success = FALSE
  #   RETURN r_success
  #END IF  
  #170214-00060#1 ---mark (e)--- 
   
  #170214-00060#1 ---add (s)--- 
   LET g_sql = " MERGE INTO xckb2_tmp a",
               " USING (SELECT xcccld,xccc001,xccc002,xccc004,xccc005,xccc006,xccc007,xccc008, ",
               "                xccc280, xccc280a,xccc280b,  ",
               "                xccc280c,xccc280d,xccc280e, ",
               "                xccc280f,xccc280g,xccc280h  ",
               "          FROM xccc_t ",
               "         WHERE xcccent = ",g_enterprise,
               "           AND xccc001 = '1'",                    #帐套本位币顺序
               "           AND xccc003 = '",g_xcat001,"'",      #成本计算类型
               "       ) b ",
               "    ON (b.xcccld  = a.xckbld AND b.xccc002 = a.xckb038 AND b.xccc004 = xckb007",
               "   AND b.xccc005 = xckb008 AND b.xccc006 = a.xckb012 AND b.xccc007 = a.xckb037 AND b.xccc008 = a.xckb017) ",
               "  WHEN MATCHED THEN ",
               "        UPDATE SET a.xckb101  = b.xccc280, ",
               "                   a.xckb101a = b.xccc280a, ",               
               "                   a.xckb101b = b.xccc280b, ",               
               "                   a.xckb101c = b.xccc280c, ",               
               "                   a.xckb101d = b.xccc280d, ",               
               "                   a.xckb101e = b.xccc280e, ",               
               "                   a.xckb101f = b.xccc280f, ",               
               "                   a.xckb101g = b.xccc280g, ",               
               "                   a.xckb101h = b.xccc280h "               
   PREPARE xckb2_pre8 FROM g_sql
   EXECUTE xckb2_pre8
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre8"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET g_sql = " MERGE INTO xckb2_tmp a",
               " USING (SELECT distinct xckbent,xckbcomp,xckbld,xckb005,xckb006,",
               "               xckb101, xckb101a,xckb101b,  ",
               "               xckb101c,xckb101d,xckb101e, ",
               "               xckb101f,xckb101g,xckb101h  ",
               "          FROM xckb_t ",
               "         WHERE xckbent = ",g_enterprise,
               "           AND xckb002 = 1 ",
               "       ) b ",
               "    ON (a.xckbent = b.xckbent AND a.xckbcomp = b.xckbcomp AND a.xckbld = b.xckbld AND ",
               "        a.xckb005 = b.xckb005 AND a.xckb006 = b.xckb006 ) ",
               "  WHEN MATCHED THEN ",
               "        UPDATE SET a.xckb101  = b.xckb101, ",
               "                   a.xckb101a = b.xckb101a, ",               
               "                   a.xckb101b = b.xckb101b, ",               
               "                   a.xckb101c = b.xckb101c, ",               
               "                   a.xckb101d = b.xckb101d, ",               
               "                   a.xckb101e = b.xckb101e, ",               
               "                   a.xckb101f = b.xckb101f, ",               
               "                   a.xckb101g = b.xckb101g, ",               
               "                   a.xckb101h = b.xckb101h "               

   PREPARE xckb2_pre81 FROM g_sql
   EXECUTE xckb2_pre81
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre81"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  

   ## 同月份的處理 from xckb_tmp
   LET g_sql = " MERGE INTO xckb2_tmp a",
               " USING (SELECT distinct xckbent,xckbcomp,xckbld,xckb005,xckb006,",
               "               xckb101, xckb101a,xckb101b,  ",
               "               xckb101c,xckb101d,xckb101e, ",
               "               xckb101f,xckb101g,xckb101h  ",
               "          FROM xckb_tmp ",
               "         WHERE xckbent = ",g_enterprise,
               "           AND xckb002 = 1 ",
               "       ) b ",
               "    ON (a.xckbent = b.xckbent AND a.xckbcomp = b.xckbcomp AND a.xckbld = b.xckbld AND ",
               "        a.xckb005 = b.xckb005 AND a.xckb006 = b.xckb006 ) ",
               "  WHEN MATCHED THEN ",
               "        UPDATE SET a.xckb101  = b.xckb101, ",
               "                   a.xckb101a = b.xckb101a, ",               
               "                   a.xckb101b = b.xckb101b, ",               
               "                   a.xckb101c = b.xckb101c, ",               
               "                   a.xckb101d = b.xckb101d, ",               
               "                   a.xckb101e = b.xckb101e, ",               
               "                   a.xckb101f = b.xckb101f, ",               
               "                   a.xckb101g = b.xckb101g, ",               
               "                   a.xckb101h = b.xckb101h "               

   PREPARE xckb2_pre82 FROM g_sql
   EXECUTE xckb2_pre82
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre82"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
  #170214-00060#1 ---add (e)--- 
   
   UPDATE xckb2_tmp
      SET xckb102 =  xckb101  * xckb021,
          xckb102a = xckb101a * xckb021,
          xckb102b = xckb101b * xckb021,
          xckb102c = xckb101c * xckb021,
          xckb102d = xckb101d * xckb021,
          xckb102e = xckb101e * xckb021,
          xckb102f = xckb101f * xckb021,
          xckb102g = xckb101g * xckb021,
          xckb102h = xckb101h * xckb021   
   #币种一进行取位
   CASE g_round_type
      WHEN '1'
         LET g_sql = " UPDATE xckb2_tmp ",
                     "    SET xckb102  = round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102a = round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102b = round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102c = round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102d = round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102e = round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102f = round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102g = round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,"), ",         
                     "        xckb102h = round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,") "          
      WHEN '2'
         LET g_sql = " UPDATE xckb2_tmp ",
                     "    SET xckb102  = (CASE WHEN MOD(round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                     "        xckb102a  = (CASE WHEN MOD(round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                     "        xckb102b  = (CASE WHEN MOD(round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102c  = (CASE WHEN MOD(round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102d  = (CASE WHEN MOD(round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102e  = (CASE WHEN MOD(round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102f  = (CASE WHEN MOD(round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102g  = (CASE WHEN MOD(round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                     "        xckb102h  = (CASE WHEN MOD(round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,") ",
                     "                         ELSE round(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
      WHEN '3'
         LET g_sql = " UPDATE xckb2_tmp ",
                     "    SET xckb102  = trunc(round(COALESCE(xckb102,0),6),",g_ooaj007_1,"),  ",
                     "        xckb102a = trunc(round(COALESCE(xckb102a,0),6),",g_ooaj007_1,"), ",
                     "        xckb102b = trunc(round(COALESCE(xckb102b,0),6),",g_ooaj007_1,"), ",
                     "        xckb102c = trunc(round(COALESCE(xckb102c,0),6),",g_ooaj007_1,"), ",
                     "        xckb102d = trunc(round(COALESCE(xckb102d,0),6),",g_ooaj007_1,"), ",
                     "        xckb102e = trunc(round(COALESCE(xckb102e,0),6),",g_ooaj007_1,"), ",
                     "        xckb102f = trunc(round(COALESCE(xckb102f,0),6),",g_ooaj007_1,"), ",
                     "        xckb102g = trunc(round(COALESCE(xckb102g,0),6),",g_ooaj007_1,"), ",
                     "        xckb102h = trunc(round(COALESCE(xckb102h,0),6),",g_ooaj007_1,") "
      WHEN '4'
         LET g_sql = " UPDATE xckb2_tmp ",
                     "    SET xckb102  = ceil(round(COALESCE(xckb102,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                     "        xckb102a = ceil(round(COALESCE(xckb102a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102b = ceil(round(COALESCE(xckb102b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102c = ceil(round(COALESCE(xckb102c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102d = ceil(round(COALESCE(xckb102d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102e = ceil(round(COALESCE(xckb102e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102f = ceil(round(COALESCE(xckb102f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102g = ceil(round(COALESCE(xckb102g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                     "        xckb102h = ceil(round(COALESCE(xckb102h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
   END CASE
   PREPARE xckb2_pre10 FROM g_sql
   EXECUTE xckb2_pre10
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE xckb2_pre10"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
    
   IF g_glaa015 = 'Y' THEN  #啟用本位幣二
      CALL s_aooi160_get_exrate('2',g_master.glaald,g_today,g_glaa001,g_glaa016,1,g_glaa018) RETURNING l_ext1            #金額
      UPDATE xckb2_tmp
         SET xckb028 = g_glaa016,
             xckb029 = xckb027 * l_ext1,
             xckb111 =  xckb101 * l_ext1,
             xckb111a = xckb101a * l_ext1,
             xckb111b = xckb101b * l_ext1,
             xckb111c = xckb101c * l_ext1,
             xckb111d = xckb101d * l_ext1,
             xckb111e = xckb101e * l_ext1,
             xckb111f = xckb101f * l_ext1,
             xckb111g = xckb101g * l_ext1,
             xckb111h = xckb101h * l_ext1
      #币种二单价进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb111  = round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111a = round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111b = round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111c = round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111d = round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111e = round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111f = round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111g = round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb111h = round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb111  = (CASE WHEN MOD(round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb111a  = (CASE WHEN MOD(round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb111b  = (CASE WHEN MOD(round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111c  = (CASE WHEN MOD(round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111d  = (CASE WHEN MOD(round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111e  = (CASE WHEN MOD(round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111f  = (CASE WHEN MOD(round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111g  = (CASE WHEN MOD(round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb111h  = (CASE WHEN MOD(round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb111  = trunc(round(COALESCE(xckb111,0),6),",g_ooaj007_1,"),  ",
                        "        xckb111a = trunc(round(COALESCE(xckb111a,0),6),",g_ooaj007_1,"), ",
                        "        xckb111b = trunc(round(COALESCE(xckb111b,0),6),",g_ooaj007_1,"), ",
                        "        xckb111c = trunc(round(COALESCE(xckb111c,0),6),",g_ooaj007_1,"), ",
                        "        xckb111d = trunc(round(COALESCE(xckb111d,0),6),",g_ooaj007_1,"), ",
                        "        xckb111e = trunc(round(COALESCE(xckb111e,0),6),",g_ooaj007_1,"), ",
                        "        xckb111f = trunc(round(COALESCE(xckb111f,0),6),",g_ooaj007_1,"), ",
                        "        xckb111g = trunc(round(COALESCE(xckb111g,0),6),",g_ooaj007_1,"), ",
                        "        xckb111h = trunc(round(COALESCE(xckb111h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb111  = ceil(round(COALESCE(xckb111,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb111a = ceil(round(COALESCE(xckb111a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111b = ceil(round(COALESCE(xckb111b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111c = ceil(round(COALESCE(xckb111c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111d = ceil(round(COALESCE(xckb111d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111e = ceil(round(COALESCE(xckb111e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111f = ceil(round(COALESCE(xckb111f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111g = ceil(round(COALESCE(xckb111g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb111h = ceil(round(COALESCE(xckb111h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE   
      PREPARE xckb2_pre11 FROM g_sql
      EXECUTE xckb2_pre11 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb2_pre11"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF       
      UPDATE xckb2_tmp
         SET xckb112 =  xckb111  * xckb021,
             xckb112a = xckb111a * xckb021,
             xckb112b = xckb111b * xckb021,
             xckb112c = xckb111c * xckb021,
             xckb112d = xckb111d * xckb021,
             xckb112e = xckb111e * xckb021,
             xckb112f = xckb111f * xckb021,
             xckb112g = xckb111g * xckb021,
             xckb112h = xckb111h * xckb021 
      #币种二金额进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb112  = round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112a = round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112b = round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112c = round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112d = round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112e = round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112f = round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112g = round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb112h = round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb112  = (CASE WHEN MOD(round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb112a  = (CASE WHEN MOD(round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb112b  = (CASE WHEN MOD(round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112c  = (CASE WHEN MOD(round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112d  = (CASE WHEN MOD(round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112e  = (CASE WHEN MOD(round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112f  = (CASE WHEN MOD(round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112g  = (CASE WHEN MOD(round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb112h  = (CASE WHEN MOD(round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb112  = trunc(round(COALESCE(xckb112,0),6),",g_ooaj007_1,"),  ",
                        "        xckb112a = trunc(round(COALESCE(xckb112a,0),6),",g_ooaj007_1,"), ",
                        "        xckb112b = trunc(round(COALESCE(xckb112b,0),6),",g_ooaj007_1,"), ",
                        "        xckb112c = trunc(round(COALESCE(xckb112c,0),6),",g_ooaj007_1,"), ",
                        "        xckb112d = trunc(round(COALESCE(xckb112d,0),6),",g_ooaj007_1,"), ",
                        "        xckb112e = trunc(round(COALESCE(xckb112e,0),6),",g_ooaj007_1,"), ",
                        "        xckb112f = trunc(round(COALESCE(xckb112f,0),6),",g_ooaj007_1,"), ",
                        "        xckb112g = trunc(round(COALESCE(xckb112g,0),6),",g_ooaj007_1,"), ",
                        "        xckb112h = trunc(round(COALESCE(xckb112h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb112  = ceil(round(COALESCE(xckb112,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb112a = ceil(round(COALESCE(xckb112a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112b = ceil(round(COALESCE(xckb112b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112c = ceil(round(COALESCE(xckb112c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112d = ceil(round(COALESCE(xckb112d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112e = ceil(round(COALESCE(xckb112e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112f = ceil(round(COALESCE(xckb112f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112g = ceil(round(COALESCE(xckb112g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb112h = ceil(round(COALESCE(xckb112h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE  
      PREPARE xckb2_pre12 FROM g_sql
      EXECUTE xckb2_pre12 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb2_pre12"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF       
   END IF
   
   IF g_glaa019 = 'Y' THEN  #啟用本位幣三
      CALL s_aooi160_get_exrate('2',g_master.glaald,g_today,g_glaa001,g_glaa020,1,g_glaa022) RETURNING l_ext2            #金額
      UPDATE xckb2_tmp
         SET xckb030 = g_glaa020,
             xckb031 =  xckb027 * l_ext2,
             xckb121 =  xckb101 * l_ext2,
             xckb121a = xckb101a * l_ext2,
             xckb121b = xckb101b * l_ext2,
             xckb121c = xckb101c * l_ext2,
             xckb121d = xckb101d * l_ext2,
             xckb121e = xckb101e * l_ext2,
             xckb121f = xckb101f * l_ext2,
             xckb121g = xckb101g * l_ext2,
             xckb121h = xckb101h * l_ext2
      #币种三单价进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb121  = round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121a = round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121b = round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121c = round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121d = round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121e = round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121f = round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121g = round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb121h = round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb121  = (CASE WHEN MOD(round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb121a  = (CASE WHEN MOD(round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb121b  = (CASE WHEN MOD(round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121c  = (CASE WHEN MOD(round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121d  = (CASE WHEN MOD(round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121e  = (CASE WHEN MOD(round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121f  = (CASE WHEN MOD(round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121g  = (CASE WHEN MOD(round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb121h  = (CASE WHEN MOD(round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb121  = trunc(round(COALESCE(xckb121,0),6),",g_ooaj007_1,"),  ",
                        "        xckb121a = trunc(round(COALESCE(xckb121a,0),6),",g_ooaj007_1,"), ",
                        "        xckb121b = trunc(round(COALESCE(xckb121b,0),6),",g_ooaj007_1,"), ",
                        "        xckb121c = trunc(round(COALESCE(xckb121c,0),6),",g_ooaj007_1,"), ",
                        "        xckb121d = trunc(round(COALESCE(xckb121d,0),6),",g_ooaj007_1,"), ",
                        "        xckb121e = trunc(round(COALESCE(xckb121e,0),6),",g_ooaj007_1,"), ",
                        "        xckb121f = trunc(round(COALESCE(xckb121f,0),6),",g_ooaj007_1,"), ",
                        "        xckb121g = trunc(round(COALESCE(xckb121g,0),6),",g_ooaj007_1,"), ",
                        "        xckb121h = trunc(round(COALESCE(xckb121h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb121  = ceil(round(COALESCE(xckb121,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb121a = ceil(round(COALESCE(xckb121a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121b = ceil(round(COALESCE(xckb121b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121c = ceil(round(COALESCE(xckb121c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121d = ceil(round(COALESCE(xckb121d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121e = ceil(round(COALESCE(xckb121e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121f = ceil(round(COALESCE(xckb121f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121g = ceil(round(COALESCE(xckb121g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb121h = ceil(round(COALESCE(xckb121h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE 
      PREPARE xckb2_pre13 FROM g_sql
      EXECUTE xckb2_pre13 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb2_pre13"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF       
      UPDATE xckb2_tmp
         SET xckb122 =  xckb121  * xckb021,
             xckb122a = xckb121a * xckb021,
             xckb122b = xckb121b * xckb021,
             xckb122c = xckb121c * xckb021,
             xckb122d = xckb121d * xckb021,
             xckb122e = xckb121e * xckb021,
             xckb122f = xckb121f * xckb021,
             xckb122g = xckb121g * xckb021,
             xckb122h = xckb121h * xckb021 
      #币种三金额进行取位
      CASE g_round_type
         WHEN '1'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb122  = round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122a = round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122b = round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122c = round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122d = round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122e = round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122f = round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122g = round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,"), ",         
                        "        xckb122h = round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,") "          
         WHEN '2'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb122  = (CASE WHEN MOD(round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb122a  = (CASE WHEN MOD(round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ", 
                        "        xckb122b  = (CASE WHEN MOD(round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122c  = (CASE WHEN MOD(round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122d  = (CASE WHEN MOD(round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122e  = (CASE WHEN MOD(round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122f  = (CASE WHEN MOD(round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122g  = (CASE WHEN MOD(round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ), ",
                        "        xckb122h  = (CASE WHEN MOD(round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,"),(2/power(10,",g_ooaj007_1,")))=0 THEN round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,") ",
                        "                         ELSE round(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,")-(1/power(10,",g_ooaj007_1,")) END ) "                     
         WHEN '3'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb122  = trunc(round(COALESCE(xckb122,0),6),",g_ooaj007_1,"),  ",
                        "        xckb122a = trunc(round(COALESCE(xckb122a,0),6),",g_ooaj007_1,"), ",
                        "        xckb122b = trunc(round(COALESCE(xckb122b,0),6),",g_ooaj007_1,"), ",
                        "        xckb122c = trunc(round(COALESCE(xckb122c,0),6),",g_ooaj007_1,"), ",
                        "        xckb122d = trunc(round(COALESCE(xckb122d,0),6),",g_ooaj007_1,"), ",
                        "        xckb122e = trunc(round(COALESCE(xckb122e,0),6),",g_ooaj007_1,"), ",
                        "        xckb122f = trunc(round(COALESCE(xckb122f,0),6),",g_ooaj007_1,"), ",
                        "        xckb122g = trunc(round(COALESCE(xckb122g,0),6),",g_ooaj007_1,"), ",
                        "        xckb122h = trunc(round(COALESCE(xckb122h,0),6),",g_ooaj007_1,") "
         WHEN '4'
            LET g_sql = " UPDATE xckb2_tmp ",
                        "    SET xckb122  = ceil(round(COALESCE(xckb122,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"),  ",
                        "        xckb122a = ceil(round(COALESCE(xckb122a,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122b = ceil(round(COALESCE(xckb122b,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122c = ceil(round(COALESCE(xckb122c,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122d = ceil(round(COALESCE(xckb122d,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122e = ceil(round(COALESCE(xckb122e,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122f = ceil(round(COALESCE(xckb122f,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122g = ceil(round(COALESCE(xckb122g,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,"), ",
                        "        xckb122h = ceil(round(COALESCE(xckb122h,0),6)*power(10,",g_ooaj007_1,"))/power(10,",g_ooaj007_1,") "
      END CASE  
      PREPARE xckb2_pre14 FROM g_sql
      EXECUTE xckb2_pre14 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE xckb2_pre14"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF       
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 年度期別檢查
# Usage..........: CALL axcp200_date_chk()
# Date & Author..: 2017/02/20 By charles4m
# Modify.........: 170220-00038#1
################################################################################
PRIVATE FUNCTION axcp200_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   DEFINE l_comp         LIKE glaa_t.glaacomp
   
   IF cl_null(g_master.glaald) THEN RETURN END IF

   IF cl_null(g_master.yy) THEN RETURN END IF

   IF cl_null(g_master.pp) THEN RETURN END IF

   SELECT glaacomp INTO l_comp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.glaald
         
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_comp
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > g_master.yy THEN
      LET g_errno = 'axc-00303'
   END IF

   IF l_yy = g_master.yy AND l_pp >= g_master.pp THEN   
      LET g_errno = 'axc-00304'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: 尾差處理
# Usage..........: CALL axcp200_upd_xckb ()
#                  RETURNING l_success
# Return code....: l_success TRUE 成功 FALSE 失敗
# Date & Author..: 17/03/13 By fionchen(#170306-00022#1 add)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp200_upd_xckb()
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_xckb005          LIKE xckb_t.xckb005,
          l_xckb006          LIKE xckb_t.xckb006,
          l_outcome_xckb014  LIKE xckb_t.xckb014,
          l_outcome_xckb102  LIKE xckb_t.xckb102,
          l_outcome_xckb102a LIKE xckb_t.xckb102a,
          l_outcome_xckb102b LIKE xckb_t.xckb102b,
          l_outcome_xckb102c LIKE xckb_t.xckb102c,
          l_outcome_xckb102d LIKE xckb_t.xckb102d,
          l_outcome_xckb102e LIKE xckb_t.xckb102e,
          l_outcome_xckb102f LIKE xckb_t.xckb102f,
          l_outcome_xckb102g LIKE xckb_t.xckb102g,
          l_outcome_xckb102h LIKE xckb_t.xckb102h,
          --income
          l_income_xckb014   LIKE xckb_t.xckb014,
          l_income_xckb102   LIKE xckb_t.xckb102,
          l_income_xckb102a  LIKE xckb_t.xckb102a,
          l_income_xckb102b  LIKE xckb_t.xckb102b,
          l_income_xckb102c  LIKE xckb_t.xckb102c,
          l_income_xckb102d  LIKE xckb_t.xckb102d,
          l_income_xckb102e  LIKE xckb_t.xckb102e,
          l_income_xckb102f  LIKE xckb_t.xckb102f,
          l_income_xckb102g  LIKE xckb_t.xckb102g,
          l_income_xckb102h  LIKE xckb_t.xckb102h
   
   LET r_success = TRUE
   
   ## 先取出本月有轉出的單子及累計的轉出量、轉出金額
   LET g_sql = " SELECT a.xckb005,a.xckb006,SUM(a.xckb014), ",
               "        SUM(a.xckb102), SUM(a.xckb102a), SUM(a.xckb102b), SUM(a.xckb102c), ",
               "        SUM(a.xckb102d),SUM(a.xckb102e), SUM(a.xckb102f), SUM(a.xckb102g), SUM(a.xckb102h) ",
               "   FROM xckb_t a",
               "  WHERE a.xckbent = '",g_enterprise,"' AND a.xckbcomp = '",g_comp,"' AND a.xckbld = '",g_master.glaald,"' ",
               "    AND a.xckb002 = -1 ",
               "    AND exists ( SELECT * FROM xckb_t b ",
               "                  WHERE a.xckbent = b.xckbent and a.xckbcomp = b.xckbcomp and a.xckbld = b.xckbld ",
               "                    AND b.xckb007 = ",g_master.yy," AND b.xckb008 = ",g_master.pp,
               "                    AND a.xckb005 = b.xckb005 AND a.xckb006 = b.xckb006 AND b.xckb002 = -1 ) ",
               "  group by a.xckb005,a.xckb006 "
   PREPARE axcp200_execute_upd_xckb_p1 FROM g_sql
   DECLARE axcp200_execute_upd_xckb_c1 CURSOR FOR axcp200_execute_upd_xckb_p1
   
   FOREACH axcp200_execute_upd_xckb_c1 INTO l_xckb005,l_xckb006,l_outcome_xckb014,
                                            l_outcome_xckb102,l_outcome_xckb102a,l_outcome_xckb102b,l_outcome_xckb102c,
                                            l_outcome_xckb102d,l_outcome_xckb102e,l_outcome_xckb102f,l_outcome_xckb102g,
                                            l_outcome_xckb102h
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axcp200_execute_upd_xckb_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      ## 用單號+項次檢查 轉出數量 和 出貨(入項)數量一樣，但金額不同的資料
      LET l_income_xckb014 = 0
      SELECT diff.* INTO l_income_xckb014,l_income_xckb102,
                         l_income_xckb102a,l_income_xckb102b,l_income_xckb102c,l_income_xckb102d,
                         l_income_xckb102e,l_income_xckb102f,l_income_xckb102g,l_income_xckb102h
       FROM(
         SELECT SUM(xckb014) xckb014,SUM(xckb102) xckb102,SUM(xckb102a) xckb102a,SUM(xckb102b) xckb102b,SUM(xckb102c) xckb102c,
                SUM(xckb102d) xckb102d,SUM(xckb102e) xckb102e,SUM(xckb102f) xckb102f,SUM(xckb102g) xckb102g,SUM(xckb102h) xckb102h
         FROM xckb_t
         WHERE xckbent = g_enterprise AND xckbcomp = g_comp AND xckbld = g_master.glaald
            AND xckb002 = 1
            AND xckb005 = l_xckb005 AND xckb006 = l_xckb006
        ) diff
       WHERE diff.xckb014 = l_outcome_xckb014
         AND (diff.xckb102 <> l_outcome_xckb102 OR diff.xckb102a <> l_outcome_xckb102a  OR diff.xckb102b <> l_outcome_xckb102b OR
              diff.xckb102c <> l_outcome_xckb102c OR diff.xckb102d <> l_outcome_xckb102d OR diff.xckb102e <> l_outcome_xckb102e OR
              diff.xckb102f <> l_outcome_xckb102f OR diff.xckb102g <> l_outcome_xckb102g OR diff.xckb102h <> l_outcome_xckb102h)
       IF SQLCA.sqlcode = 100 THEN
         CONTINUE FOREACH  --not found
       END IF
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'select axcp200_execute_upd_xckb_c1_1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
       END IF
       
       ##更新xckb_t中
       UPDATE xckb_t SET xckb102  = xckb102 + l_income_xckb102 - l_outcome_xckb102,
                         xckb102a = xckb102a + l_income_xckb102a - l_outcome_xckb102a,
                         xckb102b = xckb102b + l_income_xckb102b - l_outcome_xckb102b,
                         xckb102c = xckb102c + l_income_xckb102c - l_outcome_xckb102c,
                         xckb102d = xckb102d + l_income_xckb102d - l_outcome_xckb102d,
                         xckb102e = xckb102e + l_income_xckb102e - l_outcome_xckb102e,
                         xckb102f = xckb102f + l_income_xckb102f - l_outcome_xckb102f,
                         xckb102g = xckb102g + l_income_xckb102g - l_outcome_xckb102g,
                         xckb102h = xckb102h + l_income_xckb102h - l_outcome_xckb102h
         WHERE xckbent = g_enterprise AND xckbcomp = g_comp AND xckbld = g_master.glaald
           AND xckb002 = -1 AND xckb007 = g_master.yy AND xckb008 = g_master.pp
           AND xckb005 = l_xckb005 AND xckb006 = l_xckb006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE axcp200_execute_upd_xckb_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF 
         
   END FOREACH   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 带出账套所属法人当前的"现行成本结算年度"和"现行成本结算期别"
# Memo...........:
# Usage..........: CALL axcp200_default()
# Date & Author..: 170314 By fionchen (#170207-00034#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp200_default()
  DEFINE l_comp     LIKE glaa_t.glaacomp   
  
  SELECT glaacomp INTO l_comp
    FROM glaa_t
   WHERE glaaent = g_enterprise
     AND glaald  = g_master.glaald
         
  CALL cl_get_para(g_enterprise,l_comp,'S-FIN-6010') RETURNING g_master.yy
  CALL cl_get_para(g_enterprise,l_comp,'S-FIN-6011') RETURNING g_master.pp
END FUNCTION

#end add-point
 
{</section>}
 
