#該程式未解開Section, 採用最新樣板產出!
{<section id="afap310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2014-12-01 14:14:50), PR版次:0015(2017-02-08 11:25:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000120
#+ Filename...: afap310
#+ Description: 固定資產月結作業
#+ Creator....: 05426(2014-09-08 20:25:32)
#+ Modifier...: 01531 -SD/PR- 02599
 
{</section>}
 
{<section id="afap310.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150401-00001#27 2015/10/12 By RayHuang 分攤方式應為faam007(原來的faam006改為007)
#160426-00014#25 2016/07/27 By 02599    程序里面的foreach写法变更，以利效能提高
#160125-00005#7  2016/08/10 By 01531    查詢時加上帳套人員權限條件過濾
#160426-00014#29 2016/08/22 By 07900    月结时增加将资产分类(faaj048)写入faan档对应栏位。
#161020-00010#1  2016/10/20 By 02114    执行本月月结时检核次月是否有折旧、出售等各类异动，有就不能执行,此段检查需排除作废单据
#161024-00008#2  2016/10/24 By Hans     AFA組織類型與職能開窗清單調整。 
#161111-00028#6  2016/11/21 by 06189    标准程式定义采用宣告模式,弃用.*写法
#161104-00048#7  2016/11/24 By 01531    月结时，以faaj038状态写入faan007。
#161215-00044#1  2016/12/15 by 02481    标准程式定义采用宣告模式,弃用.*写
#170104-00050#1  2017/01/05 By 01531    当前据点资产都为停用，检查afai021是否设置已停用资产是否计提折旧，若未设置，则可月结，不检查faam折旧档
#170207-00026#1  2017/02/07 By 02114    aglq510查询固资模组时,子系统与总账对不上
#                                       经查是afap310月结时,账面余额栏位计算错误,当没有期初时,账面余额=faaj016+faaj020
#170206-00029#1  2017/02/08 By 02599    BUG修正，去除多余空格

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
   sel           LIKE type_t.chr1,
   glaald        LIKE glaa_t.glaald,
   glaald_desc   LIKE type_t.chr500,
   glaacomp      LIKE glaa_t.glaacomp,   
   glaacomp_desc LIKE type_t.chr500,
   glaa001       LIKE glaa_t.glaa001,
   period      LIKE type_t.chr20,   
   bdate         LIKE glav_t.glav004,
   edate         LIKE glav_t.glav004
                  END RECORD
 
DEFINE l_para_data           LIKE type_t.chr80
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_rec_b               LIKE type_t.num5                     
 TYPE type_master RECORD
   faansite      LIKE faan_t.faansite, 
   faansite_desc LIKE type_t.chr500, 
   faan001       LIKE faan_t.faan001, 
   faan002       LIKE faan_t.faan002, 
   stagenow      LIKE type_t.chr80,
       wc               STRING
                   END RECORD
DEFINE g_master    type_master
DEFINE g_master_t  type_master
#161215-00044#1---modify----begin-----------------
#DEFINE g_glaa      RECORD LIKE glaa_t.* 
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
#161215-00044#1---modify----end-----------------
DEFINE g_wc_cs_orga   STRING      #160125-00005#7
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
#161215-00044#1---modify----begin-----------------
#DEFINE g_glaa_t   RECORD LIKE glaa_t.*  
DEFINE g_glaa_t RECORD  #帳套資料檔
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
DEFINE g_glaa001  LIKE glaa_t.glaa001
DEFINE g_glaa004  LIKE glaa_t.glaa001
DEFINE g_glaa015  LIKE glaa_t.glaa015
DEFINE g_glaa016  LIKE glaa_t.glaa016
DEFINE g_glaa017  LIKE glaa_t.glaa017
DEFINE g_glaa018  LIKE glaa_t.glaa018
DEFINE g_glaa019  LIKE glaa_t.glaa019
DEFINE g_glaa020  LIKE glaa_t.glaa020
DEFINE g_glaa021  LIKE glaa_t.glaa021
DEFINE g_glaa022  LIKE glaa_t.glaa022
DEFINE g_glaacomp LIKE glaa_t.glaacomp
DEFINE g_flag     LIKE type_t.chr1 
#end add-point
 
{</section>}
 
{<section id="afap310.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap310 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap310_init()   
 
      #進入選單 Menu (="N")
      CALL afap310_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap310
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap310.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap310_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  value       STRING,
                  label_tag   STRING,
                  label       STRING
              END RECORD
   DEFINE i       LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
#   CALL cl_set_combo_scc('faan001','43')
#   CALL cl_set_combo_scc('faan002','8861')
   CALL s_fin_set_comp_scc('faan001','43')    
   CALL s_fin_set_comp_scc('faan002','111')  
   CALL s_fin_create_account_center_tmp()
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7       
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap310_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_bdate     LIKE glav_t.glav004    #年度月份起始日期
   DEFINE l_edate     LIKE glav_t.glav004    #年度月份結束日期
   DEFINE l_faan001   LIKE faan_t.faan001
   DEFINE l_faan002   LIKE faan_t.faan002
   DEFINE l_site      LIKE faan_t.faansite
   DEFINE l_success   LIKE type_t.chr1
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap310_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.faansite,g_master.faan001,g_master.faan002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
         BEFORE INPUT
               IF cl_null(g_master_t.faansite) THEN
                  CALL afap310_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.faansite,g_master.faansite_desc,g_master.faan001,g_master.faan002
                    TO faansite,faansite_desc,faan001,faan002

         BEFORE FIELD faansite
            LET l_site = g_master.faansite
               
         AFTER FIELD faansite
            IF NOT cl_null(g_master.faansite) THEN
               #資料存在性、有效性檢查
               LET g_errno = ' '
               CALL s_fin_account_center_chk(g_master.faansite,'',5,g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_master.faansite
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.faansite = l_site
                  CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
                  DISPLAY g_master.faansite_desc TO faansite_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #161024-00008#2---s---
            IF s_chr_get_index_of(g_wc_cs_orga,g_master.faansite,1) = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_master.faansite
               LET g_errparam.code = 'afa-00291'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_master.faansite = l_site
               CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
               DISPLAY g_master.faansite_desc TO faansite_desc
               NEXT FIELD CURRENT
            END IF
            #161024-00008#2---e---
            LET g_master.faan001 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9018')
            LET g_master.faan002 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9019')
            CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
            DISPLAY g_master.faansite_desc TO faansite_desc
            DISPLAY g_master.faan001,g_master.faan002 TO faan001,faan002            

         BEFORE FIELD faan001
            LET l_faan001 = g_master.faan001

         ON CHANGE faan001
            IF NOT cl_null(g_master.faan001) THEN
               CALL afap310_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = g_master.faan001
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.faan001 = l_faan001
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_master.faan002) THEN
                  CALL afap310_b_fill()
               END IF
            END IF

         BEFORE FIELD faan002
            LET l_faan002 = g_master.faan002

         ON CHANGE faan002
            IF NOT cl_null(g_master.faan002) THEN
               CALL afap310_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = g_master.faan002
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.faan002 = l_faan002
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_master.faan001) THEN
                  CALL afap310_b_fill()
               END IF
            END IF
               
         ON ACTION controlp INFIELD faansite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.faansite             #給予default值
            LET g_qryparam.where = " ooef201 = 'Y' "
             #160125-00005#7--add--str--
             IF NOT cl_null(g_wc_cs_orga) THEN
			       LET g_qryparam.where = g_wc_cs_orga
			    END IF
			    #160125-00005#7--add--end               
            #CALL q_ooef001()                                #呼叫開窗 #161024-00008#2
            CALL q_ooef001_47()                                       #161024-00008#2
            #161024-00008#2 
            LET g_master.faansite = g_qryparam.return1               
            DISPLAY g_master.faansite TO faansite              #
            CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
            DISPLAY BY NAME g_master.faansite_desc
            NEXT FIELD faansite                         #返回原欄位
 
         END INPUT
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE) 
            ON CHANGE sel
               LET l_ac = ARR_CURR()

               
               #因更新aoos020时是根据主帐套的归属法人更新的，所以需确保勾选的归属法人有勾选主帐套资料，不然不可月结
               #如果更新为N时，检查该帐套是否是主帐套
               #若非主帐套，则可取消勾选
               #若是主帐套，则需检查该归属法人下的非主帐套是否勾选
               #若勾选则不可取消勾选，若没有勾选则可取消     
               SELECT glaacomp,glaa014 INTO g_glaa.glaacomp,g_glaa.glaa014 FROM glaa_t 
                WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_ac].glaald
               LET l_cnt = 0
               FOR l_i = 1 TO g_detail_d.getLength()
                  IF g_detail_d[l_i].sel = "Y" THEN
                     IF g_glaa.glaacomp = g_detail_d[l_i].glaacomp THEN
                        LET l_cnt = l_cnt + 1
                     END IF
                  END IF                        
               END FOR                  
               IF g_detail_d[l_ac].sel = 'N' THEN
                  IF g_glaa.glaa014 = 'Y' THEN                  
                     IF l_cnt >= 1 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00407'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        LET g_detail_d[l_ac].sel = 'Y'                   
                     END IF 
                  END IF   
               ELSE
                  IF g_glaa.glaa014 = 'N' THEN
                     IF l_cnt <= 1 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00411'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        LET g_detail_d[l_ac].sel = 'N'                   
                     END IF 
                  END IF                     
               END IF
               DISPLAY g_detail_d[l_ac].sel TO sel
               #NEXT FIELD sel   #20150525 mark lujh
                  
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  #CALL afap310_clik_chk(l_ac)   #170104-00050#1 mark
                  CALL afap310_clik_chk(g_detail_d[l_ac].glaald,l_ac) #170104-00050#1 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_detail_d[l_ac].sel = 'N'
                     DISPLAY g_detail_d[l_ac].sel TO sel
                     NEXT FIELD sel                     
                  END IF
               END IF  
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
      
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
#20150525--unmark--str--lujh
               #CALL afap310_clik_chk(li_idx)    #170104-00050#1 mark
               CALL afap310_clik_chk(g_detail_d[li_idx].glaald,li_idx)  #170104-00050#1 add
               IF NOT cl_null(g_errno) THEN
                  LET g_detail_d[li_idx].sel = 'N'                    
               END IF
#20150525--unmark--end--lujh
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
                  #CALL afap310_clik_chk(li_idx)    #170104-00050#1 mark
                  CALL afap310_clik_chk(g_detail_d[li_idx].glaald,li_idx)  #170104-00050#1 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_detail_d[li_idx].sel = 'N'                     
                  END IF
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afap310_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL afap310_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap310_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL afap310_cycle_ld()
            CALL afap310_b_fill()            
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afap310.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap310_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL afap310_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap310_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_ooef017        LIKE ooef_t.ooef017
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_glaa003        LIKE glaa_t.glaa003
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
   DEFINE l_success        LIKE type_t.chr1 
   DEFINE l_ld_str         STRING                 #160125-00005#7    
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#160125-00005#7--mod--str
#   #取得帳務組織下所屬成員
#   CALL s_fin_account_center_sons_query('3',g_master.faansite,g_today,'1')
#   #取得帳務組織下所屬成員之帳別   
#   CALL s_fin_account_center_ld_str() RETURNING ls_wc
#   #將取回的字串轉換為SQL條件
#   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
#
# 
#   LET g_sql =" SELECT 'Y',glaald,'',glaacomp,'',glaa001,'','' FROM glaa_t ",
#              "  WHERE glaaent = ? ",
#              "    AND glaald IN ",ls_wc,    
#              "  ORDER BY glaald,glaacomp "
   CALL s_fin_account_center_sons_query('5',g_master.faansite,g_today,'1')
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
   LET ls_wc=ls_wc.substring(3,ls_wc.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,ls_wc,'2')  RETURNING l_ld_str 
   
   LET g_sql =" SELECT 'Y',glaald,'',glaacomp,'' FROM glaa_t ",
              "  WHERE glaaent = ? "
              
   IF NOT cl_null(l_ld_str) THEN   
      LET g_sql = g_sql, " AND ",l_ld_str
   END IF
   LET g_sql = g_sql,"  ORDER BY glaald,glaacomp "      
#160125-00005#7--mod--end 

 
   #end add-point
 
   PREPARE afap310_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap310_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].glaald,g_detail_d[l_ac].glaald_desc,
   g_detail_d[l_ac].glaacomp,g_detail_d[l_ac].glaacomp_desc,g_detail_d[l_ac].glaa001,
   g_detail_d[l_ac].bdate,g_detail_d[l_ac].edate
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      CALL s_axrt300_xrca_ref('xrcald',g_detail_d[l_ac].glaald,'','')
         RETURNING l_success,g_detail_d[l_ac].glaald_desc
      LET g_detail_d[l_ac].glaald_desc = g_detail_d[l_ac].glaald,"(",g_detail_d[l_ac].glaald_desc,")"

      CALL s_axrt300_xrca_ref('xrcasite',g_detail_d[l_ac].glaacomp,'','')
         RETURNING l_success,g_detail_d[l_ac].glaacomp_desc
      LET g_detail_d[l_ac].glaacomp_desc = g_detail_d[l_ac].glaacomp,"(",g_detail_d[l_ac].glaacomp_desc,")"       
      
      SELECT MAX(faan001 ||'/'||faan002) INTO g_detail_d[l_ac].period
        FROM faan_t
       WHERE faanent = g_enterprise
         AND faanld  = g_detail_d[l_ac].glaald
       GROUP BY faanld,faancomp
       
      LET l_glaa003 = NULL   
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_detail_d[l_ac].glaald,'glaa003')
               RETURNING  g_sub_success,l_glaa003
      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(l_glaa003,'',g_master.faan001,g_master.faan002)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                   l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e 
      LET g_detail_d[l_ac].bdate = l_pdate_s
      LET g_detail_d[l_ac].edate = l_pdate_e
      
      #20150525--add--str--lujh
      #CALL afap310_clik_chk(l_ac) #170104-00050#1 mark
      CALL afap310_clik_chk(g_detail_d[l_ac].glaald,l_ac)  #170104-00050#1 add      
      IF NOT cl_null(g_errno) THEN
         LET g_detail_d[l_ac].sel = 'N'                    
      END IF
      #20150525--add--end--lujh
      #end add-point
      
      CALL afap310_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afap310_sel
   
   LET l_ac = 1
   CALL afap310_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap310.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap310_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afap310.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap310_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap310.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap310_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL afap310_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap310.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap310_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="afap310.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap310_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = afap310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap310.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap310_def()
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_def()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_flag            LIKE type_t.dat

   IF NOT cl_null(g_master.faansite) THEN RETURN END IF
   #帳務中心
   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING l_success,g_master.faansite,g_errno
   CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc

#   LET l_flag = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9003')   #关账日期
#
#   LET g_master.faan001 = YEAR(l_flag)
#   LET g_master.faan002 = MONTH(l_flag)
    LET g_master.faan001 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9018')
    LET g_master.faan002 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9019')
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap310_date_chk()
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_faan001      LIKE faan_t.faan001
   DEFINE l_faan002      LIKE faan_t.faan002

   IF cl_null(g_master.faansite) THEN RETURN END IF
   IF cl_null(g_master.faan001) THEN RETURN END IF
   IF cl_null(g_master.faan002) THEN RETURN END IF

   LET l_flag = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9003')   #关账日期

   LET l_faan001 = YEAR(l_flag)
   LET l_faan002 = MONTH(l_flag)

   LET g_errno = ' '
   IF g_master.faan001 < l_faan001 THEN
      LET g_errno = 'anm-00248'
   END IF

   IF g_master.faan001 = l_faan001  AND g_master.faan002 < l_faan002 THEN
      LET g_errno = 'anm-00249'
   END IF
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap310_clik_chk(p_ld,p_ac)
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_clik_chk(p_ld,p_ac)
   DEFINE p_ac      LIKE type_t.num5
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_yy      LIKE faan_t.faan001
   DEFINE l_mm      LIKE faan_t.faan002
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_month   LIKE type_t.chr20   #20150525 add lujh
   #170104-00050#1 add s---
   DEFINE l_yy1     STRING 
   DEFINE l_mm1     STRING 
   DEFINE l_ym      STRING  
   DEFINE l_faah015 LIKE faah_t.faah015 
   DEFINE l_faah006 LIKE faah_t.faah006
   DEFINE l_faah003 LIKE faah_t.faah003
   DEFINE l_faah004 LIKE faah_t.faah004
   DEFINE l_faah001 LIKE faah_t.faah001
   DEFINE l_faal002 LIKE faal_t.faal002 
   DEFINE p_ld      LIKE glaa_t.glaald
   DEFINE l_sql     STRING 
   #170104-00050#1 add e---
     
   
   LET g_errno = NULL
   IF cl_null(p_ac) OR p_ac <= 0 THEN
      RETURN 
   END IF
   
#   #现行年度期别跟单头输入的会计年度期别不一致
#   LET l_yy = NULL
#   LET l_mm = NULL
#   LET l_yy = cl_get_para(g_enterprise,g_detail_d[p_ac].glaacomp,'S-FIN-9018')
#   LET l_mm = cl_get_para(g_enterprise,g_detail_d[p_ac].glaacomp,'S-FIN-9019')
#   IF l_yy != g_master.faan001 AND l_mm != g_master.faan002 THEN
#      LET g_errno   = 'afa-00308'
#      RETURN   
#   END IF   
   
   #檢核 帳別+年度+期別 有存在就提示要做還原
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM faan_t
    WHERE faanent = g_enterprise
      AND faanld  = g_detail_d[p_ac].glaald
      AND faan001 = g_master.faan001
      AND faan002 = g_master.faan002
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET g_errno   = 'afa-00304'
      RETURN
   END IF
   

   
