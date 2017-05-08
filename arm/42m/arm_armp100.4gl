#該程式未解開Section, 採用最新樣板產出!
{<section id="armp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-12-05 16:26:29), PR版次:0007(2017-02-17 16:42:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: armp100
#+ Description: RMA轉工單作業
#+ Creator....: 02295(2015-05-22 09:37:33)
#+ Modifier...: 05423 -SD/PR- 01996
 
{</section>}
 
{<section id="armp100.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#4  2016/04/12 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160425-00022#1  2016/04/26 By xianghui    批次执行完之后订单单头的单身不可以更改只需要做显示
#160905-00007#13  20160905 by geza           sql加上ent条件
#160816-00066#4  2016/11/25 By zhujing     产生单据后提示已产生工单XXXXX~XXXXXXX，是否开启工单进行查看，选是开启工单串到相应单据
#161129-00054#1  2016/12/05 By zhujing     单身添加库位储位栏位说明
#161124-00048#10  2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#160711-00040#28  2017/02/16  By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                        CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
   slip LIKE ooba_t.ooba001,
   date LIKE sfaa_t.sfaadocdt,
   check LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel LIKE type_t.chr1,
     rmcbdocno LIKE rmcb_t.rmcbdocno,
     rmcbseq LIKE rmcb_t.rmcbseq,
     rmcb001 LIKE rmcb_t.rmcb001,
     rmcb002 LIKE rmcb_t.rmcb002,
     rmcb003 LIKE rmcb_t.rmcb003,
     rmcb004 LIKE rmcb_t.rmcb004,
     rmcb004_desc LIKE type_t.chr80,
     rmcb004_desc_1 LIKE type_t.chr80,
     rmcb005 LIKE rmcb_t.rmcb005,
     rmcb006 LIKE rmcb_t.rmcb006,
     rmcb006_desc LIKE type_t.chr80,
     rmcb007 LIKE rmcb_t.rmcb007,
     rmcb010 LIKE rmcb_t.rmcb010,
     qty LIKE rmcb_t.rmcb010
    END RECORD

TYPE type_g_detail2_d RECORD
     sfaa_no LIKE type_t.num5,
     sfaadocno LIKE sfaa_t.sfaadocno,
     sfaadocdt LIKE sfaa_t.sfaadocdt,
     sfaa002 LIKE sfaa_t.sfaa002,
     sfaa010 LIKE sfaa_t.sfaa010,
     sfaa012 LIKE sfaa_t.sfaa012,
     sfaa013 LIKE sfaa_t.sfaa013,
     sfaa061 LIKE sfaa_t.sfaa061,  
     sfaa016 LIKE sfaa_t.sfaa016,
     sfaa017 LIKE sfaa_t.sfaa017,
     sfaa018 LIKE sfaa_t.sfaa018,
     sfaa019 LIKE sfaa_t.sfaa019,
     sfaa020 LIKE sfaa_t.sfaa020
    END RECORD
    
TYPE type_g_detail3_d RECORD
     sfba_no LIKE type_t.num5,
     sfbaseq LIKE sfba_t.sfbaseq,
     sfbaseq1 LIKE sfba_t.sfbaseq1,
     sfba002 LIKE sfba_t.sfba002,
     sfba003 LIKE sfba_t.sfba003,
     sfba004 LIKE sfba_t.sfba004,
     sfba005 LIKE sfba_t.sfba005,
     sfba022 LIKE sfba_t.sfba022,
     sfba006 LIKE sfba_t.sfba006,
     sfba021 LIKE sfba_t.sfba021,
     sfba007 LIKE sfba_t.sfba007,
     sfba008 LIKE sfba_t.sfba008,
     sfba009 LIKE sfba_t.sfba009,
     sfba010 LIKE sfba_t.sfba010,
     sfba011 LIKE sfba_t.sfba011,
     sfba012 LIKE sfba_t.sfba012,
     sfba023 LIKE sfba_t.sfba023,
     sfba024 LIKE sfba_t.sfba024,
     sfba013 LIKE sfba_t.sfba013,
     sfba014 LIKE sfba_t.sfba014,
     sfba019 LIKE sfba_t.sfba019,
     sfba019_desc LIKE inayl_t.inayl003,     #161129-00054#1 add
     sfba020 LIKE sfba_t.sfba020,
     sfba020_desc LIKE inab_t.inab003        #161129-00054#1 add
    END RECORD

TYPE type_g_detail4_d RECORD
     sfabseq LIKE sfab_t.sfabseq,
     sfab002 LIKE sfab_t.sfab002,
     sfab003 LIKE sfab_t.sfab003,
     sfab004 LIKE sfab_t.sfab004,
     sfab005 LIKE sfab_t.sfab005,
     sfab006 LIKE sfab_t.sfab006,
     sfab007 LIKE sfab_t.sfab007
    END RECORD
    
TYPE type_g_detail5_d RECORD
     sfacseq LIKE sfac_t.sfacseq,
     sfac002 LIKE sfac_t.sfac002,
     sfac001 LIKE sfac_t.sfac001,
     sfac006 LIKE sfac_t.sfac006,
     sfac003 LIKE sfac_t.sfac003,
     sfac004 LIKE sfac_t.sfac004,
     sfac005 LIKE sfac_t.sfac005
    END RECORD
    
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail5_d  DYNAMIC ARRAY OF type_g_detail5_d
DEFINE g_master  type_parameter
DEFINE g_hidden LIKE type_t.num5
DEFINE g_exe    LIKE type_t.num5
DEFINE g_rec_b  LIKE type_t.num5
#DEFINE g_ooef   RECORD LIKE ooef_t.*  #161124-00048#10 mark
#161124-00048#10 add(s)
DEFINE g_ooef RECORD  #組織基本資料檔
       ooefent LIKE ooef_t.ooefent, #企业编号
       ooefstus LIKE ooef_t.ooefstus, #状态码
       ooef001 LIKE ooef_t.ooef001, #组织编号
       ooef002 LIKE ooef_t.ooef002, #税号
       ooef004 LIKE ooef_t.ooef004, #单据别参照表号
       ooef005 LIKE ooef_t.ooef005, #单据据点编号
       ooef006 LIKE ooef_t.ooef006, #所属国家地区
       ooef007 LIKE ooef_t.ooef007, #上市柜公司编号
       ooef008 LIKE ooef_t.ooef008, #行事历参照表号
       ooef009 LIKE ooef_t.ooef009, #制造行事历对应类别
       ooef010 LIKE ooef_t.ooef010, #办公行事历对应类别
       ooef011 LIKE ooef_t.ooef011, #专属国家地区功能
       ooef012 LIKE ooef_t.ooef012, #联络对象识别码
       ooef013 LIKE ooef_t.ooef013, #日期显示格式
       ooefownid LIKE ooef_t.ooefownid, #资料所有者
       ooefowndp LIKE ooef_t.ooefowndp, #资料所有部门
       ooefcrtid LIKE ooef_t.ooefcrtid, #资料录入者
       ooefcrtdp LIKE ooef_t.ooefcrtdp, #资料录入部门
       ooefcrtdt LIKE ooef_t.ooefcrtdt, #资料创建日
       ooefmodid LIKE ooef_t.ooefmodid, #资料更改者
       ooefmoddt LIKE ooef_t.ooefmoddt, #最近更改日
       ooef014 LIKE ooef_t.ooef014, #币种参照表号
       ooef015 LIKE ooef_t.ooef015, #汇率参照表号
       ooef016 LIKE ooef_t.ooef016, #主币种编号
       ooef017 LIKE ooef_t.ooef017, #法人归属
       ooef018 LIKE ooef_t.ooef018, #时区
       ooef019 LIKE ooef_t.ooef019, #税区
       ooef020 LIKE ooef_t.ooef020, #工商登记号
       ooef021 LIKE ooef_t.ooef021, #法人代表
       ooef022 LIKE ooef_t.ooef022, #注册资本
       ooef003 LIKE ooef_t.ooef003, #法人否
       ooef023 LIKE ooef_t.ooef023, #数字/金额显示格式
       ooef024 LIKE ooef_t.ooef024, #据点对应客户/供应商编号
       ooef025 LIKE ooef_t.ooef025, #品管参照表号
       ooef026 LIKE ooef_t.ooef026, #默认存款银行账户
       ooef100 LIKE ooef_t.ooef100, #门店状态
       ooef101 LIKE ooef_t.ooef101, #层级类型
       ooef102 LIKE ooef_t.ooef102, #业态
       ooef103 LIKE ooef_t.ooef103, #渠道
       ooef104 LIKE ooef_t.ooef104, #商圈
       ooef105 LIKE ooef_t.ooef105, #可比店
       ooef106 LIKE ooef_t.ooef106, #价格参考标准
       ooef107 LIKE ooef_t.ooef107, #店庆会计期
       ooef108 LIKE ooef_t.ooef108, #散客编号
       ooef109 LIKE ooef_t.ooef109, #开业日期
       ooef110 LIKE ooef_t.ooef110, #闭店日期
       ooef111 LIKE ooef_t.ooef111, #测量面积
       ooef112 LIKE ooef_t.ooef112, #建筑面积
       ooef113 LIKE ooef_t.ooef113, #经营面积
       ooef114 LIKE ooef_t.ooef114, #合作对象总数
       ooef115 LIKE ooef_t.ooef115, #24小时营业否
       ooef120 LIKE ooef_t.ooef120, #本店取货订定比例
       ooef121 LIKE ooef_t.ooef121, #异店取货订定比例
       ooef122 LIKE ooef_t.ooef122, #总部配送订定比例
       ooef123 LIKE ooef_t.ooef123, #默认收货成本仓
       ooef124 LIKE ooef_t.ooef124, #默认出货成本仓
       ooef125 LIKE ooef_t.ooef125, #默认在途成本仓
       ooef150 LIKE ooef_t.ooef150, #门店类别
       ooef151 LIKE ooef_t.ooef151, #规模类别
       ooef152 LIKE ooef_t.ooef152, #门店周期
       ooef153 LIKE ooef_t.ooef153, #销售区域
       ooef154 LIKE ooef_t.ooef154, #销售省区
       ooef155 LIKE ooef_t.ooef155, #销售地区
       ooef156 LIKE ooef_t.ooef156, #销售片区
       ooef157 LIKE ooef_t.ooef157, #其他属性1
       ooef158 LIKE ooef_t.ooef158, #其他属性2
       ooef159 LIKE ooef_t.ooef159, #其他属性3
       ooef160 LIKE ooef_t.ooef160, #其他属性4
       ooef161 LIKE ooef_t.ooef161, #其他属性5
       ooef162 LIKE ooef_t.ooef162, #其他属性6
       ooef163 LIKE ooef_t.ooef163, #其他属性7
       ooef164 LIKE ooef_t.ooef164, #其他属性8
       ooef165 LIKE ooef_t.ooef165, #其他属性9
       ooef166 LIKE ooef_t.ooef166, #其他属性10
       ooef167 LIKE ooef_t.ooef167, #其他属性11
       ooef168 LIKE ooef_t.ooef168, #其他属性12
       ooef169 LIKE ooef_t.ooef169, #其他属性13
       ooef170 LIKE ooef_t.ooef170, #其他属性14
       ooef171 LIKE ooef_t.ooef171, #其他属性15
       ooef172 LIKE ooef_t.ooef172, #其他属性16
       ooef173 LIKE ooef_t.ooef173, #其他属性17
       ooefunit LIKE ooef_t.ooefunit, #应用组织
       ooef200 LIKE ooef_t.ooef200, #分群编号
       ooef201 LIKE ooef_t.ooef201, #营运据点
       ooef202 LIKE ooef_t.ooef202, #预测组织
       ooef203 LIKE ooef_t.ooef203, #部门组织
       ooef204 LIKE ooef_t.ooef204, #核算组织
       ooef205 LIKE ooef_t.ooef205, #预算组织
       ooef206 LIKE ooef_t.ooef206, #资金组织
       ooef207 LIKE ooef_t.ooef207, #资产组织
       ooef208 LIKE ooef_t.ooef208, #销售组织
       ooef209 LIKE ooef_t.ooef209, #销售范围
       ooef210 LIKE ooef_t.ooef210, #采购组织
       ooef211 LIKE ooef_t.ooef211, #物流组织
       ooef212 LIKE ooef_t.ooef212, #结算组织
       ooef213 LIKE ooef_t.ooef213, #nouse
       ooef214 LIKE ooef_t.ooef214, #nouse
       ooef215 LIKE ooef_t.ooef215, #nouse
       ooef216 LIKE ooef_t.ooef216, #nouse
       ooef217 LIKE ooef_t.ooef217, #nouse
       ooef301 LIKE ooef_t.ooef301, #营销中心
       ooef302 LIKE ooef_t.ooef302, #配送中心
       ooef303 LIKE ooef_t.ooef303, #采购中心
       ooef304 LIKE ooef_t.ooef304, #门店
       ooef305 LIKE ooef_t.ooef305, #办事处
       ooef306 LIKE ooef_t.ooef306, #nouse
       ooef307 LIKE ooef_t.ooef307, #nouse
       ooef308 LIKE ooef_t.ooef308, #nouse
       ooef309 LIKE ooef_t.ooef309, #nouse
       ooef310 LIKE ooef_t.ooef310, #nouse
       ooef126 LIKE ooef_t.ooef126, #默认收货非成本仓
       ooef127 LIKE ooef_t.ooef127, #默认出货非成本仓
       ooef128 LIKE ooef_t.ooef128, #默认在途非成本仓
       ooef116 LIKE ooef_t.ooef116  #语言别
END RECORD
#161124-00048#10 add(e)
DEFINE g_detail_idx LIKE type_t.num5
DEFINE g_detail_d_t type_g_detail_d
DEFINE g_detail2_d_t  type_g_detail2_d
DEFINE g_detail2_d_o  type_g_detail2_d
DEFINE l_ac2                 LIKE type_t.num10  
DEFINE l_ac3                 LIKE type_t.num10  
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="armp100.main" >}
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
   CALL cl_ap_init("arm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_armp100 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armp100_init()   
 
      #進入選單 Menu (="N")
      CALL armp100_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_armp100
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="armp100.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION armp100_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_hidden = TRUE
   LET g_exe = TRUE
   LET g_master.date = g_today
   LET g_master.check = 'N'
#   SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent= g_enterprise AND ooef001 = g_site #161124-00048#10 mark
   #161124-00048#10 add(s)
   SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,ooef005,ooef006,ooef007,
          ooef008,ooef009,ooef010,ooef011,ooef012,ooef013,ooefownid,ooefowndp,
          ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,ooefmoddt,ooef014,ooef015,
          ooef016,ooef017,ooef018,ooef019,ooef020,ooef021,ooef022,ooef003,
          ooef023,ooef024,ooef025,ooef026,ooef100,ooef101,ooef102,ooef103,
          ooef104,ooef105,ooef106,ooef107,ooef108,ooef109,ooef110,ooef111,
          ooef112,ooef113,ooef114,ooef115,ooef120,ooef121,ooef122,ooef123,
          ooef124,ooef125,ooef150,ooef151,ooef152,ooef153,ooef154,ooef155,
          ooef156,ooef157,ooef158,ooef159,ooef160,ooef161,ooef162,ooef163,
          ooef164,ooef165,ooef166,ooef167,ooef168,ooef169,ooef170,ooef171,
          ooef172,ooef173,ooefunit,ooef200,ooef201,ooef202,ooef203,ooef204,
          ooef205,ooef206,ooef207,ooef208,ooef209,ooef210,ooef211,ooef212,
          ooef213,ooef214,ooef215,ooef216,ooef217,ooef301,ooef302,ooef303,
          ooef304,ooef305,ooef306,ooef307,ooef308,ooef309,ooef310,ooef126,
          ooef127,ooef128,ooef116 
     INTO g_ooef.* FROM ooef_t WHERE ooefent= g_enterprise AND ooef001 = g_site
   #161124-00048#10 add(e)
   CALL cl_set_combo_scc('sfba008','1101')
   CALL cl_set_combo_scc('sfac002','4019')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armp100_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_imae032 LIKE imae_t.imae032
   DEFINE l_cnt     LIKE type_t.num10
   DEFINE l_sql1          STRING            #160711-00040#28 add
   DEFINE l_success LIKE type_t.num5        #160711-00040#28 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL cl_set_comp_visible('detail2',FALSE)
   LET g_errshow =1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armp100_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON rmcadocno,rmcadocdt,rmca003,rmca004,rmcb001
            BEFORE CONSTRUCT
                      
            ON ACTION controlp INFIELD rmcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_rmcadocno()                       
               DISPLAY g_qryparam.return1 TO rmcadocno  
               NEXT FIELD rmcadocno                     

            ON ACTION controlp INFIELD rmca003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       
               DISPLAY g_qryparam.return1 TO rmca003  
               NEXT FIELD rmca003                     
               
            ON ACTION controlp INFIELD rmca004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_9()                    
               DISPLAY g_qryparam.return1 TO rmca004 
               NEXT FIELD rmca004                    

            ON ACTION controlp INFIELD rmcb001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_rmaadocno()                       
               DISPLAY g_qryparam.return1 TO rmcb001  
               NEXT FIELD rmcb001
         END CONSTRUCT         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.slip,g_master.date,g_master.check

            ATTRIBUTE(WITHOUT DEFAULTS)
            
            AFTER FIELD slip
               IF NOT cl_null(g_master.slip) THEN
                  IF NOT s_aooi200_chk_slip(g_site,'',g_master.slip,'asft300') THEN
                     LET g_master.slip = ''
                     NEXT FIELD CURRENT
                  END IF
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM oobb_t
                   WHERE oobbent = g_enterprise
                     AND oobb001 = g_ooef.ooef004
                     AND oobb002 = g_master.slip
                     AND oobb004 = 'sfaa003'
                     AND oobb005 IN ('1','3','4')
                     AND oobb007 = 'N'
                  IF l_cnt > 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.slip
                     LET g_errparam.code   = "arm-00031"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()    
                     LET g_master.slip = ''
                     NEXT FIELD CURRENT                    
                  END IF 
               END IF
               
            ON ACTION controlp INFIELD slip
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.slip 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'asft300'
               LET g_qryparam.where = " NOT EXISTS(SELECT * FROM oobb_t WHERE oobaent=oobbent AND ooba001=oobb001 AND ooba002=oobb002 AND oobb004='sfaa003' AND oobb005 IN ('1','3','4') AND oobb007 ='N')"
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_master.slip = g_qryparam.return1              
               NEXT FIELD slip
               
         END INPUT
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT           
               CALL FGL_SET_ARR_CURR(l_ac)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")            
            
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               DISPLAY l_ac TO FORMONLY.h_index
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
            ON CHANGE b_sel 
               CALL armp100_upd_rmcb()
            AFTER FIELD b_qty            
               IF NOT cl_null(g_detail_d[l_ac].qty) THEN 
                  IF NOT cl_ap_chk_range(g_detail_d[l_ac].qty,"0","0","","","azz-00079",1) THEN
                     LET g_detail_d[l_ac].qty = g_detail_d_t.qty 
                     NEXT FIELD CURRENT
                  END IF                
                  IF g_detail_d[l_ac].qty > g_detail_d[l_ac].rmcb007 - g_detail_d[l_ac].rmcb010 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_detail_d[l_ac].qty 
                     LET g_errparam.code   = "arm-00024"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()    
                     LET g_detail_d[l_ac].qty = g_detail_d_t.qty                     
                     NEXT FIELD CURRENT
                  END IF
               END IF   
               CALL armp100_upd_rmcb()               
            ON ROW CHANGE
               CALL armp100_upd_rmcb()          
         END INPUT 
         
         INPUT ARRAY g_detail2_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT           
               CALL armp100_b_fill2()
               #CALL FGL_SET_ARR_CURR(l_ac2)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac2
               IF g_detail_idx > g_detail2_d.getLength() THEN
                  LET g_detail_idx = g_detail2_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_detail2_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF                 
               CALL armp100_b_fill3() 
               
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = ARR_CURR()
               DISPLAY l_ac2 TO FORMONLY.h_index
               LET g_detail_idx = l_ac2 
               CALL armp100_set_entry_b()
               CALL armp100_set_no_entry_b()
               CALL armp100_b_fill3()
               LET g_detail2_d_t.* = g_detail2_d[l_ac2].*
               LET g_detail2_d_o.* = g_detail2_d[l_ac2].*
               
            AFTER FIELD sfaadocno
               IF NOT cl_null(g_detail2_d[l_ac2].sfaadocno) THEN
                  IF g_detail2_d_o.sfaadocno<> g_detail2_d[l_ac2].sfaadocno OR cl_null(g_detail2_d_o.sfaadocno) THEN 
                     IF NOT s_aooi200_chk_slip(g_site,'',g_detail2_d[l_ac2].sfaadocno,'asft300') THEN
                        LET g_detail2_d[l_ac2].sfaadocno = g_detail2_d_t.sfaadocno
                        NEXT FIELD CURRENT
                     END IF
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM oobb_t
                      WHERE oobbent = g_enterprise
                        AND oobb001 = g_ooef.ooef004
                        AND oobb002 = g_detail2_d[l_ac2].sfaadocno
                        AND oobb004 = 'sfaa003'
                        AND oobb005 IN ('1','3','4')
                        AND oobb007 = 'N'
                     IF l_cnt > 0 THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_detail2_d[l_ac2].sfaadocno
                        LET g_errparam.code   = "arm-00031"
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()    
                        LET g_detail2_d[l_ac2].sfaadocno = g_detail2_d_t.sfaadocno
                        NEXT FIELD CURRENT                    
                     END IF 
                     CALL armp100_upd_sfaa() 
                  END IF
               ELSE
                  NEXT FIELD CURRENT              
               END IF
               LET g_detail2_d_o.sfaadocno = g_detail2_d[l_ac2].sfaadocno
               
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[l_ac2].sfaadocno 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'asft300'
               LET g_qryparam.where = " NOT EXISTS(SELECT * FROM oobb_t WHERE oobaent=oobbent AND ooba001=oobb001 AND ooba002=oobb002 AND oobb004='sfaa003' AND oobb005 IN ('1','3','4') AND oobb007 ='N')"
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_detail2_d[l_ac2].sfaadocno = g_qryparam.return1              
               NEXT FIELD sfaadocno           
 
            AFTER FIELD sfaa002
               IF NOT cl_null(g_detail2_d[l_ac2].sfaa002) THEN
                  IF g_detail2_d_o.sfaa002<> g_detail2_d[l_ac2].sfaa002 OR cl_null(g_detail2_d_o.sfaa002) THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_detail2_d[l_ac2].sfaa002
                     #160318-00025#4--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                     #160318-00025#4--add--end
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_ooag001") THEN
                        LET g_detail2_d[l_ac2].sfaa002 = g_detail2_d_t.sfaa002
                        NEXT FIELD CURRENT
                     END IF
                     CALL armp100_upd_sfaa() 
                  END IF
               ELSE
                  NEXT FIELD CURRENT               
               END IF   
               LET g_detail2_d_o.sfaa002 = g_detail2_d[l_ac2].sfaa002
               
               
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[l_ac2].sfaa002 
               CALL q_ooag001_2()                              
               LET g_detail2_d[l_ac2].sfaa002  = g_qryparam.return1              
               NEXT FIELD sfaa002 

            ON CHANGE sfaa061
               CALL armp100_set_entry_b()
               CALL armp100_set_no_entry_b()
               CALL armp100_upd_sfaa() 
               
            AFTER FIELD sfaa016
               IF NOT cl_null(g_detail2_d[l_ac2].sfaa016) THEN
                  IF g_detail2_d_o.sfaa016<> g_detail2_d[l_ac2].sfaa016 OR cl_null(g_detail2_d_o.sfaa016) THEN
                     #抓制程料号
                     SELECT imae032 INTO l_imae032 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_detail2_d[l_ac2].sfaa010
                     IF cl_null(l_imae032) THEN
                        LET l_imae032 = g_detail2_d[l_ac2].sfaa010
                     END IF                  
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = l_imae032
                     LET g_chkparam.arg3 = g_detail2_d[l_ac2].sfaa016
                    #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ecba002_1") THEN
                        #檢查成功時後續處理
                     ELSE
                        #檢查失敗時後續處理
                        LET g_detail2_d[l_ac2].sfaa016 = g_detail2_d_t.sfaa016
                        NEXT FIELD CURRENT
                     END IF
                     CALL armp100_upd_sfaa()                      
                  END IF                  
               END IF  
               LET g_detail2_d_o.sfaa016 = g_detail2_d[l_ac2].sfaa016


            ON ACTION controlp INFIELD sfaa016
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[l_ac2].sfaa016 
               #抓制程料号
               SELECT imae032 INTO l_imae032 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_detail2_d[l_ac2].sfaa010
               IF cl_null(l_imae032) THEN
                  LET l_imae032 = g_detail2_d[l_ac2].sfaa010
               END IF                  
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = l_imae032               
               CALL q_ecba002_3()                              
               LET g_detail2_d[l_ac2].sfaa016  = g_qryparam.return1              
               NEXT FIELD sfaa016 
               
            AFTER FIELD sfaa017
               IF NOT cl_null(g_detail2_d[l_ac2].sfaa017) THEN
                  IF g_detail2_d_o.sfaa017<> g_detail2_d[l_ac2].sfaa017 OR cl_null(g_detail2_d_o.sfaa017) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_detail2_d[l_ac2].sfaa017
                     LET g_chkparam.arg2 = g_today
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooeg001_2") THEN
                     
                     ELSE
                        LET g_detail2_d[l_ac2].sfaa017 = g_detail2_d_t.sfaa017
                        NEXT FIELD sfaa017
                     END IF
                     CALL armp100_upd_sfaa()
                  END IF   
               END IF                
               LET g_detail2_d_o.sfaa017 = g_detail2_d[l_ac2].sfaa017
               
            ON ACTION controlp INFIELD sfaa017
               #開窗i段
	   		   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	   		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[l_ac2].sfaa017             #給予default值
               LET g_qryparam.arg1 = g_today
               CALL q_ooeg001()                 
               LET g_detail2_d[l_ac2].sfaa017 = g_qryparam.return1        #將開窗取得的值回傳到變數
               NEXT FIELD sfaa017 
 
            AFTER FIELD sfaa019
               IF NOT cl_null(g_detail2_d[l_ac2].sfaa019) THEN
                  IF g_detail2_d_o.sfaa019<> g_detail2_d[l_ac2].sfaa019 OR cl_null(g_detail2_d_o.sfaa019) THEN               
                     IF NOT cl_null(g_detail2_d[l_ac2].sfaa020) THEN 
                        IF g_detail2_d[l_ac2].sfaa019 > g_detail2_d[l_ac2].sfaa020 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'asf-00058'
                           LET g_errparam.extend = g_detail2_d[l_ac2].sfaa019
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                       
                           LET g_detail2_d[l_ac2].sfaa019 = g_detail2_d_t.sfaa019
                           NEXT FIELD sfaa019
                        END IF
                     END IF   
                     IF NOT cl_null(g_detail2_d[l_ac2].sfaadocdt) THEN
                        IF g_detail2_d[l_ac2].sfaadocdt > g_detail2_d[l_ac2].sfaa019 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'asf-00308'
                           LET g_errparam.extend = g_detail2_d_t.sfaa019
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_detail2_d[l_ac2].sfaa019 = g_detail2_d_t.sfaa019
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     CALL armp100_upd_sfaa()
                  END IF
               END IF            
               LET g_detail2_d_o.sfaa019 = g_detail2_d[l_ac2].sfaa019
               
            AFTER FIELD sfaa020
               IF NOT cl_null(g_detail2_d[l_ac2].sfaa020) AND NOT cl_null(g_detail2_d[l_ac2].sfaa019) THEN 
                  IF g_detail2_d_o.sfaa020<> g_detail2_d[l_ac2].sfaa020 OR cl_null(g_detail2_d_o.sfaa020) THEN               
                     IF g_detail2_d[l_ac2].sfaa020 < g_detail2_d[l_ac2].sfaa019 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00058'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()           
                        LET g_detail2_d[l_ac2].sfaa020 = g_detail2_d_t.sfaa020
                        NEXT FIELD sfaa020
                     END IF
                     CALL armp100_upd_sfaa()
                  END IF
               END IF
               LET g_detail2_d_o.sfaa020 = g_detail2_d[l_ac2].sfaa020 
            ON ROW CHANGE
               CALL armp100_upd_sfaa()
               
         END INPUT  
         INPUT ARRAY g_detail3_d FROM s_detail3.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT           
               CALL FGL_SET_ARR_CURR(l_ac3)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")            
            
            BEFORE ROW
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac3 TO FORMONLY.h_index
            AFTER FIELD sfba002
               IF NOT cl_null(g_detail3_d[l_ac3].sfba002) THEN
                  IF NOT s_azzi650_chk_exist('215',g_detail3_d[l_ac3].sfba002) THEN
                     LET g_detail3_d[l_ac3].sfba002 = ''
                     NEXT FIELD sfba002
                  END IF
                  IF NOT armp100_sfbaseq_chk() THEN 
                     LET g_detail3_d[l_ac3].sfba003 = ''                    
                     NEXT FIELD sfba003                     
                  END IF                  
               END IF   

            ON ACTION controlp INFIELD sfba002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].sfba002
               LET g_qryparam.arg1 = "215"
               CALL q_oocq002()
               LET g_detail3_d[l_ac3].sfba002 = g_qryparam.return1 
               NEXT FIELD sfba002
          
            AFTER FIELD sfba003
               IF NOT cl_null(g_detail3_d[l_ac3].sfba003) THEN
                  IF NOT s_azzi650_chk_exist('221',g_detail3_d[l_ac3].sfba003) THEN
                     LET g_detail3_d[l_ac3].sfba003 = ''                    
                     NEXT FIELD sfba003
                  END IF
                  IF NOT armp100_sfbaseq_chk() THEN 
                     LET g_detail3_d[l_ac3].sfba003 = ''                    
                     NEXT FIELD sfba003                     
                  END IF
               END IF

            AFTER FIELD sfba004
               IF NOT cl_null(g_detail3_d[l_ac3].sfba004) THEN
                  IF NOT armp100_sfbaseq_chk() THEN 
                     LET g_detail3_d[l_ac3].sfba004 = ''                    
                     NEXT FIELD sfba004                     
                  END IF
               END IF

            ON ACTION controlp INFIELD sfba003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].sfba003
               LET g_qryparam.arg1 = "221"
               CALL q_oocq002()
               LET g_detail3_d[l_ac3].sfba003 = g_qryparam.return1 
               NEXT FIELD sfba003 
               
            AFTER FIELD sfba007
               IF NOT cl_ap_chk_range(g_detail3_d[l_ac3].sfba007,"0.000","1","","","azz-00079",1) THEN
                  NEXT FIELD sfba007
               END IF     
               
            AFTER FIELD sfba012 
               IF NOT cl_ap_chk_Range(g_detail3_d[l_ac3].sfba012,"0","1","","","azz-00079",1) THEN
                  LET g_detail3_d[l_ac3].sfba012 = 0
                  NEXT FIELD sfba012
               END IF

            AFTER FIELD sfba019
               IF NOT cl_null(g_detail3_d[l_ac3].sfba019) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_detail3_d[l_ac3].sfba019
                  #160318-00025#4--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#4--add--end
                  IF NOT cl_chk_exist("v_inaa001_2") THEN
                     LET g_detail3_d[l_ac3].sfba019 = ''
                     LET g_detail3_d[l_ac3].sfba019_desc = '' #161129-00054#1 add
                     NEXT FIELD sfba019
                  END IF 
                  #161129-00054#1 add-S
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_detail3_d[l_ac3].sfba019
                  CALL ap_ref_array2(g_ref_fields," SELECT inayl003 FROM inayl_t WHERE inaylent = '"||g_enterprise||"' AND inayl001 = ? AND inayl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
                  LET g_detail3_d[l_ac3].sfba019_desc = g_rtn_fields[1] 
                  #161129-00054#1 add-E
               END IF

            AFTER FIELD sfba020
                IF NOT cl_null(g_detail3_d[l_ac3].sfba020) THEN
                   INITIALIZE g_chkparam.* TO NULL
                   LET g_chkparam.arg1 = g_site
                   LET g_chkparam.arg2 = g_detail3_d[l_ac3].sfba019
                   LET g_chkparam.arg3 = g_detail3_d[l_ac3].sfba020
                   #160318-00025#4--add--str
                   LET g_errshow = TRUE 
                   LET g_chkparam.err_str[1] = "aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                   #160318-00025#4--add--end
                   IF NOT cl_chk_exist("v_inab002") THEN
                      LET g_detail3_d[l_ac3].sfba020 = ''
                      LET g_detail3_d[l_ac3].sfba020_desc = '' #161129-00054#1 add
                      NEXT FIELD sfba020
                   END IF 
                   #161129-00054#1 add-S
                   INITIALIZE g_ref_fields TO NULL 
                   LET g_ref_fields[1] = g_detail3_d[l_ac3].sfba019
                   LET g_ref_fields[2] = g_detail3_d[l_ac3].sfba020
                   CALL ap_ref_array2(g_ref_fields," SELECT inab003 FROM inab_t WHERE inabent = '"||g_enterprise||"' AND inab001 = ? AND inab002 = ? ","") RETURNING g_rtn_fields 
                   LET g_detail3_d[l_ac3].sfba020_desc = g_rtn_fields[1] 
                   #161129-00054#1 add-E
                END IF
                
            ON ACTION controlp INFIELD sfba019
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].sfba019
               CALL q_inaa001_2()
               LET g_detail3_d[l_ac3].sfba019 = g_qryparam.return1 
               NEXT FIELD sfba019             

            ON ACTION controlp INFIELD sfba020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].sfba020
               LET g_qryparam.arg1 = g_detail3_d[l_ac3].sfba019
               CALL q_inab002_3()
               LET g_detail3_d[l_ac3].sfba020 = g_qryparam.return1 
               NEXT FIELD sfba020 
               
            ON ROW CHANGE
               CALL armp100_upd_sfba() 
               
         END INPUT               
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail4_d TO s_detail4.*

            BEFORE DISPLAY             

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
              
         END DISPLAY
         DISPLAY ARRAY g_detail5_d TO s_detail5.*

            BEFORE DISPLAY             

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
              
         END DISPLAY         
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
            CALL armp100_filter()
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
            CALL armp100_query()
            NEXT FIELD slip
            #end add-point
            CALL armp100_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL armp100_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION btn_next
            IF g_detail_d.getLength() = 0 THEN 
               CONTINUE DIALOG
            END IF
            CALL armp100_upd_rmcb() 
            IF g_hidden THEN 
               CALL cl_set_comp_visible('detail',FALSE)
               CALL cl_set_comp_visible('detail2',TRUE)
               LET g_hidden = FALSE
            END IF
            CALL armp100_ins_sfaa()
            NEXT FIELD sfaadocdt
         
         ON ACTION btn_pre
            IF NOT g_hidden THEN 
               CALL cl_set_comp_visible('detail',TRUE)
               CALL cl_set_comp_visible('detail2',FALSE)
               LET g_hidden = TRUE
               LET g_exe = TRUE
            END IF            
            NEXT FIELD slip
            
         ON ACTION btn_exe
            IF g_exe THEN
               CALL armp100_execute() 
               CALL armp100_b_fill2()
               LET g_exe = FALSE
               CALL armp100_display()   #160425-00022#1
            END IF            
            NEXT FIELD slip            
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
 
