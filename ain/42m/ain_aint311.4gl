#該程式未解開Section, 採用最新樣板產出!
{<section id="aint311.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0026(2017-02-23 19:20:16), PR版次:0026(2017-02-23 19:29:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000217
#+ Filename...: aint311
#+ Description: 庫存報廢除帳作業
#+ Creator....: 01996(2014-04-22 12:21:49)
#+ Modifier...: 01258 -SD/PR- 01258
 
{</section>}
 
{<section id="aint311.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151222-00011#1    160325   by xujing   修正带不出储位名称的问题
#160315-00009#1    160325   by xujing   修正归属部门的检核
#160318-00025#16   16/04/11 By 07900    重复错误讯息修改
#160330-00017#1    16/04/18 By xujing   增加报废原因栏位相关逻
#160330-00018#1    16/04/18 By xujing   单身预设inbjsite
#160420-00024#1    16/05/31 By lixh     点修改时过账日期栏位报错且无法正常关闭作业
#160613-00038#1    16/06/14 By 06821    s_aooi200_chk_slip傳入值(原寫死程式代號)，改用g_prog處理
#160705-00042#7    16/07/15 By 02159    把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#160812-00017#3    16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#16   16/08/24 By lixh     单据类作业修改，删除时需重新检查状态
#160831-00070#6    16/10/03 By 06137    增加扫码录入功能scan_barcode(aint311)
#161118-00011#1    16/11/18 By wuxja    整单操作新增后需退出当前新增状态，防止再走INSERT
#161124-00048#5    16/12/12 By 08734    星号整批调整
#161219-00024#1    16/12/19 By Jessica  單身二 s_detail2 為排除控件，_send()請增加CALL cl_bpm_set_detail_data()
#160824-00007#280  16/12/29 By lori     修正舊值備份寫法
#170112-00038#1    17/01/12 By wuxja    1、可报废量检查需扣除本次的数量，2、新增时需同步新增inbj013
#170113-00044#1    17/01/16 By wuxja    查询资料时需加上inbi000=‘2’的条件
#170118-00015#1    17/01/18 By catmoon47 由申請單拋轉來時，如果兩筆單身完全一樣，會導致數量計算錯誤
#170123-00003#1    17/01/24 By Ann_Huang 1.由申請單拋轉自動帶入單身時,在計算l_deff_num數量計算錯誤,抓出報廢申請單的數量(l_inaq011)在過帳時會更新inaq011數量, 
#                                          故在取得申請數量總和(l_inbj009_sum)應該排除已過帳單據,否則會重複扣除
#                                        2.修正#170118-00015#1的問題,單身相同的料倉儲但申請數量不同,在取得申請單號拋轉的數據時,數量計算錯誤,
#                                          應排除本身除帳單據單號(inbidocno),才不會重複計算
#160604-00034#3    2017/02/06 By lixh    單據的單據日期及過帳日期應依aoos020裡"進銷存單據日期控管方式"、"進銷存過帳日期控管方式"處理,
#                                        如參數設定為"不可修改"時，則新增、修改時，都不可異動該欄位資料
#170209-00021#1    2016/02/09  By wuxja  查询sum（inbj009）时排除已过帐单据
#160711-00040#15   2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#170222-00045#1    2017/02/23 By wuxja    异动数量后需计算参考数量、实际数量等
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
PRIVATE type type_g_inbi_m        RECORD
       inbidocno LIKE inbi_t.inbidocno, 
   inbidocno_desc LIKE type_t.chr80, 
   inbidocdt LIKE inbi_t.inbidocdt, 
   inbi007 LIKE inbi_t.inbi007, 
   inbi000 LIKE inbi_t.inbi000, 
   inbi001 LIKE inbi_t.inbi001, 
   inbi001_desc LIKE type_t.chr80, 
   inbi002 LIKE inbi_t.inbi002, 
   inbi002_desc LIKE type_t.chr80, 
   inbi031 LIKE inbi_t.inbi031, 
   inbi032 LIKE inbi_t.inbi032, 
   inbi003 LIKE inbi_t.inbi003, 
   inbi003_desc LIKE type_t.chr80, 
   inbi021 LIKE inbi_t.inbi021, 
   inbi004 LIKE inbi_t.inbi004, 
   inbisite LIKE inbi_t.inbisite, 
   inbistus LIKE inbi_t.inbistus, 
   inbiownid LIKE inbi_t.inbiownid, 
   inbiownid_desc LIKE type_t.chr80, 
   inbiowndp LIKE inbi_t.inbiowndp, 
   inbiowndp_desc LIKE type_t.chr80, 
   inbicrtid LIKE inbi_t.inbicrtid, 
   inbicrtid_desc LIKE type_t.chr80, 
   inbicrtdp LIKE inbi_t.inbicrtdp, 
   inbicrtdp_desc LIKE type_t.chr80, 
   inbicrtdt LIKE inbi_t.inbicrtdt, 
   inbimodid LIKE inbi_t.inbimodid, 
   inbimodid_desc LIKE type_t.chr80, 
   inbimoddt LIKE inbi_t.inbimoddt, 
   inbicnfid LIKE inbi_t.inbicnfid, 
   inbicnfid_desc LIKE type_t.chr80, 
   inbicnfdt LIKE inbi_t.inbicnfdt, 
   inbipstid LIKE inbi_t.inbipstid, 
   inbipstid_desc LIKE type_t.chr80, 
   inbipstdt LIKE inbi_t.inbipstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_inbj_d        RECORD
       inbjseq LIKE inbj_t.inbjseq, 
   inbj001 LIKE inbj_t.inbj001, 
   inbj001_desc LIKE type_t.chr500, 
   inbj001_desc_desc LIKE type_t.chr500, 
   inbj002 LIKE inbj_t.inbj002, 
   inbj002_desc LIKE type_t.chr500, 
   inbj005 LIKE inbj_t.inbj005, 
   inbj005_desc LIKE type_t.chr500, 
   inbj006 LIKE inbj_t.inbj006, 
   inbj006_desc LIKE type_t.chr500, 
   inbj007 LIKE inbj_t.inbj007, 
   inbj003 LIKE inbj_t.inbj003, 
   inbj008 LIKE inbj_t.inbj008, 
   inbj016 LIKE inbj_t.inbj016, 
   inbj016_desc LIKE type_t.chr500, 
   inbj017 LIKE inbj_t.inbj017, 
   inbj017_desc LIKE type_t.chr500, 
   inbj018 LIKE inbj_t.inbj018, 
   inbj009 LIKE inbj_t.inbj009, 
   inbj011 LIKE inbj_t.inbj011, 
   inbj012 LIKE inbj_t.inbj012, 
   inbj004 LIKE inbj_t.inbj004, 
   inbj014 LIKE inbj_t.inbj014, 
   inbj014_desc LIKE type_t.chr500, 
   inbj015 LIKE inbj_t.inbj015, 
   inbj015_desc LIKE type_t.chr500, 
   inbj019 LIKE inbj_t.inbj019, 
   inbj019_desc LIKE type_t.chr500, 
   inbj020 LIKE inbj_t.inbj020, 
   inbj020_desc LIKE type_t.chr500, 
   inbj021 LIKE inbj_t.inbj021, 
   inbj021_desc LIKE type_t.chr500, 
   inbj031 LIKE inbj_t.inbj031, 
   inbjsite LIKE inbj_t.inbjsite, 
   inbj010 LIKE inbj_t.inbj010, 
   inbj013 LIKE inbj_t.inbj013
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_inbidocno LIKE inbi_t.inbidocno,
   b_inbidocno_desc LIKE type_t.chr80,
      b_inbidocdt LIKE inbi_t.inbidocdt,
      b_inbi007 LIKE inbi_t.inbi007,
      b_inbi001 LIKE inbi_t.inbi001,
   b_inbi001_desc LIKE type_t.chr80,
      b_inbi002 LIKE inbi_t.inbi002,
   b_inbi002_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_ooef                RECORD LIKE ooef_t.*  #161124-00048#5  16/12/12 By 08734 mark
#161124-00048#5  16/12/12 By 08734 add(S)
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
#161124-00048#5  16/12/12 By 08734 add(E)
DEFINE g_acc       LIKE gzcb_t.gzcb004
 TYPE type_g_inbj2_d        RECORD
                 inaoseq   LIKE inao_t.inaoseq,
                 inaoseq1  LIKE inao_t.inaoseq1,
                 inao001   LIKE inao_t.inao001,
                 imaal003  LIKE imaal_t.imaal003,
                 imaal004  LIKE imaal_t.imaal004,
                 inao008   LIKE inao_t.inao008,
                 inao009   LIKE inao_t.inao009,
                 inao010   LIKE inao_t.inao010,
                 inao012   LIKE inao_t.inao012
                               END RECORD
DEFINE g_inbj2_d          DYNAMIC ARRAY OF type_g_inbj2_d
DEFINE g_auto_flag        LIKE type_t.num5
DEFINE g_stus   LIKE type_t.chr1
DEFINE g_para   LIKE type_t.chr1
#DEFINE g_inav   RECORD LIKE inav_t.*  #161124-00048#5  16/12/12 By 08734 mark
#161124-00048#5  16/12/12 By 08734 add(S)
DEFINE g_inav RECORD  #製造批序號庫存報廢明細檔
       inavent LIKE inav_t.inavent, #企业编号
       inavsite LIKE inav_t.inavsite, #营运据点
       inav001 LIKE inav_t.inav001, #料件编号
       inav002 LIKE inav_t.inav002, #产品特征
       inav003 LIKE inav_t.inav003, #库存管理特征
       inav004 LIKE inav_t.inav004, #待报废库位
       inav005 LIKE inav_t.inav005, #待报废储位
       inav006 LIKE inav_t.inav006, #批号
       inav007 LIKE inav_t.inav007, #库存单位
       inav008 LIKE inav_t.inav008, #报废原因
       inav009 LIKE inav_t.inav009, #归属单号
       inav010 LIKE inav_t.inav010, #归属部门
       inav011 LIKE inav_t.inav011, #序号
       inav012 LIKE inav_t.inav012, #制造批号
       inav013 LIKE inav_t.inav013, #制造序号
       inav014 LIKE inav_t.inav014, #制造日期
       inav015 LIKE inav_t.inav015, #有效日期
       inav016 LIKE inav_t.inav016, #数量
       inav017 LIKE inav_t.inav017 #已报废量
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
#end add-point
       
#模組變數(Module Variables)
DEFINE g_inbi_m          type_g_inbi_m
DEFINE g_inbi_m_t        type_g_inbi_m
DEFINE g_inbi_m_o        type_g_inbi_m
DEFINE g_inbi_m_mask_o   type_g_inbi_m #轉換遮罩前資料
DEFINE g_inbi_m_mask_n   type_g_inbi_m #轉換遮罩後資料
 
   DEFINE g_inbidocno_t LIKE inbi_t.inbidocno
 
 
DEFINE g_inbj_d          DYNAMIC ARRAY OF type_g_inbj_d
DEFINE g_inbj_d_t        type_g_inbj_d
DEFINE g_inbj_d_o        type_g_inbj_d
DEFINE g_inbj_d_mask_o   DYNAMIC ARRAY OF type_g_inbj_d #轉換遮罩前資料
DEFINE g_inbj_d_mask_n   DYNAMIC ARRAY OF type_g_inbj_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="aint311.main" >}
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
   #SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site  #161124-00048#5  16/12/12 By 08734 mark
   SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,ooef005,ooef006,ooef007,ooef008,ooef009,ooef010,ooef011,ooef012,ooef013,ooefownid,ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,ooefmoddt,ooef014,ooef015,ooef016,ooef017,ooef018,ooef019,ooef020,ooef021,ooef022,ooef003,ooef023,ooef024,ooef025,ooef026,ooef100,ooef101,ooef102,ooef103,ooef104,ooef105,ooef106,ooef107,ooef108,ooef109,ooef110,ooef111,ooef112,ooef113,ooef114,ooef115,ooef120,ooef121,ooef122,ooef123,ooef124,ooef125,
       ooef150,ooef151,ooef152,ooef153,ooef154,ooef155,ooef156,ooef157,ooef158,ooef159,ooef160,ooef161,ooef162,ooef163,ooef164,ooef165,ooef166,ooef167,ooef168,ooef169,ooef170,ooef171,ooef172,ooef173,ooefunit,ooef200,ooef201,ooef202,ooef203,ooef204,ooef205,ooef206,ooef207,ooef208,ooef209,ooef210,ooef211,ooef212,ooef213,ooef214,ooef215,ooef216,ooef217,ooef301,ooef302,ooef303,ooef304,ooef305,ooef306,ooef307,ooef308,ooef309,ooef310,ooef126,ooef127,ooef128,ooef116  
      INTO g_ooef.* FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site    #161124-00048#5  16/12/12 By 08734 add
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint311'                            #160705-00042#7 160715 by sakura mark
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#7 160715 by sakura add 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT inbidocno,'',inbidocdt,inbi007,inbi000,inbi001,'',inbi002,'',inbi031, 
       inbi032,inbi003,'',inbi021,inbi004,inbisite,inbistus,inbiownid,'',inbiowndp,'',inbicrtid,'',inbicrtdp, 
       '',inbicrtdt,inbimodid,'',inbimoddt,inbicnfid,'',inbicnfdt,inbipstid,'',inbipstdt", 
                      " FROM inbi_t",
                      " WHERE inbient= ? AND inbidocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint311_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inbidocno,t0.inbidocdt,t0.inbi007,t0.inbi000,t0.inbi001,t0.inbi002, 
       t0.inbi031,t0.inbi032,t0.inbi003,t0.inbi021,t0.inbi004,t0.inbisite,t0.inbistus,t0.inbiownid,t0.inbiowndp, 
       t0.inbicrtid,t0.inbicrtdp,t0.inbicrtdt,t0.inbimodid,t0.inbimoddt,t0.inbicnfid,t0.inbicnfdt,t0.inbipstid, 
       t0.inbipstdt,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooag011 ,t10.ooag011",
               " FROM inbi_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inbi001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbi002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='302' AND t3.oocql002=t0.inbi003 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.inbiownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.inbiowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inbicrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.inbicrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inbimodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.inbicnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.inbipstid  ",
 
               " WHERE t0.inbient = " ||g_enterprise|| " AND t0.inbidocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint311_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint311 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint311_init()   
 
      #進入選單 Menu (="N")
      CALL aint311_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_lot_sel_drop_tmp()
      CALL s_aint311_lot_sel_drop_tmp()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint311
      
   END IF 
   
   CLOSE aint311_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint311.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint311_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_para   LIKE type_t.chr1
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
      CALL cl_set_combo_scc_part('inbistus','13','N,O,S,A,D,R,W,X,Z')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_lot_sel_create_tmp()
   CALL s_aint311_lot_sel_create_tmp()
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0028') RETURNING l_para
   CALL cl_set_comp_visible("inbj011,inbj012",TRUE)
   IF l_para = 'N' THEN
      CALL cl_set_comp_visible("inbj011,inbj012",FALSE)
   END IF
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN 
      CALL cl_set_comp_visible("inbj002,inbj002_desc",FALSE)
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL aint311_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint311.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint311_ui_dialog()
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
   DEFINE l_imaf053 LIKE imaf_t.imaf053
   DEFINE l_cnt     LIKE type_t.num5   
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
            CALL aint311_insert()
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
         INITIALIZE g_inbi_m.* TO NULL
         CALL g_inbj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint311_init()
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
               
               CALL aint311_fetch('') # reload data
               LET l_ac = 1
               CALL aint311_ui_detailshow() #Setting the current row 
         
               CALL aint311_idx_chk()
               #NEXT FIELD inbjseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_inbj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint311_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL aint311_inao_b_fill()
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
               CALL aint311_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ins_inao
            LET g_action_choice="ins_inao"
            IF cl_auth_chk_act("ins_inao") THEN
               
               #add-point:ON ACTION ins_inao name="menu.detail_show.page1.ins_inao"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_inbj_d[l_ac].inbj001) AND NOT cl_null(g_inbj_d[l_ac].inbj005) AND NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
                    # IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
                      IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) THEN
                        IF g_para = 'N' THEN
                           CALL s_transaction_begin()
                           SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                           CALL s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) RETURNING g_success
                           IF g_success THEN
                              CALL s_transaction_end('Y','0')
                              CALL aint311_inao_b_fill()
                           ELSE
                              CALL s_transaction_end('N','0')
                           END IF
#                           IF aint311_inao_exists() THEN
#                              IF NOT aint311_inao_ins(g_inbj_d[l_ac].inbjseq) THEN
#                                 INITIALIZE g_errparam TO NULL 
#                                 LET g_errparam.extend = "inao_t" 
#                                 LET g_errparam.code   = "std-00006"
#                                 LET g_errparam.popup  = TRUE 
#                                 CALL cl_err()
#                                 CALL s_transaction_end('N','1')
#                              ELSE
#                                 CALL s_transaction_end('Y','0')
#                                 CALL aint311_inao_b_fill()
#                              END IF
#                           END IF
                        ELSE
                           CALL s_transaction_begin()
                           CALL aint311_default_inav(g_inbj_d[l_ac].*)
                           IF s_aint311_lot_sel(g_inav.*,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq) THEN
                              CALL s_transaction_end('Y','0')
                              CALL aint311_inao_b_fill()
                           ELSE
                              CALL s_transaction_end('N','0')
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_inbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
            BEFORE DISPLAY 
               CALL aint311_inao_b_fill()            
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aint311_browser_fill("")
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
               CALL aint311_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint311_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint311_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint311_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint311_set_act_visible()   
            CALL aint311_set_act_no_visible()
            IF NOT (g_inbi_m.inbidocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " inbient = " ||g_enterprise|| " AND",
                                  " inbidocno = '", g_inbi_m.inbidocno, "' "
 
               #填到對應位置
               CALL aint311_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "inbi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbj_t" 
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
               CALL aint311_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "inbi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbj_t" 
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
                  CALL aint311_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint311_fetch("F")
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
               CALL aint311_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint311_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint311_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint311_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint311_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint311_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint311_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint311_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint311_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint311_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint311_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_inbj_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_inbj2_d)
                  LET g_export_id[2]   = "s_detail2"
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
               NEXT FIELD inbjseq
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
               CALL aint311_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint311_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint311_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ins_detial
            LET g_action_choice="ins_detial"
            IF cl_auth_chk_act("ins_detial") THEN
               
               #add-point:ON ACTION ins_detial name="menu.ins_detial"
               CALL aint311_01(g_inbi_m.inbidocno)
               CALL aint311_b_fill()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint311_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " inbient = ",g_enterprise," AND inbidocno ='",g_inbi_m.inbidocno,"'"
               #END add-point
               &include "erp/ain/aint311_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " inbient = ",g_enterprise," AND inbidocno ='",g_inbi_m.inbidocno,"'"
               #END add-point
               &include "erp/ain/aint311_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint311_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION scan_barcode
            LET g_action_choice="scan_barcode"
            IF cl_auth_chk_act("scan_barcode") THEN
               
               #add-point:ON ACTION scan_barcode name="menu.scan_barcode"
               #160831-00070#6# Add By ken 161004(S)
               #单头无资料，不可点击
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM inbi_t
                WHERE inbient = g_enterprise
                  AND inbidocno = g_inbi_m.inbidocno
                  AND inbistus = 'N'
                  AND (inbi031 IS NULL OR inbi031 = '')
               IF l_cnt < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asl-00028'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               #写入扫码录入临时表资料
               CALL s_scancode_aint311_ins_tmp(g_inbi_m.inbidocno)
               CALL aint311_b_fill()
               #160831-00070#6# Add By ken 161004(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inbi031
            LET g_action_choice="prog_inbi031"
            IF cl_auth_chk_act("prog_inbi031") THEN
               
               #add-point:ON ACTION prog_inbi031 name="menu.prog_inbi031"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint310'
               LET la_param.param[1] = g_inbi_m.inbi031

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint311_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint311_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint311_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_inbi_m.inbidocdt)
 
 
 
         
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
 