#170104-00050#1 mod s---
#   #20150126 add by chenying
#   #不存在折旧档faam，不可月结
#   #20150612--add--str--lujh
#      LET l_count = 0
#      SELECT COUNT(*) INTO l_count FROM faam_t
#       WHERE faament = g_enterprise
#         AND faamld = g_detail_d[p_ac].glaald
#      IF l_count > 0 THEN
#      #20150612--add--end--lujh
#         LET l_count = 0
#         SELECT COUNT(*) INTO l_count FROM faam_t
#          WHERE faament = g_enterprise
#            AND faamld = g_detail_d[p_ac].glaald
#            AND faam004 = g_master.faan001
#            AND faam005 = g_master.faan002
#         IF cl_null(l_count) THEN LET l_count = 0 END IF
#         IF l_count = 0 THEN
#            LET g_errno   = 'afa-00410'
#            RETURN
#         END IF
#      END IF #20150612 add lujh
#   #20150126 add by chenying
#170104-00050#1 mod e---



   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM faan_t
    WHERE faanent = g_enterprise 
      AND faanld  = g_detail_d[p_ac].glaald
   IF l_cnt > 0 THEN     
      #檢核 帳別+年度+期別 是否跨期别月结
      LET l_count = NULL
      LET l_yy = NULL
      LET l_mm = NULL
      IF g_master.faan002 = 1 THEN 
         LET l_yy = g_master.faan001 - 1
         LET l_mm = 12
      ELSE
         LET l_yy = g_master.faan001 
         LET l_mm = g_master.faan002 - 1               
      END IF  
      
      SELECT COUNT(*) INTO l_count FROM faan_t
       WHERE faanent = g_enterprise
         AND faanld  = g_detail_d[p_ac].glaald
         AND faan001 = l_yy
         AND faan002 = l_mm
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET g_errno   = 'afa-00308'  
         RETURN
      END IF 
   END IF    


   #170104-00050#1 add s---
   IF NOT cl_null(p_ld) THEN 
      LET l_yy1 = g_master.faan001 
      LET l_yy1 = l_yy1.trim()
      LET l_yy1 = l_yy1 USING "&&&&"
      LET l_mm1 = g_master.faan002
      LET l_mm1 = l_mm1.trim() 
      LET l_mm1 = l_mm1 USING "&&"
      LET l_ym = l_yy1,l_mm1
       
      #筛选所有当月需要折旧的资产 
      LET l_sql = " SELECT faah015,faah006,faah003,faah004,faah001 ",   
                  "   FROM faah_t,faaj_t ",
                  "  WHERE faahent = faajent AND faah000 =faaj000",
                  "    AND faah003 = faaj001 AND faah004 = faaj002",
                  "    AND faah001 = faaj037 ", 
                  "    AND faahent = '",g_enterprise,"'",
                  "    AND faajld  = '",p_ld,"'",
                  "    AND faah015 NOT IN ('0','4','5','6','7','10' )",  
                  "    AND faah042 NOT IN ('2','5')",
                  "    AND faaj038 NOT IN ('4','7')", 
                  "    AND (faaj028 - faaj021-faaj027 ) > 0 AND faahstus = 'Y' ",
                  "    AND faaj008 <= '",l_ym,"'", 
                  "    AND faah006 NOT IN (SELECT DISTINCT faac001 FROM faac_t WHERE faacent = faahent AND faah006 = faac001 AND faac003 =5)", #20150825 
                  "    AND faaj003 != 5 ",         
                  "    AND faaj048 ='2' "   
      LET l_sql = l_sql CLIPPED," UNION ", 
                  " SELECT faah015,faah006,faah003,faah004,faah001 ",                  
                  "   FROM faah_t,faaj_t ",
                  "  WHERE faahent = faajent AND faah000 =faaj000",
                  "    AND faah003 = faaj001 AND faah004 = faaj002",
                  "    AND faah001 = faaj037 ",  
                  "    AND faahent = '",g_enterprise,"'",
                  "    AND faajld  = '",p_ld,"'",  
                  "    AND faah015 IN ('7' )",  
                  "    AND faaj038 IN ('7' )",   
                  "    AND faahstus = 'Y' ",                
                  "    AND faah006 NOT IN (SELECT DISTINCT faac001 FROM faac_t WHERE faacent = faahent AND faah006 = faac001 AND faac003 =5)" ,#20150825
                  "    AND faaj008 <= '",l_ym,"'",  
                  "    AND faaj003 != 5 ",          
                  "    AND faaj048 ='2' "  
      PREPARE afap310_sel_faah FROM l_sql
      DECLARE afap310_fill_cur_faah CURSOR FOR afap310_sel_faah
      
      #判断它们存不存在faam
      LET g_sql =  " SELECT COUNT(*) FROM faam_t",
                   "  WHERE faament = '",g_enterprise,"'",
                   "    AND faamld = '",p_ld,"'",
                   "    AND faam004 = ",g_master.faan001,
                   "    AND faam005 = ",g_master.faan002,
                   "    AND faam001 = ?",
                   "    AND faam002 = ?",
                   "    AND faam000 = ?"
      PREPARE afap310_sel_faam FROM g_sql
      
      #检查已停用资产是否计提折旧
      LET g_sql = " SELECT faal002 FROM faal_t WHERE faalent = ",g_enterprise," AND faalld = '",p_ld,"' AND faal001 = ?"
      PREPARE afap310_sel_faal FROM g_sql
      
      LET l_count = 0
      FOREACH afap310_fill_cur_faah INTO l_faah015,l_faah006,l_faah003,l_faah004,l_faah001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cur_faah:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF  
         
         EXECUTE afap310_sel_faam USING l_faah003,l_faah004,l_faah001 INTO l_count 
         
         #非停用资产
         IF l_faah015 <> '8' THEN 
            IF l_count = 0 THEN
               LET g_errno   = 'afa-00410'
               RETURN         
            END IF 
         ELSE
            #停用资产
            EXECUTE afap310_sel_faal USING l_faah006 INTO l_faal002
            IF l_faal002 = 'Y' AND l_count = 0 THEN 
               LET g_errno   = 'afa-00410'
               RETURN              
            END IF         
         END IF      
      END FOREACH
   END IF   
   #170104-00050#1 add e--- 
   
   #20150525--add--str--lujh
   #执行本月月结时检核次月是否有折旧、出售等各类异动，有就不能执行。
   IF g_master.faan002 = '12' THEN 
      LET l_yy = g_master.faan001 + 1
      LET l_mm = 1
   ELSE
      LET l_yy = g_master.faan001
      LET l_mm = g_master.faan002 + 1
   END IF
   
   LET l_month = l_mm
   IF l_month < 10 THEN 
      LET l_month = '0' CLIPPED,l_month
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabh_t 
    WHERE fabgent = g_enterprise
      AND fabgent = fabhent 
      AND fabgld = fabhld 
      AND fabgdocno = fabhdocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabhld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'     #161020-00010#1 add lujh
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabb_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabbent 
      AND fabadocno = fabbdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   #20150525--add--str--lujh
   
   #20151008--add--str--lujh
   #外送,外送收回
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabk_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabkent 
      AND fabadocno = fabkdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   #资本化
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabj_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabjent 
      AND fabadocno = fabjdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   #合并,分割
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabl_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fablent 
      AND fabadocno = fabldocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabm_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabment 
      AND fabadocno = fabmdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   #折毕再提
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabd_t 
    WHERE fabgent = g_enterprise
      AND fabgent = fabdent 
      AND fabgld = fabdld 
      AND fabgdocno = fabddocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabgld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   #出售
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabo_t 
    WHERE fabgent = g_enterprise
      AND fabgent = faboent 
      AND fabgld = fabold 
      AND fabgdocno = fabodocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabgld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   #抵押,解除抵押
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabq_t 
    WHERE fabgent = g_enterprise
      AND fabgent = fabqent 
      AND fabgld = fabqld 
      AND fabgdocno = fabqdocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabgld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   
   #盘点
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabr_t
    WHERE fabrent = g_enterprise
      AND TO_CHAR(fabr031,'YYYY') = l_yy
      AND TO_CHAR(fabr031,'MM') = l_month
      AND fabrcomp = g_detail_d[p_ac].glaald
      AND fabrstus <> 'X'     #161020-00010#1 add lujh 
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01019'  
      RETURN
   END IF
   #20151008--add--end--lujh
   
  
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap310_cycle_ld()
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_cycle_ld()
   DEFINE l_colname_1     STRING  
   DEFINE l_comment_1     STRING  
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_flag1     LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   CALL s_transaction_begin()  #事务开始
   CALL cl_err_collect_init()  #汇总错误讯息初始化
   CALL s_azzi902_get_gzzd('afat504',"lbl_fabgdocno") RETURNING l_colname_1,l_comment_1  #异动单号
   LET g_coll_title[1] = l_colname_1
   
   LET g_success = 'Y'
   LET l_flag = FALSE #是否產生資料
   LET l_flag1 = FALSE #是否勾選拋轉帳套
      
   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = "Y" THEN
         LET l_flag1 = TRUE
         #檢查是否已有月結資料產生
         #CALL afap310_clik_chk(l_i)                        #170104-00050#1 mark
         CALL afap310_clik_chk(g_detail_d[l_i].glaald,l_i)  #170104-00050#1 add
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_detail_d[l_i].glaald
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            CONTINUE FOR
         END IF
      END IF   
   END FOR      
   
   IF g_success = 'Y' THEN
      FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = "Y" THEN   
      #161215-00044#1---modify----begin-----------------
      #   SELECT * INTO g_glaa.* 
         SELECT glaaent,glaaownid,glaaowndp,glaacrtid,
             glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
             glaa001,glaa002,glaa003,glaa004,glaa005,
             glaa006,glaa007,glaa008,glaa009,glaa010,
             glaa011,glaa012,glaa013,glaa014,glaa015,
             glaa016,glaa017,glaa018,glaa019,glaa020,
             glaa021,glaa022,glaa023,glaa024,glaa025,
             glaa026,glaa100,glaa101,glaa102,glaa103,
             glaa111,glaa112,glaa113,glaa120,glaa121,
             glaa122,glaa027,glaa130,glaa131,glaa132,
             glaa133,glaa134,glaa135,glaa136,glaa137,
             glaa138,glaa139,glaa140,glaa123,glaa124,
             glaa028 
        INTO g_glaa.glaaent,g_glaa.glaaownid,g_glaa.glaaowndp,g_glaa.glaacrtid,
             g_glaa.glaacrtdp,g_glaa.glaacrtdt,g_glaa.glaamodid,g_glaa.glaamoddt,g_glaa.glaastus,g_glaa.glaald,g_glaa.glaacomp,
             g_glaa.glaa001,g_glaa.glaa002,g_glaa.glaa003,g_glaa.glaa004,g_glaa.glaa005,
             g_glaa.glaa006,g_glaa.glaa007,g_glaa.glaa008,g_glaa.glaa009,g_glaa.glaa010,
             g_glaa.glaa011,g_glaa.glaa012,g_glaa.glaa013,g_glaa.glaa014,g_glaa.glaa015,
             g_glaa.glaa016,g_glaa.glaa017,g_glaa.glaa018,g_glaa.glaa019,g_glaa.glaa020,
             g_glaa.glaa021,g_glaa.glaa022,g_glaa.glaa023,g_glaa.glaa024,g_glaa.glaa025,
             g_glaa.glaa026,g_glaa.glaa100,g_glaa.glaa101,g_glaa.glaa102,g_glaa.glaa103,
             g_glaa.glaa111,g_glaa.glaa112,g_glaa.glaa113,g_glaa.glaa120,g_glaa.glaa121,
             g_glaa.glaa122,g_glaa.glaa027,g_glaa.glaa130,g_glaa.glaa131,g_glaa.glaa132,
             g_glaa.glaa133,g_glaa.glaa134,g_glaa.glaa135,g_glaa.glaa136,g_glaa.glaa137,
             g_glaa.glaa138,g_glaa.glaa139,g_glaa.glaa140,g_glaa.glaa123,g_glaa.glaa124,
             g_glaa.glaa028
         FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_i].glaald
         #CALL afap310_get_faan(g_detail_d[l_i].glaald,g_detail_d[l_i].glaacomp,g_detail_d[l_i].bdate,g_detail_d[l_i].edate)  #160426-00014#25 mark
         CALL afap310_get_faan2(g_detail_d[l_i].glaald,g_detail_d[l_i].glaacomp,g_detail_d[l_i].bdate,g_detail_d[l_i].edate) #160426-00014#25 add
         IF g_success = 'Y' AND l_flag=FALSE THEN
            #判斷是否產生月結資料
            SELECT COUNT(*) INTO l_cnt FROM faan_t 
            WHERE faanent = g_enterprise AND faanld = g_detail_d[l_i].glaald
              AND faan001 = g_master.faan001
              AND faan002 = g_master.faan002
            IF l_cnt> 0 THEN
               LET l_flag=TRUE
            END IF
         END IF    
      END IF
      END FOR 
   END IF      
    
   #提示選取預處理資料
   IF l_flag1 = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = '-400'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   #判斷是否產生月結資料
   IF g_success = 'Y' AND l_flag1 = TRUE AND l_flag=FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axc-00530'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF  

   IF g_success = 'N' THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axm-00088'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
   END IF
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap310_get_faan(p_glaald,p_glaacomp,p_bdate,p_edate)
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_get_faan(p_glaald,p_glaacomp,p_bdate,p_edate)
DEFINE p_glaald   LIKE glaa_t.glaald
DEFINE p_glaacomp LIKE glaa_t.glaacomp
DEFINE p_bdate    LIKE type_t.dat
DEFINE p_edate    LIKE type_t.dat
#161215-00044#1---modify----begin-----------------
#DEFINE l_faan     RECORD LIKE faan_t.*
#DEFINE l_faan_qc  RECORD LIKE faan_t.*
#DEFINE l_faan_yd  RECORD LIKE faan_t.*
#DEFINE l_faan_qm  RECORD LIKE faan_t.*
#DEFINE l_faah     RECORD LIKE faah_t.*
#DEFINE l_fabh     RECORD LIKE fabh_t.*
#DEFINE l_faam     RECORD LIKE faam_t.*
#DEFINE l_faaj     RECORD LIKE faaj_t.*
 DEFINE l_faan RECORD  #資產月結檔
        faanent LIKE faan_t.faanent, #企业编码
        faancomp LIKE faan_t.faancomp, #法人
        faansite LIKE faan_t.faansite, #资产中心
        faan001 LIKE faan_t.faan001, #年度
        faan002 LIKE faan_t.faan002, #月份
        faan003 LIKE faan_t.faan003, #卡片编号
        faan004 LIKE faan_t.faan004, #财产编号
        faan005 LIKE faan_t.faan005, #附号
        faan006 LIKE faan_t.faan006, #数量
        faan007 LIKE faan_t.faan007, #资产状态
        faan008 LIKE faan_t.faan008, #外送数量
        faanld LIKE faan_t.faanld, #账套
        faan010 LIKE faan_t.faan010, #币种
        faan011 LIKE faan_t.faan011, #汇率
        faan012 LIKE faan_t.faan012, #耐用年限
        faan013 LIKE faan_t.faan013, #未使用年限
        faan014 LIKE faan_t.faan014, #账面余额
        faan015 LIKE faan_t.faan015, #账面净值
        faan016 LIKE faan_t.faan016, #账面价值
        faan017 LIKE faan_t.faan017, #本月折旧
        faan018 LIKE faan_t.faan018, #累计折旧
        faan019 LIKE faan_t.faan019, #已计提减值准备金额
        faan020 LIKE faan_t.faan020, #预留残值
        faan030 LIKE faan_t.faan030, #重估数量
        faan031 LIKE faan_t.faan031, #重估成本
        faan032 LIKE faan_t.faan032, #重估异动累计折旧
        faan033 LIKE faan_t.faan033, #重估异动年限
        faan034 LIKE faan_t.faan034, #重估异动预留残值
        faan035 LIKE faan_t.faan035, #重估未折减额
        faan040 LIKE faan_t.faan040, #内部销售数量
        faan041 LIKE faan_t.faan041, #内部销售成本
        faan042 LIKE faan_t.faan042, #内部销售累计折旧
        faan043 LIKE faan_t.faan043, #内部销售计提减值准备
        faan044 LIKE faan_t.faan044, #内部销售预留残值
        faan045 LIKE faan_t.faan045, #内部销售未折减额
        faan050 LIKE faan_t.faan050, #销账数量
        faan051 LIKE faan_t.faan051, #销账成本
        faan052 LIKE faan_t.faan052, #销账累计折旧
        faan053 LIKE faan_t.faan053, #销账已计提减值准备
        faan054 LIKE faan_t.faan054, #销账预留残值
        faan055 LIKE faan_t.faan055, #销账未折减额
        faan060 LIKE faan_t.faan060, #报废数量
        faan061 LIKE faan_t.faan061, #报废成本
        faan062 LIKE faan_t.faan062, #报废累计折旧
        faan063 LIKE faan_t.faan063, #报废计提减值准备
        faan064 LIKE faan_t.faan064, #报废预留残值
        faan065 LIKE faan_t.faan065, #报废未折减额
        faan070 LIKE faan_t.faan070, #改良数量
        faan071 LIKE faan_t.faan071, #改良成本
        faan072 LIKE faan_t.faan072, #改良异动未用年限
        faan073 LIKE faan_t.faan073, #改良异动预留残值
        faan074 LIKE faan_t.faan074, #改良未折减额
        faan080 LIKE faan_t.faan080, #一般销售数量
        faan081 LIKE faan_t.faan081, #一般销售成本
        faan082 LIKE faan_t.faan082, #一般销售累计折旧
        faan083 LIKE faan_t.faan083, #一般销售计提减值准备
        faan084 LIKE faan_t.faan084, #一般销售预留残值
        faan085 LIKE faan_t.faan085, #一般销售未折减额
        faan090 LIKE faan_t.faan090, #折毕再提预留残值
        faan091 LIKE faan_t.faan091, #折毕再提未用年限
        faan092 LIKE faan_t.faan092, #减值准备金额
        faan100 LIKE faan_t.faan100, #本位币二币种
        faan101 LIKE faan_t.faan101, #本位币二汇率
        faan102 LIKE faan_t.faan102, #本位币二账面余额
        faan103 LIKE faan_t.faan103, #本位币二账面净值
        faan104 LIKE faan_t.faan104, #本位币二账面价值
        faan105 LIKE faan_t.faan105, #本位币二本月折旧
        faan106 LIKE faan_t.faan106, #本位币二累计折旧
        faan107 LIKE faan_t.faan107, #本位币二减值准备金额
        faan108 LIKE faan_t.faan108, #本位币二预留残值
        faan120 LIKE faan_t.faan120, #本位币二重估成本
        faan121 LIKE faan_t.faan121, #本位币二重估异动累计折旧
        faan122 LIKE faan_t.faan122, #本位币二重估已计提减值准备
        faan123 LIKE faan_t.faan123, #本位币二重估预留残值
        faan124 LIKE faan_t.faan124, #本位币二重估未折减额
        faan130 LIKE faan_t.faan130, #本位币二内部销售成本
        faan131 LIKE faan_t.faan131, #本位币二内部销售累折
        faan132 LIKE faan_t.faan132, #本位币二内部销售计提减值准备
        faan133 LIKE faan_t.faan133, #本位币二内部销售预留残值
        faan134 LIKE faan_t.faan134, #本位币二内部销售未折减额
        faan140 LIKE faan_t.faan140, #本位币二销账成本
        faan141 LIKE faan_t.faan141, #本位币二销账累计折旧
        faan142 LIKE faan_t.faan142, #本位币二销账已计提减值准备
        faan143 LIKE faan_t.faan143, #本位币二销账预留残值
        faan144 LIKE faan_t.faan144, #本位币二销账未折减额
        faan150 LIKE faan_t.faan150, #本位币二报废成本
        faan151 LIKE faan_t.faan151, #本位币二报废累计折旧
        faan152 LIKE faan_t.faan152, #本位币二报废计提减值准备
        faan153 LIKE faan_t.faan153, #本位币二报废预留残值
        faan154 LIKE faan_t.faan154, #本位币二报废未折减额
        faan160 LIKE faan_t.faan160, #本位币二改良成本
        faan161 LIKE faan_t.faan161, #本位币二改良异动预留残值
        faan162 LIKE faan_t.faan162, #本位币二改良未折减额
        faan170 LIKE faan_t.faan170, #本位币二一般销售成本
        faan171 LIKE faan_t.faan171, #本位币二一般销售累计折旧
        faan172 LIKE faan_t.faan172, #本位币二一般销售计提减值准备
        faan173 LIKE faan_t.faan173, #本位币二一般销售预留残值
        faan174 LIKE faan_t.faan174, #本位币二一般销售未折减额
        faan190 LIKE faan_t.faan190, #本位币二折毕再提预留残值
        faan191 LIKE faan_t.faan191, #本位币二减值准备金额
        faan200 LIKE faan_t.faan200, #本位币三币种
        faan201 LIKE faan_t.faan201, #本位币三汇率
        faan202 LIKE faan_t.faan202, #本位币三账面余额
        faan203 LIKE faan_t.faan203, #本位币三账面净值
        faan204 LIKE faan_t.faan204, #本位币三账面价值
        faan205 LIKE faan_t.faan205, #本位币三本月折旧
        faan206 LIKE faan_t.faan206, #本位币三累计折旧
        faan207 LIKE faan_t.faan207, #本位币三减值准备
        faan208 LIKE faan_t.faan208, #本位币三预留残值
        faan220 LIKE faan_t.faan220, #本位币三重估成本
        faan221 LIKE faan_t.faan221, #本位币三重估异动累计折旧
        faan222 LIKE faan_t.faan222, #本位币二重估已计提减值准备
        faan223 LIKE faan_t.faan223, #本位币三重估异动预留残值
        faan224 LIKE faan_t.faan224, #本位币三重估后未折减额
        faan230 LIKE faan_t.faan230, #本位币三内部销售成本
        faan231 LIKE faan_t.faan231, #本位币三内部销售累折
        faan232 LIKE faan_t.faan232, #本位币三内部销售计提减值准备
        faan233 LIKE faan_t.faan233, #本位币三内部销售预留残值
        faan234 LIKE faan_t.faan234, #本位币三内部销售未折减额
        faan240 LIKE faan_t.faan240, #本位币三销账成本
        faan241 LIKE faan_t.faan241, #本位币三销账累折
        faan242 LIKE faan_t.faan242, #本位币三销账计提减值准备
        faan243 LIKE faan_t.faan243, #本位币三销账预留残值
        faan244 LIKE faan_t.faan244, #本位币三销账未折减额
        faan250 LIKE faan_t.faan250, #本位币三报废成本
        faan251 LIKE faan_t.faan251, #本位币三报废累折
        faan252 LIKE faan_t.faan252, #本位币三报废计提减值准备
        faan253 LIKE faan_t.faan253, #本位币三报废预留残值
        faan254 LIKE faan_t.faan254, #本位币三报废未折减额
        faan260 LIKE faan_t.faan260, #本位币三改良成本
        faan261 LIKE faan_t.faan261, #本位币三改良异动预留残值
        faan262 LIKE faan_t.faan262, #本位币三改良未折减额
        faan270 LIKE faan_t.faan270, #本位币三一般销售成本
        faan271 LIKE faan_t.faan271, #本位币三一般销售累折
        faan272 LIKE faan_t.faan272, #本位币三一般销售计提减值准备
        faan273 LIKE faan_t.faan273, #本位币三一般销售预留残值
        faan274 LIKE faan_t.faan274, #本位币三一般销售未折减额
        faan290 LIKE faan_t.faan290, #本位币三折毕再提预留残值
        faan291 LIKE faan_t.faan291, #本位币三减值准备金额
        faan009 LIKE faan_t.faan009 #列账/列管
 END RECORD
 DEFINE l_faan_qc RECORD  #資產月結檔
        faanent LIKE faan_t.faanent, #企业编码
        faancomp LIKE faan_t.faancomp, #法人
        faansite LIKE faan_t.faansite, #资产中心
        faan001 LIKE faan_t.faan001, #年度
        faan002 LIKE faan_t.faan002, #月份
        faan003 LIKE faan_t.faan003, #卡片编号
        faan004 LIKE faan_t.faan004, #财产编号
        faan005 LIKE faan_t.faan005, #附号
        faan006 LIKE faan_t.faan006, #数量
        faan007 LIKE faan_t.faan007, #资产状态
        faan008 LIKE faan_t.faan008, #外送数量
        faanld LIKE faan_t.faanld, #账套
        faan010 LIKE faan_t.faan010, #币种
        faan011 LIKE faan_t.faan011, #汇率
        faan012 LIKE faan_t.faan012, #耐用年限
        faan013 LIKE faan_t.faan013, #未使用年限
        faan014 LIKE faan_t.faan014, #账面余额
        faan015 LIKE faan_t.faan015, #账面净值
        faan016 LIKE faan_t.faan016, #账面价值
        faan017 LIKE faan_t.faan017, #本月折旧
        faan018 LIKE faan_t.faan018, #累计折旧
        faan019 LIKE faan_t.faan019, #已计提减值准备金额
        faan020 LIKE faan_t.faan020, #预留残值
        faan030 LIKE faan_t.faan030, #重估数量
        faan031 LIKE faan_t.faan031, #重估成本
        faan032 LIKE faan_t.faan032, #重估异动累计折旧
        faan033 LIKE faan_t.faan033, #重估异动年限
        faan034 LIKE faan_t.faan034, #重估异动预留残值
        faan035 LIKE faan_t.faan035, #重估未折减额
        faan040 LIKE faan_t.faan040, #内部销售数量
        faan041 LIKE faan_t.faan041, #内部销售成本
        faan042 LIKE faan_t.faan042, #内部销售累计折旧
        faan043 LIKE faan_t.faan043, #内部销售计提减值准备
        faan044 LIKE faan_t.faan044, #内部销售预留残值
        faan045 LIKE faan_t.faan045, #内部销售未折减额
        faan050 LIKE faan_t.faan050, #销账数量
        faan051 LIKE faan_t.faan051, #销账成本
        faan052 LIKE faan_t.faan052, #销账累计折旧
        faan053 LIKE faan_t.faan053, #销账已计提减值准备
        faan054 LIKE faan_t.faan054, #销账预留残值
        faan055 LIKE faan_t.faan055, #销账未折减额
        faan060 LIKE faan_t.faan060, #报废数量
        faan061 LIKE faan_t.faan061, #报废成本
        faan062 LIKE faan_t.faan062, #报废累计折旧
        faan063 LIKE faan_t.faan063, #报废计提减值准备
        faan064 LIKE faan_t.faan064, #报废预留残值
        faan065 LIKE faan_t.faan065, #报废未折减额
        faan070 LIKE faan_t.faan070, #改良数量
        faan071 LIKE faan_t.faan071, #改良成本
        faan072 LIKE faan_t.faan072, #改良异动未用年限
        faan073 LIKE faan_t.faan073, #改良异动预留残值
        faan074 LIKE faan_t.faan074, #改良未折减额
        faan080 LIKE faan_t.faan080, #一般销售数量
        faan081 LIKE faan_t.faan081, #一般销售成本
        faan082 LIKE faan_t.faan082, #一般销售累计折旧
        faan083 LIKE faan_t.faan083, #一般销售计提减值准备
        faan084 LIKE faan_t.faan084, #一般销售预留残值
        faan085 LIKE faan_t.faan085, #一般销售未折减额
        faan090 LIKE faan_t.faan090, #折毕再提预留残值
        faan091 LIKE faan_t.faan091, #折毕再提未用年限
        faan092 LIKE faan_t.faan092, #减值准备金额
        faan100 LIKE faan_t.faan100, #本位币二币种
        faan101 LIKE faan_t.faan101, #本位币二汇率
        faan102 LIKE faan_t.faan102, #本位币二账面余额
        faan103 LIKE faan_t.faan103, #本位币二账面净值
        faan104 LIKE faan_t.faan104, #本位币二账面价值
        faan105 LIKE faan_t.faan105, #本位币二本月折旧
        faan106 LIKE faan_t.faan106, #本位币二累计折旧
        faan107 LIKE faan_t.faan107, #本位币二减值准备金额
        faan108 LIKE faan_t.faan108, #本位币二预留残值
        faan120 LIKE faan_t.faan120, #本位币二重估成本
        faan121 LIKE faan_t.faan121, #本位币二重估异动累计折旧
        faan122 LIKE faan_t.faan122, #本位币二重估已计提减值准备
        faan123 LIKE faan_t.faan123, #本位币二重估预留残值
        faan124 LIKE faan_t.faan124, #本位币二重估未折减额
        faan130 LIKE faan_t.faan130, #本位币二内部销售成本
        faan131 LIKE faan_t.faan131, #本位币二内部销售累折
        faan132 LIKE faan_t.faan132, #本位币二内部销售计提减值准备
        faan133 LIKE faan_t.faan133, #本位币二内部销售预留残值
        faan134 LIKE faan_t.faan134, #本位币二内部销售未折减额
        faan140 LIKE faan_t.faan140, #本位币二销账成本
        faan141 LIKE faan_t.faan141, #本位币二销账累计折旧
        faan142 LIKE faan_t.faan142, #本位币二销账已计提减值准备
        faan143 LIKE faan_t.faan143, #本位币二销账预留残值
        faan144 LIKE faan_t.faan144, #本位币二销账未折减额
        faan150 LIKE faan_t.faan150, #本位币二报废成本
        faan151 LIKE faan_t.faan151, #本位币二报废累计折旧
        faan152 LIKE faan_t.faan152, #本位币二报废计提减值准备
        faan153 LIKE faan_t.faan153, #本位币二报废预留残值
        faan154 LIKE faan_t.faan154, #本位币二报废未折减额
        faan160 LIKE faan_t.faan160, #本位币二改良成本
        faan161 LIKE faan_t.faan161, #本位币二改良异动预留残值
        faan162 LIKE faan_t.faan162, #本位币二改良未折减额
        faan170 LIKE faan_t.faan170, #本位币二一般销售成本
        faan171 LIKE faan_t.faan171, #本位币二一般销售累计折旧
        faan172 LIKE faan_t.faan172, #本位币二一般销售计提减值准备
        faan173 LIKE faan_t.faan173, #本位币二一般销售预留残值
        faan174 LIKE faan_t.faan174, #本位币二一般销售未折减额
        faan190 LIKE faan_t.faan190, #本位币二折毕再提预留残值
        faan191 LIKE faan_t.faan191, #本位币二减值准备金额
        faan200 LIKE faan_t.faan200, #本位币三币种
        faan201 LIKE faan_t.faan201, #本位币三汇率
        faan202 LIKE faan_t.faan202, #本位币三账面余额
        faan203 LIKE faan_t.faan203, #本位币三账面净值
        faan204 LIKE faan_t.faan204, #本位币三账面价值
        faan205 LIKE faan_t.faan205, #本位币三本月折旧
        faan206 LIKE faan_t.faan206, #本位币三累计折旧
        faan207 LIKE faan_t.faan207, #本位币三减值准备
        faan208 LIKE faan_t.faan208, #本位币三预留残值
        faan220 LIKE faan_t.faan220, #本位币三重估成本
        faan221 LIKE faan_t.faan221, #本位币三重估异动累计折旧
        faan222 LIKE faan_t.faan222, #本位币二重估已计提减值准备
        faan223 LIKE faan_t.faan223, #本位币三重估异动预留残值
        faan224 LIKE faan_t.faan224, #本位币三重估后未折减额
        faan230 LIKE faan_t.faan230, #本位币三内部销售成本
        faan231 LIKE faan_t.faan231, #本位币三内部销售累折
        faan232 LIKE faan_t.faan232, #本位币三内部销售计提减值准备
        faan233 LIKE faan_t.faan233, #本位币三内部销售预留残值
        faan234 LIKE faan_t.faan234, #本位币三内部销售未折减额
        faan240 LIKE faan_t.faan240, #本位币三销账成本
        faan241 LIKE faan_t.faan241, #本位币三销账累折
        faan242 LIKE faan_t.faan242, #本位币三销账计提减值准备
        faan243 LIKE faan_t.faan243, #本位币三销账预留残值
        faan244 LIKE faan_t.faan244, #本位币三销账未折减额
        faan250 LIKE faan_t.faan250, #本位币三报废成本
        faan251 LIKE faan_t.faan251, #本位币三报废累折
        faan252 LIKE faan_t.faan252, #本位币三报废计提减值准备
        faan253 LIKE faan_t.faan253, #本位币三报废预留残值
        faan254 LIKE faan_t.faan254, #本位币三报废未折减额
        faan260 LIKE faan_t.faan260, #本位币三改良成本
        faan261 LIKE faan_t.faan261, #本位币三改良异动预留残值
        faan262 LIKE faan_t.faan262, #本位币三改良未折减额
        faan270 LIKE faan_t.faan270, #本位币三一般销售成本
        faan271 LIKE faan_t.faan271, #本位币三一般销售累折
        faan272 LIKE faan_t.faan272, #本位币三一般销售计提减值准备
        faan273 LIKE faan_t.faan273, #本位币三一般销售预留残值
        faan274 LIKE faan_t.faan274, #本位币三一般销售未折减额
        faan290 LIKE faan_t.faan290, #本位币三折毕再提预留残值
        faan291 LIKE faan_t.faan291, #本位币三减值准备金额
        faan009 LIKE faan_t.faan009 #列账/列管
 END RECORD
 DEFINE l_faan_yd RECORD  #資產月結檔
        faanent LIKE faan_t.faanent, #企业编码
        faancomp LIKE faan_t.faancomp, #法人
        faansite LIKE faan_t.faansite, #资产中心
        faan001 LIKE faan_t.faan001, #年度
        faan002 LIKE faan_t.faan002, #月份
        faan003 LIKE faan_t.faan003, #卡片编号
        faan004 LIKE faan_t.faan004, #财产编号
        faan005 LIKE faan_t.faan005, #附号
        faan006 LIKE faan_t.faan006, #数量
        faan007 LIKE faan_t.faan007, #资产状态
        faan008 LIKE faan_t.faan008, #外送数量
        faanld LIKE faan_t.faanld, #账套
        faan010 LIKE faan_t.faan010, #币种
        faan011 LIKE faan_t.faan011, #汇率
        faan012 LIKE faan_t.faan012, #耐用年限
        faan013 LIKE faan_t.faan013, #未使用年限
        faan014 LIKE faan_t.faan014, #账面余额
        faan015 LIKE faan_t.faan015, #账面净值
        faan016 LIKE faan_t.faan016, #账面价值
        faan017 LIKE faan_t.faan017, #本月折旧
        faan018 LIKE faan_t.faan018, #累计折旧
        faan019 LIKE faan_t.faan019, #已计提减值准备金额
        faan020 LIKE faan_t.faan020, #预留残值
        faan030 LIKE faan_t.faan030, #重估数量
        faan031 LIKE faan_t.faan031, #重估成本
        faan032 LIKE faan_t.faan032, #重估异动累计折旧
        faan033 LIKE faan_t.faan033, #重估异动年限
        faan034 LIKE faan_t.faan034, #重估异动预留残值
        faan035 LIKE faan_t.faan035, #重估未折减额
        faan040 LIKE faan_t.faan040, #内部销售数量
        faan041 LIKE faan_t.faan041, #内部销售成本
        faan042 LIKE faan_t.faan042, #内部销售累计折旧
        faan043 LIKE faan_t.faan043, #内部销售计提减值准备
        faan044 LIKE faan_t.faan044, #内部销售预留残值
        faan045 LIKE faan_t.faan045, #内部销售未折减额
        faan050 LIKE faan_t.faan050, #销账数量
        faan051 LIKE faan_t.faan051, #销账成本
        faan052 LIKE faan_t.faan052, #销账累计折旧
        faan053 LIKE faan_t.faan053, #销账已计提减值准备
        faan054 LIKE faan_t.faan054, #销账预留残值
        faan055 LIKE faan_t.faan055, #销账未折减额
        faan060 LIKE faan_t.faan060, #报废数量
        faan061 LIKE faan_t.faan061, #报废成本
        faan062 LIKE faan_t.faan062, #报废累计折旧
        faan063 LIKE faan_t.faan063, #报废计提减值准备
        faan064 LIKE faan_t.faan064, #报废预留残值
        faan065 LIKE faan_t.faan065, #报废未折减额
        faan070 LIKE faan_t.faan070, #改良数量
        faan071 LIKE faan_t.faan071, #改良成本
        faan072 LIKE faan_t.faan072, #改良异动未用年限
        faan073 LIKE faan_t.faan073, #改良异动预留残值
        faan074 LIKE faan_t.faan074, #改良未折减额
        faan080 LIKE faan_t.faan080, #一般销售数量
        faan081 LIKE faan_t.faan081, #一般销售成本
        faan082 LIKE faan_t.faan082, #一般销售累计折旧
        faan083 LIKE faan_t.faan083, #一般销售计提减值准备
        faan084 LIKE faan_t.faan084, #一般销售预留残值
        faan085 LIKE faan_t.faan085, #一般销售未折减额
        faan090 LIKE faan_t.faan090, #折毕再提预留残值
        faan091 LIKE faan_t.faan091, #折毕再提未用年限
        faan092 LIKE faan_t.faan092, #减值准备金额
        faan100 LIKE faan_t.faan100, #本位币二币种
        faan101 LIKE faan_t.faan101, #本位币二汇率
        faan102 LIKE faan_t.faan102, #本位币二账面余额
        faan103 LIKE faan_t.faan103, #本位币二账面净值
        faan104 LIKE faan_t.faan104, #本位币二账面价值
        faan105 LIKE faan_t.faan105, #本位币二本月折旧
        faan106 LIKE faan_t.faan106, #本位币二累计折旧
        faan107 LIKE faan_t.faan107, #本位币二减值准备金额
        faan108 LIKE faan_t.faan108, #本位币二预留残值
        faan120 LIKE faan_t.faan120, #本位币二重估成本
        faan121 LIKE faan_t.faan121, #本位币二重估异动累计折旧
        faan122 LIKE faan_t.faan122, #本位币二重估已计提减值准备
        faan123 LIKE faan_t.faan123, #本位币二重估预留残值
        faan124 LIKE faan_t.faan124, #本位币二重估未折减额
        faan130 LIKE faan_t.faan130, #本位币二内部销售成本
        faan131 LIKE faan_t.faan131, #本位币二内部销售累折
        faan132 LIKE faan_t.faan132, #本位币二内部销售计提减值准备
        faan133 LIKE faan_t.faan133, #本位币二内部销售预留残值
        faan134 LIKE faan_t.faan134, #本位币二内部销售未折减额
        faan140 LIKE faan_t.faan140, #本位币二销账成本
        faan141 LIKE faan_t.faan141, #本位币二销账累计折旧
        faan142 LIKE faan_t.faan142, #本位币二销账已计提减值准备
        faan143 LIKE faan_t.faan143, #本位币二销账预留残值
        faan144 LIKE faan_t.faan144, #本位币二销账未折减额
        faan150 LIKE faan_t.faan150, #本位币二报废成本
        faan151 LIKE faan_t.faan151, #本位币二报废累计折旧
        faan152 LIKE faan_t.faan152, #本位币二报废计提减值准备
        faan153 LIKE faan_t.faan153, #本位币二报废预留残值
        faan154 LIKE faan_t.faan154, #本位币二报废未折减额
        faan160 LIKE faan_t.faan160, #本位币二改良成本
        faan161 LIKE faan_t.faan161, #本位币二改良异动预留残值
        faan162 LIKE faan_t.faan162, #本位币二改良未折减额
        faan170 LIKE faan_t.faan170, #本位币二一般销售成本
        faan171 LIKE faan_t.faan171, #本位币二一般销售累计折旧
        faan172 LIKE faan_t.faan172, #本位币二一般销售计提减值准备
        faan173 LIKE faan_t.faan173, #本位币二一般销售预留残值
        faan174 LIKE faan_t.faan174, #本位币二一般销售未折减额
        faan190 LIKE faan_t.faan190, #本位币二折毕再提预留残值
        faan191 LIKE faan_t.faan191, #本位币二减值准备金额
        faan200 LIKE faan_t.faan200, #本位币三币种
        faan201 LIKE faan_t.faan201, #本位币三汇率
        faan202 LIKE faan_t.faan202, #本位币三账面余额
        faan203 LIKE faan_t.faan203, #本位币三账面净值
        faan204 LIKE faan_t.faan204, #本位币三账面价值
        faan205 LIKE faan_t.faan205, #本位币三本月折旧
        faan206 LIKE faan_t.faan206, #本位币三累计折旧
        faan207 LIKE faan_t.faan207, #本位币三减值准备
        faan208 LIKE faan_t.faan208, #本位币三预留残值
        faan220 LIKE faan_t.faan220, #本位币三重估成本
        faan221 LIKE faan_t.faan221, #本位币三重估异动累计折旧
        faan222 LIKE faan_t.faan222, #本位币二重估已计提减值准备
        faan223 LIKE faan_t.faan223, #本位币三重估异动预留残值
        faan224 LIKE faan_t.faan224, #本位币三重估后未折减额
        faan230 LIKE faan_t.faan230, #本位币三内部销售成本
        faan231 LIKE faan_t.faan231, #本位币三内部销售累折
        faan232 LIKE faan_t.faan232, #本位币三内部销售计提减值准备
        faan233 LIKE faan_t.faan233, #本位币三内部销售预留残值
        faan234 LIKE faan_t.faan234, #本位币三内部销售未折减额
        faan240 LIKE faan_t.faan240, #本位币三销账成本
        faan241 LIKE faan_t.faan241, #本位币三销账累折
        faan242 LIKE faan_t.faan242, #本位币三销账计提减值准备
        faan243 LIKE faan_t.faan243, #本位币三销账预留残值
        faan244 LIKE faan_t.faan244, #本位币三销账未折减额
        faan250 LIKE faan_t.faan250, #本位币三报废成本
        faan251 LIKE faan_t.faan251, #本位币三报废累折
        faan252 LIKE faan_t.faan252, #本位币三报废计提减值准备
        faan253 LIKE faan_t.faan253, #本位币三报废预留残值
        faan254 LIKE faan_t.faan254, #本位币三报废未折减额
        faan260 LIKE faan_t.faan260, #本位币三改良成本
        faan261 LIKE faan_t.faan261, #本位币三改良异动预留残值
        faan262 LIKE faan_t.faan262, #本位币三改良未折减额
        faan270 LIKE faan_t.faan270, #本位币三一般销售成本
        faan271 LIKE faan_t.faan271, #本位币三一般销售累折
        faan272 LIKE faan_t.faan272, #本位币三一般销售计提减值准备
        faan273 LIKE faan_t.faan273, #本位币三一般销售预留残值
        faan274 LIKE faan_t.faan274, #本位币三一般销售未折减额
        faan290 LIKE faan_t.faan290, #本位币三折毕再提预留残值
        faan291 LIKE faan_t.faan291, #本位币三减值准备金额
        faan009 LIKE faan_t.faan009 #列账/列管
 END RECORD
 DEFINE l_faan_qm RECORD  #資產月結檔
        faanent LIKE faan_t.faanent, #企业编码
        faancomp LIKE faan_t.faancomp, #法人
        faansite LIKE faan_t.faansite, #资产中心
        faan001 LIKE faan_t.faan001, #年度
        faan002 LIKE faan_t.faan002, #月份
        faan003 LIKE faan_t.faan003, #卡片编号
        faan004 LIKE faan_t.faan004, #财产编号
        faan005 LIKE faan_t.faan005, #附号
        faan006 LIKE faan_t.faan006, #数量
        faan007 LIKE faan_t.faan007, #资产状态
        faan008 LIKE faan_t.faan008, #外送数量
        faanld LIKE faan_t.faanld, #账套
        faan010 LIKE faan_t.faan010, #币种
        faan011 LIKE faan_t.faan011, #汇率
        faan012 LIKE faan_t.faan012, #耐用年限
        faan013 LIKE faan_t.faan013, #未使用年限
        faan014 LIKE faan_t.faan014, #账面余额
        faan015 LIKE faan_t.faan015, #账面净值
        faan016 LIKE faan_t.faan016, #账面价值
        faan017 LIKE faan_t.faan017, #本月折旧
        faan018 LIKE faan_t.faan018, #累计折旧
        faan019 LIKE faan_t.faan019, #已计提减值准备金额
        faan020 LIKE faan_t.faan020, #预留残值
        faan030 LIKE faan_t.faan030, #重估数量
        faan031 LIKE faan_t.faan031, #重估成本
        faan032 LIKE faan_t.faan032, #重估异动累计折旧
        faan033 LIKE faan_t.faan033, #重估异动年限
        faan034 LIKE faan_t.faan034, #重估异动预留残值
        faan035 LIKE faan_t.faan035, #重估未折减额
        faan040 LIKE faan_t.faan040, #内部销售数量
        faan041 LIKE faan_t.faan041, #内部销售成本
        faan042 LIKE faan_t.faan042, #内部销售累计折旧
        faan043 LIKE faan_t.faan043, #内部销售计提减值准备
        faan044 LIKE faan_t.faan044, #内部销售预留残值
        faan045 LIKE faan_t.faan045, #内部销售未折减额
        faan050 LIKE faan_t.faan050, #销账数量
        faan051 LIKE faan_t.faan051, #销账成本
        faan052 LIKE faan_t.faan052, #销账累计折旧
        faan053 LIKE faan_t.faan053, #销账已计提减值准备
        faan054 LIKE faan_t.faan054, #销账预留残值
        faan055 LIKE faan_t.faan055, #销账未折减额
        faan060 LIKE faan_t.faan060, #报废数量
        faan061 LIKE faan_t.faan061, #报废成本
        faan062 LIKE faan_t.faan062, #报废累计折旧
        faan063 LIKE faan_t.faan063, #报废计提减值准备
        faan064 LIKE faan_t.faan064, #报废预留残值
        faan065 LIKE faan_t.faan065, #报废未折减额
        faan070 LIKE faan_t.faan070, #改良数量
        faan071 LIKE faan_t.faan071, #改良成本
        faan072 LIKE faan_t.faan072, #改良异动未用年限
        faan073 LIKE faan_t.faan073, #改良异动预留残值
        faan074 LIKE faan_t.faan074, #改良未折减额
        faan080 LIKE faan_t.faan080, #一般销售数量
        faan081 LIKE faan_t.faan081, #一般销售成本
        faan082 LIKE faan_t.faan082, #一般销售累计折旧
        faan083 LIKE faan_t.faan083, #一般销售计提减值准备
        faan084 LIKE faan_t.faan084, #一般销售预留残值
        faan085 LIKE faan_t.faan085, #一般销售未折减额
        faan090 LIKE faan_t.faan090, #折毕再提预留残值
        faan091 LIKE faan_t.faan091, #折毕再提未用年限
        faan092 LIKE faan_t.faan092, #减值准备金额
        faan100 LIKE faan_t.faan100, #本位币二币种
        faan101 LIKE faan_t.faan101, #本位币二汇率
        faan102 LIKE faan_t.faan102, #本位币二账面余额
        faan103 LIKE faan_t.faan103, #本位币二账面净值
        faan104 LIKE faan_t.faan104, #本位币二账面价值
        faan105 LIKE faan_t.faan105, #本位币二本月折旧
        faan106 LIKE faan_t.faan106, #本位币二累计折旧
        faan107 LIKE faan_t.faan107, #本位币二减值准备金额
        faan108 LIKE faan_t.faan108, #本位币二预留残值
        faan120 LIKE faan_t.faan120, #本位币二重估成本
        faan121 LIKE faan_t.faan121, #本位币二重估异动累计折旧
        faan122 LIKE faan_t.faan122, #本位币二重估已计提减值准备
        faan123 LIKE faan_t.faan123, #本位币二重估预留残值
        faan124 LIKE faan_t.faan124, #本位币二重估未折减额
        faan130 LIKE faan_t.faan130, #本位币二内部销售成本
        faan131 LIKE faan_t.faan131, #本位币二内部销售累折
        faan132 LIKE faan_t.faan132, #本位币二内部销售计提减值准备
        faan133 LIKE faan_t.faan133, #本位币二内部销售预留残值
        faan134 LIKE faan_t.faan134, #本位币二内部销售未折减额
        faan140 LIKE faan_t.faan140, #本位币二销账成本
        faan141 LIKE faan_t.faan141, #本位币二销账累计折旧
        faan142 LIKE faan_t.faan142, #本位币二销账已计提减值准备
        faan143 LIKE faan_t.faan143, #本位币二销账预留残值
        faan144 LIKE faan_t.faan144, #本位币二销账未折减额
        faan150 LIKE faan_t.faan150, #本位币二报废成本
        faan151 LIKE faan_t.faan151, #本位币二报废累计折旧
        faan152 LIKE faan_t.faan152, #本位币二报废计提减值准备
        faan153 LIKE faan_t.faan153, #本位币二报废预留残值
        faan154 LIKE faan_t.faan154, #本位币二报废未折减额
        faan160 LIKE faan_t.faan160, #本位币二改良成本
        faan161 LIKE faan_t.faan161, #本位币二改良异动预留残值
        faan162 LIKE faan_t.faan162, #本位币二改良未折减额
        faan170 LIKE faan_t.faan170, #本位币二一般销售成本
        faan171 LIKE faan_t.faan171, #本位币二一般销售累计折旧
        faan172 LIKE faan_t.faan172, #本位币二一般销售计提减值准备
        faan173 LIKE faan_t.faan173, #本位币二一般销售预留残值
        faan174 LIKE faan_t.faan174, #本位币二一般销售未折减额
        faan190 LIKE faan_t.faan190, #本位币二折毕再提预留残值
        faan191 LIKE faan_t.faan191, #本位币二减值准备金额
        faan200 LIKE faan_t.faan200, #本位币三币种
        faan201 LIKE faan_t.faan201, #本位币三汇率
        faan202 LIKE faan_t.faan202, #本位币三账面余额
        faan203 LIKE faan_t.faan203, #本位币三账面净值
        faan204 LIKE faan_t.faan204, #本位币三账面价值
        faan205 LIKE faan_t.faan205, #本位币三本月折旧
        faan206 LIKE faan_t.faan206, #本位币三累计折旧
        faan207 LIKE faan_t.faan207, #本位币三减值准备
        faan208 LIKE faan_t.faan208, #本位币三预留残值
        faan220 LIKE faan_t.faan220, #本位币三重估成本
        faan221 LIKE faan_t.faan221, #本位币三重估异动累计折旧
        faan222 LIKE faan_t.faan222, #本位币二重估已计提减值准备
        faan223 LIKE faan_t.faan223, #本位币三重估异动预留残值
        faan224 LIKE faan_t.faan224, #本位币三重估后未折减额
        faan230 LIKE faan_t.faan230, #本位币三内部销售成本
        faan231 LIKE faan_t.faan231, #本位币三内部销售累折
        faan232 LIKE faan_t.faan232, #本位币三内部销售计提减值准备
        faan233 LIKE faan_t.faan233, #本位币三内部销售预留残值
        faan234 LIKE faan_t.faan234, #本位币三内部销售未折减额
        faan240 LIKE faan_t.faan240, #本位币三销账成本
        faan241 LIKE faan_t.faan241, #本位币三销账累折
        faan242 LIKE faan_t.faan242, #本位币三销账计提减值准备
        faan243 LIKE faan_t.faan243, #本位币三销账预留残值
        faan244 LIKE faan_t.faan244, #本位币三销账未折减额
        faan250 LIKE faan_t.faan250, #本位币三报废成本
        faan251 LIKE faan_t.faan251, #本位币三报废累折
        faan252 LIKE faan_t.faan252, #本位币三报废计提减值准备
        faan253 LIKE faan_t.faan253, #本位币三报废预留残值
        faan254 LIKE faan_t.faan254, #本位币三报废未折减额
        faan260 LIKE faan_t.faan260, #本位币三改良成本
        faan261 LIKE faan_t.faan261, #本位币三改良异动预留残值
        faan262 LIKE faan_t.faan262, #本位币三改良未折减额
        faan270 LIKE faan_t.faan270, #本位币三一般销售成本
        faan271 LIKE faan_t.faan271, #本位币三一般销售累折
        faan272 LIKE faan_t.faan272, #本位币三一般销售计提减值准备
        faan273 LIKE faan_t.faan273, #本位币三一般销售预留残值
        faan274 LIKE faan_t.faan274, #本位币三一般销售未折减额
        faan290 LIKE faan_t.faan290, #本位币三折毕再提预留残值
        faan291 LIKE faan_t.faan291, #本位币三减值准备金额
        faan009 LIKE faan_t.faan009 #列账/列管
 END RECORD
 DEFINE l_faah RECORD  #固定資產基礎資料檔
        faahent LIKE faah_t.faahent, #企业编号
        faah000 LIKE faah_t.faah000, #生成批号
        faah001 LIKE faah_t.faah001, #卡片编号
        faah002 LIKE faah_t.faah002, #型态
        faah003 LIKE faah_t.faah003, #财产编号
        faah004 LIKE faah_t.faah004, #附号
        faah005 LIKE faah_t.faah005, #资产性质
        faah006 LIKE faah_t.faah006, #资产主要类型
        faah007 LIKE faah_t.faah007, #资产次要类型
        faah008 LIKE faah_t.faah008, #资产组
        faah009 LIKE faah_t.faah009, #供应供应商
        faah010 LIKE faah_t.faah010, #制造供应商
        faah011 LIKE faah_t.faah011, #产地
        faah012 LIKE faah_t.faah012, #名称
        faah013 LIKE faah_t.faah013, #规格型号
        faah014 LIKE faah_t.faah014, #取得日期
        faah015 LIKE faah_t.faah015, #资产状态
        faah016 LIKE faah_t.faah016, #取得方式
        faah017 LIKE faah_t.faah017, #单位
        faah018 LIKE faah_t.faah018, #数量
        faah019 LIKE faah_t.faah019, #在外数量
        faah020 LIKE faah_t.faah020, #币种
        faah021 LIKE faah_t.faah021, #原币单价
        faah022 LIKE faah_t.faah022, #原币金额
        faah023 LIKE faah_t.faah023, #本币单价
        faah024 LIKE faah_t.faah024, #本币金额
        faah025 LIKE faah_t.faah025, #保管人员
        faah026 LIKE faah_t.faah026, #保管部门
        faah027 LIKE faah_t.faah027, #存放位置
        faah028 LIKE faah_t.faah028, #存放组织
        faah029 LIKE faah_t.faah029, #负责人员
        faah030 LIKE faah_t.faah030, #管理组织
        faah031 LIKE faah_t.faah031, #核算组织
        faah032 LIKE faah_t.faah032, #归属法人
        faah033 LIKE faah_t.faah033, #直接资本化
        faah034 LIKE faah_t.faah034, #保税
        faah035 LIKE faah_t.faah035, #保险
        faah036 LIKE faah_t.faah036, #免税
        faah037 LIKE faah_t.faah037, #抵押
        faah038 LIKE faah_t.faah038, #采购单号
        faah039 LIKE faah_t.faah039, #收货单号
        faah040 LIKE faah_t.faah040, #账款单号
        faah041 LIKE faah_t.faah041, #来源营运中心
        faah042 LIKE faah_t.faah042, #资产属性
        faah043 LIKE faah_t.faah043, #预计总工作量
        faah044 LIKE faah_t.faah044, #已使用工作量
        faah045 LIKE faah_t.faah045, #账款编号项次
        faahownid LIKE faah_t.faahownid, #资料所有者
        faahowndp LIKE faah_t.faahowndp, #资料所有部门
        faahcrtid LIKE faah_t.faahcrtid, #资料录入者
        faahcrtdp LIKE faah_t.faahcrtdp, #资料录入部门
        faahcrtdt LIKE faah_t.faahcrtdt, #资料创建日
        faahmodid LIKE faah_t.faahmodid, #资料更改者
        faahmoddt LIKE faah_t.faahmoddt, #最近更改日
        faahstus LIKE faah_t.faahstus, #状态码
        faah046 LIKE faah_t.faah046, #备注
        faah047 LIKE faah_t.faah047, #保税机器截取否
        faah048 LIKE faah_t.faah048, #投资抵减状态
        faah049 LIKE faah_t.faah049, #投资抵减合并码
        faah050 LIKE faah_t.faah050, #抵减率
        faah051 LIKE faah_t.faah051, #投资抵减用途
        faah052 LIKE faah_t.faah052, #抵减金额
        faah053 LIKE faah_t.faah053, #已抵减金额
        faah054 LIKE faah_t.faah054, #投资抵减否
        faah055 LIKE faah_t.faah055, #投资抵减年限
        faah056 LIKE faah_t.faah056 #免税状态
 END RECORD
 DEFINE l_fabh RECORD  #資產異動單身檔
        fabhent LIKE fabh_t.fabhent, #企业编号
        fabhld LIKE fabh_t.fabhld, #账套
        fabhsite LIKE fabh_t.fabhsite, #营运据点
        fabhdocno LIKE fabh_t.fabhdocno, #异动单号
        fabhseq LIKE fabh_t.fabhseq, #项次
        fabh000 LIKE fabh_t.fabh000, #卡片编号
        fabh001 LIKE fabh_t.fabh001, #财产编号
        fabh002 LIKE fabh_t.fabh002, #附号
        fabh003 LIKE fabh_t.fabh003, #资产状态
        fabh004 LIKE fabh_t.fabh004, #未折减余额
        fabh005 LIKE fabh_t.fabh005, #单位
        fabh006 LIKE fabh_t.fabh006, #数量
        fabh007 LIKE fabh_t.fabh007, #处置数量
        fabh008 LIKE fabh_t.fabh008, #成本
        fabh009 LIKE fabh_t.fabh009, #累计调整成本
        fabh010 LIKE fabh_t.fabh010, #调整成本/公允价值
        fabh011 LIKE fabh_t.fabh011, #累折
        fabh012 LIKE fabh_t.fabh012, #重估累计折旧
        fabh013 LIKE fabh_t.fabh013, #未用年限
        fabh014 LIKE fabh_t.fabh014, #重估未用年限
        fabh015 LIKE fabh_t.fabh015, #预留残值
        fabh016 LIKE fabh_t.fabh016, #重估预留残值
        fabh017 LIKE fabh_t.fabh017, #已计提减值准备
        fabh018 LIKE fabh_t.fabh018, #异动
        fabh019 LIKE fabh_t.fabh019, #减值准备金额
        fabh020 LIKE fabh_t.fabh020, #异动原因
        fabh021 LIKE fabh_t.fabh021, #异动科目
        fabh022 LIKE fabh_t.fabh022, #调整成本
        fabh023 LIKE fabh_t.fabh023, #累计折旧科目
        fabh024 LIKE fabh_t.fabh024, #资产科目
        fabh025 LIKE fabh_t.fabh025, #减值准备科目
        fabh026 LIKE fabh_t.fabh026, #营运据点
        fabh027 LIKE fabh_t.fabh027, #部门
        fabh028 LIKE fabh_t.fabh028, #利润/成本中心
        fabh029 LIKE fabh_t.fabh029, #区域
        fabh030 LIKE fabh_t.fabh030, #交易客商
        fabh031 LIKE fabh_t.fabh031, #账款客商
        fabh032 LIKE fabh_t.fabh032, #客群
        fabh033 LIKE fabh_t.fabh033, #人员
        fabh034 LIKE fabh_t.fabh034, #项目编号
        fabh035 LIKE fabh_t.fabh035, #WBS
        fabh036 LIKE fabh_t.fabh036, #摘要
        fabh037 LIKE fabh_t.fabh037, #来源编号
        fabh038 LIKE fabh_t.fabh038, #来源项次
        fabh039 LIKE fabh_t.fabh039, #盘点编号
        fabh040 LIKE fabh_t.fabh040, #盘点序号
        fabh041 LIKE fabh_t.fabh041, #经营方式
        fabh042 LIKE fabh_t.fabh042, #渠道
        fabh043 LIKE fabh_t.fabh043, #品牌
        fabh060 LIKE fabh_t.fabh060, #自由核算项一
        fabh061 LIKE fabh_t.fabh061, #自由核算项二
        fabh062 LIKE fabh_t.fabh062, #自由核算项三
        fabh063 LIKE fabh_t.fabh063, #自由核算项四
        fabh064 LIKE fabh_t.fabh064, #自由核算项五
        fabh065 LIKE fabh_t.fabh065, #自由核算项六
        fabh066 LIKE fabh_t.fabh066, #自由核算项七
        fabh067 LIKE fabh_t.fabh067, #自由核算项八
        fabh068 LIKE fabh_t.fabh068, #自由核算项九
        fabh069 LIKE fabh_t.fabh069, #自由核算项十
        fabh100 LIKE fabh_t.fabh100, #本位币二币种
        fabh101 LIKE fabh_t.fabh101, #本位币二汇率
        fabh102 LIKE fabh_t.fabh102, #本位币二成本
        fabh103 LIKE fabh_t.fabh103, #本位币二调整成本
        fabh104 LIKE fabh_t.fabh104, #本位币二累折
        fabh105 LIKE fabh_t.fabh105, #本位币二重估累折
        fabh106 LIKE fabh_t.fabh106, #本位币二预留残值
        fabh107 LIKE fabh_t.fabh107, #本位币二重估残值
        fabh108 LIKE fabh_t.fabh108, #本位币二未折减额
        fabh109 LIKE fabh_t.fabh109, #本位币二已计提减值准备
        fabh110 LIKE fabh_t.fabh110, #本位币二减值准备金额
        fabh150 LIKE fabh_t.fabh150, #本位币三币种
        fabh151 LIKE fabh_t.fabh151, #本位币三汇率
        fabh152 LIKE fabh_t.fabh152, #本位币三成本
        fabh153 LIKE fabh_t.fabh153, #本位币三调整成本
        fabh154 LIKE fabh_t.fabh154, #本位币三累折
        fabh155 LIKE fabh_t.fabh155, #本位币三重估累折
        fabh156 LIKE fabh_t.fabh156, #本位币三预留残值
        fabh157 LIKE fabh_t.fabh157, #本位币三重估残值
        fabh158 LIKE fabh_t.fabh158, #本位币三未折减额
        fabh159 LIKE fabh_t.fabh159, #本位币三已计提减值准备
        fabh160 LIKE fabh_t.fabh160, #本位币三减值准备金额
        fabh070 LIKE fabh_t.fabh070, #累计折旧科目(旧)
        fabh071 LIKE fabh_t.fabh071, #资产科目(旧)
        fabh072 LIKE fabh_t.fabh072, #减值准备科目(旧)
        fabh073 LIKE fabh_t.fabh073, #处置本年累折
        fabh111 LIKE fabh_t.fabh111, #本位币二处置本年累折
        fabh161 LIKE fabh_t.fabh161, #本位币三处置本年累折
        fabh074 LIKE fabh_t.fabh074, #保险费用科目
        fabh075 LIKE fabh_t.fabh075, #主要类别
        fabh076 LIKE fabh_t.fabh076 #主要类别新
 END RECORD
 DEFINE l_faam RECORD  #固定資產折舊明細資料檔
        faament LIKE faam_t.faament, #企业编号
        faamsite LIKE faam_t.faamsite, #资产中心
        faamld LIKE faam_t.faamld, #账套编码
        faamcomp LIKE faam_t.faamcomp, #法人
        faam000 LIKE faam_t.faam000, #卡片编号
        faam001 LIKE faam_t.faam001, #财产编号
        faam002 LIKE faam_t.faam002, #附号
        faam003 LIKE faam_t.faam003, #折旧方式
        faam004 LIKE faam_t.faam004, #折旧年度
        faam005 LIKE faam_t.faam005, #折旧期别
        faam006 LIKE faam_t.faam006, #来源
        faam007 LIKE faam_t.faam007, #分摊方式
        faam008 LIKE faam_t.faam008, #分摊类别
        faam009 LIKE faam_t.faam009, #部门
        faam010 LIKE faam_t.faam010, #被分摊部门
        faam011 LIKE faam_t.faam011, #币种
        faam012 LIKE faam_t.faam012, #汇率
        faam013 LIKE faam_t.faam013, #折旧金额
        faam014 LIKE faam_t.faam014, #成本
        faam015 LIKE faam_t.faam015, #累折
        faam016 LIKE faam_t.faam016, #本年累折
        faam017 LIKE faam_t.faam017, #分摊比率
        faam018 LIKE faam_t.faam018, #已计提减值准备
        faam019 LIKE faam_t.faam019, #年折旧额
        faam020 LIKE faam_t.faam020, #资产科目
        faam021 LIKE faam_t.faam021, #累折科目
        faam022 LIKE faam_t.faam022, #折旧科目
        faam023 LIKE faam_t.faam023, #减值准备科目
        faam024 LIKE faam_t.faam024, #凭证单号
        faam025 LIKE faam_t.faam025, #凭证单号项次
        faam026 LIKE faam_t.faam026, #资产状态
        faam027 LIKE faam_t.faam027, #营运据点
        faam028 LIKE faam_t.faam028, #部门
        faam029 LIKE faam_t.faam029, #利润/成本中心
        faam030 LIKE faam_t.faam030, #区域
        faam031 LIKE faam_t.faam031, #交易客商
        faam032 LIKE faam_t.faam032, #账款客商
        faam033 LIKE faam_t.faam033, #客群
        faam034 LIKE faam_t.faam034, #人员
        faam035 LIKE faam_t.faam035, #项目编号
        faam036 LIKE faam_t.faam036, #WBS
        faam037 LIKE faam_t.faam037, #经营方式
        faam038 LIKE faam_t.faam038, #渠道
        faam039 LIKE faam_t.faam039, #品牌
        faam040 LIKE faam_t.faam040, #自由核算项一
        faam041 LIKE faam_t.faam041, #自由核算项二
        faam042 LIKE faam_t.faam042, #自由核算项三
        faam043 LIKE faam_t.faam043, #自由核算项四
        faam044 LIKE faam_t.faam044, #自由核算项五
        faam045 LIKE faam_t.faam045, #自由核算项六
        faam046 LIKE faam_t.faam046, #自由核算项七
        faam047 LIKE faam_t.faam047, #自由核算项八
        faam048 LIKE faam_t.faam048, #自由核算项九
        faam049 LIKE faam_t.faam049, #自由核算项十
        faam050 LIKE faam_t.faam050, #摘要
        faam101 LIKE faam_t.faam101, #本位币二币种
        faam102 LIKE faam_t.faam102, #本位币二汇率
        faam103 LIKE faam_t.faam103, #本位币二成本
        faam104 LIKE faam_t.faam104, #本位币二折旧金额
        faam105 LIKE faam_t.faam105, #本位币二累折
        faam106 LIKE faam_t.faam106, #本位币二本年累折
        faam107 LIKE faam_t.faam107, #本位币二年折旧额
        faam108 LIKE faam_t.faam108, #本位币二已计提减值准备
        faam151 LIKE faam_t.faam151, #本位币三币种
        faam152 LIKE faam_t.faam152, #本位币三汇率
        faam153 LIKE faam_t.faam153, #本位币三成本
        faam154 LIKE faam_t.faam154, #本位币三折旧金额
        faam155 LIKE faam_t.faam155, #本位币三累折
        faam156 LIKE faam_t.faam156, #本位币三本年累折
        faam157 LIKE faam_t.faam157, #本位币三年折旧额
        faam158 LIKE faam_t.faam158 #本位币三已计提减值准备
 END RECORD
 DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
        faajent LIKE faaj_t.faajent, #企业编码
        faajld LIKE faaj_t.faajld, #账套别编码
        faajsite LIKE faaj_t.faajsite, #营运据点
        faaj000 LIKE faaj_t.faaj000, #批号
        faaj001 LIKE faaj_t.faaj001, #财产编号
        faaj002 LIKE faaj_t.faaj002, #附号
        faaj003 LIKE faaj_t.faaj003, #折旧方式
        faaj004 LIKE faaj_t.faaj004, #耐用年限(月数)
        faaj005 LIKE faaj_t.faaj005, #未使用年限(月数)
        faaj006 LIKE faaj_t.faaj006, #分摊方式
        faaj007 LIKE faaj_t.faaj007, #分摊类别
        faaj008 LIKE faaj_t.faaj008, #开始折旧年月
        faaj009 LIKE faaj_t.faaj009, #最近折旧年度
        faaj010 LIKE faaj_t.faaj010, #最近折旧期别
        faaj011 LIKE faaj_t.faaj011, #折毕再提
        faaj012 LIKE faaj_t.faaj012, #折毕再提预留残值
        faaj013 LIKE faaj_t.faaj013, #折毕再提预留年月（数）
        faaj014 LIKE faaj_t.faaj014, #币种
        faaj015 LIKE faaj_t.faaj015, #汇率
        faaj016 LIKE faaj_t.faaj016, #成本
        faaj017 LIKE faaj_t.faaj017, #累折
        faaj018 LIKE faaj_t.faaj018, #本期累折
        faaj019 LIKE faaj_t.faaj019, #预留残值
        faaj020 LIKE faaj_t.faaj020, #调整成本
        faaj021 LIKE faaj_t.faaj021, #已计提减值准备
        faaj022 LIKE faaj_t.faaj022, #年折旧额
        faaj023 LIKE faaj_t.faaj023, #资产科目
        faaj024 LIKE faaj_t.faaj024, #累折科目
        faaj025 LIKE faaj_t.faaj025, #折旧科目
        faaj026 LIKE faaj_t.faaj026, #减值准备科目
        faaj027 LIKE faaj_t.faaj027, #销账减值准备
        faaj028 LIKE faaj_t.faaj028, #未折减额
        faaj029 LIKE faaj_t.faaj029, #第一个月未折减额
        faaj030 LIKE faaj_t.faaj030, #账款编号
        faaj031 LIKE faaj_t.faaj031, #账款编号项次
        faaj032 LIKE faaj_t.faaj032, #本期处置累折
        faaj033 LIKE faaj_t.faaj033, #处置数量
        faaj034 LIKE faaj_t.faaj034, #处置成本
        faaj035 LIKE faaj_t.faaj035, #处置累折
        faaj036 LIKE faaj_t.faaj036, #交易价格差异
        faaj037 LIKE faaj_t.faaj037, #卡片编号
        faaj038 LIKE faaj_t.faaj038, #资产状态
        faaj039 LIKE faaj_t.faaj039, #部门
        faaj040 LIKE faaj_t.faaj040, #利润/成本中心
        faaj041 LIKE faaj_t.faaj041, #区域
        faaj042 LIKE faaj_t.faaj042, #交易客商
        faaj043 LIKE faaj_t.faaj043, #账款客商
        faaj044 LIKE faaj_t.faaj044, #客群
        faaj045 LIKE faaj_t.faaj045, #项目编号
        faaj046 LIKE faaj_t.faaj046, #WBS
        faaj047 LIKE faaj_t.faaj047, #人员
        faaj101 LIKE faaj_t.faaj101, #本位币二币种
        faaj102 LIKE faaj_t.faaj102, #本位币二汇率
        faaj103 LIKE faaj_t.faaj103, #本位币二成本
        faaj104 LIKE faaj_t.faaj104, #本位币二累折
        faaj105 LIKE faaj_t.faaj105, #本位币二预留残值
        faaj106 LIKE faaj_t.faaj106, #本位币二折毕再提预留残值
        faaj107 LIKE faaj_t.faaj107, #本位币二年折旧额
        faaj108 LIKE faaj_t.faaj108, #本位币二未折减额
        faaj109 LIKE faaj_t.faaj109, #本位币二第一月未折减额
        faaj110 LIKE faaj_t.faaj110, #本位币二处置减值准备
        faaj111 LIKE faaj_t.faaj111, #本位币二本年累折
        faaj112 LIKE faaj_t.faaj112, #本位币二已计提减值准备
        faaj113 LIKE faaj_t.faaj113, #本位币二处置成本
        faaj114 LIKE faaj_t.faaj114, #本位币二处置累折
        faaj115 LIKE faaj_t.faaj115, #本位币二本期处置累折
        faaj116 LIKE faaj_t.faaj116, #本位币二交易价格差异
        faaj117 LIKE faaj_t.faaj117, #本位币二调整成本
        faaj151 LIKE faaj_t.faaj151, #本位币三币种
        faaj152 LIKE faaj_t.faaj152, #本位币三汇率
        faaj153 LIKE faaj_t.faaj153, #本位币三成本
        faaj154 LIKE faaj_t.faaj154, #本位币三累折
        faaj155 LIKE faaj_t.faaj155, #本位币三预留残值
        faaj156 LIKE faaj_t.faaj156, #本位币三折毕再提预留残值
        faaj157 LIKE faaj_t.faaj157, #本位币三年折旧额
        faaj158 LIKE faaj_t.faaj158, #本位币三未折减额
        faaj159 LIKE faaj_t.faaj159, #本位币三第一月未折减额
        faaj160 LIKE faaj_t.faaj160, #本位币三处置减值准备
        faaj161 LIKE faaj_t.faaj161, #本位币三本年累折
        faaj162 LIKE faaj_t.faaj162, #本位币三已计提减值准备
        faaj163 LIKE faaj_t.faaj163, #本位币三处置成本
        faaj164 LIKE faaj_t.faaj164, #本位币三处置累折
        faaj165 LIKE faaj_t.faaj165, #本位币三本期处置累折
        faaj166 LIKE faaj_t.faaj166, #本位币三交易价格差异
        faaj167 LIKE faaj_t.faaj167, #本位币三调整成本
        faajownid LIKE faaj_t.faajownid, #资料所有者
        faajowndp LIKE faaj_t.faajowndp, #资料所有部门
        faajcrtid LIKE faaj_t.faajcrtid, #资料录入者
        faajcrtdp LIKE faaj_t.faajcrtdp, #资料录入部门
        faajcrtdt LIKE faaj_t.faajcrtdt, #资料创建日
        faajmodid LIKE faaj_t.faajmodid, #资料更改者
        faajmoddt LIKE faaj_t.faajmoddt, #最近更改日
        faajstus LIKE faaj_t.faajstus, #状态码
        faaj048 LIKE faaj_t.faaj048  #资产分类
 END RECORD
