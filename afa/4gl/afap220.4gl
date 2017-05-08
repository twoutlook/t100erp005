#該程式未解開Section, 採用最新樣板產出!
{<section id="afap220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-01-04 14:57:12), PR版次:0009(2016-11-21 15:01:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: afap220
#+ Description: 固定資產期初開帳轉檔作業
#+ Creator....: 01531(2014-11-25 09:47:32)
#+ Modifier...: 01531 -SD/PR- 06189
 
{</section>}
 
{<section id="afap220.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160107-00003#9     2016/01/19  By fionchen   過濾不出固定資產卡片資料
#160318-00025#5     2016/04/14  By 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160125-00005#7     2016/08/09  By 01531 查詢時加上帳套人員權限條件過濾
#160905-00007#1     2016-09-05  By08734       ent调整
#161024-00008#1     2016/10/24  By Hans       AFA組織類型與職能開窗清單調整。
#161111-00028#6     2016/11/21  by 06189      标准程式定义采用宣告模式,弃用.*写法
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
       faamsite LIKE faam_t.faamsite, 
   faamsite_desc LIKE type_t.chr80, 
   glaald LIKE glaa_t.glaald, 
   glaald_desc LIKE type_t.chr80, 
   glaacomp LIKE glaa_t.glaacomp, 
   glaacomp_desc LIKE type_t.chr80, 
   glaa001 LIKE glaa_t.glaa001, 
   glaa001_desc LIKE type_t.chr80, 
   year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   faah001 LIKE type_t.chr500, 
   faah007 LIKE type_t.chr500, 
   faah003 LIKE type_t.chr500, 
   faah005 LIKE type_t.chr500, 
   faah004 LIKE type_t.chr500, 
   faah008 LIKE type_t.chr500, 
   faah006 LIKE type_t.chr500, 
   faah042 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單頭 type 宣告
 TYPE type_g_glaa_m RECORD
   faamsite      LIKE faam_t.faamsite,
   faamsite_desc LIKE type_t.chr80,
   glaald        LIKE glaa_t.glaald,
   glaald_desc   LIKE type_t.chr80,
   glaacomp      LIKE glaa_t.glaacomp,
   glaacomp_desc LIKE type_t.chr80,
   glaa001       LIKE glaa_t.glaa001,
   glaa001_desc  LIKE type_t.chr80,
   year          LIKE type_t.num5,
   month         LIKE type_t.num5
END RECORD
DEFINE g_glaa_m     type_g_glaa_m
DEFINE g_glaa_m_t   type_g_glaa_m
     
#單身 type 宣告
 TYPE type_g_faah_d RECORD
   check LIKE type_t.chr1, 
   faah003 LIKE faah_t.faah003,
   faah004 LIKE faah_t.faah004,
   faah001 LIKE faah_t.faah001, #20141230 add by chenying   
   faah006 LIKE faah_t.faah006,
   faah006_desc LIKE type_t.chr80,
   faah007 LIKE faah_t.faah007,
   faah007_desc LIKE type_t.chr80,
   faah005 LIKE faah_t.faah005, 
   faah008 LIKE faah_t.faah008,
   faah008_desc LIKE type_t.chr80,
   faah042 LIKE faah_t.faah042,
   faaj005 LIKE faaj_t.faaj005,
   faaj016 LIKE faaj_t.faaj016,
   faaj017 LIKE faaj_t.faaj017,
   faaj018 LIKE faaj_t.faaj018,
   faaj021 LIKE faaj_t.faaj021
END RECORD

DEFINE g_faah1_d RECORD
   check LIKE type_t.chr1, 
   faah003 LIKE faah_t.faah003,
   faah004 LIKE faah_t.faah004,
   faah006 LIKE faah_t.faah006,
   faah006_desc LIKE type_t.chr80,
   faah007 LIKE faah_t.faah007,
   faah007_desc LIKE type_t.chr80,
   faah005 LIKE faah_t.faah005, 
   faah008 LIKE faah_t.faah008,
   faah008_desc LIKE type_t.chr80,
   faah042 LIKE faah_t.faah042,
   faaj005 LIKE faaj_t.faaj005,
   faaj017 LIKE faaj_t.faaj017,
   faaj018 LIKE faaj_t.faaj018,
   faaj019 LIKE faaj_t.faaj019,
   faaj021 LIKE faaj_t.faaj021
END RECORD
DEFINE g_faah_d              DYNAMIC ARRAY OF type_g_faah_d 
DEFINE g_wc2                 STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num5
DEFINE l_ac1                 LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數
DEFINE g_rec_b1              LIKE type_t.num5              #單身筆數
DEFINE g_detail_b            LIKE type_t.num5
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx1        LIKE type_t.num5
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
#mark by geza 20161121 #161111-00028#6(S)
#DEFINE g_faam               RECORD LIKE faam_t.* 
#DEFINE g_faam1              RECORD LIKE faam_t.*
#DEFINE g_faah               DYNAMIC ARRAY OF RECORD LIKE faah_t.*,
#       g_faaj               DYNAMIC ARRAY OF RECORD LIKE faaj_t.*,
#       g_faal               DYNAMIC ARRAY OF RECORD LIKE faal_t.*
#DEFINE g_faah1              RECORD LIKE faah_t.*,
#       g_faaj1              RECORD LIKE faaj_t.*
#DEFINE g_faag               RECORD LIKE faag_t.*
#mark by geza 20161121 #161111-00028#6(E)
#add by geza 20161121 #161111-00028#6(S)



DEFINE g_faam RECORD  #固定資產折舊明細資料檔
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
DEFINE g_faam1 RECORD  #固定資產折舊明細資料檔
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
PRIVATE TYPE g_faah_d1 RECORD  #固定資產基礎資料檔
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
DEFINE g_faah          DYNAMIC ARRAY OF g_faah_d1
PRIVATE TYPE g_faaj_d RECORD  #固定資產帳套折舊資訊資料檔
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
       faaj048 LIKE faaj_t.faaj048 #资产分类
END RECORD
DEFINE g_faaj          DYNAMIC ARRAY OF g_faaj_d
DEFINE g_faah1         g_faah_d1
DEFINE g_faaj1         g_faaj_d
PRIVATE TYPE g_faal_d RECORD  #多部門折舊費用分攤單身檔       
   faalent      LIKE faal_t.faalent  , #企业编号
   faalld       LIKE faal_t.faalld   , #账套
   faal001      LIKE faal_t.faal001  , #资产主要类别
   faal002      LIKE faal_t.faal002  , #已停用资产是否计提折旧
   faal003      LIKE faal_t.faal003  , #当月处置是否计提折旧
   faal004      LIKE faal_t.faal004  , #资产处置转入清理科目
   faal005      LIKE faal_t.faal005  , #本月入账计提方式
   faal006      LIKE faal_t.faal006  , #资料所有者
   faalownid    LIKE faal_t.faalownid, #资料所有部门
   faalowndp    LIKE faal_t.faalowndp, #资料录入者
   faalcrtid    LIKE faal_t.faalcrtid, #资料录入部门
   faalcrtdp    LIKE faal_t.faalcrtdp, #资料创建日
   faalcrtdt    LIKE faal_t.faalcrtdt, #资料更改者
   faalmodid    LIKE faal_t.faalmodid, #最近更改日
   faalmoddt    LIKE faal_t.faalmoddt, #状态码
   faalstus     LIKE faal_t.faalstus   #列账/列管
END RECORD
DEFINE g_faal          DYNAMIC ARRAY OF g_faal_d
DEFINE g_faag RECORD  #多部門折舊費用分攤單身檔
       faagent LIKE faag_t.faagent, #企业编号
       faagld LIKE faag_t.faagld, #账套别编码
       faag001 LIKE faag_t.faag001, #数据年度
       faag002 LIKE faag_t.faag002, #数据月份
       faag003 LIKE faag_t.faag003, #分摊类别
       faag004 LIKE faag_t.faag004, #项次
       faag005 LIKE faag_t.faag005, #分摊部门
       faag006 LIKE faag_t.faag006, #折旧费用科目
       faag007 LIKE faag_t.faag007, #分摊比率
       faag008 LIKE faag_t.faag008, #变动比率类型
       faag009 LIKE faag_t.faag009, #变动比率分子科目
       faag010 LIKE faag_t.faag010 #变动数值
END RECORD
#add by geza 20161121 #161111-00028#6(E)
DEFINE g_flag               LIKE type_t.chr1
DEFINE g_flag_1             LIKE type_t.chr1
DEFINE g_mm                 LIKE type_t.chr2
DEFINE g_ym                 LIKE type_t.chr6
DEFINE g_glaa001            LIKE glaa_t.glaa001
DEFINE g_glaa015            LIKE glaa_t.glaa015
DEFINE g_glaa016            LIKE glaa_t.glaa016
DEFINE g_glaa017            LIKE glaa_t.glaa017
DEFINE g_glaa018            LIKE glaa_t.glaa018
DEFINE g_glaa019            LIKE glaa_t.glaa019
DEFINE g_glaa020            LIKE glaa_t.glaa020
DEFINE g_glaa021            LIKE glaa_t.glaa021
DEFINE g_glaa022            LIKE glaa_t.glaa022
DEFINE g_glaacomp            LIKE glaa_t.glaacomp
DEFINE g_faam013_year       LIKE faam_t.faam013
DEFINE g_faam013_all        LIKE faam_t.faam013
DEFINE g_cnt2               LIKE type_t.num5

DEFINE g_target STRING
DEFINE g_glaa004           LIKE glaa_t.glaa004
#DEFINE g_glaa_t            RECORD LIKE glaa_t.*  #20141106 #mark by geza 20161121 #161111-00028#6
#add by geza 20161121 #161111-00028#6(S)
DEFINE g_glaa_t            RECORD   #20141106 #mark by geza 20161121 #161111-00028#6
   glaaent    LIKE glaa_t.glaaent   ,  #企业编号
   glaaownid  LIKE glaa_t.glaaownid ,  #资料所有者
   glaaowndp  LIKE glaa_t.glaaowndp ,  #资料所有部门
   glaacrtid  LIKE glaa_t.glaacrtid ,  #资料录入者
   glaacrtdp  LIKE glaa_t.glaacrtdp ,  #资料录入部门
   glaacrtdt  LIKE glaa_t.glaacrtdt ,  #资料创建日
   glaamodid  LIKE glaa_t.glaamodid ,  #资料更改者
   glaamoddt  LIKE glaa_t.glaamoddt ,  #最近更改日
   glaastus   LIKE glaa_t.glaastus  ,  #状态码
   glaald     LIKE glaa_t.glaald    ,  #账套编号
   glaacomp   LIKE glaa_t.glaacomp  ,  #归属法人
   glaa001    LIKE glaa_t.glaa001   ,  #使用币种
   glaa002    LIKE glaa_t.glaa002   ,  #汇率参照表号
   glaa003    LIKE glaa_t.glaa003   ,  #会计周期参照表号
   glaa004    LIKE glaa_t.glaa004   ,  #会计科目参照表号
   glaa005    LIKE glaa_t.glaa005   ,  #现金变动参照表号
   glaa006    LIKE glaa_t.glaa006   ,  #月结方式
   glaa007    LIKE glaa_t.glaa007   ,  #年结方式
   glaa008    LIKE glaa_t.glaa008   ,  #平行记账否
   glaa009    LIKE glaa_t.glaa009   ,  #凭证登录方式
   glaa010    LIKE glaa_t.glaa010   ,  #现行年度
   glaa011    LIKE glaa_t.glaa011   ,  #现行期别
   glaa012    LIKE glaa_t.glaa012   ,  #最后过账日期
   glaa013    LIKE glaa_t.glaa013   ,  #关账日期
   glaa014    LIKE glaa_t.glaa014   ,  #主账套
   glaa015    LIKE glaa_t.glaa015   ,  #启用本位币二
   glaa016    LIKE glaa_t.glaa016   ,  #本位币二
   glaa017    LIKE glaa_t.glaa017   ,  #本位币二换算基准
   glaa018    LIKE glaa_t.glaa018   ,  #本位币二汇率采用
   glaa019    LIKE glaa_t.glaa019   ,  #启用本位币三
   glaa020    LIKE glaa_t.glaa020   ,  #本位币三
   glaa021    LIKE glaa_t.glaa021   ,  #本位币三换算基准
   glaa022    LIKE glaa_t.glaa022   ,  #本位币三汇率采用
   glaa023    LIKE glaa_t.glaa023   ,  #次账套账务生成时机
   glaa024    LIKE glaa_t.glaa024   ,  #单据别参照表号
   glaa025    LIKE glaa_t.glaa025   ,  #本位币一汇率采用
   glaa026    LIKE glaa_t.glaa026   ,  #币种参照表号
   glaa100    LIKE glaa_t.glaa100   ,  #凭证录入时自动按缺号生成
   glaa101    LIKE glaa_t.glaa101   ,  #凭证总号录入时机
   glaa102    LIKE glaa_t.glaa102   ,  #凭证成立时,借贷不平衡的处理方式
   glaa103    LIKE glaa_t.glaa103   ,  #未打印的凭证可否进行过账
   glaa111    LIKE glaa_t.glaa111   ,  #应计调整单别
   glaa112    LIKE glaa_t.glaa112   ,  #期末结转单别
   glaa113    LIKE glaa_t.glaa113   ,  #年底结转单别
   glaa120    LIKE glaa_t.glaa120   ,  #成本计算类型
   glaa121    LIKE glaa_t.glaa121   ,  #子模块启用分录底稿
   glaa122    LIKE glaa_t.glaa122   ,  #总账可维护资金异动明细
   glaa027    LIKE glaa_t.glaa027   ,  #单据据点编号
   glaa130    LIKE glaa_t.glaa130   ,  #合并账套否
   glaa131    LIKE glaa_t.glaa131   ,  #分层合并
   glaa132    LIKE glaa_t.glaa132   ,  #平均汇率计算方式
   glaa133    LIKE glaa_t.glaa133   ,  #非T100公司导入余额类型
   glaa134    LIKE glaa_t.glaa134   ,  #合并科目转换依据异动码设置值
   glaa135    LIKE glaa_t.glaa135   ,  #现流表间接法群组参照表号
   glaa136    LIKE glaa_t.glaa136   ,  #应收账款核销限定己立账凭证
   glaa137    LIKE glaa_t.glaa137   ,  #应付账款核销限定已立账凭证
   glaa138    LIKE glaa_t.glaa138   ,  #合并报表编制期别
   glaa139    LIKE glaa_t.glaa139   ,  #递延收入(负债)管理生成否
   glaa140    LIKE glaa_t.glaa140   ,  #无原出货单的递延负债减项者,是否仍立递延收入管理?
   glaa123    LIKE glaa_t.glaa123   ,  #应收帐款核销可维护资金异动明细
   glaa124    LIKE glaa_t.glaa124   ,  #应付帐款核销可维护资金异动明细
   glaa028    LIKE glaa_t.glaa028     #汇率来源
END RECORD
#add by geza 20161121 
DEFINE g_wc_cs_ld          STRING      #160125-00005#7
DEFINE g_wc_cs_orga        STRING      #160125-00005#7
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afap220.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
               
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
                              
      #end add-point
      CALL afap220_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap220 WITH FORM cl_ap_formpath("afa",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afap220_init()
 
      #進入選單 Menu (="N")
      CALL afap220_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
                              
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap220
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap220.init" >}
#+ 初始化作業
PRIVATE FUNCTION afap220_init()
 
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
   CALL cl_set_combo_scc('faah005','9903')
   CALL cl_set_combo_scc('faah042','9917') 
   CALL cl_set_combo_scc('b_faah005','9903')
   CALL cl_set_combo_scc('b_faah042','9917')  
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap220.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap220_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   CALL afap220_ui_dialog_1()
   RETURN
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.year,g_master.month,g_master.faah007,g_master.faah003,g_master.faah004, 
             g_master.faah008,g_master.faah006 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year
            #add-point:ON CHANGE year name="input.g.year"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="input.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="input.a.month"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah007
            
            #add-point:AFTER FIELD faah007 name="input.a.faah007"
            IF NOT cl_null(g_master.faah007) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.faah007
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_faad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah007
            #add-point:BEFORE FIELD faah007 name="input.b.faah007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah007
            #add-point:ON CHANGE faah007 name="input.g.faah007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="input.b.faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="input.a.faah003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah003
            #add-point:ON CHANGE faah003 name="input.g.faah003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="input.b.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="input.a.faah004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah004
            #add-point:ON CHANGE faah004 name="input.g.faah004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah008
            
            #add-point:AFTER FIELD faah008 name="input.a.faah008"
            IF NOT cl_null(g_master.faah008) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.faah008
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00011:sub-01302|afai110|",cl_get_progname("afai110",g_lang,"2"),"|:EXEPROGafai110"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002_3903") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah008
            #add-point:BEFORE FIELD faah008 name="input.b.faah008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah008
            #add-point:ON CHANGE faah008 name="input.g.faah008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="input.a.faah006"
            IF NOT cl_null(g_master.faah006) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.faah006
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="input.b.faah006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah006
            #add-point:ON CHANGE faah006 name="input.g.faah006"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="input.c.year"
            
            #END add-point
 
 
         #Ctrlp:input.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="input.c.month"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007 name="input.c.faah007"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.faah007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_faad001()                                #呼叫開窗

            LET g_master.faah007 = g_qryparam.return1              

            DISPLAY g_master.faah007 TO faah007              #

            NEXT FIELD faah007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="input.c.faah003"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="input.c.faah004"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008 name="input.c.faah008"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.faah008             #給予default值
            LET g_qryparam.default2 = "" #g_master.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_master.faah008 = g_qryparam.return1              
            #LET g_master.oocq002 = g_qryparam.return2 
            DISPLAY g_master.faah008 TO faah008              #
            #DISPLAY g_master.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD faah008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="input.c.faah006"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.faah006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_faac001()                                #呼叫開窗

            LET g_master.faah006 = g_qryparam.return1              

            DISPLAY g_master.faah006 TO faah006              #

            NEXT FIELD faah006                          #返回原欄位


            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON faamsite,glaald,glaacomp,glaa001,year,month,faah001,faah007, 
             faah003,faah004,faah008,faah006
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.faamsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faamsite
            #add-point:ON ACTION controlp INFIELD faamsite name="construct.c.faamsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#1
            CALL q_ooef001_47()                                   #161024-00008#1
            DISPLAY g_qryparam.return1 TO faamsite  #顯示到畫面上
            NEXT FIELD faamsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faamsite
            #add-point:BEFORE FIELD faamsite name="construct.b.faamsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faamsite
            
            #add-point:AFTER FIELD faamsite name="construct.a.faamsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="construct.c.glaald"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaald  #顯示到畫面上
            NEXT FIELD glaald                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="construct.b.glaald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="construct.a.glaald"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaacomp  #顯示到畫面上
            NEXT FIELD glaacomp                     #返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa001  #顯示到畫面上
            NEXT FIELD glaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="construct.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="construct.a.year"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="construct.c.year"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="construct.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="construct.a.month"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="construct.c.month"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001 name="construct.c.faah001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上
            NEXT FIELD faah001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah001
            #add-point:BEFORE FIELD faah001 name="construct.b.faah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah001
            
            #add-point:AFTER FIELD faah001 name="construct.a.faah001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007 name="construct.c.faah007"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah007  #顯示到畫面上
            NEXT FIELD faah007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah007
            #add-point:BEFORE FIELD faah007 name="construct.b.faah007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah007
            
            #add-point:AFTER FIELD faah007 name="construct.a.faah007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="construct.c.faah003"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
            NEXT FIELD faah003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="construct.b.faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="construct.a.faah003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="construct.c.faah004"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上
            NEXT FIELD faah004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="construct.b.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="construct.a.faah004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008 name="construct.c.faah008"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah008  #顯示到畫面上
            NEXT FIELD faah008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah008
            #add-point:BEFORE FIELD faah008 name="construct.b.faah008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah008
            
            #add-point:AFTER FIELD faah008 name="construct.a.faah008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="construct.c.faah006"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah006  #顯示到畫面上
            NEXT FIELD faah006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="construct.b.faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="construct.a.faah006"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
                                             
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
                                    INPUT ARRAY g_faah_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
             BEFORE INPUT
                CALL afap220_b_fill(g_wc2)
                LET g_rec_b = g_faah_d.getLength()
                CALL cl_set_comp_entry("faah003,faah004,faah006,faah007,faah005,faah008,faah042",FALSE)

            BEFORE ROW
               LET l_ac = ARR_CURR()
            
#            ON ACTION confirm
#               CALL afap220_confirm()

         END INPUT         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
#                                    DISPLAY ARRAY g_faah_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b1) #page1
#
#            BEFORE ROW
#               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
#               LET g_detail_idx1 = l_ac1
#               DISPLAY g_detail_idx1 TO h_index
#
#            BEFORE DISPLAY
#               CALL FGL_SET_ARR_CURR(g_detail_idx1)
#               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
#               DISPLAY g_rec_b1 TO h_count
#
#         END DISPLAY         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL afap220_get_buffer(l_dialog)
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
         CALL afap220_init()
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
                 CALL afap220_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afap220_transfer_argv(ls_js)
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
 
{<section id="afap220.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afap220_transfer_argv(ls_js)
 
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
 
{<section id="afap220.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afap220_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
               
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
#      CALL afap220_confirm()                         
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE afap220_process_cs CURSOR FROM ls_sql
#  FOREACH afap220_process_cs INTO
   #add-point:process段process name="process.process"
               
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL afap220_confirm()                         
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL afap220_confirm()                        
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL afap220_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="afap220.get_buffer" >}
PRIVATE FUNCTION afap220_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
   LET g_master.faah007 = p_dialog.getFieldBuffer('faah007')
   LET g_master.faah003 = p_dialog.getFieldBuffer('faah003')
   LET g_master.faah004 = p_dialog.getFieldBuffer('faah004')
   LET g_master.faah008 = p_dialog.getFieldBuffer('faah008')
   LET g_master.faah006 = p_dialog.getFieldBuffer('faah006')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afap220.msgcentre_notify" >}
PRIVATE FUNCTION afap220_msgcentre_notify()
 
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
 
{<section id="afap220.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_construct()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   DEFINE l_origin_str STRING
   DEFINE g_bookno     LIKE glaa_t.glaald
   DEFINE l_success    LIKE type_t.num5
   
   CLEAR FORM
   INITIALIZE g_glaa_m.* TO NULL
   CALL g_faah_d.clear()
   INITIALIZE g_wc2 TO NULL
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_glaa_m.faamsite,g_glaa_m.glaald,g_glaa_m.year,g_glaa_m.month
       
      
         BEFORE INPUT 
            CALL s_afat503_default(g_bookno) RETURNING l_success,g_glaa_m.faamsite,g_glaa_m.glaald,g_glaa_m.glaacomp
            CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING  g_glaa_m.faamsite_desc
            CALL afap220_glaald_desc()   #帳套說明、法人說明、幣別+幣別說明

            CALL cl_get_para(g_enterprise,g_glaa_m.faamsite,'S-FIN-9018') RETURNING g_glaa_m.year
            CALL cl_get_para(g_enterprise,g_glaa_m.faamsite,'S-FIN-9019') RETURNING g_glaa_m.month
            DISPLAY BY NAME g_glaa_m.year,g_glaa_m.month

         AFTER FIELD faamsite
            IF NOT cl_null(g_glaa_m.faamsite) THEN
               LET g_glaa_m_t.faamsite = g_glaa_m.faamsite
               #检查组织资料的合理性             
               IF NOT afap220_faamsite_chk(g_glaa_m.faamsite) THEN
                  LET g_glaa_m.faamsite = g_glaa_m_t.faamsite
                  CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING  g_glaa_m.faamsite_desc
                  DISPLAY BY NAME g_glaa_m.faamsite_desc
                  NEXT FIELD CURRENT
               END IF  
               
               #user需要檢查和資產中心的權限
               IF NOT afap220_faamsite_user_chk(g_glaa_m.faamsite) THEN
                  LET g_glaa_m.faamsite = g_glaa_m_t.faamsite
                  CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING g_glaa_m.faamsite_desc
                  DISPLAY BY NAME g_glaa_m.faamsite_desc
                  NEXT FIELD CURRENT  
               END IF
                   
               
               #帐套不为空检查法人归属是否相同
               IF NOT cl_null(g_glaa_m.glaald) THEN
                  IF NOT afap220_faamsite_glaald_chk(g_glaa_m.faamsite,g_glaa_m.glaald) THEN
                     LET g_glaa_m.faamsite = g_glaa_m_t.faamsite
                     CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING g_glaa_m.faamsite_desc
                     DISPLAY BY NAME g_glaa_m.faamsite_desc
                     NEXT FIELD CURRENT  
                  END IF
               END IF                 
            END IF
         
         AFTER FIELD glaald
        
            IF NOT cl_null(g_glaa_m.glaald) THEN
               LET g_glaa_m_t.glaald = g_glaa_m.glaald
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_glaa_m.glaald
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#5--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
               
               ELSE
                  LET g_glaa_m.glaald = g_glaa_m_t.glaald
                  CALL afap220_glaald_desc()                
               END IF               
            
               IF NOT s_ld_chk_authorization(g_user,g_glaa_m.glaald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_glaa_m.glaald
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glaa_m.glaald = g_glaa_m_t.glaald
                  CALL afap220_glaald_desc() 
                  NEXT FIELD CURRENT
               END IF
               
               #资产中心不为空时
               IF NOT cl_null(g_glaa_m.faamsite) THEN
                  IF NOT afap220_faamsite_glaald_chk(g_glaa_m.faamsite,g_glaa_m.glaald) THEN
                     LET g_glaa_m.glaald = g_glaa_m_t.glaald
                     CALL afap220_glaald_desc()
                     DISPLAY BY NAME g_glaa_m.glaald_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #SELECT * INTO g_glaa_t.* #mark by geza 20161121 #161111-00028#6
               #add by geza 20161121 #161111-00028#6(S)
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                      glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                      glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                      glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                      glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                      glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                      glaa028
               
               INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                    g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                    g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                    g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                    g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                    g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                    g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                    g_glaa_t.glaa028
               #add by geza 20161121 #161111-00028#6(E)
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald #20141106 add
               CALL afap220_glaald_desc()      
                                 
            END IF            
          
         ON ACTION controlp INFIELD faamsite
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.faamsite             #給予default值
            LET g_qryparam.where = " ooef207 = 'Y' "
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_glaa_m.faamsite = g_qryparam.return1              

            DISPLAY g_glaa_m.faamsite TO faamsite              #
            CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING g_glaa_m.faamsite_desc
            DISPLAY BY NAME g_glaa_m.faamsite_desc
            NEXT FIELD faamsite                          #返回原欄位
          
          ON ACTION controlp INFIELD glaald
	  	     #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaald             #給予default值

            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_glaa_m.faamsite,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL afap220_change_to_sql(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"

            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glaa_m.glaald = g_qryparam.return1              

            DISPLAY g_glaa_m.glaald TO glaald              #
             
            #SELECT * INTO g_glaa_t.*  #20141106 add #mark by geza 20161121 #161111-00028#6
            #add by geza 20161121 #161111-00028#6(S)
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                   glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                   glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                   glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                   glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                   glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                   glaa028
            
            INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                 g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                 g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                 g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                 g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                 g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                 g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                 g_glaa_t.glaa028
            #add by geza 20161121 #161111-00028#6(E)
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
            CALL afap220_glaald_desc()

            NEXT FIELD glaald                          #返回原欄位
            
            AFTER FIELD year
               IF NOT cl_null(g_glaa_m.year) AND g_glaa_m.year < 1 THEN
                  LET g_glaa_m.year = g_glaa_m_t.year
                  DISPLAY BY NAME g_glaa_m.year
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_glaa_m.year
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF 

            BEFORE FIELD month
               IF cl_null(g_glaa_m.year) THEN
                  NEXT FIELD year
               END IF

            AFTER FIELD month
               IF NOT cl_null(g_glaa_m.month) AND (g_glaa_m.month < 1 OR g_glaa_m.month > 12) THEN
               LET g_glaa_m.month = g_glaa_m_t.month
               DISPLAY BY NAME g_glaa_m.month
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00106'
               LET g_errparam.extend = g_glaa_m.month
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            END IF          {#ADP版次:1#}
            
        AFTER INPUT
     END INPUT
     
     CONSTRUCT BY NAME g_wc2 ON  faah003,faah004,faah006,faah007,faah005,faah008,faah042
       BEFORE CONSTRUCT
          CALL cl_qbe_init() 
              

       ON ACTION controlp INFIELD faah003  #主帳套開窗
	      INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
          CALL q_faah003()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah003 #顯示到畫面上

          NEXT FIELD faah003                    #返回原欄位 
          
       ON ACTION controlp INFIELD faah004     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
          CALL q_faah004()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah004 #顯示到畫面上

          NEXT FIELD faah004                    #返回原欄位 
          
       ON ACTION controlp INFIELD faah006     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
          CALL q_faac001()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah006 #顯示到畫面上

          NEXT FIELD faah006                    #返回原欄位
          
      ON ACTION controlp INFIELD faah007     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
          CALL q_faad001()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah007 #顯示到畫面上

          NEXT FIELD faah007                    #返回原欄位
          
      ON ACTION controlp INFIELD faah008     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
		  LET g_qryparam.arg1 = '3903'
          CALL q_oocq002()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah008 #顯示到畫面上

          NEXT FIELD faah008                    #返回原欄位
       
     END CONSTRUCT   
          
     ON ACTION qbe_select      
 
      ON ACTION qbe_save       
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   

   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION
################################################################################
# Descriptions...: 填充满足条件的数据
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_b_fill(p_wc2)
DEFINE p_wc2  STRING
DEFINE l_sql  STRING
DEFINE l_cnt  LIKE type_t.num5
DEFINE l_yy   LIKE type_t.chr10
DEFINE l_mm   LIKE type_t.chr10
DEFINE l_ym   LIKE type_t.chr10
DEFINE l_date LIKE faah_t.faah014
DEFINE l_success LIKE type_t.num5

    CALL g_faah_d.clear()
    LET l_cnt = 1
    IF cl_null(p_wc2) THEN
       LET p_wc2 = " 1=1" 
    END IF
    

    
    
    #20141230 add by chenying
    LET l_yy = g_glaa_m.year
#    LET l_yy = l_yy.trim()     #mark by yangxf
    LET l_yy = l_yy USING "&&&&"
    LET l_mm = g_glaa_m.month
#    LET l_mm = l_mm.trim()     #mark by yangxf
    LET l_mm = l_mm USING "&&"
    LET l_ym = l_yy,l_mm
    #add by yangxf --begin---
    #得到当月第一天
    SELECT to_date(l_ym,'yyyymm') INTO l_date FROM dual
    #在当前日期的基础上加1个月份
    SELECT add_months(l_date,1) INTO l_date FROM dual  
    #add by yangxf --end---    
    #20141230 add by chenying
    
    # 判斷 資產狀態, 開始折舊年月, 確認碼, 折舊方法, 剩餘月數
    #LET l_sql = " SELECT 'Y',faah003 a,faah004 b,faah001 c,faah006,'',faah007,'',faah005,faah008,'',faah042,faaj005,faaj016,faaj017,faaj018,faaj021,faah_t.*,faaj_t.*", #20141230 add faah001 by chenying #mark by geza 20161121 #161111-00028#6
    LET l_sql = " SELECT 'Y',faah003 a,faah004 b,faah001 c,faah006,'',faah007,'',faah005,faah008,'',faah042,faaj005,faaj016,faaj017,faaj018,faaj021,
                    faahent,faah000,faah001,faah002,faah003,faah004,faah005,faah006,faah007,faah008,faah009,faah010,
                    faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,
                    faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,
                    faah031,faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,
                    faah041,faah042,faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,
                    faahcrtdt,faahmodid,faahmoddt,faahstus,faah046,faah047,faah048,faah049,faah050,
                    faah051,faah052,faah053,faah054,faah055,faah056,
                    faajent,faajld,faajsite,faaj000,faaj001,faaj002,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,faaj009,faaj010,
                    faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,
                    faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,
                    faaj031,faaj032,faaj033,faaj034,faaj035,faaj036,faaj037,faaj038,faaj039,faaj040,
                    faaj041,faaj042,faaj043,faaj044,faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,
                    faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,faaj110,faaj111,faaj112,faaj113,
                    faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,faaj155,faaj156,
                    faaj157,faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,
                    faaj167,faajownid,faajowndp,faajcrtid,faajcrtdp,faajcrtdt,faajmodid,faajmoddt,faajstus,faaj048", #add by geza 20161121 #161111-00028#6
                "   FROM faah_t,faaj_t ",
                "  WHERE faahent = faajent AND faah000 =faaj000",
                "    AND faah003 = faaj001 AND faah004 = faaj002",
                "    AND faah001 = faaj037 ", #20141230 add by chenying
                "    AND faahent = '",g_enterprise,"'",
                "    AND faajld  = '",g_glaa_m.glaald,"'",
               #"    AND faah028 = '",g_glaa_m.glaacomp,"'",          #160107-00003#9 mark
                "    AND faah032 = '",g_glaa_m.glaacomp,"'", #歸屬法人 #160107-00003#9 add
                "    AND faahstus = 'Y' ",
                "    AND faah014 < '",l_date,"'",   #add by yangxf
                "    AND faah015 NOT IN('10') ", #20150120 add by chenying  
                "    AND ",p_wc2 CLIPPED
    LET l_sql = l_sql CLIPPED,"  ORDER BY a,b,c " #20141230 add c by chenying
    
    LET l_cnt = 1
    PREPARE afap220_bp_pre FROM l_sql
    DECLARE afap220_bp_cs CURSOR FOR afap220_bp_pre
    FOREACH afap220_bp_cs INTO g_faah_d[l_cnt].*,g_faah1.*,g_faaj1.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         #抓取參數資料
         SELECT faal002,faal003,faal004  
           INTO g_faal[l_cnt].faal002,g_faal[l_cnt].faal003,g_faal[l_cnt].faal004  
           FROM faal_t
          WHERE faalent = g_enterprise AND faalld = g_glaa_m.glaald
            AND faal001 = g_faah1.faah006
         
         IF cl_null(g_faal[l_cnt].faal002) THEN LET g_faal[l_cnt].faal002 = 'N' END IF
         IF cl_null(g_faal[l_cnt].faal003) THEN LET g_faal[l_cnt].faal003 = 'N' END IF
         IF cl_null(g_faal[l_cnt].faal004) THEN LET g_faal[l_cnt].faal004 = 'N' END IF
         #開帳faam013=0,不考慮提列方式faal005 by chenying
         
         IF g_faal[l_cnt].faal002 = 'N' THEN
            IF g_faah[l_cnt].faah015 = '8' THEN
               CONTINUE FOREACH
            END IF
         END IF

#20141230 mark by chenying         
#         #--折舊月份已開帳,則不再開帳(訊息不列入清單中)
#         LET g_cnt = 0
#         SELECT COUNT(*) INTO g_cnt FROM faam_t
#          WHERE faament = g_enterprise 
#            AND faam001=g_faah_d[l_cnt].faah003 
#            AND faam002=g_faah_d[l_cnt].faah004
#            AND faam000=g_faah_d[l_cnt].faah001 #20141230 add by chenying
#            AND faam004=g_glaa_m.year AND faam005=g_glaa_m.month
#            
#         IF g_cnt > 0 THEN
#            CONTINUE FOREACH
#         END IF
#         
#         #--折舊月份已開帳,則不再開帳(訊息不列入清單中)
#         LET g_cnt = 0
#         SELECT COUNT(*) INTO g_cnt FROM faam_t
#          WHERE faament = g_enterprise 
#            AND faam001=g_faah_d[l_cnt].faah003 
#            AND faam002=g_faah_d[l_cnt].faah004
#            AND faam000=g_faah_d[l_cnt].faah001 #20141230 add by chenying
#            AND (faam004>g_glaa_m.year OR (faam004=g_glaa_m.year AND faam005>=g_glaa_m.month))
#            AND faam007 <> '3' AND faam006='0'
#         IF g_cnt > 0 THEN
#            CONTINUE FOREACH
#         END IF
#
#20141230 mark by chenying  
         LET g_faah[l_cnt].* = g_faah1.*
         LET g_faaj[l_cnt].* = g_faaj1.*
 
         
         SELECT faacl003 INTO g_faah_d[l_cnt].faah006_desc FROM faacl_t
          WHERE faaclent = g_enterprise AND faacl001 = g_faah_d[l_cnt].faah006
            AND faacl002 = g_dlang
         SELECT faadl003 INTO g_faah_d[l_cnt].faah007_desc FROM faadl_t
          WHERE faadlent = g_enterprise AND faadl001 = g_faah_d[l_cnt].faah007
            AND faadl002 = g_dlang
         SELECT oocql004 INTO g_faah_d[l_cnt].faah008_desc FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = '3903'
            AND oocql002 = g_faah_d[l_cnt].faah008
            AND oocql003 = g_dlang
            
  
         LET l_cnt = l_cnt + 1
#         IF l_cnt > g_max_rec THEN
#            EXIT FOREACH
#         END IF         
    END FOREACH
    CALL g_faah_d.deleteElement(g_faah_d.getLength())
END FUNCTION
################################################################################
# Descriptions...: 帐套栏位带值
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_glaald_desc()
DEFINE l_str1      LIKE type_t.chr80
DEFINE l_str2      LIKE type_t.chr80
DEFINE l_ooall004  LIKE ooall_t.ooall004
DEFINE l_ooeal003  LIKE ooeal_t.ooeal003

   SELECT glaa001 INTO g_glaa_m.glaa001
     FROM glaa_t
    WHERE glaaent=g_enterprise AND glaald = g_glaa_m.glaald

   #帳套
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa_m.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaa_m.glaald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glaa_m.glaald_desc

   #法人
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaa_m.glaacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc
   
   #幣別   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa_m.glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaa_m.glaa001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glaa_m.glaa001,g_glaa_m.glaa001_desc 
END FUNCTION
################################################################################
# Descriptions...: 资料检查
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_fill_chk()

END FUNCTION
################################################################################
# Descriptions...: 帐套带本位币二，本位币三币别及汇率
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_glaald_get()
DEFINE r_faam152    LIKE faam_t.faam152
DEFINE r_faam102    LIKE faam_t.faam102

   SELECT glaa001,glaa004,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaacomp
     INTO g_glaa001,g_glaa004,g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaa_m.glaald
   IF NOT cl_null(g_glaa_m.glaald) THEN   
      IF g_glaa015 = 'Y' THEN
         #-----本位币二-------
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_glaa_m.glaald,g_today,g_glaa001,
                                   #目的幣別;      交易金額; 匯類類型
                                   g_glaa016,0,g_glaa018)
         RETURNING r_faam102
      END IF
      IF g_glaa019 = 'Y' THEN
         #-----本位币三-------
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_glaa_m.glaald,g_today,g_glaa001,
                                   #目的幣別;      交易金額; 匯類類型
                                   g_glaa020,0,g_glaa018)
         RETURNING r_faam152

      END IF
   END IF
   RETURN r_faam102,r_faam152
END FUNCTION
################################################################################
# Descriptions...: 资料摊提
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_confirm()
DEFINE l_msg       STRING
DEFINE l_n         LIKE type_t.num5
DEFINE l_i         LIKE type_t.num5
DEFINE l_amt       LIKE type_t.num20_6
DEFINE l_amt_o     LIKE type_t.num20_6
DEFINE l_cost      LIKE type_t.num20_6
DEFINE l_accd      LIKE type_t.num20_6
DEFINE l_fabb005   LIKE fabb_t.fabb005
DEFINE l_faah043   LIKE faah_t.faah043
DEFINE l_rate_y    LIKE type_t.num20_6
DEFINE l_rate      LIKE type_t.num20_6
DEFINE l_cnt       LIKE type_t.num5    
DEFINE l_cnt1      LIKE type_t.num5   
DEFINE p_yy,p_mm   LIKE type_t.num5
DEFINE l_faam015   LIKE faam_t.faam015
DEFINE l_faam016   LIKE faam_t.faam016
DEFINE l_amt_y     LIKE type_t.num20_6
DEFINE l_fabb005_1 LIKE fabb_t.fabb005,
       l_faam009   LIKE faam_t.faam009,
       l_curr      LIKE type_t.num20_6,
       l_curr_y    LIKE type_t.num20_6,
       l_faah015   LIKE faah_t.faah015,
       l_faaf004   LIKE faaf_t.faaf004,
       l_faag007   LIKE faag_t.faag007,
       m_faag007   LIKE faag_t.faag007,
       m_faam013   LIKE faam_t.faam013,
       m_faam014   LIKE faam_t.faam014,
       m_faam015   LIKE faam_t.faam015,
       m_faam016   LIKE faam_t.faam016,
       m_faam018   LIKE faam_t.faam018,
       m_faam019   LIKE faam_t.faam019,
       m_ratio,mm_ratio  LIKE type_t.num26_10,
       m_max_ratio  LIKE type_t.num26_10,
       m_curr      LIKE type_t.num20_6,
       y_curr      LIKE type_t.num20_6,
       m_tot       LIKE type_t.num20_6,
       p_faam015   LIKE faam_t.faam015,
       p_faam016   LIKE faam_t.faam016,
       p_faam015_1 LIKE faam_t.faam015,
       p_faam016_1 LIKE faam_t.faam016,
       mm_faag007  LIKE faag_t.faag007,
       mm_faam013  LIKE faam_t.faam013,
       mm_faam014  LIKE faam_t.faam014,
       mm_faam015  LIKE faam_t.faam015,
       mm_faam016  LIKE faam_t.faam016,
       mm_faam018  LIKE faam_t.faam018,
       mm_faam019  LIKE faam_t.faam019,
       l_faam013   LIKE faam_t.faam013,
       l_faam017   LIKE faam_t.faam017,
       m_tot_faam013  LIKE faam_t.faam013,
       m_tot_curr     LIKE faam_t.faam016,
       m_tot_faam014  LIKE faam_t.faam014,
       m_tot_faam015  LIKE faam_t.faam015,
       m_tot_faam018  LIKE faam_t.faam018,
       m_tot_faam019  LIKE faam_t.faam019,
       l_diff         LIKE faam_t.faam013,
       l_diff2        LIKE faam_t.faam013,
       m_glar         LIKE glar_t.glar005,
       m_faag005      LIKE faag_t.faag005,
       m_max_faag005  LIKE faag_t.faag005,
       l_faaj029      LIKE faaj_t.faaj029,
       l_faam010      LIKE faam_t.faam010,
       l_ooab002      LIKE ooab_t.ooab002,
       l_glac007      LIKE glac_t.glac007
DEFINE l_ooaj003      LIKE ooaj_t.ooaj003
DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
DEFINE l_ooaj0042     LIKE ooaj_t.ooaj004
DEFINE l_ooaj0043     LIKE ooaj_t.ooaj004
#20141106
DEFINE l_faam013_1   LIKE faam_t.faam013
DEFINE l_faam014_1   LIKE faam_t.faam014
DEFINE l_faam015_1   LIKE faam_t.faam015
DEFINE l_faam016_1   LIKE faam_t.faam016
DEFINE l_faam018_1   LIKE faam_t.faam018
DEFINE l_amt_1       LIKE type_t.num20_6
DEFINE l_amt_Y_1     LIKE type_t.num20_6

DEFINE g_faam013 LIKE faam_t.faam013
DEFINE g_faam016 LIKE faam_t.faam016
DEFINE g_faam014 LIKE faam_t.faam014
DEFINE g_faam015 LIKE faam_t.faam015
DEFINE g_faam018 LIKE faam_t.faam018
DEFINE g_faam019 LIKE faam_t.faam018 

#   CALL cl_showmsg_init()
   LET g_success = 'Y'
   CALL s_transaction_begin()
   CALL cl_err_collect_init()  #汇总错误讯息初始化
   FOR l_cnt = 1 TO g_faah.getLength()
      IF g_faah_d[l_cnt].check = 'Y' THEN
         #抓取參數資料
         LET l_n = 0
         LET l_msg = ''
         SELECT COUNT(*) INTO l_n FROM faal_t
          WHERE faalent = g_enterprise AND faalld = g_glaa_m.glaald
            AND faal001 = g_faah[l_cnt].faah006
         IF l_n = 0 THEN
#            CALL cl_errmsg('',g_glaa_m.glaald||g_faah[l_cnt].faah006,'','afa-00240',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_glaa_m.glaald||g_faah[l_cnt].faah006
            LET g_errparam.code = 'afa-00240'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            CONTINUE FOR
         END IF
            
         #--折舊月份已開帳,則不再開帳(訊息不列入清單中)
         LET g_cnt = 0
         SELECT COUNT(*) INTO g_cnt FROM faam_t
          WHERE faam001=g_faah[l_cnt].faah003 AND faam002=g_faah[l_cnt].faah004
            AND faam000=g_faah[l_cnt].faah001 #20141230 add by chening
            AND (faam004>g_glaa_m.year OR (faam004=g_glaa_m.year AND faam005>=g_glaa_m.month))
            AND faam007 <> '3' AND faam006='0'
            AND faamld = g_glaa_m.glaald #20150122 add faamld by chenying
            AND faament = g_enterprise #160905-00007#1 add
         IF g_cnt > 0 THEN
            CONTINUE FOR
         END IF
 
         
         IF cl_null(g_faaj[l_cnt].faaj016) THEN LET g_faaj[l_cnt].faaj016 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj017) THEN LET g_faaj[l_cnt].faaj017 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj018) THEN LET g_faaj[l_cnt].faaj018 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj019) THEN LET g_faaj[l_cnt].faaj019 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj020) THEN LET g_faaj[l_cnt].faaj020 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj021) THEN LET g_faaj[l_cnt].faaj021 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj022) THEN LET g_faaj[l_cnt].faaj022 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj027) THEN LET g_faaj[l_cnt].faaj027 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj028) THEN LET g_faaj[l_cnt].faaj028 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj029) THEN LET g_faaj[l_cnt].faaj029 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj032) THEN LET g_faaj[l_cnt].faaj032 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj034) THEN LET g_faaj[l_cnt].faaj034 = 0 END IF
         IF cl_null(g_faaj[l_cnt].faaj035) THEN LET g_faaj[l_cnt].faaj035 = 0 END IF

         IF g_faaj[l_cnt].faaj006 = '1' THEN 
            LET  l_faam009 = g_faaj[l_cnt].faaj007     #折舊部門
            LET  l_faam010 = ''
            CALL cl_get_para(g_enterprise,g_glaa_m.glaacomp,'S-FIN-9009') RETURNING l_ooab002
            IF l_ooab002 = '1' THEN   #若为1.部門，取afai050中科目
               SELECT faae003 INTO g_faaj[l_cnt].faaj025 FROM faae_t
                WHERE faaeent = g_enterprise AND faaeld = g_glaa_m.glaald
                  AND faae001 = l_faam009 AND faae002 = g_faah[l_cnt].faah006