{<section id="aint311.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint311_browser_fill(ps_page_action)
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
   LET l_wc = l_wc," AND inbisite ='",g_site,"'"
   LET l_wc = l_wc," AND inbi000 = '2' "     #170113-00044#1 add
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT inbidocno ",
                      " FROM inbi_t ",
                      " ",
                      " LEFT JOIN inbj_t ON inbjent = inbient AND inbidocno = inbjdocno ", "  ",
                      #add-point:browser_fill段sql(inbj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE inbient = " ||g_enterprise|| " AND inbjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("inbi_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT inbidocno ",
                      " FROM inbi_t ", 
                      "  ",
                      "  ",
                      " WHERE inbient = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("inbi_t")
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
      INITIALIZE g_inbi_m.* TO NULL
      CALL g_inbj_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.inbidocno,t0.inbidocdt,t0.inbi007,t0.inbi001,t0.inbi002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbistus,t0.inbidocno,t0.inbidocdt,t0.inbi007,t0.inbi001,t0.inbi002, 
          t1.oobxl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM inbi_t t0",
                  "  ",
                  "  LEFT JOIN inbj_t ON inbjent = inbient AND inbidocno = inbjdocno ", "  ", 
                  #add-point:browser_fill段sql(inbj_t1) name="browser_fill.join.inbj_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN oobxl_t t1 ON t1.oobxlent="||g_enterprise||" AND t1.oobxl001=t0.inbidocno AND t1.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inbi001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbi002 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inbient = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("inbi_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbistus,t0.inbidocno,t0.inbidocdt,t0.inbi007,t0.inbi001,t0.inbi002, 
          t1.oobxl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM inbi_t t0",
                  "  ",
                                 " LEFT JOIN oobxl_t t1 ON t1.oobxlent="||g_enterprise||" AND t1.oobxl001=t0.inbidocno AND t1.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inbi001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbi002 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inbient = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("inbi_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY inbidocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"inbi_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inbidocno,g_browser[g_cnt].b_inbidocdt, 
          g_browser[g_cnt].b_inbi007,g_browser[g_cnt].b_inbi001,g_browser[g_cnt].b_inbi002,g_browser[g_cnt].b_inbidocno_desc, 
          g_browser[g_cnt].b_inbi001_desc,g_browser[g_cnt].b_inbi002_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL s_aooi200_get_slip(g_browser[g_cnt].b_inbidocno) RETURNING g_success,l_slip
      CALL s_aooi200_get_slip_desc(l_slip) RETURNING g_browser[g_cnt].b_inbidocno_desc
      DISPLAY BY NAME g_browser[g_cnt].b_inbidocno_desc
         #end add-point
      
         #遮罩相關處理
         CALL aint311_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "O"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirm_transfer_out.png"
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
         WHEN "Z"
            LET g_browser[g_cnt].b_statepic = "stus/16/unposted.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_inbidocno) THEN
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
   CALL aint311_fetch('')
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint311_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_inbi_m.inbidocno = g_browser[g_current_idx].b_inbidocno   
 
   EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
       g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
       g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
       g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
       g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
       g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbipstid_desc
   
   CALL aint311_inbi_t_mask()
   CALL aint311_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint311.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint311_ui_detailshow()
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
 
{<section id="aint311.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint311_ui_browser_refresh()
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
      IF g_browser[l_i].b_inbidocno = g_inbi_m.inbidocno 
 
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
 
{<section id="aint311.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint311_construct()
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
   INITIALIZE g_inbi_m.* TO NULL
   CALL g_inbj_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON inbidocno,inbidocdt,inbi007,inbi001,inbi002,inbi031,inbi032,inbi003, 
          inbi021,inbistus,inbiownid,inbiowndp,inbicrtid,inbicrtdp,inbicrtdt,inbimodid,inbimoddt,inbicnfid, 
          inbicnfdt,inbipstid,inbipstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inbicrtdt>>----
         AFTER FIELD inbicrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inbimoddt>>----
         AFTER FIELD inbimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbicnfdt>>----
         AFTER FIELD inbicnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbipstdt>>----
         AFTER FIELD inbipstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.inbidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbidocno
            #add-point:ON ACTION controlp INFIELD inbidocno name="construct.c.inbidocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inbi000 = '2'"
            CALL q_inbidocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbidocno  #顯示到畫面上
            NEXT FIELD inbidocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbidocno
            #add-point:BEFORE FIELD inbidocno name="construct.b.inbidocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbidocno
            
            #add-point:AFTER FIELD inbidocno name="construct.a.inbidocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbidocdt
            #add-point:BEFORE FIELD inbidocdt name="construct.b.inbidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbidocdt
            
            #add-point:AFTER FIELD inbidocdt name="construct.a.inbidocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbidocdt
            #add-point:ON ACTION controlp INFIELD inbidocdt name="construct.c.inbidocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi007
            #add-point:BEFORE FIELD inbi007 name="construct.b.inbi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi007
            
            #add-point:AFTER FIELD inbi007 name="construct.a.inbi007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbi007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi007
            #add-point:ON ACTION controlp INFIELD inbi007 name="construct.c.inbi007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi001
            #add-point:ON ACTION controlp INFIELD inbi001 name="construct.c.inbi001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbi001  #顯示到畫面上
            NEXT FIELD inbi001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi001
            #add-point:BEFORE FIELD inbi001 name="construct.b.inbi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi001
            
            #add-point:AFTER FIELD inbi001 name="construct.a.inbi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi002
            #add-point:ON ACTION controlp INFIELD inbi002 name="construct.c.inbi002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbi002  #顯示到畫面上
            NEXT FIELD inbi002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi002
            #add-point:BEFORE FIELD inbi002 name="construct.b.inbi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi002
            
            #add-point:AFTER FIELD inbi002 name="construct.a.inbi002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbi031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi031
            #add-point:ON ACTION controlp INFIELD inbi031 name="construct.c.inbi031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inbidocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbi031  #顯示到畫面上
            NEXT FIELD inbi031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi031
            #add-point:BEFORE FIELD inbi031 name="construct.b.inbi031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi031
            
            #add-point:AFTER FIELD inbi031 name="construct.a.inbi031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi032
            #add-point:BEFORE FIELD inbi032 name="construct.b.inbi032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi032
            
            #add-point:AFTER FIELD inbi032 name="construct.a.inbi032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbi032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi032
            #add-point:ON ACTION controlp INFIELD inbi032 name="construct.c.inbi032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi003
            #add-point:ON ACTION controlp INFIELD inbi003 name="construct.c.inbi003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc  #160330-00017#1 add
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbi003  #顯示到畫面上
            NEXT FIELD inbi003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi003
            #add-point:BEFORE FIELD inbi003 name="construct.b.inbi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi003
            
            #add-point:AFTER FIELD inbi003 name="construct.a.inbi003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi021
            #add-point:BEFORE FIELD inbi021 name="construct.b.inbi021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi021
            
            #add-point:AFTER FIELD inbi021 name="construct.a.inbi021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbi021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi021
            #add-point:ON ACTION controlp INFIELD inbi021 name="construct.c.inbi021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbistus
            #add-point:BEFORE FIELD inbistus name="construct.b.inbistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbistus
            
            #add-point:AFTER FIELD inbistus name="construct.a.inbistus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbistus
            #add-point:ON ACTION controlp INFIELD inbistus name="construct.c.inbistus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbiownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbiownid
            #add-point:ON ACTION controlp INFIELD inbiownid name="construct.c.inbiownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbiownid  #顯示到畫面上
            NEXT FIELD inbiownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbiownid
            #add-point:BEFORE FIELD inbiownid name="construct.b.inbiownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbiownid
            
            #add-point:AFTER FIELD inbiownid name="construct.a.inbiownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbiowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbiowndp
            #add-point:ON ACTION controlp INFIELD inbiowndp name="construct.c.inbiowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbiowndp  #顯示到畫面上
            NEXT FIELD inbiowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbiowndp
            #add-point:BEFORE FIELD inbiowndp name="construct.b.inbiowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbiowndp
            
            #add-point:AFTER FIELD inbiowndp name="construct.a.inbiowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbicrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbicrtid
            #add-point:ON ACTION controlp INFIELD inbicrtid name="construct.c.inbicrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbicrtid  #顯示到畫面上
            NEXT FIELD inbicrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbicrtid
            #add-point:BEFORE FIELD inbicrtid name="construct.b.inbicrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbicrtid
            
            #add-point:AFTER FIELD inbicrtid name="construct.a.inbicrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbicrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbicrtdp
            #add-point:ON ACTION controlp INFIELD inbicrtdp name="construct.c.inbicrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbicrtdp  #顯示到畫面上
            NEXT FIELD inbicrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbicrtdp
            #add-point:BEFORE FIELD inbicrtdp name="construct.b.inbicrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbicrtdp
            
            #add-point:AFTER FIELD inbicrtdp name="construct.a.inbicrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbicrtdt
            #add-point:BEFORE FIELD inbicrtdt name="construct.b.inbicrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbimodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbimodid
            #add-point:ON ACTION controlp INFIELD inbimodid name="construct.c.inbimodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbimodid  #顯示到畫面上
            NEXT FIELD inbimodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbimodid
            #add-point:BEFORE FIELD inbimodid name="construct.b.inbimodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbimodid
            
            #add-point:AFTER FIELD inbimodid name="construct.a.inbimodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbimoddt
            #add-point:BEFORE FIELD inbimoddt name="construct.b.inbimoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbicnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbicnfid
            #add-point:ON ACTION controlp INFIELD inbicnfid name="construct.c.inbicnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbicnfid  #顯示到畫面上
            NEXT FIELD inbicnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbicnfid
            #add-point:BEFORE FIELD inbicnfid name="construct.b.inbicnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbicnfid
            
            #add-point:AFTER FIELD inbicnfid name="construct.a.inbicnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbicnfdt
            #add-point:BEFORE FIELD inbicnfdt name="construct.b.inbicnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbipstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbipstid
            #add-point:ON ACTION controlp INFIELD inbipstid name="construct.c.inbipstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbipstid  #顯示到畫面上
            NEXT FIELD inbipstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbipstid
            #add-point:BEFORE FIELD inbipstid name="construct.b.inbipstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbipstid
            
            #add-point:AFTER FIELD inbipstid name="construct.a.inbipstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbipstdt
            #add-point:BEFORE FIELD inbipstdt name="construct.b.inbipstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inbjseq,inbj001,inbj002,inbj002_desc,inbj005,inbj006,inbj007,inbj003, 
          inbj008,inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020, 
          inbj021,inbj031,inbjsite,inbj010,inbj013
           FROM s_detail1[1].inbjseq,s_detail1[1].inbj001,s_detail1[1].inbj002,s_detail1[1].inbj002_desc, 
               s_detail1[1].inbj005,s_detail1[1].inbj006,s_detail1[1].inbj007,s_detail1[1].inbj003,s_detail1[1].inbj008, 
               s_detail1[1].inbj016,s_detail1[1].inbj017,s_detail1[1].inbj018,s_detail1[1].inbj009,s_detail1[1].inbj011, 
               s_detail1[1].inbj012,s_detail1[1].inbj004,s_detail1[1].inbj014,s_detail1[1].inbj015,s_detail1[1].inbj019, 
               s_detail1[1].inbj020,s_detail1[1].inbj021,s_detail1[1].inbj031,s_detail1[1].inbjsite, 
               s_detail1[1].inbj010,s_detail1[1].inbj013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbjseq
            #add-point:BEFORE FIELD inbjseq name="construct.b.page1.inbjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbjseq
            
            #add-point:AFTER FIELD inbjseq name="construct.a.page1.inbjseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbjseq
            #add-point:ON ACTION controlp INFIELD inbjseq name="construct.c.page1.inbjseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj001
            #add-point:ON ACTION controlp INFIELD inbj001 name="construct.c.page1.inbj001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj001  #顯示到畫面上
            NEXT FIELD inbj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj001
            #add-point:BEFORE FIELD inbj001 name="construct.b.page1.inbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj001
            
            #add-point:AFTER FIELD inbj001 name="construct.a.page1.inbj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj002
            #add-point:ON ACTION controlp INFIELD inbj002 name="construct.c.page1.inbj002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj002  #顯示到畫面上
            NEXT FIELD inbj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj002
            #add-point:BEFORE FIELD inbj002 name="construct.b.page1.inbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj002
            
            #add-point:AFTER FIELD inbj002 name="construct.a.page1.inbj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj002_desc
            #add-point:BEFORE FIELD inbj002_desc name="construct.b.page1.inbj002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj002_desc
            
            #add-point:AFTER FIELD inbj002_desc name="construct.a.page1.inbj002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj002_desc
            #add-point:ON ACTION controlp INFIELD inbj002_desc name="construct.c.page1.inbj002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj005
            #add-point:ON ACTION controlp INFIELD inbj005 name="construct.c.page1.inbj005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj005  #顯示到畫面上
            NEXT FIELD inbj005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj005
            #add-point:BEFORE FIELD inbj005 name="construct.b.page1.inbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj005
            
            #add-point:AFTER FIELD inbj005 name="construct.a.page1.inbj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj006
            #add-point:ON ACTION controlp INFIELD inbj006 name="construct.c.page1.inbj006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj006  #顯示到畫面上
            NEXT FIELD inbj006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj006
            #add-point:BEFORE FIELD inbj006 name="construct.b.page1.inbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj006
            
            #add-point:AFTER FIELD inbj006 name="construct.a.page1.inbj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj007
            #add-point:ON ACTION controlp INFIELD inbj007 name="construct.c.page1.inbj007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj007  #顯示到畫面上
            NEXT FIELD inbj007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj007
            #add-point:BEFORE FIELD inbj007 name="construct.b.page1.inbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj007
            
            #add-point:AFTER FIELD inbj007 name="construct.a.page1.inbj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj003
            #add-point:ON ACTION controlp INFIELD inbj003 name="construct.c.page1.inbj003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj003  #顯示到畫面上
            NEXT FIELD inbj003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj003
            #add-point:BEFORE FIELD inbj003 name="construct.b.page1.inbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj003
            
            #add-point:AFTER FIELD inbj003 name="construct.a.page1.inbj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj008
            #add-point:ON ACTION controlp INFIELD inbj008 name="construct.c.page1.inbj008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj008  #顯示到畫面上
            NEXT FIELD inbj008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj008
            #add-point:BEFORE FIELD inbj008 name="construct.b.page1.inbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj008
            
            #add-point:AFTER FIELD inbj008 name="construct.a.page1.inbj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj016
            #add-point:ON ACTION controlp INFIELD inbj016 name="construct.c.page1.inbj016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj016  #顯示到畫面上
            NEXT FIELD inbj016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj016
            #add-point:BEFORE FIELD inbj016 name="construct.b.page1.inbj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj016
            
            #add-point:AFTER FIELD inbj016 name="construct.a.page1.inbj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj017
            #add-point:ON ACTION controlp INFIELD inbj017 name="construct.c.page1.inbj017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj017  #顯示到畫面上
            NEXT FIELD inbj017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj017
            #add-point:BEFORE FIELD inbj017 name="construct.b.page1.inbj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj017
            
            #add-point:AFTER FIELD inbj017 name="construct.a.page1.inbj017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj018
            #add-point:BEFORE FIELD inbj018 name="construct.b.page1.inbj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj018
            
            #add-point:AFTER FIELD inbj018 name="construct.a.page1.inbj018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj018
            #add-point:ON ACTION controlp INFIELD inbj018 name="construct.c.page1.inbj018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj009
            #add-point:BEFORE FIELD inbj009 name="construct.b.page1.inbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj009
            
            #add-point:AFTER FIELD inbj009 name="construct.a.page1.inbj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj009
            #add-point:ON ACTION controlp INFIELD inbj009 name="construct.c.page1.inbj009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj011
            #add-point:ON ACTION controlp INFIELD inbj011 name="construct.c.page1.inbj011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj011  #顯示到畫面上
            NEXT FIELD inbj011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj011
            #add-point:BEFORE FIELD inbj011 name="construct.b.page1.inbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj011
            
            #add-point:AFTER FIELD inbj011 name="construct.a.page1.inbj011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj012
            #add-point:BEFORE FIELD inbj012 name="construct.b.page1.inbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj012
            
            #add-point:AFTER FIELD inbj012 name="construct.a.page1.inbj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj012
            #add-point:ON ACTION controlp INFIELD inbj012 name="construct.c.page1.inbj012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj004
            #add-point:ON ACTION controlp INFIELD inbj004 name="construct.c.page1.inbj004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj004  #顯示到畫面上
            NEXT FIELD inbj004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj004
            #add-point:BEFORE FIELD inbj004 name="construct.b.page1.inbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj004
            
            #add-point:AFTER FIELD inbj004 name="construct.a.page1.inbj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj014
            #add-point:ON ACTION controlp INFIELD inbj014 name="construct.c.page1.inbj014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj014  #顯示到畫面上
            NEXT FIELD inbj014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj014
            #add-point:BEFORE FIELD inbj014 name="construct.b.page1.inbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj014
            
            #add-point:AFTER FIELD inbj014 name="construct.a.page1.inbj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj015
            #add-point:ON ACTION controlp INFIELD inbj015 name="construct.c.page1.inbj015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj015  #顯示到畫面上
            NEXT FIELD inbj015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj015
            #add-point:BEFORE FIELD inbj015 name="construct.b.page1.inbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj015
            
            #add-point:AFTER FIELD inbj015 name="construct.a.page1.inbj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj019
            #add-point:ON ACTION controlp INFIELD inbj019 name="construct.c.page1.inbj019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj019  #顯示到畫面上
            NEXT FIELD inbj019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj019
            #add-point:BEFORE FIELD inbj019 name="construct.b.page1.inbj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj019
            
            #add-point:AFTER FIELD inbj019 name="construct.a.page1.inbj019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj020
            #add-point:ON ACTION controlp INFIELD inbj020 name="construct.c.page1.inbj020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj020  #顯示到畫面上
            NEXT FIELD inbj020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj020
            #add-point:BEFORE FIELD inbj020 name="construct.b.page1.inbj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj020
            
            #add-point:AFTER FIELD inbj020 name="construct.a.page1.inbj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj021
            #add-point:ON ACTION controlp INFIELD inbj021 name="construct.c.page1.inbj021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbj021  #顯示到畫面上
            NEXT FIELD inbj021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj021
            #add-point:BEFORE FIELD inbj021 name="construct.b.page1.inbj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj021
            
            #add-point:AFTER FIELD inbj021 name="construct.a.page1.inbj021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj031
            #add-point:BEFORE FIELD inbj031 name="construct.b.page1.inbj031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj031
            
            #add-point:AFTER FIELD inbj031 name="construct.a.page1.inbj031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj031
            #add-point:ON ACTION controlp INFIELD inbj031 name="construct.c.page1.inbj031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbjsite
            #add-point:BEFORE FIELD inbjsite name="construct.b.page1.inbjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbjsite
            
            #add-point:AFTER FIELD inbjsite name="construct.a.page1.inbjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbjsite
            #add-point:ON ACTION controlp INFIELD inbjsite name="construct.c.page1.inbjsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj010
            #add-point:BEFORE FIELD inbj010 name="construct.b.page1.inbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj010
            
            #add-point:AFTER FIELD inbj010 name="construct.a.page1.inbj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj010
            #add-point:ON ACTION controlp INFIELD inbj010 name="construct.c.page1.inbj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj013
            #add-point:BEFORE FIELD inbj013 name="construct.b.page1.inbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj013
            
            #add-point:AFTER FIELD inbj013 name="construct.a.page1.inbj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj013
            #add-point:ON ACTION controlp INFIELD inbj013 name="construct.c.page1.inbj013"
            
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
                  WHEN la_wc[li_idx].tableid = "inbi_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inbj_t" 
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
   LET g_wc = g_wc," AND inbi000 = '2'"
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint311_filter()
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
      CONSTRUCT g_wc_filter ON inbidocno,inbidocdt,inbi007,inbi001,inbi002
                          FROM s_browse[1].b_inbidocno,s_browse[1].b_inbidocdt,s_browse[1].b_inbi007, 
                              s_browse[1].b_inbi001,s_browse[1].b_inbi002
 
         BEFORE CONSTRUCT
               DISPLAY aint311_filter_parser('inbidocno') TO s_browse[1].b_inbidocno
            DISPLAY aint311_filter_parser('inbidocdt') TO s_browse[1].b_inbidocdt
            DISPLAY aint311_filter_parser('inbi007') TO s_browse[1].b_inbi007
            DISPLAY aint311_filter_parser('inbi001') TO s_browse[1].b_inbi001
            DISPLAY aint311_filter_parser('inbi002') TO s_browse[1].b_inbi002
      
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
 
      CALL aint311_filter_show('inbidocno')
   CALL aint311_filter_show('inbidocdt')
   CALL aint311_filter_show('inbi007')
   CALL aint311_filter_show('inbi001')
   CALL aint311_filter_show('inbi002')
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint311_filter_parser(ps_field)
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
 
{<section id="aint311.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint311_filter_show(ps_field)
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
   LET ls_condition = aint311_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint311_query()
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
   CALL g_inbj_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint311_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint311_browser_fill("")
      CALL aint311_fetch("")
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
      CALL aint311_filter_show('inbidocno')
   CALL aint311_filter_show('inbidocdt')
   CALL aint311_filter_show('inbi007')
   CALL aint311_filter_show('inbi001')
   CALL aint311_filter_show('inbi002')
   CALL aint311_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint311_fetch("F") 
      #顯示單身筆數
      CALL aint311_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint311_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_slip     STRING
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
   
   LET g_inbi_m.inbidocno = g_browser[g_current_idx].b_inbidocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
       g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
       g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
       g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
       g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
       g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbipstid_desc
   
   #遮罩相關處理
   LET g_inbi_m_mask_o.* =  g_inbi_m.*
   CALL aint311_inbi_t_mask()
   LET g_inbi_m_mask_n.* =  g_inbi_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint311_set_act_visible()   
   CALL aint311_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_inbi_m.inbistus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL s_aooi200_get_slip(g_inbi_m.inbidocno) RETURNING g_success,l_slip
   IF g_success THEN
      CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0087') RETURNING g_para
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_inbi_m_t.* = g_inbi_m.*
   LET g_inbi_m_o.* = g_inbi_m.*
   
   LET g_data_owner = g_inbi_m.inbiownid      
   LET g_data_dept  = g_inbi_m.inbiowndp
   
   #重新顯示   
   CALL aint311_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint311_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_inbj_d.clear()   
 
 
   INITIALIZE g_inbi_m.* TO NULL             #DEFAULT 設定
   
   LET g_inbidocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inbi_m.inbiownid = g_user
      LET g_inbi_m.inbiowndp = g_dept
      LET g_inbi_m.inbicrtid = g_user
      LET g_inbi_m.inbicrtdp = g_dept 
      LET g_inbi_m.inbicrtdt = cl_get_current()
      LET g_inbi_m.inbimodid = g_user
      LET g_inbi_m.inbimoddt = cl_get_current()
      LET g_inbi_m.inbistus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inbi_m.inbi000 = "2"
      LET g_inbi_m.inbi032 = "N"
      LET g_inbi_m.inbi004 = "N"
      LET g_inbi_m.inbistus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      DISPLAY BY NAME g_inbi_m.inbi032
      LET g_inbi_m.inbi000 = '2'
      LET g_inbi_m.inbidocdt = g_today
      LET g_inbi_m.inbi001 = g_user
      LET g_inbi_m.inbisite = g_site
      SELECT ooag003 INTO g_inbi_m.inbi002 FROM ooag_t
       WHERE ooag001 = g_inbi_m.inbi001 AND ooagent = g_enterprise
      CALL aint311_inbi001_desc()
      CALL aint311_inbi002_desc()
      LET g_inbi_m.inbi007 = g_today
      LET g_auto_flag = TRUE
      LET g_inbi_m_t.* = g_inbi_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_inbi_m_t.* = g_inbi_m.*
      LET g_inbi_m_o.* = g_inbi_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbi_m.inbistus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         
      END CASE
 
 
 
    
      CALL aint311_input("a")
      
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
         INITIALIZE g_inbi_m.* TO NULL
         INITIALIZE g_inbj_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint311_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_inbj_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint311_set_act_visible()   
   CALL aint311_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbidocno_t = g_inbi_m.inbidocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbient = " ||g_enterprise|| " AND",
                      " inbidocno = '", g_inbi_m.inbidocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint311_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint311_cl
   
   CALL aint311_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
       g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
       g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
       g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
       g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
       g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbipstid_desc
   
   
   #遮罩相關處理
   LET g_inbi_m_mask_o.* =  g_inbi_m.*
   CALL aint311_inbi_t_mask()
   LET g_inbi_m_mask_n.* =  g_inbi_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocno_desc,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi000, 
       g_inbi_m.inbi001,g_inbi_m.inbi001_desc,g_inbi_m.inbi002,g_inbi_m.inbi002_desc,g_inbi_m.inbi031, 
       g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi003_desc,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite, 
       g_inbi_m.inbistus,g_inbi_m.inbiownid,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid,g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbicrtdt, 
       g_inbi_m.inbimodid,g_inbi_m.inbimodid_desc,g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstid_desc,g_inbi_m.inbipstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_inbi_m.inbiownid      
   LET g_data_dept  = g_inbi_m.inbiowndp
   
   #功能已完成,通報訊息中心
   CALL aint311_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint311_modify()
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
   LET g_inbi_m_t.* = g_inbi_m.*
   LET g_inbi_m_o.* = g_inbi_m.*
   
   IF g_inbi_m.inbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_inbidocno_t = g_inbi_m.inbidocno
 
   CALL s_transaction_begin()
   
   OPEN aint311_cl USING g_enterprise,g_inbi_m.inbidocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint311_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint311_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
       g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
       g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
       g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
       g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
       g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbipstid_desc
   
   #檢查是否允許此動作
   IF NOT aint311_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inbi_m_mask_o.* =  g_inbi_m.*
   CALL aint311_inbi_t_mask()
   LET g_inbi_m_mask_n.* =  g_inbi_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aint311_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_inbidocno_t = g_inbi_m.inbidocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_inbi_m.inbimodid = g_user 
LET g_inbi_m.inbimoddt = cl_get_current()
LET g_inbi_m.inbimodid_desc = cl_get_username(g_inbi_m.inbimodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_inbi_m.inbistus MATCHES "[DR]" THEN 
         LET g_inbi_m.inbistus = "N"
      END IF

      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint311_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE inbi_t SET (inbimodid,inbimoddt) = (g_inbi_m.inbimodid,g_inbi_m.inbimoddt)
          WHERE inbient = g_enterprise AND inbidocno = g_inbidocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_inbi_m.* = g_inbi_m_t.*
            CALL aint311_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_inbi_m.inbidocno != g_inbi_m_t.inbidocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE inbj_t SET inbjdocno = g_inbi_m.inbidocno
 
          WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m_t.inbidocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inbj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint311_set_act_visible()   
   CALL aint311_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inbient = " ||g_enterprise|| " AND",
                      " inbidocno = '", g_inbi_m.inbidocno, "' "
 
   #填到對應位置
   CALL aint311_browser_fill("")
 
   CLOSE aint311_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint311_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint311.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint311_input(p_cmd)
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
   DEFINE  l_date                 LIKE type_t.dat
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_sql                 STRING
   DEFINE  l_imaf053             LIKE imaf_t.imaf053
   DEFINE  l_where               STRING  #160204-00004#5 20160223 s983961--add
   DEFINE  l_success             LIKE type_t.num5  #160204-00004#5 20160223 s983961--add
   DEFINE  l_exit                LIKE type_t.chr1  #161118-00011#1 add
   DEFINE  l_sql1                STRING     #160711-00040#15 add
   DEFINE  l_flag1               LIKE type_t.num5   #170222-00045#1 add
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
   DISPLAY BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocno_desc,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi000, 
       g_inbi_m.inbi001,g_inbi_m.inbi001_desc,g_inbi_m.inbi002,g_inbi_m.inbi002_desc,g_inbi_m.inbi031, 
       g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi003_desc,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite, 
       g_inbi_m.inbistus,g_inbi_m.inbiownid,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid,g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbicrtdt, 
       g_inbi_m.inbimodid,g_inbi_m.inbimodid_desc,g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstid_desc,g_inbi_m.inbipstdt
   
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
   LET g_forupd_sql = "SELECT inbjseq,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,inbj016, 
       inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,inbj021,inbj031, 
       inbjsite,inbj010,inbj013 FROM inbj_t WHERE inbjent=? AND inbjdocno=? AND inbjseq=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint311_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint311_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   LET g_stus = 'N'    #160420-00024#1
   #end add-point
   CALL aint311_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi001,g_inbi_m.inbi002, 
       g_inbi_m.inbi031,g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbistus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   LET g_stus = 'N'
   WHILE TRUE            #161118-00011#1 add
      LET l_exit = 'Y'   #161118-00011#1 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint311.input.head" >}
      #單頭段
      INPUT BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi001,g_inbi_m.inbi002, 
          g_inbi_m.inbi031,g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbistus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint311_cl USING g_enterprise,g_inbi_m.inbidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint311_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint311_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint311_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aint311_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbidocno
            
            #add-point:AFTER FIELD inbidocno name="input.a.inbidocno"
            CALL s_aooi200_get_slip_desc(g_inbi_m.inbidocno) RETURNING g_inbi_m.inbidocno_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inbi_m.inbidocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inbi_m.inbidocno != g_inbidocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbi_t WHERE "||"inbient = '" ||g_enterprise|| "' AND "||"inbidocno = '"||g_inbi_m.inbidocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF g_inbi_m.inbidocno != g_inbi_m_o.inbidocno OR cl_null(g_inbi_m_o.inbidocno) THEN   #160824-00007#280 161229 by lori add
                  #IF NOT s_aooi200_chk_slip(g_site,'',g_inbi_m.inbidocno,'aint311') THEN #160613-00038#1 mark
                  IF NOT s_aooi200_chk_slip(g_site,'',g_inbi_m.inbidocno,g_prog) THEN     #160613-00038#1 add
                    #160824-00007#280 161229 by lori mod---(S)
                    #LET g_inbi_m.inbidocno = g_inbi_m_t.inbidocno   
                     LET g_inbi_m.inbidocno = g_inbi_m_o.inbidocno   
                     DISPLAY BY NAME g_inbi_m.inbidocno
                    #160824-00007#280 161229 by lori mod---(E)
                     NEXT FIELD CURRENT
                  END IF
                  CALL cl_get_doc_para(g_enterprise,g_site,g_inbi_m.inbidocno,'D-BAS-0079') RETURNING g_inbi_m.inbi032
                  DISPLAY BY NAME g_inbi_m.inbi032
                  
                  CALL aint311_docno_default()
               END If   #160824-00007#280 161229 by lori add
               
               CALL aint311_set_entry(p_cmd)
               CALL aint311_set_no_entry(p_cmd)
              #CALL aint311_docno_default()      #160824-00007#280 161229 by lori mark
               CALL cl_get_doc_para(g_enterprise,g_site,g_inbi_m.inbidocno,'D-BAS-0087') RETURNING g_para
               CALL aint311_set_entry(p_cmd)
               CALL aint311_set_no_entry(p_cmd)
               CALL aint311_set_act_visible()   
               CALL aint311_set_act_no_visible()
               
               
               #160204-00004#5 20160222 s983961--add(s)
               IF (g_inbi_m.inbidocno != g_inbi_m_o.inbidocno) OR cl_null(g_inbi_m_o.inbidocno) THEN
                 LET g_inbi_m.inbi031 = ''
                 DISPLAY g_inbi_m.inbi031      
               END IF                                      
               #160204-00004#5 20160222 s983961--add(e) 
            END IF

            LET g_inbi_m_o.inbidocno = g_inbi_m.inbidocno   #160204-00004#5 20160222 s983961--add
            LET g_inbi_m_o.inbi032 = g_inbi_m.inbi032       #160824-00007#280 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbidocno
            #add-point:BEFORE FIELD inbidocno name="input.b.inbidocno"
            CALL s_aooi200_get_slip_desc(g_inbi_m.inbidocno) RETURNING g_inbi_m.inbidocno_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbidocno
            #add-point:ON CHANGE inbidocno name="input.g.inbidocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbidocdt
            #add-point:BEFORE FIELD inbidocdt name="input.b.inbidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbidocdt
            
            #add-point:AFTER FIELD inbidocdt name="input.a.inbidocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbidocdt
            #add-point:ON CHANGE inbidocdt name="input.g.inbidocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi007
            #add-point:BEFORE FIELD inbi007 name="input.b.inbi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi007
            
            #add-point:AFTER FIELD inbi007 name="input.a.inbi007"
            IF NOT cl_null(g_inbi_m.inbi007) THEN
               IF g_inbi_m.inbi007 <> g_inbi_m_o.inbi007 OR cl_null(g_inbi_m_o.inbi007) THEN   #160824-00007#280 161229 by lori add
                  CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_date
                  IF g_inbi_m.inbi007 < l_date THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00077'
                     LET g_errparam.extend = g_inbi_m.inbi007||" < "||l_date
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                    #160824-00007#280 161229 by lori add---(S)
                    #LET g_inbi_m.inbi007 = g_inbi_m_t.inbi007
                     LET g_inbi_m.inbi007 = g_inbi_m_o.inbi007
                     DISPLAY BY NAME g_inbi_m.inbi007
                    #160824-00007#280 161229 by lori add---(E) 
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160824-00007#280 161229 by lori add
            END IF
            
            LET g_inbi_m_o.inbi007 = g_inbi_m.inbi007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi007
            #add-point:ON CHANGE inbi007 name="input.g.inbi007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi001
            
            #add-point:AFTER FIELD inbi001 name="input.a.inbi001"
            CALL aint311_inbi001_desc()
            IF NOT cl_null(g_inbi_m.inbi001) THEN 
               IF g_inbi_m.inbi001 <> g_inbi_m_o.inbi001 OR cl_null(g_inbi_m_o.inbi001) THEN   #160824-00007#280 161229 by lori add   
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbi_m.inbi001
                  #160318-00025#16 by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#16 by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                    #160824-00007#280 161229 by lori mod---(S)
                    #LET g_inbi_m.inbi001 = g_inbi_m_t.inbi001
                     LET g_inbi_m.inbi001 = g_inbi_m_o.inbi001
                     DISPLAY BY NAME g_inbi_m.inbi001
                    #160824-00007#280 161229 by lori mod---(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160824-00007#280 161229 by lori add
            END IF 
            
            LET g_inbi_m_o.inbi001 = g_inbi_m.inbi001   #160824-00007#280 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi001
            #add-point:BEFORE FIELD inbi001 name="input.b.inbi001"
            CALL aint311_inbi001_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi001
            #add-point:ON CHANGE inbi001 name="input.g.inbi001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi002
            
            #add-point:AFTER FIELD inbi002 name="input.a.inbi002"
            CALL aint311_inbi002_desc()
            IF NOT cl_null(g_inbi_m.inbi002) THEN 
               IF g_inbi_m.inbi002 <> g_inbi_m_o.inbi002 OR cl_null(g_inbi_m_o.inbi002) THEN   #160824-00007#280 161229 by lori add
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbi_m.inbi002
                  LET g_chkparam.arg2 = g_inbi_m.inbidocdt
                   #160318-00025#16 by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#16 by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                    #160824-00007#280 161229 by lori mod---(S) 
                    #LET g_inbi_m.inbi002 = g_inbi_m_t.inbi002
                     LET g_inbi_m.inbi002 = g_inbi_m_o.inbi002
                     DISPLAY BY NAME g_inbi_m.inbi002
                    #160824-00007#280 161229 by lori mod---(E) 
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160824-00007#280 161229 by lori add
            END IF
            
            LET g_inbi_m_o.inbi002 = g_inbi_m.inbi002   #160824-00007#280 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi002
            #add-point:BEFORE FIELD inbi002 name="input.b.inbi002"
            CALL aint311_inbi002_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi002
            #add-point:ON CHANGE inbi002 name="input.g.inbi002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi031
            
            #add-point:AFTER FIELD inbi031 name="input.a.inbi031"
            IF NOT cl_null(g_inbi_m.inbi031) THEN 
               IF g_inbi_m.inbi031 <> g_inbi_m_o.inbi031 OR cl_null(g_inbi_m_o.inbi031) THEN   #160824-00007#280 161229 by lori add
                  #160204-00004#5 20160222 s983961--add(s)
                  IF NOT cl_null(g_inbi_m.inbidocno) THEN 
                     IF NOT s_aooi210_check_doc(g_site,'', g_inbi_m.inbi031 , g_inbi_m.inbidocno ,'4','') THEN
                        LET g_inbi_m.inbi031 = g_inbi_m_t.inbi031
                        DISPLAY BY NAME g_inbi_m.inbi031
                        
                        NEXT FIELD CURRENT               
                     END IF
                  END IF
                  #160204-00004#5 20160222 s983961--add(e) 
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbi_m.inbi031
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inbidocno") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                    #160824-00007#280 161229 by lori mod---(S) 
                    #LET g_inbi_m.inbi031 = g_inbi_m_t.inbi031
                     LET g_inbi_m.inbi031 = g_inbi_m_o.inbi031
                     DISPLAY BY NAME g_inbi_m.inbi031
                    #160824-00007#280 161229 by lori mod---(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160824-00007#280 161229 by lori add
            END IF 

            LET g_inbi_m_o.inbi031 = g_inbi_m.inbi031   #160824-00007#280 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi031
            #add-point:BEFORE FIELD inbi031 name="input.b.inbi031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi031
            #add-point:ON CHANGE inbi031 name="input.g.inbi031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi032
            #add-point:BEFORE FIELD inbi032 name="input.b.inbi032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi032
            
            #add-point:AFTER FIELD inbi032 name="input.a.inbi032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi032
            #add-point:ON CHANGE inbi032 name="input.g.inbi032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi003
            
            #add-point:AFTER FIELD inbi003 name="input.a.inbi003"
            
            #160330-00017#1 add(s)
            CALL aint311_inbi003_desc()
            IF NOT cl_null(g_inbi_m.inbi003) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_inbi_m.inbi003) THEN
                  LET g_inbi_m.inbi003 = g_inbi_m_t.inbi003
                  NEXT FIELD CURRENT
               END IF
               CALL s_control_chk_doc('8',g_inbi_m.inbidocno,g_inbi_m.inbi003,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbi_m.inbi003 = g_inbi_m_t.inbi003
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbi_m.inbi003 = g_inbi_m_t.inbi003
                  NEXT FIELD CURRENT
               END IF
               
            END IF
            #160330-00017#1 add(e)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi003
            #add-point:BEFORE FIELD inbi003 name="input.b.inbi003"
            CALL aint311_inbi003_desc()  #160330-00017#1 add
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi003
            #add-point:ON CHANGE inbi003 name="input.g.inbi003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbi021
            #add-point:BEFORE FIELD inbi021 name="input.b.inbi021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbi021
            
            #add-point:AFTER FIELD inbi021 name="input.a.inbi021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbi021
            #add-point:ON CHANGE inbi021 name="input.g.inbi021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbistus
            #add-point:BEFORE FIELD inbistus name="input.b.inbistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbistus
            
            #add-point:AFTER FIELD inbistus name="input.a.inbistus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbistus
            #add-point:ON CHANGE inbistus name="input.g.inbistus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inbidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbidocno
            #add-point:ON ACTION controlp INFIELD inbidocno name="input.c.inbidocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbi_m.inbidocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef.ooef004 #
            #LET g_qryparam.arg2 = "aint311" #   #160705-00042#3 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#3 160711 by sakura add
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_inbi_m.inbidocno = g_qryparam.return1              

            DISPLAY g_inbi_m.inbidocno TO inbidocno              #

            NEXT FIELD inbidocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbidocdt
            #add-point:ON ACTION controlp INFIELD inbidocdt name="input.c.inbidocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbi007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi007
            #add-point:ON ACTION controlp INFIELD inbi007 name="input.c.inbi007"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi001
            #add-point:ON ACTION controlp INFIELD inbi001 name="input.c.inbi001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbi_m.inbi001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_inbi_m.inbi001 = g_qryparam.return1              

            DISPLAY g_inbi_m.inbi001 TO inbi001              #

            NEXT FIELD inbi001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi002
            #add-point:ON ACTION controlp INFIELD inbi002 name="input.c.inbi002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbi_m.inbi002             #給予default值
            LET g_qryparam.default2 = "" #g_inbi_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_inbi_m.inbidocdt #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_inbi_m.inbi002 = g_qryparam.return1              
            #LET g_inbi_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_inbi_m.inbi002 TO inbi002              #
            #DISPLAY g_inbi_m.ooeg001 TO ooeg001 #部門編號
            NEXT FIELD inbi002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbi031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi031
            #add-point:ON ACTION controlp INFIELD inbi031 name="input.c.inbi031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbi_m.inbi031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #160204-00004#5 20160223 s983961--add(s)
            IF NOT cl_null(g_inbi_m.inbidocno) THEN
               LET l_success = ''
               LET l_where = ''
               CALL s_aooi210_get_check_sql(g_site,'', g_inbi_m.inbidocno ,'4','','inbidocno') RETURNING l_success,l_where
               IF l_success AND NOT cl_null(l_where) THEN
                  LET g_qryparam.where = l_where
                  CALL q_inbidocno_1()                                #呼叫開窗
               END IF
            END IF
            #160204-00004#5 20160223 s983961--add(e)            
            #CALL q_inbidocno_1()                                #呼叫開窗  #160204-00004#5 20160223 s983961--mark

            LET g_inbi_m.inbi031 = g_qryparam.return1              

            DISPLAY g_inbi_m.inbi031 TO inbi031              #

            NEXT FIELD inbi031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inbi032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi032
            #add-point:ON ACTION controlp INFIELD inbi032 name="input.c.inbi032"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi003
            #add-point:ON ACTION controlp INFIELD inbi003 name="input.c.inbi003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_inbi_m.inbi003             #給予default值
            LET g_qryparam.default2 = "" #g_inbi_m.oocq002 #應用分類碼
            #給予arg
            #160330-00017#1 add(s)
            LET g_qryparam.arg1 = g_acc #
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_doc_sql('oocq002',g_inbi_m.inbidocno,'8')
                                RETURNING g_success,l_sql
            IF g_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql
            END IF
            #160330-00017#1 add(e)
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_inbi_m.inbi003 = g_qryparam.return1              
            #LET g_inbi_m.oocq002 = g_qryparam.return2 
            DISPLAY g_inbi_m.inbi003 TO inbi003              #
            #DISPLAY g_inbi_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD inbi003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.inbi021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbi021
            #add-point:ON ACTION controlp INFIELD inbi021 name="input.c.inbi021"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbistus
            #add-point:ON ACTION controlp INFIELD inbistus name="input.c.inbistus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_inbi_m.inbidocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #CALL s_aooi200_gen_docno(g_site,g_inbi_m.inbidocno,g_inbi_m.inbidocdt,'aint311') RETURNING g_success,g_inbi_m.inbidocno #160613-00038#1 mark
               CALL s_aooi200_gen_docno(g_site,g_inbi_m.inbidocno,g_inbi_m.inbidocdt,g_prog) RETURNING g_success,g_inbi_m.inbidocno     #160613-00038#1 add
               IF NOT g_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_inbi_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               LET g_auto_flag = FALSE
               CALL aint311_set_entry(p_cmd)
               CALL aint311_set_no_entry(p_cmd)
               #end add-point
               
               INSERT INTO inbi_t (inbient,inbidocno,inbidocdt,inbi007,inbi000,inbi001,inbi002,inbi031, 
                   inbi032,inbi003,inbi021,inbi004,inbisite,inbistus,inbiownid,inbiowndp,inbicrtid,inbicrtdp, 
                   inbicrtdt,inbimodid,inbimoddt,inbicnfid,inbicnfdt,inbipstid,inbipstdt)
               VALUES (g_enterprise,g_inbi_m.inbidocno,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi000, 
                   g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032,g_inbi_m.inbi003, 
                   g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
                   g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
                   g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_inbi_m:",SQLERRMESSAGE 
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
                  CALL aint311_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint311_b_fill()
                  CALL aint311_b_fill2('0')
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
               CALL aint311_inbi_t_mask_restore('restore_mask_o')
               
               UPDATE inbi_t SET (inbidocno,inbidocdt,inbi007,inbi000,inbi001,inbi002,inbi031,inbi032, 
                   inbi003,inbi021,inbi004,inbisite,inbistus,inbiownid,inbiowndp,inbicrtid,inbicrtdp, 
                   inbicrtdt,inbimodid,inbimoddt,inbicnfid,inbicnfdt,inbipstid,inbipstdt) = (g_inbi_m.inbidocno, 
                   g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002, 
                   g_inbi_m.inbi031,g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004, 
                   g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid,g_inbi_m.inbiowndp,g_inbi_m.inbicrtid, 
                   g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid,g_inbi_m.inbimoddt,g_inbi_m.inbicnfid, 
                   g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt)
                WHERE inbient = g_enterprise AND inbidocno = g_inbidocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inbi_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint311_inbi_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_inbi_m_t)
               LET g_log2 = util.JSON.stringify(g_inbi_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_inbidocno_t = g_inbi_m.inbidocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint311.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_inbj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ins_inao
            LET g_action_choice="ins_inao"
            IF cl_auth_chk_act("ins_inao") THEN
               
               #add-point:ON ACTION ins_inao name="input.detail_input.page1.ins_inao"
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) AND NOT cl_null(g_inbj_d[l_ac].inbj005) AND NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
                 # IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
                   IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) THEN
#                     CALL s_transaction_begin()
                     IF g_para = 'N' THEN
                        SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                        CALL s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) RETURNING g_success
                        IF g_success THEN
#                           CALL s_transaction_end('Y','0')
                           CALL aint311_inao_b_fill()
                        ELSE
#                           CALL s_transaction_end('N','0')
                        END IF
                     ELSE
                        CALL aint311_default_inav(g_inbj_d[l_ac].*)
                        IF s_aint311_lot_sel(g_inav.*,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq) THEN
                           CALL aint311_inao_b_fill()
                        END IF
                     END IF
#                    IF aint311_inao_exists() THEN
#                       IF NOT aint311_inao_ins(g_inbj_d[l_ac].inbjseq) THEN
#                          INITIALIZE g_errparam TO NULL 
#                          LET g_errparam.extend = "inao_t" 
#                          LET g_errparam.code   = "std-00006"
#                          LET g_errparam.popup  = TRUE 
#                          CALL cl_err()
#                          CALL s_transaction_end('N','1')
#                       ELSE
#                          CALL s_transaction_end('Y','0')
#                          CALL aint311_inao_b_fill()
#                       END IF
#                    END IF
                  END IF
               END IF
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ins_detial
            LET g_action_choice="ins_detial"
            IF cl_auth_chk_act("ins_detial") THEN
               
               #add-point:ON ACTION ins_detial name="input.detail_input.page1.ins_detial"
               CALL aint311_01(g_inbi_m.inbidocno)
               LET l_cmd = 'u'
               CALL aint311_b_fill()
               LET l_exit = 'N'     #161118-00011#1 add
               EXIT DIALOG          #161118-00011#1 add
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint311_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_inbj_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            IF g_para = 'Y'  THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM inbj_t
                WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbidocno  
               IF l_cnt = 0 THEN 
                  IF cl_null(g_inbi_m.inbi031) THEN 
                     CALL aint311_01(g_inbi_m.inbidocno)
                  ELSE
                     IF cl_ask_confirm("axm-00013") THEN
                        CALL aint311_ins_inbj() 
                     ELSE
                        INITIALIZE g_inbi_m.inbi031 TO NULL                     
                     END IF
                  END IF
                  CALL aint311_b_fill()
               END IF 
            END IF
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
            OPEN aint311_cl USING g_enterprise,g_inbi_m.inbidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint311_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint311_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inbj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inbj_d[l_ac].inbjseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inbj_d_t.* = g_inbj_d[l_ac].*  #BACKUP
               LET g_inbj_d_o.* = g_inbj_d[l_ac].*  #BACKUP
               CALL aint311_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aint311_set_no_entry_b(l_cmd)
               IF NOT aint311_lock_b("inbj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint311_bcl INTO g_inbj_d[l_ac].inbjseq,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002, 
                      g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,g_inbj_d[l_ac].inbj003, 
                      g_inbj_d[l_ac].inbj008,g_inbj_d[l_ac].inbj016,g_inbj_d[l_ac].inbj017,g_inbj_d[l_ac].inbj018, 
                      g_inbj_d[l_ac].inbj009,g_inbj_d[l_ac].inbj011,g_inbj_d[l_ac].inbj012,g_inbj_d[l_ac].inbj004, 
                      g_inbj_d[l_ac].inbj014,g_inbj_d[l_ac].inbj015,g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj020, 
                      g_inbj_d[l_ac].inbj021,g_inbj_d[l_ac].inbj031,g_inbj_d[l_ac].inbjsite,g_inbj_d[l_ac].inbj010, 
                      g_inbj_d[l_ac].inbj013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inbj_d_t.inbjseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inbj_d_mask_o[l_ac].* =  g_inbj_d[l_ac].*
                  CALL aint311_inbj_t_mask()
                  LET g_inbj_d_mask_n[l_ac].* =  g_inbj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint311_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aint311_inao_b_fill()
            IF g_inbi_m.inbi032 = 'Y' THEN
               CALL cl_set_comp_required("inbj014",TRUE)
            END IF
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
            INITIALIZE g_inbj_d[l_ac].* TO NULL 
            INITIALIZE g_inbj_d_t.* TO NULL 
            INITIALIZE g_inbj_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_inbj_d[l_ac].inbj010 = "0"
      LET g_inbj_d[l_ac].inbj013 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_inbj_d_t.* = g_inbj_d[l_ac].*     #新輸入資料
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint311_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint311_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inbj_d[li_reproduce_target].* = g_inbj_d[li_reproduce].*
 
               LET g_inbj_d[li_reproduce_target].inbjseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_inbj_d[l_ac].inbjsite = g_inbi_m.inbisite  #160330-00018#1 add
            SELECT MAX(inbjseq) + 1 INTO g_inbj_d[l_ac].inbjseq FROM inbj_t 
             WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbidocno
            IF cl_null(g_inbj_d[l_ac].inbjseq) THEN LET g_inbj_d[l_ac].inbjseq = 1 END IF
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
            CALL aint311_detail_default()
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM inbj_t 
             WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbidocno
 
               AND inbjseq = g_inbj_d[l_ac].inbjseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbi_m.inbidocno
               LET gs_keys[2] = g_inbj_d[g_detail_idx].inbjseq
               CALL aint311_insert_b('inbj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
#               IF NOT cl_null(g_inbi_m.inbi031) THEN
#                  IF NOT aint311_inao_ins(g_inbj_d[l_ac].inbjseq) THEN
#                     INITIALIZE g_inbj_d[l_ac].* TO NULL
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_inbj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint311_b_fill()
               #資料多語言用-增/改
               
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
               LET gs_keys[01] = g_inbi_m.inbidocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_inbj_d_t.inbjseq
 
            
               #刪除同層單身
               IF NOT aint311_delete_b('inbj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint311_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint311_key_delete_b(gs_keys,'inbj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint311_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               CALL aint311_upd_inav(g_inbj_d[l_ac].*)
               CALL aint311_del_inao()
               CALL aint311_inao_b_fill()
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint311_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_inbj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbjseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbj_d[l_ac].inbjseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inbjseq
            END IF 
 
 
 
            #add-point:AFTER FIELD inbjseq name="input.a.page1.inbjseq"
            IF NOT cl_null(g_inbj_d[l_ac].inbjseq) THEN 
            END IF 


            #此段落由子樣板a05產生
            IF  g_inbi_m.inbidocno IS NOT NULL AND g_inbj_d[g_detail_idx].inbjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbi_m.inbidocno != g_inbidocno_t OR g_inbj_d[g_detail_idx].inbjseq != g_inbj_d_t.inbjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbj_t WHERE "||"inbjent = '" ||g_enterprise|| "' AND "||"inbjdocno = '"||g_inbi_m.inbidocno ||"' AND "|| "inbjseq = '"||g_inbj_d[g_detail_idx].inbjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbjseq
            #add-point:BEFORE FIELD inbjseq name="input.b.page1.inbjseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbjseq
            #add-point:ON CHANGE inbjseq name="input.g.page1.inbjseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj001
            
            #add-point:AFTER FIELD inbj001 name="input.a.page1.inbj001"
            CALL aint311_inbj001_desc()
            IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
              
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_control_chk_doc('4',g_inbi_m.inbidocno,g_inbj_d[l_ac].inbj001,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_control_chk_doc('5',g_inbi_m.inbidocno,g_inbj_d[l_ac].inbj001,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
                  NEXT FIELD CURRENT
               END IF
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj001 != g_inbj_d_o.inbj001 OR cl_null(g_inbj_d_o.inbj001)) THEN   
                 IF g_para = 'Y' THEN
#                    CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                    DISPLAY BY NAME g_inbj_d[l_ac].inbj009
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
#                       NEXT FIELD CURRENT
#                    END IF
#                   
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
#                       NEXT FIELD CURRENT
#                    END IF 
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj001 = g_inbj_d_t.inbj001
#                       NEXT FIELD CURRENT
#                    END IF
                    IF NOT aint311_change_lot() THEN
                       NEXT FIELD CURRENT
                    END IF
                 ELSE
                    CALL aint311_inbj001_ref() 
                 END IF
                 
#               END IF
            END IF 
            
               
            
            
            CALL aint311_set_entry_b(l_cmd)
            CALL aint311_set_no_entry_b(l_cmd)
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj001
            #add-point:BEFORE FIELD inbj001 name="input.b.page1.inbj001"
            CALL aint311_inbj001_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj001
            #add-point:ON CHANGE inbj001 name="input.g.page1.inbj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj002
            
            #add-point:AFTER FIELD inbj002 name="input.a.page1.inbj002"
            CALL s_feature_description(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002) RETURNING g_success,g_inbj_d[l_ac].inbj002_desc
            IF g_inbj_d[l_ac].inbj002 IS NOT NULL THEN
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj002 != g_inbj_d_o.inbj002 OR g_inbj_d_o.inbj002 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                    CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                    DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                    IF NOT aint311_change_lot() THEN
                       NEXT FIELD CURRENT
                    END IF
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj002 = g_inbj_d_t.inbj002
#                       NEXT FIELD CURRENT 
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj002 = g_inbj_d_t.inbj002
#                       NEXT FIELD inbj009
#                    END IF
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj002 = g_inbj_d_t.inbj002
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj002 = g_inbj_d_t.inbj002
#                       NEXT FIELD CURRENT
#                    END IF
                  END IF
#               END IF
            END IF
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj002
            #add-point:BEFORE FIELD inbj002 name="input.b.page1.inbj002"
             CALL s_feature_description(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002) RETURNING g_success,g_inbj_d[l_ac].inbj002_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj002
            #add-point:ON CHANGE inbj002 name="input.g.page1.inbj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj002_desc
            #add-point:BEFORE FIELD inbj002_desc name="input.b.page1.inbj002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj002_desc
            
            #add-point:AFTER FIELD inbj002_desc name="input.a.page1.inbj002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj002_desc
            #add-point:ON CHANGE inbj002_desc name="input.g.page1.inbj002_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj005
            
            #add-point:AFTER FIELD inbj005 name="input.a.page1.inbj005"
            CALL aint311_inbj005_desc()
            IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj005
                  
               #呼叫檢查存在並帶值的library
               IF g_para = 'Y' THEN
                  #160318-00025#16 by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#16 by 07900 --add-end
                  IF cl_chk_exist("v_inaa001_10") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
                     NEXT FIELD CURRENT
                  END IF
               ELSE 
                  #160318-00025#16 by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#16 by 07900 --add-end
                  IF cl_chk_exist("v_inaa001_2") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_control_chk_doc('6',g_inbi_m.inbidocno,g_inbj_d[l_ac].inbj005,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_inbj_d[l_ac].inbj005) AND NOT cl_null(g_inbj_d[l_ac].inbj006)  THEN  
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM inab_t
                   WHERE inabent = g_enterprise
                     AND inabsite = g_site
                     AND inab001 = g_inbj_d[l_ac].inbj005
                     AND inab002 = g_inbj_d[l_ac].inbj006
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     LET g_inbj_d[l_ac].inbj006 = ' '                            
                  END IF                                              
               END IF
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj005 != g_inbj_d_o.inbj005 OR g_inbj_d_o.inbj005 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                     IF NOT aint311_change_lot() THEN
                       NEXT FIELD CURRENT
                     END IF
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
#                       NEXT FIELD inbj009
#                    END IF
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj005 = g_inbj_d_t.inbj005
#                       NEXT FIELD CURRENT
#                    END IF
                  ELSE
                   #  IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
                      IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) THEN 
                         IF g_inbj_d[l_ac].inbj005 != g_inbj_d_o.inbj005 OR g_inbj_d_o.inbj005 IS NULL OR
                            g_inbj_d[l_ac].inbj006 != g_inbj_d_o.inbj006 OR g_inbj_d_o.inbj006 IS NULL OR
                            g_inbj_d[l_ac].inbj007 != g_inbj_d_o.inbj007 OR g_inbj_d_o.inbj007 IS NULL THEN                        
                            CALL s_lot_inao_chk(g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,'1',g_site) RETURNING g_success,l_count
                            IF l_count > 0 THEN
                               IF g_success THEN
                                  DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbi_m.inbidocno
                                     AND inaoseq = g_inbj_d[l_ac].inbjseq
                                   SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                                  IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                                     NEXT FIELD CURRENT
                                  ELSE
                                     CALL aint311_inao_b_fill()
                                  END IF  
                               ELSE
                                  LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
                                  LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
                                  LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
                               END IF                           
                            ELSE
                               SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                               IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                                  LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
                                  LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
                                  LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
                                  NEXT FIELD CURRENT
                               ELSE
                                  CALL aint311_inao_b_fill()
                               END IF
                            END IF
                         END IF
                      END IF
                  END IF
#               END IF
                
            END IF 
            LET g_inbj_d_o.inbj005 = g_inbj_d[l_ac].inbj005
            LET g_inbj_d_o.inbj006 = g_inbj_d[l_ac].inbj006
            LET g_inbj_d_o.inbj007 = g_inbj_d[l_ac].inbj007
            CALL aint311_set_entry_b(l_cmd)
            CALL aint311_set_no_entry_b(l_cmd)
            CALL aint311_detail_back()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj005
            #add-point:BEFORE FIELD inbj005 name="input.b.page1.inbj005"
            CALL aint311_inbj005_desc()
            CALL aint311_inbj006_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj005
            #add-point:ON CHANGE inbj005 name="input.g.page1.inbj005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj006
            
            #add-point:AFTER FIELD inbj006 name="input.a.page1.inbj006"
            CALL aint311_inbj006_desc()
            IF g_inbj_d[l_ac].inbj006 IS NOT NULL THEN
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj005
               LET g_chkparam.arg2 = g_inbj_d[l_ac].inbj006 
               #160318-00025#16 by 07900 --add-str
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#16 by 07900 --add-end
               IF cl_chk_exist("v_inab002_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  LET g_inbj_d[l_ac].inbj006 = g_inbj_d_t.inbj006
                  NEXT FIELD CURRENT
               END IF
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj006 != g_inbj_d_o.inbj006 OR g_inbj_d_o.inbj006 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj006 = g_inbj_d_t.inbj006
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj006 = g_inbj_d_t.inbj006
#                       NEXT FIELD inbj009
#                    END IF
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj006 = g_inbj_d_t.inbj006
#                       NEXT FIELD CURRENT
#                    END IF 
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj006 = g_inbj_d_t.inbj006
#                       NEXT FIELD CURRENT
#                    END IF
                  ELSE
                    # IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
                      IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) THEN 
                        IF g_inbj_d[l_ac].inbj005 != g_inbj_d_o.inbj005 OR g_inbj_d_o.inbj005 IS NULL OR
                           g_inbj_d[l_ac].inbj006 != g_inbj_d_o.inbj006 OR g_inbj_d_o.inbj006 IS NULL OR
                           g_inbj_d[l_ac].inbj007 != g_inbj_d_o.inbj007 OR g_inbj_d_o.inbj007 IS NULL THEN      
                           CALL s_lot_inao_chk(g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,'1',g_site) RETURNING g_success,l_count
                           IF l_count > 0 THEN
                              IF g_success THEN
                                 DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbi_m.inbidocno
                                   AND inaoseq = g_inbj_d[l_ac].inbjseq
                                 SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                                 IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                                    NEXT FIELD CURRENT
                                 ELSE
                                    CALL aint311_inao_b_fill()
                                 END IF  
                              ELSE
                                 LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
                                 LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
                                 LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
                              END IF                           
                           ELSE
                              SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                              IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                                 LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
                                 LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
                                 LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
                                 NEXT FIELD CURRENT
                              ELSE
                                 CALL aint311_inao_b_fill()
                              END IF
                           END IF
                        END IF
                     END IF
                  END IF
#               END IF
               
            ELSE 
               LET g_inbj_d[l_ac].inbj006 = " "
            END IF
            LET g_inbj_d_o.inbj005 = g_inbj_d[l_ac].inbj005
            LET g_inbj_d_o.inbj006 = g_inbj_d[l_ac].inbj006
            LET g_inbj_d_o.inbj007 = g_inbj_d[l_ac].inbj007
            CALL aint311_detail_back()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj006
            #add-point:BEFORE FIELD inbj006 name="input.b.page1.inbj006"
            CALL aint311_inbj005_desc()
            CALL aint311_inbj006_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj006
            #add-point:ON CHANGE inbj006 name="input.g.page1.inbj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj007
            #add-point:BEFORE FIELD inbj007 name="input.b.page1.inbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj007
            
            #add-point:AFTER FIELD inbj007 name="input.a.page1.inbj007"
            IF g_inbj_d[l_ac].inbj007 IS NOT NULL THEN
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj007 != g_inbj_d_o.inbj007 OR g_inbj_d_o.inbj007 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj007 = g_inbj_d_t.inbj007
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj007 = g_inbj_d_t.inbj007
#                       NEXT FIELD inbj009
#                    END IF
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj007 = g_inbj_d_t.inbj007
#                       NEXT FIELD CURRENT                  
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj007 = g_inbj_d_t.inbj007
#                       NEXT FIELD CURRENT
#                    END IF
                  ELSE
                    # IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
                      IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) THEN 
                        IF g_inbj_d[l_ac].inbj005 != g_inbj_d_o.inbj005 OR g_inbj_d_o.inbj005 IS NULL OR
                           g_inbj_d[l_ac].inbj006 != g_inbj_d_o.inbj006 OR g_inbj_d_o.inbj006 IS NULL OR
                           g_inbj_d[l_ac].inbj007 != g_inbj_d_o.inbj007 OR g_inbj_d_o.inbj007 IS NULL THEN      
                           CALL s_lot_inao_chk(g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,'1',g_site) RETURNING g_success,l_count
                           IF l_count > 0 THEN
                              IF g_success THEN
                                 DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbi_m.inbidocno
                                   AND inaoseq = g_inbj_d[l_ac].inbjseq
                                 SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                                 IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                                    NEXT FIELD CURRENT
                                 ELSE
                                    CALL aint311_inao_b_fill()
                                 END IF  
                              ELSE
                                 LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
                                 LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
                                 LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
                              END IF                           
                           ELSE
                              SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                              IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                                 LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
                                 LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
                                 LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
                                 NEXT FIELD CURRENT
                              ELSE
                                 CALL aint311_inao_b_fill()
                              END IF
                           END IF
                        END IF
                     END IF
                  END IF
#               END IF
               
            ELSE
               LET g_inbj_d[l_ac].inbj007 = " "
            END IF
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*
            CALL aint311_detail_back()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj007
            #add-point:ON CHANGE inbj007 name="input.g.page1.inbj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj003
            #add-point:BEFORE FIELD inbj003 name="input.b.page1.inbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj003
            
            #add-point:AFTER FIELD inbj003 name="input.a.page1.inbj003"
            IF g_inbj_d[l_ac].inbj003 IS NOT NULL THEN
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj003 != g_inbj_d_o.inbj003 OR g_inbj_d_o.inbj003 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj003 = g_inbj_d_t.inbj003
#                       NEXT FIELD CURRENT
#                    END IF
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj003 = g_inbj_d_t.inbj003
#                       NEXT FIELD inbj009
#                    END IF
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj003 = g_inbj_d_t.inbj003
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj003 = g_inbj_d_t.inbj003
#                       NEXT FIELD CURRENT
#                    END IF
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
#               END IF
            END IF
            CALL aint311_detail_back()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj003
            #add-point:ON CHANGE inbj003 name="input.g.page1.inbj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj008
            
            #add-point:AFTER FIELD inbj008 name="input.a.page1.inbj008"
            IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj008

               #160318-00025#16 by 07900 --add-str
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#16 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_inbj_d[l_ac].inbj008 = g_inbj_d_t.inbj008
                  NEXT FIELD CURRENT
               END IF
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj008 != g_inbj_d_o.inbj008 OR g_inbj_d_o.inbj008 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
#                    IF NOT aint311_inaq_chk() THEN
#                       LET g_inbj_d[l_ac].inbj008 = g_inbj_d_t.inbj008
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk(l_cmd) THEN
#                       LET g_inbj_d[l_ac].inbj008 = g_inbj_d_t.inbj008
#                       NEXT FIELD inbj009
#                    END IF
#                 ELSE
#                    IF NOT aint311_inag_chk() THEN
#                       LET g_inbj_d[l_ac].inbj008 = g_inbj_d_t.inbj008
#                       NEXT FIELD CURRENT
#                    END IF
#                    
#                    IF NOT aint311_inbj009_chk_2() THEN
#                       LET g_inbj_d[l_ac].inbj008 = g_inbj_d_t.inbj008
#                       NEXT FIELD CURRENT
#                    END IF
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
#               END IF
            END IF 
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj008
            #add-point:BEFORE FIELD inbj008 name="input.b.page1.inbj008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj008
            #add-point:ON CHANGE inbj008 name="input.g.page1.inbj008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj016
            
            #add-point:AFTER FIELD inbj016 name="input.a.page1.inbj016"
            CALL aint311_inbj016_desc()
            IF NOT cl_null(g_inbj_d[l_ac].inbj016) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_inbj_d[l_ac].inbj016) THEN
                  LET g_inbj_d[l_ac].inbj016 = g_inbj_d_t.inbj016
                  NEXT FIELD CURRENT
               END IF
               CALL s_control_chk_doc('8',g_inbi_m.inbidocno,g_inbj_d[l_ac].inbj016,'','','','') RETURNING g_success,l_flag
               IF g_success THEN
                  IF NOT l_flag THEN
                     LET g_inbj_d[l_ac].inbj016 = g_inbj_d_t.inbj016
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_inbj_d[l_ac].inbj016 = g_inbj_d_t.inbj016
                  NEXT FIELD CURRENT
               END IF
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj016 != g_inbj_d_o.inbj016 OR g_inbj_d_o.inbj016 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                        CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                        DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                     IF NOT aint311_inaq_chk() THEN
                        LET g_inbj_d[l_ac].inbj016 = g_inbj_d_t.inbj016
                        NEXT FIELD CURRENT 
                     END IF
                     IF NOT aint311_inbj009_chk(l_cmd) THEN
                        LET g_inbj_d[l_ac].inbj016 = g_inbj_d_t.inbj016
                        NEXT FIELD inbj009
                     END IF
                     
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
#               END IF
            END IF
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj016
            #add-point:BEFORE FIELD inbj016 name="input.b.page1.inbj016"
            CALL aint311_inbj016_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj016
            #add-point:ON CHANGE inbj016 name="input.g.page1.inbj016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj017
            
            #add-point:AFTER FIELD inbj017 name="input.a.page1.inbj017"
            CALL aint311_inbj017_desc()
            IF NOT cl_null(g_inbj_d[l_ac].inbj017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj017
               LET g_chkparam.arg2 = g_inbi_m.inbidocdt
                  
               #呼叫檢查存在並帶值的library
              # IF cl_chk_exist("v_ooeg001") THEN  #160315-00009#1 mark
                IF cl_chk_exist("v_ooeg001_8") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  LET g_inbj_d[l_ac].inbj017 = g_inbj_d_t.inbj017
                  NEXT FIELD CURRENT
               END IF
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj017 != g_inbj_d_o.inbj017 OR g_inbj_d_o.inbj017 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                     IF NOT aint311_inaq_chk() THEN
                        LET g_inbj_d[l_ac].inbj017 = g_inbj_d_t.inbj017
                        NEXT FIELD CURRENT 
                     END IF
                     IF NOT aint311_inbj009_chk(l_cmd) THEN
                        LET g_inbj_d[l_ac].inbj017 = g_inbj_d_t.inbj017
                        NEXT FIELD inbj009
                     END IF
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
#               END IF
            END IF 
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj017
            #add-point:BEFORE FIELD inbj017 name="input.b.page1.inbj017"
            CALL aint311_inbj017_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj017
            #add-point:ON CHANGE inbj017 name="input.g.page1.inbj017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj018
            #add-point:BEFORE FIELD inbj018 name="input.b.page1.inbj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj018
            
            #add-point:AFTER FIELD inbj018 name="input.a.page1.inbj018"
            IF NOT cl_null(g_inbj_d[l_ac].inbj018) THEN
#               IF l_cmd = 'a' OR (g_inbj_d[l_ac].inbj018 != g_inbj_d_o.inbj018 OR g_inbj_d_o.inbj018 IS NULL) THEN   
                  IF g_para = 'Y' THEN
#                     CALL aint311_get_def_num(l_cmd) RETURNING g_inbj_d[l_ac].inbj009
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj009
                     IF NOT aint311_inaq_chk() THEN
                        LET g_inbj_d[l_ac].inbj018 = g_inbj_d_t.inbj018
                        NEXT FIELD CURRENT 
                     END IF
                     IF NOT aint311_inbj009_chk(l_cmd) THEN
                        LET g_inbj_d[l_ac].inbj018 = g_inbj_d_t.inbj018
                        NEXT FIELD inbj009
                     END IF
                     IF NOT aint311_change_lot() THEN
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT aint311_inbj009_chk_2() THEN
                        LET g_inbj_d[l_ac].inbj009 = g_inbj_d_t.inbj009
                        NEXT FIELD CURRENT
                     END IF
                    
                  END IF
#               END IF
            END IF
            LET g_inbj_d_o.* = g_inbj_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj018
            #add-point:ON CHANGE inbj018 name="input.g.page1.inbj018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbj_d[l_ac].inbj009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inbj009
            END IF 
 
 
 
            #add-point:AFTER FIELD inbj009 name="input.a.page1.inbj009"
            IF NOT cl_null(g_inbj_d[l_ac].inbj009) THEN 
               IF g_para = 'Y' THEN
                  IF NOT aint311_inbj009_chk(l_cmd) THEN
                     LET g_inbj_d[l_ac].inbj009 = g_inbj_d_t.inbj009
                     NEXT FIELD CURRENT
                  END IF
               ELSE
#                  IF NOT aint311_inbj009_chk_2() THEN
#                     LET g_inbj_d[l_ac].inbj009 = g_inbj_d_t.inbj009
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT cl_null(g_inbj_d[l_ac].inbj008) AND NOT cl_null(g_inbj_d[l_ac].inbj011) THEN
#                     CALL s_aooi250_convert_qty(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj008,g_inbj_d[l_ac].inbj011,g_inbj_d[l_ac].inbj009) 
#                        RETURNING g_success,g_inbj_d[l_ac].inbj012
#                  
#                     DISPLAY BY NAME g_inbj_d[l_ac].inbj012
#                  END IF
#                  
               END IF
             
               #170222-00045#1 add   --begin--
               #需检查库存量
               #参考数量、实际数量等赋值             
               CALL s_inventory_check_inan(g_site,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,
                                           g_inbj_d[l_ac].inbj007,g_inbj_d[l_ac].inbj008,g_inbj_d[l_ac].inbj009,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,0,'','') 
                    RETURNING l_success,l_flag1
               IF NOT l_success OR l_flag1 = 0 THEN
                  LET g_inbj_d[l_ac].inbj009 = g_inbj_d_t.inbj009
                  NEXT FIELD CURRENT
               END IF
             
               LET g_inbj_d[l_ac].inbj010 = g_inbj_d[l_ac].inbj009
               IF NOT cl_null(g_inbj_d[l_ac].inbj008) AND NOT cl_null(g_inbj_d[l_ac].inbj011) THEN
                  CALL s_aooi250_convert_qty(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj008,g_inbj_d[l_ac].inbj011,g_inbj_d[l_ac].inbj009)
                     RETURNING l_success,g_inbj_d[l_ac].inbj012
            
                  IF l_success THEN
                     LET g_inbj_d[l_ac].inbj013 = g_inbj_d[l_ac].inbj012
                  END IF        
               END IF
               #170222-00045#1 add   --end--
               
               IF cl_null(g_inbj_d_o.inbj009) OR g_inbj_d_o.inbj009 != g_inbj_d[l_ac].inbj009 THEN
                  CALL aint311_detail_default()
                  IF NOT cl_null(g_inbj_d[l_ac].inbj001) AND NOT cl_null(g_inbj_d[l_ac].inbj005) AND NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                     IF aint311_pxh_chk() THEN
                    #  IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
                       IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) THEN 
                         IF g_para = 'N' THEN
                            SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite AND imaf001 = g_inbj_d[l_ac].inbj001
                            IF NOT s_lot_sel('1','2',g_site,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007,l_imaf053,g_inbj_d[l_ac].inbj009,-1,g_prog,g_site,'','','',0) THEN
                               NEXT FIELD CURRENT
                            END IF
                         ELSE
                            CALL aint311_default_inav(g_inbj_d[l_ac].*)
                            IF NOT s_aint311_lot_sel(g_inav.*,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq) THEN
                               NEXT FIELD CURRENT
                            END IF
                         END IF
                         CALL aint311_inao_b_fill()
                     END IF
                  END IF
               END IF
            END IF 
            LET g_inbj_d_o.inbj009 = g_inbj_d[l_ac].inbj009

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj009
            #add-point:BEFORE FIELD inbj009 name="input.b.page1.inbj009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj009
            #add-point:ON CHANGE inbj009 name="input.g.page1.inbj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj012
            #add-point:BEFORE FIELD inbj012 name="input.b.page1.inbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj012
            
            #add-point:AFTER FIELD inbj012 name="input.a.page1.inbj012"
            #170222-00045#1 add  --begin--
            IF NOT cl_null(g_inbj_d[l_ac].inbj012) THEN
               LET g_inbj_d[l_ac].inbj013 = g_inbj_d[l_ac].inbj012
            END IF
            #170222-00045#1 add  --end--
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj012
            #add-point:ON CHANGE inbj012 name="input.g.page1.inbj012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj004
            
            #add-point:AFTER FIELD inbj004 name="input.a.page1.inbj004"
            IF NOT cl_null(g_inbj_d[l_ac].inbj004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj004
               #160318-00025#16 by 07900 --add-str
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#16 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_inbj_d[l_ac].inbj004 = g_inbj_d_t.inbj004
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj004
            #add-point:BEFORE FIELD inbj004 name="input.b.page1.inbj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj004
            #add-point:ON CHANGE inbj004 name="input.g.page1.inbj004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj014
            
            #add-point:AFTER FIELD inbj014 name="input.a.page1.inbj014"
            CALL aint311_inbj014_desc()
            IF NOT cl_null(g_inbj_d[l_ac].inbj014) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj014
               #160318-00025#16 by 07900 --add-str
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#16 by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001_8") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_inbj_d[l_ac].inbj014 = g_inbj_d_t.inbj014
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL aint311_set_entry_b(l_cmd)
            CALL aint311_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj014
            #add-point:BEFORE FIELD inbj014 name="input.b.page1.inbj014"
            CALL aint311_inbj014_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj014
            #add-point:ON CHANGE inbj014 name="input.g.page1.inbj014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj015
            
            #add-point:AFTER FIELD inbj015 name="input.a.page1.inbj015"
            CALL aint311_inbj015_desc()
            IF NOT cl_null(g_inbj_d[l_ac].inbj015) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj014
               LET g_chkparam.arg2 = g_inbj_d[l_ac].inbj015  
               #160318-00025#16 by 07900 --add-str
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#16 by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inab002_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_inbj_d[l_ac].inbj015 = g_inbj_d_t.inbj015
                  NEXT FIELD CURRENT
               END IF
            END IF
         
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj015
            #add-point:BEFORE FIELD inbj015 name="input.b.page1.inbj015"
            CALL aint311_inbj015_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj015
            #add-point:ON CHANGE inbj015 name="input.g.page1.inbj015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj019
            
            #add-point:AFTER FIELD inbj019 name="input.a.page1.inbj019"
            CALL s_desc_get_project_desc(g_inbj_d[l_ac].inbj019) RETURNING g_inbj_d[l_ac].inbj019_desc
            DISPLAY BY NAME g_inbj_d[l_ac].inbj019_desc
            
            IF NOT cl_null(g_inbj_d[l_ac].inbj019) THEN 
               IF g_inbj_d[l_ac].inbj019 != g_inbj_d_o.inbj019 OR cl_null(g_inbj_d_o.inbj019) THEN
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj019
                   #160318-00025#16 by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
                  #160318-00025#16 by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pjba001") THEN
                     #檢查成功時後續處理
                     LET g_inbj_d[l_ac].inbj019 = g_inbj_d_o.inbj019
                     CALL s_desc_get_project_desc(g_inbj_d[l_ac].inbj019) RETURNING g_inbj_d[l_ac].inbj019_desc
                     DISPLAY BY NAME g_inbj_d[l_ac].inbj019_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_inbj_d[l_ac].inbj020 = ''
                  LET g_inbj_d[l_ac].inbj020_desc = ''
                  LET g_inbj_d[l_ac].inbj021 = ''
                  LET g_inbj_d[l_ac].inbj021_desc = ''
               END IF
            END IF 
            LET g_inbj_d_o.inbj019 = g_inbj_d[l_ac].inbj019
 
            CALL aint311_set_entry_b(l_cmd)
            CALL aint311_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj019
            #add-point:BEFORE FIELD inbj019 name="input.b.page1.inbj019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj019
            #add-point:ON CHANGE inbj019 name="input.g.page1.inbj019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj020
            
            #add-point:AFTER FIELD inbj020 name="input.a.page1.inbj020"
            CALL s_desc_get_wbs_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj020) RETURNING g_inbj_d[l_ac].inbj020_desc
            DISPLAY BY NAME g_inbj_d[l_ac].inbj020_desc
            
            IF NOT cl_null(g_inbj_d[l_ac].inbj020) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj019
               LET g_chkparam.arg2 = g_inbj_d[l_ac].inbj020
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbb002") THEN
                  #檢查失敗時後續處理
                  LET g_inbj_d[l_ac].inbj020 = g_inbj_d_t.inbj020
                  CALL s_desc_get_wbs_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj020) RETURNING g_inbj_d[l_ac].inbj020_desc
                  DISPLAY BY NAME g_inbj_d[l_ac].inbj020_desc
                  NEXT FIELD CURRENT
               END IF

            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj020
            #add-point:BEFORE FIELD inbj020 name="input.b.page1.inbj020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj020
            #add-point:ON CHANGE inbj020 name="input.g.page1.inbj020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj021
            
            #add-point:AFTER FIELD inbj021 name="input.a.page1.inbj021"
            CALL s_desc_get_activity_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj021) RETURNING g_inbj_d[l_ac].inbj021_desc
            DISPLAY BY NAME g_inbj_d[l_ac].inbj021_desc
            
            IF NOT cl_null(g_inbj_d[l_ac].inbj021) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbj_d[l_ac].inbj019
               LET g_chkparam.arg2 = g_inbj_d[l_ac].inbj021
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbm002") THEN
                  #檢查失敗時後續處理
                  LET g_inbj_d[l_ac].inbj021 = g_inbj_d_t.inbj021
                  CALL s_desc_get_activity_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj021) RETURNING g_inbj_d[l_ac].inbj021_desc
                  DISPLAY BY NAME g_inbj_d[l_ac].inbj021_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj021
            #add-point:BEFORE FIELD inbj021 name="input.b.page1.inbj021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj021
            #add-point:ON CHANGE inbj021 name="input.g.page1.inbj021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj031
            #add-point:BEFORE FIELD inbj031 name="input.b.page1.inbj031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj031
            
            #add-point:AFTER FIELD inbj031 name="input.a.page1.inbj031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj031
            #add-point:ON CHANGE inbj031 name="input.g.page1.inbj031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbjsite
            #add-point:BEFORE FIELD inbjsite name="input.b.page1.inbjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbjsite
            
            #add-point:AFTER FIELD inbjsite name="input.a.page1.inbjsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbjsite
            #add-point:ON CHANGE inbjsite name="input.g.page1.inbjsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbj_d[l_ac].inbj010,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inbj010
            END IF 
 
 
 
            #add-point:AFTER FIELD inbj010 name="input.a.page1.inbj010"
            IF NOT cl_null(g_inbj_d[l_ac].inbj010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj010
            #add-point:BEFORE FIELD inbj010 name="input.b.page1.inbj010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj010
            #add-point:ON CHANGE inbj010 name="input.g.page1.inbj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbj013
            #add-point:BEFORE FIELD inbj013 name="input.b.page1.inbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbj013
            
            #add-point:AFTER FIELD inbj013 name="input.a.page1.inbj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbj013
            #add-point:ON CHANGE inbj013 name="input.g.page1.inbj013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inbjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbjseq
            #add-point:ON ACTION controlp INFIELD inbjseq name="input.c.page1.inbjseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj001
            #add-point:ON ACTION controlp INFIELD inbj001 name="input.c.page1.inbj001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

                      #給予default值
            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj001 
           
            LET g_qryparam.where = " 1=1"  
            LET g_qryparam.arg1 = g_acc
            IF g_para = 'Y' THEN
               CALL aint311_default_controlp()
            ELSE
#                IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
#               END IF
               
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT * FROM imaa_t WHERE imaaent = inagent AND imaa001 = inag001 AND imaastus = 'Y')"
              
               CALL s_control_get_doc_sql('inag001',g_inbi_m.inbidocno,'4')
                                   RETURNING g_success,l_sql
               IF g_success THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_sql
               END IF
               
               CALL s_control_get_doc_sql('inbj001',g_inbi_m.inbidocno,'5')
                                   RETURNING g_success,l_sql
               IF g_success THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_sql
               END IF
               CALL q_inag001()                                #呼叫開窗
               LET g_inbj_d[l_ac].inbj001 = g_qryparam.return1 
               DISPLAY g_inbj_d[l_ac].inbj001 TO inbj001 
            END IF

                         

                        #

            NEXT FIELD inbj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj002
            #add-point:ON ACTION controlp INFIELD inbj002 name="input.c.page1.inbj002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

           #給予default值
            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj002 
            

            LET g_qryparam.where = " 1=1"  
            IF g_para = 'Y' THEN 
              CALL aint311_default_controlp()
            ELSE
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
               END IF
                   
#               IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
#               END IF
              
               
               CALL q_inag002()                                #呼叫開窗
               LET g_inbj_d[l_ac].inbj002 = g_qryparam.return1 
            END IF
                         

            DISPLAY g_inbj_d[l_ac].inbj002 TO inbj002              #

            NEXT FIELD inbj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj002_desc
            #add-point:ON ACTION controlp INFIELD inbj002_desc name="input.c.page1.inbj002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj005
            #add-point:ON ACTION controlp INFIELD inbj005 name="input.c.page1.inbj005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj005             #給予default值
            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj006
            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj007
            #給予arg
            LET g_qryparam.arg1 = "" #

          # LET g_qryparam.where = " inaa016 = 'N'"
            LET g_qryparam.where = " 1=1"  
            IF g_para = 'Y' THEN
              CALL aint311_default_controlp()
            ELSE
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
               END IF
               
               IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
#               END IF
                       
#               IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
#               END IF
               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
#               END IF
               
               CALL s_control_get_doc_sql('inag004',g_inbi_m.inbidocno,'6')
                                   RETURNING g_success,l_sql
               IF g_success THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_sql
               END IF
               
               CALL q_inag004_12()
               LET g_inbj_d[l_ac].inbj005 = g_qryparam.return1    
               LET g_inbj_d[l_ac].inbj006 = g_qryparam.return2    
               LET g_inbj_d[l_ac].inbj007 = g_qryparam.return3  
               CALL aint311_inbj006_desc()
               DISPLAY g_inbj_d[l_ac].inbj005 TO inbj005              #
               DISPLAY g_inbj_d[l_ac].inbj006 TO inbj006 
               DISPLAY g_inbj_d[l_ac].inbj007 TO inbj007 
            END IF
                       
            
#            DISPLAY g_inbj_d[l_ac].inbj005 TO inbj005              #

            NEXT FIELD inbj005                           #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj006
            #add-point:ON ACTION controlp INFIELD inbj006 name="input.c.page1.inbj006"
            #此段落由子樣板a07產生            
            #開窗i段
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

#            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj006             #給予default值
            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj005             #給予default值
            LET g_qryparam.default2 = g_inbj_d[l_ac].inbj006
            LET g_qryparam.default3 = g_inbj_d[l_ac].inbj007

            LET g_qryparam.where = " 1=1"  
            IF g_para = 'Y' THEN
               CALL aint311_default_controlp()
            ELSE
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
               END IF
               
               IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
               END IF
               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
#               END IF
               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
#               END IF
#               
               
#               CALL q_inag005_6()
               CALL q_inag004_12()
               LET g_inbj_d[l_ac].inbj005 = g_qryparam.return1    
               LET g_inbj_d[l_ac].inbj006 = g_qryparam.return2    
               LET g_inbj_d[l_ac].inbj007 = g_qryparam.return3   
               DISPLAY g_inbj_d[l_ac].inbj005 TO inbj005              #
               CALL aint311_inbj005_desc()
               DISPLAY g_inbj_d[l_ac].inbj006 TO inbj006 
               DISPLAY g_inbj_d[l_ac].inbj007 TO inbj007 
            END IF
            
#            LET g_inbj_d[l_ac].inbj006 = g_qryparam.return1              
#
#            DISPLAY g_inbj_d[l_ac].inbj006 TO inbj006              #
#
            NEXT FIELD inbj006                           #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj007
            #add-point:ON ACTION controlp INFIELD inbj007 name="input.c.page1.inbj007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

#            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj007             #給予default值
            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj005             #給予default值
            LET g_qryparam.default2 = g_inbj_d[l_ac].inbj006
            LET g_qryparam.default3 = g_inbj_d[l_ac].inbj007
            LET g_qryparam.where = " 1=1"  
            IF g_para = 'Y' THEN
               CALL aint311_default_controlp()
            ELSE
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
               END IF
               
               IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
               END IF
               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
#               END IF
               
               CALL q_inag004_12()
#               CALL q_inag006_1()
               LET g_inbj_d[l_ac].inbj005 = g_qryparam.return1    
               LET g_inbj_d[l_ac].inbj006 = g_qryparam.return2    
               LET g_inbj_d[l_ac].inbj007 = g_qryparam.return3   
               DISPLAY g_inbj_d[l_ac].inbj005 TO inbj005              #
               CALL aint311_inbj005_desc()
               DISPLAY g_inbj_d[l_ac].inbj006 TO inbj006 
               CALL aint311_inbj006_desc()
               DISPLAY g_inbj_d[l_ac].inbj007 TO inbj007 
            END IF
            
#            LET g_inbj_d[l_ac].inbj007 = g_qryparam.return1              
#
#            DISPLAY g_inbj_d[l_ac].inbj007 TO inbj007              #

            NEXT FIELD inbj007                            #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj003
            #add-point:ON ACTION controlp INFIELD inbj003 name="input.c.page1.inbj003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj003             #給予default值

            LET g_qryparam.where = " 1=1"  
            IF g_para = 'Y' THEN
               CALL aint311_default_controlp()
            ELSE
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
               END IF
               
               IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
               END IF
               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
#               END IF
               
               
               CALL q_inag003_1()
               LET g_inbj_d[l_ac].inbj003 = g_qryparam.return1  
            END IF
                        

            DISPLAY g_inbj_d[l_ac].inbj003 TO inbj003              #

            NEXT FIELD inbj003                         #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj008
            #add-point:ON ACTION controlp INFIELD inbj008 name="input.c.page1.inbj008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj008             #給予default值

            LET g_qryparam.where = " 1=1"  
            IF g_para = 'Y' THEN
               CALL aint311_default_controlp()
            ELSE
               IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
               END IF
               
               IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
                  LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
               END IF
               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
#               END IF
#               
#               IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
#                  LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
#               END IF
                     
               CALL q_inag007()
               LET g_inbj_d[l_ac].inbj008 = g_qryparam.return1              
               DISPLAY g_inbj_d[l_ac].inbj008 TO inbj008
            END IF

                          #

            NEXT FIELD inbj008                           #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj016
            #add-point:ON ACTION controlp INFIELD inbj016 name="input.c.page1.inbj016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj016             #給予default值

            #給予arg
            LET g_qryparam.where = " 1=1 "
            IF g_para = 'Y' THEN
              CALL aint311_default_controlp()
            ELSE
               LET g_qryparam.arg1 = g_acc
               LET g_qryparam.where = " 1=1 "
               CALL s_control_get_doc_sql('oocq002',g_inbi_m.inbidocno,'8')
                                   RETURNING g_success,l_sql
               IF g_success THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_sql
               END IF
               
               CALL q_oocq002()                                #呼叫開窗
              
               LET g_inbj_d[l_ac].inbj016 = g_qryparam.return1    
               DISPLAY g_inbj_d[l_ac].inbj016 TO inbj016                  
                       #
            END IF
                          

                       #

            NEXT FIELD inbj016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj017
            #add-point:ON ACTION controlp INFIELD inbj017 name="input.c.page1.inbj017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj017             #給予default值

            #給予arg
            LET g_qryparam.where = " 1=1 "
            IF g_para = 'Y' THEN
              CALL aint311_default_controlp()
            ELSE
               LET g_qryparam.arg1 = g_inbi_m.inbidocdt #

               CALL q_ooeg001()                                #呼叫開窗
              
               LET g_inbj_d[l_ac].inbj017 = g_qryparam.return1   
               DISPLAY g_inbj_d[l_ac].inbj017 TO inbj017                
            END IF
                         #

            NEXT FIELD inbj017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj018
            #add-point:ON ACTION controlp INFIELD inbj018 name="input.c.page1.inbj018"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj017             #給予default值

            #給予arg
            LET g_qryparam.where = " 1=1 "
            IF g_para = 'Y' THEN
               CALL aint311_default_controlp()
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj009
            #add-point:ON ACTION controlp INFIELD inbj009 name="input.c.page1.inbj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj012
            #add-point:ON ACTION controlp INFIELD inbj012 name="input.c.page1.inbj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj004
            #add-point:ON ACTION controlp INFIELD inbj004 name="input.c.page1.inbj004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001_12()                                #呼叫開窗

            LET g_inbj_d[l_ac].inbj004 = g_qryparam.return1              

            DISPLAY g_inbj_d[l_ac].inbj004 TO inbj004              #

            NEXT FIELD inbj004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj014
            #add-point:ON ACTION controlp INFIELD inbj014 name="input.c.page1.inbj014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " inaa010 = 'N' AND inaa016 = 'N'"
            CALL q_inaa001()                                #呼叫開窗

            LET g_inbj_d[l_ac].inbj014 = g_qryparam.return1              

            DISPLAY g_inbj_d[l_ac].inbj014 TO inbj014              #

            NEXT FIELD inbj014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj015
            #add-point:ON ACTION controlp INFIELD inbj015 name="input.c.page1.inbj015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
        
            IF NOT cl_null(g_inbj_d[l_ac].inbj014) THEN
               LET g_qryparam.where = " inab001 = '",g_inbj_d[l_ac].inbj014,"'"
            END IF    
            CALL q_inab002()                                #呼叫開窗

            LET g_inbj_d[l_ac].inbj015 = g_qryparam.return1              

            DISPLAY g_inbj_d[l_ac].inbj015 TO inbj015              #

            NEXT FIELD inbj015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj019
            #add-point:ON ACTION controlp INFIELD inbj019 name="input.c.page1.inbj019"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pjba001()                                #呼叫開窗

            LET g_inbj_d[l_ac].inbj019 = g_qryparam.return1              

            DISPLAY g_inbj_d[l_ac].inbj019 TO inbj019              #
            CALL s_desc_get_project_desc(g_inbj_d[l_ac].inbj019) RETURNING g_inbj_d[l_ac].inbj019_desc
            DISPLAY BY NAME g_inbj_d[l_ac].inbj019_desc

            NEXT FIELD inbj019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj020
            #add-point:ON ACTION controlp INFIELD inbj020 name="input.c.page1.inbj020"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_inbj_d[l_ac].inbj019 #s


            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_inbj_d[l_ac].inbj020 = g_qryparam.return1              

            DISPLAY g_inbj_d[l_ac].inbj020 TO inbj020              #
            CALL s_desc_get_wbs_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj020) RETURNING g_inbj_d[l_ac].inbj020_desc
            DISPLAY BY NAME g_inbj_d[l_ac].inbj020_desc

            NEXT FIELD inbj020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj021
            #add-point:ON ACTION controlp INFIELD inbj021 name="input.c.page1.inbj021"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbj_d[l_ac].inbj021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_inbj_d[l_ac].inbj019 #s


            CALL q_pjbm002()                                #呼叫開窗

            LET g_inbj_d[l_ac].inbj021 = g_qryparam.return1              

            DISPLAY g_inbj_d[l_ac].inbj021 TO inbj021              #
            CALL s_desc_get_activity_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj021) RETURNING g_inbj_d[l_ac].inbj021_desc
            DISPLAY BY NAME g_inbj_d[l_ac].inbj021_desc

            NEXT FIELD inbj021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj031
            #add-point:ON ACTION controlp INFIELD inbj031 name="input.c.page1.inbj031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbjsite
            #add-point:ON ACTION controlp INFIELD inbjsite name="input.c.page1.inbjsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj010
            #add-point:ON ACTION controlp INFIELD inbj010 name="input.c.page1.inbj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbj013
            #add-point:ON ACTION controlp INFIELD inbj013 name="input.c.page1.inbj013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inbj_d[l_ac].* = g_inbj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint311_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inbj_d[l_ac].inbjseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inbj_d[l_ac].* = g_inbj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint311_inbj_t_mask_restore('restore_mask_o')
      
               UPDATE inbj_t SET (inbjdocno,inbjseq,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003, 
                   inbj008,inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019, 
                   inbj020,inbj021,inbj031,inbjsite,inbj010,inbj013) = (g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq, 
                   g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006, 
                   g_inbj_d[l_ac].inbj007,g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj008,g_inbj_d[l_ac].inbj016, 
                   g_inbj_d[l_ac].inbj017,g_inbj_d[l_ac].inbj018,g_inbj_d[l_ac].inbj009,g_inbj_d[l_ac].inbj011, 
                   g_inbj_d[l_ac].inbj012,g_inbj_d[l_ac].inbj004,g_inbj_d[l_ac].inbj014,g_inbj_d[l_ac].inbj015, 
                   g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj020,g_inbj_d[l_ac].inbj021,g_inbj_d[l_ac].inbj031, 
                   g_inbj_d[l_ac].inbjsite,g_inbj_d[l_ac].inbj010,g_inbj_d[l_ac].inbj013)
                WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbidocno 
 
                  AND inbjseq = g_inbj_d_t.inbjseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inbj_d[l_ac].* = g_inbj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inbj_d[l_ac].* = g_inbj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbi_m.inbidocno
               LET gs_keys_bak[1] = g_inbidocno_t
               LET gs_keys[2] = g_inbj_d[g_detail_idx].inbjseq
               LET gs_keys_bak[2] = g_inbj_d_t.inbjseq
               CALL aint311_update_b('inbj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint311_inbj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_inbj_d[g_detail_idx].inbjseq = g_inbj_d_t.inbjseq 
 
                  ) THEN
                  LET gs_keys[01] = g_inbi_m.inbidocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_inbj_d_t.inbjseq
 
                  CALL aint311_key_update_b(gs_keys,'inbj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inbi_m),util.JSON.stringify(g_inbj_d_t)
               LET g_log2 = util.JSON.stringify(g_inbi_m),util.JSON.stringify(g_inbj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aint311_unlock_b("inbj_t","'1'")
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
               LET g_inbj_d[li_reproduce_target].* = g_inbj_d[li_reproduce].*
 
               LET g_inbj_d[li_reproduce_target].inbjseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inbj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aint311.input.other" >}
      
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
            NEXT FIELD inbidocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inbjseq
 
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
      IF l_exit = 'N' THEN CONTINUE WHILE END IF   #161118-00011#1 add
      EXIT WHILE                                   #161118-00011#1 add
   END WHILE                                       #161118-00011#1 add
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint311_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_slip    STRING
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint311_b_fill() #單身填充
      CALL aint311_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint311_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            IF NOT cl_null(g_inbi_m.inbidocno) THEN
               CALL s_aooi200_get_slip(g_inbi_m.inbidocno) RETURNING g_success,l_slip
               CALL s_aooi200_get_slip_desc(l_slip) RETURNING g_inbi_m.inbidocno_desc
            END IF
            DISPLAY BY NAME g_inbi_m.inbidocno_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbi001
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbi001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbi001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbi002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbi002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbi002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbiownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbiownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbiownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbiowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbiowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbiowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbicrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbicrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbicrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbicrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbicrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbicrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbimodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbimodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbimodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbicnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbicnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbicnfid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbi_m.inbipstid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inbi_m.inbipstid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbi_m.inbipstid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_inbi_m_mask_o.* =  g_inbi_m.*
   CALL aint311_inbi_t_mask()
   LET g_inbi_m_mask_n.* =  g_inbi_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocno_desc,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi000, 
       g_inbi_m.inbi001,g_inbi_m.inbi001_desc,g_inbi_m.inbi002,g_inbi_m.inbi002_desc,g_inbi_m.inbi031, 
       g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi003_desc,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite, 
       g_inbi_m.inbistus,g_inbi_m.inbiownid,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid,g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbicrtdt, 
       g_inbi_m.inbimodid,g_inbi_m.inbimodid_desc,g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstid_desc,g_inbi_m.inbipstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbi_m.inbistus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_inbj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

#            CALL aint311_inbj001_desc()
            CALL s_feature_description(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002) RETURNING g_success,g_inbj_d[l_ac].inbj002_desc
#            CALL aint311_inbj005_desc()
#
#            CALL aint311_inbj006_desc()
#            CALL aint311_inbj016_desc()
#
#            CALL aint311_inbj017_desc()
#
#            CALL aint311_inbj014_desc()
#
#            CALL aint311_inbj015_desc()

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint311_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL aint311_inao_b_fill()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint311_detail_show()
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
 
{<section id="aint311.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint311_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE inbi_t.inbidocno 
   DEFINE l_oldno     LIKE inbi_t.inbidocno 
 
   DEFINE l_master    RECORD LIKE inbi_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE inbj_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_inbi_m.inbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_inbidocno_t = g_inbi_m.inbidocno
 
    
   LET g_inbi_m.inbidocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inbi_m.inbiownid = g_user
      LET g_inbi_m.inbiowndp = g_dept
      LET g_inbi_m.inbicrtid = g_user
      LET g_inbi_m.inbicrtdp = g_dept 
      LET g_inbi_m.inbicrtdt = cl_get_current()
      LET g_inbi_m.inbimodid = g_user
      LET g_inbi_m.inbimoddt = cl_get_current()
      LET g_inbi_m.inbistus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_auto_flag = TRUE
   LET g_inbi_m.inbidocdt = g_today
   LET g_inbi_m.inbi001 = g_user
   INITIALIZE g_inbi_m.inbicnfid TO NULL
   INITIALIZE g_inbi_m.inbicnfdt TO NULL
   INITIALIZE g_inbi_m.inbipstid TO NULL
   INITIALIZE g_inbi_m.inbipstdt TO NULL
   DISPLAY BY NAME g_inbi_m.inbicnfid
   DISPLAY BY NAME g_inbi_m.inbicnfdt
   DISPLAY BY NAME g_inbi_m.inbipstid
   DISPLAY BY NAME g_inbi_m.inbipstdt
   SELECT ooag003 INTO g_inbi_m.inbi002 FROM ooag_t
    WHERE ooag001 = g_inbi_m.inbi001 AND ooagent = g_enterprise
   CALL aint311_inbi001_desc()
   CALL aint311_inbi002_desc()
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbi_m.inbistus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_inbi_m.inbidocno_desc = ''
   DISPLAY BY NAME g_inbi_m.inbidocno_desc
 
   
   CALL aint311_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_inbi_m.* TO NULL
      INITIALIZE g_inbj_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint311_show()
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
   CALL aint311_set_act_visible()   
   CALL aint311_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbidocno_t = g_inbi_m.inbidocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbient = " ||g_enterprise|| " AND",
                      " inbidocno = '", g_inbi_m.inbidocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint311_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint311_idx_chk()
   
   LET g_data_owner = g_inbi_m.inbiownid      
   LET g_data_dept  = g_inbi_m.inbiowndp
   
   #功能已完成,通報訊息中心
   CALL aint311_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint311_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE inbj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint311_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbj_t
    WHERE inbjent = g_enterprise AND inbjdocno = g_inbidocno_t
 
    INTO TEMP aint311_detail
 
   #將key修正為調整後   
   UPDATE aint311_detail 
      #更新key欄位
      SET inbjdocno = g_inbi_m.inbidocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO inbj_t SELECT * FROM aint311_detail
   
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
   DROP TABLE aint311_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_inbidocno_t = g_inbi_m.inbidocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint311_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   #DEFINE l_inao  RECORD LIKE inao_t.*  #161124-00048#5  16/12/12 By 08734 mark
   #161124-00048#5  16/12/12 By 08734 add(S)
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
#161124-00048#5  16/12/12 By 08734 add(E)
   DEFINE l_inbj  type_g_inbj_d
   DEFINE l_sql STRING
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_inbi_m.inbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint311_cl USING g_enterprise,g_inbi_m.inbidocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint311_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint311_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
       g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
       g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
       g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
       g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
       g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbipstid_desc
   
   
   #檢查是否允許此動作
   IF NOT aint311_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inbi_m_mask_o.* =  g_inbi_m.*
   CALL aint311_inbi_t_mask()
   LET g_inbi_m_mask_n.* =  g_inbi_m.*
   
   CALL aint311_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint311_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_inbidocno_t = g_inbi_m.inbidocno
 
 
      DELETE FROM inbi_t
       WHERE inbient = g_enterprise AND inbidocno = g_inbi_m.inbidocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inbi_m.inbidocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_inbi_m.inbidocno,g_inbi_m.inbidocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
     IF g_para = 'Y' THEN
        LET l_sql = "SELECT inbjseq,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,", 
                     "       inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,", 
                     "       inbj021,inbj031,inbjsite,inbj010,inbj013 FROM inbj_t",   #170112-00038#1 add inbj013
                     " WHERE inbjent = ",g_enterprise," AND inbjdocno = '",g_inbi_m.inbidocno,"'"
         PREPARE delete_prep2 FROM l_sql
         DECLARE delete_curs2 CURSOR FOR delete_prep2
                         
         FOREACH delete_curs2 INTO  l_inbj.inbjseq,l_inbj.inbj001,l_inbj.inbj002,l_inbj.inbj005, 
                                    l_inbj.inbj006,l_inbj.inbj007,l_inbj.inbj003,l_inbj.inbj008, 
                                    l_inbj.inbj016,l_inbj.inbj017,l_inbj.inbj018,l_inbj.inbj009, 
                                    l_inbj.inbj011,l_inbj.inbj012,l_inbj.inbj004,l_inbj.inbj014, 
                                    l_inbj.inbj015,l_inbj.inbj019,l_inbj.inbj020,l_inbj.inbj021, 
                                    l_inbj.inbj031,l_inbj.inbjsite,l_inbj.inbj010,l_inbj.inbj013   #170112-00038#1 add inbj013
             CALL aint311_upd_inav(l_inbj.*)                       
#            CALL aint311_default_inav(l_inbj.*)
#            DECLARE delete_curs1 CURSOR FOR 
#             SELECT * FROM inao_t WHERE inaoent = g_enterprise
#                AND inaodocno = g_inbi_m.inbidocno AND inao013 = -1
#                AND inao000 = '2' AND inaoseq = l_inbj.inbjseq
#            FOREACH delete_curs1 INTO l_inao.*
#               UPDATE inav_t SET inav017 = 0
#                           WHERE inavent = g_enterprise
#                             AND inavsite = g_site
#                             AND inav001 = g_inav.inav001 
#                             AND inav002 = g_inav.inav002   
#                             AND inav003 = g_inav.inav003   
#                             AND inav004 = g_inav.inav004   
#                             AND inav005 = g_inav.inav005  
#                             AND inav006 = g_inav.inav006 
#                             AND inav007 = g_inav.inav007   
#                             AND inav008 = g_inav.inav008  
#                             AND inav009 = g_inav.inav009  
#                             AND inav010 = g_inav.inav010
#                             AND inav012 = l_inao.inao008
#                             AND inav013 = l_inao.inao009
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "inav_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = FALSE 
#                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
#            END FOREACH            
         END FOREACH
         
      END IF
      
      DELETE FROM inao_t WHERE inaoent = g_enterprise
          AND inaodocno = g_inbi_m.inbidocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inao_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      CALL aint311_inao_b_fill()
      #end add-point
      
      DELETE FROM inbj_t
       WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbidocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      
     
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inbi_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint311_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_inbj_d.clear() 
 
     
      CALL aint311_ui_browser_refresh()  
      #CALL aint311_ui_headershow()  
      #CALL aint311_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint311_browser_fill("")
         CALL aint311_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint311_cl
 
   #功能已完成,通報訊息中心
   CALL aint311_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint311.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint311_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_inbj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint311_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inbjseq,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008, 
             inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020, 
             inbj021,inbj031,inbjsite,inbj010,inbj013 ,t1.imaal003 ,t2.imaal004 ,t3.inayl003 ,t4.inab003 , 
             t5.oocql004 ,t6.ooefl003 ,t7.inayl003 ,t8.inab003 ,t9.pjbal003 ,t10.pjbbl004 ,t11.pjbml004 FROM inbj_t", 
                
                     " INNER JOIN inbi_t ON inbient = " ||g_enterprise|| " AND inbidocno = inbjdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=inbj001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=inbj001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t3 ON t3.inaylent="||g_enterprise||" AND t3.inayl001=inbj005 AND t3.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t4 ON t4.inabent="||g_enterprise||" AND t4.inabsite=inbjsite AND t4.inab001=inbj005 AND t4.inab002=inbj006  ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='302' AND t5.oocql002=inbj016 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=inbj017 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=inbj014 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent="||g_enterprise||" AND t8.inabsite=inbjsite AND t8.inab001=inbj014 AND t8.inab002=inbj015  ",
               " LEFT JOIN pjbal_t t9 ON t9.pjbalent="||g_enterprise||" AND t9.pjbal001=inbj019 AND t9.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t10 ON t10.pjbblent="||g_enterprise||" AND t10.pjbbl001=inbj019 AND t10.pjbbl002=inbj020 AND t10.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t11 ON t11.pjbmlent="||g_enterprise||" AND t11.pjbml001=inbj019 AND t11.pjbml002=inbj021 AND t11.pjbml003='"||g_dlang||"' ",
 
                     " WHERE inbjent=? AND inbjdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY inbj_t.inbjseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint311_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint311_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_inbi_m.inbidocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_inbi_m.inbidocno INTO g_inbj_d[l_ac].inbjseq,g_inbj_d[l_ac].inbj001, 
          g_inbj_d[l_ac].inbj002,g_inbj_d[l_ac].inbj005,g_inbj_d[l_ac].inbj006,g_inbj_d[l_ac].inbj007, 
          g_inbj_d[l_ac].inbj003,g_inbj_d[l_ac].inbj008,g_inbj_d[l_ac].inbj016,g_inbj_d[l_ac].inbj017, 
          g_inbj_d[l_ac].inbj018,g_inbj_d[l_ac].inbj009,g_inbj_d[l_ac].inbj011,g_inbj_d[l_ac].inbj012, 
          g_inbj_d[l_ac].inbj004,g_inbj_d[l_ac].inbj014,g_inbj_d[l_ac].inbj015,g_inbj_d[l_ac].inbj019, 
          g_inbj_d[l_ac].inbj020,g_inbj_d[l_ac].inbj021,g_inbj_d[l_ac].inbj031,g_inbj_d[l_ac].inbjsite, 
          g_inbj_d[l_ac].inbj010,g_inbj_d[l_ac].inbj013,g_inbj_d[l_ac].inbj001_desc,g_inbj_d[l_ac].inbj001_desc_desc, 
          g_inbj_d[l_ac].inbj005_desc,g_inbj_d[l_ac].inbj006_desc,g_inbj_d[l_ac].inbj016_desc,g_inbj_d[l_ac].inbj017_desc, 
          g_inbj_d[l_ac].inbj014_desc,g_inbj_d[l_ac].inbj015_desc,g_inbj_d[l_ac].inbj019_desc,g_inbj_d[l_ac].inbj020_desc, 
          g_inbj_d[l_ac].inbj021_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
#         IF cl_null(g_inbj_d[l_ac].inbj006) THEN
#            INITIALIZE g_inbj_d[l_ac].inbj006_desc TO NULL
#         END IF
         #151222-00011#1 add(s)
         CALL aint311_inbj006_desc()
         CALL aint311_inbj015_desc()
         #151222-00011#1 add(e)
         
#         IF cl_null(g_inbj_d[l_ac].inbj015) THEN
#            INITIALIZE g_inbj_d[l_ac].inbj015_desc TO NULL
#         END IF
         
         CALL s_desc_get_project_desc(g_inbj_d[l_ac].inbj019) RETURNING g_inbj_d[l_ac].inbj019_desc
         DISPLAY BY NAME g_inbj_d[l_ac].inbj019_desc

         CALL s_desc_get_wbs_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj020) RETURNING g_inbj_d[l_ac].inbj020_desc
         DISPLAY BY NAME g_inbj_d[l_ac].inbj020_desc

         CALL s_desc_get_activity_desc(g_inbj_d[l_ac].inbj019,g_inbj_d[l_ac].inbj021) RETURNING g_inbj_d[l_ac].inbj021_desc
         DISPLAY BY NAME g_inbj_d[l_ac].inbj021_desc
         
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
   
   CALL g_inbj_d.deleteElement(g_inbj_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint311_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inbj_d.getLength()
      LET g_inbj_d_mask_o[l_ac].* =  g_inbj_d[l_ac].*
      CALL aint311_inbj_t_mask()
      LET g_inbj_d_mask_n[l_ac].* =  g_inbj_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint311_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM inbj_t
       WHERE inbjent = g_enterprise AND
         inbjdocno = ps_keys_bak[1] AND inbjseq = ps_keys_bak[2]
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
         CALL g_inbj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint311_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO inbj_t
                  (inbjent,
                   inbjdocno,
                   inbjseq
                   ,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,inbj021,inbj031,inbjsite,inbj010,inbj013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inbj_d[g_detail_idx].inbj001,g_inbj_d[g_detail_idx].inbj002,g_inbj_d[g_detail_idx].inbj005, 
                       g_inbj_d[g_detail_idx].inbj006,g_inbj_d[g_detail_idx].inbj007,g_inbj_d[g_detail_idx].inbj003, 
                       g_inbj_d[g_detail_idx].inbj008,g_inbj_d[g_detail_idx].inbj016,g_inbj_d[g_detail_idx].inbj017, 
                       g_inbj_d[g_detail_idx].inbj018,g_inbj_d[g_detail_idx].inbj009,g_inbj_d[g_detail_idx].inbj011, 
                       g_inbj_d[g_detail_idx].inbj012,g_inbj_d[g_detail_idx].inbj004,g_inbj_d[g_detail_idx].inbj014, 
                       g_inbj_d[g_detail_idx].inbj015,g_inbj_d[g_detail_idx].inbj019,g_inbj_d[g_detail_idx].inbj020, 
                       g_inbj_d[g_detail_idx].inbj021,g_inbj_d[g_detail_idx].inbj031,g_inbj_d[g_detail_idx].inbjsite, 
                       g_inbj_d[g_detail_idx].inbj010,g_inbj_d[g_detail_idx].inbj013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inbj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint311_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint311_inbj_t_mask_restore('restore_mask_o')
               
      UPDATE inbj_t 
         SET (inbjdocno,
              inbjseq
              ,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,inbj021,inbj031,inbjsite,inbj010,inbj013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inbj_d[g_detail_idx].inbj001,g_inbj_d[g_detail_idx].inbj002,g_inbj_d[g_detail_idx].inbj005, 
                  g_inbj_d[g_detail_idx].inbj006,g_inbj_d[g_detail_idx].inbj007,g_inbj_d[g_detail_idx].inbj003, 
                  g_inbj_d[g_detail_idx].inbj008,g_inbj_d[g_detail_idx].inbj016,g_inbj_d[g_detail_idx].inbj017, 
                  g_inbj_d[g_detail_idx].inbj018,g_inbj_d[g_detail_idx].inbj009,g_inbj_d[g_detail_idx].inbj011, 
                  g_inbj_d[g_detail_idx].inbj012,g_inbj_d[g_detail_idx].inbj004,g_inbj_d[g_detail_idx].inbj014, 
                  g_inbj_d[g_detail_idx].inbj015,g_inbj_d[g_detail_idx].inbj019,g_inbj_d[g_detail_idx].inbj020, 
                  g_inbj_d[g_detail_idx].inbj021,g_inbj_d[g_detail_idx].inbj031,g_inbj_d[g_detail_idx].inbjsite, 
                  g_inbj_d[g_detail_idx].inbj010,g_inbj_d[g_detail_idx].inbj013) 
         WHERE inbjent = g_enterprise AND inbjdocno = ps_keys_bak[1] AND inbjseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint311_inbj_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint311_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint311.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint311_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint311.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint311_lock_b(ps_table,ps_page)
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
   #CALL aint311_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "inbj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint311_bcl USING g_enterprise,
                                       g_inbi_m.inbidocno,g_inbj_d[g_detail_idx].inbjseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint311_bcl:",SQLERRMESSAGE 
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
 
{<section id="aint311.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint311_unlock_b(ps_table,ps_page)
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
      CLOSE aint311_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint311_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("inbidocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("inbidocno",TRUE)
      CALL cl_set_comp_entry("inbidocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("inbidocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("inbi007",TRUE)
   CALL cl_set_comp_entry("inbi031",TRUE)
   CALL cl_set_comp_entry("inbi003",TRUE)   #160330-00017#1 add
   CALL cl_set_comp_entry("inbidocdt",TRUE) #160604-00034#3 add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint311_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inbidocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      #CALL cl_set_comp_entry("inbidocdt",FALSE)  #160604-00034#3
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("inbidocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("inbidocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #160604-00034#3-S
   IF NOT cl_chk_update_pstdt() THEN
      CALL cl_set_comp_entry("inbi007",FALSE)
   END IF
   IF NOT g_auto_flag THEN
      CALL cl_set_comp_entry("inbidocno",FALSE)
   END IF   
   #160604-00034#3-E
   #160604-00034#3-S
#   IF NOT g_auto_flag THEN
#      CALL cl_set_comp_entry("inbidocno,inbidocdt",FALSE)
#   END IF

#   IF g_stus = 'N' THEN
#      CALL cl_set_comp_entry("inbi007",FALSE) 
#   END IF
   #160604-00034#3-E   
   IF g_para = 'N' THEN
      INITIALIZE g_inbi_m.inbi031 TO NULL
      CALL cl_set_comp_entry("inbi031",FALSE)
   #160330-00017#1 add(s)
   ELSE
      INITIALIZE g_inbi_m.inbi003 TO NULL
      CALL aint311_inbi003_desc()
      CALL cl_set_comp_entry("inbi003",FALSE)
   #160330-00017#1 add(e)      
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint311_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("inbj002,inbj006,inbj007,inbj014,inbj015",TRUE)
   CALL cl_set_comp_entry("inbj003",TRUE)
   
   CALL cl_set_comp_required("inbj003",FALSE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint311_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_n     LIKE type_t.num5
   DEFINE l_imaf055 LIKE imaf_t.imaf055
   DEFINE l_pjaa013  LIKE pjaa_t.pjaa013 
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 = g_inbj_d[l_ac].inbj001
      AND imaa005 IS NOT NULL
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbj002",FALSE)
   END IF
   
   
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM imaf_t WHERE imafent = g_enterprise
      AND imafsite = g_site AND imaf001 = g_inbj_d[l_ac].inbj001
      AND (imaf061 = '1' OR imaf061 = '3')
   IF l_n = 0 THEN
      CALL cl_set_comp_entry("inbj007",FALSE)
   END IF
#   LET l_n = 0
#   SELECT COUNT(*) INTO l_n FROM inaa_t
#    WHERE inaaent = g_enterprise AND inaasite = g_site 
#      AND inaa001 = g_inbj_d[l_ac].inbj005 AND inaa007 = '5'
#   IF l_n != 0 THEN
#      INITIALIZE g_inbj_d[l_ac].inbj006 TO NULL 
#      DISPLAY BY NAME g_inbj_d[l_ac].inbj006
#      CALL cl_set_comp_visible("inbj006",FALSE)
#   END IF
   
   IF g_inbi_m.inbi032 = 'N' THEN
      CALL cl_set_comp_entry("inbj014,inbj015",FALSE)
   ELSE
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM inaa_t
       WHERE inaaent = g_enterprise AND inaasite = g_site 
         AND inaa001 = g_inbj_d[l_ac].inbj014 AND inaa007 = '5'
      IF l_n != 0 THEN
         LET g_inbj_d[l_ac].inbj015 = " "
         DISPLAY BY NAME g_inbj_d[l_ac].inbj015
         CALL cl_set_comp_entry("inbj015",FALSE)
      END IF
   END IF
   
   SELECT imaf055 INTO l_imaf055 FROM imaf_t
    WHERE imafent = g_enterprise AND imafsite = g_site
      AND imaf001 = g_inbj_d[l_ac].inbj001
   
   IF NOT cl_null(l_imaf055) AND l_imaf055 = '1' THEN
      CALL cl_set_comp_required("inbj003",TRUE)
   END IF
   IF NOT cl_null(l_imaf055) AND l_imaf055 = '2' THEN
      INITIALIZE g_inbj_d[l_ac].inbj003 TO NULL
      CALL cl_set_comp_entry("inbj003",FALSE)
   END IF
   #有專案代號且"專案庫存控管"="Y"時，自動將專案代號帶入庫存管理特徵欄位中，不可修改
   IF NOT cl_null(g_inbj_d[l_ac].inbj019) THEN
      SELECT pjaa013 INTO l_pjaa013 FROM pjaa_t,pjba_t 
         WHERE pjaaent = pjbaent AND pjaa001 = pjba000 AND pjaaent = g_enterprise AND pjba001 = g_inbj_d[l_ac].inbj019
      IF l_pjaa013 = 'Y' THEN
         LET g_inbj_d[l_ac].inbj003 = g_inbj_d[l_ac].inbj019
         CALL cl_set_comp_entry("inbj003",FALSE)
      END IF
   END IF
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint311_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail,ins_inao,ins_detial,statechange",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint311_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_inbi_m.inbistus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   IF g_para = 'N' OR g_inbi_m.inbistus != 'N' THEN
      CALL cl_set_act_visible("ins_detial",FALSE)
   END IF
   IF g_inbi_m.inbistus != 'N' THEN
      CALL cl_set_act_visible("ins_inao",FALSE)
   END IF
   
   IF g_inbi_m.inbistus = 'X' THEN
      CALL cl_set_act_visible("statechange",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint311_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("ins_detial,ins_inao",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint311.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint311_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   IF g_para = 'N' OR g_inbi_m.inbistus != 'N' THEN
      CALL cl_set_act_visible("ins_detial",FALSE)
   END IF
   
   IF g_inbi_m.inbistus != 'N' OR NOT aint311_pxh_chk() THEN
      CALL cl_set_act_visible("ins_inao",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint311.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint311_default_search()
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
   LET ls_wc = " inbi000 = '2' AND "
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " inbidocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "inbi_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inbj_t" 
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
 
{<section id="aint311.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint311_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_status  STRING
   DEFINE l_inbj  type_g_inbj_d
   DEFINE l_sql   STRING
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inbi_m.inbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint311_cl USING g_enterprise,g_inbi_m.inbidocno
   IF STATUS THEN
      CLOSE aint311_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint311_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
       g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
       g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
       g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
       g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
       g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbipstid_desc
   
 
   #檢查是否允許此動作
   IF NOT aint311_action_chk() THEN
      CLOSE aint311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocno_desc,g_inbi_m.inbidocdt,g_inbi_m.inbi007,g_inbi_m.inbi000, 
       g_inbi_m.inbi001,g_inbi_m.inbi001_desc,g_inbi_m.inbi002,g_inbi_m.inbi002_desc,g_inbi_m.inbi031, 
       g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi003_desc,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite, 
       g_inbi_m.inbistus,g_inbi_m.inbiownid,g_inbi_m.inbiownid_desc,g_inbi_m.inbiowndp,g_inbi_m.inbiowndp_desc, 
       g_inbi_m.inbicrtid,g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbicrtdt, 
       g_inbi_m.inbimodid,g_inbi_m.inbimodid_desc,g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfid_desc, 
       g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstid_desc,g_inbi_m.inbipstdt
 
   CASE g_inbi_m.inbistus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "O"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
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
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_inbi_m.inbistus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "O"
               HIDE OPTION "confirm_transfer_out"
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
            WHEN "Z"
               HIDE OPTION "unposted"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_inbi_m.inbistus
            WHEN "N"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"
                #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
              IF cl_bpm_chk() THEN
                  CALL cl_set_act_visible("signing",TRUE)
                  CALL cl_set_act_visible("confirm_transfer_out",FALSE)
              END IF
 
            WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirm_transfer_out,unconfirmed,hold,posted,unposted",FALSE)

            WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirm_transfer_out,unconfirmed,hold,posted,unposted",FALSE) 
             WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
               CALL cl_set_act_visible("withdraw",TRUE)  
               CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_out,hold,posted,unposted",FALSE)
         
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
               CALL cl_set_act_visible("confirm_transfer_out ",TRUE)  
               CALL cl_set_act_visible("unconfirmed,invalid,hold,posted,unposted",FALSE)
            WHEN "O"
               HIDE OPTION "confirm_transfer_out"
               HIDE OPTION "invalid"
               HIDE OPTION "unposted"
            WHEN "S"
               HIDE OPTION "posted"
               HIDE OPTION "invalid"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "confirm_transfer_out"
            WHEN "X"
               HIDE OPTION "invalid"
               HIDE OPTION "confirm_transfer_out"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"                 
         END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint311_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint311_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint311_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint311_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            LET g_stus = "N"
            LET l_status = "N"
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirm_transfer_out
         IF cl_auth_chk_act("confirm_transfer_out") THEN
            LET lc_state = "O"
            #add-point:action控制 name="statechange.confirm_transfer_out"
            IF g_inbi_m.inbistus = 'N' THEN
              
               LET l_status = "confirm"
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            LET g_stus = "S"
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
            LET g_stus = "X"
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            LET lc_state = 'O'
            LET l_status = "unpost"
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "O"
      AND lc_state <> "S"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      AND lc_state <> "Z"
      ) OR 
      g_inbi_m.inbistus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'O' AND l_status = "confirm" THEN
      IF cl_ask_confirm("aim-00108") THEN
         CALL s_aint311_cnf_chk(g_inbi_m.inbidocno) RETURNING g_success
         IF g_success THEN
            CALL s_transaction_begin()
            CALL s_aint311_cnf_upd(g_inbi_m.inbidocno) RETURNING g_success
            IF g_success THEN
               CALL s_transaction_end('Y','0')            
            ELSE          
               CALL s_transaction_end('N','1') 
               LET g_action_choice = "statechange"            
               RETURN 
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN 
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN 
      END IF
   END IF
   
   IF lc_state = 'S' THEN
      IF cl_ask_confirm("sub-00232") THEN
         CALL s_aint311_pst_chk(g_inbi_m.inbidocno) RETURNING g_success         
         IF g_success THEN
            CALL s_transaction_begin()
            IF NOT aint311_input_inbi007() THEN
               CALL s_transaction_end('N','1')  
               LET g_action_choice = "statechange"
               RETURN 
            END IF
            CALL s_aint311_pst_upd(g_inbi_m.inbidocno) RETURNING g_success
            IF g_success THEN
               CALL s_transaction_end('Y','0')            
            ELSE          
               CALL s_transaction_end('N','1')  
               LET g_action_choice = "statechange"
               RETURN 
            END IF
         ELSE
            LET g_action_choice = "statechange"
            CALL s_transaction_end('N','1')   #160812-00017#3 Add By Ken 160815
            RETURN 
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN 
      END IF
   END IF
   
   IF lc_state = 'O' AND l_status = "unpost" THEN
      IF cl_ask_confirm("sub-00233") THEN
         CALL s_aint311_unpst_chk(g_inbi_m.inbidocno) RETURNING g_success
         IF g_success THEN
            CALL s_transaction_begin()
            IF NOT s_aint311_unpst_upd(g_inbi_m.inbidocno) THEN
               CALL s_transaction_end('N','1') 
               LET g_action_choice = "statechange"
               RETURN 
            ELSE
               CALL s_transaction_end('Y','0') 
            END IF
         ELSE
            LET g_action_choice = "statechange"
            CALL s_transaction_end('N','1')   #160812-00017#3 Add By Ken 160815
            RETURN 
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN 
      END IF
   END IF
   
   IF lc_state = 'N' AND l_status = 'N' THEN
      IF cl_ask_confirm("aim-00110") THEN
         CALL s_aint311_uncnf_chk(g_inbi_m.inbidocno) RETURNING g_success
         IF g_success THEN
            CALL s_transaction_begin()
            IF NOT s_aint311_uncnf_upd(g_inbi_m.inbidocno) THEN
               CALL s_transaction_end('N','1') 
               LET g_action_choice = "statechange"
               RETURN 
            ELSE
               CALL s_transaction_end('Y','0') 
            END IF
         ELSE
            LET g_action_choice = "statechange"
            CALL s_transaction_end('N','1')   #160812-00017#3 Add By Ken 160815
            RETURN 
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      END IF
   END IF
   
   IF lc_state = 'X' THEN
      IF cl_ask_confirm("aim-00109") THEN
         IF s_aint311_void_chk(g_inbi_m.inbidocno) THEN
            CALL s_transaction_begin()
            IF s_aint311_void_upd(g_inbi_m.inbidocno) THEN
               IF g_para = 'Y' THEN
                  LET l_sql = "SELECT inbjseq,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,", 
                               "       inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,", 
                               "       inbj021,inbj031,inbjsite,inbj010,inbj013 FROM inbj_t",   #170112-00038#1 add inbj013
                               " WHERE inbjent = ",g_enterprise," AND inbjdocno = '",g_inbi_m.inbidocno,"'"
                   PREPARE statechange_prep1 FROM l_sql
                   DECLARE statechange_curs1 CURSOR FOR statechange_prep1
                                   
                   FOREACH statechange_curs1 INTO l_inbj.inbjseq,l_inbj.inbj001,l_inbj.inbj002,l_inbj.inbj005, 
                                                  l_inbj.inbj006,l_inbj.inbj007,l_inbj.inbj003,l_inbj.inbj008, 
                                                  l_inbj.inbj016,l_inbj.inbj017,l_inbj.inbj018,l_inbj.inbj009, 
                                                  l_inbj.inbj011,l_inbj.inbj012,l_inbj.inbj004,l_inbj.inbj014, 
                                                  l_inbj.inbj015,l_inbj.inbj019,l_inbj.inbj020,l_inbj.inbj021, 
                                                  l_inbj.inbj031,l_inbj.inbjsite,l_inbj.inbj010,l_inbj.inbj013 #170112-00038#1 add inbj013
                       CALL aint311_upd_inav(l_inbj.*)                       
                    
                   END FOREACH
         
               END IF
               CALL s_transaction_end('Y','0') 
            ELSE
               CALL s_transaction_end('N','1') 
               LET g_action_choice = "statechange"
               RETURN  
            END IF
         ELSE
            LET g_action_choice = "statechange"
            CALL s_transaction_end('N','1')   #160812-00017#3 Add By Ken 160815
            RETURN 
         END IF
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN 
      END IF
   END IF
   #end add-point
   
   LET g_inbi_m.inbimodid = g_user
   LET g_inbi_m.inbimoddt = cl_get_current()
   LET g_inbi_m.inbistus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inbi_t 
      SET (inbistus,inbimodid,inbimoddt) 
        = (g_inbi_m.inbistus,g_inbi_m.inbimodid,g_inbi_m.inbimoddt)     
    WHERE inbient = g_enterprise AND inbidocno = g_inbi_m.inbidocno
 
    
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
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aint311_master_referesh USING g_inbi_m.inbidocno INTO g_inbi_m.inbidocno,g_inbi_m.inbidocdt, 
          g_inbi_m.inbi007,g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi002,g_inbi_m.inbi031,g_inbi_m.inbi032, 
          g_inbi_m.inbi003,g_inbi_m.inbi021,g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid, 
          g_inbi_m.inbiowndp,g_inbi_m.inbicrtid,g_inbi_m.inbicrtdp,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid, 
          g_inbi_m.inbimoddt,g_inbi_m.inbicnfid,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstdt, 
          g_inbi_m.inbi001_desc,g_inbi_m.inbi002_desc,g_inbi_m.inbi003_desc,g_inbi_m.inbiownid_desc, 
          g_inbi_m.inbiowndp_desc,g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp_desc,g_inbi_m.inbimodid_desc, 
          g_inbi_m.inbicnfid_desc,g_inbi_m.inbipstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inbi_m.inbidocno,g_inbi_m.inbidocno_desc,g_inbi_m.inbidocdt,g_inbi_m.inbi007, 
          g_inbi_m.inbi000,g_inbi_m.inbi001,g_inbi_m.inbi001_desc,g_inbi_m.inbi002,g_inbi_m.inbi002_desc, 
          g_inbi_m.inbi031,g_inbi_m.inbi032,g_inbi_m.inbi003,g_inbi_m.inbi003_desc,g_inbi_m.inbi021, 
          g_inbi_m.inbi004,g_inbi_m.inbisite,g_inbi_m.inbistus,g_inbi_m.inbiownid,g_inbi_m.inbiownid_desc, 
          g_inbi_m.inbiowndp,g_inbi_m.inbiowndp_desc,g_inbi_m.inbicrtid,g_inbi_m.inbicrtid_desc,g_inbi_m.inbicrtdp, 
          g_inbi_m.inbicrtdp_desc,g_inbi_m.inbicrtdt,g_inbi_m.inbimodid,g_inbi_m.inbimodid_desc,g_inbi_m.inbimoddt, 
          g_inbi_m.inbicnfid,g_inbi_m.inbicnfid_desc,g_inbi_m.inbicnfdt,g_inbi_m.inbipstid,g_inbi_m.inbipstid_desc, 
          g_inbi_m.inbipstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint311_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint311_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint311.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint311_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inbj_d.getLength() THEN
         LET g_detail_idx = g_inbj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inbj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inbj_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint311_b_fill2(pi_idx)
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
   IF NOT cl_null(l_ac) THEN
      CALL aint311_inao_b_fill()
   END IF
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aint311_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint311_fill_chk(ps_idx)
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
 
{<section id="aint311.status_show" >}
PRIVATE FUNCTION aint311_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint311.mask_functions" >}
&include "erp/ain/aint311_mask.4gl"
 
{</section>}
 
{<section id="aint311.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint311_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aint311_show()
   CALL aint311_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_aint311_cnf_chk(g_inbi_m.inbidocno) THEN
      CLOSE aint311_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_inbi_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_inbj_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_inbj2_d))    #161219-00024#1
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aint311_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint311_ui_headershow()
   CALL aint311_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint311_draw_out()
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
   CALL aint311_ui_headershow()  
   CALL aint311_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint311.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint311_set_pk_array()
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
   LET g_pk_array[1].values = g_inbi_m.inbidocno
   LET g_pk_array[1].column = 'inbidocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint311.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint311.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint311_msgcentre_notify(lc_state)
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
   CALL aint311_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inbi_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint311.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint311_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#16-s
   SELECT inbistus INTO g_inbi_m.inbistus FROM inbi_t
    WHERE inbient = g_enterprise
      AND inbisite = g_site
      AND inbidocno = g_inbi_m.inbidocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_inbi_m.inbistus
         WHEN 'W'
            LET g_errno = 'sub-01347'
         WHEN 'X'
            LET g_errno = 'sub-00229'
         WHEN 'O'
            LET g_errno = 'sub-00759'
         WHEN 'S'
            LET g_errno = 'sub-00230'
         WHEN 'Z'
            LET g_errno = 'sub-00231'            
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_inbi_m.inbidocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aint311_set_act_visible()
        CALL aint311_set_act_no_visible()
        CALL aint311_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#16-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint311.other_function" readonly="Y" >}

PRIVATE FUNCTION aint311_inbi001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbi_m.inbi001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inbi_m.inbi001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbi_m.inbi001_desc
END FUNCTION

PRIVATE FUNCTION aint311_inbi002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbi_m.inbi002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbi_m.inbi002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbi_m.inbi002_desc
END FUNCTION

PRIVATE FUNCTION aint311_inbj001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbj_d[l_ac].inbj001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbj_d[l_ac].inbj001_desc = '', g_rtn_fields[1] , ''
   LET g_inbj_d[l_ac].inbj001_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inbj_d[l_ac].inbj001_desc,g_inbj_d[l_ac].inbj001_desc_desc
END FUNCTION

PRIVATE FUNCTION aint311_inbj001_ref()
   IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
      SELECT imaf015,imaf157 INTO g_inbj_d[l_ac].inbj011,g_inbj_d[l_ac].inbj004 
        FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 =g_inbj_d[l_ac].inbj001
      DISPLAY BY NAME   g_inbj_d[l_ac].inbj011,g_inbj_d[l_ac].inbj004  
      IF g_inbj_d[l_ac].inbj001 != g_inbj_d_o.inbj001 THEN
         INITIALIZE g_inbj_d[l_ac].inbj002 TO NULL     
         INITIALIZE g_inbj_d[l_ac].inbj003 TO NULL
         INITIALIZE g_inbj_d[l_ac].inbj005 TO NULL  
         INITIALIZE g_inbj_d[l_ac].inbj006 TO NULL  
         INITIALIZE g_inbj_d[l_ac].inbj007 TO NULL  
         INITIALIZE g_inbj_d[l_ac].inbj008 TO NULL     
         CALL aint311_inbj005_desc()
         CALL aint311_inbj006_desc()
         CALL s_feature_description(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002) RETURNING g_success,g_inbj_d[l_ac].inbj002_desc   
      END IF         
   END IF
END FUNCTION

PRIVATE FUNCTION aint311_inbj005_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_inbj_d[l_ac].inbj005
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_inbj_d[l_ac].inbj005_desc = '', g_rtn_fields[1] , ''
   CALL s_desc_get_stock_desc(g_site,g_inbj_d[l_ac].inbj005) RETURNING g_inbj_d[l_ac].inbj005_desc 
   DISPLAY BY NAME g_inbj_d[l_ac].inbj005_desc
END FUNCTION

PRIVATE FUNCTION aint311_inaq_chk()
DEFINE l_sql   STRING
DEFINE l_n    LIKE type_t.num5
   LET l_sql = "SELECT COUNT(*) FROM inaq_t WHERE inaqent = ",g_enterprise,
               " AND inaqsite='",g_site,"' "
   IF NOT cl_null(g_inbj_d[l_ac].inbj001)  THEN
      LET l_sql = l_sql," AND inaq001 = '",g_inbj_d[l_ac].inbj001,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj002)  THEN
      LET l_sql = l_sql," AND inaq002 = '",g_inbj_d[l_ac].inbj002,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
      LET l_sql = l_sql," AND inaq003 = '",g_inbj_d[l_ac].inbj003,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj005) THEN
      LET l_sql = l_sql," AND inaq004 = '",g_inbj_d[l_ac].inbj005,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN
      LET l_sql = l_sql," AND inaq005 = '",g_inbj_d[l_ac].inbj006,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
      LET l_sql = l_sql," AND inaq006 = '",g_inbj_d[l_ac].inbj007,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
      LET l_sql = l_sql," AND inaq007 = '",g_inbj_d[l_ac].inbj008,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj016) THEN
      LET l_sql = l_sql," AND inaq008 = '",g_inbj_d[l_ac].inbj016,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj017) THEN
      LET l_sql = l_sql," AND inaq010 = '",g_inbj_d[l_ac].inbj017,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj018) THEN
      LET l_sql = l_sql," AND inaq009 = '",g_inbj_d[l_ac].inbj018,"'"
   END IF

   PREPARE sel_inaq_pre1 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inaq_pre1 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00318'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   LET l_sql = l_sql," AND inaq011 > 0 "
   PREPARE sel_inaq_pre2 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inaq_pre2 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00319'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_inbj009_chk(p_cmd)
DEFINE l_inaq011 LIKE inaq_t.inaq011
DEFINE l_inbj009_sum LIKE inbj_t.inbj009
DEFINE l_sql STRING
DEFINE p_cmd     LIKE type_t.chr1
DEFINE l_deff_num LIKE inbj_t.inbj009
   IF NOT cl_null(g_inbj_d[l_ac].inbj001) AND NOT cl_null(g_inbj_d[l_ac].inbj005) AND NOT cl_null(g_inbj_d[l_ac].inbj008) AND NOT cl_null(g_inbj_d[l_ac].inbj009) THEN
      IF cl_null(g_inbj_d[l_ac].inbj002) THEN LET g_inbj_d[l_ac].inbj002 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj003) THEN LET g_inbj_d[l_ac].inbj003 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj006) THEN LET g_inbj_d[l_ac].inbj006 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj007) THEN LET g_inbj_d[l_ac].inbj007 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj008) THEN LET g_inbj_d[l_ac].inbj008 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj016) THEN LET g_inbj_d[l_ac].inbj016 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj017) THEN LET g_inbj_d[l_ac].inbj017 = " " END IF
      IF cl_null(g_inbj_d[l_ac].inbj018) THEN LET g_inbj_d[l_ac].inbj018 = " " END IF
      CALL aint311_get_def_num(p_cmd) RETURNING l_deff_num
      IF p_cmd = 'u' THEN
         LET l_deff_num = l_deff_num + g_inbj_d_t.inbj009
      END IF
      IF g_inbj_d[l_ac].inbj009 > l_deff_num THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00320'
         LET g_errparam.extend = g_inbj_d[l_ac].inbj009||" > "||l_deff_num
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_inbj006_desc()
  # IF NOT cl_null(g_inbj_d[l_ac].inbj006) THEN #151222-00011#1 mark
    IF g_inbj_d[l_ac].inbj006 IS NOT NULL THEN  #151222-00011#1   add
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inbj_d[l_ac].inbj005
      LET g_ref_fields[2] = g_inbj_d[l_ac].inbj006
      CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite = '"||g_site||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
      LET g_inbj_d[l_ac].inbj006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inbj_d[l_ac].inbj006_desc
   END IF