DEFINE l_count    LIKE type_t.num5
DEFINE l_count1   LIKE type_t.num5
DEFINE l_yy       LIKE faan_t.faan001
DEFINE l_mm       LIKE faan_t.faan002
DEFINE l_ooaj003  LIKE ooaj_t.ooaj003
DEFINE l_ooaj004  LIKE ooaj_t.ooaj004
DEFINE l_ooaj0042 LIKE ooaj_t.ooaj004
DEFINE l_ooaj0043 LIKE ooaj_t.ooaj004
DEFINE l_fabh007_503 LIKE fabh_t.fabh007
DEFINE l_fabh007_508 LIKE fabh_t.fabh007
DEFINE l_fabh007_506 LIKE fabh_t.fabh007
DEFINE l_fabh007_507 LIKE fabh_t.fabh007
DEFINE l_fabh007_504 LIKE fabh_t.fabh007
DEFINE l_fabh007_505 LIKE fabh_t.fabh007
DEFINE l_fabh008_503 LIKE fabh_t.fabh008
DEFINE l_fabh008_508 LIKE fabh_t.fabh008
DEFINE l_fabh008_506 LIKE fabh_t.fabh008
DEFINE l_fabh008_507 LIKE fabh_t.fabh008
DEFINE l_fabh008_504 LIKE fabh_t.fabh008
DEFINE l_fabh008_505 LIKE fabh_t.fabh008
DEFINE l_fabh013_503 LIKE fabh_t.fabh013
DEFINE l_fabh013_508 LIKE fabh_t.fabh013
DEFINE l_fabh013_506 LIKE fabh_t.fabh013
DEFINE l_fabh013_507 LIKE fabh_t.fabh013
DEFINE l_fabh013_504 LIKE fabh_t.fabh013
DEFINE l_fabh013_505 LIKE fabh_t.fabh013
DEFINE l_fabh013_501 LIKE fabh_t.fabh013
DEFINE l_fabh004_503 LIKE fabh_t.fabh004
DEFINE l_fabh004_508 LIKE fabh_t.fabh004
DEFINE l_fabh004_506 LIKE fabh_t.fabh004
DEFINE l_fabh004_507 LIKE fabh_t.fabh004
DEFINE l_fabh004_504 LIKE fabh_t.fabh004
DEFINE l_fabh004_505 LIKE fabh_t.fabh004
DEFINE l_fabh011     LIKE fabh_t.fabh011  
DEFINE l_fabh015     LIKE fabh_t.fabh015
DEFINE l_fabh011_1   LIKE fabh_t.fabh011
DEFINE l_fabh015_1   LIKE fabh_t.fabh015
DEFINE l_fabh019_502 LIKE fabh_t.fabh019
DEFINE l_fabh019_504 LIKE fabh_t.fabh019
DEFINE l_fabh019_505 LIKE fabh_t.fabh019
DEFINE l_fabh019_506 LIKE fabh_t.fabh019
DEFINE l_fabh019_507 LIKE fabh_t.fabh019
DEFINE l_fabh015_503 LIKE fabh_t.fabh015
DEFINE l_fabh015_508 LIKE fabh_t.fabh015
DEFINE l_fabh015_506 LIKE fabh_t.fabh015
DEFINE l_fabh015_507 LIKE fabh_t.fabh015
DEFINE l_fabh015_504 LIKE fabh_t.fabh015
DEFINE l_fabh015_505 LIKE fabh_t.fabh015
DEFINE l_fabh015_501 LIKE fabh_t.fabh015
DEFINE l_fabh011_503 LIKE fabh_t.fabh011
DEFINE l_fabh011_508 LIKE fabh_t.fabh011
DEFINE l_fabh011_506 LIKE fabh_t.fabh011
DEFINE l_fabh011_507 LIKE fabh_t.fabh011
DEFINE l_fabh011_504 LIKE fabh_t.fabh011
DEFINE l_fabh011_505 LIKE fabh_t.fabh011