#               IF SQLCA.SQLCODE = 100 THEN
#                   CALL cl_errmsg('',g_glaa_m.glaald||l_faam009||g_faah[l_cnt].faah006,'','afa-00184',1)
#                   CONTINUE FOR
#               END IF
            ELSE    #若为2.資產，取卡片中折舊科目
               LET g_faaj[l_cnt].faaj025 = g_faaj[l_cnt].faaj025
            END IF
            IF cl_null(g_faaj[l_cnt].faaj025) THEN
               CONTINUE FOR
            END IF
         ELSE
            LET  l_faam009 = g_faah[l_cnt].faah026     #保管部門
            LET  l_faam010 = g_faah[l_cnt].faah026     #保管部門
         END IF
         
         #成本=faaj本币成本+调整成本-销帐成本
         LET g_faam.faam014 = g_faaj[l_cnt].faaj016 + g_faaj[l_cnt].faaj020 - g_faaj[l_cnt].faaj034
         #折舊金額
         LET g_faam.faam013 = 0
         #累计折旧
         LET g_faam.faam015 = g_faaj[l_cnt].faaj017
         #本年累折
         LET g_faam.faam016 = g_faaj[l_cnt].faaj018
         #已提列減值準備
         LET g_faam.faam018 = g_faaj[l_cnt].faaj021  
         #年折舊額
         LET g_faam.faam019 = 0
         #汇率  
         LET g_faam.faam012 = g_faaj[l_cnt].faaj015  
          
         
         #本位币二汇率，本位币三汇率
         CALL afap220_glaald_get() RETURNING g_faam.faam102,g_faam.faam152
         LET g_faam.faam101 = g_glaa016    #本位币二币别
         LET g_faam.faam151 = g_glaa020    #本位币三币别
         #---本位币二---
         IF g_glaa015 = 'Y' THEN
            LET g_faam.faam103 = g_faam.faam014 * g_faam.faam102  #成本
            LET g_faam.faam104 = g_faam.faam013 * g_faam.faam102  #折旧金额
            LET g_faam.faam105 = g_faam.faam015 * g_faam.faam102  #累折
            LET g_faam.faam106 = g_faam.faam016 * g_faam.faam102  #本年累折
            LET g_faam.faam107 = g_faam.faam019 * g_faam.faam102  #年折旧额
            LET g_faam.faam108 = g_faam.faam018 * g_faam.faam102  #已提列减值准备
         END IF 
         #---本位币三---
         IF g_glaa019 = 'Y' THEN
            LET g_faam.faam153 = g_faam.faam014 * g_faam.faam152  #成本
            LET g_faam.faam154 = g_faam.faam013 * g_faam.faam152  #折旧金额
            LET g_faam.faam155 = g_faam.faam015 * g_faam.faam152  #累折
            LET g_faam.faam156 = g_faam.faam016 * g_faam.faam152  #本年累折
            LET g_faam.faam157 = g_faam.faam019 * g_faam.faam152  #年折旧额
            LET g_faam.faam158 = g_faam.faam018 * g_faam.faam152  #已提列减值准备
         END IF
         
 
         #小数位数
         #SELECT * INTO g_glaa_t.*  #mark by geza 20161121 #161111-00028#6
         #add by geza 20161121 #161111-00028#6(S)
         SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                glaa028
         
         INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
              g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
              g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
              g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
              g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
              g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
              g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
              g_glaa_t.glaa028
         #add by geza 20161121 #161111-00028#6(E)
         FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
         SELECT ooaj003,ooaj004 INTO l_ooaj003,l_ooaj004 FROM ooaj_t WHERE ooajent = g_enterprise
            AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_faaj[l_cnt].faaj014
         SELECT ooaj004 INTO l_ooaj0042 FROM ooaj_t WHERE ooajent = g_enterprise
            AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa016
         SELECT ooaj004 INTO l_ooaj0043 FROM ooaj_t WHERE ooajent = g_enterprise
            AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa020  