{<section id="armp100.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION armp100_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_sql STRING 
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"

   CALL cl_set_comp_visible('detail',TRUE)
   CALL cl_set_comp_visible('detail2',FALSE)
   LET g_hidden = TRUE
   LET g_exe = TRUE    
   
   CALL armp100_drop_table()
   CALL armp100_create_table()
   IF cl_null(g_master.wc) THEN 
      LET g_master.wc = ' 1=1'
   END IF
   LET l_sql = " INSERT INTO p100_rmcb ",
               " SELECT 'Y',rmcbdocno,rmcbseq,rmcb001,rmcb002, ",
               "        rmcb003,rmcb004,rmcb005,rmcb006,",
               "        rmcb007,rmcb010,rmcb007-rmcb010 ",
               "   FROM rmca_t,rmcb_t ",
               "  WHERE rmcaent = rmcbent AND rmcadocno = rmcbdocno ",
               "    AND rmcaent = '",g_enterprise,"'",
               "    AND rmcasite = '",g_site,"'",
               "    AND rmcastus = 'Y' ",
               "    AND rmcb009 = '1' ",
               "    AND rmcb007-rmcb010 > 0 ",
               "    AND ",g_master.wc
   PREPARE p100_ins_rmcb FROM l_sql
   EXECUTE p100_ins_rmcb   
   #end add-point
        
   LET g_error_show = 1
   CALL armp100_b_fill()
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
 
{<section id="armp100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armp100_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT sel,rmcbdocno,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004, ",
               "       imaal003,imaal004,rmcb005,rmcb006,oocal003,",
               "       rmcb007,rmcb010,qty ",
               "  FROM p100_rmcb ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND rmcb004=imaal001 AND imaal002='",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t ON oocalent = ? AND rmcb006=oocal001 AND oocal002='",g_dlang,"'"     
   #end add-point
 
   PREPARE armp100_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR armp100_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
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
      
      #end add-point
      
      CALL armp100_detail_show()      
 
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
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE armp100_sel
   
   LET l_ac = 1
   CALL armp100_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="armp100.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armp100_fetch()
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
 
{<section id="armp100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION armp100_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="armp100.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION armp100_filter()
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
   
   CALL armp100_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="armp100.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION armp100_filter_parser(ps_field)
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
 
{<section id="armp100.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION armp100_filter_show(ps_field,ps_object)
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
   LET ls_condition = armp100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION armp100_create_table()
     
   WHENEVER ERROR CONTINUE     

   CREATE TEMP TABLE p100_rmcb(
     sel  VARCHAR(1),
     rmcbdocno  VARCHAR(20),
     rmcbseq  INTEGER,
     rmcb001  VARCHAR(20),
     rmcb002  INTEGER,
     rmcb003  INTEGER,
     rmcb004  VARCHAR(40),
     rmcb005  VARCHAR(256),
     rmcb006  VARCHAR(10),
     rmcb007  DECIMAL(20,6),
     rmcb010  DECIMAL(20,6),
     qty  DECIMAL(20,6));

   CREATE TEMP TABLE p100_sfaa(
     sfaadocno  VARCHAR(20),
     sfaadocdt  DATE,
     sfaa002  VARCHAR(20),
     sfaa005  VARCHAR(20),
     sfaa006  VARCHAR(20),
     sfaa007  INTEGER,
     sfaa010  VARCHAR(40),
     sfaa012  DECIMAL(20,6),
     sfaa013  VARCHAR(10),
     sfaa061  VARCHAR(1),  
     sfaa016  VARCHAR(10),
     sfaa017  VARCHAR(10),
     sfaa018  VARCHAR(10),
     sfaa019  DATE,
     sfaa020  DATE,
     sfaa_no  SMALLINT);

   CREATE TEMP TABLE p100_sfba(
     sfba_no  SMALLINT,
     sfbaseq  INTEGER,
     sfbaseq1  INTEGER,
     sfba002  VARCHAR(10),
     sfba003  VARCHAR(10),
     sfba004  VARCHAR(10),
     sfba005  VARCHAR(40),
     sfba022  DECIMAL(20,6),
     sfba006  VARCHAR(40),
     sfba021  VARCHAR(256),
     sfba007  SMALLINT,
     sfba008  VARCHAR(1),
     sfba009  VARCHAR(1),
     sfba010  DECIMAL(20,6),
     sfba011  DECIMAL(20,6),
     sfba012  DECIMAL(20,6),
     sfba023  DECIMAL(20,6),
     sfba024  DECIMAL(20,6),
     sfba013  DECIMAL(20,6),
     sfba014  VARCHAR(10),
     sfba019  VARCHAR(10),
     sfba020  VARCHAR(10));      
     
   CREATE TEMP TABLE p100_sfab(
     sfabseq  INTEGER,
     sfab002  VARCHAR(20),
     sfab003  INTEGER,
     sfab004  INTEGER,
     sfab005  SMALLINT,
     sfab006  DECIMAL(20,6),
     sfab007  DECIMAL(20,6),
     sfab_no  SMALLINT);
    
   CREATE TEMP TABLE p100_sfac(
     sfacseq  INTEGER,
     sfac002  VARCHAR(1),
     sfac001  VARCHAR(40),
     sfac006  VARCHAR(256),
     sfac003  DECIMAL(20,6),
     sfac004  VARCHAR(10),
     sfac005  DECIMAL(20,6),
     sfac_no  SMALLINT);
END FUNCTION

PRIVATE FUNCTION armp100_drop_table()
   DROP TABLE p100_rmcb;
   DROP TABLE p100_sfaa;
   DROP TABLE p100_sfba;
   DROP TABLE p100_sfab;
   DROP TABLE p100_sfac;
END FUNCTION

PRIVATE FUNCTION armp100_upd_rmcb()
   
   IF cl_null(l_ac) OR l_ac = 0 THEN RETURN END IF 
  
   UPDATE p100_rmcb
      SET sel = g_detail_d[l_ac].sel, 
          qty = g_detail_d[l_ac].qty
    WHERE rmcbdocno = g_detail_d[l_ac].rmcbdocno
      AND rmcbseq = g_detail_d[l_ac].rmcbseq       
    
END FUNCTION

PRIVATE FUNCTION armp100_ins_sfaa()
DEFINE l_sql STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_rmcb RECORD 
     rmcbdocno LIKE rmcb_t.rmcbdocno,
     rmcbseq LIKE rmcb_t.rmcbseq,
     rmcb001 LIKE rmcb_t.rmcb001,
     rmcb002 LIKE rmcb_t.rmcb002,
     rmcb003 LIKE rmcb_t.rmcb003,
     rmcb004 LIKE rmcb_t.rmcb004,
     rmcb005 LIKE rmcb_t.rmcb005,
     rmcb006 LIKE rmcb_t.rmcb006,
     rmcb007 LIKE rmcb_t.rmcb007,
     rmcb010 LIKE rmcb_t.rmcb010,
     qty LIKE rmcb_t.rmcb010
     END RECORD
DEFINE l_cnt LIKE type_t.num5     
DEFINE l_sfaa RECORD
     sfaadocno LIKE sfaa_t.sfaadocno,
     sfaadocdt LIKE sfaa_t.sfaadocdt,
     sfaa002 LIKE sfaa_t.sfaa002,
     sfaa005 LIKE sfaa_t.sfaa005,
     sfaa006 LIKE sfaa_t.sfaa006,
     sfaa007 LIKE sfaa_t.sfaa007,     
     sfaa010 LIKE sfaa_t.sfaa010,
     sfaa012 LIKE sfaa_t.sfaa012,
     sfaa013 LIKE sfaa_t.sfaa013,
     sfaa061 LIKE sfaa_t.sfaa061,  
     sfaa016 LIKE sfaa_t.sfaa016,
     sfaa017 LIKE sfaa_t.sfaa017,
     sfaa018 LIKE sfaa_t.sfaa018,
     sfaa019 LIKE sfaa_t.sfaa019,
     sfaa020 LIKE sfaa_t.sfaa020,
     sfaa_no LIKE type_t.num5
     END RECORD
DEFINE l_sfba RECORD
     sfba_no LIKE type_t.num5,
     sfbaseq LIKE sfba_t.sfbaseq,
     sfbaseq1 LIKE sfba_t.sfbaseq1,
     sfba002 LIKE sfba_t.sfba002,
     sfba003 LIKE sfba_t.sfba003,
     sfba004 LIKE sfba_t.sfba004,
     sfba005 LIKE sfba_t.sfba005,
     sfba022 LIKE sfba_t.sfba022,
     sfba006 LIKE sfba_t.sfba006,
     sfba021 LIKE sfba_t.sfba021,
     sfba007 LIKE sfba_t.sfba007,
     sfba008 LIKE sfba_t.sfba008,
     sfba009 LIKE sfba_t.sfba009,
     sfba010 LIKE sfba_t.sfba010,
     sfba011 LIKE sfba_t.sfba011,
     sfba012 LIKE sfba_t.sfba012,
     sfba023 LIKE sfba_t.sfba023,
     sfba024 LIKE sfba_t.sfba024,
     sfba013 LIKE sfba_t.sfba013,
     sfba014 LIKE sfba_t.sfba014,
     sfba019 LIKE sfba_t.sfba019,
     sfba020 LIKE sfba_t.sfba020     
     END RECORD  
DEFINE l_sfab RECORD      
     sfabseq LIKE sfab_t.sfabseq,
     sfab002 LIKE sfab_t.sfab002,
     sfab003 LIKE sfab_t.sfab003,
     sfab004 LIKE sfab_t.sfab004,
     sfab005 LIKE sfab_t.sfab005,
     sfab006 LIKE sfab_t.sfab006,
     sfab007 LIKE sfab_t.sfab007,
     sfab_no LIKE type_t.num5
     END RECORD
DEFINE l_sfac RECORD     
     sfacseq LIKE sfac_t.sfacseq,
     sfac002 LIKE sfac_t.sfac002,
     sfac001 LIKE sfac_t.sfac001,
     sfac006 LIKE sfac_t.sfac006,
     sfac003 LIKE sfac_t.sfac003,
     sfac004 LIKE sfac_t.sfac004,
     sfac005 LIKE sfac_t.sfac005,
     sfac_no LIKE type_t.num5
     END RECORD
DEFINE l_last_item LIKE imaa_t.imaa001
DEFINE l_last_feature LIKE rmcb_t.rmcb005


   DELETE FROM p100_sfaa;
   DELETE FROM p100_sfba;
   DELETE FROM p100_sfab;
   DELETE FROM p100_sfac;
            
   LET l_cnt = 0
   LET l_last_item = ''
   LET l_sql = " SELECT rmcbdocno,rmcbseq,rmcb001,rmcb002,rmcb003,",
               "        rmcb004,rmcb005,rmcb006,rmcb007,rmcb010,qty ",
               "   FROM p100_rmcb ",
               "  WHERE sel = 'Y' ",
               "  ORDER BY rmcb004 "
   PREPARE p100_rmcb_pre FROM l_sql
   DECLARE p100_rmcb_cur CURSOR FOR p100_rmcb_pre
   FOREACH p100_rmcb_cur INTO l_rmcb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF g_master.check = 'Y' AND NOT cl_null(l_last_item) AND l_last_item = l_rmcb.rmcb004 THEN
         LET l_cnt = l_cnt
      ELSE
         LET l_cnt = l_cnt + 1      
      END IF
              
      LET l_sfaa.sfaadocno = g_master.slip
      LET l_sfaa.sfaadocdt = g_master.date
      LET l_sfaa.sfaa002 = g_user
      LET l_sfaa.sfaa005 = '5'
      LET l_sfaa.sfaa006 = l_rmcb.rmcbdocno
      LET l_sfaa.sfaa007 = l_rmcb.rmcbseq      
      LET l_sfaa.sfaa010 = l_rmcb.rmcb004
      SELECT imae016 INTO l_sfaa.sfaa013
        FROM imae_t
       WHERE imaeent = g_enterprise
         AND imae001 = l_rmcb.rmcb004
         AND imaesite = g_site 
      CALL s_aooi250_convert_qty(l_rmcb.rmcb004,l_rmcb.rmcb006,l_sfaa.sfaa013,l_rmcb.qty) 
         RETURNING l_success,l_sfaa.sfaa012
      IF NOT l_success THEN
         LET l_sfaa.sfaa012 = l_rmcb.qty
      END IF
      LET l_sfaa.sfaa061 = 'N'
      LET l_sfaa.sfaa016 = ''
      LET l_sfaa.sfaa017 = ''
      LET l_sfaa.sfaa018 = g_site
      LET l_sfaa.sfaa019 = g_today
      CALL s_asft300_06('1',l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa019) RETURNING l_success,l_sfaa.sfaa020
          
      LET l_sfaa.sfaa_no = l_cnt
      IF g_master.check = 'Y' AND NOT cl_null(l_last_item) AND l_last_item = l_rmcb.rmcb004 THEN 
         LET l_sfaa.sfaa005 = 'MULTI'
         LET l_sfaa.sfaa006 = ''
         LET l_sfaa.sfaa007 = ''  
         
         UPDATE p100_sfaa
            SET sfaa012 = sfaa012 + l_sfaa.sfaa012,
                sfaa005 = l_sfaa.sfaa005,
                sfaa006 = l_sfaa.sfaa006,
                sfaa007 = l_sfaa.sfaa007        
          WHERE sfaa_no = l_cnt
      ELSE
         INSERT INTO p100_sfaa VALUES (l_sfaa.*)      
      END IF
      
      ##新增備料明細
      LET l_sfba.sfbaseq= 10    
      LET l_sfba.sfbaseq1 = 0 
      LET l_sfba.sfba002 = ''
      LET l_sfba.sfba003 = '' 
      LET l_sfba.sfba004 = ''
      LET l_sfba.sfba005 = l_rmcb.rmcb004
      LET l_sfba.sfba022 = 1
      LET l_sfba.sfba006 = l_rmcb.rmcb004
      LET l_sfba.sfba021 = '' 
      LET l_sfba.sfba007 = ''
      LET l_sfba.sfba008 = '1'
      LET l_sfba.sfba009 = 'N'
      LET l_sfba.sfba010 = 1
      LET l_sfba.sfba011 = 1
      LET l_sfba.sfba012 = 0
      LET l_sfba.sfba023 = l_sfaa.sfaa012
      LET l_sfba.sfba024 = 0
      LET l_sfba.sfba013 = l_sfaa.sfaa012
      LET l_sfba.sfba014 = l_sfaa.sfaa013
      LET l_sfba.sfba019 = ''
      LET l_sfba.sfba020 = ''
      
      LET l_sfba.sfba_no = l_cnt
      INSERT INTO p100_sfba VALUES(l_sfba.*)
      CALL armp100_ins_sfba(l_rmcb.rmcb001,l_rmcb.rmcb002,l_cnt,l_sfaa.sfaa012)
      
      ##新增工單來源    
      SELECT MAX(sfabseq) INTO l_sfab.sfabseq
        FROM p100_sfab
       WHERE sfab_no = l_cnt 
      IF cl_null(l_sfab.sfabseq) THEN 
         LET l_sfab.sfabseq= 1
      ELSE
         LET l_sfab.sfabseq = l_sfab.sfabseq + 1      
      END IF 
      LET l_sfab.sfab002 = l_rmcb.rmcbdocno
      LET l_sfab.sfab003 = l_rmcb.rmcbseq
      LET l_sfab.sfab004 = 0
      LET l_sfab.sfab005 = 0
      LET l_sfab.sfab006 = 10
      LET l_sfab.sfab007 = l_rmcb.qty
      LET l_sfab.sfab_no = l_cnt
      INSERT INTO p100_sfab VALUES(l_sfab.*)
      
      ##新增生產料號明細
      IF g_master.check = 'Y' AND NOT cl_null(l_last_item) AND l_last_item = l_rmcb.rmcb004
        AND NOT cl_null(l_last_feature) AND l_last_feature = l_rmcb.rmcb005 THEN 
         UPDATE p100_sfac 
            SET sfac003 = sfac003 + l_sfaa.sfaa012
          WHERE sfac_no = l_cnt
      ELSE          
         SELECT MAX(sfacseq) INTO l_sfac.sfacseq
           FROM p100_sfac
          WHERE sfac_no = l_cnt 
         IF cl_null(l_sfac.sfacseq) THEN 
            LET l_sfac.sfacseq= 1
         ELSE
            LET l_sfac.sfacseq = l_sfac.sfacseq + 1      
         END IF      
         LET l_sfac.sfac002 = '1'
         LET l_sfac.sfac001 = l_rmcb.rmcb004
         LET l_sfac.sfac006 = l_rmcb.rmcb005
         LET l_sfac.sfac003 = l_rmcb.qty
         LET l_sfac.sfac004 = l_rmcb.rmcb006
         LET l_sfac.sfac005 = 0
         LET l_sfac.sfac_no = l_cnt 
         INSERT INTO p100_sfac VALUES(l_sfac.*)      
      END IF
      LET l_last_item = l_rmcb.rmcb004
      LET l_last_feature = l_rmcb.rmcb005      
   END FOREACH
END FUNCTION

PRIVATE FUNCTION armp100_ins_sfba(p_rmbcdocno,p_rmcbseq,p_cnt,p_sfaa012)
DEFINE p_rmbcdocno LIKE rmcb_t.rmcbdocno,
       p_rmcbseq LIKE rmcb_t.rmcbseq,
       p_cnt LIKE type_t.num5,
       p_sfaa012 LIKE sfaa_t.sfaa012
DEFINE l_sql STRING 
DEFINE l_seq LIKE type_t.num5
DEFINE l_sfba RECORD
     sfba_no LIKE type_t.num5,
     sfbaseq LIKE sfba_t.sfbaseq,
     sfbaseq1 LIKE sfba_t.sfbaseq1,
     sfba002 LIKE sfba_t.sfba002,
     sfba003 LIKE sfba_t.sfba003,
     sfba004 LIKE sfba_t.sfba004,
     sfba005 LIKE sfba_t.sfba005,
     sfba022 LIKE sfba_t.sfba022,
     sfba006 LIKE sfba_t.sfba006,
     sfba021 LIKE sfba_t.sfba021,
     sfba007 LIKE sfba_t.sfba007,
     sfba008 LIKE sfba_t.sfba008,
     sfba009 LIKE sfba_t.sfba009,
     sfba010 LIKE sfba_t.sfba010,
     sfba011 LIKE sfba_t.sfba011,
     sfba012 LIKE sfba_t.sfba012,
     sfba023 LIKE sfba_t.sfba023,
     sfba024 LIKE sfba_t.sfba024,
     sfba013 LIKE sfba_t.sfba013,
     sfba014 LIKE sfba_t.sfba014,
     sfba019 LIKE sfba_t.sfba019,
     sfba020 LIKE sfba_t.sfba020
     END RECORD 
DEFINE l_success LIKE type_t.num5

   LET l_sfba.sfbaseq= 10 
   
   SELECT rmab013 INTO l_sfba.sfba011
     FROM rmab_t
    WHERE rmabent = g_enterprise
      AND rmabdocno = p_rmbcdocno
      AND rmabseq = p_rmcbseq
      
   LET l_sql = " SELECT rmbc001,rmbc002,rmbc003,rmbc004 ",
               "   FROM rmba_t a,rmbb_t,rmbc_t ",
               "  WHERE rmbaent = rmbbent AND rmbadocno = rmbbdocno AND rmba000 = rmbb000 ",
               "    AND rmbbent = rmbcent AND rmbbdocno = rmbcdocno AND rmbb000 = rmbc000 AND rmbbseq = rmbcseq ",
               "    AND rmbaent = '",g_enterprise,"'",
               "    AND rmbasite = '",g_site,"'",
               "    AND rmbadocno = '",p_rmbcdocno,"'",
               "    AND rmbbseq = ",p_rmcbseq,
               "    AND rmbastus = 'Y' ",
               "    AND rmba000 = (SELECT MAX(b.rmba000) FROM rmba_t b WHERE a.rmbaent=b.rmbaent AND a.rmbadocno=b.rmbadocno)"
   PREPARE p100_sel_rmbc_pre FROM l_sql
   DECLARE p100_sel_rmbc_cur CURSOR FOR p100_sel_rmbc_pre
   FOREACH p100_sel_rmbc_cur INTO l_sfba.sfba005,l_sfba.sfba021,l_sfba.sfba014,l_sfba.sfba010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfba.sfbaseq = l_sfba.sfbaseq + 10      
      LET l_sfba.sfbaseq1 = 0 
      LET l_sfba.sfba002 = ''
      LET l_sfba.sfba003 = '' 
      LET l_sfba.sfba004 = ''
      LET l_sfba.sfba022 = 1
      LET l_sfba.sfba006 = l_sfba.sfba005 
      LET l_sfba.sfba007 = ''
      LET l_sfba.sfba008 = '1'
      LET l_sfba.sfba009 = 'N'
      #LET l_sfba.sfba011 = 1
      LET l_sfba.sfba012 = 0
      LET l_sfba.sfba019 = g_today
      LET l_sfba.sfba023 = p_sfaa012 * l_sfba.sfba010/l_sfba.sfba011
      LET l_sfba.sfba024 = 0
      LET l_sfba.sfba013 = l_sfba.sfba023 + l_sfba.sfba024  
      CALL s_asft300_03(l_sfba.sfba006,l_sfba.sfba013) RETURNING l_success,l_sfba.sfba013
      LET l_sfba.sfba024 = l_sfba.sfba013 - l_sfba.sfba023 
      LET l_sfba.sfba019 = ''
      LET l_sfba.sfba020 = ''
      LET l_sfba.sfba_no = p_cnt
      INSERT INTO p100_sfba VALUES(l_sfba.*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_sfba:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF      
   END FOREACH   

END FUNCTION

PRIVATE FUNCTION armp100_b_fill2()
DEFINE l_sql STRING
DEFINE l_cnt  LIKE type_t.num5
     
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL g_detail5_d.clear()
   LET l_cnt = 1
   LET l_sql = "SELECT sfaa_no,sfaadocno,sfaadocdt,sfaa002,sfaa010, ",
               "       sfaa012,sfaa013,sfaa061,sfaa016,sfaa017,",
               "       sfaa018,sfaa019,sfaa020",
               "  FROM p100_sfaa "
   PREPARE armp100_sfaa_pre FROM l_sql
   DECLARE armp100_sfaa_cur CURSOR FOR armp100_sfaa_pre
   FOREACH armp100_sfaa_cur INTO g_detail2_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
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
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   
END FUNCTION

PRIVATE FUNCTION armp100_b_fill3()
DEFINE l_sql STRING 
DEFINE l_cnt LIKE type_t.num5

   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN 
      RETURN
   END IF
   CALL g_detail3_d.clear()
   LET l_cnt = 1
   #161129-00054#1 mod-S
#   LET l_sql = " SELECT * FROM p100_sfba WHERE sfba_no = ",g_detail2_d[g_detail_idx].sfaa_no
   LET l_sql = " SELECT sfba_no,sfbaseq,sfbaseq1,sfba002,sfba003, ",
               "        sfba004,sfba005,sfba022,sfba006,sfba021,",
               "        sfba007,sfba008,sfba009,sfba010,sfba011,",
               "        sfba012,sfba023,sfba024,sfba013,sfba014,",
               "        sfba019,",
               "        (SELECT inayl003 FROM inayl_t WHERE inayl001 = sfba019 AND inayl002 = '",g_dlang,"' AND inaylent = ",g_enterprise,") inayl003,",
               "        sfba020,",
               "        (SELECT inab003 FROM inab_t WHERE inab001 = sfba019 AND inab002 = sfba020 AND inabsite = '",g_site,"' AND inabent = ",g_enterprise,") inab003 ",
               " FROM p100_sfba ",
               " WHERE sfba_no = ",g_detail2_d[g_detail_idx].sfaa_no
   #161129-00054#1 mod-E
   PREPARE armp100_sfba_pre FROM l_sql
   DECLARE armp100_sfba_cur CURSOR FOR armp100_sfba_pre
   FOREACH armp100_sfba_cur INTO g_detail3_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
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
   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())  

   CALL g_detail4_d.clear()
   LET l_cnt = 1
   LET l_sql = " SELECT * FROM p100_sfab WHERE sfab_no = ",g_detail2_d[g_detail_idx].sfaa_no
   PREPARE armp100_sfab_pre FROM l_sql
   DECLARE armp100_sfab_cur CURSOR FOR armp100_sfab_pre
   FOREACH armp100_sfab_cur INTO g_detail4_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
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
   CALL g_detail4_d.deleteElement(g_detail4_d.getLength()) 

   CALL g_detail5_d.clear()
   LET l_cnt = 1
   LET l_sql = " SELECT * FROM p100_sfac WHERE sfac_no = ",g_detail2_d[g_detail_idx].sfaa_no
   PREPARE armp100_sfac_pre FROM l_sql
   DECLARE armp100_sfac_cur CURSOR FOR armp100_sfac_pre
   FOREACH armp100_sfac_cur INTO g_detail5_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
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
   CALL g_detail5_d.deleteElement(g_detail5_d.getLength()) 
   
END FUNCTION

PRIVATE FUNCTION armp100_execute()
DEFINE l_sql STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_sfaa RECORD
     sfaa_no LIKE type_t.num5,
     sfaadocno LIKE sfaa_t.sfaadocno,
     sfaadocdt LIKE sfaa_t.sfaadocdt,
     sfaa002 LIKE sfaa_t.sfaa002,
     sfaa006 LIKE sfaa_t.sfaa006,
     sfaa007 LIKE sfaa_t.sfaa007,     
     sfaa010 LIKE sfaa_t.sfaa010,
     sfaa012 LIKE sfaa_t.sfaa012,
     sfaa013 LIKE sfaa_t.sfaa013,
     sfaa061 LIKE sfaa_t.sfaa061,  
     sfaa016 LIKE sfaa_t.sfaa016,
     sfaa017 LIKE sfaa_t.sfaa017,
     sfaa018 LIKE sfaa_t.sfaa018,
     sfaa019 LIKE sfaa_t.sfaa019,
     sfaa020 LIKE sfaa_t.sfaa020,
     sfaa003 LIKE sfaa_t.sfaa003,
     sfaa004 LIKE sfaa_t.sfaa004,
     sfaa005 LIKE sfaa_t.sfaa005,
     sfaa057 LIKE sfaa_t.sfaa057,
     sfaa001 LIKE sfaa_t.sfaa001, 
     sfaa008 LIKE sfaa_t.sfaa008,
     sfaa063 LIKE sfaa_t.sfaa063,
     sfaa009 LIKE sfaa_t.sfaa009,
     sfaa022 LIKE sfaa_t.sfaa022,
     sfaa023 LIKE sfaa_t.sfaa023,
     sfaa024 LIKE sfaa_t.sfaa024,
     sfaa064 LIKE sfaa_t.sfaa064,
     sfaa021 LIKE sfaa_t.sfaa021,
     sfaa025 LIKE sfaa_t.sfaa025,
     sfaa011 LIKE sfaa_t.sfaa011,
     sfaa058 LIKE sfaa_t.sfaa058,
     sfaa060 LIKE sfaa_t.sfaa060,
     sfaa014 LIKE sfaa_t.sfaa014,
     sfaa028 LIKE sfaa_t.sfaa028,
     sfaa015 LIKE sfaa_t.sfaa015,
     sfaa029 LIKE sfaa_t.sfaa029,
     sfaa026 LIKE sfaa_t.sfaa026,
     sfaa030 LIKE sfaa_t.sfaa030,
     sfaa031 LIKE sfaa_t.sfaa031,
     sfaa062 LIKE sfaa_t.sfaa062,
     sfaa032 LIKE sfaa_t.sfaa032,
     sfaa068 LIKE sfaa_t.sfaa068,
     sfaa033 LIKE sfaa_t.sfaa033,
     sfaa034 LIKE sfaa_t.sfaa034,
     sfaa035 LIKE sfaa_t.sfaa035,
     sfaa059 LIKE sfaa_t.sfaa059,
     sfaa036 LIKE sfaa_t.sfaa036,
     sfaa037 LIKE sfaa_t.sfaa037,
     sfaa038 LIKE sfaa_t.sfaa038,
     sfaa039 LIKE sfaa_t.sfaa039,
     sfaa040 LIKE sfaa_t.sfaa040,
     sfaa041 LIKE sfaa_t.sfaa041,
     sfaa042 LIKE sfaa_t.sfaa042,
     sfaa043 LIKE sfaa_t.sfaa043,
     sfaa044 LIKE sfaa_t.sfaa044,
     sfaa069 LIKE sfaa_t.sfaa069,
     sfaa070 LIKE sfaa_t.sfaa070,
     sfaa065 LIKE sfaa_t.sfaa065,
     sfaa045 LIKE sfaa_t.sfaa045,
     sfaa046 LIKE sfaa_t.sfaa046,
     sfaa049 LIKE sfaa_t.sfaa049,
     sfaa050 LIKE sfaa_t.sfaa050,
     sfaa047 LIKE sfaa_t.sfaa047,
     sfaa051 LIKE sfaa_t.sfaa051,
     sfaa048 LIKE sfaa_t.sfaa048,
     sfaa055 LIKE sfaa_t.sfaa055,
     sfaa056 LIKE sfaa_t.sfaa056,
     sfaa071 LIKE sfaa_t.sfaa071,  #160425-00019 by whitney add 齊料套數
     sfaaownid LIKE sfaa_t.sfaaownid,
     sfaaowndp LIKE sfaa_t.sfaaowndp,
     sfaacrtid LIKE sfaa_t.sfaacrtid,
     sfaacrtdp LIKE sfaa_t.sfaacrtdp,
     sfaacrtdt DATETIME YEAR TO SECOND,
     sfaamodid LIKE sfaa_t.sfaamodid,
     sfaamoddt DATETIME YEAR TO SECOND,
     sfaacnfid LIKE sfaa_t.sfaacnfid,
     sfaacnfdt DATETIME YEAR TO SECOND,
     sfaapstid LIKE sfaa_t.sfaapstid,
     sfaapstdt DATETIME YEAR TO SECOND,
     sfaastus  LIKE sfaa_t.sfaastus      
     END RECORD
#160816-00066#4 add-S
DEFINE l_stano    LIKE sfaa_t.sfaadocno   
DEFINE l_endno    LIKE sfaa_t.sfaadocno   
DEFINE l_cnt      LIKE type_t.num10       
DEFINE l_str      STRING                  
DEFINE ls_wc      STRING
DEFINE la_param   RECORD
       prog       STRING,
       actionid   STRING,
       background LIKE type_t.chr1,
       param      DYNAMIC ARRAY OF STRING
       END RECORD
DEFINE ls_js      STRING
#160816-00066#4 add-E
     
     
   CALL s_transaction_begin() 
   
   LET l_sql = " INSERT INTO sfaa_t(sfaaent,sfaasite,sfaadocno,sfaadocdt,sfaa001,",
               "                    sfaa002,sfaa003,sfaa004,sfaa057,sfaa005,",
               "                    sfaa010,sfaa012,sfaa013,sfaa061,sfaa016,",
               "                    sfaa017,sfaa018,sfaa019,sfaa020,",
               "                    sfaa008,sfaa063,sfaa009,sfaa022,",
               "                    sfaa023,sfaa024,sfaa064,sfaa021,sfaa025,",
               "                    sfaa011,sfaa058,sfaa060,sfaa014,",
               "                    sfaa028,sfaa015,sfaa029,sfaa026,sfaa030,",
               "                    sfaa031,sfaa062,sfaa032,sfaa068,sfaa033,",
               "                    sfaa034,sfaa035,sfaa059,sfaa036,sfaa037,",
               "                    sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,",
               "                    sfaa043,sfaa044,sfaa069,sfaa070,sfaa065,",
               "                    sfaa045,sfaa046,sfaa049,sfaa050,sfaa047,",
               "                    sfaa051,sfaa048,sfaa055,sfaa056, ",              
               "                    sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,",
               "                    sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,sfaapstid,",
               "                    sfaapstdt,sfaastus,sfaa006,sfaa007)",
               "  VALUES(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?, ",
               "         ?,?,?,?,    ?,?,?,?,?,  ?,?,?,?,    ?,?,?,?,?,  ?,?,?,?,?, ",
               "         ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,",
               "         ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?)"      
   PREPARE sfaa_ins FROM l_sql  
   
   LET l_sql = " INSERT INTO sfba_t(sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,",
               "                    sfba002,sfba003,sfba004,sfba005,sfba022,",
               "                    sfba006,sfba021,sfba007,sfba008,sfba009,",
               "                    sfba010,sfba011,sfba012,sfba023,sfba024,",
               "                    sfba013,sfba014,sfba019,sfba020,sfba026,sfba028) ",
               " SELECT '",g_enterprise,"','",g_site,"',?,sfbaseq,sfbaseq1,",
               "               sfba002,sfba003,sfba004,sfba005,sfba022,",
               "               sfba006,sfba021,sfba007,sfba008,sfba009,",
               "               sfba010,sfba011,sfba012,sfba023,sfba024,",
               "               sfba013,sfba014,sfba019,sfba020,'1','N' ",
               "   FROM p100_sfba WHERE sfba_no = ?"
   PREPARE sfba_ins FROM l_sql     
      
   LET l_sql = " INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfabseq,sfab001,",
               "                    sfab002,sfab003,sfab004,sfab005,sfab006,",
               "                    sfab007)",
               " SELECT '",g_enterprise,"','",g_site,"',?,sfabseq,'5',", 
               "        sfab002,sfab003,sfab004,sfab005,sfab006,sfab007 ",
               "   FROM p100_sfab WHERE sfab_no = ? "
   PREPARE sfab_ins FROM l_sql   
    
   LET l_sql = " INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,",
               "                    sfac002,sfac003,sfac004,sfac005,sfac006)",
               " SELECT '",g_enterprise,"','",g_site,"',?,sfacseq,sfac001,", 
               "        '1',sfac003,sfac004,sfac005,sfac006 ",
               "   FROM p100_sfac WHERE sfac_no = ? "
   PREPARE sfac_ins FROM l_sql 
      
   LET l_success = TRUE
   LET l_sql = "SELECT sfaa_no,sfaadocno,sfaadocdt,sfaa002,sfaa005,sfaa006,sfaa007,sfaa010, ",
               "       sfaa012,sfaa013,sfaa061,sfaa016,sfaa017,",
               "       sfaa018,sfaa019,sfaa020",
               "  FROM p100_sfaa "
   PREPARE armp100_sfaa_p FROM l_sql
   DECLARE armp100_sfaa_c CURSOR FOR armp100_sfaa_p   
   LET l_cnt = 1     #160816-00066#4 add
   FOREACH armp100_sfaa_c INTO l_sfaa.sfaa_no,l_sfaa.sfaadocno,l_sfaa.sfaadocdt,l_sfaa.sfaa002,
                               l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa010,
                               l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa061,l_sfaa.sfaa016,l_sfaa.sfaa017,
                               l_sfaa.sfaa018,l_sfaa.sfaa019,l_sfaa.sfaa020
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      LET l_sfaa.sfaa001 = "0"
      LET l_sfaa.sfaa015 = ''
      LET l_sfaa.sfaa062 = "Y"
      LET l_sfaa.sfaa038 = "N"
      LET l_sfaa.sfaa039 = "N"
      LET l_sfaa.sfaa040 = "N"
      LET l_sfaa.sfaa041 = "N"
      LET l_sfaa.sfaa042 = "N"
      LET l_sfaa.sfaa043 = "N"
      LET l_sfaa.sfaa044 = "N"
      LET l_sfaa.sfaa045 = ''
      LET l_sfaa.sfaa046 = ''
      LET l_sfaa.sfaa047 = ''
      LET l_sfaa.sfaa048 = ''
      LET l_sfaa.sfaa049 = "0"
      LET l_sfaa.sfaa050 = "0"
      LET l_sfaa.sfaa051 = "0"
      LET l_sfaa.sfaa055 = "0"
      LET l_sfaa.sfaa056 = "0"
      LET l_sfaa.sfaa003 = '1'
      LET l_sfaa.sfaa057 = '1'
      LET l_sfaa.sfaa065 = '0'
      LET l_sfaa.sfaa070 = ''
      LET l_sfaa.sfaa023 = ''
      
      LET l_sfaa.sfaa001 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa001',l_sfaa.sfaa001)
      LET l_sfaa.sfaa003 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa003',l_sfaa.sfaa003)
      LET l_sfaa.sfaa057 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa057',l_sfaa.sfaa057)
      LET l_sfaa.sfaa002 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa002',l_sfaa.sfaa002)
      LET l_sfaa.sfaa004 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa004',l_sfaa.sfaa004)
      LET l_sfaa.sfaa008 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa008',l_sfaa.sfaa008)
      LET l_sfaa.sfaa063 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa063',l_sfaa.sfaa063)
      LET l_sfaa.sfaa009 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa009',l_sfaa.sfaa009)
      LET l_sfaa.sfaa022 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa022',l_sfaa.sfaa022)
      LET l_sfaa.sfaa023 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa023',l_sfaa.sfaa023)
      LET l_sfaa.sfaa024 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa024',l_sfaa.sfaa024)
      LET l_sfaa.sfaa064 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa064',l_sfaa.sfaa064)
      LET l_sfaa.sfaa021 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa021',l_sfaa.sfaa021)
      LET l_sfaa.sfaa025 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa025',l_sfaa.sfaa025)
      LET l_sfaa.sfaa011 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa011',l_sfaa.sfaa011)
      LET l_sfaa.sfaa058 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa058',l_sfaa.sfaa058)
      LET l_sfaa.sfaa060 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa060',l_sfaa.sfaa060)
      LET l_sfaa.sfaa014 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa014',l_sfaa.sfaa014)
      LET l_sfaa.sfaa028 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa028',l_sfaa.sfaa028)
      LET l_sfaa.sfaa015 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa015',l_sfaa.sfaa015)
      LET l_sfaa.sfaa029 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa029',l_sfaa.sfaa029)
      LET l_sfaa.sfaa026 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa026',l_sfaa.sfaa026)
      LET l_sfaa.sfaa030 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa030',l_sfaa.sfaa030)
      LET l_sfaa.sfaa031 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa031',l_sfaa.sfaa031)
      LET l_sfaa.sfaa062 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa062',l_sfaa.sfaa062)
      LET l_sfaa.sfaa032 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa032',l_sfaa.sfaa032)
      LET l_sfaa.sfaa068 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa068',l_sfaa.sfaa068)
      LET l_sfaa.sfaa033 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa033',l_sfaa.sfaa033)
      LET l_sfaa.sfaa034 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa034',l_sfaa.sfaa034)
      LET l_sfaa.sfaa035 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa035',l_sfaa.sfaa035)
      LET l_sfaa.sfaa059 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa059',l_sfaa.sfaa059)
      LET l_sfaa.sfaa036 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa036',l_sfaa.sfaa036)
      LET l_sfaa.sfaa037 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa037',l_sfaa.sfaa037)
      LET l_sfaa.sfaa038 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa038',l_sfaa.sfaa038)
      LET l_sfaa.sfaa039 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa039',l_sfaa.sfaa039)
      LET l_sfaa.sfaa040 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa040',l_sfaa.sfaa040)
      LET l_sfaa.sfaa041 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa041',l_sfaa.sfaa041)
      LET l_sfaa.sfaa042 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa042',l_sfaa.sfaa042)
      LET l_sfaa.sfaa043 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa043',l_sfaa.sfaa043)
      LET l_sfaa.sfaa044 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa044',l_sfaa.sfaa044)
      LET l_sfaa.sfaa069 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa069',l_sfaa.sfaa069)
      LET l_sfaa.sfaa070 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa070',l_sfaa.sfaa070)
      LET l_sfaa.sfaa065 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa065',l_sfaa.sfaa065)
      LET l_sfaa.sfaa045 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa045',l_sfaa.sfaa045)
      LET l_sfaa.sfaa046 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa046',l_sfaa.sfaa046)
      LET l_sfaa.sfaa049 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa049',l_sfaa.sfaa049)
      LET l_sfaa.sfaa050 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa050',l_sfaa.sfaa050)
      LET l_sfaa.sfaa047 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa047',l_sfaa.sfaa047)
      LET l_sfaa.sfaa051 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa051',l_sfaa.sfaa051)
      LET l_sfaa.sfaa048 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa048',l_sfaa.sfaa048)
      LET l_sfaa.sfaa055 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa055',l_sfaa.sfaa055)
      LET l_sfaa.sfaa056 = s_aooi200_get_doc_default(g_site,'1',l_sfaa.sfaadocno,'sfaa056',l_sfaa.sfaa056) 
   
      CALL s_aooi200_gen_docno(g_site,l_sfaa.sfaadocno,l_sfaa.sfaadocdt,'asft300') 
         RETURNING l_success,l_sfaa.sfaadocno
      LET l_sfaa.sfaa003 = '2'
      LET l_sfaa.sfaa004 = '1'
      LET l_sfaa.sfaa057 = '1'
      
      LET l_sfaa.sfaaownid = g_user
      LET l_sfaa.sfaaowndp = g_dept
      LET l_sfaa.sfaacrtid = g_user
      LET l_sfaa.sfaacrtdp = g_dept
      LET l_sfaa.sfaacrtdt = cl_get_current()
      LET l_sfaa.sfaamodid = g_user
      LET l_sfaa.sfaamoddt = cl_get_current()
      LET l_sfaa.sfaacnfid = '' 
      LET l_sfaa.sfaacnfdt = ''
      LET l_sfaa.sfaapstid = ''
      LET l_sfaa.sfaapstdt = ''
      LET l_sfaa.sfaastus  = 'N'  
      LET l_sfaa.sfaa071   = 0    #160425-00019 by whitney add 齊料套數
      
      EXECUTE sfaa_ins USING g_enterprise,g_site,l_sfaa.sfaadocno,l_sfaa.sfaadocdt,'0',
                             l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,l_sfaa.sfaa057,l_sfaa.sfaa005,
                             l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa061,l_sfaa.sfaa016,
                             l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,l_sfaa.sfaa020,
                             l_sfaa.sfaa008,l_sfaa.sfaa063,l_sfaa.sfaa009,l_sfaa.sfaa022,
                             l_sfaa.sfaa023,l_sfaa.sfaa024,l_sfaa.sfaa064,l_sfaa.sfaa021,l_sfaa.sfaa025,
                             l_sfaa.sfaa011,l_sfaa.sfaa058,l_sfaa.sfaa060,l_sfaa.sfaa014,
                             l_sfaa.sfaa028,l_sfaa.sfaa015,l_sfaa.sfaa029,l_sfaa.sfaa026,l_sfaa.sfaa030,
                             l_sfaa.sfaa031,l_sfaa.sfaa062,l_sfaa.sfaa032,l_sfaa.sfaa068,l_sfaa.sfaa033,
                             l_sfaa.sfaa034,l_sfaa.sfaa035,l_sfaa.sfaa059,l_sfaa.sfaa036,l_sfaa.sfaa037,
                             l_sfaa.sfaa038,l_sfaa.sfaa039,l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,
                             l_sfaa.sfaa043,l_sfaa.sfaa044,l_sfaa.sfaa069,l_sfaa.sfaa070,l_sfaa.sfaa065,
                             l_sfaa.sfaa045,l_sfaa.sfaa046,l_sfaa.sfaa049,l_sfaa.sfaa050,l_sfaa.sfaa047,
                             l_sfaa.sfaa051,l_sfaa.sfaa048,l_sfaa.sfaa055,l_sfaa.sfaa056,                             
                             l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,l_sfaa.sfaacrtdt,
                             l_sfaa.sfaamodid,l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,l_sfaa.sfaapstid,
                             l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaa006,l_sfaa.sfaa007    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_sfaa" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF         
      UPDATE p100_sfaa 
         SET sfaadocno = l_sfaa.sfaadocno
       WHERE sfaa_no = l_sfaa.sfaa_no      
      #160816-00066#4 add-S
      IF l_cnt = 1 THEN    
         LET l_stano = l_sfaa.sfaadocno
      END IF
      LET l_cnt = l_cnt + 1
      #160816-00066#4 add-E
       
      EXECUTE sfba_ins USING l_sfaa.sfaadocno,l_sfaa.sfaa_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_sfba" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF       
      EXECUTE sfab_ins USING l_sfaa.sfaadocno,l_sfaa.sfaa_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_sfab" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF       
      EXECUTE sfac_ins USING l_sfaa.sfaadocno,l_sfaa.sfaa_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_sfac" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF       
   END FOREACH
   IF l_success THEN 
      LET l_sql = "UPDATE rmcb_t a",
                  "   SET a.rmcb010 = a.rmcb010 + (SELECT b.qty FROM p100_rmcb b WHERE a.rmcbdocno = b.rmcbdocno AND a.rmcbseq = b.rmcbseq AND b.sel = 'Y')",
                  " WHERE a.rmcbent = '",g_enterprise,"' AND a.rmcbsite = '",g_site,"'",
                  "   AND EXISTS(SELECT * FROM p100_rmcb b WHERE a.rmcbdocno = b.rmcbdocno AND a.rmcbseq = b.rmcbseq AND b.sel = 'Y')"
      PREPARE upd_rmcb FROM l_sql
      EXECUTE upd_rmcb   
      LET l_sql = "UPDATE rmab_t a",
                  "   SET a.rmab014 = a.rmab014 + (SELECT SUM(b.qty) FROM p100_rmcb b WHERE a.rmabdocno = b.rmcb001 AND a.rmabseq = b.rmcb002 AND b.sel = 'Y')",
                  " WHERE a.rmabent = '",g_enterprise,"' AND a.rmabsite = '",g_site,"'",
                  "   AND EXISTS(SELECT * FROM p100_rmcb b WHERE a.rmabdocno = b.rmcb001 AND a.rmabseq = b.rmcb002 AND b.sel = 'Y')"
      PREPARE upd_rmab FROM l_sql
      EXECUTE upd_rmab       
   END IF
   IF l_success THEN
      #160816-00066#4 add-S
      LET l_endno = l_sfaa.sfaadocno
      #160816-00066#4 add-E
      CALL s_transaction_end('Y','0')
      #160816-00066#4 add-S         #成功产生工单，单据范围：%1,是否开启工单进行查看？
      IF l_stano <> l_endno THEN
         LET l_str = l_stano CLIPPED,'~',l_endno CLIPPED
      ELSE 
         LET l_str = l_stano CLIPPED
      END IF
      IF cl_ask_confirm_parm('arm-00067',l_str) THEN
         IF l_stano <> l_endno THEN
            LET l_str = " (sfaadocno BETWEEN '",l_stano CLIPPED,"' AND '",l_endno CLIPPED,"' )"
         ELSE 
            LET l_str = " sfaadocno = '",l_stano CLIPPED,"' "
         END IF        
         LET la_param.prog = 'asft300'
         LET la_param.param[3] = l_str
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun(ls_js)
      END IF
      #160816-00066#4 add-E
   ELSE
      CALL s_transaction_end('N','0')
      CALL cl_ask_confirm3("adz-00218","")
   END IF
END FUNCTION

PRIVATE FUNCTION armp100_set_entry_b()

   CALL cl_set_comp_entry("sfaa016",TRUE)               
END FUNCTION

PRIVATE FUNCTION armp100_set_no_entry_b()
   IF l_ac > 0 THEN                
      IF g_detail2_d[l_ac].sfaa061 = 'N' THEN 
         CALL cl_set_comp_entry("sfaa016",FALSE)
      END IF  
   END IF 
END FUNCTION

PRIVATE FUNCTION armp100_upd_sfaa()
   IF cl_null(l_ac2) OR l_ac2 = 0 THEN RETURN END IF 
  
   UPDATE p100_sfaa
      SET sfaadocdt = g_detail2_d[l_ac2].sfaadocdt, 
          sfaa002 = g_detail2_d[l_ac2].sfaa002,
          sfaa061 = g_detail2_d[l_ac2].sfaa061,
          sfaa016 = g_detail2_d[l_ac2].sfaa016, 
          sfaa017 = g_detail2_d[l_ac2].sfaa017,
          sfaa019 = g_detail2_d[l_ac2].sfaa019,
          sfaa020 = g_detail2_d[l_ac2].sfaa020
    WHERE sfaa_no = g_detail2_d[l_ac2].sfaa_no
    
END FUNCTION

PRIVATE FUNCTION armp100_upd_sfba()
   IF cl_null(l_ac3) OR l_ac3 = 0 THEN RETURN END IF 
  
   UPDATE p100_sfba
      SET sfba002 = g_detail3_d[l_ac3].sfba002,
          sfba003 = g_detail3_d[l_ac3].sfba003,
          sfba004 = g_detail3_d[l_ac3].sfba004, 
          sfba007 = g_detail3_d[l_ac3].sfba007,
          sfba008 = g_detail3_d[l_ac3].sfba008,
          sfba009 = g_detail3_d[l_ac3].sfba009,
          sfba012 = g_detail3_d[l_ac3].sfba012,
          sfba019 = g_detail3_d[l_ac3].sfba019,
          sfba020 = g_detail3_d[l_ac3].sfba020
    WHERE sfba_no = g_detail3_d[l_ac3].sfba_no
END FUNCTION
##同项次的部位+作业编号+制程序+BOM料号为相同,不同项次不可以有同样的部位+作业编号+制程序+BOM料号
PRIVATE FUNCTION armp100_sfbaseq_chk()
DEFINE l_n1      LIKE type_t.num5

  IF cl_null(g_detail3_d[l_ac3].sfbaseq) THEN
     RETURN TRUE
  END IF 
  IF g_detail3_d[l_ac3].sfba002 IS NULL THEN
     RETURN TRUE
  END IF 
  IF g_detail3_d[l_ac3].sfba003 IS NULL THEN
     RETURN TRUE
  END IF
  IF g_detail3_d[l_ac3].sfba004 IS NULL THEN
     RETURN TRUE
  END IF
  IF g_detail3_d[l_ac3].sfba005 IS NULL THEN
     RETURN TRUE
  END IF

  SELECT COUNT(*) INTO l_n1 
    FROM sfba_t 
   WHERE sfba_no = g_detail3_d[l_ac3].sfba_no
     AND sfba002 = g_detail3_d[l_ac3].sfba002 AND sfba003 = g_detail3_d[l_ac3].sfba003
     AND sfba004 = g_detail3_d[l_ac3].sfba004 AND sfba005 = g_detail3_d[l_ac3].sfba005
     AND sfbaent = g_enterprise #add by geza 20160905 #160905-00007#13
  IF l_n1 > 0 THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'asf-00070'
     LET g_errparam.extend = ''
     LET g_errparam.popup = TRUE
     CALL cl_err()
   
     RETURN FALSE
  END IF

  RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 执行完之后显示单身不让更改
# Date & Author..: 2016/04/26 By xianghui
# Modify.........: 160425-00022#1
################################################################################
PRIVATE FUNCTION armp100_display()
DEFINE l_imae032 LIKE imae_t.imae032
DEFINE l_cnt     LIKE type_t.num10
DEFINE l_sql1          STRING            #160711-00040#28 add
DEFINE l_success LIKE type_t.num5        #160711-00040#28 add
   IF g_detail2_d.getlength() > 0 THEN 
      LET g_detail_idx = 1              
      CALL armp100_b_fill3() 
   END IF 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
         BEFORE DISPLAY 
            LET l_ac2 = g_curr_diag.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac2              
            CALL armp100_b_fill3() 
            
         BEFORE ROW
            LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac2
            CALL armp100_b_fill3()        
          
      END DISPLAY      
      
      CONSTRUCT BY NAME g_master.wc ON rmcadocno,rmcadocdt,rmca003,rmca004,rmcb001
         BEFORE CONSTRUCT
                   
         ON ACTION controlp INFIELD rmcadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmcadocno()                       
            DISPLAY g_qryparam.return1 TO rmcadocno  
            NEXT FIELD rmcadocno                     
       
         ON ACTION controlp INFIELD rmca003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       
            DISPLAY g_qryparam.return1 TO rmca003  
            NEXT FIELD rmca003                     
            
         ON ACTION controlp INFIELD rmca004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                    
            DISPLAY g_qryparam.return1 TO rmca004 
            NEXT FIELD rmca004                    
       
         ON ACTION controlp INFIELD rmcb001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                       
            DISPLAY g_qryparam.return1 TO rmcb001  
            NEXT FIELD rmcb001
      END CONSTRUCT  
      INPUT BY NAME g_master.slip,g_master.date,g_master.check
       
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD slip
            IF NOT cl_null(g_master.slip) THEN
               IF NOT s_aooi200_chk_slip(g_site,'',g_master.slip,'asft300') THEN
                  LET g_master.slip = ''
                  NEXT FIELD CURRENT
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM oobb_t
                WHERE oobbent = g_enterprise
                  AND oobb001 = g_ooef.ooef004
                  AND oobb002 = g_master.slip
                  AND oobb004 = 'sfaa003'
                  AND oobb005 IN ('1','3','4')
                  AND oobb007 = 'N'
               IF l_cnt > 0 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_master.slip
                  LET g_errparam.code   = "arm-00031"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()    
                  LET g_master.slip = ''
                  NEXT FIELD CURRENT                    
               END IF 
            END IF
            
         ON ACTION controlp INFIELD slip
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.slip 
            LET g_qryparam.arg1 = g_ooef.ooef004
            LET g_qryparam.arg2 = 'asft300'
            LET g_qryparam.where = " NOT EXISTS(SELECT * FROM oobb_t WHERE oobaent=oobbent AND ooba001=oobb001 AND ooba002=oobb002 AND oobb004='sfaa003' AND oobb005 IN ('1','3','4') AND oobb007 ='N')"
            #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                              
            LET g_master.slip = g_qryparam.return1              
            NEXT FIELD slip
            
      END INPUT 
      ON ACTION close 
         LET g_action_choice="exit"      
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG

      ON ACTION accept
         CALL armp100_query()
         EXIT DIALOG
         
      #主選單用ACTION
      &include "main_menu_exit_dialog.4gl"
      &include "relating_action.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG         
   END DIALOG             
END FUNCTION

#end add-point
 
{</section>}
 