DEFINE l_fabh007     LIKE fabh_t.fabh007
DEFINE l_fabh004     LIKE fabh_t.fabh004
DEFINE l_fabh008     LIKE fabh_t.fabh008
DEFINE l_fabh013     LIKE fabh_t.fabh013
DEFINE l_fabh018     LIKE fabh_t.fabh018

DEFINE l_fabk006_1   LIKE fabk_t.fabk006
DEFINE l_fabk006_2   LIKE fabk_t.fabk006
DEFINE l_count_qc    LIKE type_t.num5

#20150605--add--str--
DEFINE l_faaj016     LIKE faaj_t.faaj016
DEFINE l_faaj017     LIKE faaj_t.faaj017
DEFINE l_faaj020     LIKE faaj_t.faaj020
DEFINE l_faaj034     LIKE faaj_t.faaj034
#20150605--add--end--

#年
LET l_faan.faan001 = g_master.faan001
#月
LET l_faan.faan002 = g_master.faan002
#帐套
LET l_faan.faanld = p_glaald 
#法人
LET l_faan.faancomp = p_glaacomp
#资产中心
LET l_faan.faansite = g_master.faansite



   #卡片编号 #财编 #附号 #帐套 #币别 #汇率 #资产主要类型（获取afai021参数用）#资产状态 #数量 #耐用年限 #未使用年限
   LET g_sql = " SELECT faah001,faah003,faah004,faajld,faah020,faaj015,faah006,faah015,faah018,faaj004,faaj005,faaj014,faaj038  ",   #150819-00007#1 add faaj014 lujh  #161104-00048#7 add faaj038 
               "   FROM faah_t LEFT JOIN faaj_t ",
               "     ON faajent = faahent AND faah000 = faaj000 ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ",
               "    AND faah015 NOT IN('5','6','10') ", #20150121 add by chenying
               "  WHERE faahent = '",g_enterprise,"' AND faajld = '",p_glaald,"'",
               "    AND faah014 <= '",p_edate,"' ",  #20150213
               "    AND faahstus = 'Y' AND faajstus = 'Y' "
   PREPARE afap310_pr_qc FROM g_sql
   DECLARE afap310_cs_qc CURSOR FOR afap310_pr_qc               

   #是否有上期
   LET g_sql = " SELECT COUNT(*) ",
               "   FROM faan_t ",
               "  WHERE faanent = '",g_enterprise,"' AND faan001 = ? AND faan002 = ? ",
               "    AND faan003 = ? AND faan004 = ? AND faan005 = ? AND faanld = ? " 
   PREPARE afap310_pr_qc_faan_count FROM g_sql
   
   
   #上期
   #数量 #资产状态 #帐面余额(期初成本) #帐面净值 #帐面价值 #本月折旧 #累计折旧 #计提减值准备金额 #预留残值  
   LET g_sql = " SELECT faan006,faan007,faan014,faan015,faan016,faan017,faan018,faan019,faan020 ",
               "   FROM faan_t ",
               "  WHERE faanent = '",g_enterprise,"' AND faan001 = ? AND faan002 = ? ",
               "    AND faan003 = ? AND faan004 = ? AND faan005 = ? AND faanld = ? " 
   PREPARE afap310_pr_qc_faan FROM g_sql
   DECLARE afap310_cs_qc_faan CURSOR FOR afap310_pr_qc_faan  

   #当期
   #数量 #资产状态 #帐面余额 #帐面净值 #帐面价值 
   #本月折旧 #累计折旧 #减值准备金额 #预留残值 
   LET g_sql = " SELECT faah018,faah015,faaj016,faaj028,faaj016-faaj017-faaj021,", #20150120 add faaj016 by chenying
               "        faam013,faaj017,faaj021,faaj019  ",
               "   FROM faaj_t LEFT JOIN faah_t ",
               "     ON faajent = faahent AND faah000 = faaj000 ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ",
               "               LEFT JOIN faam_t ",
               "    ON faajent = faament AND faaj037 = faam000 ",
               "    AND faaj001 = faam001 AND faaj002 = faam002 ",
               "  WHERE faahent = '",g_enterprise,"' AND faajld = ? ",
               "    AND faah001 = ? AND faah003 = ? AND faah004 = ? ",
               "    AND faahstus = 'Y' AND faajstus = 'Y' "
         
   PREPARE afap310_pr_qc_faah FROM g_sql
   DECLARE afap310_cs_qc_faah CURSOR FOR afap310_pr_qc_faah

   #本月累折 #afap230
   LET g_sql = " SELECT faam013 ",
               "   FROM faam_t ",
               "  WHERE faament = '",g_enterprise,"' AND faam000 = ? AND faam001 = ? ",
               "    AND faam002 = ? AND faamld = ? ",
               "    AND faam007 IN ('1','2') ", #faam007=1是单一部门；2是多部门汇总 #150401-00001#27
               "    AND faam004 = '",g_master.faan001,"'",               #add by yangxf
               "    AND faam005 = '",g_master.faan002,"'"                #add by yangxf
   PREPARE afap310_pr_yd_faam FROM g_sql