#         LET g_faam.faam012 = s_num_round('1',g_faam.faam012,l_ooaj003)
         LET g_faam.faam013 = s_num_round('1',g_faam.faam013,l_ooaj004) 
         LET g_faam.faam014 = s_num_round('1',g_faam.faam014,l_ooaj004)
         LET g_faam.faam015 = s_num_round('1',g_faam.faam015,l_ooaj004)
         LET g_faam.faam016 = s_num_round('1',g_faam.faam016,l_ooaj004)
         LET g_faam.faam018 = s_num_round('1',g_faam.faam018,l_ooaj004)
         LET g_faam.faam019 = s_num_round('1',g_faam.faam019,l_ooaj004)
         #本位币二
#         #汇率          
#         LET g_faam.faam102 = s_num_round('1',g_faam.faam102,l_ooaj003)
         LET g_faam.faam103 = s_num_round('1',g_faam.faam103,l_ooaj0042)
         LET g_faam.faam104 = s_num_round('1',g_faam.faam104,l_ooaj0042)
         LET g_faam.faam105 = s_num_round('1',g_faam.faam105,l_ooaj0042)
         LET g_faam.faam106 = s_num_round('1',g_faam.faam106,l_ooaj0042)
         LET g_faam.faam107 = s_num_round('1',g_faam.faam107,l_ooaj0042)
         LET g_faam.faam108 = s_num_round('1',g_faam.faam108,l_ooaj0042) 
         #本位币三
