#該程式未解開Section, 採用最新樣板產出!
{<section id="armp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-12-05 16:21:27), PR版次:0007(2017-02-17 16:37:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: armp200
#+ Description: RMA轉銷退作業
#+ Creator....: 02295(2015-05-26 14:21:42)
#+ Modifier...: 05423 -SD/PR- 01996
 
{</section>}
 
{<section id="armp200.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#21   2016/04/19  BY 07900    校验代码重复错误讯息的修改
#160816-00001#9    2016/08/17  By 08734    抓取理由碼改CALL sub
#160816-00066#5    2016/11/25  By zhujing  产生单据后提示已产生销退单XXXXX~XXXXXXX，是否开启单据进行查看，选是开启销退单串到相应单
#161125-00049#1    2016/12/05  By zhujing  产生单据后，display段未预设l_acc，l_acc2的值，导致报错：参数传入为空
#161129-00054#1    2016/12/05  By zhujing  单身添加库位储位栏位说明
#161124-00048#10   2016/12/13  By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#160711-00040#28   2017/02/16  By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
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
   xmdkdocno LIKE xmdk_t.xmdkdocno,
   inbadocno LIKE inba_t.inbadocno,
   xmdkdocdt LIKE xmdk_t.xmdkdocdt,
   xmdl014 LIKE xmdl_t.xmdl014,
   xmdl015 LIKE xmdl_t.xmdl015,
   xmdl050 LIKE xmdl_t.xmdl050,
   inba007 LIKE inba_t.inba007,
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
     xmdkdocno LIKE xmdk_t.xmdkdocno,
     xmdkdocdt LIKE xmdk_t.xmdkdocdt,
     xmdk003 LIKE xmdk_t.xmdk003,
     xmdk004 LIKE xmdk_t.xmdk004,
     xmdk007 LIKE xmdk_t.xmdk007,
     xmdk_no LIKE type_t.num5
     END RECORD
TYPE type_g_detail3_d RECORD
     xmdlseq LIKE xmdl_t.xmdlseq,
     xmdl001 LIKE xmdl_t.xmdl001,
     xmdl002 LIKE xmdl_t.xmdl002,
     xmdl003 LIKE xmdl_t.xmdl003,
     xmdl004 LIKE xmdl_t.xmdl004,
     xmdl005 LIKE xmdl_t.xmdl005,
     xmdl006 LIKE xmdl_t.xmdl006,
     xmdl008 LIKE xmdl_t.xmdl008,
     xmdl009 LIKE xmdl_t.xmdl009,
     xmdl094 LIKE xmdl_t.xmdl094,
     xmdl095 LIKE xmdl_t.xmdl095,
     xmdl017 LIKE xmdl_t.xmdl017,
     xmdl018 LIKE xmdl_t.xmdl018,
     xmdl014 LIKE xmdl_t.xmdl014,
     xmdl014_desc LIKE inayl_t.inayl003,  #161129-00054#1 add
     xmdl015 LIKE xmdl_t.xmdl015,
     xmdl015_desc LIKE inab_t.inab003,    #161129-00054#1 add
     xmdl016 LIKE xmdl_t.xmdl016,
     xmdl052 LIKE xmdl_t.xmdl052,
     xmdl022 LIKE xmdl_t.xmdl022,
     xmdl021 LIKE xmdl_t.xmdl021,
     xmdl_no LIKE type_t.num5
     END RECORD

DEFINE g_rec_b  LIKE type_t.num5 
#DEFINE g_ooef   RECORD LIKE ooef_t.* #161124-00048#10 mark
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
DEFINE g_master  type_parameter  
DEFINE g_detail_idx LIKE type_t.num5
DEFINE g_detail_d_t type_g_detail_d
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE l_ac2        LIKE type_t.num10
DEFINE l_ac3        LIKE type_t.num10
DEFINE g_hidden LIKE type_t.num5
DEFINE g_exe    LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="armp200.main" >}
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
      OPEN WINDOW w_armp200 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armp200_init()   
 
      #進入選單 Menu (="N")
      CALL armp200_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_armp200
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="armp200.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION armp200_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
#   SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent= g_enterprise AND ooef001 = g_site #161124-00048#10 mark
   #161124-00048#10 add(s)
   SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,ooef005,ooef006,ooef007,
          ooef008,ooef009,ooef010,ooef011,ooef012,ooef013,ooefownid,ooefowndp,
          ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,ooefmoddt,ooef014,ooef015,ooef016,
          ooef017,ooef018,ooef019,ooef020,ooef021,ooef022,ooef003,ooef023,ooef024,
          ooef025,ooef026,ooef100,ooef101,ooef102,ooef103,ooef104,ooef105,ooef106,
          ooef107,ooef108,ooef109,ooef110,ooef111,ooef112,ooef113,ooef114,ooef115,
          ooef120,ooef121,ooef122,ooef123,ooef124,ooef125,ooef150,ooef151,ooef152,
          ooef153,ooef154,ooef155,ooef156,ooef157,ooef158,ooef159,ooef160,ooef161,
          ooef162,ooef163,ooef164,ooef165,ooef166,ooef167,ooef168,ooef169,ooef170,
          ooef171,ooef172,ooef173,ooefunit,ooef200,ooef201,ooef202,ooef203,ooef204,
          ooef205,ooef206,ooef207,ooef208,ooef209,ooef210,ooef211,ooef212,ooef213,
          ooef214,ooef215,ooef216,ooef217,ooef301,ooef302,ooef303,ooef304,ooef305,
          ooef306,ooef307,ooef308,ooef309,ooef310,ooef126,ooef127,ooef128,ooef116 
     INTO g_ooef.* FROM ooef_t WHERE ooefent= g_enterprise AND ooef001 = g_site
   #161124-00048#10 add(e)
   LET g_hidden = TRUE
   LET g_exe = TRUE
   LET g_master.xmdkdocdt = g_today
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armp200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armp200_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_type       LIKE type_t.chr1
   DEFINE l_inaa007    LIKE inaa_t.inaa007
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_ooba015    LIKE ooba_t.ooba015
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   DEFINE l_acc        LIKE gzcb_t.gzcb007
   DEFINE l_acc2       LIKE gzcb_t.gzcb007
   DEFINE l_flag       LIKE type_t.chr1
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql1          STRING            #160711-00040#28 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL cl_set_comp_visible('detail2',FALSE)
   #160816-00001#9  2016/08/17  By 08734 Mark
  # SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint301'
  # SELECT gzcb004 INTO l_acc2 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'axmt600'
   LET l_acc = s_fin_get_scc_value('24','aint301','2')  #160816-00001#9  2016/08/17  By 08734 add
   LET l_acc2 = s_fin_get_scc_value('24','axmt600','2')  #160816-00001#9  2016/08/17  By 08734 add
   LET g_errshow = 1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armp200_init()
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
         INPUT BY NAME g_master.xmdkdocno,g_master.inbadocno,g_master.xmdkdocdt,g_master.xmdl014,
                       g_master.xmdl015,g_master.inba007,g_master.xmdl050
            ATTRIBUTE(WITHOUT DEFAULTS)        

            AFTER FIELD xmdkdocno
               IF NOT cl_null(g_master.xmdkdocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_master.xmdkdocno,'axmt600') THEN
                     LET g_master.xmdkdocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF

            AFTER FIELD inbadocno
               IF NOT cl_null(g_master.inbadocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_master.inbadocno,'aint301') THEN
                     LET g_master.inbadocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               
            AFTER FIELD xmdl014
               IF NOT cl_null(g_master.xmdl014)THEN               
                                 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                      
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_master.xmdl014    #庫位
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end         
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_master.xmdl014 = ''
                     NEXT FIELD CURRENT
                  END IF
                  LET l_inaa007 = ''
                  SELECT inaa007 INTO l_inaa007
                    FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_site
                     AND inaa001 = g_master.xmdl014
                  CALL cl_set_comp_entry("xmdl015",TRUE)
                  CALL cl_set_comp_required("xmdl015",FALSE)
                  IF l_inaa007 = '5' THEN 
                     CALL cl_set_comp_entry("xmdl015",FALSE)
                     LET g_master.xmdl015 = ''
                  ELSE
                     CALL cl_set_comp_required("xmdl015",TRUE)
                  END IF
                  IF NOT cl_null(g_master.xmdl015) THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                                    
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = g_master.xmdl014
                     LET g_chkparam.arg3 = g_master.xmdl015
                     #160318-00025#21  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     #160318-00025#21  by 07900 --add-end                  
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_inab002") THEN
                        LET g_master.xmdl014 = ''
                        NEXT FIELD CURRENT
                     END IF    
                  END IF                   
               END IF
               
            AFTER FIELD xmdl015 
               IF NOT cl_null(g_master.xmdl015) THEN
                  IF cl_null(g_master.xmdl015) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00126'    #庫位不可為空
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_master.xmdl014
                  LET g_chkparam.arg3 = g_master.xmdl015
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_master.xmdl015 = ''
                     NEXT FIELD CURRENT
                  END IF    
               END IF  
            
            AFTER FIELD xmdl050
               IF NOT cl_null(g_master.xmdl050) THEN              
                  IF NOT s_azzi650_chk_exist(l_acc2,g_master.xmdl050) THEN
                     LET g_master.xmdl050 = ''
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的理由碼是否在單據別限制範圍內
                  CALL s_control_chk_doc('8',g_master.xmdkdocno,g_master.xmdl050,'','','','')
                  RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_master.xmdl050 = ''
                     NEXT FIELD CURREN
                  END IF                  
               END IF            
            AFTER FIELD inba007
               IF NOT cl_null(g_master.inba007) THEN              
                  IF NOT s_azzi650_chk_exist(l_acc,g_master.inba007) THEN
                     LET g_master.inba007 = ''
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的理由碼是否在單據別限制範圍內
                  CALL s_control_chk_doc('8',g_master.inbadocno,g_master.inba007,'','','','')
                  RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_master.inba007 = ''
                     NEXT FIELD CURRENT
                  END IF                  
               END IF   
               
            ON ACTION controlp INFIELD xmdl050
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
		      	#獲取參照表編號
		      	LET l_ooef004 = ''
		      	SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef005 = g_site
		      	
		      	LET l_n = 0
		      	SELECT COUNT(oobi003) INTO l_n FROM ooba_t,oobi_t WHERE oobaent=oobient AND ooba001=oobi001 AND ooba002=oobi002 
                       AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.xmdkdocno
		      	IF l_n > 0 THEN
		      	   #判斷是正向列表還是負向列表
		      	   LET l_ooba015 = ''
		      	   SELECT ooba015 INTO l_ooba015 FROM ooba_t
		      	     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.xmdkdocno
                     #正向列表
                     IF l_ooba015 = '1' THEN
                        LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.xmdkdocno,"')"
                     END IF
                     
                     #負向列表
                     IF l_ooba015 = '2' THEN
                        LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.xmdkdocno,"')"
                     END IF
                  END IF
                  LET g_qryparam.default1 = g_master.xmdl050      #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = l_acc2 #
                  CALL q_oocq002()                                #呼叫開窗         
                  LET g_master.xmdl050 = g_qryparam.return1        #將開窗取得的值回傳到變數          
                  DISPLAY g_master.xmdl050 TO xmdl050              #顯示到畫面上        
                  NEXT FIELD xmdl050 
                  
            ON ACTION controlp INFIELD inba007
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
		      	#獲取參照表編號
		      	LET l_ooef004 = ''
		      	SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef005 = g_site
		      	
		      	LET l_n = 0
		      	SELECT COUNT(oobi003) INTO l_n FROM ooba_t,oobi_t WHERE oobaent=oobient AND ooba001=oobi001 AND ooba002=oobi002 
                       AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.inbadocno
		      	IF l_n > 0 THEN
		      	   #判斷是正向列表還是負向列表
		      	   LET l_ooba015 = ''
		      	   SELECT ooba015 INTO l_ooba015 FROM ooba_t
		      	     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.inbadocno
                     #正向列表
                     IF l_ooba015 = '1' THEN
                        LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.inbadocno,"')"
                     END IF
                     
                     #負向列表
                     IF l_ooba015 = '2' THEN
                        LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.inbadocno,"')"
                     END IF
                  END IF
                  LET g_qryparam.default1 = g_master.inba007      #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = l_acc #
                  CALL q_oocq002()                                #呼叫開窗         
                  LET g_master.inba007 = g_qryparam.return1        #將開窗取得的值回傳到變數          
                  DISPLAY g_master.inba007 TO inba007              #顯示到畫面上        
                  NEXT FIELD inba007 


            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xmdkdocno 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'axmt600'
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_master.xmdkdocno = g_qryparam.return1              
               NEXT FIELD xmdkdocno

            ON ACTION controlp INFIELD inbadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.inbadocno 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'aint301'
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_master.inbadocno = g_qryparam.return1              
               NEXT FIELD inbadocno

            ON ACTION controlp INFIELD xmdl014
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xmdl014 
               LET g_qryparam.arg1 = g_site
               CALL q_inaa001_4()                              
               LET g_master.xmdl014 = g_qryparam.return1              
               NEXT FIELD xmdl014
               
            ON ACTION controlp INFIELD xmdl015
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xmdl015 
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = g_master.xmdl014
               CALL q_inab002_8()                              
               LET g_master.xmdl015 = g_qryparam.return1              
               NEXT FIELD xmdl015               
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
            
            ON CHANGE b_sel 
               CALL armp200_upd_rmcb()
               
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
               CALL armp200_upd_rmcb() 
               
            ON ROW CHANGE 
               CALL armp200_upd_rmcb()               
               
         END INPUT
         
         INPUT ARRAY g_detail2_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT 
               CALL armp200_upd_xmdl()            
               CALL armp200_b_fill2()
               LET l_ac2 = g_curr_diag.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac2
               IF g_detail_idx > g_detail2_d.getLength() THEN
                  LET g_detail_idx = g_detail2_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_detail2_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF               
               
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac2
               DISPLAY l_ac2 TO FORMONLY.h_index
               CALL armp200_b_fill3()               
            
            AFTER FIELD xmdkdocno_1            
               IF NOT cl_null(g_detail2_d[l_ac2].xmdkdocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_detail2_d[l_ac2].xmdkdocno,'axmt600') THEN
                     LET g_detail2_d[l_ac2].xmdkdocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            ON ACTION controlp INFIELD xmdkdocno_1
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail2_d[l_ac2].xmdkdocno 
               LET g_qryparam.arg1 = g_ooef.ooef004
               LET g_qryparam.arg2 = 'axmt600'
               #160711-00040#28 add(s)
               CALL s_control_get_docno_sql(g_user,g_dept)
                   RETURNING l_success,l_sql1
               IF NOT cl_null(l_sql1) THEN
                  LET g_qryparam.where = l_sql1
               END IF
               #160711-00040#28 add(e)
               CALL q_ooba002_1()                              
               LET g_detail2_d[l_ac2].xmdkdocno = g_qryparam.return1              
               NEXT FIELD xmdkdocno_1
               
            ON ROW CHANGE
               CALL armp200_upd_xmdk()
            AFTER ROW  
               CALL armp200_upd_xmdk()            
         END INPUT  
         
         INPUT ARRAY g_detail3_d FROM s_detail3.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE) 
                     
            BEFORE INPUT 
               CALL armp200_upd_xmdk()            
               CALL FGL_SET_ARR_CURR(l_ac3)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3") 
               
            BEFORE ROW
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac3 TO FORMONLY.h_index 
               IF NOT cl_null(g_detail3_d[l_ac3].xmdl014) THEN 
                  CALL cl_set_comp_entry("xmdl015_1",TRUE)
                  IF NOT s_axmt540_inaa007_chk(g_detail3_d[l_ac3].xmdl014) THEN 
                     LET g_detail3_d[l_ac3].xmdl015 = ' '
                     CALL cl_set_comp_entry("xmdl015_1",FALSE)
                  END IF
               END IF   
            AFTER FIELD xmdl014_1 
               IF NOT cl_null(g_detail3_d[l_ac3].xmdl014)THEN
                  #得出來源成本庫否
                  CALL s_axmt600_warehouse_cost(g_detail3_d[l_ac3].xmdl001,g_detail3_d[l_ac3].xmdl002)
                  RETURNING l_type                  
                                 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                 
                  #替換錯誤訊息
                  LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
                           
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_detail3_d[l_ac3].xmdl014    #庫位
                  LET g_chkparam.arg3 = l_type
                           
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001_6") THEN
                     LET g_detail3_d[l_ac3].xmdl014 = ''
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的庫位(From)是否在單據別限制範圍內
                  IF NOT cl_null(g_master.xmdkdocno) THEN
                     CALL s_control_chk_doc('6',g_master.xmdkdocno,g_detail3_d[l_ac3].xmdl014,'','','','')
                     RETURNING l_success,l_flag
                     IF NOT l_success OR NOT l_flag THEN
                        LET g_detail3_d[l_ac3].xmdl014 = ''
                        LET g_detail3_d[l_ac3].xmdl014_desc = ''  #161129-00054#1 add
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  IF NOT cl_null(g_detail3_d[l_ac3].xmdl015) THEN                  
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                                    
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = g_detail3_d[l_ac3].xmdl014
                     LET g_chkparam.arg3 = g_detail3_d[l_ac3].xmdl015
                    #160318-00025#21  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     #160318-00025#21  by 07900 --add-end                    
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_inab002") THEN
                        LET g_detail3_d[l_ac3].xmdl015 = ''
                        LET g_detail3_d[l_ac3].xmdl015_desc = ''  #161129-00054#1 add
                        NEXT FIELD CURRENT
                     END IF    
                  END IF 
                  CALL cl_set_comp_entry("xmdl015_1",TRUE)
                  IF NOT s_axmt540_inaa007_chk(g_detail3_d[l_ac3].xmdl014) THEN 
                     LET g_detail3_d[l_ac3].xmdl015 = ' '
                     LET g_detail3_d[l_ac3].xmdl015_desc = ''  #161129-00054#1 add
                     CALL cl_set_comp_entry("xmdl015_1",FALSE)
                  END IF
                  #161129-00054#1 add-S
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_detail3_d[l_ac3].xmdl014
                  CALL ap_ref_array2(g_ref_fields," SELECT inayl003 FROM inayl_t WHERE inaylent = '"||g_enterprise||"' AND inayl001 = ? AND inayl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
                  LET g_detail3_d[l_ac3].xmdl014_desc = g_rtn_fields[1] 
                  #161129-00054#1 add-E                  
               END IF
               
            AFTER FIELD xmdl015_1 
               IF NOT cl_null(g_detail3_d[l_ac3].xmdl015) THEN
                  IF cl_null(g_detail3_d[l_ac3].xmdl014) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00126'    #庫位不可為空
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_detail3_d[l_ac3].xmdl014
                  LET g_chkparam.arg3 = g_detail3_d[l_ac3].xmdl015
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end                   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_detail3_d[l_ac3].xmdl015 = ''
                     LET g_detail3_d[l_ac3].xmdl015_desc = ''  #161129-00054#1 add
                     NEXT FIELD CURRENT
                  END IF  
                   #161129-00054#1 add-S
                   INITIALIZE g_ref_fields TO NULL 
                   LET g_ref_fields[1] = g_detail3_d[l_ac3].xmdl014
                   LET g_ref_fields[2] = g_detail3_d[l_ac3].xmdl015
                   CALL ap_ref_array2(g_ref_fields," SELECT inab003 FROM inab_t WHERE inabent = '"||g_enterprise||"' AND inab001 = ? AND inab002 = ? ","") RETURNING g_rtn_fields 
                   LET g_detail3_d[l_ac3].xmdl015_desc = g_rtn_fields[1] 
                   #161129-00054#1 add-E  
               END IF    
               
            AFTER FIELD xmdl021
               IF NOT cl_null(g_detail3_d[l_ac3].xmdl021) THEN
                  IF NOT s_axmt540_unit_chk(g_detail3_d[l_ac3].xmdl008,g_detail3_d[l_ac3].xmdl021) THEN
                     LET g_detail3_d[l_ac3].xmdl021 = ''
                     #CALL s_desc_get_unit_desc(g_xmdl_d[l_ac3].xmdl017) RETURNING g_xmdl_d[l_ac3].xmdl017_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF                  
            AFTER FIELD xmdl022
               IF NOT cl_null(g_detail3_d[l_ac3].xmdl022) AND NOT cl_null(g_detail3_d[l_ac3].xmdl021) THEN
                  CALL s_aooi250_take_decimals(g_detail3_d[l_ac3].xmdl021,g_detail3_d[l_ac3].xmdl022) RETURNING l_success,g_detail3_d[l_ac3].xmdl022
               END IF
            
            ON ACTION controlp INFIELD xmdl014_1
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].xmdl014
               CALL s_axmt600_warehouse_cost(g_detail3_d[l_ac3].xmdl001,g_detail3_d[l_ac3].xmdl002)
                  RETURNING l_type 
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.where = "inaa010 = '",l_type,"'"
               CALL q_inaa001_4()                              
               LET g_detail3_d[l_ac3].xmdl014 = g_qryparam.return1              
               NEXT FIELD xmdl014_1
               
            ON ACTION controlp INFIELD xmdl015_1
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].xmdl015 
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = g_detail3_d[l_ac3].xmdl014
               CALL q_inab002_8()                              
               LET g_detail3_d[l_ac3].xmdl015  = g_qryparam.return1              
               NEXT FIELD xmdl015_1 

            ON ACTION controlp INFIELD xmdl021
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail3_d[l_ac3].xmdl021 
               CALL q_ooca001_1()                              
               LET g_detail3_d[l_ac3].xmdl021 = g_qryparam.return1              
               NEXT FIELD xmdl021
               
            ON ROW CHANGE
               CALL armp200_upd_xmdl()               
            AFTER ROW   
               CALL armp200_upd_xmdl()
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
            CALL armp200_filter()
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
            CALL armp200_query()
            NEXT FIELD xmdkdocno
            #end add-point
            CALL armp200_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL armp200_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION btn_next
            IF g_detail_d.getLength() = 0 THEN 
               CONTINUE DIALOG
            END IF            
            IF g_hidden THEN 
               CALL cl_set_comp_visible('detail',FALSE)
               CALL cl_set_comp_visible('detail2',TRUE)
               LET g_hidden = FALSE
            END IF
            CALL armp200_upd_rmcb()
            CALL armp200_ins_temp()
            CALL armp200_b_fill2()
            IF g_detail2_d.getLength() <> 0 THEN 
               LET g_detail_idx = 1
            END IF          
            CALL armp200_b_fill3()            
            NEXT FIELD xmdl014_1
         
         ON ACTION btn_pre
            IF NOT g_hidden THEN 
               CALL cl_set_comp_visible('detail',TRUE)
               CALL cl_set_comp_visible('detail2',FALSE)
               LET g_hidden = TRUE
               LET g_exe = TRUE
            END IF         
            NEXT FIELD xmdkdocno
            
         ON ACTION btn_exe
            IF g_exe THEN
               CALL armp200_upd_xmdl()
               CALL armp200_execute() 
               CALL armp200_b_fill2()
               LET g_exe = FALSE
               CALL armp200_display()
            END IF 
            IF NOT g_hidden THEN 
               CALL cl_set_comp_visible('detail',TRUE)
               CALL cl_set_comp_visible('detail2',FALSE)
               LET g_hidden = TRUE
               LET g_exe = TRUE
            END IF             
            EXIT DIALOG            
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
 