END FUNCTION

PRIVATE FUNCTION aint311_inbj016_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbj_d[l_ac].inbj016
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbj_d[l_ac].inbj016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbj_d[l_ac].inbj016_desc
END FUNCTION

PRIVATE FUNCTION aint311_inbj017_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbj_d[l_ac].inbj017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbj_d[l_ac].inbj017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbj_d[l_ac].inbj017_desc
END FUNCTION

PRIVATE FUNCTION aint311_inbj014_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_inbj_d[l_ac].inbj014
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_inbj_d[l_ac].inbj014_desc = '', g_rtn_fields[1] , ''
   CALL s_desc_get_stock_desc(g_site,g_inbj_d[l_ac].inbj014) RETURNING g_inbj_d[l_ac].inbj014_desc  
   DISPLAY BY NAME g_inbj_d[l_ac].inbj014_desc
END FUNCTION

PRIVATE FUNCTION aint311_inbj015_desc()
   #IF NOT cl_null(g_inbj_d[l_ac].inbj015) THEN #151222-00011#1 mark
   IF g_inbj_d[l_ac].inbj015 IS NOT NULL THEN  #151222-00011#1 add
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inbj_d[l_ac].inbj014
      LET g_ref_fields[2] = g_inbj_d[l_ac].inbj015
      CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite = '"||g_site||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
      LET g_inbj_d[l_ac].inbj015_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inbj_d[l_ac].inbj015_desc
   END IF