#         LET g_faam.faam152 = s_num_round('1',g_faam.faam152,l_ooaj003)
         LET g_faam.faam153 = s_num_round('1',g_faam.faam153,l_ooaj0043)
         LET g_faam.faam154 = s_num_round('1',g_faam.faam154,l_ooaj0043)
         LET g_faam.faam155 = s_num_round('1',g_faam.faam155,l_ooaj0043)
         LET g_faam.faam156 = s_num_round('1',g_faam.faam156,l_ooaj0043)
         LET g_faam.faam157 = s_num_round('1',g_faam.faam157,l_ooaj0043)
         LET g_faam.faam158 = s_num_round('1',g_faam.faam158,l_ooaj0043)
 
         
         INSERT INTO faam_t(  faament,faamsite,faamld,faamcomp,faam000,faam001,
                              faam002,faam003,faam004,faam005,faam006,
                              faam007,faam008,faam009,faam010,faam011,
                              faam012,faam013,faam014,faam015,faam016,
                              faam017,faam018,faam019,faam020,faam021,
                              faam022,faam023,faam024,faam025,faam026,
                              faam027,faam028,faam029,faam030,faam031,
                              faam032,faam033,faam034,faam035,faam036,
                              faam101,faam102,faam103,faam104,faam105,faam106,faam107,faam108,
                              faam151,faam152,faam153,faam154,faam155,faam156,faam157,faam158)  
                       VALUES(g_enterprise,g_glaa_m.faamsite,g_faaj[l_cnt].faajld,g_glaacomp,g_faah[l_cnt].faah001,g_faaj[l_cnt].faaj001,   #1-5
                              g_faaj[l_cnt].faaj002,g_faaj[l_cnt].faaj003,g_glaa_m.year,g_glaa_m.month,'0',    #6-10
                              g_faaj[l_cnt].faaj006,g_faaj[l_cnt].faaj007,l_faam009,l_faam010,g_faaj[l_cnt].faaj014,  #11-15
                              g_faam.faam012,g_faam.faam013,g_faam.faam014,g_faam.faam015,g_faam.faam016,100,g_faam.faam018, #16-22 #20150128 1-->100
                              g_faam.faam019,g_faaj[l_cnt].faaj023,g_faaj[l_cnt].faaj024,g_faaj[l_cnt].faaj025, #23-26，faam019先给0，不做计算，先faam019=g_faaj[l_cnt].faaj022+l_amt
                              g_faaj[l_cnt].faaj026,'','',g_faah[l_cnt].faah015,g_faaj[l_cnt].faajsite,g_faaj[l_cnt].faaj039, #27-32
                              g_faaj[l_cnt].faaj040,g_faaj[l_cnt].faaj041,g_faaj[l_cnt].faaj042,g_faaj[l_cnt].faaj043,  #33-36
                              g_faaj[l_cnt].faaj044,'',g_faaj[l_cnt].faaj045,g_faaj[l_cnt].faaj046,g_faam.faam101,g_faam.faam102,#37-41
                              g_faam.faam103,g_faam.faam104,g_faam.faam105, #42-44
                              g_faam.faam106,g_faam.faam107,g_faam.faam108,g_faam.faam151,g_faam.faam152,g_faam.faam153, #45-51
                              g_faam.faam154,g_faam.faam155,g_faam.faam156,g_faam.faam157,g_faam.faam158)  #52-56
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','ins faam_t',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins faam_t'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_cnt2 = g_cnt2 + 1
            LET g_success='N'
            CONTINUE FOR
         END IF
 
   
        IF g_faaj[l_cnt].faaj006 = '2' THEN
        #-------- 折舊明細檔 SQL (針對多部門分攤折舊金額) ---------------
        #LET g_sql=" SELECT * FROM faam_t WHERE   faam004='",g_glaa_m.year,"'", #mark by geza 2016121 #161111-00028#6
        LET g_sql=" SELECT    faament,faamsite,faamld,faamcomp,faam000,faam001,faam002,faam003,faam004,faam005,
                              faam006,faam007,faam008,faam009,faam010,faam011,faam012,faam013,faam014,faam015,
                              faam016,faam017,faam018,faam019,faam020,faam021,faam022,faam023,faam024,faam025,
                              faam026,faam027,faam028,faam029,faam030,faam031,faam032,faam033,faam034,faam035,
                              faam036,faam037,faam038,faam039,faam040,faam041,faam042,faam043,faam044,faam045,
                              faam046,faam047,faam048,faam049,faam050,faam101,faam102,faam103,faam104,faam105,
                              faam106,faam107,faam108,faam151,faam152,faam153,faam154,faam155,faam156,faam157,
                              faam158 
                              FROM faam_t WHERE   faam004='",g_glaa_m.year,"'", #mark by geza 2016121 #161111-00028#6
                  "                          AND faam005='",g_glaa_m.month,"'",
                  "                          AND faam006='0' AND faam007 = '2'",
                  "                          AND faam001='",g_faaj[l_cnt].faaj001,"'",
                  "                          AND faam002='",g_faaj[l_cnt].faaj002,"'",
                  "                          AND faam000='",g_faaj[l_cnt].faaj037,"'", #20141230 add by chening
                  "                          AND faament='",g_enterprise,"'",
                  "                          AND faamld='",g_glaa_m.glaald,"'"                  
        PREPARE p220_pre1 FROM g_sql
        DECLARE p220_cur1 CURSOR WITH HOLD FOR p220_pre1
        #FOREACH p220_cur1 INTO g_faam1.* #mark by geza 2016121 #161111-00028#6
        #add by geza 2016121 #161111-00028#6(S)
        FOREACH p220_cur1 INTO g_faam1.faament,g_faam1.faamsite,g_faam1.faamld,g_faam1.faamcomp,g_faam1.faam000,g_faam1.faam001,g_faam1.faam002,g_faam1.faam003,g_faam1.faam004,g_faam1.faam005,
                               g_faam1.faam006,g_faam1.faam007, g_faam1.faam008,g_faam1.faam009,g_faam1.faam010,g_faam1.faam011,g_faam1.faam012,g_faam1.faam013,g_faam1.faam014,g_faam1.faam015,
                               g_faam1.faam016,g_faam1.faam017, g_faam1.faam018,g_faam1.faam019,g_faam1.faam020,g_faam1.faam021,g_faam1.faam022,g_faam1.faam023,g_faam1.faam024,g_faam1.faam025,
                               g_faam1.faam026,g_faam1.faam027, g_faam1.faam028,g_faam1.faam029,g_faam1.faam030,g_faam1.faam031,g_faam1.faam032,g_faam1.faam033,g_faam1.faam034,g_faam1.faam035,
                               g_faam1.faam036,g_faam1.faam037, g_faam1.faam038,g_faam1.faam039,g_faam1.faam040,g_faam1.faam041,g_faam1.faam042,g_faam1.faam043,g_faam1.faam044,g_faam1.faam045,
                               g_faam1.faam046,g_faam1.faam047, g_faam1.faam048,g_faam1.faam049,g_faam1.faam050,g_faam1.faam101,g_faam1.faam102,g_faam1.faam103,g_faam1.faam104,g_faam1.faam105,
                               g_faam1.faam106,g_faam1.faam107, g_faam1.faam108,g_faam1.faam151,g_faam1.faam152,g_faam1.faam153,g_faam1.faam154,g_faam1.faam155,g_faam1.faam156,g_faam1.faam157,
                               g_faam1.faam158 
        #add by geza 2016121 #161111-00028#6(E)
           IF STATUS THEN
