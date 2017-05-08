#該程式未解開Section, 採用最新樣板產出!
{<section id="armt300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-11-21 17:14:47), PR版次:0010(2017-02-17 16:46:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: armt300
#+ Description: RMA判別作業
#+ Creator....: 02295(2015-05-08 11:27:06)
#+ Modifier...: 05423 -SD/PR- 01996
 
{</section>}
 
{<section id="armt300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#4   2015/11/25   By 06948   增加作廢時詢問「是否作廢」
#160318-00025#33  2016/04/13   By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160812-00017#1   2016/08/15   By 06137   在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#33  2016/08/25   By lixh    单据类作业修改，删除时需重新检查状态
#160816-00066#2   2016/11/21   By zhujing 1.单头进单身时，若单头RMA单号不为空白，提示“是否自动生成单身资料”，选Y则自动带单身资料
#                                         2.单身RMA单号开窗中增加RMA项次、点收项序、料号、产品特征、点收数量，开窗挑选后自动带出后面栏位
#                                         3.整单操作增加3个action：
#                                           转工单，调用armp100产生工单
#                                           转销退，调用armp200产生销退单
#                                           转覆出，调用armp300产生覆出单
#161124-00048#11  2016/12/19   By zhujing .*整批调整
#170120-00054#1   2017/01/20   By zhujing  调整系统中无ENT的SQL条件增加ent
#160711-00040#28   2017/02/16  By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                        CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
PRIVATE type type_g_rmca_m        RECORD
       rmcadocno LIKE rmca_t.rmcadocno, 
   rmcadocno_desc LIKE type_t.chr80, 
   rmcadocdt LIKE rmca_t.rmcadocdt, 
   rmcasite LIKE rmca_t.rmcasite, 
   rmca003 LIKE rmca_t.rmca003, 
   rmca003_desc LIKE type_t.chr80, 
   rmca004 LIKE rmca_t.rmca004, 
   rmca004_desc LIKE type_t.chr80, 
   rmcastus LIKE rmca_t.rmcastus, 
   rmca001 LIKE rmca_t.rmca001, 
   rmca002 LIKE rmca_t.rmca002, 
   rmca002_desc LIKE type_t.chr80, 
   rmcaownid LIKE rmca_t.rmcaownid, 
   rmcaownid_desc LIKE type_t.chr80, 
   rmcaowndp LIKE rmca_t.rmcaowndp, 
   rmcaowndp_desc LIKE type_t.chr80, 
   rmcacrtid LIKE rmca_t.rmcacrtid, 
   rmcacrtid_desc LIKE type_t.chr80, 
   rmcacrtdp LIKE rmca_t.rmcacrtdp, 
   rmcacrtdp_desc LIKE type_t.chr80, 
   rmcacrtdt LIKE rmca_t.rmcacrtdt, 
   rmcamodid LIKE rmca_t.rmcamodid, 
   rmcamodid_desc LIKE type_t.chr80, 
   rmcamoddt LIKE rmca_t.rmcamoddt, 
   rmcacnfid LIKE rmca_t.rmcacnfid, 
   rmcacnfid_desc LIKE type_t.chr80, 
   rmcacnfdt LIKE rmca_t.rmcacnfdt, 
   rmcapstid LIKE rmca_t.rmcapstid, 
   rmcapstid_desc LIKE type_t.chr80, 
   rmcapstdt LIKE rmca_t.rmcapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rmcb_d        RECORD
       rmcbsite LIKE rmcb_t.rmcbsite, 
   rmcbseq LIKE rmcb_t.rmcbseq, 
   rmcb001 LIKE rmcb_t.rmcb001, 
   rmcb002 LIKE rmcb_t.rmcb002, 
   rmcb003 LIKE rmcb_t.rmcb003, 
   rmcb004 LIKE rmcb_t.rmcb004, 
   rmcb004_desc LIKE type_t.chr500, 
   rmcb004_desc_1 LIKE type_t.chr500, 
   rmcb005 LIKE rmcb_t.rmcb005, 
   rmcb005_desc LIKE type_t.chr500, 
   rmcb006 LIKE rmcb_t.rmcb006, 
   rmcb006_desc LIKE type_t.chr500, 
   rmab017 LIKE rmab_t.rmab017, 
   rmcb007 LIKE rmcb_t.rmcb007, 
   rmcb008 LIKE rmcb_t.rmcb008, 
   rmcb008_desc LIKE type_t.chr500, 
   rmcb009 LIKE rmcb_t.rmcb009, 
   rmcb010 LIKE rmcb_t.rmcb010, 
   rmcb011 LIKE rmcb_t.rmcb011
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rmcadocno LIKE rmca_t.rmcadocno,
      b_rmcadocdt LIKE rmca_t.rmcadocdt,
      b_rmca003 LIKE rmca_t.rmca003,
      b_rmca004 LIKE rmca_t.rmca004
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161124-00048#11 mod-S
#DEFINE g_ooef   RECORD LIKE ooef_t.*
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
#161124-00048#11 mod-E
DEFINE g_ask       LIKE type_t.num5       #詢問是否自動產生單身 #160816-00066#2 add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rmca_m          type_g_rmca_m
DEFINE g_rmca_m_t        type_g_rmca_m
DEFINE g_rmca_m_o        type_g_rmca_m
DEFINE g_rmca_m_mask_o   type_g_rmca_m #轉換遮罩前資料
DEFINE g_rmca_m_mask_n   type_g_rmca_m #轉換遮罩後資料
 
   DEFINE g_rmcadocno_t LIKE rmca_t.rmcadocno
 
 
DEFINE g_rmcb_d          DYNAMIC ARRAY OF type_g_rmcb_d
DEFINE g_rmcb_d_t        type_g_rmcb_d
DEFINE g_rmcb_d_o        type_g_rmcb_d
DEFINE g_rmcb_d_mask_o   DYNAMIC ARRAY OF type_g_rmcb_d #轉換遮罩前資料
DEFINE g_rmcb_d_mask_n   DYNAMIC ARRAY OF type_g_rmcb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_detail_multi_table_t    RECORD
      rmabdocno LIKE rmab_t.rmabdocno,
      rmabseq LIKE rmab_t.rmabseq,
      rmab017 LIKE rmab_t.rmab017
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="armt300.main" >}
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
   CALL cl_ap_init("arm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rmcadocno,'',rmcadocdt,rmcasite,rmca003,'',rmca004,'',rmcastus,rmca001, 
       rmca002,'',rmcaownid,'',rmcaowndp,'',rmcacrtid,'',rmcacrtdp,'',rmcacrtdt,rmcamodid,'',rmcamoddt, 
       rmcacnfid,'',rmcacnfdt,rmcapstid,'',rmcapstdt", 
                      " FROM rmca_t",
                      " WHERE rmcaent= ? AND rmcadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rmcadocno,t0.rmcadocdt,t0.rmcasite,t0.rmca003,t0.rmca004,t0.rmcastus, 
       t0.rmca001,t0.rmca002,t0.rmcaownid,t0.rmcaowndp,t0.rmcacrtid,t0.rmcacrtdp,t0.rmcacrtdt,t0.rmcamodid, 
       t0.rmcamoddt,t0.rmcacnfid,t0.rmcacnfdt,t0.rmcapstid,t0.rmcapstdt,t1.oobxl003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.pmaal004 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011 ,t11.ooag011", 
 
               " FROM rmca_t t0",
                              " LEFT JOIN oobxl_t t1 ON t1.oobxlent="||g_enterprise||" AND t1.oobxl001=t0.rmcadocno AND t1.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rmca003  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rmca004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.rmca002 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rmcaownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rmcaowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.rmcacrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.rmcacrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rmcamodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rmcacnfid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rmcapstid  ",
 
               " WHERE t0.rmcaent = " ||g_enterprise|| " AND t0.rmcadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE armt300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_armt300 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armt300_init()   
 
      #進入選單 Menu (="N")
      CALL armt300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_armt300
      
   END IF 
   
   CLOSE armt300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="armt300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION armt300_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('rmcastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('rmcb009','4059') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #161124-00048#11 mod-S
#   SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent= g_enterprise AND ooef001 = g_site
   SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,
          ooef005,ooef006,ooef007,ooef008,ooef009,
          ooef010,ooef011,ooef012,ooef013,ooefownid,
          ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,
          ooefmoddt,ooef014,ooef015,ooef016,ooef017,
          ooef018,ooef019,ooef020,ooef021,ooef022,
          ooef003,ooef023,ooef024,ooef025,ooef026,
          ooef100,ooef101,ooef102,ooef103,ooef104,
          ooef105,ooef106,ooef107,ooef108,ooef109,
          ooef110,ooef111,ooef112,ooef113,ooef114,
          ooef115,ooef120,ooef121,ooef122,ooef123,
          ooef124,ooef125,ooef150,ooef151,ooef152,
          ooef153,ooef154,ooef155,ooef156,ooef157,
          ooef158,ooef159,ooef160,ooef161,ooef162,
          ooef163,ooef164,ooef165,ooef166,ooef167,
          ooef168,ooef169,ooef170,ooef171,ooef172,
          ooef173,ooefunit,ooef200,ooef201,ooef202,
          ooef203,ooef204,ooef205,ooef206,ooef207,
          ooef208,ooef209,ooef210,ooef211,ooef212,
          ooef213,ooef214,ooef215,ooef216,ooef217,
          ooef301,ooef302,ooef303,ooef304,ooef305,
          ooef306,ooef307,ooef308,ooef309,ooef310,
          ooef126,ooef127,ooef128,ooef116
     INTO g_ooef.* 
     FROM ooef_t 
    WHERE ooefent= g_enterprise AND ooef001 = g_site
   #161124-00048#11 mod-E
   #end add-point
   
   #初始化搜尋條件
   CALL armt300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="armt300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION armt300_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL armt300_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_rmca_m.* TO NULL
         CALL g_rmcb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armt300_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL armt300_fetch('') # reload data
               LET l_ac = 1
               CALL armt300_ui_detailshow() #Setting the current row 
         
               CALL armt300_idx_chk()
               #NEXT FIELD rmcbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rmcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt300_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL armt300_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL armt300_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL armt300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL armt300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL armt300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL armt300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL armt300_set_act_visible()   
            CALL armt300_set_act_no_visible()
            IF NOT (g_rmca_m.rmcadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rmcaent = " ||g_enterprise|| " AND",
                                  " rmcadocno = '", g_rmca_m.rmcadocno, "' "
 
               #填到對應位置
               CALL armt300_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rmca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmcb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL armt300_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rmca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmcb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL armt300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL armt300_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL armt300_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL armt300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL armt300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL armt300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL armt300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL armt300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt300_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_rmcb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD rmcbseq
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL armt300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL armt300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION to_armp300
            LET g_action_choice="to_armp300"
            IF cl_auth_chk_act("to_armp300") THEN
               
               #add-point:ON ACTION to_armp300 name="menu.to_armp300"
               #160816-00066#2 add
               IF g_rmca_m.rmcastus = 'Y' THEN
                  IF cl_ask_confirm('arm-00061') THEN           #是否自動產生覆出单
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF armt300_produce_rmda(g_rmca_m.rmcadocno) THEN
                        CALL s_transaction_end('Y','0')
                        CALL cl_ask_confirm3("std-00012","")
                        CALL armt300_fetch("")
                     ELSE
                        CALL s_transaction_end('N','0')
                        CALL cl_ask_confirm3("adz-00218","")
                     END IF
                     CALL cl_err_collect_show()
                  END IF            
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL armt300_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL armt300_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " rmcadocno = '",g_rmca_m.rmcadocno,"' AND rmcaent = ",g_enterprise," AND rmcasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " rmcadocno = '",g_rmca_m.rmcadocno,"' AND rmcaent = ",g_enterprise," AND rmcasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL armt300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL armt300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION to_armp100
            LET g_action_choice="to_armp100"
            IF cl_auth_chk_act("to_armp100") THEN
               
               #add-point:ON ACTION to_armp100 name="menu.to_armp100"
               #160816-00066#2 add
               IF g_rmca_m.rmcastus = 'Y' THEN
                  IF cl_ask_confirm('arm-00060') THEN           #是否自動產生工单
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF armt300_produce_sfaa(g_rmca_m.rmcadocno) THEN
                        CALL s_transaction_end('Y','0')
                        CALL cl_ask_confirm3("std-00012","")
                        CALL armt300_fetch("")
                     ELSE
                        CALL s_transaction_end('N','0')
                        CALL cl_ask_confirm3("adz-00218","")
                     END IF
                     CALL cl_err_collect_show()
                  END IF            
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION to_armp200
            LET g_action_choice="to_armp200"
            IF cl_auth_chk_act("to_armp200") THEN
               
               #add-point:ON ACTION to_armp200 name="menu.to_armp200"
               #160816-00066#2 add
               IF g_rmca_m.rmcastus = 'Y' THEN
                  IF cl_ask_confirm('axm-00719') THEN           #是否自動產生銷退單
                     CALL s_transaction_begin()
                     IF armt300_produce_xmdk(g_rmca_m.rmcadocno) THEN
                        CALL s_transaction_end('Y','0')
                        CALL cl_ask_confirm3("std-00012","")
                        CALL armt300_fetch("")
                     ELSE
                        CALL s_transaction_end('N','0')
                        CALL cl_ask_confirm3("adz-00218","")
                     END IF
                  END IF            
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL armt300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL armt300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL armt300_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rmca_m.rmcadocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="armt300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION armt300_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rmcadocno ",
                      " FROM rmca_t ",
                      " ",
                      " LEFT JOIN rmcb_t ON rmcbent = rmcaent AND rmcadocno = rmcbdocno ", "  ",
                      #add-point:browser_fill段sql(rmcb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " LEFT JOIN rmab_t ON rmabent = "||g_enterprise||" AND rmcadocno = rmabdocno AND rmcbseq = rmabseq ", 
 
 
                      " WHERE rmcaent = " ||g_enterprise|| " AND rmcbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rmca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rmcadocno ",
                      " FROM rmca_t ", 
                      "  ",
                      "  ",
                      " WHERE rmcaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rmca_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_rmca_m.* TO NULL
      CALL g_rmcb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rmcadocno,t0.rmcadocdt,t0.rmca003,t0.rmca004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmcastus,t0.rmcadocno,t0.rmcadocdt,t0.rmca003,t0.rmca004 ",
                  " FROM rmca_t t0",
                  "  ",
                  "  LEFT JOIN rmcb_t ON rmcbent = rmcaent AND rmcadocno = rmcbdocno ", "  ", 
                  #add-point:browser_fill段sql(rmcb_t1) name="browser_fill.join.rmcb_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN rmab_t ON rmabent = "||g_enterprise||" AND rmcadocno = rmabdocno AND rmcbseq = rmabseq ", 
 
 
                  
                  " WHERE t0.rmcaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rmca_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmcastus,t0.rmcadocno,t0.rmcadocdt,t0.rmca003,t0.rmca004 ",
                  " FROM rmca_t t0",
                  "  ",
                  
                  " WHERE t0.rmcaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rmca_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY rmcadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rmca_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rmcadocno,g_browser[g_cnt].b_rmcadocdt, 
          g_browser[g_cnt].b_rmca003,g_browser[g_cnt].b_rmca004
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL armt300_browser_mask()
      
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
         IF g_cnt > g_max_browse THEN
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
   
   IF cl_null(g_browser[g_cnt].b_rmcadocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION armt300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rmca_m.rmcadocno = g_browser[g_current_idx].b_rmcadocno   
 
   EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
       g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
       g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
       g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
       g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
       g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
   
   CALL armt300_rmca_t_mask()
   CALL armt300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="armt300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION armt300_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION armt300_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_rmcadocno = g_rmca_m.rmcadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION armt300_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_rmca_m.* TO NULL
   CALL g_rmcb_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON rmcadocno,rmcadocdt,rmcasite,rmca003,rmca004,rmcastus,rmca001,rmca002, 
          rmcaownid,rmcaowndp,rmcacrtid,rmcacrtdp,rmcacrtdt,rmcamodid,rmcamoddt,rmcacnfid,rmcacnfdt, 
          rmcapstid,rmcapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rmcacrtdt>>----
         AFTER FIELD rmcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rmcamoddt>>----
         AFTER FIELD rmcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmcacnfdt>>----
         AFTER FIELD rmcacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmcapstdt>>----
         AFTER FIELD rmcapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rmcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcadocno
            #add-point:ON ACTION controlp INFIELD rmcadocno name="construct.c.rmcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcadocno  #顯示到畫面上
            NEXT FIELD rmcadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcadocno
            #add-point:BEFORE FIELD rmcadocno name="construct.b.rmcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcadocno
            
            #add-point:AFTER FIELD rmcadocno name="construct.a.rmcadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcadocdt
            #add-point:BEFORE FIELD rmcadocdt name="construct.b.rmcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcadocdt
            
            #add-point:AFTER FIELD rmcadocdt name="construct.a.rmcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcadocdt
            #add-point:ON ACTION controlp INFIELD rmcadocdt name="construct.c.rmcadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcasite
            #add-point:BEFORE FIELD rmcasite name="construct.b.rmcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcasite
            
            #add-point:AFTER FIELD rmcasite name="construct.a.rmcasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcasite
            #add-point:ON ACTION controlp INFIELD rmcasite name="construct.c.rmcasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca003
            #add-point:ON ACTION controlp INFIELD rmca003 name="construct.c.rmca003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmca003  #顯示到畫面上
            NEXT FIELD rmca003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca003
            #add-point:BEFORE FIELD rmca003 name="construct.b.rmca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca003
            
            #add-point:AFTER FIELD rmca003 name="construct.a.rmca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca004
            #add-point:ON ACTION controlp INFIELD rmca004 name="construct.c.rmca004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmca004  #顯示到畫面上
            NEXT FIELD rmca004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca004
            #add-point:BEFORE FIELD rmca004 name="construct.b.rmca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca004
            
            #add-point:AFTER FIELD rmca004 name="construct.a.rmca004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcastus
            #add-point:BEFORE FIELD rmcastus name="construct.b.rmcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcastus
            
            #add-point:AFTER FIELD rmcastus name="construct.a.rmcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcastus
            #add-point:ON ACTION controlp INFIELD rmcastus name="construct.c.rmcastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca001
            #add-point:ON ACTION controlp INFIELD rmca001 name="construct.c.rmca001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmca001  #顯示到畫面上
            NEXT FIELD rmca001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca001
            #add-point:BEFORE FIELD rmca001 name="construct.b.rmca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca001
            
            #add-point:AFTER FIELD rmca001 name="construct.a.rmca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca002
            #add-point:ON ACTION controlp INFIELD rmca002 name="construct.c.rmca002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmca002  #顯示到畫面上
            NEXT FIELD rmca002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca002
            #add-point:BEFORE FIELD rmca002 name="construct.b.rmca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca002
            
            #add-point:AFTER FIELD rmca002 name="construct.a.rmca002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcaownid
            #add-point:ON ACTION controlp INFIELD rmcaownid name="construct.c.rmcaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcaownid  #顯示到畫面上
            NEXT FIELD rmcaownid                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcaownid
            #add-point:BEFORE FIELD rmcaownid name="construct.b.rmcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcaownid
            
            #add-point:AFTER FIELD rmcaownid name="construct.a.rmcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcaowndp
            #add-point:ON ACTION controlp INFIELD rmcaowndp name="construct.c.rmcaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcaowndp  #顯示到畫面上
            NEXT FIELD rmcaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcaowndp
            #add-point:BEFORE FIELD rmcaowndp name="construct.b.rmcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcaowndp
            
            #add-point:AFTER FIELD rmcaowndp name="construct.a.rmcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcacrtid
            #add-point:ON ACTION controlp INFIELD rmcacrtid name="construct.c.rmcacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcacrtid  #顯示到畫面上
            NEXT FIELD rmcacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcacrtid
            #add-point:BEFORE FIELD rmcacrtid name="construct.b.rmcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcacrtid
            
            #add-point:AFTER FIELD rmcacrtid name="construct.a.rmcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcacrtdp
            #add-point:ON ACTION controlp INFIELD rmcacrtdp name="construct.c.rmcacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcacrtdp  #顯示到畫面上
            NEXT FIELD rmcacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcacrtdp
            #add-point:BEFORE FIELD rmcacrtdp name="construct.b.rmcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcacrtdp
            
            #add-point:AFTER FIELD rmcacrtdp name="construct.a.rmcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcacrtdt
            #add-point:BEFORE FIELD rmcacrtdt name="construct.b.rmcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcamodid
            #add-point:ON ACTION controlp INFIELD rmcamodid name="construct.c.rmcamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcamodid  #顯示到畫面上
            NEXT FIELD rmcamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcamodid
            #add-point:BEFORE FIELD rmcamodid name="construct.b.rmcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcamodid
            
            #add-point:AFTER FIELD rmcamodid name="construct.a.rmcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcamoddt
            #add-point:BEFORE FIELD rmcamoddt name="construct.b.rmcamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmcacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcacnfid
            #add-point:ON ACTION controlp INFIELD rmcacnfid name="construct.c.rmcacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcacnfid  #顯示到畫面上
            NEXT FIELD rmcacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcacnfid
            #add-point:BEFORE FIELD rmcacnfid name="construct.b.rmcacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcacnfid
            
            #add-point:AFTER FIELD rmcacnfid name="construct.a.rmcacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcacnfdt
            #add-point:BEFORE FIELD rmcacnfdt name="construct.b.rmcacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmcapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcapstid
            #add-point:ON ACTION controlp INFIELD rmcapstid name="construct.c.rmcapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcapstid  #顯示到畫面上
            NEXT FIELD rmcapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcapstid
            #add-point:BEFORE FIELD rmcapstid name="construct.b.rmcapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcapstid
            
            #add-point:AFTER FIELD rmcapstid name="construct.a.rmcapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcapstdt
            #add-point:BEFORE FIELD rmcapstdt name="construct.b.rmcapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rmcbsite,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004,rmcb005,rmcb005_desc, 
          rmcb006,rmab017,rmcb007,rmcb008,rmcb009,rmcb010,rmcb011
           FROM s_detail1[1].rmcbsite,s_detail1[1].rmcbseq,s_detail1[1].rmcb001,s_detail1[1].rmcb002, 
               s_detail1[1].rmcb003,s_detail1[1].rmcb004,s_detail1[1].rmcb005,s_detail1[1].rmcb005_desc, 
               s_detail1[1].rmcb006,s_detail1[1].rmab017,s_detail1[1].rmcb007,s_detail1[1].rmcb008,s_detail1[1].rmcb009, 
               s_detail1[1].rmcb010,s_detail1[1].rmcb011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcbsite
            #add-point:BEFORE FIELD rmcbsite name="construct.b.page1.rmcbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcbsite
            
            #add-point:AFTER FIELD rmcbsite name="construct.a.page1.rmcbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcbsite
            #add-point:ON ACTION controlp INFIELD rmcbsite name="construct.c.page1.rmcbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcbseq
            #add-point:BEFORE FIELD rmcbseq name="construct.b.page1.rmcbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcbseq
            
            #add-point:AFTER FIELD rmcbseq name="construct.a.page1.rmcbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcbseq
            #add-point:ON ACTION controlp INFIELD rmcbseq name="construct.c.page1.rmcbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmcb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb001
            #add-point:ON ACTION controlp INFIELD rmcb001 name="construct.c.page1.rmcb001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcb001  #顯示到畫面上
            NEXT FIELD rmcb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb001
            #add-point:BEFORE FIELD rmcb001 name="construct.b.page1.rmcb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb001
            
            #add-point:AFTER FIELD rmcb001 name="construct.a.page1.rmcb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb002
            #add-point:BEFORE FIELD rmcb002 name="construct.b.page1.rmcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb002
            
            #add-point:AFTER FIELD rmcb002 name="construct.a.page1.rmcb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb002
            #add-point:ON ACTION controlp INFIELD rmcb002 name="construct.c.page1.rmcb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb003
            #add-point:BEFORE FIELD rmcb003 name="construct.b.page1.rmcb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb003
            
            #add-point:AFTER FIELD rmcb003 name="construct.a.page1.rmcb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb003
            #add-point:ON ACTION controlp INFIELD rmcb003 name="construct.c.page1.rmcb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmcb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb004
            #add-point:ON ACTION controlp INFIELD rmcb004 name="construct.c.page1.rmcb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcb004  #顯示到畫面上
            NEXT FIELD rmcb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb004
            #add-point:BEFORE FIELD rmcb004 name="construct.b.page1.rmcb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb004
            
            #add-point:AFTER FIELD rmcb004 name="construct.a.page1.rmcb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb005
            #add-point:BEFORE FIELD rmcb005 name="construct.b.page1.rmcb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb005
            
            #add-point:AFTER FIELD rmcb005 name="construct.a.page1.rmcb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb005
            #add-point:ON ACTION controlp INFIELD rmcb005 name="construct.c.page1.rmcb005"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb005_desc
            #add-point:BEFORE FIELD rmcb005_desc name="construct.b.page1.rmcb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb005_desc
            
            #add-point:AFTER FIELD rmcb005_desc name="construct.a.page1.rmcb005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb005_desc
            #add-point:ON ACTION controlp INFIELD rmcb005_desc name="construct.c.page1.rmcb005_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmcb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb006
            #add-point:ON ACTION controlp INFIELD rmcb006 name="construct.c.page1.rmcb006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcb006  #顯示到畫面上
            NEXT FIELD rmcb006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb006
            #add-point:BEFORE FIELD rmcb006 name="construct.b.page1.rmcb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb006
            
            #add-point:AFTER FIELD rmcb006 name="construct.a.page1.rmcb006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab017
            #add-point:BEFORE FIELD rmab017 name="construct.b.page1.rmab017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab017
            
            #add-point:AFTER FIELD rmab017 name="construct.a.page1.rmab017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab017
            #add-point:ON ACTION controlp INFIELD rmab017 name="construct.c.page1.rmab017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb007
            #add-point:BEFORE FIELD rmcb007 name="construct.b.page1.rmcb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb007
            
            #add-point:AFTER FIELD rmcb007 name="construct.a.page1.rmcb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb007
            #add-point:ON ACTION controlp INFIELD rmcb007 name="construct.c.page1.rmcb007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmcb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb008
            #add-point:ON ACTION controlp INFIELD rmcb008 name="construct.c.page1.rmcb008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1132"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmcb008  #顯示到畫面上
            NEXT FIELD rmcb008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb008
            #add-point:BEFORE FIELD rmcb008 name="construct.b.page1.rmcb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb008
            
            #add-point:AFTER FIELD rmcb008 name="construct.a.page1.rmcb008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb009
            #add-point:BEFORE FIELD rmcb009 name="construct.b.page1.rmcb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb009
            
            #add-point:AFTER FIELD rmcb009 name="construct.a.page1.rmcb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb009
            #add-point:ON ACTION controlp INFIELD rmcb009 name="construct.c.page1.rmcb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb010
            #add-point:BEFORE FIELD rmcb010 name="construct.b.page1.rmcb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb010
            
            #add-point:AFTER FIELD rmcb010 name="construct.a.page1.rmcb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb010
            #add-point:ON ACTION controlp INFIELD rmcb010 name="construct.c.page1.rmcb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb011
            #add-point:BEFORE FIELD rmcb011 name="construct.b.page1.rmcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb011
            
            #add-point:AFTER FIELD rmcb011 name="construct.a.page1.rmcb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmcb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb011
            #add-point:ON ACTION controlp INFIELD rmcb011 name="construct.c.page1.rmcb011"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "rmca_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rmcb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION armt300_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON rmcadocno,rmcadocdt,rmca003,rmca004
                          FROM s_browse[1].b_rmcadocno,s_browse[1].b_rmcadocdt,s_browse[1].b_rmca003, 
                              s_browse[1].b_rmca004
 
         BEFORE CONSTRUCT
               DISPLAY armt300_filter_parser('rmcadocno') TO s_browse[1].b_rmcadocno
            DISPLAY armt300_filter_parser('rmcadocdt') TO s_browse[1].b_rmcadocdt
            DISPLAY armt300_filter_parser('rmca003') TO s_browse[1].b_rmca003
            DISPLAY armt300_filter_parser('rmca004') TO s_browse[1].b_rmca004
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL armt300_filter_show('rmcadocno')
   CALL armt300_filter_show('rmcadocdt')
   CALL armt300_filter_show('rmca003')
   CALL armt300_filter_show('rmca004')
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION armt300_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="armt300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION armt300_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = armt300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION armt300_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_rmcb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL armt300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL armt300_browser_fill("")
      CALL armt300_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL armt300_filter_show('rmcadocno')
   CALL armt300_filter_show('rmcadocdt')
   CALL armt300_filter_show('rmca003')
   CALL armt300_filter_show('rmca004')
   CALL armt300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL armt300_fetch("F") 
      #顯示單身筆數
      CALL armt300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION armt300_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_rmca_m.rmcadocno = g_browser[g_current_idx].b_rmcadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
       g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
       g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
       g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
       g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
       g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
   
   #遮罩相關處理
   LET g_rmca_m_mask_o.* =  g_rmca_m.*
   CALL armt300_rmca_t_mask()
   LET g_rmca_m_mask_n.* =  g_rmca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt300_set_act_visible()   
   CALL armt300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rmca_m_t.* = g_rmca_m.*
   LET g_rmca_m_o.* = g_rmca_m.*
   
   LET g_data_owner = g_rmca_m.rmcaownid      
   LET g_data_dept  = g_rmca_m.rmcaowndp
   
   #重新顯示   
   CALL armt300_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.insert" >}
#+ 資料新增
PRIVATE FUNCTION armt300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rmcb_d.clear()   
 
 
   INITIALIZE g_rmca_m.* TO NULL             #DEFAULT 設定
   
   LET g_rmcadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmca_m.rmcaownid = g_user
      LET g_rmca_m.rmcaowndp = g_dept
      LET g_rmca_m.rmcacrtid = g_user
      LET g_rmca_m.rmcacrtdp = g_dept 
      LET g_rmca_m.rmcacrtdt = cl_get_current()
      LET g_rmca_m.rmcamodid = g_user
      LET g_rmca_m.rmcamoddt = cl_get_current()
      LET g_rmca_m.rmcastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_rmca_m.rmcasite = g_site
      LET g_rmca_m.rmcadocdt = g_today
      LET g_rmca_m.rmca003 = g_user
      LET g_rmca_m.rmca004 = g_dept
      CALL s_desc_get_person_desc(g_rmca_m.rmca003) RETURNING g_rmca_m.rmca003_desc 
      CALL s_desc_get_department_desc(g_rmca_m.rmca004) RETURNING g_rmca_m.rmca004_desc            
      LET g_rmca_m_t.* = g_rmca_m.* 
      LET g_rmca_m_o.* = g_rmca_m.*      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rmca_m_t.* = g_rmca_m.*
      LET g_rmca_m_o.* = g_rmca_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmca_m.rmcastus 
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
 
 
 
    
      CALL armt300_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_rmca_m.* TO NULL
         INITIALIZE g_rmcb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL armt300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rmcb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt300_set_act_visible()   
   CALL armt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmcaent = " ||g_enterprise|| " AND",
                      " rmcadocno = '", g_rmca_m.rmcadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE armt300_cl
   
   CALL armt300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
       g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
       g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
       g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
       g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
       g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
   
   
   #遮罩相關處理
   LET g_rmca_m_mask_o.* =  g_rmca_m.*
   CALL armt300_rmca_t_mask()
   LET g_rmca_m_mask_n.* =  g_rmca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocno_desc,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003, 
       g_rmca_m.rmca003_desc,g_rmca_m.rmca004,g_rmca_m.rmca004_desc,g_rmca_m.rmcastus,g_rmca_m.rmca001, 
       g_rmca_m.rmca002,g_rmca_m.rmca002_desc,g_rmca_m.rmcaownid,g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp, 
       g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid,g_rmca_m.rmcamodid_desc,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid, 
       g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstid_desc,g_rmca_m.rmcapstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rmca_m.rmcaownid      
   LET g_data_dept  = g_rmca_m.rmcaowndp
   
   #功能已完成,通報訊息中心
   CALL armt300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.modify" >}
#+ 資料修改
PRIVATE FUNCTION armt300_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rmca_m_t.* = g_rmca_m.*
   LET g_rmca_m_o.* = g_rmca_m.*
   
   IF g_rmca_m.rmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
   CALL s_transaction_begin()
   
   OPEN armt300_cl USING g_enterprise,g_rmca_m.rmcadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
       g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
       g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
       g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
       g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
       g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
   
   #檢查是否允許此動作
   IF NOT armt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmca_m_mask_o.* =  g_rmca_m.*
   CALL armt300_rmca_t_mask()
   LET g_rmca_m_mask_n.* =  g_rmca_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL armt300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rmca_m.rmcamodid = g_user 
LET g_rmca_m.rmcamoddt = cl_get_current()
LET g_rmca_m.rmcamodid_desc = cl_get_username(g_rmca_m.rmcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_rmca_m.rmcastus MATCHES "[DR]" THEN 
         LET g_rmca_m.rmcastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL armt300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rmca_t SET (rmcamodid,rmcamoddt) = (g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt)
          WHERE rmcaent = g_enterprise AND rmcadocno = g_rmcadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rmca_m.* = g_rmca_m_t.*
            CALL armt300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rmca_m.rmcadocno != g_rmca_m_t.rmcadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rmcb_t SET rmcbdocno = g_rmca_m.rmcadocno
 
          WHERE rmcbent = g_enterprise AND rmcbdocno = g_rmca_m_t.rmcadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rmcb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmcb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'rmabent'
LET l_new_key[02] = g_rmca_m.rmcadocno
LET l_old_key[02] = g_rmcadocno_t
LET l_field_key[02] = 'rmabdocno'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'rmab_t')
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt300_set_act_visible()   
   CALL armt300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rmcaent = " ||g_enterprise|| " AND",
                      " rmcadocno = '", g_rmca_m.rmcadocno, "' "
 
   #填到對應位置
   CALL armt300_browser_fill("")
 
   CLOSE armt300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="armt300.input" >}
#+ 資料輸入
PRIVATE FUNCTION armt300_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_rmac001 LIKE rmac_t.rmac001
   DEFINE l_rmcb007 LIKE rmcb_t.rmcb007
   DEFINE l_where               STRING  #160204-00004#4 Add By Ken 160222(S)
   DEFINE l_msg                 LIKE type_t.chr10     #160816-00066#2 add
   DEFINE l_num                 LIKE type_t.num10     #160816-00066#2 add
   DEFINE l_sql1          STRING            #160711-00040#28 add
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocno_desc,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003, 
       g_rmca_m.rmca003_desc,g_rmca_m.rmca004,g_rmca_m.rmca004_desc,g_rmca_m.rmcastus,g_rmca_m.rmca001, 
       g_rmca_m.rmca002,g_rmca_m.rmca002_desc,g_rmca_m.rmcaownid,g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp, 
       g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid,g_rmca_m.rmcamodid_desc,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid, 
       g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstid_desc,g_rmca_m.rmcapstdt 
 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rmcbsite,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,rmcb007, 
       rmcb008,rmcb009,rmcb010,rmcb011 FROM rmcb_t WHERE rmcbent=? AND rmcbdocno=? AND rmcbseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt300_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL armt300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL armt300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004, 
       g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   LET g_ask = TRUE  #160816-00066#2 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="armt300.input.head" >}
      #單頭段
      INPUT BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004, 
          g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN armt300_cl USING g_enterprise,g_rmca_m.rmcadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL armt300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL armt300_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcadocno
            
            #add-point:AFTER FIELD rmcadocno name="input.a.rmcadocno"
            CALL s_aooi200_get_slip_desc(g_rmca_m.rmcadocno) RETURNING g_rmca_m.rmcadocno_desc
            DISPLAY BY NAME g_rmca_m.rmcadocno_desc            
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rmca_m.rmcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmca_m.rmcadocno != g_rmcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmca_t WHERE "||"rmcaent = '" ||g_enterprise|| "' AND "||"rmcadocno = '"||g_rmca_m.rmcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_rmca_m.rmcadocno) THEN 
               IF NOT s_aooi200_chk_slip(g_site,'',g_rmca_m.rmcadocno,g_prog) THEN
                  LET g_rmca_m.rmcadocno = g_rmca_m_o.rmcadocno
                  NEXT FIELD CURRENT
               END IF   
            END IF
            
            #160204-00004#4 Add By Ken 160222(S)
            #如果單號新舊值不同時，把來源單號清空
            IF NOT cl_null(g_rmca_m.rmcadocno) THEN 
               IF (g_rmca_m.rmcadocno <> g_rmca_m_o.rmcadocno) OR (g_rmca_m_o.rmcadocno IS NULL) THEN
                  LET g_rmca_m.rmca001 = ''
                  DISPLAY BY NAME g_rmca_m.rmca001
               END IF
            END IF
            LET g_rmca_m_o.rmcadocno = g_rmca_m.rmcadocno            
            #160204-00004#4 Add By Ken 160222(E)	
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcadocno
            #add-point:BEFORE FIELD rmcadocno name="input.b.rmcadocno"
            CALL s_aooi200_get_slip_desc(g_rmca_m.rmcadocno) RETURNING g_rmca_m.rmcadocno_desc
            DISPLAY BY NAME g_rmca_m.rmcadocno_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcadocno
            #add-point:ON CHANGE rmcadocno name="input.g.rmcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcadocdt
            #add-point:BEFORE FIELD rmcadocdt name="input.b.rmcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcadocdt
            
            #add-point:AFTER FIELD rmcadocdt name="input.a.rmcadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcadocdt
            #add-point:ON CHANGE rmcadocdt name="input.g.rmcadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcasite
            #add-point:BEFORE FIELD rmcasite name="input.b.rmcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcasite
            
            #add-point:AFTER FIELD rmcasite name="input.a.rmcasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcasite
            #add-point:ON CHANGE rmcasite name="input.g.rmcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca003
            
            #add-point:AFTER FIELD rmca003 name="input.a.rmca003"
            CALL s_desc_get_person_desc(g_rmca_m.rmca003) RETURNING g_rmca_m.rmca003_desc 
            DISPLAY BY NAME g_rmca_m.rmca003_desc
            
            IF NOT cl_null(g_rmca_m.rmca003) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rmca_m_o.rmca003 <> g_rmca_m.rmca003 OR cl_null(g_rmca_m_o.rmca003))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rmca_m.rmca003                  
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     CALL armt300_rmca003_def()                     
                  ELSE
                     #檢查失敗時後續處理
                     LET g_rmca_m.rmca003 = g_rmca_m_t.rmca003
                     NEXT FIELD CURRENT 
                  END IF                     
               END IF
            END IF
            LET g_rmca_m_o.rmca003 = g_rmca_m.rmca003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca003
            #add-point:BEFORE FIELD rmca003 name="input.b.rmca003"
            CALL s_desc_get_person_desc(g_rmca_m.rmca003) RETURNING g_rmca_m.rmca003_desc
            DISPLAY BY NAME g_rmca_m.rmca003_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmca003
            #add-point:ON CHANGE rmca003 name="input.g.rmca003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca004
            
            #add-point:AFTER FIELD rmca004 name="input.a.rmca004"
            CALL s_desc_get_department_desc(g_rmca_m.rmca004) RETURNING g_rmca_m.rmca004_desc
            DISPLAY BY NAME g_rmca_m.rmca004_desc
            IF NOT cl_null(g_rmca_m.rmca003) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmca_m.rmca004
               LET g_chkparam.arg2 = g_rmca_m.rmcadocdt
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_rmca_m.rmca004 = g_rmca_m_t.rmca004
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca004
            #add-point:BEFORE FIELD rmca004 name="input.b.rmca004"
            CALL s_desc_get_department_desc(g_rmca_m.rmca004) RETURNING g_rmca_m.rmca004_desc
            DISPLAY BY NAME g_rmca_m.rmca004_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmca004
            #add-point:ON CHANGE rmca004 name="input.g.rmca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcastus
            #add-point:BEFORE FIELD rmcastus name="input.b.rmcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcastus
            
            #add-point:AFTER FIELD rmcastus name="input.a.rmcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcastus
            #add-point:ON CHANGE rmcastus name="input.g.rmcastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca001
            #add-point:BEFORE FIELD rmca001 name="input.b.rmca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca001
            
            #add-point:AFTER FIELD rmca001 name="input.a.rmca001"
            IF NOT cl_null(g_rmca_m.rmca001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rmca_m_o.rmca001 <> g_rmca_m.rmca001 OR cl_null(g_rmca_m_o.rmca001))) THEN 
                  #160204-00004#4 Add By Ken 160222(S)
                  IF NOT s_aooi210_check_doc(g_site,'',g_rmca_m.rmca001,g_rmca_m.rmcadocno,'4','') THEN
                     LET g_rmca_m.rmca001 = g_rmca_m_t.rmca001
                     NEXT FIELD CURRENT
                  END IF
                  #160204-00004#4 Add By Ken 160222(E)                  
                  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rmca_m.rmca001
                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_rmaadocno_2") THEN
                     SELECT rmaa001 INTO g_rmca_m.rmca002 
                       FROM rmaa_t
                      WHERE rmaaent = g_enterprise
                        AND rmaadocno = g_rmca_m.rmca001 
                     DISPLAY BY NAME g_rmca_m.rmca002                         
                  ELSE
                     LET g_rmca_m.rmca001 = g_rmca_m_t.rmca001
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF
            LET g_rmca_m_o.rmca001 = g_rmca_m.rmca001
            CALL armt300_set_entry(p_cmd)
            CALL armt300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmca001
            #add-point:ON CHANGE rmca001 name="input.g.rmca001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmca002
            
            #add-point:AFTER FIELD rmca002 name="input.a.rmca002"
            CALL s_desc_get_trading_partner_abbr_desc(g_rmca_m.rmca002) RETURNING g_rmca_m.rmca002_desc
            DISPLAY BY NAME g_rmca_m.rmca002_desc
            IF NOT cl_null(g_rmca_m.rmca002) THEN 
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmca_m.rmca002
               LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_7") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmca002
            #add-point:BEFORE FIELD rmca002 name="input.b.rmca002"
            CALL s_desc_get_trading_partner_abbr_desc(g_rmca_m.rmca002) RETURNING g_rmca_m.rmca002_desc
            DISPLAY BY NAME g_rmca_m.rmca002_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmca002
            #add-point:ON CHANGE rmca002 name="input.g.rmca002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rmcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcadocno
            #add-point:ON ACTION controlp INFIELD rmcadocno name="input.c.rmcadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmca_m.rmcadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef.ooef004
            LET g_qryparam.arg2 = g_prog
            #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rmca_m.rmcadocno = g_qryparam.return1              

            DISPLAY g_rmca_m.rmcadocno TO rmcadocno              #

            NEXT FIELD rmcadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcadocdt
            #add-point:ON ACTION controlp INFIELD rmcadocdt name="input.c.rmcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmcasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcasite
            #add-point:ON ACTION controlp INFIELD rmcasite name="input.c.rmcasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca003
            #add-point:ON ACTION controlp INFIELD rmca003 name="input.c.rmca003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmca_m.rmca003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_rmca_m.rmca003 = g_qryparam.return1              

            DISPLAY g_rmca_m.rmca003 TO rmca003              #
            CALL armt300_rmca003_def()
            NEXT FIELD rmca003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca004
            #add-point:ON ACTION controlp INFIELD rmca004 name="input.c.rmca004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmca_m.rmca004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_rmca_m.rmcadocdt


            CALL q_ooeg001()                                #呼叫開窗

            LET g_rmca_m.rmca004 = g_qryparam.return1              

            DISPLAY g_rmca_m.rmca004 TO rmca004              #

            NEXT FIELD rmca004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcastus
            #add-point:ON ACTION controlp INFIELD rmcastus name="input.c.rmcastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca001
            #add-point:ON ACTION controlp INFIELD rmca001 name="input.c.rmca001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmca_m.rmca001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " rmaastus = 'S' ",
                                   " AND EXISTS(SELECT * FROM rmac_t WHERE rmaaent = rmacent AND rmaadocno=rmacdocno)"            
            #160204-00004#4 Add By Ken 160222(S)
            #組合過濾前後置單據資料SQL
            CALL s_aooi210_get_check_sql(g_site,'',g_rmca_m.rmcadocno,'4','','rmaadocno') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_where
               CALL q_rmaadocno()
            END IF
            #160204-00004#4 Add By Ken 160222(E)           
                 
            #CALL q_rmaadocno()             #呼叫開窗   #160204-00004#4 Mark By Ken 160222(S)

            LET g_rmca_m.rmca001 = g_qryparam.return1              

            DISPLAY g_rmca_m.rmca001 TO rmca001              #

            NEXT FIELD rmca001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmca002
            #add-point:ON ACTION controlp INFIELD rmca002 name="input.c.rmca002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmca_m.rmca002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site


            CALL q_pmaa001_6()                                #呼叫開窗

            LET g_rmca_m.rmca002 = g_qryparam.return1              

            DISPLAY g_rmca_m.rmca002 TO rmca002              #

            NEXT FIELD rmca002                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rmca_m.rmcadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt,g_prog) 
                  RETURNING l_success,g_rmca_m.rmcadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_rmca_m.rmcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD rmcadocno
               END IF
               #end add-point
               
               INSERT INTO rmca_t (rmcaent,rmcadocno,rmcadocdt,rmcasite,rmca003,rmca004,rmcastus,rmca001, 
                   rmca002,rmcaownid,rmcaowndp,rmcacrtid,rmcacrtdp,rmcacrtdt,rmcamodid,rmcamoddt,rmcacnfid, 
                   rmcacnfdt,rmcapstid,rmcapstdt)
               VALUES (g_enterprise,g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003, 
                   g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002,g_rmca_m.rmcaownid, 
                   g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid, 
                   g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rmca_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #160816-00066#2 add-S
               IF NOT cl_null(g_rmca_m.rmca001) AND g_ask = TRUE THEN   
                  LET l_msg = 'arm-00045'   #是否由[RMA维护作业(armt100)]自动产生单身资料！
                  IF cl_ask_confirm(l_msg) THEN
                        CALL armt300_auto_insert() RETURNING l_success #自動帶入RMA單單身
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.code   = 'arm-00059'    #该RMA单点收料件均已做判别处理，故无单身产生。
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                        END IF
                  END IF
                  LET g_ask = FALSE
               END IF
               CALL armt300_b_fill()
               #160816-00066#2 add-E
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL armt300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL armt300_b_fill()
                  CALL armt300_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL armt300_rmca_t_mask_restore('restore_mask_o')
               
               UPDATE rmca_t SET (rmcadocno,rmcadocdt,rmcasite,rmca003,rmca004,rmcastus,rmca001,rmca002, 
                   rmcaownid,rmcaowndp,rmcacrtid,rmcacrtdp,rmcacrtdt,rmcamodid,rmcamoddt,rmcacnfid,rmcacnfdt, 
                   rmcapstid,rmcapstdt) = (g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003, 
                   g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002,g_rmca_m.rmcaownid, 
                   g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid, 
                   g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstdt) 
 
                WHERE rmcaent = g_enterprise AND rmcadocno = g_rmcadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmca_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL armt300_rmca_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rmca_m_t)
               LET g_log2 = util.JSON.stringify(g_rmca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               LET g_rmca_m_t.* = g_rmca_m.*
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="armt300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rmcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #160816-00066#2 add-S
            LET l_num = 0
            SELECT COUNT(1) INTO l_num
              FROM rmcb_t
             WHERE rmcbent = g_enterprise
               AND rmcbsite = g_site
               AND rmcbdocno = g_rmca_m.rmcadocno
            IF NOT cl_null(g_rmca_m.rmca001) AND (l_num = 0 OR cl_null(l_num)) AND g_ask = TRUE THEN   
                  LET l_msg = 'arm-00045'   #是否由[RMA维护作业(armt100)]自动产生单身资料！
                  IF cl_ask_confirm(l_msg) THEN
                        CALL armt300_auto_insert() RETURNING l_success #自動帶入RMA單單身
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.code   = 'arm-00059'    #该RMA单点收料件均已做判别处理，故无单身产生。
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                        END IF
                        LET g_ask = FALSE
                  END IF
            END IF
            #160816-00066#2 add-E
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rmcb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL armt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rmcb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN armt300_cl USING g_enterprise,g_rmca_m.rmcadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rmcb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmcb_d[l_ac].rmcbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rmcb_d_t.* = g_rmcb_d[l_ac].*  #BACKUP
               LET g_rmcb_d_o.* = g_rmcb_d[l_ac].*  #BACKUP
               CALL armt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL armt300_set_no_entry_b(l_cmd)
               IF NOT armt300_lock_b("rmcb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH armt300_bcl INTO g_rmcb_d[l_ac].rmcbsite,g_rmcb_d[l_ac].rmcbseq,g_rmcb_d[l_ac].rmcb001, 
                      g_rmcb_d[l_ac].rmcb002,g_rmcb_d[l_ac].rmcb003,g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005, 
                      g_rmcb_d[l_ac].rmcb006,g_rmcb_d[l_ac].rmcb007,g_rmcb_d[l_ac].rmcb008,g_rmcb_d[l_ac].rmcb009, 
                      g_rmcb_d[l_ac].rmcb010,g_rmcb_d[l_ac].rmcb011
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rmcb_d_t.rmcbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rmcb_d_mask_o[l_ac].* =  g_rmcb_d[l_ac].*
                  CALL armt300_rmcb_t_mask()
                  LET g_rmcb_d_mask_n[l_ac].* =  g_rmcb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL armt300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.rmabdocno = g_rmca_m.rmcadocno
LET g_detail_multi_table_t.rmabseq = g_rmcb_d[l_ac].rmcbseq
LET g_detail_multi_table_t.rmab017 = g_rmcb_d[l_ac].rmab017
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rmabent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rmabdocno'
            LET l_var_keys[02] = g_rmca_m.rmcadocno
            LET l_field_keys[03] = 'rmabseq'
            LET l_var_keys[03] = g_rmcb_d[l_ac].rmcbseq
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rmab_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rmcb_d[l_ac].* TO NULL 
            INITIALIZE g_rmcb_d_t.* TO NULL 
            INITIALIZE g_rmcb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rmcb_d[l_ac].rmcb009 = "1"
      LET g_rmcb_d[l_ac].rmcb010 = "0"
      LET g_rmcb_d[l_ac].rmcb011 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_rmcb_d[l_ac].rmcbsite = g_rmca_m.rmcasite
            IF cl_null(g_rmcb_d[l_ac].rmcbseq) THEN
               SELECT MAX(rmcbseq) INTO g_rmcb_d[l_ac].rmcbseq
                 FROM rmcb_t
                WHERE rmcbent = g_enterprise
                  AND rmcbdocno = g_rmca_m.rmcadocno
               IF cl_null(g_rmcb_d[l_ac].rmcbseq) THEN 
                  LET g_rmcb_d[l_ac].rmcbseq = 1
               ELSE
                  LET g_rmcb_d[l_ac].rmcbseq = g_rmcb_d[l_ac].rmcbseq + 1               
               END IF
            END IF
            IF NOT cl_null(g_rmca_m.rmca001) THEN 
               LET g_rmcb_d[l_ac].rmcb001 = g_rmca_m.rmca001
            END IF
            #end add-point
            LET g_rmcb_d_t.* = g_rmcb_d[l_ac].*     #新輸入資料
            LET g_rmcb_d_o.* = g_rmcb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL armt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL armt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rmcb_d[li_reproduce_target].* = g_rmcb_d[li_reproduce].*
 
               LET g_rmcb_d[li_reproduce_target].rmcbseq = NULL
 
            END IF
            
LET g_detail_multi_table_t.rmabdocno = g_rmca_m.rmcadocno
LET g_detail_multi_table_t.rmabseq = g_rmcb_d[l_ac].rmcbseq
LET g_detail_multi_table_t.rmab017 = g_rmcb_d[l_ac].rmab017
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rmcb_t 
             WHERE rmcbent = g_enterprise AND rmcbdocno = g_rmca_m.rmcadocno
 
               AND rmcbseq = g_rmcb_d[l_ac].rmcbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmca_m.rmcadocno
               LET gs_keys[2] = g_rmcb_d[g_detail_idx].rmcbseq
               CALL armt300_insert_b('rmcb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rmcb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmcb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt300_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rmca_m.rmcadocno = g_detail_multi_table_t.rmabdocno AND
         g_rmcb_d[l_ac].rmcbseq = g_detail_multi_table_t.rmabseq AND
         g_rmcb_d[l_ac].rmab017 = g_detail_multi_table_t.rmab017 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rmabent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rmca_m.rmcadocno
            LET l_field_keys[02] = 'rmabdocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rmabdocno
            LET l_var_keys[03] = g_rmcb_d[l_ac].rmcbseq
            LET l_field_keys[03] = 'rmabseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rmabseq
            LET l_vars[01] = g_rmcb_d[l_ac].rmab017
            LET l_fields[01] = 'rmab017'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rmab_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rmca_m.rmcadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rmcb_d_t.rmcbseq
 
            
               #刪除同層單身
               IF NOT armt300_delete_b('rmcb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT armt300_key_delete_b(gs_keys,'rmcb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rmabent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rmabdocno'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rmabdocno
                  LET l_field_keys[03] = 'rmabseq'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.rmabseq
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rmab_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE armt300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rmcb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmcb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcbsite
            #add-point:BEFORE FIELD rmcbsite name="input.b.page1.rmcbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcbsite
            
            #add-point:AFTER FIELD rmcbsite name="input.a.page1.rmcbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcbsite
            #add-point:ON CHANGE rmcbsite name="input.g.page1.rmcbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcbseq
            #add-point:BEFORE FIELD rmcbseq name="input.b.page1.rmcbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcbseq
            
            #add-point:AFTER FIELD rmcbseq name="input.a.page1.rmcbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rmca_m.rmcadocno IS NOT NULL AND g_rmcb_d[g_detail_idx].rmcbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rmca_m.rmcadocno != g_rmcadocno_t OR g_rmcb_d[g_detail_idx].rmcbseq != g_rmcb_d_t.rmcbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmcb_t WHERE "||"rmcbent = '" ||g_enterprise|| "' AND "||"rmcbdocno = '"||g_rmca_m.rmcadocno ||"' AND "|| "rmcbseq = '"||g_rmcb_d[g_detail_idx].rmcbseq ||"'",'std-00004',0) THEN 
                     LET g_rmcb_d[l_ac].rmcbseq = g_rmcb_d_t.rmcbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcbseq
            #add-point:ON CHANGE rmcbseq name="input.g.page1.rmcbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb001
            #add-point:BEFORE FIELD rmcb001 name="input.b.page1.rmcb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb001
            
            #add-point:AFTER FIELD rmcb001 name="input.a.page1.rmcb001"
            IF NOT cl_null(g_rmcb_d[l_ac].rmcb001) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rmcb_d_o.rmcb001 <> g_rmcb_d[l_ac].rmcb001 OR cl_null(g_rmcb_d_o.rmcb001))) THEN 
                  #160204-00004#4 Add By Ken 160222(S)
                  IF NOT s_aooi210_check_doc(g_site,'',g_rmcb_d[l_ac].rmcb001,g_rmca_m.rmcadocno,'4','') THEN
                     LET g_rmcb_d[l_ac].rmcb001 = g_rmcb_d_t.rmcb001 
                     NEXT FIELD CURRENT
                  END IF
                  #160204-00004#4 Add By Ken 160222(E)        
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rmcb_d[l_ac].rmcb001
                  LET g_chkparam.arg2 = g_rmca_m.rmca002
                  IF NOT cl_chk_exist("v_rmaadocno_1") THEN
                     LET g_rmcb_d[l_ac].rmcb001 = g_rmcb_d_t.rmcb001 
                     NEXT FIELD CURRENT
                  END IF 
                  IF NOT armt300_rmac_chk_def(l_cmd) THEN 
                     LET g_rmcb_d[l_ac].rmcb001 = g_rmcb_d_t.rmcb001 
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            END IF
            LET g_rmcb_d_o.rmcb001 = g_rmcb_d[l_ac].rmcb001               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb001
            #add-point:ON CHANGE rmcb001 name="input.g.page1.rmcb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmcb_d[l_ac].rmcb002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmcb002
            END IF 
 
 
 
            #add-point:AFTER FIELD rmcb002 name="input.a.page1.rmcb002"
            IF NOT cl_null(g_rmcb_d[l_ac].rmcb002) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rmcb_d_o.rmcb002 <> g_rmcb_d[l_ac].rmcb002 OR cl_null(g_rmcb_d_o.rmcb002))) THEN 
                  IF NOT armt300_rmac_chk_def(l_cmd) THEN 
                     LET g_rmcb_d[l_ac].rmcb002 = g_rmcb_d_t.rmcb002 
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF
            LET g_rmcb_d_o.rmcb002 = g_rmcb_d[l_ac].rmcb002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb002
            #add-point:BEFORE FIELD rmcb002 name="input.b.page1.rmcb002"
            #160816-00066#2 add-S
            IF NOT cl_null(g_rmcb_d[l_ac].rmcb001) THEN
               IF NOT armt300_rmac_chk_def(l_cmd) THEN 
                  LET g_rmcb_d[l_ac].rmcb001 = g_rmcb_d_t.rmcb001 
                  NEXT FIELD rmcb001
               END IF   
            END IF
            #160816-00066#2 add-E
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb002
            #add-point:ON CHANGE rmcb002 name="input.g.page1.rmcb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmcb_d[l_ac].rmcb003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmcb003
            END IF 
 
 
 
            #add-point:AFTER FIELD rmcb003 name="input.a.page1.rmcb003"
            IF NOT cl_null(g_rmcb_d[l_ac].rmcb003) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rmcb_d_o.rmcb003 <> g_rmcb_d[l_ac].rmcb003 OR cl_null(g_rmcb_d_o.rmcb003))) THEN 
                  IF NOT armt300_rmac_chk_def(l_cmd) THEN 
                     LET g_rmcb_d[l_ac].rmcb003 = g_rmcb_d_t.rmcb003 
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF
            LET g_rmcb_d_o.rmcb003 = g_rmcb_d[l_ac].rmcb003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb003
            #add-point:BEFORE FIELD rmcb003 name="input.b.page1.rmcb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb003
            #add-point:ON CHANGE rmcb003 name="input.g.page1.rmcb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb004
            
            #add-point:AFTER FIELD rmcb004 name="input.a.page1.rmcb004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb004
            #add-point:BEFORE FIELD rmcb004 name="input.b.page1.rmcb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb004
            #add-point:ON CHANGE rmcb004 name="input.g.page1.rmcb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb005
            
            #add-point:AFTER FIELD rmcb005 name="input.a.page1.rmcb005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb005
            #add-point:BEFORE FIELD rmcb005 name="input.b.page1.rmcb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb005
            #add-point:ON CHANGE rmcb005 name="input.g.page1.rmcb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb005_desc
            #add-point:BEFORE FIELD rmcb005_desc name="input.b.page1.rmcb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb005_desc
            
            #add-point:AFTER FIELD rmcb005_desc name="input.a.page1.rmcb005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb005_desc
            #add-point:ON CHANGE rmcb005_desc name="input.g.page1.rmcb005_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb006
            
            #add-point:AFTER FIELD rmcb006 name="input.a.page1.rmcb006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb006
            #add-point:BEFORE FIELD rmcb006 name="input.b.page1.rmcb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb006
            #add-point:ON CHANGE rmcb006 name="input.g.page1.rmcb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmcb_d[l_ac].rmcb007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmcb007
            END IF 
 
 
 
            #add-point:AFTER FIELD rmcb007 name="input.a.page1.rmcb007"
            IF NOT cl_null(g_rmcb_d[l_ac].rmcb007) THEN 
               SELECT rmac001 INTO l_rmac001
                 FROM rmac_t
                WHERE rmacent = g_enterprise
                  AND rmacdocno = g_rmcb_d[l_ac].rmcb001
                  AND rmacseq = g_rmcb_d[l_ac].rmcb002
                  AND rmacseq1 = g_rmcb_d[l_ac].rmcb003
               CALL armt300_get_rmcb007() RETURNING l_rmcb007   
               IF g_rmcb_d[l_ac].rmcb007 > l_rmac001-l_rmcb007 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_rmcb_d[l_ac].rmcb007
                  LET g_errparam.code   = 'arm-00006' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  LET g_rmcb_d[l_ac].rmcb007 = g_rmcb_d_t.rmcb007 
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb007
            #add-point:BEFORE FIELD rmcb007 name="input.b.page1.rmcb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb007
            #add-point:ON CHANGE rmcb007 name="input.g.page1.rmcb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb008
            
            #add-point:AFTER FIELD rmcb008 name="input.a.page1.rmcb008"
            CALL s_desc_get_acc_desc('1132',g_rmcb_d[l_ac].rmcb008) RETURNING g_rmcb_d[l_ac].rmcb008_desc
            IF NOT cl_null(g_rmcb_d[l_ac].rmcb008) THEN 
               IF NOT s_azzi650_chk_exist('1132',g_rmcb_d[l_ac].rmcb008) THEN
                  LET g_rmcb_d[l_ac].rmcb008 = g_rmcb_d_t.rmcb008
                  NEXT FIELD CURRENT
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb008
            #add-point:BEFORE FIELD rmcb008 name="input.b.page1.rmcb008"
            CALL s_desc_get_acc_desc('1132',g_rmcb_d[l_ac].rmcb008) RETURNING g_rmcb_d[l_ac].rmcb008_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb008
            #add-point:ON CHANGE rmcb008 name="input.g.page1.rmcb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb009
            #add-point:BEFORE FIELD rmcb009 name="input.b.page1.rmcb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb009
            
            #add-point:AFTER FIELD rmcb009 name="input.a.page1.rmcb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb009
            #add-point:ON CHANGE rmcb009 name="input.g.page1.rmcb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb010
            #add-point:BEFORE FIELD rmcb010 name="input.b.page1.rmcb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb010
            
            #add-point:AFTER FIELD rmcb010 name="input.a.page1.rmcb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb010
            #add-point:ON CHANGE rmcb010 name="input.g.page1.rmcb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmcb011
            #add-point:BEFORE FIELD rmcb011 name="input.b.page1.rmcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmcb011
            
            #add-point:AFTER FIELD rmcb011 name="input.a.page1.rmcb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmcb011
            #add-point:ON CHANGE rmcb011 name="input.g.page1.rmcb011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rmcbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcbsite
            #add-point:ON ACTION controlp INFIELD rmcbsite name="input.c.page1.rmcbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcbseq
            #add-point:ON ACTION controlp INFIELD rmcbseq name="input.c.page1.rmcbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb001
            #add-point:ON ACTION controlp INFIELD rmcb001 name="input.c.page1.rmcb001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmcb_d[l_ac].rmcb001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #160816-00066#2 mod-S