END FUNCTION

PRIVATE FUNCTION aint311_inao_b_fill()
DEFINE l_sql  STRING 
DEFINE l_cnt  LIKE type_t.num5
   CALL g_inbj2_d.clear()
   LET l_sql = "SELECT inaoseq,inaoseq2,inao001,imaal003,imaal004,inao008,inao009,inao010,inao012 FROM inao_t ",
               " LEFT OUTER JOIN imaal_t ON imaalent = inaoent AND imaal001 = inao001 AND imaal002 = '",g_dlang,"'",
              # " WHERE inaoent = ",g_enterprise," AND inaodocno = '",g_inbi_m.inbidocno,"' AND inaoseq = ",g_inbj_d[g_detail_idx].inbjseq,
               " WHERE inaoent = ",g_enterprise," AND inaodocno = '",g_inbi_m.inbidocno,"'",
               " AND inao000 = '2' AND inao013 = -1 "
#   IF g_inbj_d[l_ac].inbj002 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inao002 = '",g_inbj_d[g_detail_idx].inbj002,"'"
#   END IF
#   
#   IF g_inbj_d[l_ac].inbj003 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inao003 = '",g_inbj_d[g_detail_idx].inbj003,"'"
#   END IF
#   
#   IF g_inbj_d[l_ac].inbj004 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inao004 = '",g_inbj_d[g_detail_idx].inbj004,"'"
#   END IF 
#   
#   IF g_inbj_d[l_ac].inbj005 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inao005 = '",g_inbj_d[g_detail_idx].inbj005,"'"
#   END IF 
#   
#   IF g_inbj_d[l_ac].inbj006 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inao006 = '",g_inbj_d[g_detail_idx].inbj006,"'"
#   END IF 
#   
#   IF g_inbj_d[l_ac].inbj007 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inao006 = '",g_inbj_d[g_detail_idx].inbj007,"'"
#   END IF 
   
   LET l_sql = l_sql," ORDER BY inaoseq,inaoseq1"
   
   PREPARE sel_inao_prep1 FROM l_sql
   DECLARE sel_inao_curs1 CURSOR FOR sel_inao_prep1
   
   LET l_cnt = 1
   FOREACH sel_inao_curs1 INTO g_inbj2_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_inbj2_d.deleteElement(g_inbj2_d.getLength())