#              CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','foreach p220_cur1',1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'foreach p220_cur1'
              LET g_errparam.code = STATUS
              LET g_errparam.popup = TRUE
              CALL cl_err()              
              LET g_cnt2 = g_cnt2 + 1
              LET g_success='N'
              CONTINUE FOREACH
           END IF
           #-->讀取分攤方式
           SELECT faaf004 INTO l_faaf004 FROM faaf_t 
             WHERE faafent = g_enterprise AND faafld = g_glaa_m.glaald 
               AND faaf001 = g_glaa_m.year AND faaf002 = g_glaa_m.month
               AND faaf003 = g_faam1.faam008
               AND faafstus = 'Y'
           IF SQLCA.sqlcode THEN
#              CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','afa-00062',1)
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = g_faaj[l_cnt].faaj001
              LET g_errparam.code = 'afa-00062'
              LET g_errparam.popup = TRUE
              CALL cl_err()           
              LET g_cnt2 = g_cnt2 + 1
              LET g_success='N'
              CONTINUE FOREACH
           END IF
           #-->讀取分母
           IF l_faaf004='1' THEN
              SELECT SUM(faag007) INTO l_faag007 FROM faag_t
                WHERE faagent = g_enterprise AND faagld = g_glaa_m.glaald
                  AND faag001 = g_glaa_m.year AND faag002 = g_glaa_m.month
                  AND faag003 = g_faam1.faam008
              IF SQLCA.sqlcode OR cl_null(l_faag007) THEN
#                 CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','afa-00062',1)
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = g_faaj[l_cnt].faaj001
                 LET g_errparam.code = 'afa-00062'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()           
                 LET g_cnt2 = g_cnt2 + 1
                 LET g_success='N'
                 CONTINUE FOREACH
              END IF
              LET m_faag007 = l_faag007           # 分攤比率合計
           END IF
	    
           #-->保留金額以便處理尾差
           #mm_faam*始终作为最开始的总金额
           LET mm_faam013=g_faam1.faam013          # 被分攤金額
           LET mm_faam016=g_faam1.faam016          # 本年累折金額
           LET mm_faam014=g_faam1.faam014          # 被分攤成本
           LET mm_faam015=g_faam1.faam015          # 被分攤累折
           LET mm_faam018=g_faam1.faam018          # 被分攤減值
           LET mm_faam019=g_faam1.faam019
           
           LET g_faam013 =g_faam1.faam013          # 被分攤金額
           LET g_faam016 =g_faam1.faam016          # 本年累折金額
           LET g_faam014 =g_faam1.faam014          # 被分攤成本
           LET g_faam015 =g_faam1.faam015          # 被分攤累折
           LET g_faam018 =g_faam1.faam018          # 被分攤減值
           LET g_faam019 =g_faam1.faam019           
           #m_tot_faam*作为4舍5入后的总金额           
           LET m_tot_faam013 = 0                   # 累计 
           LET m_tot_curr    = 0                   # 累计
           LET m_tot_faam014 = 0                   # 累计
           LET m_tot_faam015 = 0                   # 累计
           LET m_tot_faam018 = 0                   # 累计          
	        LET m_tot_faam019 = 0                   # 累计
	        
           #------- 找 faag_t分攤單身檔 ---------------
           LET m_tot=0
           DECLARE p220_cur2 CURSOR WITH HOLD FOR
           #SELECT * FROM faag_t #mark by geza 2016121 #161111-00028#6
           #add by geza 2016121 #161111-00028#6(S)
           SELECT faagent,faagld,faag001,
                  faag002,faag003,faag004,
                  faag005,faag006,faag007,
                  faag008,faag009,faag010          
           FROM faag_t
           #add by geza 2016121 #161111-00028#6(E)
            WHERE faagent=g_enterprise AND faagld=g_faam1.faamld
              AND faag001=g_faam1.faam004 AND faag002=g_faam1.faam005
              AND faag003=g_faam1.faam008  
           #FOREACH p220_cur2 INTO g_faag.* #mark by geza 2016121 #161111-00028#6
           FOREACH p220_cur2 INTO g_faag.faagent,g_faag.faagld, g_faag.faag001,
                                  g_faag.faag002,g_faag.faag003,g_faag.faag004,
                                  g_faag.faag005,g_faag.faag006,g_faag.faag007,
                                  g_faag.faag008,g_faag.faag009,g_faag.faag010     #add by geza 2016121 #161111-00028#6
              IF SQLCA.sqlcode OR (cl_null(l_faag007) AND l_faaf004='1') THEN
#                 CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','afa-00062',1)
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = g_faaj[l_cnt].faaj001
                 LET g_errparam.code = 'afa-00062'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()           
                 LET g_cnt2 = g_cnt2 + 1
                 LET g_success='N'
                 CONTINUE FOREACH
              END IF
              CASE l_faaf004
                 WHEN '1'
                    LET m_max_ratio = 0    #获取最大分摊率的部门和比率    
                    LET m_max_faag005 =''  
                    LET l_cnt1 = 0
                    SELECT COUNT(*) INTO l_cnt1
                      FROM faam_t
                     WHERE faament = g_enterprise AND faamld=g_faam1.faamld
                       AND faam001=g_faam1.faam001 AND faam002=g_faam1.faam002
                       AND faam000=g_faam1.faam000 #20141230 add by chenying
                       AND faam004=g_faam1.faam004 AND faam005=g_faam1.faam005
                       AND faam009=g_faag.faag005 AND faam007='3'
#                       AND (faam006 = '1' OR faam006='0') #20150127 mark by chenying
                       AND faam006='0'   #20150127 add by chenying 不考虑折旧afap230资料，从afai100抓基础资料                               
               

                    LET mm_ratio   = g_faag.faag007/m_faag007*100       # 分攤比率(存入faam016用)
                    LET m_ratio    = g_faag.faag007/l_faag007*100       # 分攤比率
                    LET m_faam013  = g_faam013*m_ratio/100             # 分攤金額
                    LET m_curr     = g_faam016*m_ratio/100             # 分攤金額
                    LET m_faam014  = g_faam014*m_ratio/100             # 分攤成本
                    LET m_faam015  = g_faam015*m_ratio/100             # 分攤累折
                    LET m_faam018  = g_faam018*m_ratio/100             # 分攤減值
                    LET m_faam019  = g_faam019*m_ratio/100             # 年折舊額 
                    LET l_faag007  = l_faag007 - g_faag.faag007         # 總分攤比率減少
                    LET g_faam013  = g_faam013 - m_faam013
                    LET g_faam016  = g_faam016 - m_curr
                    LET g_faam014  = g_faam014 - m_faam014
                    LET g_faam015  = g_faam015 - m_faam015
                    LET g_faam018  = g_faam018 - m_faam018
                    LET g_faam019  = g_faam019 - m_faam019
                    
                    #记录最大分摊比率的部门，用于尾差处理
                    IF m_ratio > m_max_ratio THEN
                       LET m_max_faag005 = g_faag.faag005
                       LET m_max_ratio = m_ratio
                    END IF        
                    
                    IF l_cnt1 > 0 THEN
                       LET m_faam013 = s_num_round('1',m_faam013,l_ooaj004) 
                       LET m_faam014 = s_num_round('1',m_faam014,l_ooaj004)
                       LET m_faam015 = s_num_round('1',m_faam015,l_ooaj004)
                       LET m_curr    = s_num_round('1',m_curr,l_ooaj004)
                       LET m_faam018 = s_num_round('1',m_faam018,l_ooaj004)
                       LET m_faam019 = s_num_round('1',m_faam019,l_ooaj004)
                       
                       LET m_tot_faam013=m_tot_faam013+m_faam013  
                       LET m_tot_curr   =m_tot_curr   +m_curr  
                       LET m_tot_faam014=m_tot_faam014+m_faam014  
                       LET m_tot_faam015=m_tot_faam015+m_faam015  
                       LET m_tot_faam018=m_tot_faam018+m_faam018
                       
                       UPDATE faam_t SET   faam013 = m_faam013,
                                           faam016 = m_curr,
                                           faam010 = g_faam1.faam009,
                                           faam022 = g_faag.faag006,
                                           faam014 = m_faam014,
                                           faam015 = m_faam015,
                                           faam017 = g_faag.faag007,
                                           faam018 = m_faam018
                                            
                                     WHERE faament = g_enterprise AND faamld=g_faam1.faamld
                                       AND faam001 = g_faam1.faam001 AND faam002=g_faam1.faam002
                                       AND faam000 = g_faam1.faam000 #20141230 add by chening
                                       AND faam004=g_faam1.faam004 AND faam005=g_faam1.faam005
                                       AND faam009=g_faag.faag005 AND faam007='3'  #20150127 mod g_faam1.faam009-->g_faag.faag005 by chenying
#                                       AND (faam006 = '1' OR faam006='0')  #20150127 mark by chenying
                                       AND faam006='0'   #20150127 add by chenying 不考虑折旧afap230资料，从afai100抓基础资料                                        
	    
                       IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
#                          CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','upd faam_t',1)
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.extend = 'UPD faam_t'
                          LET g_errparam.code = SQLCA.SQLCODE
                          LET g_errparam.popup = TRUE
                          CALL cl_err()                          
                          LET g_cnt2 = g_cnt2 + 1
                          LET g_success='N'
                          CONTINUE FOREACH
                       END IF
                    ELSE
                       IF cl_null(g_faag.faag005) THEN
                          LET g_faag.faag005=' '
                       END IF
                       #---本位币二---
                       IF g_glaa015 = 'Y' THEN
                          LET g_faam1.faam103 = m_faam014 * g_faam.faam102  #成本
                          LET g_faam1.faam104 = m_faam013 * g_faam.faam102  #折旧金额
                          LET g_faam1.faam105 = m_faam015 * g_faam.faam102  #累折
                          LET g_faam1.faam106 = m_curr * g_faam.faam102     #本年累折
                          LET g_faam1.faam107 = m_faam019 * g_faam.faam102  #年折旧额
                          LET g_faam1.faam108 = m_faam018 * g_faam.faam102  #已提列减值准备
                       END IF
                       #---本位币三---
                       IF g_glaa019 = 'Y' THEN
                          LET g_faam1.faam153 = m_faam014 * g_faam.faam152  #成本
                          LET g_faam1.faam154 = m_faam013 * g_faam.faam152  #折旧金额
                          LET g_faam1.faam155 = m_faam015 * g_faam.faam152  #累折
                          LET g_faam1.faam156 = m_curr * g_faam.faam152     #本年累折
                          LET g_faam1.faam157 = m_faam019 * g_faam.faam152  #年折旧额
                          LET g_faam1.faam158 = m_faam018 * g_faam.faam152  #已提列减值准备
                       END IF
 
                       #小数位数
                       #SELECT * INTO g_glaa_t.*  #mark by geza 20161121 #161111-00028#6
                       #add by geza 20161121 #161111-00028#6(S)
                       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                              glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                              glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                              glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                              glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                              glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                              glaa028
                       
                       INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                            g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                            g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                            g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                            g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                            g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                            g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                            g_glaa_t.glaa028
                       #add by geza 20161121 #161111-00028#6(E)                       
                       FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
                       SELECT ooaj003,ooaj004 INTO l_ooaj003,l_ooaj004 FROM ooaj_t WHERE ooajent = g_enterprise
                          AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_faaj[l_cnt].faaj014
                       SELECT ooaj004 INTO l_ooaj0042 FROM ooaj_t WHERE ooajent = g_enterprise
                          AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa016
                       SELECT ooaj004 INTO l_ooaj0043 FROM ooaj_t WHERE ooajent = g_enterprise
                          AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa020 
                          
                       #本位币
                       LET g_faam1.faam012 = g_faaj[l_cnt].faaj015
                       LET g_faam1.faam013 = m_faam013
                       LET g_faam1.faam014 = m_faam014
                       LET g_faam1.faam015 = m_faam015
                       LET g_faam1.faam016 = m_curr
                       LET g_faam1.faam018 = m_faam018  
                       LET g_faam1.faam019 = 0
#                       #汇率            
#                       LET g_faam1.faam012 =  s_num_round('1',g_faam1.faam012,l_ooaj003)
                       LET g_faam1.faam013 =  s_num_round('1',g_faam1.faam013,l_ooaj004) 
                       LET g_faam1.faam014 =  s_num_round('1',g_faam1.faam014,l_ooaj004)
                       LET g_faam1.faam015 =  s_num_round('1',g_faam1.faam015,l_ooaj004)
                       LET g_faam1.faam016 =  s_num_round('1',g_faam1.faam016,l_ooaj004)
                       LET g_faam1.faam018 =  s_num_round('1',g_faam1.faam018,l_ooaj004)
                       LET g_faam1.faam019 =  s_num_round('1',g_faam1.faam019,l_ooaj004)
                       #本位币二
                       #汇率          
#                       LET g_faam1.faam102 =  s_num_round('1',g_faam1.faam102,l_ooaj003)
                       LET g_faam1.faam103 =  s_num_round('1',g_faam1.faam103,l_ooaj0042)
                       LET g_faam1.faam104 =  s_num_round('1',g_faam1.faam104,l_ooaj0042)
                       LET g_faam1.faam105 =  s_num_round('1',g_faam1.faam105,l_ooaj0042)
                       LET g_faam1.faam106 =  s_num_round('1',g_faam1.faam106,l_ooaj0042)
                       LET g_faam1.faam107 =  s_num_round('1',g_faam1.faam107,l_ooaj0042)
                       LET g_faam1.faam108 =  s_num_round('1',g_faam1.faam108,l_ooaj0042) 
                       #本位币三