{<section id="armp200.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION armp200_query()
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
   CALL armp200_drop_table()
   CALL armp200_create_table()
   IF cl_null(g_master.wc) THEN 
      LET g_master.wc = '1=1'
   END IF 
   LET l_sql = " INSERT INTO p200_rmcb ",
               " SELECT 'N',rmcbdocno,rmcbseq,rmcb001,rmcb002, ",
               "        rmcb003,rmcb004,rmcb005,rmcb006,",
               "        rmcb007,rmcb010,rmcb007-rmcb010 ",
               "   FROM rmca_t,rmcb_t ",
               "  WHERE rmcaent = rmcbent AND rmcadocno = rmcbdocno ",
               "    AND rmcaent = '",g_enterprise,"'",
               "    AND rmcasite = '",g_site,"'",
               "    AND rmcb009 = '2' ",
               "    AND rmcastus = 'Y'",
               "    AND rmcb007-rmcb010 > 0 ",
               "    AND ",g_master.wc
   PREPARE p200_ins_rmcb FROM l_sql
   EXECUTE p200_ins_rmcb 
   #end add-point
        
   LET g_error_show = 1
   CALL armp200_b_fill()
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
 
{<section id="armp200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armp200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT 'N',rmcbdocno,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004, ",
               "        imaal003,imaal004,rmcb005,rmcb006,oocal003,",
               "        rmcb007,rmcb010,qty ",
               "   FROM p200_rmcb ",
               "        LEFT OUTER JOIN imaal_t ON imaalent = '",g_enterprise,"' AND rmcb004=imaal001 AND imaal002='",g_dlang,"'",
               "        LEFT OUTER JOIN oocal_t ON oocalent = ? AND rmcb006=oocal001 AND oocal002='",g_dlang,"'"  
   #end add-point
 
   PREPARE armp200_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR armp200_sel
   
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
      
      CALL armp200_detail_show()      
 
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
   FREE armp200_sel
   
   LET l_ac = 1
   CALL armp200_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="armp200.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armp200_fetch()
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
 
{<section id="armp200.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION armp200_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="armp200.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION armp200_filter()
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
   
   CALL armp200_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="armp200.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION armp200_filter_parser(ps_field)
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
 
{<section id="armp200.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION armp200_filter_show(ps_field,ps_object)
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
   LET ls_condition = armp200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION armp200_create_table()
   
   WHENEVER ERROR CONTINUE     

   CREATE TEMP TABLE p200_rmcb(
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

   #销退单单头
   CREATE TEMP TABLE p200_xmdk(
     xmdkdocno  VARCHAR(20),
     xmdkdocdt  DATE,
     xmdk003  VARCHAR(20),
     xmdk004  VARCHAR(10),
     xmdk007  VARCHAR(10),
     xmdk086  VARCHAR(20),
     xmdk_no  SMALLINT);
    
   #销退单单身    
   CREATE TEMP TABLE p200_xmdl(
     xmdlseq  INTEGER,
     xmdl001  VARCHAR(20),
     xmdl002  INTEGER,
     xmdl003  VARCHAR(20),
     xmdl004  INTEGER,
     xmdl005  INTEGER,
     xmdl006  INTEGER,
     xmdl008  VARCHAR(40),
     xmdl009  VARCHAR(256),
     xmdl094  VARCHAR(20),
     xmdl095  INTEGER,
     xmdl017  VARCHAR(10),
     xmdl018  DECIMAL(20,6),
     xmdl014  VARCHAR(10),
     xmdl015  VARCHAR(10),
     xmdl016  VARCHAR(30),
     xmdl052  VARCHAR(30),
     xmdl022  DECIMAL(20,6),
     xmdl021  VARCHAR(10),
     xmdl050  VARCHAR(10),
     xmdl019  VARCHAR(10),
     xmdl020  DECIMAL(20,6),
     xmdl_no  SMALLINT);
     
   #杂发单单头
   CREATE TEMP TABLE p200_inba(
     inbadocno  VARCHAR(20),
     inbadocdt  DATE,
     inba001  VARCHAR(10),
     inba002  DATE,
     inba003  VARCHAR(20),
     inba004  VARCHAR(10),
     inba005  VARCHAR(10),
     inba006  VARCHAR(20),
     inba007  VARCHAR(10),
     inba_no  SMALLINT);

   #杂发单单身
   CREATE TEMP TABLE p200_inbb(
     inbbseq  INTEGER,
     inbb001  VARCHAR(40),
     inbb002  VARCHAR(256),
     inbb003  VARCHAR(30),
     inbb004  VARCHAR(40),
     inbb007  VARCHAR(10),
     inbb008  VARCHAR(10),
     inbb009  VARCHAR(30),
     inbb010  VARCHAR(10),
     inbb011  DECIMAL(20,6),
     inbb012  DECIMAL(20,6),
     inbb013  VARCHAR(10),
     inbb014  DECIMAL(20,6),
     inbb015  DECIMAL(20,6),
     inbb016  VARCHAR(10),
     inbb_no  SMALLINT);   
   
END FUNCTION

PRIVATE FUNCTION armp200_drop_table()
   DROP TABLE p200_rmcb;
   DROP TABLE p200_xmdk;
   DROP TABLE p200_xmdl;
END FUNCTION

PRIVATE FUNCTION armp200_upd_rmcb()
   IF cl_null(l_ac) OR l_ac = 0 THEN RETURN END IF 
  
   UPDATE p200_rmcb
      SET sel = g_detail_d[l_ac].sel, 
          qty = g_detail_d[l_ac].qty
    WHERE rmcbdocno = g_detail_d[l_ac].rmcbdocno
      AND rmcbseq = g_detail_d[l_ac].rmcbseq 
END FUNCTION

PRIVATE FUNCTION armp200_ins_temp()
DEFINE l_sql STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_cnt LIKE type_t.num5
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
DEFINE l_xmdk RECORD
     xmdkdocno LIKE xmdk_t.xmdkdocno,
     xmdkdocdt LIKE xmdk_t.xmdkdocdt,
     xmdk003 LIKE xmdk_t.xmdk003,
     xmdk004 LIKE xmdk_t.xmdk004,
     xmdk007 LIKE xmdk_t.xmdk007,
     xmdk086 LIKE xmdk_t.xmdk086,
     xmdk_no LIKE type_t.num5
     END RECORD
DEFINE l_xmdl RECORD
     xmdlseq LIKE xmdl_t.xmdlseq,
     xmdl001 LIKE xmdl_t.xmdl001,
     xmdl002 LIKE xmdl_t.xmdl002,
     xmdl003 LIKE xmdl_t.xmdl003,
     xmdl004 LIKE xmdl_t.xmdl004,
     xmdl005 LIKE xmdl_t.xmdl005,
     xmdl006 LIKE xmdl_t.xmdl006,
     xmdl008 LIKE xmdl_t.xmdl008,
     xmdl009 LIKE xmdl_t.xmdl009,
     xmdl094 LIKE xmdl_t.xmdl094,
     xmdl095 LIKE xmdl_t.xmdl095,
     xmdl017 LIKE xmdl_t.xmdl017,
     xmdl018 LIKE xmdl_t.xmdl018,
     xmdl014 LIKE xmdl_t.xmdl014,
     xmdl015 LIKE xmdl_t.xmdl015,
     xmdl016 LIKE xmdl_t.xmdl016,
     xmdl052 LIKE xmdl_t.xmdl052,
     xmdl022 LIKE xmdl_t.xmdl022,
     xmdl021 LIKE xmdl_t.xmdl021,
     xmdl050 LIKE xmdl_t.xmdl050,
     xmdl019 LIKE xmdl_t.xmdl019,  #151213-00001#3 add by lixh 20160218
     xmdl020 LIKE xmdl_t.xmdl020,     
     xmdl_no LIKE type_t.num5

     END RECORD

   #杂发单单头
DEFINE l_inba RECORD
     inbadocno LIKE inba_t.inbadocno,
     inbadocdt LIKE inba_t.inbadocdt,
     inba001 LIKE inba_t.inba001,
     inba002 LIKE inba_t.inba002,
     inba003 LIKE inba_t.inba003,
     inba004 LIKE inba_t.inba004,
     inba005 LIKE inba_t.inba005,
     inba006 LIKE inba_t.inba006,
     inba007 LIKE inba_t.inba007,
     inba_no LIKE type_t.num5
   END RECORD
   #杂发单单身
DEFINE l_inbb RECORD
     inbbseq LIKE inbb_t.inbbseq,
     inbb001 LIKE inbb_t.inbb001,
     inbb002 LIKE inbb_t.inbb002,
     inbb003 LIKE inbb_t.inbb003,
     inbb004 LIKE inbb_t.inbb004,
     inbb007 LIKE inbb_t.inbb007,
     inbb008 LIKE inbb_t.inbb008,
     inbb009 LIKE inbb_t.inbb009,
     inbb010 LIKE inbb_t.inbb010,
     inbb011 LIKE inbb_t.inbb011,
     inbb012 LIKE inbb_t.inbb012,
     inbb013 LIKE inbb_t.inbb013,
     inbb014 LIKE inbb_t.inbb014,
     inbb015 LIKE inbb_t.inbb015,
     inbb016 LIKE inbb_t.inbb016,
     inbb_no LIKE type_t.num5
   END RECORD
DEFINE l_xmdk007_t   LIKE xmdk_t.xmdk007


   DELETE FROM p200_xmdk;
   DELETE FROM p200_xmdl;
   DELETE FROM p200_inba;
   DELETE FROM p200_inbb;
   
   
   LET l_xmdk007_t = ''
   LET l_cnt = 1  
   LET l_sql = " SELECT rmcbdocno,rmcbseq,rmcb001,rmcb002,rmcb003,",
               "        rmcb004,rmcb005,rmcb006,rmcb007,rmcb010,qty ",
               "   FROM p200_rmcb ",
               "  WHERE sel = 'Y' ",
               "  ORDER BY rmcb001 "
   PREPARE p200_rmcb_pre FROM l_sql
   DECLARE p200_rmcb_cur CURSOR FOR p200_rmcb_pre
   FOREACH p200_rmcb_cur INTO l_rmcb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      SELECT rmaa001 INTO l_xmdk.xmdk007
        FROM rmaa_t
       WHERE rmaaent = g_enterprise
         AND rmaadocno = l_rmcb.rmcb001
         
      IF cl_null(l_xmdk007_t) OR l_xmdk007_t <> l_xmdk.xmdk007 THEN 
         LET l_cnt  = l_cnt + 1
         LET l_xmdk.xmdkdocno = g_master.xmdkdocno
         LET l_xmdk.xmdkdocdt = g_master.xmdkdocdt
         LET l_xmdk.xmdk003 = g_user
         LET l_xmdk.xmdk004 = g_dept
         SELECT rmaa001 INTO l_xmdk.xmdk007
           FROM rmaa_t
          WHERE rmaaent = g_enterprise
            AND rmaadocno = l_rmcb.rmcb001  
         LET l_xmdk.xmdk086 = l_rmcb.rmcbdocno            
         LET l_xmdk.xmdk_no = l_cnt
         INSERT INTO p200_xmdk VALUES (l_xmdk.*) 


         #杂发单
         LET l_inba.inbadocno = g_master.inbadocno
         LET l_inba.inbadocdt = g_master.xmdkdocdt
         LET l_inba.inba001 = '1'
         LET l_inba.inba002 = g_master.xmdkdocdt
         LET l_inba.inba003 = g_user
         LET l_inba.inba004 = g_dept
         LET l_inba.inba005 = '10'
         LET l_inba.inba006 = ''
         LET l_inba.inba007 = g_master.inba007
         LET l_inba.inba_no = l_cnt
       
         INSERT INTO p200_inba VALUES(l_inba.*)

        LET l_xmdk007_t = l_xmdk.xmdk007
      END IF
      
      
      
      ##新增備料明細
      SELECT MAX(xmdlseq) INTO l_xmdl.xmdlseq
        FROM p200_xmdl
       WHERE xmdl_no = l_cnt 
      IF cl_null(l_xmdl.xmdlseq) THEN 
         LET l_xmdl.xmdlseq = 1
      ELSE
         LET l_xmdl.xmdlseq = l_xmdl.xmdlseq + 1      
      END IF   

      SELECT rmab003,rmab004,rmab005,rmab006,rmab007,rmab008
        INTO l_xmdl.xmdl001,l_xmdl.xmdl002,l_xmdl.xmdl003,
             l_xmdl.xmdl004,l_xmdl.xmdl005,l_xmdl.xmdl006
        FROM rmab_t
       WHERE rmabent = g_enterprise
         AND rmabdocno = l_rmcb.rmcb001
         AND rmabseq = l_rmcb.rmcb002
         
      LET l_xmdl.xmdl008 = l_rmcb.rmcb004
      LET l_xmdl.xmdl009 = l_rmcb.rmcb005
      LET l_xmdl.xmdl094 = l_rmcb.rmcbdocno
      LET l_xmdl.xmdl095 = l_rmcb.rmcbseq
      LET l_xmdl.xmdl014 = g_master.xmdl014
      LET l_xmdl.xmdl015 = g_master.xmdl015
      LET l_xmdl.xmdl015 = ' '
      LET l_xmdl.xmdl017 = l_rmcb.rmcb006
      LET l_xmdl.xmdl018 = l_rmcb.qty
      LET l_xmdl.xmdl050 = g_master.xmdl050
      
      SELECT rmac002,rmac003,rmac004,rmac005
        INTO l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb009,l_xmdl.xmdl052
        FROM rmac_t
       WHERE rmacent = g_enterprise
         AND rmacdocno = l_rmcb.rmcb001
         AND rmacseq = l_rmcb.rmcb002
         AND rmacseq1 = l_rmcb.rmcb003
         
      LET l_xmdl.xmdl022 = l_rmcb.qty
      LET l_xmdl.xmdl021 = l_rmcb.rmcb006
      LET l_xmdl.xmdl050 = g_master.xmdl050
      LET l_xmdl.xmdl_no = l_cnt 
      #151213-00001#3 add by lixh 20160218
      SELECT imaf015 INTO l_xmdl.xmdl019 FROM imaf_t 
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = l_xmdl.xmdl008
      IF NOT cl_null(l_xmdl.xmdl019) THEN  
         CALL s_aooi250_convert_qty(l_xmdl.xmdl008,l_xmdl.xmdl017,l_xmdl.xmdl019,l_xmdl.xmdl018)
                       RETURNING l_success,l_xmdl.xmdl020 
      END IF        
      IF cl_null(l_xmdl.xmdl020) THEN LET l_xmdl.xmdl020 = 0 END IF    
      #151213-00001#3 add by lixh 20160218
      INSERT INTO p200_xmdl VALUES(l_xmdl.*)

      LET l_inbb.inbbseq = g_master.inbadocno
      SELECT MAX(inbbseq) INTO l_inbb.inbbseq
        FROM p200_inbb
       WHERE inbb_no = l_cnt 
      IF cl_null(l_inbb.inbbseq) THEN 
         LET l_inbb.inbbseq = 1
      ELSE
         LET l_inbb.inbbseq = l_inbb.inbbseq + 1      
      END IF       
      LET l_inbb.inbb001 = l_xmdl.xmdl008
      LET l_inbb.inbb002 = l_xmdl.xmdl009
      LET l_inbb.inbb003 = l_xmdl.xmdl052
      LET l_inbb.inbb004 = ''
      LET l_inbb.inbb010 = l_xmdl.xmdl017
      LET l_inbb.inbb011 = l_xmdl.xmdl018
      LET l_inbb.inbb012 = l_xmdl.xmdl018
      LET l_inbb.inbb013 = l_xmdl.xmdl017
      LET l_inbb.inbb014 = l_xmdl.xmdl018    
      LET l_inbb.inbb015 = l_xmdl.xmdl018
      LET l_inbb.inbb016 = g_master.inba007
      LET l_inbb.inbb_no = l_cnt
    
      INSERT INTO p200_inbb VALUES(l_inbb.*)
   END FOREACH   
END FUNCTION

PRIVATE FUNCTION armp200_execute()
DEFINE l_sql STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_xmdk RECORD
     xmdkdocno LIKE xmdk_t.xmdkdocno,
     xmdkdocdt LIKE xmdk_t.xmdkdocdt,
     xmdk003 LIKE xmdk_t.xmdk003,
     xmdk004 LIKE xmdk_t.xmdk004,
     xmdk007 LIKE xmdk_t.xmdk007,
     xmdk_no LIKE type_t.num5,
     xmdk001 LIKE xmdk_t.xmdk001,
     xmdk002 LIKE xmdk_t.xmdk002,
     xmdk005 LIKE xmdk_t.xmdk005,
     xmdk006 LIKE xmdk_t.xmdk006,
     xmdk008 LIKE xmdk_t.xmdk008,
     xmdk009 LIKE xmdk_t.xmdk009,
     xmdk010 LIKE xmdk_t.xmdk010,
     xmdk011 LIKE xmdk_t.xmdk011,
     xmdk012 LIKE xmdk_t.xmdk012,
     xmdk013 LIKE xmdk_t.xmdk013,
     xmdk014 LIKE xmdk_t.xmdk014,
     xmdk015 LIKE xmdk_t.xmdk015,
     xmdk016 LIKE xmdk_t.xmdk016,
     xmdk018 LIKE xmdk_t.xmdk018,
     xmdk019 LIKE xmdk_t.xmdk019,
     xmdk020 LIKE xmdk_t.xmdk020,
     xmdk021 LIKE xmdk_t.xmdk021,
     xmdk022 LIKE xmdk_t.xmdk022,
     xmdk023 LIKE xmdk_t.xmdk023,
     xmdk024 LIKE xmdk_t.xmdk024,
     xmdk030 LIKE xmdk_t.xmdk030,
     xmdk031 LIKE xmdk_t.xmdk031,
     xmdkownid LIKE xmdk_t.xmdkownid,
     xmdkowndp LIKE xmdk_t.xmdkowndp,
     xmdkcrtid LIKE xmdk_t.xmdkcrtid,
     xmdkcrtdp LIKE xmdk_t.xmdkcrtdp,
     xmdkcrtdt DATETIME YEAR TO SECOND,
     xmdkmodid LIKE xmdk_t.xmdkmodid,
     xmdkmoddt DATETIME YEAR TO SECOND,
     xmdkcnfid LIKE xmdk_t.xmdkcnfid,
     xmdkcnfdt DATETIME YEAR TO SECOND,
     xmdkpstid LIKE xmdk_t.xmdkpstid,
     xmdkpstdt DATETIME YEAR TO SECOND,
     xmdkstus  LIKE xmdk_t.xmdkstus,
     xmdk000 LIKE xmdk_t.xmdk000,
     xmdk042 LIKE xmdk_t.xmdk042,
     xmdk043 LIKE xmdk_t.xmdk043,
     xmdk045 LIKE xmdk_t.xmdk045,
     xmdk046 LIKE xmdk_t.xmdk046,
     xmdk082 LIKE xmdk_t.xmdk082,     
     xmdk083 LIKE xmdk_t.xmdk083,    
     xmdk084 LIKE xmdk_t.xmdk084,
     xmdk085 LIKE xmdk_t.xmdk085,
     xmdk086 LIKE xmdk_t.xmdk086     
     END RECORD
DEFINE l_xmdl RECORD     
   xmdlseq LIKE xmdl_t.xmdlseq,
   xmdl008 LIKE xmdl_t.xmdl008,
   xmdl009 LIKE xmdl_t.xmdl009,
   xmdl011 LIKE xmdl_t.xmdl011,
   xmdl012 LIKE xmdl_t.xmdl012,
   xmdl014 LIKE xmdl_t.xmdl014,
   xmdl015 LIKE xmdl_t.xmdl015,
   xmdl016 LIKE xmdl_t.xmdl016,
   xmdl052 LIKE xmdl_t.xmdl052,
   xmdl017 LIKE xmdl_t.xmdl017,
   xmdl018 LIKE xmdl_t.xmdl018,
   xmdl019 LIKE xmdl_t.xmdl019,
   xmdl020 LIKE xmdl_t.xmdl020
   END RECORD 


DEFINE l_oodbl004 LIKE oodbl_t.oodbl004,
       l_oodb011 LIKE oodb_t.oodb011
DEFINE l_inbadocno  LIKE inba_t.inbadocno
DEFINE l_slip       LIKE ooba_t.ooba001
#160816-00066#5 add-S
DEFINE l_stano    LIKE xmdk_t.xmdkdocno   
DEFINE l_endno    LIKE xmdk_t.xmdkdocno   
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
#160816-00066#5 add-E

   CALL s_transaction_begin() 
   CALL cl_err_collect_init()
   LET l_sql = " INSERT INTO xmdk_t(xmdkent,xmdksite,xmdkdocno,xmdkdocdt,xmdk001,", 
               "                    xmdk002,xmdk003,xmdk004,xmdk005,xmdk006,",  
               "                    xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,",   
               "                    xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk018,",
               "                    xmdk022,xmdk023,xmdk024,xmdk030,xmdk031,",   
               "                    xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,", 
               "                    xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,",  
               "                    xmdkpstdt,xmdkstus,xmdk000,xmdk042,xmdk043,",   
               "                    xmdk045,xmdk046,xmdk082,xmdk083,xmdk084,",   
               "                    xmdk085,xmdk086)",
               "  VALUES(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,?,  ?,?,?,?,?,",
               "         ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,?,? )"      
   PREPARE xmdk_ins FROM l_sql 
  
   LET l_sql = " INSERT INTO xmdl_t(xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,",
               "                    xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,",
               "                    xmdl008,xmdl009,xmdl094,xmdl095,xmdl017,",
               "                    xmdl018,xmdl014,xmdl015,xmdl016,xmdl052,",
               "                    xmdl022,xmdl021,xmdl013,xmdl023,xmdl041,xmdl050,xmdl019,xmdl020) ", #151213-00001#3 add by lixh 20160218
               " SELECT '",g_enterprise,"','",g_site,"',?,xmdlseq,xmdl001,",
               "                  xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,",
               "                  xmdl008,xmdl009,xmdl094,xmdl095,xmdl017,",
               "                  xmdl018,xmdl014,xmdl015,xmdl016,xmdl052,",
               "                  xmdl022,xmdl021,'N','N','N',xmdl050,xmdl019,xmdl020 ", #151213-00001#3 add by lixh 20160218
               "   FROM p200_xmdl WHERE xmdl_no = ?"
   PREPARE xmdl_ins FROM l_sql  
   
   LET l_sql = " SELECT xmdlseq,xmdl008,xmdl009,xmdl011,xmdl012,",
               "        xmdl014,xmdl015,xmdl016,xmdl052,xmdl017,",
               "        xmdl018,xmdl019,xmdl020 ",
               "   FROM xmdl_t ",
               "  WHERE xmdlent = '",g_enterprise,"'",
               "    AND xmdldocno = ? "
   PREPARE ins_xmdm_pre FROM l_sql
   DECLARE ins_xmdm_cur CURSOR FOR ins_xmdm_pre
      
   #杂发单单头
   LET l_sql = " INSERT INTO inba_t(inbaent,inbasite,inbadocno,inbadocdt,inba001,",
               "                    inba002,inba003,inba004,inba005,inba006,inba007)",
               "  SELECT '",g_enterprise,"','",g_site,"',?,inbadocdt,inba001,inba002,",
               "                    inba003,inba004,inba005,?,inba007 ",
               "  FROM p200_inba WHERE inba_no = ?"
   PREPARE inba_ins FROM l_sql 
   #杂发单单身
   LET l_sql = " INSERT INTO inbb_t(inbbent,inbbsite,inbbdocno,inbbseq,inbb001,",
               "                    inbb002,inbb003,inbb004,inbb007,inbb008,",
               "                    inbb009,inbb010,inbb011,inbb012,inbb013,",
               "                    inbb014,inbb015,inbb016,inbb017,inbb018,inbb019) ",
               " SELECT DISTINCT '",g_enterprise,"','",g_site,"',?,inbbseq,inbb001,",
               "                    inbb002,inbb003,inbb004,inbb007,inbb008,",
               "                    inbb009,inbb010,inbb011,inbb012 a,inbb013,",
               "                    inbb014,inbb015,inbb016,?,'N',inbb012 b  ",
               "   FROM p200_inbb WHERE inbb_no = ?"
   PREPARE inbb_ins FROM l_sql 
   
   LET l_sql = " INSERT INTO inbc_t(inbcent, inbcsite,inbcdocno,inbcseq,inbcseq1, ",
               "                    inbc001,inbc002,inbc003,inbc004,inbc005,inbc006,inbc007, ",
               "                    inbc009,inbc010,inbc011,inbc015,inbc016,inbc017,inbc021,inbc022,inbc023) ", 
               "  SELECT DISTINCT '",g_enterprise,"','",g_site,"',inbbdocno,inbbseq,1,",
               "          inbb001,inbb002,inbb003,inbb004,",
               "          inbb007,inbb008,inbb009,",
               "          inbb010,inbb011,inbb013,",
               "          inbb015,inbb022,inbb021,",
               "          inbb023,inbb024,inbb025 ",
               "    FROM inbb_t ",
               "   WHERE inbbent = '",g_enterprise,"'",
               "     AND inbbdocno = ? "
   PREPARE ins_inbc FROM l_sql

   LET l_success = TRUE
   LET l_sql = "SELECT DISTINCT xmdkdocno,xmdkdocdt,xmdk003,xmdk004,xmdk007,xmdk086,xmdk_no ",
               "  FROM p200_xmdk "
   PREPARE armp200_xmdk_p FROM l_sql
   DECLARE armp200_xmdk_c CURSOR FOR armp200_xmdk_p
   LET l_cnt = 1     #160816-00066#5 add
   FOREACH armp200_xmdk_c INTO l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk003,
                               l_xmdk.xmdk004,l_xmdk.xmdk007,l_xmdk.xmdk086,l_xmdk.xmdk_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      #产生销退单弹头
      CALL s_aooi200_gen_docno(g_site,l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,'axmt600') 
         RETURNING l_success,l_xmdk.xmdkdocno
      
      LET l_xmdk.xmdk001 = l_xmdk.xmdkdocdt
      LET l_xmdk.xmdk002 = '6'
      LET l_xmdk.xmdk005 = ''
      LET l_xmdk.xmdk006 = ''
      LET l_xmdk.xmdk008 = l_xmdk.xmdk007
      LET l_xmdk.xmdk009 = l_xmdk.xmdk007
            #收款條件,交易條件,稅別,發票類型,幣別,
      SELECT pmab087,pmab103,pmab084,pmab106,pmab083,
            #取價方式,運輸方式,交運起點,交運終點,銷售通路,銷售分類
             pmab104,pmab090,pmab091,pmab092,pmab088,pmab089            
        INTO l_xmdk.xmdk010,l_xmdk.xmdk011,l_xmdk.xmdk012,l_xmdk.xmdk015,l_xmdk.xmdk016,
             l_xmdk.xmdk018,l_xmdk.xmdk022,l_xmdk.xmdk023,l_xmdk.xmdk024,l_xmdk.xmdk030,l_xmdk.xmdk031
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = g_site
         AND pmab001 = l_xmdk.xmdk007
      
      #檢查、取得稅別、單價含稅否
      CALL s_tax_chk(g_site,l_xmdk.xmdk012)
      RETURNING l_success,l_oodbl004,l_xmdk.xmdk014,l_xmdk.xmdk013,l_oodb011
      
      LET l_xmdk.xmdk000 = "6"
      LET l_xmdk.xmdk042 = "1"
      LET l_xmdk.xmdk043 = "1"
      LET l_xmdk.xmdk045 = "1"
      LET l_xmdk.xmdk046 = "1"
      LET l_xmdk.xmdk082 = "1"      
      LET l_xmdk.xmdk083 = "N"     
      LET l_xmdk.xmdk084 = "1"
      LET l_xmdk.xmdk085 = "3"
      
      LET l_xmdk.xmdkownid = g_user
      LET l_xmdk.xmdkowndp = g_dept
      LET l_xmdk.xmdkcrtid = g_user
      LET l_xmdk.xmdkcrtdp = g_dept
      LET l_xmdk.xmdkcrtdt = cl_get_current()
      LET l_xmdk.xmdkmodid = g_user
      LET l_xmdk.xmdkmoddt = cl_get_current()
#      LET l_xmdk.xmdkcnfid = g_user 
#      LET l_xmdk.xmdkcnfdt = cl_get_current()
#      LET l_xmdk.xmdkpstid = g_user
#      LET l_xmdk.xmdkpstdt = cl_get_current()
      LET l_xmdk.xmdkstus  = 'N'
           
      EXECUTE xmdk_ins USING g_enterprise,g_site,l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk001,
                             l_xmdk.xmdk002,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk005,l_xmdk.xmdk006,
                             l_xmdk.xmdk007,l_xmdk.xmdk008,l_xmdk.xmdk009,l_xmdk.xmdk010,l_xmdk.xmdk011,
                             l_xmdk.xmdk012,l_xmdk.xmdk013,l_xmdk.xmdk014,l_xmdk.xmdk015,l_xmdk.xmdk016,l_xmdk.xmdk018,
                             l_xmdk.xmdk022,l_xmdk.xmdk023,l_xmdk.xmdk024,l_xmdk.xmdk030,l_xmdk.xmdk031,
                             l_xmdk.xmdkownid,l_xmdk.xmdkowndp,l_xmdk.xmdkcrtid,l_xmdk.xmdkcrtdp,l_xmdk.xmdkcrtdt,
                             l_xmdk.xmdkmodid,l_xmdk.xmdkmoddt,l_xmdk.xmdkcnfid,l_xmdk.xmdkcnfdt,l_xmdk.xmdkpstid,
                             l_xmdk.xmdkpstdt,l_xmdk.xmdkstus,l_xmdk.xmdk000,l_xmdk.xmdk042,l_xmdk.xmdk043,
                             l_xmdk.xmdk045,l_xmdk.xmdk046,l_xmdk.xmdk082,l_xmdk.xmdk083,l_xmdk.xmdk084,
                             l_xmdk.xmdk085,l_xmdk.xmdk086 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_xmdk" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF  

      UPDATE p200_xmdk 
         SET xmdkdocno = l_xmdk.xmdkdocno
       WHERE xmdk_no = l_xmdk.xmdk_no 
      #160816-00066#5 add-S
      IF l_cnt = 1 THEN    
         LET l_stano = l_xmdk.xmdkdocno
      END IF
      LET l_cnt = l_cnt + 1
      #160816-00066#5 add-E 
       
      EXECUTE xmdl_ins USING l_xmdk.xmdkdocno,l_xmdk.xmdk_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_xmdl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF 
      
      #新增多庫儲批
      OPEN ins_xmdm_cur USING l_xmdk.xmdkdocno
      FOREACH ins_xmdm_cur INTO l_xmdl.xmdlseq,l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl011,l_xmdl.xmdl012,
                                l_xmdl.xmdl014,l_xmdl.xmdl015,l_xmdl.xmdl016,l_xmdl.xmdl052,l_xmdl.xmdl017,
                                l_xmdl.xmdl018,l_xmdl.xmdl019,l_xmdl.xmdl020      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF                                          
         CALL axmt540_01_xmdm_modify('6',l_xmdl.xmdlseq,g_site,l_xmdk.xmdkdocno,l_xmdl.xmdlseq,
                                      l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl011,l_xmdl.xmdl012,
                                      l_xmdl.xmdl014,l_xmdl.xmdl015,l_xmdl.xmdl016,l_xmdl.xmdl052,
                                      l_xmdl.xmdl017,l_xmdl.xmdl018,l_xmdl.xmdl019,l_xmdl.xmdl020,
                                     '','') RETURNING l_success
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_xmdm" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH   
      
      
      #产生杂发单
      CALL s_aooi200_gen_docno(g_site,g_master.inbadocno,g_master.xmdkdocdt,'aint301') 
         RETURNING l_success,l_inbadocno      
      EXECUTE inba_ins USING l_inbadocno,l_xmdk.xmdkdocno,l_xmdk.xmdk_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_inba" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF  
      UPDATE inba_t
         SET inbaownid = l_xmdk.xmdkownid,
             inbaowndp = l_xmdk.xmdkowndp,
             inbacrtid = l_xmdk.xmdkcrtid,
             inbacrtdp = l_xmdk.xmdkcrtdp,
             inbacrtdt = l_xmdk.xmdkcrtdt,
             inbamodid = l_xmdk.xmdkmodid,
             inbamoddt = l_xmdk.xmdkmoddt
       WHERE inbaent = g_enterprise
         AND inbadocno = l_inbadocno 
         
      EXECUTE inbb_ins USING l_inbadocno,l_xmdk.xmdkdocno,l_xmdk.xmdk_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_inbb" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF

      EXECUTE ins_inbc USING l_inbadocno     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_inbc" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      LET g_prog = 'axmt600'
      CALL s_axmt600_conf_chk(l_xmdk.xmdkdocno) RETURNING l_success
      IF NOT l_success THEN
         LET l_success = FALSE
         EXIT FOREACH
      ELSE
         CALL s_axmt600_conf_upd(l_xmdk.xmdkdocno) RETURNING l_success
         IF NOT l_success THEN
            LET l_success = FALSE
            EXIT FOREACH
         ELSE
            #150310-00003#10 add by lixh 銷退單D-BAS-0083= 'Y'(審核后自動過賬)不需要再次過賬
            CALL s_aooi200_get_slip(l_xmdk.xmdkdocno) RETURNING l_success,l_slip
            IF NOT l_success THEN
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0083') = 'N' OR cl_null(cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0083')) THEN  
            #150310-00003#10 add by lixh 銷退單D-BAS-0083= 'Y'(審核后自動過賬)不需要再次過賬
               CALL s_axmt600_post_chk(l_xmdk.xmdkdocno) RETURNING l_success
               IF NOT l_success THEN
                  LET l_success = FALSE
                  EXIT FOREACH
               ELSE 
                  CALL s_axmt600_post_upd(l_xmdk.xmdkdocno,l_inbadocno) RETURNING l_success
                  IF NOT l_success THEN
                     LET l_success = FALSE
                     EXIT FOREACH
                  END IF
               END IF
            END IF #150310-00003#10 add by lixh 銷退單D-BAS-0083= 'Y'(審核后自動過賬)不需要再次過賬            
         END IF
      END IF
      LET g_prog = 'armp200'
#      LET g_prog = 'aint301'
#      IF NOT s_aint302_conf_chk(l_inbadocno) THEN
#         LET l_success = FALSE
#         EXIT FOREACH
#      ELSE
#        IF NOT s_aint302_conf(l_inbadocno) THEN
#           LET l_success = FALSE
#           EXIT FOREACH
#        ELSE
#           UPDATE inba_t 
#              SET inba002 = l_xmdk.xmdkcrtdt
#            WHERE inbaent = g_enterprise 
#              AND inbasite = g_site 
#              AND inbadocno = l_inbadocno
#           IF NOT s_aint302_posted(l_inbadocno) THEN
#              LET l_success = FALSE
#              EXIT FOREACH
#           END IF
#        END IF
#     END IF   
#     LET g_prog = 'armp200' 
        
   END FOREACH
   
   IF l_success THEN 
      LET l_sql = "UPDATE rmcb_t a",
                  "   SET a.rmcb010 = a.rmcb010 + (SELECT b.qty FROM p200_rmcb b WHERE a.rmcbdocno = b.rmcbdocno AND a.rmcbseq = b.rmcbseq AND b.sel = 'Y')",
                  " WHERE a.rmcbent = '",g_enterprise,"' AND a.rmcbsite = '",g_site,"'",
                  "   AND EXISTS(SELECT * FROM p200_rmcb b WHERE a.rmcbdocno = b.rmcbdocno AND a.rmcbseq = b.rmcbseq AND b.sel = 'Y')"
      PREPARE upd_rmcb FROM l_sql
      EXECUTE upd_rmcb   
      LET l_sql = "UPDATE rmab_t a",
                  "   SET a.rmab015 = a.rmab015 + (SELECT SUM(b.qty) FROM p200_rmcb b WHERE a.rmabdocno = b.rmcb001 AND a.rmabseq = b.rmcb002 AND b.sel = 'Y')",
                  " WHERE a.rmabent = '",g_enterprise,"' AND a.rmabsite = '",g_site,"'",
                  "   AND EXISTS(SELECT * FROM p200_rmcb b WHERE a.rmabdocno = b.rmcb001 AND a.rmabseq = b.rmcb002 AND b.sel = 'Y')"
      PREPARE upd_rmab FROM l_sql
      EXECUTE upd_rmab       
   END IF   
   CALL cl_err_collect_show()
   IF l_success THEN
      #160816-00066#5 add-S
      LET l_endno = l_xmdk.xmdkdocno
      #160816-00066#5 add-E
      CALL s_transaction_end('Y','0')
      #160816-00066#5 add-S         #成功产生销退单，单据范围：%1，是否开启单据进行查看？
      IF l_stano <> l_endno THEN
         LET l_str = l_stano CLIPPED,'~',l_endno CLIPPED
      ELSE 
         LET l_str = l_stano CLIPPED
      END IF
      IF cl_ask_confirm_parm('arm-00068',l_str) THEN
         IF l_stano <> l_endno THEN
            LET l_str = " (xmdkdocno BETWEEN '",l_stano CLIPPED,"' AND '",l_endno CLIPPED,"' )"
         ELSE 
            LET l_str = " xmdkdocno = '",l_stano CLIPPED,"' "
         END IF        
         LET la_param.prog = 'axmt600' #
         LET la_param.param[2] = l_str
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun(ls_js)
      END IF
      #160816-00066#4 add-E
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION

PRIVATE FUNCTION armp200_b_fill2()
DEFINE l_sql STRING 
DEFINE l_cnt LIKE type_t.num10

   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   LET l_cnt = 1
   LET l_sql = "SELECT xmdkdocno,xmdkdocdt,xmdk003,xmdk004,xmdk007,xmdk_no ",
               "  FROM p200_xmdk "
   PREPARE armp200_xmdk_pre FROM l_sql
   DECLARE armp200_xmdk_cur CURSOR FOR armp200_xmdk_pre
   FOREACH armp200_xmdk_cur INTO g_detail2_d[l_cnt].*
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

PRIVATE FUNCTION armp200_b_fill3()
DEFINE l_sql STRING 
DEFINE l_cnt LIKE type_t.num10

   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN 
      RETURN
   END IF

   CALL g_detail3_d.clear()
   LET l_cnt = 1
   LET l_sql = " SELECT xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,",
               "        xmdl005,xmdl006,xmdl008,xmdl009,xmdl094,",
               #161129-00054#1 mod-S
#               "        xmdl095,xmdl017,xmdl018,xmdl014,xmdl015,",
               "        xmdl095,xmdl017,xmdl018,xmdl014,",
               "        (SELECT inayl003 FROM inayl_t WHERE inayl001 = xmdl014 AND inayl002 = '",g_dlang,"' AND inaylent = ",g_enterprise,") inayl003, ",
               "        xmdl015,",
               "        (SELECT inab003 FROM inab_t WHERE inab001 = xmdl014 AND inab002 = xmdl015 AND inabsite = '",g_site,"' AND inabent = ",g_enterprise,") inab003, ",
               #161129-00054#1 mod-E
               "        xmdl016,xmdl052,xmdl022,xmdl021,xmdl_no",
               "   FROM p200_xmdl ",
               "  WHERE xmdl_no = ",g_detail2_d[g_detail_idx].xmdk_no
   PREPARE armp200_xmdl_pre FROM l_sql
   DECLARE armp200_xmdl_cur CURSOR FOR armp200_xmdl_pre
   FOREACH armp200_xmdl_cur INTO g_detail3_d[l_cnt].*
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
END FUNCTION

PRIVATE FUNCTION armp200_upd_xmdk()
   IF cl_null(l_ac2) OR l_ac2 = 0 THEN RETURN END IF 
  
   UPDATE p200_xmdk
      SET xmdkdocno = g_detail2_d[l_ac2].xmdkdocno
    WHERE xmdk_no = g_detail2_d[l_ac2].xmdk_no 
END FUNCTION

PRIVATE FUNCTION armp200_upd_xmdl()
   IF cl_null(l_ac3) OR l_ac3 = 0 THEN RETURN END IF 
  
   UPDATE p200_xmdl
      SET xmdl014 = g_detail3_d[l_ac3].xmdl014,
          xmdl015 = g_detail3_d[l_ac3].xmdl015,
          xmdl016 = g_detail3_d[l_ac3].xmdl016,
          xmdl052 = g_detail3_d[l_ac3].xmdl052,
          xmdl021 = g_detail3_d[l_ac3].xmdl021,
          xmdl022 = g_detail3_d[l_ac3].xmdl022
    WHERE xmdl_no = g_detail3_d[l_ac3].xmdl_no 
      AND xmdlseq = g_detail3_d[l_ac3].xmdlseq
END FUNCTION

PRIVATE FUNCTION armp200_display()
DEFINE l_type       LIKE type_t.chr1
DEFINE l_inaa007    LIKE inaa_t.inaa007
DEFINE l_ooef004    LIKE ooef_t.ooef004
DEFINE l_n          LIKE type_t.num5
DEFINE l_ooba015    LIKE ooba_t.ooba015
DEFINE l_ooba002    LIKE ooba_t.ooba002
DEFINE l_acc        LIKE gzcb_t.gzcb007
DEFINE l_acc2       LIKE gzcb_t.gzcb007
DEFINE l_flag       LIKE type_t.chr1
DEFINE l_success    LIKE type_t.num5   
DEFINE l_sql1          STRING            #160711-00040#28 add

   IF g_detail2_d.getlength() > 0 THEN 
      LET g_detail_idx = 1              
      CALL armp200_b_fill3() 
   END IF 
   
   LET l_acc = s_fin_get_scc_value('24','aint301','2')   #161125-00049#1 add
   LET l_acc2 = s_fin_get_scc_value('24','axmt600','2')  #161125-00049#1 add
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
         BEFORE DISPLAY 
            LET l_ac2 = g_curr_diag.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac2              
            CALL armp200_b_fill3() 
            
         BEFORE ROW
            LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac2
            CALL armp200_b_fill3()        
          
      END DISPLAY
      DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)
         
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
      #end add-point
      #add-point:ui_dialog段input
      INPUT BY NAME g_master.xmdkdocno,g_master.inbadocno,g_master.xmdkdocdt,g_master.xmdl014,
                    g_master.xmdl015,g_master.inba007,g_master.xmdl050
         ATTRIBUTE(WITHOUT DEFAULTS)        
       
         AFTER FIELD xmdkdocno
            IF NOT cl_null(g_master.xmdkdocno) THEN 
               IF NOT s_aooi200_chk_slip(g_site,'',g_master.xmdkdocno,'axmt600') THEN
                  LET g_master.xmdkdocno = ''
                  NEXT FIELD CURRENT
               END IF   
            END IF
       
         AFTER FIELD inbadocno
            IF NOT cl_null(g_master.inbadocno) THEN 
               IF NOT s_aooi200_chk_slip(g_site,'',g_master.inbadocno,'aint301') THEN
                  LET g_master.inbadocno = ''
                  NEXT FIELD CURRENT
               END IF   
            END IF
            
         AFTER FIELD xmdl014
            IF NOT cl_null(g_master.xmdl014)THEN               
                              
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
                   
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_master.xmdl014    #庫位
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#21  by 07900 --add-end         
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001") THEN
                  LET g_master.xmdl014 = ''
                  NEXT FIELD CURRENT
               END IF
               LET l_inaa007 = ''
               SELECT inaa007 INTO l_inaa007
                 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_site
                  AND inaa001 = g_master.xmdl014
               CALL cl_set_comp_entry("xmdl015",TRUE)
               CALL cl_set_comp_required("xmdl015",FALSE)
               IF l_inaa007 = '5' THEN 
                  CALL cl_set_comp_entry("xmdl015",FALSE)
                  LET g_master.xmdl015 = ''
               ELSE
                  CALL cl_set_comp_required("xmdl015",TRUE)
               END IF
               IF NOT cl_null(g_master.xmdl015) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_master.xmdl014
                  LET g_chkparam.arg3 = g_master.xmdl015
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end                    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_master.xmdl014 = ''
                     NEXT FIELD CURRENT
                  END IF    
               END IF                   
            END IF
            
         AFTER FIELD xmdl015 
            IF NOT cl_null(g_master.xmdl015) THEN
               IF cl_null(g_master.xmdl015) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00126'    #庫位不可為空
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
       
                  NEXT FIELD CURRENT
               END IF
            
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
                              
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_master.xmdl014
               LET g_chkparam.arg3 = g_master.xmdl015
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#21  by 07900 --add-end                   
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inab002") THEN
                  LET g_master.xmdl015 = ''
                  NEXT FIELD CURRENT
               END IF    
            END IF  
         
         AFTER FIELD xmdl050
            IF NOT cl_null(g_master.xmdl050) THEN              
               IF NOT s_azzi650_chk_exist(l_acc2,g_master.xmdl050) THEN
                  LET g_master.xmdl050 = ''
                  NEXT FIELD CURRENT
               END IF
               #檢核輸入的理由碼是否在單據別限制範圍內
               CALL s_control_chk_doc('8',g_master.xmdkdocno,g_master.xmdl050,'','','','')
               RETURNING l_success,l_flag
               IF NOT l_success OR NOT l_flag THEN
                  LET g_master.xmdl050 = ''
                  NEXT FIELD CURREN
               END IF                  
            END IF            
         AFTER FIELD inba007
            IF NOT cl_null(g_master.inba007) THEN              
               IF NOT s_azzi650_chk_exist(l_acc,g_master.inba007) THEN
                  LET g_master.inba007 = ''
                  NEXT FIELD CURRENT
               END IF
               #檢核輸入的理由碼是否在單據別限制範圍內
               CALL s_control_chk_doc('8',g_master.inbadocno,g_master.inba007,'','','','')
               RETURNING l_success,l_flag
               IF NOT l_success OR NOT l_flag THEN
                  LET g_master.inba007 = ''
                  NEXT FIELD CURRENT
               END IF                  
            END IF   
            
         ON ACTION controlp INFIELD xmdl050
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
		   	#獲取參照表編號
		   	LET l_ooef004 = ''
		   	SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef005 = g_site
		   	
		   	LET l_n = 0
		   	SELECT COUNT(oobi003) INTO l_n FROM ooba_t,oobi_t WHERE oobaent=oobient AND ooba001=oobi001 AND ooba002=oobi002 
                    AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.xmdkdocno
		   	IF l_n > 0 THEN
		   	   #判斷是正向列表還是負向列表
		   	   LET l_ooba015 = ''
		   	   SELECT ooba015 INTO l_ooba015 FROM ooba_t
		   	     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.xmdkdocno
                  #正向列表
                  IF l_ooba015 = '1' THEN
                     LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.xmdkdocno,"')"
                  END IF
                  
                  #負向列表
                  IF l_ooba015 = '2' THEN
                     LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.xmdkdocno,"')"
                  END IF
               END IF
               LET g_qryparam.default1 = g_master.xmdl050      #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = l_acc2 #
               CALL q_oocq002()                                #呼叫開窗         
               LET g_master.xmdl050 = g_qryparam.return1        #將開窗取得的值回傳到變數          
               DISPLAY g_master.xmdl050 TO xmdl050              #顯示到畫面上        
               NEXT FIELD xmdl050 
               
         ON ACTION controlp INFIELD inba007
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
		   	#獲取參照表編號
		   	LET l_ooef004 = ''
		   	SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef005 = g_site
		   	
		   	LET l_n = 0
		   	SELECT COUNT(oobi003) INTO l_n FROM ooba_t,oobi_t WHERE oobaent=oobient AND ooba001=oobi001 AND ooba002=oobi002 
                    AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.inbadocno
		   	IF l_n > 0 THEN
		   	   #判斷是正向列表還是負向列表
		   	   LET l_ooba015 = ''
		   	   SELECT ooba015 INTO l_ooba015 FROM ooba_t
		   	     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_master.inbadocno
                  #正向列表
                  IF l_ooba015 = '1' THEN
                     LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.inbadocno,"')"
                  END IF
                  
                  #負向列表
                  IF l_ooba015 = '2' THEN
                     LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",g_master.inbadocno,"')"
                  END IF
               END IF
               LET g_qryparam.default1 = g_master.inba007      #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = l_acc #
               CALL q_oocq002()                                #呼叫開窗         
               LET g_master.inba007 = g_qryparam.return1        #將開窗取得的值回傳到變數          
               DISPLAY g_master.inba007 TO inba007              #顯示到畫面上        
               NEXT FIELD inba007 
       
       
         ON ACTION controlp INFIELD xmdkdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xmdkdocno 
            LET g_qryparam.arg1 = g_ooef.ooef004
            LET g_qryparam.arg2 = 'axmt600'
            #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                              
            LET g_master.xmdkdocno = g_qryparam.return1              
            NEXT FIELD xmdkdocno
       
         ON ACTION controlp INFIELD inbadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.inbadocno 
            LET g_qryparam.arg1 = g_ooef.ooef004
            LET g_qryparam.arg2 = 'aint301'
            #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                              
            LET g_master.inbadocno = g_qryparam.return1              
            NEXT FIELD inbadocno
       
         ON ACTION controlp INFIELD xmdl014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xmdl014 
            LET g_qryparam.arg1 = g_site
            CALL q_inaa001_4()                              
            LET g_master.xmdl014 = g_qryparam.return1              
            NEXT FIELD xmdl014
            
         ON ACTION controlp INFIELD xmdl015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xmdl015 
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = g_master.xmdl014
            CALL q_inab002_8()                              
            LET g_master.xmdl015 = g_qryparam.return1              
            NEXT FIELD xmdl015               
      END INPUT     
         
      ON ACTION close 
         LET g_action_choice="exit"      
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG

      ON ACTION accept
         CALL armp200_query()
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
 
