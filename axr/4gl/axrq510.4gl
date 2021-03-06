#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-04-28 10:36:27), PR版次:0007(2016-12-16 17:28:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: axrq510
#+ Description: 代收銀待抵單查詢作業
#+ Creator....: 02599(2015-04-22 22:20:00)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="axrq510.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#7   2016/02/24  By yangtt   增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串pmabsite
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
#160913-00017#10  2016/09/22  By 07900    AXR模组调整交易客商开窗
#161021-00050#5   2016/10/26  By 08729    處理組織開窗
#161123-00048#5   2016/11/28  By 08729    開窗增加過濾據點
#161215-00044#2   2016/12/16  by 02481    标准程式定义采用宣告模式,弃用.*写
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_xrca_m RECORD
       xrcasite LIKE xrca_t.xrcasite, 
   xrcasite_desc LIKE type_t.chr80, 
   xrca003 LIKE xrca_t.xrca003, 
   xrca003_desc LIKE type_t.chr80, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE type_t.chr80, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrca001 LIKE xrca_t.xrca001, 
   xrcadocno_desc LIKE type_t.chr80, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr80, 
   xrca005 LIKE xrca_t.xrca005, 
   xrca005_desc LIKE type_t.chr80, 
   xrca038 LIKE xrca_t.xrca038, 
   xrcastus LIKE xrca_t.xrcastus, 
   xrca007 LIKE xrca_t.xrca007, 
   xrca007_desc LIKE type_t.chr80, 
   xrca035 LIKE xrca_t.xrca035, 
   xrca035_desc LIKE type_t.chr80, 
   xrca036 LIKE xrca_t.xrca036, 
   xrca036_desc LIKE type_t.chr80, 
   xrca059 LIKE xrca_t.xrca059, 
   xrca059_desc LIKE type_t.chr80, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca103 LIKE xrca_t.xrca103, 
   xrca104 LIKE xrca_t.xrca104, 
   xrca107 LIKE xrca_t.xrca107, 
   xrca108 LIKE xrca_t.xrca108, 
   xrcc109 LIKE type_t.num20_6, 
   lbl_calc LIKE type_t.num20_6, 
   glaa001 LIKE type_t.chr10, 
   xrca101 LIKE xrca_t.xrca101, 
   xrca113 LIKE xrca_t.xrca113, 
   xrca114 LIKE xrca_t.xrca114, 
   xrca117 LIKE xrca_t.xrca117, 
   xrcc113 LIKE type_t.num20_6, 
   xrca118 LIKE xrca_t.xrca118, 
   xrcc119 LIKE type_t.num20_6, 
   lbl_calc2 LIKE type_t.num20_6, 
   xrca014 LIKE xrca_t.xrca014, 
   xrca014_desc LIKE type_t.chr80, 
   xrca034 LIKE xrca_t.xrca034, 
   xrca034_desc LIKE type_t.chr80, 
   xrca015 LIKE xrca_t.xrca015, 
   xrca015_desc LIKE type_t.chr80, 
   xrca033 LIKE xrca_t.xrca033, 
   xrca033_desc LIKE type_t.chr80, 
   xrca060 LIKE xrca_t.xrca060, 
   xrca011 LIKE xrca_t.xrca011, 
   xrca011_desc LIKE type_t.chr80, 
   xrca013 LIKE xrca_t.xrca013, 
   xrca012 LIKE xrca_t.xrca012, 
   xrca016 LIKE xrca_t.xrca016, 
   xrca018 LIKE xrca_t.xrca018, 
   xrca053 LIKE xrca_t.xrca053, 
   xrca017 LIKE xrca_t.xrca017, 
   xrca052 LIKE xrca_t.xrca052, 
   xrca050 LIKE xrca_t.xrca050, 
   xrca063 LIKE xrca_t.xrca063, 
   xrca051 LIKE xrca_t.xrca051, 
   xrca051_desc LIKE type_t.chr80, 
   xrca1002 LIKE type_t.chr10, 
   xrca1032 LIKE type_t.num20_6, 
   xrca1042 LIKE type_t.num20_6, 
   xrca1072 LIKE type_t.num20_6, 
   xrca1082 LIKE type_t.num20_6, 
   xrcc1092 LIKE type_t.num20_6, 
   lbl_calc_2 LIKE type_t.num20_6, 
   glaa0012 LIKE type_t.chr10, 
   xrca1012 LIKE type_t.num26_10, 
   xrca120 LIKE xrca_t.xrca120, 
   xrca121 LIKE xrca_t.xrca121, 
   xrca130 LIKE xrca_t.xrca130, 
   xrca131 LIKE xrca_t.xrca131, 
   xrca1132 LIKE type_t.num20_6, 
   xrca123 LIKE xrca_t.xrca123, 
   xrca133 LIKE xrca_t.xrca133, 
   xrca1142 LIKE type_t.num20_6, 
   xrca124 LIKE xrca_t.xrca124, 
   xrca134 LIKE xrca_t.xrca134, 
   xrca1172 LIKE type_t.num20_6, 
   xrca127 LIKE xrca_t.xrca127, 
   xrca137 LIKE xrca_t.xrca137, 
   xrcc1132 LIKE type_t.num20_6, 
   xrcc123 LIKE type_t.num20_6, 
   xrcc133 LIKE type_t.num20_6, 
   xrca1182 LIKE type_t.num20_6, 
   xrca128 LIKE xrca_t.xrca128, 
   xrca138 LIKE xrca_t.xrca138, 
   xrcc1192 LIKE type_t.num20_6, 
   xrcc129 LIKE type_t.num20_6, 
   xrcc139 LIKE type_t.num20_6, 
   lbl_calc2_2 LIKE type_t.num20_6, 
   lbl_calc3 LIKE type_t.num20_6, 
   lbl_calc4 LIKE type_t.num20_6, 
   xrca006 LIKE xrca_t.xrca006, 
   xrca008 LIKE xrca_t.xrca008, 
   xrca009 LIKE xrca_t.xrca009, 
   xrca010 LIKE xrca_t.xrca010, 
   xrca008_desc LIKE type_t.chr80, 
   xrca019 LIKE xrca_t.xrca019, 
   xrca023 LIKE xrca_t.xrca023, 
   xrca024 LIKE xrca_t.xrca024, 
   xrca058 LIKE xrca_t.xrca058, 
   xrca058_desc LIKE type_t.chr80, 
   xrca046 LIKE xrca_t.xrca046, 
   xrca047 LIKE xrca_t.xrca047, 
   xrca048 LIKE xrca_t.xrca048, 
   xrca025 LIKE xrca_t.xrca025, 
   xrca026 LIKE xrca_t.xrca026, 
   xrca028 LIKE xrca_t.xrca028, 
   xrca028_desc LIKE type_t.chr80, 
   xrca029 LIKE xrca_t.xrca029, 
   xrca030 LIKE xrca_t.xrca030, 
   xrca031 LIKE xrca_t.xrca031, 
   xrca032 LIKE xrca_t.xrca032, 
   xrca021 LIKE xrca_t.xrca021, 
   xrca020 LIKE xrca_t.xrca020, 
   xrca022 LIKE xrca_t.xrca022, 
   xrca065 LIKE xrca_t.xrca065, 
   xrca066 LIKE xrca_t.xrca066, 
   xrca037 LIKE xrca_t.xrca037, 
   xrca039 LIKE xrca_t.xrca039, 
   xrca040 LIKE xrca_t.xrca040, 
   xrca041 LIKE xrca_t.xrca041, 
   xrca041_desc LIKE type_t.chr80, 
   xrca042 LIKE xrca_t.xrca042, 
   xrca043 LIKE xrca_t.xrca043, 
   xrca044 LIKE xrca_t.xrca044, 
   xrca045 LIKE xrca_t.xrca045, 
   xrca049 LIKE xrca_t.xrca049, 
   xrca054 LIKE xrca_t.xrca054, 
   xrca054_desc LIKE type_t.chr80, 
   xrca055 LIKE xrca_t.xrca055, 
   xrca055_desc LIKE type_t.chr80, 
   xrca056 LIKE xrca_t.xrca056, 
   xrca057 LIKE xrca_t.xrca057, 
   xrca057_desc LIKE type_t.chr80, 
   xrca061 LIKE xrca_t.xrca061, 
   xrca062 LIKE xrca_t.xrca062, 
   xrca064 LIKE xrca_t.xrca064, 
   xrca106 LIKE xrca_t.xrca106, 
   xrca116 LIKE xrca_t.xrca116, 
   xrca126 LIKE xrca_t.xrca126, 
   xrca136 LIKE xrca_t.xrca136, 
   xrcacomp LIKE xrca_t.xrcacomp, 
   xrcacomp_desc LIKE type_t.chr80, 
   xrcaownid LIKE xrca_t.xrcaownid, 
   xrcaownid_desc LIKE type_t.chr80, 
   xrcaowndp LIKE xrca_t.xrcaowndp, 
   xrcaowndp_desc LIKE type_t.chr80, 
   xrcacrtid LIKE xrca_t.xrcacrtid, 
   xrcacrtid_desc LIKE type_t.chr80, 
   xrcacrtdp LIKE xrca_t.xrcacrtdp, 
   xrcacrtdp_desc LIKE type_t.chr80, 
   xrcacrtdt LIKE xrca_t.xrcacrtdt, 
   xrcamodid LIKE xrca_t.xrcamodid, 
   xrcamodid_desc LIKE type_t.chr80, 
   xrcamoddt LIKE xrca_t.xrcamoddt, 
   xrcacnfid LIKE xrca_t.xrcacnfid, 
   xrcacnfid_desc LIKE type_t.chr80, 
   xrcacnfdt LIKE xrca_t.xrcacnfdt, 
   xrcapstid LIKE xrca_t.xrcapstid, 
   xrcapstid_desc LIKE type_t.chr80, 
   xrcapstdt LIKE xrca_t.xrcapstdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_xrcald LIKE xrca_t.xrcald,
      b_xrcadocno LIKE xrca_t.xrcadocno
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161215-00044#2---modify----begin-----------------
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
 #161215-00044#2---modify----end-----------------
DEFINE g_sql_ctrl        STRING                #151231-00010#7
DEFINE g_site_str        STRING  #160811-00009#2 
DEFINE g_comp            LIKE glaa_t.glaacomp  #161123-00048#5-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xrca_m        type_g_xrca_m  #單頭變數宣告
DEFINE g_xrca_m_t      type_g_xrca_m  #單頭舊值宣告(系統還原用)
DEFINE g_xrca_m_o      type_g_xrca_m  #單頭舊值宣告(其他用途)
DEFINE g_xrca_m_mask_o type_g_xrca_m  #轉換遮罩前資料
DEFINE g_xrca_m_mask_n type_g_xrca_m  #轉換遮罩後資料
 
   DEFINE g_xrcald_t LIKE xrca_t.xrcald