#                       LET g_faam1.faam152 =  s_num_round('1',g_faam1.faam152,l_ooaj003)
                       LET g_faam1.faam153 =  s_num_round('1',g_faam1.faam153,l_ooaj0043)
                       LET g_faam1.faam154 =  s_num_round('1',g_faam1.faam154,l_ooaj0043)
                       LET g_faam1.faam155 =  s_num_round('1',g_faam1.faam155,l_ooaj0043)
                       LET g_faam1.faam156 =  s_num_round('1',g_faam1.faam156,l_ooaj0043)
                       LET g_faam1.faam157 =  s_num_round('1',g_faam1.faam157,l_ooaj0043)
                       LET g_faam1.faam158 =  s_num_round('1',g_faam1.faam158,l_ooaj0043)
 
                       LET m_tot_faam013=m_tot_faam013+g_faam1.faam013
                       LET m_tot_curr   =m_tot_curr   +g_faam1.faam016  
                       LET m_tot_faam014=m_tot_faam014+g_faam1.faam014  
                       LET m_tot_faam015=m_tot_faam015+g_faam1.faam015  
                       LET m_tot_faam018=m_tot_faam018+g_faam1.faam018
                       
                       INSERT INTO faam_t(faament,faamsite,faamld,faamcomp,faam000,faam001,
                              faam002,faam003,faam004,faam005,faam006,
                              faam007,faam008,faam009,faam010,faam011,
                              faam012,faam013,faam014,faam015,faam016,
                              faam017,faam018,faam019,faam020,faam021,faam022,faam023,faam024,faam025,faam026,
                              faam027,faam028,faam029,faam030,faam031,faam032,faam033,faam034,faam035,faam036,
                              faam101,faam102,faam103,faam104,faam105,faam106,faam107,faam108,
                              faam151,faam152,faam153,faam154,faam155,faam156,faam157,faam158)  
                       VALUES(g_enterprise,g_glaa_m.faamsite,g_faaj[l_cnt].faajld,g_glaacomp,g_faah[l_cnt].faah001,g_faaj[l_cnt].faaj001,
                              g_faaj[l_cnt].faaj002,g_faaj[l_cnt].faaj003,g_glaa_m.year,g_glaa_m.month,'0',  #1-10
                              '3',g_faaj[l_cnt].faaj007,g_faag.faag005,g_faam1.faam009,g_faaj[l_cnt].faaj014,  #11~15
                              g_faam1.faam012,g_faam1.faam013,g_faam1.faam014,g_faam1.faam015,g_faam1.faam016,g_faag.faag007,g_faam1.faam018, #16~22 #20150128 g_faag.faag007/100-->g_faag.faag007 
                              g_faam1.faam019,g_faam1.faam020,g_faam1.faam021,g_faag.faag006,  #19~22，faam019先给0，不做计算，先faam019=g_faaj[l_cnt].faaj022+m_faam013
                              g_faaj[l_cnt].faaj026,'','',g_faah[l_cnt].faah015,g_faaj[l_cnt].faajsite,g_faaj[l_cnt].faaj039,
                              g_faaj[l_cnt].faaj040,g_faaj[l_cnt].faaj041,g_faaj[l_cnt].faaj042,g_faaj[l_cnt].faaj043,
                              g_faaj[l_cnt].faaj044,'',g_faaj[l_cnt].faaj045,g_faaj[l_cnt].faaj046,
                              g_faam1.faam101,g_faam1.faam102,
                              g_faam1.faam103,g_faam1.faam104,g_faam1.faam105, 
                              g_faam1.faam106,g_faam1.faam107,g_faam1.faam108,g_faam1.faam151,g_faam1.faam152,g_faam1.faam153, 
                              g_faam1.faam154,g_faam1.faam155,g_faam1.faam156,g_faam1.faam157,g_faam1.faam158)                              
                       IF STATUS THEN
#                          CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','ins faam_t',1)
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = 'ins faam_t'
                           LET g_errparam.code = SQLCA.SQLCODE
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                          LET g_cnt2 = g_cnt2 + 1
                          LET g_success='N'
                          CONTINUE FOREACH
                       END IF
                    END IF
# dennon lai 01/04/18 本期累折=今年度本期折舊(fan07)的加總
#                       累積折舊=全期本期折舊(fan07)的加總
               #No.3426 010824 modify 若用上述方法在年中導入時折舊會少
                  #例7月導入,fan 6月資料,本月折舊fan07=6月折舊金額, 故用
                  #select sum(fan07)的方法會少1-5 月的折舊金額
                  #故改成抓前一期累折+本月的折舊
                       IF g_faam1.faam005=1 THEN
                          LET p_yy = g_faam1.faam004-1
                          LET p_mm=12
                       ELSE
                          LET p_yy = g_faam1.faam004
                          LET p_mm=g_faam1.faam005-1
                       END IF
                        LET p_faam016=0  LET p_faam015=0
                        SELECT SUM(faam016),SUM(faam015) INTO p_faam016,p_faam015
                          FROM faam_t
                         WHERE faament = g_enterprise AND faamld=g_faam1.faamld
                           AND faam001=g_faam1.faam001 AND faam002=g_faam1.faam002
                           AND faam000=g_faam1.faam000 #20141230 add by chenying
                           AND faam004=p_yy AND faam005=p_mm
                           AND faam009=g_faag.faag005 AND faam007='3'
                           AND (faam006 = '1' OR faam006='0')
                       IF SQLCA.SQLCODE THEN
                          LET p_faam016=0   LET p_faam015=0
                       END IF
                       IF cl_null(p_faam016) THEN
                          LET p_faam016=0
                       END IF
                       IF cl_null(p_faam015) THEN
                          LET p_faam015=0
                       END IF
                       IF g_faam.faam005 = 1 THEN
                          LET p_faam016= 0
                       END IF
                       LET p_faam016_1=0  LET p_faam015_1=0
                       SELECT SUM(faam013),SUM(faam013) INTO p_faam016_1,p_faam015_1 
                      #SELECT SUM(faam016),SUM(faam015) INTO p_faam016_1,p_faam015_1                       
                         FROM faam_t
                        WHERE faament = g_enterprise AND faamld=g_faam1.faamld
                           AND faam001=g_faam1.faam001 AND faam002=g_faam1.faam002
                           AND faam000=g_faam1.faam000 #20141230 add by chenying
                           AND faam004=p_yy AND faam005=p_mm
                           AND faam009=g_faag.faag005 AND faam007='3'
                           AND faam006 = '2'
                       IF SQLCA.SQLCODE THEN
                          LET p_faam016_1=0   LET p_faam015_1=0
                       END IF
                       IF cl_null(p_faam016_1) THEN LET p_faam016_1=0 END IF
                       IF cl_null(p_faam015_1) THEN LET p_faam015_1=0 END IF
                       IF g_faam.faam005 = 1 THEN LET p_faam016_1 = 0 END IF
                       LET g_faam013_year = p_faam016 +m_faam013 + p_faam016_1
                       LET g_faam013_all  = p_faam015 +m_faam013 + p_faam015_1
#分摊前已经算上当期的本月折旧了,分摊后数据不用再考虑，直接按比率计算
#                       SELECT COUNT(*) INTO g_cnt FROM faam_t
#                        WHERE faament = g_enterprise AND faamld=g_faam1.faamld
#                          AND faam001=g_faam1.faam001 AND faam002=g_faam1.faam002
#                          AND faam004=g_faam1.faam004 AND faam005=g_faam1.faam005
#                          AND faam009=g_faag.faag005 AND faam007='3'
#                          AND faam006 = '0' #1201
#                       IF g_cnt>0 THEN
#                          LET g_faam013_year = s_num_round('1',g_faam013_year,l_ooaj004) #20141106 add
#                          LET g_faam013_all  = s_num_round('1',g_faam013_all,l_ooaj004) #20141106 add
#                          UPDATE faam_t SET faam016=g_faam013_year,faam015=g_faam013_all
#                           WHERE faament = g_enterprise AND faamld=g_faam1.faamld
#                             AND faam001=g_faam1.faam001 AND faam002=g_faam1.faam002
#                             AND faam004=g_faam1.faam004 AND faam005=g_faam1.faam005
#                             AND faam009=g_faag.faag005 AND faam007='3'
#                             AND faam006 = '0' #1201
#                          IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#                             CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','upd faam_t',1)
#                             LET g_cnt2 = g_cnt2 + 1
#                             LET g_success='N'
#                             CONTINUE FOREACH
#                          END IF
#                       END IF
                    WHEN '2'
                       LET l_glac007 = ''
                       SELECT glac007 INTO l_glac007 FROM glac_t
                        WHERE glacent = g_enterprise AND glac001=g_glaa004
                          AND glac002 = g_faag.faag009
                       IF l_glac007='1' THEN
                          SELECT SUM(glar005-glar006) INTO m_glar FROM glar_t
                           WHERE glarent =g_enterprise AND glarld=g_glaa_m.glaald
                             AND glar001 =g_faag.faag009 AND glar002=g_glaa_m.year
                             AND glar003 <=g_glaa_m.month
                       ELSE
                          SELECT glar005-glar006 INTO m_glar FROM glar_t
                           WHERE glarent =g_enterprise AND glarld=g_glaa_m.glaald
                             AND glar001 =g_faag.faag009 AND glar002=g_glaa_m.year
                             AND glar003 =g_glaa_m.month
                       END IF  
                       IF STATUS=100 OR m_glar IS NULL THEN LET m_glar=0 END IF
                       LET m_tot=m_tot+m_glar          ## 累加變動比率分母金額
                    END CASE
              END FOREACH 
              
                 IF l_faaf004 = '2' THEN           
                    LET m_max_ratio = 0         
                    LET m_max_faag005 =''
                    LET l_glac007 = '' 
                    SELECT glac007 INTO l_glac007 FROM glac_t
                     WHERE glacent = g_enterprise AND glac001=g_glaa004
                       AND glac002 = g_faag.faag009
                       
                    LET g_faam013=g_faam1.faam013          # 被分攤金額
                    LET g_faam014=g_faam1.faam014          # 被分攤成本
                    LET g_faam015=g_faam1.faam015          # 被分攤累折
                    LET g_faam018=g_faam1.faam018          # 被分攤減值 
                    
                    FOREACH p220_cur2 INTO g_faag.*                       
                       IF l_glac007='1' THEN
                          SELECT SUM(glar005-glar006) INTO m_glar FROM glar_t
                           WHERE glarent =g_enterprise AND glarld=g_glaa_m.glaald
                             AND glar001 =g_faag.faag009 AND glar002=g_glaa_m.year
                             AND glar003 <=g_glaa_m.month
                       ELSE
                          SELECT glar005-glar006 INTO m_glar FROM glar_t
                           WHERE glarent =g_enterprise AND glarld=g_glaa_m.glaald
                             AND glar001 =g_faag.faag009 AND glar002=g_glaa_m.year
                             AND glar003 =g_glaa_m.month
                       END IF  
                       IF STATUS=100 OR m_glar IS NULL THEN
                          LET m_glar=0
                       END IF
                       SELECT SUM(faam013) INTO y_curr FROM faam_t
                        WHERE faament = g_enterprise AND faamld = g_glaa_m.glaald
                          AND faam001 = g_faam1.faam001 AND faam002 = g_faam1.faam002
                          AND faam000 = g_faam1.faam000 #20141230 add by chenying
                          AND faam004 = g_glaa_m.year AND faam005 < g_glaa_m.month
                          AND faam009 = g_faag.faag005 AND faam007 = '3'
			       
                       IF cl_null(y_curr) THEN
                          LET y_curr = 0
                       END IF
                       LET m_ratio = m_glar/m_tot*100
                       IF m_ratio > m_max_ratio THEN
                          LET m_max_faag005 = g_faag.faag005
                          LET m_max_ratio = m_ratio
                       END IF
                       IF cl_null(g_faaj[l_cnt].faaj017) THEN LET g_faaj[l_cnt].faaj017 = 0 END IF
                       IF cl_null(g_faaj[l_cnt].faaj018) THEN LET g_faaj[l_cnt].faaj018 = 0 END IF

                       LET m_faam013 = g_faam013*m_ratio/100  #折旧金额
                       LET m_curr    = y_curr + m_faam013     #本年累折
                       LET m_faam014 = g_faam014*m_ratio/100  #成本
                       LET m_faam015 = g_faam015*m_ratio/100  #累折
                       LET m_faam018 = g_faam018*m_ratio/100  #已提列减值准备    
                       LET m_faam019=g_faam1.faam019*m_ratio/100
                       LET m_tot_faam013=m_tot_faam013+m_faam013
                       LET m_tot_curr =m_tot_curr +m_curr
                       LET m_tot_faam014=m_tot_faam014+m_faam014
                       LET m_tot_faam015=m_tot_faam015+m_faam015
                       LET m_tot_faam018=m_tot_faam018+m_faam018
                       LET m_tot_faam019=m_tot_faam019+m_faam019
                       SELECT COUNT(*) INTO g_cnt FROM faam_t
                        WHERE faament = g_enterprise AND faamld = g_glaa_m.glaald
                          AND faam001 = g_faam1.faam001 AND faam002 = g_faam1.faam002
                          AND faam000 = g_faam1.faam000 #20141230 add by chenying
                          AND faam004 = g_glaa_m.year AND faam005 < g_glaa_m.month
                          AND faam009 = g_faag.faag005 AND faam007 = '3'
                          AND faam006 = '2'
                       IF g_cnt>0 THEN
                           
                          LET m_faam013 =  s_num_round('1',m_faam013,l_ooaj004) 
                          LET m_curr    =  s_num_round('1',m_curr,l_ooaj004)
                          LET m_faam018 =  s_num_round('1',m_faam018,l_ooaj004)
                          
                      
                          UPDATE faam_t SET faam013 = m_faam013,
                                            faam016 = m_curr,
                                            faam010 = g_faam1.faam010,
                                            faam022 = g_faag.faag006,
                                            faam017 = m_ratio,
                                            faam018 = m_faam018
                           WHERE faament = g_enterprise AND faamld = g_glaa_m.glaald
                             AND faam001 = g_faam1.faam001 AND faam002 = g_faam1.faam002
                             AND faam000 = g_faam1.faam000 #20141230 add by chenying
                             AND faam004 = g_glaa_m.year AND faam005 < g_glaa_m.month
                             AND faam009 = g_faag.faag005 AND faam007 = '3'
                             AND faam006 = '2'
                          IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