#######已计提减值准备金额############################################################### 
#上期faan/当期新增afai100的已计提减值准备金额+当期异动的减值准备金额（afat502考虑调增/调减,其他直接相加）
#afat502/506/507 fabh
#504/505 fabo
#减值准备/销账/报废/出售/调拨

   #afat502 #考虑调增调减，故单独组sql
   LET g_sql = " SELECT fabh018,fabh019 FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = '",g_enterprise,"' AND fabhld = ?",
               "    AND fabg005 = '14' AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh FROM g_sql
   DECLARE afap310_cs_yd_fabh CURSOR FOR afap310_pr_yd_fabh
   
   #afat506/507
   LET g_sql = " SELECT SUM(fabh019) FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = '",g_enterprise,"' ",
               "    AND fabg005 IN ('6','21') ",
               "    AND fabg005 = ? AND fabhld = ? AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh_2 FROM g_sql
   DECLARE afap310_cs_yd_fabh_2 CURSOR FOR afap310_pr_yd_fabh_2   
   
   #afat504/505
   LET g_sql = " SELECT SUM(fabo020) FROM fabg_t LEFT OUTER JOIN fabo_t ",
               "     ON fabgent = faboent AND fabgld = fabold AND fabgdocno =  fabodocno ",
               "  WHERE faboent = '",g_enterprise,"' ",
               "    AND fabg005 IN ('4','17') ",
               "    AND fabg005 = ? AND fabold = ? AND fabo003 = ? AND fabo001 = ? AND fabo002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh_7 FROM g_sql
   DECLARE afap310_cs_yd_fabh_7 CURSOR FOR afap310_pr_yd_fabh_7     
#######已计提减值准备金额###############################################################

#######累计折旧#预留残值#######################################################################
#上期faan/当期faah的累计折旧+本期的faam013+当期异动累折
#上期faan/当期faah的预留残值+当期异动累折
#afat503/506/507/504/505/508/501
#重估/销账/报废/出售/调拨/改良/折毕再提

   #afat503 #考虑重估异动累折/异动预留残值 fabh
   #afat508 #考虑改良异动预留残值 fabh
   #afat506/507 #考虑累折+预留残值 fabh
   #afat504/505 #考虑累折+预留残值 fabo
   #afat501 #考虑预留残值 fabd_t
   LET g_sql = " SELECT SUM(fabh012-fabh011),SUM(fabh016-fabh015),SUM(fabh011),SUM(fabh015) ",
               "   FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = '",g_enterprise,"' ",
               "    AND fabg005 IN('8','9','6','21') ",
               "    AND fabg005 = ? AND fabhld = ? AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh_6 FROM g_sql
   DECLARE afap310_cs_yd_fabh_6 CURSOR FOR afap310_pr_yd_fabh_6
   
   LET g_sql = " SELECT '','',SUM(fabo019),SUM(fabo025) ",
               "   FROM fabg_t LEFT OUTER JOIN fabo_t ",
               "     ON fabgent = faboent AND fabgld = fabold AND fabgdocno =  fabodocno ",
               "  WHERE faboent = '",g_enterprise,"' ",
               "    AND fabg005 IN('4','17') ",
               "    AND fabg005 = ? AND fabold = ? AND fabo003 = ? AND fabo001 = ? AND fabo002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabo FROM g_sql
   DECLARE afap310_cs_yd_fabo CURSOR FOR afap310_pr_yd_fabo

   LET g_sql = " SELECT '','','',SUM(fabd010) ",
               "   FROM fabg_t LEFT OUTER JOIN fabd_t ",
               "     ON fabgent = fabdent AND fabgld = fabdld AND fabgdocno =  fabddocno ",
               "  WHERE fabdent = '",g_enterprise,"' ",
               "    AND fabg005 IN('12') ",
               "    AND fabg005 = ? AND fabdld = ? AND fabd000 = ? AND fabd001 = ? AND fabd002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'Y' " 
   PREPARE afap310_pr_yd_fabd FROM g_sql
   DECLARE afap310_cs_yd_fabd CURSOR FOR afap310_pr_yd_fabd
#######累计折旧#预留残值####################################################################### 
 
#######数量#成本#年限#未折减额#################################################################
#数量/成本/未折减额 afat503/506/507/508 fabh
#                  afat504/505  fabo
#                  afat501 fabd
#年限 afat503/508/501
#afat503/508异动未折减额= 异动成本fabh010-异动累折(fabh012-fabh011)
   #afat503/508
   #重估改良的成本和未折减额都是调整成本
   LET g_sql = " SELECT SUM(fabh006),SUM(fabh010),SUM(fabh010-fabh012+fabh011),SUM(fabh014-fabh013) FROM fabg_t LEFT OUTER JOIN fabh_t ", #20150129 原抓成本fabh008,未折减额fabh004 改成异动后的
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = '",g_enterprise,"' ",
               "    AND fabg005 IN('8','9') AND fabg005 = ? AND fabhld = ? AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh_3 FROM g_sql
   DECLARE afap310_cs_yd_fabh_3 CURSOR FOR afap310_pr_yd_fabh_3

   #afat503/508 调增调减
   LET g_sql = " SELECT fabh018 FROM fabg_t LEFT OUTER JOIN fabh_t ",  
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = '",g_enterprise,"' ",
               "    AND fabg005 IN('8','9') AND fabg005 = ? AND fabhld = ? AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh018 FROM g_sql
   DECLARE afap310_cs_yd_fabh018 CURSOR FOR afap310_pr_yd_fabh018
   
   #afat506/507
   LET g_sql = " SELECT SUM(fabh007),SUM(fabh008),SUM(fabh004),'' FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = '",g_enterprise,"' ",
               "    AND fabg005 IN('6','21') AND fabg005 = ? AND fabhld = ? AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabh_5 FROM g_sql
   DECLARE afap310_cs_yd_fabh_5 CURSOR FOR afap310_pr_yd_fabh_5
   
   #afat504/505
   LET g_sql = " SELECT SUM(fabo007),SUM(fabo018),SUM(fabo022),'' FROM fabg_t LEFT OUTER JOIN fabo_t ",
               "     ON fabgent = faboent AND fabgld = fabold AND fabgdocno =  fabodocno ",
               "  WHERE faboent = '",g_enterprise,"' ",
               "    AND fabg005 IN('4','17') AND fabg005 = ? AND fabold = ? AND fabo003 = ? AND fabo001 = ? AND fabo002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'S' " 
   PREPARE afap310_pr_yd_fabo_2 FROM g_sql
   DECLARE afap310_cs_yd_fabo_2 CURSOR FOR afap310_pr_yd_fabo_2
   
   #afat501
   LET g_sql = " SELECT '','','',fabd007 FROM fabg_t LEFT OUTER JOIN fabd_t ",
               "     ON fabgent = fabdent AND fabgld = fabdld AND fabgdocno =  fabddocno ",
               "  WHERE fabdent = '",g_enterprise,"' ",
               "    AND fabg005 IN('12') AND fabg005 = ? AND fabdld = ? AND fabd000 = ? AND fabd001 = ? AND fabd002 = ? ",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", #20150203 add by chenying 
               "    AND fabgstus = 'Y' " 
   PREPARE afap310_pr_yd_fabd_2 FROM g_sql
   DECLARE afap310_cs_yd_fabd_2 CURSOR FOR afap310_pr_yd_fabd_2 
#######数量#成本#年限#未折减额#################################################################   
   
   #外送数量 #afat440外送(10)-afat450回收(11) 
   LET g_sql = " SELECT SUM(fabk006) FROM faba_t LEFT OUTER JOIN fabk_t ",
               "     ON fabaent = fabkent AND fabadocno = fabkdocno ",
               "  WHERE fabkent = '",g_enterprise,"' AND faba003 = ? ",
               "    AND fabk000 = ? AND fabk001 = ? AND fabk002 = ? ",
               "    AND fabastus = 'Y' ",
               "    AND fabadocdt <= '",p_edate,"' AND fabadocdt >= '",p_bdate,"' "  #20150203 add by chenying                
   PREPARE afap310_pr_fabk FROM g_sql
   DECLARE afap310_cs_fabk CURSOR FOR afap310_pr_fabk           
 
   #20150605--add--str-- faan015/faan016  账面净值/账面价值改取faaj_t
   LET g_sql = " SELECT faaj016,faaj017,faaj020,faaj034 ",
               "   FROM faaj_t ",
               "  WHERE faajent = '",g_enterprise,"'",
               "    AND faajld = ? ",
               "    AND faaj037 = ? ",
               "    AND faaj001 = ? ",
               "    AND faaj002 = ? "
   PREPARE afap310_prel_faaj FROM g_sql
   DECLARE afap310_curl_faaj CURSOR FOR afap310_prel_faaj
   #20150605--add--end--
   
   FOREACH afap310_cs_qc INTO l_faah.faah001,l_faah.faah003,l_faah.faah004,
                              l_faaj.faajld,l_faah.faah020,l_faaj.faaj015,l_faah.faah006,
                              l_faah.faah015,l_faah.faah018,l_faaj.faaj004,l_faaj.faaj005,
                              l_faaj.faaj014,   #150819-00007#1 add lujh 
                              l_faaj.faaj038    #161104-00048#7 add 
                                      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach afap310_cs_qc:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF

      #币别
      #LET l_faan.faan010 = l_faah.faah020    #150819-00007#1 mark lujh 
      LET l_faan.faan010 = l_faaj.faaj014     #150819-00007#1 add lujh 
   
      #汇率
      LET l_faan.faan011 = l_faaj.faaj015
      #资产状态(暂不考虑下面异动段处理的逻辑，直接来源于afai100)
      #LET l_faan.faan007 = l_faah.faah015   #161104-00048#7 mark
      LET l_faan.faan007 = l_faaj.faaj038    #161104-00048#7 add
      #数量(afai100中最开始的总数量)
      LET l_faan.faan006 = l_faah.faah018
      #耐用年限
      LET l_faan.faan012 = l_faaj.faaj004
      #未使用年限
      LET l_faan.faan013 = l_faaj.faaj005      
      
      #外送数量 afat440\afat450 外送-收回
      #20150120 add by chenying
      LET l_fabk006_1 = 0
      LET l_fabk006_2 = 0
      #20150120 add by chenying
      EXECUTE afap310_cs_fabk USING '10',l_faah.faah001,l_faah.faah003,l_faah.faah004 INTO l_fabk006_1
      EXECUTE afap310_cs_fabk USING '11',l_faah.faah001,l_faah.faah003,l_faah.faah004 INTO l_fabk006_2
      IF cl_null(l_fabk006_1) THEN LET l_fabk006_1 = 0 END IF
      IF cl_null(l_fabk006_2) THEN LET l_fabk006_2 = 0 END IF
      LET l_faan.faan008 = l_fabk006_1 - l_fabk006_2


      
############期初##################
#1#前期faan作为期初
#2#当期afai100新增的作为期初
############期初################## 
      #20150608--add--str--lujh
      LET l_yy = NULL
      LET l_mm = NULL
      IF g_master.faan002 = 1 THEN 
         LET l_yy = g_master.faan001 - 1
         LET l_mm = 12
      ELSE
         LET l_yy = g_master.faan001 
         LET l_mm = g_master.faan002 - 1               
      END IF
      #20150608--add--end--lujh

      LET l_count_qc = 0 #20150120 add by chenying
      #EXECUTE afap310_pr_qc_faan_count USING g_master.faan001,g_master.faan002,   #20150608 mark lujh
      EXECUTE afap310_pr_qc_faan_count USING l_yy,l_mm,    #20150608 add lujh
                                             l_faah.faah001,l_faah.faah003,l_faah.faah004,
                                             l_faaj.faajld
         INTO l_count_qc 
      #若上期faan有期初资料，获取faan作为期初资料    
      #若上期faan无资料,则表示是当期afai100新增的资料,作为期初
      IF l_count_qc > 0 THEN   
         LET l_yy = NULL
         LET l_mm = NULL
         IF g_master.faan002 = 1 THEN 
            LET l_yy = g_master.faan001 - 1
            LET l_mm = 12
         ELSE
            LET l_yy = g_master.faan001 
            LET l_mm = g_master.faan002 - 1               
         END IF   
         
         #20150120 add by chenying
         LET l_faan_qc.faan006 = 0
         LET l_faan_qc.faan007 = 0
         LET l_faan_qc.faan014 = 0
         LET l_faan_qc.faan015 = 0
         LET l_faan_qc.faan016 = 0
         LET l_faan_qc.faan017 = 0
         LET l_faan_qc.faan018 = 0
         LET l_faan_qc.faan019 = 0
         LET l_faan_qc.faan020 = 0
         #20150120 add by chenying
         FOREACH afap310_cs_qc_faan USING l_yy,l_mm,l_faah.faah001,l_faah.faah003,l_faah.faah004,l_faaj.faajld
                                     INTO l_faan_qc.faan006,l_faan_qc.faan007,l_faan_qc.faan014,
                                          l_faan_qc.faan015,l_faan_qc.faan016,l_faan_qc.faan017,
                                          l_faan_qc.faan018,l_faan_qc.faan019,l_faan_qc.faan020
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "foreach afap310_cs_qc_faan:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
               EXIT FOREACH
            END IF
            IF cl_null(l_faan_qc.faan006) THEN LET l_faan_qc.faan006 = 0 END IF           
            IF cl_null(l_faan_qc.faan014) THEN LET l_faan_qc.faan014 = 0 END IF   
            IF cl_null(l_faan_qc.faan015) THEN LET l_faan_qc.faan015 = 0 END IF   
            IF cl_null(l_faan_qc.faan016) THEN LET l_faan_qc.faan016 = 0 END IF   
            IF cl_null(l_faan_qc.faan017) THEN LET l_faan_qc.faan017 = 0 END IF   
            IF cl_null(l_faan_qc.faan018) THEN LET l_faan_qc.faan018 = 0 END IF   
            IF cl_null(l_faan_qc.faan019) THEN LET l_faan_qc.faan019 = 0 END IF
            IF cl_null(l_faan_qc.faan020) THEN LET l_faan_qc.faan020 = 0 END IF              
         END FOREACH  
      ELSE
         #20150120 add by chenying
         LET l_faan_qc.faan006 = 0
         LET l_faan_qc.faan007 = 0
         LET l_faan_qc.faan014 = 0
         LET l_faan_qc.faan015 = 0
         LET l_faan_qc.faan016 = 0
         LET l_faan_qc.faan017 = 0
         LET l_faan_qc.faan018 = 0
         LET l_faan_qc.faan019 = 0
         LET l_faan_qc.faan020 = 0
         #20150120 add by chenying      
         FOREACH afap310_cs_qc_faah USING l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004
                                     INTO l_faan_qc.faan006,l_faan_qc.faan007,l_faan_qc.faan014,
                                          l_faan_qc.faan015,l_faan_qc.faan016,l_faan_qc.faan017,
                                          l_faan_qc.faan018,l_faan_qc.faan019,l_faan_qc.faan020
                                          
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "foreach afap310_cs_qc_faah:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
               EXIT FOREACH
            END IF
            IF cl_null(l_faan_qc.faan006) THEN LET l_faan_qc.faan006 = 0 END IF           
            IF cl_null(l_faan_qc.faan014) THEN LET l_faan_qc.faan014 = 0 END IF   
            IF cl_null(l_faan_qc.faan015) THEN LET l_faan_qc.faan015 = 0 END IF   
            IF cl_null(l_faan_qc.faan016) THEN LET l_faan_qc.faan016 = 0 END IF   
            IF cl_null(l_faan_qc.faan017) THEN LET l_faan_qc.faan017 = 0 END IF   
            IF cl_null(l_faan_qc.faan018) THEN LET l_faan_qc.faan018 = 0 END IF   
            IF cl_null(l_faan_qc.faan019) THEN LET l_faan_qc.faan019 = 0 END IF
            IF cl_null(l_faan_qc.faan020) THEN LET l_faan_qc.faan020 = 0 END IF            
         END FOREACH          
      END IF 
    IF cl_null(l_faan_qc.faan006) THEN LET l_faan_qc.faan006 = 0 END IF           
    IF cl_null(l_faan_qc.faan014) THEN LET l_faan_qc.faan014 = 0 END IF   
    IF cl_null(l_faan_qc.faan015) THEN LET l_faan_qc.faan015 = 0 END IF   
    IF cl_null(l_faan_qc.faan016) THEN LET l_faan_qc.faan016 = 0 END IF   
    IF cl_null(l_faan_qc.faan017) THEN LET l_faan_qc.faan017 = 0 END IF   
    IF cl_null(l_faan_qc.faan018) THEN LET l_faan_qc.faan018 = 0 END IF   
    IF cl_null(l_faan_qc.faan019) THEN LET l_faan_qc.faan019 = 0 END IF
    IF cl_null(l_faan_qc.faan020) THEN LET l_faan_qc.faan020 = 0 END IF        
############异动############################################################################
      LET l_faan.faan017 = 0 #20150120 add by chenying
      #本月折旧（不管是上期faan还是从afai100新增过来的，他都是抓afap230里的faam013作为期末）
      EXECUTE afap310_pr_yd_faam USING l_faah.faah001,l_faah.faah003,l_faah.faah004,l_faaj.faajld
         INTO l_faan.faan017 
      IF cl_null(l_faan.faan017) THEN LET l_faan.faan017 = 0 END IF    
 
#######已计提减值准备金额############################################################### 
      #afat502
      LET l_fabh019_502 = 0  
      LET l_fabh.fabh019 = 0
      LET l_fabh.fabh018 = 0 #20150120 add by chenying
      FOREACH afap310_cs_yd_fabh USING l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh.fabh018,l_fabh.fabh019
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF  

         #回冲为Y,调增：上期的减值准备金额/当期新增afai100+当月的单据上的减值准备金额，调减，就减去
         #回冲为N,上期的减值准备金额/当期新增afai100+当月的单据上的减值准备金额(调增，调减）
         CALL cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9015') RETURNING g_flag
         IF cl_null(l_fabh.fabh019) THEN LET l_fabh.fabh019 = 0 END IF
         IF g_flag = 'Y' THEN 
            #减值准备冲回
            IF l_fabh.fabh018 = '1' THEN #调增
               LET l_fabh019_502 = l_fabh019_502 + l_fabh.fabh019
            ELSE
               LET l_fabh019_502 = l_fabh019_502 + l_fabh.fabh019*(-1)
            END IF            
         ELSE
            #减值准备不冲回
            LET l_fabh019_502 = l_fabh019_502 + l_fabh.fabh019
         END IF    
      END FOREACH
      
      #afat506
      LET l_fabh.fabh019 = 0 
      LET l_fabh019_506 = 0
      FOREACH afap310_cs_yd_fabh_2 USING '6',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh.fabh019
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh.fabh019) THEN LET l_fabh.fabh019 = 0 END IF
         LET l_fabh019_506 = l_fabh.fabh019
      END FOREACH 

      #afat507
      LET l_fabh.fabh019 = 0
      LET l_fabh019_507 = 0      
      FOREACH afap310_cs_yd_fabh_2 USING '21',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh.fabh019
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh.fabh019) THEN LET l_fabh.fabh019 = 0 END IF 
         LET l_fabh019_507 = l_fabh.fabh019
      END FOREACH   
      
      #afat504
      LET l_fabh.fabh019 = 0 
      LET l_fabh019_504 = 0
      FOREACH afap310_cs_yd_fabh_7 USING '4',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh.fabh019
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_7:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh.fabh019) THEN LET l_fabh.fabh019 = 0 END IF
         LET l_fabh019_504 = l_fabh.fabh019
      END FOREACH   

      #afat505
      LET l_fabh.fabh019 = 0
      LET l_fabh019_505 = 0      
      FOREACH afap310_cs_yd_fabh_7 USING '17',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh.fabh019
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_7:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         IF cl_null(l_fabh.fabh019) THEN LET l_fabh.fabh019 = 0 END IF         
         LET l_fabh019_505 = l_fabh.fabh019
      END FOREACH   
      
      #已计提减值准备金额
      IF l_count_qc > 0 THEN #上期
         LET l_faan.faan019 = l_faan_qc.faan019+l_fabh019_502-(l_fabh019_506+l_fabh019_507+l_fabh019_504+l_fabh019_505) 
      ELSE
         LET l_faan.faan019 = l_faan_qc.faan019  
      END IF
      LET l_faan.faan092 = l_fabh019_502
      LET l_faan.faan053 = l_fabh019_506
      LET l_faan.faan063 = l_fabh019_507
      LET l_faan.faan083 = l_fabh019_504
      LET l_faan.faan043 = l_fabh019_505      
#######已计提减值准备金额############################################################### 
   