#   DISPLAY ARRAY g_inbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_inbj2_d.getLength())
#      BEFORE DISPLAY 
#         EXIT DISPLAY
#   END DISPLAY 
   FREE sel_inao_curs1
END FUNCTION

PRIVATE FUNCTION aint311_ins_inbj()
DEFINE l_inbj    type_g_inbj_d
DEFINE l_inbj2   type_g_inbj_d
DEFINE l_sql    STRING
DEFINE l_inbj009_sum LIKE inbj_t.inbj009
DEFINE l_inaq011 LIKE inaq_t.inaq011
DEFINE l_deff_num LIKE inaq_t.inaq011
DEFINE l_inbj009 LIKE inbj_t.inbj009
DEFINE l_deff_num1 LIKE type_t.num5
DEFINE l_inbj009_2 LIKE inbj_t.inbj009
DEFINE l_cnt     LIKE type_t.num5
   LET l_sql = "SELECT inbjseq,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,", 
               "       inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,", 
               "       inbj021,inbj031,inbjsite,inbj010,inbj013 FROM inbj_t",   #170112-00038#1 add inbj013
               " WHERE inbjent = ",g_enterprise," AND inbjdocno = '",g_inbi_m.inbi031,"'"
   PREPARE sel_inbj_pre1 FROM l_sql
   DECLARE sel_inbj_cur1 CURSOR FOR sel_inbj_pre1
   LET l_cnt  = 1
   FOREACH sel_inbj_cur1 INTO l_inbj.inbjseq,l_inbj.inbj001,l_inbj.inbj002,l_inbj.inbj005, 
                              l_inbj.inbj006,l_inbj.inbj007,l_inbj.inbj003,l_inbj.inbj008, 
                              l_inbj.inbj016,l_inbj.inbj017,l_inbj.inbj018,l_inbj.inbj009, 
                              l_inbj.inbj011,l_inbj.inbj012,l_inbj.inbj004,l_inbj.inbj014, 
                              l_inbj.inbj015,l_inbj.inbj019,l_inbj.inbj020,l_inbj.inbj021, 
                              l_inbj.inbj031,l_inbj.inbjsite,l_inbj.inbj010,l_inbj.inbj013  #170112-00038#1 add inbj013
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      
      IF l_inbj.inbj018 IS NULL THEN
         LET l_inbj.inbj018 = ' '
      END IF
      IF l_inbj.inbj015 IS NULL THEN
         LET l_inbj.inbj015 = ' '
      END IF  
      
      LET l_inbj2.* = l_inbj.*
      LET l_inbj2.inbjseq = l_cnt
      LET l_inbj2.inbj009 = l_inbj.inbj010
      LET l_inbj2.inbj012 = l_inbj.inbj013 #170112-00038#1 add inbj013