#                             CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','upd faam_t',1)
                             INITIALIZE g_errparam TO NULL
                             LET g_errparam.extend = 'UPD faam_t'
                             LET g_errparam.code = SQLCA.SQLCODE
                             LET g_errparam.popup = TRUE
                             CALL cl_err()
                             LET g_cnt2 = g_cnt2 + 1
                             LET g_success='N'
                             CONTINUE FOREACH
                          END IF
                       ELSE
                          IF cl_null(g_faag.faag005) THEN
                             LET g_faag.faag005=' '
                          END IF
                          #---本位币二---
                          IF g_glaa015 = 'Y' THEN
                             LET g_faam1.faam103 = m_faam014 * g_faam.faam102  #成本
                             LET g_faam1.faam104 = m_faam013 * g_faam.faam102  #折旧金额
                             LET g_faam1.faam105 = m_faam015 * g_faam.faam102  #累折
                             LET g_faam1.faam106 = m_curr * g_faam.faam102  #本年累折
                             LET g_faam1.faam107 = m_faam019 * g_faam.faam102  #年折旧额
                             LET g_faam1.faam108 = m_faam018 * g_faam.faam102  #已提列减值准备
                          END IF
                          #---本位币三---
                          IF g_glaa019 = 'Y' THEN
                             LET g_faam1.faam153 = m_faam014 * g_faam.faam152  #成本
                             LET g_faam1.faam154 = m_faam013 * g_faam.faam152  #折旧金额
                             LET g_faam1.faam155 = m_faam015 * g_faam.faam152  #累折
                             LET g_faam1.faam156 = m_curr * g_faam.faam152  #本年累折
                             LET g_faam1.faam157 = m_faam019 * g_faam.faam152  #年折旧额
                             LET g_faam1.faam158 = m_faam018 * g_faam.faam152  #已提列减值准备
                          END IF
                          
                           
                          #小数位数
                          #SELECT * INTO g_glaa_t.* #mark by geza 20161121 #161111-00028#6
                          #add by geza 20161121 #161111-00028#6(S)
                          SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                                 glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                                 glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                                 glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                                 glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                                 glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                                 glaa028
                          
                          INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                               g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                               g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                               g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                               g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                               g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                               g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                               g_glaa_t.glaa028
                          #add by geza 20161121 #161111-00028#6(E)   
                          FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
                          SELECT ooaj003,ooaj004 INTO l_ooaj003,l_ooaj004 FROM ooaj_t WHERE ooajent = g_enterprise
                             AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_faaj[l_cnt].faaj014
                          SELECT ooaj004 INTO l_ooaj0042 FROM ooaj_t WHERE ooajent = g_enterprise
                             AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa016
                          SELECT ooaj004 INTO l_ooaj0043 FROM ooaj_t WHERE ooajent = g_enterprise
                             AND ooaj001 = g_glaa_t.glaa026 AND ooaj002 = g_glaa_t.glaa020 
                             
                          #本位币
                          LET g_faam1.faam012 = g_faaj[l_cnt].faaj015
                          LET g_faam1.faam013 = m_faam013
                          LET g_faam1.faam014 = m_faam014
                          LET g_faam1.faam015 = m_faam015
                          LET g_faam1.faam016 = m_curr
                          LET g_faam1.faam018 = m_faam018  
                          LET g_faam1.faam019 = 0
#                          #汇率            
#                          LET g_faam1.faam012 = s_num_round('1',g_faam1.faam012,l_ooaj003)
                          LET g_faam1.faam013 = s_num_round('1',g_faam1.faam013,l_ooaj004) 
                          LET g_faam1.faam014 = s_num_round('1',g_faam1.faam014,l_ooaj004)
                          LET g_faam1.faam015 = s_num_round('1',g_faam1.faam015,l_ooaj004)
                          LET g_faam1.faam016 = s_num_round('1',g_faam1.faam016,l_ooaj004)
                          LET g_faam1.faam018 = s_num_round('1',g_faam1.faam018,l_ooaj004)
                          LET g_faam1.faam019 = s_num_round('1',g_faam1.faam019,l_ooaj004)
                          #本位币二
                          #汇率          
#                          LET g_faam1.faam102 = s_num_round('1',g_faam1.faam102,l_ooaj003)
                          LET g_faam1.faam103 = s_num_round('1',g_faam1.faam103,l_ooaj0042)
                          LET g_faam1.faam104 = s_num_round('1',g_faam1.faam104,l_ooaj0042)
                          LET g_faam1.faam105 = s_num_round('1',g_faam1.faam105,l_ooaj0042)
                          LET g_faam1.faam106 = s_num_round('1',g_faam1.faam106,l_ooaj0042)
                          LET g_faam1.faam107 = s_num_round('1',g_faam1.faam107,l_ooaj0042)
                          LET g_faam1.faam108 = s_num_round('1',g_faam1.faam108,l_ooaj0042) 
                          #本位币三
#                          LET g_faam1.faam152 = s_num_round('1',g_faam1.faam152,l_ooaj003)
                          LET g_faam1.faam153 = s_num_round('1',g_faam1.faam153,l_ooaj0043)
                          LET g_faam1.faam154 = s_num_round('1',g_faam1.faam154,l_ooaj0043)
                          LET g_faam1.faam155 = s_num_round('1',g_faam1.faam155,l_ooaj0043)
                          LET g_faam1.faam156 = s_num_round('1',g_faam1.faam156,l_ooaj0043)
                          LET g_faam1.faam157 = s_num_round('1',g_faam1.faam157,l_ooaj0043)
                          LET g_faam1.faam158 = s_num_round('1',g_faam1.faam158,l_ooaj0043)
                           
                       
                          INSERT INTO faam_t(faament,faamsite,faamld,faamcomp,faam000,faam001,faam002,faam003,faam004,faam005,faam006,
                                            faam007,faam008,faam009,faam010,faam011,faam012,faam013,faam014,faam015,faam016,
                                            faam017,faam018,faam019,faam020,faam021,faam022,faam023,faam024,faam025,faam026,
                                            faam027,faam028,faam029,faam030,faam031,faam032,faam033,faam034,faam035,faam036,
                                            faam101,faam102,faam103,faam104,faam105,faam106,faam107,faam108,
                                            faam151,faam152,faam153,faam154,faam155,faam156,faam157,faam158)  
                                VALUES(g_enterprise,g_glaa_m.faamsite,g_faaj[l_cnt].faajld,g_glaacomp,g_faah[l_cnt].faah001,g_faaj[l_cnt].faaj001,
                                       g_faaj[l_cnt].faaj002,g_faaj[l_cnt].faaj003,g_glaa_m.year,g_glaa_m.month,'0',  #1-6
                                       '3',g_faaj[l_cnt].faaj007,g_faag.faag005,g_faam1.faam009,g_faaj[l_cnt].faaj014,  #7~11
                                       g_faam1.faam012,g_faam1.faam013,g_faam1.faam014,g_faam1.faam015,g_faam1.faam016,m_ratio,g_faam1.faam018, #12~18
                                       g_faam1.faam019,g_faam1.faam020,g_faam1.faam021,g_faag.faag006,  #19~22，faam019先给0，不做计算，先faam019=g_faaj[l_cnt].faaj022+m_faam013
                                       g_faaj[l_cnt].faaj026,'','',g_faah[l_cnt].faah015,g_faaj[l_cnt].faajsite,g_faaj[l_cnt].faaj039,
                                       g_faaj[l_cnt].faaj040,g_faaj[l_cnt].faaj041,g_faaj[l_cnt].faaj042,g_faaj[l_cnt].faaj043,
                                       g_faaj[l_cnt].faaj044,'',g_faaj[l_cnt].faaj045,g_faaj[l_cnt].faaj046,
                                       g_faam1.faam101,g_faam1.faam102,
                                       g_faam1.faam103,g_faam1.faam104,g_faam1.faam105, 
                                       g_faam1.faam106,g_faam1.faam107,g_faam1.faam108,g_faam1.faam151,g_faam1.faam152,g_faam1.faam153, 
                                       g_faam1.faam154,g_faam1.faam155,g_faam1.faam156,g_faam1.faam157,g_faam1.faam158)        
                          IF STATUS THEN
#                             CALL cl_errmsg('faaj001',g_faaj[l_cnt].faaj001,'','ins faam_t',1)
#                             LET g_cnt2 = g_cnt2 + 1
#                             LET g_success='N'
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.extend = 'INSERT faam_t'
                              LET g_errparam.code = SQLCA.SQLCODE
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_success = 'N' 
                             LET g_cnt2 = g_cnt2 + 1
                             CONTINUE FOREACH
                          END IF
                       END IF 
                    END FOREACH
                    IF cl_null(m_max_faag005) THEN LET m_max_faag005 = g_faag.faag005 END IF
                 END IF
          IF l_faaf004 = '2' OR l_faaf004 = '1' THEN  
             IF m_tot_faam013!=mm_faam013 OR m_tot_curr!=m_curr OR
                m_tot_faam014!=mm_faam014 OR m_tot_faam015!=mm_faam015 THEN

                LET m_faag005 = m_max_faag005
                SELECT faam013,faam016 INTO l_faam013,l_faam016 FROM faam_t
                 WHERE faament = g_enterprise AND faamld = g_glaa_m.glaald
                   AND faam001 = g_faam1.faam001 AND faam002 = g_faam1.faam002
                   AND faam000 = g_faam1.faam000 #20141230 add by chenying
                   AND faam004 = g_glaa_m.year AND faam005 = g_glaa_m.month
                   AND faam009 = m_faag005 AND faam007 = '3'
                   AND faam006 = '0' #20150127 
                LET l_diff = mm_faam013 - m_tot_faam013
                IF l_diff < 0 THEN
                   LET l_diff = l_diff * -1
                   IF l_faam013 < l_diff THEN
                      LET l_diff = 0
                   ELSE
                      LET l_diff = l_diff * -1
                   END IF
                END IF
                IF cl_null(m_tot_curr) THEN
                   LET m_tot_curr=0
                END IF
                LET l_diff2 = mm_faam016 - m_tot_curr
                IF l_diff2 < 0 THEN
                   LET l_diff2 = l_diff2 * -1
                   IF l_faam016 < l_diff2 THEN
                      LET l_diff2 = 0
                   ELSE
                      LET l_diff2 = l_diff2 * -1
                   END IF
                END IF
 
 
                UPDATE faam_t SET faam013=faam013+l_diff, 
                                  faam016=faam016+l_diff2,
                                  faam014=faam014+mm_faam014-m_tot_faam014, 
                                  faam015=faam015+mm_faam015-m_tot_faam015, 
                                  faam018=faam018+mm_faam018-m_tot_faam018 
                                   
                 WHERE faament = g_enterprise AND faamld = g_glaa_m.glaald
                   AND faam001 = g_faam1.faam001 AND faam002 = g_faam1.faam002
                   AND faam000 = g_faam1.faam000 #20141230 add by chening
                   AND faam004 = g_glaa_m.year AND faam005 = g_glaa_m.month
                   AND faam009 = m_faag005 AND faam007 = '3'
                   AND faam006 = '0' #20150127
                IF STATUS OR SQLCA.sqlerrd[3]=0  THEN