#######累计折旧#预留残值#######################################################################
      #afat503
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0 
      LET l_fabh011_503 = 0   
      LET l_fabh015_503 = 0      
      FOREACH afap310_cs_yd_fabh_6 USING '8',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                    INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_6:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF  
         LET l_fabh011_503 = l_fabh011
         LET l_fabh015_503 = l_fabh015 
      END FOREACH

      #afat508
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0  
      LET l_fabh015_508 = 0     
      FOREACH afap310_cs_yd_fabh_6 USING '9',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_6:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF         
         LET l_fabh015_508 = l_fabh015_1 
      END FOREACH
      
      #afat504
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0  
      LET l_fabh011_504 = 0
      LET l_fabh015_504 = 0       
      FOREACH afap310_cs_yd_fabo  USING '4',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabo:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF           
         LET l_fabh011_504 = l_fabh011_1
         LET l_fabh015_504 = l_fabh015_1 
      END FOREACH
      
      #afat505
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0  
      LET l_fabh011_505 = 0
      LET l_fabh015_505 = 0       
      FOREACH afap310_cs_yd_fabo USING '17',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabo:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF           
         LET l_fabh011_505 = l_fabh011_1
         LET l_fabh015_505 = l_fabh015_1 
      END FOREACH

      #afat506
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0  
      LET l_fabh011_506 = 0
      LET l_fabh015_506 = 0       
      FOREACH afap310_cs_yd_fabh_6 USING '6',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_6:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF           
         LET l_fabh011_506 = l_fabh011_1
         LET l_fabh015_506 = l_fabh015_1 
      END FOREACH
      
      #afat507
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0  
      LET l_fabh011_507 = 0
      LET l_fabh015_507 = 0       
      FOREACH afap310_cs_yd_fabh_6 USING '21',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_6:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF           
         LET l_fabh011_507 = l_fabh011_1
         LET l_fabh015_507 = l_fabh015_1 
      END FOREACH

      #afat501
      LET l_fabh011 = 0 
      LET l_fabh015 = 0 
      LET l_fabh011_1 = 0 
      LET l_fabh015_1 = 0  
      LET l_fabh015_501 = 0       
      FOREACH afap310_cs_yd_fabd USING '12',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh011,l_fabh015,l_fabh011_1,l_fabh015_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabd:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh011) THEN LET l_fabh011 = 0 END IF
         IF cl_null(l_fabh015) THEN LET l_fabh015 = 0 END IF
         IF cl_null(l_fabh011_1) THEN LET l_fabh011_1 = 0 END IF
         IF cl_null(l_fabh015_1) THEN LET l_fabh015_1 = 0 END IF           
         LET l_fabh015_501 = l_fabh015_1 
      END FOREACH
      
      
      IF cl_null(l_fabh011_503) THEN LET l_fabh011_503 = 0 END IF
      IF cl_null(l_fabh011_504) THEN LET l_fabh011_504 = 0 END IF
      IF cl_null(l_fabh011_505) THEN LET l_fabh011_505 = 0 END IF
      IF cl_null(l_fabh011_506) THEN LET l_fabh011_506 = 0 END IF
      IF cl_null(l_fabh011_507) THEN LET l_fabh011_507 = 0 END IF
      IF cl_null(l_fabh015_503) THEN LET l_fabh015_503 = 0 END IF
      IF cl_null(l_fabh015_504) THEN LET l_fabh015_504 = 0 END IF
      IF cl_null(l_fabh015_505) THEN LET l_fabh015_505 = 0 END IF
      IF cl_null(l_fabh015_506) THEN LET l_fabh015_506 = 0 END IF
      IF cl_null(l_fabh015_507) THEN LET l_fabh015_507 = 0 END IF 
      IF cl_null(l_fabh015_508) THEN LET l_fabh015_508 = 0 END IF        
      IF cl_null(l_fabh015_501) THEN LET l_fabh015_501 = 0 END IF       
      #累计折旧 
      IF l_count_qc > 0 THEN #上期
         #LET l_faan.faan018 = l_faan_qc.faan018+l_faan.faan017-(l_fabh011_503+l_fabh011_504+l_fabh011_505+l_fabh011_506+l_fabh011_507)  #20150608 mark lujh
         LET l_faan.faan018 = l_faan_qc.faan018+l_faan.faan017+l_fabh011_503-(l_fabh011_504+l_fabh011_505+l_fabh011_506+l_fabh011_507)   #20150608 add lujh
      ELSE
         LET l_faan.faan018 = l_faan_qc.faan018#+l_faan.faan017 #20150129 当期时，afap230产生本月折旧更新到afai100 faaj017,故不需再加
      END IF
      LET l_faan.faan032 = l_fabh011_503
      LET l_faan.faan082 = l_fabh011_504
      LET l_faan.faan042 = l_fabh011_505
      LET l_faan.faan052 = l_fabh011_506
      LET l_faan.faan062 = l_fabh011_507
      #预留残值
      IF l_count_qc > 0 THEN #上期
         #LET l_faan.faan020 = l_faan_qc.faan020-(l_fabh015_503+l_fabh015_508+l_fabh015_504+l_fabh015_505+l_fabh015_506+l_fabh015_507+l_fabh015_501) #20150608 mark lujh 
         LET l_faan.faan020 = l_faan_qc.faan020+l_fabh015_503+l_fabh015_508-(l_fabh015_504+l_fabh015_505+l_fabh015_506+l_fabh015_507+l_fabh015_501)  #20150608 add lujh
      ELSE
         LET l_faan.faan020 = l_faan_qc.faan020 
      END IF
      LET l_faan.faan034 = l_fabh015_503
      LET l_faan.faan084 = l_fabh015_504
      LET l_faan.faan044 = l_fabh015_505
      LET l_faan.faan054 = l_fabh015_506
      LET l_faan.faan064 = l_fabh015_507  
      LET l_faan.faan090 = l_fabh015_501  
      LET l_faan.faan073 = l_fabh015_508       
#######累计折旧#预留残值####################################################################### 

#######数量#成本#年限#未折减额#################################################################   
      #afat503
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh007_503 = 0 
      LET l_fabh008_503 = 0 
      LET l_fabh004_503 = 0 
      LET l_fabh013_503 = 0    
      FOREACH afap310_cs_yd_fabh_3 USING '8',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_3:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF

         LET l_fabh018 = NULL  
         EXECUTE afap310_cs_yd_fabh018 USING '8',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh018                     
         IF cl_null(l_fabh018) THEN LET l_fabh018 = 1 END IF                       
         IF l_fabh018 = 2 THEN 
            LET l_fabh008 =  l_fabh008 * (-1)
         END IF
         LET l_fabh007_503 = l_fabh007 
         LET l_fabh008_503 = l_fabh008 
         LET l_fabh004_503 = l_fabh004 
         LET l_fabh013_503 = l_fabh013  
      END FOREACH    

      #afat508
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh007_508 = 0 
      LET l_fabh008_508 = 0 
      LET l_fabh004_508 = 0 
      LET l_fabh013_508 = 0    
      FOREACH afap310_cs_yd_fabh_3 USING '9',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_3:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF 
         
         LET l_fabh018 = NULL 
         EXECUTE afap310_cs_yd_fabh018 USING '9',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh018
         IF cl_null(l_fabh018) THEN LET l_fabh018 = 1 END IF          
         IF l_fabh018 = 2 THEN 
            LET l_fabh008 =  l_fabh008 * (-1)
         END IF         
         LET l_fabh007_508 = l_fabh007 
         LET l_fabh008_508 = l_fabh008 
         LET l_fabh004_508 = l_fabh004 
         LET l_fabh013_508 = l_fabh013  
      END FOREACH  
      
      #afat506
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh007_506 = 0 
      LET l_fabh008_506 = 0 
      LET l_fabh004_506 = 0  
      FOREACH afap310_cs_yd_fabh_5 USING '6',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_5:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF          
         LET l_fabh007_506 = l_fabh007 
         LET l_fabh008_506 = l_fabh008 
         LET l_fabh004_506 = l_fabh004 
      END FOREACH  

      #afat507
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh007_507 = 0 
      LET l_fabh008_507 = 0 
      LET l_fabh004_507 = 0  
      FOREACH afap310_cs_yd_fabh_5 USING '21',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabh_5:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF          
         LET l_fabh007_507 = l_fabh007 
         LET l_fabh008_507 = l_fabh008 
         LET l_fabh004_507 = l_fabh004 
      END FOREACH 
      
      #afat505
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh007_505 = 0 
      LET l_fabh008_505 = 0 
      LET l_fabh004_505 = 0  
      FOREACH afap310_cs_yd_fabo_2 USING '17',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabo_2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF          
         LET l_fabh007_505 = l_fabh007 
         LET l_fabh008_505 = l_fabh008 
         LET l_fabh004_505 = l_fabh004 
      END FOREACH  

      #afat504
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh007_504 = 0 
      LET l_fabh008_504 = 0 
      LET l_fabh004_504 = 0  
      FOREACH afap310_cs_yd_fabo_2 USING '4',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabo_2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF          
         LET l_fabh007_504 = l_fabh007 
         LET l_fabh008_504 = l_fabh008 
         LET l_fabh004_504 = l_fabh004 
      END FOREACH 
      
      #afat501
      LET l_fabh007 = 0 
      LET l_fabh008 = 0 
      LET l_fabh004 = 0 
      LET l_fabh013 = 0
      LET l_fabh013_501 = 0  
      FOREACH afap310_cs_yd_fabd_2 USING '12',l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004 
                                  INTO l_fabh007,l_fabh008,l_fabh004,l_fabh013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach afap310_cs_yd_fabd_2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF 
         IF cl_null(l_fabh007) THEN LET l_fabh007 = 0 END IF
         IF cl_null(l_fabh008) THEN LET l_fabh008 = 0 END IF
         IF cl_null(l_fabh004) THEN LET l_fabh004 = 0 END IF
         IF cl_null(l_fabh013) THEN LET l_fabh013 = 0 END IF          
         LET l_fabh013_501 = l_fabh013 
      END FOREACH  


      IF cl_null(l_fabh007_503) THEN LET l_fabh007_503 = 0 END IF
      IF cl_null(l_fabh007_508) THEN LET l_fabh007_508 = 0 END IF
      IF cl_null(l_fabh007_506) THEN LET l_fabh007_506 = 0 END IF
      IF cl_null(l_fabh007_507) THEN LET l_fabh007_507 = 0 END IF
      IF cl_null(l_fabh007_504) THEN LET l_fabh007_504 = 0 END IF
      IF cl_null(l_fabh007_505) THEN LET l_fabh007_505 = 0 END IF
      IF cl_null(l_fabh008_503) THEN LET l_fabh007_503 = 0 END IF
      IF cl_null(l_fabh008_508) THEN LET l_fabh007_508 = 0 END IF
      IF cl_null(l_fabh008_506) THEN LET l_fabh007_506 = 0 END IF
      IF cl_null(l_fabh008_507) THEN LET l_fabh007_507 = 0 END IF
      IF cl_null(l_fabh008_504) THEN LET l_fabh007_504 = 0 END IF
      IF cl_null(l_fabh008_505) THEN LET l_fabh007_505 = 0 END IF
      IF cl_null(l_fabh013_503) THEN LET l_fabh013_503 = 0 END IF
      IF cl_null(l_fabh013_508) THEN LET l_fabh013_508 = 0 END IF
      IF cl_null(l_fabh004_503) THEN LET l_fabh004_503 = 0 END IF
      IF cl_null(l_fabh004_508) THEN LET l_fabh004_508 = 0 END IF
      IF cl_null(l_fabh004_506) THEN LET l_fabh004_506 = 0 END IF
      IF cl_null(l_fabh004_507) THEN LET l_fabh004_507 = 0 END IF
      IF cl_null(l_fabh004_504) THEN LET l_fabh004_504 = 0 END IF
      IF cl_null(l_fabh004_505) THEN LET l_fabh004_505 = 0 END IF      
      #数量
      LET l_faan.faan030 = l_fabh007_503
      LET l_faan.faan070 = l_fabh007_508
      LET l_faan.faan050 = l_fabh007_506
      LET l_faan.faan060 = l_fabh007_507
      LET l_faan.faan080 = l_fabh007_504
      LET l_faan.faan040 = l_fabh007_505
      #2015/02/15 Add By 01727 ---(S)---
      #如果数量都减完,标示已无此资产.不需要在汇入月结档
#      IF l_faan.faan006 = l_faan.faan030 + l_faan.faan040 + l_faan.faan050 + l_faan.faan060 + l_faan.faan070 + l_faan.faan080 THEN    #mark by yangxf
      IF l_faan.faan006 = l_faan.faan040 + l_faan.faan050 + l_faan.faan060 + l_faan.faan080 THEN   #add by yangxf   
         CONTINUE FOREACH
      END IF
      #2015/02/15 Add By 01727 ---(E)---
      #成本
      LET l_faan_yd.faan014 = l_fabh008_503+l_fabh008_508-(l_fabh008_506+l_fabh008_507+l_fabh008_504+l_fabh008_505) 
      LET l_faan.faan031 = l_fabh008_503
      LET l_faan.faan071 = l_fabh008_508
      LET l_faan.faan051 = l_fabh008_506
      LET l_faan.faan061 = l_fabh008_507
      LET l_faan.faan081 = l_fabh008_504
      LET l_faan.faan041 = l_fabh008_505      
      #年限
      LET l_faan.faan033 = l_fabh013_503
      LET l_faan.faan072 = l_fabh013_508
      LET l_faan.faan091 = l_fabh013_501
      #未折减额
      LET l_faan.faan035 = l_fabh004_503
      LET l_faan.faan074 = l_fabh004_508
      LET l_faan.faan055 = l_fabh004_506
      LET l_faan.faan065 = l_fabh004_507
      LET l_faan.faan085 = l_fabh004_504
      LET l_faan.faan045 = l_fabh004_505        
#######数量#成本#年限#未折减额#################################################################   
#######异动##################################################################################################       

#######期末##################################################################################################  
     #帳面餘額
     IF l_count_qc > 0 THEN 
        LET l_faan.faan014 = l_faan_qc.faan014 + l_faan_yd.faan014 
     ELSE
        LET l_faan.faan014 = l_faan_qc.faan014
     END IF
     #帐面净值= 帳面餘額 - 累計折舊
     #20150605--mod--add--
     #LET l_faan.faan015 = l_faan.faan014 - l_faan.faan018 
     EXECUTE afap310_prel_faaj USING l_faaj.faajld,l_faah.faah001,l_faah.faah003,l_faah.faah004
        INTO l_faaj016,l_faaj017,l_faaj020,l_faaj034
     IF cl_null(l_faaj016) THEN LET l_faaj016= 0 END IF
     IF cl_null(l_faaj017) THEN LET l_faaj017= 0 END IF
     IF cl_null(l_faaj020) THEN LET l_faaj020= 0 END IF
     IF cl_null(l_faaj034) THEN LET l_faaj034= 0 END IF
     LET l_faan.faan015 = l_faaj016+l_faaj020-l_faaj034-l_faaj017
     #帐面价值=  帳面餘額 - 已計提減值準備金額 - 累折
     #LET l_faan.faan016 = l_faan.faan014 - l_faan.faan019 - l_faan.faan018
     #LET l_faan.faan016 = l_faan.faan014 - l_faan.faan019 - l_faan.faan018+l_faaj020-l_faaj034   #20150608 mark lujh
     LET l_faan.faan016 = l_faan.faan015 - l_faan.faan019            #20150608 add lujh
     #20150605--mod--end--
     
     IF cl_null(l_faan.faan014) THEN LET l_faan.faan014 = 0 END IF
     IF cl_null(l_faan.faan015) THEN LET l_faan.faan015 = 0 END IF
     IF cl_null(l_faan.faan016) THEN LET l_faan.faan016 = 0 END IF
#######期末##################################################################################################  
      
      #本位币二汇率，本位币三汇率
      CALL afap310_glaald_get(p_glaald) RETURNING l_faan.faan101,l_faan.faan201
      LET l_faan.faan100 = g_glaa016    #本位币二币别
      LET l_faan.faan200 = g_glaa020    #本位币三币别
      #---本位币二---
      IF g_glaa015 = 'Y' THEN   
         LET l_faan.faan102 = l_faan.faan014 * l_faan.faan101
         LET l_faan.faan103 = l_faan.faan015 * l_faan.faan101
         LET l_faan.faan104 = l_faan.faan016 * l_faan.faan101
         LET l_faan.faan105 = l_faan.faan017 * l_faan.faan101
         LET l_faan.faan106 = l_faan.faan018 * l_faan.faan101
         LET l_faan.faan107 = l_faan.faan019 * l_faan.faan101
         LET l_faan.faan108 = l_faan.faan020 * l_faan.faan101
         LET l_faan.faan120 = l_faan.faan031 * l_faan.faan101
         LET l_faan.faan121 = l_faan.faan032 * l_faan.faan101
         LET l_faan.faan122 = l_faan.faan033 * l_faan.faan101
         LET l_faan.faan123 = l_faan.faan034 * l_faan.faan101
         LET l_faan.faan124 = l_faan.faan035 * l_faan.faan101
         LET l_faan.faan130 = l_faan.faan041 * l_faan.faan101
         LET l_faan.faan131 = l_faan.faan042 * l_faan.faan101
         LET l_faan.faan132 = l_faan.faan043 * l_faan.faan101
         LET l_faan.faan133 = l_faan.faan044 * l_faan.faan101
         LET l_faan.faan134 = l_faan.faan045 * l_faan.faan101
         LET l_faan.faan140 = l_faan.faan051 * l_faan.faan101
         LET l_faan.faan141 = l_faan.faan052 * l_faan.faan101
         LET l_faan.faan142 = l_faan.faan053 * l_faan.faan101
         LET l_faan.faan143 = l_faan.faan054 * l_faan.faan101
         LET l_faan.faan144 = l_faan.faan055 * l_faan.faan101
         LET l_faan.faan150 = l_faan.faan061 * l_faan.faan101
         LET l_faan.faan151 = l_faan.faan062 * l_faan.faan101
         LET l_faan.faan152 = l_faan.faan063 * l_faan.faan101
         LET l_faan.faan153 = l_faan.faan064 * l_faan.faan101
         LET l_faan.faan154 = l_faan.faan065 * l_faan.faan101
         LET l_faan.faan160 = l_faan.faan071 * l_faan.faan101
         LET l_faan.faan161 = l_faan.faan073 * l_faan.faan101
         LET l_faan.faan162 = l_faan.faan074 * l_faan.faan101
         LET l_faan.faan170 = l_faan.faan081 * l_faan.faan101
         LET l_faan.faan171 = l_faan.faan082 * l_faan.faan101
         LET l_faan.faan172 = l_faan.faan083 * l_faan.faan101
         LET l_faan.faan173 = l_faan.faan084 * l_faan.faan101
         LET l_faan.faan174 = l_faan.faan085 * l_faan.faan101 
         LET l_faan.faan190 = l_faan.faan090 * l_faan.faan101
         LET l_faan.faan191 = l_faan.faan092 * l_faan.faan101         
      END IF
      #---本位币三---
      IF g_glaa019 = 'Y' THEN  
         LET l_faan.faan202 = l_faan.faan014 * l_faan.faan201
         LET l_faan.faan203 = l_faan.faan015 * l_faan.faan201
         LET l_faan.faan204 = l_faan.faan016 * l_faan.faan201
         LET l_faan.faan205 = l_faan.faan017 * l_faan.faan201
         LET l_faan.faan206 = l_faan.faan018 * l_faan.faan201
         LET l_faan.faan207 = l_faan.faan019 * l_faan.faan201
         LET l_faan.faan208 = l_faan.faan020 * l_faan.faan201
         LET l_faan.faan220 = l_faan.faan031 * l_faan.faan201
         LET l_faan.faan221 = l_faan.faan032 * l_faan.faan201
         LET l_faan.faan222 = l_faan.faan033 * l_faan.faan201
         LET l_faan.faan223 = l_faan.faan034 * l_faan.faan201
         LET l_faan.faan224 = l_faan.faan035 * l_faan.faan201
         LET l_faan.faan230 = l_faan.faan041 * l_faan.faan201
         LET l_faan.faan231 = l_faan.faan042 * l_faan.faan201
         LET l_faan.faan232 = l_faan.faan043 * l_faan.faan201
         LET l_faan.faan233 = l_faan.faan044 * l_faan.faan201
         LET l_faan.faan234 = l_faan.faan045 * l_faan.faan201
         LET l_faan.faan240 = l_faan.faan051 * l_faan.faan201
         LET l_faan.faan241 = l_faan.faan052 * l_faan.faan201
         LET l_faan.faan242 = l_faan.faan053 * l_faan.faan201
         LET l_faan.faan243 = l_faan.faan054 * l_faan.faan201
         LET l_faan.faan244 = l_faan.faan055 * l_faan.faan201
         LET l_faan.faan250 = l_faan.faan061 * l_faan.faan201
         LET l_faan.faan251 = l_faan.faan062 * l_faan.faan201
         LET l_faan.faan252 = l_faan.faan063 * l_faan.faan201
         LET l_faan.faan253 = l_faan.faan064 * l_faan.faan201
         LET l_faan.faan254 = l_faan.faan065 * l_faan.faan201
         LET l_faan.faan260 = l_faan.faan071 * l_faan.faan201
         LET l_faan.faan261 = l_faan.faan073 * l_faan.faan201
         LET l_faan.faan262 = l_faan.faan074 * l_faan.faan201
         LET l_faan.faan270 = l_faan.faan081 * l_faan.faan201
         LET l_faan.faan271 = l_faan.faan082 * l_faan.faan201
         LET l_faan.faan272 = l_faan.faan083 * l_faan.faan201
         LET l_faan.faan273 = l_faan.faan084 * l_faan.faan201
         LET l_faan.faan274 = l_faan.faan085 * l_faan.faan201 
         LET l_faan.faan290 = l_faan.faan090 * l_faan.faan201
         LET l_faan.faan291 = l_faan.faan092 * l_faan.faan201    
      END IF  

      #小数位数
      #161215-00044#1---modify----begin-----------------
      #SELECT *   INTO g_glaa_t.*  
      SELECT glaaent,glaaownid,glaaowndp,glaacrtid,
             glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
             glaa001,glaa002,glaa003,glaa004,glaa005,
             glaa006,glaa007,glaa008,glaa009,glaa010,
             glaa011,glaa012,glaa013,glaa014,glaa015,
             glaa016,glaa017,glaa018,glaa019,glaa020,
             glaa021,glaa022,glaa023,glaa024,glaa025,
             glaa026,glaa100,glaa101,glaa102,glaa103,
             glaa111,glaa112,glaa113,glaa120,glaa121,
             glaa122,glaa027,glaa130,glaa131,glaa132,
             glaa133,glaa134,glaa135,glaa136,glaa137,
             glaa138,glaa139,glaa140,glaa123,glaa124,
             glaa028 
        INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,
             g_glaa_t.glaacrtdp,g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
             g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,
             g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
             g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,
             g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
             g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,
             g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
             g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,
             g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
             g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,
             g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
             g_glaa_t.glaa028            
       #161215-00044#1---modify----end-----------------
       FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_glaald 
      SELECT ooaj003,ooaj004 INTO l_ooaj003,l_ooaj004 FROM ooaj_t WHERE ooajent = g_enterprise
         AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = l_faan.faan010
      SELECT ooaj004 INTO l_ooaj0042 FROM ooaj_t WHERE ooajent = g_enterprise
         AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa016
      SELECT ooaj004 INTO l_ooaj0043 FROM ooaj_t WHERE ooajent = g_enterprise
         AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa020  
      #本位币