#      LET l_inbj2.inbjdocno = g_inbi_m.inbidocno
      LET l_inbj2.inbj005 = l_inbj.inbj014
      LET l_inbj2.inbj006 = l_inbj.inbj015
      INITIALIZE l_inbj2.inbj014 TO NULL
      INITIALIZE l_inbj2.inbj015 TO NULL
      
    #170123-00003#1-(S)-remark
      #170118-00015#1--mark--start--
      #這裡沒有項次的概念，這樣相減會有錯誤
      SELECT SUM(inbj009) INTO l_inbj009 FROM inbj_t,inbi_t WHERE inbjent = inbient    #抓出来源单据已经打过资料的数量
         AND inbjdocno = inbidocno AND inbient = g_enterprise AND inbistus <> 'X' AND inbi000 = '2'
         AND inbi031 = g_inbi_m.inbi031
         AND inbj001 = l_inbj2.inbj001 AND inbj005 = l_inbj2.inbj005 AND inbj002 = l_inbj2.inbj002 
         AND inbj003 = l_inbj2.inbj003  AND inbj006 = l_inbj2.inbj006
         AND inbj007 = l_inbj2.inbj007  AND inbj008 = l_inbj2.inbj008 AND inbj016 = l_inbj2.inbj016 
         AND inbj017 = l_inbj2.inbj017 AND inbj018 = l_inbj2.inbj018      
         AND inbidocno <> g_inbi_m.inbidocno  #170123-00003#1 add 排除自身單據 
      IF cl_null(l_inbj009) THEN LET l_inbj009 = 0 END IF 
      LET l_deff_num1 =   l_inbj2.inbj009 - l_inbj009          
      #170118-00015#1--mark--end----
    #170123-00003#1-(E)-remark  
      #抓出已经打过资料的数量(相同料倉儲批等)
      SELECT SUM(inbj009) INTO l_inbj009_sum FROM inbj_t,inbi_t WHERE inbjent = inbient    
         AND inbjdocno = inbidocno AND inbient = g_enterprise AND inbistus <> 'X' AND inbi000 = '2'         
         AND inbj001 = l_inbj2.inbj001 AND inbj005 = l_inbj2.inbj005 AND inbj002 = l_inbj2.inbj002 
         AND inbj003 = l_inbj2.inbj003  AND inbj006 = l_inbj2.inbj006
         AND inbj007 = l_inbj2.inbj007  AND inbj008 = l_inbj2.inbj008 AND inbj016 = l_inbj2.inbj016 
         AND inbj017 = l_inbj2.inbj017 AND inbj018 = l_inbj2.inbj018
         AND inbistus <> 'S' #170123-00003#1 add 排除已過帳單據
      IF cl_null(l_inbj009_sum) THEN LET l_inbj009_sum = 0 END IF
      #抓出報廢申請單的數量(相同料倉儲批等)
      LET l_inaq011 = 0
      SELECT inaq011 INTO l_inaq011 FROM inaq_t WHERE inaqent = g_enterprise
                     AND inaqsite = g_site AND inaq001 = l_inbj2.inbj001
                     AND inaq004 = l_inbj2.inbj005 AND inaq002 = l_inbj2.inbj002
                     AND inaq003 = l_inbj2.inbj003 AND inaq005 = l_inbj2.inbj006
                     AND inaq006 = l_inbj2.inbj007 AND inaq007 = l_inbj2.inbj008
                     AND inaq008 = l_inbj2.inbj016 AND inaq010 = l_inbj2.inbj017
                     AND inaq009 = l_inbj2.inbj018 
      LET l_deff_num = l_inaq011 - l_inbj009_sum  #可報廢的數量
      IF l_deff_num <= 0 THEN
         EXIT FOREACH
      ELSE
        #170123-00003#1-(S)-remark
         #170118-00015#1--mark--start--
         IF l_deff_num1 >= l_deff_num THEN
            LET l_inbj2.inbj009 = l_deff_num
         ELSE
            LET l_inbj2.inbj009 = l_deff_num1
         END IF
         #170118-00015#1--mark--end----
        #170123-00003#1-(E)-remark
        
        #170123-00003#1-(S)-mark
        ##170118-00015#1--add---start--
        ##如果可報廢量小於本項次要報廢的數量，則本項次數量替換為可報廢量
        #IF l_deff_num < l_inbj2.inbj009 THEN
        #   LET l_inbj2.inbj009 = l_deff_num
        #END IF
        ##170118-00015#1--add---end----
        #170123-00003#1-(E)-mark
      END IF
      
      IF l_inbj2.inbj009 <= 0 THEN
         CONTINUE FOREACH
      END IF