DEFINE g_xrcadocno_t LIKE xrca_t.xrcadocno
 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq510.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#7(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161123-00048#5 mark
   #151231-00010#7(E)
   #161123-00048#5-add(s)
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl
   #161123-00048#5-add(e)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xrcasite,'',xrca003,'',xrcald,'',xrcadocno,xrca001,'',xrcadocdt,xrca004, 
       '',xrca005,'',xrca038,xrcastus,xrca007,'',xrca035,'',xrca036,'',xrca059,'',xrca100,xrca103,xrca104, 
       xrca107,xrca108,'','','',xrca101,xrca113,xrca114,xrca117,'',xrca118,'','',xrca014,'',xrca034, 
       '',xrca015,'',xrca033,'',xrca060,xrca011,'',xrca013,xrca012,xrca016,xrca018,xrca053,xrca017,xrca052, 
       xrca050,xrca063,xrca051,'','','','','','','','','','',xrca120,xrca121,xrca130,xrca131,'',xrca123, 
       xrca133,'',xrca124,xrca134,'',xrca127,xrca137,'','','','',xrca128,xrca138,'','','','','','',xrca006, 
       xrca008,xrca009,xrca010,'',xrca019,xrca023,xrca024,xrca058,'',xrca046,xrca047,xrca048,xrca025, 
       xrca026,xrca028,'',xrca029,xrca030,xrca031,xrca032,xrca021,xrca020,xrca022,xrca065,xrca066,xrca037, 
       xrca039,xrca040,xrca041,'',xrca042,xrca043,xrca044,xrca045,xrca049,xrca054,'',xrca055,'',xrca056, 
       xrca057,'',xrca061,xrca062,xrca064,xrca106,xrca116,xrca126,xrca136,xrcacomp,'',xrcaownid,'',xrcaowndp, 
       '',xrcacrtid,'',xrcacrtdp,'',xrcacrtdt,xrcamodid,'',xrcamoddt,xrcacnfid,'',xrcacnfdt,xrcapstid, 
       '',xrcapstdt", 
                      " FROM xrca_t",
                      " WHERE xrcaent= ? AND xrcald=? AND xrcadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xrcasite,t0.xrca003,t0.xrcald,t0.xrcadocno,t0.xrca001,t0.xrcadocdt, 
       t0.xrca004,t0.xrca005,t0.xrca038,t0.xrcastus,t0.xrca007,t0.xrca035,t0.xrca036,t0.xrca059,t0.xrca100, 
       t0.xrca103,t0.xrca104,t0.xrca107,t0.xrca108,t0.xrca101,t0.xrca113,t0.xrca114,t0.xrca117,t0.xrca118, 
       t0.xrca014,t0.xrca034,t0.xrca015,t0.xrca033,t0.xrca060,t0.xrca011,t0.xrca013,t0.xrca012,t0.xrca016, 
       t0.xrca018,t0.xrca053,t0.xrca017,t0.xrca052,t0.xrca050,t0.xrca063,t0.xrca051,t0.xrca120,t0.xrca121, 
       t0.xrca130,t0.xrca131,t0.xrca123,t0.xrca133,t0.xrca124,t0.xrca134,t0.xrca127,t0.xrca137,t0.xrca128, 
       t0.xrca138,t0.xrca006,t0.xrca008,t0.xrca009,t0.xrca010,t0.xrca019,t0.xrca023,t0.xrca024,t0.xrca058, 
       t0.xrca046,t0.xrca047,t0.xrca048,t0.xrca025,t0.xrca026,t0.xrca028,t0.xrca029,t0.xrca030,t0.xrca031, 
       t0.xrca032,t0.xrca021,t0.xrca020,t0.xrca022,t0.xrca065,t0.xrca066,t0.xrca037,t0.xrca039,t0.xrca040, 
       t0.xrca041,t0.xrca042,t0.xrca043,t0.xrca044,t0.xrca045,t0.xrca049,t0.xrca054,t0.xrca055,t0.xrca056, 
       t0.xrca057,t0.xrca061,t0.xrca062,t0.xrca064,t0.xrca106,t0.xrca116,t0.xrca126,t0.xrca136,t0.xrcacomp, 
       t0.xrcaownid,t0.xrcaowndp,t0.xrcacrtid,t0.xrcacrtdp,t0.xrcacrtdt,t0.xrcamodid,t0.xrcamoddt,t0.xrcacnfid, 
       t0.xrcacnfdt,t0.xrcapstid,t0.xrcapstdt,t1.ooefl003 ,t2.ooag011 ,t3.glaal002 ,t4.oobxl003 ,t5.pmaal004 , 
       t6.pmaal004 ,t7.oocql004 ,t8.bgaal003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooefl003 ,t12.ooefl003 , 
       t13.oodbl004 ,t14.oocq004 ,t15.ooibl004 ,t16.oocql004 ,t17.isacl004 ,t18.oocql004 ,t19.oocql004 , 
       t20.ooidl003 ,t21.ooag011 ,t22.ooefl003 ,t23.ooag011 ,t24.ooefl003 ,t25.ooag011 ,t26.ooefl003 , 
       t27.ooag011 ,t28.ooag011 ,t29.ooag011",
               " FROM xrca_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xrcasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.xrca003  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.xrcald AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t4 ON t4.oobxlent="||g_enterprise||" AND t4.oobxl001=t0.xrcadocno AND t4.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xrca004 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.xrca005 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='3111' AND t7.oocql002=t0.xrca007 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN bgaal_t t8 ON t8.bgaalent="||g_enterprise||" AND t8.bgaal001=t0.xrca059 AND t8.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.xrca014  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.xrca034 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.xrca015 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.xrca033 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oodbl_t t13 ON t13.oodblent="||g_enterprise||" AND t13.oodbl001='' AND t13.oodbl002=t0.xrca011 AND t13.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN oocq_t t14 ON t14.oocqent="||g_enterprise||" AND t14.oocq001='3115' AND t14.oocq002=t0.xrca015 AND t14.oocq003='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t15 ON t15.ooiblent="||g_enterprise||" AND t15.ooibl002=t0.xrca008 AND t15.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='295' AND t16.oocql002=t0.xrca058 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN isacl_t t17 ON t17.isaclent="||g_enterprise||" AND t17.isacl001='' AND t17.isacl002=t0.xrca028 AND t17.isacl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='3113' AND t18.oocql002=t0.xrca041 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='3114' AND t19.oocql002=t0.xrca054 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooidl_t t20 ON t20.ooidlent="||g_enterprise||" AND t20.ooidl001=t0.xrca055 AND t20.ooidl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t21 ON t21.ooagent="||g_enterprise||" AND t21.ooag001=t0.xrca057  ",
               " LEFT JOIN ooefl_t t22 ON t22.ooeflent="||g_enterprise||" AND t22.ooefl001=t0.xrcacomp AND t22.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t23 ON t23.ooagent="||g_enterprise||" AND t23.ooag001=t0.xrcaownid  ",
               " LEFT JOIN ooefl_t t24 ON t24.ooeflent="||g_enterprise||" AND t24.ooefl001=t0.xrcaowndp AND t24.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t25 ON t25.ooagent="||g_enterprise||" AND t25.ooag001=t0.xrcacrtid  ",
               " LEFT JOIN ooefl_t t26 ON t26.ooeflent="||g_enterprise||" AND t26.ooefl001=t0.xrcacrtdp AND t26.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t27 ON t27.ooagent="||g_enterprise||" AND t27.ooag001=t0.xrcamodid  ",
               " LEFT JOIN ooag_t t28 ON t28.ooagent="||g_enterprise||" AND t28.ooag001=t0.xrcacnfid  ",
               " LEFT JOIN ooag_t t29 ON t29.ooagent="||g_enterprise||" AND t29.ooag001=t0.xrcapstid  ",
 
               " WHERE t0.xrcaent = " ||g_enterprise|| " AND t0.xrcald = ? AND t0.xrcadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq510 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq510_init()   
 
      #進入選單 Menu (="N")
      CALL axrq510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq510
      
   END IF 
   
   CLOSE axrq510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('xrcastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('xrca001','8302') 
   CALL cl_set_combo_scc('xrca060','8321') 
   CALL cl_set_combo_scc('xrca016','8340') 
   CALL cl_set_combo_scc('xrca017','8324') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_axrt300_set_scc()
   CALL axrq510_set_scc()
   #end add-point
   
   #根據外部參數進行搜尋
   CALL axrq510_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq510_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   
   #action default動作
   
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xrca_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axrq510_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL axrq510_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL axrq510_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL axrq510_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL axrq510_set_act_visible()
               CALL axrq510_set_act_no_visible()
               IF NOT (g_xrca_m.xrcald IS NULL
                 OR g_xrca_m.xrcadocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " xrcaent = " ||g_enterprise|| " AND",
                                     " xrcald = '", g_xrca_m.xrcald, "' "
                                     ," AND xrcadocno = '", g_xrca_m.xrcadocno, "' "
 
                  #填到對應位置
                  CALL axrq510_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL axrq510_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL axrq510_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL axrq510_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL axrq510_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL axrq510_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL axrq510_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axrq510_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axrq510_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq510_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu2.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrq342_01
            LET g_action_choice="open_axrq342_01"
            IF cl_auth_chk_act("open_axrq342_01") THEN
               
               #add-point:ON ACTION open_axrq342_01 name="menu2.open_axrq342_01"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt310
            LET g_action_choice="open_axrt310"
            IF cl_auth_chk_act("open_axrt310") THEN
               
               #add-point:ON ACTION open_axrt310 name="menu2.open_axrt310"
               CALL axrq510_open_axrt310()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xrca018
            LET g_action_choice="prog_xrca018"
            IF cl_auth_chk_act("prog_xrca018") THEN
               
               #add-point:ON ACTION prog_xrca018 name="menu2.prog_xrca018"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axrt350'
               LET la_param.param[1] = g_xrca_m.xrcald
               LET la_param.param[2] = g_xrca_m.xrca018

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrq510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrq510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrq510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrca_m.xrcadocdt)
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL axrq510_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL axrq510_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL axrq510_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL axrq510_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL axrq510_set_act_visible()
               CALL axrq510_set_act_no_visible()
               IF NOT (g_xrca_m.xrcald IS NULL
                 OR g_xrca_m.xrcadocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " xrcaent = " ||g_enterprise|| " AND",
                                     " xrcald = '", g_xrca_m.xrcald, "' "
                                     ," AND xrcadocno = '", g_xrca_m.xrcadocno, "' "
 
                  #填到對應位置
                  CALL axrq510_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL axrq510_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL axrq510_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL axrq510_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL axrq510_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL axrq510_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               #EXIT DIALOG
               
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               END IF
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL axrq510_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axrq510_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axrq510_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq510_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrq342_01
            LET g_action_choice="open_axrq342_01"
            IF cl_auth_chk_act("open_axrq342_01") THEN
               
               #add-point:ON ACTION open_axrq342_01 name="menu.open_axrq342_01"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt310
            LET g_action_choice="open_axrt310"
            IF cl_auth_chk_act("open_axrt310") THEN
               
               #add-point:ON ACTION open_axrt310 name="menu.open_axrt310"
               CALL axrq510_open_axrt310()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xrca018
            LET g_action_choice="prog_xrca018"
            IF cl_auth_chk_act("prog_xrca018") THEN
               
               #add-point:ON ACTION prog_xrca018 name="menu.prog_xrca018"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axrt350'
               LET la_param.param[1] = g_xrca_m.xrcald
               LET la_param.param[2] = g_xrca_m.xrca018

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrq510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrq510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrq510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrca_m.xrcadocdt)
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION axrq510_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_str             STRING
   DEFINE l_gzcb002         LIKE gzcb_t.gzcb002
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "xrcald,xrcadocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET p_wc = p_wc," AND xrca005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8302' AND gzcb005 LIKE '%",g_prog,"%'",
               " ORDER BY gzcb002 ASC"
   PREPARE xrca001_pre FROM l_sql
   DECLARE xrca001_cur CURSOR FOR xrca001_pre
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH xrca001_cur INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = "'",l_gzcb002,"'" CONTINUE FOREACH END IF
      LET l_gzcb002 = "'",l_gzcb002,"'"
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   LET p_wc = p_wc," AND xrca001 IN (",l_str,")"
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM xrca_t ",
               "  ",
               "  ",
               " WHERE xrcaent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("xrca_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_xrca_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.xrcastus,t0.xrcald,t0.xrcadocno",
               " FROM xrca_t t0 ",
               "  ",
               
               " WHERE t0.xrcaent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("xrca_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
 
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrca_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xrcald,g_browser[g_cnt].b_xrcadocno 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
 
      FREE browse_pre
 
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_xrcald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrq510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq510_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_sql          STRING
   DEFINE l_str          STRING 
   DEFINE l_gzcb002      LIKE gzcb_t.gzcb002 
   DEFINE l_ld_str       STRING #160811-00009#2 
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   LET g_site_str = NULL   #160811-00009#2 
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_xrca_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON xrcasite,xrca003,xrcald,xrcadocno,xrca001,xrcadocdt,xrca004,xrca005, 
          xrca038,xrcastus,xrca007,xrca035,xrca035_desc,xrca036,xrca036_desc,xrca059,xrca100,xrca103, 
          xrca104,xrca107,xrca108,glaa001,xrca101,xrca113,xrca114,xrca117,xrca118,xrca014,xrca034,xrca015, 
          xrca033,xrca060,xrca011,xrca013,xrca012,xrca016,xrca018,xrca053,xrca017,xrca052,xrca050,xrca063, 
          xrca051,xrca120,xrca121,xrca130,xrca131,xrca123,xrca133,xrca124,xrca134,xrca127,xrca137,xrca128, 
          xrca138,xrca006,xrca008,xrca009,xrca010,xrca019,xrca023,xrca024,xrca058,xrca046,xrca047,xrca048, 
          xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,xrca021,xrca020,xrca022,xrca065,xrca066, 
          xrca037,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca049,xrca054,xrca055,xrca056, 
          xrca057,xrca061,xrca062,xrca064,xrca106,xrca116,xrca126,xrca136,xrcacomp,xrcaownid,xrcaowndp, 
          xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt,xrcapstid,xrcapstdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xrcacrtdt>>----
         AFTER FIELD xrcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xrcamoddt>>----
         AFTER FIELD xrcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrcacnfdt>>----
         AFTER FIELD xrcacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrcapstdt>>----
         AFTER FIELD xrcapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.xrcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcasite
            #add-point:ON ACTION controlp INFIELD xrcasite name="construct.c.xrcasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                       #呼叫開窗   #161021-00050#5 mark
            CALL q_ooef001_46()                                #161021-00050#5 add
            DISPLAY g_qryparam.return1 TO xrcasite  #顯示到畫面上
            NEXT FIELD xrcasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcasite
            #add-point:BEFORE FIELD xrcasite name="construct.b.xrcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcasite
            
            #add-point:AFTER FIELD xrcasite name="construct.a.xrcasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str  #160811-00009#2  
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca003
            #add-point:ON ACTION controlp INFIELD xrca003 name="construct.c.xrca003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca003  #顯示到畫面上
            NEXT FIELD xrca003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca003
            #add-point:BEFORE FIELD xrca003 name="construct.b.xrca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca003
            
            #add-point:AFTER FIELD xrca003 name="construct.a.xrca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="construct.c.xrcald"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str  #160811-00009#2 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160811-00009#2 add s---
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept            
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"  
            #160811-00009#2 add e---
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcald  #顯示到畫面上
            NEXT FIELD xrcald                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="construct.b.xrcald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="construct.a.xrcald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="construct.c.xrcadocno"
#            LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8302' AND gzcb005 LIKE '%",g_prog,"%'",
#                        " ORDER BY gzcb002 ASC"
#            PREPARE xrca001_pre1 FROM l_sql
#            DECLARE xrca001_cur1 CURSOR FOR xrca001_pre1
#            LET l_str = Null
#            LET l_gzcb002 = Null
#            FOREACH xrca001_cur INTO l_gzcb002
#               IF cl_null(l_str) THEN LET l_str = "'",l_gzcb002,"'" CONTINUE FOREACH END IF
#               LET l_str = l_str,",'",l_gzcb002,"'"
#            END FOREACH

            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = "xrca001 IN (",l_str,")"
            LET g_qryparam.where = "xrca001 = '26' "
            #151231-00010#7--(S)
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND xrca005 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND xrca005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            #161123-00048#5-add(s)
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrcald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161123-00048#5-add(e)
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上
            NEXT FIELD xrcadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="construct.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="construct.a.xrcadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca001
            #add-point:BEFORE FIELD xrca001 name="construct.b.xrca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca001
            
            #add-point:AFTER FIELD xrca001 name="construct.a.xrca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca001
            #add-point:ON ACTION controlp INFIELD xrca001 name="construct.c.xrca001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocdt
            #add-point:BEFORE FIELD xrcadocdt name="construct.b.xrcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocdt
            
            #add-point:AFTER FIELD xrcadocdt name="construct.a.xrcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocdt
            #add-point:ON ACTION controlp INFIELD xrcadocdt name="construct.c.xrcadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca004
            #add-point:ON ACTION controlp INFIELD xrca004 name="construct.c.xrca004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
             # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗    
            #161123-00048#5-add(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161123-00048#5-add(E)             
            CALL q_pmaa001_25()   #160913-00017#10 add 

            DISPLAY g_qryparam.return1 TO xrca004  #顯示到畫面上
            NEXT FIELD xrca004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca004
            #add-point:BEFORE FIELD xrca004 name="construct.b.xrca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca004
            
            #add-point:AFTER FIELD xrca004 name="construct.a.xrca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca005
            #add-point:ON ACTION controlp INFIELD xrca005 name="construct.c.xrca005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " pmac002 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmac002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                   "          WHERE pmaaent = ",g_enterprise,
                                   "            AND ",g_sql_ctrl,
                                   "            AND pmaaent = pmacent ",
                                   "            AND pmaa001 = pmac002 )"
            END IF
            #151231-00010#1(E)
            CALL q_pmac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca005  #顯示到畫面上
            NEXT FIELD xrca005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca005
            #add-point:BEFORE FIELD xrca005 name="construct.b.xrca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca005
            
            #add-point:AFTER FIELD xrca005 name="construct.a.xrca005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca038
            #add-point:ON ACTION controlp INFIELD xrca038 name="construct.c.xrca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrca038 IN (SELECT UNIQUE xrca038 FROM xrca_t WHERE xrcaent=",g_enterprise," AND xrca001='14' )"
            CALL q_xrca038()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca038  #顯示到畫面上
            NEXT FIELD xrca038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca038
            #add-point:BEFORE FIELD xrca038 name="construct.b.xrca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca038
            
            #add-point:AFTER FIELD xrca038 name="construct.a.xrca038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcastus
            #add-point:BEFORE FIELD xrcastus name="construct.b.xrcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcastus
            
            #add-point:AFTER FIELD xrcastus name="construct.a.xrcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcastus
            #add-point:ON ACTION controlp INFIELD xrcastus name="construct.c.xrcastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca007
            #add-point:ON ACTION controlp INFIELD xrca007 name="construct.c.xrca007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca007  #顯示到畫面上
            NEXT FIELD xrca007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca007
            #add-point:BEFORE FIELD xrca007 name="construct.b.xrca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca007
            
            #add-point:AFTER FIELD xrca007 name="construct.a.xrca007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca035
            #add-point:ON ACTION controlp INFIELD xrca035 name="construct.c.xrca035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161123-00048#5-add(s)
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_xrca_m.xrcald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_comp
               AND glaa014 = 'Y'  
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_xrca_m.xrcald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161123-00048#5-add(e)
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca035  #顯示到畫面上
            NEXT FIELD xrca035                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca035
            #add-point:BEFORE FIELD xrca035 name="construct.b.xrca035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca035
            
            #add-point:AFTER FIELD xrca035 name="construct.a.xrca035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca035_desc
            #add-point:BEFORE FIELD xrca035_desc name="construct.b.xrca035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca035_desc
            
            #add-point:AFTER FIELD xrca035_desc name="construct.a.xrca035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca035_desc
            #add-point:ON ACTION controlp INFIELD xrca035_desc name="construct.c.xrca035_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca036
            #add-point:ON ACTION controlp INFIELD xrca036 name="construct.c.xrca036"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161123-00048#5-add(s)
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_xrca_m.xrcald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_comp
               AND glaa014 = 'Y'  
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_xrca_m.xrcald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161123-00048#5-add(e)
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca036  #顯示到畫面上
            NEXT FIELD xrca036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca036
            #add-point:BEFORE FIELD xrca036 name="construct.b.xrca036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca036
            
            #add-point:AFTER FIELD xrca036 name="construct.a.xrca036"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca036_desc
            #add-point:BEFORE FIELD xrca036_desc name="construct.b.xrca036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca036_desc
            
            #add-point:AFTER FIELD xrca036_desc name="construct.a.xrca036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca036_desc
            #add-point:ON ACTION controlp INFIELD xrca036_desc name="construct.c.xrca036_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca059
            #add-point:ON ACTION controlp INFIELD xrca059 name="construct.c.xrca059"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca059  #顯示到畫面上
            NEXT FIELD xrca059                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca059
            #add-point:BEFORE FIELD xrca059 name="construct.b.xrca059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca059
            
            #add-point:AFTER FIELD xrca059 name="construct.a.xrca059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca100
            #add-point:ON ACTION controlp INFIELD xrca100 name="construct.c.xrca100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca100  #顯示到畫面上
            NEXT FIELD xrca100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca100
            #add-point:BEFORE FIELD xrca100 name="construct.b.xrca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca100
            
            #add-point:AFTER FIELD xrca100 name="construct.a.xrca100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca103
            #add-point:BEFORE FIELD xrca103 name="construct.b.xrca103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca103
            
            #add-point:AFTER FIELD xrca103 name="construct.a.xrca103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca103
            #add-point:ON ACTION controlp INFIELD xrca103 name="construct.c.xrca103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca104
            #add-point:BEFORE FIELD xrca104 name="construct.b.xrca104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca104
            
            #add-point:AFTER FIELD xrca104 name="construct.a.xrca104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca104
            #add-point:ON ACTION controlp INFIELD xrca104 name="construct.c.xrca104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca107
            #add-point:BEFORE FIELD xrca107 name="construct.b.xrca107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca107
            
            #add-point:AFTER FIELD xrca107 name="construct.a.xrca107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca107
            #add-point:ON ACTION controlp INFIELD xrca107 name="construct.c.xrca107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca108
            #add-point:BEFORE FIELD xrca108 name="construct.b.xrca108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca108
            
            #add-point:AFTER FIELD xrca108 name="construct.a.xrca108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca108
            #add-point:ON ACTION controlp INFIELD xrca108 name="construct.c.xrca108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca101
            #add-point:BEFORE FIELD xrca101 name="construct.b.xrca101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca101
            
            #add-point:AFTER FIELD xrca101 name="construct.a.xrca101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca101
            #add-point:ON ACTION controlp INFIELD xrca101 name="construct.c.xrca101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca113
            #add-point:BEFORE FIELD xrca113 name="construct.b.xrca113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca113
            
            #add-point:AFTER FIELD xrca113 name="construct.a.xrca113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca113
            #add-point:ON ACTION controlp INFIELD xrca113 name="construct.c.xrca113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca114
            #add-point:BEFORE FIELD xrca114 name="construct.b.xrca114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca114
            
            #add-point:AFTER FIELD xrca114 name="construct.a.xrca114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca114
            #add-point:ON ACTION controlp INFIELD xrca114 name="construct.c.xrca114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca117
            #add-point:BEFORE FIELD xrca117 name="construct.b.xrca117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca117
            
            #add-point:AFTER FIELD xrca117 name="construct.a.xrca117"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca117
            #add-point:ON ACTION controlp INFIELD xrca117 name="construct.c.xrca117"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca118
            #add-point:BEFORE FIELD xrca118 name="construct.b.xrca118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca118
            
            #add-point:AFTER FIELD xrca118 name="construct.a.xrca118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca118
            #add-point:ON ACTION controlp INFIELD xrca118 name="construct.c.xrca118"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca014
            #add-point:ON ACTION controlp INFIELD xrca014 name="construct.c.xrca014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca014  #顯示到畫面上
            NEXT FIELD xrca014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca014
            #add-point:BEFORE FIELD xrca014 name="construct.b.xrca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca014
            
            #add-point:AFTER FIELD xrca014 name="construct.a.xrca014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca034
            #add-point:ON ACTION controlp INFIELD xrca034 name="construct.c.xrca034"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca034  #顯示到畫面上
            NEXT FIELD xrca034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca034
            #add-point:BEFORE FIELD xrca034 name="construct.b.xrca034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca034
            
            #add-point:AFTER FIELD xrca034 name="construct.a.xrca034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca015
            #add-point:ON ACTION controlp INFIELD xrca015 name="construct.c.xrca015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca015  #顯示到畫面上
            NEXT FIELD xrca015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca015
            #add-point:BEFORE FIELD xrca015 name="construct.b.xrca015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca015
            
            #add-point:AFTER FIELD xrca015 name="construct.a.xrca015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca033
            #add-point:BEFORE FIELD xrca033 name="construct.b.xrca033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca033
            
            #add-point:AFTER FIELD xrca033 name="construct.a.xrca033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca033
            #add-point:ON ACTION controlp INFIELD xrca033 name="construct.c.xrca033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca033     #顯示到畫面上
            NEXT FIELD xrca033
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca060
            #add-point:BEFORE FIELD xrca060 name="construct.b.xrca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca060
            
            #add-point:AFTER FIELD xrca060 name="construct.a.xrca060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca060
            #add-point:ON ACTION controlp INFIELD xrca060 name="construct.c.xrca060"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca011
            #add-point:ON ACTION controlp INFIELD xrca011 name="construct.c.xrca011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca011  #顯示到畫面上
            NEXT FIELD xrca011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca011
            #add-point:BEFORE FIELD xrca011 name="construct.b.xrca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca011
            
            #add-point:AFTER FIELD xrca011 name="construct.a.xrca011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca013
            #add-point:BEFORE FIELD xrca013 name="construct.b.xrca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca013
            
            #add-point:AFTER FIELD xrca013 name="construct.a.xrca013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca013
            #add-point:ON ACTION controlp INFIELD xrca013 name="construct.c.xrca013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca012
            #add-point:BEFORE FIELD xrca012 name="construct.b.xrca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca012
            
            #add-point:AFTER FIELD xrca012 name="construct.a.xrca012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca012
            #add-point:ON ACTION controlp INFIELD xrca012 name="construct.c.xrca012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca016
            #add-point:BEFORE FIELD xrca016 name="construct.b.xrca016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca016
            
            #add-point:AFTER FIELD xrca016 name="construct.a.xrca016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca016
            #add-point:ON ACTION controlp INFIELD xrca016 name="construct.c.xrca016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca018
            #add-point:ON ACTION controlp INFIELD xrca018 name="construct.c.xrca018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca018  #顯示到畫面上
            NEXT FIELD xrca018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca018
            #add-point:BEFORE FIELD xrca018 name="construct.b.xrca018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca018
            
            #add-point:AFTER FIELD xrca018 name="construct.a.xrca018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca053
            #add-point:ON ACTION controlp INFIELD xrca053 name="construct.c.xrca053"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca053  #顯示到畫面上
            NEXT FIELD xrca053                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca053
            #add-point:BEFORE FIELD xrca053 name="construct.b.xrca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca053
            
            #add-point:AFTER FIELD xrca053 name="construct.a.xrca053"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca017
            #add-point:BEFORE FIELD xrca017 name="construct.b.xrca017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca017
            
            #add-point:AFTER FIELD xrca017 name="construct.a.xrca017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca017
            #add-point:ON ACTION controlp INFIELD xrca017 name="construct.c.xrca017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca052
            #add-point:BEFORE FIELD xrca052 name="construct.b.xrca052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca052
            
            #add-point:AFTER FIELD xrca052 name="construct.a.xrca052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca052
            #add-point:ON ACTION controlp INFIELD xrca052 name="construct.c.xrca052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca050
            #add-point:BEFORE FIELD xrca050 name="construct.b.xrca050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca050
            
            #add-point:AFTER FIELD xrca050 name="construct.a.xrca050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca050
            #add-point:ON ACTION controlp INFIELD xrca050 name="construct.c.xrca050"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca063
            #add-point:ON ACTION controlp INFIELD xrca063 name="construct.c.xrca063"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrca063()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca063  #顯示到畫面上
            NEXT FIELD xrca063                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca063
            #add-point:BEFORE FIELD xrca063 name="construct.b.xrca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca063
            
            #add-point:AFTER FIELD xrca063 name="construct.a.xrca063"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca051
            #add-point:BEFORE FIELD xrca051 name="construct.b.xrca051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca051
            
            #add-point:AFTER FIELD xrca051 name="construct.a.xrca051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca051
            #add-point:ON ACTION controlp INFIELD xrca051 name="construct.c.xrca051"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #給予arg
            LET g_qryparam.arg1 = '3115'
            CALL q_oocq002 ()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca051  #顯示到畫面上
            NEXT FIELD xrca051
            #END add-point
 
 
         #Ctrlp:construct.c.xrca120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca120
            #add-point:ON ACTION controlp INFIELD xrca120 name="construct.c.xrca120"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca120  #顯示到畫面上
            NEXT FIELD xrca120                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca120
            #add-point:BEFORE FIELD xrca120 name="construct.b.xrca120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca120
            
            #add-point:AFTER FIELD xrca120 name="construct.a.xrca120"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca121
            #add-point:BEFORE FIELD xrca121 name="construct.b.xrca121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca121
            
            #add-point:AFTER FIELD xrca121 name="construct.a.xrca121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca121
            #add-point:ON ACTION controlp INFIELD xrca121 name="construct.c.xrca121"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca130
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca130
            #add-point:ON ACTION controlp INFIELD xrca130 name="construct.c.xrca130"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca130  #顯示到畫面上
            NEXT FIELD xrca130                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca130
            #add-point:BEFORE FIELD xrca130 name="construct.b.xrca130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca130
            
            #add-point:AFTER FIELD xrca130 name="construct.a.xrca130"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca131
            #add-point:BEFORE FIELD xrca131 name="construct.b.xrca131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca131
            
            #add-point:AFTER FIELD xrca131 name="construct.a.xrca131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca131
            #add-point:ON ACTION controlp INFIELD xrca131 name="construct.c.xrca131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca123
            #add-point:BEFORE FIELD xrca123 name="construct.b.xrca123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca123
            
            #add-point:AFTER FIELD xrca123 name="construct.a.xrca123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca123
            #add-point:ON ACTION controlp INFIELD xrca123 name="construct.c.xrca123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca133
            #add-point:BEFORE FIELD xrca133 name="construct.b.xrca133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca133
            
            #add-point:AFTER FIELD xrca133 name="construct.a.xrca133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca133
            #add-point:ON ACTION controlp INFIELD xrca133 name="construct.c.xrca133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca124
            #add-point:BEFORE FIELD xrca124 name="construct.b.xrca124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca124
            
            #add-point:AFTER FIELD xrca124 name="construct.a.xrca124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca124
            #add-point:ON ACTION controlp INFIELD xrca124 name="construct.c.xrca124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca134
            #add-point:BEFORE FIELD xrca134 name="construct.b.xrca134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca134
            
            #add-point:AFTER FIELD xrca134 name="construct.a.xrca134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca134
            #add-point:ON ACTION controlp INFIELD xrca134 name="construct.c.xrca134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca127
            #add-point:BEFORE FIELD xrca127 name="construct.b.xrca127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca127
            
            #add-point:AFTER FIELD xrca127 name="construct.a.xrca127"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca127
            #add-point:ON ACTION controlp INFIELD xrca127 name="construct.c.xrca127"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca137
            #add-point:BEFORE FIELD xrca137 name="construct.b.xrca137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca137
            
            #add-point:AFTER FIELD xrca137 name="construct.a.xrca137"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca137
            #add-point:ON ACTION controlp INFIELD xrca137 name="construct.c.xrca137"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca128
            #add-point:BEFORE FIELD xrca128 name="construct.b.xrca128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca128
            
            #add-point:AFTER FIELD xrca128 name="construct.a.xrca128"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca128
            #add-point:ON ACTION controlp INFIELD xrca128 name="construct.c.xrca128"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca138
            #add-point:BEFORE FIELD xrca138 name="construct.b.xrca138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca138
            
            #add-point:AFTER FIELD xrca138 name="construct.a.xrca138"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca138
            #add-point:ON ACTION controlp INFIELD xrca138 name="construct.c.xrca138"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca006
            #add-point:BEFORE FIELD xrca006 name="construct.b.xrca006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca006
            
            #add-point:AFTER FIELD xrca006 name="construct.a.xrca006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca006
            #add-point:ON ACTION controlp INFIELD xrca006 name="construct.c.xrca006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca008
            #add-point:ON ACTION controlp INFIELD xrca008 name="construct.c.xrca008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooib001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca008  #顯示到畫面上
            NEXT FIELD xrca008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca008
            #add-point:BEFORE FIELD xrca008 name="construct.b.xrca008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca008
            
            #add-point:AFTER FIELD xrca008 name="construct.a.xrca008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca009
            #add-point:BEFORE FIELD xrca009 name="construct.b.xrca009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca009
            
            #add-point:AFTER FIELD xrca009 name="construct.a.xrca009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca009
            #add-point:ON ACTION controlp INFIELD xrca009 name="construct.c.xrca009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca010
            #add-point:BEFORE FIELD xrca010 name="construct.b.xrca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca010
            
            #add-point:AFTER FIELD xrca010 name="construct.a.xrca010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca010
            #add-point:ON ACTION controlp INFIELD xrca010 name="construct.c.xrca010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca019
            #add-point:ON ACTION controlp INFIELD xrca019 name="construct.c.xrca019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrca019_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca019  #顯示到畫面上
            NEXT FIELD xrca019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca019
            #add-point:BEFORE FIELD xrca019 name="construct.b.xrca019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca019
            
            #add-point:AFTER FIELD xrca019 name="construct.a.xrca019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca023
            #add-point:ON ACTION controlp INFIELD xrca023 name="construct.c.xrca023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗    
            #161123-00048#5-add(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161123-00048#5-add(E)            
            CALL q_pmaa001_25()   #160913-00017#10 add 
            DISPLAY g_qryparam.return1 TO xrca023  #顯示到畫面上
            NEXT FIELD xrca023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca023
            #add-point:BEFORE FIELD xrca023 name="construct.b.xrca023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca023
            
            #add-point:AFTER FIELD xrca023 name="construct.a.xrca023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca024
            #add-point:BEFORE FIELD xrca024 name="construct.b.xrca024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca024
            
            #add-point:AFTER FIELD xrca024 name="construct.a.xrca024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca024
            #add-point:ON ACTION controlp INFIELD xrca024 name="construct.c.xrca024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca058
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca058
            #add-point:ON ACTION controlp INFIELD xrca058 name="construct.c.xrca058"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "295"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca058  #顯示到畫面上
            NEXT FIELD xrca058                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca058
            #add-point:BEFORE FIELD xrca058 name="construct.b.xrca058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca058
            
            #add-point:AFTER FIELD xrca058 name="construct.a.xrca058"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca046
            #add-point:BEFORE FIELD xrca046 name="construct.b.xrca046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca046
            
            #add-point:AFTER FIELD xrca046 name="construct.a.xrca046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca046
            #add-point:ON ACTION controlp INFIELD xrca046 name="construct.c.xrca046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca047
            #add-point:BEFORE FIELD xrca047 name="construct.b.xrca047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca047
            
            #add-point:AFTER FIELD xrca047 name="construct.a.xrca047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca047
            #add-point:ON ACTION controlp INFIELD xrca047 name="construct.c.xrca047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca048
            #add-point:BEFORE FIELD xrca048 name="construct.b.xrca048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca048
            
            #add-point:AFTER FIELD xrca048 name="construct.a.xrca048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca048
            #add-point:ON ACTION controlp INFIELD xrca048 name="construct.c.xrca048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca025
            #add-point:BEFORE FIELD xrca025 name="construct.b.xrca025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca025
            
            #add-point:AFTER FIELD xrca025 name="construct.a.xrca025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca025
            #add-point:ON ACTION controlp INFIELD xrca025 name="construct.c.xrca025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca026
            #add-point:BEFORE FIELD xrca026 name="construct.b.xrca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca026
            
            #add-point:AFTER FIELD xrca026 name="construct.a.xrca026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca026
            #add-point:ON ACTION controlp INFIELD xrca026 name="construct.c.xrca026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca028
            #add-point:BEFORE FIELD xrca028 name="construct.b.xrca028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca028
            
            #add-point:AFTER FIELD xrca028 name="construct.a.xrca028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca028
            #add-point:ON ACTION controlp INFIELD xrca028 name="construct.c.xrca028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca029
            #add-point:BEFORE FIELD xrca029 name="construct.b.xrca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca029
            
            #add-point:AFTER FIELD xrca029 name="construct.a.xrca029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca029
            #add-point:ON ACTION controlp INFIELD xrca029 name="construct.c.xrca029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca030
            #add-point:BEFORE FIELD xrca030 name="construct.b.xrca030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca030
            
            #add-point:AFTER FIELD xrca030 name="construct.a.xrca030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca030
            #add-point:ON ACTION controlp INFIELD xrca030 name="construct.c.xrca030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca031
            #add-point:BEFORE FIELD xrca031 name="construct.b.xrca031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca031
            
            #add-point:AFTER FIELD xrca031 name="construct.a.xrca031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca031
            #add-point:ON ACTION controlp INFIELD xrca031 name="construct.c.xrca031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca032
            #add-point:BEFORE FIELD xrca032 name="construct.b.xrca032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca032
            
            #add-point:AFTER FIELD xrca032 name="construct.a.xrca032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca032
            #add-point:ON ACTION controlp INFIELD xrca032 name="construct.c.xrca032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca021
            #add-point:BEFORE FIELD xrca021 name="construct.b.xrca021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca021
            
            #add-point:AFTER FIELD xrca021 name="construct.a.xrca021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca021
            #add-point:ON ACTION controlp INFIELD xrca021 name="construct.c.xrca021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca020
            #add-point:BEFORE FIELD xrca020 name="construct.b.xrca020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca020
            
            #add-point:AFTER FIELD xrca020 name="construct.a.xrca020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca020
            #add-point:ON ACTION controlp INFIELD xrca020 name="construct.c.xrca020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca022
            #add-point:BEFORE FIELD xrca022 name="construct.b.xrca022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca022
            
            #add-point:AFTER FIELD xrca022 name="construct.a.xrca022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca022
            #add-point:ON ACTION controlp INFIELD xrca022 name="construct.c.xrca022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca065
            #add-point:BEFORE FIELD xrca065 name="construct.b.xrca065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca065
            
            #add-point:AFTER FIELD xrca065 name="construct.a.xrca065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca065
            #add-point:ON ACTION controlp INFIELD xrca065 name="construct.c.xrca065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca066
            #add-point:BEFORE FIELD xrca066 name="construct.b.xrca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca066
            
            #add-point:AFTER FIELD xrca066 name="construct.a.xrca066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca066
            #add-point:ON ACTION controlp INFIELD xrca066 name="construct.c.xrca066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca037
            #add-point:BEFORE FIELD xrca037 name="construct.b.xrca037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca037
            
            #add-point:AFTER FIELD xrca037 name="construct.a.xrca037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca037
            #add-point:ON ACTION controlp INFIELD xrca037 name="construct.c.xrca037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca039
            #add-point:BEFORE FIELD xrca039 name="construct.b.xrca039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca039
            
            #add-point:AFTER FIELD xrca039 name="construct.a.xrca039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca039
            #add-point:ON ACTION controlp INFIELD xrca039 name="construct.c.xrca039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca040
            #add-point:BEFORE FIELD xrca040 name="construct.b.xrca040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca040
            
            #add-point:AFTER FIELD xrca040 name="construct.a.xrca040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca040
            #add-point:ON ACTION controlp INFIELD xrca040 name="construct.c.xrca040"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca041
            #add-point:ON ACTION controlp INFIELD xrca041 name="construct.c.xrca041"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca041  #顯示到畫面上
            NEXT FIELD xrca041                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca041
            #add-point:BEFORE FIELD xrca041 name="construct.b.xrca041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca041
            
            #add-point:AFTER FIELD xrca041 name="construct.a.xrca041"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca042
            #add-point:BEFORE FIELD xrca042 name="construct.b.xrca042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca042
            
            #add-point:AFTER FIELD xrca042 name="construct.a.xrca042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca042
            #add-point:ON ACTION controlp INFIELD xrca042 name="construct.c.xrca042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca043
            #add-point:BEFORE FIELD xrca043 name="construct.b.xrca043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca043
            
            #add-point:AFTER FIELD xrca043 name="construct.a.xrca043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca043
            #add-point:ON ACTION controlp INFIELD xrca043 name="construct.c.xrca043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca044
            #add-point:BEFORE FIELD xrca044 name="construct.b.xrca044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca044
            
            #add-point:AFTER FIELD xrca044 name="construct.a.xrca044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca044
            #add-point:ON ACTION controlp INFIELD xrca044 name="construct.c.xrca044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca045
            #add-point:BEFORE FIELD xrca045 name="construct.b.xrca045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca045
            
            #add-point:AFTER FIELD xrca045 name="construct.a.xrca045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca045
            #add-point:ON ACTION controlp INFIELD xrca045 name="construct.c.xrca045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca049
            #add-point:BEFORE FIELD xrca049 name="construct.b.xrca049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca049
            
            #add-point:AFTER FIELD xrca049 name="construct.a.xrca049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca049
            #add-point:ON ACTION controlp INFIELD xrca049 name="construct.c.xrca049"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca054
            #add-point:ON ACTION controlp INFIELD xrca054 name="construct.c.xrca054"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca054  #顯示到畫面上
            NEXT FIELD xrca054                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca054
            #add-point:BEFORE FIELD xrca054 name="construct.b.xrca054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca054
            
            #add-point:AFTER FIELD xrca054 name="construct.a.xrca054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca055
            #add-point:ON ACTION controlp INFIELD xrca055 name="construct.c.xrca055"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooid001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca055  #顯示到畫面上
            NEXT FIELD xrca055                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca055
            #add-point:BEFORE FIELD xrca055 name="construct.b.xrca055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca055
            
            #add-point:AFTER FIELD xrca055 name="construct.a.xrca055"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca056
            #add-point:BEFORE FIELD xrca056 name="construct.b.xrca056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca056
            
            #add-point:AFTER FIELD xrca056 name="construct.a.xrca056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca056
            #add-point:ON ACTION controlp INFIELD xrca056 name="construct.c.xrca056"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca057
            #add-point:ON ACTION controlp INFIELD xrca057 name="construct.c.xrca057"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrca057()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca057  #顯示到畫面上
            NEXT FIELD xrca057                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca057
            #add-point:BEFORE FIELD xrca057 name="construct.b.xrca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca057
            
            #add-point:AFTER FIELD xrca057 name="construct.a.xrca057"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca061
            #add-point:BEFORE FIELD xrca061 name="construct.b.xrca061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca061
            
            #add-point:AFTER FIELD xrca061 name="construct.a.xrca061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca061
            #add-point:ON ACTION controlp INFIELD xrca061 name="construct.c.xrca061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca062
            #add-point:BEFORE FIELD xrca062 name="construct.b.xrca062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca062
            
            #add-point:AFTER FIELD xrca062 name="construct.a.xrca062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca062
            #add-point:ON ACTION controlp INFIELD xrca062 name="construct.c.xrca062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca064
            #add-point:BEFORE FIELD xrca064 name="construct.b.xrca064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca064
            
            #add-point:AFTER FIELD xrca064 name="construct.a.xrca064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca064
            #add-point:ON ACTION controlp INFIELD xrca064 name="construct.c.xrca064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca106
            #add-point:BEFORE FIELD xrca106 name="construct.b.xrca106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca106
            
            #add-point:AFTER FIELD xrca106 name="construct.a.xrca106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca106
            #add-point:ON ACTION controlp INFIELD xrca106 name="construct.c.xrca106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca116
            #add-point:BEFORE FIELD xrca116 name="construct.b.xrca116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca116
            
            #add-point:AFTER FIELD xrca116 name="construct.a.xrca116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca116
            #add-point:ON ACTION controlp INFIELD xrca116 name="construct.c.xrca116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca126
            #add-point:BEFORE FIELD xrca126 name="construct.b.xrca126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca126
            
            #add-point:AFTER FIELD xrca126 name="construct.a.xrca126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca126
            #add-point:ON ACTION controlp INFIELD xrca126 name="construct.c.xrca126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca136
            #add-point:BEFORE FIELD xrca136 name="construct.b.xrca136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca136
            
            #add-point:AFTER FIELD xrca136 name="construct.a.xrca136"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrca136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca136
            #add-point:ON ACTION controlp INFIELD xrca136 name="construct.c.xrca136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacomp
            #add-point:BEFORE FIELD xrcacomp name="construct.b.xrcacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcacomp
            
            #add-point:AFTER FIELD xrcacomp name="construct.a.xrcacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcacomp
            #add-point:ON ACTION controlp INFIELD xrcacomp name="construct.c.xrcacomp"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcaownid
            #add-point:ON ACTION controlp INFIELD xrcaownid name="construct.c.xrcaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcaownid  #顯示到畫面上
            NEXT FIELD xrcaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcaownid
            #add-point:BEFORE FIELD xrcaownid name="construct.b.xrcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcaownid
            
            #add-point:AFTER FIELD xrcaownid name="construct.a.xrcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcaowndp
            #add-point:ON ACTION controlp INFIELD xrcaowndp name="construct.c.xrcaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcaowndp  #顯示到畫面上
            NEXT FIELD xrcaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcaowndp
            #add-point:BEFORE FIELD xrcaowndp name="construct.b.xrcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcaowndp
            
            #add-point:AFTER FIELD xrcaowndp name="construct.a.xrcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcacrtid
            #add-point:ON ACTION controlp INFIELD xrcacrtid name="construct.c.xrcacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcacrtid  #顯示到畫面上
            NEXT FIELD xrcacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacrtid
            #add-point:BEFORE FIELD xrcacrtid name="construct.b.xrcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcacrtid
            
            #add-point:AFTER FIELD xrcacrtid name="construct.a.xrcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcacrtdp
            #add-point:ON ACTION controlp INFIELD xrcacrtdp name="construct.c.xrcacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcacrtdp  #顯示到畫面上
            NEXT FIELD xrcacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacrtdp
            #add-point:BEFORE FIELD xrcacrtdp name="construct.b.xrcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcacrtdp
            
            #add-point:AFTER FIELD xrcacrtdp name="construct.a.xrcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacrtdt
            #add-point:BEFORE FIELD xrcacrtdt name="construct.b.xrcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcamodid
            #add-point:ON ACTION controlp INFIELD xrcamodid name="construct.c.xrcamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcamodid  #顯示到畫面上
            NEXT FIELD xrcamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcamodid
            #add-point:BEFORE FIELD xrcamodid name="construct.b.xrcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcamodid
            
            #add-point:AFTER FIELD xrcamodid name="construct.a.xrcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcamoddt
            #add-point:BEFORE FIELD xrcamoddt name="construct.b.xrcamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrcacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcacnfid
            #add-point:ON ACTION controlp INFIELD xrcacnfid name="construct.c.xrcacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcacnfid  #顯示到畫面上
            NEXT FIELD xrcacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacnfid
            #add-point:BEFORE FIELD xrcacnfid name="construct.b.xrcacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcacnfid
            
            #add-point:AFTER FIELD xrcacnfid name="construct.a.xrcacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacnfdt
            #add-point:BEFORE FIELD xrcacnfdt name="construct.b.xrcacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrcapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcapstid
            #add-point:ON ACTION controlp INFIELD xrcapstid name="construct.c.xrcapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcapstid  #顯示到畫面上
            NEXT FIELD xrcapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcapstid
            #add-point:BEFORE FIELD xrcapstid name="construct.b.xrcapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcapstid
            
            #add-point:AFTER FIELD xrcapstid name="construct.a.xrcapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcapstdt
            #add-point:BEFORE FIELD xrcapstdt name="construct.b.xrcapstdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="axrq510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axrq510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_xrca_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL axrq510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axrq510_browser_fill(g_wc,"F")
      CALL axrq510_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL axrq510_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axrq510_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axrq510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axrq510_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_xrca_m.xrcald = g_browser[g_current_idx].b_xrcald
   LET g_xrca_m.xrcadocno = g_browser[g_current_idx].b_xrcadocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE axrq510_master_referesh USING g_xrca_m.xrcald,g_xrca_m.xrcadocno INTO g_xrca_m.xrcasite,g_xrca_m.xrca003, 
       g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005, 
       g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059, 
       g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrca101, 
       g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118,g_xrca_m.xrca014,g_xrca_m.xrca034, 
       g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012, 
       g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050, 
       g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131, 
       g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127,g_xrca_m.xrca137, 
       g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047, 
       g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030, 
       g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065, 
       g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca042, 
       g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106, 
       g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp, 
       g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt, 
       g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt,g_xrca_m.xrcasite_desc, 
       g_xrca_m.xrca003_desc,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno_desc,g_xrca_m.xrca004_desc,g_xrca_m.xrca005_desc, 
       g_xrca_m.xrca007_desc,g_xrca_m.xrca059_desc,g_xrca_m.xrca014_desc,g_xrca_m.xrca034_desc,g_xrca_m.xrca015_desc, 
       g_xrca_m.xrca033_desc,g_xrca_m.xrca011_desc,g_xrca_m.xrca051_desc,g_xrca_m.xrca008_desc,g_xrca_m.xrca058_desc, 
       g_xrca_m.xrca028_desc,g_xrca_m.xrca041_desc,g_xrca_m.xrca054_desc,g_xrca_m.xrca055_desc,g_xrca_m.xrca057_desc, 
       g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid_desc, 
       g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcamodid_desc,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcapstid_desc 
 
   
   #遮罩相關處理
   LET g_xrca_m_mask_o.* =  g_xrca_m.*
   CALL axrq510_xrca_t_mask()
   LET g_xrca_m_mask_n.* =  g_xrca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL axrq510_set_act_visible()
   CALL axrq510_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_xrca_m_t.* = g_xrca_m.*
   LET g_xrca_m_o.* = g_xrca_m.*
   
   LET g_data_owner = g_xrca_m.xrcaownid      
   LET g_data_dept  = g_xrca_m.xrcaowndp
   
   #重新顯示
   CALL axrq510_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrq510_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_xrca_m.* TO NULL             #DEFAULT 設定
   LET g_xrcald_t = NULL
   LET g_xrcadocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrca_m.xrcaownid = g_user
      LET g_xrca_m.xrcaowndp = g_dept
      LET g_xrca_m.xrcacrtid = g_user
      LET g_xrca_m.xrcacrtdp = g_dept 
      LET g_xrca_m.xrcacrtdt = cl_get_current()
      LET g_xrca_m.xrcamodid = g_user
      LET g_xrca_m.xrcamoddt = cl_get_current()
      LET g_xrca_m.xrcastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xrca_m.xrca103 = "0"
      LET g_xrca_m.xrca104 = "0"
      LET g_xrca_m.xrca107 = "0"
      LET g_xrca_m.xrca108 = "0"
      LET g_xrca_m.xrca113 = "0"
      LET g_xrca_m.xrca114 = "0"
      LET g_xrca_m.xrca117 = "0"
      LET g_xrca_m.xrca118 = "0"
      LET g_xrca_m.xrca1032 = "0"
      LET g_xrca_m.xrca1042 = "0"
      LET g_xrca_m.xrca1072 = "0"
      LET g_xrca_m.xrca1082 = "0"
      LET g_xrca_m.xrca1012 = "1"
      LET g_xrca_m.xrca1132 = "0"
      LET g_xrca_m.xrca123 = "0"
      LET g_xrca_m.xrca133 = "0"
      LET g_xrca_m.xrca1142 = "0"
      LET g_xrca_m.xrca124 = "0"
      LET g_xrca_m.xrca134 = "0"
      LET g_xrca_m.xrca1172 = "0"
      LET g_xrca_m.xrca127 = "0"
      LET g_xrca_m.xrca137 = "0"
      LET g_xrca_m.xrca1182 = "0"
      LET g_xrca_m.xrca128 = "0"
      LET g_xrca_m.xrca138 = "0"
      LET g_xrca_m.xrca030 = "0"
      LET g_xrca_m.xrca031 = "0"
      LET g_xrca_m.xrca032 = "0"
      LET g_xrca_m.xrca044 = "0"
      LET g_xrca_m.xrca106 = "0"
      LET g_xrca_m.xrca116 = "0"
      LET g_xrca_m.xrca126 = "0"
      LET g_xrca_m.xrca136 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrca_m.xrcastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL axrq510_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_xrca_m.* TO NULL
         CALL axrq510_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL axrq510_set_act_visible()
   CALL axrq510_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xrcald_t = g_xrca_m.xrcald
   LET g_xrcadocno_t = g_xrca_m.xrcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrcaent = " ||g_enterprise|| " AND",
                      " xrcald = '", g_xrca_m.xrcald, "' "
                      ," AND xrcadocno = '", g_xrca_m.xrcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrq510_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axrq510_master_referesh USING g_xrca_m.xrcald,g_xrca_m.xrcadocno INTO g_xrca_m.xrcasite,g_xrca_m.xrca003, 
       g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005, 
       g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059, 
       g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrca101, 
       g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118,g_xrca_m.xrca014,g_xrca_m.xrca034, 
       g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012, 
       g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050, 
       g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131, 
       g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127,g_xrca_m.xrca137, 
       g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047, 
       g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030, 
       g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065, 
       g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca042, 
       g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106, 
       g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp, 
       g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt, 
       g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt,g_xrca_m.xrcasite_desc, 
       g_xrca_m.xrca003_desc,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno_desc,g_xrca_m.xrca004_desc,g_xrca_m.xrca005_desc, 
       g_xrca_m.xrca007_desc,g_xrca_m.xrca059_desc,g_xrca_m.xrca014_desc,g_xrca_m.xrca034_desc,g_xrca_m.xrca015_desc, 
       g_xrca_m.xrca033_desc,g_xrca_m.xrca011_desc,g_xrca_m.xrca051_desc,g_xrca_m.xrca008_desc,g_xrca_m.xrca058_desc, 
       g_xrca_m.xrca028_desc,g_xrca_m.xrca041_desc,g_xrca_m.xrca054_desc,g_xrca_m.xrca055_desc,g_xrca_m.xrca057_desc, 
       g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid_desc, 
       g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcamodid_desc,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcapstid_desc 
 
   
   
   #遮罩相關處理
   LET g_xrca_m_mask_o.* =  g_xrca_m.*
   CALL axrq510_xrca_t_mask()
   LET g_xrca_m_mask_n.* =  g_xrca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrca003,g_xrca_m.xrca003_desc,g_xrca_m.xrcald, 
       g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocno_desc,g_xrca_m.xrcadocdt, 
       g_xrca_m.xrca004,g_xrca_m.xrca004_desc,g_xrca_m.xrca005,g_xrca_m.xrca005_desc,g_xrca_m.xrca038, 
       g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca007_desc,g_xrca_m.xrca035,g_xrca_m.xrca035_desc, 
       g_xrca_m.xrca036,g_xrca_m.xrca036_desc,g_xrca_m.xrca059,g_xrca_m.xrca059_desc,g_xrca_m.xrca100, 
       g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrcc109,g_xrca_m.lbl_calc, 
       g_xrca_m.glaa001,g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrcc113, 
       g_xrca_m.xrca118,g_xrca_m.xrcc119,g_xrca_m.lbl_calc2,g_xrca_m.xrca014,g_xrca_m.xrca014_desc,g_xrca_m.xrca034, 
       g_xrca_m.xrca034_desc,g_xrca_m.xrca015,g_xrca_m.xrca015_desc,g_xrca_m.xrca033,g_xrca_m.xrca033_desc, 
       g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca011_desc,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016, 
       g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050,g_xrca_m.xrca063, 
       g_xrca_m.xrca051,g_xrca_m.xrca051_desc,g_xrca_m.xrca1002,g_xrca_m.xrca1032,g_xrca_m.xrca1042, 
       g_xrca_m.xrca1072,g_xrca_m.xrca1082,g_xrca_m.xrcc1092,g_xrca_m.lbl_calc_2,g_xrca_m.glaa0012,g_xrca_m.xrca1012, 
       g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131,g_xrca_m.xrca1132,g_xrca_m.xrca123, 
       g_xrca_m.xrca133,g_xrca_m.xrca1142,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca1172,g_xrca_m.xrca127, 
       g_xrca_m.xrca137,g_xrca_m.xrcc1132,g_xrca_m.xrcc123,g_xrca_m.xrcc133,g_xrca_m.xrca1182,g_xrca_m.xrca128, 
       g_xrca_m.xrca138,g_xrca_m.xrcc1192,g_xrca_m.xrcc129,g_xrca_m.xrcc139,g_xrca_m.lbl_calc2_2,g_xrca_m.lbl_calc3, 
       g_xrca_m.lbl_calc4,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca008_desc, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca058_desc,g_xrca_m.xrca046, 
       g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca028_desc, 
       g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020, 
       g_xrca_m.xrca022,g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040, 
       g_xrca_m.xrca041,g_xrca_m.xrca041_desc,g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045, 
       g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca054_desc,g_xrca_m.xrca055,g_xrca_m.xrca055_desc, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca057_desc,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064, 
       g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc, 
       g_xrca_m.xrcaownid,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid, 
       g_xrca_m.xrcacrtid_desc,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid, 
       g_xrca_m.xrcamodid_desc,g_xrca_m.xrcamoddt,g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcacnfdt, 
       g_xrca_m.xrcapstid,g_xrca_m.xrcapstid_desc,g_xrca_m.xrcapstdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_xrca_m.xrcaownid      
   LET g_data_dept  = g_xrca_m.xrcaowndp
 
   #功能已完成,通報訊息中心
   CALL axrq510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axrq510.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrq510_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_xrca_m.xrcald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_xrcald_t = g_xrca_m.xrcald
   LET g_xrcadocno_t = g_xrca_m.xrcadocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN axrq510_cl USING g_enterprise,g_xrca_m.xrcald,g_xrca_m.xrcadocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrq510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE axrq510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrq510_master_referesh USING g_xrca_m.xrcald,g_xrca_m.xrcadocno INTO g_xrca_m.xrcasite,g_xrca_m.xrca003, 
       g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005, 
       g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059, 
       g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrca101, 
       g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118,g_xrca_m.xrca014,g_xrca_m.xrca034, 
       g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012, 
       g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050, 
       g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131, 
       g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127,g_xrca_m.xrca137, 
       g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047, 
       g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030, 
       g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065, 
       g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca042, 
       g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106, 
       g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp, 
       g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt, 
       g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt,g_xrca_m.xrcasite_desc, 
       g_xrca_m.xrca003_desc,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno_desc,g_xrca_m.xrca004_desc,g_xrca_m.xrca005_desc, 
       g_xrca_m.xrca007_desc,g_xrca_m.xrca059_desc,g_xrca_m.xrca014_desc,g_xrca_m.xrca034_desc,g_xrca_m.xrca015_desc, 
       g_xrca_m.xrca033_desc,g_xrca_m.xrca011_desc,g_xrca_m.xrca051_desc,g_xrca_m.xrca008_desc,g_xrca_m.xrca058_desc, 
       g_xrca_m.xrca028_desc,g_xrca_m.xrca041_desc,g_xrca_m.xrca054_desc,g_xrca_m.xrca055_desc,g_xrca_m.xrca057_desc, 
       g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid_desc, 
       g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcamodid_desc,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcapstid_desc 
 
 
   #檢查是否允許此動作
   IF NOT axrq510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xrca_m_mask_o.* =  g_xrca_m.*
   CALL axrq510_xrca_t_mask()
   LET g_xrca_m_mask_n.* =  g_xrca_m.*
   
   
 
   #顯示資料
   CALL axrq510_show()
   
   WHILE TRUE
      LET g_xrca_m.xrcald = g_xrcald_t
      LET g_xrca_m.xrcadocno = g_xrcadocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_xrca_m.xrcamodid = g_user 
LET g_xrca_m.xrcamoddt = cl_get_current()
LET g_xrca_m.xrcamodid_desc = cl_get_username(g_xrca_m.xrcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL axrq510_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xrca_m.* = g_xrca_m_t.*
         CALL axrq510_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE xrca_t SET (xrcamodid,xrcamoddt) = (g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt)
       WHERE xrcaent = g_enterprise AND xrcald = g_xrcald_t
         AND xrcadocno = g_xrcadocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL axrq510_set_act_visible()
   CALL axrq510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xrcaent = " ||g_enterprise|| " AND",
                      " xrcald = '", g_xrca_m.xrcald, "' "
                      ," AND xrcadocno = '", g_xrca_m.xrcadocno, "' "
 
   #填到對應位置
   CALL axrq510_browser_fill(g_wc,"")
 
   CLOSE axrq510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrq510_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="axrq510.input" >}
#+ 資料輸入
PRIVATE FUNCTION axrq510_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrca003,g_xrca_m.xrca003_desc,g_xrca_m.xrcald, 
       g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocno_desc,g_xrca_m.xrcadocdt, 
       g_xrca_m.xrca004,g_xrca_m.xrca004_desc,g_xrca_m.xrca005,g_xrca_m.xrca005_desc,g_xrca_m.xrca038, 
       g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca007_desc,g_xrca_m.xrca035,g_xrca_m.xrca035_desc, 
       g_xrca_m.xrca036,g_xrca_m.xrca036_desc,g_xrca_m.xrca059,g_xrca_m.xrca059_desc,g_xrca_m.xrca100, 
       g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrcc109,g_xrca_m.lbl_calc, 
       g_xrca_m.glaa001,g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrcc113, 
       g_xrca_m.xrca118,g_xrca_m.xrcc119,g_xrca_m.lbl_calc2,g_xrca_m.xrca014,g_xrca_m.xrca014_desc,g_xrca_m.xrca034, 
       g_xrca_m.xrca034_desc,g_xrca_m.xrca015,g_xrca_m.xrca015_desc,g_xrca_m.xrca033,g_xrca_m.xrca033_desc, 
       g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca011_desc,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016, 
       g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050,g_xrca_m.xrca063, 
       g_xrca_m.xrca051,g_xrca_m.xrca051_desc,g_xrca_m.xrca1002,g_xrca_m.xrca1032,g_xrca_m.xrca1042, 
       g_xrca_m.xrca1072,g_xrca_m.xrca1082,g_xrca_m.xrcc1092,g_xrca_m.lbl_calc_2,g_xrca_m.glaa0012,g_xrca_m.xrca1012, 
       g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131,g_xrca_m.xrca1132,g_xrca_m.xrca123, 
       g_xrca_m.xrca133,g_xrca_m.xrca1142,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca1172,g_xrca_m.xrca127, 
       g_xrca_m.xrca137,g_xrca_m.xrcc1132,g_xrca_m.xrcc123,g_xrca_m.xrcc133,g_xrca_m.xrca1182,g_xrca_m.xrca128, 
       g_xrca_m.xrca138,g_xrca_m.xrcc1192,g_xrca_m.xrcc129,g_xrca_m.xrcc139,g_xrca_m.lbl_calc2_2,g_xrca_m.lbl_calc3, 
       g_xrca_m.lbl_calc4,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca008_desc, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca058_desc,g_xrca_m.xrca046, 
       g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca028_desc, 
       g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020, 
       g_xrca_m.xrca022,g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040, 
       g_xrca_m.xrca041,g_xrca_m.xrca041_desc,g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045, 
       g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca054_desc,g_xrca_m.xrca055,g_xrca_m.xrca055_desc, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca057_desc,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064, 
       g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc, 
       g_xrca_m.xrcaownid,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid, 
       g_xrca_m.xrcacrtid_desc,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid, 
       g_xrca_m.xrcamodid_desc,g_xrca_m.xrcamoddt,g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcacnfdt, 
       g_xrca_m.xrcapstid,g_xrca_m.xrcapstid_desc,g_xrca_m.xrcapstdt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL axrq510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axrq510_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.xrca003,g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001, 
          g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005,g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007, 
          g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059,g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104, 
          g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrcc109,g_xrca_m.lbl_calc,g_xrca_m.glaa001,g_xrca_m.xrca101, 
          g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrcc113,g_xrca_m.xrca118,g_xrca_m.xrcc119, 
          g_xrca_m.lbl_calc2,g_xrca_m.xrca014,g_xrca_m.xrca034,g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060, 
          g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053, 
          g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050,g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca1002, 
          g_xrca_m.xrca1032,g_xrca_m.xrca1042,g_xrca_m.xrca1072,g_xrca_m.xrca1082,g_xrca_m.xrcc1092, 
          g_xrca_m.lbl_calc_2,g_xrca_m.glaa0012,g_xrca_m.xrca1012,g_xrca_m.xrca120,g_xrca_m.xrca121, 
          g_xrca_m.xrca130,g_xrca_m.xrca131,g_xrca_m.xrca1132,g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca1142, 
          g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca1172,g_xrca_m.xrca127,g_xrca_m.xrca137,g_xrca_m.xrcc1132, 
          g_xrca_m.xrcc123,g_xrca_m.xrcc133,g_xrca_m.xrca1182,g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrcc1192, 
          g_xrca_m.xrcc129,g_xrca_m.xrcc139,g_xrca_m.lbl_calc2_2,g_xrca_m.lbl_calc3,g_xrca_m.lbl_calc4, 
          g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca019,g_xrca_m.xrca023, 
          g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025, 
          g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032, 
          g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037, 
          g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044, 
          g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055,g_xrca_m.xrca056,g_xrca_m.xrca057, 
          g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126, 
          g_xrca_m.xrca136,g_xrca_m.xrcacomp 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcasite
            
            #add-point:AFTER FIELD xrcasite name="input.a.xrcasite"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcasite
            #add-point:BEFORE FIELD xrcasite name="input.b.xrcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcasite
            #add-point:ON CHANGE xrcasite name="input.g.xrcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca003
            
            #add-point:AFTER FIELD xrca003 name="input.a.xrca003"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca003
            #add-point:BEFORE FIELD xrca003 name="input.b.xrca003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca003
            #add-point:ON CHANGE xrca003 name="input.g.xrca003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="input.a.xrcald"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="input.b.xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcald
            #add-point:ON CHANGE xrcald name="input.g.xrcald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="input.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocno
            #add-point:ON CHANGE xrcadocno name="input.g.xrcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca001
            #add-point:BEFORE FIELD xrca001 name="input.b.xrca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca001
            
            #add-point:AFTER FIELD xrca001 name="input.a.xrca001"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca001
            #add-point:ON CHANGE xrca001 name="input.g.xrca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocdt
            #add-point:BEFORE FIELD xrcadocdt name="input.b.xrcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocdt
            
            #add-point:AFTER FIELD xrcadocdt name="input.a.xrcadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocdt
            #add-point:ON CHANGE xrcadocdt name="input.g.xrcadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca004
            
            #add-point:AFTER FIELD xrca004 name="input.a.xrca004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca004
            #add-point:BEFORE FIELD xrca004 name="input.b.xrca004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca004
            #add-point:ON CHANGE xrca004 name="input.g.xrca004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca005
            
            #add-point:AFTER FIELD xrca005 name="input.a.xrca005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca005
            #add-point:BEFORE FIELD xrca005 name="input.b.xrca005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca005
            #add-point:ON CHANGE xrca005 name="input.g.xrca005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca038
            #add-point:BEFORE FIELD xrca038 name="input.b.xrca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca038
            
            #add-point:AFTER FIELD xrca038 name="input.a.xrca038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca038
            #add-point:ON CHANGE xrca038 name="input.g.xrca038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcastus
            #add-point:BEFORE FIELD xrcastus name="input.b.xrcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcastus
            
            #add-point:AFTER FIELD xrcastus name="input.a.xrcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcastus
            #add-point:ON CHANGE xrcastus name="input.g.xrcastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca007
            
            #add-point:AFTER FIELD xrca007 name="input.a.xrca007"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca007
            #add-point:BEFORE FIELD xrca007 name="input.b.xrca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca007
            #add-point:ON CHANGE xrca007 name="input.g.xrca007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca035
            
            #add-point:AFTER FIELD xrca035 name="input.a.xrca035"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca035
            #add-point:BEFORE FIELD xrca035 name="input.b.xrca035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca035
            #add-point:ON CHANGE xrca035 name="input.g.xrca035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca036
            
            #add-point:AFTER FIELD xrca036 name="input.a.xrca036"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca036
            #add-point:BEFORE FIELD xrca036 name="input.b.xrca036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca036
            #add-point:ON CHANGE xrca036 name="input.g.xrca036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca059
            
            #add-point:AFTER FIELD xrca059 name="input.a.xrca059"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca059
            #add-point:BEFORE FIELD xrca059 name="input.b.xrca059"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca059
            #add-point:ON CHANGE xrca059 name="input.g.xrca059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca100
            #add-point:BEFORE FIELD xrca100 name="input.b.xrca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca100
            
            #add-point:AFTER FIELD xrca100 name="input.a.xrca100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca100
            #add-point:ON CHANGE xrca100 name="input.g.xrca100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca103
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca103,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca103
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca103 name="input.a.xrca103"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca103
            #add-point:BEFORE FIELD xrca103 name="input.b.xrca103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca103
            #add-point:ON CHANGE xrca103 name="input.g.xrca103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca104
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca104,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca104
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca104 name="input.a.xrca104"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca104
            #add-point:BEFORE FIELD xrca104 name="input.b.xrca104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca104
            #add-point:ON CHANGE xrca104 name="input.g.xrca104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca107
            #add-point:BEFORE FIELD xrca107 name="input.b.xrca107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca107
            
            #add-point:AFTER FIELD xrca107 name="input.a.xrca107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca107
            #add-point:ON CHANGE xrca107 name="input.g.xrca107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca108
            #add-point:BEFORE FIELD xrca108 name="input.b.xrca108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca108
            
            #add-point:AFTER FIELD xrca108 name="input.a.xrca108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca108
            #add-point:ON CHANGE xrca108 name="input.g.xrca108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc109
            #add-point:BEFORE FIELD xrcc109 name="input.b.xrcc109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc109
            
            #add-point:AFTER FIELD xrcc109 name="input.a.xrcc109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc109
            #add-point:ON CHANGE xrcc109 name="input.g.xrcc109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_calc
            #add-point:BEFORE FIELD lbl_calc name="input.b.lbl_calc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_calc
            
            #add-point:AFTER FIELD lbl_calc name="input.a.lbl_calc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_calc
            #add-point:ON CHANGE lbl_calc name="input.g.lbl_calc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="input.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="input.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa001
            #add-point:ON CHANGE glaa001 name="input.g.glaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca101
            #add-point:BEFORE FIELD xrca101 name="input.b.xrca101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca101
            
            #add-point:AFTER FIELD xrca101 name="input.a.xrca101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca101
            #add-point:ON CHANGE xrca101 name="input.g.xrca101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca113
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca113,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca113
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca113 name="input.a.xrca113"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca113
            #add-point:BEFORE FIELD xrca113 name="input.b.xrca113"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca113
            #add-point:ON CHANGE xrca113 name="input.g.xrca113"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca114
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca114,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca114
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca114 name="input.a.xrca114"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca114
            #add-point:BEFORE FIELD xrca114 name="input.b.xrca114"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca114
            #add-point:ON CHANGE xrca114 name="input.g.xrca114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca117
            #add-point:BEFORE FIELD xrca117 name="input.b.xrca117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca117
            
            #add-point:AFTER FIELD xrca117 name="input.a.xrca117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca117
            #add-point:ON CHANGE xrca117 name="input.g.xrca117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc113
            #add-point:BEFORE FIELD xrcc113 name="input.b.xrcc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc113
            
            #add-point:AFTER FIELD xrcc113 name="input.a.xrcc113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc113
            #add-point:ON CHANGE xrcc113 name="input.g.xrcc113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca118
            #add-point:BEFORE FIELD xrca118 name="input.b.xrca118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca118
            
            #add-point:AFTER FIELD xrca118 name="input.a.xrca118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca118
            #add-point:ON CHANGE xrca118 name="input.g.xrca118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc119
            #add-point:BEFORE FIELD xrcc119 name="input.b.xrcc119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc119
            
            #add-point:AFTER FIELD xrcc119 name="input.a.xrcc119"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc119
            #add-point:ON CHANGE xrcc119 name="input.g.xrcc119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_calc2
            #add-point:BEFORE FIELD lbl_calc2 name="input.b.lbl_calc2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_calc2
            
            #add-point:AFTER FIELD lbl_calc2 name="input.a.lbl_calc2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_calc2
            #add-point:ON CHANGE lbl_calc2 name="input.g.lbl_calc2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca014
            
            #add-point:AFTER FIELD xrca014 name="input.a.xrca014"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca014
            #add-point:BEFORE FIELD xrca014 name="input.b.xrca014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca014
            #add-point:ON CHANGE xrca014 name="input.g.xrca014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca034
            
            #add-point:AFTER FIELD xrca034 name="input.a.xrca034"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca034
            #add-point:BEFORE FIELD xrca034 name="input.b.xrca034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca034
            #add-point:ON CHANGE xrca034 name="input.g.xrca034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca015
            
            #add-point:AFTER FIELD xrca015 name="input.a.xrca015"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca015
            #add-point:BEFORE FIELD xrca015 name="input.b.xrca015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca015
            #add-point:ON CHANGE xrca015 name="input.g.xrca015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca033
            
            #add-point:AFTER FIELD xrca033 name="input.a.xrca033"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca033
            #add-point:BEFORE FIELD xrca033 name="input.b.xrca033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca033
            #add-point:ON CHANGE xrca033 name="input.g.xrca033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca060
            #add-point:BEFORE FIELD xrca060 name="input.b.xrca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca060
            
            #add-point:AFTER FIELD xrca060 name="input.a.xrca060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca060
            #add-point:ON CHANGE xrca060 name="input.g.xrca060"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca011
            
            #add-point:AFTER FIELD xrca011 name="input.a.xrca011"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca011
            #add-point:BEFORE FIELD xrca011 name="input.b.xrca011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca011
            #add-point:ON CHANGE xrca011 name="input.g.xrca011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca013
            #add-point:BEFORE FIELD xrca013 name="input.b.xrca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca013
            
            #add-point:AFTER FIELD xrca013 name="input.a.xrca013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca013
            #add-point:ON CHANGE xrca013 name="input.g.xrca013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca012
            #add-point:BEFORE FIELD xrca012 name="input.b.xrca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca012
            
            #add-point:AFTER FIELD xrca012 name="input.a.xrca012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca012
            #add-point:ON CHANGE xrca012 name="input.g.xrca012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca016
            #add-point:BEFORE FIELD xrca016 name="input.b.xrca016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca016
            
            #add-point:AFTER FIELD xrca016 name="input.a.xrca016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca016
            #add-point:ON CHANGE xrca016 name="input.g.xrca016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca018
            #add-point:BEFORE FIELD xrca018 name="input.b.xrca018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca018
            
            #add-point:AFTER FIELD xrca018 name="input.a.xrca018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca018
            #add-point:ON CHANGE xrca018 name="input.g.xrca018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca053
            #add-point:BEFORE FIELD xrca053 name="input.b.xrca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca053
            
            #add-point:AFTER FIELD xrca053 name="input.a.xrca053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca053
            #add-point:ON CHANGE xrca053 name="input.g.xrca053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca017
            #add-point:BEFORE FIELD xrca017 name="input.b.xrca017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca017
            
            #add-point:AFTER FIELD xrca017 name="input.a.xrca017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca017
            #add-point:ON CHANGE xrca017 name="input.g.xrca017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca052
            #add-point:BEFORE FIELD xrca052 name="input.b.xrca052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca052
            
            #add-point:AFTER FIELD xrca052 name="input.a.xrca052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca052
            #add-point:ON CHANGE xrca052 name="input.g.xrca052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca050
            #add-point:BEFORE FIELD xrca050 name="input.b.xrca050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca050
            
            #add-point:AFTER FIELD xrca050 name="input.a.xrca050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca050
            #add-point:ON CHANGE xrca050 name="input.g.xrca050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca063
            #add-point:BEFORE FIELD xrca063 name="input.b.xrca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca063
            
            #add-point:AFTER FIELD xrca063 name="input.a.xrca063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca063
            #add-point:ON CHANGE xrca063 name="input.g.xrca063"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca051
            
            #add-point:AFTER FIELD xrca051 name="input.a.xrca051"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca051
            #add-point:BEFORE FIELD xrca051 name="input.b.xrca051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca051
            #add-point:ON CHANGE xrca051 name="input.g.xrca051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1002
            #add-point:BEFORE FIELD xrca1002 name="input.b.xrca1002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1002
            
            #add-point:AFTER FIELD xrca1002 name="input.a.xrca1002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1002
            #add-point:ON CHANGE xrca1002 name="input.g.xrca1002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1032
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca1032,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca1032
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca1032 name="input.a.xrca1032"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1032
            #add-point:BEFORE FIELD xrca1032 name="input.b.xrca1032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1032
            #add-point:ON CHANGE xrca1032 name="input.g.xrca1032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1042
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca1042,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca1042
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca1042 name="input.a.xrca1042"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1042
            #add-point:BEFORE FIELD xrca1042 name="input.b.xrca1042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1042
            #add-point:ON CHANGE xrca1042 name="input.g.xrca1042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1072
            #add-point:BEFORE FIELD xrca1072 name="input.b.xrca1072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1072
            
            #add-point:AFTER FIELD xrca1072 name="input.a.xrca1072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1072
            #add-point:ON CHANGE xrca1072 name="input.g.xrca1072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1082
            #add-point:BEFORE FIELD xrca1082 name="input.b.xrca1082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1082
            
            #add-point:AFTER FIELD xrca1082 name="input.a.xrca1082"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1082
            #add-point:ON CHANGE xrca1082 name="input.g.xrca1082"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc1092
            #add-point:BEFORE FIELD xrcc1092 name="input.b.xrcc1092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc1092
            
            #add-point:AFTER FIELD xrcc1092 name="input.a.xrcc1092"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc1092
            #add-point:ON CHANGE xrcc1092 name="input.g.xrcc1092"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_calc_2
            #add-point:BEFORE FIELD lbl_calc_2 name="input.b.lbl_calc_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_calc_2
            
            #add-point:AFTER FIELD lbl_calc_2 name="input.a.lbl_calc_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_calc_2
            #add-point:ON CHANGE lbl_calc_2 name="input.g.lbl_calc_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa0012
            #add-point:BEFORE FIELD glaa0012 name="input.b.glaa0012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa0012
            
            #add-point:AFTER FIELD glaa0012 name="input.a.glaa0012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa0012
            #add-point:ON CHANGE glaa0012 name="input.g.glaa0012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1012
            #add-point:BEFORE FIELD xrca1012 name="input.b.xrca1012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1012
            
            #add-point:AFTER FIELD xrca1012 name="input.a.xrca1012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1012
            #add-point:ON CHANGE xrca1012 name="input.g.xrca1012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca120
            #add-point:BEFORE FIELD xrca120 name="input.b.xrca120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca120
            
            #add-point:AFTER FIELD xrca120 name="input.a.xrca120"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca120
            #add-point:ON CHANGE xrca120 name="input.g.xrca120"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca121
            #add-point:BEFORE FIELD xrca121 name="input.b.xrca121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca121
            
            #add-point:AFTER FIELD xrca121 name="input.a.xrca121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca121
            #add-point:ON CHANGE xrca121 name="input.g.xrca121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca130
            #add-point:BEFORE FIELD xrca130 name="input.b.xrca130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca130
            
            #add-point:AFTER FIELD xrca130 name="input.a.xrca130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca130
            #add-point:ON CHANGE xrca130 name="input.g.xrca130"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca131
            #add-point:BEFORE FIELD xrca131 name="input.b.xrca131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca131
            
            #add-point:AFTER FIELD xrca131 name="input.a.xrca131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca131
            #add-point:ON CHANGE xrca131 name="input.g.xrca131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1132
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca1132,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca1132
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca1132 name="input.a.xrca1132"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1132
            #add-point:BEFORE FIELD xrca1132 name="input.b.xrca1132"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1132
            #add-point:ON CHANGE xrca1132 name="input.g.xrca1132"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca123
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca123,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca123
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca123 name="input.a.xrca123"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca123
            #add-point:BEFORE FIELD xrca123 name="input.b.xrca123"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca123
            #add-point:ON CHANGE xrca123 name="input.g.xrca123"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca133
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca133,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca133
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca133 name="input.a.xrca133"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca133
            #add-point:BEFORE FIELD xrca133 name="input.b.xrca133"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca133
            #add-point:ON CHANGE xrca133 name="input.g.xrca133"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1142
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca1142,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca1142
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca1142 name="input.a.xrca1142"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1142
            #add-point:BEFORE FIELD xrca1142 name="input.b.xrca1142"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1142
            #add-point:ON CHANGE xrca1142 name="input.g.xrca1142"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca124
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca124,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca124
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca124 name="input.a.xrca124"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca124
            #add-point:BEFORE FIELD xrca124 name="input.b.xrca124"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca124
            #add-point:ON CHANGE xrca124 name="input.g.xrca124"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca134
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca134,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca134
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca134 name="input.a.xrca134"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca134
            #add-point:BEFORE FIELD xrca134 name="input.b.xrca134"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca134
            #add-point:ON CHANGE xrca134 name="input.g.xrca134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1172
            #add-point:BEFORE FIELD xrca1172 name="input.b.xrca1172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1172
            
            #add-point:AFTER FIELD xrca1172 name="input.a.xrca1172"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1172
            #add-point:ON CHANGE xrca1172 name="input.g.xrca1172"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca127
            #add-point:BEFORE FIELD xrca127 name="input.b.xrca127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca127
            
            #add-point:AFTER FIELD xrca127 name="input.a.xrca127"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca127
            #add-point:ON CHANGE xrca127 name="input.g.xrca127"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca137
            #add-point:BEFORE FIELD xrca137 name="input.b.xrca137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca137
            
            #add-point:AFTER FIELD xrca137 name="input.a.xrca137"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca137
            #add-point:ON CHANGE xrca137 name="input.g.xrca137"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc1132
            #add-point:BEFORE FIELD xrcc1132 name="input.b.xrcc1132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc1132
            
            #add-point:AFTER FIELD xrcc1132 name="input.a.xrcc1132"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc1132
            #add-point:ON CHANGE xrcc1132 name="input.g.xrcc1132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc123
            #add-point:BEFORE FIELD xrcc123 name="input.b.xrcc123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc123
            
            #add-point:AFTER FIELD xrcc123 name="input.a.xrcc123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc123
            #add-point:ON CHANGE xrcc123 name="input.g.xrcc123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc133
            #add-point:BEFORE FIELD xrcc133 name="input.b.xrcc133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc133
            
            #add-point:AFTER FIELD xrcc133 name="input.a.xrcc133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc133
            #add-point:ON CHANGE xrcc133 name="input.g.xrcc133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca1182
            #add-point:BEFORE FIELD xrca1182 name="input.b.xrca1182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca1182
            
            #add-point:AFTER FIELD xrca1182 name="input.a.xrca1182"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca1182
            #add-point:ON CHANGE xrca1182 name="input.g.xrca1182"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca128
            #add-point:BEFORE FIELD xrca128 name="input.b.xrca128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca128
            
            #add-point:AFTER FIELD xrca128 name="input.a.xrca128"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca128
            #add-point:ON CHANGE xrca128 name="input.g.xrca128"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca138
            #add-point:BEFORE FIELD xrca138 name="input.b.xrca138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca138
            
            #add-point:AFTER FIELD xrca138 name="input.a.xrca138"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca138
            #add-point:ON CHANGE xrca138 name="input.g.xrca138"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc1192
            #add-point:BEFORE FIELD xrcc1192 name="input.b.xrcc1192"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc1192
            
            #add-point:AFTER FIELD xrcc1192 name="input.a.xrcc1192"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc1192
            #add-point:ON CHANGE xrcc1192 name="input.g.xrcc1192"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc129
            #add-point:BEFORE FIELD xrcc129 name="input.b.xrcc129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc129
            
            #add-point:AFTER FIELD xrcc129 name="input.a.xrcc129"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc129
            #add-point:ON CHANGE xrcc129 name="input.g.xrcc129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcc139
            #add-point:BEFORE FIELD xrcc139 name="input.b.xrcc139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcc139
            
            #add-point:AFTER FIELD xrcc139 name="input.a.xrcc139"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcc139
            #add-point:ON CHANGE xrcc139 name="input.g.xrcc139"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_calc2_2
            #add-point:BEFORE FIELD lbl_calc2_2 name="input.b.lbl_calc2_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_calc2_2
            
            #add-point:AFTER FIELD lbl_calc2_2 name="input.a.lbl_calc2_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_calc2_2
            #add-point:ON CHANGE lbl_calc2_2 name="input.g.lbl_calc2_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_calc3
            #add-point:BEFORE FIELD lbl_calc3 name="input.b.lbl_calc3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_calc3
            
            #add-point:AFTER FIELD lbl_calc3 name="input.a.lbl_calc3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_calc3
            #add-point:ON CHANGE lbl_calc3 name="input.g.lbl_calc3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_calc4
            #add-point:BEFORE FIELD lbl_calc4 name="input.b.lbl_calc4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_calc4
            
            #add-point:AFTER FIELD lbl_calc4 name="input.a.lbl_calc4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_calc4
            #add-point:ON CHANGE lbl_calc4 name="input.g.lbl_calc4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca006
            #add-point:BEFORE FIELD xrca006 name="input.b.xrca006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca006
            
            #add-point:AFTER FIELD xrca006 name="input.a.xrca006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca006
            #add-point:ON CHANGE xrca006 name="input.g.xrca006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca008
            
            #add-point:AFTER FIELD xrca008 name="input.a.xrca008"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca008
            #add-point:BEFORE FIELD xrca008 name="input.b.xrca008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca008
            #add-point:ON CHANGE xrca008 name="input.g.xrca008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca009
            #add-point:BEFORE FIELD xrca009 name="input.b.xrca009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca009
            
            #add-point:AFTER FIELD xrca009 name="input.a.xrca009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca009
            #add-point:ON CHANGE xrca009 name="input.g.xrca009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca010
            #add-point:BEFORE FIELD xrca010 name="input.b.xrca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca010
            
            #add-point:AFTER FIELD xrca010 name="input.a.xrca010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca010
            #add-point:ON CHANGE xrca010 name="input.g.xrca010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca019
            #add-point:BEFORE FIELD xrca019 name="input.b.xrca019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca019
            
            #add-point:AFTER FIELD xrca019 name="input.a.xrca019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca019
            #add-point:ON CHANGE xrca019 name="input.g.xrca019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca023
            #add-point:BEFORE FIELD xrca023 name="input.b.xrca023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca023
            
            #add-point:AFTER FIELD xrca023 name="input.a.xrca023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca023
            #add-point:ON CHANGE xrca023 name="input.g.xrca023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca024
            #add-point:BEFORE FIELD xrca024 name="input.b.xrca024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca024
            
            #add-point:AFTER FIELD xrca024 name="input.a.xrca024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca024
            #add-point:ON CHANGE xrca024 name="input.g.xrca024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca058
            
            #add-point:AFTER FIELD xrca058 name="input.a.xrca058"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca058
            #add-point:BEFORE FIELD xrca058 name="input.b.xrca058"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca058
            #add-point:ON CHANGE xrca058 name="input.g.xrca058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca046
            #add-point:BEFORE FIELD xrca046 name="input.b.xrca046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca046
            
            #add-point:AFTER FIELD xrca046 name="input.a.xrca046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca046
            #add-point:ON CHANGE xrca046 name="input.g.xrca046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca047
            #add-point:BEFORE FIELD xrca047 name="input.b.xrca047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca047
            
            #add-point:AFTER FIELD xrca047 name="input.a.xrca047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca047
            #add-point:ON CHANGE xrca047 name="input.g.xrca047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca048
            #add-point:BEFORE FIELD xrca048 name="input.b.xrca048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca048
            
            #add-point:AFTER FIELD xrca048 name="input.a.xrca048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca048
            #add-point:ON CHANGE xrca048 name="input.g.xrca048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca025
            #add-point:BEFORE FIELD xrca025 name="input.b.xrca025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca025
            
            #add-point:AFTER FIELD xrca025 name="input.a.xrca025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca025
            #add-point:ON CHANGE xrca025 name="input.g.xrca025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca026
            #add-point:BEFORE FIELD xrca026 name="input.b.xrca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca026
            
            #add-point:AFTER FIELD xrca026 name="input.a.xrca026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca026
            #add-point:ON CHANGE xrca026 name="input.g.xrca026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca028
            
            #add-point:AFTER FIELD xrca028 name="input.a.xrca028"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca028
            #add-point:BEFORE FIELD xrca028 name="input.b.xrca028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca028
            #add-point:ON CHANGE xrca028 name="input.g.xrca028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca029
            #add-point:BEFORE FIELD xrca029 name="input.b.xrca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca029
            
            #add-point:AFTER FIELD xrca029 name="input.a.xrca029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca029
            #add-point:ON CHANGE xrca029 name="input.g.xrca029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca030
            #add-point:BEFORE FIELD xrca030 name="input.b.xrca030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca030
            
            #add-point:AFTER FIELD xrca030 name="input.a.xrca030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca030
            #add-point:ON CHANGE xrca030 name="input.g.xrca030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca031
            #add-point:BEFORE FIELD xrca031 name="input.b.xrca031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca031
            
            #add-point:AFTER FIELD xrca031 name="input.a.xrca031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca031
            #add-point:ON CHANGE xrca031 name="input.g.xrca031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca032
            #add-point:BEFORE FIELD xrca032 name="input.b.xrca032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca032
            
            #add-point:AFTER FIELD xrca032 name="input.a.xrca032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca032
            #add-point:ON CHANGE xrca032 name="input.g.xrca032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca021
            #add-point:BEFORE FIELD xrca021 name="input.b.xrca021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca021
            
            #add-point:AFTER FIELD xrca021 name="input.a.xrca021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca021
            #add-point:ON CHANGE xrca021 name="input.g.xrca021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca020
            #add-point:BEFORE FIELD xrca020 name="input.b.xrca020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca020
            
            #add-point:AFTER FIELD xrca020 name="input.a.xrca020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca020
            #add-point:ON CHANGE xrca020 name="input.g.xrca020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca022
            #add-point:BEFORE FIELD xrca022 name="input.b.xrca022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca022
            
            #add-point:AFTER FIELD xrca022 name="input.a.xrca022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca022
            #add-point:ON CHANGE xrca022 name="input.g.xrca022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca065
            #add-point:BEFORE FIELD xrca065 name="input.b.xrca065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca065
            
            #add-point:AFTER FIELD xrca065 name="input.a.xrca065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca065
            #add-point:ON CHANGE xrca065 name="input.g.xrca065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca066
            #add-point:BEFORE FIELD xrca066 name="input.b.xrca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca066
            
            #add-point:AFTER FIELD xrca066 name="input.a.xrca066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca066
            #add-point:ON CHANGE xrca066 name="input.g.xrca066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca037
            #add-point:BEFORE FIELD xrca037 name="input.b.xrca037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca037
            
            #add-point:AFTER FIELD xrca037 name="input.a.xrca037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca037
            #add-point:ON CHANGE xrca037 name="input.g.xrca037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca039
            #add-point:BEFORE FIELD xrca039 name="input.b.xrca039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca039
            
            #add-point:AFTER FIELD xrca039 name="input.a.xrca039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca039
            #add-point:ON CHANGE xrca039 name="input.g.xrca039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca040
            #add-point:BEFORE FIELD xrca040 name="input.b.xrca040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca040
            
            #add-point:AFTER FIELD xrca040 name="input.a.xrca040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca040
            #add-point:ON CHANGE xrca040 name="input.g.xrca040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca041
            
            #add-point:AFTER FIELD xrca041 name="input.a.xrca041"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca041
            #add-point:BEFORE FIELD xrca041 name="input.b.xrca041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca041
            #add-point:ON CHANGE xrca041 name="input.g.xrca041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca042
            #add-point:BEFORE FIELD xrca042 name="input.b.xrca042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca042
            
            #add-point:AFTER FIELD xrca042 name="input.a.xrca042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca042
            #add-point:ON CHANGE xrca042 name="input.g.xrca042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca043
            #add-point:BEFORE FIELD xrca043 name="input.b.xrca043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca043
            
            #add-point:AFTER FIELD xrca043 name="input.a.xrca043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca043
            #add-point:ON CHANGE xrca043 name="input.g.xrca043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca044
            #add-point:BEFORE FIELD xrca044 name="input.b.xrca044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca044
            
            #add-point:AFTER FIELD xrca044 name="input.a.xrca044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca044
            #add-point:ON CHANGE xrca044 name="input.g.xrca044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca045
            #add-point:BEFORE FIELD xrca045 name="input.b.xrca045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca045
            
            #add-point:AFTER FIELD xrca045 name="input.a.xrca045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca045
            #add-point:ON CHANGE xrca045 name="input.g.xrca045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca049
            #add-point:BEFORE FIELD xrca049 name="input.b.xrca049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca049
            
            #add-point:AFTER FIELD xrca049 name="input.a.xrca049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca049
            #add-point:ON CHANGE xrca049 name="input.g.xrca049"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca054
            
            #add-point:AFTER FIELD xrca054 name="input.a.xrca054"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca054
            #add-point:BEFORE FIELD xrca054 name="input.b.xrca054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca054
            #add-point:ON CHANGE xrca054 name="input.g.xrca054"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca055
            
            #add-point:AFTER FIELD xrca055 name="input.a.xrca055"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca055
            #add-point:BEFORE FIELD xrca055 name="input.b.xrca055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca055
            #add-point:ON CHANGE xrca055 name="input.g.xrca055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca056
            #add-point:BEFORE FIELD xrca056 name="input.b.xrca056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca056
            
            #add-point:AFTER FIELD xrca056 name="input.a.xrca056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca056
            #add-point:ON CHANGE xrca056 name="input.g.xrca056"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca057
            
            #add-point:AFTER FIELD xrca057 name="input.a.xrca057"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca057
            #add-point:BEFORE FIELD xrca057 name="input.b.xrca057"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca057
            #add-point:ON CHANGE xrca057 name="input.g.xrca057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca061
            #add-point:BEFORE FIELD xrca061 name="input.b.xrca061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca061
            
            #add-point:AFTER FIELD xrca061 name="input.a.xrca061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca061
            #add-point:ON CHANGE xrca061 name="input.g.xrca061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca062
            #add-point:BEFORE FIELD xrca062 name="input.b.xrca062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca062
            
            #add-point:AFTER FIELD xrca062 name="input.a.xrca062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca062
            #add-point:ON CHANGE xrca062 name="input.g.xrca062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca064
            #add-point:BEFORE FIELD xrca064 name="input.b.xrca064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca064
            
            #add-point:AFTER FIELD xrca064 name="input.a.xrca064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca064
            #add-point:ON CHANGE xrca064 name="input.g.xrca064"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca106
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xrca_m.xrca106,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xrca106
            END IF 
 
 
 
            #add-point:AFTER FIELD xrca106 name="input.a.xrca106"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca106
            #add-point:BEFORE FIELD xrca106 name="input.b.xrca106"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca106
            #add-point:ON CHANGE xrca106 name="input.g.xrca106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca116
            #add-point:BEFORE FIELD xrca116 name="input.b.xrca116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca116
            
            #add-point:AFTER FIELD xrca116 name="input.a.xrca116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca116
            #add-point:ON CHANGE xrca116 name="input.g.xrca116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca126
            #add-point:BEFORE FIELD xrca126 name="input.b.xrca126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca126
            
            #add-point:AFTER FIELD xrca126 name="input.a.xrca126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca126
            #add-point:ON CHANGE xrca126 name="input.g.xrca126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca136
            #add-point:BEFORE FIELD xrca136 name="input.b.xrca136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca136
            
            #add-point:AFTER FIELD xrca136 name="input.a.xrca136"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca136
            #add-point:ON CHANGE xrca136 name="input.g.xrca136"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcacomp
            
            #add-point:AFTER FIELD xrcacomp name="input.a.xrcacomp"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcacomp
            #add-point:BEFORE FIELD xrcacomp name="input.b.xrcacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcacomp
            #add-point:ON CHANGE xrcacomp name="input.g.xrcacomp"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrcasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcasite
            #add-point:ON ACTION controlp INFIELD xrcasite name="input.c.xrcasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca003
            #add-point:ON ACTION controlp INFIELD xrca003 name="input.c.xrca003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="input.c.xrcald"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca001
            #add-point:ON ACTION controlp INFIELD xrca001 name="input.c.xrca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocdt
            #add-point:ON ACTION controlp INFIELD xrcadocdt name="input.c.xrcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca004
            #add-point:ON ACTION controlp INFIELD xrca004 name="input.c.xrca004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca005
            #add-point:ON ACTION controlp INFIELD xrca005 name="input.c.xrca005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca038
            #add-point:ON ACTION controlp INFIELD xrca038 name="input.c.xrca038"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcastus
            #add-point:ON ACTION controlp INFIELD xrcastus name="input.c.xrcastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca007
            #add-point:ON ACTION controlp INFIELD xrca007 name="input.c.xrca007"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca035
            #add-point:ON ACTION controlp INFIELD xrca035 name="input.c.xrca035"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca036
            #add-point:ON ACTION controlp INFIELD xrca036 name="input.c.xrca036"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca059
            #add-point:ON ACTION controlp INFIELD xrca059 name="input.c.xrca059"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca100
            #add-point:ON ACTION controlp INFIELD xrca100 name="input.c.xrca100"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca103
            #add-point:ON ACTION controlp INFIELD xrca103 name="input.c.xrca103"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca104
            #add-point:ON ACTION controlp INFIELD xrca104 name="input.c.xrca104"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca107
            #add-point:ON ACTION controlp INFIELD xrca107 name="input.c.xrca107"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca108
            #add-point:ON ACTION controlp INFIELD xrca108 name="input.c.xrca108"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc109
            #add-point:ON ACTION controlp INFIELD xrcc109 name="input.c.xrcc109"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_calc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_calc
            #add-point:ON ACTION controlp INFIELD lbl_calc name="input.c.lbl_calc"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="input.c.glaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca101
            #add-point:ON ACTION controlp INFIELD xrca101 name="input.c.xrca101"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca113
            #add-point:ON ACTION controlp INFIELD xrca113 name="input.c.xrca113"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca114
            #add-point:ON ACTION controlp INFIELD xrca114 name="input.c.xrca114"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca117
            #add-point:ON ACTION controlp INFIELD xrca117 name="input.c.xrca117"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc113
            #add-point:ON ACTION controlp INFIELD xrcc113 name="input.c.xrcc113"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca118
            #add-point:ON ACTION controlp INFIELD xrca118 name="input.c.xrca118"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc119
            #add-point:ON ACTION controlp INFIELD xrcc119 name="input.c.xrcc119"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_calc2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_calc2
            #add-point:ON ACTION controlp INFIELD lbl_calc2 name="input.c.lbl_calc2"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca014
            #add-point:ON ACTION controlp INFIELD xrca014 name="input.c.xrca014"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca034
            #add-point:ON ACTION controlp INFIELD xrca034 name="input.c.xrca034"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca015
            #add-point:ON ACTION controlp INFIELD xrca015 name="input.c.xrca015"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca033
            #add-point:ON ACTION controlp INFIELD xrca033 name="input.c.xrca033"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca060
            #add-point:ON ACTION controlp INFIELD xrca060 name="input.c.xrca060"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca011
            #add-point:ON ACTION controlp INFIELD xrca011 name="input.c.xrca011"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca013
            #add-point:ON ACTION controlp INFIELD xrca013 name="input.c.xrca013"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca012
            #add-point:ON ACTION controlp INFIELD xrca012 name="input.c.xrca012"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca016
            #add-point:ON ACTION controlp INFIELD xrca016 name="input.c.xrca016"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca018
            #add-point:ON ACTION controlp INFIELD xrca018 name="input.c.xrca018"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca053
            #add-point:ON ACTION controlp INFIELD xrca053 name="input.c.xrca053"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca017
            #add-point:ON ACTION controlp INFIELD xrca017 name="input.c.xrca017"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca052
            #add-point:ON ACTION controlp INFIELD xrca052 name="input.c.xrca052"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca050
            #add-point:ON ACTION controlp INFIELD xrca050 name="input.c.xrca050"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca063
            #add-point:ON ACTION controlp INFIELD xrca063 name="input.c.xrca063"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca051
            #add-point:ON ACTION controlp INFIELD xrca051 name="input.c.xrca051"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1002
            #add-point:ON ACTION controlp INFIELD xrca1002 name="input.c.xrca1002"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca1032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1032
            #add-point:ON ACTION controlp INFIELD xrca1032 name="input.c.xrca1032"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1042
            #add-point:ON ACTION controlp INFIELD xrca1042 name="input.c.xrca1042"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1072
            #add-point:ON ACTION controlp INFIELD xrca1072 name="input.c.xrca1072"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1082
            #add-point:ON ACTION controlp INFIELD xrca1082 name="input.c.xrca1082"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc1092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc1092
            #add-point:ON ACTION controlp INFIELD xrcc1092 name="input.c.xrcc1092"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_calc_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_calc_2
            #add-point:ON ACTION controlp INFIELD lbl_calc_2 name="input.c.lbl_calc_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa0012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa0012
            #add-point:ON ACTION controlp INFIELD glaa0012 name="input.c.glaa0012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrca_m.glaa0012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooai001()                                #呼叫開窗

            LET g_xrca_m.glaa0012 = g_qryparam.return1              

            DISPLAY g_xrca_m.glaa0012 TO glaa0012              #

            NEXT FIELD glaa0012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrca1012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1012
            #add-point:ON ACTION controlp INFIELD xrca1012 name="input.c.xrca1012"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca120
            #add-point:ON ACTION controlp INFIELD xrca120 name="input.c.xrca120"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca121
            #add-point:ON ACTION controlp INFIELD xrca121 name="input.c.xrca121"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca130
            #add-point:ON ACTION controlp INFIELD xrca130 name="input.c.xrca130"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca131
            #add-point:ON ACTION controlp INFIELD xrca131 name="input.c.xrca131"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1132
            #add-point:ON ACTION controlp INFIELD xrca1132 name="input.c.xrca1132"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca123
            #add-point:ON ACTION controlp INFIELD xrca123 name="input.c.xrca123"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca133
            #add-point:ON ACTION controlp INFIELD xrca133 name="input.c.xrca133"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1142
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1142
            #add-point:ON ACTION controlp INFIELD xrca1142 name="input.c.xrca1142"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca124
            #add-point:ON ACTION controlp INFIELD xrca124 name="input.c.xrca124"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca134
            #add-point:ON ACTION controlp INFIELD xrca134 name="input.c.xrca134"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1172
            #add-point:ON ACTION controlp INFIELD xrca1172 name="input.c.xrca1172"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca127
            #add-point:ON ACTION controlp INFIELD xrca127 name="input.c.xrca127"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca137
            #add-point:ON ACTION controlp INFIELD xrca137 name="input.c.xrca137"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc1132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc1132
            #add-point:ON ACTION controlp INFIELD xrcc1132 name="input.c.xrcc1132"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc123
            #add-point:ON ACTION controlp INFIELD xrcc123 name="input.c.xrcc123"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc133
            #add-point:ON ACTION controlp INFIELD xrcc133 name="input.c.xrcc133"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca1182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca1182
            #add-point:ON ACTION controlp INFIELD xrca1182 name="input.c.xrca1182"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca128
            #add-point:ON ACTION controlp INFIELD xrca128 name="input.c.xrca128"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca138
            #add-point:ON ACTION controlp INFIELD xrca138 name="input.c.xrca138"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc1192
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc1192
            #add-point:ON ACTION controlp INFIELD xrcc1192 name="input.c.xrcc1192"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc129
            #add-point:ON ACTION controlp INFIELD xrcc129 name="input.c.xrcc129"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcc139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcc139
            #add-point:ON ACTION controlp INFIELD xrcc139 name="input.c.xrcc139"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_calc2_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_calc2_2
            #add-point:ON ACTION controlp INFIELD lbl_calc2_2 name="input.c.lbl_calc2_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_calc3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_calc3
            #add-point:ON ACTION controlp INFIELD lbl_calc3 name="input.c.lbl_calc3"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_calc4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_calc4
            #add-point:ON ACTION controlp INFIELD lbl_calc4 name="input.c.lbl_calc4"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca006
            #add-point:ON ACTION controlp INFIELD xrca006 name="input.c.xrca006"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca008
            #add-point:ON ACTION controlp INFIELD xrca008 name="input.c.xrca008"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca009
            #add-point:ON ACTION controlp INFIELD xrca009 name="input.c.xrca009"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca010
            #add-point:ON ACTION controlp INFIELD xrca010 name="input.c.xrca010"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca019
            #add-point:ON ACTION controlp INFIELD xrca019 name="input.c.xrca019"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca023
            #add-point:ON ACTION controlp INFIELD xrca023 name="input.c.xrca023"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca024
            #add-point:ON ACTION controlp INFIELD xrca024 name="input.c.xrca024"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca058
            #add-point:ON ACTION controlp INFIELD xrca058 name="input.c.xrca058"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca046
            #add-point:ON ACTION controlp INFIELD xrca046 name="input.c.xrca046"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca047
            #add-point:ON ACTION controlp INFIELD xrca047 name="input.c.xrca047"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca048
            #add-point:ON ACTION controlp INFIELD xrca048 name="input.c.xrca048"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca025
            #add-point:ON ACTION controlp INFIELD xrca025 name="input.c.xrca025"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca026
            #add-point:ON ACTION controlp INFIELD xrca026 name="input.c.xrca026"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca028
            #add-point:ON ACTION controlp INFIELD xrca028 name="input.c.xrca028"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca029
            #add-point:ON ACTION controlp INFIELD xrca029 name="input.c.xrca029"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca030
            #add-point:ON ACTION controlp INFIELD xrca030 name="input.c.xrca030"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca031
            #add-point:ON ACTION controlp INFIELD xrca031 name="input.c.xrca031"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca032
            #add-point:ON ACTION controlp INFIELD xrca032 name="input.c.xrca032"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca021
            #add-point:ON ACTION controlp INFIELD xrca021 name="input.c.xrca021"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca020
            #add-point:ON ACTION controlp INFIELD xrca020 name="input.c.xrca020"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca022
            #add-point:ON ACTION controlp INFIELD xrca022 name="input.c.xrca022"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca065
            #add-point:ON ACTION controlp INFIELD xrca065 name="input.c.xrca065"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca066
            #add-point:ON ACTION controlp INFIELD xrca066 name="input.c.xrca066"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca037
            #add-point:ON ACTION controlp INFIELD xrca037 name="input.c.xrca037"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca039
            #add-point:ON ACTION controlp INFIELD xrca039 name="input.c.xrca039"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca040
            #add-point:ON ACTION controlp INFIELD xrca040 name="input.c.xrca040"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca041
            #add-point:ON ACTION controlp INFIELD xrca041 name="input.c.xrca041"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca042
            #add-point:ON ACTION controlp INFIELD xrca042 name="input.c.xrca042"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca043
            #add-point:ON ACTION controlp INFIELD xrca043 name="input.c.xrca043"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca044
            #add-point:ON ACTION controlp INFIELD xrca044 name="input.c.xrca044"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca045
            #add-point:ON ACTION controlp INFIELD xrca045 name="input.c.xrca045"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca049
            #add-point:ON ACTION controlp INFIELD xrca049 name="input.c.xrca049"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca054
            #add-point:ON ACTION controlp INFIELD xrca054 name="input.c.xrca054"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca055
            #add-point:ON ACTION controlp INFIELD xrca055 name="input.c.xrca055"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca056
            #add-point:ON ACTION controlp INFIELD xrca056 name="input.c.xrca056"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca057
            #add-point:ON ACTION controlp INFIELD xrca057 name="input.c.xrca057"
 
            #END add-point
 
 
         #Ctrlp:input.c.xrca061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca061
            #add-point:ON ACTION controlp INFIELD xrca061 name="input.c.xrca061"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca062
            #add-point:ON ACTION controlp INFIELD xrca062 name="input.c.xrca062"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca064
            #add-point:ON ACTION controlp INFIELD xrca064 name="input.c.xrca064"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca106
            #add-point:ON ACTION controlp INFIELD xrca106 name="input.c.xrca106"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca116
            #add-point:ON ACTION controlp INFIELD xrca116 name="input.c.xrca116"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca126
            #add-point:ON ACTION controlp INFIELD xrca126 name="input.c.xrca126"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrca136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca136
            #add-point:ON ACTION controlp INFIELD xrca136 name="input.c.xrca136"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcacomp
            #add-point:ON ACTION controlp INFIELD xrcacomp name="input.c.xrcacomp"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM xrca_t
                WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald
                  AND xrcadocno = g_xrca_m.xrcadocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO xrca_t (xrcaent,xrcasite,xrca003,xrcald,xrcadocno,xrca001,xrcadocdt,xrca004, 
                      xrca005,xrca038,xrcastus,xrca007,xrca035,xrca036,xrca059,xrca100,xrca103,xrca104, 
                      xrca107,xrca108,xrca101,xrca113,xrca114,xrca117,xrca118,xrca014,xrca034,xrca015, 
                      xrca033,xrca060,xrca011,xrca013,xrca012,xrca016,xrca018,xrca053,xrca017,xrca052, 
                      xrca050,xrca063,xrca051,xrca120,xrca121,xrca130,xrca131,xrca123,xrca133,xrca124, 
                      xrca134,xrca127,xrca137,xrca128,xrca138,xrca006,xrca008,xrca009,xrca010,xrca019, 
                      xrca023,xrca024,xrca058,xrca046,xrca047,xrca048,xrca025,xrca026,xrca028,xrca029, 
                      xrca030,xrca031,xrca032,xrca021,xrca020,xrca022,xrca065,xrca066,xrca037,xrca039, 
                      xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca049,xrca054,xrca055,xrca056, 
                      xrca057,xrca061,xrca062,xrca064,xrca106,xrca116,xrca126,xrca136,xrcacomp,xrcaownid, 
                      xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt, 
                      xrcapstid,xrcapstdt)
                  VALUES (g_enterprise,g_xrca_m.xrcasite,g_xrca_m.xrca003,g_xrca_m.xrcald,g_xrca_m.xrcadocno, 
                      g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005,g_xrca_m.xrca038, 
                      g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059, 
                      g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108, 
                      g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118, 
                      g_xrca_m.xrca014,g_xrca_m.xrca034,g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060, 
                      g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016,g_xrca_m.xrca018, 
                      g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050,g_xrca_m.xrca063, 
                      g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131, 
                      g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127, 
                      g_xrca_m.xrca137,g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008, 
                      g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024, 
                      g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025, 
                      g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031, 
                      g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065, 
                      g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041, 
                      g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049, 
                      g_xrca_m.xrca054,g_xrca_m.xrca055,g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061, 
                      g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126, 
                      g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp,g_xrca_m.xrcacrtid, 
                      g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt,g_xrca_m.xrcacnfid, 
                      g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrca_m.xrcald
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrq510_xrca_t_mask_restore('restore_mask_o')
               
               UPDATE xrca_t SET (xrcasite,xrca003,xrcald,xrcadocno,xrca001,xrcadocdt,xrca004,xrca005, 
                   xrca038,xrcastus,xrca007,xrca035,xrca036,xrca059,xrca100,xrca103,xrca104,xrca107, 
                   xrca108,xrca101,xrca113,xrca114,xrca117,xrca118,xrca014,xrca034,xrca015,xrca033,xrca060, 
                   xrca011,xrca013,xrca012,xrca016,xrca018,xrca053,xrca017,xrca052,xrca050,xrca063,xrca051, 
                   xrca120,xrca121,xrca130,xrca131,xrca123,xrca133,xrca124,xrca134,xrca127,xrca137,xrca128, 
                   xrca138,xrca006,xrca008,xrca009,xrca010,xrca019,xrca023,xrca024,xrca058,xrca046,xrca047, 
                   xrca048,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,xrca021,xrca020,xrca022, 
                   xrca065,xrca066,xrca037,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca049, 
                   xrca054,xrca055,xrca056,xrca057,xrca061,xrca062,xrca064,xrca106,xrca116,xrca126,xrca136, 
                   xrcacomp,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid, 
                   xrcacnfdt,xrcapstid,xrcapstdt) = (g_xrca_m.xrcasite,g_xrca_m.xrca003,g_xrca_m.xrcald, 
                   g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005, 
                   g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036, 
                   g_xrca_m.xrca059,g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107, 
                   g_xrca_m.xrca108,g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117, 
                   g_xrca_m.xrca118,g_xrca_m.xrca014,g_xrca_m.xrca034,g_xrca_m.xrca015,g_xrca_m.xrca033, 
                   g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016, 
                   g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050, 
                   g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130, 
                   g_xrca_m.xrca131,g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134, 
                   g_xrca_m.xrca127,g_xrca_m.xrca137,g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006, 
                   g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca019,g_xrca_m.xrca023, 
                   g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047,g_xrca_m.xrca048, 
                   g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030, 
                   g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022, 
                   g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040, 
                   g_xrca_m.xrca041,g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045, 
                   g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055,g_xrca_m.xrca056,g_xrca_m.xrca057, 
                   g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106,g_xrca_m.xrca116, 
                   g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp, 
                   g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt, 
                   g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt)
                WHERE xrcaent = g_enterprise AND xrcald = g_xrcald_t #
                  AND xrcadocno = g_xrcadocno_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrca_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL axrq510_xrca_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_xrca_m_t)
                     LET g_log2 = util.JSON.stringify(g_xrca_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axrq510_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xrca_t.xrcald 
   DEFINE l_oldno     LIKE xrca_t.xrcald 
   DEFINE l_newno02     LIKE xrca_t.xrcadocno 
   DEFINE l_oldno02     LIKE xrca_t.xrcadocno 
 
   DEFINE l_master    RECORD LIKE xrca_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_xrca_m.xrcald IS NULL
      OR g_xrca_m.xrcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_xrcald_t = g_xrca_m.xrcald
   LET g_xrcadocno_t = g_xrca_m.xrcadocno
 
   
   #清空key值
   LET g_xrca_m.xrcald = ""
   LET g_xrca_m.xrcadocno = ""
 
    
   CALL axrq510_set_entry("a")
   CALL axrq510_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrca_m.xrcaownid = g_user
      LET g_xrca_m.xrcaowndp = g_dept
      LET g_xrca_m.xrcacrtid = g_user
      LET g_xrca_m.xrcacrtdp = g_dept 
      LET g_xrca_m.xrcacrtdt = cl_get_current()
      LET g_xrca_m.xrcamodid = g_user
      LET g_xrca_m.xrcamoddt = cl_get_current()
      LET g_xrca_m.xrcastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrca_m.xrcastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xrca_m.xrcald_desc = ''
   DISPLAY BY NAME g_xrca_m.xrcald_desc
   LET g_xrca_m.xrcadocno_desc = ''
   DISPLAY BY NAME g_xrca_m.xrcadocno_desc
 
   
   #資料輸入
   CALL axrq510_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_xrca_m.* TO NULL
      CALL axrq510_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xrca_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL axrq510_set_act_visible()
   CALL axrq510_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xrcald_t = g_xrca_m.xrcald
   LET g_xrcadocno_t = g_xrca_m.xrcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrcaent = " ||g_enterprise|| " AND",
                      " xrcald = '", g_xrca_m.xrcald, "' "
                      ," AND xrcadocno = '", g_xrca_m.xrcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrq510_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_xrca_m.xrcaownid      
   LET g_data_dept  = g_xrca_m.xrcaowndp
              
   #功能已完成,通報訊息中心
   CALL axrq510_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.show" >}
#+ 資料顯示 
PRIVATE FUNCTION axrq510_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_slip            LIKE xrca_t.xrcadocno
   DEFINE l_oodb005         LIKE oodb_t.oodb005
   DEFINE l_oodb006         LIKE oodb_t.oodb006
   DEFINE l_oodb011         LIKE oodb_t.oodb011
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
 
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axrq510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #161215-00044#2---modify----begin-----------------
   #SELECT * INTO g_glaa.* 
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161215-00044#2---modify----end----------------- 
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald

   CALL s_aooi200_fin_get_slip(g_xrca_m.xrcadocno) RETURNING l_success,l_slip

   CALL s_aooi200_fin_get_slip_desc(l_slip) RETURNING g_xrca_m.xrcadocno_desc

   CALL s_tax_chk(g_glaa.glaacomp,g_xrca_m.xrca011)
      RETURNING l_success,g_xrca_m.xrca011_desc,l_oodb005,l_oodb006,l_oodb011

   CALL s_axrt300_xrca_ref('xrca035',g_xrca_m.xrca035,g_glaa.glaa004,'') RETURNING l_success,g_xrca_m.xrca035_desc

   LET g_xrca_m.glaa001 = g_glaa.glaa001

   SELECT xrcc109,xrcc119,xrcc129,xrcc139,xrcc113,xrcc123,xrcc133
     INTO g_xrca_m.xrcc109,g_xrca_m.xrcc119,g_xrca_m.xrcc129,g_xrca_m.xrcc139,
                           g_xrca_m.xrcc113,g_xrca_m.xrcc123,g_xrca_m.xrcc133
     FROM xrcc_t WHERE xrccent = g_enterprise
      AND xrccdocno = g_xrca_m.xrcadocno
      AND xrccld = g_xrca_m.xrcald

   LET g_xrca_m.xrca118 = g_xrca_m.xrca118 + g_xrca_m.xrcc113
   LET g_xrca_m.xrca128 = g_xrca_m.xrca128 + g_xrca_m.xrcc123
   LET g_xrca_m.xrca138 = g_xrca_m.xrca138 + g_xrca_m.xrcc133

   LET g_xrca_m.lbl_calc = g_xrca_m.xrca108 - g_xrca_m.xrcc109
   LET g_xrca_m.lbl_calc2= g_xrca_m.xrca118 - g_xrca_m.xrcc119
   LET g_xrca_m.lbl_calc3= g_xrca_m.xrca128 - g_xrca_m.xrcc129
   LET g_xrca_m.lbl_calc4= g_xrca_m.xrca138 - g_xrca_m.xrcc139

   LET g_xrca_m.xrca1002   = g_xrca_m.xrca100
   LET g_xrca_m.xrca1032   = g_xrca_m.xrca103
   LET g_xrca_m.xrca1042   = g_xrca_m.xrca104
   LET g_xrca_m.xrca1072   = g_xrca_m.xrca107
   LET g_xrca_m.xrca1082   = g_xrca_m.xrca108
   LET g_xrca_m.xrcc1092   = g_xrca_m.xrcc109
   LET g_xrca_m.lbl_calc_2 = g_xrca_m.lbl_calc

   LET g_xrca_m.glaa0012   = g_xrca_m.glaa001
   LET g_xrca_m.xrca1132   = g_xrca_m.xrca113
   LET g_xrca_m.xrca1142   = g_xrca_m.xrca114
   LET g_xrca_m.xrca1172   = g_xrca_m.xrca117
   LET g_xrca_m.xrcc1132   = g_xrca_m.xrcc113
   LET g_xrca_m.xrca1182   = g_xrca_m.xrca118
   LET g_xrca_m.xrcc1192   = g_xrca_m.xrcc119
   LET g_xrca_m.lbl_calc2_2= g_xrca_m.lbl_calc2

   SELECT xrca038 INTO g_xrca_m.xrca038 FROM xrca_t WHERE xrcadocno = g_xrca_m.xrca018 AND xrcaent = g_enterprise

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrca003,g_xrca_m.xrca003_desc,g_xrca_m.xrcald, 
       g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocno_desc,g_xrca_m.xrcadocdt, 
       g_xrca_m.xrca004,g_xrca_m.xrca004_desc,g_xrca_m.xrca005,g_xrca_m.xrca005_desc,g_xrca_m.xrca038, 
       g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca007_desc,g_xrca_m.xrca035,g_xrca_m.xrca035_desc, 
       g_xrca_m.xrca036,g_xrca_m.xrca036_desc,g_xrca_m.xrca059,g_xrca_m.xrca059_desc,g_xrca_m.xrca100, 
       g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrcc109,g_xrca_m.lbl_calc, 
       g_xrca_m.glaa001,g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrcc113, 
       g_xrca_m.xrca118,g_xrca_m.xrcc119,g_xrca_m.lbl_calc2,g_xrca_m.xrca014,g_xrca_m.xrca014_desc,g_xrca_m.xrca034, 
       g_xrca_m.xrca034_desc,g_xrca_m.xrca015,g_xrca_m.xrca015_desc,g_xrca_m.xrca033,g_xrca_m.xrca033_desc, 
       g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca011_desc,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016, 
       g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050,g_xrca_m.xrca063, 
       g_xrca_m.xrca051,g_xrca_m.xrca051_desc,g_xrca_m.xrca1002,g_xrca_m.xrca1032,g_xrca_m.xrca1042, 
       g_xrca_m.xrca1072,g_xrca_m.xrca1082,g_xrca_m.xrcc1092,g_xrca_m.lbl_calc_2,g_xrca_m.glaa0012,g_xrca_m.xrca1012, 
       g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131,g_xrca_m.xrca1132,g_xrca_m.xrca123, 
       g_xrca_m.xrca133,g_xrca_m.xrca1142,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca1172,g_xrca_m.xrca127, 
       g_xrca_m.xrca137,g_xrca_m.xrcc1132,g_xrca_m.xrcc123,g_xrca_m.xrcc133,g_xrca_m.xrca1182,g_xrca_m.xrca128, 
       g_xrca_m.xrca138,g_xrca_m.xrcc1192,g_xrca_m.xrcc129,g_xrca_m.xrcc139,g_xrca_m.lbl_calc2_2,g_xrca_m.lbl_calc3, 
       g_xrca_m.lbl_calc4,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca008_desc, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca058_desc,g_xrca_m.xrca046, 
       g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca028_desc, 
       g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020, 
       g_xrca_m.xrca022,g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040, 
       g_xrca_m.xrca041,g_xrca_m.xrca041_desc,g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045, 
       g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca054_desc,g_xrca_m.xrca055,g_xrca_m.xrca055_desc, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca057_desc,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064, 
       g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc, 
       g_xrca_m.xrcaownid,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid, 
       g_xrca_m.xrcacrtid_desc,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid, 
       g_xrca_m.xrcamodid_desc,g_xrca_m.xrcamoddt,g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcacnfdt, 
       g_xrca_m.xrcapstid,g_xrca_m.xrcapstid_desc,g_xrca_m.xrcapstdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL axrq510_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrca_m.xrcastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
    IF g_glaa.glaa015 = 'N' AND g_glaa.glaa019 = 'N' THEN
       CALL cl_set_comp_visible('axrq510_pg3',FALSE)
       RETURN
    END IF

      CALL cl_set_comp_visible('xrca120,xrca121,xrca123,xrca124,xrca127,xrcc123,xrca128,xrcc129,lbl_calc3',TRUE)
      CALL cl_set_comp_visible('xrca130,xrca131,xrca133,xrca134,xrca137,xrcc133,xrca138,xrcc139,lbl_calc4',TRUE)
    IF g_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('xrca120,xrca121,xrca123,xrca124,xrca127,xrcc123,xrca128,xrcc129,lbl_calc3',FALSE)
    END IF

    IF g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('xrca130,xrca131,xrca133,xrca134,xrca137,xrcc133,xrca138,xrcc139,lbl_calc4',FALSE)
    END IF

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION axrq510_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_xrca_m.xrcald IS NULL
   OR g_xrca_m.xrcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_xrcald_t = g_xrca_m.xrcald
   LET g_xrcadocno_t = g_xrca_m.xrcadocno
 
   
   
 
   OPEN axrq510_cl USING g_enterprise,g_xrca_m.xrcald,g_xrca_m.xrcadocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrq510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE axrq510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrq510_master_referesh USING g_xrca_m.xrcald,g_xrca_m.xrcadocno INTO g_xrca_m.xrcasite,g_xrca_m.xrca003, 
       g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005, 
       g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059, 
       g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrca101, 
       g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118,g_xrca_m.xrca014,g_xrca_m.xrca034, 
       g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012, 
       g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050, 
       g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131, 
       g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127,g_xrca_m.xrca137, 
       g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047, 
       g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030, 
       g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065, 
       g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca042, 
       g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106, 
       g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp, 
       g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt, 
       g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt,g_xrca_m.xrcasite_desc, 
       g_xrca_m.xrca003_desc,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno_desc,g_xrca_m.xrca004_desc,g_xrca_m.xrca005_desc, 
       g_xrca_m.xrca007_desc,g_xrca_m.xrca059_desc,g_xrca_m.xrca014_desc,g_xrca_m.xrca034_desc,g_xrca_m.xrca015_desc, 
       g_xrca_m.xrca033_desc,g_xrca_m.xrca011_desc,g_xrca_m.xrca051_desc,g_xrca_m.xrca008_desc,g_xrca_m.xrca058_desc, 
       g_xrca_m.xrca028_desc,g_xrca_m.xrca041_desc,g_xrca_m.xrca054_desc,g_xrca_m.xrca055_desc,g_xrca_m.xrca057_desc, 
       g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid_desc, 
       g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcamodid_desc,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcapstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT axrq510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrca_m_mask_o.* =  g_xrca_m.*
   CALL axrq510_xrca_t_mask()
   LET g_xrca_m_mask_n.* =  g_xrca_m.*
   
   #將最新資料顯示到畫面上
   CALL axrq510_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrq510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM xrca_t 
       WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald 
         AND xrcadocno = g_xrca_m.xrcadocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xrca_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE axrq510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL axrq510_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL axrq510_browser_fill(g_wc,"")
         CALL axrq510_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axrq510_cl
 
   #功能已完成,通報訊息中心
   CALL axrq510_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axrq510_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xrcald = g_xrca_m.xrcald
         AND g_browser[l_i].b_xrcadocno = g_xrca_m.xrcadocno
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="axrq510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axrq510_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("xrcald,xrcadocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axrq510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xrcald,xrcadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axrq510_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrq510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axrq510_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrq510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrq510_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xrcald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xrcadocno = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq510.mask_functions" >}
&include "erp/axr/axrq510_mask.4gl"
 
{</section>}
 
{<section id="axrq510.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axrq510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   RETURN
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrca_m.xrcald IS NULL
      OR g_xrca_m.xrcadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axrq510_cl USING g_enterprise,g_xrca_m.xrcald,g_xrca_m.xrcadocno
   IF STATUS THEN
      CLOSE axrq510_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrq510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axrq510_master_referesh USING g_xrca_m.xrcald,g_xrca_m.xrcadocno INTO g_xrca_m.xrcasite,g_xrca_m.xrca003, 
       g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca005, 
       g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036,g_xrca_m.xrca059, 
       g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrca101, 
       g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118,g_xrca_m.xrca014,g_xrca_m.xrca034, 
       g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013,g_xrca_m.xrca012, 
       g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050, 
       g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131, 
       g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127,g_xrca_m.xrca137, 
       g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046,g_xrca_m.xrca047, 
       g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029,g_xrca_m.xrca030, 
       g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065, 
       g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca042, 
       g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca055, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106, 
       g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid,g_xrca_m.xrcaowndp, 
       g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt, 
       g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt,g_xrca_m.xrcasite_desc, 
       g_xrca_m.xrca003_desc,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno_desc,g_xrca_m.xrca004_desc,g_xrca_m.xrca005_desc, 
       g_xrca_m.xrca007_desc,g_xrca_m.xrca059_desc,g_xrca_m.xrca014_desc,g_xrca_m.xrca034_desc,g_xrca_m.xrca015_desc, 
       g_xrca_m.xrca033_desc,g_xrca_m.xrca011_desc,g_xrca_m.xrca051_desc,g_xrca_m.xrca008_desc,g_xrca_m.xrca058_desc, 
       g_xrca_m.xrca028_desc,g_xrca_m.xrca041_desc,g_xrca_m.xrca054_desc,g_xrca_m.xrca055_desc,g_xrca_m.xrca057_desc, 
       g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid_desc, 
       g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcamodid_desc,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcapstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT axrq510_action_chk() THEN
      CLOSE axrq510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrca003,g_xrca_m.xrca003_desc,g_xrca_m.xrcald, 
       g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocno_desc,g_xrca_m.xrcadocdt, 
       g_xrca_m.xrca004,g_xrca_m.xrca004_desc,g_xrca_m.xrca005,g_xrca_m.xrca005_desc,g_xrca_m.xrca038, 
       g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca007_desc,g_xrca_m.xrca035,g_xrca_m.xrca035_desc, 
       g_xrca_m.xrca036,g_xrca_m.xrca036_desc,g_xrca_m.xrca059,g_xrca_m.xrca059_desc,g_xrca_m.xrca100, 
       g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrcc109,g_xrca_m.lbl_calc, 
       g_xrca_m.glaa001,g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrcc113, 
       g_xrca_m.xrca118,g_xrca_m.xrcc119,g_xrca_m.lbl_calc2,g_xrca_m.xrca014,g_xrca_m.xrca014_desc,g_xrca_m.xrca034, 
       g_xrca_m.xrca034_desc,g_xrca_m.xrca015,g_xrca_m.xrca015_desc,g_xrca_m.xrca033,g_xrca_m.xrca033_desc, 
       g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca011_desc,g_xrca_m.xrca013,g_xrca_m.xrca012,g_xrca_m.xrca016, 
       g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052,g_xrca_m.xrca050,g_xrca_m.xrca063, 
       g_xrca_m.xrca051,g_xrca_m.xrca051_desc,g_xrca_m.xrca1002,g_xrca_m.xrca1032,g_xrca_m.xrca1042, 
       g_xrca_m.xrca1072,g_xrca_m.xrca1082,g_xrca_m.xrcc1092,g_xrca_m.lbl_calc_2,g_xrca_m.glaa0012,g_xrca_m.xrca1012, 
       g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130,g_xrca_m.xrca131,g_xrca_m.xrca1132,g_xrca_m.xrca123, 
       g_xrca_m.xrca133,g_xrca_m.xrca1142,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca1172,g_xrca_m.xrca127, 
       g_xrca_m.xrca137,g_xrca_m.xrcc1132,g_xrca_m.xrcc123,g_xrca_m.xrcc133,g_xrca_m.xrca1182,g_xrca_m.xrca128, 
       g_xrca_m.xrca138,g_xrca_m.xrcc1192,g_xrca_m.xrcc129,g_xrca_m.xrcc139,g_xrca_m.lbl_calc2_2,g_xrca_m.lbl_calc3, 
       g_xrca_m.lbl_calc4,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca008_desc, 
       g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca058_desc,g_xrca_m.xrca046, 
       g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca028_desc, 
       g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020, 
       g_xrca_m.xrca022,g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040, 
       g_xrca_m.xrca041,g_xrca_m.xrca041_desc,g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045, 
       g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca054_desc,g_xrca_m.xrca055,g_xrca_m.xrca055_desc, 
       g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca057_desc,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064, 
       g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc, 
       g_xrca_m.xrcaownid,g_xrca_m.xrcaownid_desc,g_xrca_m.xrcaowndp,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid, 
       g_xrca_m.xrcacrtid_desc,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid, 
       g_xrca_m.xrcamodid_desc,g_xrca_m.xrcamoddt,g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcacnfdt, 
       g_xrca_m.xrcapstid,g_xrca_m.xrcapstid_desc,g_xrca_m.xrcapstdt
 
   CASE g_xrca_m.xrcastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xrca_m.xrcastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_xrca_m.xrcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE axrq510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_xrca_m.xrcamodid = g_user
   LET g_xrca_m.xrcamoddt = cl_get_current()
   LET g_xrca_m.xrcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrca_t 
      SET (xrcastus,xrcamodid,xrcamoddt) 
        = (g_xrca_m.xrcastus,g_xrca_m.xrcamodid,g_xrca_m.xrcamoddt)     
    WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald
      AND xrcadocno = g_xrca_m.xrcadocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axrq510_master_referesh USING g_xrca_m.xrcald,g_xrca_m.xrcadocno INTO g_xrca_m.xrcasite, 
          g_xrca_m.xrca003,g_xrca_m.xrcald,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocdt,g_xrca_m.xrca004, 
          g_xrca_m.xrca005,g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca035,g_xrca_m.xrca036, 
          g_xrca_m.xrca059,g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108, 
          g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117,g_xrca_m.xrca118,g_xrca_m.xrca014, 
          g_xrca_m.xrca034,g_xrca_m.xrca015,g_xrca_m.xrca033,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca013, 
          g_xrca_m.xrca012,g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052, 
          g_xrca_m.xrca050,g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca120,g_xrca_m.xrca121,g_xrca_m.xrca130, 
          g_xrca_m.xrca131,g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca127, 
          g_xrca_m.xrca137,g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009, 
          g_xrca_m.xrca010,g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca046, 
          g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028,g_xrca_m.xrca029, 
          g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032,g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022, 
          g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037,g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041, 
          g_xrca_m.xrca042,g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054, 
          g_xrca_m.xrca055,g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064, 
          g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126,g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcaownid, 
          g_xrca_m.xrcaowndp,g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtdp,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid, 
          g_xrca_m.xrcamoddt,g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstdt, 
          g_xrca_m.xrcasite_desc,g_xrca_m.xrca003_desc,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno_desc, 
          g_xrca_m.xrca004_desc,g_xrca_m.xrca005_desc,g_xrca_m.xrca007_desc,g_xrca_m.xrca059_desc,g_xrca_m.xrca014_desc, 
          g_xrca_m.xrca034_desc,g_xrca_m.xrca015_desc,g_xrca_m.xrca033_desc,g_xrca_m.xrca011_desc,g_xrca_m.xrca051_desc, 
          g_xrca_m.xrca008_desc,g_xrca_m.xrca058_desc,g_xrca_m.xrca028_desc,g_xrca_m.xrca041_desc,g_xrca_m.xrca054_desc, 
          g_xrca_m.xrca055_desc,g_xrca_m.xrca057_desc,g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid_desc, 
          g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid_desc,g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcamodid_desc, 
          g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrca003,g_xrca_m.xrca003_desc, 
          g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcadocno,g_xrca_m.xrca001,g_xrca_m.xrcadocno_desc, 
          g_xrca_m.xrcadocdt,g_xrca_m.xrca004,g_xrca_m.xrca004_desc,g_xrca_m.xrca005,g_xrca_m.xrca005_desc, 
          g_xrca_m.xrca038,g_xrca_m.xrcastus,g_xrca_m.xrca007,g_xrca_m.xrca007_desc,g_xrca_m.xrca035, 
          g_xrca_m.xrca035_desc,g_xrca_m.xrca036,g_xrca_m.xrca036_desc,g_xrca_m.xrca059,g_xrca_m.xrca059_desc, 
          g_xrca_m.xrca100,g_xrca_m.xrca103,g_xrca_m.xrca104,g_xrca_m.xrca107,g_xrca_m.xrca108,g_xrca_m.xrcc109, 
          g_xrca_m.lbl_calc,g_xrca_m.glaa001,g_xrca_m.xrca101,g_xrca_m.xrca113,g_xrca_m.xrca114,g_xrca_m.xrca117, 
          g_xrca_m.xrcc113,g_xrca_m.xrca118,g_xrca_m.xrcc119,g_xrca_m.lbl_calc2,g_xrca_m.xrca014,g_xrca_m.xrca014_desc, 
          g_xrca_m.xrca034,g_xrca_m.xrca034_desc,g_xrca_m.xrca015,g_xrca_m.xrca015_desc,g_xrca_m.xrca033, 
          g_xrca_m.xrca033_desc,g_xrca_m.xrca060,g_xrca_m.xrca011,g_xrca_m.xrca011_desc,g_xrca_m.xrca013, 
          g_xrca_m.xrca012,g_xrca_m.xrca016,g_xrca_m.xrca018,g_xrca_m.xrca053,g_xrca_m.xrca017,g_xrca_m.xrca052, 
          g_xrca_m.xrca050,g_xrca_m.xrca063,g_xrca_m.xrca051,g_xrca_m.xrca051_desc,g_xrca_m.xrca1002, 
          g_xrca_m.xrca1032,g_xrca_m.xrca1042,g_xrca_m.xrca1072,g_xrca_m.xrca1082,g_xrca_m.xrcc1092, 
          g_xrca_m.lbl_calc_2,g_xrca_m.glaa0012,g_xrca_m.xrca1012,g_xrca_m.xrca120,g_xrca_m.xrca121, 
          g_xrca_m.xrca130,g_xrca_m.xrca131,g_xrca_m.xrca1132,g_xrca_m.xrca123,g_xrca_m.xrca133,g_xrca_m.xrca1142, 
          g_xrca_m.xrca124,g_xrca_m.xrca134,g_xrca_m.xrca1172,g_xrca_m.xrca127,g_xrca_m.xrca137,g_xrca_m.xrcc1132, 
          g_xrca_m.xrcc123,g_xrca_m.xrcc133,g_xrca_m.xrca1182,g_xrca_m.xrca128,g_xrca_m.xrca138,g_xrca_m.xrcc1192, 
          g_xrca_m.xrcc129,g_xrca_m.xrcc139,g_xrca_m.lbl_calc2_2,g_xrca_m.lbl_calc3,g_xrca_m.lbl_calc4, 
          g_xrca_m.xrca006,g_xrca_m.xrca008,g_xrca_m.xrca009,g_xrca_m.xrca010,g_xrca_m.xrca008_desc, 
          g_xrca_m.xrca019,g_xrca_m.xrca023,g_xrca_m.xrca024,g_xrca_m.xrca058,g_xrca_m.xrca058_desc, 
          g_xrca_m.xrca046,g_xrca_m.xrca047,g_xrca_m.xrca048,g_xrca_m.xrca025,g_xrca_m.xrca026,g_xrca_m.xrca028, 
          g_xrca_m.xrca028_desc,g_xrca_m.xrca029,g_xrca_m.xrca030,g_xrca_m.xrca031,g_xrca_m.xrca032, 
          g_xrca_m.xrca021,g_xrca_m.xrca020,g_xrca_m.xrca022,g_xrca_m.xrca065,g_xrca_m.xrca066,g_xrca_m.xrca037, 
          g_xrca_m.xrca039,g_xrca_m.xrca040,g_xrca_m.xrca041,g_xrca_m.xrca041_desc,g_xrca_m.xrca042, 
          g_xrca_m.xrca043,g_xrca_m.xrca044,g_xrca_m.xrca045,g_xrca_m.xrca049,g_xrca_m.xrca054,g_xrca_m.xrca054_desc, 
          g_xrca_m.xrca055,g_xrca_m.xrca055_desc,g_xrca_m.xrca056,g_xrca_m.xrca057,g_xrca_m.xrca057_desc, 
          g_xrca_m.xrca061,g_xrca_m.xrca062,g_xrca_m.xrca064,g_xrca_m.xrca106,g_xrca_m.xrca116,g_xrca_m.xrca126, 
          g_xrca_m.xrca136,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc,g_xrca_m.xrcaownid,g_xrca_m.xrcaownid_desc, 
          g_xrca_m.xrcaowndp,g_xrca_m.xrcaowndp_desc,g_xrca_m.xrcacrtid,g_xrca_m.xrcacrtid_desc,g_xrca_m.xrcacrtdp, 
          g_xrca_m.xrcacrtdp_desc,g_xrca_m.xrcacrtdt,g_xrca_m.xrcamodid,g_xrca_m.xrcamodid_desc,g_xrca_m.xrcamoddt, 
          g_xrca_m.xrcacnfid,g_xrca_m.xrcacnfid_desc,g_xrca_m.xrcacnfdt,g_xrca_m.xrcapstid,g_xrca_m.xrcapstid_desc, 
          g_xrca_m.xrcapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axrq510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrq510_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrq510.signature" >}
   
 
{</section>}
 
{<section id="axrq510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrq510_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xrca_m.xrcald
   LET g_pk_array[1].column = 'xrcald'
   LET g_pk_array[2].values = g_xrca_m.xrcadocno
   LET g_pk_array[2].column = 'xrcadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrq510.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="axrq510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axrq510_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL axrq510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrq510.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axrq510_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrq510.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 串聯axrt310
# Memo...........:
# Usage..........: CALL axrq510_open_axrt310()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/02/05 By zhangwei
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq510_open_axrt310()
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING

   IF cl_null(g_xrca_m.xrcadocno) THEN RETURN END IF

   LET la_param.prog = "axrt350"
   LET la_param.param[1] = g_xrca_m.xrcald
   LET la_param.param[2] = g_xrca_m.xrca018
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun(ls_js)

END FUNCTION

################################################################################
# Descriptions...: 设置scc码
# Memo...........:
# Usage..........: CALL axrq510_set_scc()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/04/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq510_set_scc()
   DEFINE l_sql      STRING
   DEFINE l_str      STRING 
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002  
  
   #xrca016,xrcb001下拉菜單取值,SCC_8340 AND gzcb004='axrt350' OR gzcb005='axrt350'
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8340' AND (gzcb004 LIKE '%axrt350%' OR gzcb005 LIKE '%axrt350%')"
   PREPARE axrt350_xrcb001_prep FROM l_sql
   DECLARE axrt350_xrcb001_curs CURSOR FOR axrt350_xrcb001_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrt350_xrcb001_curs INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('xrca016','8340',l_str)
END FUNCTION

 
{</section>}
 