#            LET g_qryparam.where = "rmaa001 = '",g_rmca_m.rmca002,"' AND rmaastus = 'S' ",   
#                                   " AND EXISTS(SELECT * FROM rmac_t WHERE rmaaent = rmacent AND rmaadocno=rmacdocno)"                                 
#            #160204-00004#4 Add By Ken 160222(S)
            IF NOT cl_null(g_rmca_m.rmca001) THEN
               LET g_qryparam.where = " rmaadocno = '",g_rmca_m.rmca001,"' AND rmaa001 = '",g_rmca_m.rmca002,"' AND rmaastus = 'S' "
            ELSE
               LET g_qryparam.where = " rmaa001 = '",g_rmca_m.rmca002,"' AND rmaastus = 'S' "
            END IF
            #160816-00066#2 mod-E                                 
            #組合過濾前後置單據資料SQL
            CALL s_aooi210_get_check_sql(g_site,'',g_rmca_m.rmcadocno,'4','','rmaadocno') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_where
               #160816-00066#2 mod-S
#               CALL q_rmaadocno()
               CALL q_rmaadocno_1()    #回传RMA点收单身相关资料至本单身
               #160816-00066#2 mod-E
            END IF
            #160204-00004#4 Add By Ken 160222(E) 
            #CALL q_rmaadocno()                                #呼叫開窗   #160204-00004#4 Mark By Ken 160222

            LET g_rmcb_d[l_ac].rmcb001 = g_qryparam.return1              
            #160816-00066#2 add-S
            LET g_rmcb_d[l_ac].rmcb002 = g_qryparam.return2 
            LET g_rmcb_d[l_ac].rmcb003 = g_qryparam.return3
            LET g_rmcb_d[l_ac].rmcb004 = g_qryparam.return4 
            LET g_rmcb_d[l_ac].rmcb005 = g_qryparam.return5 
            LET g_rmcb_d[l_ac].rmcb006 = g_qryparam.return6 
            LET g_rmcb_d[l_ac].rmcb007 = g_qryparam.return7 
            #160816-00066#2 add-E

            DISPLAY g_rmcb_d[l_ac].rmcb001 TO rmcb001              #
            #160816-00066#2 add-S
            DISPLAY g_rmcb_d[l_ac].rmcb002 TO rmcb002              #
            DISPLAY g_rmcb_d[l_ac].rmcb003 TO rmcb003              #
            DISPLAY g_rmcb_d[l_ac].rmcb004 TO rmcb004              #
            DISPLAY g_rmcb_d[l_ac].rmcb005 TO rmcb005              #
            DISPLAY g_rmcb_d[l_ac].rmcb006 TO rmcb006              #
            DISPLAY g_rmcb_d[l_ac].rmcb007 TO rmcb007              #
            #160816-00066#2 add-E

            NEXT FIELD rmcb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb002
            #add-point:ON ACTION controlp INFIELD rmcb002 name="input.c.page1.rmcb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb003
            #add-point:ON ACTION controlp INFIELD rmcb003 name="input.c.page1.rmcb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb004
            #add-point:ON ACTION controlp INFIELD rmcb004 name="input.c.page1.rmcb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb005
            #add-point:ON ACTION controlp INFIELD rmcb005 name="input.c.page1.rmcb005"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb005_desc
            #add-point:ON ACTION controlp INFIELD rmcb005_desc name="input.c.page1.rmcb005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb006
            #add-point:ON ACTION controlp INFIELD rmcb006 name="input.c.page1.rmcb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb007
            #add-point:ON ACTION controlp INFIELD rmcb007 name="input.c.page1.rmcb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb008
            #add-point:ON ACTION controlp INFIELD rmcb008 name="input.c.page1.rmcb008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmcb_d[l_ac].rmcb008             #給予default值
            LET g_qryparam.default2 = "" #g_rmcb_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "1132" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_rmcb_d[l_ac].rmcb008 = g_qryparam.return1              
            #LET g_rmcb_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_rmcb_d[l_ac].rmcb008 TO rmcb008              #
            #DISPLAY g_rmcb_d[l_ac].oocql004 TO oocql004 #說明
            NEXT FIELD rmcb008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb009
            #add-point:ON ACTION controlp INFIELD rmcb009 name="input.c.page1.rmcb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb010
            #add-point:ON ACTION controlp INFIELD rmcb010 name="input.c.page1.rmcb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmcb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmcb011
            #add-point:ON ACTION controlp INFIELD rmcb011 name="input.c.page1.rmcb011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rmcb_d[l_ac].* = g_rmcb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rmcb_d[l_ac].rmcbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rmcb_d[l_ac].* = g_rmcb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL armt300_rmcb_t_mask_restore('restore_mask_o')
      
               UPDATE rmcb_t SET (rmcbdocno,rmcbsite,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004,rmcb005, 
                   rmcb006,rmcb007,rmcb008,rmcb009,rmcb010,rmcb011) = (g_rmca_m.rmcadocno,g_rmcb_d[l_ac].rmcbsite, 
                   g_rmcb_d[l_ac].rmcbseq,g_rmcb_d[l_ac].rmcb001,g_rmcb_d[l_ac].rmcb002,g_rmcb_d[l_ac].rmcb003, 
                   g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005,g_rmcb_d[l_ac].rmcb006,g_rmcb_d[l_ac].rmcb007, 
                   g_rmcb_d[l_ac].rmcb008,g_rmcb_d[l_ac].rmcb009,g_rmcb_d[l_ac].rmcb010,g_rmcb_d[l_ac].rmcb011) 
 
                WHERE rmcbent = g_enterprise AND rmcbdocno = g_rmca_m.rmcadocno 
 
                  AND rmcbseq = g_rmcb_d_t.rmcbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmcb_d[l_ac].* = g_rmcb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmcb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rmcb_d[l_ac].* = g_rmcb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rmca_m.rmcadocno = g_detail_multi_table_t.rmabdocno AND
         g_rmcb_d[l_ac].rmcbseq = g_detail_multi_table_t.rmabseq AND
         g_rmcb_d[l_ac].rmab017 = g_detail_multi_table_t.rmab017 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rmabent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rmca_m.rmcadocno
            LET l_field_keys[02] = 'rmabdocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rmabdocno
            LET l_var_keys[03] = g_rmcb_d[l_ac].rmcbseq
            LET l_field_keys[03] = 'rmabseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rmabseq
            LET l_vars[01] = g_rmcb_d[l_ac].rmab017
            LET l_fields[01] = 'rmab017'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rmab_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmca_m.rmcadocno
               LET gs_keys_bak[1] = g_rmcadocno_t
               LET gs_keys[2] = g_rmcb_d[g_detail_idx].rmcbseq
               LET gs_keys_bak[2] = g_rmcb_d_t.rmcbseq
               CALL armt300_update_b('rmcb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL armt300_rmcb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rmcb_d[g_detail_idx].rmcbseq = g_rmcb_d_t.rmcbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rmca_m.rmcadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmcb_d_t.rmcbseq
 
                  CALL armt300_key_update_b(gs_keys,'rmcb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rmca_m),util.JSON.stringify(g_rmcb_d_t)
               LET g_log2 = util.JSON.stringify(g_rmca_m),util.JSON.stringify(g_rmcb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL armt300_unlock_b("rmcb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rmcb_d[li_reproduce_target].* = g_rmcb_d[li_reproduce].*
 
               LET g_rmcb_d[li_reproduce_target].rmcbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rmcb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rmcb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="armt300.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD rmcadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rmcbsite
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION armt300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL armt300_b_fill() #單身填充
      CALL armt300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL armt300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_get_slip_desc(g_rmca_m.rmcadocno) RETURNING g_rmca_m.rmcadocno_desc
   #end add-point
   
   #遮罩相關處理
   LET g_rmca_m_mask_o.* =  g_rmca_m.*
   CALL armt300_rmca_t_mask()
   LET g_rmca_m_mask_n.* =  g_rmca_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocno_desc,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003, 
       g_rmca_m.rmca003_desc,g_rmca_m.rmca004,g_rmca_m.rmca004_desc,g_rmca_m.rmcastus,g_rmca_m.rmca001, 
       g_rmca_m.rmca002,g_rmca_m.rmca002_desc,g_rmca_m.rmcaownid,g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp, 
       g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid,g_rmca_m.rmcamodid_desc,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid, 
       g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstid_desc,g_rmca_m.rmcapstdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmca_m.rmcastus 
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
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_rmcb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_rmcb_d[l_ac].rmcb001
      LET g_ref_fields[2] = g_rmcb_d[l_ac].rmcb002
      CALL ap_ref_array2(g_ref_fields," SELECT rmab017 FROM rmab_t WHERE rmabent = '"||g_enterprise||"' AND rmabdocno = ? AND rmabseq = ? ","") RETURNING g_rtn_fields 
      LET g_rmcb_d[l_ac].rmab017 = g_rtn_fields[1] 
      CALL s_feature_description(g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005) RETURNING l_success,g_rmcb_d[l_ac].rmcb005_desc
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL armt300_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION armt300_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION armt300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rmca_t.rmcadocno 
   DEFINE l_oldno     LIKE rmca_t.rmcadocno 
 
   DEFINE l_master    RECORD LIKE rmca_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rmcb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_rmca_m.rmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
    
   LET g_rmca_m.rmcadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmca_m.rmcaownid = g_user
      LET g_rmca_m.rmcaowndp = g_dept
      LET g_rmca_m.rmcacrtid = g_user
      LET g_rmca_m.rmcacrtdp = g_dept 
      LET g_rmca_m.rmcacrtdt = cl_get_current()
      LET g_rmca_m.rmcamodid = g_user
      LET g_rmca_m.rmcamoddt = cl_get_current()
      LET g_rmca_m.rmcastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rmca_m.rmcasite = g_site
   LET g_rmca_m.rmcadocdt = g_today
   LET g_rmca_m.rmca003 = g_user
   LET g_rmca_m.rmca004 = g_dept
   LET g_rmca_m.rmcacnfid = ''
   LET g_rmca_m.rmcacnfid_desc = ''
   LET g_rmca_m.rmcacnfdt = ''
   
   CALL s_desc_get_person_desc(g_rmca_m.rmca003) RETURNING g_rmca_m.rmca003_desc 
   CALL s_desc_get_department_desc(g_rmca_m.rmca004) RETURNING g_rmca_m.rmca004_desc
   
   CALL s_desc_get_person_desc(g_rmca_m.rmcaownid) RETURNING g_rmca_m.rmcaownid_desc 
   CALL s_desc_get_department_desc(g_rmca_m.rmcaowndp) RETURNING g_rmca_m.rmcaowndp_desc

   CALL s_desc_get_person_desc(g_rmca_m.rmcacrtid) RETURNING g_rmca_m.rmcacrtid_desc 
   CALL s_desc_get_department_desc(g_rmca_m.rmcacrtdp) RETURNING g_rmca_m.rmcacrtdp_desc
   
   CALL s_desc_get_person_desc(g_rmca_m.rmcamodid) RETURNING g_rmca_m.rmcamodid_desc   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmca_m.rmcastus 
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
      LET g_rmca_m.rmcadocno_desc = ''
   DISPLAY BY NAME g_rmca_m.rmcadocno_desc
 
   
   CALL armt300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rmca_m.* TO NULL
      INITIALIZE g_rmcb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL armt300_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt300_set_act_visible()   
   CALL armt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmcaent = " ||g_enterprise|| " AND",
                      " rmcadocno = '", g_rmca_m.rmcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
 
   #end add-point
   
   CALL armt300_idx_chk()
   
   LET g_data_owner = g_rmca_m.rmcaownid      
   LET g_data_dept  = g_rmca_m.rmcaowndp
   
   #功能已完成,通報訊息中心
   CALL armt300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION armt300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rmcb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_sql  STRING 
   #161124-00048#11 mod-S
#   DEFINE l_rmcb RECORD LIKE rmcb_t.*
   DEFINE l_rmcb RECORD  #RMA判別單單身檔
          rmcbent LIKE rmcb_t.rmcbent, #企业编号
          rmcbsite LIKE rmcb_t.rmcbsite, #营运据点
          rmcbdocno LIKE rmcb_t.rmcbdocno, #判别单号
          rmcbseq LIKE rmcb_t.rmcbseq, #项次
          rmcb001 LIKE rmcb_t.rmcb001, #RMA单号
          rmcb002 LIKE rmcb_t.rmcb002, #RMA项次
          rmcb003 LIKE rmcb_t.rmcb003, #点收项序
          rmcb004 LIKE rmcb_t.rmcb004, #料号
          rmcb005 LIKE rmcb_t.rmcb005, #产品特征
          rmcb006 LIKE rmcb_t.rmcb006, #单位
          rmcb007 LIKE rmcb_t.rmcb007, #数量
          rmcb008 LIKE rmcb_t.rmcb008, #不良原因
          rmcb009 LIKE rmcb_t.rmcb009, #判别结果
          rmcb010 LIKE rmcb_t.rmcb010, #已转数量
          rmcb011 LIKE rmcb_t.rmcb011  #维修入库
   END RECORD
   #161124-00048#11 mod-E
   DEFINE l_rmcb001_t LIKE rmcb_t.rmcb001
   DEFINE l_rmcb002_t LIKE rmcb_t.rmcb002
   DEFINE l_rmcb003_t LIKE rmcb_t.rmcb003
   DEFINE l_rmcb007 LIKE rmcb_t.rmcb007
   DEFINE l_rmac001 LIKE rmac_t.rmac001
   DEFINE l_cnt LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE armt300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmcb_t
    WHERE rmcbent = g_enterprise AND rmcbdocno = g_rmcadocno_t
 
    INTO TEMP armt300_detail
 
   #將key修正為調整後   
   UPDATE armt300_detail 
      #更新key欄位
      SET rmcbdocno = g_rmca_m.rmcadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   LET l_rmcb001_t = ''
   LET l_rmcb002_t = '' 
   LET l_rmcb003_t = ''   
   LET l_sql = "SELECT * FROM armt300_detail ORDER BY rmcb001,rmcb002,rmcb003,rmcbseq "
   PREPARE armt300_reproduce_pr FROM l_sql
   DECLARE armt300_reproduce_cr CURSOR FOR armt300_reproduce_pr
   FOREACH armt300_reproduce_cr INTO l_rmcb.* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      IF l_rmcb.rmcb001=l_rmcb001_t AND l_rmcb.rmcb002=l_rmcb002_t AND l_rmcb.rmcb003=l_rmcb003_t THEN 
         DELETE FROM armt300_detail 
          WHERE rmcb001 = l_rmcb.rmcb001
            AND rmcb002 = l_rmcb.rmcb002
            AND rmcb003 = l_rmcb.rmcb003
            AND rmcbseq = l_rmcb.rmcbseq
         CONTINUE FOREACH   
      END IF
      SELECT rmac001 INTO l_rmac001
        FROM rmac_t
       WHERE rmacent = g_enterprise
         AND rmacdocno = l_rmcb.rmcb001
         AND rmacseq = l_rmcb.rmcb002
         AND rmacseq1 = l_rmcb.rmcb003 
      IF cl_null(l_rmac001) THEN LET l_rmac001 = 0 END IF        
      CALL armt300_get_rmcb007_2(l_rmcb.rmcb001,l_rmcb.rmcb002,l_rmcb.rmcb003) RETURNING l_rmcb007
      LET l_rmcb.rmcb007 = l_rmac001-l_rmcb007
      IF l_rmcb.rmcb007 = 0 THEN 
         DELETE FROM armt300_detail 
          WHERE rmcb001 = l_rmcb.rmcb001
            AND rmcb002 = l_rmcb.rmcb002
            AND rmcb003 = l_rmcb.rmcb003
            AND rmcbseq = l_rmcb.rmcbseq
      ELSE            
         UPDATE armt300_detail
            SET rmcb007 = l_rmcb.rmcb007         
          WHERE rmcb001 = l_rmcb.rmcb001
            AND rmcb002 = l_rmcb.rmcb002
            AND rmcb003 = l_rmcb.rmcb003
            AND rmcbseq = l_rmcb.rmcbseq      
      END IF   
      LET l_rmcb001_t = l_rmcb.rmcb001 
      LET l_rmcb002_t = l_rmcb.rmcb002 
      LET l_rmcb003_t = l_rmcb.rmcb003
   END FOREACH 
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rmcb_t SELECT * FROM armt300_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rmcb_t
    WHERE rmcbent = g_enterprise
      AND rmcbdocno = g_rmca_m.rmcadocno       
   IF l_cnt = 0 THEN 
      CALL cl_ask_pressanykey("arm-00021")   
   END IF
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmcadocno_t = g_rmca_m.rmcadocno
   RETURN
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE armt300_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM rmab_t 
    WHERE rmabent = g_enterprise AND rmabdocno = g_rmcadocno_t
 
     INTO TEMP armt300_detail_lang
 
   #將key修正為調整後   
   UPDATE armt300_detail_lang 
      #更新key欄位
      SET rmabdocno = g_rmca_m.rmcadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO rmab_t SELECT * FROM armt300_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt300_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION armt300_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rmca_m.rmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN armt300_cl USING g_enterprise,g_rmca_m.rmcadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
       g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
       g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
       g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
       g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
       g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT armt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmca_m_mask_o.* =  g_rmca_m.*
   CALL armt300_rmca_t_mask()
   LET g_rmca_m_mask_n.* =  g_rmca_m.*
   
   CALL armt300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL armt300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rmcadocno_t = g_rmca_m.rmcadocno
 
 
      DELETE FROM rmca_t
       WHERE rmcaent = g_enterprise AND rmcadocno = g_rmca_m.rmcadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rmca_m.rmcadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rmcb_t
       WHERE rmcbent = g_enterprise AND rmcbdocno = g_rmca_m.rmcadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rmca_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE armt300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rmcb_d.clear() 
 
     
      CALL armt300_ui_browser_refresh()  
      #CALL armt300_ui_headershow()  
      #CALL armt300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'rmabent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'rmabdocno'
         LET l_var_keys_bak[02] = g_rmca_m.rmcadocno
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rmab_t')
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL armt300_browser_fill("")
         CALL armt300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE armt300_cl
 
   #功能已完成,通報訊息中心
   CALL armt300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="armt300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armt300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rmcb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF armt300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rmcbsite,rmcbseq,rmcb001,rmcb002,rmcb003,rmcb004,rmcb005,rmcb006, 
             rmcb007,rmcb008,rmcb009,rmcb010,rmcb011 ,t1.imaal003 ,t2.oocal003 ,t3.oocql004 FROM rmcb_t", 
                
                     " INNER JOIN rmca_t ON rmcaent = " ||g_enterprise|| " AND rmcadocno = rmcbdocno ",
 
                     #" LEFT JOIN rmab_t ON rmabent = "||g_enterprise||" AND rmcadocno = rmabdocno AND rmcbseq = rmabseq",
                     
                     " LEFT JOIN rmab_t ON rmabent = "||g_enterprise||" AND rmcadocno = rmabdocno AND rmcbseq = rmabseq",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=rmcb004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=rmcb006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1132' AND t3.oocql002=rmcb008 AND t3.oocql003='"||g_dlang||"' ",
 
                     " WHERE rmcbent=? AND rmcbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rmcb_t.rmcbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR armt300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rmca_m.rmcadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rmca_m.rmcadocno INTO g_rmcb_d[l_ac].rmcbsite,g_rmcb_d[l_ac].rmcbseq, 
          g_rmcb_d[l_ac].rmcb001,g_rmcb_d[l_ac].rmcb002,g_rmcb_d[l_ac].rmcb003,g_rmcb_d[l_ac].rmcb004, 
          g_rmcb_d[l_ac].rmcb005,g_rmcb_d[l_ac].rmcb006,g_rmcb_d[l_ac].rmcb007,g_rmcb_d[l_ac].rmcb008, 
          g_rmcb_d[l_ac].rmcb009,g_rmcb_d[l_ac].rmcb010,g_rmcb_d[l_ac].rmcb011,g_rmcb_d[l_ac].rmcb004_desc, 
          g_rmcb_d[l_ac].rmcb006_desc,g_rmcb_d[l_ac].rmcb008_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_rmcb_d.deleteElement(g_rmcb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE armt300_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rmcb_d.getLength()
      LET g_rmcb_d_mask_o[l_ac].* =  g_rmcb_d[l_ac].*
      CALL armt300_rmcb_t_mask()
      LET g_rmcb_d_mask_n[l_ac].* =  g_rmcb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION armt300_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM rmcb_t
       WHERE rmcbent = g_enterprise AND
         rmcbdocno = ps_keys_bak[1] AND rmcbseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rmcb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION armt300_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO rmcb_t
                  (rmcbent,
                   rmcbdocno,
                   rmcbseq
                   ,rmcbsite,rmcb001,rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,rmcb007,rmcb008,rmcb009,rmcb010,rmcb011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rmcb_d[g_detail_idx].rmcbsite,g_rmcb_d[g_detail_idx].rmcb001,g_rmcb_d[g_detail_idx].rmcb002, 
                       g_rmcb_d[g_detail_idx].rmcb003,g_rmcb_d[g_detail_idx].rmcb004,g_rmcb_d[g_detail_idx].rmcb005, 
                       g_rmcb_d[g_detail_idx].rmcb006,g_rmcb_d[g_detail_idx].rmcb007,g_rmcb_d[g_detail_idx].rmcb008, 
                       g_rmcb_d[g_detail_idx].rmcb009,g_rmcb_d[g_detail_idx].rmcb010,g_rmcb_d[g_detail_idx].rmcb011) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rmcb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION armt300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmcb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL armt300_rmcb_t_mask_restore('restore_mask_o')
               
      UPDATE rmcb_t 
         SET (rmcbdocno,
              rmcbseq
              ,rmcbsite,rmcb001,rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,rmcb007,rmcb008,rmcb009,rmcb010,rmcb011) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rmcb_d[g_detail_idx].rmcbsite,g_rmcb_d[g_detail_idx].rmcb001,g_rmcb_d[g_detail_idx].rmcb002, 
                  g_rmcb_d[g_detail_idx].rmcb003,g_rmcb_d[g_detail_idx].rmcb004,g_rmcb_d[g_detail_idx].rmcb005, 
                  g_rmcb_d[g_detail_idx].rmcb006,g_rmcb_d[g_detail_idx].rmcb007,g_rmcb_d[g_detail_idx].rmcb008, 
                  g_rmcb_d[g_detail_idx].rmcb009,g_rmcb_d[g_detail_idx].rmcb010,g_rmcb_d[g_detail_idx].rmcb011)  
 
         WHERE rmcbent = g_enterprise AND rmcbdocno = ps_keys_bak[1] AND rmcbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmcb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmcb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt300_rmcb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'rmabent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'rmabdocno'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'rmabseq'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'rmab_t')
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION armt300_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION armt300_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION armt300_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL armt300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rmcb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN armt300_bcl USING g_enterprise,
                                       g_rmca_m.rmcadocno,g_rmcb_d[g_detail_idx].rmcbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt300_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION armt300_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE armt300_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION armt300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rmcadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rmcadocno",TRUE)
      CALL cl_set_comp_entry("rmcadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rmca001,rmca002",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION armt300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rmcadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rmcadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rmcadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_rmca_m.rmca001) THEN
      CALL cl_set_comp_entry("rmca002",FALSE)
   END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rmcb_t
    WHERE rmcbent = g_enterprise
      AND rmcbdocno = g_rmca_m.rmcadocno
   IF l_cnt > 0 THEN 
      CALL cl_set_comp_entry("rmca001",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION armt300_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("rmcb001",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION armt300_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF NOT cl_null(g_rmca_m.rmca001) THEN 
      CALL cl_set_comp_entry("rmcb001",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION armt300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION armt300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_cnt      LIKE type_t.num5     #160816-00066#2 add
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rmca_m.rmcastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160816-00066#2 add-S
   CALL cl_set_act_visible("to_armp100,to_armp200,to_armp300", FALSE)
   IF g_rmca_m.rmcastus = 'Y' THEN
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM rmca_t,rmcb_t
       WHERE rmcadocno = rmcbdocno AND rmcaent = rmcbent AND rmcasite = rmcbsite
         AND rmcadocno = g_rmca_m.rmcadocno AND rmcaent = g_enterprise AND rmcasite = g_site
         AND rmcastus = 'Y' AND rmcb007-rmcb010 > 0 AND rmcb009 = '1'
      IF l_cnt > 0 THEN
         CALL cl_set_act_visible("to_armp100", TRUE)
      END IF
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM rmca_t,rmcb_t
       WHERE rmcadocno = rmcbdocno AND rmcaent = rmcbent AND rmcasite = rmcbsite
         AND rmcadocno = g_rmca_m.rmcadocno AND rmcaent = g_enterprise AND rmcasite = g_site
         AND rmcastus = 'Y' AND rmcb007-rmcb010 > 0 AND rmcb009 = '2'
      IF l_cnt > 0 THEN
         CALL cl_set_act_visible("to_armp200", TRUE)
      END IF
      SELECT COUNT(1) INTO l_cnt
        FROM rmca_t,rmcb_t
       WHERE rmcadocno = rmcbdocno AND rmcaent = rmcbent AND rmcasite = rmcbsite
         AND rmcadocno = g_rmca_m.rmcadocno AND rmcaent = g_enterprise AND rmcasite = g_site
         AND rmcastus = 'Y' AND rmcb007-rmcb010 > 0 AND rmcb009 = '3'
      IF l_cnt > 0 THEN
         CALL cl_set_act_visible("to_armp300", TRUE)
      END IF
   END IF
   #160816-00066#2 add-E
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION armt300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION armt300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION armt300_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " rmcadocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "rmca_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rmcb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="armt300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION armt300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_rmca_m.rmcastus = 'X' THEN 
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rmca_m.rmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN armt300_cl USING g_enterprise,g_rmca_m.rmcadocno
   IF STATUS THEN
      CLOSE armt300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
       g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
       g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
       g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
       g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
       g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT armt300_action_chk() THEN
      CLOSE armt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocno_desc,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite,g_rmca_m.rmca003, 
       g_rmca_m.rmca003_desc,g_rmca_m.rmca004,g_rmca_m.rmca004_desc,g_rmca_m.rmcastus,g_rmca_m.rmca001, 
       g_rmca_m.rmca002,g_rmca_m.rmca002_desc,g_rmca_m.rmcaownid,g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp, 
       g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdp_desc, 
       g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid,g_rmca_m.rmcamodid_desc,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid, 
       g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstid_desc,g_rmca_m.rmcapstdt 
 
 
   CASE g_rmca_m.rmcastus
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
         CASE g_rmca_m.rmcastus
            
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
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      
      CASE g_rmca_m.rmcastus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE

      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT armt300_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE armt300_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT armt300_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE armt300_cl
            RETURN
         END IF
 
 
 
	  
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
      g_rmca_m.rmcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE armt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---   
   LET l_success = TRUE   
   IF lc_state = 'Y' THEN 
      CALL s_armt300_conf_chk(g_rmca_m.rmcadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
         RETURN
      ELSE   
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         ELSE   
            CALL s_armt300_conf_upd(g_rmca_m.rmcadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF      
         END IF 
      END IF         
   END IF
   IF lc_state = 'N' THEN
      CALL s_armt300_unconf_chk(g_rmca_m.rmcadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
         RETURN
      ELSE   
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         ELSE   
            CALL s_armt300_unconf_upd(g_rmca_m.rmcadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF      
         END IF 
      END IF 
   END IF  
   #end add-point
   
   LET g_rmca_m.rmcamodid = g_user
   LET g_rmca_m.rmcamoddt = cl_get_current()
   LET g_rmca_m.rmcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rmca_t 
      SET (rmcastus,rmcamodid,rmcamoddt) 
        = (g_rmca_m.rmcastus,g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt)     
    WHERE rmcaent = g_enterprise AND rmcadocno = g_rmca_m.rmcadocno
 
    
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
      EXECUTE armt300_master_referesh USING g_rmca_m.rmcadocno INTO g_rmca_m.rmcadocno,g_rmca_m.rmcadocdt, 
          g_rmca_m.rmcasite,g_rmca_m.rmca003,g_rmca_m.rmca004,g_rmca_m.rmcastus,g_rmca_m.rmca001,g_rmca_m.rmca002, 
          g_rmca_m.rmcaownid,g_rmca_m.rmcaowndp,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtdp,g_rmca_m.rmcacrtdt, 
          g_rmca_m.rmcamodid,g_rmca_m.rmcamoddt,g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid, 
          g_rmca_m.rmcapstdt,g_rmca_m.rmcadocno_desc,g_rmca_m.rmca003_desc,g_rmca_m.rmca004_desc,g_rmca_m.rmca002_desc, 
          g_rmca_m.rmcaownid_desc,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp_desc, 
          g_rmca_m.rmcamodid_desc,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rmca_m.rmcadocno,g_rmca_m.rmcadocno_desc,g_rmca_m.rmcadocdt,g_rmca_m.rmcasite, 
          g_rmca_m.rmca003,g_rmca_m.rmca003_desc,g_rmca_m.rmca004,g_rmca_m.rmca004_desc,g_rmca_m.rmcastus, 
          g_rmca_m.rmca001,g_rmca_m.rmca002,g_rmca_m.rmca002_desc,g_rmca_m.rmcaownid,g_rmca_m.rmcaownid_desc, 
          g_rmca_m.rmcaowndp,g_rmca_m.rmcaowndp_desc,g_rmca_m.rmcacrtid,g_rmca_m.rmcacrtid_desc,g_rmca_m.rmcacrtdp, 
          g_rmca_m.rmcacrtdp_desc,g_rmca_m.rmcacrtdt,g_rmca_m.rmcamodid,g_rmca_m.rmcamodid_desc,g_rmca_m.rmcamoddt, 
          g_rmca_m.rmcacnfid,g_rmca_m.rmcacnfid_desc,g_rmca_m.rmcacnfdt,g_rmca_m.rmcapstid,g_rmca_m.rmcapstid_desc, 
          g_rmca_m.rmcapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE armt300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION armt300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rmcb_d.getLength() THEN
         LET g_detail_idx = g_rmcb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rmcb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rmcb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armt300_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL armt300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION armt300_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="armt300.status_show" >}
PRIVATE FUNCTION armt300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="armt300.mask_functions" >}
&include "erp/arm/armt300_mask.4gl"
 
{</section>}
 
{<section id="armt300.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION armt300_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL armt300_show()
   CALL armt300_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rmca_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rmcb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL armt300_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL armt300_ui_headershow()
   CALL armt300_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION armt300_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL armt300_ui_headershow()  
   CALL armt300_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="armt300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION armt300_set_pk_array()
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
   LET g_pk_array[1].values = g_rmca_m.rmcadocno
   LET g_pk_array[1].column = 'rmcadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="armt300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION armt300_msgcentre_notify(lc_state)
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
   CALL armt300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rmca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION armt300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#33-s
   SELECT rmcastus INTO g_rmca_m.rmcastus FROM rmca_t
    WHERE rmcaent = g_enterprise
      AND rmcasite = g_site
      AND rmcadocno = g_rmca_m.rmcadocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rmca_m.rmcastus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_rmca_m.rmcadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL armt300_set_act_visible()
        CALL armt300_set_act_no_visible()
        CALL armt300_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#33-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt300.other_function" readonly="Y" >}

PRIVATE FUNCTION armt300_rmca003_def()
   SELECT ooag003 INTO g_rmca_m.rmca004
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_rmca_m.rmca003
   CALL s_desc_get_department_desc(g_rmca_m.rmca004) RETURNING g_rmca_m.rmca004_desc
   DISPLAY BY NAME g_rmca_m.rmca004_desc    
END FUNCTION

PRIVATE FUNCTION armt300_rmac_chk_def(p_cmd)
DEFINE p_cmd LIKE type_t.chr1
DEFINE l_cnt  LIKE type_t.num5
DEFINE r_success LIKE type_t.num5
DEFINE l_success LIKE type_t.num5
DEFINE l_rmcb007 LIKE rmcb_t.rmcb007
   
   LET r_success = TRUE
   
   #160816-00066#2 add-S   若RMA单对应点收单身仅一笔，也带出
   IF NOT cl_null(g_rmcb_d[l_ac].rmcb001) THEN
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM rmac_t
       WHERE rmacdocno = g_rmcb_d[l_ac].rmcb001
         AND rmacent = g_enterprise 
         AND rmacsite = g_site
      IF l_cnt = 1 THEN
         SELECT rmabseq,rmacseq1,rmab009,rmab010,rmab011,rmab017,rmac001
           INTO g_rmcb_d[l_ac].rmcb002,g_rmcb_d[l_ac].rmcb003,g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005,g_rmcb_d[l_ac].rmcb006,g_rmcb_d[l_ac].rmab017,g_rmcb_d[l_ac].rmcb007
           FROM rmab_t,rmac_t
          WHERE rmabent = rmacent AND rmabdocno = rmacdocno AND rmabseq = rmacseq AND rmacsite = rmabsite
            AND rmabent = g_enterprise
            AND rmabdocno = g_rmcb_d[l_ac].rmcb001
            AND rmabsite = g_site            
         CALL s_desc_get_item_desc(g_rmcb_d[l_ac].rmcb004) RETURNING g_rmcb_d[l_ac].rmcb004_desc,g_rmcb_d[l_ac].rmcb004_desc_1
         CALL s_feature_description(g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005) RETURNING l_success,g_rmcb_d[l_ac].rmcb005_desc
         CALL s_desc_get_unit_desc(g_rmcb_d[l_ac].rmcb006) RETURNING g_rmcb_d[l_ac].rmcb006_desc 
         CALL armt300_get_rmcb007() RETURNING l_rmcb007
         LET g_rmcb_d[l_ac].rmcb007 = g_rmcb_d[l_ac].rmcb007 - l_rmcb007         
         RETURN r_success
      END IF
   END IF
   #160816-00066#2 add-E
   IF g_rmcb_d[l_ac].rmcb001 IS NOT NULL AND g_rmcb_d[l_ac].rmcb002 IS NOT NULL AND g_rmcb_d[l_ac].rmcb003 IS NOT NULL THEN 
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt
        FROM rmac_t
       WHERE rmacent = g_enterprise
         AND rmacdocno = g_rmcb_d[l_ac].rmcb001
         AND rmacseq = g_rmcb_d[l_ac].rmcb002
         AND rmacseq1 = g_rmcb_d[l_ac].rmcb003  
      IF l_cnt = 0 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rmcb_d[l_ac].rmcb001,"+",g_rmcb_d[l_ac].rmcb002,"+",g_rmcb_d[l_ac].rmcb003 
         LET g_errparam.code   = 'arm-00005' 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #p_cmd = 'a' OR (p_cmd = 'u' AND (
      IF g_rmcb_d[l_ac].rmcb001 != g_rmcb_d_o.rmcb001 OR g_rmcb_d[l_ac].rmcb002 != g_rmcb_d_o.rmcb002 OR g_rmcb_d[l_ac].rmcb003 != g_rmcb_d_o.rmcb003 OR cl_null(g_rmcb_d_o.rmcb001) OR cl_null(g_rmcb_d_o.rmcb002) OR cl_null(g_rmcb_d_o.rmcb003)THEN 
         SELECT rmab009,rmab010,rmab011,rmab017,rmac001
           INTO g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005,g_rmcb_d[l_ac].rmcb006,g_rmcb_d[l_ac].rmab017,g_rmcb_d[l_ac].rmcb007
           FROM rmab_t,rmac_t
          WHERE rmabent = rmacent AND rmabdocno = rmacdocno AND rmabseq = rmacseq
            AND rmabent = g_enterprise
            AND rmabdocno = g_rmcb_d[l_ac].rmcb001
            AND rmabseq = g_rmcb_d[l_ac].rmcb002
            AND rmacseq1 = g_rmcb_d[l_ac].rmcb003     
         CALL s_desc_get_item_desc(g_rmcb_d[l_ac].rmcb004) RETURNING g_rmcb_d[l_ac].rmcb004_desc,g_rmcb_d[l_ac].rmcb004_desc_1
         CALL s_feature_description(g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005) RETURNING l_success,g_rmcb_d[l_ac].rmcb005_desc
         CALL s_desc_get_unit_desc(g_rmcb_d[l_ac].rmcb006) RETURNING g_rmcb_d[l_ac].rmcb006_desc 
         CALL armt300_get_rmcb007() RETURNING l_rmcb007
         LET g_rmcb_d[l_ac].rmcb007 = g_rmcb_d[l_ac].rmcb007 - l_rmcb007         
      END IF
   END IF
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION armt300_get_rmcb007()
DEFINE r_rmcb007 LIKE rmcb_t.rmcb007

   SELECT SUM(rmcb007) INTO r_rmcb007
     FROM rmcb_t,rmca_t
    WHERE rmcaent = rmcbent
      AND rmcadocno = rmcbdocno
      AND rmcbent = g_enterprise
      AND rmcb001 = g_rmcb_d[l_ac].rmcb001
      AND rmcb002 = g_rmcb_d[l_ac].rmcb002
      AND rmcb003 = g_rmcb_d[l_ac].rmcb003
      AND rmcastus <> 'X'
      AND NOT EXISTS(SELECT 1 FROM rmcb_t 
                      WHERE rmcbent = g_enterprise 
                        AND rmcbdocno = g_rmca_m.rmcadocno
                        AND rmcbseq = g_rmcb_d[l_ac].rmcbseq)
   IF cl_null(r_rmcb007) THEN 
      LET r_rmcb007 = 0 
   END IF
   RETURN r_rmcb007      
END FUNCTION

PRIVATE FUNCTION armt300_get_rmcb007_2(p_rmcb001,p_rmcb002,p_rmcb003)
DEFINE p_rmcb001 LIKE rmcb_t.rmcb001,
       p_rmcb002 LIKE rmcb_t.rmcb002,
       p_rmcb003 LIKE rmcb_t.rmcb003
DEFINE r_rmcb007 LIKE rmcb_t.rmcb007

   SELECT SUM(rmcb007) INTO r_rmcb007
     FROM rmcb_t,rmca_t
    WHERE rmcaent = rmcbent
      AND rmcadocno = rmcbdocno
      AND rmcbent = g_enterprise
      AND rmcb001 = p_rmcb001
      AND rmcb002 = p_rmcb002
      AND rmcb003 = p_rmcb003
      AND rmcastus <> 'X'
   IF cl_null(r_rmcb007) THEN 
      LET r_rmcb007 = 0 
   END IF
   RETURN r_rmcb007  
END FUNCTION

################################################################################
# Descriptions...: 自动产生点收单身
# Date & Author..: 161122 By zhujing
# Modify.........: #160816-00066#2
################################################################################
PRIVATE FUNCTION armt300_auto_insert()
DEFINE r_success     LIKE type_t.num5
DEFINE l_rmacdocno   LIKE rmac_t.rmacdocno
DEFINE l_rmacseq     LIKE rmac_t.rmacseq
DEFINE l_rmacseq1    LIKE rmac_t.rmacseq1
DEFINE l_rmcb007     LIKE rmcb_t.rmcb007
DEFINE l_sql         STRING
DEFINE l_msg         STRING
DEFINE l_success     LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_no          LIKE type_t.num10 
DEFINE l_rmac001     LIKE rmac_t.rmac001  

   LET l_sql = " SELECT rmacseq,rmacseq1 ",
               " FROM rmac_t ",
               " WHERE rmacent = ",g_enterprise,
               "   AND rmacsite = '",g_site,"'",
               "   AND rmacdocno = ?",
               " ORDER BY rmacseq,rmacseq1 "
   PREPARE default_insert_rmcb_pre FROM l_sql
   DECLARE default_insert_rmcb_cur CURSOR FOR default_insert_rmcb_pre
   LET l_rmacdocno = g_rmca_m.rmca001
   LET l_ac = 1
   LET l_no = 0 
   CALL cl_err_collect_init()
   CALL cl_showmsg_init()
   
   LET r_success = TRUE
   LET l_success = TRUE
   
   FOREACH default_insert_rmcb_cur USING l_rmacdocno INTO l_rmacseq,l_rmacseq1
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('FOREACH','','',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #替換錯誤訊息
      CALL cl_getmsg_parm('arm-00058',g_dlang,l_rmacdocno ||'|'||l_rmacseq||'|'|| l_rmacseq1) RETURNING l_msg   #單號：%1 項次：%2
      LET g_rmcb_d[l_ac].rmcbseq = l_ac
      LET g_rmcb_d[l_ac].rmcb001 = l_rmacdocno
      LET g_rmcb_d[l_ac].rmcb002 = l_rmacseq
      LET g_rmcb_d[l_ac].rmcb003 = l_rmacseq1
      
      SELECT rmab009,rmab010,rmab011,rmab017,rmac001
        INTO g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005,g_rmcb_d[l_ac].rmcb006,g_rmcb_d[l_ac].rmab017,g_rmcb_d[l_ac].rmcb007
        FROM rmab_t,rmac_t
       WHERE rmabent = rmacent AND rmabdocno = rmacdocno AND rmabseq = rmacseq
         AND rmabent = g_enterprise
         AND rmabdocno = l_rmacdocno
         AND rmabseq = l_rmacseq
         AND rmacseq1 = l_rmacseq1
      CALL s_desc_get_item_desc(g_rmcb_d[l_ac].rmcb004) RETURNING g_rmcb_d[l_ac].rmcb004_desc,g_rmcb_d[l_ac].rmcb004_desc_1
      CALL s_feature_description(g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005) RETURNING l_success,g_rmcb_d[l_ac].rmcb005_desc
      CALL s_desc_get_unit_desc(g_rmcb_d[l_ac].rmcb006) RETURNING g_rmcb_d[l_ac].rmcb006_desc 
      CALL armt300_get_rmcb007() RETURNING l_rmcb007
      LET g_rmcb_d[l_ac].rmcb007 = g_rmcb_d[l_ac].rmcb007 - l_rmcb007   
      IF g_rmcb_d[l_ac].rmcb007 = 0 THEN
         CONTINUE FOREACH
      END IF
      LET g_rmcb_d[l_ac].rmcb009 = "1"
      LET g_rmcb_d[l_ac].rmcb010 = "0"
      LET g_rmcb_d[l_ac].rmcb011 = "0" 
      LET g_rmcb_d[l_ac].rmcbsite = g_site
      INSERT INTO rmcb_t
         (rmcbent,
          rmcbdocno,
          rmcbseq,
          rmcb001,rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,rmcb007,rmcb009,rmcb010,rmcb011,rmcbsite)
      VALUES(g_enterprise,
             g_rmca_m.rmcadocno,g_rmcb_d[l_ac].rmcbseq,
             g_rmcb_d[l_ac].rmcb001,g_rmcb_d[l_ac].rmcb002,g_rmcb_d[l_ac].rmcb003, 
             g_rmcb_d[l_ac].rmcb004,g_rmcb_d[l_ac].rmcb005,g_rmcb_d[l_ac].rmcb006, 
             g_rmcb_d[l_ac].rmcb007,g_rmcb_d[l_ac].rmcb009, 
             g_rmcb_d[l_ac].rmcb010,g_rmcb_d[l_ac].rmcb011,g_rmcb_d[l_ac].rmcbsite) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmcb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         LET r_success = FALSE 
         RETURN r_success
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   IF l_ac = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code   = 'arm-00059' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET r_success = FALSE
   END IF
   CALL g_rmcb_d.deleteElement(l_ac)
      
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 转工单
# Memo...........: #160816-00066#2
# Date & Author..: 2016-11-23 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt300_produce_sfaa(p_docno)
DEFINE p_docno    LIKE rmca_t.rmcadocno
DEFINE l_rmcb RECORD  #RMA判別單單身檔
       rmcbent LIKE rmcb_t.rmcbent, #企业编号
       rmcbsite LIKE rmcb_t.rmcbsite, #营运据点
       rmcbdocno LIKE rmcb_t.rmcbdocno, #判别单号
       rmcbseq LIKE rmcb_t.rmcbseq, #项次
       rmcb001 LIKE rmcb_t.rmcb001, #RMA单号
       rmcb002 LIKE rmcb_t.rmcb002, #RMA项次
       rmcb003 LIKE rmcb_t.rmcb003, #点收项序
       rmcb004 LIKE rmcb_t.rmcb004, #料号
       rmcb005 LIKE rmcb_t.rmcb005, #产品特征
       rmcb006 LIKE rmcb_t.rmcb006, #单位
       rmcb007 LIKE rmcb_t.rmcb007, #数量
       rmcb008 LIKE rmcb_t.rmcb008, #不良原因
       rmcb009 LIKE rmcb_t.rmcb009, #判别结果
       rmcb010 LIKE rmcb_t.rmcb010, #已转数量
       rmcb011 LIKE rmcb_t.rmcb011  #维修入库
END RECORD
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企业编号
       sfaaownid LIKE sfaa_t.sfaaownid, #资料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #资料所有部门
       sfaacrtid LIKE sfaa_t.sfaacrtid, #资料录入者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #资料录入部门
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #资料创建日
       sfaamodid LIKE sfaa_t.sfaamodid, #资料更改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近更改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #资料审核者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #数据审核日
       sfaapstid LIKE sfaa_t.sfaapstid, #资料过账者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #资料过账日
       sfaastus LIKE sfaa_t.sfaastus, #状态码
       sfaasite LIKE sfaa_t.sfaasite, #营运据点
       sfaadocno LIKE sfaa_t.sfaadocno, #单号
       sfaadocdt LIKE sfaa_t.sfaadocdt, #单据日期
       sfaa001 LIKE sfaa_t.sfaa001, #变更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人员
       sfaa003 LIKE sfaa_t.sfaa003, #工单类型
       sfaa004 LIKE sfaa_t.sfaa004, #发料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工单来源
       sfaa006 LIKE sfaa_t.sfaa006, #来源单号
       sfaa007 LIKE sfaa_t.sfaa007, #来源项次
       sfaa008 LIKE sfaa_t.sfaa008, #来源项序
       sfaa009 LIKE sfaa_t.sfaa009, #参考客户
       sfaa010 LIKE sfaa_t.sfaa010, #生产料号
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生产数量
       sfaa013 LIKE sfaa_t.sfaa013, #生产单位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #工艺编号
       sfaa017 LIKE sfaa_t.sfaa017, #部门供应商
       sfaa018 LIKE sfaa_t.sfaa018, #协作据点
       sfaa019 LIKE sfaa_t.sfaa019, #预计开工日
       sfaa020 LIKE sfaa_t.sfaa020, #预计完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工单单号
       sfaa022 LIKE sfaa_t.sfaa022, #参考原始单号
       sfaa023 LIKE sfaa_t.sfaa023, #参考原始项次
       sfaa024 LIKE sfaa_t.sfaa024, #参考原始项序
       sfaa025 LIKE sfaa_t.sfaa025, #前工单单号
       sfaa026 LIKE sfaa_t.sfaa026, #料表批号(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #项目编号
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活动
       sfaa031 LIKE sfaa_t.sfaa031, #理由码
       sfaa032 LIKE sfaa_t.sfaa032, #紧急比率
       sfaa033 LIKE sfaa_t.sfaa033, #优先级
       sfaa034 LIKE sfaa_t.sfaa034, #预计入库库位
       sfaa035 LIKE sfaa_t.sfaa035, #预计入库储位
       sfaa036 LIKE sfaa_t.sfaa036, #手册编号
       sfaa037 LIKE sfaa_t.sfaa037, #保税核准文号
       sfaa038 LIKE sfaa_t.sfaa038, #保税核销
       sfaa039 LIKE sfaa_t.sfaa039, #备料已生成
       sfaa040 LIKE sfaa_t.sfaa040, #生产工艺路线已审核
       sfaa041 LIKE sfaa_t.sfaa041, #冻结
       sfaa042 LIKE sfaa_t.sfaa042, #返工
       sfaa043 LIKE sfaa_t.sfaa043, #备置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #实际开始发料日
       sfaa046 LIKE sfaa_t.sfaa046, #最后入库日
       sfaa047 LIKE sfaa_t.sfaa047, #生管结案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本结案日
       sfaa049 LIKE sfaa_t.sfaa049, #已发料套数
       sfaa050 LIKE sfaa_t.sfaa050, #已入库合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入库不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工单转入数量
       sfaa054 LIKE sfaa_t.sfaa054, #工单转出数量
       sfaa055 LIKE sfaa_t.sfaa055, #下线数量
       sfaa056 LIKE sfaa_t.sfaa056, #报废数量
       sfaa057 LIKE sfaa_t.sfaa057, #委外类型
       sfaa058 LIKE sfaa_t.sfaa058, #参考数量
       sfaa059 LIKE sfaa_t.sfaa059, #预计入库批号
       sfaa060 LIKE sfaa_t.sfaa060, #参考单位
       sfaa061 LIKE sfaa_t.sfaa061, #工艺
       sfaa062 LIKE sfaa_t.sfaa062, #纳入APS计算
       sfaa063 LIKE sfaa_t.sfaa063, #来源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #参考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管结案状态
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程编号
       sfaa067 LIKE sfaa_t.sfaa067, #多角流进程号
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供给量
       sfaa070 LIKE sfaa_t.sfaa070, #原始预计完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齐料套数
       sfaa072 LIKE sfaa_t.sfaa072  #保税否
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
     sfba020 LIKE sfba_t.sfba020,
     sfba026 LIKE sfba_t.sfba026,
     sfba028 LIKE sfba_t.sfba028
     END RECORD  
DEFINE l_sfab RECORD      
     sfabseq LIKE sfab_t.sfabseq,
     sfab001 LIKE sfab_t.sfab001,
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
DEFINE  l_docno      LIKE sfaa_t.sfaadocno
DEFINE  l_cnt        LIKE type_t.num10
DEFINE  l_success    LIKE type_t.num5
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_qty        LIKE type_t.num10
DEFINE  l_type       LIKE type_t.chr2
DEFINE  l_sql        STRING 

      LET r_success = TRUE
      LET l_success = TRUE
      IF cl_null(p_docno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'sub-00228'
	      LET g_errparam.extend = p_docno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF
	
#	   #檢查是否有已對應的工单
	   LET l_cnt = 0
#	   SELECT COUNT(*) INTO l_cnt
#	     FROM sfaa_t
#	    WHERE sfaaent = g_enterprise
#	      AND sfaa005 = '5'
#	      AND sfaa006 = p_docno
#	      AND sfaastus <> 'X'
#	   IF l_cnt > 0 THEN
#	      INITIALIZE g_errparam TO NULL
#	      LET g_errparam.code = 'arm-00062'     #该判别单已有存在的工单！
#	      LET g_errparam.extend = p_docno
#	      LET g_errparam.popup = TRUE
#	      CALL cl_err()
#	      LET r_success = FALSE
#	      RETURN r_success      
#	   END IF
	   
	   #依據aooi210所設置的訂單對應的銷退單別
	   CALL s_aooi210_get_doc(g_site,'',6,p_docno,'asft300','arm-00065')      #[转工单]请挑选工单单别！
	        RETURNING l_success,l_docno
	   IF NOT l_success THEN
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF  
	   
	   IF cl_null(l_docno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'agl-00122'
	      LET g_errparam.extend = p_docno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success
	   END IF 
	   	   
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
                  "             VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?)"
      PREPARE sfba_ins FROM l_sql     
         
      LET l_sql = " INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfabseq,sfab001,",
                  "                    sfab002,sfab003,sfab004,sfab005,sfab006,",
                  "                    sfab007)",
                  "            VALUES (?,?,?,?,?, ?,?,?,?,?, ?)"
      PREPARE sfab_ins FROM l_sql   
       
      LET l_sql = " INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,",
                  "                    sfac002,sfac003,sfac004,sfac005,sfac006)",
                  "             VALUES (?,?,?,?,?, ?,?,?,?,?)"
      PREPARE sfac_ins FROM l_sql 
      LET l_cnt = 0
      #161124-00048#11 mod-S
#      LET l_sql = " SELECT * FROM rmcb_t ",
      LET l_sql = " SELECT rmcbent,rmcbsite,rmcbdocno,rmcbseq,rmcb001,",
                  "        rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,",
                  "        rmcb007,rmcb008,rmcb009,rmcb010,rmcb011 ",
                  "   FROM rmcb_t ",
      #161124-00048#11 mod-E
	            "  WHERE rmcbent = ",g_enterprise,
	            "    AND rmcbsite = '",g_site,"' ",
	            "    AND rmcbdocno = '",p_docno,"' ",
	            "    AND rmcb009 = '1' ",
	            "  ORDER BY rmcbdocno,rmcbseq "
   	PREPARE rmcb1_pre FROM l_sql
   	DECLARE rmcb1_sel_curs CURSOR FOR rmcb1_pre
      FOREACH rmcb1_sel_curs INTO l_rmcb.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET l_cnt = l_cnt + 1
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
      
         #取單號
   	   CALL s_aooi200_gen_docno(g_site,l_docno,g_today,'asft300') RETURNING l_success,l_sfaa.sfaadocno
   	   IF NOT l_success THEN
   	      INITIALIZE g_errparam TO NULL
   	      LET g_errparam.code = 'apm-00003'
   	      LET g_errparam.extend = p_docno
   	      LET g_errparam.popup = TRUE
   	      CALL cl_err()
   	      LET r_success = FALSE
   	      RETURN r_success         
   	   END IF 
   	   LET l_sfaa.sfaadocdt = cl_get_current()
         LET l_sfaa.sfaa002 = g_user
         LET l_sfaa.sfaa005 = '5'
         LET l_sfaa.sfaa006 = l_rmcb.rmcbdocno
         LET l_sfaa.sfaa007 = l_rmcb.rmcbseq      
         LET l_sfaa.sfaa010 = l_rmcb.rmcb004
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
         LET l_sfaa.sfaa071   = 0
         
         SELECT imae016 INTO l_sfaa.sfaa013
           FROM imae_t
          WHERE imaeent = g_enterprise
            AND imae001 = l_rmcb.rmcb004
            AND imaesite = g_site 
         IF cl_null(l_rmcb.rmcb007) THEN LET l_rmcb.rmcb007 = 0 END IF
         IF cl_null(l_rmcb.rmcb010) THEN LET l_rmcb.rmcb010 = 0 END IF
         LET l_qty = l_rmcb.rmcb007-l_rmcb.rmcb010
         CALL s_aooi250_convert_qty(l_rmcb.rmcb004,l_rmcb.rmcb006,l_sfaa.sfaa013,l_qty) 
            RETURNING l_success,l_sfaa.sfaa012
         IF NOT l_success THEN
            LET l_sfaa.sfaa012 = l_qty
         END IF
         LET l_sfaa.sfaa061 = 'N'
         LET l_sfaa.sfaa016 = ''
         LET l_sfaa.sfaa017 = ''
         LET l_sfaa.sfaa018 = g_site
         LET l_sfaa.sfaa019 = g_today
         CALL s_asft300_06('1',l_sfaa.sfaa010,l_sfaa.sfaa012,l_sfaa.sfaa019) RETURNING l_success,l_sfaa.sfaa020
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
         LET l_sfba.sfba026 = '1'
         LET l_sfba.sfba028 = 'N'
         
         LET l_sfba.sfba_no = l_cnt
         
         EXECUTE sfba_ins USING g_enterprise,g_site,l_sfaa.sfaadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
                                l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,l_sfba.sfba022,
                                l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,
                                l_sfba.sfba010,l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba023,l_sfba.sfba024,
                                l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba026,l_sfba.sfba028
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_sfba" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF  
         CALL armt300_ins_sfba(l_rmcb.rmcb001,l_rmcb.rmcb002,l_cnt,l_sfaa.sfaa012,l_sfaa.sfaadocno)
         
         ##新增工單來源    
         SELECT MAX(sfabseq) INTO l_sfab.sfabseq
           FROM sfab_t
          WHERE sfabdocno = l_sfaa.sfaadocno
            AND sfabent = g_enterprise    #170120-00054#1 add
         IF cl_null(l_sfab.sfabseq) THEN 
            LET l_sfab.sfabseq= 1
         ELSE
            LET l_sfab.sfabseq = l_sfab.sfabseq + 1      
         END IF 
         LET l_sfab.sfab001 = '5'
         LET l_sfab.sfab002 = l_rmcb.rmcbdocno
         LET l_sfab.sfab003 = l_rmcb.rmcbseq
         LET l_sfab.sfab004 = 0
         LET l_sfab.sfab005 = 0
         LET l_sfab.sfab006 = 10
         LET l_sfab.sfab007 = l_qty
         LET l_sfab.sfab_no = l_cnt
         EXECUTE sfab_ins USING g_enterprise,g_site,l_sfaa.sfaadocno,l_sfab.sfabseq,l_sfab.sfab001,
                                l_sfab.sfab002,l_sfab.sfab003,l_sfab.sfab004,l_sfab.sfab005,l_sfab.sfab006,l_sfab.sfab007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_sfab" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF  
         
         ##新增生產料號明細
         SELECT MAX(sfacseq) INTO l_sfac.sfacseq
           FROM sfac_t
          WHERE sfacdocno = l_sfaa.sfaadocno
            AND sfacent = g_enterprise #170120-00054#1 add
         IF cl_null(l_sfac.sfacseq) THEN 
            LET l_sfac.sfacseq= 1
         ELSE
            LET l_sfac.sfacseq = l_sfac.sfacseq + 1      
         END IF      
         LET l_sfac.sfac002 = '1'
         LET l_sfac.sfac001 = l_rmcb.rmcb004
         LET l_sfac.sfac006 = l_rmcb.rmcb005
         LET l_sfac.sfac003 = l_qty
         LET l_sfac.sfac004 = l_rmcb.rmcb006
         LET l_sfac.sfac005 = 0
         LET l_sfac.sfac_no = l_cnt 
         EXECUTE sfac_ins USING g_enterprise,g_site,l_sfaa.sfaadocno,l_sfac.sfacseq,l_sfac.sfac001,
                                l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_sfac" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF  
         UPDATE rmcb_t 
            SET rmcb010 = rmcb010+l_qty
          WHERE rmcbent= g_enterprise
            AND rmcbsite = g_site
            AND rmcbdocno = p_docno
            AND rmcbseq = l_rmcb.rmcbseq
         UPDATE rmab_t 
            SET rmab014 = rmab014+l_qty
          WHERE rmabent = g_enterprise
            AND rmabsite = g_site
            AND rmabdocno = l_rmcb.rmcb001
            AND rmabseq = l_rmcb.rmcb002
      END FOREACH
      IF NOT l_success THEN
         LET r_success = l_success
      END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 转销退
# Memo...........: #160816-00066#2
# Date & Author..: 2016-11-23 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt300_produce_xmdk(p_docno)
DEFINE p_docno    LIKE rmca_t.rmcadocno
DEFINE r_success  LIKE type_t.num5
DEFINE l_rmcb RECORD  #RMA判別單單身檔
       rmcbent LIKE rmcb_t.rmcbent, #企业编号
       rmcbsite LIKE rmcb_t.rmcbsite, #营运据点
       rmcbdocno LIKE rmcb_t.rmcbdocno, #判别单号
       rmcbseq LIKE rmcb_t.rmcbseq, #项次
       rmcb001 LIKE rmcb_t.rmcb001, #RMA单号
       rmcb002 LIKE rmcb_t.rmcb002, #RMA项次
       rmcb003 LIKE rmcb_t.rmcb003, #点收项序
       rmcb004 LIKE rmcb_t.rmcb004, #料号
       rmcb005 LIKE rmcb_t.rmcb005, #产品特征
       rmcb006 LIKE rmcb_t.rmcb006, #单位
       rmcb007 LIKE rmcb_t.rmcb007, #数量
       rmcb008 LIKE rmcb_t.rmcb008, #不良原因
       rmcb009 LIKE rmcb_t.rmcb009, #判别结果
       rmcb010 LIKE rmcb_t.rmcb010, #已转数量
       rmcb011 LIKE rmcb_t.rmcb011  #维修入库
END RECORD
DEFINE l_xmdk RECORD
     xmdkdocno LIKE xmdk_t.xmdkdocno,
     xmdkdocdt LIKE xmdk_t.xmdkdocdt,
     xmdk003 LIKE xmdk_t.xmdk003,
     xmdk004 LIKE xmdk_t.xmdk004,
     xmdk007 LIKE xmdk_t.xmdk007,
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
   xmdl001 LIKE xmdl_t.xmdl001,
   xmdl002 LIKE xmdl_t.xmdl002,
   xmdl003 LIKE xmdl_t.xmdl003,
   xmdl004 LIKE xmdl_t.xmdl004,
   xmdl005 LIKE xmdl_t.xmdl005,
   xmdl006 LIKE xmdl_t.xmdl006,
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
   xmdl020 LIKE xmdl_t.xmdl020,
   xmdl021 LIKE xmdl_t.xmdl021,
   xmdl022 LIKE xmdl_t.xmdl022,
   xmdl050 LIKE xmdl_t.xmdl050,
   xmdl094 LIKE xmdl_t.xmdl094,
   xmdl095 LIKE xmdl_t.xmdl095
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
     inba007 LIKE inba_t.inba007
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
     inbb016 LIKE inbb_t.inbb016
   END RECORD
DEFINE  l_docno      LIKE sfaa_t.sfaadocno
DEFINE  l_cnt        LIKE type_t.num10
DEFINE  l_success    LIKE type_t.num5
DEFINE  l_qty        LIKE type_t.num10
DEFINE  l_type       LIKE type_t.chr2
DEFINE  l_xmdk007_t  LIKE xmdk_t.xmdk007
DEFINE  l_oodbl004   LIKE oodbl_t.oodbl004,
        l_oodb011    LIKE oodb_t.oodb011
DEFINE  l_inbadocno  LIKE inba_t.inbadocno
DEFINE  l_slip       LIKE ooba_t.ooba001
DEFINE  l_sql        STRING 
DEFINE l_input          RECORD     #返回
      xmdkdocno LIKE xmdk_t.xmdkdocno,
      inbadocno LIKE inba_t.inbadocno,
      xmdkdocdt LIKE xmdk_t.xmdkdocdt,
      xmdl014 LIKE xmdl_t.xmdl014,
      xmdl015 LIKE xmdl_t.xmdl015,
      xmdl050 LIKE xmdl_t.xmdl050,
      inba007 LIKE inba_t.inba007
                      END RECORD

      LET r_success = TRUE
      LET l_success = TRUE
      IF cl_null(p_docno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'sub-00228'
	      LET g_errparam.extend = p_docno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF
	
	   #檢查是否有已對應的銷退單
	   LET l_cnt = 0
#	   SELECT COUNT(*) INTO l_cnt
#	     FROM xmdk_t
#	    WHERE xmdkent = g_enterprise
#	      AND xmdk000 = '6'      #销退单
#	      AND xmdk086 = p_docno
#	      AND xmdkstus <> 'X'
#	   IF l_cnt > 0 THEN
#	      INITIALIZE g_errparam TO NULL
#	      LET g_errparam.code = 'arm-00063'     #该判别单已有存在的销退单！
#	      LET g_errparam.extend = p_docno
#	      LET g_errparam.popup = TRUE
#	      CALL cl_err()
#	      LET r_success = FALSE
#	      RETURN r_success      
#	   END IF
	   
	   #依據aooi210所設置的訂單對應的銷退單別
	   CALL armt300_armp200_input()
	        RETURNING l_success,l_input.*
	   IF NOT l_success THEN
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF  
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
                  "            VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,'N','N','N',?,?,?) "
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
                  "             VALUES(?,?,?,?,?, ?,?,?,?,?,?) "
      PREPARE inba_ins FROM l_sql 
      #杂发单单身
      LET l_sql = " INSERT INTO inbb_t(inbbent,inbbsite,inbbdocno,inbbseq,inbb001,",
                  "                    inbb002,inbb003,inbb004,inbb007,inbb008,",
                  "                    inbb009,inbb010,inbb011,inbb012,inbb013,",
                  "                    inbb014,inbb015,inbb016,inbb017,inbb018,inbb019) ",
                  "             VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,'N',?)"
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
      LET l_cnt = 0
      #161124-00048#11 mod-S
#      LET l_sql = " SELECT * FROM rmcb_t ",
      LET l_sql = " SELECT rmcbent,rmcbsite,rmcbdocno,rmcbseq,rmcb001,",
                  "        rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,",
                  "        rmcb007,rmcb008,rmcb009,rmcb010,rmcb011 ",
                  "   FROM rmcb_t ",
      #161124-00048#11 mod-E
	            "  WHERE rmcbent = ",g_enterprise,
	            "    AND rmcbsite = '",g_site,"' ",
	            "    AND rmcbdocno = '",p_docno,"' ",
	            "    AND rmcb009 = '2' ",
	            "  ORDER BY rmcbdocno,rmcbseq "
   	PREPARE rmcb2_pre FROM l_sql
   	DECLARE rmcb2_sel_curs CURSOR FOR rmcb2_pre
      FOREACH rmcb2_sel_curs INTO l_rmcb.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET l_cnt = l_cnt + 1
         SELECT rmaa001 INTO l_xmdk.xmdk007
           FROM rmaa_t
          WHERE rmaaent = g_enterprise
            AND rmaadocno = l_rmcb.rmcb001
            
         IF cl_null(l_xmdk007_t) OR l_xmdk007_t <> l_xmdk.xmdk007 THEN 
            LET l_cnt  = l_cnt + 1
            LET l_xmdk.xmdkdocno = l_input.xmdkdocno
            LET l_xmdk.xmdkdocdt = l_input.xmdkdocdt
            LET l_xmdk.xmdk003 = g_user
            LET l_xmdk.xmdk004 = g_dept
            SELECT rmaa001 INTO l_xmdk.xmdk007
              FROM rmaa_t
             WHERE rmaaent = g_enterprise
               AND rmaadocno = l_rmcb.rmcb001  
            LET l_xmdk.xmdk086 = l_rmcb.rmcbdocno     
            
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
                                   
            ##新增備料明細
            SELECT MAX(xmdlseq) INTO l_xmdl.xmdlseq
              FROM xmdl_t
             WHERE xmdldocno = l_xmdk.xmdkdocno
               AND xmdlent = g_enterprise #170120-00054#1 add
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
            LET l_xmdl.xmdl014 = l_input.xmdl014
            LET l_xmdl.xmdl015 = l_input.xmdl015
            LET l_xmdl.xmdl015 = ' '
            LET l_xmdl.xmdl017 = l_rmcb.rmcb006
            LET l_xmdl.xmdl018 = l_rmcb.rmcb007
            LET l_xmdl.xmdl050 = l_input.xmdl050
            
            SELECT rmac002,rmac003,rmac004,rmac005
              INTO l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb009,l_xmdl.xmdl052
              FROM rmac_t
             WHERE rmacent = g_enterprise
               AND rmacdocno = l_rmcb.rmcb001
               AND rmacseq = l_rmcb.rmcb002
               AND rmacseq1 = l_rmcb.rmcb003
               
            LET l_xmdl.xmdl022 = l_rmcb.rmcb007
            LET l_xmdl.xmdl021 = l_rmcb.rmcb006
            LET l_xmdl.xmdl050 = l_input.xmdl050
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
            EXECUTE xmdl_ins USING g_enterprise,g_site,l_xmdk.xmdkdocno,l_xmdl.xmdlseq,l_xmdl.xmdl001,
                                   l_xmdl.xmdl002,l_xmdl.xmdl003,l_xmdl.xmdl004,l_xmdl.xmdl005,l_xmdl.xmdl006,
                                   l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl094,l_xmdl.xmdl095,l_xmdl.xmdl017,
                                   l_xmdl.xmdl018,l_xmdl.xmdl014,l_xmdl.xmdl015,l_xmdl.xmdl016,l_xmdl.xmdl052,
                                   l_xmdl.xmdl022,l_xmdl.xmdl021,l_xmdl.xmdl050,l_xmdl.xmdl019,l_xmdl.xmdl020
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
            CALL s_aooi200_gen_docno(g_site,l_input.inbadocno,l_input.xmdkdocdt,'aint301') 
               RETURNING l_success,l_inbadocno  
            #杂发单
            LET l_inba.inbadocno = l_inbadocno
            LET l_inba.inbadocdt = l_input.xmdkdocdt
            LET l_inba.inba001 = '1'
            LET l_inba.inba002 = l_input.xmdkdocdt
            LET l_inba.inba003 = g_user
            LET l_inba.inba004 = g_dept
            LET l_inba.inba005 = '10'
            LET l_inba.inba006 = ''
            LET l_inba.inba007 = l_input.inba007
            #杂发单单头
            EXECUTE inba_ins USING g_enterprise,g_site,l_inbadocno,l_inba.inbadocdt,l_inba.inba001,
                                   l_inba.inba002,l_inba.inba003,l_inba.inba004,l_inba.inba005,l_inba.inba006,l_inba.inba007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins_inba" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
               LET r_success = l_success
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
            #杂发单单身
            SELECT MAX(inbbseq) INTO l_inbb.inbbseq
              FROM inbb_t
             WHERE inbbdocno = l_inbadocno
               AND inbbent = g_enterprise
               AND inbbsite = g_site
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
            LET l_inbb.inbb016 = l_input.inba007
            EXECUTE inbb_ins USING g_enterprise,g_site,l_inbadocno,l_inbb.inbbseq,l_inbb.inbb001,
                                   l_inbb.inbb002,l_inbb.inbb003,l_inbb.inbb004,l_inbb.inbb007,l_inbb.inbb008,
                                   l_inbb.inbb009,l_inbb.inbb010,l_inbb.inbb011,l_inbb.inbb012,l_inbb.inbb013,
                                   l_inbb.inbb014,l_inbb.inbb015,l_inbb.inbb016,l_xmdk.xmdkdocno,l_inbb.inbb012
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
            LET g_prog = 'armt300'
         END IF
         UPDATE rmcb_t 
            SET rmcb010 = l_rmcb.rmcb007
          WHERE rmcbent= g_enterprise
            AND rmcbsite = g_site
            AND rmcbdocno = p_docno
            AND rmcbseq = l_rmcb.rmcbseq
         UPDATE rmab_t 
            SET rmab015 = rmab015+l_rmcb.rmcb007
          WHERE rmabent = g_enterprise
            AND rmabsite = g_site
            AND rmabdocno = l_rmcb.rmcb001
            AND rmabseq = l_rmcb.rmcb002
      END FOREACH
      IF NOT l_success THEN
         LET r_success = l_success
      END IF
      CALL cl_err_collect_show()  
RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 转覆出
# Memo...........: #160816-00066#2
# Date & Author..: 2016-11-23 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt300_produce_rmda(p_docno)
DEFINE p_docno    LIKE rmca_t.rmcadocno
DEFINE r_success  LIKE type_t.num5
DEFINE l_rmcb RECORD  #RMA判別單單身檔
       rmcbent LIKE rmcb_t.rmcbent, #企业编号
       rmcbsite LIKE rmcb_t.rmcbsite, #营运据点
       rmcbdocno LIKE rmcb_t.rmcbdocno, #判别单号
       rmcbseq LIKE rmcb_t.rmcbseq, #项次
       rmcb001 LIKE rmcb_t.rmcb001, #RMA单号
       rmcb002 LIKE rmcb_t.rmcb002, #RMA项次
       rmcb003 LIKE rmcb_t.rmcb003, #点收项序
       rmcb004 LIKE rmcb_t.rmcb004, #料号
       rmcb005 LIKE rmcb_t.rmcb005, #产品特征
       rmcb006 LIKE rmcb_t.rmcb006, #单位
       rmcb007 LIKE rmcb_t.rmcb007, #数量
       rmcb008 LIKE rmcb_t.rmcb008, #不良原因
       rmcb009 LIKE rmcb_t.rmcb009, #判别结果
       rmcb010 LIKE rmcb_t.rmcb010, #已转数量
       rmcb011 LIKE rmcb_t.rmcb011  #维修入库
END RECORD
DEFINE l_rmda RECORD  #RMA覆出單單頭檔
       rmdaent    LIKE rmda_t.rmdaent, #企业编号
       rmdasite   LIKE rmda_t.rmdasite, #营运据点
       rmdadocno  LIKE rmda_t.rmdadocno, #覆出单号
       rmdadocdt  LIKE rmda_t.rmdadocdt, #覆出日期
       rmda_no LIKE type_t.num5,
       rmda001 LIKE rmda_t.rmda001, #扣账日期
       rmda002 LIKE rmda_t.rmda002, #业务人员
       rmda003 LIKE rmda_t.rmda003, #业务部门
       rmda004 LIKE rmda_t.rmda004, #RMA单号
       rmda005 LIKE rmda_t.rmda005, #客户编号
       rmda006 LIKE rmda_t.rmda006, #收货客户
       rmda007 LIKE rmda_t.rmda007, #账款客户
       rmda008 LIKE rmda_t.rmda008, #发票客户
       rmda009 LIKE rmda_t.rmda009, #包装单制作
       rmda010 LIKE rmda_t.rmda010, #invoice制作
       rmda011 LIKE rmda_t.rmda011, #送货地址
       rmda012 LIKE rmda_t.rmda012, #运输方式
       rmda013 LIKE rmda_t.rmda013, #起运地
       rmda014 LIKE rmda_t.rmda014, #目的地
       rmda015 LIKE rmda_t.rmda015, #送货供应商
       rmda016 LIKE rmda_t.rmda016, #航班/船班/车号
       rmda017 LIKE rmda_t.rmda017, #起运日期
       rmda018 LIKE rmda_t.rmda018, #唛头编号
       rmda019 LIKE rmda_t.rmda019, #运输状态
       rmdaownid LIKE rmda_t.rmdaownid, #资料所有者
       rmdaowndp LIKE rmda_t.rmdaowndp, #资料所有部门
       rmdacrtid LIKE rmda_t.rmdacrtid, #资料录入者
       rmdacrtdp LIKE rmda_t.rmdacrtdp, #资料录入部门
       rmdacrtdt LIKE rmda_t.rmdacrtdt, #资料创建日
       rmdamodid LIKE rmda_t.rmdamodid, #资料更改者
       rmdamoddt LIKE rmda_t.rmdamoddt, #最近更改日
       rmdastus LIKE rmda_t.rmdastus, #状态码
       rmdacnfid LIKE rmda_t.rmdacnfid, #资料审核者
       rmdacnfdt LIKE rmda_t.rmdacnfdt, #数据审核日
       rmdapstid LIKE rmda_t.rmdapstid, #资料过账者
       rmdapstdt LIKE rmda_t.rmdapstdt  #资料过账日
END RECORD
DEFINE l_rmdb RECORD  #RMA覆出單單身檔
       rmdbent LIKE rmdb_t.rmdbent, #企业编号
       rmdbsite LIKE rmdb_t.rmdbsite, #营运据点
       rmdbdocno LIKE rmdb_t.rmdbdocno, #单据单号
       rmdb_no  LIKE type_t.num5,
       rmdbseq LIKE rmdb_t.rmdbseq, #项次
       rmdb001 LIKE rmdb_t.rmdb001, #RMA单号
       rmdb002 LIKE rmdb_t.rmdb002, #RMA项次
       rmdb003 LIKE rmdb_t.rmdb003, #料号
       rmdb004 LIKE rmdb_t.rmdb004, #产品特征
       rmdb005 LIKE rmdb_t.rmdb005, #单位
       rmdb006 LIKE rmdb_t.rmdb006, #覆出数量
       rmdb007 LIKE rmdb_t.rmdb007, #库位
       rmdb008 LIKE rmdb_t.rmdb008, #储位
       rmdb009 LIKE rmdb_t.rmdb009, #批号
       rmdb010 LIKE rmdb_t.rmdb010, #库存特征
       rmdb011 LIKE rmdb_t.rmdb011, #备注
       rmdb012 LIKE rmdb_t.rmdb012, #多库储批出货
       rmdb013 LIKE rmdb_t.rmdb013, #计价数量
       rmdb014 LIKE rmdb_t.rmdb014, #覆出类型
       rmdb015 LIKE rmdb_t.rmdb015, #单价
       rmdb016 LIKE rmdb_t.rmdb016, #税前金额
       rmdb017 LIKE rmdb_t.rmdb017  #含税金额
END RECORD
DEFINE  l_docno      LIKE sfaa_t.sfaadocno
DEFINE  l_cnt        LIKE type_t.num10
DEFINE  l_success    LIKE type_t.num5
DEFINE  l_type       LIKE type_t.chr2
DEFINE  l_sql        STRING 
DEFINE l_rmba006     LIKE rmba_t.rmba006     #税种
DEFINE l_rmba010     LIKE rmba_t.rmba010     #币种
DEFINE l_rmba011     LIKE rmba_t.rmba011     #汇率
DEFINE l_tax         LIKE rmdb_t.rmdb017     #税额

      LET r_success = TRUE
      LET l_success = TRUE
      IF cl_null(p_docno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'sub-00228'
	      LET g_errparam.extend = p_docno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF
	
	   #檢查是否有已對應的覆出单
	   LET l_cnt = 0
#	   SELECT COUNT(*) INTO l_cnt
#	     FROM rmda_t
#	    WHERE rmdaent = g_enterprise
#	      AND rmda004 = p_docno        #待修改，rmdb需添加来源判别单栏位
#	      AND NOT EXISTS (SELECT 1 FROM rmdb_t WHERE rmdb001 = p_docno AND rmdbdocno = rmdadocno AND rmdbent = g_enterprise AND rmdbsite = g_site)
#	      AND rmdastus <> 'X'
#	   IF l_cnt > 0 THEN
#	      INITIALIZE g_errparam TO NULL
#	      LET g_errparam.code = 'arm-00064'     #该判别单已有存在的覆出单！
#	      LET g_errparam.extend = p_docno
#	      LET g_errparam.popup = TRUE
#	      CALL cl_err()
#	      LET r_success = FALSE
#	      RETURN r_success      
#	   END IF
	   
	   #依據aooi210所設置的訂單對應的銷退單別
	   CALL s_aooi210_get_doc(g_site,'',6,p_docno,'armt400','arm-00066')      #[转覆出]请挑选覆出单别！
	        RETURNING l_success,l_docno
	   IF NOT l_success THEN
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF  
	   
	   IF cl_null(l_docno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'agl-00122'
	      LET g_errparam.extend = p_docno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success
	   END IF 
	   
	   LET l_sql = " INSERT INTO rmda_t(rmdaent,rmdasite,rmdadocno,rmdadocdt,rmda001,", 
                  "                    rmda002,rmda003,rmda004,rmda005,rmda006,",  
                  "                    rmda007,rmda008,rmda009,rmda010,rmda011,",   
                  "                    rmda012,rmda013,rmda014,rmda015,rmda016,rmda017,",
                  "                    rmda018,rmda019,rmdaownid,rmdaowndp,rmdacrtid,",   
                  "                    rmdacrtdp,rmdacrtdt,rmdamodid,rmdamoddt,rmdastus,", 
                  "                    rmdacnfid,rmdacnfdt,rmdapstid,rmdapstdt) ",
                  "  VALUES(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,?,  ?,?,?,?,?,",
                  "         ?,?,?,?,?,  ?,?,?,? )"      
      PREPARE rmda_ins FROM l_sql 
   
      LET l_sql = " INSERT INTO rmdb_t(rmdbent,rmdbsite,rmdbdocno,rmdbseq,rmdb001,",
                  "                    rmdb002,rmdb003,rmdb004,rmdb005,rmdb006,",
                  "                    rmdb007,rmdb008,rmdb009,rmdb010,rmdb012,",
                  "                    rmdb013,rmdb014,rmdb015,rmdb016,rmdb017 ) ",
                  "             VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,'N', ?,'3',?,?,?)"
      PREPARE rmdb_ins FROM l_sql  
      
      LET l_sql = " INSERT INTO rmdc_t(rmdcent,rmdcsite,rmdcdocno,rmdcseq,rmdcseq1,",
                  "                    rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,",
                  "                    rmdc006,rmdc007,rmdc008 ) ",
                  "             VALUES(?,?,?,?,'1', ?,?,?,?,?, ?,?,?)"
      PREPARE rmdc_ins FROM l_sql  

      LET l_success = TRUE
      LET l_cnt = 0
      #161124-00048#11 mod-S
#      LET l_sql = " SELECT * FROM rmcb_t ",
      LET l_sql = " SELECT rmcbent,rmcbsite,rmcbdocno,rmcbseq,rmcb001,",
                  "        rmcb002,rmcb003,rmcb004,rmcb005,rmcb006,",
                  "        rmcb007,rmcb008,rmcb009,rmcb010,rmcb011 ",
                  "   FROM rmcb_t ",
      #161124-00048#11 mod-E
	            "  WHERE rmcbent = ",g_enterprise,
	            "    AND rmcbsite = '",g_site,"' ",
	            "    AND rmcbdocno = '",p_docno,"' ",
	            "    AND rmcb009 = '3' ",
	            "  ORDER BY rmcbdocno,rmcbseq "
   	PREPARE rmcb3_pre FROM l_sql
   	DECLARE rmcb3_sel_curs CURSOR FOR rmcb3_pre
      FOREACH rmcb3_sel_curs INTO l_rmcb.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET l_cnt = l_cnt + 1
         LET l_rmda.rmdadocdt = cl_get_current()
         #产生覆出单单头
         CALL s_aooi200_gen_docno(g_site,l_docno,l_rmda.rmdadocdt,'armt400') 
            RETURNING l_success,l_rmda.rmdadocno
         SELECT rmaa001 INTO l_rmda.rmda005
           FROM rmaa_t
          WHERE rmaaent = g_enterprise
            AND rmaadocno = l_rmcb.rmcb001
            
         LET l_rmda.rmda002 = g_user
         LET l_rmda.rmda003 = g_dept
         LET l_rmda.rmda004 = l_rmcb.rmcb001
         SELECT rmaa001 INTO l_rmda.rmda005
           FROM rmaa_t
          WHERE rmaaent = g_enterprise
            AND rmaadocno = l_rmcb.rmcb001  
         LET l_rmda.rmda001 = l_rmda.rmdadocdt
         LET l_rmda.rmda006 = l_rmda.rmda005
         LET l_rmda.rmda007 = l_rmda.rmda005
         LET l_rmda.rmda008 = l_rmda.rmda005
         LET l_rmda.rmda009 = 'N'
         LET l_rmda.rmda010 = 'N'
         LET l_rmda.rmda019 = '1'
         LET l_rmda.rmdastus = 'N'
         SELECT pmab090,pmab091,pmab092
           INTO l_rmda.rmda012,l_rmda.rmda013,l_rmda.rmda014
           FROM pmab_t
          WHERE pmabent = g_enterprise            
            AND pmabsite = g_site
            AND pmab001 = l_rmda.rmda005
         
         LET l_rmda.rmdaownid = g_user
         LET l_rmda.rmdaowndp = g_dept
         LET l_rmda.rmdacrtid = g_user
         LET l_rmda.rmdacrtdp = g_dept
         LET l_rmda.rmdacrtdt = cl_get_current()
         LET l_rmda.rmdamodid = g_user
         LET l_rmda.rmdamoddt = cl_get_current()
         
         EXECUTE rmda_ins USING g_enterprise,g_site,l_rmda.rmdadocno,l_rmda.rmdadocdt,l_rmda.rmda001,
                                l_rmda.rmda002,l_rmda.rmda003,l_rmda.rmda004,l_rmda.rmda005,l_rmda.rmda006,
                                l_rmda.rmda007,l_rmda.rmda008,l_rmda.rmda009,l_rmda.rmda010,l_rmda.rmda011,
                                l_rmda.rmda012,l_rmda.rmda013,l_rmda.rmda014,l_rmda.rmda015,l_rmda.rmda016,l_rmda.rmda017,
                                l_rmda.rmda018,l_rmda.rmda019,l_rmda.rmdaownid,l_rmda.rmdaowndp,l_rmda.rmdacrtid,
                                l_rmda.rmdacrtdp,l_rmda.rmdacrtdt,l_rmda.rmdamodid,l_rmda.rmdamoddt,l_rmda.rmdastus,
                                l_rmda.rmdacnfid,l_rmda.rmdacnfdt,l_rmda.rmdapstid,l_rmda.rmdapstdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_rmda" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF  
         #rmdb
         SELECT MAX(rmdbseq) INTO l_rmdb.rmdbseq
           FROM rmdb_t
          WHERE rmdbdocno = l_rmda.rmdadocno
            AND rmdbent = g_enterprise
            AND rmdbsite = g_site
         IF cl_null(l_rmdb.rmdbseq) THEN 
            LET l_rmdb.rmdbseq = 1
         ELSE
            LET l_rmdb.rmdbseq = l_rmdb.rmdbseq + 1      
         END IF
         
         LET l_rmdb.rmdb001 = l_rmcb.rmcb001   
         LET l_rmdb.rmdb002 = l_rmcb.rmcb002   
         LET l_rmdb.rmdb003 = l_rmcb.rmcb004    #料号
         LET l_rmdb.rmdb004 = l_rmcb.rmcb005    #产品特征
         LET l_rmdb.rmdb005 = l_rmcb.rmcb006    #单位
         #库位、储位带单别参数值
         LET l_rmdb.rmdb007 = cl_get_doc_para(g_enterprise,g_site,l_docno,'E-MFG-0042')
         
         SELECT rmac004,rmac005                 #批号、库存特征
           INTO l_rmdb.rmdb009,l_rmdb.rmdb010
           FROM rmac_t
          WHERE rmacent = g_enterprise
            AND rmacdocno = l_rmcb.rmcb001
            AND rmacseq = l_rmcb.rmcb002
            AND rmacseq1 = l_rmcb.rmcb003
         
         #计价数量带覆出数量
         LET l_rmdb.rmdb006 = l_rmcb.rmcb007
         LET l_rmdb.rmdb013 = l_rmcb.rmcb007
         #单价、税前金额、含税金额
         IF NOT cl_null(l_rmdb.rmdb001) OR NOT cl_null(l_rmdb.rmdb002) THEN 
            SELECT rmba006,rmba010,rmba011 INTO l_rmba006,l_rmba010,l_rmba011
              FROM rmba_t
             WHERE rmbadocno = l_rmdb.rmdb001
               AND rmbasite = g_site
               AND rmbaent = g_enterprise
             ORDER BY rmba000 DESC
            LET l_rmdb.rmdb015 = 0 
            CALL s_axmt500_get_amount(l_rmdb.rmdb001,l_rmdb.rmdb002,l_rmdb.rmdb013,l_rmdb.rmdb015,l_rmba006,l_rmba010,l_rmba011)
               RETURNING l_rmdb.rmdb016,l_rmdb.rmdb017,l_tax
            IF cl_null(l_rmdb.rmdb016) THEN LET l_rmdb.rmdb016 = 0 END IF
            IF cl_null(l_rmdb.rmdb017) THEN LET l_rmdb.rmdb017 = 0 END IF
         END IF
         EXECUTE rmdb_ins USING g_enterprise,g_site,l_rmda.rmdadocno,l_rmdb.rmdbseq,l_rmdb.rmdb001,
                                l_rmdb.rmdb002,l_rmdb.rmdb003,l_rmdb.rmdb004,l_rmdb.rmdb005,l_rmdb.rmdb006,
                                l_rmdb.rmdb007,l_rmdb.rmdb008,l_rmdb.rmdb009,l_rmdb.rmdb010,
                                l_rmdb.rmdb013,l_rmdb.rmdb015,l_rmdb.rmdb016,l_rmdb.rmdb017
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_rmdb" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF  
         
         EXECUTE rmdc_ins USING g_enterprise,g_site,l_rmda.rmdadocno,l_rmdb.rmdbseq,
                                l_rmdb.rmdb003,l_rmdb.rmdb004,l_rmdb.rmdb005,l_rmdb.rmdb006,l_rmdb.rmdb007,
                                l_rmdb.rmdb008,l_rmdb.rmdb009,l_rmdb.rmdb010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_rmdc" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF  
         
         UPDATE rmcb_t 
            SET rmcb010 = l_rmcb.rmcb007
          WHERE rmcbent= g_enterprise
            AND rmcbsite = g_site
            AND rmcbdocno = p_docno
            AND rmcbseq = l_rmcb.rmcbseq
         UPDATE rmab_t 
            SET rmab016 = rmab016+l_rmcb.rmcb007
          WHERE rmabent = g_enterprise
            AND rmabsite = g_site
            AND rmabdocno = l_rmcb.rmcb001
            AND rmabseq = l_rmcb.rmcb002
         IF NOT s_armt400_conf_chk(l_rmda.rmdadocno) THEN
            LET r_success = FALSE
            RETURN r_success    
         END IF 
         IF NOT s_armt400_conf_upd(l_rmda.rmdadocno) THEN
            LET r_success = FALSE
            RETURN r_success    
         END IF
      END FOREACH
      IF NOT l_success THEN
         LET r_success = l_success
      END IF
RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 备料插入
# Memo...........: #160816-00066#2
# Date & Author..: 2016-11-23 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt300_ins_sfba(p_rmbcdocno,p_rmbcseq,p_cnt,p_sfaa012,p_sfaadocno)
DEFINE p_rmbcdocno LIKE rmbc_t.rmbcdocno,
       p_rmbcseq LIKE rmbc_t.rmbcseq,
       p_cnt LIKE type_t.num5,
       p_sfaa012 LIKE sfaa_t.sfaa012,
       p_sfaadocno LIKE sfaa_t.sfaadocno
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
     sfba020 LIKE sfba_t.sfba020,
     sfba026 LIKE sfba_t.sfba026,
     sfba028 LIKE sfba_t.sfba028
     END RECORD 
DEFINE l_success LIKE type_t.num5

   LET l_sfba.sfbaseq= 10 
   
   SELECT rmab013 INTO l_sfba.sfba011
     FROM rmab_t
    WHERE rmabent = g_enterprise
      AND rmabdocno = p_rmbcdocno
      AND rmabseq = p_rmbcseq
      
   LET l_sql = " SELECT rmbc001,rmbc002,rmbc003,rmbc004 ",
               "   FROM rmba_t a,rmbb_t,rmbc_t ",
               "  WHERE rmbaent = rmbbent AND rmbadocno = rmbbdocno AND rmba000 = rmbb000 ",
               "    AND rmbbent = rmbcent AND rmbbdocno = rmbcdocno AND rmbb000 = rmbc000 AND rmbbseq = rmbcseq ",
               "    AND rmbaent = '",g_enterprise,"'",
               "    AND rmbasite = '",g_site,"'",
               "    AND rmbadocno = '",p_rmbcdocno,"'",
               "    AND rmbbseq = ",p_rmbcseq,
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
      LET l_sfba.sfba026 = '1'
      LET l_sfba.sfba028 = 'N'
      LET l_sfba.sfba_no = p_cnt
      EXECUTE sfba_ins USING g_enterprise,g_site,p_sfaadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
                             l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,l_sfba.sfba022,
                             l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,
                             l_sfba.sfba010,l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba023,l_sfba.sfba024,
                             l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba026,l_sfba.sfba028
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

################################################################################
# Descriptions...: 获取转销退的input条件
################################################################################
PRIVATE FUNCTION armt300_armp200_input()
   DEFINE r_success   LIKE type_t.num5     #執行結果
   DEFINE l_ooef004   LIKE ooef_t.ooef004  #進銷存單據別參照表號
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_where     STRING
   DEFINE l_only      LIKE type_t.chr1
   DEFINE l_type       LIKE type_t.chr1
   DEFINE l_inaa007    LIKE inaa_t.inaa007
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_ooba015    LIKE ooba_t.ooba015
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   DEFINE l_acc        LIKE gzcb_t.gzcb007
   DEFINE l_acc2       LIKE gzcb_t.gzcb007
   DEFINE tm          RECORD     #返回
      xmdkdocno LIKE xmdk_t.xmdkdocno,
      inbadocno LIKE inba_t.inbadocno,
      xmdkdocdt LIKE xmdk_t.xmdkdocdt,
      xmdl014 LIKE xmdl_t.xmdl014,
      xmdl015 LIKE xmdl_t.xmdl015,
      xmdl050 LIKE xmdl_t.xmdl050,
      inba007 LIKE inba_t.inba007
                      END RECORD
   DEFINE l_sql1          STRING            #160711-00040#28 add
   
   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   INITIALIZE tm.* TO NULL

   #由營運據點抓取aooi100單據別參照表號
   IF cl_null(g_ooef.ooef004) THEN
      CALL s_aooi100_sel_ooef004(g_site) RETURNING r_success,g_ooef.ooef004
      IF NOT r_success THEN
         RETURN r_success,tm.*
      END IF
   END IF
   LET l_acc = s_fin_get_scc_value('24','aint301','2')  
   LET l_acc2 = s_fin_get_scc_value('24','axmt600','2') 
   
   OPEN WINDOW w_s_armt300_s01 WITH FORM cl_ap_formpath("sub",'s_armt300_s01')

   CALL cl_ui_init( )

   INITIALIZE tm.* TO NULL
#   #顯示備註p_show
#   CALL s_desc_get_error_desc(p_show) RETURNING tm.show_desc
#   DISPLAY BY NAME tm.show_desc
      
   INPUT BY NAME tm.xmdkdocno,tm.inbadocno,tm.xmdkdocdt,tm.xmdl014,tm.xmdl015,tm.inba007,tm.xmdl050 WITHOUT DEFAULTS
      BEFORE INPUT
      
         AFTER FIELD xmdkdocno
               IF NOT cl_null(tm.xmdkdocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',tm.xmdkdocno,'axmt600') THEN
                     LET tm.xmdkdocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF

            AFTER FIELD inbadocno
               IF NOT cl_null(tm.inbadocno) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',tm.inbadocno,'aint301') THEN
                     LET tm.inbadocno = ''
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               
            AFTER FIELD xmdl014
               IF NOT cl_null(tm.xmdl014)THEN               
                                 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                      
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = tm.xmdl014    #庫位
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end         
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET tm.xmdl014 = ''
                     NEXT FIELD CURRENT
                  END IF
                  LET l_inaa007 = ''
                  SELECT inaa007 INTO l_inaa007
                    FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_site
                     AND inaa001 = tm.xmdl014
                  CALL cl_set_comp_entry("xmdl015",TRUE)
                  CALL cl_set_comp_required("xmdl015",FALSE)
                  IF l_inaa007 = '5' THEN 
                     CALL cl_set_comp_entry("xmdl015",FALSE)
                     LET tm.xmdl015 = ''
                  ELSE
                     CALL cl_set_comp_required("xmdl015",TRUE)
                  END IF
                  IF NOT cl_null(tm.xmdl015) THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                                    
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = tm.xmdl014
                     LET g_chkparam.arg3 = tm.xmdl015
                     #160318-00025#21  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     #160318-00025#21  by 07900 --add-end                  
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_inab002") THEN
                        LET tm.xmdl014 = ''
                        NEXT FIELD CURRENT
                     END IF    
                  END IF                   
               END IF
               
            AFTER FIELD xmdl015 
               IF NOT cl_null(tm.xmdl015) THEN
                  IF cl_null(tm.xmdl015) THEN
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
                  LET g_chkparam.arg2 = tm.xmdl014
                  LET g_chkparam.arg3 = tm.xmdl015
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET tm.xmdl015 = ''
                     NEXT FIELD CURRENT
                  END IF    
               END IF  
            
            AFTER FIELD xmdl050
               IF NOT cl_null(tm.xmdl050) THEN              
                  IF NOT s_azzi650_chk_exist(l_acc2,tm.xmdl050) THEN
                     LET tm.xmdl050 = ''
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的理由碼是否在單據別限制範圍內
                  CALL s_control_chk_doc('8',tm.xmdkdocno,tm.xmdl050,'','','','')
                  RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'apm-00237'    #输入的理由码不在单据别限制范围内，不可使用此理由码！
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
                     LET tm.xmdl050 = ''
                     NEXT FIELD CURRENT
                  END IF                  
               END IF            
            AFTER FIELD inba007
               IF NOT cl_null(tm.inba007) THEN              
                  IF NOT s_azzi650_chk_exist(l_acc,tm.inba007) THEN
                     LET tm.inba007 = ''
                     NEXT FIELD CURRENT
                  END IF
                  #檢核輸入的理由碼是否在單據別限制範圍內
                  CALL s_control_chk_doc('8',tm.inbadocno,tm.inba007,'','','','')
                  RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'apm-00237'    #输入的理由码不在单据别限制范围内，不可使用此理由码！
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
                     LET tm.inba007 = ''
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
                       AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = tm.xmdkdocno
		      	IF l_n > 0 THEN
		      	   #判斷是正向列表還是負向列表
		      	   LET l_ooba015 = ''
		      	   SELECT ooba015 INTO l_ooba015 FROM ooba_t
		      	     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = tm.xmdkdocno
                     #正向列表
                     IF l_ooba015 = '1' THEN
                        LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",tm.xmdkdocno,"')"
                     END IF
                     
                     #負向列表
                     IF l_ooba015 = '2' THEN
                        LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",tm.xmdkdocno,"')"
                     END IF
                  END IF
                  LET g_qryparam.default1 = tm.xmdl050      #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = l_acc2 #
                  CALL q_oocq002()                                #呼叫開窗         
                  LET tm.xmdl050 = g_qryparam.return1        #將開窗取得的值回傳到變數          
                  DISPLAY tm.xmdl050 TO xmdl050              #顯示到畫面上        
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
                       AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = tm.inbadocno
		      	IF l_n > 0 THEN
		      	   #判斷是正向列表還是負向列表
		      	   LET l_ooba015 = ''
		      	   SELECT ooba015 INTO l_ooba015 FROM ooba_t
		      	     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = tm.inbadocno
                     #正向列表
                     IF l_ooba015 = '1' THEN
                        LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",tm.inbadocno,"')"
                     END IF
                     
                     #負向列表
                     IF l_ooba015 = '2' THEN
                        LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",tm.inbadocno,"')"
                     END IF
                  END IF
                  LET g_qryparam.default1 = tm.inba007      #給予default值
                  
                  #給予arg
                  LET g_qryparam.arg1 = l_acc #
                  CALL q_oocq002()                                #呼叫開窗         
                  LET tm.inba007 = g_qryparam.return1        #將開窗取得的值回傳到變數          
                  DISPLAY tm.inba007 TO inba007              #顯示到畫面上        
                  NEXT FIELD inba007 


            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.xmdkdocno 
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
               LET tm.xmdkdocno = g_qryparam.return1              
               NEXT FIELD xmdkdocno

            ON ACTION controlp INFIELD inbadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.inbadocno 
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
               LET tm.inbadocno = g_qryparam.return1              
               NEXT FIELD inbadocno

            ON ACTION controlp INFIELD xmdl014
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.xmdl014 
               LET g_qryparam.arg1 = g_site
               CALL q_inaa001_4()                              
               LET tm.xmdl014 = g_qryparam.return1              
               NEXT FIELD xmdl014
               
            ON ACTION controlp INFIELD xmdl015
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.xmdl015 
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = tm.xmdl014
               CALL q_inab002_8()                              
               LET tm.xmdl015 = g_qryparam.return1              
               NEXT FIELD xmdl015               
            
      ON ACTION accept
         ACCEPT INPUT
         
      ON ACTION cancel
         EXIT INPUT

      ON ACTION exit
         EXIT INPUT
      
      AFTER INPUT
      
   END INPUT
   
   CLOSE WINDOW w_s_armt300_s01
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      INITIALIZE tm.* TO NULL
      RETURN r_success,tm.*
   END IF
   
   RETURN r_success,tm.*
END FUNCTION

 
{</section>}
 