#      INSERT INTO inbj_t VALUES (l_inbj2.*)
      INSERT INTO inbj_t
                  (inbjent,
                   inbjdocno,
                   inbjseq
                   ,inbj001,inbj002,inbj005,inbj006,inbj007,inbj003,inbj008,inbj016,inbj017,inbj018,inbj009,inbj011,inbj012,inbj004,inbj014,inbj015,inbj019,inbj020,inbj021,inbj031,inbjsite,inbj010,inbj013)  #170112-00038#1 add inbj013 
            VALUES(g_enterprise,
                   g_inbi_m.inbidocno,l_inbj2.inbjseq
                   ,l_inbj2.inbj001,l_inbj2.inbj002,l_inbj2.inbj005, 
                       l_inbj2.inbj006,l_inbj2.inbj007,l_inbj2.inbj003, 
                       l_inbj2.inbj008,l_inbj2.inbj016,l_inbj2.inbj017, 
                       l_inbj2.inbj018,l_inbj2.inbj009,l_inbj2.inbj011, 
                       l_inbj2.inbj012,l_inbj2.inbj004,l_inbj2.inbj014, 
                       l_inbj2.inbj015,l_inbj2.inbj019,l_inbj2.inbj020, 
                       l_inbj2.inbj021,l_inbj2.inbj031,l_inbj2.inbjsite,l_inbj2.inbj010,l_inbj2.inbj013)  #170112-00038#1 add inbj013
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      
#     SELECT inbj009 INTO l_inbj009_2 FROM inbj_t
#      WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbi031
#        AND inbjseq = l_inbj.inbjseq
#     IF l_inbj009_2 = l_inbj2.inbj009 THEN
#         IF NOT aint311_inao_ins(l_inbj.inbjseq) THEN
    
         IF NOT aint311_inao_ins(l_inbj2.*,l_inbj.*) THEN
            EXIT FOREACH
         END IF
#     ELSE
#        
#     END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
END FUNCTION

PRIVATE FUNCTION aint311_inao_ins(p_inbj2,p_inbj)
#DEFINE l_inao  RECORD LIKE inao_t.*  #161124-00048#5  16/12/12 By 08734 mark
#161124-00048#5  16/12/12 By 08734 add(S)
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
#161124-00048#5  16/12/12 By 08734 add(E)
DEFINE p_inbj type_g_inbj_d
DEFINE p_inbj2 type_g_inbj_d
DEFINE l_docno LIKE inbi_t.inbidocno
DEFINE l_n  LIKE type_t.num5
DEFINE l_qty  LIKE inbj_t.inbj009
DEFINE l_cnt LIKE type_t.num5

   DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_inbi_m.inbidocno
                        AND inaoseq = p_inbj2.inbjseq AND inaoseq1 = 1 
                        AND inao000 = '2' AND inao013 = -1
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
#   IF g_para = 'Y' THEN
      LET l_docno = g_inbi_m.inbi031
