#該程式未解開Section, 採用最新樣板產出!
{<section id="aint170.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2015-02-25 17:05:09), PR版次:0027(2017-02-20 15:19:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000362
#+ Filename...: aint170
#+ Description: 庫存異常變更維護作業
#+ Creator....: 01996(2014-04-01 14:47:44)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="aint170.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#1    15/12/30 By tsungyung 手動輸入特徵碼沒有同步新增inam_t[料件產品特徵明細檔](整批修改)
#151228-00010#1    16/02/25 By xujing    單身輸入第1筆後，進到第2筆項次之後，按刪除，程式會異常，無法再進入insert段
#141222-00014#13   16/03/02 By xujing    現在變更單會控卡一張單子同一顆料只能維護一筆,請放寬此控卡,改成控卡相同的料,產品特徵,庫位,儲位,批號,庫存管理特徵只能維護一筆
#160318-00015#1    16/03/23 by xujing    新增制造批序号日期
#160318-00003#1    16/03/23 by xujing    变更单位要存在于料件主档允许使用的单位
#160314-00009#9    16/03/25 By zhujing   各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00025#19   16/04/14 BY 07900     校验代码重复错误讯息的修改
#160613-00038#1    16/06/14 By 06821     s_aooi200_chk_slip傳入值(原寫死程式代號)，改用g_prog處理
#160512-00004#1    16/06/20 By Whitney   inai012製造日期改抓inae010
#160705-00042#7    16/07/15 By 02159     把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#160729-00013#1    16/07/29 By lixh      增加控制组检核
#160812-00017#2    16/08/15 By 06814     在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#16   16/08/24 By lixh      单据类作业修改，删除时需重新检查状态
#161121-00004#1    16/11/21 By wuxja     检查是否存在变更明细的判断不需要，因为料号和变更类型至少有一个不一样
#161124-00048#5    16/12/09 By 08734     星号整批调整
#161123-00010#1    16/12/12 By lixh      FUNCTION aint170_inbh_ins() 捞取资料条件给值不准确
#160824-00007#276  16/12/23 By lori      修正舊值備份寫法
#160711-00040#15   17/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
PRIVATE type type_g_inbf_m        RECORD
       inbfdocno LIKE inbf_t.inbfdocno, 
   inbfdocno_desc LIKE type_t.chr80, 
   inbfdocdt LIKE inbf_t.inbfdocdt, 
   inbf001 LIKE inbf_t.inbf001, 
   inbf001_desc LIKE type_t.chr80, 
   inbf002 LIKE inbf_t.inbf002, 
   inbf002_desc LIKE type_t.chr80, 
   inbf003 LIKE inbf_t.inbf003, 
   inbf003_desc LIKE type_t.chr80, 
   inbf004 LIKE inbf_t.inbf004, 
   inbfsite LIKE inbf_t.inbfsite, 
   inbfstus LIKE inbf_t.inbfstus, 
   inbfownid LIKE inbf_t.inbfownid, 
   inbfownid_desc LIKE type_t.chr80, 
   inbfowndp LIKE inbf_t.inbfowndp, 
   inbfowndp_desc LIKE type_t.chr80, 
   inbfcrtid LIKE inbf_t.inbfcrtid, 
   inbfcrtid_desc LIKE type_t.chr80, 
   inbfcrtdp LIKE inbf_t.inbfcrtdp, 
   inbfcrtdp_desc LIKE type_t.chr80, 
   inbfcrtdt LIKE inbf_t.inbfcrtdt, 
   inbfmodid LIKE inbf_t.inbfmodid, 
   inbfmodid_desc LIKE type_t.chr80, 
   inbfmoddt LIKE inbf_t.inbfmoddt, 
   inbfcnfid LIKE inbf_t.inbfcnfid, 
   inbfcnfid_desc LIKE type_t.chr80, 
   inbfcnfdt LIKE inbf_t.inbfcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_inbg_d        RECORD
       inbgseq LIKE inbg_t.inbgseq, 
   inbg001 LIKE inbg_t.inbg001, 
   inbg002 LIKE inbg_t.inbg002, 
   inbg002_desc LIKE type_t.chr500, 
   inbg002_desc_desc LIKE type_t.chr500, 
   inbg003 LIKE inbg_t.inbg003, 
   inbg003_desc LIKE type_t.chr500, 
   inbg004 LIKE inbg_t.inbg004, 
   inbg004_desc LIKE type_t.chr500, 
   inbg005 LIKE inbg_t.inbg005, 
   inbg005_desc LIKE type_t.chr500, 
   inbg006 LIKE inbg_t.inbg006, 
   inbg008 LIKE inbg_t.inbg008, 
   inbg007 LIKE inbg_t.inbg007, 
   inbg009 LIKE inbg_t.inbg009, 
   inbg010 LIKE inbg_t.inbg010, 
   inbg011 LIKE inbg_t.inbg011, 
   inbg031 LIKE inbg_t.inbg031, 
   inbg031_desc LIKE type_t.chr500, 
   inbg012 LIKE inbg_t.inbg012, 
   inbg032 LIKE inbg_t.inbg032, 
   inbgsite LIKE inbg_t.inbgsite
       END RECORD
PRIVATE TYPE type_g_inbg2_d RECORD
       inbhseq LIKE inbh_t.inbhseq, 
   inbhseq1 LIKE inbh_t.inbhseq1, 
   inbh001 LIKE inbh_t.inbh001, 
   inbh002 LIKE inbh_t.inbh002, 
   inbh002_desc LIKE type_t.chr500, 
   inbh002_desc_1 LIKE type_t.chr500, 
   inbh003 LIKE inbh_t.inbh003, 
   inbh003_desc LIKE type_t.chr500, 
   inbh004 LIKE inbh_t.inbh004, 
   inbh004_desc LIKE type_t.chr500, 
   inbh005 LIKE inbh_t.inbh005, 
   inbh006 LIKE inbh_t.inbh006, 
   inbh008 LIKE inbh_t.inbh008, 
   inbh007 LIKE inbh_t.inbh007, 
   inbh011 LIKE inbh_t.inbh011, 
   inbh012 LIKE inbh_t.inbh012, 
   inbh014 LIKE inbh_t.inbh014, 
   inbh013 LIKE inbh_t.inbh013, 
   inbh017 LIKE inbh_t.inbh017
       END RECORD
PRIVATE TYPE type_g_inbg3_d RECORD
       inaoseq1 LIKE inao_t.inaoseq1, 
   inaoseq2 LIKE inao_t.inaoseq2, 
   inao000 LIKE inao_t.inao000, 
   inao001 LIKE inao_t.inao001, 
   inao001_desc LIKE type_t.chr500, 
   inao001_desc_1 LIKE type_t.chr500, 
   inao005 LIKE inao_t.inao005, 
   inao005_desc LIKE type_t.chr500, 
   inao006 LIKE inao_t.inao006, 
   inao006_desc LIKE type_t.chr500, 
   inao008 LIKE inao_t.inao008, 
   inao009 LIKE inao_t.inao009, 
   inao0081 LIKE type_t.chr500, 
   inao0091 LIKE type_t.chr500, 
   inao012 LIKE inao_t.inao012, 
   inao013 LIKE inao_t.inao013, 
   inao014 LIKE inao_t.inao014
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_inbfdocno LIKE inbf_t.inbfdocno,
   b_inbfdocno_desc LIKE type_t.chr80,
      b_inbfdocdt LIKE inbf_t.inbfdocdt,
      b_inbf001 LIKE inbf_t.inbf001,
   b_inbf001_desc LIKE type_t.chr80,
      b_inbf002 LIKE inbf_t.inbf002,
   b_inbf002_desc LIKE type_t.chr80,
      b_inbf003 LIKE inbf_t.inbf003,
   b_inbf003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_ooef                RECORD LIKE ooef_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
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
       ooef116 LIKE ooef_t.ooef116 #语言别
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
DEFINE g_acc                 LIKE gzcb_t.gzcb004
DEFINE g_inbf_o              type_g_inbf_m
#end add-point
       
#模組變數(Module Variables)
DEFINE g_inbf_m          type_g_inbf_m
DEFINE g_inbf_m_t        type_g_inbf_m
DEFINE g_inbf_m_o        type_g_inbf_m
DEFINE g_inbf_m_mask_o   type_g_inbf_m #轉換遮罩前資料
DEFINE g_inbf_m_mask_n   type_g_inbf_m #轉換遮罩後資料
 
   DEFINE g_inbfdocno_t LIKE inbf_t.inbfdocno
 
 
DEFINE g_inbg_d          DYNAMIC ARRAY OF type_g_inbg_d
DEFINE g_inbg_d_t        type_g_inbg_d
DEFINE g_inbg_d_o        type_g_inbg_d
DEFINE g_inbg_d_mask_o   DYNAMIC ARRAY OF type_g_inbg_d #轉換遮罩前資料
DEFINE g_inbg_d_mask_n   DYNAMIC ARRAY OF type_g_inbg_d #轉換遮罩後資料
DEFINE g_inbg2_d          DYNAMIC ARRAY OF type_g_inbg2_d
DEFINE g_inbg2_d_t        type_g_inbg2_d
DEFINE g_inbg2_d_o        type_g_inbg2_d
DEFINE g_inbg2_d_mask_o   DYNAMIC ARRAY OF type_g_inbg2_d #轉換遮罩前資料
DEFINE g_inbg2_d_mask_n   DYNAMIC ARRAY OF type_g_inbg2_d #轉換遮罩後資料
DEFINE g_inbg3_d          DYNAMIC ARRAY OF type_g_inbg3_d
DEFINE g_inbg3_d_t        type_g_inbg3_d
DEFINE g_inbg3_d_o        type_g_inbg3_d
DEFINE g_inbg3_d_mask_o   DYNAMIC ARRAY OF type_g_inbg3_d #轉換遮罩前資料
DEFINE g_inbg3_d_mask_n   DYNAMIC ARRAY OF type_g_inbg3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
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
 
{<section id="aint170.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   #SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site  #161124-00048#5  16/12/09 By 08734 mark
   SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,ooef005,ooef006,ooef007,ooef008,ooef009,ooef010,ooef011,ooef012,ooef013,ooefownid,ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,ooefmoddt,ooef014,ooef015,ooef016,ooef017,ooef018,ooef019,ooef020,ooef021,ooef022,ooef003,ooef023,ooef024,ooef025,ooef026,ooef100,ooef101,ooef102,ooef103,ooef104,ooef105,ooef106,ooef107,ooef108,ooef109,ooef110,ooef111,ooef112,ooef113,ooef114,ooef115,ooef120,ooef121,ooef122,ooef123,ooef124,ooef125,
       ooef150,ooef151,ooef152,ooef153,ooef154,ooef155,ooef156,ooef157,ooef158,ooef159,ooef160,ooef161,ooef162,ooef163,ooef164,ooef165,ooef166,ooef167,ooef168,ooef169,ooef170,ooef171,ooef172,ooef173,ooefunit,ooef200,ooef201,ooef202,ooef203,ooef204,ooef205,ooef206,ooef207,ooef208,ooef209,ooef210,ooef211,ooef212,ooef213,ooef214,ooef215,ooef216,ooef217,ooef301,ooef302,ooef303,ooef304,ooef305,ooef306,ooef307,ooef308,ooef309,ooef310,ooef126,ooef127,ooef128,ooef116 
      INTO g_ooef.* FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site  #161124-00048#5  16/12/09 By 08734 add
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint170'                            #160705-00042#7 160715 by sakura mark
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#7 160715 by sakura add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT inbfdocno,'',inbfdocdt,inbf001,'',inbf002,'',inbf003,'',inbf004,inbfsite, 
       inbfstus,inbfownid,'',inbfowndp,'',inbfcrtid,'',inbfcrtdp,'',inbfcrtdt,inbfmodid,'',inbfmoddt, 
       inbfcnfid,'',inbfcnfdt", 
                      " FROM inbf_t",
                      " WHERE inbfent= ? AND inbfdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint170_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inbfdocno,t0.inbfdocdt,t0.inbf001,t0.inbf002,t0.inbf003,t0.inbf004, 
       t0.inbfsite,t0.inbfstus,t0.inbfownid,t0.inbfowndp,t0.inbfcrtid,t0.inbfcrtdp,t0.inbfcrtdt,t0.inbfmodid, 
       t0.inbfmoddt,t0.inbfcnfid,t0.inbfcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooefl003 ,t7.ooag011 ,t8.ooag011",
               " FROM inbf_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inbf001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbf002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.inbfownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inbfowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.inbfcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.inbfcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.inbfmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inbfcnfid  ",
 
               " WHERE t0.inbfent = " ||g_enterprise|| " AND t0.inbfdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint170_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint170 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint170_init()   
 
      #進入選單 Menu (="N")
      CALL aint170_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint170
      
   END IF 
   
   CLOSE aint170_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint170.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint170_init()
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('inbfstus','13','N,Y,S,A,D,R,W,X')
 
      CALL cl_set_combo_scc('inbg001','2080') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"

   CALL cl_set_combo_scc('inbh001','2080')
   CALL cl_set_combo_scc('inao000','2091')
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN 
      CALL cl_set_comp_visible("inbg005,inbg005_desc,inbh005,inbh011",FALSE)
      CALL cl_set_combo_scc_part('inbh001','2080','2,3,4,5,6')
   END IF 
   #end add-point
   
   #初始化搜尋條件
   CALL aint170_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint170.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint170_ui_dialog()
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
            CALL aint170_insert()
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
         INITIALIZE g_inbf_m.* TO NULL
         CALL g_inbg_d.clear()
         CALL g_inbg2_d.clear()
         CALL g_inbg3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint170_init()
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
               
               CALL aint170_fetch('') # reload data
               LET l_ac = 1
               CALL aint170_ui_detailshow() #Setting the current row 
         
               CALL aint170_idx_chk()
               #NEXT FIELD inbgseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_inbg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint170_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL aint170_b_fill2('2')
CALL aint170_b_fill2('3')
 
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL cl_set_act_visible("set_change",TRUE)
               IF g_inbg_d[l_ac].inbg012 = 'N' THEN
                  CALL cl_set_act_visible("set_change",FALSE)
               END IF
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
               CALL aint170_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION set_change
            LET g_action_choice="set_change"
            IF cl_auth_chk_act("set_change") THEN
               
               #add-point:ON ACTION set_change name="menu.detail_show.page1.set_change"
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  CALL aint170_01(g_inbf_m.inbfdocno,g_inbg_d[l_ac].*)
               ELSE
                  CALL aint170_02(g_inbf_m.inbfdocno,g_inbg_d[l_ac].*)
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
             
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_inbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint170_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aint170_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第二階單身段落
         DISPLAY ARRAY g_inbg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint170_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aint170_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aint170_browser_fill("")
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
               CALL aint170_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint170_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint170_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint170_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint170_set_act_visible()   
            CALL aint170_set_act_no_visible()
            IF NOT (g_inbf_m.inbfdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " inbfent = " ||g_enterprise|| " AND",
                                  " inbfdocno = '", g_inbf_m.inbfdocno, "' "
 
               #填到對應位置
               CALL aint170_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "inbf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbg_t" 
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
               CALL aint170_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "inbf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbg_t" 
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
                  CALL aint170_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint170_fetch("F")
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
               CALL aint170_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint170_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint170_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint170_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint170_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint170_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint170_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint170_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint170_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint170_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint170_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_inbg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_inbg2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_inbg3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD inbgseq
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
               CALL aint170_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint170_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint170_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint170_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint170_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint170_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint170_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint170_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_inbf_m.inbfdocdt)
 
 
 
         
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
 
{<section id="aint170.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint170_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_slip            STRING
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
   LET l_wc = l_wc," AND inbfsite = '",g_site,"'"
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT inbfdocno ",
                      " FROM inbf_t ",
                      " ",
                      " LEFT JOIN inbg_t ON inbgent = inbfent AND inbfdocno = inbgdocno ", "  ",
                      #add-point:browser_fill段sql(inbg_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN inbh_t ON inbhent = inbfent AND inbgdocno = inbhdocno AND inbgseq = inbhseq", "  ",
                      #add-point:browser_fill段sql(inbh_t1) name="browser_fill.cnt.join.inbh_t1"
                      
                      #end add-point
 
                      " LEFT JOIN inao_t ON inaoent = inbfent AND inbgdocno = inaodocno AND inbgseq = inaoseq", "  ",
                      #add-point:browser_fill段sql(inao_t1) name="browser_fill.cnt.join.inao_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
                      " ",
 
 
                      " WHERE inbfent = " ||g_enterprise|| " AND inbgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("inbf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT inbfdocno ",
                      " FROM inbf_t ", 
                      "  ",
                      "  ",
                      " WHERE inbfent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("inbf_t")
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
      INITIALIZE g_inbf_m.* TO NULL
      CALL g_inbg_d.clear()        
      CALL g_inbg2_d.clear() 
      CALL g_inbg3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.inbfdocno,t0.inbfdocdt,t0.inbf001,t0.inbf002,t0.inbf003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbfstus,t0.inbfdocno,t0.inbfdocdt,t0.inbf001,t0.inbf002,t0.inbf003, 
          t1.ooag011 ,t2.ooefl003 ,t3.oocql004 ",
                  " FROM inbf_t t0",
                  "  ",
                  "  LEFT JOIN inbg_t ON inbgent = inbfent AND inbfdocno = inbgdocno ", "  ", 
                  #add-point:browser_fill段sql(inbg_t1) name="browser_fill.join.inbg_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN inbh_t ON inbhent = inbfent AND inbgdocno = inbhdocno AND inbgseq = inbhseq", "  ", 
                  #add-point:browser_fill段sql(inbh_t1) name="browser_fill.join.inbh_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN inao_t ON inaoent = inbfent AND inbgdocno = inaodocno AND inbgseq = inaoseq", "  ", 
                  #add-point:browser_fill段sql(inao_t1) name="browser_fill.join.inao_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
                  " ",
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inbf001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbf002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='305' AND t3.oocql002=t0.inbf003 AND t3.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.inbfent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("inbf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbfstus,t0.inbfdocno,t0.inbfdocdt,t0.inbf001,t0.inbf002,t0.inbf003, 
          t1.ooag011 ,t2.ooefl003 ,t3.oocql004 ",
                  " FROM inbf_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inbf001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbf002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='305' AND t3.oocql002=t0.inbf003 AND t3.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.inbfent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("inbf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY inbfdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"inbf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inbfdocno,g_browser[g_cnt].b_inbfdocdt, 
          g_browser[g_cnt].b_inbf001,g_browser[g_cnt].b_inbf002,g_browser[g_cnt].b_inbf003,g_browser[g_cnt].b_inbf001_desc, 
          g_browser[g_cnt].b_inbf002_desc,g_browser[g_cnt].b_inbf003_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL s_aooi200_get_slip(g_browser[g_cnt].b_inbfdocno) RETURNING g_success,l_slip
      CALL s_aooi200_get_slip_desc(l_slip) RETURNING g_browser[g_cnt].b_inbfdocno_desc
      DISPLAY BY NAME g_browser[g_cnt].b_inbfdocno_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_inbf003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '"||g_acc||"' AND oocql002=? AND oocql003='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_inbf003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_inbf003_desc
         #end add-point
      
         #遮罩相關處理
         CALL aint170_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_inbfdocno) THEN
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
 
{<section id="aint170.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint170_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_inbf_m.inbfdocno = g_browser[g_current_idx].b_inbfdocno   
 
   EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
       g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
       g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
       g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
       g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
   
   CALL aint170_inbf_t_mask()
   CALL aint170_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint170.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint170_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint170_ui_browser_refresh()
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
      IF g_browser[l_i].b_inbfdocno = g_inbf_m.inbfdocno 
 
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
 
{<section id="aint170.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint170_construct()
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
   INITIALIZE g_inbf_m.* TO NULL
   CALL g_inbg_d.clear()        
   CALL g_inbg2_d.clear() 
   CALL g_inbg3_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON inbfdocno,inbfdocno_desc,inbfdocdt,inbf001,inbf002,inbf003,inbf003_desc, 
          inbf004,inbfsite,inbfstus,inbfownid,inbfowndp,inbfcrtid,inbfcrtdp,inbfcrtdt,inbfmodid,inbfmoddt, 
          inbfcnfid,inbfcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inbfcrtdt>>----
         AFTER FIELD inbfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inbfmoddt>>----
         AFTER FIELD inbfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbfcnfdt>>----
         AFTER FIELD inbfcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbfpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfdocno
            #add-point:BEFORE FIELD inbfdocno name="construct.b.inbfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfdocno
            
            #add-point:AFTER FIELD inbfdocno name="construct.a.inbfdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfdocno
            #add-point:ON ACTION controlp INFIELD inbfdocno name="construct.c.inbfdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfdocno  #顯示到畫面上
            NEXT FIELD inbfdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfdocno_desc
            #add-point:BEFORE FIELD inbfdocno_desc name="construct.b.inbfdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfdocno_desc
            
            #add-point:AFTER FIELD inbfdocno_desc name="construct.a.inbfdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfdocno_desc
            #add-point:ON ACTION controlp INFIELD inbfdocno_desc name="construct.c.inbfdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfdocdt
            #add-point:BEFORE FIELD inbfdocdt name="construct.b.inbfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfdocdt
            
            #add-point:AFTER FIELD inbfdocdt name="construct.a.inbfdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfdocdt
            #add-point:ON ACTION controlp INFIELD inbfdocdt name="construct.c.inbfdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf001
            #add-point:ON ACTION controlp INFIELD inbf001 name="construct.c.inbf001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbf001  #顯示到畫面上
            NEXT FIELD inbf001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf001
            #add-point:BEFORE FIELD inbf001 name="construct.b.inbf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf001
            
            #add-point:AFTER FIELD inbf001 name="construct.a.inbf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf002
            #add-point:ON ACTION controlp INFIELD inbf002 name="construct.c.inbf002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbf002  #顯示到畫面上
            NEXT FIELD inbf002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf002
            #add-point:BEFORE FIELD inbf002 name="construct.b.inbf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf002
            
            #add-point:AFTER FIELD inbf002 name="construct.a.inbf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf003
            #add-point:ON ACTION controlp INFIELD inbf003 name="construct.c.inbf003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbf003  #顯示到畫面上
            NEXT FIELD inbf003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf003
            #add-point:BEFORE FIELD inbf003 name="construct.b.inbf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf003
            
            #add-point:AFTER FIELD inbf003 name="construct.a.inbf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf003_desc
            #add-point:BEFORE FIELD inbf003_desc name="construct.b.inbf003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf003_desc
            
            #add-point:AFTER FIELD inbf003_desc name="construct.a.inbf003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbf003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf003_desc
            #add-point:ON ACTION controlp INFIELD inbf003_desc name="construct.c.inbf003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf004
            #add-point:BEFORE FIELD inbf004 name="construct.b.inbf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf004
            
            #add-point:AFTER FIELD inbf004 name="construct.a.inbf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf004
            #add-point:ON ACTION controlp INFIELD inbf004 name="construct.c.inbf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfsite
            #add-point:BEFORE FIELD inbfsite name="construct.b.inbfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfsite
            
            #add-point:AFTER FIELD inbfsite name="construct.a.inbfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfsite
            #add-point:ON ACTION controlp INFIELD inbfsite name="construct.c.inbfsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfstus
            #add-point:BEFORE FIELD inbfstus name="construct.b.inbfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfstus
            
            #add-point:AFTER FIELD inbfstus name="construct.a.inbfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfstus
            #add-point:ON ACTION controlp INFIELD inbfstus name="construct.c.inbfstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfownid
            #add-point:ON ACTION controlp INFIELD inbfownid name="construct.c.inbfownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfownid  #顯示到畫面上
            NEXT FIELD inbfownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfownid
            #add-point:BEFORE FIELD inbfownid name="construct.b.inbfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfownid
            
            #add-point:AFTER FIELD inbfownid name="construct.a.inbfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfowndp
            #add-point:ON ACTION controlp INFIELD inbfowndp name="construct.c.inbfowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfowndp  #顯示到畫面上
            NEXT FIELD inbfowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfowndp
            #add-point:BEFORE FIELD inbfowndp name="construct.b.inbfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfowndp
            
            #add-point:AFTER FIELD inbfowndp name="construct.a.inbfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfcrtid
            #add-point:ON ACTION controlp INFIELD inbfcrtid name="construct.c.inbfcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfcrtid  #顯示到畫面上
            NEXT FIELD inbfcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfcrtid
            #add-point:BEFORE FIELD inbfcrtid name="construct.b.inbfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfcrtid
            
            #add-point:AFTER FIELD inbfcrtid name="construct.a.inbfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfcrtdp
            #add-point:ON ACTION controlp INFIELD inbfcrtdp name="construct.c.inbfcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfcrtdp  #顯示到畫面上
            NEXT FIELD inbfcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfcrtdp
            #add-point:BEFORE FIELD inbfcrtdp name="construct.b.inbfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfcrtdp
            
            #add-point:AFTER FIELD inbfcrtdp name="construct.a.inbfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfcrtdt
            #add-point:BEFORE FIELD inbfcrtdt name="construct.b.inbfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfmodid
            #add-point:ON ACTION controlp INFIELD inbfmodid name="construct.c.inbfmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfmodid  #顯示到畫面上
            NEXT FIELD inbfmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfmodid
            #add-point:BEFORE FIELD inbfmodid name="construct.b.inbfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfmodid
            
            #add-point:AFTER FIELD inbfmodid name="construct.a.inbfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfmoddt
            #add-point:BEFORE FIELD inbfmoddt name="construct.b.inbfmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbfcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfcnfid
            #add-point:ON ACTION controlp INFIELD inbfcnfid name="construct.c.inbfcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbfcnfid  #顯示到畫面上
            NEXT FIELD inbfcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfcnfid
            #add-point:BEFORE FIELD inbfcnfid name="construct.b.inbfcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfcnfid
            
            #add-point:AFTER FIELD inbfcnfid name="construct.a.inbfcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfcnfdt
            #add-point:BEFORE FIELD inbfcnfdt name="construct.b.inbfcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inbgseq,inbg001,inbg002,inbg003,inbg004,inbg005,inbg005_desc,inbg006, 
          inbg008,inbg007,inbg009,inbg010,inbg011,inbg031,inbg031_desc,inbg012,inbg032,inbgsite
           FROM s_detail1[1].inbgseq,s_detail1[1].inbg001,s_detail1[1].inbg002,s_detail1[1].inbg003, 
               s_detail1[1].inbg004,s_detail1[1].inbg005,s_detail1[1].inbg005_desc,s_detail1[1].inbg006, 
               s_detail1[1].inbg008,s_detail1[1].inbg007,s_detail1[1].inbg009,s_detail1[1].inbg010,s_detail1[1].inbg011, 
               s_detail1[1].inbg031,s_detail1[1].inbg031_desc,s_detail1[1].inbg012,s_detail1[1].inbg032, 
               s_detail1[1].inbgsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbgseq
            #add-point:BEFORE FIELD inbgseq name="construct.b.page1.inbgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbgseq
            
            #add-point:AFTER FIELD inbgseq name="construct.a.page1.inbgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbgseq
            #add-point:ON ACTION controlp INFIELD inbgseq name="construct.c.page1.inbgseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg001
            #add-point:BEFORE FIELD inbg001 name="construct.b.page1.inbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg001
            
            #add-point:AFTER FIELD inbg001 name="construct.a.page1.inbg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg001
            #add-point:ON ACTION controlp INFIELD inbg001 name="construct.c.page1.inbg001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg002
            #add-point:ON ACTION controlp INFIELD inbg002 name="construct.c.page1.inbg002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg002  #顯示到畫面上
            NEXT FIELD inbg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg002
            #add-point:BEFORE FIELD inbg002 name="construct.b.page1.inbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg002
            
            #add-point:AFTER FIELD inbg002 name="construct.a.page1.inbg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg003
            #add-point:ON ACTION controlp INFIELD inbg003 name="construct.c.page1.inbg003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg003  #顯示到畫面上
            NEXT FIELD inbg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg003
            #add-point:BEFORE FIELD inbg003 name="construct.b.page1.inbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg003
            
            #add-point:AFTER FIELD inbg003 name="construct.a.page1.inbg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg004
            #add-point:ON ACTION controlp INFIELD inbg004 name="construct.c.page1.inbg004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg004  #顯示到畫面上
            NEXT FIELD inbg004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg004
            #add-point:BEFORE FIELD inbg004 name="construct.b.page1.inbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg004
            
            #add-point:AFTER FIELD inbg004 name="construct.a.page1.inbg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg005
            #add-point:ON ACTION controlp INFIELD inbg005 name="construct.c.page1.inbg005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg005  #顯示到畫面上
            NEXT FIELD inbg005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg005
            #add-point:BEFORE FIELD inbg005 name="construct.b.page1.inbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg005
            
            #add-point:AFTER FIELD inbg005 name="construct.a.page1.inbg005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg005_desc
            #add-point:BEFORE FIELD inbg005_desc name="construct.b.page1.inbg005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg005_desc
            
            #add-point:AFTER FIELD inbg005_desc name="construct.a.page1.inbg005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg005_desc
            #add-point:ON ACTION controlp INFIELD inbg005_desc name="construct.c.page1.inbg005_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg006
            #add-point:ON ACTION controlp INFIELD inbg006 name="construct.c.page1.inbg006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg006  #顯示到畫面上
            NEXT FIELD inbg006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg006
            #add-point:BEFORE FIELD inbg006 name="construct.b.page1.inbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg006
            
            #add-point:AFTER FIELD inbg006 name="construct.a.page1.inbg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg008
            #add-point:ON ACTION controlp INFIELD inbg008 name="construct.c.page1.inbg008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg008  #顯示到畫面上
            NEXT FIELD inbg008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg008
            #add-point:BEFORE FIELD inbg008 name="construct.b.page1.inbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg008
            
            #add-point:AFTER FIELD inbg008 name="construct.a.page1.inbg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg007
            #add-point:ON ACTION controlp INFIELD inbg007 name="construct.c.page1.inbg007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg007  #顯示到畫面上
            NEXT FIELD inbg007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg007
            #add-point:BEFORE FIELD inbg007 name="construct.b.page1.inbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg007
            
            #add-point:AFTER FIELD inbg007 name="construct.a.page1.inbg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg009
            #add-point:ON ACTION controlp INFIELD inbg009 name="construct.c.page1.inbg009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inai007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg009  #顯示到畫面上
            NEXT FIELD inbg009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg009
            #add-point:BEFORE FIELD inbg009 name="construct.b.page1.inbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg009
            
            #add-point:AFTER FIELD inbg009 name="construct.a.page1.inbg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg010
            #add-point:ON ACTION controlp INFIELD inbg010 name="construct.c.page1.inbg010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inai008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg010  #顯示到畫面上
            NEXT FIELD inbg010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg010
            #add-point:BEFORE FIELD inbg010 name="construct.b.page1.inbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg010
            
            #add-point:AFTER FIELD inbg010 name="construct.a.page1.inbg010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg011
            #add-point:BEFORE FIELD inbg011 name="construct.b.page1.inbg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg011
            
            #add-point:AFTER FIELD inbg011 name="construct.a.page1.inbg011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg011
            #add-point:ON ACTION controlp INFIELD inbg011 name="construct.c.page1.inbg011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inbg011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg011  #顯示到畫面上
            NEXT FIELD inbg011
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg031
            #add-point:ON ACTION controlp INFIELD inbg031 name="construct.c.page1.inbg031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbg031  #顯示到畫面上
            NEXT FIELD inbg031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg031
            #add-point:BEFORE FIELD inbg031 name="construct.b.page1.inbg031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg031
            
            #add-point:AFTER FIELD inbg031 name="construct.a.page1.inbg031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg031_desc
            #add-point:BEFORE FIELD inbg031_desc name="construct.b.page1.inbg031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg031_desc
            
            #add-point:AFTER FIELD inbg031_desc name="construct.a.page1.inbg031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg031_desc
            #add-point:ON ACTION controlp INFIELD inbg031_desc name="construct.c.page1.inbg031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg012
            #add-point:BEFORE FIELD inbg012 name="construct.b.page1.inbg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg012
            
            #add-point:AFTER FIELD inbg012 name="construct.a.page1.inbg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg012
            #add-point:ON ACTION controlp INFIELD inbg012 name="construct.c.page1.inbg012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg032
            #add-point:BEFORE FIELD inbg032 name="construct.b.page1.inbg032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg032
            
            #add-point:AFTER FIELD inbg032 name="construct.a.page1.inbg032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg032
            #add-point:ON ACTION controlp INFIELD inbg032 name="construct.c.page1.inbg032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbgsite
            #add-point:BEFORE FIELD inbgsite name="construct.b.page1.inbgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbgsite
            
            #add-point:AFTER FIELD inbgsite name="construct.a.page1.inbgsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbgsite
            #add-point:ON ACTION controlp INFIELD inbgsite name="construct.c.page1.inbgsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON inbh001,inbh002,inbh003,inbh004,inbh005,inbh006,inbh008,inbh007,inbh011, 
          inbh012,inbh014,inbh013,inbh017
           FROM s_detail2[1].inbh001,s_detail2[1].inbh002,s_detail2[1].inbh003,s_detail2[1].inbh004, 
               s_detail2[1].inbh005,s_detail2[1].inbh006,s_detail2[1].inbh008,s_detail2[1].inbh007,s_detail2[1].inbh011, 
               s_detail2[1].inbh012,s_detail2[1].inbh014,s_detail2[1].inbh013,s_detail2[1].inbh017
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh001
            #add-point:BEFORE FIELD inbh001 name="construct.b.page2.inbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh001
            
            #add-point:AFTER FIELD inbh001 name="construct.a.page2.inbh001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh001
            #add-point:ON ACTION controlp INFIELD inbh001 name="construct.c.page2.inbh001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh002
            #add-point:BEFORE FIELD inbh002 name="construct.b.page2.inbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh002
            
            #add-point:AFTER FIELD inbh002 name="construct.a.page2.inbh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh002
            #add-point:ON ACTION controlp INFIELD inbh002 name="construct.c.page2.inbh002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh002  #顯示到畫面上
            NEXT FIELD inbh002  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh003
            #add-point:BEFORE FIELD inbh003 name="construct.b.page2.inbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh003
            
            #add-point:AFTER FIELD inbh003 name="construct.a.page2.inbh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh003
            #add-point:ON ACTION controlp INFIELD inbh003 name="construct.c.page2.inbh003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh003  #顯示到畫面上
            NEXT FIELD inbh003 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh004
            #add-point:BEFORE FIELD inbh004 name="construct.b.page2.inbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh004
            
            #add-point:AFTER FIELD inbh004 name="construct.a.page2.inbh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh004
            #add-point:ON ACTION controlp INFIELD inbh004 name="construct.c.page2.inbh004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh004  #顯示到畫面上
            NEXT FIELD inbh004  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh005
            #add-point:BEFORE FIELD inbh005 name="construct.b.page2.inbh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh005
            
            #add-point:AFTER FIELD inbh005 name="construct.a.page2.inbh005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh005
            #add-point:ON ACTION controlp INFIELD inbh005 name="construct.c.page2.inbh005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh005  #顯示到畫面上
            NEXT FIELD inbh005  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh006
            #add-point:BEFORE FIELD inbh006 name="construct.b.page2.inbh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh006
            
            #add-point:AFTER FIELD inbh006 name="construct.a.page2.inbh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh006
            #add-point:ON ACTION controlp INFIELD inbh006 name="construct.c.page2.inbh006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh006  #顯示到畫面上
            NEXT FIELD inbh006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh008
            #add-point:BEFORE FIELD inbh008 name="construct.b.page2.inbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh008
            
            #add-point:AFTER FIELD inbh008 name="construct.a.page2.inbh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh008
            #add-point:ON ACTION controlp INFIELD inbh008 name="construct.c.page2.inbh008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh008  #顯示到畫面上
            NEXT FIELD inbh008  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh007
            #add-point:BEFORE FIELD inbh007 name="construct.b.page2.inbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh007
            
            #add-point:AFTER FIELD inbh007 name="construct.a.page2.inbh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh007
            #add-point:ON ACTION controlp INFIELD inbh007 name="construct.c.page2.inbh007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh007  #顯示到畫面上
            NEXT FIELD inbh007 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh011
            #add-point:BEFORE FIELD inbh011 name="construct.b.page2.inbh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh011
            
            #add-point:AFTER FIELD inbh011 name="construct.a.page2.inbh011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh011
            #add-point:ON ACTION controlp INFIELD inbh011 name="construct.c.page2.inbh011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh011  #顯示到畫面上
            NEXT FIELD inbh011 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh012
            #add-point:BEFORE FIELD inbh012 name="construct.b.page2.inbh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh012
            
            #add-point:AFTER FIELD inbh012 name="construct.a.page2.inbh012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh012
            #add-point:ON ACTION controlp INFIELD inbh012 name="construct.c.page2.inbh012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh012  #顯示到畫面上
            NEXT FIELD inbh012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh014
            #add-point:BEFORE FIELD inbh014 name="construct.b.page2.inbh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh014
            
            #add-point:AFTER FIELD inbh014 name="construct.a.page2.inbh014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh014
            #add-point:ON ACTION controlp INFIELD inbh014 name="construct.c.page2.inbh014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh014  #顯示到畫面上
            NEXT FIELD inbh014 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh013
            #add-point:BEFORE FIELD inbh013 name="construct.b.page2.inbh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh013
            
            #add-point:AFTER FIELD inbh013 name="construct.a.page2.inbh013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh013
            #add-point:ON ACTION controlp INFIELD inbh013 name="construct.c.page2.inbh013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbh013  #顯示到畫面上
            NEXT FIELD inbh013 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbh017
            #add-point:BEFORE FIELD inbh017 name="construct.b.page2.inbh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbh017
            
            #add-point:AFTER FIELD inbh017 name="construct.a.page2.inbh017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbh017
            #add-point:ON ACTION controlp INFIELD inbh017 name="construct.c.page2.inbh017"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON NULL
           FROM NULL
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
          
       
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
                  WHEN la_wc[li_idx].tableid = "inbf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inbg_t" 
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint170_filter()
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
      CONSTRUCT g_wc_filter ON inbfdocno,inbfdocdt,inbf001,inbf002,inbf003
                          FROM s_browse[1].b_inbfdocno,s_browse[1].b_inbfdocdt,s_browse[1].b_inbf001, 
                              s_browse[1].b_inbf002,s_browse[1].b_inbf003
 
         BEFORE CONSTRUCT
               DISPLAY aint170_filter_parser('inbfdocno') TO s_browse[1].b_inbfdocno
            DISPLAY aint170_filter_parser('inbfdocdt') TO s_browse[1].b_inbfdocdt
            DISPLAY aint170_filter_parser('inbf001') TO s_browse[1].b_inbf001
            DISPLAY aint170_filter_parser('inbf002') TO s_browse[1].b_inbf002
            DISPLAY aint170_filter_parser('inbf003') TO s_browse[1].b_inbf003
      
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
 
      CALL aint170_filter_show('inbfdocno')
   CALL aint170_filter_show('inbfdocdt')
   CALL aint170_filter_show('inbf001')
   CALL aint170_filter_show('inbf002')
   CALL aint170_filter_show('inbf003')
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint170_filter_parser(ps_field)
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
 
{<section id="aint170.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint170_filter_show(ps_field)
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
   LET ls_condition = aint170_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint170_query()
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
   CALL g_inbg_d.clear()
   CALL g_inbg2_d.clear()
   CALL g_inbg3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint170_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint170_browser_fill("")
      CALL aint170_fetch("")
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aint170_filter_show('inbfdocno')
   CALL aint170_filter_show('inbfdocdt')
   CALL aint170_filter_show('inbf001')
   CALL aint170_filter_show('inbf002')
   CALL aint170_filter_show('inbf003')
   CALL aint170_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint170_fetch("F") 
      #顯示單身筆數
      CALL aint170_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint170_fetch(p_flag)
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
   CALL g_inbg2_d.clear()
   CALL g_inbg3_d.clear()
 
   
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
   
   LET g_inbf_m.inbfdocno = g_browser[g_current_idx].b_inbfdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
       g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
       g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
       g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
       g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
   
   #遮罩相關處理
   LET g_inbf_m_mask_o.* =  g_inbf_m.*
   CALL aint170_inbf_t_mask()
   LET g_inbf_m_mask_n.* =  g_inbf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint170_set_act_visible()   
   CALL aint170_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   CALL cl_set_act_visible("delete,modify,modify_detail,statechange",TRUE)
#   IF g_inbf_m.inbfstus = 'Y' OR g_inbf_m.inbfstus = 'X' THEN
#      CALL cl_set_act_visible("delete,modify,modify_detail,statechange",FALSE)
#   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_inbf_m_t.* = g_inbf_m.*
   LET g_inbf_m_o.* = g_inbf_m.*
   
   LET g_data_owner = g_inbf_m.inbfownid      
   LET g_data_dept  = g_inbf_m.inbfowndp
   
   #重新顯示   
   CALL aint170_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint170_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_inbg_d.clear()   
   CALL g_inbg2_d.clear()  
   CALL g_inbg3_d.clear()  
 
 
   INITIALIZE g_inbf_m.* TO NULL             #DEFAULT 設定
   
   LET g_inbfdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inbf_m.inbfownid = g_user
      LET g_inbf_m.inbfowndp = g_dept
      LET g_inbf_m.inbfcrtid = g_user
      LET g_inbf_m.inbfcrtdp = g_dept 
      LET g_inbf_m.inbfcrtdt = cl_get_current()
      LET g_inbf_m.inbfmodid = g_user
      LET g_inbf_m.inbfmoddt = cl_get_current()
      LET g_inbf_m.inbfstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inbf_m.inbfstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_inbf_m.inbfdocdt = g_today
      LET g_inbf_m.inbfsite = g_site
      LET g_inbf_m.inbf001 = g_user
      SELECT ooag003 INTO g_inbf_m.inbf002 FROM ooag_t
       WHERE ooag001 = g_inbf_m.inbf001 AND ooagent = g_enterprise
      CALL aint170_inbf001_desc()
      CALL aint170_inbf002_desc()
      LET g_inbf_m_t.* = g_inbf_m.*
      LET g_inbf_o.* = g_inbf_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_inbf_m_t.* = g_inbf_m.*
      LET g_inbf_m_o.* = g_inbf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbf_m.inbfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
 
 
 
    
      CALL aint170_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      IF INT_FLAG THEN
         IF NOT cl_null(l_ac) THEN
            IF aint170_inbh_exist() THEN
               DELETE FROM inbh_t WHERE inbhent = g_enterprise AND inbhdocno = g_inbf_m.inbfdocno AND inbhseq = g_inbg_d[l_ac].inbgseq
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            IF aint170_inao_exist() THEN
               DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbf_m.inbfdocno AND inaoseq = g_inbg_d[l_ac].inbgseq
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
         END IF
      END IF
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
         INITIALIZE g_inbf_m.* TO NULL
         INITIALIZE g_inbg_d TO NULL
         INITIALIZE g_inbg2_d TO NULL
         INITIALIZE g_inbg3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint170_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_inbg_d.clear()
      #CALL g_inbg2_d.clear()
      #CALL g_inbg3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint170_set_act_visible()   
   CALL aint170_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbfent = " ||g_enterprise|| " AND",
                      " inbfdocno = '", g_inbf_m.inbfdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint170_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint170_cl
   
   CALL aint170_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
       g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
       g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
       g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
       g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
   
   
   #遮罩相關處理
   LET g_inbf_m_mask_o.* =  g_inbf_m.*
   CALL aint170_inbf_t_mask()
   LET g_inbf_m_mask_n.* =  g_inbf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocno_desc,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002,g_inbf_m.inbf002_desc,g_inbf_m.inbf003,g_inbf_m.inbf003_desc,g_inbf_m.inbf004, 
       g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp, 
       g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtid_desc,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdp_desc, 
       g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid, 
       g_inbf_m.inbfcnfid_desc,g_inbf_m.inbfcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_inbf_m.inbfownid      
   LET g_data_dept  = g_inbf_m.inbfowndp
   
   #功能已完成,通報訊息中心
   CALL aint170_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint170_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_inbf_m_t.* = g_inbf_m.*
   LET g_inbf_m_o.* = g_inbf_m.*
   
   IF g_inbf_m.inbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
   CALL s_transaction_begin()
   
   OPEN aint170_cl USING g_enterprise,g_inbf_m.inbfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint170_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint170_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
       g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
       g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
       g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
       g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aint170_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inbf_m_mask_o.* =  g_inbf_m.*
   CALL aint170_inbf_t_mask()
   LET g_inbf_m_mask_n.* =  g_inbf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
   
   CALL aint170_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
    
   WHILE TRUE
      LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_inbf_m.inbfmodid = g_user 
LET g_inbf_m.inbfmoddt = cl_get_current()
LET g_inbf_m.inbfmodid_desc = cl_get_username(g_inbf_m.inbfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_inbf_m_t.* = g_inbf_m.*
      IF g_inbf_m.inbfstus MATCHES "[DR]" THEN 
         LET g_inbf_m.inbfstus = "N"
      END IF

      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint170_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      IF INT_FLAG THEN
         IF NOT cl_null(l_ac) THEN
            IF aint170_inbh_exist() THEN
               DELETE FROM inbh_t WHERE inbhent = g_enterprise AND inbhdocno = g_inbf_m.inbfdocno AND inbhseq = g_inbg_d[l_ac].inbgseq
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            IF aint170_inao_exist() THEN
               DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbf_m.inbfdocno AND inaoseq = g_inbg_d[l_ac].inbgseq
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
         END IF
      END IF
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE inbf_t SET (inbfmodid,inbfmoddt) = (g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt)
          WHERE inbfent = g_enterprise AND inbfdocno = g_inbfdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_inbf_m.* = g_inbf_m_t.*
            CALL aint170_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_inbf_m.inbfdocno != g_inbf_m_t.inbfdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE inbg_t SET inbgdocno = g_inbf_m.inbfdocno
 
          WHERE inbgent = g_enterprise AND inbgdocno = g_inbf_m_t.inbfdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inbg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         UPDATE inbh_t
            SET inbhdocno = g_inbf_m.inbfdocno
 
          WHERE inbhent = g_enterprise AND
                inbhdocno = g_inbfdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbh_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         UPDATE inao_t
            SET inaodocno = g_inbf_m.inbfdocno
 
          WHERE inaoent = g_enterprise AND
                inaodocno = g_inbfdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inao_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint170_set_act_visible()   
   CALL aint170_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inbfent = " ||g_enterprise|| " AND",
                      " inbfdocno = '", g_inbf_m.inbfdocno, "' "
 
   #填到對應位置
   CALL aint170_browser_fill("")
 
   CLOSE aint170_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint170_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint170.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint170_input(p_cmd)
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
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_date                LIKE type_t.dat
   DEFINE  l_sql1                STRING     #160711-00040#15 add
   DEFINE  l_success             LIKE type_t.num5  #160711-00040#15 add
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
   DISPLAY BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocno_desc,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002,g_inbf_m.inbf002_desc,g_inbf_m.inbf003,g_inbf_m.inbf003_desc,g_inbf_m.inbf004, 
       g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp, 
       g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtid_desc,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdp_desc, 
       g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid, 
       g_inbf_m.inbfcnfid_desc,g_inbf_m.inbfcnfdt
   
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
   LET g_forupd_sql = "SELECT inbgseq,inbg001,inbg002,inbg003,inbg004,inbg005,inbg006,inbg008,inbg007, 
       inbg009,inbg010,inbg011,inbg031,inbg012,inbg032,inbgsite FROM inbg_t WHERE inbgent=? AND inbgdocno=?  
       AND inbgseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint170_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inbhseq,inbhseq1,inbh001,inbh002,inbh003,inbh004,inbh005,inbh006,inbh008, 
       inbh007,inbh011,inbh012,inbh014,inbh013,inbh017 FROM inbh_t WHERE inbhent=? AND inbhdocno=? AND  
       inbhseq=? AND inbhseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint170_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inaoseq1,inaoseq2,inao000,inao001,inao005,inao006,inao008,inao009,inao012, 
       inao013,inao014 FROM inao_t WHERE inaoent=? AND inaodocno=? AND inaoseq=? AND inaoseq1=? AND  
       inaoseq2=? AND inao000=? AND inao013=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint170_bcl3 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint170_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aint170_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003, 
       g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint170.input.head" >}
      #單頭段
      INPUT BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003, 
          g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint170_cl USING g_enterprise,g_inbf_m.inbfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint170_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint170_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint170_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aint170_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfdocno
            
            #add-point:AFTER FIELD inbfdocno name="input.a.inbfdocno"
            CALL s_aooi200_get_slip_desc(g_inbf_m.inbfdocno) RETURNING g_inbf_m.inbfdocno_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inbf_m.inbfdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inbf_m.inbfdocno != g_inbfdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbf_t WHERE "||"inbfent = '" ||g_enterprise|| "' AND "||"inbfdocno = '"||g_inbf_m.inbfdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #IF NOT s_aooi200_chk_slip(g_site,'',g_inbf_m.inbfdocno,'aint170') THEN #160613-00038#1 mark
               IF NOT s_aooi200_chk_slip(g_site,'',g_inbf_m.inbfdocno,g_prog) THEN     #160613-00038#1 add
                  LET g_inbf_m.inbfdocno = g_inbf_m_t.inbfdocno
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfdocno
            #add-point:BEFORE FIELD inbfdocno name="input.b.inbfdocno"
            CALL s_aooi200_get_slip_desc(g_inbf_m.inbfdocno) RETURNING g_inbf_m.inbfdocno_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbfdocno
            #add-point:ON CHANGE inbfdocno name="input.g.inbfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfdocdt
            #add-point:BEFORE FIELD inbfdocdt name="input.b.inbfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfdocdt
            
            #add-point:AFTER FIELD inbfdocdt name="input.a.inbfdocdt"
            
            IF NOT cl_null(g_inbf_m.inbfdocdt) THEN
               CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_date
               IF g_inbf_m.inbfdocdt < l_date THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00077'
                  LET g_errparam.extend =g_inbf_m.inbfdocdt||" < "||l_date
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_inbf_m.inbfdocdt = g_inbf_m_t.inbfdocdt
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbfdocdt
            #add-point:ON CHANGE inbfdocdt name="input.g.inbfdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf001
            
            #add-point:AFTER FIELD inbf001 name="input.a.inbf001"
            CALL aint170_inbf001_desc()
            IF NOT cl_null(g_inbf_m.inbf001) THEN 
               IF g_inbf_m.inbf001 != g_inbf_m_o.inbf001 OR cl_null(g_inbf_m_o.inbf001) THEN   #160824-00007#276 161223 by lori add
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbf_m.inbf001
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#18  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                    #LET g_inbf_m.inbf001 = g_inbf_m_t.inbf001   #160824-00007#276 161223 by lori mark
                     LET g_inbf_m.inbf001 = g_inbf_m_o.inbf001   #160824-00007#276 161223 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  
                 #IF (p_cmd = 'a' AND g_inbf_m.inbf001 != g_inbf_o.inbf001) OR (p_cmd = 'u' AND g_inbf_m.inbf001 != g_inbf_m_t.inbf001) THEN   #160824-00007#276 161223 by lori mark
                     SELECT ooag003 INTO g_inbf_m.inbf002 FROM ooag_t
                      WHERE ooag001 = g_inbf_m.inbf001 AND ooagent = g_enterprise
                 #END IF   #160824-00007#276 161223 by lori mark
               END IF      #160824-00007#276 161223 by lori add   
            END IF
            
           #LET g_inbf_o.inbf001 = g_inbf_m.inbf001     #160824-00007#276 161223 by lori mark
            LET g_inbf_m_o.inbf001 = g_inbf_m.inbf001   #160824-00007#276 161223 by lori add
            LET g_inbf_m_o.inbf002 = g_inbf_m.inbf002   #160824-00007#276 161223 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf001
            #add-point:BEFORE FIELD inbf001 name="input.b.inbf001"
            CALL aint170_inbf001_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbf001
            #add-point:ON CHANGE inbf001 name="input.g.inbf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf002
            
            #add-point:AFTER FIELD inbf002 name="input.a.inbf002"
            CALL aint170_inbf002_desc()
            IF NOT cl_null(g_inbf_m.inbf002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbf_m.inbf002
               LET g_chkparam.arg2 = g_inbf_m.inbfdocdt
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#19  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_inbf_m.inbf002 = g_inbf_m_t.inbf002
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf002
            #add-point:BEFORE FIELD inbf002 name="input.b.inbf002"
            CALL aint170_inbf002_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbf002
            #add-point:ON CHANGE inbf002 name="input.g.inbf002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf003
            
            #add-point:AFTER FIELD inbf003 name="input.a.inbf003"
            CALL aint170_inbf003_desc()
            IF NOT cl_null(g_inbf_m.inbf003) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_inbf_m.inbf003) THEN
                  LET g_inbf_m.inbf003 = g_inbf_m_t.inbf003
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf003
            #add-point:BEFORE FIELD inbf003 name="input.b.inbf003"
            CALL aint170_inbf003_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbf003
            #add-point:ON CHANGE inbf003 name="input.g.inbf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbf004
            #add-point:BEFORE FIELD inbf004 name="input.b.inbf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbf004
            
            #add-point:AFTER FIELD inbf004 name="input.a.inbf004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbf004
            #add-point:ON CHANGE inbf004 name="input.g.inbf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfsite
            #add-point:BEFORE FIELD inbfsite name="input.b.inbfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfsite
            
            #add-point:AFTER FIELD inbfsite name="input.a.inbfsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbfsite
            #add-point:ON CHANGE inbfsite name="input.g.inbfsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbfstus
            #add-point:BEFORE FIELD inbfstus name="input.b.inbfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbfstus
            
            #add-point:AFTER FIELD inbfstus name="input.a.inbfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbfstus
            #add-point:ON CHANGE inbfstus name="input.g.inbfstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inbfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfdocno
            #add-point:ON ACTION controlp INFIELD inbfdocno name="input.c.inbfdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbf_m.inbfdocno            #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef.ooef004 #
            #LET g_qryparam.arg2 = "aint170"     #160705-00042#3 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#3 160711 by sakura add

            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_inbf_m.inbfdocno  = g_qryparam.return1              

            DISPLAY g_inbf_m.inbfdocno  TO inbfdocno             #

            NEXT FIELD inbfdocno 
            #END add-point
 
 
         #Ctrlp:input.c.inbfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfdocdt
            #add-point:ON ACTION controlp INFIELD inbfdocdt name="input.c.inbfdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf001
            #add-point:ON ACTION controlp INFIELD inbf001 name="input.c.inbf001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbf_m.inbf001             #給予default值

            #給予arg
            
            CALL q_ooag001()                                #呼叫開窗

            LET g_inbf_m.inbf001 = g_qryparam.return1              

            DISPLAY g_inbf_m.inbf001 TO inbf001              #

            NEXT FIELD inbf001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf002
            #add-point:ON ACTION controlp INFIELD inbf002 name="input.c.inbf002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbf_m.inbf002             #給予default值
 
            LET g_qryparam.arg1 = g_inbf_m.inbfdocdt

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_inbf_m.inbf002 = g_qryparam.return1              
            #LET g_inbf_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_inbf_m.inbf002 TO inbf002              #
            #DISPLAY g_inbf_m.ooeg001 TO ooeg001 #部門編號
            NEXT FIELD inbf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf003
            #add-point:ON ACTION controlp INFIELD inbf003 name="input.c.inbf003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbf_m.inbf003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_acc #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_inbf_m.inbf003 = g_qryparam.return1              

            DISPLAY g_inbf_m.inbf003 TO inbf003              #

            NEXT FIELD inbf003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbf004
            #add-point:ON ACTION controlp INFIELD inbf004 name="input.c.inbf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfsite
            #add-point:ON ACTION controlp INFIELD inbfsite name="input.c.inbfsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbfstus
            #add-point:ON ACTION controlp INFIELD inbfstus name="input.c.inbfstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_inbf_m.inbfdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #CALL s_aooi200_gen_docno(g_site,g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt,'aint170') RETURNING g_success,g_inbf_m.inbfdocno #160613-00038#1 mark
               CALL s_aooi200_gen_docno(g_site,g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt,g_prog) RETURNING g_success,g_inbf_m.inbfdocno     #160613-00038#1 add
               IF NOT g_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_inbf_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               CALL aint170_set_entry(p_cmd)
               CALL aint170_set_no_entry(p_cmd)
               #end add-point
               
               INSERT INTO inbf_t (inbfent,inbfdocno,inbfdocdt,inbf001,inbf002,inbf003,inbf004,inbfsite, 
                   inbfstus,inbfownid,inbfowndp,inbfcrtid,inbfcrtdp,inbfcrtdt,inbfmodid,inbfmoddt,inbfcnfid, 
                   inbfcnfdt)
               VALUES (g_enterprise,g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf002, 
                   g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid, 
                   g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid, 
                   g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_inbf_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aint170_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint170_b_fill()
                  CALL aint170_b_fill2('0')
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
               CALL aint170_inbf_t_mask_restore('restore_mask_o')
               
               UPDATE inbf_t SET (inbfdocno,inbfdocdt,inbf001,inbf002,inbf003,inbf004,inbfsite,inbfstus, 
                   inbfownid,inbfowndp,inbfcrtid,inbfcrtdp,inbfcrtdt,inbfmodid,inbfmoddt,inbfcnfid,inbfcnfdt) = (g_inbf_m.inbfdocno, 
                   g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004, 
                   g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid, 
                   g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid, 
                   g_inbf_m.inbfcnfdt)
                WHERE inbfent = g_enterprise AND inbfdocno = g_inbfdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inbf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint170_inbf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_inbf_m_t)
               LET g_log2 = util.JSON.stringify(g_inbf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint170.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_inbg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inbg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint170_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_inbg_d.getLength()
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
            CALL aint170_b_fill2('2')
CALL aint170_b_fill2('3')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aint170_cl USING g_enterprise,g_inbf_m.inbfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint170_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint170_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inbg_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inbg_d[l_ac].inbgseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inbg_d_t.* = g_inbg_d[l_ac].*  #BACKUP
               LET g_inbg_d_o.* = g_inbg_d[l_ac].*  #BACKUP
               CALL aint170_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL aint170_detail_required()
               #end add-point  
               CALL aint170_set_no_entry_b(l_cmd)
               IF NOT aint170_lock_b("inbg_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint170_bcl INTO g_inbg_d[l_ac].inbgseq,g_inbg_d[l_ac].inbg001,g_inbg_d[l_ac].inbg002, 
                      g_inbg_d[l_ac].inbg003,g_inbg_d[l_ac].inbg004,g_inbg_d[l_ac].inbg005,g_inbg_d[l_ac].inbg006, 
                      g_inbg_d[l_ac].inbg008,g_inbg_d[l_ac].inbg007,g_inbg_d[l_ac].inbg009,g_inbg_d[l_ac].inbg010, 
                      g_inbg_d[l_ac].inbg011,g_inbg_d[l_ac].inbg031,g_inbg_d[l_ac].inbg012,g_inbg_d[l_ac].inbg032, 
                      g_inbg_d[l_ac].inbgsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inbg_d_t.inbgseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inbg_d_mask_o[l_ac].* =  g_inbg_d[l_ac].*
                  CALL aint170_inbg_t_mask()
                  LET g_inbg_d_mask_n[l_ac].* =  g_inbg_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint170_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
#            CALL aint170_detail_required()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inbg_d[l_ac].* TO NULL 
            INITIALIZE g_inbg_d_t.* TO NULL 
            INITIALIZE g_inbg_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_inbg_d[l_ac].inbg001 = "1"
      LET g_inbg_d[l_ac].inbg012 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_inbg_d_t.* = g_inbg_d[l_ac].*     #新輸入資料
            LET g_inbg_d_o.* = g_inbg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint170_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint170_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inbg_d[li_reproduce_target].* = g_inbg_d[li_reproduce].*
 
               LET g_inbg_d[li_reproduce_target].inbgseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(inbgseq) + 1  INTO g_inbg_d[l_ac].inbgseq FROM inbg_t
             WHERE inbgent = g_enterprise AND inbgdocno = g_inbf_m.inbfdocno
            IF cl_null(g_inbg_d[l_ac].inbgseq) THEN LET g_inbg_d[l_ac].inbgseq = 1 END IF
            IF NOT cl_null(g_inbf_m.inbf003) THEN LET g_inbg_d[l_ac].inbg031 = g_inbf_m.inbf003 END IF
            CALL aint170_inbg031_desc()
            LET g_inbg_d[l_ac].inbgsite = g_site
            CALL aint170_detail_required()
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

            #151228-00010#1 add start
           #IF NOT aint170_detail_exists() THEN   #161121-00004#1 mark
           #   CANCEL INSERT                      #161121-00004#1 mark
           #END IF                                #161121-00004#1 mark
            #151228-00010#1 add end

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM inbg_t 
             WHERE inbgent = g_enterprise AND inbgdocno = g_inbf_m.inbfdocno
 
               AND inbgseq = g_inbg_d[l_ac].inbgseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbf_m.inbfdocno
               LET gs_keys[2] = g_inbg_d[g_detail_idx].inbgseq
               CALL aint170_insert_b('inbg_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_inbg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint170_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF NOT aint170_inbh_exist() THEN
                  CALL aint170_inbh_ins()
               END IF
               IF NOT aint170_inao_exist() THEN
                  IF aint170_chk_pxh_exists() THEN
                     CALL aint170_inao_ins()
                  END IF
               END IF
               CALL aint170_b_fill2('2')
               DISPLAY ARRAY g_inbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) 
                  BEFORE DISPLAY 
                     EXIT DISPLAY
               END DISPLAY 
               CALL aint170_b_fill2('3')
               DISPLAY ARRAY g_inbg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) 
                  BEFORE DISPLAY 
                     EXIT DISPLAY
               END DISPLAY 
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
               LET gs_keys[01] = g_inbf_m.inbfdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_inbg_d_t.inbgseq
 
            
               #刪除同層單身
               IF NOT aint170_delete_b('inbg_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint170_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint170_key_delete_b(gs_keys,'inbg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint170_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               DELETE FROM inbh_t WHERE inbhent = g_enterprise AND inbhdocno = g_inbf_m.inbfdocno AND inbhseq = g_inbg_d[l_ac].inbgseq
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inbg_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE 
               END IF
               DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbf_m.inbfdocno AND inaoseq = g_inbg_d[l_ac].inbgseq
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inao_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE 
               END IF
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint170_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  
               #end add-point
               LET l_count = g_inbg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inbg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbgseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbg_d[l_ac].inbgseq,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD inbgseq
            END IF 
 
 
 
            #add-point:AFTER FIELD inbgseq name="input.a.page1.inbgseq"
            IF NOT cl_null(g_inbg_d[l_ac].inbgseq) THEN 
            END IF 


            #此段落由子樣板a05產生
            IF  g_inbf_m.inbfdocno IS NOT NULL AND g_inbg_d[g_detail_idx].inbgseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbf_m.inbfdocno != g_inbfdocno_t OR g_inbg_d[g_detail_idx].inbgseq != g_inbg_d_t.inbgseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbg_t WHERE "||"inbgent = '" ||g_enterprise|| "' AND "||"inbgdocno = '"||g_inbf_m.inbfdocno ||"' AND "|| "inbgseq = '"||g_inbg_d[g_detail_idx].inbgseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbgseq
            #add-point:BEFORE FIELD inbgseq name="input.b.page1.inbgseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbgseq
            #add-point:ON CHANGE inbgseq name="input.g.page1.inbgseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg001
            #add-point:BEFORE FIELD inbg001 name="input.b.page1.inbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg001
            
            #add-point:AFTER FIELD inbg001 name="input.a.page1.inbg001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg001
            #add-point:ON CHANGE inbg001 name="input.g.page1.inbg001"
            IF NOT aint170_inbg001_inbg002_chk(l_cmd) THEN
               LET g_inbg_d[l_ac].inbg001 = g_inbg_d_t.inbg001
               NEXT FIELD CURRENT
            END IF
            IF l_cmd = 'u' AND g_inbg_d[l_ac].inbg001 != g_inbg_d_t.inbg001 THEN
               INITIALIZE g_inbg_d[l_ac].inbg011 TO NULL
               DISPLAY BY NAME g_inbg_d[l_ac].inbg011
            END IF
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT aint170_inag_chk_exist() THEN
                  LET g_inbg_d[l_ac].inbg001 = g_inbg_d_t.inbg001
                  NEXT FIELD CURRENT
               END IF
            ELSE
               IF NOT aint170_inai_chk_exist() THEN
                  LET g_inbg_d[l_ac].inbg001 = g_inbg_d_t.inbg001
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aint170_detail_required()
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg002
            
            #add-point:AFTER FIELD inbg002 name="input.a.page1.inbg002"
            CALL aint170_inbg002_desc()
            IF g_inbg_d[l_ac].inbg002 IS NOT NULL THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_imaf001_1") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
#                  NEXT FIELD CURRENT
#               END IF
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('4',g_inbf_m.inbfdocno,g_inbg_d[l_ac].inbg002,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_control_chk_doc('5',g_inbf_m.inbfdocno,g_inbg_d[l_ac].inbg002,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
                  NEXT FIELD CURRENT
               END IF
    
            END IF 
            #141222-00014 #13 mark
#            IF NOT aint170_inbg002_exist() THEN
#               LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
#               NEXT FIELD CURRENT
#            END IF
            #141222-00014 #13 mark
            IF NOT aint170_inbg001_inbg002_chk(l_cmd) THEN
               LET g_inbg_d[l_ac].inbg002 = g_inbg_d_t.inbg002
               NEXT FIELD CURRENT
            END IF
            CALL aint170_set_entry_b(l_cmd)
            CALL aint170_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg002
            #add-point:BEFORE FIELD inbg002 name="input.b.page1.inbg002"
            CALL aint170_inbg002_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg002
            #add-point:ON CHANGE inbg002 name="input.g.page1.inbg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg003
            
            #add-point:AFTER FIELD inbg003 name="input.a.page1.inbg003"
            CALL aint170_inbg003_desc()
            IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg003
#               IF NOT cl_chk_exist("v_inaa001_2") THEN
#                  LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
#                  NEXT FIELD CURRENT
#               END IF
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('6',g_inbf_m.inbfdocno,g_inbg_d[l_ac].inbg003,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
                  NEXT FIELD CURRENT
               END IF
               #160729-00013#1-s
               CALL s_control_chk_doc('1',g_inbf_m.inbfdocno,'5',g_user,g_dept,'','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbg_d[l_ac].inbg003 = g_inbg_d_t.inbg003
                  NEXT FIELD CURRENT
               END IF               
               #160729-00013#1-e
            END IF
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg003
            #add-point:BEFORE FIELD inbg003 name="input.b.page1.inbg003"
            CALL aint170_inbg003_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg003
            #add-point:ON CHANGE inbg003 name="input.g.page1.inbg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg004
            
            #add-point:AFTER FIELD inbg004 name="input.a.page1.inbg004"
            CALL aint170_inbg004_desc()
            IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = g_site
#               LET g_chkparam.arg2 = g_inbg_d[l_ac].inbg003
#               LET g_chkparam.arg3 = g_inbg_d[l_ac].inbg004
#               IF NOT cl_chk_exist("v_inab002_1") THEN
#                  LET g_inbg_d[l_ac].inbg004 = g_inbg_d_t.inbg004
#                  NEXT FIELD CURRENT
#               END IF
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg004 = g_inbg_d_t.inbg004
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg004 = g_inbg_d_t.inbg004
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_inbg_d[l_ac].inbg003) THEN
                  CALL s_control_chk_doc('6',g_inbf_m.inbfdocno,g_inbg_d[l_ac].inbg003,g_inbg_d[l_ac].inbg004,'','','') RETURNING g_success,l_flag
                  IF g_success THEN
                     IF NOT l_flag THEN
                        LET g_inbg_d[l_ac].inbg004 = g_inbg_d_t.inbg004
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET g_inbg_d[l_ac].inbg004 = g_inbg_d_t.inbg004
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg004
            #add-point:BEFORE FIELD inbg004 name="input.b.page1.inbg004"
            CALL aint170_inbg004_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg004
            #add-point:ON CHANGE inbg004 name="input.g.page1.inbg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg005
            
            #add-point:AFTER FIELD inbg005 name="input.a.page1.inbg005"
            CALL s_feature_description(g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg005) RETURNING g_success,g_inbg_d[l_ac].inbg005_desc
            IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg005 = g_inbg_d_t.inbg005
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg005 = g_inbg_d_t.inbg005
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #151224-00025#1 tsungyung --- add start ---
               IF NOT s_feature_direct_input(g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg005,g_inbg_d_t.inbg005,g_inbf_m.inbfdocno,g_inbf_m.inbfsite) THEN
                  NEXT FIELD CURRENT
               END IF   
               #151224-00025#1 tsungyung --- add end   ---               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg005
            #add-point:BEFORE FIELD inbg005 name="input.b.page1.inbg005"
            CALL s_feature_description(g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg005) RETURNING g_success,g_inbg_d[l_ac].inbg005_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg005
            #add-point:ON CHANGE inbg005 name="input.g.page1.inbg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg005_desc
            #add-point:BEFORE FIELD inbg005_desc name="input.b.page1.inbg005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg005_desc
            
            #add-point:AFTER FIELD inbg005_desc name="input.a.page1.inbg005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg005_desc
            #add-point:ON CHANGE inbg005_desc name="input.g.page1.inbg005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg006
            #add-point:BEFORE FIELD inbg006 name="input.b.page1.inbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg006
            
            #add-point:AFTER FIELD inbg006 name="input.a.page1.inbg006"

            IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg006 = g_inbg_d_t.inbg006
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg006 = g_inbg_d_t.inbg006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg006
            #add-point:ON CHANGE inbg006 name="input.g.page1.inbg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg008
            #add-point:BEFORE FIELD inbg008 name="input.b.page1.inbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg008
            
            #add-point:AFTER FIELD inbg008 name="input.a.page1.inbg008"
            IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg008 = g_inbg_d_t.inbg008
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg008 = g_inbg_d_t.inbg008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg008
            #add-point:ON CHANGE inbg008 name="input.g.page1.inbg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg007
            #add-point:BEFORE FIELD inbg007 name="input.b.page1.inbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg007
            
            #add-point:AFTER FIELD inbg007 name="input.a.page1.inbg007"
            IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg007 = g_inbg_d_t.inbg007
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg007 = g_inbg_d_t.inbg007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg007
            #add-point:ON CHANGE inbg007 name="input.g.page1.inbg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg009
            #add-point:BEFORE FIELD inbg009 name="input.b.page1.inbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg009
            
            #add-point:AFTER FIELD inbg009 name="input.a.page1.inbg009"
            IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg009 = g_inbg_d_t.inbg009
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg009 = g_inbg_d_t.inbg009
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg009
            #add-point:ON CHANGE inbg009 name="input.g.page1.inbg009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg010
            #add-point:BEFORE FIELD inbg010 name="input.b.page1.inbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg010
            
            #add-point:AFTER FIELD inbg010 name="input.a.page1.inbg010"
            IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
               IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
                  IF NOT aint170_inag_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg010 = g_inbg_d_t.inbg010
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT aint170_inai_chk_exist() THEN
                     LET g_inbg_d[l_ac].inbg010 = g_inbg_d_t.inbg010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg010
            #add-point:ON CHANGE inbg010 name="input.g.page1.inbg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg011
            #add-point:BEFORE FIELD inbg011 name="input.b.page1.inbg011"
#            IF cl_null(g_inbg_d[l_ac].inbg011) AND g_inbg_d[l_ac].inbg001 = '1' THEN   #160314-00009#9  16/03/25 By zhujing marked
            IF cl_null(g_inbg_d[l_ac].inbg011) AND g_inbg_d[l_ac].inbg001 = '1' AND s_feature_auto_chk(g_inbg_d[l_ac].inbg002) THEN #160314-00009#9  16/03/25 By zhujing add
               CALL s_feature_single(g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg011,g_site,'') 
                    RETURNING g_success,g_inbg_d[l_ac].inbg011
               DISPLAY BY NAME g_inbg_d[l_ac].inbg011
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg011
            
            #add-point:AFTER FIELD inbg011 name="input.a.page1.inbg011"
            IF NOT cl_null(g_inbg_d[l_ac].inbg011) AND NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
               IF g_inbg_d[l_ac].inbg001 = '3' THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
                  LET g_chkparam.arg2 = g_inbg_d[l_ac].inbg011
                 # LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg011
                  #IF NOT cl_chk_exist("v_ooca001") THEN
                   IF NOT cl_chk_exist("v_imao002") THEN   #160318-00003#1
                     LET g_inbg_d[l_ac].inbg011 = g_inbg_d_t.inbg011
                     NEXT FIELD CURRENT
                  END IF
               END IF              
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg011
            #add-point:ON CHANGE inbg011 name="input.g.page1.inbg011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg031
            
            #add-point:AFTER FIELD inbg031 name="input.a.page1.inbg031"
            CALL aint170_inbg031_desc()
            IF NOT cl_null(g_inbg_d[l_ac].inbg031) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_inbg_d[l_ac].inbg031) THEN
                  LET g_inbg_d[l_ac].inbg031 = g_inbg_d_t.inbg031
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg031
            #add-point:BEFORE FIELD inbg031 name="input.b.page1.inbg031"
            CALL aint170_inbg031_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg031
            #add-point:ON CHANGE inbg031 name="input.g.page1.inbg031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg031_desc
            #add-point:BEFORE FIELD inbg031_desc name="input.b.page1.inbg031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg031_desc
            
            #add-point:AFTER FIELD inbg031_desc name="input.a.page1.inbg031_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg031_desc
            #add-point:ON CHANGE inbg031_desc name="input.g.page1.inbg031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg012
            #add-point:BEFORE FIELD inbg012 name="input.b.page1.inbg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg012
            
            #add-point:AFTER FIELD inbg012 name="input.a.page1.inbg012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg012
            #add-point:ON CHANGE inbg012 name="input.g.page1.inbg012"
            IF NOT cl_null(g_inbg_d[l_ac].inbg012) THEN
               IF g_inbg_d[l_ac].inbg012 = 'Y' THEN
                  IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN 
                     CALL aint170_01(g_inbf_m.inbfdocno,g_inbg_d[l_ac].*)
                  ELSE
                     CALL aint170_02(g_inbf_m.inbfdocno,g_inbg_d[l_ac].*)
                  END IF
  
               ELSE
                  DELETE FROM inbh_t WHERE inbhent = g_enterprise AND inbhdocno = g_inbf_m.inbfdocno AND inbhseq = g_inbg_d[l_ac].inbgseq
                  DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbf_m.inbfdocno AND inaoseq = g_inbg_d[l_ac].inbgseq
                  CALL aint170_inbh_ins()
                  IF aint170_chk_pxh_exists() THEN
                     CALL aint170_inao_ins()
                  END IF
               END IF
            END IF
            CALL aint170_b_fill2('2')
            DISPLAY ARRAY g_inbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) 
               BEFORE DISPLAY 
                  EXIT DISPLAY
            END DISPLAY 
            CALL aint170_b_fill2('3')
            DISPLAY ARRAY g_inbg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) 
               BEFORE DISPLAY 
                  EXIT DISPLAY
            END DISPLAY 
            CALL s_transaction_begin()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbg032
            #add-point:BEFORE FIELD inbg032 name="input.b.page1.inbg032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbg032
            
            #add-point:AFTER FIELD inbg032 name="input.a.page1.inbg032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbg032
            #add-point:ON CHANGE inbg032 name="input.g.page1.inbg032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbgsite
            #add-point:BEFORE FIELD inbgsite name="input.b.page1.inbgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbgsite
            
            #add-point:AFTER FIELD inbgsite name="input.a.page1.inbgsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbgsite
            #add-point:ON CHANGE inbgsite name="input.g.page1.inbgsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbgseq
            #add-point:ON ACTION controlp INFIELD inbgseq name="input.c.page1.inbgseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg001
            #add-point:ON ACTION controlp INFIELD inbg001 name="input.c.page1.inbg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg002
            #add-point:ON ACTION controlp INFIELD inbg002 name="input.c.page1.inbg002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg002             #給予default值
           
            #給予arg
            LET g_qryparam.where = " 1=1"  
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inag001()                                #呼叫開窗
            ELSE           
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
              
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inai001()
            END IF
            LET g_inbg_d[l_ac].inbg002 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg002 TO inbg002              #

            NEXT FIELD inbg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg003
            #add-point:ON ACTION controlp INFIELD inbg003 name="input.c.page1.inbg003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg003             #給予default值
            LET g_qryparam.default2 = g_inbg_d[l_ac].inbg004 
            #給予arg
            LET g_qryparam.where = " 1=1"
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               
              #CALL q_inag004_4()                                #呼叫開窗
               LET g_qryparam.where = g_qryparam.where," AND inag008 > 0"
               CALL q_inag004()
            ELSE
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
                     
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
              #CALL q_inai004()
               CALL q_inai004_1()
            END IF
            LET g_inbg_d[l_ac].inbg003 = g_qryparam.return1              
          # LET g_inbg_d[l_ac].inbg004 = g_qryparam.return2 
            DISPLAY g_inbg_d[l_ac].inbg003 TO inbg003              #
          # DISPLAY g_inbg_d[l_ac].inbg004 TO inbg004 #儲位編號
          # CALL aint170_inbg004_desc()
            NEXT FIELD inbg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg004
            #add-point:ON ACTION controlp INFIELD inbg004 name="input.c.page1.inbg004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg004             #給予default值

            #給予arg
            LET g_qryparam.where = " 1=1"
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
                       
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               
               CALL q_inag005_6()                                #呼叫開窗
            ELSE
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
                  
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inai005()
            END IF
            LET g_inbg_d[l_ac].inbg004 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg004 TO inbg004              #

            NEXT FIELD inbg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg005
            #add-point:ON ACTION controlp INFIELD inbg005 name="input.c.page1.inbg005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg005             #給予default值

            #給予arg

            LET g_qryparam.where = " 1=1"
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inag002()                                #呼叫開窗
            ELSE
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
                      
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inai002()
            END IF
            LET g_inbg_d[l_ac].inbg005 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg005 TO inbg005              #

            NEXT FIELD inbg005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg005_desc
            #add-point:ON ACTION controlp INFIELD inbg005_desc name="input.c.page1.inbg005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg006
            #add-point:ON ACTION controlp INFIELD inbg006 name="input.c.page1.inbg006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg006             #給予default值

            #給予arg

            LET g_qryparam.where = " 1=1"
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inag003_1()                                #呼叫開窗
            ELSE
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
                           
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inai003()
            END IF
            LET g_inbg_d[l_ac].inbg006 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg006 TO inbg006              #

            NEXT FIELD inbg006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg008
            #add-point:ON ACTION controlp INFIELD inbg008 name="input.c.page1.inbg008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg008             #給予default值

            #給予arg

            LET g_qryparam.where = " 1=1"
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               CALL q_inag007()                                #呼叫開窗
            ELSE
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               CALL q_inai009()
            END IF
            LET g_inbg_d[l_ac].inbg008 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg008 TO inbg008              #

            NEXT FIELD inbg008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg007
            #add-point:ON ACTION controlp INFIELD inbg007 name="input.c.page1.inbg007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg007             #給予default值

            #給予arg

            LET g_qryparam.where = " 1=1"
            IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inag006_1()                                #呼叫開窗
            ELSE
               IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
               END IF
                        
               IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
               END IF
               
               IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
                  LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
               END IF
               CALL q_inai006_1()
            END IF
            LET g_inbg_d[l_ac].inbg007 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg007 TO inbg007              #

            NEXT FIELD inbg007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg009
            #add-point:ON ACTION controlp INFIELD inbg009 name="input.c.page1.inbg009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg009             #給予default值

            #給予arg
            LET g_qryparam.where = " 1=1"
            IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
               LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
            END IF
            CALL q_inai007()                                #呼叫開窗

            LET g_inbg_d[l_ac].inbg009 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg009 TO inbg009              #

            NEXT FIELD inbg009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg010
            #add-point:ON ACTION controlp INFIELD inbg010 name="input.c.page1.inbg010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg010             #給予default值

            #給予arg
            LET g_qryparam.where = " 1=1"
            IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
               LET g_qryparam.where = g_qryparam.where," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
            END IF
            
            IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
            END IF
            CALL q_inai008()                                #呼叫開窗

            LET g_inbg_d[l_ac].inbg010 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg010 TO inbg010              #

            NEXT FIELD inbg010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg011
            #add-point:ON ACTION controlp INFIELD inbg011 name="input.c.page1.inbg011"
            CASE g_inbg_d[l_ac].inbg001 
               WHEN '1'
                  CALL s_feature_single(g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg011,g_site,'') RETURNING g_success,g_inbg_d[l_ac].inbg011
               WHEN '3'
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
		          
                  LET g_qryparam.default1 = g_inbg_d[l_ac].inbg011             #給予default值
		          
                  #給予arg
                 # CALL q_ooca001_1()                                #呼叫開窗
                  
                  LET g_qryparam.arg1 = g_inbg_d[l_ac].inbg002  #160318-00003#1 add
		            CALL q_imao002()  #160318-00003#1 add
                  LET g_inbg_d[l_ac].inbg011 = g_qryparam.return1  
            END CASE
                        

            DISPLAY g_inbg_d[l_ac].inbg011 TO inbg011              #

#            NEXT FIELD inbg011      #160314-00009#9  16/03/25 By zhujing marked
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg031
            #add-point:ON ACTION controlp INFIELD inbg031 name="input.c.page1.inbg031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbg_d[l_ac].inbg031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_acc #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_inbg_d[l_ac].inbg031 = g_qryparam.return1              

            DISPLAY g_inbg_d[l_ac].inbg031 TO inbg031              #

            NEXT FIELD inbg031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg031_desc
            #add-point:ON ACTION controlp INFIELD inbg031_desc name="input.c.page1.inbg031_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg012
            #add-point:ON ACTION controlp INFIELD inbg012 name="input.c.page1.inbg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbg032
            #add-point:ON ACTION controlp INFIELD inbg032 name="input.c.page1.inbg032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbgsite
            #add-point:ON ACTION controlp INFIELD inbgsite name="input.c.page1.inbgsite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inbg_d[l_ac].* = g_inbg_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint170_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inbg_d[l_ac].inbgseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inbg_d[l_ac].* = g_inbg_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"

               #141222-00014#13 add start
             # IF NOT aint170_detail_exists() THEN  #161121-00004#1 mark
             #    CALL s_transaction_end('N','0')   #161121-00004#1 mark
             #    EXIT DIALOG                       #161121-00004#1 mark
             # END IF                               #161121-00004#1 mark
              #141222-00014#13 add end 
 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint170_inbg_t_mask_restore('restore_mask_o')
      
               UPDATE inbg_t SET (inbgdocno,inbgseq,inbg001,inbg002,inbg003,inbg004,inbg005,inbg006, 
                   inbg008,inbg007,inbg009,inbg010,inbg011,inbg031,inbg012,inbg032,inbgsite) = (g_inbf_m.inbfdocno, 
                   g_inbg_d[l_ac].inbgseq,g_inbg_d[l_ac].inbg001,g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg003, 
                   g_inbg_d[l_ac].inbg004,g_inbg_d[l_ac].inbg005,g_inbg_d[l_ac].inbg006,g_inbg_d[l_ac].inbg008, 
                   g_inbg_d[l_ac].inbg007,g_inbg_d[l_ac].inbg009,g_inbg_d[l_ac].inbg010,g_inbg_d[l_ac].inbg011, 
                   g_inbg_d[l_ac].inbg031,g_inbg_d[l_ac].inbg012,g_inbg_d[l_ac].inbg032,g_inbg_d[l_ac].inbgsite) 
 
                WHERE inbgent = g_enterprise AND inbgdocno = g_inbf_m.inbfdocno 
 
                  AND inbgseq = g_inbg_d_t.inbgseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inbg_d[l_ac].* = g_inbg_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inbg_d[l_ac].* = g_inbg_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbf_m.inbfdocno
               LET gs_keys_bak[1] = g_inbfdocno_t
               LET gs_keys[2] = g_inbg_d[g_detail_idx].inbgseq
               LET gs_keys_bak[2] = g_inbg_d_t.inbgseq
               CALL aint170_update_b('inbg_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint170_inbg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_inbg_d[g_detail_idx].inbgseq = g_inbg_d_t.inbgseq 
 
                  ) THEN
                  LET gs_keys[01] = g_inbf_m.inbfdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_inbg_d_t.inbgseq
 
                  CALL aint170_key_update_b(gs_keys,'inbg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inbf_m),util.JSON.stringify(g_inbg_d_t)
               LET g_log2 = util.JSON.stringify(g_inbf_m),util.JSON.stringify(g_inbg_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT aint170_detail_change() THEN   
                  DELETE FROM inbh_t WHERE inbhent = g_enterprise AND inbhdocno = g_inbf_m.inbfdocno AND inbhseq = g_inbg_d[l_ac].inbgseq
                  DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbf_m.inbfdocno AND inaoseq = g_inbg_d[l_ac].inbgseq
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inbg_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_inbg_d[l_ac].* = g_inbg_d_t.*                     
                     CALL s_transaction_end('N','0')
                  END IF
                  IF g_inbg_d[l_ac].inbg012 = 'Y' THEN  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00190'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                  END IF
                  CALL aint170_inbh_ins()
                  IF aint170_chk_pxh_exists() THEN
                     CALL aint170_inao_ins()
                  END IF
                  CALL aint170_b_fill2('2')
                  DISPLAY ARRAY g_inbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) 
                     BEFORE DISPLAY 
                        EXIT DISPLAY
                  END DISPLAY 
                  CALL aint170_b_fill2('3')
                  DISPLAY ARRAY g_inbg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) 
                     BEFORE DISPLAY 
                        EXIT DISPLAY
                  END DISPLAY 
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #151228-00010#1 mark start
#            IF l_cmd !='d' THEN
#               IF NOT aint170_detail_exists() THEN
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
            #151228-00010#1 mark end
            #end add-point
            CALL aint170_unlock_b("inbg_t","'1'")
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
               LET g_inbg_d[li_reproduce_target].* = g_inbg_d[li_reproduce].*
 
               LET g_inbg_d[li_reproduce_target].inbgseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inbg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inbg_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
      DISPLAY ARRAY g_inbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL aint170_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx2 = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL aint170_idx_chk()
            LET g_current_page = 2
      
         #自訂ACTION(detail_show,page_2)
         
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_inbg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL aint170_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx2 = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL aint170_idx_chk()
            LET g_current_page = 3
      
         #自訂ACTION(detail_show,page_3)
         
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
{</section>}
 
{<section id="aint170.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD inbfdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inbgseq
               WHEN "s_detail2"
                  NEXT FIELD inbhseq
               WHEN "s_detail3"
                  NEXT FIELD inaoseq1
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint170_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_slip    STRING
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint170_b_fill() #單身填充
      CALL aint170_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint170_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            IF NOT cl_null(g_inbf_m.inbfdocno) THEN
               CALL s_aooi200_get_slip(g_inbf_m.inbfdocno) RETURNING g_success,l_slip
               CALL s_aooi200_get_slip_desc(l_slip) RETURNING g_inbf_m.inbfdocno_desc
            END IF
            DISPLAY BY NAME g_inbf_m.inbfdocno_desc

#            CALL aint170_inbf001_desc()
#            CALL aint170_inbf002_desc()
            CALL aint170_inbf003_desc()
            


#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbf_m.inbfownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbf_m.inbfownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbf_m.inbfownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbf_m.inbfowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inbf_m.inbfowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbf_m.inbfowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbf_m.inbfcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbf_m.inbfcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbf_m.inbfcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbf_m.inbfcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inbf_m.inbfcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbf_m.inbfcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbf_m.inbfmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbf_m.inbfmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbf_m.inbfmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbf_m.inbfcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbf_m.inbfcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbf_m.inbfcnfid_desc

         

   #end add-point
   
   #遮罩相關處理
   LET g_inbf_m_mask_o.* =  g_inbf_m.*
   CALL aint170_inbf_t_mask()
   LET g_inbf_m_mask_n.* =  g_inbf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocno_desc,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002,g_inbf_m.inbf002_desc,g_inbf_m.inbf003,g_inbf_m.inbf003_desc,g_inbf_m.inbf004, 
       g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp, 
       g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtid_desc,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdp_desc, 
       g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid, 
       g_inbf_m.inbfcnfid_desc,g_inbf_m.inbfcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbf_m.inbfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
   FOR l_ac = 1 TO g_inbg_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
             CALL s_feature_description(g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg005) RETURNING g_success,g_inbg_d[l_ac].inbg005_desc
#            CALL aint170_inbg002_desc()
#
#            CALL aint170_inbg003_desc()
#            
#            CALL aint170_inbg004_desc()
            CALL aint170_inbg031_desc()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_inbg2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inbg2_d[l_ac].inbh002
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inbg2_d[l_ac].inbh002_desc = '', g_rtn_fields[1] , ''
      LET g_inbg2_d[l_ac].inbh002_desc_1 = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inbg2_d[l_ac].inbh002_desc,g_inbg2_d[l_ac].inbh002_desc_1
      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_inbg2_d[l_ac].inbh003
#      CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#      LET g_inbg2_d[l_ac].inbh003_desc = '', g_rtn_fields[1] , ''
      CALL s_desc_get_stock_desc(g_site,g_inbg2_d[l_ac].inbh003) RETURNING g_inbg2_d[l_ac].inbh003_desc
      DISPLAY BY NAME g_inbg2_d[l_ac].inbh003_desc
     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inbg2_d[l_ac].inbh003
      LET g_ref_fields[2] = g_inbg2_d[l_ac].inbh004
      CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
      LET g_inbg2_d[l_ac].inbh004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inbg2_d[l_ac].inbh004_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_inbg3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inbg3_d[l_ac].inao001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inbg3_d[l_ac].inao001_desc = '', g_rtn_fields[1] , ''
      LET g_inbg3_d[l_ac].inao001_desc_1 = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inbg3_d[l_ac].inao001_desc,g_inbg3_d[l_ac].inao001_desc_1
      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_inbg3_d[l_ac].inao005
#      CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#      LET g_inbg3_d[l_ac].inao005_desc = '', g_rtn_fields[1] , ''
      CALL s_desc_get_stock_desc(g_site,g_inbg3_d[l_ac].inao005) RETURNING g_inbg3_d[l_ac].inao005_desc
      DISPLAY BY NAME g_inbg3_d[l_ac].inao005_desc
     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inbg3_d[l_ac].inao005
      LET g_ref_fields[2] = g_inbg3_d[l_ac].inao006
      CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
      LET g_inbg3_d[l_ac].inao006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inbg3_d[l_ac].inao006_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint170_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint170_detail_show()
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
 
{<section id="aint170.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint170_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE inbf_t.inbfdocno 
   DEFINE l_oldno     LIKE inbf_t.inbfdocno 
 
   DEFINE l_master    RECORD LIKE inbf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE inbg_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE inbh_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE inao_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_inbf_m.inbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
    
   LET g_inbf_m.inbfdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inbf_m.inbfownid = g_user
      LET g_inbf_m.inbfowndp = g_dept
      LET g_inbf_m.inbfcrtid = g_user
      LET g_inbf_m.inbfcrtdp = g_dept 
      LET g_inbf_m.inbfcrtdt = cl_get_current()
      LET g_inbf_m.inbfmodid = g_user
      LET g_inbf_m.inbfmoddt = cl_get_current()
      LET g_inbf_m.inbfstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_inbf_m.inbf001 = g_user
   SELECT ooag003 INTO g_inbf_m.inbf002 FROM ooag_t
    WHERE ooag001 = g_inbf_m.inbf001 AND ooagent = g_enterprise
   LET g_inbf_m.inbfdocdt = g_today
   CALL aint170_inbf001_desc()
   CALL aint170_inbf002_desc()
   LET g_inbf_m_t.* = g_inbf_m.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbf_m.inbfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      LET g_inbf_m.inbfdocno_desc = ''
   DISPLAY BY NAME g_inbf_m.inbfdocno_desc
 
   
   CALL aint170_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_inbf_m.* TO NULL
      INITIALIZE g_inbg_d TO NULL
      INITIALIZE g_inbg2_d TO NULL
      INITIALIZE g_inbg3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint170_show()
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
   CALL aint170_set_act_visible()   
   CALL aint170_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbfent = " ||g_enterprise|| " AND",
                      " inbfdocno = '", g_inbf_m.inbfdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint170_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint170_idx_chk()
   
   LET g_data_owner = g_inbf_m.inbfownid      
   LET g_data_dept  = g_inbf_m.inbfowndp
   
   #功能已完成,通報訊息中心
   CALL aint170_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint170_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE inbg_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE inbh_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE inao_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint170_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbg_t
    WHERE inbgent = g_enterprise AND inbgdocno = g_inbfdocno_t
 
    INTO TEMP aint170_detail
 
   #將key修正為調整後   
   UPDATE aint170_detail 
      #更新key欄位
      SET inbgdocno = g_inbf_m.inbfdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO inbg_t SELECT * FROM aint170_detail
   
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
   DROP TABLE aint170_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbh_t 
    WHERE inbhent = g_enterprise AND inbhdocno = g_inbfdocno_t
 
    INTO TEMP aint170_detail
 
   #將key修正為調整後   
   UPDATE aint170_detail SET inbhdocno = g_inbf_m.inbfdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO inbh_t SELECT * FROM aint170_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint170_detail
   
   LET g_data_owner = g_inbf_m.inbfownid      
   LET g_data_dept  = g_inbf_m.inbfowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inao_t 
    WHERE inaoent = g_enterprise AND inaodocno = g_inbfdocno_t
 
    INTO TEMP aint170_detail
 
   #將key修正為調整後   
   UPDATE aint170_detail SET inaodocno = g_inbf_m.inbfdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO inao_t SELECT * FROM aint170_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint170_detail
   
   LET g_data_owner = g_inbf_m.inbfownid      
   LET g_data_dept  = g_inbf_m.inbfowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint170_delete()
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
   
   IF g_inbf_m.inbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint170_cl USING g_enterprise,g_inbf_m.inbfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint170_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint170_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
       g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
       g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
       g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
       g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aint170_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inbf_m_mask_o.* =  g_inbf_m.*
   CALL aint170_inbf_t_mask()
   LET g_inbf_m_mask_n.* =  g_inbf_m.*
   
   CALL aint170_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint170_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_inbfdocno_t = g_inbf_m.inbfdocno
 
 
      DELETE FROM inbf_t
       WHERE inbfent = g_enterprise AND inbfdocno = g_inbf_m.inbfdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inbf_m.inbfdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM inbg_t
       WHERE inbgent = g_enterprise AND inbgdocno = g_inbf_m.inbfdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      IF NOT s_aooi200_del_docno(g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM inbh_t
       WHERE inbhent = g_enterprise AND
             inbhdocno = g_inbf_m.inbfdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise AND
             inaodocno = g_inbf_m.inbfdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inbf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint170_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_inbg_d.clear() 
      CALL g_inbg2_d.clear()       
      CALL g_inbg3_d.clear()       
 
     
      CALL aint170_ui_browser_refresh()  
      #CALL aint170_ui_headershow()  
      #CALL aint170_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint170_browser_fill("")
         CALL aint170_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint170_cl
 
   #功能已完成,通報訊息中心
   CALL aint170_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint170.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint170_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_inbg_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint170_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inbgseq,inbg001,inbg002,inbg003,inbg004,inbg005,inbg006,inbg008, 
             inbg007,inbg009,inbg010,inbg011,inbg031,inbg012,inbg032,inbgsite ,t1.imaal003 ,t2.imaal004 , 
             t3.inayl003 ,t4.inab003 FROM inbg_t",   
                     " INNER JOIN inbf_t ON inbfent = " ||g_enterprise|| " AND inbfdocno = inbgdocno ",
 
                     #"",
                     " LEFT JOIN inbh_t ON inbgent = inbhent AND inbgdocno = inbhdocno AND inbgseq = inbhseq ",
               " LEFT JOIN inao_t ON inbgent = inaoent AND inbgdocno = inaodocno AND inbgseq = inaoseq ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
                     " ",
 
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=inbg002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=inbg002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t3 ON t3.inaylent="||g_enterprise||" AND t3.inayl001=inbg003 AND t3.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t4 ON t4.inabent="||g_enterprise||" AND t4.inabsite=inbgsite AND t4.inab001=inbg003 AND t4.inab002=inbg004  ",
 
                     " WHERE inbgent=? AND inbgdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
   IF NOT cl_null(g_wc2_table3) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table3 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY inbg_t.inbgseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint170_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint170_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_inbf_m.inbfdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_inbf_m.inbfdocno INTO g_inbg_d[l_ac].inbgseq,g_inbg_d[l_ac].inbg001, 
          g_inbg_d[l_ac].inbg002,g_inbg_d[l_ac].inbg003,g_inbg_d[l_ac].inbg004,g_inbg_d[l_ac].inbg005, 
          g_inbg_d[l_ac].inbg006,g_inbg_d[l_ac].inbg008,g_inbg_d[l_ac].inbg007,g_inbg_d[l_ac].inbg009, 
          g_inbg_d[l_ac].inbg010,g_inbg_d[l_ac].inbg011,g_inbg_d[l_ac].inbg031,g_inbg_d[l_ac].inbg012, 
          g_inbg_d[l_ac].inbg032,g_inbg_d[l_ac].inbgsite,g_inbg_d[l_ac].inbg002_desc,g_inbg_d[l_ac].inbg002_desc_desc, 
          g_inbg_d[l_ac].inbg003_desc,g_inbg_d[l_ac].inbg004_desc   #(ver:78)
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
   
   CALL g_inbg_d.deleteElement(g_inbg_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint170_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inbg_d.getLength()
      LET g_inbg_d_mask_o[l_ac].* =  g_inbg_d[l_ac].*
      CALL aint170_inbg_t_mask()
      LET g_inbg_d_mask_n[l_ac].* =  g_inbg_d[l_ac].*
   END FOR
   
   LET g_inbg2_d_mask_o.* =  g_inbg2_d.*
   FOR l_ac = 1 TO g_inbg2_d.getLength()
      LET g_inbg2_d_mask_o[l_ac].* =  g_inbg2_d[l_ac].*
      CALL aint170_inbh_t_mask()
      LET g_inbg2_d_mask_n[l_ac].* =  g_inbg2_d[l_ac].*
   END FOR
   LET g_inbg3_d_mask_o.* =  g_inbg3_d.*
   FOR l_ac = 1 TO g_inbg3_d.getLength()
      LET g_inbg3_d_mask_o[l_ac].* =  g_inbg3_d[l_ac].*
      CALL aint170_inao_t_mask()
      LET g_inbg3_d_mask_n[l_ac].* =  g_inbg3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint170_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM inbg_t
       WHERE inbgent = g_enterprise AND
         inbgdocno = ps_keys_bak[1] AND inbgseq = ps_keys_bak[2]
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
         CALL g_inbg_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM inbh_t
       WHERE inbhent = g_enterprise AND
             inbhdocno = ps_keys_bak[1] AND inbhseq = ps_keys_bak[2] AND inbhseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_inbg2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise AND
             inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2] AND inaoseq1 = ps_keys_bak[3] AND inaoseq2 = ps_keys_bak[4] AND inao000 = ps_keys_bak[5] AND inao013 = ps_keys_bak[6]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_inbg3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint170_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO inbg_t
                  (inbgent,
                   inbgdocno,
                   inbgseq
                   ,inbg001,inbg002,inbg003,inbg004,inbg005,inbg006,inbg008,inbg007,inbg009,inbg010,inbg011,inbg031,inbg012,inbg032,inbgsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inbg_d[g_detail_idx].inbg001,g_inbg_d[g_detail_idx].inbg002,g_inbg_d[g_detail_idx].inbg003, 
                       g_inbg_d[g_detail_idx].inbg004,g_inbg_d[g_detail_idx].inbg005,g_inbg_d[g_detail_idx].inbg006, 
                       g_inbg_d[g_detail_idx].inbg008,g_inbg_d[g_detail_idx].inbg007,g_inbg_d[g_detail_idx].inbg009, 
                       g_inbg_d[g_detail_idx].inbg010,g_inbg_d[g_detail_idx].inbg011,g_inbg_d[g_detail_idx].inbg031, 
                       g_inbg_d[g_detail_idx].inbg012,g_inbg_d[g_detail_idx].inbg032,g_inbg_d[g_detail_idx].inbgsite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inbg_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO inbh_t
                  (inbhent,
                   inbhdocno,inbhseq,
                   inbhseq1
                   ,inbh001,inbh002,inbh003,inbh004,inbh005,inbh006,inbh008,inbh007,inbh011,inbh012,inbh014,inbh013,inbh017) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_inbg2_d[g_detail_idx2].inbh001,g_inbg2_d[g_detail_idx2].inbh002,g_inbg2_d[g_detail_idx2].inbh003, 
                       g_inbg2_d[g_detail_idx2].inbh004,g_inbg2_d[g_detail_idx2].inbh005,g_inbg2_d[g_detail_idx2].inbh006, 
                       g_inbg2_d[g_detail_idx2].inbh008,g_inbg2_d[g_detail_idx2].inbh007,g_inbg2_d[g_detail_idx2].inbh011, 
                       g_inbg2_d[g_detail_idx2].inbh012,g_inbg2_d[g_detail_idx2].inbh014,g_inbg2_d[g_detail_idx2].inbh013, 
                       g_inbg2_d[g_detail_idx2].inbh017)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_inbg2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO inao_t
                  (inaoent,
                   inaodocno,inaoseq,
                   inaoseq1,inaoseq2,inao000,inao013
                   ,inao001,inao005,inao006,inao008,inao009,inao012,inao014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6]
                   ,g_inbg3_d[g_detail_idx2].inao001,g_inbg3_d[g_detail_idx2].inao005,g_inbg3_d[g_detail_idx2].inao006, 
                       g_inbg3_d[g_detail_idx2].inao008,g_inbg3_d[g_detail_idx2].inao009,g_inbg3_d[g_detail_idx2].inao012, 
                       g_inbg3_d[g_detail_idx2].inao014)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_inbg3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint170_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint170_inbg_t_mask_restore('restore_mask_o')
               
      UPDATE inbg_t 
         SET (inbgdocno,
              inbgseq
              ,inbg001,inbg002,inbg003,inbg004,inbg005,inbg006,inbg008,inbg007,inbg009,inbg010,inbg011,inbg031,inbg012,inbg032,inbgsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inbg_d[g_detail_idx].inbg001,g_inbg_d[g_detail_idx].inbg002,g_inbg_d[g_detail_idx].inbg003, 
                  g_inbg_d[g_detail_idx].inbg004,g_inbg_d[g_detail_idx].inbg005,g_inbg_d[g_detail_idx].inbg006, 
                  g_inbg_d[g_detail_idx].inbg008,g_inbg_d[g_detail_idx].inbg007,g_inbg_d[g_detail_idx].inbg009, 
                  g_inbg_d[g_detail_idx].inbg010,g_inbg_d[g_detail_idx].inbg011,g_inbg_d[g_detail_idx].inbg031, 
                  g_inbg_d[g_detail_idx].inbg012,g_inbg_d[g_detail_idx].inbg032,g_inbg_d[g_detail_idx].inbgsite)  
 
         WHERE inbgent = g_enterprise AND inbgdocno = ps_keys_bak[1] AND inbgseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint170_inbg_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL aint170_inbh_t_mask_restore('restore_mask_o')
               
      UPDATE inbh_t 
         SET (inbhdocno,inbhseq,
              inbhseq1
              ,inbh001,inbh002,inbh003,inbh004,inbh005,inbh006,inbh008,inbh007,inbh011,inbh012,inbh014,inbh013,inbh017) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_inbg2_d[g_detail_idx2].inbh001,g_inbg2_d[g_detail_idx2].inbh002,g_inbg2_d[g_detail_idx2].inbh003, 
                  g_inbg2_d[g_detail_idx2].inbh004,g_inbg2_d[g_detail_idx2].inbh005,g_inbg2_d[g_detail_idx2].inbh006, 
                  g_inbg2_d[g_detail_idx2].inbh008,g_inbg2_d[g_detail_idx2].inbh007,g_inbg2_d[g_detail_idx2].inbh011, 
                  g_inbg2_d[g_detail_idx2].inbh012,g_inbg2_d[g_detail_idx2].inbh014,g_inbg2_d[g_detail_idx2].inbh013, 
                  g_inbg2_d[g_detail_idx2].inbh017) 
         WHERE inbhent = g_enterprise AND inbhdocno = ps_keys_bak[1] AND inbhseq = ps_keys_bak[2] AND inbhseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint170_inbh_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inao_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL aint170_inao_t_mask_restore('restore_mask_o')
               
      UPDATE inao_t 
         SET (inaodocno,inaoseq,
              inaoseq1,inaoseq2,inao000,inao013
              ,inao001,inao005,inao006,inao008,inao009,inao012,inao014) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6]
              ,g_inbg3_d[g_detail_idx2].inao001,g_inbg3_d[g_detail_idx2].inao005,g_inbg3_d[g_detail_idx2].inao006, 
                  g_inbg3_d[g_detail_idx2].inao008,g_inbg3_d[g_detail_idx2].inao009,g_inbg3_d[g_detail_idx2].inao012, 
                  g_inbg3_d[g_detail_idx2].inao014) 
         WHERE inaoent = g_enterprise AND inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2] AND inaoseq1 = ps_keys_bak[3] AND inaoseq2 = ps_keys_bak[4] AND inao000 = ps_keys_bak[5] AND inao013 = ps_keys_bak[6]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inao_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint170_inao_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint170_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'inbg_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE inbh_t 
         SET (inbhdocno,inbhseq) 
              = 
             (g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq) 
         WHERE inbhent = g_enterprise AND
               inbhdocno = ps_keys_bak[1] AND inbhseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行update
   IF ps_table = 'inbg_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update3"
      
      #end add-point
      
      UPDATE inao_t 
         SET (inaodocno,inaoseq) 
              = 
             (g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq) 
         WHERE inaoent = g_enterprise AND
               inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update3"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint170_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'inbg_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM inbh_t 
            WHERE inbhent = g_enterprise AND
                  inbhdocno = ps_keys_bak[1] AND inbhseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行delete
   IF ps_table = 'inbg_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete3"
      
      #end add-point
      
      DELETE FROM inao_t 
            WHERE inaoent = g_enterprise AND
                  inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete3"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint170_lock_b(ps_table,ps_page)
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
   #CALL aint170_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "inbg_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint170_bcl USING g_enterprise,
                                       g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint170_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "inbh_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint170_bcl2 USING g_enterprise,
                                             g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq,
                                             g_inbg2_d[g_detail_idx2].inbhseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint170_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "inao_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint170_bcl3 USING g_enterprise,
                                             g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq,
                                             g_inbg3_d[g_detail_idx2].inaoseq1,g_inbg3_d[g_detail_idx2].inaoseq2, 
                                                 g_inbg3_d[g_detail_idx2].inao000,g_inbg3_d[g_detail_idx2].inao013 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint170_bcl3:",SQLERRMESSAGE 
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
 
{<section id="aint170.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint170_unlock_b(ps_table,ps_page)
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
      CLOSE aint170_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint170_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint170_bcl3
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint170_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("inbfdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("inbfdocno",TRUE)
      CALL cl_set_comp_entry("inbfdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("inbfdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint170_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inbfdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("inbfdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("inbfdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("inbfdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_inbf_m.inbfdocno) AND NOT cl_null(g_inbf_m.inbfdocdt) THEN
      CALL cl_set_comp_entry("inbfdocno,inbfdocdt",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint170_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("inbg005,inbg006,inbg007,inbg008,inbg009,inbg010",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint170_set_no_entry_b(p_cmd)
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
   CALL aint170_inbg002_set_no_entry()
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint170_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail,statechange", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint170_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_inbf_m.inbfstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF g_inbf_m.inbfstus MATCHES '[YX]' THEN
       CALL cl_set_act_visible("statechange", FALSE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint170_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint170.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint170_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint170.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint170_default_search()
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
      LET ls_wc = ls_wc, " inbfdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "inbf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inbg_t" 
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
 
{<section id="aint170.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint170_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inbf_m.inbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint170_cl USING g_enterprise,g_inbf_m.inbfdocno
   IF STATUS THEN
      CLOSE aint170_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint170_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
       g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
       g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
       g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
       g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aint170_action_chk() THEN
      CLOSE aint170_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocno_desc,g_inbf_m.inbfdocdt,g_inbf_m.inbf001,g_inbf_m.inbf001_desc, 
       g_inbf_m.inbf002,g_inbf_m.inbf002_desc,g_inbf_m.inbf003,g_inbf_m.inbf003_desc,g_inbf_m.inbf004, 
       g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp, 
       g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtid_desc,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdp_desc, 
       g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid, 
       g_inbf_m.inbfcnfid_desc,g_inbf_m.inbfcnfdt
 
   CASE g_inbf_m.inbfstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         CASE g_inbf_m.inbfstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
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
      
      CALL cl_set_act_visible("unconfirmed,posted",FALSE)   
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CASE g_inbf_m.inbfstus
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
            IF NOT aint170_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint170_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint170_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint170_cl
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
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
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
      AND lc_state <> "S"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_inbf_m.inbfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint170_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'Y' THEN
      IF cl_ask_confirm('lib-054') THEN
         CALL s_aint170_confirm_chk(g_inbf_m.inbfdocno) RETURNING g_success
         IF g_success THEN
            CALL s_transaction_begin()
            CALL s_aint170_confirm_upd(g_inbf_m.inbfdocno) RETURNING g_success
            IF g_success THEN
               CALL s_transaction_end('Y','1')
            ELSE
               CALL s_transaction_end('N','1')
               RETURN 
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
            RETURN       
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
         RETURN 
      END IF
   END IF
   
   IF lc_state = 'X' THEN
      IF cl_ask_confirm('lib-016') THEN
         CALL s_aint170_void_chk(g_inbf_m.inbfdocno) RETURNING g_success
         IF g_success THEN
            CALL s_transaction_begin()
            CALL s_aint170_void_upd(g_inbf_m.inbfdocno) RETURNING g_success
            IF g_success THEN
               CALL s_transaction_end('Y','1')
            ELSE
               CALL s_transaction_end('N','1')
               RETURN 
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
            RETURN       
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
         RETURN 
      END IF
   END IF
   #end add-point
   
   LET g_inbf_m.inbfmodid = g_user
   LET g_inbf_m.inbfmoddt = cl_get_current()
   LET g_inbf_m.inbfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inbf_t 
      SET (inbfstus,inbfmodid,inbfmoddt) 
        = (g_inbf_m.inbfstus,g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt)     
    WHERE inbfent = g_enterprise AND inbfdocno = g_inbf_m.inbfdocno
 
    
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      EXECUTE aint170_master_referesh USING g_inbf_m.inbfdocno INTO g_inbf_m.inbfdocno,g_inbf_m.inbfdocdt, 
          g_inbf_m.inbf001,g_inbf_m.inbf002,g_inbf_m.inbf003,g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus, 
          g_inbf_m.inbfownid,g_inbf_m.inbfowndp,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtdp,g_inbf_m.inbfcrtdt, 
          g_inbf_m.inbfmodid,g_inbf_m.inbfmoddt,g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfdt,g_inbf_m.inbf001_desc, 
          g_inbf_m.inbf002_desc,g_inbf_m.inbfownid_desc,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid_desc, 
          g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inbf_m.inbfdocno,g_inbf_m.inbfdocno_desc,g_inbf_m.inbfdocdt,g_inbf_m.inbf001, 
          g_inbf_m.inbf001_desc,g_inbf_m.inbf002,g_inbf_m.inbf002_desc,g_inbf_m.inbf003,g_inbf_m.inbf003_desc, 
          g_inbf_m.inbf004,g_inbf_m.inbfsite,g_inbf_m.inbfstus,g_inbf_m.inbfownid,g_inbf_m.inbfownid_desc, 
          g_inbf_m.inbfowndp,g_inbf_m.inbfowndp_desc,g_inbf_m.inbfcrtid,g_inbf_m.inbfcrtid_desc,g_inbf_m.inbfcrtdp, 
          g_inbf_m.inbfcrtdp_desc,g_inbf_m.inbfcrtdt,g_inbf_m.inbfmodid,g_inbf_m.inbfmodid_desc,g_inbf_m.inbfmoddt, 
          g_inbf_m.inbfcnfid,g_inbf_m.inbfcnfid_desc,g_inbf_m.inbfcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint170_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint170_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint170.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint170_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inbg_d.getLength() THEN
         LET g_detail_idx = g_inbg_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inbg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inbg_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_inbg2_d.getLength() THEN
         LET g_detail_idx2 = g_inbg2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inbg2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_inbg2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_inbg3_d.getLength() THEN
         LET g_detail_idx2 = g_inbg3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inbg3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_inbg3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint170_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_inao013       LIKE inao_t.inao013
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
   IF aint170_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_inbg_d.getLength() > 0 THEN
               CALL g_inbg2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT inbhseq,inbhseq1,inbh001,inbh002,inbh003,inbh004,inbh005,inbh006, 
             inbh008,inbh007,inbh011,inbh012,inbh014,inbh013,inbh017 ,t5.imaal003 ,t6.inayl003 ,t7.inab003 FROM inbh_t", 
                 
                     "",
                                    " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=inbh002 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=inbh003 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t7 ON t7.inabent="||g_enterprise||" AND t7.inabsite=inbhsite AND t7.inab001=inbh003 AND t7.inab002=inbh004  ",
 
                     " WHERE inbhent=? AND inbhdocno=? AND inbhseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  inbh_t.inbhseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         IF g_detail_idx = 0 THEN
            RETURN 
         END IF 
         
         #end add-point
         
         #先清空資料
               CALL g_inbg2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint170_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR aint170_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq INTO g_inbg2_d[l_ac].inbhseq, 
             g_inbg2_d[l_ac].inbhseq1,g_inbg2_d[l_ac].inbh001,g_inbg2_d[l_ac].inbh002,g_inbg2_d[l_ac].inbh003, 
             g_inbg2_d[l_ac].inbh004,g_inbg2_d[l_ac].inbh005,g_inbg2_d[l_ac].inbh006,g_inbg2_d[l_ac].inbh008, 
             g_inbg2_d[l_ac].inbh007,g_inbg2_d[l_ac].inbh011,g_inbg2_d[l_ac].inbh012,g_inbg2_d[l_ac].inbh014, 
             g_inbg2_d[l_ac].inbh013,g_inbg2_d[l_ac].inbh017,g_inbg2_d[l_ac].inbh002_desc,g_inbg2_d[l_ac].inbh003_desc, 
             g_inbg2_d[l_ac].inbh004_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbg2_d[l_ac].inbh002
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inbg2_d[l_ac].inbh002_desc = '', g_rtn_fields[1] , ''
            LET g_inbg2_d[l_ac].inbh002_desc_1 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbg2_d[l_ac].inbh002_desc,g_inbg2_d[l_ac].inbh002_desc_1
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbg2_d[l_ac].inbh003
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_inbg2_d[l_ac].inbh003_desc = '', g_rtn_fields[1] , ''
            CALL s_desc_get_stock_desc(g_site,g_inbg2_d[l_ac].inbh003) RETURNING g_inbg2_d[l_ac].inbh003_desc
            DISPLAY BY NAME g_inbg2_d[l_ac].inbh003_desc
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbg2_d[l_ac].inbh003
            LET g_ref_fields[2] = g_inbg2_d[l_ac].inbh004
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_inbg2_d[l_ac].inbh004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbg2_d[l_ac].inbh004_desc
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_inbg2_d.deleteElement(g_inbg2_d.getLength())
 
      END IF
   END IF
 
   IF aint170_fill_chk(3) THEN
      IF (pi_idx = 3 OR pi_idx = 0 ) AND g_inbg_d.getLength() > 0 THEN
               CALL g_inbg3_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT inaoseq1,inaoseq2,inao000,inao001,inao005,inao006,inao008,inao009, 
             inao012,inao013,inao014 ,t8.imaal003 ,t9.inayl003 ,t10.inab003 FROM inao_t",    
                     "",
                                    " LEFT JOIN imaal_t t8 ON t8.imaalent="||g_enterprise||" AND t8.imaal001=inao001 AND t8.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t9 ON t9.inaylent="||g_enterprise||" AND t9.inayl001=inao005 AND t9.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t10 ON t10.inabent="||g_enterprise||" AND t10.inab001=inao005 AND t10.inab002=inao006  ",
 
                     " WHERE inaoent=? AND inaodocno=? AND inaoseq=?"
         
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  inao_t.inaoseq1,inao_t.inaoseq2,inao_t.inao000,inao_t.inao013" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill3"
         IF g_detail_idx = 0 THEN
            RETURN 
         END IF 
         #end add-point
         
         #先清空資料
               CALL g_inbg3_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint170_pb3 FROM g_sql
         DECLARE b_fill_curs3 CURSOR FOR aint170_pb3
         
      #  OPEN b_fill_curs3 USING g_enterprise,g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs3 USING g_enterprise,g_inbf_m.inbfdocno,g_inbg_d[g_detail_idx].inbgseq INTO g_inbg3_d[l_ac].inaoseq1, 
             g_inbg3_d[l_ac].inaoseq2,g_inbg3_d[l_ac].inao000,g_inbg3_d[l_ac].inao001,g_inbg3_d[l_ac].inao005, 
             g_inbg3_d[l_ac].inao006,g_inbg3_d[l_ac].inao008,g_inbg3_d[l_ac].inao009,g_inbg3_d[l_ac].inao012, 
             g_inbg3_d[l_ac].inao013,g_inbg3_d[l_ac].inao014,g_inbg3_d[l_ac].inao001_desc,g_inbg3_d[l_ac].inao005_desc, 
             g_inbg3_d[l_ac].inao006_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill3"
            SELECT inao013 INTO l_inao013 FROM inao_t WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno = g_inbf_m.inbfdocno
               AND inaoseq = g_inbg_d[g_detail_idx].inbgseq AND inaoseq1 = g_inbg3_d[l_ac].inaoseq1 AND inaoseq2 = g_inbg3_d[l_ac].inaoseq2
            IF l_inao013 = 1 AND l_ac != 1 THEN
               LET g_inbg3_d[l_ac-1].inao0081 = g_inbg3_d[l_ac].inao008
               LET g_inbg3_d[l_ac-1].inao0091 = g_inbg3_d[l_ac].inao009
               INITIALIZE g_inbg3_d[l_ac].* TO NULL
               CONTINUE FOREACH
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbg3_d[l_ac].inao001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inbg3_d[l_ac].inao001_desc = '', g_rtn_fields[1] , ''
            LET g_inbg3_d[l_ac].inao001_desc_1 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbg3_d[l_ac].inao001_desc,g_inbg3_d[l_ac].inao001_desc_1
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbg3_d[l_ac].inao005
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_inbg3_d[l_ac].inao005_desc = '', g_rtn_fields[1] , ''
            CALL s_desc_get_stock_desc(g_site,g_inbg3_d[l_ac].inao005) RETURNING g_inbg3_d[l_ac].inao005_desc            
            DISPLAY BY NAME g_inbg3_d[l_ac].inao005_desc
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbg3_d[l_ac].inao005
            LET g_ref_fields[2] = g_inbg3_d[l_ac].inao006
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_inbg3_d[l_ac].inao006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbg3_d[l_ac].inao006_desc
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_inbg3_d.deleteElement(g_inbg3_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_inbg2_d_mask_o.* =  g_inbg2_d.*
   FOR l_ac = 1 TO g_inbg2_d.getLength()
      LET g_inbg2_d_mask_o[l_ac].* =  g_inbg2_d[l_ac].*
      CALL aint170_inbh_t_mask()
      LET g_inbg2_d_mask_n[l_ac].* =  g_inbg2_d[l_ac].*
   END FOR
   LET g_inbg3_d_mask_o.* =  g_inbg3_d.*
   FOR l_ac = 1 TO g_inbg3_d.getLength()
      LET g_inbg3_d_mask_o[l_ac].* =  g_inbg3_d[l_ac].*
      CALL aint170_inao_t_mask()
      LET g_inbg3_d_mask_n[l_ac].* =  g_inbg3_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aint170_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint170_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aint170.status_show" >}
PRIVATE FUNCTION aint170_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint170.mask_functions" >}
&include "erp/ain/aint170_mask.4gl"
 
{</section>}
 
{<section id="aint170.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint170_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aint170_show()
   CALL aint170_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
    CALL s_aint170_confirm_chk(g_inbf_m.inbfdocno) RETURNING g_success
    IF NOT g_success THEN
       CLOSE aint170_cl
       CALL s_transaction_end('N','0')
       RETURN FALSE
    END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_inbf_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_inbg_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_inbg2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_inbg3_d))
 
 
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
   #CALL aint170_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint170_ui_headershow()
   CALL aint170_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint170_draw_out()
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
   CALL aint170_ui_headershow()  
   CALL aint170_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint170.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint170_set_pk_array()
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
   LET g_pk_array[1].values = g_inbf_m.inbfdocno
   LET g_pk_array[1].column = 'inbfdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint170.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint170.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint170_msgcentre_notify(lc_state)
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
   CALL aint170_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inbf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint170.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint170_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#16-s
   SELECT inbfstus INTO g_inbf_m.inbfstus FROM inbf_t
    WHERE inbfent = g_enterprise
      AND inbfsite = g_site
      AND inbfdocno = g_inbf_m.inbfdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_inbf_m.inbfstus
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
        LET g_errparam.extend = g_inbf_m.inbfdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aint170_set_act_visible()
        CALL aint170_set_act_no_visible()
        CALL aint170_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#16-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint170.other_function" readonly="Y" >}
#校驗庫存欄位
#p_flag = '1':料件
#p_flag = '2':料件+庫位
#p_flag = '3':料件+庫位+儲位
#p_flag = '4':料件+庫位+儲位+產品特徵
#p_flag = '5':料件+庫位+儲位+庫存管理特徵
#p_flag = '6':料件+庫位+儲位+庫存單位
#p_flag = '7':料件+庫位+儲位+批號
#p_flag = '8':料件+庫位+儲位+製造批號
#p_flag = '9':料件+庫位+儲位+製造序號
PRIVATE FUNCTION aint170_detail_chk(p_flag)
DEFINE p_flag LIKE type_t.chr1
#DEFINE l_sql   STRING
#DEFINE l_sql1   STRING
#DEFINE l_sql2   STRING
#DEFINE l_sql3   STRING
#DEFINE l_sql4   STRING
#DEFINE l_sql5   STRING
#DEFINE l_sql6   STRING
#DEFINE l_sql7   STRING
#DEFINE l_n    LIKE type_t.num5
#   LET l_sql = "SELECT COUNT(*) FROM inag_t WHERE inagent = ",g_enterprise,
#               " AND inagsite='",g_site,"' "
#   IF p_flag = '1' THEN
#      LET l_sql1 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
#      PREPARE sel_inag_pre1 FROM l_sql1
#      LET l_n = 0
#      EXECUTE sel_inag_pre1 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002,'ain-00119',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql1 = l_sql1," AND inag008 > 0 "
#      PREPARE sel_inag_pre2 FROM l_sql1
#      LET l_n = 0
#      EXECUTE sel_inag_pre2 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002,'ain-00120',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '2' THEN
#      LET l_sql2 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
#      PREPARE sel_inag_pre3 FROM l_sql2
#      LET l_n = 0
#      EXECUTE sel_inag_pre3 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003,'ain-00126',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql2 = l_sql2," AND inag008 > 0 "
#      PREPARE sel_inag_pre4 FROM l_sql2
#      LET l_n = 0
#      EXECUTE sel_inag_pre4 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003,'ain-00127',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '3' THEN
#      LET l_sql3 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag004 = '",g_inbg_d[l_ac].inbg003,"' AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
#      PREPARE sel_inag_pre5 FROM l_sql3
#      LET l_n = 0
#      EXECUTE sel_inag_pre5 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004,'ain-00135',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql3 = l_sql3," AND inag008 > 0 "
#      PREPARE sel_inag_pre6 FROM l_sql3
#      LET l_n = 0
#      EXECUTE sel_inag_pre6 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004,'ain-00136',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '4' THEN
#      LET l_sql4 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag004 = '",g_inbg_d[l_ac].inbg003,"' AND inag005 = '",g_inbg_d[l_ac].inbg004,"'",
#                         " AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
#      PREPARE sel_inag_pre7 FROM l_sql4
#      LET l_n = 0
#      EXECUTE sel_inag_pre7 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg005,'ain-00137',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql4 = l_sql4," AND inag008 > 0 "
#      PREPARE sel_inag_pre8 FROM l_sql4
#      LET l_n = 0
#      EXECUTE sel_inag_pre8 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg005,'ain-00138',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '5' THEN
#      LET l_sql5 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag004 = '",g_inbg_d[l_ac].inbg003,"' AND inag005 = '",g_inbg_d[l_ac].inbg004,"'",
#                         " AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
#      PREPARE sel_inag_pre9 FROM l_sql5
#      LET l_n = 0
#      EXECUTE sel_inag_pre9 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg006,'ain-00139',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql5 = l_sql5," AND inag008 > 0 "
#      PREPARE sel_inag_pre10 FROM l_sql5
#      LET l_n = 0
#      EXECUTE sel_inag_pre10 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg006,'ain-00140',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '6' THEN
#      LET l_sql6 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag004 = '",g_inbg_d[l_ac].inbg003,"' AND inag005 = '",g_inbg_d[l_ac].inbg004,"'",
#                         " AND inag007 = '",g_inbg_d[l_ac].inbg007,"'"
#      PREPARE sel_inag_pre11 FROM l_sql6
#      LET l_n = 0
#      EXECUTE sel_inag_pre11 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg007,'ain-00141',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql6 = l_sql6," AND inag008 > 0 "
#      PREPARE sel_inag_pre12 FROM l_sql6
#      LET l_n = 0
#      EXECUTE sel_inag_pre12 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg007,'ain-00142',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '7' THEN
#      LET l_sql7 = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag004 = '",g_inbg_d[l_ac].inbg003,"' AND inag005 = '",g_inbg_d[l_ac].inbg004,"'",
#                         " AND inag006 = '",g_inbg_d[l_ac].inbg008,"'"
#      PREPARE sel_inag_pre13 FROM l_sql7
#      LET l_n = 0
#      EXECUTE sel_inag_pre13 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg008,'ain-00143',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql7 = l_sql7," AND inag008 > 0 "
#      PREPARE sel_inag_pre14 FROM l_sql7
#      LET l_n = 0
#      EXECUTE sel_inag_pre14 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg008,'ain-00144',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '8' THEN
#      LET l_sql= " SELECT COUNT(*) FROM inai_t WHERE inaient = ",g_enterprise," AND inaisite = '",g_site,"' inai001 = '",g_inbg_d[l_ac].inbg002,"' AND inai004 = '",g_inbg_d[l_ac].inbg003,"' AND inai005 = '",g_inbg_d[l_ac].inbg004,"'",
#                 " AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
#      PREPARE sel_inai_pre FROM l_sql
#      LET l_n = 0
#      EXECUTE sel_inai_pre INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg009,'ain-00145',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql = l_sql," AND inai010 > 0 "
#      PREPARE sel_inai_pre1 FROM l_sql
#      LET l_n = 0
#      EXECUTE sel_inai_pre1 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg009,'ain-00146',1)
#         RETURN FALSE
#      END IF
#   END IF
#   
#   IF p_flag = '9' THEN
#      LET l_sql= " SELECT COUNT(*) FROM inai_t WHERE inaient = ",g_enterprise," AND inaisite = '",g_site,"' inai001 = '",g_inbg_d[l_ac].inbg002,"' AND inai004 = '",g_inbg_d[l_ac].inbg003,"' AND inai005 = '",g_inbg_d[l_ac].inbg004,"'",
#                 " AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
#      PREPARE sel_inai_pre2 FROM l_sql
#      LET l_n = 0
#      EXECUTE sel_inai_pre2 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg010,'ain-00147',1)
#         RETURN FALSE
#      END IF
#      
#      LET l_sql = l_sql," AND inai010 > 0 "
#      PREPARE sel_inai_pre3 FROM l_sql
#      LET l_n = 0
#      EXECUTE sel_inai_pre3 INTO l_n
#      IF l_n = 0 THEN
#         CALL cl_err(g_inbg_d[l_ac].inbg002||" + "||g_inbg_d[l_ac].inbg003||" + "||g_inbg_d[l_ac].inbg004||" + "||g_inbg_d[l_ac].inbg010,'ain-00148',1)
#         RETURN FALSE
#      END IF
#   END IF
#   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inbf001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbf_m.inbf001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inbf_m.inbf001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbf_m.inbf001_desc
END FUNCTION

PRIVATE FUNCTION aint170_inbf002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbf_m.inbf002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbf_m.inbf002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbf_m.inbf002_desc
END FUNCTION

PRIVATE FUNCTION aint170_inbf003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbf_m.inbf003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbf_m.inbf003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbf_m.inbf003_desc
END FUNCTION

PRIVATE FUNCTION aint170_inbg002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbg_d[l_ac].inbg002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbg_d[l_ac].inbg002_desc = '', g_rtn_fields[1] , ''
   LET g_inbg_d[l_ac].inbg002_desc_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbg_d[l_ac].inbg002_desc,g_inbg_d[l_ac].inbg002_desc_desc
END FUNCTION

PRIVATE FUNCTION aint170_inbg002_set_no_entry()
DEFINE l_n     LIKE type_t.num5
DEFINE l_sql   STRING
DEFINE l_sql1   STRING
DEFINE l_sql2   STRING
DEFINE l_sql3   STRING
DEFINE l_sql4   STRING
DEFINE l_sql5   STRING
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 = g_inbg_d[l_ac].inbg002
      AND imaa005 IS NOT NULL
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbg005",FALSE)
   END IF
   
   LET l_sql = "SELECT COUNT(*) FROM imaf_t WHERE imafent = ",g_enterprise,
               " AND imafsite = '",g_site,"' AND imaf001 = '",g_inbg_d[l_ac].inbg002,"'"
   LET l_sql1 = l_sql," AND imaf055 <> '2' "
   PREPARE sel_imaf_pre1 FROM l_sql1
   LET l_n = 0
   EXECUTE sel_imaf_pre1 INTO l_n
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbg006",FALSE)
   END IF
   
   LET l_sql2 = l_sql," AND (imaf061 = '1' OR imaf061 = '3')"
   PREPARE sel_imaf_pre2 FROM l_sql2
   LET l_n = 0
   EXECUTE sel_imaf_pre2 INTO l_n
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbg007",FALSE)
   END IF
   
   LET l_sql3 = l_sql," AND (imaf071 = '1' OR imaf071 = '3')"
   PREPARE sel_imaf_pre3 FROM l_sql3
   LET l_n = 0
   EXECUTE sel_imaf_pre3 INTO l_n
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbg009",FALSE)
   END IF
   
   LET l_sql4 = l_sql," AND (imaf081 = '1' OR imaf081 = '3') "
   PREPARE sel_imaf_pre4 FROM l_sql4
   LET l_n = 0
   EXECUTE sel_imaf_pre4 INTO l_n
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbg010",FALSE)
   END IF
   
   LET l_sql5 = l_sql," AND imaf054 = 'Y'" 
   PREPARE sel_imaf_pre5 FROM l_sql5
   LET l_n = 0
   EXECUTE sel_imaf_pre5 INTO l_n
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbg008",FALSE)
      SELECT imaf053 INTO g_inbg_d[l_ac].inbg008 
        FROM imaf_t WHERE imafent = g_enterprise
         AND imafsite = g_site AND imaf001 = g_inbg_d[l_ac].inbg002
      DISPLAY BY NAME g_inbg_d[l_ac].inbg008 
   END IF
END FUNCTION

PRIVATE FUNCTION aint170_inbg003_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_inbg_d[l_ac].inbg003
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_inbg_d[l_ac].inbg003_desc = '', g_rtn_fields[1] , ''
   CALL s_desc_get_stock_desc(g_site,g_inbg_d[l_ac].inbg003) RETURNING g_inbg_d[l_ac].inbg003_desc            
   DISPLAY BY NAME g_inbg_d[l_ac].inbg003_desc
END FUNCTION

PRIVATE FUNCTION aint170_inbg004_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbg_d[l_ac].inbg003
   LET g_ref_fields[2] = g_inbg_d[l_ac].inbg004
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
   LET g_inbg_d[l_ac].inbg004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbg_d[l_ac].inbg004_desc
END FUNCTION
# 新增變更明細檔
PRIVATE FUNCTION aint170_inbh_ins()
DEFINE l_sql   STRING
DEFINE l_cnt   LIKE type_t.num5
#DEFINE l_inag  RECORD LIKE inag_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企业编号
       inagsite LIKE inag_t.inagsite, #营运据点
       inag001 LIKE inag_t.inag001, #料件编号
       inag002 LIKE inag_t.inag002, #产品特征
       inag003 LIKE inag_t.inag003, #库存管理特征
       inag004 LIKE inag_t.inag004, #库位编号
       inag005 LIKE inag_t.inag005, #储位编号
       inag006 LIKE inag_t.inag006, #批号
       inag007 LIKE inag_t.inag007, #库存单位
       inag008 LIKE inag_t.inag008, #账面库存数量
       inag009 LIKE inag_t.inag009, #实际库存数量
       inag010 LIKE inag_t.inag010, #库存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本库否
       inag013 LIKE inag_t.inag013, #拣货优先序
       inag014 LIKE inag_t.inag014, #最近一次盘点日期
       inag015 LIKE inag_t.inag015, #最后异动日期
       inag016 LIKE inag_t.inag016, #呆滞日期
       inag017 LIKE inag_t.inag017, #第一次入库日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #备置数量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二进位码
       inag024 LIKE inag_t.inag024, #参考单位
       inag025 LIKE inag_t.inag025, #参考数量
       inag026 LIKE inag_t.inag026, #最近一次检验日期
       inag027 LIKE inag_t.inag027, #下次检验日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人员
       inag030 LIKE inag_t.inag030, #留置部门
       inag031 LIKE inag_t.inag031, #留置单号
       inag032 LIKE inag_t.inag032, #基础单位
       inag033 LIKE inag_t.inag033 #基础单位数量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
#DEFINE l_inbh  RECORD LIKE inbh_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inbh RECORD  #庫存異常變更明細檔
       inbhent LIKE inbh_t.inbhent, #企业编号
       inbhsite LIKE inbh_t.inbhsite, #营运据点
       inbhdocno LIKE inbh_t.inbhdocno, #单据编号
       inbhseq LIKE inbh_t.inbhseq, #项次
       inbhseq1 LIKE inbh_t.inbhseq1, #项序
       inbh001 LIKE inbh_t.inbh001, #变更类型
       inbh002 LIKE inbh_t.inbh002, #料件编号
       inbh003 LIKE inbh_t.inbh003, #库位
       inbh004 LIKE inbh_t.inbh004, #储位
       inbh005 LIKE inbh_t.inbh005, #变更前-产品特征
       inbh006 LIKE inbh_t.inbh006, #变更前-库存管理特征
       inbh007 LIKE inbh_t.inbh007, #变更前-批号
       inbh008 LIKE inbh_t.inbh008, #变更前-库存单位
       inbh011 LIKE inbh_t.inbh011, #变更后-产品特征
       inbh012 LIKE inbh_t.inbh012, #变更后-库存管理特征
       inbh013 LIKE inbh_t.inbh013, #变更后-批号
       inbh014 LIKE inbh_t.inbh014, #变更后-库存单位
       inbh017 LIKE inbh_t.inbh017 #变更数量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
   IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
     #161123-00010#1-S
     IF g_inbg_d[l_ac].inbg005 IS NULL THEN
        LET g_inbg_d[l_ac].inbg005 = ' '
     END IF
     IF g_inbg_d[l_ac].inbg006 IS NULL THEN
        LET g_inbg_d[l_ac].inbg006 = ' '
     END IF   
     IF g_inbg_d[l_ac].inbg004 IS NULL THEN
        LET g_inbg_d[l_ac].inbg004 = ' '
     END IF   
     IF g_inbg_d[l_ac].inbg007 IS NULL THEN
        LET g_inbg_d[l_ac].inbg007 = ' '
     END IF         
     #161123-00010#1-E
     # LET l_sql = "SELECT * FROM inag_t WHERE inagent = ",g_enterprise,  #161124-00048#5  16/12/09 By 08734 mark
      LET l_sql = "SELECT inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,inag009,inag010,inag011,inag012,inag013,inag014,inag015,inag016,inag017,inag018,inag019,inag020,inag021,inag022,inag023,inag024,inag025,inag026,inag027,inag028,inag029,inag030,inag031,inag032,inag033 FROM inag_t WHERE inagent = ",g_enterprise,  #161124-00048#5  16/12/09 By 08734 add
                  " AND inagsite = '",g_site,"' AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag008 <> 0 "
      IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
      END IF
      PREPARE sel_inag_prep1 FROM l_sql
      DECLARE sel_inag_curs1 CURSOR FOR sel_inag_prep1
      
      LET l_cnt = 1
      FOREACH sel_inag_curs1 INTO l_inag.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_inbh.inbhent = g_enterprise
         LET l_inbh.inbhsite = g_site
         LET l_inbh.inbhdocno = g_inbf_m.inbfdocno
         LET l_inbh.inbhseq = g_inbg_d[l_ac].inbgseq
         LET l_inbh.inbhseq1 = l_cnt
         LET l_inbh.inbh001 = g_inbg_d[l_ac].inbg001
         LET l_inbh.inbh002 = l_inag.inag001
         LET l_inbh.inbh003 = l_inag.inag004
         LET l_inbh.inbh004 = l_inag.inag005
         LET l_inbh.inbh005 = l_inag.inag002
         LET l_inbh.inbh006 = l_inag.inag003
         LET l_inbh.inbh007 = l_inag.inag006
         LET l_inbh.inbh008 = l_inag.inag007 
         CASE 
            WHEN g_inbg_d[l_ac].inbg001 = '1'
               LET l_inbh.inbh011 = g_inbg_d[l_ac].inbg011
               LET l_inbh.inbh012 = l_inag.inag003
               LET l_inbh.inbh013 = l_inag.inag006
               LET l_inbh.inbh014 = l_inag.inag007
            WHEN g_inbg_d[l_ac].inbg001 = '2'
               LET l_inbh.inbh011 = l_inag.inag002
               LET l_inbh.inbh012 = g_inbg_d[l_ac].inbg011
               LET l_inbh.inbh013 = l_inag.inag006
               LET l_inbh.inbh014 = l_inag.inag007
            WHEN g_inbg_d[l_ac].inbg001 = '3'
               LET l_inbh.inbh011 = l_inag.inag002
               LET l_inbh.inbh012 = l_inag.inag003
               LET l_inbh.inbh013 = l_inag.inag006
               LET l_inbh.inbh014 = g_inbg_d[l_ac].inbg011
            WHEN g_inbg_d[l_ac].inbg001 = '4'
               LET l_inbh.inbh011 = l_inag.inag002
               LET l_inbh.inbh012 = l_inag.inag003
               LET l_inbh.inbh013 = g_inbg_d[l_ac].inbg011
               LET l_inbh.inbh014 = l_inag.inag007
#            WHEN g_inbg_d[l_ac].inbg001 MATCHES '[56]'
#               LET l_inbh.inbh011 = l_inag.inag002
#               LET l_inbh.inbh012 = l_inag.inag003
#               LET l_inbh.inbh013 = l_inag.inag006
#               LET l_inbh.inbh014 = l_inag.inag007
         END CASE    
         LET l_inbh.inbh017 = l_inag.inag008
         #INSERT INTO inbh_t VALUES (l_inbh.*)  #161124-00048#5  16/12/09 By 08734 mark
         INSERT INTO inbh_t(inbhent,inbhsite,inbhdocno,inbhseq,inbhseq1,inbh001,inbh002,inbh003,inbh004,inbh005,inbh006,inbh007,inbh008,inbh011,inbh012,inbh013,inbh014,inbh017)  #161124-00048#5  16/12/09 By 08734 add
            VALUES (l_inbh.inbhent,l_inbh.inbhsite,l_inbh.inbhdocno,l_inbh.inbhseq,l_inbh.inbhseq1,l_inbh.inbh001,l_inbh.inbh002,l_inbh.inbh003,l_inbh.inbh004,l_inbh.inbh005,l_inbh.inbh006,l_inbh.inbh007,l_inbh.inbh008,l_inbh.inbh011,l_inbh.inbh012,l_inbh.inbh013,l_inbh.inbh014,l_inbh.inbh017)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            EXIT FOREACH
         END IF
         LET l_cnt = l_cnt + 1
      END FOREACH
   END IF
END FUNCTION
#新增inao_t
PRIVATE FUNCTION aint170_inao_ins()
DEFINE l_sql        STRING
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_cnt1       LIKE type_t.num5
#DEFINE l_inai       RECORD LIKE inai_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企业编号
       inaisite LIKE inai_t.inaisite, #营运据点
       inai001 LIKE inai_t.inai001, #料件编号
       inai002 LIKE inai_t.inai002, #产品特征
       inai003 LIKE inai_t.inai003, #库存管理特征
       inai004 LIKE inai_t.inai004, #库位编号
       inai005 LIKE inai_t.inai005, #储位编号
       inai006 LIKE inai_t.inai006, #批号
       inai007 LIKE inai_t.inai007, #制造批号
       inai008 LIKE inai_t.inai008, #制造序号
       inai009 LIKE inai_t.inai009, #库存单位
       inai010 LIKE inai_t.inai010, #账面基础单位库存数量
       inai011 LIKE inai_t.inai011, #实际基础单位库存数量
       inai012 LIKE inai_t.inai012, #制造日期
       inai013 LIKE inai_t.inai013, #Tag二进位码
       inai014 LIKE inai_t.inai014 #基础单位
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
#DEFINE l_inao       RECORD LIKE inao_t.*  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
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
       inao025 LIKE inao_t.inao025 #已退品量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
DEFINE l_imaf031    LIKE imaf_t.imaf031  #160318-00015#1
DEFINE l_imaf032    LIKE imaf_t.imaf032  #160318-00015#1
DEFINE l_inae010    LIKE inae_t.inae010  #160512-00004#1 by whitney add

   #160512-00004#1 by whitney modify start
   #LET l_sql = "SELECT * FROM inai_t WHERE inaient = ",g_enterprise,
   #            " AND inaisite = '",g_site,"' AND inai001 = '",g_inbg_d[l_ac].inbg002,"' AND inai010 > 0 "
   #LET l_sql = " SELECT inai_t.*,inae010 FROM inai_t ",  #161124-00048#5  16/12/09 By 08734 mark
   LET l_sql = " SELECT inaient,inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008,inai009,inai010,inai011,inai012,inai013,inai014,inae010 FROM inai_t ",  #161124-00048#5  16/12/09 By 08734 add
               "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
               "  WHERE inaient = ",g_enterprise,
               "    AND inaisite = '",g_site,"' ",
               "    AND inai001 = '",g_inbg_d[l_ac].inbg002,"' ",
               "    AND inai010 > 0 "
   #160512-00004#1 by whitney modify end
   IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg001 MATCHES '[56]' THEN
      IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
      END IF
   END IF
   
   IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
   END IF
   PREPARE sel_inai_prep1 FROM l_sql
   DECLARE sel_inai_curs1 CURSOR FOR sel_inai_prep1
   LET l_cnt = 1
   FOREACH sel_inai_curs1 INTO l_inai.*,l_inae010  #160512-00004#1 by whitney add l_inae010
      
      LET l_inao.inaoent = g_enterprise
      LET l_inao.inaosite = g_site
      LET l_inao.inaodocno = g_inbf_m.inbfdocno
      LET l_inao.inaoseq = g_inbg_d[l_ac].inbgseq
      LET l_inao.inaoseq1 = l_cnt
      LET l_inao.inaoseq2 = 1
      LET l_inao.inao000 = '2'
      LET l_inao.inao001 = l_inai.inai001
      LET l_inao.inao002 = l_inai.inai002
      LET l_inao.inao003 = l_inai.inai003
      LET l_inao.inao005 = l_inai.inai004
      LET l_inao.inao006 = l_inai.inai005
      LET l_inao.inao007 = l_inai.inai006
      LET l_inao.inao008 = l_inai.inai007
      LET l_inao.inao009 = l_inai.inai008
      LET l_inao.inao012 = l_inai.inai010
      LET l_inao.inao013 = -1
      LET l_inao.inao014 = l_inai.inai009
      LET l_inao.inao010 = l_inae010  #160512-00004#1 by whitney modify l_inai.inai012 -> l_inae010
      
      #160318-00015#1 add(s)
      SELECT imaf031,imaf032 INTO l_imaf031,l_imaf032 
        FROM imaf_t WHERE imafent = g_enterprise 
         AND imafsite = g_site AND imaf001 = g_inbg.inbg002
      CALL s_date_get_date(l_inai.inai001,l_imaf031,l_imaf032) RETURNING l_inao.inao011
      #160318-00015#1 add(e)
      
      #新增变更前
      #INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#5  16/12/09 By 08734 mark
      INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025)  #161124-00048#5  16/12/09 By 08734 add
         VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         EXIT FOREACH
      END IF
      
      #新增变更后
      LET l_inao.inaoseq2 = 2
      LET l_inao.inao013 = 1
      CASE WHEN g_inbg_d[l_ac].inbg001 = '1'
              LET l_inao.inao002 = g_inbg_d[l_ac].inbg011
              LET l_inao.inao003 = l_inai.inai003
              LET l_inao.inao007 = l_inai.inai006
              LET l_inao.inao008 = l_inai.inai007
              LET l_inao.inao009 = l_inai.inai008
           WHEN g_inbg_d[l_ac].inbg001 = '2'
              LET l_inao.inao002 = l_inai.inai002
              LET l_inao.inao003 = g_inbg_d[l_ac].inbg011
              LET l_inao.inao007 = l_inai.inai006
              LET l_inao.inao008 = l_inai.inai007
              LET l_inao.inao009 = l_inai.inai008
           WHEN g_inbg_d[l_ac].inbg001 = '4'
              LET l_inao.inao002 = l_inai.inai002
              LET l_inao.inao003 = l_inai.inai003
              LET l_inao.inao007 = g_inbg_d[l_ac].inbg011
              LET l_inao.inao008 = l_inai.inai007
              LET l_inao.inao009 = l_inai.inai008
           WHEN g_inbg_d[l_ac].inbg001 ='5'
              LET l_inao.inao002 = l_inai.inai002
              LET l_inao.inao003 = l_inai.inai003
              LET l_inao.inao007 = l_inai.inai006
              LET l_inao.inao008 = g_inbg_d[l_ac].inbg011
              LET l_inao.inao009 = l_inai.inai008
           WHEN g_inbg_d[l_ac].inbg001 ='6'
              LET l_inao.inao002 = l_inai.inai002
              LET l_inao.inao003 = l_inai.inai003
              LET l_inao.inao007 = l_inai.inai006
              LET l_inao.inao008 = l_inai.inai007
              LET l_inao.inao009 = g_inbg_d[l_ac].inbg011
      END CASE
      #INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#5  16/12/09 By 08734 mark
      INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025)  #161124-00048#5  16/12/09 By 08734 add
         VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   
END FUNCTION

PRIVATE FUNCTION aint170_chk_pxh_exists()
DEFINE l_n  LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n  FROM imaf_t WHERE imafent = g_enterprise
      AND imafsite = g_site AND imaf001 = g_inbg_d[l_ac].inbg002
      AND imaf071 != '2' AND imaf081 != '2'
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inbg001_inbg002_chk(p_cmd)
DEFINE l_n   LIKE type_t.num5
DEFINE p_cmd LIKE type_t.chr1
   IF NOT cl_null(g_inbg_d[l_ac].inbgseq) AND NOT cl_null(g_inbg_d[l_ac].inbg001) AND NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM inbg_t 
       WHERE inbgent = g_enterprise AND inbgdocno = g_inbf_m.inbfdocno
         AND inbg001 = g_inbg_d[l_ac].inbg001 AND inbg002 = g_inbg_d[l_ac].inbg002 AND inbgseq <> g_inbg_d[l_ac].inbgseq
   
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00172'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
       CASE g_inbg_d[l_ac].inbg001 
          WHEN '1'
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
             IF NOT cl_chk_exist("v_imaa001_8") THEN
                RETURN FALSE
             END IF
          WHEN '2'
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
             IF NOT cl_chk_exist("v_imaf001_8") THEN
                RETURN FALSE
             END IF
          WHEN '3'
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
             IF NOT cl_chk_exist("v_imaf001_12") THEN
                RETURN FALSE
             END IF   
          WHEN '4'
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
             IF NOT cl_chk_exist("v_imaf001_9") THEN
                RETURN FALSE
             END IF
          WHEN '5'
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
             IF NOT cl_chk_exist("v_imaf001_10") THEN
                RETURN FALSE
             END IF
          WHEN '6'
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = g_inbg_d[l_ac].inbg002
             IF NOT cl_chk_exist("v_imaf001_11") THEN
                RETURN FALSE
             END IF
       END CASE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inbg031_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbg_d[l_ac].inbg031
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbg_d[l_ac].inbg031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbg_d[l_ac].inbg031_desc

END FUNCTION

PRIVATE FUNCTION aint170_inag_chk_exist()
DEFINE l_sql   STRING
DEFINE l_n    LIKE type_t.num5
   LET l_sql = "SELECT COUNT(*) FROM inag_t WHERE inagent = ",g_enterprise,
               " AND inagsite='",g_site,"' "
   IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
      LET l_sql = l_sql," AND inag001 = '",g_inbg_d[l_ac].inbg002,"'"
   END IF

   IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
   END IF

   IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
   END IF

   IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
   END IF

   IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
   END IF

   PREPARE sel_inag_pre1 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre1 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00119'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   LET l_sql = l_sql," AND inag008 <> 0 "
   PREPARE sel_inag_pre2 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre2 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00504'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inai_chk_exist()
DEFINE l_n  LIKE type_t.num5
DEFINE l_sql STRING
   LET l_sql= " SELECT COUNT(*) FROM inai_t WHERE inaient = ",g_enterprise," AND inaisite = '",g_site,"' "

   IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
      LET l_sql = l_sql," AND inai001 = '",g_inbg_d[l_ac].inbg002,"'"
   END IF

   IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
   END IF

   IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
   END IF

   IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
   END IF

   IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
   END IF

   IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
   END IF

   IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
   END IF

   IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
   END IF
 
   IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
   END IF
   PREPARE sel_inai_pre1 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inai_pre1 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00145'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   LET l_sql = l_sql," AND inai010 > 0 "
   PREPARE sel_inai_pre2 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inai_pre2 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00146'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inbh_exist()
DEFINE l_n   LIKE type_t.num5
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM inbh_t
    WHERE inbhent = g_enterprise AND inbhdocno = g_inbf_m.inbfdocno 
      AND inbhseq = g_inbg_d[l_ac].inbgseq
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inao_exist()
DEFINE l_n   LIKE type_t.num5
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM inao_t
    WHERE inaoent = g_enterprise AND inaodocno = g_inbf_m.inbfdocno 
      AND inaoseq = g_inbg_d[l_ac].inbgseq
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_inbg002_exist()
DEFINE l_n  LIKE type_t.num5
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM inbg_t WHERE inbgent = g_enterprise 
      AND inbgdocno = g_inbf_m.inbfdocno AND inbg002 = g_inbg_d[l_ac].inbg002 
      AND inbgseq <> g_inbg_d[l_ac].inbgseq
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00215'
      LET g_errparam.extend = g_inbg_d[l_ac].inbg002
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inbf_t,inbg_t WHERE inbfent = g_enterprise
       AND inbgent = inbfent  AND inbgdocno = inbfdocno AND inbg002 = g_inbg_d[l_ac].inbg002 
       AND inbfdocno <> g_inbf_m.inbfdocno AND inbfstus = 'N'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00224'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_detail_change()
   IF ((g_inbg_d[l_ac].inbg003 != g_inbg_d_t.inbg003 AND g_inbg_d_t.inbg003 IS NOT NULL) OR (g_inbg_d[l_ac].inbg003 IS NOT NULL AND g_inbg_d_t.inbg003 IS NULL) OR (g_inbg_d[l_ac].inbg003 IS NULL AND g_inbg_d_t.inbg003 IS NOT NULL)) 
      OR ((g_inbg_d[l_ac].inbg004 != g_inbg_d_t.inbg004 AND g_inbg_d_t.inbg004 IS NOT NULL) OR (g_inbg_d[l_ac].inbg004 IS NOT NULL AND g_inbg_d_t.inbg004 IS NULL) OR (g_inbg_d[l_ac].inbg004 IS NULL AND g_inbg_d_t.inbg004 IS NOT NULL))
      OR ((g_inbg_d[l_ac].inbg005 != g_inbg_d_t.inbg005 AND g_inbg_d_t.inbg005 IS NOT NULL) OR (g_inbg_d[l_ac].inbg005 IS NOT NULL AND g_inbg_d_t.inbg005 IS NULL) OR (g_inbg_d[l_ac].inbg005 IS NULL AND g_inbg_d_t.inbg005 IS NOT NULL))
      OR ((g_inbg_d[l_ac].inbg006 != g_inbg_d_t.inbg006 AND g_inbg_d_t.inbg006 IS NOT NULL) OR (g_inbg_d[l_ac].inbg006 IS NOT NULL AND g_inbg_d_t.inbg006 IS NULL) OR (g_inbg_d[l_ac].inbg006 IS NULL AND g_inbg_d_t.inbg006 IS NOT NULL))
      OR ((g_inbg_d[l_ac].inbg007 != g_inbg_d_t.inbg007 AND g_inbg_d_t.inbg007 IS NOT NULL) OR (g_inbg_d[l_ac].inbg007 IS NOT NULL AND g_inbg_d_t.inbg007 IS NULL) OR (g_inbg_d[l_ac].inbg007 IS NULL AND g_inbg_d_t.inbg007 IS NOT NULL))
      OR ((g_inbg_d[l_ac].inbg008 != g_inbg_d_t.inbg008 AND g_inbg_d_t.inbg008 IS NOT NULL) OR (g_inbg_d[l_ac].inbg008 IS NOT NULL AND g_inbg_d_t.inbg008 IS NULL) OR (g_inbg_d[l_ac].inbg008 IS NULL AND g_inbg_d_t.inbg008 IS NOT NULL))
      OR ((g_inbg_d[l_ac].inbg009 != g_inbg_d_t.inbg009 AND g_inbg_d_t.inbg009 IS NOT NULL) OR (g_inbg_d[l_ac].inbg009 IS NOT NULL AND g_inbg_d_t.inbg009 IS NULL) OR (g_inbg_d[l_ac].inbg009 IS NULL AND g_inbg_d_t.inbg009 IS NOT NULL))     
      OR ((g_inbg_d[l_ac].inbg010 != g_inbg_d_t.inbg010 AND g_inbg_d_t.inbg010 IS NOT NULL) OR (g_inbg_d[l_ac].inbg010 IS NOT NULL AND g_inbg_d_t.inbg010 IS NULL) OR (g_inbg_d[l_ac].inbg010 IS NULL AND g_inbg_d_t.inbg010 IS NOT NULL)) 
      OR (g_inbg_d[l_ac].inbg001 != g_inbg_d_t.inbg001)
      OR (g_inbg_d[l_ac].inbg011 != g_inbg_d_t.inbg011) THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint170_detail_required()
DEFINE l_n   LIKE type_t.num5
CALL cl_set_comp_required("inbg005,inbg006,inbg007,inbg008,inbg009,inbg010,inbg011",FALSE)
   CASE g_inbg_d[l_ac].inbg001   #xj
      WHEN '1'
         CALL cl_set_comp_required("inbg005,inbg011",TRUE)
#      WHEN '2'
#         CALL cl_set_comp_required("inbg006",TRUE)
      WHEN '3'
         CALL cl_set_comp_required("inbg008,inbg011",TRUE)
      WHEN '4'
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM imaf_t WHERE imafent = g_enterprise
           AND imafsite = g_site AND imaf001 = g_inbg_d[l_ac].inbg002
           AND (imaf061 = '1' OR imaf061 = '3')
         IF l_n > 0 THEN
            CALL cl_set_comp_required("inbg007,inbg011",TRUE)
         END IF
      WHEN '5'
         CALL cl_set_comp_required("inbg009,inbg011",TRUE)
      WHEN '6'
         CALL cl_set_comp_required("inbg010,inbg011",TRUE)
   END CASE

END FUNCTION

PRIVATE FUNCTION aint170_detail_exists()
DEFINE l_n  LIKE type_t.num5
DEFINE l_sql STRING
#DEFINE l_inag  RECORD LIKE inag_t.*  #141222-00014#13 add  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企业编号
       inagsite LIKE inag_t.inagsite, #营运据点
       inag001 LIKE inag_t.inag001, #料件编号
       inag002 LIKE inag_t.inag002, #产品特征
       inag003 LIKE inag_t.inag003, #库存管理特征
       inag004 LIKE inag_t.inag004, #库位编号
       inag005 LIKE inag_t.inag005, #储位编号
       inag006 LIKE inag_t.inag006, #批号
       inag007 LIKE inag_t.inag007, #库存单位
       inag008 LIKE inag_t.inag008, #账面库存数量
       inag009 LIKE inag_t.inag009, #实际库存数量
       inag010 LIKE inag_t.inag010, #库存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本库否
       inag013 LIKE inag_t.inag013, #拣货优先序
       inag014 LIKE inag_t.inag014, #最近一次盘点日期
       inag015 LIKE inag_t.inag015, #最后异动日期
       inag016 LIKE inag_t.inag016, #呆滞日期
       inag017 LIKE inag_t.inag017, #第一次入库日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #备置数量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二进位码
       inag024 LIKE inag_t.inag024, #参考单位
       inag025 LIKE inag_t.inag025, #参考数量
       inag026 LIKE inag_t.inag026, #最近一次检验日期
       inag027 LIKE inag_t.inag027, #下次检验日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人员
       inag030 LIKE inag_t.inag030, #留置部门
       inag031 LIKE inag_t.inag031, #留置单号
       inag032 LIKE inag_t.inag032, #基础单位
       inag033 LIKE inag_t.inag033 #基础单位数量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
#DEFINE l_inbh  RECORD LIKE inbh_t.*  #141222-00014#13 add  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inbh RECORD  #庫存異常變更明細檔
       inbhent LIKE inbh_t.inbhent, #企业编号
       inbhsite LIKE inbh_t.inbhsite, #营运据点
       inbhdocno LIKE inbh_t.inbhdocno, #单据编号
       inbhseq LIKE inbh_t.inbhseq, #项次
       inbhseq1 LIKE inbh_t.inbhseq1, #项序
       inbh001 LIKE inbh_t.inbh001, #变更类型
       inbh002 LIKE inbh_t.inbh002, #料件编号
       inbh003 LIKE inbh_t.inbh003, #库位
       inbh004 LIKE inbh_t.inbh004, #储位
       inbh005 LIKE inbh_t.inbh005, #变更前-产品特征
       inbh006 LIKE inbh_t.inbh006, #变更前-库存管理特征
       inbh007 LIKE inbh_t.inbh007, #变更前-批号
       inbh008 LIKE inbh_t.inbh008, #变更前-库存单位
       inbh011 LIKE inbh_t.inbh011, #变更后-产品特征
       inbh012 LIKE inbh_t.inbh012, #变更后-库存管理特征
       inbh013 LIKE inbh_t.inbh013, #变更后-批号
       inbh014 LIKE inbh_t.inbh014, #变更后-库存单位
       inbh017 LIKE inbh_t.inbh017 #变更数量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
#DEFINE l_inai  RECORD LIKE inai_t.*  #141222-00014#13 add  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企业编号
       inaisite LIKE inai_t.inaisite, #营运据点
       inai001 LIKE inai_t.inai001, #料件编号
       inai002 LIKE inai_t.inai002, #产品特征
       inai003 LIKE inai_t.inai003, #库存管理特征
       inai004 LIKE inai_t.inai004, #库位编号
       inai005 LIKE inai_t.inai005, #储位编号
       inai006 LIKE inai_t.inai006, #批号
       inai007 LIKE inai_t.inai007, #制造批号
       inai008 LIKE inai_t.inai008, #制造序号
       inai009 LIKE inai_t.inai009, #库存单位
       inai010 LIKE inai_t.inai010, #账面基础单位库存数量
       inai011 LIKE inai_t.inai011, #实际基础单位库存数量
       inai012 LIKE inai_t.inai012, #制造日期
       inai013 LIKE inai_t.inai013, #Tag二进位码
       inai014 LIKE inai_t.inai014 #基础单位
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
#DEFINE l_inao  RECORD LIKE inao_t.*  #141222-00014#13 add  #161124-00048#5  16/12/09 By 08734 mark
#161124-00048#5  16/12/09 By 08734 add(S)
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
       inao025 LIKE inao_t.inao025 #已退品量
END RECORD
#161124-00048#5  16/12/09 By 08734 add(E)
#141222-00014#13 mark start    
#   IF NOT cl_null(g_inbg_d[g_detail_idx].inbg002) AND g_inbg_d[g_detail_idx].inbg003 IS NOT NULL AND g_inbg_d[g_detail_idx].inbg004 IS NOT NULL AND
#      g_inbg_d[g_detail_idx].inbg005 IS NOT NULL  AND g_inbg_d[g_detail_idx].inbg006 IS NOT NULL AND g_inbg_d[g_detail_idx].inbg007 IS NOT NULL THEN  #141222-00014 #13
#      LET l_sql = "SELECT COUNT(*) FROM inbg_t WHERE inbgent = ",g_enterprise,
#                  "   AND inbgdocno = '",g_inbf_m.inbfdocno,"' AND inbgseq <> ",g_inbg_d[g_detail_idx].inbgseq
# #     IF NOT cl_null(g_inbg_d[l_ac].inbg002) THEN
#         LET l_sql = l_sql," AND inbg002 = '",g_inbg_d[g_detail_idx].inbg002,"'"
# #     END IF
#      
# #     IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inbg003 = '",g_inbg_d[g_detail_idx].inbg003,"'"
# #     END IF
#      
# #     IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inbg004 = '",g_inbg_d[g_detail_idx].inbg004,"'"
# #     END IF
#      
# #     IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inbg005 = '",g_inbg_d[g_detail_idx].inbg005,"'"
# #     END IF
#      
# #     IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inbg006 = '",g_inbg_d[g_detail_idx].inbg006,"'"
# #     END IF
#      
# #     IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inbg007 = '",g_inbg_d[g_detail_idx].inbg007,"'"
# #     END IF
#      
#      PREPARE detail_exists_prep FROM l_sql
#      LET l_n = 0
#      EXECUTE detail_exists_prep INTO l_n
#      IF l_n > 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'ain-00215'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      
#         RETURN FALSE
#      END IF
#   END IF
#141222-00014#13 mark end
#141222-00014#13 add start
   LET l_sql = "SELECT COUNT(*) FROM inbh_t WHERE inbhent = ",g_enterprise,
               "   AND inbhsite = '",g_site,"' AND inbh002 = ? AND inbh003 = ?",
               "   AND inbh004 = ? AND inbh005 = ? AND inbh006 = ? ",
               "   AND inbh007 = ? AND inbh008 = ? AND inbhdocno = '",g_inbf_m.inbfdocno,"'",
               "   AND inbhseq <> ",g_inbg_d[l_ac].inbgseq
   PREPARE sel_inbh_prep1 FROM l_sql
   
   IF g_inbg_d[l_ac].inbg001 NOT MATCHES '[56]' THEN
      #LET l_sql = "SELECT * FROM inag_t WHERE inagent = ",g_enterprise,  #161124-00048#5  16/12/09 By 08734 mark
      LET l_sql = "SELECT inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,inag009,inag010,inag011,inag012,inag013,inag014,inag015,inag016,inag017,inag018,inag019,inag020,inag021,inag022,inag023,inag024,inag025,inag026,inag027,inag028,inag029,inag030,inag031,inag032,inag033 FROM inag_t WHERE inagent = ",g_enterprise,  #161124-00048#5  16/12/09 By 08734 add
                  " AND inagsite = '",g_site,"' AND inag001 = '",g_inbg_d[l_ac].inbg002,"' AND inag008 <> 0 "
      IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag004 = '",g_inbg_d[l_ac].inbg003,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag005 = '",g_inbg_d[l_ac].inbg004,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag002 = '",g_inbg_d[l_ac].inbg005,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag003 = '",g_inbg_d[l_ac].inbg006,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag006 = '",g_inbg_d[l_ac].inbg007,"'"
      END IF
      
      IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
         LET l_sql = l_sql," AND inag007 = '",g_inbg_d[l_ac].inbg008,"'"
      END IF
      PREPARE sel_inag_prep2 FROM l_sql
      DECLARE sel_inag_curs2 CURSOR FOR sel_inag_prep2
      
      
#      LET l_cnt = 1
      FOREACH sel_inag_curs2 INTO l_inag.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
#         LET l_inbh.inbhent = g_enterprise
#         LET l_inbh.inbhsite = g_site
#         LET l_inbh.inbhdocno = g_inbf_m.inbfdocno
#         LET l_inbh.inbhseq = g_inbg_d[l_ac].inbgseq
#         LET l_inbh.inbhseq1 = l_cnt
#         LET l_inbh.inbh001 = g_inbg_d[l_ac].inbg001
         LET l_inbh.inbh002 = l_inag.inag001
         LET l_inbh.inbh003 = l_inag.inag004
         LET l_inbh.inbh004 = l_inag.inag005
         LET l_inbh.inbh005 = l_inag.inag002
         LET l_inbh.inbh006 = l_inag.inag003
         LET l_inbh.inbh007 = l_inag.inag006
         LET l_inbh.inbh008 = l_inag.inag007 
         
         LET l_n = 0
         EXECUTE sel_inbh_prep1 USING l_inbh.inbh002,l_inbh.inbh003,l_inbh.inbh004,
                                      l_inbh.inbh005,l_inbh.inbh006,l_inbh.inbh007,l_inbh.inbh008
                                 INTO l_n
         IF l_n > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00739'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
#         CASE 
#            WHEN g_inbg_d[l_ac].inbg001 = '1'
#               LET l_inbh.inbh011 = g_inbg_d[l_ac].inbg011
#               LET l_inbh.inbh012 = l_inag.inag003
#               LET l_inbh.inbh013 = l_inag.inag006
#               LET l_inbh.inbh014 = l_inag.inag007
#            WHEN g_inbg_d[l_ac].inbg001 = '2'
#               LET l_inbh.inbh011 = l_inag.inag002
#               LET l_inbh.inbh012 = g_inbg_d[l_ac].inbg011
#               LET l_inbh.inbh013 = l_inag.inag006
#               LET l_inbh.inbh014 = l_inag.inag007
#            WHEN g_inbg_d[l_ac].inbg001 = '3'
#               LET l_inbh.inbh011 = l_inag.inag002
#               LET l_inbh.inbh012 = l_inag.inag003
#               LET l_inbh.inbh013 = l_inag.inag006
#               LET l_inbh.inbh014 = g_inbg_d[l_ac].inbg011
#            WHEN g_inbg_d[l_ac].inbg001 = '4'
#               LET l_inbh.inbh011 = l_inag.inag002
#               LET l_inbh.inbh012 = l_inag.inag003
#               LET l_inbh.inbh013 = g_inbg_d[l_ac].inbg011
#               LET l_inbh.inbh014 = l_inag.inag007
#
#         END CASE    
#         LET l_inbh.inbh017 = l_inag.inag008
#         INSERT INTO inbh_t VALUES (l_inbh.*)
#         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
#            EXIT FOREACH
#         END IF
#         LET l_cnt = l_cnt + 1
      END FOREACH
   END IF
   

   #LET l_sql = "SELECT * FROM inai_t WHERE inaient = ",g_enterprise,  #161124-00048#5  16/12/09 By 08734 mark
   LET l_sql = "SELECT inaient,inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008,inai009,inai010,inai011,inai012,inai013,inai014 FROM inai_t WHERE inaient = ",g_enterprise,  #161124-00048#5  16/12/09 By 08734 add
               " AND inaisite = '",g_site,"' AND inai001 = '",g_inbg_d[l_ac].inbg002,"' AND inai010 > 0 "
   IF g_inbg_d[l_ac].inbg003 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai004 = '",g_inbg_d[l_ac].inbg003,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg004 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai005 = '",g_inbg_d[l_ac].inbg004,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg005 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai002 = '",g_inbg_d[l_ac].inbg005,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg006 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai003 = '",g_inbg_d[l_ac].inbg006,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg001 MATCHES '[56]' THEN
      IF g_inbg_d[l_ac].inbg008 IS NOT NULL THEN
         LET l_sql = l_sql," AND inai009 = '",g_inbg_d[l_ac].inbg008,"'"
      END IF
   END IF
   
   IF g_inbg_d[l_ac].inbg007 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai006 = '",g_inbg_d[l_ac].inbg007,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg009 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai007 = '",g_inbg_d[l_ac].inbg009,"'"
   END IF
   
   IF g_inbg_d[l_ac].inbg010 IS NOT NULL THEN
      LET l_sql = l_sql," AND inai008 = '",g_inbg_d[l_ac].inbg010,"'"
   END IF
   PREPARE sel_inai_prep2 FROM l_sql
   DECLARE sel_inai_curs2 CURSOR FOR sel_inai_prep2
   
   LET l_sql = "SELECT COUNT(*) FROM inao_t WHERE inaoent = ",g_enterprise,
               "   AND inaosite = '",g_site,"' AND inaodocno = '",g_inbf_m.inbfdocno,"'",
               "   AND inao001 = ? AND inao002 = ? AND inao003 = ? AND inao005 = ? ",
               "   AND inao006 = ? AND inao007 = ? AND inao008 = ? AND inao009 = ? ",
               "   AND inaoseq <> ",g_inbg_d[l_ac].inbgseq             
   PREPARE sel_inao_prep1 FROM l_sql
   
#   LET l_cnt = 1
   FOREACH sel_inai_curs2 INTO l_inai.*
      
#      LET l_inao.inaoent = g_enterprise
#      LET l_inao.inaosite = g_site
#      LET l_inao.inaodocno = g_inbf_m.inbfdocno
#      LET l_inao.inaoseq = g_inbg_d[l_ac].inbgseq
#      LET l_inao.inaoseq1 = l_cnt
#      LET l_inao.inaoseq2 = 1
#      LET l_inao.inao000 = '2'
      LET l_inao.inao001 = l_inai.inai001
      LET l_inao.inao002 = l_inai.inai002
      LET l_inao.inao003 = l_inai.inai003
      LET l_inao.inao005 = l_inai.inai004
      LET l_inao.inao006 = l_inai.inai005
      LET l_inao.inao007 = l_inai.inai006
      LET l_inao.inao008 = l_inai.inai007
      LET l_inao.inao009 = l_inai.inai008
      
      LET l_n = 0
      EXECUTE sel_inao_prep1 USING l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao005,
                                   l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009
                               INTO l_n
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00740'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
          
         RETURN FALSE
      END IF
      
#      LET l_inao.inao012 = l_inai.inai010
#      LET l_inao.inao013 = -1
#      LET l_inao.inao014 = l_inai.inai009
#      LET l_inao.inao010 = l_inai.inai012
      #新增变更前
#      INSERT INTO inao_t VALUES(l_inao.*)
#      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
#         EXIT FOREACH
#      END IF
      
      #新增变更后
#      LET l_inao.inaoseq2 = 2
#      LET l_inao.inao013 = 1
#      CASE WHEN g_inbg_d[l_ac].inbg001 = '1'
#              LET l_inao.inao002 = g_inbg_d[l_ac].inbg011
#              LET l_inao.inao003 = l_inai.inai003
#              LET l_inao.inao007 = l_inai.inai006
#              LET l_inao.inao008 = l_inai.inai007
#              LET l_inao.inao009 = l_inai.inai008
#           WHEN g_inbg_d[l_ac].inbg001 = '2'
#              LET l_inao.inao002 = l_inai.inai002
#              LET l_inao.inao003 = g_inbg_d[l_ac].inbg011
#              LET l_inao.inao007 = l_inai.inai006
#              LET l_inao.inao008 = l_inai.inai007
#              LET l_inao.inao009 = l_inai.inai008
#           WHEN g_inbg_d[l_ac].inbg001 = '4'
#              LET l_inao.inao002 = l_inai.inai002
#              LET l_inao.inao003 = l_inai.inai003
#              LET l_inao.inao007 = g_inbg_d[l_ac].inbg011
#              LET l_inao.inao008 = l_inai.inai007
#              LET l_inao.inao009 = l_inai.inai008
#           WHEN g_inbg_d[l_ac].inbg001 ='5'
#              LET l_inao.inao002 = l_inai.inai002
#              LET l_inao.inao003 = l_inai.inai003
#              LET l_inao.inao007 = l_inai.inai006
#              LET l_inao.inao008 = g_inbg_d[l_ac].inbg011
#              LET l_inao.inao009 = l_inai.inai008
#           WHEN g_inbg_d[l_ac].inbg001 ='6'
#              LET l_inao.inao002 = l_inai.inai002
#              LET l_inao.inao003 = l_inai.inai003
#              LET l_inao.inao007 = l_inai.inai006
#              LET l_inao.inao008 = l_inai.inai007
#              LET l_inao.inao009 = g_inbg_d[l_ac].inbg011
#      END CASE
#      INSERT INTO inao_t VALUES(l_inao.*)
#      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
#         EXIT FOREACH
#      END IF
#      LET l_cnt = l_cnt + 1
   END FOREACH
#141222-00014#13 add end
   RETURN TRUE
END FUNCTION

 
{</section>}
 