#      LET l_faan.faan011 = s_num_round('1',l_faan.faan011,l_ooaj003)
      LET l_faan.faan014 = s_num_round('1',l_faan.faan014,l_ooaj004)
      LET l_faan.faan015 = s_num_round('1',l_faan.faan015,l_ooaj004)
      LET l_faan.faan016 = s_num_round('1',l_faan.faan016,l_ooaj004)
      LET l_faan.faan017 = s_num_round('1',l_faan.faan017,l_ooaj004)
      LET l_faan.faan018 = s_num_round('1',l_faan.faan018,l_ooaj004)
      LET l_faan.faan019 = s_num_round('1',l_faan.faan019,l_ooaj004)
      LET l_faan.faan020 = s_num_round('1',l_faan.faan020,l_ooaj004)
      LET l_faan.faan031 = s_num_round('1',l_faan.faan031,l_ooaj004)
      LET l_faan.faan032 = s_num_round('1',l_faan.faan032,l_ooaj004)
      LET l_faan.faan033 = s_num_round('1',l_faan.faan033,l_ooaj004)
      LET l_faan.faan034 = s_num_round('1',l_faan.faan034,l_ooaj004)
      LET l_faan.faan035 = s_num_round('1',l_faan.faan035,l_ooaj004)
      LET l_faan.faan041 = s_num_round('1',l_faan.faan041,l_ooaj004)
      LET l_faan.faan042 = s_num_round('1',l_faan.faan042,l_ooaj004)
      LET l_faan.faan043 = s_num_round('1',l_faan.faan043,l_ooaj004)
      LET l_faan.faan044 = s_num_round('1',l_faan.faan044,l_ooaj004)
      LET l_faan.faan045 = s_num_round('1',l_faan.faan045,l_ooaj004)
      LET l_faan.faan051 = s_num_round('1',l_faan.faan051,l_ooaj004)
      LET l_faan.faan052 = s_num_round('1',l_faan.faan052,l_ooaj004)
      LET l_faan.faan053 = s_num_round('1',l_faan.faan053,l_ooaj004)
      LET l_faan.faan054 = s_num_round('1',l_faan.faan054,l_ooaj004)
      LET l_faan.faan055 = s_num_round('1',l_faan.faan055,l_ooaj004)
      LET l_faan.faan061 = s_num_round('1',l_faan.faan061,l_ooaj004)
      LET l_faan.faan062 = s_num_round('1',l_faan.faan062,l_ooaj004)
      LET l_faan.faan063 = s_num_round('1',l_faan.faan063,l_ooaj004)
      LET l_faan.faan064 = s_num_round('1',l_faan.faan064,l_ooaj004)
      LET l_faan.faan065 = s_num_round('1',l_faan.faan065,l_ooaj004)
      LET l_faan.faan071 = s_num_round('1',l_faan.faan071,l_ooaj004)
      LET l_faan.faan073 = s_num_round('1',l_faan.faan073,l_ooaj004)
      LET l_faan.faan074 = s_num_round('1',l_faan.faan074,l_ooaj004)
      LET l_faan.faan081 = s_num_round('1',l_faan.faan081,l_ooaj004)
      LET l_faan.faan082 = s_num_round('1',l_faan.faan082,l_ooaj004)
      LET l_faan.faan083 = s_num_round('1',l_faan.faan083,l_ooaj004)
      LET l_faan.faan084 = s_num_round('1',l_faan.faan084,l_ooaj004)
      LET l_faan.faan085 = s_num_round('1',l_faan.faan085,l_ooaj004) 
      LET l_faan.faan090 = s_num_round('1',l_faan.faan090,l_ooaj004)
      LET l_faan.faan092 = s_num_round('1',l_faan.faan092,l_ooaj004)
  

      #本位币二
#      LET l_faan.faan101 = s_num_round('1',l_faan.faan101,l_ooaj003)
      LET l_faan.faan102 = s_num_round('1',l_faan.faan102,l_ooaj0042)
      LET l_faan.faan103 = s_num_round('1',l_faan.faan103,l_ooaj0042)
      LET l_faan.faan104 = s_num_round('1',l_faan.faan104,l_ooaj0042)
      LET l_faan.faan105 = s_num_round('1',l_faan.faan105,l_ooaj0042)
      LET l_faan.faan106 = s_num_round('1',l_faan.faan106,l_ooaj0042)
      LET l_faan.faan107 = s_num_round('1',l_faan.faan107,l_ooaj0042)
      LET l_faan.faan108 = s_num_round('1',l_faan.faan108,l_ooaj0042)
      LET l_faan.faan120 = s_num_round('1',l_faan.faan120,l_ooaj0042)
      LET l_faan.faan121 = s_num_round('1',l_faan.faan121,l_ooaj0042)
      LET l_faan.faan122 = s_num_round('1',l_faan.faan122,l_ooaj0042)
      LET l_faan.faan123 = s_num_round('1',l_faan.faan123,l_ooaj0042)
      LET l_faan.faan124 = s_num_round('1',l_faan.faan124,l_ooaj0042)
      LET l_faan.faan130 = s_num_round('1',l_faan.faan130,l_ooaj0042)
      LET l_faan.faan131 = s_num_round('1',l_faan.faan131,l_ooaj0042)
      LET l_faan.faan132 = s_num_round('1',l_faan.faan132,l_ooaj0042)
      LET l_faan.faan133 = s_num_round('1',l_faan.faan133,l_ooaj0042)
      LET l_faan.faan134 = s_num_round('1',l_faan.faan134,l_ooaj0042)
      LET l_faan.faan140 = s_num_round('1',l_faan.faan140,l_ooaj0042)
      LET l_faan.faan141 = s_num_round('1',l_faan.faan141,l_ooaj0042)
      LET l_faan.faan142 = s_num_round('1',l_faan.faan142,l_ooaj0042)
      LET l_faan.faan143 = s_num_round('1',l_faan.faan143,l_ooaj0042)
      LET l_faan.faan144 = s_num_round('1',l_faan.faan144,l_ooaj0042)
      LET l_faan.faan150 = s_num_round('1',l_faan.faan150,l_ooaj0042)
      LET l_faan.faan151 = s_num_round('1',l_faan.faan151,l_ooaj0042)
      LET l_faan.faan152 = s_num_round('1',l_faan.faan152,l_ooaj0042)
      LET l_faan.faan153 = s_num_round('1',l_faan.faan153,l_ooaj0042)
      LET l_faan.faan154 = s_num_round('1',l_faan.faan154,l_ooaj0042)
      LET l_faan.faan160 = s_num_round('1',l_faan.faan160,l_ooaj0042)
      LET l_faan.faan161 = s_num_round('1',l_faan.faan161,l_ooaj0042)
      LET l_faan.faan162 = s_num_round('1',l_faan.faan162,l_ooaj0042)
      LET l_faan.faan170 = s_num_round('1',l_faan.faan170,l_ooaj0042)
      LET l_faan.faan171 = s_num_round('1',l_faan.faan171,l_ooaj0042)
      LET l_faan.faan172 = s_num_round('1',l_faan.faan172,l_ooaj0042)
      LET l_faan.faan173 = s_num_round('1',l_faan.faan173,l_ooaj0042)
      LET l_faan.faan174 = s_num_round('1',l_faan.faan174,l_ooaj0042)
      LET l_faan.faan190 = s_num_round('1',l_faan.faan190,l_ooaj0042) 
      LET l_faan.faan191 = s_num_round('1',l_faan.faan191,l_ooaj0042)
 
      
      #本位币三
#      LET l_faan.faan201 = s_num_round('1',l_faan.faan102,l_ooaj003)
      LET l_faan.faan202 = s_num_round('1',l_faan.faan202,l_ooaj0043)
      LET l_faan.faan203 = s_num_round('1',l_faan.faan203,l_ooaj0043)
      LET l_faan.faan204 = s_num_round('1',l_faan.faan204,l_ooaj0043)
      LET l_faan.faan205 = s_num_round('1',l_faan.faan205,l_ooaj0043)
      LET l_faan.faan206 = s_num_round('1',l_faan.faan206,l_ooaj0043)
      LET l_faan.faan207 = s_num_round('1',l_faan.faan207,l_ooaj0043)
      LET l_faan.faan208 = s_num_round('1',l_faan.faan208,l_ooaj0043)
      LET l_faan.faan220 = s_num_round('1',l_faan.faan220,l_ooaj0043)
      LET l_faan.faan221 = s_num_round('1',l_faan.faan221,l_ooaj0043)
      LET l_faan.faan222 = s_num_round('1',l_faan.faan222,l_ooaj0043)
      LET l_faan.faan223 = s_num_round('1',l_faan.faan223,l_ooaj0043)
      LET l_faan.faan224 = s_num_round('1',l_faan.faan224,l_ooaj0043)
      LET l_faan.faan230 = s_num_round('1',l_faan.faan230,l_ooaj0043)
      LET l_faan.faan231 = s_num_round('1',l_faan.faan231,l_ooaj0043)
      LET l_faan.faan232 = s_num_round('1',l_faan.faan232,l_ooaj0043)
      LET l_faan.faan233 = s_num_round('1',l_faan.faan233,l_ooaj0043)
      LET l_faan.faan234 = s_num_round('1',l_faan.faan234,l_ooaj0043)
      LET l_faan.faan240 = s_num_round('1',l_faan.faan240,l_ooaj0043)
      LET l_faan.faan241 = s_num_round('1',l_faan.faan241,l_ooaj0043)
      LET l_faan.faan242 = s_num_round('1',l_faan.faan242,l_ooaj0043)
      LET l_faan.faan243 = s_num_round('1',l_faan.faan243,l_ooaj0043)
      LET l_faan.faan244 = s_num_round('1',l_faan.faan244,l_ooaj0043)
      LET l_faan.faan250 = s_num_round('1',l_faan.faan250,l_ooaj0043)
      LET l_faan.faan251 = s_num_round('1',l_faan.faan251,l_ooaj0043)
      LET l_faan.faan252 = s_num_round('1',l_faan.faan252,l_ooaj0043)
      LET l_faan.faan253 = s_num_round('1',l_faan.faan253,l_ooaj0043)
      LET l_faan.faan254 = s_num_round('1',l_faan.faan254,l_ooaj0043)
      LET l_faan.faan260 = s_num_round('1',l_faan.faan260,l_ooaj0043)
      LET l_faan.faan261 = s_num_round('1',l_faan.faan261,l_ooaj0043)
      LET l_faan.faan262 = s_num_round('1',l_faan.faan262,l_ooaj0043)
      LET l_faan.faan270 = s_num_round('1',l_faan.faan270,l_ooaj0043)
      LET l_faan.faan271 = s_num_round('1',l_faan.faan271,l_ooaj0043)
      LET l_faan.faan272 = s_num_round('1',l_faan.faan272,l_ooaj0043)
      LET l_faan.faan273 = s_num_round('1',l_faan.faan273,l_ooaj0043)
      LET l_faan.faan274 = s_num_round('1',l_faan.faan274,l_ooaj0043)
      LET l_faan.faan290 = s_num_round('1',l_faan.faan290,l_ooaj0043) 
      LET l_faan.faan291 = s_num_round('1',l_faan.faan291,l_ooaj0043)
     
         
      INSERT INTO faan_t(faanent,faancomp,faansite,faan001,faan002,faan003,
                         faan004,faan005 ,faan006 ,faan007,faanld ,faan008,
                         faan010,faan011 ,faan012 ,faan013,faan014,faan015,
                         faan016,faan017 ,faan018 ,faan019,faan020,faan030,
                         faan031,faan032 ,faan033 ,faan034,faan035,faan040,
                         faan041,faan042 ,faan043 ,faan044,faan045,faan050,
                         faan051,faan052 ,faan053 ,faan054,faan055,faan060,
                         faan061,faan062 ,faan063 ,faan064,faan065,faan070,
                         faan071,faan072 ,faan073 ,faan074,faan080,faan081,
                         faan082,faan083 ,faan084 ,faan085,faan090,faan091,
                         faan092,
                         faan100,faan101 ,faan102 ,faan103,faan104,faan105,faan106,faan107,faan108,
                         faan120,faan121 ,faan122 ,faan123,faan124,
                         faan130,faan131 ,faan132 ,faan133,faan134,
                         faan140,faan141 ,faan142 ,faan143,faan144,
                         faan150,faan151 ,faan152 ,faan153,faan154,
                         faan160,faan161 ,faan162 ,faan170,faan171,faan172,faan173,faan174,
                         faan190,faan191 ,        
                         faan200,faan201 ,faan202 ,faan203,faan204,faan205,faan206,faan207,faan208,
                         faan220,faan221 ,faan222 ,faan223,faan224,
                         faan230,faan231 ,faan232 ,faan233,faan234,
                         faan240,faan241 ,faan242 ,faan243,faan244,
                         faan250,faan251 ,faan252 ,faan253,faan254,
                         faan260,faan261 ,faan262 ,faan270,faan271,faan272,faan273,faan274,
                         faan290,faan291 )  
           VALUES(g_enterprise,p_glaacomp,g_master.faansite,g_master.faan001,g_master.faan002,l_faah.faah001, 
                  l_faah.faah003,l_faah.faah004 ,l_faan.faan006 ,l_faan.faan007,l_faan.faanld ,l_faan.faan008,
                  l_faan.faan010,l_faan.faan011 ,l_faan.faan012 ,l_faan.faan013,l_faan.faan014,l_faan.faan015,
                  l_faan.faan016,l_faan.faan017 ,l_faan.faan018 ,l_faan.faan019,l_faan.faan020,l_faan.faan030,
                  l_faan.faan031,l_faan.faan032 ,l_faan.faan033 ,l_faan.faan034,l_faan.faan035,l_faan.faan040,
                  l_faan.faan041,l_faan.faan042 ,l_faan.faan043 ,l_faan.faan044,l_faan.faan045,l_faan.faan050,
                  l_faan.faan051,l_faan.faan052 ,l_faan.faan053 ,l_faan.faan054,l_faan.faan055,l_faan.faan060,
                  l_faan.faan061,l_faan.faan062 ,l_faan.faan063 ,l_faan.faan064,l_faan.faan065,l_faan.faan070,
                  l_faan.faan071,l_faan.faan072 ,l_faan.faan073 ,l_faan.faan074,l_faan.faan080,l_faan.faan081,
                  l_faan.faan082,l_faan.faan083 ,l_faan.faan084 ,l_faan.faan085,l_faan.faan090,l_faan.faan091,
                  l_faan.faan092,
                  l_faan.faan100,l_faan.faan101 ,l_faan.faan102 ,l_faan.faan103,l_faan.faan104,l_faan.faan105,l_faan.faan106,l_faan.faan107,l_faan.faan108,
                  l_faan.faan120,l_faan.faan121 ,l_faan.faan122 ,l_faan.faan123,l_faan.faan124,
                  l_faan.faan130,l_faan.faan131 ,l_faan.faan132 ,l_faan.faan133,l_faan.faan134,
                  l_faan.faan140,l_faan.faan141 ,l_faan.faan142 ,l_faan.faan143,l_faan.faan144,
                  l_faan.faan150,l_faan.faan151 ,l_faan.faan152 ,l_faan.faan153,l_faan.faan154,
                  l_faan.faan160,l_faan.faan161 ,l_faan.faan162 ,l_faan.faan170,l_faan.faan171,l_faan.faan172,l_faan.faan173,l_faan.faan174,
                  l_faan.faan190,l_faan.faan191 ,        
                  l_faan.faan200,l_faan.faan201 ,l_faan.faan202 ,l_faan.faan203,l_faan.faan204,l_faan.faan205,l_faan.faan206,l_faan.faan207,l_faan.faan208,
                  l_faan.faan220,l_faan.faan221 ,l_faan.faan222 ,l_faan.faan223,l_faan.faan224,
                  l_faan.faan230,l_faan.faan231 ,l_faan.faan232 ,l_faan.faan233,l_faan.faan234,
                  l_faan.faan240,l_faan.faan241 ,l_faan.faan242 ,l_faan.faan243,l_faan.faan244,
                  l_faan.faan250,l_faan.faan251 ,l_faan.faan252 ,l_faan.faan253,l_faan.faan254,
                  l_faan.faan260,l_faan.faan261 ,l_faan.faan262 ,l_faan.faan270,l_faan.faan271,l_faan.faan272,l_faan.faan273,l_faan.faan274,
                  l_faan.faan290,l_faan.faan291 ) 
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "insert faan_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N'
         END IF    
   END FOREACH                              

   #根据主帐套的归属法人更新aoos020
   IF g_glaa.glaa014 = 'Y' THEN   
      LET l_yy = NULL
      LET l_mm = NULL
      LET l_yy = cl_get_para(g_enterprise,p_glaacomp,'S-FIN-9018')
      LET l_mm = cl_get_para(g_enterprise,p_glaacomp,'S-FIN-9019')   
      IF l_mm = 12 THEN 
         LET l_yy = l_yy + 1
         LET l_mm = 1
      ELSE
         LET l_yy = l_yy
         LET l_mm = l_mm + 1               
      END IF 
      
      UPDATE ooab_t SET ooab002 = l_yy  
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-9018'
         AND ooabsite = p_glaacomp
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd ooab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
        
      UPDATE ooab_t SET ooab002 = l_mm
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-9019'
         AND ooabsite = p_glaacomp          
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd ooab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
   END IF      
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap310_glaald_get(p_ld) 
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_glaald_get(p_ld)
DEFINE r_faan101    LIKE faan_t.faan101
DEFINE r_faan201    LIKE faan_t.faan101
DEFINE p_ld         LIKE glaa_t.glaald

   SELECT glaa001,glaa004,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaacomp
     INTO g_glaa001,g_glaa004,g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
   IF NOT cl_null(p_ld) THEN   
      IF g_glaa015 = 'Y' THEN
         #-----本位币二-------
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',p_ld,g_today,g_glaa001,
                                   #目的幣別;      交易金額; 匯類類型
                                   g_glaa016,0,g_glaa018)
         RETURNING r_faan101
      END IF
      IF g_glaa019 = 'Y' THEN
         #-----本位币三-------
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',p_ld,g_today,g_glaa001,
                                   #目的幣別;      交易金額; 匯類類型
                                   g_glaa020,0,g_glaa018)
         RETURNING r_faan201

      END IF
   END IF
   RETURN r_faan101,r_faan201
END FUNCTION

