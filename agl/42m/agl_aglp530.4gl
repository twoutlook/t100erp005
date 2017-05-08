#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2014-09-25 16:56:16), PR版次:0017(2017-02-14 15:53:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000405
#+ Filename...: aglp530
#+ Description: 期末結轉作業
#+ Creator....: 01531(2014-07-03 08:55:02)
#+ Modifier...: 01531 -SD/PR- 02599
 
{</section>}
 
{<section id="aglp530.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151222-00008#1   2015/12/22   By 02599  删除凭证单号时同步更新单别对应的最大流水号
#160201-00015#2   2016/02/01   By 03538  遇到當年最末期,未能產生應計調整傳票問題修正,以及隔年年度期別處理
#160201-00015#3   2016/02/02   By 03538  修正遇跨年度重複執行aglp530的時候,不會先砍掉已存在的RA之問題
#160318-00005#16  2016/03/25   by 07675  將重複內容的錯誤訊息置換為公用錯誤訊息
#160628-00036#2   2016/07/08   By 01531  月結作業時, 依設定將科目轉入指定的本期損益科目
#161018-00024#1   2016/10/20   By 02599  月结时agli010现行年度glaa010、期别glaa011为null，也可以更新glaa_t
#161111-00028#8   2016/11/28   by 02481  标准程式定义采用宣告模式,弃用.*写法
#161227-00016#1   2016/12/28   By 01531  参数要连号就把原来的凭证改作废
#170104-00011#1   2017/01/04   By 01531  参数要连号就把原来的凭证改作废，更新表错误，应更新glap_t
#170104-00009#1   2017/01/04   By 01531  月結沒有成功, 但仍會更新最新的年度期別, 不成功就不應更新且不要再啟動 年結作業
#170120-00051#1   2017/01/22   By 02599  年底结转会在aglp540中更新年度和期别，故aglp530不更新
#170208-00016#1   2017/02/08   By 02599  产生的应计凭证，当含有启用细项立冲的科目的凭证，凭证状态=N，否则凭证状态=Y
#170214-00033#1   2017/02/14   By 02599  需求单#170208-00016#1修改不需要了，还原回来

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
       glapld LIKE glap_t.glapld, 
   glapld_desc LIKE type_t.chr80, 
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#161111-00028#8----modify----begin---------
#DEFINE g_glap      RECORD LIKE glap_t.*
#DEFINE g_glaq      RECORD LIKE glaq_t.*
#DEFINE g_glar      RECORD LIKE glar_t.*
DEFINE g_glap RECORD  #傳票憑證單頭檔
       glapent LIKE glap_t.glapent, #企業編號
       glapld LIKE glap_t.glapld, #帳套
       glapcomp LIKE glap_t.glapcomp, #法人
       glapdocno LIKE glap_t.glapdocno, #單號
       glapdocdt LIKE glap_t.glapdocdt, #單據日期
       glap001 LIKE glap_t.glap001, #傳票性質
       glap002 LIKE glap_t.glap002, #會計年度
       glap003 LIKE glap_t.glap003, #會計季別
       glap004 LIKE glap_t.glap004, #會計期別
       glap005 LIKE glap_t.glap005, #會計周別
       glap006 LIKE glap_t.glap006, #收支科目
       glap007 LIKE glap_t.glap007, #來源碼
       glap008 LIKE glap_t.glap008, #帳款類型
       glap009 LIKE glap_t.glap009, #總號
       glap010 LIKE glap_t.glap010, #借方總金額
       glap011 LIKE glap_t.glap011, #貸方總金額
       glap012 LIKE glap_t.glap012, #列印次數
       glap013 LIKE glap_t.glap013, #附件張數
       glap014 LIKE glap_t.glap014, #外幣憑證否
       glap015 LIKE glap_t.glap015, #原傳票編號
       glap016 LIKE glap_t.glap016, #來源帳套編號
       glap017 LIKE glap_t.glap017, #來源傳票編號
       glapownid LIKE glap_t.glapownid, #資料所有者
       glapowndp LIKE glap_t.glapowndp, #資料所屬部門
       glapcrtid LIKE glap_t.glapcrtid, #資料建立者
       glapcrtdp LIKE glap_t.glapcrtdp, #資料建立部門
       glapcrtdt LIKE glap_t.glapcrtdt, #資料創建日
       glapmodid LIKE glap_t.glapmodid, #資料修改者
       glapmoddt LIKE glap_t.glapmoddt, #最近修改日
       glapcnfid LIKE glap_t.glapcnfid, #資料確認者
       glapcnfdt LIKE glap_t.glapcnfdt, #資料確認日
       glappstid LIKE glap_t.glappstid, #資料過帳者
       glappstdt LIKE glap_t.glappstdt, #資料過帳日
       glapstus LIKE glap_t.glapstus  #狀態碼
       END RECORD

DEFINE g_glaq RECORD  #傳票憑證單身檔
       glaqent LIKE glaq_t.glaqent, #企業編號
       glaqcomp LIKE glaq_t.glaqcomp, #法人
       glaqld LIKE glaq_t.glaqld, #帳套
       glaqdocno LIKE glaq_t.glaqdocno, #單號
       glaqseq LIKE glaq_t.glaqseq, #項次
       glaq001 LIKE glaq_t.glaq001, #摘要
       glaq002 LIKE glaq_t.glaq002, #科目編號
       glaq003 LIKE glaq_t.glaq003, #借方金額
       glaq004 LIKE glaq_t.glaq004, #貸方金額
       glaq005 LIKE glaq_t.glaq005, #交易幣別
       glaq006 LIKE glaq_t.glaq006, #匯率
       glaq007 LIKE glaq_t.glaq007, #計價單位
       glaq008 LIKE glaq_t.glaq008, #數量
       glaq009 LIKE glaq_t.glaq009, #單價
       glaq010 LIKE glaq_t.glaq010, #原幣金額
       glaq011 LIKE glaq_t.glaq011, #票據編碼
       glaq012 LIKE glaq_t.glaq012, #票據日期
       glaq013 LIKE glaq_t.glaq013, #申請人
       glaq014 LIKE glaq_t.glaq014, #銀行帳號
       glaq015 LIKE glaq_t.glaq015, #款別編號
       glaq016 LIKE glaq_t.glaq016, #收支專案
       glaq017 LIKE glaq_t.glaq017, #營運據點
       glaq018 LIKE glaq_t.glaq018, #部門
       glaq019 LIKE glaq_t.glaq019, #利潤/成本中心
       glaq020 LIKE glaq_t.glaq020, #區域
       glaq021 LIKE glaq_t.glaq021, #收付款客商
       glaq022 LIKE glaq_t.glaq022, #帳款客戶
       glaq023 LIKE glaq_t.glaq023, #客群
       glaq024 LIKE glaq_t.glaq024, #產品類別
       glaq025 LIKE glaq_t.glaq025, #人員
       glaq026 LIKE glaq_t.glaq026, #no use
       glaq027 LIKE glaq_t.glaq027, #專案編號
       glaq028 LIKE glaq_t.glaq028, #WBS
       glaq029 LIKE glaq_t.glaq029, #自由核算項一
       glaq030 LIKE glaq_t.glaq030, #自由核算項二
       glaq031 LIKE glaq_t.glaq031, #自由核算項三
       glaq032 LIKE glaq_t.glaq032, #自由核算項四
       glaq033 LIKE glaq_t.glaq033, #自由核算項五
       glaq034 LIKE glaq_t.glaq034, #自由核算項六
       glaq035 LIKE glaq_t.glaq035, #自由核算項七
       glaq036 LIKE glaq_t.glaq036, #自由核算項八
       glaq037 LIKE glaq_t.glaq037, #自由核算項九
       glaq038 LIKE glaq_t.glaq038, #自由核算項十
       glaq039 LIKE glaq_t.glaq039, #匯率(本位幣二)
       glaq040 LIKE glaq_t.glaq040, #借方金額(本位幣二)
       glaq041 LIKE glaq_t.glaq041, #貸方金額(本位幣二)
       glaq042 LIKE glaq_t.glaq042, #匯率(本位幣三)
       glaq043 LIKE glaq_t.glaq043, #借方金額(本位幣三)
       glaq044 LIKE glaq_t.glaq044, #貸方金額(本位幣三)
       glaq051 LIKE glaq_t.glaq051, #經營方式
       glaq052 LIKE glaq_t.glaq052, #渠道
       glaq053 LIKE glaq_t.glaq053  #品牌
       END RECORD

DEFINE g_glar RECORD  #會計科目各期餘額檔
       glarent LIKE glar_t.glarent, #企業編號
       glarcomp LIKE glar_t.glarcomp, #法人
       glarld LIKE glar_t.glarld, #帳套
       glar001 LIKE glar_t.glar001, #會計科目
       glar002 LIKE glar_t.glar002, #年度
       glar003 LIKE glar_t.glar003, #期別
       glar004 LIKE glar_t.glar004, #組合要素(key)
       glar005 LIKE glar_t.glar005, #借方金額
       glar006 LIKE glar_t.glar006, #貸方金額
       glar007 LIKE glar_t.glar007, #借方筆數
       glar008 LIKE glar_t.glar008, #貸方筆數
       glar009 LIKE glar_t.glar009, #交易幣別
       glar010 LIKE glar_t.glar010, #原幣借方金額
       glar011 LIKE glar_t.glar011, #原幣貸方金額
       glar012 LIKE glar_t.glar012, #營運據點
       glar013 LIKE glar_t.glar013, #部門
       glar014 LIKE glar_t.glar014, #利潤/成本中心
       glar015 LIKE glar_t.glar015, #區域
       glar016 LIKE glar_t.glar016, #收付款客商
       glar017 LIKE glar_t.glar017, #帳款客商
       glar018 LIKE glar_t.glar018, #客群
       glar019 LIKE glar_t.glar019, #產品類別
       glar020 LIKE glar_t.glar020, #人員
       glar021 LIKE glar_t.glar021, #no use
       glar022 LIKE glar_t.glar022, #專案編號
       glar023 LIKE glar_t.glar023, #WBS
       glar024 LIKE glar_t.glar024, #自由核算項一
       glar025 LIKE glar_t.glar025, #自由核算項二
       glar026 LIKE glar_t.glar026, #自由核算項三
       glar027 LIKE glar_t.glar027, #自由核算項四
       glar028 LIKE glar_t.glar028, #自由核算項五
       glar029 LIKE glar_t.glar029, #自由核算項六
       glar030 LIKE glar_t.glar030, #自由核算項七
       glar031 LIKE glar_t.glar031, #自由核算項八
       glar032 LIKE glar_t.glar032, #自由核算項九
       glar033 LIKE glar_t.glar033, #自由核算項十
       glar034 LIKE glar_t.glar034, #借方金額(本位幣二)
       glar035 LIKE glar_t.glar035, #貸方金額(本位幣二)
       glar036 LIKE glar_t.glar036, #借方金額(本位幣三)
       glar037 LIKE glar_t.glar037, #貸方金額(本位幣三)
       glar051 LIKE glar_t.glar051, #經營方式
       glar052 LIKE glar_t.glar052, #通路
       glar053 LIKE glar_t.glar053  #品牌
       END RECORD

 #161111-00028#8----modify----end---------
DEFINE g_ref_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_glaa001                LIKE glaa_t.glaa001    #账簿币别
DEFINE g_glaa004                LIKE glaa_t.glaa004    #会计科目参照表号
DEFINE g_glaacomp               LIKE glaa_t.glaacomp   #归属法人
DEFINE g_glaa003                LIKE glaa_t.glaa003    #會計週期參照表號
DEFINE g_glaa006                LIKE glaa_t.glaa006    #月結方式
DEFINE g_glaa007                LIKE glaa_t.glaa007    #年結方式
DEFINE g_glaa010                LIKE glaa_t.glaa010    #现行年度
DEFINE g_glaa011                LIKE glaa_t.glaa011    #期别
DEFINE g_glaa013                LIKE glaa_t.glaa013    #关账日期
DEFINE g_glaa024                LIKE glaa_t.glaa024    #单据参照表号
DEFINE g_glaa111                LIKE glaa_t.glaa111    #应计调整单别
DEFINE g_glaa112                LIKE glaa_t.glaa112    #期末结转单别
DEFINE g_ooef008                LIKE ooef_t.ooef008    #單別參照表號
DEFINE g_glaa015                LIKE glaa_t.glaa015
DEFINE g_glaa016                LIKE glaa_t.glaa016
DEFINE g_glaa018                LIKE glaa_t.glaa018
DEFINE g_glaa019                LIKE glaa_t.glaa019
DEFINE g_glaa020                LIKE glaa_t.glaa020
DEFINE g_glaa022                LIKE glaa_t.glaa022
DEFINE g_flag                   LIKE type_t.chr1
DEFINE g_max_period             LIKE type_t.num5        #最大期別
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglp530.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aglp530_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp530 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp530_init()
 
      #進入選單 Menu (="N")
      CALL aglp530_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp530
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE p530_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp530.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp530_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_pass        LIKE type_t.num5
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
   #單據別參照表號   
   SELECT ooef008 INTO g_ooef008 FROM ooef_t WHERE ooefent = g_enterprise
                                               AND ooef001 = g_site       
   #获取预设主帐别
   CALL s_ld_bookno()  RETURNING l_success,g_master.glapld
   IF l_success = FALSE THEN
      RETURN 
   END IF 

   #權限檢查
   CALL s_ld_chk_authorization(g_user,g_master.glapld) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00164'
      LET g_errparam.extend = g_master.glapld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #依据帐别抓取会计周期，现行年度，现行期别，关账日期
   LET g_glaa003 = ''
   LET g_glaa010 = ''
   LET g_glaa011 = ''
   LET g_glaa013 = ''
   LET g_glaa112 = ''
   SELECT glaa003,glaa010,glaa011,glaa013,glaa024,glaa111,glaa112 
     INTO g_glaa003,g_glaa010,g_glaa011,g_glaa013,g_glaa024,g_glaa111,g_glaa112 
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.glapld
      
   CALL aglp530_creat_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglp530.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp530_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_pass       LIKE type_t.num5
   DEFINE l_glav003    LIKE glav_t.glav003
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glapld,g_master.glap002,g_master.glap004 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #预设值
               LET g_master.glapld =  g_master.glapld
               CALL aglp530_glapld_desc() 
               LET g_master.glap002 = g_glaa010
               LET g_master.glap004 = g_glaa011
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapld
            
            #add-point:AFTER FIELD glapld name="input.a.glapld"
            IF NOT cl_null(g_master.glapld) THEN
               CALL aglp530_glapld_chk(g_master.glapld)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.glapld
                  #160318-00005#16  --add--str
                  LET g_errparam.replace[1] ='agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog    ='agli010'
                  #160318-00005#16  --add--end
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glapld = ''
                  DISPLAY '' TO glapld_desc
                  NEXT FIELD glapld
               END IF 
               #检查使用者是否有权限使用当前账别
               CALL s_ld_chk_authorization(g_user,g_master.glapld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_master.glapld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glapld = ''
                  DISPLAY '' TO glapld_desc
                  NEXT FIELD glapld
               END IF 
               #依据帐别抓取会计周期，现行年度，现行期别，关账日期
               LET g_glaa003 = ''
               LET g_glaa010 = ''
               LET g_glaa011 = ''
               LET g_glaa013 = ''
               LET g_glaa112 = ''
               SELECT glaa003,glaa010,glaa011,glaa013,glaa024,glaa112 
                 INTO g_glaa003,g_glaa010,g_glaa011,g_glaa013,g_glaa024,g_glaa112 
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_master.glapld
               LET g_master.glap002 = g_glaa010
               LET g_master.glap004 = g_glaa011
               DISPLAY g_master.glap002 TO glap002
               DISPLAY g_master.glap004 TO glap004 
            END IF 
            CALL aglp530_glapld_desc() 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapld
            #add-point:BEFORE FIELD glapld name="input.b.glapld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapld
            #add-point:ON CHANGE glapld name="input.g.glapld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap002
            #add-point:BEFORE FIELD glap002 name="input.b.glap002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap002
            
            #add-point:AFTER FIELD glap002 name="input.a.glap002"
            IF NOT cl_null(g_master.glap002) THEN
               IF g_master.glap002 <1000 OR g_master.glap002 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_master.glap002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glap002 =''
                  NEXT FIELD glap002
               END IF
               IF g_master.glap002 < YEAR(g_glaa013) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00163'
                  LET g_errparam.extend = g_master.glap002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glap002 =''
                  NEXT FIELD glap002
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap002
            #add-point:ON CHANGE glap002 name="input.g.glap002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap004
            #add-point:BEFORE FIELD glap004 name="input.b.glap004"
            IF cl_null(g_master.glap002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00183'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD glap002
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap004
            
            #add-point:AFTER FIELD glap004 name="input.a.glap004"
             IF NOT cl_null(g_master.glap004) THEN
                #资料检查,期别依据agli100对应年度设置不同，分12期和13期
                SELECT glav003 INTO l_glav003 FROM glav_t
                 WHERE glavent = g_enterprise
                   AND glav001 = g_glaa003
                   AND glav002 = g_master.glap002
                #1.月，2.周，3.445式   
                IF cl_null(l_glav003) OR l_glav003 = '1' OR l_glav003 = '3' THEN
                   IF (g_master.glap004 < 1) OR (g_master.glap004 > 12) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'agl-00127'
                      LET g_errparam.extend = g_master.glap004
                      LET g_errparam.popup = FALSE
                      CALL cl_err()

                      LET g_master.glap004 = ''
                      NEXT FIELD glap004
                   END IF 
                ELSE
                   IF g_master.glap004 <1 OR g_master.glap004 >13 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'agl-00143'
                      LET g_errparam.extend = g_master.glap004
                      LET g_errparam.popup = FALSE
                      CALL cl_err()

                      LET g_master.glap004 = ''
                      NEXT FIELD glap004
                   END IF 
                END IF 
              
                IF g_master.glap002 = YEAR(g_glaa013) AND  g_master.glap004 < MONTH(g_glaa013) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00163'
                   LET g_errparam.extend = g_master.glap004
                   LET g_errparam.popup = FALSE
                   CALL cl_err()

                   LET g_master.glap004 = ''
                   NEXT FIELD glap004
                END IF 
             END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap004
            #add-point:ON CHANGE glap004 name="input.g.glap004"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glapld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapld
            #add-point:ON ACTION controlp INFIELD glapld name="input.c.glapld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glapld       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_master.glapld = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL aglp530_glapld_desc()
            DISPLAY g_master.glapld_desc TO glapld_desc
            DISPLAY g_master.glapld TO glapld               #顯示到畫面上
            NEXT FIELD glapld                               #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap002
            #add-point:ON ACTION controlp INFIELD glap002 name="input.c.glap002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glap004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap004
            #add-point:ON ACTION controlp INFIELD glap004 name="input.c.glap004"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
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
            CALL aglp530_get_buffer(l_dialog)
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
         CALL aglp530_init()
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
                 CALL aglp530_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp530_transfer_argv(ls_js)
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
 
{<section id="aglp530.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp530_transfer_argv(ls_js)
 
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
 
{<section id="aglp530.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp530_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_glav003       LIKE glav_t.glav003
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_cmd     STRING
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   INITIALIZE g_glap.* TO NULL
   INITIALIZE g_glaq.* TO NULL
   INITIALIZE g_glar.* TO NULL
   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   CALL cl_err_collect_init()
   LET g_success = 'Y'
   LET g_flag='Y'
   #帳套相關資料抓取
   SELECT glaa003,glaa010,glaa011,glaa013,glaa024,glaa111,glaa112 
     INTO g_glaa003,g_glaa010,g_glaa011,g_glaa013,g_glaa024,g_glaa111,g_glaa112 
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.glapld
   #判断结转年度期别是否小于关账日期
   IF (g_master.glap002 < YEAR(g_glaa013)) OR (g_master.glap002 = YEAR(g_glaa013) AND
      (NOT cl_null(g_master.glap004) AND g_master.glap004 < MONTH(g_glaa013))) THEN
#      CALL cl_errmsg('glaa013',g_glaa013,'','agl-00163',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_glaa013
      LET g_errparam.code = 'agl-00163'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show() 
      RETURN    
   END IF 
   #判斷是否設置拋轉月結傳票單據別
   IF cl_null(g_glaa112) THEN
#      CALL cl_errmsg('glaa112',g_glaa112,'','agl-00223',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_glaa112
      LET g_errparam.code = 'agl-00223'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show() 
      RETURN  
   END IF 
   
  #160201-00015#3 mark--
  ##先判断是否已经做月结
  #CALL aglp530_chk()
  #160201-00015#3 mark--      
   #产生两张CE类的传票+產生次期應計調整傳票(RA)
   #依据帐别抓取对应法人,币别,会计参照表号,结账方式1:表结法，2：账结法
   SELECT glaacomp,glaa001,glaa003,glaa004,glaa006,glaa007,glaa015,
          glaa016,glaa018,glaa019,glaa020,glaa022,glaa024
     INTO g_glaacomp,g_glaa001,g_glaa003,g_glaa004,g_glaa006,g_glaa007,g_glaa015,
          g_glaa016,g_glaa018,g_glaa019,
          g_glaa020,g_glaa022,g_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.glapld
   
   #资料检查,期别依据agli100对应年度设置不同，分12期和13期
   SELECT glav003 INTO l_glav003 FROM glav_t
    WHERE glavent = g_enterprise
      AND glav001 = g_glaa003
      AND glav002 = g_master.glap002
   #最大期别
   IF l_glav003='2' THEN
      LET g_max_period =13
   ELSE
      LET g_max_period =12
   END IF
   #160201-00015#3-s--
   #先判断是否已经做月结
   CALL aglp530_chk()
   #160201-00015#3-e--      
   #月結方式采用表結法
   IF g_glaa006 = '1' THEN
      IF g_master.glap004 < g_max_period THEN
         CALL aglp530_glaa006_1() #表結法
      ELSE
         #當最後一期時，年結方式采用表結法時
         IF g_glaa007 = '1' THEN 
            CALL aglp530_glaa006_1() #表結法
         ELSE
         #當最後一期時，年結方式采用帳結法時
            CALL aglp530_glaa006_3() #表結法
         END IF
      END IF
   ELSE
      #月結方式采用帳結法
      CALL aglp530_glaa006_2(g_master.glap004,g_master.glap004) #帳結法
   END IF 
   
   IF g_success='Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
   IF g_success = 'Y' THEN  #170104-00009#1 add
      LET g_flag=g_success
      #开启事务
      CALL s_transaction_begin()
      LET g_success='Y'
      
      #→產生次期應計調整傳票(RA)
  #   IF g_master.glap004 < g_max_period THEN   #160201-00015#2 mark
      IF g_master.glap004 <=g_max_period THEN   #160201-00015#2    
         #判斷是否設置應計調整傳票單據別
         IF cl_null(g_glaa111) THEN
#            CALL cl_errmsg('glaa111',g_glaa111,'','agl-00231',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_glaa111
            LET g_errparam.code = 'agl-00231'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show() 
            RETURN  
         END IF
         CALL aglp530_ra_gen()
         #161018-00024#1--mod--str--
#         IF g_glaa010=g_master.glap002 AND g_glaa011=g_master.glap004 THEN
         IF g_glaa010=g_master.glap002 AND g_glaa011=g_master.glap004 
            AND g_master.glap004 < g_max_period
            OR cl_null(g_glaa010) OR cl_null(g_glaa011)
         THEN
         #161018-00024#1--mod--end
            #更新对应帐别的会计年度，期别，期别 = 期别+1
            UPDATE glaa_t SET glaa010 = g_master.glap002,
                              glaa011 = g_master.glap004+1
             WHERE glaaent = g_enterprise
               AND glaald = g_master.glapld
         END IF
  #   ELSE                                         #160201-00015#2 mark
      END IF                                       #160201-00015#2   
      IF g_master.glap004 = g_max_period THEN      #160201-00015#2
      #→當執行期別為當年度最末一期,則系統呼叫年度結轉作業(aglp540)並傳入年度訊息自動執行之.
         INITIALIZE la_param.* TO NULL
         LET la_param.prog = 'aglp540'
         LET la_param.param[1] = g_master.glapld
         LET la_param.param[2] = g_master.glap002        
         LET ls_cmd = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_cmd)
        
         #161018-00024#1--mod--str--
#         IF g_glaa010=g_master.glap002 AND g_glaa011=g_max_period THEN
#170120-00051#1--mark--str--
#         IF g_glaa010=g_master.glap002 AND g_glaa011=g_max_period 
#            OR cl_null(g_glaa010) OR cl_null(g_glaa011)
#         THEN
#         #161018-00024#1--mod--end
#            #更新对应帐别的会计年度，期别，
#            #年度=年度+1， 期别 =1
#            UPDATE glaa_t SET glaa010 = g_master.glap002+1, 
#                              glaa011 = 1
#             WHERE glaaent = g_enterprise
#               AND glaald = g_master.glapld
#         END IF
#170120-00051#1--mark--end
      END IF 
   
      IF SQLCA.SQLCODE THEN
#         CALL cl_errmsg('UPD_glaa',g_master.glapld,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'UPD_glaa'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show() 
         RETURN  
      END IF 
      
      #產生細項立沖各期餘額當
      CALL aglp530_glaz()
      
      IF g_success = 'Y' THEN 
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
   END IF #170104-00009#1 add   
   
   CALL cl_err_collect_show() 
      
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglp530_process_cs CURSOR FROM ls_sql
#  FOREACH aglp530_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aglp530_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp530.get_buffer" >}
PRIVATE FUNCTION aglp530_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glapld = p_dialog.getFieldBuffer('glapld')
   LET g_master.glap002 = p_dialog.getFieldBuffer('glap002')
   LET g_master.glap004 = p_dialog.getFieldBuffer('glap004')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp530.msgcentre_notify" >}
PRIVATE FUNCTION aglp530_msgcentre_notify()
 
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
 
{<section id="aglp530.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 獲取帳別說明
# Memo...........:
# Usage..........: CALL aglp530_glapld_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/3 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_glapld_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.glapld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.glapld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.glapld_desc
END FUNCTION

################################################################################
# Descriptions...: 帳別檢查
# Memo...........:
# Usage..........: CALL aglp530_glapld_chk(p_glapld)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/3 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_glapld_chk(p_glapld)
   DEFINE p_glapld    LIKE glap_t.glapld
   DEFINE l_glaastus  LIKE glaa_t.glaastus
   
   LET g_errno = ''
   SELECT glaastus INTO l_glaastus FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glapld
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#16 mod  #'agl-00051'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 表结法
# Memo...........: 1~11期產生一張CE傳票
# Usage..........: CALL aglp530_glaa006_1()
# Input parameter:  
# Return code....:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_glaa006_1()
   #期末结转科目
   DEFINE l_glab              DYNAMIC ARRAY OF RECORD 
          glab005             LIKE glab_t.glab005
          END RECORD
   DEFINE l_glaq              DYNAMIC ARRAY OF RECORD 
          glaq010             LIKE glaq_t.glaq010,
          glaq002             LIKE glaq_t.glaq002,
          glaq003             LIKE glaq_t.glaq003,
          glaq004             LIKE glaq_t.glaq004,
          glaq040             LIKE glaq_t.glaq040,
          glaq041             LIKE glaq_t.glaq041,
          glaq043             LIKE glaq_t.glaq043,
          glaq044             LIKE glaq_t.glaq044,
          glaq017             LIKE glaq_t.glaq017,
          glaq018             LIKE glaq_t.glaq018,
          glaq019             LIKE glaq_t.glaq019,
          glaq020             LIKE glaq_t.glaq020,
          glaq021             LIKE glaq_t.glaq021,
          glaq022             LIKE glaq_t.glaq022,
          glaq023             LIKE glaq_t.glaq023,
          glaq024             LIKE glaq_t.glaq024,
          glaq051             LIKE glaq_t.glaq051,
          glaq052             LIKE glaq_t.glaq052,
          glaq053             LIKE glaq_t.glaq053,
          glaq025             LIKE glaq_t.glaq025,
          glaq027             LIKE glaq_t.glaq027,
          glaq028             LIKE glaq_t.glaq028,
          glaq029             LIKE glaq_t.glaq029,
          glaq030             LIKE glaq_t.glaq030,
          glaq031             LIKE glaq_t.glaq031,
          glaq032             LIKE glaq_t.glaq032,
          glaq033             LIKE glaq_t.glaq033,
          glaq034             LIKE glaq_t.glaq034,
          glaq035             LIKE glaq_t.glaq035,
          glaq036             LIKE glaq_t.glaq036,
          glaq037             LIKE glaq_t.glaq037,
          glaq038             LIKE glaq_t.glaq038
          END RECORD
   DEFINE l_sql               STRING
   DEFINE l_i,l_cnt           LIKE type_t.num5
   DEFINE l_sum               LIKE glaq_t.glaq003
   DEFINE l_sum1              LIKE glaq_t.glaq003   #差异(本位幣一)
   DEFINE l_sum2              LIKE glaq_t.glaq003   #差异(本位幣二)
   DEFINE l_sum3              LIKE glaq_t.glaq003   #差异(本位幣三)
   DEFINE l_success           LIKE type_t.num5
   DEFINE ld_date             DATETIME YEAR TO SECOND
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_errno             LIKE type_t.chr100
   DEFINE l_glav002           LIKE glav_t.glav002
   DEFINE l_glav005           LIKE glav_t.glav005
   DEFINE l_sdate_s           LIKE glav_t.glav004
   DEFINE l_sdate_e           LIKE glav_t.glav004
   DEFINE l_glav006           LIKE glav_t.glav006
   DEFINE l_pdate_s           LIKE glav_t.glav004
   DEFINE l_pdate_e           LIKE glav_t.glav004
   DEFINE l_glav007           LIKE glav_t.glav007
   DEFINE l_wdate_s           LIKE glav_t.glav004
   DEFINE l_wdate_e           LIKE glav_t.glav004
   DEFINE l_sql1              STRING
   DEFINE l_sql2              STRING
   DEFINE l_red           LIKE type_t.chr10
   #科目核算项
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #自由核算项
   DEFINE l_glad017       LIKE glad_t.glad017     #自由核算项一
   DEFINE l_glad018       LIKE glad_t.glad018     #自由核算项二
   DEFINE l_glad019       LIKE glad_t.glad019     #自由核算项三
   DEFINE l_glad020       LIKE glad_t.glad020     #自由核算项四
   DEFINE l_glad021       LIKE glad_t.glad021     #自由核算项五
   DEFINE l_glad022       LIKE glad_t.glad022     #自由核算项六
   DEFINE l_glad023       LIKE glad_t.glad023     #自由核算项七
   DEFINE l_glad024       LIKE glad_t.glad024     #自由核算项八
   DEFINE l_glad025       LIKE glad_t.glad025     #自由核算项九
   DEFINE l_glad026       LIKE glad_t.glad026     #自由核算项十
   DEFINE l_glch002       LIKE glch_t.glch002     #160628-00036#2 
   DEFINE l_glch003       LIKE glch_t.glch003     #160628-00036#2 
   DEFINE l_glac008       LIKE glac_t.glac008     #160628-00036#2 
   DEFINE l_glap010       LIKE glap_t.glap010     #160628-00036#2
   DEFINE l_glap011       LIKE glap_t.glap011     #160628-00036#2
   
   #初始化  
   CALL l_glaq.clear()
   #========单头glap_t======================
      LET g_glap.glapent = g_enterprise
      LET g_glap.glapcomp = g_glaacomp 
      LET g_glap.glapld = g_master.glapld 
      LET g_glap.glap001 = '1'      
      LET g_glap.glap002 = g_master.glap002
      LET g_glap.glap004 = g_master.glap004
      LET g_glap.glapdocno = g_glaa112

      CALL s_get_accdate(g_glaa003,'',g_master.glap002,g_master.glap004)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      IF l_flag='N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'l_errno'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_success = 'N'
         RETURN
      END IF         
      LET g_glap.glapdocdt=l_pdate_e
      CALL s_aooi200_fin_gen_docno(g_master.glapld,g_glaa024,g_glaa003,g_glap.glapdocno,g_glap.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
      IF l_success = FALSE THEN
         LET g_success = 'N'      
         RETURN
      END IF 
      #獲取單據別對應參數：紅字傳票否
      CALL s_fin_get_doc_para(g_master.glapld,g_glaacomp,g_glaa112,'D-FIN-1002') RETURNING l_red
      
      LET g_glap.glap007 = 'CE'
      LET g_glap.glap009 = 0
      LET g_glap.glap009 = 0
      LET g_glap.glap013 = 0
      LET g_glap.glap014 = 'N'
      LET g_glap.glapstus = 'Y'
      LET g_glap.glapcrtid = g_user
      LET g_glap.glapcrtdt = cl_get_current()
      LET g_glap.glapownid = g_user
      LET g_glap.glapowndp = g_dept
      LET g_glap.glapcrtid = g_user
      LET g_glap.glapcrtdp = g_dept 
      LET g_glap.glapcrtdt = cl_get_current()
      LET g_glap.glapcnfid = g_user
      LET g_glap.glapcnfdt = cl_get_current()
      LET ld_date = cl_get_current()
      #=================单身glaq_t================================
      LET g_glaq.glaqent = g_glap.glapent
      LET g_glaq.glaqld = g_glap.glapld
      LET g_glaq.glaqdocno = g_glap.glapdocno
      LET g_glaq.glaqcomp = g_glap.glapcomp
      LET g_glaq.glaq005 = g_glaa001
      LET g_glaq.glaq006 = 1  #匯率(本位幣一)
      #匯率(本位幣二)
      IF g_glaa015='Y' THEN
         CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa016,0,g_glaa018)
         RETURNING  g_glaq.glaq039
      ELSE
         LET g_glaq.glaq039 = 0  
      END IF
      #匯率(本位幣三)
      IF g_glaa019='Y' THEN
         CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa020,0,g_glaa022)
         RETURNING  g_glaq.glaq042
      ELSE
         LET g_glaq.glaq042 = 0  
      END IF

      #抓取科目
      LET l_cnt=0
      SELECT COUNT(*) INTO l_cnt FROM glab_t
      WHERE glabent=g_enterprise AND glabld=g_master.glapld
      AND glab003 IN ('9711_01','9711_02')
      IF l_cnt=0 THEN
#         CALL cl_errmsg('','','','agl-00230',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code = 'agl-00230'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         RETURN
      END IF
      
      LET l_i = 1
      LET l_sql = " SELECT glab005 FROM glab_t ",
                  "  WHERE glabent = '",g_enterprise,"'",
                  "    AND glabld = '",g_master.glapld,"'",
                  "    AND glab003 IN ('9711_01','9711_02')",
                  "    ORDER BY glab003 "
      PREPARE aglp530_glab005_pre FROM l_sql
      DECLARE aglp530_glab005_cs  CURSOR FOR  aglp530_glab005_pre
      CALL l_glab.clear()
      FOREACH aglp530_glab005_cs INTO l_glab[l_i].glab005 
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('',l_glab[l_i].glab005,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_glab[l_i].glab005
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            EXIT FOREACH
         END IF
         IF cl_null(l_glab[l_i].glab005) THEN
#            CALL cl_errmsg('','','','agl-00230',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code = 'agl-00230'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
         LET l_i = l_i + 1
      END FOREACH
      IF g_success = 'N' THEN
         RETURN
      END IF
 
      #传票金额（贷-借）
      SELECT SUM(glar006)-SUM(glar005)#,SUM(glar035)-SUM(glar034),SUM(glar037)-SUM(glar036)
        INTO l_sum#,l_sum2,l_sum3
        FROM glar_t
       WHERE glarent = g_enterprise
         AND glarld = g_glaq.glaqld
         AND glar001 IN (SELECT glar001 FROM glac_t,glar_t 
                          WHERE glarent = glacent
                            AND glar001 = glac002
                            AND glarent = g_enterprise
                            AND glarld = g_glaq.glaqld
                            AND glar002 = g_master.glap002
                            AND glar003 = g_master.glap004
                            AND glac001 = g_glaa004        #会计科目参照表号
                            AND glac003 IN ('2','3')       #獨立或明細科目
                            AND glac006 = '1'              #账户科目
                            AND glac007 = '6')            #损益类科目                             
         AND glar002 = g_master.glap002
         AND glar003 = g_master.glap004
         IF cl_null(l_sum) THEN  LET l_sum = 0 END IF
#         IF cl_null(l_sum2) THEN  LET l_sum2 = 0 END IF
#         IF cl_null(l_sum3) THEN  LET l_sum3 = 0 END IF
         IF l_sum = 0  THEN
#            CALL cl_errmsg('','','','agl-00145',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code = 'agl-00145'
            LET g_errparam.popup = TRUE
            CALL cl_err()
#            LET g_success = 'N' #170208-00016#1 mark
            RETURN
         END IF 
         IF l_sum > 0  THEN
            LET g_glap.glap010 = l_sum  
            LET g_glap.glap011 = l_sum
         ELSE
            LET g_glap.glap010 = l_sum*(-1)
            LET g_glap.glap011 = l_sum*(-1)
         END IF 
        
        #获取该科目是否设置核算项
        CALL aglp530_fix_acc_sql(l_glab[1].glab005 ) RETURNING l_sql1,l_sql2
        #損益類
        LET l_sql="SELECT SUM(glar006)-SUM(glar005),SUM(glar035)-SUM(glar034),SUM(glar037)-SUM(glar036),",l_sql2,      
                  "  FROM glar_t ",
                  " WHERE glarent = ",g_enterprise,
                  "   AND glarld = '",g_glaq.glaqld,"'",
                  "   AND glar001 IN (SELECT glar001 FROM glac_t,glar_t",
                  "                    WHERE glarent = glacent AND glar001 = glac002",
                  "                      AND glarent = ",g_enterprise,
                  "                      AND glarld = '",g_glaq.glaqld,"'",
                  "                      AND glar002 = ",g_master.glap002,
                  "                      AND glar003 = ",g_master.glap004,
                  "                      AND glac001 = '",g_glaa004,"'", #会计科目参照表号
                  "                      AND glac003 IN ('2','3')",      #獨立或明細科目
                  "                      AND glac006 = '1'",             #账户科目
                  "                      AND glac007 = '6')",            #损益类科目
                  "   AND glar002 =", g_master.glap002,
                  "   AND glar003 =", g_master.glap004,
                  " GROUP BY ",l_sql2," ORDER BY ",l_sql2
                  
        PREPARE aglp530_glar_pr1 FROM l_sql
        DECLARE aglp530_glar_cs1  CURSOR FOR  aglp530_glar_pr1
        
        #获取该科目是否设置核算项
        CALL aglp530_fix_acc_sql(l_glab[2].glab005 ) RETURNING l_sql1,l_sql2
        #資產類
        LET l_sql="SELECT SUM(glar006)-SUM(glar005),SUM(glar035)-SUM(glar034),SUM(glar037)-SUM(glar036),",l_sql2,      
                  "  FROM glar_t ",
                  " WHERE glarent = ",g_enterprise,
                  "   AND glarld = '",g_glaq.glaqld,"'",
                  "   AND glar001 IN (SELECT glar001 FROM glac_t,glar_t",
                  "                    WHERE glarent = glacent AND glar001 = glac002",
                  "                      AND glarent = ",g_enterprise,
                  "                      AND glarld = '",g_glaq.glaqld,"'",
                  "                      AND glar002 = ",g_master.glap002,
                  "                      AND glar003 = ",g_master.glap004,
                  "                      AND glac001 = '",g_glaa004,"'", #会计科目参照表号
                  "                      AND glac003 IN ('2','3')",      #獨立或明細科目
                  "                      AND glac006 = '1'",             #账户科目
                  "                      AND glac007 = '6')",            #损益类科目
                  "   AND glar002 =", g_master.glap002,
                  "   AND glar003 =", g_master.glap004,
                  " GROUP BY ",l_sql2," ORDER BY ",l_sql2
                  
        PREPARE aglp530_glar_pr2 FROM l_sql
        DECLARE aglp530_glar_cs2  CURSOR FOR  aglp530_glar_pr2
              
        #损益类在借方
        LET l_i=1
        FOREACH aglp530_glar_cs1 INTO l_sum1,l_sum2,l_sum3,l_glaq[l_i].glaq017,l_glaq[l_i].glaq018,l_glaq[l_i].glaq019,
                                      l_glaq[l_i].glaq020,l_glaq[l_i].glaq021,l_glaq[l_i].glaq022,l_glaq[l_i].glaq023,
                                      l_glaq[l_i].glaq024,l_glaq[l_i].glaq051,l_glaq[l_i].glaq052,l_glaq[l_i].glaq053,
                                      l_glaq[l_i].glaq025,l_glaq[l_i].glaq027,l_glaq[l_i].glaq028,l_glaq[l_i].glaq029,
                                      l_glaq[l_i].glaq030,l_glaq[l_i].glaq031,l_glaq[l_i].glaq032,l_glaq[l_i].glaq033,
                                      l_glaq[l_i].glaq034,l_glaq[l_i].glaq035,l_glaq[l_i].glaq036,l_glaq[l_i].glaq037,
                                      l_glaq[l_i].glaq038
                                      
           IF SQLCA.sqlcode THEN
#              CALL cl_errmsg('FOREACH','','',SQLCA.SQLCODE,1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'FOREACH'
              LET g_errparam.code = SQLCA.SQLCODE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = 'N' 
              EXIT FOREACH
           END IF
           IF l_sum1=0 THEN
              CONTINUE FOREACH
           END IF
           LET l_glaq[l_i].glaq003 = 0
           LET l_glaq[l_i].glaq004 = 0
           LET l_glaq[l_i].glaq040 = 0
           LET l_glaq[l_i].glaq041 = 0
           LET l_glaq[l_i].glaq043 = 0
           LET l_glaq[l_i].glaq044 = 0
#不考虑金额正负方向，金额放在借方
#           IF l_sum1>0 OR l_red='Y' THEN
              LET l_glaq[l_i].glaq010 = l_sum1
              LET l_glaq[l_i].glaq002 = l_glab[1].glab005    #损益类
              LET l_glaq[l_i].glaq003 = l_sum1               #借方金額(本位幣一)
              IF g_glaa015='Y' THEN
                 LET l_glaq[l_i].glaq040 = l_sum2     #借方金額(本位幣二)
              END IF
              IF g_glaa019='Y' THEN
                 LET l_glaq[l_i].glaq043 = l_sum3     #借方金額(本位幣三)
              END IF
     
           LET l_i = l_i + 1
        END FOREACH
        #资产类在贷方
        FOREACH aglp530_glar_cs2 INTO l_sum1,l_sum2,l_sum3,l_glaq[l_i].glaq017,l_glaq[l_i].glaq018,l_glaq[l_i].glaq019,
                                      l_glaq[l_i].glaq020,l_glaq[l_i].glaq021,l_glaq[l_i].glaq022,l_glaq[l_i].glaq023,
                                      l_glaq[l_i].glaq024,l_glaq[l_i].glaq051,l_glaq[l_i].glaq052,l_glaq[l_i].glaq053,
                                      l_glaq[l_i].glaq025,l_glaq[l_i].glaq027,l_glaq[l_i].glaq028,l_glaq[l_i].glaq029,
                                      l_glaq[l_i].glaq030,l_glaq[l_i].glaq031,l_glaq[l_i].glaq032,l_glaq[l_i].glaq033,
                                      l_glaq[l_i].glaq034,l_glaq[l_i].glaq035,l_glaq[l_i].glaq036,l_glaq[l_i].glaq037,
                                      l_glaq[l_i].glaq038
           IF SQLCA.sqlcode THEN
#              CALL cl_errmsg('FOREACH','','',SQLCA.SQLCODE,1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'FOREACH'
              LET g_errparam.code = SQLCA.SQLCODE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = 'N' 
              EXIT FOREACH
           END IF
           IF l_sum1=0 THEN
              CONTINUE FOREACH
           END IF
           LET l_glaq[l_i].glaq003 = 0
           LET l_glaq[l_i].glaq004 = 0
           LET l_glaq[l_i].glaq040 = 0
           LET l_glaq[l_i].glaq041 = 0
           LET l_glaq[l_i].glaq043 = 0
           LET l_glaq[l_i].glaq044 = 0
#不考虑金额正负方向，金额放在贷方           
#           IF l_sum1>0 OR l_red='Y' THEN
              LET l_glaq[l_i].glaq010 = l_sum1
              LET l_glaq[l_i].glaq002 = l_glab[2].glab005    #資產类
              LET l_glaq[l_i].glaq004 = l_sum1               #貸方金額(本位幣一)
              IF g_glaa015='Y' THEN
                 LET l_glaq[l_i].glaq041 = l_sum2     #貸方金額(本位幣二)
              END IF
              IF g_glaa019='Y' THEN
                 LET l_glaq[l_i].glaq044 = l_sum3     #貸方金額(本位幣三)
              END IF
        
           LET l_i = l_i + 1
        END FOREACH
   
        #160628-00036#2 add s---
        LET l_sql = " SELECT glch002,glch003 FROM glch_t ",
                    "  WHERE glchent = '",g_enterprise,"'",
                    "    AND glchld = '",g_master.glapld,"'",
                    "    AND glch001 = '",g_master.glap002,"'",
                    "    ORDER BY glch002,glch003 "       
        PREPARE aglp530_glch_pre FROM l_sql
        DECLARE aglp530_glch_cs  CURSOR FOR  aglp530_glch_pre   

        LET l_sql = " SELECT glac008 FROM glac_t ",
                    "  WHERE glacent = '",g_enterprise,"'",
                    "    AND glac001 = '",g_glaa004,"'", #会计科目参照表号
                    "    AND glac003 IN ('2','3')",      #獨立或明細科目
                    "    AND glac006 = '1'",             #账户科目
                    "    AND glac007 = '3' ",            #共用类科目  
                    "    AND glac002 = ? "
        PREPARE aglp530_glac_pre FROM l_sql
 
        FOREACH aglp530_glch_cs INTO l_glch002,l_glch003 
           IF SQLCA.sqlcode THEN
#              CALL cl_errmsg('FOREACH','','',SQLCA.SQLCODE,1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'FOREACH aglp530_glch_cs'
              LET g_errparam.code = SQLCA.SQLCODE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = 'N' 
              EXIT FOREACH
           END IF        
           #获取该科目是否设置核算项
           CALL aglp530_fix_acc_sql(l_glch002) RETURNING l_sql1,l_sql2
           
           EXECUTE aglp530_glac_pre USING l_glch002 INTO l_glac008
           
                        
           #共用類借
           LET l_sql="SELECT SUM(glar006)-SUM(glar005),SUM(glar035)-SUM(glar034),SUM(glar037)-SUM(glar036),",l_sql2,     
                     "  FROM glar_t ",
                     " WHERE glarent = ",g_enterprise,
                     "   AND glarld = '",g_glaq.glaqld,"'",
                     "   AND glar001 = ? ",
                     "   AND glar002 =", g_master.glap002,
                     "   AND glar003 =", g_master.glap004,
                     " GROUP BY ",l_sql2," ORDER BY ",l_sql2
           
                  
           PREPARE aglp530_glar_pr3 FROM l_sql
           DECLARE aglp530_glar_cs3  CURSOR FOR  aglp530_glar_pr3

           #共用类在借方                  
           FOREACH aglp530_glar_cs3 USING l_glch002
                                    INTO l_sum1,l_sum2,l_sum3,l_glaq[l_i].glaq017,l_glaq[l_i].glaq018,l_glaq[l_i].glaq019,
                                         l_glaq[l_i].glaq020,l_glaq[l_i].glaq021,l_glaq[l_i].glaq022,l_glaq[l_i].glaq023,
                                         l_glaq[l_i].glaq024,l_glaq[l_i].glaq051,l_glaq[l_i].glaq052,l_glaq[l_i].glaq053,
                                         l_glaq[l_i].glaq025,l_glaq[l_i].glaq027,l_glaq[l_i].glaq028,l_glaq[l_i].glaq029,
                                         l_glaq[l_i].glaq030,l_glaq[l_i].glaq031,l_glaq[l_i].glaq032,l_glaq[l_i].glaq033,
                                         l_glaq[l_i].glaq034,l_glaq[l_i].glaq035,l_glaq[l_i].glaq036,l_glaq[l_i].glaq037,
                                         l_glaq[l_i].glaq038
                                         
              IF SQLCA.sqlcode THEN
   #              CALL cl_errmsg('FOREACH','','',SQLCA.SQLCODE,1)
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = 'FOREACH'
                 LET g_errparam.code = SQLCA.SQLCODE
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_success = 'N' 
                 EXIT FOREACH
              END IF
              IF l_sum1=0 THEN
                 CONTINUE FOREACH
              END IF
              LET l_glaq[l_i].glaq003 = 0
              LET l_glaq[l_i].glaq004 = 0
              LET l_glaq[l_i].glaq040 = 0
              LET l_glaq[l_i].glaq041 = 0
              LET l_glaq[l_i].glaq043 = 0
              LET l_glaq[l_i].glaq044 = 0

              IF l_glac008 = '2' THEN
                 LET l_glaq[l_i].glaq010 = l_sum1
                 LET l_glaq[l_i].glaq002 = l_glch002    #共用类
                 LET l_glaq[l_i].glaq003 = l_sum1               #借方金額(本位幣一)
                 IF g_glaa015='Y' THEN
                    LET l_glaq[l_i].glaq040 = l_sum2     #借方金額(本位幣二)
                 END IF
                 IF g_glaa019='Y' THEN
                    LET l_glaq[l_i].glaq043 = l_sum3     #借方金額(本位幣三)
                 END IF
              ELSE
                 LET l_glaq[l_i].glaq010 = l_sum1 * (-1)
                 LET l_glaq[l_i].glaq002 = l_glch002    #共用类
                 LET l_glaq[l_i].glaq003 = l_sum1 * (-1)        #借方金額(本位幣一)
                 IF g_glaa015='Y' THEN
                    LET l_glaq[l_i].glaq040 = l_sum2 * (-1)     #借方金額(本位幣二)
                 END IF
                 IF g_glaa019='Y' THEN
                    LET l_glaq[l_i].glaq043 = l_sum3 * (-1)    #借方金額(本位幣三)
                 END IF
              END IF   

 
              IF l_red = 'N' AND l_glaq[l_i].glaq003<0 THEN 
                 CALL aglp530_red(l_glaq[l_i].glaq010,l_glaq[l_i].glaq003,l_glaq[l_i].glaq004,l_glaq[l_i].glaq040,l_glaq[l_i].glaq041,l_glaq[l_i].glaq043,l_glaq[l_i].glaq044)
                    RETURNING l_glaq[l_i].glaq010,l_glaq[l_i].glaq003,l_glaq[l_i].glaq004,l_glaq[l_i].glaq040,l_glaq[l_i].glaq041,l_glaq[l_i].glaq043,l_glaq[l_i].glaq044
              END IF
              LET l_i = l_i + 1
           END FOREACH
           
           #获取该科目是否设置核算项
           CALL aglp530_fix_acc_sql(l_glch003) RETURNING l_sql1,l_sql2
           #损益類贷
           LET l_sql="SELECT SUM(glar006)-SUM(glar005),SUM(glar035)-SUM(glar034),SUM(glar037)-SUM(glar036),",l_sql2,      
                     "  FROM glar_t ",
                     " WHERE glarent = ",g_enterprise,
                     "   AND glarld = '",g_glaq.glaqld,"'",
                     "   AND glar001 = ? ",
                     "   AND glar002 =", g_master.glap002,
                     "   AND glar003 =", g_master.glap004,
                     " GROUP BY ",l_sql2," ORDER BY ",l_sql2
           PREPARE aglp530_glar_pr4 FROM l_sql
           DECLARE aglp530_glar_cs4  CURSOR FOR  aglp530_glar_pr4 
           
           #损益类在贷方
           FOREACH aglp530_glar_cs4 USING l_glch002
                                    INTO l_sum1,l_sum2,l_sum3,l_glaq[l_i].glaq017,l_glaq[l_i].glaq018,l_glaq[l_i].glaq019,
                                         l_glaq[l_i].glaq020,l_glaq[l_i].glaq021,l_glaq[l_i].glaq022,l_glaq[l_i].glaq023,
                                         l_glaq[l_i].glaq024,l_glaq[l_i].glaq051,l_glaq[l_i].glaq052,l_glaq[l_i].glaq053,
                                         l_glaq[l_i].glaq025,l_glaq[l_i].glaq027,l_glaq[l_i].glaq028,l_glaq[l_i].glaq029,
                                         l_glaq[l_i].glaq030,l_glaq[l_i].glaq031,l_glaq[l_i].glaq032,l_glaq[l_i].glaq033,
                                         l_glaq[l_i].glaq034,l_glaq[l_i].glaq035,l_glaq[l_i].glaq036,l_glaq[l_i].glaq037,
                                         l_glaq[l_i].glaq038
              IF SQLCA.sqlcode THEN
   #              CALL cl_errmsg('FOREACH','','',SQLCA.SQLCODE,1)
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = 'FOREACH'
                 LET g_errparam.code = SQLCA.SQLCODE
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_success = 'N' 
                 EXIT FOREACH
              END IF
              IF l_sum1=0 THEN
                 CONTINUE FOREACH
              END IF
              LET l_glaq[l_i].glaq003 = 0
              LET l_glaq[l_i].glaq004 = 0
              LET l_glaq[l_i].glaq040 = 0
              LET l_glaq[l_i].glaq041 = 0
              LET l_glaq[l_i].glaq043 = 0
              LET l_glaq[l_i].glaq044 = 0
   #不考虑金额正负方向，金额放在贷方           
   #           IF l_sum1>0 OR l_red='Y' THEN
              IF l_glac008 = '2' THEN
                 LET l_glaq[l_i].glaq010 = l_sum1
                 LET l_glaq[l_i].glaq002 = l_glch003    #损益类
                 LET l_glaq[l_i].glaq004 = l_sum1               #貸方金額(本位幣一)
                 IF g_glaa015='Y' THEN
                    LET l_glaq[l_i].glaq041 = l_sum2     #貸方金額(本位幣二)
                 END IF
                 IF g_glaa019='Y' THEN
                    LET l_glaq[l_i].glaq044 = l_sum3     #貸方金額(本位幣三)
                 END IF 
              ELSE
                 LET l_glaq[l_i].glaq010 = l_sum1 * (-1)
                 LET l_glaq[l_i].glaq002 = l_glch003    #损益类
                 LET l_glaq[l_i].glaq004 = l_sum1 * (-1)              #貸方金額(本位幣一)
                 IF g_glaa015='Y' THEN
                    LET l_glaq[l_i].glaq041 = l_sum2 * (-1)    #貸方金額(本位幣二)
                 END IF
                 IF g_glaa019='Y' THEN
                    LET l_glaq[l_i].glaq044 = l_sum3 * (-1)    #貸方金額(本位幣三)
                 END IF               
              END IF 


              IF l_red = 'N' AND l_glaq[l_i].glaq004<0  THEN 
                 CALL aglp530_red(l_glaq[l_i].glaq010,l_glaq[l_i].glaq003,l_glaq[l_i].glaq004,l_glaq[l_i].glaq040,l_glaq[l_i].glaq041,l_glaq[l_i].glaq043,l_glaq[l_i].glaq044)
                    RETURNING l_glaq[l_i].glaq010,l_glaq[l_i].glaq003,l_glaq[l_i].glaq004,l_glaq[l_i].glaq040,l_glaq[l_i].glaq041,l_glaq[l_i].glaq043,l_glaq[l_i].glaq044
              END IF
              
              LET l_i = l_i + 1
           END FOREACH 
           

        END FOREACH
        #160628-00036#2 add e---    

        #INS--glap_t,glaq_t,glar_t
        #161111-00028#8----modify----begin---------       
        #INSERT INTO glap_t VALUES (g_glap.*)
        INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,glap005,
                              glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,glap016,
                              glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                              glapcnfdt,glappstid,glappstdt,glapstus)
           VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,g_glap.glap005,
                  g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,g_glap.glap015,g_glap.glap016,
                  g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,g_glap.glapmoddt,g_glap.glapcnfid,
                  g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
        #161111-00028#8----modify----end---------
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('INSERT glap_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'INSERT glap_t'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N' 
        END IF
        UPDATE glap_t SET glapcrtdt = ld_date,
                          glapcnfdt = ld_date
         WHERE glapent = g_enterprise
           AND glapld = g_glap.glapld
           AND glapdocno = g_glap.glapdocno
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('UPD date',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'UPDATE glap_t'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N' 
        END IF 
        
        IF g_success = 'Y' THEN
           #l_cnt=1：借，l_cnt = 2：贷
           LET l_i=l_i-1
           FOR l_cnt =1 TO l_i
#160628-00036#2 mod s---            
#               CALL s_voucher_fix_acc_open_chk(g_master.glapld,l_glaq[l_cnt].glaq002)
#               RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033
#               #自由核算项
#               SELECT glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,glad026
#                 INTO l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,l_glad022,l_glad023,l_glad024,l_glad025,l_glad026
#                 FROM glad_t
#                WHERE gladent = g_enterprise
#                  AND gladld = g_master.glapld
#                  AND glad001 = l_glaq[l_cnt].glaq002
                 
#               #營運據點
#               IF cl_null(l_glaq[l_cnt].glaq017) THEN
#                  LET l_glaq[l_cnt].glaq017 = g_glap.glapcomp
#               END IF
#               #該科目做部門管理
#               IF l_glad007 <> 'Y' OR l_glad007 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq018 = ' ' 
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq018) THEN
#                     #依據登入用戶抓取所在部門
#                     SELECT ooag003 INTO l_glaq[l_cnt].glaq018 FROM ooag_t
#                      WHERE ooagent = g_enterprise
#                        AND ooag001 = g_user
#                  END IF
#               END IF 
#               #該科目做利潤成本管理時
#               IF l_glad008 <> 'Y' OR l_glad008 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq019 = ' ' 
#               ELSE                  
#                  IF cl_null(l_glaq[l_cnt].glaq019) THEN
#                     SELECT ooeg004 INTO l_glaq[l_cnt].glaq019 FROM ooeg_t 
#                      WHERE ooegent = g_enterprise 
#                        AND ooeg001 = (SELECT ooag003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_user)
#                  END IF
#               END IF 
#               #該科目做區域管理時
#               IF l_glad009 <> 'Y' OR l_glad009 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq020 = ' '
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq020) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'4') RETURNING l_glaq[l_cnt].glaq020
#                  END IF
#               END IF 
#               #該科目做客商管理
#               IF l_glad010 <> 'Y' OR l_glad010 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq021 = ' '
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq021) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'5') RETURNING l_glaq[l_cnt].glaq021
#                  END IF
#               END IF 
#               #該科目做账款客商管理時
#               IF l_glad027 <> 'Y' OR l_glad027 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq022 = ' '
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq022) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'6') RETURNING l_glaq[l_cnt].glaq022
#                  END IF
#               END IF 
#               #該科目做客群管理時
#               IF l_glad011 <> 'Y' OR l_glad011 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq023 = ' '     
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq023) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'7') RETURNING l_glaq[l_cnt].glaq023
#                  END IF   
#               END IF 
#               #該科目做產品分類管理時，
#               IF l_glad012 <> 'Y' OR l_glad012 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq024 = ' '   
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq024) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'8') RETURNING l_glaq[l_cnt].glaq024
#                  END IF   
#               END IF 
#               #該科目做经营方式管理時，
#               IF l_glad031 <> 'Y' OR l_glad031 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq051 = ' '   
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq051) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'9') RETURNING l_glaq[l_cnt].glaq051
#                  END IF
#               END IF
#               #該科目做渠道管理時，
#               IF l_glad032 <> 'Y' OR l_glad032 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq052 = ' '    
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq052) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'10') RETURNING l_glaq[l_cnt].glaq052
#                  END IF
#               END IF
#               #該科目做品牌管理時，
#               IF l_glad033 <> 'Y' OR l_glad033 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq053 = ' '    
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq053) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'11') RETURNING l_glaq[l_cnt].glaq053
#                  END IF
#               END IF
#               #該科目做人員管理時，
#               IF l_glad013 <> 'Y' OR l_glad013 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq025 = ' '     
#               ELSE
#                  LET l_glaq[l_cnt].glaq025 = g_user
#               END IF 
#               #該科目做專案管理時，
#               IF l_glad015 <> 'Y' OR l_glad015 IS NULL THEN
#                  LET l_glaq[l_cnt].glaq027 = ' '   
#               ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq027) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'13') RETURNING l_glaq[l_cnt].glaq027
#                  END IF   
#               END IF 
#                #該科目做WBS管理時，
#                IF l_glad016 <> 'Y' OR l_glad016 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq028 = ' '  
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq028) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'14') RETURNING l_glaq[l_cnt].glaq028
#                  END IF   
#                END IF 
#                #核算项一
#                IF l_glad017 <> 'Y' OR l_glad017 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq029 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq029) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'15') RETURNING l_glaq[l_cnt].glaq029
#                  END IF
#                END IF 
#                #核算项二
#                IF l_glad018 <> 'Y' OR l_glad018 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq030 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq030) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'16') RETURNING l_glaq[l_cnt].glaq030
#                  END IF
#                END IF
#                #核算项三
#                IF l_glad019 <> 'Y' OR l_glad019 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq031 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq031) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'17') RETURNING l_glaq[l_cnt].glaq031
#                  END IF
#                END IF
#                #核算项四
#                IF l_glad020 <> 'Y' OR l_glad020 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq032 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq032) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'18') RETURNING l_glaq[l_cnt].glaq032
#                  END IF
#                END IF
#                #核算项五
#                IF l_glad021 <> 'Y' OR l_glad021 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq033 = ' '  
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq033) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'19') RETURNING l_glaq[l_cnt].glaq033
#                  END IF   
#                END IF
#                #核算项四六
#                IF l_glad022 <> 'Y' OR l_glad022 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq034 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq034) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'20') RETURNING l_glaq[l_cnt].glaq034
#                  END IF
#                END IF
#                #核算项七
#                IF l_glad023 <> 'Y' OR l_glad023 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq035 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq035) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'21') RETURNING l_glaq[l_cnt].glaq035
#                  END IF
#                END IF
#                #核算项八
#                IF l_glad024 <> 'Y' OR l_glad024 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq036 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq036) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'22') RETURNING l_glaq[l_cnt].glaq036
#                  END IF
#                END IF
#                #核算项九
#                IF l_glad025 <> 'Y' OR l_glad025 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq037 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq037) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'23') RETURNING l_glaq[l_cnt].glaq037
#                  END IF
#                END IF
#                #核算项十
#                IF l_glad026 <> 'Y' OR l_glad026 IS NULL THEN
#                   LET l_glaq[l_cnt].glaq038 = ' '   
#                ELSE
#                  IF cl_null(l_glaq[l_cnt].glaq038) THEN
#                     CALL s_voucher_get_fix_default_value(g_glap.glapld,l_glaq[l_cnt].glaq002,'24') RETURNING l_glaq[l_cnt].glaq038
#                  END IF
#                END IF
               #INS---glaq_t
               LET g_glaq.glaqseq = l_cnt 
               LET g_glaq.glaq010 = l_glaq[l_cnt].glaq010
               LET g_glaq.glaq002 = l_glaq[l_cnt].glaq002
               LET g_glaq.glaq003 = l_glaq[l_cnt].glaq003
               LET g_glaq.glaq004 = l_glaq[l_cnt].glaq004
               LET g_glaq.glaq040 = l_glaq[l_cnt].glaq040
               LET g_glaq.glaq041 = l_glaq[l_cnt].glaq041
               LET g_glaq.glaq043 = l_glaq[l_cnt].glaq043
               LET g_glaq.glaq044 = l_glaq[l_cnt].glaq044
               LET g_glaq.glaq017 = l_glaq[l_cnt].glaq017
               LET g_glaq.glaq018 = l_glaq[l_cnt].glaq018
               LET g_glaq.glaq019 = l_glaq[l_cnt].glaq019
               LET g_glaq.glaq020 = l_glaq[l_cnt].glaq020
               LET g_glaq.glaq021 = l_glaq[l_cnt].glaq021
               LET g_glaq.glaq022 = l_glaq[l_cnt].glaq022
               LET g_glaq.glaq023 = l_glaq[l_cnt].glaq023
               LET g_glaq.glaq024 = l_glaq[l_cnt].glaq024
               LET g_glaq.glaq051 = l_glaq[l_cnt].glaq051
               LET g_glaq.glaq052 = l_glaq[l_cnt].glaq052
               LET g_glaq.glaq053 = l_glaq[l_cnt].glaq053
               LET g_glaq.glaq025 = l_glaq[l_cnt].glaq025
               LET g_glaq.glaq027 = l_glaq[l_cnt].glaq027
               LET g_glaq.glaq028 = l_glaq[l_cnt].glaq028
               LET g_glaq.glaq029 = l_glaq[l_cnt].glaq029
               LET g_glaq.glaq030 = l_glaq[l_cnt].glaq030
               LET g_glaq.glaq031 = l_glaq[l_cnt].glaq031
               LET g_glaq.glaq032 = l_glaq[l_cnt].glaq032
               LET g_glaq.glaq033 = l_glaq[l_cnt].glaq033
               LET g_glaq.glaq034 = l_glaq[l_cnt].glaq034
               LET g_glaq.glaq035 = l_glaq[l_cnt].glaq035
               LET g_glaq.glaq036 = l_glaq[l_cnt].glaq036
               LET g_glaq.glaq037 = l_glaq[l_cnt].glaq037
               LET g_glaq.glaq038 = l_glaq[l_cnt].glaq038
             
               #核算項預設值
               CALL aglp530_fix_acc_open(g_glaq.glaqld,l_glaq[l_cnt].glaq002)