#                     LET g_success='N'
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = "lib-00101"
#                     LET g_errparam.popup = TRUE
#                     LET g_errparam.replace[1] = g_faaj[l_cnt].faaj001
#                     LET g_errparam.replace[2] ="faam_t"
#                     LET g_errparam.extend = "upd faam_t"
#                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
#                     CALL cl_err()
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = "upd faam_t"
                      LET g_errparam.code = 'lib-00101'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_success = 'N' 
                END IF
             END IF
             LET m_tot_faam013=0
             LET m_tot_faam014=0
             LET m_tot_faam015=0
             LET m_tot_faam018=0
             LET m_tot_curr =0
             LET m_tot=0
            END IF 
            END FOREACH 
         END IF
      ELSE
         CONTINUE FOR
      END IF
   END FOR
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
#   CALL cl_err_showmsg()
   CALL cl_err_collect_show()  #显示错误讯息汇总
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_ui_dialog_1()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   DEFINE l_origin_str STRING
   DEFINE g_bookno     LIKE glaa_t.glaald
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.chr1
   
   WHILE TRUE
      #add-point:ui_dialog段before dialog2

      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_glaa_m.faamsite,g_glaa_m.glaald,g_glaa_m.year,g_glaa_m.month
       
      
         BEFORE INPUT 
            LET g_sub_success = FALSE
            CALL s_afat503_default(g_bookno) RETURNING l_success,g_glaa_m.faamsite,g_glaa_m.glaald,g_glaa_m.glaacomp
            CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING  g_glaa_m.faamsite_desc
            
            CALL afap220_glaald_desc()   #帳套說明、法人說明、幣別+幣別說明

            CALL cl_get_para(g_enterprise,g_glaa_m.faamsite,'S-FIN-9018') RETURNING g_glaa_m.year
            CALL cl_get_para(g_enterprise,g_glaa_m.faamsite,'S-FIN-9019') RETURNING g_glaa_m.month
            DISPLAY BY NAME g_glaa_m.year,g_glaa_m.month,g_glaa_m.faamsite_desc

         BEFORE FIELD faamsite
            LET g_glaa_m_t.faamsite = g_glaa_m.faamsite
            
         AFTER FIELD faamsite
            IF NOT cl_null(g_glaa_m.faamsite) THEN
               
               #检查组织资料的合理性             
               IF NOT s_afat502_site_chk(g_glaa_m.faamsite) THEN
                  LET g_glaa_m.faamsite = g_glaa_m_t.faamsite
                  CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING  g_glaa_m.faamsite_desc
                  DISPLAY BY NAME g_glaa_m.faamsite_desc
                  NEXT FIELD CURRENT
               END IF  
               
               #user需要檢查和資產中心的權限
               IF NOT afap220_faamsite_user_chk(g_glaa_m.faamsite) THEN
                  LET g_glaa_m.faamsite = g_glaa_m_t.faamsite
                  CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING g_glaa_m.faamsite_desc
                  DISPLAY BY NAME g_glaa_m.faamsite_desc
                  NEXT FIELD CURRENT  
               END IF
                   
               
               #帐套不为空检查法人归属是否相同
               IF NOT cl_null(g_glaa_m.glaald) THEN
                  IF NOT s_afat502_site_ld_chk(g_glaa_m.faamsite,g_glaa_m.glaald) THEN
                     LET g_glaa_m.faamsite = g_glaa_m_t.faamsite
                     CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING g_glaa_m.faamsite_desc
                     DISPLAY BY NAME g_glaa_m.faamsite_desc
                     NEXT FIELD CURRENT  
                  END IF
               END IF  
               #20150120 add by chenying               
               IF NOT cl_null(g_glaa_m.glaald) THEN                
                  #SELECT * INTO g_glaa_t.* #mark by geza 20161121 #161111-00028#6
                  #add by geza 20161121 #161111-00028#6(S)
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                         glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                         glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                         glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                         glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                         glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                         glaa028
                  
                  INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                       g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                       g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                       g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                       g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                       g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                       g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                       g_glaa_t.glaa028
                  #add by geza 20161121 #161111-00028#6(E)   
                  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald  
                  LET g_glaa_m.glaacomp = g_glaa_t.glaacomp                  
                  CALL afap220_glaald_desc()   
               END IF 
               #20150120 add by chenying               
         END IF       
         
         BEFORE FIELD glaald
            LET g_glaa_m_t.glaald = g_glaa_m.glaald
          
         AFTER FIELD glaald
        
            IF NOT cl_null(g_glaa_m.glaald) THEN
                
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_glaa_m.glaald
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#5--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
               
               ELSE
                  LET g_glaa_m.glaald = g_glaa_m_t.glaald
                  CALL afap220_glaald_desc()                
               END IF               
            
               IF NOT s_ld_chk_authorization(g_user,g_glaa_m.glaald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_glaa_m.glaald
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glaa_m.glaald = g_glaa_m_t.glaald
                  CALL afap220_glaald_desc() 
                  NEXT FIELD CURRENT
               END IF
               
               #资产中心不为空时
               IF NOT cl_null(g_glaa_m.faamsite) THEN
                  IF NOT s_afat502_site_ld_chk(g_glaa_m.faamsite,g_glaa_m.glaald) THEN
                     LET g_glaa_m.glaald = g_glaa_m_t.glaald
                     CALL afap220_glaald_desc()
                     DISPLAY BY NAME g_glaa_m.glaald_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #SELECT * INTO g_glaa_t.* #mark by geza 20161121 #161111-00028#6
               #add by geza 20161121 #161111-00028#6(S)
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                      glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                      glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                      glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                      glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                      glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                      glaa028
               
               INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                    g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                    g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                    g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                    g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                    g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                    g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                    g_glaa_t.glaa028
               #add by geza 20161121 #161111-00028#6(E)   
               
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald #20141106 add
               LET g_glaa_m.glaacomp = g_glaa_t.glaacomp  #20150120 add by chenying
               CALL afap220_glaald_desc()      
                                 
            END IF            


         ON ACTION controlp INFIELD faamsite
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.faamsite             #給予default值
            
            #160125-00005#7--add--str--
            IF NOT cl_null(g_wc_cs_orga) THEN
			      LET g_qryparam.where = g_wc_cs_orga
			   END IF
			   #160125-00005#7--add--end
			   
            LET g_qryparam.where = " ooef207 = 'Y' "
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_glaa_m.faamsite = g_qryparam.return1              

            DISPLAY g_glaa_m.faamsite TO faamsite              #
            CALL afap220_faamsite_desc(g_glaa_m.faamsite) RETURNING g_glaa_m.faamsite_desc
            DISPLAY BY NAME g_glaa_m.faamsite_desc
            NEXT FIELD faamsite                          #返回原欄位
          
          ON ACTION controlp INFIELD glaald
	  	     #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaald             #給予default值

            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_glaa_m.faamsite,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL afap220_change_to_sql(l_origin_str) RETURNING l_origin_str  
            LET l_origin_str=l_origin_str.substring(2,l_origin_str.getLength()-1) #160125-00005#7 add             
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )" #160125-00005#7 mark
            LET g_qryparam.where = "  (glaa008 = 'Y' OR glaa014 = 'Y') " #160125-00005#7 add
            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            #160125-00005#7--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING g_wc_cs_ld
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_qryparam.where," AND ",g_wc_cs_ld
            END IF
            #160125-00005#7--add--end             
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glaa_m.glaald = g_qryparam.return1              

            DISPLAY g_glaa_m.glaald TO glaald              #
             
            #SELECT * INTO g_glaa_t.* #mark by geza 20161121 #161111-00028#6
            #add by geza 20161121 #161111-00028#6(S)
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,
                   glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                   glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
                   glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,
                   glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                   glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,
                   glaa028
            
            INTO g_glaa_t.glaaent,g_glaa_t.glaaownid,g_glaa_t.glaaowndp,g_glaa_t.glaacrtid,g_glaa_t.glaacrtdp,
                 g_glaa_t.glaacrtdt,g_glaa_t.glaamodid,g_glaa_t.glaamoddt,g_glaa_t.glaastus,g_glaa_t.glaald,g_glaa_t.glaacomp,
                 g_glaa_t.glaa001,g_glaa_t.glaa002,g_glaa_t.glaa003,g_glaa_t.glaa004,g_glaa_t.glaa005,g_glaa_t.glaa006,g_glaa_t.glaa007,g_glaa_t.glaa008,g_glaa_t.glaa009,g_glaa_t.glaa010,
                 g_glaa_t.glaa011,g_glaa_t.glaa012,g_glaa_t.glaa013,g_glaa_t.glaa014,g_glaa_t.glaa015,g_glaa_t.glaa016,g_glaa_t.glaa017,g_glaa_t.glaa018,g_glaa_t.glaa019,g_glaa_t.glaa020,
                 g_glaa_t.glaa021,g_glaa_t.glaa022,g_glaa_t.glaa023,g_glaa_t.glaa024,g_glaa_t.glaa025,g_glaa_t.glaa026,g_glaa_t.glaa100,g_glaa_t.glaa101,g_glaa_t.glaa102,g_glaa_t.glaa103,
                 g_glaa_t.glaa111,g_glaa_t.glaa112,g_glaa_t.glaa113,g_glaa_t.glaa120,g_glaa_t.glaa121,g_glaa_t.glaa122,g_glaa_t.glaa027,g_glaa_t.glaa130,g_glaa_t.glaa131,g_glaa_t.glaa132,
                 g_glaa_t.glaa133,g_glaa_t.glaa134,g_glaa_t.glaa135,g_glaa_t.glaa136,g_glaa_t.glaa137,g_glaa_t.glaa138,g_glaa_t.glaa139,g_glaa_t.glaa140,g_glaa_t.glaa123,g_glaa_t.glaa124,
                 g_glaa_t.glaa028
            #add by geza 20161121 #161111-00028#6(E)   
            
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald #20141106 add
            CALL afap220_glaald_desc()

            NEXT FIELD glaald                          #返回原欄位
            
            AFTER FIELD year
               IF NOT cl_null(g_glaa_m.year) AND g_glaa_m.year < 1 THEN
                  LET g_glaa_m.year = g_glaa_m_t.year
                  DISPLAY BY NAME g_glaa_m.year
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_glaa_m.year
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF 

            BEFORE FIELD month
               IF cl_null(g_glaa_m.year) THEN
                  NEXT FIELD year
               END IF

            AFTER FIELD month
               IF NOT cl_null(g_glaa_m.month) AND (g_glaa_m.month < 1 OR g_glaa_m.month > 12) THEN
               LET g_glaa_m.month = g_glaa_m_t.month
               DISPLAY BY NAME g_glaa_m.month
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00106'
               LET g_errparam.extend = g_glaa_m.month
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            END IF          {#ADP版次:1#}
            
        AFTER INPUT
     END INPUT
     
     CONSTRUCT BY NAME g_wc2 ON  faah003,faah004,faah001,faah006,faah007,faah005,faah008,faah042
       BEFORE CONSTRUCT
          CALL cl_qbe_init() 
              
       #20141230 add by chenying       
       ON ACTION controlp INFIELD faah001  #主帳套開窗
	       INITIALIZE g_qryparam.* TO NULL 
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
          CALL q_faah001()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah001 #顯示到畫面上

          NEXT FIELD faah001                    #返回原欄位 
       #20141230 add by chenying
       
       ON ACTION controlp INFIELD faah003  #主帳套開窗
	       INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
          CALL q_faah003()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah003 #顯示到畫面上

          NEXT FIELD faah003                    #返回原欄位 
          
       ON ACTION controlp INFIELD faah004     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
          CALL q_faah004()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah004 #顯示到畫面上

          NEXT FIELD faah004                    #返回原欄位 
          
       ON ACTION controlp INFIELD faah006     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
          CALL q_faac001()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah006 #顯示到畫面上

          NEXT FIELD faah006                    #返回原欄位
          
      ON ACTION controlp INFIELD faah007     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
          CALL q_faad001()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah007 #顯示到畫面上

          NEXT FIELD faah007                    #返回原欄位
          
      ON ACTION controlp INFIELD faah008     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		    LET g_qryparam.reqry = FALSE
		    LET g_qryparam.arg1 = '3903'
          CALL q_oocq002()                #呼叫開窗
          DISPLAY g_qryparam.return1 TO faah008 #顯示到畫面上

          NEXT FIELD faah008                    #返回原欄位
       
     END CONSTRUCT
     
       INPUT ARRAY g_faah_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)
             BEFORE INPUT
                CALL afap220_b_fill(g_wc2)
                LET g_rec_b = g_faah_d.getLength()
                CALL cl_set_comp_entry("faah003,faah004,faah006,faah007,faah005,faah008,faah042",FALSE)

            BEFORE ROW
               LET l_ac = ARR_CURR()
            
#            ON ACTION confirm
#               CALL afap220_confirm()

         END INPUT 
         
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL afap220_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
           #CALL afap220_construct()
           #CALL afap220_b_fill(g_wc2)
           #NEXT FIELD check
            #end add-point

         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_faah_d.getLength()
               LET g_faah_d[li_idx].check = "Y"
               #add-point:ui_dialog段on action selall
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_faah_d.getLength()
               LET g_faah_d[li_idx].check = "N"
               #add-point:ui_dialog段on action selnone

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_faah_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_faah_d[li_idx].check = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
 
            #end add-point
         
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_faah_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_faah_d[li_idx].check = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel

            #end add-point
            
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL afap220_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後

               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION batch_execute
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE lc_param.* TO NULL
            #add-point:ui_dialog段qbeclear
            INITIALIZE g_glaa_m.* TO NULL
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG


         ON ACTION accept
            #20141230 add by chenying
            #检查是否已开账
            LET g_cnt = 0
            LET l_flag = 'Y'
            SELECT COUNT(*) INTO g_cnt FROM faam_t
             WHERE faament = g_enterprise 
               AND faam006 = '0'  
               AND faamld = g_glaa_m.glaald #20150122 add faamld by chenying
            LET l_success = TRUE   
            CALL s_transaction_begin()       
            IF g_cnt > 0 THEN 
               IF cl_ask_confirm('afa-00373') THEN
                  CALL afap220_del_faam() RETURNING l_success
               ELSE
                  LET l_success = FALSE     
                  LET l_flag = 'N'          
               END IF
            END IF 
            IF l_success = TRUE THEN
               CALL s_transaction_end('Y','0') 
               CALL afap220_b_fill(g_wc2)
               NEXT FIELD check
            ELSE
              IF l_flag = 'N' THEN 
                 CALL s_transaction_end('N','0') 
                 LET INT_FLAG = TRUE                 
                 EXIT DIALOG
              ELSE
                 CALL s_transaction_end('N','0')   
              END IF         
            END IF      
            #20141230 add by chenying            
#            CALL afap220_b_fill(g_wc2)
#            NEXT FIELD check
            
         #add-point:ui_dialog段action

         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #add-point:ui_dialog段exit dialog
                              
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         #LET g_jobid = cl_schedule_get_jobid(g_prog)
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL afap220_process(ls_js)
            WHEN g_schedule.gzpa003 = "1"
            #    CALL cl_schedule_update_data(g_jobid,ls_js)
                 LET ls_js = afap220_transfer_argv(ls_js)
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
 
         #add-point:ui_dialog段after schedule

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

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap220_faamsite_desc(p_ooef001)
# Input parameter:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_faamsite_desc(p_ooef001)
   DEFINE p_ooef001         LIKE ooef_t.ooef001
   DEFINE r_desc           LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL afap220_faamsite_chk(p_site)
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_faamsite_chk(p_site)
DEFINE p_site    LIKE faam_t.faamsite
DEFINE l_n       LIKE type_t.num5
DEFINE l_ooef003 LIKE ooef_t.ooef003

    #检查是否存在ooef 组织档
    SELECT COUNT(*) INTO l_n FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00094'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
    #检查是否有效
    SELECT COUNT(*) INTO l_n FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site AND ooefstus = 'Y'
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00105'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
    #检查是否是资产中心
    SELECT COUNT(*) INTO l_n FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site AND ooefstus = 'Y' AND ooef207 = 'Y'
    IF l_n = 0 THEN
       SELECT ooef003 INTO l_ooef003 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site
       IF l_ooef003 = 'N' THEN #法人可作为资产中心
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'afa-00004'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          RETURN FALSE
       END IF
    END IF
    
    #检查资产中心的合理性ooed
    SELECT COUNT(*) INTO l_n FROM ooed_t WHERE ooedent = g_enterprise AND ooed004 = p_site
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00201'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
    #检查是否资产中心类型
    SELECT COUNT(*) INTO l_n FROM ooed_t WHERE ooedent = g_enterprise AND ooed004 = p_site AND ooed001 = '5'
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00290' 
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
     
    #检查ooed是否过期
    SELECT COUNT(*) INTO l_n FROM ooed_t WHERE ooedent = g_enterprise 
       AND ooed004 = p_site AND ooed001 = '5' AND ((ooed006 <= g_today AND ooed007 >= g_today) OR ooed007 IS NULL)
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00202' 
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
    RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap220_faamsite_glaald_chk(p_site,p_ld)
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_faamsite_glaald_chk(p_site,p_ld)
DEFINE p_site      LIKE faam_t.faamsite
DEFINE p_ld        LIKE glaa_t.glaald
DEFINE l_ooef017   LIKE ooef_t.ooef017
DEFINE l_glaacomp  LIKE glaa_t.glaacomp

   #抓取资产中心法人
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = p_site

   #抓取帐套归属法人
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld
    
   IF l_ooef017 <> l_glaacomp THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00292'   
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap220_faamsite_user_chk()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_faamsite_user_chk(p_site)
DEFINE p_site  LIKE faam_t.faamsite
DEFINE l_n     LIKE type_t.num5

   SELECT COUNT(*) INTO l_n FROM gzxc_t
    WHERE gzxcent = g_enterprise 
      AND gzxc001 = g_user
      AND gzxc002 = '1'
      AND gzxc004 = p_site
      AND ((gzxc005 IS NULL  OR gzxc005 <=g_today) AND (gzxc006 IS NULL OR gzxc006 >=g_today))
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00291'  
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap220_change_to_sql(p_wc)
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap220_del_faam()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afap220_del_faam()
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM faam_t WHERE faament = g_enterprise AND faam006 = '0' AND faamld = g_glaa_m.glaald   #20150122 add faamld by chenying
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "del faam" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   
      LET r_success = FALSE
   END IF      
   RETURN r_success  
END FUNCTION

#end add-point
 
{</section>}
 