################################################################################
# Descriptions...: 产生月结资料
# Memo...........: #160426-00014#25 add 程式优化
# Usage..........: CALL afap310_get_faan2(p_glaald,p_glaacomp,p_bdate,p_edate)
# Input parameter: p_glaald       账套
#                : p_glaacomp     法人
#                : p_bdate        起始日期
#                : p_edate        截止日期
# Return code....: 
# Date & Author..: 2016/07/27 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afap310_get_faan2(p_glaald,p_glaacomp,p_bdate,p_edate)
   DEFINE p_glaald           LIKE glaa_t.glaald
   DEFINE p_glaacomp         LIKE glaa_t.glaacomp
   DEFINE p_bdate            LIKE type_t.dat
   DEFINE p_edate            LIKE type_t.dat
   DEFINE l_sql              STRING
   DEFINE l_sql_faan091      STRING
   DEFINE l_yy               LIKE type_t.num5
   DEFINE l_mm               LIKE type_t.num5


   #折畢再提未用年限faan091 : afat501
   LET l_sql_faan091 = " (SELECT NVL(fabd007,0) FROM fabg_t LEFT OUTER JOIN fabd_t ",
                       "     ON fabgent = fabdent AND fabgld = fabdld AND fabgdocno =  fabddocno ",
                       "  WHERE fabdent = '",g_enterprise,"' ",
                       "    AND fabg005 ='12' AND fabdld = faajld AND fabd000 = faah001 AND fabd001 = faah003 AND fabd002 = faah004 ",
                       "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", 
                       "    AND fabgstus = 'Y') faan091 "  
                       
                       
   #1).抓取所有资产资料插入月结档中
   #账面金额faan015 = faanj016+faaj020-faaj017-faaj034
               #企业编号\法人\资产中心\年度\期别
   LET g_sql = "INSERT INTO faan_t (faanent,faancomp,faansite,faan001,faan002,",
               #卡片编号\财产编号\附号\账套\资产状态\ （列账/列管）
               "                    faan003,faan004,faan005,faanld,faan007,faan009,", #160426-00014#29 add faan009
               #数量\币别\汇率\耐用年限\未使用年限
               "                    faan006,faan010,faan011,faan012,faan013,",
               #本位币二币别\本位币二汇率\本位币三币别\本位币三汇率
               "                    faan100,faan101,faan200,faan201,",
               #账面余额\账面净值\账面价值\累计折旧\减值准备\预留残值
               "                    faan014,faan015,faan016,faan018,faan019,faan020,",
               #本位币二账面余额\本位币二账面净值\本位币二账面价值\本位币二累计折旧\本位币二减值准备\本位币二预留残值
               "                    faan102,faan103,faan104,faan106,faan107,faan108,",
               #本位币三账面余额\本位币三账面净值\本位币三账面价值\本位币三累计折旧\本位币三减值准备\本位币三预留残值
               "                    faan202,faan203,faan204,faan206,faan207,faan208,",
               #折畢再提未用年限faan091
               "                    faan091,",
               #从此处栏位往下，金额默认=0
               "                    faan008,faan017,",
               "                    faan030,faan031,faan032,faan033,faan034,faan035,",
               "                    faan040,faan041,faan042,faan043,faan044,faan045,",
               "                    faan050,faan051,faan052,faan053,faan054,faan055,",
               "                    faan060,faan061,faan062,faan063,faan064,faan065,",
               "                    faan070,faan071,faan072,faan073,faan074,",
               "                    faan080,faan081,faan082,faan083,faan084,faan085,",
               "                    faan090,faan092,",
               #本位币二
               "                    faan105,",
               "                    faan120,faan121,faan122,faan123,faan124,",
               "                    faan130,faan131,faan132,faan133,faan134,",
               "                    faan140,faan141,faan142,faan143,faan144,",
               "                    faan150,faan151,faan152,faan153,faan154,",
               "                    faan160,faan161,faan162,",
               "                    faan170,faan171,faan172,faan173,faan174,",
               "                    faan190,faan191,",
               #本位币三
               "                    faan205,",
               "                    faan220,faan221,faan222,faan223,faan224,",
               "                    faan230,faan231,faan232,faan233,faan234,",
               "                    faan240,faan241,faan242,faan243,faan244,",
               "                    faan250,faan251,faan252,faan253,faan254,",
               "                    faan260,faan261,faan262,",
               "                    faan270,faan271,faan272,faan273,faan274,",
               "                    faan290,faan291",
               ")",
               #企业编号\法人\资产中心\年度\期别
               " SELECT faahent,'",p_glaacomp,"','",g_master.faansite,"',",g_master.faan001,",",g_master.faan002,",",
               #卡片编号\财产编号\附号\账套\资产状态\（列账/列管）
               "        faah001,faah003,faah004,faajld,faah015,faaj048,", #160426-00014#29 add faaj048
               #数量\币别\汇率\耐用年限\未使用年限
               "        faah018,faaj014,faaj015,faaj004,faaj005,", 
               #本位币二币别\本位币二汇率\本位币三币别\本位币三汇率
               "        faaj101,NVL(faaj102,0),faaj151,NVL(faaj152,0),",
               #账面余额\账面净值\账面价值\累计折旧\减值准备\预留残值
               "        faaj016+faaj020,faaj016+faaj020-faaj017-faaj034,0,faaj017,faaj021,faaj019,",      #170207-00026#1 change faaj016 to faaj016+faaj020 
               #本位币二账面余额\本位币二账面净值\本位币二账面价值\本位币二累计折旧\本位币二减值准备\本位币二预留残值
               "        faaj103+faaj117,faaj103+faaj117-faaj104-faaj113,0,faaj104,faaj112,faaj105,",      #170207-00026#1 change faaj103 to faaj103+faaj117 
               #本位币三账面余额\本位币三账面净值\本位币三账面价值\本位币三累计折旧\本位币三减值准备\本位币三预留残值
               "        faaj153+faaj167,faaj153+faaj167-faaj154-faaj163,0,faaj154,faaj162,faaj155,",      #170207-00026#1 change faaj153 to faaj153+faaj167 
                        l_sql_faan091,",",
               #从此处栏位往下，金额默认=0
               "        0,0,",
               "        0,0,0,0,0,0,",
               "        0,0,0,0,0,0,",
               "        0,0,0,0,0,0,",
               "        0,0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,0,",
               "        0,0,",
               #本位币二
               "        0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,",
               #本位币三
               "        0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,0,0,",
               "        0,0,0,",
               "        0,0,0,0,0,",
               "        0,0",
               "   FROM faah_t LEFT JOIN faaj_t ",
               "     ON faajent = faahent AND faah000 = faaj000 ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ",
               "    AND faah015 NOT IN('5','6','10') ",
               "  WHERE faahent = '",g_enterprise,"' AND faajld = '",p_glaald,"'",
               "    AND faah014 <= '",p_edate,"' ", 
               "    AND faahstus = 'Y' AND faajstus = 'Y' "
   PREPARE afap310_ins_faan_pr FROM g_sql
   EXECUTE afap310_ins_faan_pr
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "insert faan_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
   #2).外送数量faan008 = afat440外送(10)-afat450回收(11) 
   LET g_sql = "MERGE INTO faan_t x",
               " USING (SELECT fabk000,fabk001,fabk002,SUM(CASE WHEN faba003='11' THEN fabk006*-1 ELSE fabk006 END) fabk006 ",
               "          FROM faba_t LEFT OUTER JOIN fabk_t ON fabaent = fabkent AND fabadocno = fabkdocno ",
               "         WHERE fabkent = ",g_enterprise,
               "           AND fabastus = 'Y' ",
               "           AND fabadocdt <= '",p_edate,"' AND fabadocdt >= '",p_bdate,"' " ,
               "         GROUP BY fabk000,fabk001,fabk002) y ",
               " ON(x.faan003=y.fabk000 AND x.faan004=y.fabk001 AND x.faan005=y.fabk002)",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan008 = NVL(y.fabk006,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan008_pr FROM g_sql
   EXECUTE afap310_faan008_pr
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan008" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #3).本月折旧faan017/faan105/faan205: afap230
   LET g_sql = "MERGE INTO faan_t x",
               " USING (SELECT faam000,faam001,faam002,NVL(faam013,0) faam013,NVL(faam104,0) faam104,NVL(faam154,0) faam154 ",
               "          FROM faam_t ",
               "         WHERE faament = ",g_enterprise,
               "           AND faamld = '",p_glaald,"'", #170206-00029#1 mod 去除单引号后面多余空格
               "           AND faam007 IN ('1','2') ", 
               "           AND faam004 = '",g_master.faan001,"'", 
               "           AND faam005 = '",g_master.faan002,"') y",
               " ON (x.faan003=y.faam000 AND x.faan004=y.faam001 AND x.faan005=y.faam002)",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan017 = NVL(y.faam013,0),",
               "            x.faan105 = NVL(y.faam104,0),",
               "            x.faan205 = NVL(y.faam154,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan017_pr FROM g_sql
   EXECUTE afap310_faan017_pr
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan017" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF          
              
   #4).afat501          
   #折畢再提預留殘值faan090/faan190/faan290 = SUM(fabd010) 
   LET g_sql = "MERGE INTO faan_t x",
               " USING (SELECT fabd000,fabd001,fabd002,SUM(NVL(fabd010,0)) fabd010,SUM(NVL(fabd103,0)) fabd103,SUM(NVL(fabd152,0)) fabd152 ",
               "          FROM fabg_t LEFT OUTER JOIN fabd_t ",
               "            ON fabgent = fabdent AND fabgld = fabdld AND fabgdocno =  fabddocno ",
               "         WHERE fabdent = ",g_enterprise, #170206-00029#1 去除g_enterprise前后单引号
               "           AND fabg005 ='12' AND fabdld = '",p_glaald,"'",
               "           AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ",
               "           AND fabgstus = 'Y' ",
               "         GROUP BY fabd000,fabd001,fabd002) y",            
               " ON (x.faan003=y.fabd000 AND x.faan004=y.fabd001 AND x.faan005=y.fabd002)",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan090 = NVL(y.fabd010,0),",
               "            x.faan190 = NVL(y.fabd103,0),",
               "            x.faan290 = NVL(y.fabd152,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan090_pr FROM g_sql
   EXECUTE afap310_faan090_pr
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan090" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 

   #5).afat502
   #减值准备金额faa092/faan191/faan291 = SUM(fabh019) 
   #回冲为Y,调增：上期的减值准备金额/当期新增afai100+当月的单据上的减值准备金额，调减，就减去
   #回冲为N,上期的减值准备金额/当期新增afai100+当月的单据上的减值准备金额(调增，调减）
   CALL cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9015') RETURNING g_flag
   LET g_sql = "MERGE INTO faan_t x",
               " USING(SELECT fabh000,fabh001,fabh002,",
               "              SUM(NVL(CASE WHEN '",g_flag,"' = 'Y' AND fabh018 <> '1' THEN fabh019*-1 ELSE fabh019 END,0)) fabh019,",
               "              SUM(NVL(CASE WHEN '",g_flag,"' = 'Y' AND fabh018 <> '1' THEN fabh110*-1 ELSE fabh110 END,0)) fabh110,",
               "              SUM(NVL(CASE WHEN '",g_flag,"' = 'Y' AND fabh018 <> '1' THEN fabh160*-1 ELSE fabh160 END,0)) fabh160 ",
               "         FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "           ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "        WHERE fabhent = ",g_enterprise," AND fabhld = '",p_glaald,"'", #170206-00029#1 去除g_enterprise前后单引号
               "          AND fabg005 = '14' ",
               "          AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", 
               "          AND fabgstus = 'S'",
               "        GROUP BY fabh000,fabh001,fabh002) y ",
               " ON (x.faan003=y.fabh000 AND x.faan004=y.fabh001 AND x.faan005=y.fabh002)",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan092 = NVL(y.fabh019,0),",
               "            x.faan191 = NVL(y.fabh110,0),",
               "            x.faan291 = NVL(y.fabh160,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan092_pr FROM g_sql
   EXECUTE afap310_faan092_pr
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan092" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 

   #6).afat503
   #重估數量faan030 = SUM(fabh006)
   #重估成本faan031/faan120/faan220 = SUM(fabh010)
   #重估異動累計折舊faan032/faan121/faan221 = SUM(fabh012-fabh011)
   #重估異動年限faan033 = SUM(fabh014-fabh013)
   #重估異動預留殘值faan034/faan123/faan223 = SUM(fabh016-fabh015)
   #重估未折減額faan035/faan124/faan224 = SUM(fabh010-fabh012+fabh011)
   LET l_sql = " SELECT fabh000,fabh001,fabh002,",
               #        重估数量/重估成本
               "        SUM(fabh006) fabh006,SUM(fabh010) fabh010,",
               #        重估异动累计折旧
               "        SUM(fabh012-fabh011) fabh012_11,",
               #        重估异动年限 
               "        SUM(fabh014-fabh013) fabh014_13,",
               #        重估异动预留残值
               "        SUM(fabh016-fabh015) fabh016_15,",
               #        重估未折减额
               "        SUM(fabh010-fabh012+fabh011) fabh010_12,",  
               #        预留残值
               "        SUM(fabh015) fabh015,",
               #        本位币二重估成本/本位币三重估成本
               "        SUM(NVL(fabh103,0)) fabh103,SUM(NVL(fabh153,0)) fabh153,",               
               #        本位币二重估异动累计折旧/本位币三重估异动累计折旧
               "        SUM(NVL(fabh105-fabh104,0)) fabh105_104,SUM(NVL(fabh155-fabh154,0)) fabh155_154,",
               #        本位币二重估异动预留残值/本位币三重估异动预留残值
               "        SUM(NVL(fabh107-fabh106,0)) fabh107_106,SUM(NVL(fabh157-fabh156,0)) fabh157_156,",
               #        本位币二重估未折减额/本位币三重估未折减额
               "        SUM(NVL(fabh103-fabh105+fabh104,0)) fabh103_105,SUM(NVL(fabh153-fabh155+fabh154,0)) fabh153_155,",
               #        本位币二预留残值/本位币三预留残值
               "        SUM(NVL(fabh106,0)) fabh106,SUM(NVL(fabh156,0)) fabh156 ",
               "   FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = ",g_enterprise, #170206-00029#1 去除g_enterprise前后单引号
               "    AND fabg005 = ? AND fabhld = '",p_glaald,"'",
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", 
               "    AND fabgstus = 'S' ",
               "  GROUP BY fabh000,fabh001,fabh002 "
   LET g_sql = "MERGE INTO faan_t x",
               " USING(",l_sql,") y",
               " ON (x.faan003=y.fabh000 AND x.faan004=y.fabh001 AND x.faan005=y.fabh002) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan030 = NVL(y.fabh006,0),",
               "            x.faan031 = NVL(y.fabh010,0),",
               "            x.faan032 = NVL(y.fabh012_11,0),",
               "            x.faan033 = NVL(y.fabh014_13,0),",
               "            x.faan034 = NVL(y.fabh016_15,0),",
               "            x.faan035 = NVL(y.fabh010_12,0),",
               "            x.faan120 = NVL(y.fabh103,0),",
               "            x.faan121 = NVL(y.fabh105_104,0),",
               "            x.faan123 = NVL(y.fabh107_106,0),",
               "            x.faan124 = NVL(y.fabh103_105,0),",
               "            x.faan220 = NVL(y.fabh153,0),",
               "            x.faan221 = NVL(y.fabh155_154,0),",
               "            x.faan223 = NVL(y.fabh157_156,0),",
               "            x.faan224 = NVL(y.fabh153_155,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan030_pr FROM g_sql
   EXECUTE afap310_faan030_pr USING '8'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan030" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #7).afat508
   #改良數量faan070 = SUM(fabh006)
   #改良成本faan071/faan160/faan260 = SUM(fabh010)
   #改良異動未用年限faan072 = SUM(fabh014-fabh013)
   #改良異動預留殘值faan073/faan161/faan261 = SUM(fabh015)
   #改良未折減額faan074/faan162/faan262 = SUM(fabh010-fabh012+fabh011)
   LET g_sql = "MERGE INTO faan_t x",
               " USING(",l_sql,") y",
               " ON (x.faan003=y.fabh000 AND x.faan004=y.fabh001 AND x.faan005=y.fabh002) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan070 = NVL(y.fabh006,0),",
               "            x.faan071 = NVL(y.fabh010,0),",
               "            x.faan072 = NVL(y.fabh014_13,0),",
               "            x.faan073 = NVL(y.fabh015,0),",
               "            x.faan074 = NVL(y.fabh010_12,0),",
               "            x.faan160 = NVL(y.fabh103,0),",
               "            x.faan161 = NVL(y.fabh106,0),",
               "            x.faan162 = NVL(y.fabh103_105,0),",
               "            x.faan260 = NVL(y.fabh153,0),",
               "            x.faan261 = NVL(y.fabh156,0),",
               "            x.faan262 = NVL(y.fabh153_155,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan070_pr FROM g_sql
   EXECUTE afap310_faan070_pr USING '9'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan070" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #8).afat504
   #一般銷售數量faan080 = SUM(fabo007)
   #一般銷售成本faan081/faan170/faan270 = SUM(fabo018)
   #一般銷售累計折舊faan082/faan171/faan271 = SUM(fabo019)
   #一般銷售計提減值準備faan083/faan172/faan272 = SUM(fabo020)
   #一般銷售預留殘值faan084/faan173/faan273 = SUM(fabo025)
   #一般銷售未折減額faan085/faan174/faan274 = SUM(fabo022)
   LET l_sql= " SELECT fabo003,fabo001,fabo002,",
              #数量/成本/累計折舊
              "        SUM(fabo007) fabo007,SUM(fabo018) fabo018,SUM(fabo019) fabo019,",
              #計提減值準備/預留殘值/未折減額
              "        SUM(fabo020) fabo020,SUM(fabo025) fabo025,SUM(fabo022) fabo022,",
              #本位币二成本/本位币二累計折舊
              "        SUM(fabo107) fabo107,SUM(fabo108) fabo108,",
              #本位币二計提減值準備/本位币二預留殘值/本位币二未折減額
              "        SUM(fabo109) fabo109,SUM(fabo112) fabo112,SUM(fabo111) fabo111,",
              #本位币三成本/本位币三累計折舊
              "        SUM(fabo156) fabo156,SUM(fabo157) fabo157,",
              #本位币三計提減值準備/本位币三預留殘值/本位币三未折減額
              "        SUM(fabo158) fabo158,SUM(fabo161) fabo161,SUM(fabo160) fabo160 ",
              "    FROM fabg_t LEFT OUTER JOIN fabo_t ",
              "     ON fabgent = faboent AND fabgld = fabold AND fabgdocno =  fabodocno ",
              "  WHERE faboent = ",g_enterprise, #170206-00029#1 去除g_enterprise前后单引号
              "    AND fabg005 = ? AND fabold = '",p_glaald,"'",
              "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ", 
              "    AND fabgstus = 'S' ",
              "  GROUP BY fabo003,fabo001,fabo002"
  
   LET g_sql = "MERGE INTO faan_t x",
               " USING(",l_sql,") y",
               " ON (x.faan003=y.fabo003 AND x.faan004=y.fabo001 AND x.faan005=y.fabo002) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan080 = NVL(y.fabo007,0),",
               "            x.faan081 = NVL(y.fabo018,0),",
               "            x.faan082 = NVL(y.fabo019,0),",
               "            x.faan083 = NVL(y.fabo020,0),",
               "            x.faan084 = NVL(y.fabo025,0),",
               "            x.faan085 = NVL(y.fabo022,0),",
               "            x.faan170 = NVL(y.fabo107,0),",
               "            x.faan171 = NVL(y.fabo108,0),",
               "            x.faan172 = NVL(y.fabo109,0),",
               "            x.faan173 = NVL(y.fabo112,0),",
               "            x.faan174 = NVL(y.fabo111,0),",
               "            x.faan270 = NVL(y.fabo156,0),",
               "            x.faan271 = NVL(y.fabo157,0),",
               "            x.faan272 = NVL(y.fabo158,0),",
               "            x.faan273 = NVL(y.fabo161,0),",
               "            x.faan274 = NVL(y.fabo160,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan080_pr FROM g_sql
   EXECUTE afap310_faan080_pr USING '4'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan080" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #9).afat505
   #内部銷售數量faan040 = SUM(fabo007)
   #内部銷售成本faan041/faan130/faan230 = SUM(fabo018)
   #内部銷售累計折舊faan042/faan131/faan231 = SUM(fabo019)
   #内部銷售計提減值準備faan043/faan132/faan232 = SUM(fabo020)
   #内部銷售預留殘值faan044/faan133/faan233 = SUM(fabo025)
   #内部銷售未折減額faan045/faan134/faan234 = SUM(fabo022)
   LET g_sql = "MERGE INTO faan_t x",
               " USING(",l_sql,") y",
               " ON (x.faan003=y.fabo003 AND x.faan004=y.fabo001 AND x.faan005=y.fabo002) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan040 = NVL(y.fabo007,0),",
               "            x.faan041 = NVL(y.fabo018,0),",
               "            x.faan042 = NVL(y.fabo019,0),",
               "            x.faan043 = NVL(y.fabo020,0),",
               "            x.faan044 = NVL(y.fabo025,0),",
               "            x.faan045 = NVL(y.fabo022,0),",
               "            x.faan130 = NVL(y.fabo107,0),",
               "            x.faan131 = NVL(y.fabo108,0),",
               "            x.faan132 = NVL(y.fabo109,0),",
               "            x.faan133 = NVL(y.fabo112,0),",
               "            x.faan134 = NVL(y.fabo111,0),",
               "            x.faan230 = NVL(y.fabo156,0),",
               "            x.faan231 = NVL(y.fabo157,0),",
               "            x.faan232 = NVL(y.fabo158,0),",
               "            x.faan233 = NVL(y.fabo161,0),",
               "            x.faan234 = NVL(y.fabo160,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan040_pr FROM g_sql
   EXECUTE afap310_faan040_pr USING '17'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan040" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
   #10).afat506
   #銷帳數量faan050 = SUM(fabh007)
   #銷帳成本faan051/faan140/faan240 = SUM(fabh008)
   #銷帳累計折舊faan052/faan141/faan241 = SUM(fabh011)
   #銷帳已計提減值準備faan053/faan142/faan242 = SUM(fabh019)
   #銷帳預留殘值faan054/faan143/faan243 = SUM(fabh015)
   #銷帳未折減額faan055/faan144/faan244 = SUM(fabh004)
   LET l_sql = " SELECT fabh000,fabh001,fabh002,",
               #数量/成本/累计折旧
               "        SUM(fabh007) fabh007,SUM(fabh008) fabh008,SUM(fabh011) fabh011,",
               #减值准备/预留残值/未折减额
               "        SUM(fabh019) fabh019,SUM(fabh015) fabh015,SUM(fabh004) fabh004,",
               #本位币二成本/本位币二累计折旧
               "        SUM(fabh102) fabh102,SUM(fabh104) fabh104,",
               #本位币二减值准备/本位币二预留残值/本位币二未折减额
               "        SUM(fabh110) fabh110,SUM(fabh106) fabh106,SUM(fabh108) fabh108,",
               #本位币三成本/本位币三累计折旧
               "        SUM(fabh152) fabh152,SUM(fabh154) fabh154,",
               #本位币三减值准备/本位币三预留残值/本位币三未折减额
               "        SUM(fabh160) fabh160,SUM(fabh156) fabh156,SUM(fabh158) fabh158 ",
               "   FROM fabg_t LEFT OUTER JOIN fabh_t ",
               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
               "  WHERE fabhent = ",g_enterprise, #170206-00029#1 去除g_enterprise前后单引号
               "    AND fabg005 = ? AND fabhld = '",p_glaald,"'", 
               "    AND fabgdocdt <= '",p_edate,"' AND fabgdocdt >= '",p_bdate,"' ",
               "    AND fabgstus = 'S'",
               "  GROUP BY fabh000,fabh001,fabh002 "
    
   LET g_sql = "MERGE INTO faan_t x",
               " USING(",l_sql,") y",
               " ON (x.faan003=y.fabh000 AND x.faan004=y.fabh001 AND x.faan005=y.fabh002) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan050 = NVL(y.fabh007,0),",
               "            x.faan051 = NVL(y.fabh008,0),",
               "            x.faan052 = NVL(y.fabh011,0),",
               "            x.faan053 = NVL(y.fabh019,0),",
               "            x.faan054 = NVL(y.fabh015,0),",
               "            x.faan055 = NVL(y.fabh004,0),",
               "            x.faan140 = NVL(y.fabh102,0),",
               "            x.faan141 = NVL(y.fabh104,0),",
               "            x.faan142 = NVL(y.fabh110,0),",
               "            x.faan143 = NVL(y.fabh106,0),",
               "            x.faan144 = NVL(y.fabh108,0),",
               "            x.faan240 = NVL(y.fabh152,0),",
               "            x.faan241 = NVL(y.fabh154,0),",
               "            x.faan242 = NVL(y.fabh160,0),",
               "            x.faan243 = NVL(y.fabh156,0),",
               "            x.faan244 = NVL(y.fabh158,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan050_pr FROM g_sql
   EXECUTE afap310_faan050_pr USING '6'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan050" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 

   #11).afat507
   #報廢數量faan060 = SUM(fabh007)
   #報廢成本faan061/faan150/faan250 = SUM(fabh008)
   #報廢累計折舊faan062/faan151/faan251 = SUM(fabh011)
   #報廢已計提減值準備faan063/faan152/faan252 = SUM(fabh019)
   #報廢預留殘值faan064/faan153/faan253 = SUM(fabh015)
   #報廢未折減額faan065/faan154/faan254 = SUM(fabh004)
   LET g_sql = "MERGE INTO faan_t x",
               " USING(",l_sql,") y",
               " ON (x.faan003=y.fabh000 AND x.faan004=y.fabh001 AND x.faan005=y.fabh002) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan060 = NVL(y.fabh007,0),",
               "            x.faan061 = NVL(y.fabh008,0),",
               "            x.faan062 = NVL(y.fabh011,0),",
               "            x.faan063 = NVL(y.fabh019,0),",
               "            x.faan064 = NVL(y.fabh015,0),",
               "            x.faan065 = NVL(y.fabh004,0),",
               "            x.faan150 = NVL(y.fabh102,0),",
               "            x.faan151 = NVL(y.fabh104,0),",
               "            x.faan152 = NVL(y.fabh110,0),",
               "            x.faan153 = NVL(y.fabh106,0),",
               "            x.faan154 = NVL(y.fabh108,0),",
               "            x.faan250 = NVL(y.fabh152,0),",
               "            x.faan251 = NVL(y.fabh154,0),",
               "            x.faan252 = NVL(y.fabh160,0),",
               "            x.faan253 = NVL(y.fabh156,0),",
               "            x.faan254 = NVL(y.fabh158,0) ",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan060_pr FROM g_sql
   EXECUTE afap310_faan060_pr USING '21'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan060" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #12).如果数量都减完,标示已无此资产.不需要在汇入月结档，
   #    因此，删除faan006 = faan040 + faan050 + faan060 + faan080
   DELETE FROM faan_t
   WHERE faanent=g_enterprise AND faan001=g_master.faan001 AND faan002=g_master.faan002
   AND faanld=p_glaald AND faan006 = faan040 + faan050 + faan060 + faan080
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "delete faan_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 

   #13).更新
   #账面余额faan014=期初 + faan031 + faan071 - (faan041 + faan051 + faan061 + faan081)
   #累计折旧faan018=期初 + faan017 + faan032 - (faan042 + faan052 + faan062 + faan082
   #减值准备faan019=期初 + faan092 - (faan043 + faan053 + faan063 + faan083)
   #预留残值faan020=期初 + faan034 + faan073 - (faan044 + faan054 + faan064 + faan084 + faan090)
   LET l_yy = NULL
   LET l_mm = NULL
   IF g_master.faan002 = 1 THEN 
      LET l_yy = g_master.faan001 - 1
      LET l_mm = 12
   ELSE
      LET l_yy = g_master.faan001 
      LET l_mm = g_master.faan002 - 1               
   END IF 
   LET g_sql = "MERGE INTO faan_t x",
               " USING( SELECT faan003,faan004,faan005,faan014,faan018,faan019,faan020, ",
               "               faan102,faan106,faan107,faan108,faan202,faan206,faan207,faan208 ",
               "          FROM faan_t ",
               "         WHERE faanent=",g_enterprise," AND faan001=",l_yy," AND faan002=",l_mm,
               "           AND faanld='",p_glaald,"'",
               "       ) y",
               " ON (x.faan003=y.faan003 AND x.faan004=y.faan004 AND x.faan005=y.faan005) ",
               " WHEN MATCHED THEN ",
               " UPDATE SET x.faan014 = y.faan014 + x.faan031 + x.faan071 - (x.faan041 + x.faan051 + x.faan061 + x.faan081),",
               "            x.faan018 = y.faan018 + x.faan017 + x.faan032 - (x.faan042 + x.faan052 + x.faan062 + x.faan082),",
               "            x.faan019 = y.faan019 + x.faan092 - (x.faan043 + x.faan053 + x.faan063 + x.faan083),",
               "            x.faan020 = y.faan020 + x.faan034 + x.faan073 - (x.faan044 + x.faan054 + x.faan064 + x.faan084 + x.faan090),",
               #本位币二
               "            x.faan102 = y.faan102 + x.faan120 + x.faan160 - (x.faan130 + x.faan140 + x.faan150 + x.faan170),",
               "            x.faan106 = y.faan106 + x.faan105 + x.faan121 - (x.faan131 + x.faan141 + x.faan151 + x.faan171),",
               "            x.faan107 = y.faan107 + x.faan191 - (x.faan132 + x.faan142 + x.faan152 + x.faan172),",
               "            x.faan108 = y.faan108 + x.faan123 + x.faan161 - (x.faan133 + x.faan143 + x.faan153 + x.faan173 + x.faan190),",
               #本位币三
               "            x.faan202 = y.faan202 + x.faan220 + x.faan260 - (x.faan230 + x.faan240 + x.faan250 + x.faan270),",
               "            x.faan206 = y.faan206 + x.faan205 + x.faan221 - (x.faan231 + x.faan241 + x.faan251 + x.faan271),",
               "            x.faan207 = y.faan207 + x.faan291 - (x.faan232 + x.faan242 + x.faan252 + x.faan272),",
               "            x.faan208 = y.faan208 + x.faan223 + x.faan261 - (x.faan233 + x.faan243 + x.faan253 + x.faan273 + x.faan290)",
               " WHERE x.faanent=",g_enterprise," AND x.faan001=",g_master.faan001,
               "   AND x.faan002=",g_master.faan002," AND x.faanld='",p_glaald,"'"
   PREPARE afap310_faan014_pr FROM g_sql
   EXECUTE afap310_faan014_pr
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan014" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #14).更新账面价值faan016 = faan015 - faan019
   UPDATE faan_t SET faan016 = faan015 - faan019,
                     faan104 = faan103 - faan107,
                     faan204 = faan203 - faan207
    WHERE faanent=g_enterprise AND faan001=g_master.faan001 
      AND faan002=g_master.faan002 AND faanld=p_glaald
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan014" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   
   #15).#折畢再提未用年限faan091是数字类型，更新数据库中NULL值为0
   UPDATE faan_t SET faan091 = 0 
    WHERE faanent=g_enterprise AND faan001=g_master.faan001 
      AND faan002=g_master.faan002 AND faanld=p_glaald
      AND faan091 IS NULL
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "update faan014" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
   #根据主帐套的归属法人更新aoos020
   IF g_glaa.glaa014 = 'Y' THEN   
      LET l_yy = NULL
      LET l_mm = NULL
      LET l_yy = cl_get_para(g_enterprise,p_glaacomp,'S-FIN-9018')
      LET l_mm = cl_get_para(g_enterprise,p_glaacomp,'S-FIN-9019')   
      IF l_mm = 12 THEN 
         LET l_yy = l_yy + 1
         LET l_mm = 1
      ELSE
         LET l_yy = l_yy
         LET l_mm = l_mm + 1               
      END IF 
      
      UPDATE ooab_t SET ooab002 = l_yy  
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-9018'
         AND ooabsite = p_glaacomp
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd ooab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
        
      UPDATE ooab_t SET ooab002 = l_mm
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-9019'
         AND ooabsite = p_glaacomp          
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd ooab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
   END IF      
END FUNCTION

#end add-point
 
{</section>}
 