#160628-00036#2 mod e---
               #摘要
               LET g_glaq.glaq001=g_glap.glap002 USING '<<<<',cl_getmsg('agl-00274',g_lang),
                                  g_glap.glap004 USING '<<<<',cl_getmsg('axc-00589',g_lang)," ",
                                  cl_getmsg('agl-00309',g_lang)
               #161111-00028#8----modify----begin---------                   
               #INSERT INTO glaq_t VALUES(g_glaq.*)
                INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,
                                    glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                                    glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,
                                    glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                                    glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,
                                    glaq052,glaq053)
                 VALUES(g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,
                        g_glaq.glaq006,g_glaq.glaq007,g_glaq.glaq008,g_glaq.glaq009,g_glaq.glaq010,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,
                        g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,
                        g_glaq.glaq026,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                        g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,g_glaq.glaq051,
                        g_glaq.glaq052,g_glaq.glaq053)
               #161111-00028#8----modify----end---------
               IF SQLCA.SQLCODE THEN
#                  CALL cl_errmsg('INSERT glaq_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'INSERT glaq_t'
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_success = 'N' 
               END IF 
           END FOR
        END IF
         
        #160628-00036#2 add str---
        LET l_glap010 = 0
        LET l_glap011 = 0
        SELECT SUM(glaq003),SUM(glaq004) INTO l_glap010,l_glap011 FROM glaq_t WHERE glaqent = g_enterprise 
           AND glaqld = g_glap.glapld AND glaqdocno = g_glap.glapdocno
        UPDATE glap_t SET glap010 = l_glap010,
                          glap011 = l_glap011
           WHERE glapent = g_enterprise AND glapld = g_glap.glapld AND glapdocno = g_glap.glapdocno
        IF SQLCA.SQLCODE THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'UPDATE glap_t'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N' 
        END IF            
        #160628-00036#2 add end---   
        
        #CE凭证过账
        CALL s_voucher_post_chk(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
        IF l_success = TRUE THEN
           CALL s_voucher_post_upd(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
        END IF 
        IF l_success = FALSE THEN
           LET g_success = 'N'
        END IF 
       
END FUNCTION

################################################################################
# Descriptions...: 當該帳別選擇的期末結帳方式='帳結法'
# Memo...........:
# Usage..........: CALL aglp530_glaa006_2(p_glap004_s,p_glap004_e)
# Input parameter: p_glap004_s   起始期別
#                : p_glap004_e   截止期別 
# Return code....:  
# Date & Author..: 02599 
# Modify.........: 2015/1/31改成傳入起始截止期別
################################################################################
PRIVATE FUNCTION aglp530_glaa006_2(p_glap004_s,p_glap004_e)
   DEFINE p_glap004_s      LIKE glap_t.glap004
   DEFINE p_glap004_e      LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5 
   DEFINE l_sum1_d         LIKE glaq_t.glaq003  #借方金額(本位幣一)
   DEFINE l_sum2_d         LIKE glaq_t.glaq003  #借方金額(本位幣二)
   DEFINE l_sum3_d         LIKE glaq_t.glaq003  #借方金額(本位幣三)
   DEFINE l_sum1_c         LIKE glaq_t.glaq003  #貸方金額(本位幣一)
   DEFINE l_sum2_c         LIKE glaq_t.glaq003  #貸方金額(本位幣二)
   DEFINE l_sum3_c         LIKE glaq_t.glaq003  #貸方金額(本位幣三)
   DEFINE l_profit1        LIKE glaq_t.glaq003
   DEFINE l_profit2        LIKE glaq_t.glaq003
   DEFINE ld_date          DATETIME YEAR TO SECOND
   DEFINE l_sql            STRING
   DEFINE l_sql1           STRING 
   DEFINE l_sql2           STRING   
   DEFINE l_glab005        LIKE glab_t.glab005
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_count          LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_glch002        LIKE glch_t.glch002     #160628-00036#2 
   DEFINE l_glch003        LIKE glch_t.glch003     #160628-00036#2  
   DEFINE l_glac008        LIKE glac_t.glac008     #160628-00036#2
   DEFINE l_n              LIKE type_t.num5        #160628-00036#2
   DEFINE l_red            LIKE type_t.chr10       #160628-00036#2
   #A.產生兩張期末結轉傳票(CE)
   ####################### A-1.費用科目結轉本年利潤 ###########################
   #  傳票單別=總帳參數設定檔.結轉用單別
   #  傳票日期=執行年期的當期最末一日
   #  來源類型='CE'的傳票單頭單身資料(glap_t,glaq_t)且傳票狀態='已過帳'
   #  科目編號=當期傳票有費用類科目的傳票憑證單身資料(glaq_t).科目編號(費用科目的判斷=損益類科目且餘額型態為借方)
   #  傳票金額=原當期傳票費用科目的傳票單身金額但借貸相反
   #  上述費用類科目逐一產生對應的傳票單身資料後, 其金額總和另增一筆傳票單身,借:總帳參數設定檔.本年利潤
   
   #清空临时表
   DELETE FROM p530_tmp
   
   LET l_count=0
   #本年利潤科目
   SELECT glab005 INTO l_glab005 FROM glab_t
    WHERE glabent=g_enterprise AND glabld=g_master.glapld
      AND glab001='12' AND glab002='9711' AND glab003='9711_04'
   IF cl_null(l_glab005) THEN
#      CALL cl_errmsg('','','','agl-00210',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code = 'agl-00210'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   #获取该科目是否设置核算项
   CALL aglp530_fix_acc_sql(l_glab005) RETURNING l_sql1,l_sql2
   #=============单头glap_t====================
   LET g_glap.glapent = g_enterprise
   LET g_glap.glapcomp = g_glaacomp
   LET g_glap.glapld = g_master.glapld 
   LET g_glap.glap001 = '1'      
   LET g_glap.glap002 = g_master.glap002
   LET g_glap.glap004 = g_master.glap004
   LET g_glap.glapdocno = g_glaa112
   CALL s_get_accdate(g_glaa003,'',g_master.glap002,g_master.glap004)
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'
      RETURN
   END IF         
   LET g_glap.glapdocdt=l_pdate_e
   LET l_success = TRUE
   CALL s_aooi200_fin_gen_docno(g_master.glapld,g_glaa024,g_glaa003,g_glap.glapdocno,g_glap.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
   IF l_success = FALSE THEN 
      LET g_success = 'N'
      RETURN
   END IF       
   LET g_glap.glap007 = 'CE'
   LET g_glap.glap009 = 0
   LET g_glap.glap009 = 0
   LET g_glap.glap013 = 0
   LET g_glap.glap014 = 'N'
   LET g_glap.glapstus = 'Y'
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapownid = g_user
   LET g_glap.glapowndp = g_dept
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdp = g_dept 
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapcnfid = g_user
   LET g_glap.glapcnfdt = cl_get_current()
   LET ld_date = cl_get_current()
   #==============单身glaq_t======================
   LET g_glaq.glaqent = g_glap.glapent
   LET g_glaq.glaqld = g_glap.glapld
   LET g_glaq.glaqdocno = g_glap.glapdocno
   LET g_glaq.glaqcomp = g_glap.glapcomp
   LET g_glaq.glaq005 = g_glaa001
   LET g_glaq.glaq006 = 1
   
   #獲取單據別對應參數：紅字傳票否
   CALL s_fin_get_doc_para(g_master.glapld,g_glaacomp,g_glaa112,'D-FIN-1002') RETURNING l_red   #160628-00036#2
   
   #匯率(本位幣二)
   IF g_glaa015='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa016,0,g_glaa018)
      RETURNING  g_glaq.glaq039
   ELSE
      LET g_glaq.glaq039 = 0  
   END IF
   #匯率(本位幣三)
   IF g_glaa019='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa020,0,g_glaa022)
      RETURNING  g_glaq.glaq042
   ELSE
      LET g_glaq.glaq042 = 0  
   END IF
   #摘要
   LET g_glaq.glaq001=g_glap.glap002 USING '<<<<',cl_getmsg('agl-00274',g_lang),
                      g_glap.glap004 USING '<<<<',cl_getmsg('axc-00589',g_lang)," ",
                      cl_getmsg('agl-00309',g_lang)
   LET g_glaq.glaqseq = 1
   LET l_sql = " SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),",
               "        glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "        glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "        glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
               "   FROM glaq_t,glap_t ",
               "  WHERE glaqent = glapent ",
               "    AND glaqld = glapld ",
               "    AND glaqdocno = glapdocno ",                  
               "    AND glaqent = ",g_enterprise,"",
               "    AND glaqld = '",g_master.glapld,"'"  ,                
               "    AND glaq002 IN ( SELECT glaq002 FROM glaq_t,glac_t ",
               "                     WHERE glaqent = glacent",
               "                       AND glaq002 = glac002",
               "                       AND glac001 = '",g_glaa004,"'",
               "                       AND glac007 = '6'",    #损益类
               "                       AND glac008 = '1') ",  #借余
               "    AND glap002 = ",g_master.glap002,
               "    AND glap004 BETWEEN ",p_glap004_s," AND ",p_glap004_e,
               "    AND glapstus = 'S'", 
               "    GROUP BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "             glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "             glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
               "    ORDER BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "             glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "             glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053"
   PREPARE aglp530_glaq_pre   FROM l_sql
   DECLARE aglp530_glaq_cs  CURSOR FOR  aglp530_glaq_pre
   FOREACH aglp530_glaq_cs INTO g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044,
                                g_glaq.glaq002,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,
                                g_glaq.glaq015,g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,
                                g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,
                                g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,
                                g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                                g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq051,g_glaq.glaq052,
                                g_glaq.glaq053
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_glaq.glaq002
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
          
      #借贷相反
      IF cl_null(g_glaq.glaq003) THEN LET g_glaq.glaq003 = 0  END IF
      IF cl_null(g_glaq.glaq004) THEN LET g_glaq.glaq004 = 0  END IF
      IF cl_null(g_glaq.glaq040) THEN LET g_glaq.glaq040 = 0  END IF
      IF cl_null(g_glaq.glaq041) THEN LET g_glaq.glaq041 = 0  END IF
      IF cl_null(g_glaq.glaq043) THEN LET g_glaq.glaq043 = 0  END IF
      IF cl_null(g_glaq.glaq044) THEN LET g_glaq.glaq044 = 0  END IF
      
      #当该科目借贷都有金额时
      IF g_glaq.glaq003<>0 AND g_glaq.glaq004<>0 THEN
         LET g_glaq.glaq003 = g_glaq.glaq003 - g_glaq.glaq004
         IF g_glaq.glaq003 < 0 THEN
            LET g_glaq.glaq004 = g_glaq.glaq003 * (-1)
            LET g_glaq.glaq003 = 0
         ELSE
            LET g_glaq.glaq004 = 0
         END IF
      END IF
      
      #当该科目金额都为0时不用写入
      IF g_glaq.glaq003=0 AND g_glaq.glaq004=0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_sum1_d = g_glaq.glaq003
      LET g_glaq.glaq003 = g_glaq.glaq004
      LET g_glaq.glaq004 = l_sum1_d
      LET l_sum2_d = g_glaq.glaq040
      LET g_glaq.glaq040 = g_glaq.glaq041
      LET g_glaq.glaq041 = l_sum2_d
      LET l_sum3_d = g_glaq.glaq043
      LET g_glaq.glaq043 = g_glaq.glaq044
      LET g_glaq.glaq044 = l_sum2_d      
      LET g_glaq.glaq010 = g_glaq.glaq003 + g_glaq.glaq004
      
      INSERT INTO p530_tmp (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,
                            glaq005,glaq006,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                            glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                            glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,
                            glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,
                            glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,glaq052,glaq053)
      VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
              g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
              g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,g_glaq.glaq016,
              g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
              g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
              g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
              g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,
              g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
              g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053)
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('ins_tmp_1',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins_tmp_1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      LET g_glaq.glaqseq = g_glaq.glaqseq +1           
   END FOREACH
   #其金額總和另增一筆傳票單身,如果贷-借>0,则产生借方金额，否则反之。科目：本年利润，
   #按照科目设置的固定核算项分别产生传票单身资料
#   LET g_glaq.glaq002 = '2298'    #本年利润
   LET g_glaq.glaq002 = l_glab005  #本年利润
   
   LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),",l_sql1,
             "  FROM p530_tmp ",
             " GROUP BY ",l_sql1," ORDER BY ",l_sql1
   PREPARE aglp530_tmp_pr1 FROM l_sql
   DECLARE aglp530_tmp_cs1 CURSOR FOR aglp530_tmp_pr1
   #获取项次
   SELECT MAX(glaqseq)+1 INTO g_glaq.glaqseq FROM p530_tmp
   IF cl_null(g_glaq.glaqseq) OR g_glaq.glaqseq=0 THEN 
      LET g_glaq.glaqseq=1
   END IF
   
   FOREACH aglp530_tmp_cs1 INTO l_sum1_d,l_sum1_c,l_sum2_d,l_sum2_c,l_sum3_d,l_sum3_c,
                                g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,
                                g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,
                                g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053,g_glaq.glaq025,
                                g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,
                                g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
                                g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038
                                
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH aglp530_tmp_cs1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      LET l_profit1 = 0
      IF cl_null(l_sum1_d) THEN LET l_sum1_d = 0  END IF
      IF cl_null(l_sum1_c) THEN LET l_sum1_c = 0  END IF
      IF cl_null(l_sum2_d) THEN LET l_sum2_d = 0  END IF
      IF cl_null(l_sum2_c) THEN LET l_sum2_c = 0  END IF
      IF cl_null(l_sum3_d) THEN LET l_sum3_d = 0  END IF
      IF cl_null(l_sum3_c) THEN LET l_sum3_c = 0  END IF
        
      #贷 - 借>0,产生借方资料，否则产生在贷方             
      LET l_profit1 = l_sum1_c - l_sum1_d 
      #差额为0，则不需进行在产生一笔资料来平借贷
      IF l_profit1 <>0 THEN
         IF l_profit1 > 0 THEN
            LET g_glaq.glaq003 = l_profit1
            LET g_glaq.glaq004 = 0
            #本位幣二
            IF g_glaa015='Y' THEN
               LET g_glaq.glaq040 = l_sum2_c - l_sum2_d
               LET g_glaq.glaq041 = 0
            ELSE
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = 0
            END IF
            #本位幣三
            IF g_glaa019 THEN
               LET g_glaq.glaq043 = l_sum3_c - l_sum3_d
               LET g_glaq.glaq044 = 0
            ELSE
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = 0
            END IF
            LET g_glaq.glaq010 = g_glaq.glaq003
         ELSE
            LET l_profit1 = l_profit1 * (-1)
            LET g_glaq.glaq003 = 0
            LET g_glaq.glaq004 = l_profit1
            #本位幣二
            IF g_glaa015='Y' THEN
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = (l_sum2_c - l_sum2_d)*-1
            ELSE
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = 0
            END IF
            #本位幣三
            IF g_glaa019 THEN
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = (l_sum3_c - l_sum3_d)*-1
            ELSE
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = 0
            END IF
            LET g_glaq.glaq010 = g_glaq.glaq004              
         END IF
         #核算項預設值
         CALL aglp530_fix_acc_open(g_glaq.glaqld,g_glaq.glaq002)
         INSERT INTO p530_tmp (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,
                               glaq003,glaq004,glaq005,glaq006,glaq010,
                               glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                               glaq023,glaq024,glaq025,glaq027,glaq028,
                               glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,
                               glaq051,glaq052,glaq053,
                               glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,
                               glaq035,glaq036,glaq037,glaq038)
         VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
                 g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
                 g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
                 g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
                 g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
                 g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053,
                 g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
                 g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('ins_tmp_2',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins_tmp_2'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
         LET g_glaq.glaqseq = g_glaq.glaqseq +1  
      END IF
   END FOREACH      
   #==============INS_glap_t==========
   SELECT COUNT(*) INTO l_cnt FROM p530_tmp 
    WHERE glaqdocno=g_glaq.glaqdocno
   IF l_cnt>0 THEN
      #借方金额为单身借贷金额之和
      SELECT SUM(glaq003),SUM(glaq004) INTO g_glap.glap010,g_glap.glap011
        FROM p530_tmp 
      #161111-00028#8----modify----begin---------       
      #INSERT INTO glap_t VALUES (g_glap.*)
      INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,glap005,
                            glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,glap016,
                            glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                            glapcnfdt,glappstid,glappstdt,glapstus)
         VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,g_glap.glap005,
                g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,g_glap.glap015,g_glap.glap016,
                g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,g_glap.glapmoddt,g_glap.glapcnfid,
                g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
      #161111-00028#8----modify----end---------
        
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('INS_glap_a1',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INS_glap_a1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      UPDATE glap_t SET glapcrtdt = ld_date,
                        glapcnfdt = ld_date
       WHERE glapent = g_enterprise
         AND glapld = g_glap.glapld
         AND glapdocno = g_glap.glapdocno
      IF SQLCA.SQLCODE THEN
#         CALL cl_errmsg('UPD date',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'UPDATE glap_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF         
      #==============INS_glaq_t==========
      LET l_sql = " INSERT INTO glaq_t(glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,
                                       glaq003,glaq004,glaq005,glaq006,glaq010,
                                       glaq011,glaq012,glaq013,glaq014,glaq015,
                                       glaq016,glaq017,glaq018,glaq019,glaq020,
                                       glaq021,glaq022,glaq023,glaq024,glaq025,
                                       glaq027,glaq028,glaq029,glaq030,
                                       glaq031,glaq032,glaq033,glaq034,glaq035,
                                       glaq036,glaq037,glaq038,glaq039,glaq040,
                                       glaq041,glaq042,glaq043,glaq044,
                                       glaq051,glaq052,glaq053) ",
                  " SELECT * FROM p530_tmp "
      PREPARE aglp530_ins_glaq_pre   FROM l_sql
      EXECUTE aglp530_ins_glaq_pre
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('INS_glaq_a1',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INS_glaq_a1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF 
      
      #CE傳票的過帳動作
      LET l_success = TRUE
      CALL s_voucher_post_chk(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
      IF l_success = TRUE THEN
         CALL s_voucher_post_upd(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
      END IF 
      IF l_success = FALSE THEN
         LET g_success = 'N'
      END IF
   ELSE
      LET l_count=l_count+1
   END IF
   ###################### A-2.收入科目結轉本年利潤#######################
   # 傳票單別=總帳參數設定檔.結轉用單別
   # 傳票日期=執行年期的當期最末一日
   # 來源類型='CE'的傳票單頭單身資料(glap_t,glaq_t)且傳票狀態='已過帳'
   # 科目編號=當期傳票有收入類科目的傳票憑證單身資料(glar_t).科目編號(收入科目的判斷=損益類科目且餘額型態為貸方)
   # 傳票金額=原當期傳票收入科目的傳票單身金額但借貸相反
   # 上述收入類科目逐一產生對應的傳票單身資料後, 其金額總和另增一筆傳票單身,貸:總帳參數設定檔.本年利潤
   INITIALIZE g_glap.* TO NULL
   INITIALIZE g_glaq.* TO NULL
   INITIALIZE g_glar.* TO NULL
   #清空临时表
   DELETE FROM p530_tmp 
      
   LET g_glap.glapent = g_enterprise
   LET g_glap.glapcomp = g_glaacomp
   LET g_glap.glapld = g_master.glapld 
   LET g_glap.glap001 = '1'      
   LET g_glap.glap002 = g_master.glap002
   LET g_glap.glap004 = g_master.glap004
   LET g_glap.glapdocno = g_glaa112

   CALL s_get_accdate(g_glaa003,'',g_master.glap002,g_master.glap004)
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'
      RETURN
   END IF         
   LET g_glap.glapdocdt=l_pdate_e
   LET l_success = TRUE
   CALL s_aooi200_fin_gen_docno(g_master.glapld,g_glaa024,g_glaa003,g_glap.glapdocno,g_glap.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
   IF l_success = FALSE THEN 
      LET g_success = 'N'
      RETURN
   END IF       
   LET g_glap.glap007 = 'CE'
   LET g_glap.glap009 = 0
   LET g_glap.glap009 = 0
   LET g_glap.glap013 = 0
   LET g_glap.glap014 = 'N'
   LET g_glap.glapstus = 'Y'
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapownid = g_user
   LET g_glap.glapowndp = g_dept
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdp = g_dept 
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapcnfid = g_user
   LET g_glap.glapcnfdt = cl_get_current() 
   LET ld_date = cl_get_current()       
   #==============单身glaq_t======================
   LET g_glaq.glaqent = g_glap.glapent
   LET g_glaq.glaqld = g_glap.glapld
   LET g_glaq.glaqdocno = g_glap.glapdocno
   LET g_glaq.glaqcomp = g_glap.glapcomp
   LET g_glaq.glaq005 = g_glaa001
   LET g_glaq.glaq006 = 1
   #匯率(本位幣二)
   IF g_glaa015='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa016,0,g_glaa018)
      RETURNING  g_glaq.glaq039
   ELSE
      LET g_glaq.glaq039 = 0  
   END IF
   #匯率(本位幣三)
   IF g_glaa019='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa020,0,g_glaa022)
      RETURNING  g_glaq.glaq042
   ELSE
      LET g_glaq.glaq042 = 0  
   END IF
   #摘要
   LET g_glaq.glaq001=g_glap.glap002 USING '<<<<',cl_getmsg('agl-00274',g_lang),
                      g_glap.glap004 USING '<<<<',cl_getmsg('axc-00589',g_lang)," ",
                      cl_getmsg('agl-00309',g_lang)
   LET g_glaq.glaqseq = 1
   LET l_sql = " SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),",
               "        glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "        glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "        glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
               "   FROM glaq_t,glap_t ",
               "  WHERE glaqent = glapent ",
               "    AND glaqld = glapld ",
               "    AND glaqdocno = glapdocno ",                  
               "    AND glaqent = ",g_enterprise,"",
               "    AND glaqld = '",g_master.glapld,"'" ,                 
               "    AND glaq002 IN (SELECT glaq002 FROM glaq_t,glac_t",
               "                     WHERE glaqent = glacent",
               "                       AND glaq002 = glac002",
               "                       AND glac001 = '",g_glaa004,"'",
               "                       AND glac007 = '6'",
               "                       AND glac008 = '2') ",
               "    AND glap002 = ",g_master.glap002,
               "    AND glap004 BETWEEN ",p_glap004_s," AND ",p_glap004_e,
               "    AND glapstus = 'S'",                  
               "    GROUP BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "             glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "             glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
               "    ORDER BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "             glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "             glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053"
   PREPARE aglp530_glaq_pre2 FROM l_sql
   DECLARE aglp530_glaq_cs2  CURSOR FOR  aglp530_glaq_pre2
   FOREACH aglp530_glaq_cs2 INTO g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044,
                                 g_glaq.glaq002,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,
                                 g_glaq.glaq015,g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,
                                 g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,
                                 g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,
                                 g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                                 g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq051,g_glaq.glaq052,
                                 g_glaq.glaq053
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH aglp530_glaq_cs2'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
         
      #借贷相反
      IF cl_null(g_glaq.glaq003) THEN LET g_glaq.glaq003 = 0  END IF
      IF cl_null(g_glaq.glaq004) THEN LET g_glaq.glaq004 = 0  END IF
      IF cl_null(g_glaq.glaq040) THEN LET g_glaq.glaq040 = 0  END IF
      IF cl_null(g_glaq.glaq041) THEN LET g_glaq.glaq041 = 0  END IF
      IF cl_null(g_glaq.glaq043) THEN LET g_glaq.glaq043 = 0  END IF
      IF cl_null(g_glaq.glaq044) THEN LET g_glaq.glaq044 = 0  END IF
      
      #当该科目借贷都有金额时
      IF g_glaq.glaq003<>0 AND g_glaq.glaq004<>0 THEN
         LET g_glaq.glaq003 = g_glaq.glaq003 - g_glaq.glaq004
         IF g_glaq.glaq003 < 0 THEN
            LET g_glaq.glaq004 = g_glaq.glaq003 * (-1)
            LET g_glaq.glaq003 = 0
         ELSE
            LET g_glaq.glaq004 = 0
         END IF
      END IF
      
      #当该科目金额都为0时不用写入
      IF g_glaq.glaq003=0 AND g_glaq.glaq004=0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_sum1_d = g_glaq.glaq003
      LET g_glaq.glaq003 = g_glaq.glaq004
      LET g_glaq.glaq004 = l_sum1_d
      LET l_sum2_d = g_glaq.glaq040
      LET g_glaq.glaq040 = g_glaq.glaq041
      LET g_glaq.glaq041 = l_sum2_d
      LET l_sum3_d = g_glaq.glaq043
      LET g_glaq.glaq043 = g_glaq.glaq044
      LET g_glaq.glaq044 = l_sum3_d
      LET g_glaq.glaq010 = g_glaq.glaq003 + g_glaq.glaq004
      
      INSERT INTO p530_tmp (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,
                            glaq005,glaq006,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                            glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                            glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,
                            glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,
                            glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,glaq052,glaq053)
      VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
              g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
              g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,g_glaq.glaq016,
              g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
              g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
              g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
              g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,
              g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
              g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053)
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('ins_tmp_3',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins_tmp_3'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      LET g_glaq.glaqseq = g_glaq.glaqseq +1            
   END FOREACH
   #其金額總和另增一筆傳票單身,如果借-贷>0,则产生借方金额，否则反之。科目：本年利润，
   #按照科目设置的固定核算项分别产生传票单身资料
#   LET g_glaq.glaq002 = '2298'    #本年利润
   LET g_glaq.glaq002 = l_glab005  #本年利润
   
   LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),",l_sql1,
             "  FROM p530_tmp ",
             " GROUP BY ",l_sql1," ORDER BY ",l_sql1
   PREPARE aglp530_tmp_pr2 FROM l_sql
   DECLARE aglp530_tmp_cs2 CURSOR FOR aglp530_tmp_pr2
   
   #获取项次
   SELECT MAX(glaqseq)+1 INTO g_glaq.glaqseq FROM p530_tmp
   IF cl_null(g_glaq.glaqseq) OR g_glaq.glaqseq=0 THEN 
      LET g_glaq.glaqseq=1
   END IF
   
   FOREACH aglp530_tmp_cs2 INTO l_sum1_d,l_sum1_c,l_sum2_d,l_sum2_c,l_sum3_d,l_sum3_c,
                                g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,
                                g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,
                                g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053,
                                g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
                                g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,
                                g_glaq.glaq034,g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038
                                
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH aglp530_tmp_cs2'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      LET l_profit2 = 0
      IF cl_null(l_sum1_d) THEN LET l_sum1_d = 0  END IF
      IF cl_null(l_sum1_c) THEN LET l_sum1_c = 0  END IF
      IF cl_null(l_sum2_d) THEN LET l_sum2_d = 0  END IF
      IF cl_null(l_sum2_c) THEN LET l_sum2_c = 0  END IF
      IF cl_null(l_sum3_d) THEN LET l_sum3_d = 0  END IF
      IF cl_null(l_sum3_c) THEN LET l_sum3_c = 0  END IF
      #借 - 贷>0,产生贷方资料，否则产生在借方             
      LET l_profit2 = l_sum1_d - l_sum1_c
      IF l_profit2 <> 0 THEN      
         IF l_profit2 > 0 THEN
            LET g_glaq.glaq004 = l_profit2
            LET g_glaq.glaq003 = 0
            #本位幣二
            IF g_glaa015='Y' THEN
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = l_sum2_d-l_sum2_c
            ELSE
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = 0
            END IF
            #本位幣三
            IF g_glaa019='Y' THEN
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = l_sum3_d-l_sum3_c
            ELSE
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = 0
            END IF
            LET g_glaq.glaq010 = g_glaq.glaq004
         ELSE
            LET l_profit2 = l_profit2 * (-1)
            LET g_glaq.glaq004 = 0
            LET g_glaq.glaq003 = l_profit2 
            #本位幣二
            IF g_glaa015='Y' THEN
               LET g_glaq.glaq040 = (l_sum2_d-l_sum2_c)*-1
               LET g_glaq.glaq041 = 0
            ELSE
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = 0
            END IF
            #本位幣三
            IF g_glaa019='Y' THEN
               LET g_glaq.glaq043 = (l_sum3_d-l_sum3_c)*-1
               LET g_glaq.glaq044 = 0
            ELSE
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = 0
            END IF
            LET g_glaq.glaq010 = g_glaq.glaq003            
         END IF
         #核算項預設值
         CALL aglp530_fix_acc_open(g_glaq.glaqld,g_glaq.glaq002)
         
         INSERT INTO p530_tmp (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,
                               glaq003,glaq004,glaq005,glaq006,glaq010,
                               glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                               glaq023,glaq024,glaq025,glaq027,glaq028,
                               glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,
                               glaq051,glaq052,glaq053,
                               glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,
                               glaq035,glaq036,glaq037,glaq038)
         VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
                 g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
                 g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
                 g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
                 g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
                 g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053,
                 g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
                 g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('ins_tmp_4',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins_tmp_4'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         LET g_glaq.glaqseq=g_glaq.glaqseq+1
      END IF 
   END FOREACH      
   #==============INS_glap_t==========
   SELECT COUNT(*) INTO l_cnt FROM p530_tmp 
    WHERE glaqdocno=g_glaq.glaqdocno
   IF l_cnt>0 THEN
       #借方金额为单身借贷金额之和
       SELECT SUM(glaq003),SUM(glaq004) INTO g_glap.glap010,g_glap.glap011
         FROM p530_tmp 
       #161111-00028#8----modify----begin---------       
       #INSERT INTO glap_t VALUES (g_glap.*)
       INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,glap005,
                             glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,glap016,
                             glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                             glapcnfdt,glappstid,glappstdt,glapstus)
          VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,g_glap.glap005,
                 g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,g_glap.glap015,g_glap.glap016,
                 g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,g_glap.glapmoddt,g_glap.glapcnfid,
                 g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
       #161111-00028#8----modify----end---------
       IF SQLCA.sqlcode THEN
#          CALL cl_errmsg('INS_glap_a2',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'INS_glap_a2'
          LET g_errparam.code = SQLCA.SQLCODE
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET g_success = 'N' 
       END IF 
       UPDATE glap_t SET glapcrtdt = ld_date,
                           glapcnfdt = ld_date
          WHERE glapent = g_enterprise
            AND glapld = g_glap.glapld
            AND glapdocno = g_glap.glapdocno
         IF SQLCA.SQLCODE THEN
#            CALL cl_errmsg('UPD date',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'UPDATE glap_t'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
       #==============INS_glaq_t==========
       LET l_sql = " INSERT INTO glaq_t(glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,
                                        glaq003,glaq004,glaq005,glaq006,glaq010,
                                        glaq011,glaq012,glaq013,glaq014,glaq015,
                                        glaq016,glaq017,glaq018,glaq019,glaq020,
                                        glaq021,glaq022,glaq023,glaq024,glaq025,
                                        glaq027,glaq028,glaq029,glaq030,
                                        glaq031,glaq032,glaq033,glaq034,glaq035,
                                        glaq036,glaq037,glaq038,glaq039,glaq040,
                                        glaq041,glaq042,glaq043,glaq044,
                                        glaq051,glaq052,glaq053) ",
                     " SELECT * FROM p530_tmp "
       PREPARE aglp530_ins_glaq_pre2   FROM l_sql
       EXECUTE aglp530_ins_glaq_pre2
       IF SQLCA.sqlcode THEN
#          CALL cl_errmsg('INS_glaq_a2',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'INS_glaq_a2'
          LET g_errparam.code = SQLCA.SQLCODE
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET g_success = 'N' 
       END IF
       
       #CE傳票的過帳動作
       LET l_success = TRUE
       CALL s_voucher_post_chk(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
       IF l_success = TRUE THEN
          CALL s_voucher_post_upd(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
       END IF
          
       IF l_success = FALSE THEN
          LET g_success = 'N'
       END IF
   ELSE
      LET l_count=l_count+1
   END IF       

   #160628-00036#2 add s---
   ####################### A-3.共用科目 ########################
   #  傳票單別=總帳參數設定檔.結轉用單別
   #  傳票日期=執行年期的當期最末一日
   #  來源類型='CE'的傳票單頭單身資料(glap_t,glaq_t)且傳票狀態='已過帳'
   #  科目編號=當期傳票有共用類科目的傳票憑證單身資料(glaq_t).科目編號(共用科目的判斷=共用类科目)
   #  傳票金額=原當期傳票共用科目的傳票單身金額
   # 上述收入類科目逐一產生對應的傳票單身資料後, 其金額總和另增一筆傳票單身,貸:損益科目 
   
   #清空临时表
   DELETE FROM p530_tmp
   LET l_count = 0
      
   LET l_sql = " SELECT glch003 FROM glch_t ",
               "  WHERE glchent = '",g_enterprise,"' AND glchld = '",g_master.glapld,"'",
               "    AND glch001 = ",g_master.glap002,
               "    AND glch002 = ?",
               "    AND glchstus = 'Y'"
   PREPARE aglp530_glaq_pre5 FROM l_sql
   DECLARE aglp530_glaq_cur5 CURSOR FOR aglp530_glaq_pre5

 

   #=============单头glap_t====================
   LET g_glap.glapent = g_enterprise
   LET g_glap.glapcomp = g_glaacomp
   LET g_glap.glapld = g_master.glapld 
   LET g_glap.glap001 = '1'      
   LET g_glap.glap002 = g_master.glap002
   LET g_glap.glap004 = g_master.glap004
   LET g_glap.glapdocno = g_glaa112
   CALL s_get_accdate(g_glaa003,'',g_master.glap002,g_master.glap004)
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'
      RETURN
   END IF         
   LET g_glap.glapdocdt=l_pdate_e
   LET l_success = TRUE
   CALL s_aooi200_fin_gen_docno(g_master.glapld,g_glaa024,g_glaa003,g_glap.glapdocno,g_glap.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
   IF l_success = FALSE THEN 
      LET g_success = 'N'
      RETURN
   END IF       
   LET g_glap.glap007 = 'CE'
   LET g_glap.glap009 = 0
   LET g_glap.glap009 = 0
   LET g_glap.glap013 = 0
   LET g_glap.glap014 = 'N'
   LET g_glap.glapstus = 'Y'
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapownid = g_user
   LET g_glap.glapowndp = g_dept
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdp = g_dept 
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapcnfid = g_user
   LET g_glap.glapcnfdt = cl_get_current()
   LET ld_date = cl_get_current()
   #==============单身glaq_t======================
   LET g_glaq.glaqent = g_glap.glapent
   LET g_glaq.glaqld = g_glap.glapld
   LET g_glaq.glaqdocno = g_glap.glapdocno
   LET g_glaq.glaqcomp = g_glap.glapcomp
   LET g_glaq.glaq005 = g_glaa001
   LET g_glaq.glaq006 = 1
   #匯率(本位幣二)
   IF g_glaa015='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa016,0,g_glaa018)
      RETURNING  g_glaq.glaq039
   ELSE
      LET g_glaq.glaq039 = 0  
   END IF
   #匯率(本位幣三)
   IF g_glaa019='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa020,0,g_glaa022)
      RETURNING  g_glaq.glaq042
   ELSE
      LET g_glaq.glaq042 = 0  
   END IF
   #摘要
   LET g_glaq.glaq001=g_glap.glap002 USING '<<<<',cl_getmsg('agl-00274',g_lang),
                      g_glap.glap004 USING '<<<<',cl_getmsg('axc-00589',g_lang)," ",
                      cl_getmsg('agl-00309',g_lang)
   LET g_glaq.glaqseq = 1
   
   LET l_sql = " SELECT glac008 FROM glac_t ",
               "  WHERE glacent = '",g_enterprise,"'",
               "    AND glac001 = '",g_glaa004,"'", #会计科目参照表号 
               "    AND glac002 = ? "
   PREPARE aglp530_glac_pre1 FROM l_sql   
   
   LET l_sql = " SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),",
               "        glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "        glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "        glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
               "   FROM glaq_t,glap_t ",
               "  WHERE glaqent = glapent ",
               "    AND glaqld = glapld ",
               "    AND glaqdocno = glapdocno ",                  
               "    AND glaqent = ",g_enterprise,"",
               "    AND glaqld = '",g_master.glapld,"'"  ,                
               "    AND glaq002 IN ( SELECT glch002 FROM glch_t WHERE glchent = '",g_enterprise,"' AND glchld = '",g_master.glapld,"'",
               "                        AND glch001 = ",g_master.glap002,
               "                        AND glchstus = 'Y')",
               "    AND glap002 = ",g_master.glap002,
               "    AND glap004 BETWEEN ",p_glap004_s," AND ",p_glap004_e,
               "    AND glapstus = 'S'", 
               "    GROUP BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "             glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "             glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
               "    ORDER BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
               "             glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
               "             glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "             glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053"
   PREPARE aglp530_glaq_pre3   FROM l_sql
   DECLARE aglp530_glaq_cs3  CURSOR FOR  aglp530_glaq_pre3
   FOREACH aglp530_glaq_cs3 INTO l_sum1_d,l_sum1_c,l_sum2_d,l_sum2_c,l_sum3_d,l_sum3_c,
                                g_glaq.glaq002,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,
                                g_glaq.glaq015,g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,
                                g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,
                                g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,
                                g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                                g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq051,g_glaq.glaq052,
                                g_glaq.glaq053
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('',g_glaq.glaq002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_glaq.glaq002
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      LET l_glch002 = g_glaq.glaq002 
      LET l_n = 0
   

      
       IF cl_null(l_sum1_d) THEN LET l_sum1_d = 0  END IF
       IF cl_null(l_sum1_c) THEN LET l_sum1_c = 0  END IF
       IF cl_null(l_sum2_d) THEN LET l_sum2_d = 0  END IF
       IF cl_null(l_sum2_c) THEN LET l_sum2_c = 0  END IF
       IF cl_null(l_sum3_d) THEN LET l_sum3_d = 0  END IF
       IF cl_null(l_sum3_c) THEN LET l_sum3_c = 0  END IF      
      
       EXECUTE aglp530_glac_pre1 USING l_glch002 INTO l_glac008 
       IF l_glac008 = '1' THEN 
          LET g_glaq.glaq003 = l_sum1_d - l_sum1_c
          LET g_glaq.glaq040 = l_sum2_d - l_sum2_c
          LET g_glaq.glaq043 = l_sum3_d - l_sum3_c
          LET g_glaq.glaq004 = 0
          LET g_glaq.glaq041 = 0
          LET g_glaq.glaq044 = 0
       ELSE
          LET g_glaq.glaq003 = l_sum1_c - l_sum1_d
          LET g_glaq.glaq040 = l_sum2_c - l_sum2_d
          LET g_glaq.glaq043 = l_sum3_c - l_sum3_d
          LET g_glaq.glaq004 = 0
          LET g_glaq.glaq041 = 0
          LET g_glaq.glaq044 = 0       
       END IF
        
      IF l_red = 'N' AND g_glaq.glaq003<0 THEN 
         CALL aglp530_red(g_glaq.glaq010,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044)
            RETURNING g_glaq.glaq010,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044
      END IF
         
      LET g_glaq.glaq010 = g_glaq.glaq003
      #当该科目金额都为0时不用写入
      IF g_glaq.glaq003=0 AND g_glaq.glaq004=0 THEN
         CONTINUE FOREACH
      END IF
      
      
      INSERT INTO p530_tmp (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,
                            glaq005,glaq006,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                            glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
                            glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,
                            glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,
                            glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,glaq052,glaq053)
      VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
              g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
              g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,g_glaq.glaq016,
              g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
              g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
              g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
              g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,
              g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
              g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins_tmp_5'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      LET g_glaq.glaqseq = g_glaq.glaqseq +1   
      LET l_glch002 = g_glaq.glaq002

      ######對應權益類科目#######
      FOREACH aglp530_glaq_cur5 USING l_glch002 INTO l_glch003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'FOREACH aglp530_glaq_cur5'
            LET g_errparam.code = 'agl-00471'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            EXIT FOREACH
         END IF       
      END FOREACH 
      
      LET g_glaq.glaq002 = l_glch003
      
      #获取该科目是否设置核算项
      CALL aglp530_fix_acc_sql(l_glch003) RETURNING l_sql1,l_sql2
      
      LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),",l_sql1,
                "  FROM p530_tmp ",
                " WHERE glaq002 = '",l_glch002,"' ",
                "   AND glaq017 = '",g_glaq.glaq017,"' AND glaq018 = '",g_glaq.glaq018,"'",
                "   AND glaq019 = '",g_glaq.glaq019,"' AND glaq020 = '",g_glaq.glaq020,"'",
                "   AND glaq021 = '",g_glaq.glaq021,"' AND glaq022 = '",g_glaq.glaq022,"'",
                "   AND glaq024 = '",g_glaq.glaq024,"' AND glaq025 = '",g_glaq.glaq025,"'",
                "   AND glaq051 = '",g_glaq.glaq051,"' AND glaq052 = '",g_glaq.glaq052,"'",
                "   AND glaq053 = '",g_glaq.glaq053,"' AND glaq027 = '",g_glaq.glaq027,"'",
                "   AND glaq028 = '",g_glaq.glaq028,"' AND glaq029 = '",g_glaq.glaq029,"'",
                "   AND glaq030 = '",g_glaq.glaq030,"' AND glaq031 = '",g_glaq.glaq031,"'",
                "   AND glaq032 = '",g_glaq.glaq032,"' AND glaq033 = '",g_glaq.glaq033,"'",
                "   AND glaq034 = '",g_glaq.glaq034,"' AND glaq035 = '",g_glaq.glaq035,"'",
                "   AND glaq036 = '",g_glaq.glaq036,"' AND glaq037 = '",g_glaq.glaq037,"'",
                "   AND glaq038 = '",g_glaq.glaq038,"' AND glaq023 = '",g_glaq.glaq023,"'",
                " GROUP BY ",l_sql1," ORDER BY ",l_sql1
      PREPARE aglp530_tmp_pr4 FROM l_sql
      DECLARE aglp530_tmp_cs4 CURSOR FOR aglp530_tmp_pr4
      
      FOREACH aglp530_tmp_cs4 INTO l_sum1_d,l_sum1_c,l_sum2_d,l_sum2_c,l_sum3_d,l_sum3_c,
                                   g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,
                                   g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,
                                   g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053,
                                   g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
                                   g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,
                                   g_glaq.glaq034,g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'FOREACH aglp530_glaq_cs4'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            EXIT FOREACH
         END IF   
   

         LET l_profit2 = 0
         IF cl_null(l_sum1_d) THEN LET l_sum1_d = 0  END IF
         IF cl_null(l_sum1_c) THEN LET l_sum1_c = 0  END IF
         IF cl_null(l_sum2_d) THEN LET l_sum2_d = 0  END IF
         IF cl_null(l_sum2_c) THEN LET l_sum2_c = 0  END IF
         IF cl_null(l_sum3_d) THEN LET l_sum3_d = 0  END IF
         IF cl_null(l_sum3_c) THEN LET l_sum3_c = 0  END IF
         
         EXECUTE aglp530_glac_pre1 USING l_glch002 INTO l_glac008
         
         IF l_glac008 = '1' THEN 
            LET g_glaq.glaq004 =  l_sum1_c - l_sum1_d 
            LET g_glaq.glaq003 = 0
            #本位幣二
            IF g_glaa015='Y' THEN
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 =  l_sum2_c - l_sum2_d 
            ELSE
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = 0
            END IF
            #本位幣三
            IF g_glaa019='Y' THEN
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = l_sum3_c - l_sum3_d
            ELSE
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = 0
            END IF
            LET g_glaq.glaq010 = g_glaq.glaq004
         ELSE
            LET g_glaq.glaq004 = l_sum1_d - l_sum1_c
            LET g_glaq.glaq003 = 0 
            #本位幣二
            IF g_glaa015='Y' THEN
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = l_sum2_d-l_sum2_c 
            ELSE
               LET g_glaq.glaq040 = 0
               LET g_glaq.glaq041 = 0
            END IF
            #本位幣三
            IF g_glaa019='Y' THEN
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = l_sum3_d-l_sum3_c
            ELSE
               LET g_glaq.glaq043 = 0
               LET g_glaq.glaq044 = 0
            END IF
            LET g_glaq.glaq010 = g_glaq.glaq004            
         END IF
                 
          IF l_red = 'N' AND g_glaq.glaq004<0 THEN 
             CALL aglp530_red(g_glaq.glaq010,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044)
                RETURNING g_glaq.glaq010,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044
          END IF         
            
            #当该科目金额都为0时不用写入
            IF g_glaq.glaq003=0 AND g_glaq.glaq004=0 THEN
               CONTINUE FOREACH
            END IF
                  
            #核算項預設值
            CALL aglp530_fix_acc_open(g_glaq.glaqld,g_glaq.glaq002)
            
            INSERT INTO p530_tmp (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,
                                  glaq003,glaq004,glaq005,glaq006,glaq010,
                                  glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                                  glaq023,glaq024,glaq025,glaq027,glaq028,
                                  glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,
                                  glaq051,glaq052,glaq053,
                                  glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,
                                  glaq035,glaq036,glaq037,glaq038)
            VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
                    g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
                    g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
                    g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
                    g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
                    g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053,
                    g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
                    g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins_tmp_6'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N' 
            END IF
            LET g_glaq.glaqseq=g_glaq.glaqseq+1
        
                         
      END FOREACH  
      
   END FOREACH

   #==============INS_glap_t==========
   SELECT COUNT(*) INTO l_cnt FROM p530_tmp 
    WHERE glaqdocno=g_glaq.glaqdocno
   IF l_cnt>0 THEN
       #借方金额为单身借贷金额之和
       SELECT SUM(glaq003),SUM(glaq004) INTO g_glap.glap010,g_glap.glap011
         FROM p530_tmp 
       #161111-00028#8----modify----begin---------       
       #INSERT INTO glap_t VALUES (g_glap.*)
       INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,glap005,
                             glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,glap016,
                             glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                             glapcnfdt,glappstid,glappstdt,glapstus)
          VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,g_glap.glap005,
                 g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,g_glap.glap015,g_glap.glap016,
                 g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,g_glap.glapmoddt,g_glap.glapcnfid,
                 g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
       #161111-00028#8----modify----end---------
       IF SQLCA.sqlcode THEN
#          CALL cl_errmsg('INS_glap_a2',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'INS_glap_a2'
          LET g_errparam.code = SQLCA.SQLCODE
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET g_success = 'N' 
       END IF 
       UPDATE glap_t SET glapcrtdt = ld_date,
                           glapcnfdt = ld_date
          WHERE glapent = g_enterprise
            AND glapld = g_glap.glapld
            AND glapdocno = g_glap.glapdocno
         IF SQLCA.SQLCODE THEN
#            CALL cl_errmsg('UPD date',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'UPDATE glap_t'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
       #==============INS_glaq_t==========
       LET g_glaq.glaqseq = 1
       LET l_sql = " SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044), ",
                   "        glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
                   "        glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
                   "        glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
                   "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
                   "   FROM p530_tmp ",
                   "   GROUP BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
                   "        glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
                   "        glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
                   "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053",
                   "   ORDER BY glaq002,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,glaq017,",
                   "        glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,",
                   "        glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
                   "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053"
       PREPARE aglp530_ins_glaq_pre3   FROM l_sql
       DECLARE aglp530_ins_glaq_cur3 CURSOR FOR aglp530_ins_glaq_pre3       
       FOREACH aglp530_ins_glaq_cur3 INTO g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq043,g_glaq.glaq044,
                                          g_glaq.glaq002,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,g_glaq.glaq016,g_glaq.glaq017, 
                                          g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025, 
                                          g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034, 
                                          g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053 
         IF g_glaq.glaq003 - g_glaq.glaq004 = 0 THEN 
            CONTINUE FOREACH
         END IF         
         INSERT INTO glaq_t(glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,
                            glaq003,glaq004,glaq005,glaq006,glaq010,
                            glaq011,glaq012,glaq013,glaq014,glaq015,
                            glaq016,glaq017,glaq018,glaq019,glaq020,
                            glaq021,glaq022,glaq023,glaq024,glaq025,
                            glaq027,glaq028,glaq029,glaq030,
                            glaq031,glaq032,glaq033,glaq034,glaq035,
                            glaq036,glaq037,glaq038,glaq039,glaq040,
                            glaq041,glaq042,glaq043,glaq044,
                            glaq051,glaq052,glaq053) 
              VALUES(       g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld, g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,
                            g_glaq.glaq003,g_glaq.glaq004, g_glaq.glaq005,g_glaq.glaq006,  g_glaq.glaq010,
                            g_glaq.glaq011,g_glaq.glaq012, g_glaq.glaq013,g_glaq.glaq014,  g_glaq.glaq015,
                            g_glaq.glaq016,g_glaq.glaq017, g_glaq.glaq018,g_glaq.glaq019,  g_glaq.glaq020,
                            g_glaq.glaq021,g_glaq.glaq022, g_glaq.glaq023,g_glaq.glaq024,  g_glaq.glaq025,
                            g_glaq.glaq027,g_glaq.glaq028, g_glaq.glaq029,g_glaq.glaq030,
                            g_glaq.glaq031,g_glaq.glaq032, g_glaq.glaq033,g_glaq.glaq034,  g_glaq.glaq035,
                            g_glaq.glaq036,g_glaq.glaq037, g_glaq.glaq038,g_glaq.glaq039,  g_glaq.glaq040,
                            g_glaq.glaq041,g_glaq.glaq042, g_glaq.glaq043,g_glaq.glaq044,
                            g_glaq.glaq051,g_glaq.glaq052, g_glaq.glaq053)                            
 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'INS_glaq_a3'
             LET g_errparam.code = SQLCA.SQLCODE
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET g_success = 'N' 
          END IF
          LET g_glaq.glaqseq = g_glaq.glaqseq + 1  
       END FOREACH
       #CE傳票的過帳動作
       LET l_success = TRUE
       CALL s_voucher_post_chk(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
       IF l_success = TRUE THEN
          CALL s_voucher_post_upd(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
       END IF
          
       IF l_success = FALSE THEN
          LET g_success = 'N'
       END IF
   ELSE
      LET l_count=l_count+1
   END IF       
   #160628-00036#2 add e---

   #IF l_count=2 THEN  #160628-00036#2
   IF l_count=3 THEN   #160628-00036#2
#      CALL cl_errmsg('','','','agl-00145',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code = 'agl-00145'
      LET g_errparam.popup = TRUE
      CALL cl_err()
#      LET g_success = 'N' #170208-00016#1 mark
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL aglp530_creat_tmp()
# Input parameter:  
# Return code....:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_creat_tmp()
   #建临时表
   DROP TABLE p530_tmp;
   
   CREATE TEMP TABLE p530_tmp (
   glaqent    SMALLINT,
   glaqcomp   VARCHAR(10),
   glaqld     VARCHAR(5),
   glaqdocno  VARCHAR(20),
   glaqseq    INTEGER,
   glaq001    VARCHAR(255),
   glaq002    VARCHAR(24),
   glaq003    DECIMAL(20,6),
   glaq004    DECIMAL(20,6),
   glaq005    VARCHAR(10),
   glaq006    DECIMAL(20,10),
   glaq010    DECIMAL(20,6),
   glaq011    VARCHAR(20),
   glaq012    DATE,
   glaq013    VARCHAR(20),
   glaq014    VARCHAR(30),
   glaq015    VARCHAR(10),
   glaq016    VARCHAR(10),
   glaq017    VARCHAR(10),
   glaq018    VARCHAR(10),
   glaq019    VARCHAR(10),
   glaq020    VARCHAR(10),
   glaq021    VARCHAR(10),
   glaq022    VARCHAR(10),
   glaq023    VARCHAR(10),
   glaq024    VARCHAR(10),
   glaq025    VARCHAR(20),
   glaq027    VARCHAR(20),
   glaq028    VARCHAR(30),
   glaq029    VARCHAR(30),
   glaq030    VARCHAR(30),
   glaq031    VARCHAR(30),
   glaq032    VARCHAR(30),
   glaq033    VARCHAR(30),
   glaq034    VARCHAR(30),
   glaq035    VARCHAR(30),
   glaq036    VARCHAR(30),
   glaq037    VARCHAR(30),
   glaq038    VARCHAR(30),
   glaq039    DECIMAL(20,10),
   glaq040    DECIMAL(20,6),
   glaq041    DECIMAL(20,6),
   glaq042    DECIMAL(20,10),
   glaq043    DECIMAL(20,6),
   glaq044    DECIMAL(20,6),
   glaq051    VARCHAR(10),
   glaq052    VARCHAR(10),
   glaq053    VARCHAR(10))
   
END FUNCTION

################################################################################
# Descriptions...: 产生次期应计调整传票
# Memo...........:
# Usage..........: CALL aglp530_ra_gen()
# Input parameter:   
# Return code....: 
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_ra_gen()

   DEFINE l_sum         LIKE glaq_t.glaq003
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_glapdocno   LIKE glap_t.glapdocno
   DEFINE ld_date       DATETIME YEAR TO SECOND
   DEFINE l_slip        LIKE ooba_t.ooba002
   DEFINE l_red         LIKE type_t.chr80
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_errno       LIKE type_t.chr100
   DEFINE l_glav002     LIKE glav_t.glav002
   DEFINE l_glav005     LIKE glav_t.glav005
   DEFINE l_sdate_s     LIKE glav_t.glav004
   DEFINE l_sdate_e     LIKE glav_t.glav004
   DEFINE l_glav006     LIKE glav_t.glav006
   DEFINE l_pdate_s     LIKE glav_t.glav004
   DEFINE l_pdate_e     LIKE glav_t.glav004
   DEFINE l_glav007     LIKE glav_t.glav007
   DEFINE l_wdate_s     LIKE glav_t.glav004
   DEFINE l_wdate_e     LIKE glav_t.glav004
   DEFINE l_cnt         LIKE type_t.num5   #170208-00016#1 add
   
#A.先將次期已產生過的'RA'傳票刪除(已經過帳的需先過帳還原後再進行刪除動作),再重新產生次期'RA'傳票)
#    每張當期應計傳票(AC)同步產生一張次期且傳票狀態='已過帳'的RA傳票
#    
#    傳票單別=總帳參數設定檔.應計調整用單別  
#    傳票日期=執行年期的次期起始日(執行年期:2013/06,則RA傳票日=2013/07/01)
#    來源類型='RA'
#    科目編號=同AC傳票單身
#    傳票金額=同AC傳票單身但借貸相反
#    若總帳單據別參數.紅字傳票否='Y',則產生的RA傳票借貸按原AC傳票,僅借貸金額均為原金額*(-1),即依參數設定決定是否產生負數傳票
#    IF 紅字傳票否='Y' THEN
#       LET 借方金额 = 借方金额 * -1
#       LET 贷方金额 = 贷方金额 * -1
#    ELSE
#       傳票金額=同AC傳票單身但借貸相反
#    END IF 
#  B.累計當期科目期餘額檔資料(即步驟A.RA傳票的過帳動作)
#       
#→更新指定帳別的帳別基本資料檔(glaa_t).現行會計期別(累加一期)

     INITIALIZE g_glap.* TO NULL
     INITIALIZE g_glaq.* TO NULL
     INITIALIZE g_glar.* TO NULL
     
     #161111-00028#8----modify----begin---------
     #LET l_sql = " SELECT * FROM glap_t ",
     LET l_sql = " SELECT glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,",
                 "glap005,glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,",
                 "glap016,glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,",
                 "glapcnfid,glapcnfdt,glappstid,glappstdt,glapstus FROM glap_t ",
     #161111-00028#8----modify----end---------
                 "  WHERE glapent = '",g_enterprise,"'",
                 "    AND glapld = '",g_master.glapld,"'",
                 "    AND glap002 = '",g_master.glap002,"'",
                 "    AND glap004 = '",g_master.glap004,"'",
                 "    AND glap007 = 'AC'",
                 "    AND glapstus = 'S'", 
                 "  ORDER BY glapdocdt  " 
     PREPARE aglp530_ac_glap_pre  FROM l_sql
     IF SQLCA.SQLCODE THEN
#        CALL cl_errmsg('l_sql','ra_gen_glap','',SQLCA.SQLCODE,1) 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = 'ra_gen_glap'
        LET g_errparam.code = SQLCA.SQLCODE
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_success = 'N'
     END IF 
     DECLARE aglp530_ac_glap_cs CURSOR FOR aglp530_ac_glap_pre
     
     #161111-00028#8----modify----begin---------
     #LET l_sql = " SELECT * FROM glaq_t ",
     LET l_sql = " SELECT glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,",
                 "glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,",
                 "glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,glaq026,glaq027,",
                 "glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,",
                 "glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,glaq052,glaq053 FROM glaq_t ",
     #161111-00028#8----modify----end---------
                 "  WHERE glaqent = '",g_enterprise,"'",
                 "    AND glaqld = '",g_master.glapld,"'",
                 "    AND glaqdocno =? ",
                 " ORDER BY glaqdocno,glaqseq "
     PREPARE aglp530_ac_glaq_pre  FROM l_sql
     IF SQLCA.SQLCODE THEN
#        CALL cl_errmsg('l_sql','ra_gen_glaq','',SQLCA.SQLCODE,1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = 'ra_gen_glaq'
        LET g_errparam.code = SQLCA.SQLCODE
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_success = 'N'
     END IF 
     DECLARE aglp530_ac_glaq_cs CURSOR FOR aglp530_ac_glaq_pre 
     #获取下一期别第一天
     #160201-00015#2--s
     IF g_master.glap004 = g_max_period THEN
        CALL s_get_accdate(g_glaa003,'',g_master.glap002+1,1)
        RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                  l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
     ELSE
     #160201-00015#2--e      
        CALL s_get_accdate(g_glaa003,'',g_master.glap002,g_master.glap004+1)
        RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                  l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
     END IF   #160201-00015#2                  
     IF l_flag='N' THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = l_errno
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET g_success = 'N'
        RETURN
     END IF 
     
     FOREACH aglp530_ac_glap_cs INTO g_glap.*
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('FOREACH',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'FOREACH aglp530_ac_glap_cs'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'
           EXIT FOREACH
        END IF 
        LET l_glapdocno = g_glap.glapdocno
        LET g_glap.glapdocno = g_glaa111
#        LET g_glap.glapdocdt = MDY(g_master.glap004+1,1,g_master.glap002)
        LET g_glap.glapdocdt = l_pdate_s
        LET l_success = TRUE
        CALL s_aooi200_fin_gen_docno(g_glap.glapld,g_glaa024,g_glaa003,g_glap.glapdocno,g_glap.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
        IF l_success = FALSE THEN
           LET g_success = 'N'
           RETURN
        END IF
        LET g_glap.glap001='1'
        #160201-00015#2--s
        IF g_master.glap004 = g_max_period THEN
           LET g_glap.glap002 = g_master.glap002+1        
           LET g_glap.glap004 = 1
        ELSE
        #160201-00015#2--e            
           LET g_glap.glap004 = g_master.glap004+1        
        END IF                  #160201-00015#2
        LET g_glap.glap012= 0   #160201-00015#2           
        LET g_glap.glap007='RA'
#170214-00033#1--mark--str--        
#        #170208-00016#1--add--str--
#        #当凭证中的存在启用细项立冲的科目，凭证状态给N未审核，反之，凭证状态给Y已审核
#        LET l_cnt = 0
#        SELECT COUNT(1) INTO l_cnt FROM glaq_t
#         WHERE glaqent=g_enterprise AND glaqld=g_glap.glapld
#           AND glaqdocno=l_glapdocno
#           AND glaq002 IN (SELECT glad001 FROM glad_t
#                            WHERE gladent=g_enterprise AND gladld=g_glap.glapld
#                              AND glad003='Y' AND gladstus='Y')
#        IF l_cnt > 0 THEN
#           LET g_glap.glapstus = 'N'
#        ELSE
#        #170208-00016#1--add--end
#170214-00033#1--mark--end
           LET g_glap.glapstus = 'Y'
#        END IF #170208-00016#1 add #170214-00033#1 mark
        LET g_glap.glapcrtid = g_user
        LET g_glap.glapcrtdt = cl_get_current()
        LET g_glap.glapownid = g_user
        LET g_glap.glapowndp = g_dept
        LET g_glap.glapcrtid = g_user
        LET g_glap.glapcrtdp = g_dept 
        LET g_glap.glapcrtdt = cl_get_current()
        LET g_glap.glapcnfid = g_user
        LET g_glap.glapcnfdt = cl_get_current()
        LET ld_date = cl_get_current()
        #INS_glap_t==========
        #161111-00028#8----modify----begin---------
        #INSERT INTO glap_t VALUES(g_glap.*)
        INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,glap005,
                            glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,glap016,
                            glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                            glapcnfdt,glappstid,glappstdt,glapstus)
         VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,g_glap.glap005,
                g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,g_glap.glap015,g_glap.glap016,
                g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,g_glap.glapmoddt,g_glap.glapcnfid,
                g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
        #161111-00028#8----modify----end---------
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('RA_gen_glap','g_glap.glapdocno','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'INSERT glap_t'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'
        END IF 
        UPDATE glap_t SET glapcrtdt = ld_date,
                          glapcnfdt = ld_date
         WHERE glapent = g_enterprise
           AND glapld = g_glap.glapld
           AND glapdocno = g_glap.glapdocno
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('UPD date',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'UPDATE glap_t'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N' 
        END IF 
        OPEN aglp530_ac_glaq_cs USING l_glapdocno
        FOREACH aglp530_ac_glaq_cs INTO g_glaq.*
           IF SQLCA.SQLCODE THEN
#              CALL cl_errmsg('RA_gen_glaq','g_glap.glapdocno','',SQLCA.SQLCODE,1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'FOREACH aglp530_ac_glaq_cs'
              LET g_errparam.code = SQLCA.SQLCODE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = 'N'
           END IF
           #傳票金額=同AC傳票單身但借貸相反
           #若總帳單據別參數.紅字傳票否='Y',則產生的RA傳票借貸按原AC傳票,僅借貸金額均為原金額*(-1),即依參數設定決定是否產生負數傳票
           #IF 紅字傳票否='Y' THEN
           #   LET 借方金额 = 借方金额 * -1
           #   LET 贷方金额 = 贷方金额 * -1
           #ELSE
           #   傳票金額=同AC傳票單身但借貸相反  
           #END IF
           LET g_glaq.glaqdocno = g_glap.glapdocno
           IF cl_null(g_glaq.glaq003) THEN LET g_glaq.glaq003 = 0  END IF
           IF cl_null(g_glaq.glaq004) THEN LET g_glaq.glaq004 = 0  END IF
           IF cl_null(g_glaq.glaq040) THEN LET g_glaq.glaq040 = 0  END IF
           IF cl_null(g_glaq.glaq041) THEN LET g_glaq.glaq041 = 0  END IF
           IF cl_null(g_glaq.glaq043) THEN LET g_glaq.glaq043 = 0  END IF
           IF cl_null(g_glaq.glaq044) THEN LET g_glaq.glaq044 = 0  END IF
           #獲取單據別
           CALL s_aooi200_fin_get_slip(g_glap.glapdocno) RETURNING l_success,l_slip
           IF l_success = FALSE THEN
              LET g_success = 'N'
              RETURN
           END IF 
           #獲取單據別對應參數：紅字傳票否
           CALL s_fin_get_doc_para(g_glap.glapld,g_glaacomp,l_slip,'D-FIN-1002') RETURNING l_red
           IF l_red = 'Y' THEN
              LET g_glaq.glaq003 = g_glaq.glaq003 * (-1)
              LET g_glaq.glaq004 = g_glaq.glaq004 * (-1)
              LET g_glaq.glaq040 = g_glaq.glaq040 * (-1)
              LET g_glaq.glaq041 = g_glaq.glaq041 * (-1)
              LET g_glaq.glaq043 = g_glaq.glaq043 * (-1)
              LET g_glaq.glaq044 = g_glaq.glaq044 * (-1)
           ELSE
              LET l_sum = g_glaq.glaq003
              LET g_glaq.glaq003 = g_glaq.glaq004
              LET g_glaq.glaq004 = l_sum
              LET l_sum = g_glaq.glaq040
              LET g_glaq.glaq040 = g_glaq.glaq041
              LET g_glaq.glaq041 = l_sum
              LET l_sum = g_glaq.glaq043
              LET g_glaq.glaq043 = g_glaq.glaq044
              LET g_glaq.glaq044 = l_sum
           END IF 
           #INS_glaq_t==================
           #161111-00028#8----modify----begin---------
           #INSERT INTO glaq_t VALUES(g_glaq.*)
           INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,
                               glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                               glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,
                               glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                               glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,
                               glaq052,glaq053)
            VALUES(g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,
                   g_glaq.glaq006,g_glaq.glaq007,g_glaq.glaq008,g_glaq.glaq009,g_glaq.glaq010,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,
                   g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,
                   g_glaq.glaq026,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                   g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,g_glaq.glaq051,
                   g_glaq.glaq052,g_glaq.glaq053)
           #161111-00028#8----modify----end---------
           IF SQLCA.SQLCODE THEN
#              CALL cl_errmsg('RA_gen_glaq','g_glap.glapdocno','',SQLCA.SQLCODE,1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'INSERT glaq_t'
              LET g_errparam.code = SQLCA.SQLCODE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = 'N'
           END IF 
       END FOREACH
#       #当凭证状态是已审核时，才可以过正
#       IF g_glap.glapstus = 'Y' THEN #170208-00016#1 add #170214-00033#1 mark
       #RA传票过账
       LET l_success = TRUE
       CALL s_voucher_post_chk(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
       IF l_success = TRUE THEN
          CALL s_voucher_post_upd(g_glap.glapld,g_glap.glapdocno) RETURNING l_success 
       END IF 
       IF l_success = FALSE THEN
          LET g_success = 'N'
       END IF 
#       END IF #170208-00016#1 add #170214-00033#1 mark
    END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 判断是否已经做月结
# Memo...........:
# Usage..........: CALL aglp530_chk()
# Input parameter:  
# Return code....:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_chk()
#判断是否已经做月结
#如果已经产生CE累的凭证则需先过账还原再删除
#如果已经产生RA累的凭证则需先过账还原再删除
  DEFINE l_sql             STRING 
  DEFINE l_glapdocno       LIKE glap_t.glapdocno
  DEFINE l_glapstus        LIKE glap_t.glapstus
  DEFINE l_next            LIKE glap_t.glap004
  DEFINE l_success         LIKE type_t.num5
  DEFINE l_glapdocdt       LIKE glap_t.glapdocdt  #151222-00008#1 add
  DEFINE l_scom0002        LIKE type_t.chr10      #161227-00016#1 add 
  
  LET l_success = TRUE
  
  CALL cl_get_para(g_enterprise,g_glaacomp,'S-COM-0002') RETURNING l_scom0002  #161227-00016#1 add
  
  LET g_prog="aglt310"  #151222-00008#1 add 用于更新单别最大流水号
  #查询CE类的传票
  LET l_sql = " SELECT glapdocno,glapstus,glapdocdt ",   #151222-00008#1 add 'glapdocdt'
              " FROM glap_t ", 
              " WHERE glapent = '",g_enterprise,"'",
              "   AND glapld = '",g_master.glapld,"'",
              "   AND glap002 = ",g_master.glap002,"",
              "   AND glap004 = ",g_master.glap004,"",
              "   AND glap007 = 'CE'",
              "   AND glapstus <> 'X'", #170104-00009#9 add 
              " ORDER BY glapdocno DESC"    #151222-00008#1 add
  PREPARE aglp530_chk_pr  FROM l_sql
  DECLARE aglp530_chk_cs  CURSOR FOR aglp530_chk_pr
  FOREACH aglp530_chk_cs INTO l_glapdocno,l_glapstus,l_glapdocdt #151222-00008#1 add 'l_glapdocdt'
     IF SQLCA.SQLCODE THEN
#        CALL cl_errmsg('FOREACH',l_glapdocno,'',SQLCA.SQLCODE,1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = 'FOREACH aglp530_chk_cs'
        LET g_errparam.code = SQLCA.SQLCODE
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_success = 'N'
        EXIT FOREACH
     END IF
#     IF NOT cl_null(l_glapstus) THEN  #151222-00008#1 mark
     IF l_glapstus = 'S' THEN
        LET l_success = TRUE
        CALL s_voucher_unpost_chk(g_master.glapld,l_glapdocno) RETURNING l_success
        IF l_success = TRUE THEN
           CALL s_voucher_unpost_upd(g_master.glapld,l_glapdocno) RETURNING l_success
        END IF
        IF l_success = FALSE THEN
           LET g_success = 'N'  
        END IF 
     END IF 
     
     IF l_scom0002 = 'N' THEN  #161227-00016#1 add
        #删除单身
        DELETE FROM glaq_t WHERE glaqent = g_enterprise
                             AND glaqld = g_master.glapld
                             AND glaqdocno = l_glapdocno
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('DEL_glap',l_glapdocno,'',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'DEL_glaq'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'
        END IF 
        #删除单头
        DELETE FROM glap_t WHERE glapent = g_enterprise
                             AND glapld = g_master.glapld
                             AND glapdocno = l_glapdocno
                             AND glap002 = g_master.glap002
                             AND glap004 = g_master.glap004
                             AND glap007 = 'CE'
        IF SQLCA.SQLCODE THEN
#           CALL cl_errmsg('DEL_glaq',l_glapdocno,'',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'DEL_glap'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'
        END IF
       ##170104-00011#1 add s---
       #更新单别最大流水号
       CALL s_aooi200_fin_del_docno(g_master.glapld,l_glapdocno,l_glapdocdt) RETURNING l_success
       IF l_success = FALSE THEN
          LET g_success = 'N'
       END IF   
       ##170104-00011#1 add e--
       
     #161227-00016#1 add s--- 
     ELSE 
##170104-00011#1 mark s---     
#        UPDATE glaq_t SET glaqstus = 'X' 
#                    WHERE glaqent = g_enterprise
#                      AND glaqld = g_master.glapld
#                      AND glaqdocno = l_glapdocno  
##170104-00011#1 mark e---
#170104-00011#1 add s---
        UPDATE glap_t SET glapstus = 'X' 
                      WHERE glapent = g_enterprise 
                        AND glapld = g_master.glapld
                        AND glapdocno = l_glapdocno
                        AND glap002 = g_master.glap002
                        AND glap004 = g_master.glap004
                        AND glap007 = 'CE'
#170104-00011#1 add e---
        IF SQLCA.SQLCODE THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = 'UPDATE glap_t',l_glapdocno
           LET g_errparam.code   = SQLCA.SQLCODE
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET g_success = 'N' 
        END IF  
     END IF     
     #161227-00016#1 add e---
#170104-00011#1 mod s---     
#     #151222-00008#1--add--str--
#     #更新单别最大流水号
#     CALL s_aooi200_fin_del_docno(g_master.glapld,l_glapdocno,l_glapdocdt) RETURNING l_success
#     IF l_success = FALSE THEN
#        LET g_success = 'N'
#     END IF
#     #151222-00008#1--add--end     
#170104-00011#1 mod e---

#     END IF  #151222-00008#1 mark
  END FOREACH
  #160201-00015#3--s
  IF g_master.glap004 = g_max_period then
     LET l_sql = " SELECT glapdocno,glapstus,glapdocdt FROM glap_t ",
                 "  WHERE glapld = '",g_master.glapld,"'",
                 "    AND glap002 = ",g_master.glap002+1,"",
                 "    AND glapent = ",g_enterprise, #170214-00033#1 add
                 "    AND glap004 = 1 ",
                 "    AND glap007 = 'RA'",
                 "  ORDER BY glapdocno,glapdocdt "
  ELSE
  #160201-00015#3--e    
     LET l_next = g_master.glap004+1
     #查询RA类的传票，如果已经存在并且已经过账，则需先过账还原在删除
     LET l_sql = " SELECT glapdocno,glapstus,glapdocdt FROM glap_t ", #151222-00008#1 add 'glapdocdt'
                 "  WHERE glapld = '",g_master.glapld,"'",
                 "    AND glap002 = ",g_master.glap002,"",
                 "    AND glapent = ",g_enterprise, #170214-00033#1 add
                 "    AND glap004 = ",l_next,"",
                 "    AND glap007 = 'RA'",
   #              "    AND glapstus = 'S'",        #151222-00008#1 mark
                 "  ORDER BY glapdocno,glapdocdt DESC " #151222-00008#1 add 'glapdocno'
  END IF   #160201-00015#3                 
  PREPARE p530_ra_chk_pre   FROM l_sql
  DECLARE p530_ra_chk_cs CURSOR FOR p530_ra_chk_pre
  FOREACH p530_ra_chk_cs INTO l_glapdocno,l_glapstus,l_glapdocdt #151222-00008#1 add 'l_glapstus,l_glapdocdt'
     IF SQLCA.SQLCODE THEN
#        CALL cl_errmsg('FOREACH',l_glapdocno,'',SQLCA.SQLCODE,1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = 'FOREACH p530_ra_chk_cs'
        LET g_errparam.code = SQLCA.SQLCODE
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_success = 'N'
        EXIT FOREACH
     END IF
     IF l_glapstus = 'S' THEN  #151222-00008#1 add
        CALL s_voucher_unpost_chk(g_master.glapld,l_glapdocno) RETURNING l_success
        IF l_success = TRUE THEN
           CALL s_voucher_unpost_upd(g_master.glapld,l_glapdocno) RETURNING l_success
        END IF
        IF l_success = FALSE THEN
           LET g_success = 'N'
        END IF 
     #151222-00008#1--add--str--
     END IF
     IF l_scom0002 = 'N' THEN  #161227-00016#1 add
        #删除单身
        DELETE FROM glaq_t WHERE glaqent = g_enterprise
                             AND glaqld = g_master.glapld
                             AND glaqdocno = l_glapdocno
        IF SQLCA.SQLCODE THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'DEL_glaq'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'
        END IF 
        #删除单头
        DELETE FROM glap_t WHERE glapent = g_enterprise
                             AND glapld = g_master.glapld
                             AND glapdocno = l_glapdocno
        IF SQLCA.SQLCODE THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'DEL_glap'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N'
        END IF
        ##170104-00011#1 add s---     
        #更新单别最大流水号
        CALL s_aooi200_fin_del_docno(g_master.glapld,l_glapdocno,l_glapdocdt) RETURNING l_success
        IF l_success = FALSE THEN
           LET g_success = 'N'
        END IF
        ##170104-00011#1 add e---        
     #161227-00016#1 add s---
     ELSE
##170104-00011#1 mod s---     
#        UPDATE glaq_t SET glaqstus = 'X' 
#                    WHERE glaqent = g_enterprise
#                      AND glaqld = g_master.glapld
#                      AND glaqdocno = l_glapdocno
##170104-00011#1 mod e---
#170104-00011#1 add s---
        UPDATE glap_t SET glapstus = 'X'
                    WHERE glapent = g_enterprise
                      AND glapld = g_master.glapld
                      AND glapdocno = l_glapdocno
#170104-00011#1 add e---                      
        IF SQLCA.SQLCODE THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = 'UPDATE glap_t',l_glapdocno
           LET g_errparam.code   = SQLCA.SQLCODE
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET g_success = 'N' 
        END IF       
     END IF
##170104-00011#1 mod s---       
#     #161227-00016#1 add e---     
#     #更新单别最大流水号
#     CALL s_aooi200_fin_del_docno(g_master.glapld,l_glapdocno,l_glapdocdt) RETURNING l_success
#     IF l_success = FALSE THEN
#        LET g_success = 'N'
#     END IF
#     #151222-00008#1--add--end
##170104-00011#1 mod e---  
  END FOREACH
#151222-00008#1--mark--str-- 
#  DELETE FROM glaq_t WHERE glaqent = g_enterprise
#                       AND glaqld = g_master.glapld
#                       AND glaqdocno IN (SELECT glapdocno FROM glap_t 
#                                          WHERE glapent = g_enterprise
#                                            AND glapld = g_master.glapld
#                                            AND glap002 = g_master.glap002
#                                            AND glap004 = l_next
#                                            AND glap007 = 'RA')
#  IF SQLCA.SQLCODE THEN
##     CALL cl_errmsg('DEL_glaq',l_glapdocno,'',SQLCA.SQLCODE,1)
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.extend = 'DEL_glaq'
#     LET g_errparam.code = SQLCA.SQLCODE
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#     LET g_success = 'N'
#  END IF
#  
#  DELETE FROM glap_t WHERE glapent = g_enterprise
#                       AND glapld = g_master.glapld
#                       AND glap002 = g_master.glap002
#                       AND glap004 = l_next
#                       AND glap007 = 'RA'
#  IF SQLCA.SQLCODE THEN
##     CALL cl_errmsg('DEL_glaq',l_glapdocno,'',SQLCA.SQLCODE,1)
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.extend = 'DEL_glap'
#     LET g_errparam.code = SQLCA.SQLCODE
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#     LET g_success = 'N'
#  END IF 
#151222-00008#1--mark--end
   LET g_prog="aglp530"  #151222-00008#1 add 用于更新单别最大流水号
END FUNCTION

################################################################################
# Descriptions...: 結轉細項立沖帳資料
# Memo...........:
# Usage..........: CALL aglp530_glaz()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/02/11 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_glaz()
 #161111-00028#8----modify----begin---------   
  #DEFINE l_glaz          RECORD LIKE glaz_t.*
  #DEFINE l_glax          RECORD LIKE glax_t.*
  DEFINE l_glaz RECORD  #傳票細項立沖各期餘額檔
       glazent LIKE glaz_t.glazent, #企業編號
       glazld LIKE glaz_t.glazld, #帳套
       glazcomp LIKE glaz_t.glazcomp, #法人
       glazdocno LIKE glaz_t.glazdocno, #單號
       glazseq LIKE glaz_t.glazseq, #項次
       glazdocdt LIKE glaz_t.glazdocdt, #單據日期
       glaz001 LIKE glaz_t.glaz001, #年度
       glaz002 LIKE glaz_t.glaz002, #期別
       glaz003 LIKE glaz_t.glaz003, #會計科目
       glaz004 LIKE glaz_t.glaz004, #本幣立帳金額(當期期初金額)
       glaz005 LIKE glaz_t.glaz005, #本幣已沖金額(當期已沖金額)
       glaz006 LIKE glaz_t.glaz006, #計價單位
       glaz007 LIKE glaz_t.glaz007, #立帳數量(當期期初數量)
       glaz008 LIKE glaz_t.glaz008, #已沖數量(當期已沖數量)
       glaz009 LIKE glaz_t.glaz009, #交易幣別
       glaz010 LIKE glaz_t.glaz010, #原幣立帳金額(當期期初金額)
       glaz011 LIKE glaz_t.glaz011, #原幣已沖金額(當期已沖金額)
       glaz012 LIKE glaz_t.glaz012, #營運據點
       glaz013 LIKE glaz_t.glaz013, #部門
       glaz014 LIKE glaz_t.glaz014, #利潤/成本中心
       glaz015 LIKE glaz_t.glaz015, #區域
       glaz016 LIKE glaz_t.glaz016, #收付款客商
       glaz017 LIKE glaz_t.glaz017, #帳款客商
       glaz018 LIKE glaz_t.glaz018, #客群
       glaz019 LIKE glaz_t.glaz019, #產品類別
       glaz020 LIKE glaz_t.glaz020, #人員
       glaz021 LIKE glaz_t.glaz021, #no use
       glaz022 LIKE glaz_t.glaz022, #專案編號
       glaz023 LIKE glaz_t.glaz023, #WBS
       glaz024 LIKE glaz_t.glaz024, #自由核算項一
       glaz025 LIKE glaz_t.glaz025, #自由核算項二
       glaz026 LIKE glaz_t.glaz026, #自由核算項三
       glaz027 LIKE glaz_t.glaz027, #自由核算項四
       glaz028 LIKE glaz_t.glaz028, #自由核算項五
       glaz029 LIKE glaz_t.glaz029, #自由核算項六
       glaz030 LIKE glaz_t.glaz030, #自由核算項七
       glaz031 LIKE glaz_t.glaz031, #自由核算項八
       glaz032 LIKE glaz_t.glaz032, #自由核算項九
       glaz033 LIKE glaz_t.glaz033, #自由核算項十
       glaz034 LIKE glaz_t.glaz034, #立帳金額(本位幣二當期期初金額
       glaz035 LIKE glaz_t.glaz035, #已沖金額(本位幣二當期已沖金額)
       glaz036 LIKE glaz_t.glaz036, #立帳金額(本位幣三當期期初金額)
       glaz037 LIKE glaz_t.glaz037, #已沖金額(本位幣三當期已沖金額)
       glaz061 LIKE glaz_t.glaz061, #經營方式
       glaz062 LIKE glaz_t.glaz062, #渠道
       glaz063 LIKE glaz_t.glaz063  #品牌
       END RECORD
   DEFINE l_glax RECORD  #傳票項次立帳異動檔
       glaxent LIKE glax_t.glaxent, #企業編號
       glaxownid LIKE glax_t.glaxownid, #資料所有者
       glaxowndp LIKE glax_t.glaxowndp, #資料所屬部門
       glaxcrtid LIKE glax_t.glaxcrtid, #資料建立者
       glaxcrtdp LIKE glax_t.glaxcrtdp, #資料建立部門
       glaxcrtdt LIKE glax_t.glaxcrtdt, #資料創建日
       glaxmodid LIKE glax_t.glaxmodid, #資料修改者
       glaxmoddt LIKE glax_t.glaxmoddt, #最近修改日
       glaxcnfid LIKE glax_t.glaxcnfid, #資料確認者
       glaxcnfdt LIKE glax_t.glaxcnfdt, #資料確認日
       glaxstus LIKE glax_t.glaxstus, #狀態碼
       glaxld LIKE glax_t.glaxld, #帳套
       glaxcomp LIKE glax_t.glaxcomp, #法人
       glaxdocno LIKE glax_t.glaxdocno, #單號
       glaxseq LIKE glax_t.glaxseq, #項次
       glaxdocdt LIKE glax_t.glaxdocdt, #單據日期
       glax001 LIKE glax_t.glax001, #摘要
       glax002 LIKE glax_t.glax002, #科目編號
       glax003 LIKE glax_t.glax003, #本幣立帳金額
       glax005 LIKE glax_t.glax005, #交易幣別
       glax006 LIKE glax_t.glax006, #匯率
       glax007 LIKE glax_t.glax007, #計價單位
       glax008 LIKE glax_t.glax008, #立帳數量
       glax009 LIKE glax_t.glax009, #單價
       glax010 LIKE glax_t.glax010, #原幣立帳金額
       glax011 LIKE glax_t.glax011, #票據號碼
       glax012 LIKE glax_t.glax012, #票據日期
       glax013 LIKE glax_t.glax013, #申請人
       glax014 LIKE glax_t.glax014, #銀行帳號
       glax015 LIKE glax_t.glax015, #結算方式
       glax016 LIKE glax_t.glax016, #收支專案
       glax017 LIKE glax_t.glax017, #營運據點
       glax018 LIKE glax_t.glax018, #部門
       glax019 LIKE glax_t.glax019, #利潤/成本中心
       glax020 LIKE glax_t.glax020, #區域
       glax021 LIKE glax_t.glax021, #收付款客商
       glax022 LIKE glax_t.glax022, #帳款客商
       glax023 LIKE glax_t.glax023, #客群
       glax024 LIKE glax_t.glax024, #產品類別
       glax025 LIKE glax_t.glax025, #人員
       glax026 LIKE glax_t.glax026, #no use
       glax027 LIKE glax_t.glax027, #專案編號
       glax028 LIKE glax_t.glax028, #WBS
       glax029 LIKE glax_t.glax029, #自由核算項一
       glax030 LIKE glax_t.glax030, #自由核算項二
       glax031 LIKE glax_t.glax031, #自由核算項三
       glax032 LIKE glax_t.glax032, #自由核算項四
       glax033 LIKE glax_t.glax033, #自由核算項五
       glax034 LIKE glax_t.glax034, #自由核算項六
       glax035 LIKE glax_t.glax035, #自由核算項七
       glax036 LIKE glax_t.glax036, #自由核算項八
       glax037 LIKE glax_t.glax037, #自由核算項九
       glax038 LIKE glax_t.glax038, #自由核算項十
       glax041 LIKE glax_t.glax041, #本幣預沖金額
       glax042 LIKE glax_t.glax042, #本幣已沖金額
       glax043 LIKE glax_t.glax043, #預沖數量
       glax044 LIKE glax_t.glax044, #已沖數量
       glax045 LIKE glax_t.glax045, #原幣預沖金額
       glax046 LIKE glax_t.glax046, #原幣已沖金額
       glax047 LIKE glax_t.glax047, #資料來源
       glax048 LIKE glax_t.glax048, #原始憑證號碼
       glax049 LIKE glax_t.glax049, #會計年度
       glax050 LIKE glax_t.glax050, #會計期別
       glax051 LIKE glax_t.glax051, #匯率(本位幣二)
       glax052 LIKE glax_t.glax052, #立帳金額(本位幣二)
       glax053 LIKE glax_t.glax053, #預沖金額(本位幣二)
       glax054 LIKE glax_t.glax054, #已沖金額(本位幣二)
       glax055 LIKE glax_t.glax055, #匯率(本位幣三)
       glax056 LIKE glax_t.glax056, #立帳金額(本位幣三)
       glax057 LIKE glax_t.glax057, #預沖金額(本位幣三)
       glax058 LIKE glax_t.glax058, #已沖金額(本位幣三)
       glax061 LIKE glax_t.glax061, #經營方式
       glax062 LIKE glax_t.glax062, #渠道
       glax063 LIKE glax_t.glax063  #品牌
       END RECORD

 #161111-00028#8----modify----end---------
   DEFINE l_sql           STRING
   DEFINE l_yy            LIKE glap_t.glap002
   DEFINE l_mm            LIKE glap_t.glap004
   DEFINE l_glay003_s     LIKE glay_t.glay003
   DEFINE l_glay008_s     LIKE glay_t.glay008
   DEFINE l_glay010_s     LIKE glay_t.glay010
   DEFINE l_glay052_s     LIKE glay_t.glay052
   DEFINE l_glay054_s     LIKE glay_t.glay054
   
   #刪除當期期末結轉資料
   DELETE FROM glaz_t
   WHERE glazent=g_enterprise AND glazld=g_master.glapld
     AND glaz001=g_master.glap002    AND glaz002=g_master.glap004
   
   #上一年度期別
   IF g_master.glap004=1 THEN
      LET l_yy=g_master.glap002-1
      LET l_mm=12
   ELSE
      LET l_yy=g_master.glap002
      LET l_mm=g_master.glap004-1
   END IF
   
   LET l_sql="SELECT glazent,glazld,glazcomp,glazdocno,glazseq,glazdocdt,",
             "       glaz001,glaz002,glaz003,glaz004,glaz005,glaz006,glaz007,glaz008,glaz009,glaz010,",
             "       glaz011,glaz012,glaz013,glaz014,glaz015,glaz016,glaz017,glaz018,glaz019,glaz020,",
             "       glaz022,glaz023,glaz024,glaz025,glaz026,glaz027,glaz028,glaz029,glaz030,",
             "       glaz031,glaz032,glaz033,glaz034,glaz035,glaz036,glaz037,glaz061,glaz062,glaz063 ",
             "  FROM glaz_t",
             " WHERE glazent='",g_enterprise,"' AND glazld='",g_master.glapld,"' ",
             "   AND glaz001= ",l_yy," AND glaz002= ",l_mm,
             "   AND glaz004-glaz005>0 ",
             " ORDER BY glaz_t.glazdocno,glaz_t.glazseq,glaz_t.glaz003"
   PREPARE aglp530_glaz_pr1 FROM l_sql
   DECLARE aglp530_glaz_cs1 CURSOR FOR aglp530_glaz_pr1
   
   #結轉上期沒有沖抵完的細項立沖資料
   FOREACH aglp530_glaz_cs1 INTO l_glaz.glazent,l_glaz.glazld,l_glaz.glazcomp,l_glaz.glazdocno,l_glaz.glazseq,l_glaz.glazdocdt,
                                 l_glaz.glaz001,l_glaz.glaz002,l_glaz.glaz003,l_glaz.glaz004,l_glaz.glaz005,
                                 l_glaz.glaz006,l_glaz.glaz007,l_glaz.glaz008,l_glaz.glaz009,l_glaz.glaz010,
                                 l_glaz.glaz011,l_glaz.glaz012,l_glaz.glaz013,l_glaz.glaz014,l_glaz.glaz015,
                                 l_glaz.glaz016,l_glaz.glaz017,l_glaz.glaz018,l_glaz.glaz019,l_glaz.glaz020,
                                 l_glaz.glaz022,l_glaz.glaz023,l_glaz.glaz024,l_glaz.glaz025,
                                 l_glaz.glaz026,l_glaz.glaz027,l_glaz.glaz028,l_glaz.glaz029,l_glaz.glaz030,
                                 l_glaz.glaz031,l_glaz.glaz032,l_glaz.glaz033,l_glaz.glaz034,l_glaz.glaz035,
                                 l_glaz.glaz036,l_glaz.glaz037,l_glaz.glaz061,l_glaz.glaz062,l_glaz.glaz063
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','FOREACH','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH aglp530_glaz_cs1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      LET l_glaz.glaz004=l_glaz.glaz004-l_glaz.glaz005   #本幣立帳金額(本位幣一)
      LET l_glaz.glaz007=l_glaz.glaz007-l_glaz.glaz008   #立帳數量
      LET l_glaz.glaz010=l_glaz.glaz010-l_glaz.glaz011   #原幣立帳金額
      LET l_glaz.glaz034=l_glaz.glaz034-l_glaz.glaz035   #本幣立帳金額(本位幣二)
      LET l_glaz.glaz036=l_glaz.glaz036-l_glaz.glaz037   #本幣立帳金額(本位幣三)
      
      #匯總本期細項沖帳金額
      LET l_glay003_s=0
      LET l_glay008_s=0
      LET l_glay010_s=0
      LET l_glay052_s=0
      LET l_glay054_s=0
      SELECT SUM(glay003),SUM(glay008),SUM(glay010),SUM(glay052),SUM(glay054) 
        INTO l_glay003_s,l_glay008_s,l_glay010_s,l_glay052_s,l_glay054_s
        FROM glay_t
       WHERE glayent=g_enterprise AND glayld=g_master.glapld
         AND glay002=l_glaz.glaz002
         AND glay041=l_glaz.glazdocno
         AND glay042=l_glaz.glazseq
         AND glay049=g_master.glap002
         AND glay050=g_master.glap004
      IF cl_null(l_glay003_s)  THEN LET l_glay003_s=0 END IF
      IF cl_null(l_glay008_s)  THEN LET l_glay008_s=0 END IF
      IF cl_null(l_glay010_s)  THEN LET l_glay010_s=0 END IF 
      IF cl_null(l_glay052_s)  THEN LET l_glay052_s=0 END IF 
      IF cl_null(l_glay054_s)  THEN LET l_glay054_s=0 END IF 
      LET l_glaz.glaz005=l_glay003_s    #本幣沖帳金額(本位幣一)
      LET l_glaz.glaz008=l_glay008_s    #沖帳數量
      LET l_glaz.glaz011=l_glay010_s    #原幣沖帳金額
      LET l_glaz.glaz035=l_glay052_s    #本幣沖帳金額(本位幣二)
      LET l_glaz.glaz037=l_glay054_s    #本幣沖帳金額(本位幣三)
      
      LET l_glaz.glaz001=g_master.glap002      #年度
      LET l_glaz.glaz002=g_master.glap004      #期別
      
      INSERT INTO glaz_t(
      glazent,glazld,glazcomp,glazdocno,glazseq,glazdocdt,
      glaz001,glaz002,glaz003,glaz004,glaz005,glaz006,glaz007,glaz008,glaz009,glaz010,
      glaz011,glaz012,glaz013,glaz014,glaz015,glaz016,glaz017,glaz018,glaz019,glaz020,
      glaz022,glaz023,glaz024,glaz025,glaz026,glaz027,glaz028,glaz029,glaz030,
      glaz031,glaz032,glaz033,glaz034,glaz035,glaz036,glaz037,glaz061,glaz062,glaz063
      )
      VALUES(
      l_glaz.glazent,l_glaz.glazld,l_glaz.glazcomp,l_glaz.glazdocno,l_glaz.glazseq,l_glaz.glazdocdt,
      l_glaz.glaz001,l_glaz.glaz002,l_glaz.glaz003,l_glaz.glaz004,l_glaz.glaz005,
      l_glaz.glaz006,l_glaz.glaz007,l_glaz.glaz008,l_glaz.glaz009,l_glaz.glaz010,
      l_glaz.glaz011,l_glaz.glaz012,l_glaz.glaz013,l_glaz.glaz014,l_glaz.glaz015,
      l_glaz.glaz016,l_glaz.glaz017,l_glaz.glaz018,l_glaz.glaz019,l_glaz.glaz020,
      l_glaz.glaz022,l_glaz.glaz023,l_glaz.glaz024,l_glaz.glaz025,
      l_glaz.glaz026,l_glaz.glaz027,l_glaz.glaz028,l_glaz.glaz029,l_glaz.glaz030,
      l_glaz.glaz031,l_glaz.glaz032,l_glaz.glaz033,l_glaz.glaz034,l_glaz.glaz035,
      l_glaz.glaz036,l_glaz.glaz037,l_glaz.glaz061,l_glaz.glaz062,l_glaz.glaz063
      )
      IF SQLCA.SQLCODE THEN
#         CALL cl_errmsg('INSERT glaz_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INSERT glaz_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
         
   END FOREACH
   
   #本期立賬
   LET l_sql="SELECT glaxcomp,glaxdocno,glaxseq,glaxdocdt,",
             "       glax002,glax003,glax005,glax007,glax008,glax010,glax017,glax018,glax019,glax020,",
             "       glax021,glax022,glax023,glax024,glax025,glax027,glax028,",
             "       glax029,glax030,glax031,glax032,glax033,glax034,glax035,glax036,glax037,glax038, ",
             "       glax052,glax056,glax051,glax052,glax053 ",
             "  FROM glax_t",
             " WHERE glaxent='",g_enterprise,"' AND glaxld='",g_master.glapld,"' ",
             "   AND glax049= ",g_master.glap002," AND glax050= ",g_master.glap004,
             " ORDER BY glax_t.glaxdocno,glax_t.glaxseq,glax_t.glax002"
   PREPARE aglp530_glax_pr1 FROM l_sql
   DECLARE aglp530_glax_cs1 CURSOR FOR aglp530_glax_pr1
   FOREACH aglp530_glax_cs1 INTO l_glax.glaxcomp,l_glax.glaxdocno,l_glax.glaxseq,l_glax.glaxdocdt,l_glax.glax002,
                                 l_glax.glax003,l_glax.glax005,l_glax.glax007,l_glax.glax008,l_glax.glax010,
                                 l_glax.glax017,l_glax.glax018,l_glax.glax019,l_glax.glax020,
                                 l_glax.glax021,l_glax.glax022,l_glax.glax023,l_glax.glax024,
                                 l_glax.glax025,l_glax.glax027,l_glax.glax028,
                                 l_glax.glax029,l_glax.glax030,l_glax.glax031,l_glax.glax032,l_glax.glax033,
                                 l_glax.glax034,l_glax.glax035,l_glax.glax036,l_glax.glax037,l_glax.glax038,
                                 l_glax.glax052,l_glax.glax056,l_glax.glax051,l_glax.glax052,l_glax.glax053
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','FOREACH','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH aglp530_glax_cs1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      INITIALIZE l_glaz.* TO NULL
      LET l_glaz.glazent=g_enterprise
      LET l_glaz.glazld =g_master.glapld
      LET l_glaz.glazcomp=l_glax.glaxcomp
      LET l_glaz.glazdocno=l_glax.glaxdocno
      LET l_glaz.glazseq=l_glax.glaxseq
      LET l_glaz.glazdocdt=l_glax.glaxdocdt
      LET l_glaz.glaz001=g_master.glap002
      LET l_glaz.glaz002=g_master.glap004
      LET l_glaz.glaz003=l_glax.glax002
      
      LET l_glaz.glaz004=l_glax.glax003 #本幣立帳金額(本位幣一)
      LET l_glaz.glaz006=l_glax.glax007 #計價單位
      LET l_glaz.glaz007=l_glax.glax008 #立帳數量
      LET l_glaz.glaz009=l_glax.glax005 #交易幣別
      LET l_glaz.glaz010=l_glax.glax010 #原幣立帳金額
      LET l_glaz.glaz034=l_glax.glax052 #本幣立帳金額(本位幣二)
      LET l_glaz.glaz036=l_glax.glax056 #本幣立帳金額(本位幣三)
      #匯總本期細項沖帳金額
      LET l_glay003_s=0
      LET l_glay008_s=0
      LET l_glay010_s=0
      LET l_glay052_s=0
      LET l_glay054_s=0
      SELECT SUM(glay003),SUM(glay008),SUM(glay010),SUM(glay052),SUM(glay054)  
        INTO l_glay003_s,l_glay008_s,l_glay010_s,l_glay052_s,l_glay054_s
        FROM glay_t
       WHERE glayent=g_enterprise AND glayld=g_master.glapld
         AND glay002=l_glax.glax002
         AND glay041=l_glax.glaxdocno
         AND glay042=l_glax.glaxseq
         AND glay049=g_master.glap002
         AND glay050=g_master.glap004
      IF cl_null(l_glay003_s)  THEN LET l_glay003_s=0 END IF
      IF cl_null(l_glay008_s)  THEN LET l_glay008_s=0 END IF
      IF cl_null(l_glay010_s)  THEN LET l_glay010_s=0 END IF 
      IF cl_null(l_glay052_s)  THEN LET l_glay052_s=0 END IF 
      IF cl_null(l_glay054_s)  THEN LET l_glay054_s=0 END IF 
      LET l_glaz.glaz005=l_glay003_s    #本幣沖帳金額(本位幣一)
      LET l_glaz.glaz008=l_glay008_s    #沖帳數量
      LET l_glaz.glaz011=l_glay010_s    #原幣沖帳金額
      LET l_glaz.glaz035=l_glay052_s    #本幣沖帳金額(本位幣二)
      LET l_glaz.glaz037=l_glay054_s    #本幣沖帳金額(本位幣三)
      
      LET l_glaz.glaz012=l_glax.glax017
      LET l_glaz.glaz013=l_glax.glax018
      LET l_glaz.glaz014=l_glax.glax019
      LET l_glaz.glaz015=l_glax.glax020
      LET l_glaz.glaz016=l_glax.glax021
      LET l_glaz.glaz017=l_glax.glax022
      LET l_glaz.glaz018=l_glax.glax023
      LET l_glaz.glaz019=l_glax.glax024
      LET l_glaz.glaz020=l_glax.glax025
#      LET l_glaz.glaz021=l_glax.glax026
      LET l_glaz.glaz022=l_glax.glax027
      LET l_glaz.glaz023=l_glax.glax028
      LET l_glaz.glaz024=l_glax.glax029
      LET l_glaz.glaz025=l_glax.glax030
      LET l_glaz.glaz026=l_glax.glax031
      LET l_glaz.glaz027=l_glax.glax032
      LET l_glaz.glaz028=l_glax.glax033
      LET l_glaz.glaz029=l_glax.glax034
      LET l_glaz.glaz030=l_glax.glax035
      LET l_glaz.glaz031=l_glax.glax036
      LET l_glaz.glaz032=l_glax.glax037
      LET l_glaz.glaz033=l_glax.glax038
      LET l_glaz.glaz061=l_glax.glax061
      LET l_glaz.glaz062=l_glax.glax062
      LET l_glaz.glaz063=l_glax.glax063
      
      INSERT INTO glaz_t(
      glazent,glazld,glazcomp,glazdocno,glazseq,glazdocdt,
      glaz001,glaz002,glaz003,glaz004,glaz005,glaz006,glaz007,glaz008,glaz009,glaz010,
      glaz011,glaz012,glaz013,glaz014,glaz015,glaz016,glaz017,glaz018,glaz019,glaz020,
      glaz022,glaz023,glaz024,glaz025,glaz026,glaz027,glaz028,glaz029,glaz030,
      glaz031,glaz032,glaz033,glaz034,glaz035,glaz036,glaz037,glaz061,glaz062,glaz063
      )
      VALUES(
      l_glaz.glazent,l_glaz.glazld,l_glaz.glazcomp,l_glaz.glazdocno,l_glaz.glazseq,l_glaz.glazdocdt,
      l_glaz.glaz001,l_glaz.glaz002,l_glaz.glaz003,l_glaz.glaz004,l_glaz.glaz005,
      l_glaz.glaz006,l_glaz.glaz007,l_glaz.glaz008,l_glaz.glaz009,l_glaz.glaz010,
      l_glaz.glaz011,l_glaz.glaz012,l_glaz.glaz013,l_glaz.glaz014,l_glaz.glaz015,
      l_glaz.glaz016,l_glaz.glaz017,l_glaz.glaz018,l_glaz.glaz019,l_glaz.glaz020,
      l_glaz.glaz022,l_glaz.glaz023,l_glaz.glaz024,l_glaz.glaz025,
      l_glaz.glaz026,l_glaz.glaz027,l_glaz.glaz028,l_glaz.glaz029,l_glaz.glaz030,
      l_glaz.glaz031,l_glaz.glaz032,l_glaz.glaz033,l_glaz.glaz034,l_glaz.glaz035,
      l_glaz.glaz036,l_glaz.glaz037,l_glaz.glaz061,l_glaz.glaz062,l_glaz.glaz063
      )
      IF SQLCA.SQLCODE THEN
#         CALL cl_errmsg('INSERT glaz_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INSERT glaz_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 判读是否设置固定核算项，组成SQL语句
# Memo...........:
# Usage..........: CALL aglp530_fix_acc_sql(p_glaq002)
# Input parameter: p_glaq002    科目编号
# Return code....: r_sql        SQL语句 
# Date & Author..: 2013/03/20 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_fix_acc_sql(p_glaq002)
   DEFINE p_glaq002       LIKE glaq_t.glaq002
   DEFINE r_sql           STRING
   DEFINE r_sql1          STRING
   #科目核算项
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #自由核算项
   DEFINE l_glad017       LIKE glad_t.glad017     #自由核算项一
   DEFINE l_glad018       LIKE glad_t.glad018     #自由核算项二
   DEFINE l_glad019       LIKE glad_t.glad019     #自由核算项三
   DEFINE l_glad020       LIKE glad_t.glad020     #自由核算项四
   DEFINE l_glad021       LIKE glad_t.glad021     #自由核算项五
   DEFINE l_glad022       LIKE glad_t.glad022     #自由核算项六
   DEFINE l_glad023       LIKE glad_t.glad023     #自由核算项七
   DEFINE l_glad024       LIKE glad_t.glad024     #自由核算项八
   DEFINE l_glad025       LIKE glad_t.glad025     #自由核算项九
   DEFINE l_glad026       LIKE glad_t.glad026     #自由核算项十
   
   CALL s_voucher_fix_acc_open_chk(g_master.glapld,p_glaq002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033
   #自由核算项
   SELECT glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,glad026
     INTO l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,l_glad022,l_glad023,l_glad024,l_glad025,l_glad026
     FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_master.glapld
      AND glad001 = p_glaq002
      
   LET r_sql="glaq017"
   LET r_sql1="glar012"
   
   IF l_glad007='Y' THEN
      LET r_sql=r_sql,",glaq018"
      LET r_sql1=r_sql1,",glar013"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   IF l_glad008='Y' THEN
      LET r_sql=r_sql,",glaq019"
      LET r_sql1=r_sql1,",glar014"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   IF l_glad009='Y' THEN
      LET r_sql=r_sql,",glaq020"
      LET r_sql1=r_sql1,",glar015"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   IF l_glad010='Y' THEN
      LET r_sql=r_sql,",glaq021"
      LET r_sql1=r_sql1,",glar016"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF

   IF l_glad027='Y' THEN
      LET r_sql=r_sql,",glaq022"
      LET r_sql1=r_sql1,",glar017"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF

   IF l_glad011='Y' THEN
      LET r_sql=r_sql,",glaq023"
      LET r_sql1=r_sql1,",glar018"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF

   IF l_glad012='Y' THEN
      LET r_sql=r_sql,",glaq024"
      LET r_sql1=r_sql1,",glar019"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   #經營方式
   IF l_glad031='Y' THEN
      LET r_sql=r_sql,",glaq051"
      LET r_sql1=r_sql1,",glar051"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   #渠道
   IF l_glad032='Y' THEN
      LET r_sql=r_sql,",glaq052"
      LET r_sql1=r_sql1,",glar052"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   #品牌
   IF l_glad033='Y' THEN
      LET r_sql=r_sql,",glaq053"
      LET r_sql1=r_sql1,",glar053"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   #人員
   IF l_glad013='Y' THEN
      LET r_sql=r_sql,",glaq025"
      LET r_sql1=r_sql1,",glar020"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF

#   IF l_glad014='Y' THEN
#      LET r_sql=r_sql,",glaq026"
#      LET r_sql1=r_sql1,",glar021"
#   ELSE
#      LET r_sql=r_sql,",''"
#      LET r_sql1=r_sql1,",''"
#   END IF

   IF l_glad015='Y' THEN
      LET r_sql=r_sql,",glaq027"
      LET r_sql1=r_sql1,",glar022"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   IF l_glad016='Y' THEN
      LET r_sql=r_sql,",glaq028"
      LET r_sql1=r_sql1,",glar023"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項一
   IF l_glad017='Y' THEN
      LET r_sql=r_sql,",glaq029"
      LET r_sql1=r_sql1,",glar024"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項二
   IF l_glad018='Y' THEN
      LET r_sql=r_sql,",glaq030"
      LET r_sql1=r_sql1,",glar025"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項三
   IF l_glad019='Y' THEN
      LET r_sql=r_sql,",glaq031"
      LET r_sql1=r_sql1,",glar026"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項四
   IF l_glad020='Y' THEN
      LET r_sql=r_sql,",glaq032"
      LET r_sql1=r_sql1,",glar027"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項五
   IF l_glad021='Y' THEN
      LET r_sql=r_sql,",glaq033"
      LET r_sql1=r_sql1,",glar028"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項六
   IF l_glad022='Y' THEN
      LET r_sql=r_sql,",glaq034"
      LET r_sql1=r_sql1,",glar029"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項七
   IF l_glad023='Y' THEN
      LET r_sql=r_sql,",glaq035"
      LET r_sql1=r_sql1,",glar030"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項八
   IF l_glad024='Y' THEN
      LET r_sql=r_sql,",glaq036"
      LET r_sql1=r_sql1,",glar031"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項九
   IF l_glad025='Y' THEN
      LET r_sql=r_sql,",glaq037"
      LET r_sql1=r_sql1,",glar032"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   #自由核算項十
   IF l_glad026='Y' THEN
      LET r_sql=r_sql,",glaq038"
      LET r_sql1=r_sql1,",glar033"
   ELSE
      LET r_sql=r_sql,",''"
      LET r_sql1=r_sql1,",''"
   END IF
   
   RETURN r_sql,r_sql1
END FUNCTION

################################################################################
# Descriptions...: 月結方式：表結法，年結方式：帳結法
# Memo...........: 最後一期(12/13期)結轉產生3張傳票
# Usage..........: CALL aglp530_glaa006_3()
# Date & Author..: 2015/1/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_glaa006_3()
   DEFINE l_period            LIKE type_t.num5
   DEFINE l_sql,l_sql1        STRING
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_errno             LIKE type_t.chr100
   DEFINE l_glav002           LIKE glav_t.glav002
   DEFINE l_glav005           LIKE glav_t.glav005
   DEFINE l_sdate_s           LIKE glav_t.glav004
   DEFINE l_sdate_e           LIKE glav_t.glav004
   DEFINE l_glav006           LIKE glav_t.glav006
   DEFINE l_pdate_s           LIKE glav_t.glav004
   DEFINE l_pdate_e           LIKE glav_t.glav004
   DEFINE l_glav007           LIKE glav_t.glav007
   DEFINE l_wdate_s           LIKE glav_t.glav004
   DEFINE l_wdate_e           LIKE glav_t.glav004
   
   #第一张：把1－11月的冲回凭证
   #========单头glap_t======================
   INITIALIZE g_glap.* TO NULL
   LET g_glap.glapent = g_enterprise
   LET g_glap.glapcomp = g_glaacomp 
   LET g_glap.glapld = g_master.glapld 
   LET g_glap.glap001 = '1'      
   LET g_glap.glap002 = g_master.glap002
   LET g_glap.glap004 = g_master.glap004
   LET g_glap.glapdocno = g_glaa112

   CALL s_get_accdate(g_glaa003,'',g_master.glap002,g_master.glap004)
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'l_errno'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'
      RETURN
   END IF         
   LET g_glap.glapdocdt=l_pdate_e
   CALL s_aooi200_fin_gen_docno(g_master.glapld,g_glaa024,g_glaa003,g_glap.glapdocno,g_glap.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
   IF l_success = FALSE THEN
      LET g_success = 'N'      
      RETURN
   END IF 
   
   LET g_glap.glap007 = 'CE'
   LET g_glap.glap009 = 0
   LET g_glap.glap009 = 0
   LET g_glap.glap013 = 0
   LET g_glap.glap014 = 'N'
   LET g_glap.glapstus = 'Y'
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapownid = g_user
   LET g_glap.glapowndp = g_dept
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdp = g_dept 
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapcnfid = g_user
   LET g_glap.glapcnfdt = cl_get_current()
   
   #=================单身glaq_t================================
   INITIALIZE g_glaq.* TO NULL
   LET g_glaq.glaqent = g_glap.glapent
   LET g_glaq.glaqld = g_glap.glapld
   LET g_glaq.glaqdocno = g_glap.glapdocno
   LET g_glaq.glaqcomp = g_glap.glapcomp
   LET g_glaq.glaq005 = g_glaa001
   LET g_glaq.glaq006 = 1  #匯率(本位幣一)
   #匯率(本位幣二)
   IF g_glaa015='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa016,0,g_glaa018)
      RETURNING  g_glaq.glaq039
   ELSE
      LET g_glaq.glaq039 = 0  
   END IF
   #匯率(本位幣三)
   IF g_glaa019='Y' THEN
      CALL s_aooi160_get_exrate('2',g_glap.glapld,g_glap.glapdocdt,g_glaq.glaq005,g_glaa020,0,g_glaa022)
      RETURNING  g_glaq.glaq042
   ELSE
      LET g_glaq.glaq042 = 0  
   END IF
   #摘要
   LET g_glaq.glaq001=g_glap.glap002 USING '<<<<',cl_getmsg('agl-00274',g_lang),
                      g_glap.glap004 USING '<<<<',cl_getmsg('axc-00589',g_lang)," ",
                      cl_getmsg('agl-00309',g_lang)
                      
   LET l_period = g_max_period - 1
   #借方
   LET l_sql1="       glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,",
              "       glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,",
              "       glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038",
              "  FROM glaq_t",
              "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
              " WHERE glaqent = ",g_enterprise,
              "   AND glaqld = '",g_glaq.glaqld,"'",
              "   AND glap002 =", g_master.glap002,
              "   AND glap004 <= ",l_period ,
              "   AND glap007 = 'CE' ",  #CE傳票
              "   AND glapstus = 'S' ",
              " GROUP BY glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,",
              "          glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,",
              "          glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038",
              " ORDER BY glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,",
              "          glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,",
              "          glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038"
   #借方:本期损益（资产类）
   LET l_sql = "SELECT SUM(glaq004),SUM(glaq041),SUM(glaq044), ",l_sql1
   PREPARE aglp530_glaq_3_pr1 FROM l_sql
   DECLARE aglp530_glaq_3_cs1  CURSOR FOR  aglp530_glaq_3_pr1
   #貸方:本期损益（损益类）
   LET l_sql = "SELECT SUM(glaq003),SUM(glaq040),SUM(glaq043),",l_sql1
   PREPARE aglp530_glaq_3_pr2 FROM l_sql
   DECLARE aglp530_glaq_3_cs2  CURSOR FOR  aglp530_glaq_3_pr2
   
   #借方
   LET g_glaq.glaqseq = 1
   LET g_glaq.glaq004=0
   LET g_glaq.glaq010=0
   LET g_glaq.glaq041=0
   LET g_glaq.glaq044=0
   FOREACH aglp530_glaq_3_cs1 INTO g_glaq.glaq003,g_glaq.glaq040,g_glaq.glaq043,g_glaq.glaq002,
                                   g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,
                                   g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq051,g_glaq.glaq052,
                                   g_glaq.glaq053,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,
                                   g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
                                   g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      IF cl_null(g_glaq.glaq003) THEN LET g_glaq.glaq003=0 END IF
      IF g_glaq.glaq003 = 0 THEN
         CONTINUE FOREACH
      END IF
      IF cl_null(g_glaq.glaq040) THEN LET g_glaq.glaq040=0 END IF
      IF cl_null(g_glaq.glaq043) THEN LET g_glaq.glaq043=0 END IF
      LET g_glaq.glaq010=g_glaq.glaq003

      INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,
                            glaq005,glaq006,glaq010,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                            glaq023,glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,
                            glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,
                            glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,glaq052,glaq053)
      VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
              g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
              g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
              g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
              g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
              g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,
              g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
              g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins p530_tmp'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      LET g_glaq.glaqseq = g_glaq.glaqseq +1 
   END FOREACH
   
   #貸方
   LET g_glaq.glaq003=0
   LET g_glaq.glaq010=0
   LET g_glaq.glaq040=0
   LET g_glaq.glaq043=0
   FOREACH aglp530_glaq_3_cs2 INTO g_glaq.glaq004,g_glaq.glaq041,g_glaq.glaq044,g_glaq.glaq002,
                                   g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,
                                   g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq051,g_glaq.glaq052,
                                   g_glaq.glaq053,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,
                                   g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
                                   g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FOREACH'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      IF cl_null(g_glaq.glaq004) THEN LET g_glaq.glaq004 =0 END IF
      IF g_glaq.glaq004 = 0 THEN
         CONTINUE FOREACH
      END IF
      IF cl_null(g_glaq.glaq041) THEN LET g_glaq.glaq041=0 END IF
      IF cl_null(g_glaq.glaq044) THEN LET g_glaq.glaq044=0 END IF
      LET g_glaq.glaq010=g_glaq.glaq004
      
      INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,
                            glaq005,glaq006,glaq010,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                            glaq023,glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,
                            glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,
                            glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,glaq052,glaq053)
      VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,
              g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,g_glaq.glaq006,g_glaq.glaq010,
              g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,
              g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,g_glaq.glaq027,g_glaq.glaq028,
              g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,
              g_glaq.glaq035,g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,
              g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,
              g_glaq.glaq051,g_glaq.glaq052,g_glaq.glaq053)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins p530_tmp'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      LET g_glaq.glaqseq = g_glaq.glaqseq +1 
   END FOREACH
   
   #==============INS_glap_t==========
   IF g_glaq.glaqseq > 1 THEN
      #借方金额为单身借贷金额之和
      SELECT SUM(glaq003),SUM(glaq004) INTO g_glap.glap010,g_glap.glap011
        FROM glaq_t
       WHERE glaqent=g_enterprise AND glaqld=g_glap.glapld AND glaqdocno=g_glap.glapdocno 
      #161111-00028#8----modify----begin---------       
      #INSERT INTO glap_t VALUES (g_glap.*)
      INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,glap005,
                            glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,glap015,glap016,
                            glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,glapmoddt,glapcnfid,
                            glapcnfdt,glappstid,glappstdt,glapstus)
         VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,g_glap.glap005,
                g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,g_glap.glap015,g_glap.glap016,
                g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,g_glap.glapmoddt,g_glap.glapcnfid,
                g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
      #161111-00028#8----modify----end---------
        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INS_glap_a1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      
      #CE傳票的過帳動作
      LET l_success = TRUE
      CALL s_voucher_post_chk(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
      IF l_success = TRUE THEN
         CALL s_voucher_post_upd(g_glap.glapld,g_glap.glapdocno) RETURNING l_success
      END IF 
      IF l_success = FALSE THEN
         LET g_success = 'N'
      END IF
   END IF
   
   #第二张：1-12结转成本费用
   #第三张：1-12结转收入
   CALL aglp530_glaa006_2(1,g_max_period)
END FUNCTION

################################################################################
# Descriptions...: 設置未啟用的核算項為空格
# Memo...........:
# Usage..........: CALL aglp530_fix_acc_open(p_glaqld,p_glaq002)
# Input parameter: p_glaqld       帳套
#                : p_glaq002      科目編號
# Date & Author..: 2015/02/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_fix_acc_open(p_glaqld,p_glaq002)
   DEFINE p_glaqld        LIKE glaq_t.glaqld
   DEFINE p_glaq002       LIKE glaq_t.glaq002
   #科目核算项
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #自由核算项
   DEFINE l_glad017       LIKE glad_t.glad017     #自由核算项一
   DEFINE l_glad018       LIKE glad_t.glad018     #自由核算项二
   DEFINE l_glad019       LIKE glad_t.glad019     #自由核算项三
   DEFINE l_glad020       LIKE glad_t.glad020     #自由核算项四
   DEFINE l_glad021       LIKE glad_t.glad021     #自由核算项五
   DEFINE l_glad022       LIKE glad_t.glad022     #自由核算项六
   DEFINE l_glad023       LIKE glad_t.glad023     #自由核算项七
   DEFINE l_glad024       LIKE glad_t.glad024     #自由核算项八
   DEFINE l_glad025       LIKE glad_t.glad025     #自由核算项九
   DEFINE l_glad026       LIKE glad_t.glad026     #自由核算项十
   
   CALL s_voucher_fix_acc_open_chk(p_glaqld,p_glaq002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033
   #自由核算项
   SELECT glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,glad026
     INTO l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,l_glad022,l_glad023,l_glad024,l_glad025,l_glad026
     FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld = p_glaqld
      AND glad001 = p_glaq002
      
   #營運據點
   IF cl_null(g_glaq.glaq017) THEN
      SELECT glaacomp INTO g_glaq.glaq017 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_glaqld
      IF cl_null(g_glaq.glaq017) THEN LET g_glaq.glaq017 = ' ' END IF  #160628-00036#2
   END IF
   #該科目做部門管理
   IF l_glad007 <> 'Y' OR l_glad007 IS NULL THEN
      LET g_glaq.glaq018 = ' ' 
   ELSE
      IF cl_null(g_glaq.glaq018) THEN
         #依據登入用戶抓取所在部門
         SELECT ooag003 INTO g_glaq.glaq018 FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_user
         IF cl_null(g_glaq.glaq018) THEN LET g_glaq.glaq018 = ' ' END IF  #160628-00036#2   
      END IF
   END IF 
   #該科目做利潤成本管理時
   IF l_glad008 <> 'Y' OR l_glad008 IS NULL THEN
      LET g_glaq.glaq019 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq019) THEN
         SELECT ooeg004 INTO g_glaq.glaq019 FROM ooeg_t 
          WHERE ooegent = g_enterprise 
            AND ooeg001 = (SELECT ooag003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_user)
         IF cl_null(g_glaq.glaq019) THEN LET g_glaq.glaq019 = ' ' END IF  #160628-00036#2           
      END IF
   END IF 
   #該科目做區域管理時
   IF l_glad009 <> 'Y' OR l_glad009 IS NULL THEN
      LET g_glaq.glaq020 = ' '
   ELSE
      IF cl_null(g_glaq.glaq020) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'4') RETURNING g_glaq.glaq020
      END IF
   END IF 
   #該科目做客商管理
   IF l_glad010 <> 'Y' OR l_glad010 IS NULL THEN
      LET g_glaq.glaq021 = ' '
   ELSE
      IF cl_null(g_glaq.glaq021) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'5') RETURNING g_glaq.glaq021
      END IF
   END IF 
   #該科目做账款客商管理時
   IF l_glad027 <> 'Y' OR l_glad027 IS NULL THEN
      LET g_glaq.glaq022 = ' '
   ELSE
      IF cl_null(g_glaq.glaq022) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'6') RETURNING g_glaq.glaq022
      END IF
   END IF 
   #該科目做客群管理時
   IF l_glad011 <> 'Y' OR l_glad011 IS NULL THEN
      LET g_glaq.glaq023 = ' '     
   ELSE
      IF cl_null(g_glaq.glaq023) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'7') RETURNING g_glaq.glaq023
      END IF   
   END IF 
   #該科目做產品分類管理時，
   IF l_glad012 <> 'Y' OR l_glad012 IS NULL THEN
      LET g_glaq.glaq024 = ' '    
   ELSE
      IF cl_null(g_glaq.glaq024) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'8') RETURNING g_glaq.glaq024
      END IF
   END IF 
   #該科目做经营方式管理時，
   IF l_glad031 <> 'Y' OR l_glad031 IS NULL THEN
      LET g_glaq.glaq051 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq051) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'9') RETURNING g_glaq.glaq051
      END IF
   END IF
   #該科目做渠道管理時，
   IF l_glad032 <> 'Y' OR l_glad032 IS NULL THEN
      LET g_glaq.glaq052 = ' '    
   ELSE
      IF cl_null(g_glaq.glaq052) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'10') RETURNING g_glaq.glaq052
      END IF
   END IF
   #該科目做品牌管理時，
   IF l_glad033 <> 'Y' OR l_glad033 IS NULL THEN
      LET g_glaq.glaq053 = ' '    
   ELSE
      IF cl_null(g_glaq.glaq053) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'11') RETURNING g_glaq.glaq053
      END IF
   END IF
   #該科目做人員管理時，
   IF l_glad013 <> 'Y' OR l_glad013 IS NULL THEN
      LET g_glaq.glaq025 = ' '    
   ELSE
      LET g_glaq.glaq025 = g_user
   END IF 
   #該科目做專案管理時，
   IF l_glad015 <> 'Y' OR l_glad015 IS NULL THEN
      LET g_glaq.glaq027 = ' '     
   ELSE
      IF cl_null(g_glaq.glaq027) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'13') RETURNING g_glaq.glaq027
      END IF 
   END IF 
   #該科目做WBS管理時，
   IF l_glad016 <> 'Y' OR l_glad016 IS NULL THEN
      LET g_glaq.glaq028 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq028) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'14') RETURNING g_glaq.glaq028
      END IF
   END IF 
   #核算项一
   IF l_glad017 <> 'Y' OR l_glad017 IS NULL THEN
      LET g_glaq.glaq029 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq029) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'15') RETURNING g_glaq.glaq029
      END IF
   END IF 
   #核算项二
   IF l_glad018 <> 'Y' OR l_glad018 IS NULL THEN
      LET g_glaq.glaq030 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq030) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'16') RETURNING g_glaq.glaq030
      END IF
   END IF
   #核算项三
   IF l_glad019 <> 'Y' OR l_glad019 IS NULL THEN
      LET g_glaq.glaq031 = ' '  
   ELSE
      IF cl_null(g_glaq.glaq031) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'17') RETURNING g_glaq.glaq031
      END IF   
   END IF
   #核算项四
   IF l_glad020 <> 'Y' OR l_glad020 IS NULL THEN
      LET g_glaq.glaq032 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq032) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'18') RETURNING g_glaq.glaq032
      END IF
   END IF
   #核算项五
   IF l_glad021 <> 'Y' OR l_glad021 IS NULL THEN
      LET g_glaq.glaq033 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq033) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'19') RETURNING g_glaq.glaq033
      END IF
   END IF
   #核算项四六
   IF l_glad022 <> 'Y' OR l_glad022 IS NULL THEN
      LET g_glaq.glaq034 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq034) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'20') RETURNING g_glaq.glaq034
      END IF
   END IF
   #核算项七
   IF l_glad023 <> 'Y' OR l_glad023 IS NULL THEN
      LET g_glaq.glaq035 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq035) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'21') RETURNING g_glaq.glaq035
      END IF
   END IF
   #核算项八
   IF l_glad024 <> 'Y' OR l_glad024 IS NULL THEN
      LET g_glaq.glaq036 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq036) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'22') RETURNING g_glaq.glaq036
      END IF
   END IF
   #核算项九
   IF l_glad025 <> 'Y' OR l_glad025 IS NULL THEN
      LET g_glaq.glaq037 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq037) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'23') RETURNING g_glaq.glaq037
      END IF
   END IF
   #核算项十
   IF l_glad026 <> 'Y' OR l_glad026 IS NULL THEN
      LET g_glaq.glaq038 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq038) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'24') RETURNING g_glaq.glaq038
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 共用类非红字处理
# Memo...........:
# Usage..........: CALL aglp530_red(p_glaq010,p_glaq003,p_glaq004,p_glaq040,p_glac041,p_glac043,p_glac044)
# Input parameter: 
# Date & Author..: 2016/07/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp530_red(p_glaq010,p_glaq003,p_glaq004,p_glaq040,p_glaq041,p_glaq043,p_glaq044)
DEFINE p_glaq010    LIKE glaq_t.glaq010
DEFINE p_glaq003    LIKE glaq_t.glaq003
DEFINE p_glaq004    LIKE glaq_t.glaq004
DEFINE p_glaq040    LIKE glaq_t.glaq040
DEFINE p_glaq041    LIKE glaq_t.glaq041
DEFINE p_glaq043    LIKE glaq_t.glaq043
DEFINE p_glaq044    LIKE glaq_t.glaq044
DEFINE p_glaq010_r  LIKE glaq_t.glaq010
DEFINE p_glaq003_r  LIKE glaq_t.glaq003
DEFINE p_glaq004_r  LIKE glaq_t.glaq004
DEFINE p_glaq040_r  LIKE glaq_t.glaq040
DEFINE p_glaq041_r  LIKE glaq_t.glaq041
DEFINE p_glaq043_r  LIKE glaq_t.glaq043
DEFINE p_glaq044_r  LIKE glaq_t.glaq044


   #當非紅字傳票時且金額小於零，借貸相反，金額*(-1) 
   IF p_glaq003 < 0 THEN    
      LET p_glaq004_r = p_glaq003 * (-1)
      LET p_glaq003_r = 0 
      #本位幣二
      IF g_glaa015='Y' THEN
         LET p_glaq041_r = p_glaq040 * (-1)
         LET p_glaq040_r = 0 
      ELSE
         LET p_glaq040_r = 0
         LET p_glaq041_r = 0
      END IF
      #本位幣三
      IF g_glaa019='Y' THEN
         LET p_glaq044_r = p_glaq043 * (-1)
         LET p_glaq043_r = 0
      ELSE
         LET p_glaq043_r = 0
         LET p_glaq044_r = 0
      END IF
      LET p_glaq010_r = p_glaq004_r  
   END IF 

   #當非紅字傳票時且金額小於零，借貸相反，金額*(-1) 
   IF p_glaq004 < 0 THEN  
      LET p_glaq003_r = p_glaq004 * (-1)   
      LET p_glaq004_r = 0
      #本位幣二
      IF g_glaa015='Y' THEN
         LET p_glaq040_r = p_glaq041 * (-1)
         LET p_glaq041_r = 0
      ELSE
         LET p_glaq040_r = 0
         LET p_glaq041_r = 0
      END IF
      #本位幣三
      IF g_glaa019='Y' THEN
         LET p_glaq043_r = p_glaq044 * (-1)
         LET p_glaq044_r = 0
      ELSE
         LET p_glaq043_r = 0
         LET p_glaq044_r = 0
      END IF
      LET p_glaq010_r = p_glaq003_r 
   END IF
   RETURN p_glaq010_r,p_glaq003_r,p_glaq004_r,p_glaq040_r,p_glaq041_r,p_glaq043_r,p_glaq044_r   
END FUNCTION

#end add-point
 
{</section>}
 