#   ELSE
#      LET l_docno = g_inbi_m.inbi001
#   END IF
   #DECLARE sel_inao_curs CURSOR FOR SELECT * FROM inao_t  #161124-00048#5  16/12/12 By 08734 mark
   DECLARE sel_inao_curs CURSOR FOR SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025 FROM inao_t  #161124-00048#5  16/12/12 By 08734 add
    WHERE inaoent = g_enterprise AND inaodocno = l_docno
      AND inaoseq = p_inbj.inbjseq AND inaoseq1 = 1 
      AND inao000 = '2' AND inao013 = 1
   LET l_qty = 0
   LET l_cnt = 1
   FOREACH sel_inao_curs INTO l_inao.*
      IF SQLCA.SQLCODE THEN 
         RETURN FALSE
      END IF
      LET l_qty = l_qty + l_inao.inao012  #判断申请数量是否够产生inao_t资料
      IF p_inbj2.inbj009 < l_qty THEN
         EXIT FOREACH
      END IF
      CALL aint311_default_inav(p_inbj2.*)
      LET l_n = 0   
      #排除掉已经打过报废制造批序号的资料
      SELECT COUNT(*) INTO l_n FROM inav_t
       WHERE inavent = g_enterprise AND inavsite = g_site
         AND inav001 = g_inav.inav001 AND inav002 = g_inav.inav002
         AND inav003 = g_inav.inav003 AND inav004 = g_inav.inav004
         AND inav005 = g_inav.inav005 AND inav006 = g_inav.inav006
         AND inav007 = g_inav.inav007 AND inav008 = g_inav.inav008
         AND inav009 = g_inav.inav009 AND inav010 = g_inav.inav010
         AND inav012 = l_inao.inao008 AND inav013 = l_inao.inao009
         AND inav016 = inav017
      IF l_n > 0 THEN
         CONTINUE FOREACH
      END IF
      LET l_inao.inao013 = -1
      LET l_inao.inaodocno = g_inbi_m.inbidocno
      LET l_inao.inaoseq2 = l_cnt
      #INSERT INTO inao_t VALUES(l_inao.*)  #161124-00048#5  16/12/12 By 08734 mark
      INSERT INTO inao_t(inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024,inao025)  #161124-00048#5  16/12/12 By 08734 add
         VALUES(l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,l_inao.inao024,l_inao.inao025)
      IF SQLCA.SQLCODE THEN
         RETURN FALSE
      END IF
      
#     #如果走报废品管理则
#     IF NOT cl_null(g_inbi_m.inbi032) AND g_inbi_m.inbi032 = 'Y' THEN
#        LET l_inao.inao005 = p_inbj014
#        LET l_inao.inao006 = p_inbj015
#        LET l_inao.inao013 = 1
#     END IF
      
      #报废档制造批序号回写
      LET g_inav.inav012 = l_inao.inao008
      LET g_inav.inav013 = l_inao.inao009
      IF NOT s_aint311_upd_inav017('1',g_inbi_m.inbidocno,l_cnt,p_inbj2.inbj014,p_inbj2.inbj015,g_inav.*) THEN
         RETURN FALSE
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_docno_default()
    LET g_inbi_m.inbidocdt = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbidocdt',g_inbi_m.inbidocdt)
    LET g_inbi_m.inbi001   = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbi001',g_inbi_m.inbi001)
    LET g_inbi_m.inbi002   = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbi002',g_inbi_m.inbi002)
    LET g_inbi_m.inbi031   = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbi004',g_inbi_m.inbi031)
    LET g_inbi_m.inbi032   = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbi003',g_inbi_m.inbi032)
    IF cl_null(g_inbi_m.inbi032) THEN LET g_inbi_m.inbi032 = 'N' END IF
    LET g_inbi_m.inbi021   = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbi021',g_inbi_m.inbi021)
    LET g_inbi_m.inbi007   = s_aooi200_get_doc_default(g_site,'1',g_inbi_m.inbidocno,'inbi007',g_inbi_m.inbi007)
    
    #160824-00007#280 161229 by lori add---(S)
    LET g_inbi_m_o.inbidocdt = g_inbi_m.inbidocdt
    LET g_inbi_m_o.inbi001   = g_inbi_m.inbi001  
    LET g_inbi_m_o.inbi002   = g_inbi_m.inbi002  
    LET g_inbi_m_o.inbi031   = g_inbi_m.inbi031  
    LET g_inbi_m_o.inbi032   = g_inbi_m.inbi032  
    LET g_inbi_m_o.inbi021   = g_inbi_m.inbi021  
    LET g_inbi_m_o.inbi007   = g_inbi_m.inbi007  
    #160824-00007#280 161229 by lori add---(E)
END FUNCTION

PRIVATE FUNCTION aint311_input_inbi007()
DEFINE l_date    LIKE type_t.dat 
DEFINE l_flag    LIKE type_t.chr1  #160604-00034#3

 CALL aint311_set_entry('')
 CALL aint311_set_no_entry('')
 #160604-00034#3-S
 LET l_flag = 'N' 
 IF NOT cl_chk_update_pstdt() THEN
    CALL cl_set_comp_entry("inbi007",FALSE) 
    IF g_stus = 'S' THEN
       LET g_inbi_m.inbi007 = g_today
       DISPLAY BY NAME g_inbi_m.inbi007
       LET l_flag = 'Y'
    END IF 
 END IF   
 IF l_flag = 'N' THEN
 #160604-00034#3-E
 DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 

     INPUT BY NAME g_inbi_m.inbi007 ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT 
            IF g_stus = 'S' THEN
               LET g_inbi_m.inbi007 = g_today
            END IF
         AFTER FIELD inbi007
            IF NOT cl_null(g_inbi_m.inbi007) THEN
               CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_date
               IF g_inbi_m.inbi007 < l_date THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00077'
                  LET g_errparam.extend = g_inbi_m.inbi007||" < "||l_date
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_inbi_m.inbi007 = g_today
               END IF
            END IF 

      END INPUT

      ON ACTION accept
         #add-point:input段accept
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
      
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
      
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   END DIALOG
   END IF #160604-00034#3
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN FALSE
   ELSE
      UPDATE inbi_t SET inbi007 = g_inbi_m.inbi007
                  WHERE inbient = g_enterprise AND inbidocno = g_inbi_m.inbidocno
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_inag_chk()
DEFINE l_sql   STRING
DEFINE l_n    LIKE type_t.num5
   LET l_sql = "SELECT COUNT(*) FROM inag_t WHERE inagent = ",g_enterprise,
               " AND inagsite='",g_site,"' "
   IF NOT cl_null(g_inbj_d[l_ac].inbj001) THEN
      LET l_sql = l_sql," AND inag001 = '",g_inbj_d[l_ac].inbj001,"'"
   END IF

   IF NOT cl_null(g_inbj_d[l_ac].inbj005)  THEN
      LET l_sql = l_sql," AND inag004 = '",g_inbj_d[l_ac].inbj005,"'"
   END IF

   IF NOT cl_null(g_inbj_d[l_ac].inbj006)  THEN
      LET l_sql = l_sql," AND inag005 = '",g_inbj_d[l_ac].inbj006,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj002) THEN
      LET l_sql = l_sql," AND inag002 = '",g_inbj_d[l_ac].inbj002,"'"
   END IF

   IF NOT cl_null(g_inbj_d[l_ac].inbj003) THEN
      LET l_sql = l_sql," AND inag003 = '",g_inbj_d[l_ac].inbj003,"'"
   END IF
   
   IF NOT cl_null(g_inbj_d[l_ac].inbj007) THEN
      LET l_sql = l_sql," AND inag006 = '",g_inbj_d[l_ac].inbj007,"'"
   END IF

   IF NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
      LET l_sql = l_sql," AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
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
   
   LET l_sql = l_sql," AND inag008 > 0 "
   PREPARE sel_inag_pre2 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre2 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00120'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_inbj009_chk_2()
DEFINE l_inag008 LIKE inag_t.inag008
DEFINE l_sql STRING
   IF NOT cl_null(g_inbj_d[l_ac].inbj009) AND NOT cl_null(g_inbj_d[l_ac].inbj001) AND NOT cl_null(g_inbj_d[l_ac].inbj005) AND NOT cl_null(g_inbj_d[l_ac].inbj008) THEN
      CALL aint311_detail_default()
      LET l_sql = "SELECT inag008 FROM inag_t WHERE inagent = ",g_enterprise,
                   "  AND inagsite = '",g_site,"' AND inag001 = '",g_inbj_d[l_ac].inbj001,"'",
                   "  AND inag004 = '",g_inbj_d[l_ac].inbj005,"' AND 1=1 ",
                   "  AND inag002 = '",g_inbj_d[l_ac].inbj002,"'",
                   "  AND inag003 = '",g_inbj_d[l_ac].inbj003,"' AND inag005 = '",g_inbj_d[l_ac].inbj006,"'",
                   "  AND inag006 = '",g_inbj_d[l_ac].inbj007,"' AND inag007 = '",g_inbj_d[l_ac].inbj008,"'"
      LET l_inag008 = 0
      PREPARE sel_inag008_prep FROM l_sql
      EXECUTE sel_inag008_prep INTO l_inag008
      IF g_inbj_d[l_ac].inbj009 > l_inag008 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00184'
         LET g_errparam.extend = g_inbj_d[l_ac].inbj009||" > "||l_inag008
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_detail_default()
   IF cl_null(g_inbj_d[l_ac].inbj002) THEN LET g_inbj_d[l_ac].inbj002 = " " END IF
   IF cl_null(g_inbj_d[l_ac].inbj003) THEN LET g_inbj_d[l_ac].inbj003 = " " END IF
   IF cl_null(g_inbj_d[l_ac].inbj006) THEN LET g_inbj_d[l_ac].inbj006 = " " END IF
   IF cl_null(g_inbj_d[l_ac].inbj007) THEN LET g_inbj_d[l_ac].inbj007 = " " END IF
   IF cl_null(g_inbj_d[l_ac].inbj008) THEN LET g_inbj_d[l_ac].inbj008 = " " END IF
END FUNCTION

PRIVATE FUNCTION aint311_inao_exists()
DEFINE l_n  LIKE type_t.num5
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inao_t 
    WHERE inaoent = g_enterprise AND inaodocno = g_inbi_m.inbidocno
      AND inaoseq = g_inbj_d[l_ac].inbjseq AND inaoseq1 = 1 
      AND inao000 = '1' AND inao013 = -1
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_pxh_chk()
DEFINE l_n LIKE type_t.num5
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM imaf_t 
    WHERE imafent = g_enterprise AND imafsite = g_inbi_m.inbisite
      AND imaf001 = g_inbj_d[l_ac].inbj001 AND (imaf071 = '1' OR imaf081 = '1')
   IF l_n = 0 THEN
      RETURN FALSE 
   END IF
   
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM inai_t
    WHERE inaient = g_enterprise AND inaisite = g_inbi_m.inbisite
      AND inai001 = g_inbj_d[l_ac].inbj001 AND inai002 = g_inbj_d[l_ac].inbj002
      AND inai003 = g_inbj_d[l_ac].inbj003 AND inai004 = g_inbj_d[l_ac].inbj005
      AND inai005 = g_inbj_d[l_ac].inbj006 AND inai006 = g_inbj_d[l_ac].inbj007
      AND inai010 > 0
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#获取inaq可报废量,排除已打资料的数量
PRIVATE FUNCTION aint311_get_def_num(p_cmd)
DEFINE l_inaq011 LIKE inaq_t.inaq011
DEFINE l_inbj009_sum LIKE inbj_t.inbj009
DEFINE l_sql STRING
DEFINE p_cmd     LIKE type_t.chr1
DEFINE l_deff_num LIKE inbj_t.inbj009     
     LET l_sql = "SELECT inaq011 FROM inaq_t WHERE inaqent = ",g_enterprise,
                   "  AND inaqsite = '",g_site,"' AND inaq001 = '",g_inbj_d[l_ac].inbj001,"'",
                   "  AND inaq004 = '",g_inbj_d[l_ac].inbj005,"' AND inaq002 = '",g_inbj_d[l_ac].inbj002,"'",
                   "  AND inaq003 = '",g_inbj_d[l_ac].inbj003,"' AND inaq005 = '",g_inbj_d[l_ac].inbj006,"'",
                   "  AND inaq006 = '",g_inbj_d[l_ac].inbj007,"' AND inaq007 = '",g_inbj_d[l_ac].inbj008,"'",
                   "  AND inaq008 = '",g_inbj_d[l_ac].inbj016,"' AND inaq010 = '",g_inbj_d[l_ac].inbj017,"'",
                   "  AND inaq009 = '",g_inbj_d[l_ac].inbj018,"'"
      LET l_inaq011 = 0
      PREPARE sel_inaq011_prep FROM l_sql
      EXECUTE sel_inaq011_prep INTO l_inaq011
      SELECT SUM(inbj009) INTO l_inbj009_sum FROM inbj_t,inbi_t WHERE inbjent = inbient
         AND inbjdocno = inbidocno AND inbient = g_enterprise AND inbistus <> 'X' AND inbi000 = '2' 
         AND inbj001 = g_inbj_d[l_ac].inbj001
         AND inbj005 = g_inbj_d[l_ac].inbj005 AND inbj002 = g_inbj_d[l_ac].inbj002
         AND inbj003 = g_inbj_d[l_ac].inbj003 AND inbj006 = g_inbj_d[l_ac].inbj006
         AND inbj007 = g_inbj_d[l_ac].inbj007 AND inbj008 = g_inbj_d[l_ac].inbj008
         AND inbj016 = g_inbj_d[l_ac].inbj016 AND inbj017 = g_inbj_d[l_ac].inbj017
         AND inbj018 = g_inbj_d[l_ac].inbj018
         AND inbistus <> 'S'    #170209-00021#1 add 排除已过帐单据
      IF cl_null(l_inbj009_sum) THEN LET l_inbj009_sum = 0 END IF
#      IF p_cmd = 'a' THEN
         #LET l_deff_num = l_inaq011 - l_inbj009_sum                       #170112-00038#1 mark
          LET l_deff_num = l_inaq011 - l_inbj009_sum + g_inbj_d_t.inbj009  #170112-00038#1 add
#      ELSE
#         LET l_deff_num = l_inaq011 - l_inbj009_sum + g_inbj_d_t.inbj009
#      END IF
      RETURN l_deff_num
END FUNCTION
#判断申请数量是否与来源数量一致
PRIVATE FUNCTION aint311_same_qty()
DEFINE l_qty LIKE type_t.num20_6
DEFINE l_inbj009 LIKE inbj_t.inbj009

   IF NOT cl_null(g_inbi_m.inbi031) THEN
      SELECT inbj009 INTO l_inbj009 FROM inbj_t
       WHERE inbjent = g_enterprise AND inbjdocno = g_inbi_m.inbidocno
         AND inbjseq = g_inbj_d[l_ac].inbjseq
      IF l_inbj009 != g_inbj_d[l_ac].inbj009 THEN
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION
#给inav_t赋值
PRIVATE FUNCTION aint311_default_inav(p_inbj)
DEFINE p_inbj  type_g_inbj_d  
   LET g_inav.inavent = g_enterprise
   LET g_inav.inavsite = g_site
   LET g_inav.inav001 = p_inbj.inbj001
   LET g_inav.inav002 = p_inbj.inbj002
   LET g_inav.inav003 = p_inbj.inbj003
   LET g_inav.inav004 = p_inbj.inbj005
   LET g_inav.inav005 = p_inbj.inbj006
   LET g_inav.inav006 = p_inbj.inbj007
   LET g_inav.inav007 = p_inbj.inbj008
   LET g_inav.inav008 = p_inbj.inbj016
   LET g_inav.inav009 = p_inbj.inbj018
   LET g_inav.inav010 = p_inbj.inbj017
   LET g_inav.inav016 = p_inbj.inbj009
END FUNCTION
#产出inao_t资料
PRIVATE FUNCTION aint311_del_inao()
   DELETE FROM inao_t WHERE inaoent = g_enterprise
      AND inaodocno = g_inbi_m.inbidocno AND inaoseq = g_inbj_d[l_ac].inbjseq
END FUNCTION
#回写inav_t资料
PRIVATE FUNCTION aint311_upd_inav(p_inbj)
DEFINE p_inbj type_g_inbj_d   
   IF g_para = 'Y' THEN
      CALL aint311_default_inav(p_inbj.*)
      UPDATE inav_t SET inav017 = 0
                  WHERE inavent = g_enterprise
                    AND inavsite = g_site
                    AND inav001 = g_inav.inav001 
                    AND inav002 = g_inav.inav002   
                    AND inav003 = g_inav.inav003   
                    AND inav004 = g_inav.inav004   
                    AND inav005 = g_inav.inav005  
                    AND inav006 = g_inav.inav006 
                    AND inav007 = g_inav.inav007   
                    AND inav008 = g_inav.inav008  
                    AND inav009 = g_inav.inav009  
                    AND inav010 = g_inav.inav010
                    AND EXISTS( SELECT 1 FROM inao_t WHERE inaoent = g_enterprise
                    AND inaodocno = g_inbi_m.inbidocno  AND inaoseq = p_inbj.inbjseq
                    AND inao008 = inav012 AND inao009 = inav013)
   END IF
END FUNCTION
#备份单身重要资料
PRIVATE FUNCTION aint311_detail_back()
     LET g_inbj_d_o.inbj001 = g_inbj_d[l_ac].inbj001
     LET g_inbj_d_o.inbj002 = g_inbj_d[l_ac].inbj002
     LET g_inbj_d_o.inbj003 = g_inbj_d[l_ac].inbj003
     LET g_inbj_d_o.inbj005 = g_inbj_d[l_ac].inbj005
     LET g_inbj_d_o.inbj006 = g_inbj_d[l_ac].inbj006
     LET g_inbj_d_o.inbj007 = g_inbj_d[l_ac].inbj007
     LET g_inbj_d_o.inbj008 = g_inbj_d[l_ac].inbj008
     LET g_inbj_d_o.inbj016 = g_inbj_d[l_ac].inbj016
     LET g_inbj_d_o.inbj017 = g_inbj_d[l_ac].inbj017
     LET g_inbj_d_o.inbj018 = g_inbj_d[l_ac].inbj018
     LET g_inbj_d_o.inbj009 = g_inbj_d[l_ac].inbj009 
END FUNCTION
#还原单身重要资料
PRIVATE FUNCTION aint311_detail_return()
     IF g_inbj_d_o.inbj001 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj001 = g_inbj_d_o.inbj001
     END IF
     
     IF g_inbj_d_o.inbj002 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj002 = g_inbj_d_o.inbj002
     END IF
     
     IF g_inbj_d_o.inbj003 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj003 = g_inbj_d_o.inbj003
     END IF
     
     IF g_inbj_d_o.inbj005 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj005 = g_inbj_d_o.inbj005
     END IF
     
     IF g_inbj_d_o.inbj006 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj006 = g_inbj_d_o.inbj006
     END IF
     
     IF g_inbj_d_o.inbj007 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj007 = g_inbj_d_o.inbj007
     END IF
     
     IF g_inbj_d_o.inbj008 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj008 = g_inbj_d_o.inbj008
     END IF
     
     IF g_inbj_d_o.inbj016 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj016 = g_inbj_d_o.inbj016
     END IF
     
     IF g_inbj_d_o.inbj017 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj017 = g_inbj_d_o.inbj017
     END IF
     
     IF g_inbj_d_o.inbj018 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj018 = g_inbj_d_o.inbj018
     END IF
     
     IF g_inbj_d_o.inbj009 IS NOT NULL THEN
        LET g_inbj_d[l_ac].inbj009 = g_inbj_d_o.inbj009
     END IF 

     CALL aint311_inbj001_desc()
     CALL aint311_inbj005_desc()
     CALL aint311_inbj006_desc()
     CALL s_feature_description(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002) RETURNING g_success,g_inbj_d[l_ac].inbj002_desc
     CALL aint311_inbj016_desc()
     CALL aint311_inbj017_desc()
END FUNCTION

PRIVATE FUNCTION aint311_change_lot()
DEFINE l_count LIKE type_t.num5   
 #  IF s_lot_batch_number(g_inbj_d[l_ac].inbj001,g_site) THEN
    IF s_lot_batch_number_1n3(g_inbj_d[l_ac].inbj001,g_site) AND NOT cl_null(g_inbj_d[l_ac].inbj009) THEN 
      IF g_para = 'Y' THEN
         IF (g_inbj_d[l_ac].inbj001 != g_inbj_d_o.inbj001 OR (g_inbj_d_o.inbj001 IS NULL AND g_inbj_d[l_ac].inbj001 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj002 != g_inbj_d_o.inbj002 OR (g_inbj_d_o.inbj002 IS NULL AND g_inbj_d[l_ac].inbj002 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj003 != g_inbj_d_o.inbj003 OR (g_inbj_d_o.inbj003 IS NULL AND g_inbj_d[l_ac].inbj003 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj005 != g_inbj_d_o.inbj005 OR (g_inbj_d_o.inbj005 IS NULL AND g_inbj_d[l_ac].inbj005 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj006 != g_inbj_d_o.inbj006 OR (g_inbj_d_o.inbj006 IS NULL AND g_inbj_d[l_ac].inbj006 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj007 != g_inbj_d_o.inbj007 OR (g_inbj_d_o.inbj007 IS NULL AND g_inbj_d[l_ac].inbj007 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj008 != g_inbj_d_o.inbj008 OR (g_inbj_d_o.inbj008 IS NULL AND g_inbj_d[l_ac].inbj008 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj016 != g_inbj_d_o.inbj016 OR (g_inbj_d_o.inbj016 IS NULL AND g_inbj_d[l_ac].inbj016 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj017 != g_inbj_d_o.inbj017 OR (g_inbj_d_o.inbj017 IS NULL AND g_inbj_d[l_ac].inbj017 IS NOT NULL)) OR
            (g_inbj_d[l_ac].inbj018 != g_inbj_d_o.inbj018 OR (g_inbj_d_o.inbj018 IS NULL AND g_inbj_d[l_ac].inbj018 IS NOT NULL)) THEN  
            CALL s_lot_inao_chk(g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq,1,'1',g_site) RETURNING g_success,l_count

            IF l_count > 0 THEN
               IF g_success THEN
                  CALL aint311_upd_inav(g_inbj_d_o.*)
                  CALL aint311_del_inao()
                  CALL aint311_default_inav(g_inbj_d[l_ac].*)
                  IF NOT s_aint311_lot_sel(g_inav.*,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq) THEN
                     CALL aint311_detail_return()
#                     RETURN FALSE
                  END IF
               ELSE
                  CALL aint311_detail_return()
#                  RETURN FALSE
               END IF
            ELSE
               CALL aint311_default_inav(g_inbj_d[l_ac].*)
               IF NOT s_aint311_lot_sel(g_inav.*,g_inbi_m.inbidocno,g_inbj_d[l_ac].inbjseq) THEN
                  CALL aint311_detail_return()
#                  RETURN FALSE
               END IF
            END IF 
         END IF
      END IF
   END IF
   CALL aint311_inao_b_fill()
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aint311_default_controlp()
   LET g_qryparam.default1 = g_inbj_d[l_ac].inbj001 
   LET g_qryparam.default2 = g_inbj_d[l_ac].inbj002 
   LET g_qryparam.default3 = g_inbj_d[l_ac].inbj003 
   LET g_qryparam.default4 = g_inbj_d[l_ac].inbj005 
   LET g_qryparam.default5 = g_inbj_d[l_ac].inbj006 
   LET g_qryparam.default6 = g_inbj_d[l_ac].inbj007 
   LET g_qryparam.default7 = g_inbj_d[l_ac].inbj008 
   LET g_qryparam.default8 = g_inbj_d[l_ac].inbj016 
   LET g_qryparam.default9 = g_inbj_d[l_ac].inbj017 
   LET g_qryparam.default10 = g_inbj_d[l_ac].inbj018
    
   CALL q_inaq001()                                #呼叫開窗
   
   LET g_inbj_d[l_ac].inbj001 = g_qryparam.return1 
   LET g_inbj_d[l_ac].inbj002 = g_qryparam.return2 
   LET g_inbj_d[l_ac].inbj003 = g_qryparam.return3 
   LET g_inbj_d[l_ac].inbj005 = g_qryparam.return4 
   LET g_inbj_d[l_ac].inbj006 = g_qryparam.return5 
   LET g_inbj_d[l_ac].inbj007 = g_qryparam.return6 
   LET g_inbj_d[l_ac].inbj008 = g_qryparam.return7 
   LET g_inbj_d[l_ac].inbj016 = g_qryparam.return8 
   LET g_inbj_d[l_ac].inbj017 = g_qryparam.return9 
   LET g_inbj_d[l_ac].inbj018 = g_qryparam.return10 
   DISPLAY g_inbj_d[l_ac].inbj001 TO inbj001
   DISPLAY g_inbj_d[l_ac].inbj002 TO inbj002
   DISPLAY g_inbj_d[l_ac].inbj003 TO inbj003
   DISPLAY g_inbj_d[l_ac].inbj005 TO inbj005
   DISPLAY g_inbj_d[l_ac].inbj006 TO inbj006
   DISPLAY g_inbj_d[l_ac].inbj007 TO inbj007
   DISPLAY g_inbj_d[l_ac].inbj008 TO inbj008
   DISPLAY g_inbj_d[l_ac].inbj016 TO inbj016
   DISPLAY g_inbj_d[l_ac].inbj017 TO inbj017
   DISPLAY g_inbj_d[l_ac].inbj018 TO inbj018
   CALL aint311_inbj001_desc()
   CALL aint311_inbj005_desc()
   CALL aint311_inbj006_desc()
   CALL s_feature_description(g_inbj_d[l_ac].inbj001,g_inbj_d[l_ac].inbj002) RETURNING g_success,g_inbj_d[l_ac].inbj002_desc
   CALL aint311_inbj016_desc()
   CALL aint311_inbj017_desc()

END FUNCTION
#报废原因说明
PRIVATE FUNCTION aint311_inbi003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbi_m.inbi003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='302' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbi_m.inbi003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbi_m.inbi003_desc
END FUNCTION

 
{</section>}
 
